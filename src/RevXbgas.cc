//
// _RevXbgas_cc_
//
// Copyright (C) 2017-2021 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#include "RevXbgas.h"

using namespace SST;
using namespace RevCPU;

// Ref: https://stackoverflow.com/questions/11656241/how-to-print-uint128-t-number-using-gcc

static int print_u128_u(uint128_t u128)
{
    int rc;
    if (u128 > UINT64_MAX)
    {
        uint128_t leading  = u128 / P10_UINT64;
        uint64_t  trailing = u128 % P10_UINT64;
        rc = print_u128_u(leading);
        rc += printf("%." TO_STRING(E10_UINT64) PRIu64, trailing);
    }
    else
    {
        uint64_t u64 = u128;
        rc = printf("%" PRIu64, u64);
    }
    return rc;
}

RevXbgas::RevXbgas( xbgasNicAPI *XNic, RevOpts *Opts, RevMem *Mem, SST::Output *Output )
  : xnic(XNic), opts(Opts), mem(Mem), output(Output) {
  output->verbose(CALL_INFO, 5, 0,
                  "Initializing the XBGAS object; set up the XBGAS message handler\n");
  // Set up the Xbgas message handler
  xnic->setMsgHandler(new Event::Handler<RevXbgas>(this, &RevXbgas::handleXbgasMessage));

}

void RevXbgas::initXbgasMem( xbgasNicAPI *XNic ) {
  output->verbose(CALL_INFO, 1, 0, "Initializing Xbgas firmware memory.\n");

  // init all the entries to -1
  uint64_t ptr = (uint64_t)(_XBGAS_NAMESPACE_TABLE_ADDR_);
  uint64_t nmspace = 0x0;
  int64_t id = -1;
  unsigned numPEs = 0;
  for( unsigned i=0; i<_XBGAS_NAMESPACE_TABLE_MAX_ENTRIES_; i++ ){
    mem->WriteU64(ptr, (uint64_t)(nmspace));
    mem->WriteU64(ptr+8, (uint64_t)(id));
    ptr += sizeof(NamespaceTbEntry);
  }

  // The first entry in the namespace table is always [0, myPE], refering to local memory
  id = (int64_t)(xnic->getAddress());
  ptr = (uint64_t)(_XBGAS_NAMESPACE_TABLE_ADDR_);
  mem->WriteU64(ptr+8, (uint64_t)(id));

  // Initialize the Xbgas firmware memory for recording the info of PE ID and the total number of PEs
  ptr = (uint64_t)(_XBGAS_MY_PE_ADDR_);
  mem->WriteU64(ptr, (uint64_t)(id));

  numPEs = (unsigned)(xnic->getNumPEs());
  ptr = (uint64_t)(_XBGAS_TOTAL_PE_ADDR_);
  mem->WriteU64(ptr, (uint64_t)(numPEs));

  // Initialize the Namespace Lookaside Buffer
  // Addr 0x00 is always reserved for the local access
  std::vector<SST::Interfaces::SimpleNetwork::nid_t> xbgasHosts;
  xbgasHosts = xnic->getXbgasHosts();

  NLB.push_back(std::make_pair(0x0, id));
  for(SST::Interfaces::SimpleNetwork::nid_t i: xbgasHosts){
    if ( (int64_t)i != id)
      NLB.push_back( std::make_pair( (uint64_t(i+1)), i ) );
  }

  output->verbose(CALL_INFO, 4, 0, "--> MY NLB is: \n");
  int i = 0;
  for ( auto it=NLB.begin(); it != NLB.end(); ++it ){
    output->verbose(CALL_INFO, 4, 0, "--> Entry: %d | Namespace: 0x%" PRId64 " | Node ID: %" PRId64 "\n", i, std::get<0>(*it), std::get<1>(*it));
    i++;
  }

  output->verbose(CALL_INFO, 1, 0, "Initialization of Xbgas firmware memory complete.\n");
}

bool RevXbgas::isFinished() {
  bool rtn = true;
  if( !SendMB.empty() || !ReadQueue.empty() || !TrackTags.empty() || !GetResponses.empty() || !TrackGets.empty() || !TrackTags.empty() )
    rtn = false;

  return rtn;
}

void RevXbgas::handleXbgasMessage(Event *ev){
  xbgasNicEvent *event = static_cast<xbgasNicEvent*>(ev);
  switch( event->getOpcode() ){
  case xbgasNicEvent::Success:
    handleSuccess(event);
    break;
  case xbgasNicEvent::Failed:
    handleFailed(event);
    break;
  case xbgasNicEvent::Get:
    handleGet(event);
    break;
  case xbgasNicEvent::Put:
    handlePut(event);
    break;
  default:
    // xbgas devices should never receive these commands
    output->fatal(CALL_INFO, -1,
                "Error: host devices cannot handle %s commands\n",
                event->getOpcodeStr().c_str());
    break;
  }
  delete event;
}

void RevXbgas::handleSuccess(xbgasNicEvent *event){
  output->verbose(CALL_INFO, 5, 0, "Handling XBGAS Success Confirmation from PE=%d, Size=%" PRIu32 "\n", event->getSrc(), event->getSize());
  // search for the tag in the tag list
  std::pair<uint8_t,int> Entry = std::make_pair(event->getTag(), event->getSrc());
  auto it = std::find(TrackTags.begin(), TrackTags.end(), Entry);
  if( it == TrackTags.end() ){
    // nothing found, raise an error
    output->fatal(CALL_INFO, -1,
                 "Error: failed to find matching tag and source identifier for incoming message: tag=%d; src=%d\n",
                 event->getTag(),
                 event->getSrc());
    return ;  // should not reach this
  }

  // search for the tag in the outstanding get list, tuple<Tag,Dest,Addr>
  std::vector<std::tuple<uint8_t, int, uint64_t>>::iterator GetIter;
  for( GetIter = TrackGets.begin(); GetIter != TrackGets.end(); ++GetIter ){
    if( std::get<0>(*GetIter) = event->getTag() ){
      // Found a valid entry; put returned data in the GetResponses list
      uint8_t tmp_tag = event->getTag();
      uint32_t tmp_size = event->getSize();
      unsigned tmp_block = event->getNumBlocks(tmp_size);
      uint64_t *Data = new uint64_t [tmp_block];

      event->getData(Data);

      output->verbose(CALL_INFO, 5, 0,
                      "Push response of Tag=%d to GetResponses.\n",
                      event->getTag());

      GetResponses.push_back(std::make_tuple(tmp_tag, Data, tmp_size));
      break;
    }
  }
  // remove the entry
  TrackTags.erase(it);
}

void RevXbgas::handleFailed(xbgasNicEvent *event){
  // search for the tag in the tag list
  std::pair<uint8_t,int> Entry = std::make_pair(event->getTag(), event->getSrc());
  auto it = std::find(TrackTags.begin(), TrackTags.end(), Entry);
  if( it == TrackTags.end() ){
    // nothing found, raise an error
    output->fatal(CALL_INFO, -1,
                 "Error: failed to find matching tag and source identifier for incoming message: tag=%d; src=%d\n",
                 event->getTag(),
                 event->getSrc());
    return ;  // should not reach this
  }

  // remove the entry
  TrackTags.erase(it);
}

void RevXbgas::handleGet(xbgasNicEvent *event){
  output->verbose(CALL_INFO, 5, 0, "Handling XBGAS Get Request from PE=%d, Tag=%d\n", event->getSrc(), event->getTag());
  // push an event entry back onto the ReadQueue
  ReadQueue.push_back(std::make_tuple(event->getTag(),
                                      event->getSize(),
                                      RandCost(), 
                                      event->getSrc(),
                                      event->getAddr()));
}

void RevXbgas::handlePut(xbgasNicEvent *event){
  output->verbose(CALL_INFO, 5, 0, "Handling XBGAS Put Request for PE=%d\n", event->getSrc());
  // retrieve the data
  uint32_t Size = event->getSize();
  uint64_t *Data = new uint64_t [event->getNumBlocks(Size)];
  event->getData(Data);

  if( !mem->WriteMem(event->getAddr(), Size, (void *)(Data)) ){
    delete[] Data;
    // build failed response
    buildFailedResp(event);
    return ;
  }

  delete[] Data;
  // build success response
  buildSuccessResp(event);
  return;
}

void RevXbgas::buildSuccessResp(xbgasNicEvent *event){
  output->verbose(CALL_INFO, 5, 0, "Building success return packet\n");
  xbgasNicEvent *SEvent = new xbgasNicEvent();
  SEvent->setSrc(xnic->getAddress());
  if( !SEvent->buildSuccess(event->getTag()) ){
    output->fatal(CALL_INFO, -1,
                 "Error: failed to construct success command for tag=%d\n",
                 event->getTag());
  }
  SendMB.push(std::make_pair(SEvent, event->getSrc()));
}

void RevXbgas::buildFailedResp(xbgasNicEvent *event){
  output->verbose(CALL_INFO, 5, 0, "Building failed return packet\n");
  xbgasNicEvent *FEvent = new xbgasNicEvent();
  FEvent->setSrc(xnic->getAddress());
  if( !FEvent->buildFailed(event->getTag()) ){
    output->fatal(CALL_INFO, -1,
                 "Error: failed to construct failure command for tag=%d\n",
                 event->getTag());
  }
  SendMB.push(std::make_pair(FEvent, event->getSrc()));
}

void RevXbgas::clockTick(Cycle_t currentCycle, unsigned msgPerCycle){
  // process the read queue
  if( ! processXBGASMemRead() )
      output->fatal(CALL_INFO, -1, "Error: failed to process the XBGAS memory read queue\n" );
  
  for( unsigned i=0; i < msgPerCycle; i++ ){
    // check the mailbox for message to inject
    if( ! sendXBGASMessage() )
      output->fatal(CALL_INFO, -1, "Error: could not send XBGAS command message\n" );
  }
}

bool RevXbgas::processXBGASMemRead(){
  // walk the entire vector and decrement all the counters
  // if we have a counter decrement to '0', then process the read request
  // send responses as necessary

  // decrement all the counts
  int i = 0;
  for( auto &it : ReadQueue ){
    if( std::get<2>(it) != 0 )
      std::get<2>(it)--;
    i++;
  }

  // walk all the nodes and see which requests need to be flushed
  for( auto it=ReadQueue.begin(); it != ReadQueue.end(); ++it ){
    if( std::get<2>(*it) == 0 ){
      // process this read request
      uint8_t tmp_tag = std::get<0>(*it);
      uint32_t tmp_size = std::get<1>(*it);
      int tmp_src = std::get<3>(*it);
      uint64_t tmp_addr = std::get<4>(*it);

      // -- setup the response
      xbgasNicEvent *SCmd = new xbgasNicEvent();
      uint64_t *Data = new uint64_t [SCmd->getNumBlocks(tmp_size)];
      if( !mem->ReadMem( tmp_addr,
                         (size_t)(tmp_size),
                         (void *)(Data)) ){
        // build a failed response
        SCmd->buildFailed(tmp_tag);
        SCmd->setSrc(xnic->getAddress());
        SendMB.push(std::make_pair(SCmd, tmp_src));
      }else{
        // build a successful response
        SCmd->buildSuccess(tmp_tag);
        SCmd->setSize(tmp_size);
        SCmd->setData(Data, tmp_size);
        SCmd->setSrc(xnic->getAddress());
        SendMB.push(std::make_pair(SCmd, tmp_src));

        output->verbose(CALL_INFO, 5, 0,
                 "Process XBGAS Mem Read request from %d: Tag=%u, Size=%" PRIu32 ", Addr=0x%2x, Value=%" PRId64 "\n",
                 tmp_src, tmp_tag, tmp_size, tmp_addr, (uint64_t)(*Data));
      }
      delete[] Data;
    }
  }

  // delete the completed nodes
  unsigned count = ReadQueue.size();
  for( unsigned i=0; i<count;){
    if( std::get<2>(ReadQueue[i]) == 0 ){
      ReadQueue.erase(ReadQueue.begin()+i);
      --count;
    }else{
      ++i;
    }
  }
  
  return true;
}

bool RevXbgas::sendXBGASMessage(){
  // check the mailbox for the next message
  if( SendMB.empty() )
    return true;

  output->verbose(CALL_INFO, 5, 0,
                 "Sending XBGAS message from %d to %d; Opc=%s; Tag=%u; Size=%" PRIu32 "\n",
                 int(xnic->getAddress()), SendMB.front().second,
                 SendMB.front().first->getOpcodeStr().c_str(),
                 SendMB.front().first->getTag(),
                 SendMB.front().first->getSize());

  xnic->send(SendMB.front().first, SendMB.front().second);
  // save the message to track the response
  uint8_t Opc = SendMB.front().first->getOpcode();
  if( (Opc != xbgasNicEvent::Success) && (Opc != xbgasNicEvent::Failed) ){
    TrackTags.push_back(std::make_pair(SendMB.front().first->getTag(),
                                            SendMB.front().second));
  }

  SendMB.pop();

  return true;
}

bool RevXbgas::WriteMem( uint64_t Nmspace, uint64_t Addr, size_t Len, void *Data ){
  int Dest = findDest(Nmspace);
  output->verbose(CALL_INFO, 5, 0,
                  "Writing %" PRIu32 " Bytes to PE %d Starting at 0x%2x.\n", Len, Dest, Addr);
  xbgasNicEvent *PEvent = nullptr;
  uint8_t Tag  = createTag();
  uint32_t Size = (uint32_t)(Len * 8);
  uint64_t Src = xnic->getAddress();
  
  PEvent = new xbgasNicEvent(xnic->getName()); // new event to send
  PEvent->setSrc(Src);

  // populate it
  if( !PEvent->buildPut(Tag, Addr, Size, (uint64_t *)Data) ){
    output->fatal(CALL_INFO, -1,
                  "%s, Error: could not create XBGAS PUT command\n",
                  xnic->getName().c_str());
  }
  
  SendMB.push(std::make_pair(PEvent, Dest));
  return true;
}

void RevXbgas::WriteU8( uint64_t Nmspace, uint64_t Addr, uint8_t Value) {
  uint8_t Tmp = Value;
  if( !WriteMem( Nmspace, Addr, 1, (void *)(&Tmp) ) )
    output->fatal(CALL_INFO, -1, "Error: could not write remote memory (U8)");
}

void RevXbgas::WriteU16( uint64_t Nmspace, uint64_t Addr, uint16_t Value) {
  uint16_t Tmp = Value;
  if( !WriteMem( Nmspace, Addr, 2, (void *)(&Tmp) ) )
    output->fatal(CALL_INFO, -1, "Error: could not write remote memory (U16)");
}

void RevXbgas::WriteU32( uint64_t Nmspace, uint64_t Addr, uint32_t Value) {
  uint32_t Tmp = Value;
  if( !WriteMem( Nmspace, Addr, 4, (void *)(&Tmp) ) )
    output->fatal(CALL_INFO, -1, "Error: could not write remote memory (U32)");
}

void RevXbgas::WriteU64( uint64_t Nmspace, uint64_t Addr, uint64_t Value) {
  uint64_t Tmp = Value;
  if( !WriteMem( Nmspace, Addr, 8, (void *)(&Tmp) ) )
    output->fatal(CALL_INFO, -1, "Error: could not write remote memory (U64)");
}

void RevXbgas::WriteU128( uint64_t Nmspace, uint64_t Addr, uint128_t Value) {
  uint128_t Tmp = Value;
  if( !WriteMem( Nmspace, Addr, 16, (void *)(&Tmp) ) )
    output->fatal(CALL_INFO, -1, "Error: could not write remote memory (U128)");
}

void RevXbgas::WriteFloat( uint64_t Nmspace, uint64_t Addr, float Value) {
  uint32_t Tmp = 0x00;
  std::memcpy(&Tmp,&Value,sizeof(float));
  if( !WriteMem( Nmspace, Addr, 4, (void *)(&Tmp) ) )
    output->fatal(CALL_INFO, -1, "Error: could not write remote memory (FLOAT)");
}

void RevXbgas::WriteDouble( uint64_t Nmspace, uint64_t Addr, double Value) {
  uint64_t Tmp = 0x00;
  std::memcpy(&Tmp,&Value,sizeof(double));
  if( !WriteMem( Nmspace, Addr, 8, (void *)(&Tmp) ) )
    output->fatal(CALL_INFO, -1, "Error: could not write remote memory (DOUBLE)");
}


bool RevXbgas::ReadMem( uint64_t Nmspace, uint64_t Addr, size_t Len){
  int Dest = findDest(Nmspace);
  xbgasNicEvent *GEvent = nullptr;
  uint8_t Tag  = createTag();
  uint32_t Size = (uint32_t)(Len * 8);
  uint64_t Src = xnic->getAddress();
  bool recvd = false;

  output->verbose(CALL_INFO, 5, 0,
                  "Reading %" PRIu32 " Bytes from PE=%d Starting at 0x%2x, Tag=%u\n", Len, Dest, Addr, Tag);

  GEvent = new xbgasNicEvent(xnic->getName()); // new event to send
  GEvent->setSrc(Src);

  // populate it
  if( !GEvent->buildGet(Tag, Addr, Size) ){
    output->fatal(CALL_INFO, -1,
                  "%s, Error: could not create XBGAS Get command\n",
                  xnic->getName().c_str());
  }
  
  // Populate it
  SendMB.push(std::make_pair(GEvent, Dest));

  // Remember the get request
  TrackGets.push_back(std::make_tuple(Tag, Dest, Addr));

  return true;
}

void RevXbgas::ReadU8( uint64_t Nmspace, uint64_t Addr ) {
  if( !ReadMem( Nmspace, Addr, 1) )
    output->fatal(CALL_INFO, -1, "Error: could not read remote memory (U8)");
}

void RevXbgas::ReadU16( uint64_t Nmspace, uint64_t Addr ) {
  if( !ReadMem( Nmspace, Addr, 2 ) )
    output->fatal(CALL_INFO, -1, "Error: could not read remote memory (U16)");
}

void RevXbgas::ReadU32( uint64_t Nmspace, uint64_t Addr ) {
  if( !ReadMem( Nmspace, Addr, 4 ) )
    output->fatal(CALL_INFO, -1, "Error: could not read remote memory (U32)");
}

void RevXbgas::ReadU64( uint64_t Nmspace, uint64_t Addr ) {
  if( !ReadMem( Nmspace, Addr, 8 ) )
    output->fatal(CALL_INFO, -1, "Error: could not read remote memory (U64)");
}

void RevXbgas::ReadU128( uint64_t Nmspace, uint64_t Addr ) {
  if( !ReadMem( Nmspace, Addr, 16 ) )
    output->fatal(CALL_INFO, -1, "Error: could not read remote memory (U128)");
}

void RevXbgas::ReadFloat( uint64_t Nmspace, uint64_t Addr ) {
  if( !ReadMem( Nmspace, Addr, 4 ) )
    output->fatal(CALL_INFO, -1, "Error: could not read remote memory (FLOAT)");
}

void RevXbgas::ReadDouble( uint64_t Nmspace, uint64_t Addr ) {
  if( !ReadMem( Nmspace, Addr, 8 ) )
    output->fatal(CALL_INFO, -1, "Error: could not read remote memory (DOUBLE)");
}

uint8_t RevXbgas::createTag(){
  uint8_t rtn = 0;
  if( PrivTag == 0b11111111 ){
    rtn = 0b00000000;
    PrivTag = 0b00000001;
    return rtn;
  }else{
    rtn = PrivTag;
    PrivTag +=1;
  }
  return rtn;
}

int RevXbgas::findDest(uint64_t nmspace){
  // return nmspace;
  for( auto it=NLB.begin(); it != NLB.end(); ++it ) {
    if( std::get<0>(*it) == nmspace ) {
      return std::get<1>(*it);
    }
  }
  return -1;
}

bool RevXbgas::checkGetRequests( uint64_t Nmspace, uint64_t Addr, uint8_t *Tag ){
  int Dest = findDest(Nmspace);
  for( auto it=TrackGets.begin(); it != TrackGets.end(); ++it ){
    if( (std::get<1>(*it) == Dest) && (std::get<2>(*it) == Addr) ) {
      *Tag = std::get<0>(*it);
      output->verbose(CALL_INFO, 6, 0,
                      "Get request for PE=%d, Addr=0x%2x has been sent; Tag=%u\n", Dest, Addr, *Tag);
      return true;
    }
  }

  output->verbose(CALL_INFO, 6, 0,
                      "Get request for PE=%d, Addr=0x%2x has NOT been sent.\n", Dest, Addr);
  return false;
}

bool RevXbgas::readGetResponses( uint8_t Tag, void *Data ){
  output->verbose(CALL_INFO, 6, 0, "Read Get Response for Tag=%u\n", Tag);
  char *DataMem = (char *)(Data);
  for( auto it=GetResponses.begin(); it != GetResponses.end(); ++it ) {
    if( std::get<0>(*it) == Tag ) {
      uint64_t *tmp_data = std::get<1>(*it);
      unsigned Len = getNumBlocks(std::get<2>(*it));
      for( unsigned i=0; i < Len; i++ ){
        DataMem[i] = tmp_data[i];
      }
      delete[] tmp_data;

      for( auto itt=TrackGets.begin(); itt != TrackGets.end(); ++it ){
        if( std::get<0>(*itt) == Tag ) {
          TrackGets.erase(itt);
          break;
        }
      }

      GetResponses.erase(it);
      // print_u128_u((uint128_t)(*DataMem));
      // output->verbose(CALL_INFO, 5, 0, "Response for Tag %u: Value=%d\n", Tag, ndigits);
      output->verbose(CALL_INFO, 5, 0, "Response for Tag %u: Value=%" PRId64 "\n", Tag, (uint64_t)(*DataMem));
      return true;
    }
  }
  return false;
}

unsigned RevXbgas::RandCost(){
  unsigned MinCost = 0;
  unsigned MaxCost = 0;
  opts->GetMemCost(0,MinCost,MaxCost);
  return mem->RandCost(MinCost, MaxCost); 
}

unsigned RevXbgas::getNumBlocks(uint32_t Sz){
  unsigned blocks = 0;

  if( Sz == 0 ){
    blocks = 0;
  }else if ( Sz < 8 ){
    blocks = 1;
  }else{
    blocks = Sz/8;
    if( (Sz%8) > 0 )
      blocks += 1;
  }

  return blocks;
}