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

std::atomic<uint32_t> SST::RevCPU::xbgasNicEvent::main_id(0);

bool xbgasNicEvent::setData(uint8_t *In, uint32_t TotalSz){
  if( TotalSz == 0 )
    return true;
  for( unsigned i=0; i<TotalSz; i++ ){
    Data.push_back(In[i]);
  }
  return true;
}

void xbgasNicEvent::getData(uint8_t *Buffer){
  if( Size == 0 )
    return;
  for( size_t i=0; i<Size; i++){
    Buffer[i] = Data[i];
  }
}

bool xbgasNicEvent::buildREADRqst( uint64_t SrcAddr, uint64_t DestAddr, 
                                   size_t Size, uint32_t Nelem, 
                                   uint32_t Stride,
                                   RevFlag Fl ){
  Id = main_id++;
  Opcode = RmtMemOp::READRqst;
  if( !setSrcAddr(SrcAddr) )
    return false;
  if( !setDestAddr(DestAddr) )
    return false;
  if( !setSize(Size) )
    return false;
  if( !setNelem(Nelem) )
    return false;
  if( !setStride(Stride) )
    return false;
  if( !setFlags(Fl) )
    return false;
  return true;
}

bool xbgasNicEvent::buildWRITERqst(uint64_t DestAddr, size_t Size, 
                                   uint32_t Nelem, uint32_t Stride, 
                                   RevFlag Fl,
                                   uint8_t *Buffer){
  uint32_t TotalSize = Size * Nelem;
  Id = main_id++;
  Opcode = RmtMemOp::WRITERqst;
  if( !setDestAddr(DestAddr) )
    return false;
  if( !setSize(Size) )
    return false;
  if( !setNelem(Nelem) )
    return false;
  if( !setStride(Stride) )
    return false;
  if( !setData(Buffer, TotalSize) )
    return false;
  if( !setFlags(Fl) )
    return false;
  return true;
}

bool xbgasNicEvent::buildREADResp(uint64_t Id, uint64_t DestAddr, size_t Size, 
                                  uint32_t Nelem, uint32_t Stride,
                                  uint8_t *Buffer){
  uint32_t TotalSize = Size * Nelem;
  Id = Id;
  Opcode = RmtMemOp::READResp;
  if( !setDestAddr(DestAddr) )
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

bool xbgasNicEvent::buildWRITEResp(uint64_t Id){
  Id = Id;
  Opcode = RmtMemOp::WRITEResp;
  return true;
}

XbgasNIC::XbgasNIC(ComponentId_t id, Params& params, Event::HandlerBase *handler)
  : xbgasNicAPI(id, params, handler) {
  // setup the initial logging functions
  int verbosity = params.find<int>("verbose", 0);
  std::string ClockFreq = params.find<std::string>("clock", "1Ghz");

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

  registerClock(ClockFreq, new Clock::Handler<XbgasNIC>(this, &XbgasNIC::clockTick));

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
      xbgasNicEvent *ev = new xbgasNicEvent();

      SST::Interfaces::SimpleNetwork::Request * req = new SST::Interfaces::SimpleNetwork::Request();
      req->dest = SST::Interfaces::SimpleNetwork::INIT_BROADCAST_ADDR;
      req->src = link_control->getEndpointID();
      req->givePayload(ev);
      link_control->sendInitData(req);
      // Push back local PE ID
      xbgasHosts.push_back(link_control->getEndpointID());
    }
  }

  while( SST::Interfaces::SimpleNetwork::Request * req = link_control->recvInitData() ) {
    xbgasNicEvent *ev = static_cast<xbgasNicEvent*>(req->takePayload());
    numDest++;
    output->verbose(CALL_INFO, 1, 0,
                    "%s received init message from %u\n",
                    getName().c_str(), ev->getSrcId());
    // Push back remote PE ID
    xbgasHosts.push_back(req->src);
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
