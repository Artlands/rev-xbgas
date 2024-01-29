//
// _RevRmtMemCtrl_h_
//
// Copyright (C) 2017-2023 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

// #include "../include/RevMem.h"
// #include "../include/XbgasNIC.h"
#include "../include/RevRmtMemCtrl.h"
#include "../include/RevInstTable.h"

using namespace SST;
using namespace SST::RevCPU;
using namespace SST::Interfaces;

#define _XBGAS_DEBUG

// Remote memory controller interface
// RevMem:RmtReadVal->RevMem:RmtReadMem->RevRmtMemCtrl:sendRmtReadRqst
// rqstQ.push_back -> RevRmtMemCtrl:processNextRqst -> RevRmtMemCtrl:buildRmtMemRqst

// ----------------------------------------
// RevRmtMemOp
// ----------------------------------------
RevRmtMemOp::RevRmtMemOp( unsigned Hart, uint64_t Nmspace, uint64_t SrcAddr, size_t Size, 
                          RmtMemOp Op, RevFlag flags )
  : Hart(Hart), Nmspace(Nmspace), SrcAddr(SrcAddr), DestAddr(0), Size(Size), 
    Nelem(1), Stride(0), Op(Op), Flags(flags),
    target(nullptr), procReq(){
}

RevRmtMemOp::RevRmtMemOp( unsigned Hart, uint64_t Nmspace, uint64_t SrcAddr, size_t Size, 
                          void *target, RmtMemOp Op, RevFlag Flags )
  : Hart(Hart), Nmspace(Nmspace), SrcAddr(SrcAddr), DestAddr(0), Size(Size), 
    Nelem(1), Stride(0), Op(Op), Flags(Flags),
    target(target), procReq(){
}

RevRmtMemOp::RevRmtMemOp( unsigned Hart, uint64_t Nmspace, uint64_t DestAddr, size_t Size, 
                          char *buffer, RmtMemOp Op, RevFlag Flags )
  : Hart(Hart), Nmspace(Nmspace), SrcAddr(0), DestAddr(DestAddr), Size(Size), 
    Nelem(1), Stride(0), Op(Op), Flags(Flags),
    target(nullptr), procReq() {
  for(uint32_t i = 0; i < Size; ++i){
    membuf.push_back(buffer[i]);
  }
}

RevRmtMemOp::RevRmtMemOp( unsigned Hart, uint64_t Nmspace, uint64_t SrcAddr, size_t Size,
                          uint32_t Nelem, uint32_t Stride, uint64_t DestAddr, 
                          RmtMemOp Op, RevFlag Flags )
  : Hart(Hart), Nmspace(Nmspace), SrcAddr(SrcAddr), DestAddr(DestAddr), Size(Size), 
    Nelem(Nelem), Stride(Stride), Op(Op), Flags(Flags),
    target(nullptr), procReq(){
}

// ----------------------------------------
// RevRmtMemCtrl
// ----------------------------------------
RevRmtMemCtrl::RevRmtMemCtrl(ComponentId_t id, const Params& params)
  : SubComponent(id), output(nullptr) {
  
  uint32_t verbosity = params.find<uint32_t>("verbose");
  output = new SST::Output("[RevRmtMemCtrl @t]: ", verbosity, 0, SST::Output::STDOUT);

}

RevRmtMemCtrl::~RevRmtMemCtrl(){
  delete output;
}

// ----------------------------------------
// RevBasicRmtMemCtrl
// ----------------------------------------
RevBasicRmtMemCtrl::RevBasicRmtMemCtrl(ComponentId_t id, const Params& params)
  : RevRmtMemCtrl(id, params), xbgasNic(nullptr), virtualHart(0), 
    myPEid(0), numPEs(0),
    max_loads(64), max_stores(64), max_ops(2),
    num_read(0x00ull), num_write(0x00ull){

  std::string ClockFreq = params.find<std::string>("clock", "1Ghz");

  xbgasNic = loadUserSubComponent<RevCPU::xbgasNicAPI>( "xbgasNicIface");
  
  if( !xbgasNic ){
    output->fatal(CALL_INFO, -1, "Error: unable to load xbgasNicAPI\n");
  }

  xbgasNic->setMsgHandler(new Event::Handler<RevBasicRmtMemCtrl>(
                          this, &RevBasicRmtMemCtrl::rmtMemEventHandler));

  virtualHart = params.find<uint16_t>("numHarts", "1");
  max_loads = params.find<uint32_t>("max_loads", 64);
  max_stores = params.find<uint32_t>("max_stores", 64);
  max_ops = params.find<uint32_t>("ops_per_cycle", 2);

  rqstQ.reserve(max_ops);

  registerStats();

  registerClock( ClockFreq,
                 new Clock::Handler<RevBasicRmtMemCtrl>(this, &RevBasicRmtMemCtrl::clockTick ) );
}

RevBasicRmtMemCtrl::~RevBasicRmtMemCtrl(){
  for( auto* p: rqstQ )
    delete p;
  rqstQ.clear();
}

void RevBasicRmtMemCtrl::registerStats(){
  for( auto* stat: {
    "RmtReadInFlight",
    "RmtReadPending",
    "RmtReadBytes",
    "RmtWriteInFlight",
    "RmtWritePending",
    "RmtWritesBytes",
  }) {
    stats.push_back(registerStatistic<uint64_t>(stat));
  }
}

void RevBasicRmtMemCtrl::recordStat(RevBasicRmtMemCtrl::RmtMemCtrlStats Stat, uint64_t Data){
  stats[Stat]->addData(Data);
}

void RevBasicRmtMemCtrl::rmtMemEventHandler(Event *ev) {
  xbgasNicEvent *event = static_cast<xbgasNicEvent*>(ev);
  switch(event->getOp()){
    case RmtMemOp::READRqst:
      handleReadRqst( event );
      break;
    case RmtMemOp::WRITERqst:
      handleWriteRqst( event );
      break;
    case RmtMemOp::READResp:
      handleReadResp( event );
      break;
    case RmtMemOp::WRITEResp:
      handleWriteResp( event );
      break;
    // case RmtMemOp::Finish:
    //   handleFinish( event );
    //   break;
    default:
      output->fatal(CALL_INFO, -1, "Error : unknown remote memory operation type\n");
      break;
  }
}

void RevBasicRmtMemCtrl::handleReadRqst( xbgasNicEvent *ev ){
  uint32_t Id       = ev->getID();
  uint32_t SrcId    = ev->getSrcId();
  uint64_t SrcAddr  = ev->getSrcAddr(); 
  uint64_t DestAddr = ev->getDestAddr();
  size_t   Size     = ev->getSize();
  uint32_t Nelem    = ev->getNelem();
  uint32_t Stride   = ev->getStride();
  RevFlag  Flags    = ev->getFlags();

#ifdef _XBGAS_DEBUG
  std::cout << "PE " << getPEID() << " handle Read Rqst, ";
  std::cout << "Event ID: " << Id
            << ", SrcId: " << SrcId 
            << ", SrcAddr: 0x" << std::hex << SrcAddr 
            << ", DestAddr: 0x" << std::hex << DestAddr
            << ", Size: " << Size 
            << ", Nelem: " << Nelem 
            << ", Stride: " << Stride << std::endl;
#endif

  uint8_t *buffer = new uint8_t[Size * Nelem];

  // Records the read request info in the load queue 
  LocalLoadRecord.insert({RmtLSQHash(SrcId, Id), 
                         {SrcId, Id, DestAddr, Size, Nelem, Stride, Flags, buffer}});
  LocalLoadCount.insert({RmtLSQHash(SrcId, Id), 0x00ul});
  LocalLoadType.insert({RmtLSQHash(SrcId, Id), RmtMemOp::READRqst});

  for( uint32_t i=0; i < Nelem; i++ ){
    MemReq req(SrcAddr + i * Stride,                      // Memory address
               0,                                         // Destination register (ignored)
               RevRegClass::RegUNKNOWN,                   // Register class (ignored)
               virtualHart,                               // Virtual Hart ID
               MemOp::MemOpREAD,                          // Memory operation
               true,                                      // Outstanding
               [this](const MemReq& req) {                // Lambda function as a callback
                  RevBasicRmtMemCtrl::MarkLocalLoadComplete(req);
               });
    LocalLoadTrack.insert({SrcAddr + i * Stride, RmtLSQHash(SrcId, Id)});
    Mem->ReadMem(virtualHart, 
                 SrcAddr + i * Stride, 
                 Size, 
                 (void *)(&buffer[i * Size]), 
                 std::move(req), 
                 Flags);
  }
}

void RevBasicRmtMemCtrl::handleWriteRqst( xbgasNicEvent *ev ){
  uint32_t Id       = ev->getID();
  uint32_t SrcId    = ev->getSrcId();
  uint64_t SrcAddr  = ev->getSrcAddr(); 
  uint64_t DestAddr = ev->getDestAddr();
  size_t   Size     = ev->getSize();
  uint32_t Nelem    = ev->getNelem();
  uint32_t Stride   = ev->getStride();
  RevFlag  Flags    = ev->getFlags();


#ifdef _XBGAS_DEBUG
  std::cout << "PE " << getPEID() << " handle Write Rqst, ";
  std::cout << "Event ID: " << Id
            << ", SrcId: " << SrcId 
            << ", SrcAddr: 0x" << std::hex << SrcAddr 
            << ", DestAddr: 0x" << std::hex << DestAddr
            << ", Size: " << Size 
            << ", Nelem: " << Nelem 
            << ", Stride: " << Stride << std::endl;
#endif

  uint8_t *buffer = new uint8_t[Size * Nelem];
  ev->getData( buffer );
  
  for( uint32_t i=0; i < Nelem; i++ ){
    Mem->WriteMem(virtualHart, 
                  DestAddr + i * Stride, 
                  Size, 
                  (void *)(&buffer[i * Size]), 
                  Flags);
  }

  delete[] buffer;

  // Send the write response
  xbgasNicEvent *RmtEvent = new xbgasNicEvent( getName() );
  RmtEvent->buildWRITEResp(Id);
  xbgasNic->send(RmtEvent, SrcId);
}

void RevBasicRmtMemCtrl::handleReadResp( xbgasNicEvent *ev ){

#ifdef _XBGAS_DEBUG
  std::cout << "PE " << getPEID()
            << " handle Read Resp, "
            << "Event ID: " << ev->getID()
            << ", SrcId: " << ev->getSrcId() 
            << ", SrcAddr: 0x" << std::hex << ev->getSrcAddr() 
            << ", DestAddr: 0x" << std::hex << ev->getDestAddr()
            << ", Size: " << ev->getSize() 
            << ", Nelem: " << ev->getNelem() 
            << ", Stride: " << ev->getStride() << std::endl;
#endif

  if( std::find(requests.begin(), requests.end(), ev->getID()) != requests.end() ){
    requests.erase(std::find(requests.begin(), requests.end(), ev->getID()));
    RevRmtMemOp *Op = outstanding[ev->getID()];
    const RmtMemReq& r = Op->getRmtMemReq();
    uint8_t *target = static_cast<uint8_t *>(Op->getTarget());

    if( !Op )
      output->fatal(CALL_INFO, -1, "RevRmtMemOp is null in handleReadResp\n");
    switch(ev->getOp()){
    case RmtMemOp::READResp:
      ev->getData( target );    // Copy the data to the target register
      r.MarkRmtLoadComplete();  // Mark the remote load complete
      break;
    case RmtMemOp::BulkREADResp:
      handleWriteRqst(ev);      // Write the data to the local memory
      break;
    default:
      output->fatal(CALL_INFO, -1, "Error: unknown remote memory response\n");
      break;
    }
    outstanding.erase(ev->getID());
    delete ev;
  } else {
    output->fatal(CALL_INFO, -1, "Error: found unknown ReadResp\n");
  }
  num_read--;
  return;
}

void RevBasicRmtMemCtrl::handleWriteResp( xbgasNicEvent *ev ){

#ifdef _XBGAS_DEBUG
  std::cout << "PE " << getPEID()
            << " handle Write Resp, "
            << "Event ID: " << ev->getID()
            << ", SrcId: " << ev->getSrcId() 
            << ", SrcAddr: 0x" << std::hex << ev->getSrcAddr() 
            << ", DestAddr: 0x" << std::hex << ev->getDestAddr()
            << ", Size: " << ev->getSize() 
            << ", Nelem: " << ev->getNelem() 
            << ", Stride: " << ev->getStride() << std::endl;
#endif

  if( std::find(requests.begin(), requests.end(), ev->getID()) != requests.end() ){
    requests.erase(std::find(requests.begin(), requests.end(), ev->getID()));
    RevRmtMemOp *Op = outstanding[ev->getID()];
    if( !Op )
      output->fatal(CALL_INFO, -1, "RevRmtMemOp is null in handleWriteResp\n");
    switch(ev->getOp()){
    case RmtMemOp::WRITEResp:
      break;
    case RmtMemOp::BulkWRITEResp:
      break;
    default:
      output->fatal(CALL_INFO, -1, "Error: unknown remote memory response\n");
      break;
    }
    outstanding.erase(ev->getID());
    delete ev;
  } else {
    output->fatal(CALL_INFO, -1, "Error: found unknown WriteResp\n");
  }
  num_write--;
  return;
}


void RevBasicRmtMemCtrl::MarkLocalLoadComplete( const MemReq& req ) {
  // Count the number of elements already fulfilled
  auto it = LocalLoadTrack.find(req.Addr);
  uint64_t id = it->second;
  if( LocalLoadCount.find(id) != LocalLoadCount.end() ){
    LocalLoadCount[id]++;
    // Remove the entry from the load track table
    LocalLoadTrack.erase(it);
  } else {
    output->fatal(CALL_INFO, -1, "Error: unable to find the load count entry\n");
  }

  auto Entry = LocalLoadRecord.find(id)->second;
  xbgasNicEvent *RmtEvent;
  
  // Check if all the elements have been fulfilled
  if( LocalLoadCount[id] == std::get<LOAD_RECORD_NELEM>(Entry) ){
    uint8_t *buffer = std::get<LOAD_RECORD_BUFFER>(Entry);
    RmtMemOp OpType = LocalLoadType.find(id)->second;


#ifdef _XBGAS_DEBUG
  std::cout << "PE " << getPEID() << " mark local load complete, ";
  std::cout << "Event ID: " << std::get<LOAD_RECORD_ID>(Entry)
            << ", SrcId: " << std::get<LOAD_RECORD_SRCID>(Entry) 
            << ", OpTyPE " << rmtMemOpToString(OpType)
            << std::endl;
#endif


    switch (OpType) {
    case RmtMemOp::READRqst:
    case RmtMemOp::BulkREADRqst:
      // All the elements have been fulfilled; send the response
      RmtEvent = new xbgasNicEvent( getName() );
      RmtEvent->buildREADResp(std::get<LOAD_RECORD_ID>(Entry), 
                              std::get<LOAD_RECORD_DESTADDR>(Entry),
                              std::get<LOAD_RECORD_SIZE>(Entry), 
                              std::get<LOAD_RECORD_NELEM>(Entry),
                              std::get<LOAD_RECORD_STRIDE>(Entry),
                              buffer);
      // Destination is the source of the request
      xbgasNic->send(RmtEvent, std::get<LOAD_RECORD_SRCID>(Entry));
      break;
    case RmtMemOp::BulkWRITERqst:
      // All the elements have been read to buffer; send the write request
      RmtEvent = EventsToSend.find(id)->second;
      RmtEvent->setData( buffer, 
                         std::get<LOAD_RECORD_SIZE>(Entry) * std::get<LOAD_RECORD_NELEM>(Entry) );
      xbgasNic->send(RmtEvent, std::get<LOAD_RECORD_DESTID>(Entry));
      EventsToSend.erase(id);
      break;
    default:
      break;
    }
    // Remove buffer and the entry from the load queue
    delete[] buffer;
    LocalLoadCount.erase(id);
    LocalLoadRecord.erase(id);
    LocalLoadType.erase(id);
  }
}

void RevBasicRmtMemCtrl::init(unsigned int phase){
  xbgasNic->init(phase);
}

void RevBasicRmtMemCtrl::setup(){
  if( xbgasNic == nullptr )
    output->fatal(CALL_INFO, -1, "Error: xBGAS NIC Inferface is null\n");
  xbgasNic->setup();

  xbgasHosts = xbgasNic->getXbgasHosts();
  myPEid = xbgasNic->getAddress();
  numPEs = xbgasHosts.size();

  // Namespece Lookaside Buffer Initialization. Now using a naive implementation,
  // i.e, the first entry is reserved for the local PE and the rest of namespace id
  // is calculated by adding 1 to the PE id.
  uint64_t nmspace = 0;

  if (xbgasHosts.size() != 0) {
    // The first entry is reserved for the local PE
    nmspaceLB[nmspace] = myPEid;
    for ( unsigned i = 1; i < numPEs; i++ ) {
      nmspace = (uint64_t)(xbgasHosts[i] + 1);
      nmspaceLB[nmspace] = xbgasHosts[i];
    }
  }

#ifdef _XBGAS_DEBUG
  std::cout << "Namespace Lookaside Buffer of PE " << myPEid << ":" << std::endl;
  std::cout << "|" << std::string(23, '-') << "|" << "\n";
  std::cout << "|" << " Namespace " << "|" << "Physical ID" << "|" << "\n";
  for (auto it = nmspaceLB.begin(); it != nmspaceLB.end(); ++it) {
    std::cout << "|" << std::string(11, '-') << "+" << std::string(11, '-') << "|" << "\n";
    std::cout << "|" << std::string(5, ' ') << it->first << std::string(5, ' ') << "|"
                     << std::string(5, ' ') << it->second << std::string(5, ' ') << "|" << '\n';
  }
  std::cout << "|" << std::string(23, '-') << "|" << "\n";
#endif

}

void RevBasicRmtMemCtrl::finish(){
}

bool RevBasicRmtMemCtrl::sendRmtReadRqst( unsigned Hart, uint64_t Nmspace, 
                                          uint64_t SrcAddr, size_t Size, 
                                          void *Target,
                                          const RmtMemReq& req, RevFlag flags) {
// #ifdef _XBGAS_DEBUG
//   std::cout << "PE " << getPEID() << ", RevBasicRmtMemCtrl::sendRmtReadRqst" 
//             << ", Nmspace: " << Nmspace << std::endl;
// #endif
  
  if( Size == 0 )
    return true;
  RevRmtMemOp *Op = new RevRmtMemOp( Hart, Nmspace, SrcAddr, Size, 
                                     Target, RmtMemOp::READRqst, flags );
  RevFlag TmpFlags = Op->getNonCacheFlags();
  Op->setRmtMemReq( req );
  Op->setFlags( TmpFlags );
  rqstQ.push_back( Op );
  recordStat(RevBasicRmtMemCtrl::RmtMemCtrlStats::RmtReadPending, 1);
  return true;
}

bool RevBasicRmtMemCtrl::sendRmtBulkReadRqst( unsigned Hart, uint64_t Nmspace, 
                                              uint64_t SrcAddr, size_t Size, 
                                              uint32_t Nelem, uint32_t Stride, 
                                              uint64_t DestAddr,
                                              const RmtMemReq& req, RevFlag flags) {
  if( Size == 0 )
    return true;
  RevRmtMemOp *Op = new RevRmtMemOp( Hart, Nmspace, SrcAddr, Size, Nelem, Stride,
                                     DestAddr, RmtMemOp::BulkREADRqst, flags );
  RevFlag TmpFlags = Op->getNonCacheFlags();
  Op->setRmtMemReq( req );
  Op->setFlags( TmpFlags );
  rqstQ.push_back( Op );
  recordStat(RevBasicRmtMemCtrl::RmtMemCtrlStats::RmtReadPending, 1);
  return true;
}

bool RevBasicRmtMemCtrl::sendRmtWriteRqst( unsigned Hart, uint64_t Nmspace, 
                                           uint64_t DestAddr, size_t Size, 
                                           char *buffer, RevFlag flags) {
  if( Size == 0 )
    return true;
  RevRmtMemOp *Op = new RevRmtMemOp( Hart, Nmspace, DestAddr, Size, buffer,
                                     RmtMemOp::WRITERqst, flags );
  RevFlag TmpFlags = Op->getNonCacheFlags();
  Op->setFlags( TmpFlags );
  rqstQ.push_back( Op );
  recordStat(RevBasicRmtMemCtrl::RmtMemCtrlStats::RmtWritePending, 1);
  return true;
}

bool RevBasicRmtMemCtrl::sendRmtBulkWriteRqst( unsigned Hart, uint64_t Nmspace, 
                                               uint64_t DestAddr, size_t Size,
                                               uint32_t Nelem, uint32_t Stride,
                                               uint64_t SrcAddr, RevFlag flags) {
  if( Size == 0 )
    return true;
  RevRmtMemOp *Op = new RevRmtMemOp( Hart, Nmspace, DestAddr, Size, Nelem, Stride,
                                     SrcAddr, RmtMemOp::BulkWRITERqst, flags );
  RevFlag TmpFlags = Op->getNonCacheFlags();
  Op->setFlags( TmpFlags );
  rqstQ.push_back( Op );
  recordStat(RevBasicRmtMemCtrl::RmtMemCtrlStats::RmtWritePending, 1);
  return true;
}

bool RevBasicRmtMemCtrl::clockTick( Cycle_t cycle ){
  // process the remote memory requests
  bool done = false;
  unsigned t_max_ops = 0;
  unsigned t_max_loads = 0;
  unsigned t_max_stores = 0;

  while( !done ){
    if( !processNextRqst(t_max_loads, t_max_stores, t_max_ops) ){
      // error occurred
      output->fatal(CALL_INFO, -1, "Error: unable to process next remote memory request\n");
    }
    if( t_max_ops == max_ops )
      done = true;
  }

  return false;
}

bool RevBasicRmtMemCtrl::isDone() {
  return requests.size() == 0;
}

bool RevBasicRmtMemCtrl::processNextRqst(unsigned &t_max_loads, 
                                         unsigned &t_max_stores, 
                                         unsigned &t_max_ops){
  if( rqstQ.size() == 0 ){
    // nothing to do, saturate and exit this cycle
    t_max_ops = max_ops;
    return true;
  }

  bool success = false;
  // retrieve the next candidate remote memory operation
  for( unsigned i = 0; i < rqstQ.size(); i++ ){
    RevRmtMemOp *op = rqstQ[i];
    if( isRmtMemOpAvailable(op, t_max_loads, t_max_stores) ){
      // op is good to execute, build a remote memory request packet
      t_max_ops++;

      // build the remote memory request
      if( !buildRmtMemRqst(op, success) ){
        output->fatal(CALL_INFO, -1, "Error: unable to build remote memory request\n");
        return false;
      }

      // sent the request, remove it
      if( success ){
        rqstQ.erase(rqstQ.begin()+i);
      } else {
        // go ahead and max out our current request window
        // otherwise, this request for induce an infinite loop
        // we also leave the current (failed) request in the queue
        t_max_ops = max_ops;
      }
      return true; 
    }
  }

  // if we reach this point, then we've attempted to
  // process all the potential requests.  none exist
  // that can be dispatched at this time.
  t_max_ops = max_ops;
  return true;
}

bool RevBasicRmtMemCtrl::isRmtMemOpAvailable( RevRmtMemOp *Op, 
                                              unsigned &t_max_loads, 
                                              unsigned &t_max_stores ){
  switch(Op->getOp()){
  case RmtMemOp::READRqst:
    if( t_max_loads < max_loads ){
      t_max_loads++;
      return true;
    }
    break;
  case RmtMemOp::WRITERqst:
    if( t_max_stores < max_stores ){
      t_max_stores++;
      return true;
    }
    break;
  default:
    output->fatal(CALL_INFO, -1, "Error: unknown remote memory operation\n");
    break;
  }
  return false;
}

bool RevBasicRmtMemCtrl::buildRmtMemRqst( RevRmtMemOp *Op, bool &Success ){
  uint32_t SrcId = (uint32_t)( xbgasNic->getAddress() );
  uint32_t DestId = findDest( Op->getNmspace() );
  uint8_t *buffer = nullptr;
  
  // Build the remote memory read request packet; remote memory write request
  // is built after the data is read from the local memory, which is implemented
  // in the callback function
  xbgasNicEvent *RmtEvent = new xbgasNicEvent( getName() );
  RmtEvent->setSrcId( SrcId );

  uint32_t Id;
  uint64_t SrcAddr  = Op->getSrcAddr(); 
  uint64_t DestAddr = Op->getDestAddr();
  size_t   Size     = Op->getSize();
  uint32_t Nelem    = Op->getNelem();
  uint32_t Stride   = Op->getStride();
  RevFlag Flags     = Op->getFlags();
  std::vector<uint8_t> tmpBuf = Op->getBuf();

  switch(Op->getOp()){
  case RmtMemOp::READRqst:
  case RmtMemOp::BulkREADRqst:
    RmtEvent->buildREADRqst(SrcAddr, 
                            DestAddr,
                            Size, 
                            Nelem, 
                            Stride,
                            Flags);
    xbgasNic->send(RmtEvent, DestId);
    requests.push_back(RmtEvent->getID());

#ifdef _XBGAS_DEBUG
  std::cout << "PE " << getPEID() 
            << " build Read Rqst, "
            << "Event Id: " << std::dec << RmtEvent->getID() 
            << std::endl;
#endif

    outstanding[RmtEvent->getID()] = Op;
    recordStat(RmtReadInFlight, 1);
    num_read++;
    break;
  case RmtMemOp::WRITERqst:
    buffer = new uint8_t[Size];
    for(unsigned i = 0; i < Size; ++i){
      buffer[i] = tmpBuf[i];
    }
    RmtEvent->buildWRITERqst(DestAddr, 
                             Size, 
                             Nelem, 
                             Stride, 
                             Flags,
                             buffer);
    xbgasNic->send(RmtEvent, DestId);
    requests.push_back(RmtEvent->getID());

#ifdef _XBGAS_DEBUG
  std::cout << "PE " << getPEID() 
            << " build Write Rqst, "
            << "Event Id: " << std::dec << RmtEvent->getID() 
            << std::endl;
#endif

    outstanding[RmtEvent->getID()] = Op;
    recordStat(RmtWriteInFlight, 1);
    num_write++;
    delete[] buffer;
    break;
  case RmtMemOp::BulkWRITERqst:
    // Buffer is empty now and will be filled in the callback function
    buffer = new uint8_t[Size * Nelem];
    RmtEvent->buildWRITERqst(DestAddr, 
                             Size, 
                             Nelem, 
                             Stride, 
                             Flags,
                             buffer);
    Id = RmtEvent->getID();
    // Records the read request info in the load queue 
    LocalLoadRecord.insert({RmtLSQHash(DestId, Id), 
                           {DestId, Id, DestAddr, Size, Nelem, Stride, Flags, buffer}});
    LocalLoadCount.insert({RmtLSQHash(DestId, Id), 0x00ul});
    LocalLoadType.insert({RmtLSQHash(DestId, Id), RmtMemOp::BulkWRITERqst});
    EventsToSend.insert({RmtLSQHash(DestId, Id), RmtEvent});

    for( uint32_t i=0; i < Nelem; i++ ){
      MemReq req(SrcAddr + i * Stride,                      // Memory address
                 0,                                         // Destination register (ignored)
                 RevRegClass::RegUNKNOWN,                   // Register class (ignored)
                 virtualHart,                               // Virtual Hart ID
                 MemOp::MemOpREAD,                          // Memory operation
                 true,                                      // Outstanding
                 [this](const MemReq& req) {                // Lambda function as a callback
                     RevBasicRmtMemCtrl::MarkLocalLoadComplete(req);
                 });
      LocalLoadTrack.insert({SrcAddr + i * Stride,
                             RmtLSQHash(DestId, Id)});
      Mem->ReadMem(virtualHart, 
                   SrcAddr + i * Stride, 
                   Size, 
                   (void *)(&buffer[i * Size]), 
                   std::move(req), 
                   Flags);
    }
    requests.push_back(RmtEvent->getID());
    outstanding[RmtEvent->getID()] = Op;
    recordStat(RmtWriteInFlight, 1);
    num_write++;
    break;
  default:
    return false;
    break;
  }
  Success = true;
  return true;
}

uint32_t RevBasicRmtMemCtrl::findDest( uint64_t Nmspace ){
  auto it = nmspaceLB.find(Nmspace);
  if( it == nmspaceLB.end() )
    return -1;
  else
    return it->second;
}

std::string RevBasicRmtMemCtrl::rmtMemOpToString( RmtMemOp OpType ) {
  switch (OpType) {
  case RmtMemOp::READRqst:
    return "READRqst";
  case RmtMemOp::BulkREADRqst:
    return "BulkREADRqst";
  case RmtMemOp::WRITERqst:
    return "WRITERqst";
  case RmtMemOp::BulkWRITERqst:
    return "BulkWRITERqst";
  case RmtMemOp::READResp:
    return "READResp";
  case RmtMemOp::BulkREADResp:
    return "BulkREADResp";
  case RmtMemOp::WRITEResp:
    return "WRITEResp";
  case RmtMemOp::BulkWRITEResp:
    return "BulkWRITEResp";
  default:
    return "Unknown";
  }
}
