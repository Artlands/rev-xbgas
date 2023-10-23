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

bool xbgasNicEvent::buildGetRqst( uint64_t PktId, uint64_t Addr, size_t Size){
  Opcode = XbgasOpcode::GetRqst;
  if( !setPktId(PktId) )
    return false;
  if( !setAddr(Addr) )
    return false;
  if( !setSize(Size) )
    return false;
  if( !setNelem(1) )
    return false;
  if( !setStride(0) )
    return false;
  return true;
}

bool xbgasNicEvent::buildBulkGetRqst( uint64_t PktId, uint64_t Addr,  size_t Size, 
                                      uint32_t Nelem, uint32_t Stride ){
  Opcode = XbgasOpcode::BulkGetRqst;
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

bool xbgasNicEvent::buildPutRqst(uint64_t PktId, uint64_t Addr, size_t Size){
  Opcode = XbgasOpcode::PutRqst;
  if( !setPktId(PktId) )
    return false;
  if( !setAddr(Addr) )
    return false;
  if( !setSize(Size) )
    return false;
  if( !setNelem(1) )
    return false;
  if( !setStride(0) )
    return false;
  return true;
}

bool xbgasNicEvent::buildBulkPutRqst(uint64_t PktId, uint64_t Addr, size_t Size, 
                                     uint32_t Nelem, uint32_t Stride){
  Opcode = XbgasOpcode::BulkPutRqst;
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

bool xbgasNicEvent::buildGetResp(uint64_t PktId, size_t Size){
  Opcode = XbgasOpcode::GetResp;
  if( !setPktId(PktId) )
    return false;
  return true;
}

bool xbgasNicEvent::buildBulkGetResp(uint64_t PktId, size_t Size, uint32_t Nelem){
  Opcode = XbgasOpcode::BulkGetResp;
  if( !setPktId(PktId) )
    return false;
  return true;
}

bool xbgasNicEvent::buildPutResp(uint64_t PktId){
  Opcode = XbgasOpcode::PutResp;
  if( !setPktId(PktId) )
    return false;
  return true;
}

bool xbgasNicEvent::buildBulkPutResp(uint64_t PktId){
  Opcode = XbgasOpcode::BulkPutResp;
  if( !setPktId(PktId) )
    return false;
  return true;
}

XbgasNIC::XbgasNIC(ComponentId_t id, Params& params)
  : xbgasNicAPI(id, params) {
  // setup the initial logging functions
  int verbosity = params.find<int>("verbose", 0);
  output = new SST::Output("", verbosity, 0, SST::Output::STDOUT);

  const std::string nicClock = params.find<std::string>("clock", "1GHz");
  registerClock(nicClock, new Clock::Handler<XbgasNIC>(this, &XbgasNIC::clockTick));

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
  delete output;
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
    }
  }

  while( SST::Interfaces::SimpleNetwork::Request * req = iFace->recvInitData() ) {
    xbgasNicEvent *ev = static_cast<xbgasNicEvent*>(req->takePayload());
    numDest++;
    output->verbose(CALL_INFO, 1, 0,
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
    if( req != nullptr ){
      xbgasNicEvent *ev = static_cast<xbgasNicEvent*>(req->takePayload());
      delete req;
      (*msgHandler)(ev);
    }
  }
  return true;
}

void XbgasNIC::send(xbgasNicEvent* event, int destination){
  SST::Interfaces::SimpleNetwork::Request *req = new SST::Interfaces::SimpleNetwork::Request();
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
    if( iFace->spaceToSend(0, 512) && iFace->send(sendQ.front(), 0)) {
      sendQ.pop();
    }else{
      break;
    }
  }

  return false;
}


// EOF
