//
// _XbgasNIC_h_
//
// Copyright (C) 2017-2023 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#ifndef _SST_XBGASNIC_H_
#define _SST_XBGASNIC_H_

// -- Standard Headers
#include <vector>
#include <queue>
#include <tuple>
#include <utility>
#include <string>
#include <unistd.h>

// -- SST Headers
#include "SST.h"

#include "../common/include/RevCommon.h"

namespace SST::RevCPU{

using namespace SST::Interfaces; 

/**
 * xbgasNicEvent : inherited class to handle the individual network events for XbgasNIC
 */
class xbgasNicEvent : public SST::Event{
public:
  /// xbgasNicEvent: standard constructor
  xbgasNicEvent(std::string name)
  : Event(), SrcName(name), SrcId(0), SrcAddr(0), 
    DestAddr(0), Size(0), Nelem(0), Stride(0), 
    Data(), Opcode(RmtMemOp::Unknown), Flags(0) {}

  /// xbgasNicEvent: secondary constructor
  xbgasNicEvent(): Event() {}

  ~xbgasNicEvent() { }

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
  void getData(uint8_t *Buffer);

  /// xbgasNicEvent: retrieve the remote memory operation code
  RmtMemOp getOp() { return Opcode; }

  /// xbgasNicEvent: retrieve the flags
  StandardMem::Request::flags_t getFlags() { return Flags; }

  /// xbgasNicEvent: set the source node Id
  bool setSrcId(uint32_t S) { SrcId = S; return true; }

  /// xbgasNicEvent: set the source/destination address
  bool setSrcAddr(uint64_t Ad) { SrcAddr = Ad; return true; }

  /// xbgasNicEvent: set the source/destination address
  bool setDestAddr(uint64_t Ad) { DestAddr = Ad; return true; }

  /// xbgasNicEvent: set the element size
  bool setSize(size_t Sz) { Size = Sz; return true; }

  /// xbgasNicEvent: set the number of elements
  bool setNelem(uint32_t Ne) { Nelem = Ne; return true; }

  /// xbgasNicEvent: set the stride value
  bool setStride(uint32_t Sd) { Stride = Sd; return true; }

  /// xbgasNicEvent: set the packet data
  bool setData(uint8_t *Buffer, uint32_t TotalSz);

  /// xbgasNicEvent: set the flags
  bool setFlags(StandardMem::Request::flags_t Fl) { Flags = Fl; return true; }

  // ------------------------------------------------
  // Packet Building Functions
  // ------------------------------------------------
  
  /// xbgasNicEvent: build a READ request packet
  bool buildREADRqst(uint64_t SrcAddr, uint64_t DestAddr, 
                     size_t Size, uint32_t Nelem, 
                     uint32_t Stride,
                     StandardMem::Request::flags_t Fl);
  
  /// xbgasNicEvent: build a WRITE request packet
  bool buildWRITERqst(uint64_t DestAddr, size_t Size, 
                      uint32_t Nelem, uint32_t Stride, 
                      StandardMem::Request::flags_t Fl,
                      uint8_t *Buffer);
  
  /// xbgasNicEvent: build a READ respond packet
  bool buildREADResp(uint64_t Id, uint64_t DestAddr, size_t Size, 
                     uint32_t Nelem, uint32_t Stride,
                     uint8_t *Buffer);
  
  /// xbgasNicEvent: build a WRITE respond packet
  bool buildWRITEResp(uint64_t Id);

  /// xbgasNicEvent: virtual function to clone an event
  virtual Event* clone(void) override{
    xbgasNicEvent* ev = new xbgasNicEvent(*this);
    return ev;
  }

protected:
  uint32_t Id;                          ///< xbgasNicEvent: Id for the packet
  std::string SrcName;                  ///< xbgasNicEvent: Name of the sending device
  uint32_t SrcId;                       ///< xbgasNicEvent: Source node ID
  uint64_t SrcAddr;                     ///< xbgasNicEvent: source address for read
  uint64_t DestAddr;                    ///< xbgasNicEvent: destination address for write
  size_t Size;                          ///< xbgasNicEvent: Size of each data elements
  uint32_t Nelem;                       ///< xbgasNicEvent: Number of elements
  uint32_t Stride;                      ///< xbgasNicEvent: Stride for bulk transfers
  std::vector<uint8_t> Data;            ///< xbgasNicEvent: Data payload
  RmtMemOp Opcode;                      ///< xbgasNicEvent: Operation code
  StandardMem::Request::flags_t Flags;  ///< xbgasNicEvent: Memory request flags
  
private:
  static std::atomic<uint32_t> main_id; ///< xbgasNicEvent: main request id counter

public:
  /// xbgasNicEvent: event serializer
  void serialize_order(SST::Core::Serialization::serializer &ser) override{
    Event::serialize_order(ser);
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
  }

  /// xbgasNicEvent: implements the NIC serialization
  ImplementSerializable(SST::RevCPU::xbgasNicEvent);
};  // end xbgasNicEvent


/**
 * xbgasNicAPI : Handles the subcomponent NIC API
 */
class xbgasNicAPI: public SST::SubComponent{
public:
  SST_ELI_REGISTER_SUBCOMPONENT_API(SST::RevCPU::xbgasNicAPI, TimeConverter*, Event::HandlerBase *)

  SST_ELI_DOCUMENT_PARAMS( {"verbose", "Verbosity for output (0 = nothing)", "0"} )

  /// xbgasNicEvent: constructor
  xbgasNicAPI( ComponentId_t id, Params& params, TimeConverter* tc, Event::HandlerBase *handler) : SubComponent(id) { }

  /// xbgasNicEvent: default destructor
  virtual ~xbgasNicAPI() {}

  /// xbgasNicEvent: initializes the network
  virtual void init(unsigned int phase) = 0;

  /// xbgasNicEvent: setup the network
  virtual void setup() = 0;

  /// xbgasNicEvent: finish function
  virtual void finish() = 0;

  /// xbgasNicEvent: send a message on the network
  virtual void send(xbgasNicEvent *ev, int dest) = 0;

  /// xbgasNicEvent: retrieve the number of potential destinations
  virtual int getNumDestinations() = 0;

  /// xbgasNicEvent: returns the NIC's network address
  virtual SST::Interfaces::SimpleNetwork::nid_t getAddress() = 0;

  /// xbgasNicAPI: retrieve the number of hosts
  virtual unsigned getNumPEs() = 0;

  /// xbgasNicAPI: retrieve the hosts
  virtual std::vector<SST::Interfaces::SimpleNetwork::nid_t> getXbgasHosts() = 0;

protected:
  SST::Output *output;                    ///< xbgasNicEvent: SST output object
}; /// end xbgasNicAPI

// ----------------------------------------
// XbgasNIC: the Rev network interface controller subcomponent
// ----------------------------------------
class XbgasNIC : public xbgasNicAPI {
public:
  // Register with the SST Core
  SST_ELI_REGISTER_SUBCOMPONENT(
    XbgasNIC,
    "revcpu",
    "XbgasNIC",
    SST_ELI_ELEMENT_VERSION(1, 0, 0),
    "RISC-V SST xBGAS NIC",
    SST::RevCPU::xbgasNicAPI
  )

  // Register the parameters
  SST_ELI_DOCUMENT_PARAMS(
    {"clock", "Clock frequency of the NIC", "1Ghz"},
    {"verbose", "Verbosity for output (0 = nothing)", "0"},
  )

  // Register the ports
  SST_ELI_DOCUMENT_PORTS(
    {"port", "Link to network", {"RevCPU.xbgasNicEvent"} }
  )

  // Register the subcomponent slots
  SST_ELI_DOCUMENT_SUBCOMPONENT_SLOTS(
    {"linkcontrol", "Network interface", "SST::Interfaces::SimpleNetwork"}
  )

  /// XbgasNIC: constructor
  XbgasNIC(ComponentId_t id, Params& params, TimeConverter* tc, Event::HandlerBase *handler);

  /// XbgasNIC: destructor
  ~XbgasNIC();

  /// XbgasNIC: initialization function
  void init(unsigned int phase) override;

  /// XbgasNIC: setup function
  void setup() override;

  /// XbgasNIC: finish function
  void finish() override;

  /// XbgasNIC: send event to the destination id
  void send(xbgasNicEvent *ev, int dest) override;

  /// XbgasNIC: retrieve the number of destinations
  int getNumDestinations() override;

  /// XbgasNIC: get the endpoint's network address
  SST::Interfaces::SimpleNetwork::nid_t getAddress() override;

  /// XbgasNIC: retrieve the number of hosts
  unsigned getNumPEs() { return (unsigned)(xbgasHosts.size()); }

  /// XbgasNIC: retrieve the hosts
  std::vector<SST::Interfaces::SimpleNetwork::nid_t> getXbgasHosts() {return xbgasHosts;}

  /// XbgasNIC: callback function for the SimpleNetwork interface
  bool msgNotify(int virtualNetwork);

  /// XbgasNIC: clock function
  bool clockTick(Cycle_t cycle);

protected:
  SST::Output *output;                    ///< XbgasNIC: SST output object

  SST::Interfaces::SimpleNetwork* link_control; ///< XbgasNIC: SST network interface

  SST::Event::HandlerBase *msgHandler;    ///< XbgasNIC: SST message handler

  bool initBroadcastSent;                 ///< XbgasNIC: has the init bcast been sent?

  int numDest;                            ///< XbgasNIC: number of SST destinations

  std::queue<SST::Interfaces::SimpleNetwork::Request*> sendQ; ///< XbgasNIC: buffered send queue

private:
  std::vector<SST::Interfaces::SimpleNetwork::nid_t> xbgasHosts; ///< XbgasNIC: xbgas hosts list
}; // end XbgasNIC

} // namespace SST::RevCPU

#endif // _SST_XBGASNIC_H_

// EOF
