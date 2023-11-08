//
// _RevRmtMemCtrl_h_
//
// Copyright (C) 2017-2023 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#include "../include/RevRmtMemCtrl.h"
#include "../include/RevInstTable.h"

using namespace SST;
using namespace SST::RevCPU;
using namespace SST::Interfaces;

// ----------------------------------------
// RevRmtMemOp
// ----------------------------------------
RevRmtMemOp::RevRmtMemOp( unsigned Hart, uint64_t Nmspace, uint64_t SrcAddr, size_t Size, 
                          RmtMemOp Op, StandardMem::Request::flags_t flags )
  : Hart(Hart), Nmspace(Nmspace), SrcAddr(SrcAddr), DestAddr(0), Size(Size), 
    Nelem(1), Stride(0), Op(Op), Flags(flags),
    target(nullptr), procReq(){
}

RevRmtMemOp::RevRmtMemOp( unsigned Hart, uint64_t Nmspace, uint64_t SrcAddr, size_t Size, 
                          void *target, RmtMemOp Op, StandardMem::Request::flags_t Flags )
  : Hart(Hart), Nmspace(Nmspace), SrcAddr(SrcAddr), DestAddr(0), Size(Size), 
    Nelem(1), Stride(0), Op(Op), Flags(Flags),
    target(target), procReq(){
}

RevRmtMemOp::RevRmtMemOp( unsigned Hart, uint64_t Nmspace, uint64_t SrcAddr, size_t Size,
                          uint32_t Nelem, uint32_t Stride, uint64_t DestAddr, 
                          RmtMemOp Op, StandardMem::Request::flags_t Flags )
  : Hart(Hart), Nmspace(Nmspace), SrcAddr(SrcAddr), DestAddr(DestAddr), Size(Size), 
    Nelem(Nelem), Stride(Stride), Op(Op), Flags(Flags),
    target(nullptr), procReq(){
}

RevRmtMemOp::RevRmtMemOp( unsigned Hart, uint64_t Nmspace, uint64_t DestAddr, size_t Size, 
                          char *buffer, RmtMemOp Op, StandardMem::Request::flags_t Flags )
  : Hart(Hart), Nmspace(Nmspace), SrcAddr(0), DestAddr(DestAddr), Size(Size), 
    Nelem(1), Stride(0), Op(Op), Flags(Flags),
    target(nullptr), procReq() {
  for(uint32_t i = 0; i < Size; ++i){
    membuf.push_back(buffer[i]);
  }
}

RevRmtMemOp::RevRmtMemOp( unsigned Hart, uint64_t Nmspace, uint64_t DestAddr, size_t Size,
                          uint32_t Nelem, uint32_t Stride, uint64_t SrcAddr, 
                          char *buffer, RmtMemOp Op, StandardMem::Request::flags_t Flags )
  : Hart(Hart), Nmspace(Nmspace), SrcAddr(SrcAddr), DestAddr(DestAddr), Size(Size), 
    Nelem(Nelem), Stride(Stride), Op(Op), Flags(Flags),
    target(nullptr), procReq(){
  for(uint32_t i = 0; i < Size; ++i){
    membuf.push_back(buffer[i]);
  }
}

// ----------------------------------------
// RevRmtMemCtrl
// ----------------------------------------
RevRmtMemCtrl::RevRmtMemCtrl(ComponentId_t id, const Params& params, TimeConverter* tc)
  : SubComponent(id), output(nullptr) {
  
  uint32_t verbosity = params.find<uint32_t>("verbose");
  output = new Output("RevRmtMemCtrl[@p:@l]: ", verbosity, 0, SST::Output::STDOUT);

}

RevRmtMemCtrl::~RevRmtMemCtrl(){
  delete output;
}

// ----------------------------------------
// RevBasicRmtMemCtrl
// ----------------------------------------
RevBasicRmtMemCtrl::RevBasicRmtMemCtrl(ComponentId_t id, const Params& params, TimeConverter* tc)
  : RevRmtMemCtrl(id, params, tc), xbgasNicIface(nullptr), virtualHart(0),
    max_loads(64), max_stores(64), max_ops(2),
    num_read(0x00ull), num_write(0x00ull){
  
  Params xbgasNicParams = params.get_scoped_params("xbgasNicParams");
  xbgasNicIface = loadAnonymousSubComponent<RevCPU::xbgasNicAPI>( "revcpu.XbgasNIC",
                                                                  "xbgasNicIface", 
                                                                  0,
                                                                  ComponentInfo::SHARE_NONE, //ComponentInfo::SHARE_PORTS | ComponentInfo::INSERT_STATS,
                                                                  xbgasNicParams,
                                                                  tc,
                                                                  new Event::Handler<RevBasicRmtMemCtrl>(
                                                                    this, &RevBasicRmtMemCtrl::rmtMemEventHandler
                                                                  ));

  if( !xbgasNicIface ){
    output->fatal(CALL_INFO, -1, "Error: unable to load xbgasNicAPI\n");
  }

  virtualHart = params.find<uint16_t>("numHarts", "1");
  max_loads = params.find<uint32_t>("max_loads", 64);
  max_stores = params.find<uint32_t>("max_stores", 64);
  max_ops = params.find<uint32_t>("ops_per_cycle", 2);

  rqstQ.reserve(max_ops);

  registerStats();

  registerClock( tc,
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
    case RmtMemOp::BulkREADRqst:
      handleRmtReadRqst( event );
      break;
    case RmtMemOp::WRITERqst:
    case RmtMemOp::BulkWRITERqst:
      handleRmtWriteRqst( event );
      break;
    case RmtMemOp::READResp:
    case RmtMemOp::BulkREADResp:
      handleRmtReadResp( event );
      break;
    case RmtMemOp::WRITEResp:
    case RmtMemOp::BulkWRITEResp:
      handleRmtWriteResp( event );
      break;
    // case RmtMemOp::Finish:
    //   handleFinish( event );
    //   break;
    default:
      output->fatal(CALL_INFO, -1, "Error : unknown remote memory operation type\n");
      break;
  }
}

void RevBasicRmtMemCtrl::handleRmtReadRqst( xbgasNicEvent *ev ){
  uint32_t Id       = ev->getID();
  uint32_t SrcId    = ev->getSrcId();
  uint64_t SrcAddr  = ev->getSrcAddr(); 
  uint64_t DestAddr = ev->getDestAddr();
  size_t   Size     = ev->getSize();
  uint32_t Nelem    = ev->getNelem();
  uint32_t Stride   = ev->getStride();
  StandardMem::Request::flags_t Flags = ev->getFlags();

  uint8_t *buffer = new uint8_t[Nelem*Stride];

  // Records the read request info in the load queue 
  LocalLoadRecord.insert({make_rmt_lsq_hash(ev->getSrcId(), ev->getID()), 
                         {SrcId, Id, DestAddr, Size, Nelem, Stride, buffer}});
  LocalLoadCount.insert({make_rmt_lsq_hash(ev->getSrcId(), ev->getID()), 0x00ul});

  for( uint32_t i=0; i < Nelem; i++ ){
    MemReq req{};
    req.Set(SrcAddr + i * Stride,                      // Memory address
            0,                                         // Destination register (ignored)
            RevRegClass::RegUNKNOWN,                   // Register class (ignored)
            virtualHart,                               // Virtual Hart ID
            MemOp::MemOpREAD,                          // Memory operation
            true,                                      // Outstanding
            MarkLocalLoadComplete());                  // Callback function
    LocalLoadTrack.insert({SrcAddr + i * Stride,
                           make_rmt_lsq_hash(ev->getSrcId(), ev->getID())});
    Mem->ReadMem(virtualHart, 
                 SrcAddr + i * Stride, 
                 Size, 
                 (void *)(&buffer[i * Size]), 
                 req, 
                 Flags);
  }
}

void RevBasicRmtMemCtrl::handleRmtWriteRqst( xbgasNicEvent *ev ){
  size_t   Size     = ev->getSize();
  uint32_t Nelem    = ev->getNelem();
  uint32_t Stride   = ev->getStride();
  uint64_t DestAddr = ev->getDestAddr();
  StandardMem::Request::flags_t Flags = ev->getFlags();

  uint8_t *buffer = new uint8_t[Nelem*Stride];
  ev->getData( buffer );
  
  for( uint32_t i=0; i < Nelem; i++ ){
    Mem->WriteMem(virtualHart, 
                  DestAddr + i * Stride, 
                  Size, 
                  (void *)(&buffer[i * Size]), 
                  Flags);
  }
  delete[] buffer;
}

void RevBasicRmtMemCtrl::handleRmtReadResp( xbgasNicEvent *ev ){
}

void RevBasicRmtMemCtrl::handleRmtWriteResp( xbgasNicEvent *ev ){
}

void RevBasicRmtMemCtrl::MarkLocalLoadComplete( const MemReq& req ){
  // Count the number of elements already fulfilled
  auto it = LocalLoadTrack.find(req.Addr);
  uint64_t id = it->second;
  if( LocalLoadCount.find(id) != LocalLoadCount.end() ){
    LocalLoadCount[id]++;
    // Remove the entry from the load table
    LocalLoadTrack.erase(it);
  } else {
    output->fatal(CALL_INFO, -1, "Error: unable to find the load queue entry\n");
  }

  auto Entry = LocalLoadRecord.find(id)->second;

  // Check if all the elements have been fulfilled
  if( LocalLoadCount[id] == std::get<LOAD_RECORD_NELEM>(Entry) ){
    // All the elements have been fulfilled; send the response
    xbgasNicEvent *RmtEvent = new xbgasNicEvent();
    uint8_t *buffer = std::get<LOAD_RECORD_BUFFER>(Entry);
    RmtEvent->buildREADResp(std::get<LOAD_RECORD_ID>(Entry), 
                            std::get<LOAD_RECORD_DESTADDR>(Entry),
                            std::get<LOAD_RECORD_SIZE>(Entry), 
                            std::get<LOAD_RECORD_NELEM>(Entry),
                            std::get<LOAD_RECORD_STRIDE>(Entry),
                            buffer);

    // Destination is the source of the request
    xbgasNicIface->send(RmtEvent, std::get<LOAD_RECORD_SRCID>(Entry));

    // Remove buffer and the entry from the load queue
    delete[] buffer;
    LocalLoadCount.erase(id);
    LocalLoadRecord.erase(id);
  }
}

void RevBasicRmtMemCtrl::init(unsigned int phase){
  int id = (int)(xbgasNicIface->getAddress());  
  // int numPEs = (int)(xbgasNicIface->getNumPEs());

  // Namespece Lookaside Buffer Initialization. Now using a naive implementation
  uint64_t nmspace = 0;
  xbgasHosts = xbgasNicIface->getXbgasHosts();

  if (xbgasHosts.size() != 0) {
    // The first entry is reserved for the local PE
    nmspaceLB[nmspace] = id;
    for ( unsigned i = 1; i < xbgasHosts.size(); i++ ) {
      nmspace = (uint64_t)(xbgasHosts[i] + 1);
      nmspaceLB[nmspace] = xbgasHosts[i];
    }
  }
}

void RevBasicRmtMemCtrl::setup(){
}

void RevBasicRmtMemCtrl::finish(){
}

bool RevBasicRmtMemCtrl::sendRmtReadRqst( unsigned Hart, uint64_t Nmspace, 
                                          uint64_t SrcAddr, size_t Size, 
                                          void *Target,
                                          const RmtMemReq& req, 
                                          StandardMem::Request::flags_t flags) {
  if( Size == 0 )
    return true;
  RevRmtMemOp *Op = new RevRmtMemOp( Hart, Nmspace, SrcAddr, Size, 
                                     Target, RmtMemOp::READRqst, flags );
  StandardMem::Request::flags_t TmpFlags = Op->getNonCacheFlags();
  Op->setRmtMemReq( req );
  Op->setFlags( TmpFlags );
  rqstQ.push_back( Op );
  recordStat(RevBasicRmtMemCtrl::RmtMemCtrlStats::RmtReadPending, 1);
  return true;
}

bool RevBasicRmtMemCtrl::sendRmtWriteRqst( unsigned Hart, uint64_t Nmspace, 
                         uint64_t DestAddr, size_t Size, char *buffer, 
                         StandardMem::Request::flags_t flags) {
  if( Size == 0 )
    return true;
  RevRmtMemOp *Op = new RevRmtMemOp( Hart, Nmspace, DestAddr, Size, buffer,
                                     RmtMemOp::WRITERqst, flags );
  StandardMem::Request::flags_t TmpFlags = Op->getNonCacheFlags();
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
  uint64_t SrcAddr, DestAddr;
  uint32_t Src = (uint32_t)( xbgasNicIface->getAddress() );
  uint32_t Dest = findDest( Op->getNmspace() );
  size_t Size = Op->getSize();
  StandardMem::Request::flags_t Flags = Op->getFlags();

  // Build the remote memory request packet
  xbgasNicEvent *RmtEvent = new xbgasNicEvent();

  switch(Op->getOp()){
  case RmtMemOp::READRqst:
    SrcAddr = Op->getSrcAddr();
    RmtEvent->buildREADRqst(SrcAddr, Size, Flags);
    requests.push_back(RmtEvent->getID());
    outstanding[RmtEvent->getID()] = Op;
    recordStat(RmtReadInFlight, 1);
    num_read++;
    break;
  case RmtMemOp::WRITERqst:
    DestAddr = Op->getDestAddr();
    RmtEvent->buildWRITERqst(DestAddr, Size, Op->getBuf(), Flags);
    requests.push_back(RmtEvent->getID());
    outstanding[RmtEvent->getID()] = Op;
    recordStat(RmtWriteInFlight, 1);
    num_write++;
    break;
  default:
    return false;
    break;
  }

  RmtEvent->setSrcId( Src );
  xbgasNicIface->send(RmtEvent, Dest);
  return true;
}

uint32_t RevBasicRmtMemCtrl::findDest( uint64_t Nmspace ){
  auto it = nmspaceLB.find(Nmspace);
  if( it == nmspaceLB.end() )
    return -1;
  else
    return it->second;
}
