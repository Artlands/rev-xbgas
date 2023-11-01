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

XbgasNIC::XbgasNIC(ComponentId_t id, Params& params, TimeConverter* tc, Event::HandlerBase *handler)
  : xbgasNicAPI(id, params, tc, handler) {
  // setup the initial logging functions
  int verbosity = params.find<int>("verbose", 0);
  output = new SST::Output("", verbosity, 0, SST::Output::STDOUT);

  // load the SimpleNetwork interfaces
  link_control = loadUserSubComponent<SimpleNetwork>("linkcontrol", ComponentInfo::SHARE_NONE, 1);
  if( !link_control ){
    // load the anonymous nic
    Params netparams;
    netparams.insert("port_name", params.find<std::string>("port", "port"));
    netparams.insert("input_buf_size", params.find<std::string>("network_input_buffer_size", "1KiB"));
    netparams.insert("output_buf_size", params.find<std::string>("network_output_buffer_size", "1KiB"));
    netparams.insert("link_bw", params.find<std::string>("network_bw", "80GiB/s"));
    link_control = loadAnonymousSubComponent<SST::Interfaces::SimpleNetwork>("merlin.linkcontrol",
                                                                             "linkcontrol",
                                                                             0,
                                                                             ComponentInfo::SHARE_PORTS | ComponentInfo::INSERT_STATS,
                                                                             netparams,
                                                                             1);
  }

  link_control->setNotifyOnReceive(new SST::Interfaces::SimpleNetwork::Handler<XbgasNIC>(this, &XbgasNIC::msgNotify));

  registerClock(tc, new Clock::Handler<XbgasNIC>(this, &XbgasNIC::clockTick));

  initBroadcastSent = false;

  numDest = 0;

  msgHandler = handler;
}

XbgasNIC::~XbgasNIC(){
  delete output;
}

void XbgasNIC::init(unsigned int phase){
  link_control->init(phase);

  if( link_control->isNetworkInitialized() ){
    if( !initBroadcastSent) {
      initBroadcastSent = true;
      xbgasNicEvent *ev = new xbgasNicEvent(getName());

      SST::Interfaces::SimpleNetwork::Request * req = new SST::Interfaces::SimpleNetwork::Request();
      req->dest = SST::Interfaces::SimpleNetwork::INIT_BROADCAST_ADDR;
      req->src = link_control->getEndpointID();
      req->givePayload(ev);
      link_control->sendInitData(req);
    }
  }

  while( SST::Interfaces::SimpleNetwork::Request * req = link_control->recvInitData() ) {
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

void XbgasNIC::finish(){
}

bool XbgasNIC::msgNotify(int vn){
  SST::Interfaces::SimpleNetwork::Request* req = link_control->recv(0);
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
  req->src = link_control->getEndpointID();
  req->givePayload(event);
  sendQ.push(req);
}

int XbgasNIC::getNumDestinations(){
  return numDest;
}

SST::Interfaces::SimpleNetwork::nid_t XbgasNIC::getAddress(){
  return link_control->getEndpointID();
}

bool XbgasNIC::clockTick(Cycle_t cycle){
  while( !sendQ.empty() ){
    if( link_control->spaceToSend(0, 512) && link_control->send(sendQ.front(), 0)) {
      sendQ.pop();
    }else{
      break;
    }
  }

  return false;
}


// EOF
