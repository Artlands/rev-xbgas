//
// _XbgasNIC_cc_
//
// Copyright (C) 2017-2024 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#include "XbgasNIC.h"

using namespace SST;
using namespace RevCPU;

std::atomic<uint32_t> SST::RevCPU::xbgasNicEvent::main_id( 0 );

bool xbgasNicEvent::setData( uint8_t* In, uint32_t TotalSz ) {
  if( TotalSz == 0 )
    return true;
  for( unsigned i = 0; i < TotalSz; i++ ) {
    Data.push_back( In[i] );
  }
  return true;
}

void xbgasNicEvent::getData( uint8_t* Buffer ) {
  if( Size == 0 )
    return;
  for( size_t i = 0; i < Size; i++ ) {
    Buffer[i] = Data[i];
  }
}

bool xbgasNicEvent::buildREADRqst( uint64_t SrcAddr, uint64_t DestAddr, size_t Size, uint32_t Nelem, uint32_t Stride, RevFlag Fl ) {
  Opcode = RmtMemOp::READRqst;
  if( !setId( main_id++ ) )
    return false;
  if( !setSrcAddr( SrcAddr ) )
    return false;
  if( !setDestAddr( DestAddr ) )
    return false;
  if( !setSize( Size ) )
    return false;
  if( !setNelem( Nelem ) )
    return false;
  if( !setStride( Stride ) )
    return false;
  if( !setFlags( Fl ) )
    return false;
  return true;
}

bool xbgasNicEvent::buildWRITERqst( uint64_t DestAddr, size_t Size, uint32_t Nelem, uint32_t Stride, RevFlag Fl, uint8_t* Buffer ) {
  Opcode = RmtMemOp::WRITERqst;
  if( !setId( main_id++ ) )
    return false;
  if( !setDestAddr( DestAddr ) )
    return false;
  if( !setSize( Size ) )
    return false;
  if( !setNelem( Nelem ) )
    return false;
  if( !setStride( Stride ) )
    return false;
  if( !setData( Buffer, Size * Nelem ) )
    return false;
  if( !setFlags( Fl ) )
    return false;
  return true;
}

bool xbgasNicEvent::buildREADResp( uint64_t Id, uint64_t DestAddr, size_t Size, uint32_t Nelem, uint32_t Stride, uint8_t* Buffer ) {
  Opcode = RmtMemOp::READResp;
  if( !setId( Id ) )
    return false;
  if( !setDestAddr( DestAddr ) )
    return false;
  if( !setSize( Size ) )
    return false;
  if( !setNelem( Nelem ) )
    return false;
  if( !setStride( Stride ) )
    return false;
  if( !setData( Buffer, Size * Nelem ) )
    return false;
  return true;
}

bool xbgasNicEvent::buildWRITEResp( uint64_t Id ) {
  Opcode = RmtMemOp::WRITEResp;
  if( !setId( Id ) )
    return false;
  return true;
}

XbgasNIC::XbgasNIC( ComponentId_t id, Params& params ) : xbgasNicAPI( id, params ) {

  // setup the initial logging functions
  int         verbosity = params.find<int>( "verbose", 0 );
  std::string ClockFreq = params.find<std::string>( "clock", "1Ghz" );

  output                = new SST::Output( "", verbosity, 0, SST::Output::STDOUT );
  registerClock( ClockFreq, new Clock::Handler<XbgasNIC>( this, &XbgasNIC::clockTick ) );

  // load the SimpleNetwork interfaces
  iFace = loadUserSubComponent<SST::Interfaces::SimpleNetwork>( "iface", ComponentInfo::SHARE_NONE, 1 );
  if( !iFace ) {
    // load the anonymous nic
    Params netparams;
    netparams.insert( "port_name", params.find<std::string>( "port", "port" ) );
    netparams.insert( "input_buf_size", params.find<std::string>( "network_input_buffer_size", "1KiB" ) );
    netparams.insert( "output_buf_size", params.find<std::string>( "network_output_buffer_size", "1KiB" ) );
    netparams.insert( "link_bw", params.find<std::string>( "network_bw", "80GiB/s" ) );
    iFace = loadAnonymousSubComponent<SST::Interfaces::SimpleNetwork>(
      "merlin.linkcontrol", "iface", 0, ComponentInfo::SHARE_PORTS | ComponentInfo::INSERT_STATS, netparams, 1
    );
  }

  if( !iFace ) {
    output->fatal( CALL_INFO, -1, "%s, Error: unable to load a simple network interface\n", getName().c_str() );
  }

  iFace->setNotifyOnReceive( new SST::Interfaces::SimpleNetwork::Handler<XbgasNIC>( this, &XbgasNIC::msgNotify ) );

  initBroadcastSent = false;

  numDest           = 0;

  msgHandler        = nullptr;
}

XbgasNIC::~XbgasNIC() {
  delete output;
}

void XbgasNIC::init( unsigned int phase ) {
  iFace->init( phase );

  if( iFace->isNetworkInitialized() ) {
    if( !initBroadcastSent ) {
      initBroadcastSent                            = true;
      xbgasNicEvent* ev                            = new xbgasNicEvent();

      SST::Interfaces::SimpleNetwork::Request* req = new SST::Interfaces::SimpleNetwork::Request();
      req->dest                                    = SST::Interfaces::SimpleNetwork::INIT_BROADCAST_ADDR;
      req->src                                     = iFace->getEndpointID();
      req->givePayload( ev );
      iFace->sendInitData( req );
      // Push back local PE ID
      xbgasHosts.push_back( iFace->getEndpointID() );
    }
  }

  while( SST::Interfaces::SimpleNetwork::Request* req = iFace->recvInitData() ) {
    xbgasNicEvent* ev = static_cast<xbgasNicEvent*>( req->takePayload() );
    numDest++;
    output->verbose( CALL_INFO, 1, 0, "%s received init message from %u\n", getName().c_str(), ev->getSrcId() );
    // Push back remote PE ID
    xbgasHosts.push_back( req->src );
  }
}

void XbgasNIC::setup() {
  iFace->setup();
  if( msgHandler == nullptr ) {
    output->fatal(
      CALL_INFO,
      -1,
      "%s, Error: XbgasNIC implements a callback-based notification and parent has not registerd a callback function\n",
      getName().c_str()
    );
  }
}

void XbgasNIC::finish() {
  iFace->finish();
}

bool XbgasNIC::msgNotify( int vn ) {
  SST::Interfaces::SimpleNetwork::Request* req = iFace->recv( 0 );
  if( req != nullptr ) {
    if( req != nullptr ) {
      xbgasNicEvent* ev = static_cast<xbgasNicEvent*>( req->takePayload() );
      delete req;
      ( *msgHandler )( ev );
    }
  }
  return true;
}

void XbgasNIC::send( xbgasNicEvent* event, int destination ) {
  SST::Interfaces::SimpleNetwork::Request* req = new SST::Interfaces::SimpleNetwork::Request();
  req->dest                                    = destination;
  req->src                                     = iFace->getEndpointID();
  req->givePayload( event );
  sendQ.push( req );
}

int XbgasNIC::getNumDestinations() {
  return numDest;
}

SST::Interfaces::SimpleNetwork::nid_t XbgasNIC::getAddress() {
  return iFace->getEndpointID();
}

bool XbgasNIC::clockTick( Cycle_t cycle ) {
  while( !sendQ.empty() ) {
    if( iFace->spaceToSend( 0, 512 ) && iFace->send( sendQ.front(), 0 ) ) {
      sendQ.pop();
    } else {
      break;
    }
  }
  return false;
}

// EOF
