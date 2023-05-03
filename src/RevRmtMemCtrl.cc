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

using namespace SST;
using namespace RevCPU;

std::atomic<uint64_t> SST::RevCPU::RevBasicRmtMemCtrl::main_id(0);

// ----------------------------------------
// RevRmtMemCtrl
// ----------------------------------------
RevRmtMemCtrl::RevRmtMemCtrl(ComponentId_t id, Params& params)
  : SubComponent(id), output(nullptr) {

  uint32_t verbosity = (uint32_t)params.find<uint32_t>("verbose", 0);
  output = new SST::Output("RevRmtMemCtrl[@f:@l:@p] ", verbosity, 0, SST::Output::STDOUT);

}

RevRmtMemCtrl::~RevRmtMemCtrl(){
  delete output;
}

// ----------------------------------------
// RevBasicRmtMemCtrl
// ----------------------------------------
RevBasicRmtMemCtrl::RevBasicRmtMemCtrl(ComponentId_t id, Params& params)
  : RevRmtMemCtrl(id, params), mem(nullptr), xbgas_nic(nullptr),
    max_loads(64), max_stores(64), max_responses(2), max_ops(2),
    num_read(0), num_write(0){
  
  std::string ClockFreq = params.find<std::string>("clock", "1GHz");

  max_loads = params.find<unsigned>("max_loads", 64);
  max_stores = params.find<unsigned>("max_stores", 64);
  max_responses = params.find<unsigned>("max_responses", 2);
  max_ops = params.find<unsigned>("ops_per_cycle", 2);

  rqstQ.reserve(max_ops);

  xbgas_nic = loadUserSubComponent<xbgasNicAPI>("xbgas_nic");
  xbgas_nic->setMsgHandler( new Event::Handler<RevBasicRmtMemCtrl>(this, &RevBasicRmtMemCtrl::rmtMemEventHandler) );

  registerStats();

  registerClock(ClockFreq, 
                new Clock::Handler<RevBasicRmtMemCtrl>(this, &RevBasicRmtMemCtrl::clockTick) );
}

RevBasicRmtMemCtrl::~RevBasicRmtMemCtrl(){
  delete mem;
  delete xbgas_nic;

  for( unsigned i=0; i<rqstQ.size(); i++ ){
    delete rqstQ[i].first;
  }
  rqstQ.clear();

  for( unsigned i=0; i<respQ.size(); i++ ){
    delete respQ[i].first;
  }
  respQ.clear();

  for (auto& kv : outstanding) {
    if (kv.second != nullptr)
      delete kv.second;
  }
  outstanding.clear();

}

void RevBasicRmtMemCtrl::registerStats(){
  stats.push_back(registerStatistic<uint64_t>("RmtReadInFlight"));
  stats.push_back(registerStatistic<uint64_t>("RmtReadPending"));
  stats.push_back(registerStatistic<uint64_t>("RmtReads"));
  stats.push_back(registerStatistic<uint64_t>("RmtWriteInFlight"));
  stats.push_back(registerStatistic<uint64_t>("RmtWritePending"));
  stats.push_back(registerStatistic<uint64_t>("RmtWrites"));
}

void RevBasicRmtMemCtrl::recordStat(RmtMemCtrlStat Stat, uint64_t Data){
  if( Stat > RevBasicRmtMemCtrl::RmtMemCtrlStat::RmtWrites ) {
    // do nothing
    return;
  }
  stats[Stat]->addData(Data);
}

void RevBasicRmtMemCtrl::init(unsigned int phase){
  int id = -1;
  int numPEs = 0;
  xbgas_nic->init(phase);
  id = (int)(xbgas_nic->getAddress());
  numPEs = (int)(xbgas_nic->getNumPEs());
  // Todo: write id and numPEs to the reserved memory
  
  // Namespece Lookaside Buffer Initialization. Now using a naive implementation
  std::vector<SST::Interfaces::SimpleNetwork::nid_t> xbgasHosts;
  xbgasHosts = xbgas_nic->getXbgasHosts();
  // The first entry is reserved for the local PE
  nmspaceLB.push_back(std::make_pair(0x0, id));
  for ( unsigned i = 0; i < xbgasHosts.size(); i++ ) {
    nmspaceLB.push_back( std::make_pair(i+1, i) );
  }
}

void RevBasicRmtMemCtrl::setup(){
  xbgas_nic->setup();
}

bool RevBasicRmtMemCtrl::isFinished(){
  bool rtn = false;
  if( rqstQ.empty() && respQ.empty() ){
    rtn = true;
  }
  return rtn;
}

int RevBasicRmtMemCtrl::findDest( uint64_t Nmspace ){
  int rtn = -1;
  for( unsigned i=0; i<nmspaceLB.size(); i++ ){
    if( nmspaceLB[i].first == Nmspace ){
      rtn = nmspaceLB[i].second;
      break;
    }
  }
  return rtn;
}

bool RevBasicRmtMemCtrl::isRmtMemOpAvail(xbgasNicEvent *ev, unsigned &t_max_loads, unsigned &t_max_stores){
  switch( ev->getOpcode() ){
  case xbgasNicEvent::GetRqst:
  case xbgasNicEvent::DmaGetRqst:
    if( t_max_loads < max_loads ){
      t_max_loads++;
      return true;
    }
    return false;
    break;
  case xbgasNicEvent::PutRqst:
  case xbgasNicEvent::DmaPutRqst:
    if( t_max_stores < max_stores ){
      t_max_stores++;
      return true;
    }
    return false;
    break;
  default:
    output->fatal(CALL_INFO, -1, "Error : unknown remote memory operation type\n");
    return false;
    break;
  }
  return false;
}

bool RevBasicRmtMemCtrl::sendRmtReadRqst( uint64_t Nmspace, uint64_t SrcAddr, 
                                          uint32_t Size, void *Target){
  int Src = (int)(xbgas_nic->getAddress());
  int Dest = findDest(Nmspace);
  uint64_t rqstId = main_id++;
  if( Size == 0 || Dest == -1 ){
    return false;
  }
  
  // Build the remote read request
  xbgasNicEvent *RmtEvent= new xbgasNicEvent();
  RmtEvent->setSrc( Src );
  RmtEvent->setTarget( Target );
  RmtEvent->buildGetRqst( rqstId, SrcAddr, Size );

  // Add the request to the request queue
  rqstQ.push_back( std::make_pair(RmtEvent, Dest) );
  recordStat(RmtMemCtrlStat::RmtReadPending, 1);
  return true;
}

bool RevBasicRmtMemCtrl::sendRmtDmaReadRqst( uint64_t Nmspace, uint64_t SrcAddr, 
                                             uint32_t Size, uint32_t Nelem, 
                                             uint32_t Stride, uint64_t DmaDestAddr ){
  int Src = (int)(xbgas_nic->getAddress());
  int Dest = findDest(Nmspace);
  uint64_t rqstId = main_id++;
  uint32_t TotalSize = Size * Nelem;
  if( TotalSize == 0 || Dest == -1 ){
    return false;
  }
  
  // Build the DMA remote read request
  xbgasNicEvent *RmtEvent= new xbgasNicEvent();
  RmtEvent->setSrc( Src );
  RmtEvent->buildDmaGetRqst( rqstId, SrcAddr, Size, Nelem, Stride, DmaDestAddr );

  // Add the request to the request queue
  rqstQ.push_back( std::make_pair(RmtEvent, Dest) );
  recordStat(RmtMemCtrlStat::RmtReadPending, 1);
  return true;
}

bool RevBasicRmtMemCtrl::sendRmtWriteRqst( uint64_t Nmspace, uint64_t DestAddr, 
                                           uint32_t Size, uint8_t *Buffer){
  int Src = (int)(xbgas_nic->getAddress());
  int Dest = findDest(Nmspace);
  uint64_t rqstId = main_id++;
  if( Size == 0 || Dest == -1 ){
    return false;
  }

  // Build the remote write request
  xbgasNicEvent *RmtEvent= new xbgasNicEvent();
  RmtEvent->setSrc( Src );
  RmtEvent->buildPutRqst( rqstId, DestAddr, Size, Buffer );

  // Add the request to the request queue
  rqstQ.push_back( std::make_pair(RmtEvent, Dest) );
  recordStat(RmtMemCtrlStat::RmtWritePending, 1);
  return true;
}

bool RevBasicRmtMemCtrl::sendRmtDmaWriteRqst( uint64_t Nmspace, uint64_t DestAddr, 
                                              uint32_t Size, uint32_t Nelem, 
                                              uint32_t Stride, uint64_t DmaSrcAddr ){
  int Src = (int)(xbgas_nic->getAddress());
  int Dest = findDest(Nmspace);
  uint64_t rqstId = main_id++;
  uint32_t TotalSize = Size * Nelem;
  if( TotalSize == 0 || Dest == -1 ){
    return false;
  }

  // Read the data to buffer from the source address
  uint8_t *Buffer = new uint8_t[TotalSize];
  uint64_t TmpAddr = 0;
  uint64_t TmpVal = 0;
  uint8_t *Data = (uint8_t *)((void *)(&TmpVal));
  for(uint32_t i=0; i<Nelem; i++){
    TmpAddr = DmaSrcAddr + i*Stride;
    mem->ReadMem(TmpAddr, Size, (void *)(&TmpVal), REVMEM_FLAGS(RevCPU::RevFlag::F_NONCACHEABLE));
    for(uint32_t j=0; j<Size; j++){
      Buffer[i*Size+j] = Data[j];
    }
    TmpVal = 0;
  }

  // Build the DMA remote write request
  xbgasNicEvent *RmtEvent= new xbgasNicEvent();
  RmtEvent->setSrc( Src );
  RmtEvent->buildDmaPutRqst( rqstId, DestAddr, Size, Buffer, Nelem, Stride, DmaSrcAddr);

  // Add the request to the request queue
  rqstQ.push_back( std::make_pair(RmtEvent, Dest) );
  recordStat(RmtMemCtrlStat::RmtWritePending, 1);
  delete[] Buffer;
  return true;
}

bool RevBasicRmtMemCtrl::sendRmtMemRqsts(unsigned &t_max_loads,
                                         unsigned &t_max_stores,
                                         unsigned &t_max_ops) {
  if (rqstQ.size() == 0) {
    // nothing to do, saturate and exit this cycle
    t_max_ops = max_ops;
    return true;
  }

  // retrieve the next candidate memory operation
  for( unsigned i=0; i<rqstQ.size(); i++ ){
    xbgasNicEvent *ev = rqstQ[i].first;
    if( isRmtMemOpAvail(ev, t_max_loads, t_max_stores) ){
      // op is good to execute, record in the requests vector
      switch( ev->getOpcode() ){
      case xbgasNicEvent::GetRqst:
      case xbgasNicEvent::DmaGetRqst:
        recordStat(RmtMemCtrlStat::RmtReadInFlight, 1);
        num_read++;
        break;
      case xbgasNicEvent::PutRqst:
      case xbgasNicEvent::DmaPutRqst:
        recordStat(RmtMemCtrlStat::RmtWriteInFlight, 1);
        num_write++;
        break;
      default:
        break;
      }
      t_max_ops++;
      requests.push_back(ev->getPktId());
      outstanding[ev->getPktId()] = ev;
      xbgas_nic->send( rqstQ[i].first, rqstQ[i].second );

      // remove the request from the vector
      std::swap(rqstQ[i], rqstQ.back());
      rqstQ.pop_back();
      return true;
    }
  }
  // Attemped to send all the potential remote memory requests, but none can
  // be sent. Saturate and exit this cycle.
  t_max_ops = max_ops;
  return true;
}

bool RevBasicRmtMemCtrl::sendRmtMemResps(unsigned &t_max_responses) {
  if( respQ.size() == 0 ){
    // nothing to do, saturate and exit this cycle
    t_max_responses = max_responses;
    return true;
  }

  // retrieve the next candidate memory response
  for( unsigned i=0; i<respQ.size(); i++ ){
    if( t_max_responses < max_responses ){
      t_max_responses++;
      // send the response
      xbgas_nic->send( respQ[i].first, respQ[i].second );
      std::swap(respQ[i], respQ.back());
      respQ.pop_back();
      return true;
    }
  }
  // Attemped to send all the potential remote memory responses, but none can
  // be sent. Saturate and exit this cycle.
  t_max_responses = max_responses;
  return true;
}

bool RevBasicRmtMemCtrl::handleRmtReadRqst( xbgasNicEvent *ev ){
  int Src = (int)(xbgas_nic->getAddress());
  int Dest = ev->getSrc();
  uint64_t PktId = ev->getPktId();
  uint32_t Size = ev->getSize();
  uint32_t Nelem = ev->getNelem();
  uint32_t Stride = ev->getStride();
  uint64_t SrcAddr = ev->getSrcAddr();
  uint64_t DestAddr = ev->getDestAddr();
  xbgasNicEvent::XbgasOpcode Opcode = ev->getOpcode();

  // Read the data to buffer from the source address
  uint32_t TotalSize = Size * Nelem;
  uint8_t *Buffer = new uint8_t[TotalSize];
  uint64_t TmpAddr = 0;
  uint64_t TmpVal = 0;
  uint8_t *Data = (uint8_t *)((void *)(&TmpVal));
  for(uint32_t i=0; i<Nelem; i++){
    TmpAddr = SrcAddr + i*Stride;
    mem->ReadMem(TmpAddr, Size, (void *)(&TmpVal), REVMEM_FLAGS(RevCPU::RevFlag::F_NONCACHEABLE));
    for(uint32_t j=0; j<Size; j++){
      Buffer[i*Size+j] = Data[j];
    }
    TmpVal = 0;
  }

  // Build the read response
  xbgasNicEvent *RmtEvent= new xbgasNicEvent();
  RmtEvent->setSrc( Src );
  if (Opcode == xbgasNicEvent::GetRqst) {
    RmtEvent->buildGetResp( PktId, Size, Buffer );
  } else if (Opcode == xbgasNicEvent::DmaGetRqst) {
    RmtEvent->buildDmaGetResp( PktId, Size, Nelem, Stride, DestAddr, Buffer );
  } else {
    delete[] Buffer;
    return false;
  }

  // Add thre response to the response queue
  respQ.push_back( std::make_pair(RmtEvent, Dest) );
  delete[] Buffer;
  return true;
}

bool RevBasicRmtMemCtrl::handleRmtWriteRqst( xbgasNicEvent *ev ){
  int Src = (int)(xbgas_nic->getAddress());
  int Dest = ev->getSrc();
  uint64_t PktId = ev->getPktId();
  uint32_t Size = ev->getSize();
  uint32_t Nelem = ev->getNelem();
  uint32_t Stride = ev->getStride();
  uint64_t DestAddr = ev->getDestAddr();
  xbgasNicEvent::XbgasOpcode Opcode = ev->getOpcode();

  // Read the data to buffer from the packet
  uint32_t TotalSize = Size * Nelem;
  uint8_t *Buffer = new uint8_t[TotalSize];
  ev->getData( Buffer );

  // Write the data to the destination address
  uint64_t TmpAddr = 0;
  for(uint32_t i=0; i<Nelem; i++){
    TmpAddr = DestAddr + i*Stride;
    mem->WriteMem(TmpAddr, Size, (void *)(&Buffer[i*Size]), REVMEM_FLAGS(RevCPU::RevFlag::F_NONCACHEABLE));
  }

  // Build the write response
  xbgasNicEvent *RmtEvent= new xbgasNicEvent();
  RmtEvent->setSrc( Src );
  if (Opcode == xbgasNicEvent::PutResp) {
    RmtEvent->buildPutResp( PktId );
  } else if (Opcode == xbgasNicEvent::DmaPutResp) {
    RmtEvent->buildDmaPutResp( PktId );
  } else {
    delete[] Buffer;
    return false;
  }

  // Add thre response to the response queue
  respQ.push_back( std::make_pair(RmtEvent, Dest) );
  delete[] Buffer;
  return true;
}

void RevBasicRmtMemCtrl::handleRmtReadResp( xbgasNicEvent *ev ) {
  if( std::find(requests.begin(), requests.end(), ev->getPktId()) != requests.end() ){
    // the response is for a pending request, remove the request from the pending requests list
    requests.erase( std::find(requests.begin(), requests.end(), ev->getPktId()) );
    xbgasNicEvent *op = outstanding[ev->getPktId()];
    uint32_t Size = ev->getSize();
    uint32_t Nelem = ev->getNelem();
    uint32_t Stride = ev->getStride();
    uint64_t DestAddr = ev->getDestAddr();

    // Read the data to buffer from the packet
    uint32_t TotalSize = Size * Nelem;
    uint8_t *Buffer = new uint8_t[TotalSize];
    ev->getData( Buffer );

    switch(ev->getOpcode()){
      case xbgasNicEvent::GetResp: {
        // update the target register
        uint8_t *Target = (uint8_t *)(op->getTarget());
        for(uint32_t i=0; i<Size; i++){
          Target[i] = Buffer[i];
          Target++;
        }
        break;
      }
      case xbgasNicEvent::DmaGetResp: {
        // Write the data to the destination address
        uint64_t TmpAddr = 0;
        for(uint32_t i=0; i<Nelem; i++){
          TmpAddr = DestAddr + i*Stride;
          mem->WriteMem(TmpAddr, Size, (void *)(&Buffer[i*Size]), REVMEM_FLAGS(RevCPU::RevFlag::F_NONCACHEABLE));
        }
        break;
      }
      default: {
        output->fatal(CALL_INFO, -1, "Error : unknown remote memory operation type\n");
        break;
      }
    }
    outstanding.erase(ev->getPktId());
    delete[] Buffer;
    delete ev;
    num_read--;
    return;
  }
  return;
}

void RevBasicRmtMemCtrl::handleRmtWriteResp( xbgasNicEvent *ev ) {
  if( std::find(requests.begin(), requests.end(), ev->getPktId()) != requests.end() ){
    // the response is for a pending request, remove the request from the pending requests list
    requests.erase( std::find(requests.begin(), requests.end(), ev->getPktId()) );
    delete ev;
    outstanding.erase(ev->getPktId());
    num_write--;
    return;
  } 
}

void RevBasicRmtMemCtrl::rmtMemEventHandler( Event *ev ) {
  xbgasNicEvent *event = static_cast<xbgasNicEvent*>(ev);
  switch(event->getOpcode()){
    case xbgasNicEvent::GetRqst:
    case xbgasNicEvent::DmaGetRqst:
      handleRmtReadRqst( event );
      break;
    case xbgasNicEvent::PutRqst:
    case xbgasNicEvent::DmaPutRqst:
      handleRmtWriteRqst( event );
      break;
    case xbgasNicEvent::GetResp:
    case xbgasNicEvent::DmaGetResp:
      handleRmtReadResp( event );
      break;
    case xbgasNicEvent::PutResp:
    case xbgasNicEvent::DmaPutResp:
      handleRmtWriteResp( event );
      break;
    default:
      output->fatal(CALL_INFO, -1, "Error : unknown remote memory operation type\n");
      break;
  }
}

bool RevBasicRmtMemCtrl::clockTick(Cycle_t){
  // process the remote memory requests queue
  bool rqst_done = false;
  bool resp_done = false;
  unsigned t_max_loads = 0;
  unsigned t_max_stores = 0;
  unsigned t_max_responses = 0;
  unsigned t_max_ops = 0;

  while( !rqst_done ){
    if( !sendRmtMemRqsts(t_max_loads, t_max_stores, t_max_ops) ){
      // error occurred
      output->fatal(CALL_INFO, -1, "Error: failed to send remote memory requests\n");
    }
    if( t_max_ops == max_ops ){
      rqst_done = true;
    }
  }

  while( !resp_done ){
    if( !sendRmtMemResps(t_max_responses) ){
      // error occurred
      output->fatal(CALL_INFO, -1, "Error: failed to send remote memory responses\n");
    }
    if( t_max_responses == max_responses ){
      resp_done = true;
    }
  }

  return true;
}