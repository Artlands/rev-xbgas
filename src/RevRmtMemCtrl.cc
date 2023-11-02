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

std::atomic<int64_t> SST::RevCPU::RevBasicRmtMemCtrl::main_id(0);

// ----------------------------------------
// RevRmtMemOp
// ----------------------------------------
RevRmtMemOp::RevRmtMemOp( unsigned Hart, uint64_t Nmspace, uint64_t SrcAddr, size_t Size, 
                          MemOp Op, StandardMem::Request::flags_t flags )
  : Hart(Hart), Nmspace(Nmspace), SrcAddr(SrcAddr), DstAddr(0), Size(Size), 
    Nelem(1), Stride(0), Op(Op), Flags(flags),
    target(nullptr), procReq(){
}

RevRmtMemOp::RevRmtMemOp( unsigned Hart, uint64_t Nmspace, uint64_t SrcAddr, size_t Size, 
                          void *target, MemOp Op, StandardMem::Request::flags_t Flags )
  : Hart(Hart), Nmspace(Nmspace), SrcAddr(SrcAddr), DstAddr(0), Size(Size), 
    Nelem(1), Stride(0), Op(Op), Flags(Flags),
    target(target), procReq(){
}

RevRmtMemOp::RevRmtMemOp( unsigned Hart, uint64_t Nmspace, uint64_t SrcAddr, size_t Size,
                          uint32_t Nelem, uint32_t Stride, uint64_t DstAddr, 
                          MemOp Op, StandardMem::Request::flags_t Flags )
  : Hart(Hart), Nmspace(Nmspace), SrcAddr(SrcAddr), DstAddr(DstAddr), Size(Size), 
    Nelem(Nelem), Stride(Stride), Op(Op), Flags(Flags),
    target(nullptr), procReq(){
}

RevRmtMemOp::RevRmtMemOp( unsigned Hart, uint64_t Nmspace, uint64_t DstAddr, size_t Size, 
                          char *buffer, MemOp Op, StandardMem::Request::flags_t Flags )
  : Hart(Hart), Nmspace(Nmspace), SrcAddr(0), DstAddr(DstAddr), Size(Size), 
    Nelem(1), Stride(0), Op(Op), Flags(Flags),
    target(nullptr), procReq() {
  for(uint32_t i = 0; i < Size; ++i){
    membuf.push_back(buffer[i]);
  }
}

RevRmtMemOp::RevRmtMemOp( unsigned Hart, uint64_t Nmspace, uint64_t DstAddr, size_t Size,
                          uint32_t Nelem, uint32_t Stride, uint64_t SrcAddr, 
                          char *buffer, MemOp Op, StandardMem::Request::flags_t Flags )
  : Hart(Hart), Nmspace(Nmspace), SrcAddr(SrcAddr), DstAddr(DstAddr), Size(Size), 
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
  : RevRmtMemCtrl(id, params, tc), xbgasNicIface(nullptr),
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
}

void RevBasicRmtMemCtrl::init(unsigned int phase){
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
                                     Target, MemOp::MemOpREAD, flags );
  Op->setRmtMemOp( req );
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
                                     MemOp::MemOpWRITE, flags );
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
  case MemOp::MemOpREAD:
    if( t_max_loads < max_loads ){
      t_max_loads++;
      return true;
    }
    break;
  case MemOp::MemOpWRITE:
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
 return true;
}

int RevBasicRmtMemCtrl::findDest( uint64_t Nmspace ){
  auto it = nmspaceLB.find(Nmspace);
  if( it == nmspaceLB.end() )
    return -1;
  else
    return it->second;
}
