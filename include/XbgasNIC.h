//
// _XbgasNIC_h_
//
// Copyright (C) 2017-2024 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#ifndef _SST_XBGASNIC_H_
#define _SST_XBGASNIC_H_

// -- Standard Headers
#include <queue>
#include <string>
#include <tuple>
#include <unistd.h>
#include <utility>
#include <vector>

// -- SST Headers
#include "SST.h"

// -- RevCPU Headers
#include "../common/include/RevCommon.h"
#include "RevMemCtrl.h"

namespace SST::RevCPU {

using namespace SST::Interfaces;

/**
 * xbgasNicEvent : inherited class to handle the individual network events for XbgasNIC
 */
class xbgasNicEvent : public SST::Event {
public:
  /// xbgasNicEvent: standard constructor
  xbgasNicEvent( std::string name )
    : Event(), Id( 0 ), SrcName( name ), SrcId( 0 ), SrcAddr( 0 ), DestAddr( 0 ), Size( 0 ), Nelem( 0 ), Stride( 0 ), Data(),
      Opcode( RmtMemOp::Unknown ), Flags( RevFlag::F_NONE ) {}

  /// xbgasNicEvent: secondary constructor
  xbgasNicEvent() : Event() {}

  ~xbgasNicEvent() {}

  /// xbgasNicEvent: retrieve the Hart ID
  unsigned getHart() { return Hart; }

  /// xbgasNicEvent: retrieve the packet Id
  uint32_t getID() { return Id; }

  /// xbgasNicEvent: retrieve the source node Id
  uint32_t getSrcId() { return SrcId; }

  /// xbgasNicEvent: retrieve the source address
  uint64_t getSrcAddr() { return SrcAddr; }

  /// xbgasNicEvent: retrieve the source address
  uint64_t getDestAddr() { return DestAddr; }

  /// xbgasNicEvent: retrieve the element size
  size_t getSize() { return Size; }

  /// xbgasNicEvent: retrieve the number of elements
  uint32_t getNelem() { return Nelem; }

  /// xbgasNicEvent: retrieve the stride value
  uint32_t getStride() { return Stride; }

  /// xbgasNicEvent: retrieve the packet data
  void getData( uint8_t* Buffer );

  /// xbgasNicEvent: retrieve the remote memory operation code
  RmtMemOp getOp() { return Opcode; }

  /// xbgasNicEvent: retrieve the flags
  RevFlag getFlags() { return Flags; }

  /// xbgasNicEvent: retrieve the Aq flags
  uint8_t getAq() { return Aq; }

  /// xbgasNicEvent: retrieve the Rl flags
  uint8_t getRl() { return Rl; }

  /// xbgasNicEvent: set the Hart ID
  bool setHart( unsigned H ) {
    Hart = H;
    return true;
  }

  /// xbgasNicEvent: set the event Id
  bool setId( uint32_t I ) {
    Id = I;
    return true;
  }

  /// xbgasNicEvent: set the source node Id
  bool setSrcId( uint32_t S ) {
    SrcId = S;
    return true;
  }

  /// xbgasNicEvent: set the source/destination address
  bool setSrcAddr( uint64_t Ad ) {
    SrcAddr = Ad;
    return true;
  }

  /// xbgasNicEvent: set the source/destination address
  bool setDestAddr( uint64_t Ad ) {
    DestAddr = Ad;
    return true;
  }

  /// xbgasNicEvent: set the element size
  bool setSize( size_t Sz ) {
    Size = Sz;
    return true;
  }

  /// xbgasNicEvent: set the number of elements
  bool setNelem( uint32_t Ne ) {
    Nelem = Ne;
    return true;
  }

  /// xbgasNicEvent: set the stride value
  bool setStride( uint32_t Sd ) {
    Stride = Sd;
    return true;
  }

  /// xbgasNicEvent: set the packet data
  bool setData( uint8_t* Buffer, uint32_t TotalSz );

  /// xbgasNicEvent: set the Opcode
  bool setOp( RmtMemOp Op ) {
    Opcode = Op;
    return true;
  }

  /// xbgasNicEvent: set the flags
  bool setFlags( RevFlag Fl ) {
    Flags = Fl;
    return true;
  }

  /// xbgasNicEvent: set the Aq flags
  bool setAq( uint8_t Aq ) {
    Aq = Aq;
    return true;
  }

  /// xbgasNicEvent: set the Rl flags
  bool setRl( uint8_t Rl ) {
    Rl = Rl;
    return true;
  }

  // ------------------------------------------------
  // Packet Building Functions
  // ------------------------------------------------

  /// xbgasNicEvent: build a READ request packet
  bool buildREADRqst( uint64_t SrcAddr, uint64_t DestAddr, size_t Size, uint32_t Nelem, uint32_t Stride, RevFlag Fl );

  /// xbgasNicEvent: build a READ LOCK request packet
  bool buildREADLOCKRqst( uint64_t SrcAddr, size_t Size, RevFlag Fl, uint8_t Aq, uint8_t Rl );

  /// xbgasNicEvent: build a WRITE request packet
  bool buildWRITERqst( uint64_t DestAddr, size_t Size, uint32_t Nelem, uint32_t Stride, RevFlag Fl, uint8_t* Buffer );

  /// xbgasNicEvent: build a WRITE UNLOCK request packet
  bool buildWRITEUNLOCKRqst( uint64_t DestAddr, size_t Size, RevFlag Fl, uint8_t* Buffer, uint8_t Aq, uint8_t Rl );

  /// xbgasNicEvent: build a READ respond packet
  bool buildREADResp( uint64_t Id, uint64_t DestAddr, size_t Size, uint32_t Nelem, uint32_t Stride, uint8_t* Buffer );

  /// xbgasNicEvent: build a READ LOCK respond packet
  bool buildREADLOCKResp( uint64_t Id, size_t Size, uint8_t* Buffer );

  /// xbgasNicEvent: build a WRITE respond packet
  bool buildWRITEResp( uint64_t Id );

  /// xbgasNicEvent: build a WRITE UNLOCK respond packet
  bool buildWRITEUNLOCKResp( uint64_t Id, size_t Size, uint8_t* Target );

  /// xbgasNicEvent: virtual function to clone an event
  virtual Event* clone( void ) override {
    xbgasNicEvent* ev = new xbgasNicEvent( *this );
    return ev;
  }

protected:
  unsigned             Hart{};      ///< xbgasNicEvent: Hart ID
  uint32_t             Id{};        ///< xbgasNicEvent: Id for the packet
  std::string          SrcName{};   ///< xbgasNicEvent: Name of the sending device
  uint32_t             SrcId{};     ///< xbgasNicEvent: Source node ID
  uint64_t             SrcAddr{};   ///< xbgasNicEvent: source address for read
  uint64_t             DestAddr{};  ///< xbgasNicEvent: destination address for write
  size_t               Size{};      ///< xbgasNicEvent: Size of each data elements
  uint32_t             Nelem{};     ///< xbgasNicEvent: Number of elements
  uint32_t             Stride{};    ///< xbgasNicEvent: Stride for bulk transfers
  std::vector<uint8_t> Data{};      ///< xbgasNicEvent: Data payload
  RmtMemOp             Opcode{};    ///< xbgasNicEvent: Operation code
  RevFlag              Flags{};     ///< xbgasNicEvent: Memory request flags
  uint8_t              Aq{};        ///< xbgasNicEvent: Acquire flag
  uint8_t              Rl{};        ///< xbgasNicEvent: Release flag

private:
  static std::atomic<uint32_t> main_id;  ///< xbgasNicEvent: main request id counter

public:
  /// xbgasNicEvent: event serializer
  void serialize_order( SST::Core::Serialization::serializer& ser ) override {
    Event::serialize_order( ser );
    ser & Hart;
    ser & Id;
    ser & SrcName;
    ser & SrcId;
    ser & SrcAddr;
    ser & DestAddr;
    ser & Size;
    ser & Nelem;
    ser & Stride;
    ser & Data;
    ser & Opcode;
    ser & Flags;
    ser & Aq;
    ser & Rl;
  }

  /// xbgasNicEvent: implements the NIC serialization
  ImplementSerializable( SST::RevCPU::xbgasNicEvent );
};  // end xbgasNicEvent

/**
 * xbgasNicAPI : Handles the subcomponent NIC API
 */
class xbgasNicAPI : public SST::SubComponent {
public:
  SST_ELI_REGISTER_SUBCOMPONENT_API( SST::RevCPU::xbgasNicAPI )

  SST_ELI_DOCUMENT_PARAMS( { "verbose", "Verbosity for output (0 = nothing)", "0" } )

  /// xbgasNicAPI: constructor
  xbgasNicAPI( ComponentId_t id, Params& params ) : SubComponent( id ) {}

  /// xbgasNicAPI: default destructor
  virtual ~xbgasNicAPI() {}

  /// xbgasNicAPI: set the event handler
  virtual void setMsgHandler( Event::HandlerBase* handler )                  = 0;

  /// xbgasNicAPI: initializes the network
  virtual void init( unsigned int phase )                                    = 0;

  /// xbgasNicAPI: setup the network
  virtual void setup()                                                       = 0;

  /// xbgasNicAPI: finish function
  virtual void finish()                                                      = 0;

  /// xbgasNicAPI: send a message on the network
  virtual void send( xbgasNicEvent* ev, int dest )                           = 0;

  /// xbgasNicAPI: retrieve the number of potential destinations
  virtual int getNumDestinations()                                           = 0;

  /// xbgasNicAPI: returns the NIC's network address
  virtual SST::Interfaces::SimpleNetwork::nid_t getAddress()                 = 0;

  /// xbgasNicAPI: retrieve the hosts
  virtual std::vector<SST::Interfaces::SimpleNetwork::nid_t> getXbgasHosts() = 0;

protected:
  SST::Output* output;  ///< xbgasNicEvent: SST output object
};  /// end xbgasNicAPI

// ----------------------------------------
// XbgasNIC: the Rev network interface controller subcomponent
// ----------------------------------------
class XbgasNIC : public xbgasNicAPI {
public:
  // Register with the SST Core
  SST_ELI_REGISTER_SUBCOMPONENT(
    XbgasNIC, "revcpu", "XbgasNIC", SST_ELI_ELEMENT_VERSION( 1, 0, 0 ), "RISC-V SST xBGAS NIC", SST::RevCPU::xbgasNicAPI
  )

  // Register the parameters
  SST_ELI_DOCUMENT_PARAMS(
    { "clock", "Clock frequency of the NIC", "1Ghz" },
    { "port", "Port to use, if loaded as an anonymous subcomponent", "network" },
    { "verbose", "Verbosity for output (0 = nothing)", "0" },
  )

  // Register the ports
  SST_ELI_DOCUMENT_PORTS( { "port", "Link to network", { "RevCPU.xbgasNicEvent" } } )

  // Register the subcomponent slots
  SST_ELI_DOCUMENT_SUBCOMPONENT_SLOTS( { "iface", "SimpleNetwork interface to a network", "SST::Interfaces::SimpleNetwork" } )

  /// XbgasNIC: constructor
  XbgasNIC( ComponentId_t id, Params& params );

  /// XbgasNIC: destructor
  ~XbgasNIC();

  /// XbgasNIC: set the event handler
  virtual void setMsgHandler( Event::HandlerBase* handler ) { msgHandler = handler; };

  /// XbgasNIC: initialization function
  void init( unsigned int phase ) override;

  /// XbgasNIC: setup function
  void setup() override;

  /// XbgasNIC: finish function
  void finish() override;

  /// XbgasNIC: send event to the destination id
  void send( xbgasNicEvent* ev, int dest ) override;

  /// XbgasNIC: retrieve the number of destinations
  int getNumDestinations() override;

  /// XbgasNIC: get the endpoint's network address
  SST::Interfaces::SimpleNetwork::nid_t getAddress() override;

  /// XbgasNIC: retrieve the hosts
  std::vector<SST::Interfaces::SimpleNetwork::nid_t> getXbgasHosts() { return xbgasHosts; }

  /// XbgasNIC: callback function for the SimpleNetwork interface
  bool msgNotify( int virtualNetwork );

  /// XbgasNIC: clock function
  bool clockTick( Cycle_t cycle );

protected:
  SST::Output* output;  ///< XbgasNIC: SST output object

  SST::Interfaces::SimpleNetwork* iFace;  ///< XbgasNIC: SST network interface

  SST::Event::HandlerBase* msgHandler;  ///< XbgasNIC: SST message handler

  bool initBroadcastSent;  ///< XbgasNIC: has the init bcast been sent?

  int numDest;  ///< XbgasNIC: number of SST destinations

  std::queue<SST::Interfaces::SimpleNetwork::Request*> sendQ;  ///< XbgasNIC: buffered send queue

private:
  std::vector<SST::Interfaces::SimpleNetwork::nid_t> xbgasHosts;  ///< XbgasNIC: xbgas hosts list
};  // end XbgasNIC

}  // namespace SST::RevCPU

#endif  // _SST_XBGASNIC_H_

// EOF
