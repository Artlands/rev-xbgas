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
#include "../common/include/XbgasAddr.h"

using namespace SST;
using namespace RevCPU;

RevXbgas::RevXbgas( xbgasNicAPI *XNic, RevOpts *Opts, RevMem *Mem, SST::Output *Output )
  : xnic(XNic), opts(Opts), mem(Mem), output(Output) {
  output->verbose(CALL_INFO, 6, 0,
                  "Initializing the XBGAS object; set up the XBGAS message handler\n");
  // Set up the Xbgas message handler
  xnic->setMsgHandler(new Event::Handler<RevXbgas>(this, &RevXbgas::handleXbgasMessage));

}

void RevXbgas::initXbgasMem( xbgasNicAPI *XNic ) {
  // output->verbose(CALL_INFO, 1, 0, "Initializing Xbgas firmware memory.\n");

  uint64_t ptr;
  int64_t id = -1;
  unsigned numPEs = 0;

  // The first entry in the namespace table is always [0, myPE], refering to local memory
  id = (int64_t)(xnic->getAddress());

  // Initialize the Xbgas firmware memory for recording the info of PE ID and the total number of PEs
  ptr = (uint64_t)(_XBGAS_MY_PE_);
  mem->WriteU64(ptr, (uint64_t)(id));

  numPEs = (unsigned)(xnic->getNumPEs());
  ptr = (uint64_t)(_XBGAS_TOTAL_NPE_);
  mem->WriteU64(ptr, (uint64_t)(numPEs));

#if 0
// #ifdef _XBGAS_DEBUG_
  if (id == 1) {
    std::cout << "_XBGAS_MY_PE_: 0x" << std::hex << _XBGAS_MY_PE_ << ", Value = " << std::dec << id << std::endl;
    std::cout << "_XBGAS_TOTAL_NPE_: 0x" << std::hex << _XBGAS_TOTAL_NPE_ << ", Value = " << std::dec << numPEs << std::endl;
    // std::cout << "_REV_HEAP_START_: 0x" << std::hex << _REV_HEAP_START_ << std::endl;
    // std::cout << "_REV_HEAP_END_: 0x" << std::hex << _REV_HEAP_END_ << std::endl;
    // std::cout << "_REV_HEAP_SIZE_: " << std::hex << _REV_HEAP_SIZE_ << std::endl;
  }
#endif

  // Initialize the Namespace Lookaside Buffer
  // Addr 0x00 is always reserved for the local access
  std::vector<SST::Interfaces::SimpleNetwork::nid_t> xbgasHosts;
  xbgasHosts = xnic->getXbgasHosts();

  NLB.push_back(std::make_pair(0x0, id));
  for(SST::Interfaces::SimpleNetwork::nid_t i: xbgasHosts){
    NLB.push_back( std::make_pair( (uint64_t(i+1)), i ) );
  }

  // output->verbose(CALL_INFO, 6, 0, "--> MY NLB is: \n");
  // int i = 0;
  // for ( auto it=NLB.begin(); it != NLB.end(); ++it ){
  //   output->verbose(CALL_INFO, 6, 0, "--> Entry: %d | Namespace: 0x%" PRId64 " | Node ID: %" PRId64 "\n", i, std::get<0>(*it), std::get<1>(*it));
  //   i++;
  // }

  // output->verbose(CALL_INFO, 1, 0, "Initialization of Xbgas firmware memory complete.\n");
}

bool RevXbgas::isFinished() {
  bool rtn = true;
  if( !SendMB.empty() || !ReadQueue.empty() || !TrackTags.empty() || !GetResponses.empty() || !TrackGets.empty() )
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
  output->verbose(CALL_INFO, 6, 0, "Handling XBGAS Success Confirmation from PE=%d, Size=%" PRIu32 "\n", event->getSrc(), event->getSize());
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
    if( std::get<0>(*GetIter) == event->getTag() ){
      // Found a valid entry; put returned data in the GetResponses list if 
      // it is not a DMA event
      uint64_t tmp_addr = 0x00ull;
      uint8_t tmp_tag = event->getTag();
      uint32_t tmp_size = event->getSize();
      uint32_t tmp_nelem = event->getNelem();
      uint32_t tmp_stride = event->getStride();
      size_t tmp_len = (size_t)(tmp_size/tmp_nelem);
      uint64_t tmp_dest_addr = event->getDestAddr();
      bool tmp_dma = event->getDMA();
      uint64_t *Data = new uint64_t [event->getNumBlocks(tmp_size)];
      char *DataElem = (char *)(Data);
      event->getData(Data);

      if ( !tmp_dma ) {
        output->verbose(CALL_INFO, 6, 0,
                      "Push response of Tag=%d to GetResponses.\n",
                      event->getTag());

        GetResponses.push_back(std::make_tuple(tmp_tag, Data, tmp_size));
      } else {
        // DMA operation; write to memory directly; destination addr, stride

#if 0 //def _XBGAS_DEBUG_
          int64_t id = (int64_t)(mem->ReadU64(_XBGAS_MY_PE_));
          if ( (id == 0) && tmp_dma ){ 
            std::cout << "_XBGAS_DEBUG_ CPU " << id
                      << ": PE0 BULK GET:" << std::endl;
          }
#endif

        for( unsigned i=0; i<tmp_nelem; i++ ){
          tmp_addr = tmp_dest_addr + (uint64_t)(i * tmp_stride);

#if 0 //def _XBGAS_DEBUG_
          if ( (id == 0) && tmp_dma ) { 
            std::cout << "\tUpdate value @" << std::hex << tmp_addr
                      << " " << std:: dec << (int)(mem->ReadU32(tmp_addr));
          }
#endif

          if( !mem->WriteMem(tmp_addr, tmp_len, (void *)(&DataElem[i*tmp_len])) ){
            output->fatal(CALL_INFO, -1, "Error: DMA failure\n" );
            break;
          }

#if 0 //def _XBGAS_DEBUG_
          if ( (id == 0) && tmp_dma ) { 
            std::cout << " --> " << std::dec << (int)(mem->ReadU32(tmp_addr)) << std::endl;
          }
#endif
        }
        // Success to write all elements;
        // erase TrackGets
        TrackGets.erase(GetIter);
      }
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
  output->verbose(CALL_INFO, 6, 0, "Handling XBGAS Get Request from PE=%d, Tag=%d\n", event->getSrc(), event->getTag());
  // push an event entry back onto the ReadQueue
  ReadQueue.push_back(std::make_tuple(event->getTag(),
                                      RandCost(), 
                                      event->getSize(),
                                      event->getNelem(),
                                      event->getStride(),
                                      event->getSrc(),
                                      event->getAddr(),
                                      event->getDMA(),
                                      event->getDestAddr()));
}

void RevXbgas::handlePut(xbgasNicEvent *event){
  uint64_t tmp_addr = 0x00ull;
  output->verbose(CALL_INFO, 6, 0, "Handling XBGAS Put Request for PE=%d\n", event->getSrc());
  // retrieve the data
  uint32_t Size = event->getSize();
  bool DmaFlag = event->getDMA();
  uint32_t Nelem = event->getNelem();
  uint32_t Stride = event->getStride();
  size_t Len = (size_t)(Size/Nelem);
  uint64_t Addr = event->getAddr();
  uint64_t *Data = new uint64_t [event->getNumBlocks(Size)];
  event->getData(Data);

  char *DataElem = (char *)(Data);

#if 0 //def _XBGAS_DEBUG_
  int64_t id = (int64_t)(mem->ReadU64(_XBGAS_MY_PE_));
  if ( (id == 1) ) { 
    std::cout << "_XBGAS_DEBUG_ CPU " << id
              << ": PE0 PUT:" << std::endl;
  }
#endif

  // Write each element to the target address
  for( unsigned i=0; i<Nelem; i++) {
    tmp_addr = Addr + (uint64_t)(i * Stride);

#if 0 //def _XBGAS_DEBUG_
    if ( (id == 1) ) { 
      std::cout << "\tUpdate value @" << std::hex << tmp_addr
                << " " << std:: dec << (int)(mem->ReadU32(tmp_addr));
    }
#endif

    if( !mem->WriteMem(tmp_addr, Len, (void *)(&DataElem[i*Len])) ){
      delete[] Data;
      // build failed response
      buildFailedResp(event);
      return ;
    }

#if 0 //def _XBGAS_DEBUG_
    if ( (id == 1) ) { 
      std::cout << " --> " << std::dec << (int)(mem->ReadU32(tmp_addr)) << std::endl;
    }
#endif

  }

  delete[] Data;
  // build success response
  buildSuccessResp(event);
  return;
}

void RevXbgas::buildSuccessResp(xbgasNicEvent *event){
  output->verbose(CALL_INFO, 6, 0, "Building success return packet\n");
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
  output->verbose(CALL_INFO, 6, 0, "Building failed return packet\n");
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

  // print xbgas memory heap
}

bool RevXbgas::processXBGASMemRead(){
  // walk the entire vector and decrement all the counters
  // if we have a counter decrement to '0', then process the read request
  // send responses as necessary

  // ReadQueue
  //       0 - Tag  
  //       1 - Cost
  //       2 - Size
  //       3 - Nelem
  //       4 - Stride
  //       5 - Src
  //       6 - Addr
  //       7 - DmaFlag
  //       8 - DmaDestAddr

  // decrement all the counts
  int i = 0;
  for( auto &it : ReadQueue ){
    if( std::get<1>(it) != 0 )
      std::get<1>(it)--;
    i++;
  }

  // walk all the nodes and see which requests need to be flushed
  for( auto it=ReadQueue.begin(); it != ReadQueue.end(); ++it ){
    if( std::get<1>(*it) == 0 ){
      uint64_t tmp_addr = 0x00ull;
      // process this read request
      uint8_t tmp_tag = std::get<0>(*it);
      uint32_t tmp_size = std::get<2>(*it);
      uint32_t tmp_nelem = std::get<3>(*it);
      uint32_t tmp_stride = std::get<4>(*it);
      int tmp_src = std::get<5>(*it);
      uint64_t tmp_base_addr = std::get<6>(*it);
      bool tmp_dma = std::get<7>(*it);
      uint64_t tmp_dest_addr = std::get<8>(*it);

      // -- setup the response
      xbgasNicEvent *OPEvent = new xbgasNicEvent();
      size_t Len = (size_t)(tmp_size/tmp_nelem);

      // Data for storing the memory readings
      uint64_t *Data = new uint64_t [OPEvent->getNumBlocks(tmp_size)];
      char *DataElem = (char *)(Data);

      bool flag = 1;
      // Try to read memory for each requested element
      for( unsigned i=0; i<tmp_nelem; i++ ){
        tmp_addr = tmp_base_addr + (uint64_t)(i * (1 + tmp_stride) * Len);

        if( !mem->ReadMem( tmp_addr, Len, (void *)(&DataElem[i*Len])) ){
          flag = 0;
          break;
        }
      }

      if (flag == 0) {
        // build a failed response
        OPEvent->buildFailed(tmp_tag);
        OPEvent->setSrc(xnic->getAddress());
        SendMB.push(std::make_pair(OPEvent, tmp_src));
      }else{
        // build a successful response
        OPEvent->buildSuccess(tmp_tag);
        OPEvent->setSize(tmp_size);
        OPEvent->setData(Data, tmp_size);
        OPEvent->setSrc(xnic->getAddress());
        OPEvent->setDMA(tmp_dma);
        OPEvent->setDestAddr(tmp_dest_addr);
        SendMB.push(std::make_pair(OPEvent, tmp_src));

        output->verbose(CALL_INFO, 6, 0,
                 "Process XBGAS Mem Read request from %d: Tag=%u, Size=%" PRIu32 ", Addr=0x%2x\n",
                 tmp_src, tmp_tag, tmp_size, tmp_addr);
      }
      delete[] Data;
    }
  }

  // delete the completed nodes
  unsigned count = ReadQueue.size();
  for( unsigned i=0; i<count;){
    if( std::get<1>(ReadQueue[i]) == 0 ){
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

  output->verbose(CALL_INFO, 6, 0,
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

bool RevXbgas::WriteMem( uint64_t Nmspace, uint64_t Addr, size_t Len, 
                         uint32_t Nelem, uint32_t Stride, 
                         bool Dma, void *Data ){
  uint32_t idx = 0;
  uint64_t tmp_addr = 0x00ull;
  int Dest = findDest(Nmspace);
  output->verbose(CALL_INFO, 6, 0,
                  "Writing %" PRIu32 " Bytes to PE %d Starting at 0x%2x; Stride = %" PRIu32 ", # of elements = %" PRIu32 "\n", 
                  Len, Dest, Addr, Stride, Nelem);
  
  // Len: bytes for the data type; Size: the packet size; 
  // Stride: the distance (in bytes) between consecutive elements.
  // Block: one block contains 8 bytes
  // For transferring 2 int numbers, Size = Len (4 bytes) * Nelem (2) = 8 bytes
  // Number of blocks needed: 1

  uint8_t Tag  = createTag();
  uint32_t Size = (uint32_t)(Len * Nelem);
  uint64_t Src = xnic->getAddress();
  char *DataElem = (char *)(Data);

  xbgasNicEvent *PEvent = new xbgasNicEvent(xnic->getName()); // new event to send
  PEvent->setSrc(Src);

  // Buffer
  uint64_t *Buf = new uint64_t[PEvent->getNumBlocks(Size)];
  char *BufElem = (char *)(Buf);

  bool flag = 0;

  if ( Dma ) {
    // Read memory and save to buffer

  // #ifdef _XBGAS_DEBUG_
  #if 0
      int64_t id = (int64_t)(mem->ReadU64(_XBGAS_MY_PE_));
      if ( id == 0) { 
        std::cout << "_XBGAS_DEBUG_ CPU" << id
                  << ": [WriteMem] " << std::endl;
      }
  #endif

    for( unsigned i=0; i< Nelem; i++ ){
      tmp_addr = (uint64_t)(DataElem) + (uint64_t)(i * Stride);
      if( !mem->ReadMem( tmp_addr, Len, (void *)(&BufElem[i*Len])) ){
        break;
      }

  // #ifdef _XBGAS_DEBUG_
  #if 0
      if ( id == 0) { 
        std::cout << "\tBuffer[" << std::dec << int(i) 
                  << "] = 0x" << std::hex << (int64_t)(BufElem[i*Len]) << std::endl;
      }
  #endif

      flag = 1;
    }
  } else {
    // Copy data to buffer
    for( unsigned i=0; i< Len; i++ ){
      BufElem[i] = DataElem[i];
    }

// #ifdef _XBGAS_DEBUG_
#if 0
      int64_t id = (int64_t)(mem->ReadU64(_XBGAS_MY_PE_));
      if ( id == 0) { 
        std::cout << "_XBGAS_DEBUG_ CPU" << id
                  << ": [WriteMem] "<< std::endl
                  << "\tBuffer[0] = 0x" << std::hex
                  << (uint64_t)(Buf[0]) << std::endl;
      }
#endif

    flag = 1;
  }

  if ( flag == 0 ){
    output->fatal(CALL_INFO, -1,
                  "%s, Error: could not create XBGAS PUT command\n",
                  xnic->getName().c_str());

  } else {
    // populate it
    if( !PEvent->buildPut(Tag, Addr, Size, Nelem, Stride, Dma, Buf) ){
      output->fatal(CALL_INFO, -1,
                    "%s, Error: could not create XBGAS PUT command\n",
                    xnic->getName().c_str());
    }
    SendMB.push(std::make_pair(PEvent, Dest));
  }

  delete[] Buf;
  return true;
}

void RevXbgas::WriteU8( uint64_t Nmspace, uint64_t Addr, uint8_t Value) {
  uint8_t Tmp = Value;
  if( !WriteMem( Nmspace, Addr, 1, 1, 0, false, (void *)(&Tmp) ) )
    output->fatal(CALL_INFO, -1, "Error: could not write remote memory (U8)");
}

void RevXbgas::WriteU16( uint64_t Nmspace, uint64_t Addr, uint16_t Value) {
  uint16_t Tmp = Value;
  if( !WriteMem( Nmspace, Addr, 2, 1, 0, false, (void *)(&Tmp) ) )
    output->fatal(CALL_INFO, -1, "Error: could not write remote memory (U16)");
}

void RevXbgas::WriteU32( uint64_t Nmspace, uint64_t Addr, uint32_t Value) {
  uint32_t Tmp = Value;
  if( !WriteMem( Nmspace, Addr, 4, 1, 0, false, (void *)(&Tmp) ) )
    output->fatal(CALL_INFO, -1, "Error: could not write remote memory (U32)");
}

void RevXbgas::WriteU64( uint64_t Nmspace, uint64_t Addr, uint64_t Value) {
  uint64_t Tmp = Value;
  if( !WriteMem( Nmspace, Addr, 8, 1, 0, false, (void *)(&Tmp) ) )
    output->fatal(CALL_INFO, -1, "Error: could not write remote memory (U64)");
}

void RevXbgas::WriteFloat( uint64_t Nmspace, uint64_t Addr, float Value) {
  uint32_t Tmp = 0x00;
  std::memcpy(&Tmp,&Value,sizeof(float));
  if( !WriteMem( Nmspace, Addr, 4, 1, 0, false, (void *)(&Tmp) ) )
    output->fatal(CALL_INFO, -1, "Error: could not write remote memory (FLOAT)");
}

void RevXbgas::WriteDouble( uint64_t Nmspace, uint64_t Addr, double Value) {
  uint64_t Tmp = 0x00;
  std::memcpy(&Tmp,&Value,sizeof(double));
  if( !WriteMem( Nmspace, Addr, 8, 1, 0, false, (void *)(&Tmp) ) )
    output->fatal(CALL_INFO, -1, "Error: could not write remote memory (DOUBLE)");
}

void RevXbgas::WriteBulkU8( uint64_t Nmspace, uint64_t DestAddr, 
                            uint32_t Nelem, uint32_t Stride, uint64_t SrcAddr) {
  if ( !WriteMem( Nmspace, DestAddr, 1, Nelem, Stride, true, (void *)(SrcAddr)) )
    output->fatal(CALL_INFO, -1, "Error: could not write remote memory (U8 BULK)");
}

void RevXbgas::WriteBulkU16( uint64_t Nmspace, uint64_t DestAddr, 
                            uint32_t Nelem, uint32_t Stride, uint64_t SrcAddr) {
  if ( !WriteMem( Nmspace, DestAddr, 2, Nelem, Stride, true, (void *)(SrcAddr)) )
    output->fatal(CALL_INFO, -1, "Error: could not write remote memory (U16 BULK)");
}

void RevXbgas::WriteBulkU32( uint64_t Nmspace, uint64_t DestAddr, 
                            uint32_t Nelem, uint32_t Stride, uint64_t SrcAddr) {
  if ( !WriteMem( Nmspace, DestAddr, 4, Nelem, Stride, true, (void *)(SrcAddr)) )
    output->fatal(CALL_INFO, -1, "Error: could not write remote memory (U32 BULK)");
}

void RevXbgas::WriteBulkU64( uint64_t Nmspace, uint64_t DestAddr, 
                            uint32_t Nelem, uint32_t Stride, uint64_t SrcAddr) {
  if ( !WriteMem( Nmspace, DestAddr, 8, Nelem, Stride, true, (void *)(SrcAddr)) )
    output->fatal(CALL_INFO, -1, "Error: could not write remote memory (U64 BULK)");
}

void RevXbgas::WriteBulkFloat( uint64_t Nmspace, uint64_t DestAddr, 
                            uint32_t Nelem, uint32_t Stride, uint64_t SrcAddr) {
  if ( !WriteMem( Nmspace, DestAddr, 4, Nelem, Stride, true, (void *)(SrcAddr)) )
    output->fatal(CALL_INFO, -1, "Error: could not write remote memory (FLOAT BULK)");
}

void RevXbgas::WriteBulkDouble( uint64_t Nmspace, uint64_t DestAddr, 
                                uint32_t Nelem, uint32_t Stride, uint64_t SrcAddr) {
  if ( !WriteMem( Nmspace, DestAddr, 8, Nelem, Stride, true, (void *)(SrcAddr)) )
    output->fatal(CALL_INFO, -1, "Error: could not write remote memory (DOUBLE BULK)");
}

bool RevXbgas::ReadMem( uint64_t Nmspace, uint64_t Addr, size_t Len, 
                        uint32_t Nelem, uint32_t Stride, 
                        bool Dma, uint64_t DmaDestAddr ){
  int Dest = findDest(Nmspace);
  xbgasNicEvent *GEvent = nullptr;
  uint8_t Tag  = createTag();
  uint32_t Size = (uint32_t)(Len * Nelem);
  uint64_t Src = xnic->getAddress();
  bool recvd = false;

  output->verbose(CALL_INFO, 6, 0,
                  "Reading %" PRIu32 " Bytes from PE=%d Starting at 0x%2x, Tag=%u\n", Len, Dest, Addr, Tag);

  GEvent = new xbgasNicEvent(xnic->getName()); // new event to send
  GEvent->setSrc(Src);
  GEvent->setDMA(Dma);

  // populate it
  if( !GEvent->buildGet(Tag, Addr, Size, Nelem, Stride, Dma, DmaDestAddr) ){
    output->fatal(CALL_INFO, -1,
                  "%s, Error: could not create XBGAS Get command\n",
                  xnic->getName().c_str());
  }
  
  SendMB.push(std::make_pair(GEvent, Dest));

  // Remember the get request
  TrackGets.push_back(std::make_tuple(Tag, Dest, Addr));

  return true;
}

void RevXbgas::ReadU8( uint64_t Nmspace, uint64_t Addr ) {
  if( !ReadMem( Nmspace, Addr, 1, 1, 0, false, 0x00ull) )
    output->fatal(CALL_INFO, -1, "Error: could not read remote memory (U8)");
}

void RevXbgas::ReadU16( uint64_t Nmspace, uint64_t Addr ) {
  if( !ReadMem( Nmspace, Addr, 2, 1, 0, false, 0x00ull) )
    output->fatal(CALL_INFO, -1, "Error: could not read remote memory (U16)");
}

void RevXbgas::ReadU32( uint64_t Nmspace, uint64_t Addr ) {
  if( !ReadMem( Nmspace, Addr, 4, 1, 0, false, 0x00ull) )
    output->fatal(CALL_INFO, -1, "Error: could not read remote memory (U32)");
}

void RevXbgas::ReadU64( uint64_t Nmspace, uint64_t Addr ) {
  if( !ReadMem( Nmspace, Addr, 8, 1, 0, false, 0x00ull) )
    output->fatal(CALL_INFO, -1, "Error: could not read remote memory (U64)");
}

void RevXbgas::ReadFloat( uint64_t Nmspace, uint64_t Addr ) {
  if( !ReadMem( Nmspace, Addr, 4, 1, 0, false, 0x00ull) )
    output->fatal(CALL_INFO, -1, "Error: could not read remote memory (FLOAT)");
}

void RevXbgas::ReadDouble( uint64_t Nmspace, uint64_t Addr ) {
  if( !ReadMem( Nmspace, Addr, 8, 1, 0, false, 0x00ull) )
    output->fatal(CALL_INFO, -1, "Error: could not read remote memory (DOUBLE)");
}

void RevXbgas::ReadBulkU8( uint64_t Nmspace, uint64_t SrcAddr, 
                           uint32_t Nelem, uint32_t Stride, 
                           uint64_t DestAddr) {
  
  if( !ReadMem( Nmspace, SrcAddr, 1, Nelem, Stride, true, DestAddr) )
    output->fatal(CALL_INFO, -1, "Error: could not read remote memory (U8 BULK)");
}

void RevXbgas::ReadBulkU16( uint64_t Nmspace, uint64_t SrcAddr, 
                           uint32_t Nelem, uint32_t Stride, uint64_t DestAddr) {
  
  if( !ReadMem( Nmspace, SrcAddr, 2, Nelem, Stride, true, DestAddr) )
    output->fatal(CALL_INFO, -1, "Error: could not read remote memory (U16 BULK)");
}

void RevXbgas::ReadBulkU32( uint64_t Nmspace, uint64_t SrcAddr, 
                           uint32_t Nelem, uint32_t Stride, uint64_t DestAddr) {
  
  if( !ReadMem( Nmspace, SrcAddr, 4, Nelem, Stride, true, DestAddr) )
    output->fatal(CALL_INFO, -1, "Error: could not read remote memory (U32 BULK)");
}

void RevXbgas::ReadBulkU64( uint64_t Nmspace, uint64_t SrcAddr, 
                            uint32_t Nelem, uint32_t Stride, uint64_t DestAddr) {
  
  if( !ReadMem( Nmspace, SrcAddr, 8, Nelem, Stride, true, DestAddr) )
    output->fatal(CALL_INFO, -1, "Error: could not read remote memory (U64 BULK)");
}

void RevXbgas::ReadBulkFloat( uint64_t Nmspace, uint64_t SrcAddr, 
                              uint32_t Nelem, uint32_t Stride, uint64_t DestAddr) {
  
  if( !ReadMem( Nmspace, SrcAddr, 4, Nelem, Stride, true, DestAddr) )
    output->fatal(CALL_INFO, -1, "Error: could not read remote memory (FLOAT BULK)");
}

void RevXbgas::ReadBulkDouble( uint64_t Nmspace, uint64_t SrcAddr, 
                               uint32_t Nelem, uint32_t Stride, uint64_t DestAddr) {
  
  if( !ReadMem( Nmspace, SrcAddr, 8, Nelem, Stride, true, DestAddr) )
    output->fatal(CALL_INFO, -1, "Error: could not read remote memory (DOUBLE BULK)");
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
  char *DataElem = (char *)(Data);
  for( auto it=GetResponses.begin(); it != GetResponses.end(); ++it ) {
    if( std::get<0>(*it) == Tag ) {
      uint64_t *tmp_data = std::get<1>(*it);
      char *tmp_data_elem = (char *)tmp_data;
      size_t Len = (size_t)(std::get<2>(*it));  // Len = Size since Nelem is always 1 for the Responses queue.
      for( unsigned i=0; i < Len; i++ ){
        DataElem[i] = tmp_data_elem[i];
      }
      delete[] tmp_data;

      for( auto itt=TrackGets.begin(); itt != TrackGets.end(); ++it ){
        if( std::get<0>(*itt) == Tag ) {
          TrackGets.erase(itt);
          break;
        }
      }

      GetResponses.erase(it);
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