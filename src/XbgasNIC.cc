//
// _XbgasNIC_cc_
//
// Copyright (C) 2017-2023 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#include "../include/XbgasNIC.h"

using namespace SST;
using namespace RevCPU;

std::string xbgasNicEvent::getOpcodeStr(){
  switch(Opcode){
    case xbgasNicEvent::GetRqst:
      return "GetRqst";
      break;
    case xbgasNicEvent::PutRqst:
      return "PutRqst";
      break;
    case xbgasNicEvent::BulkGetRqst:
      return "BulkGetRqst";
      break;
    case xbgasNicEvent::BulkPutRqst:
      return "BulkPutRqst";
      break;
    case xbgasNicEvent::GetResp:
      return "GetResp";
      break;
    case xbgasNicEvent::PutResp:
      return "PutResp";
      break;
    case xbgasNicEvent::BulkGetResp:
      return "BulkGetResp";
      break;
    case xbgasNicEvent::BulkPutResp:
      return "BulkPutResp";
      break;
    default:
      return "UNKNOWN";
      break;
  }
}

// unsigned xbgasNicEvent::getNumBlocks(uint32_t Sz){
//   unsigned blocks = 0;
//   if( Sz == 0 ){
//     blocks = 0;
//   }else if ( Sz < 8 ){
//     blocks = 1;
//   }else{
//     blocks = Sz/8;
//     if( (Sz%8) > 0 )
//       blocks += 1;
//   }
//   return blocks;
// }

// void xbgasNicEvent::getData(uint64_t *Out){
//   unsigned blocks = 0;
//   uint32_t TotalSize = Size * Nelem;
//   if( TotalSize == 0 )
//     return;
//   blocks = getNumBlocks(TotalSize);
//   for( unsigned i=0; i<blocks; i++){
//     Out[i] = Data[i];
//   }
// }

// bool xbgasNicEvent::setData(uint64_t *In, uint32_t Sz){
//   unsigned blocks = 0;
//   if( Sz == 0 )
//     return true;
//   blocks = getNumBlocks(Sz);
//   for( unsigned i=0; i<blocks; i++ ){
//     Data.push_back(In[i]);
//   }
//   return true;
// }

void xbgasNicEvent::getData(uint8_t *Out){
  if( Data.size() == 0 )
    return;
  for( unsigned i=0; i<Data.size(); i++){
    Out[i] = Data[i];
  }
}

bool xbgasNicEvent::setData(uint8_t *In, uint32_t Sz){
  if( Sz == 0 )
    return true;
  for( unsigned i=0; i<Sz; i++ ){
    Data.push_back(In[i]);
  }
  return true;
}

bool xbgasNicEvent::buildGetRqst( uint64_t PktId, uint64_t Addr, uint32_t Size){
  Opcode = xbgasNicEvent::GetRqst;
  if( !setPktId(PktId) )
    return false;
  if( !setAddr(Addr) )
    return false;
  if( !setSize(Size) )
    return false;
  return true;
}

bool xbgasNicEvent::buildBulkGetRqst( uint64_t PktId, uint64_t Addr,  uint32_t Size, 
                                      uint32_t Nelem, uint32_t Stride ){
  Opcode = xbgasNicEvent::BulkGetRqst;
  if( !setPktId(PktId) )
    return false;
  if( !setAddr(Addr) )
    return false;
  if( !setSize(Size) )
    return false;
  if( !setNelem(Nelem) )
    return false;
  if( !setStride(Stride) )
    return false;
  return true;
}

bool xbgasNicEvent::buildPutRqst(uint64_t PktId, uint64_t Addr, 
                                 uint32_t Size, uint8_t *Buffer){
  Opcode = xbgasNicEvent::PutRqst;
  if ( Buffer == nullptr )
    return false;
  if( !setPktId(PktId) )
    return false;
  if( !setAddr(Addr) )
    return false;
  if( !setSize(Size) )
    return false;
  if( !setData(Buffer, Size) )
    return false;
  return true;
}

bool xbgasNicEvent::buildBulkPutRqst(uint64_t PktId, uint64_t Addr, uint32_t Size, 
                                     uint32_t Nelem, uint32_t Stride, uint8_t *Buffer){
  uint32_t TotalSize = Size * Nelem;
  Opcode = xbgasNicEvent::BulkPutRqst;
  if ( Buffer == nullptr )
    return false;
  if( !setPktId(PktId) )
    return false;
  if( !setAddr(Addr) )
    return false;
  if( !setSize(Size) )
    return false;
  if( !setNelem(Nelem) )
    return false;
  if( !setStride(Stride) )
    return false;
  if( !setData(Buffer, TotalSize) )
    return false;
  return true;
}

bool xbgasNicEvent::buildGetResp(uint64_t PktId, uint32_t Size, uint8_t *Buffer){
  Opcode = xbgasNicEvent::GetResp;
  if ( Buffer == nullptr )
    return false;
  if( !setPktId(PktId) )
    return false;
  if( !setData(Buffer, Size) )
    return false;
  return true;
}

bool xbgasNicEvent::buildBulkGetResp(uint64_t PktId, uint32_t Size, 
                                     uint32_t Nelem, uint8_t *Buffer){
  uint32_t TotalSize = Size * Nelem;
  Opcode = xbgasNicEvent::BulkGetResp;
  if ( Buffer == nullptr )
    return false;
  if( !setPktId(PktId) )
    return false;
  if( !setData(Buffer, TotalSize) )
    return false;
  return true;
}

bool xbgasNicEvent::buildPutResp(uint64_t PktId){
  Opcode = xbgasNicEvent::PutResp;
  if( !setPktId(PktId) )
    return false;
  return true;
}

bool xbgasNicEvent::buildBulkPutResp(uint64_t PktId){
  Opcode = xbgasNicEvent::BulkPutResp;
  if( !setPktId(PktId) )
    return false;
  return true;
}

XbgasNIC::XbgasNIC(ComponentId_t id, Params& params)
  : xbgasNicAPI(id, params) {
  // setup the initial logging functions
  int verbosity = params.find<int>("verbose",0);
  output = new SST::Output("", verbosity, 0, SST::Output::STDOUT);

  registerClock("1Ghz", new Clock::Handler<XbgasNIC>(this,&XbgasNIC::clockTick));

  // load the SimpleNetwork interfaces
  iFace = loadUserSubComponent<SST::Interfaces::SimpleNetwork>("iface", ComponentInfo::SHARE_NONE, 1); 
  if( !iFace ){
    // load the anonymous nic
    Params netparams;
    netparams.insert("port_name", params.find<std::string>("port", "network"));
    netparams.insert("in_buf_size", "256B");
    netparams.insert("out_buf_size", "256B");
    netparams.insert("link_bw", "40GiB/s");
    iFace = loadAnonymousSubComponent<SST::Interfaces::SimpleNetwork>("merlin.linkcontrol",
                                                                      "iface",
                                                                      0,
                                                                      ComponentInfo::SHARE_PORTS | ComponentInfo::INSERT_STATS,
                                                                      netparams,
                                                                      1);
  }

  iFace->setNotifyOnReceive(new SST::Interfaces::SimpleNetwork::Handler<XbgasNIC>(this, &XbgasNIC::msgNotify));

  initBroadcastSent = false;

  numDest = 0;

  msgHandler = nullptr;
}

XbgasNIC::~XbgasNIC(){
}

void XbgasNIC::setMsgHandler(Event::HandlerBase* handler){
  msgHandler = handler;
}

void XbgasNIC::init(unsigned int phase){
  iFace->init(phase);

  if( iFace->isNetworkInitialized() ){
    if( !initBroadcastSent) {
      initBroadcastSent = true;
      xbgasNicEvent *ev = new xbgasNicEvent(getName());

      SST::Interfaces::SimpleNetwork::Request * req = new SST::Interfaces::SimpleNetwork::Request();
      req->dest = SST::Interfaces::SimpleNetwork::INIT_BROADCAST_ADDR;
      req->src = iFace->getEndpointID();
      req->givePayload(ev);
      iFace->sendInitData(req);
      // Local PE ID
      xbgasHosts.push_back(iFace->getEndpointID());
    }
  }

  while( SST::Interfaces::SimpleNetwork::Request * req = iFace->recvInitData() ) {
    xbgasNicEvent *ev = static_cast<xbgasNicEvent*>(req->takePayload());
    numDest++;
    SST::Interfaces::SimpleNetwork::nid_t srcID = req->src;
    // Remote PE IDs
    xbgasHosts.push_back(srcID);
    output->verbose(CALL_INFO, 6, 0,
                    "%s received init message from %s\n",
                    getName().c_str(), ev->getSource().c_str());
  }
}

void XbgasNIC::setup(){
  if( msgHandler == nullptr ){
    output->fatal(CALL_INFO, -1,
                  "%s, Error: XbgasNIC implements a callback-based notification and parent has not registerd a callback function\n",
                  getName().c_str());
  }
}

bool XbgasNIC::msgNotify(int vn){
  SST::Interfaces::SimpleNetwork::Request* req = iFace->recv(0);

  if( req != nullptr ){
    xbgasNicEvent *ev = static_cast<xbgasNicEvent*>(req->takePayload());

    if( !ev ){
      output->fatal(CALL_INFO, -1, "%s, Error: xbgasNicEvent on XbgasNIC is null\n",
                    getName().c_str());
    }

    // output->verbose(CALL_INFO, 4, 0,
    //                 "%s received message %s from %d\n",
    //                 getName().c_str(), ev->getOpcodeStr().c_str(), ev->getSrc());

    (*msgHandler)(ev);
    delete req;
  }

  return true;
}

void XbgasNIC::send(xbgasNicEvent* event, int destination){
  SST::Interfaces::SimpleNetwork::Request *req = new SST::Interfaces::SimpleNetwork::Request();
  // output->verbose(CALL_INFO, 4, 0,
  //                 "%s sending message %s to %d\n",
  //                 getName().c_str(), event->getOpcodeStr().c_str(), destination);
  req->dest = destination;
  req->src = iFace->getEndpointID();
  req->givePayload(event);
  sendQ.push(req);
}

int XbgasNIC::getNumDestinations(){
  return numDest;
}

SST::Interfaces::SimpleNetwork::nid_t XbgasNIC::getAddress(){
  return iFace->getEndpointID();
}

bool XbgasNIC::clockTick(Cycle_t cycle){
  while( !sendQ.empty() ){
    if( iFace->spaceToSend(0,512) && iFace->send(sendQ.front(),0)) {
      sendQ.pop();
    }else{
      break;
    }
  }

  return false;
}
// EOF
