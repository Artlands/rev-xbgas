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

namespace SST::RevCPU{

using namespace SST::Interfaces;

enum class XbgasOpcode: uint8_t {
  GetRqst     = 0b0000,     ///< xbgasNicEvent: Get request
  PutRqst     = 0b0001,     ///< xbgasNicEvent: Put request
  BulkGetRqst = 0b0010,     ///< xbgasNicEvent: bulk Get request
  BulkPutRqst = 0b0011,     ///< xbgasNicEvent: bulk Put request
  GetResp     = 0b0100,     ///< xbgasNicEvent: Get response
  PutResp     = 0b0101,     ///< xbgasNicEvent: Put response
  BulkGetResp = 0b0110,     ///< xbgasNicEvent: bulk Get response
  BulkPutResp = 0b0111,     ///< xbgasNicEvent: bulk Put response
  Finish      = 0b1111,     ///< xbgasNicEvent: Finish notification
  Unknown     = 0b1000      ///< xbgasNicEvent: Unknown operation
}; 

/**
 * xbgasNicEvent : inherited class to handle the individual network events for XbgasNIC
 */
class xbgasNicEvent : public SST::Event{
public:
  /// xbgasNicEvent: standard constructor
  explicit xbgasNicEvent(std::string name) : 
    Event(), PktId(0), SrcName(std::move(name)),
    Src(0), Addr(0), Size(0), Nelem(0), Stride(0), 
    Data(), Opcode(XbgasOpcode::Unknown), Flags(0) { }

  /// xbgasNicEvent: extended constructor
  xbgasNicEvent(std::string name, std::vector<uint8_t> data):
    Event(), PktId(0), SrcName(std::move(name)),
    Src(0), Addr(0), Size(0), Nelem(0), Stride(0), 
    Data(std::move(data)), Opcode(XbgasOpcode::Unknown), Flags(0) { }

  /// xbgasNicEvent: retrieve the packet Id
  uint64_t getPktId() { return PktId; }

  /// xbgasNicEvent: retrieve the source name
  std::string getSource() { return SrcName; }

  /// xbgasNicEvent: retrieve the source node Id
  uint32_t getSrc() { return Src; }

  /// xbgasNicEvent: retrieve the source/destination address
  uint64_t getAddr() { return Addr; }

  /// xbgasNicEvent: retrieve the element size
  size_t getSize() { return Size; }

  /// xbgasNicEvent: retrieve the number of elements
  uint32_t getNelem() { return Nelem; }

  /// xbgasNicEvent: retrieve the stride value
  uint32_t getStride() { return Stride; }

  /// xbgasNicEvent: retrieve the flags
  StandardMem::Request::flags_t getFlags() { return Flags; }

  /// xbgasNicEvent: set the packet Id
  bool setPktId(uint64_t Id) { PktId = Id; return true; }

  /// xbgasNicEvent: set the source node Id
  bool setSrc(uint32_t S) { Src = S; return true; }

  /// xbgasNicEvent: set the source/destination address
  bool setAddr(uint64_t Ad) { Addr = Ad; return true; }

  /// xbgasNicEvent: set the element size
  bool setSize(size_t Sz) { Size = Sz; return true; }

  /// xbgasNicEvent: set the number of elements
  bool setNelem(uint32_t Ne) { Nelem = Ne; return true; }

  /// xbgasNicEvent: set the stride value
  bool setStride(uint32_t Sd) { Stride = Sd; return true; }

  /// xbgasNicEvent: set the flags
  bool setFlags(StandardMem::Request::flags_t Fl) { Flags = Fl; return true; }

  // ------------------------------------------------
  // Packet Building Functions
  // ------------------------------------------------

  /// xbgasNicEvent: build a Get request packet
  bool buildGetRqst(uint64_t PktId, uint64_t Addr, size_t Size);
  
  /// xbgasNicEvent: build a bulk Get request packet
  bool buildBulkGetRqst(uint64_t PktId, uint64_t Addr, size_t Size, 
                        uint32_t Nelem, uint32_t Stride);
  
  /// xbgasNicEvent: build a Put request packet
  bool buildPutRqst(uint64_t PktId, uint64_t Addr, size_t Size);
  
  /// xbgasNicEvent: build a bulk Put request packet
  bool buildBulkPutRqst(uint64_t PktId, uint64_t Addr, size_t Size, 
                        uint32_t Nelem, uint32_t Stride);
  
  /// xbgasNicEvent: build a Get respond packet
  bool buildGetResp(uint64_t PktId, size_t Size);

  /// xbgasNicEvent: build a bulk Get respond packet
  bool buildBulkGetResp(uint64_t PktId, size_t Size, uint32_t Nelem);
  
  /// xbgasNicEvent: build a Put respond packet
  bool buildPutResp(uint64_t PktId);

  /// xbgasNicEvent: build a bulk Put respond packet
  bool buildBulkPutResp(uint64_t PktId);

  /// xbgasNicEvent: virtual function to clone an event
  virtual Event* clone(void) override{
    xbgasNicEvent* ev = new xbgasNicEvent(*this);
    return ev;
  }

private:
  uint64_t PktId;                       ///< xbgasNicEvent: Id for the packet
  std::string SrcName;                  ///< xbgasNicEvent: Name of the sending device
  uint32_t Src;                         ///< xbgasNicEvent: Source node ID
  uint64_t Addr;                        ///< xbgasNicEvent: Remote memory address
  size_t Size;                          ///< xbgasNicEvent: Size of each data elements
  uint32_t Nelem;                       ///< xbgasNicEvent: Number of elements
  uint32_t Stride;                      ///< xbgasNicEvent: Stride for bulk transfers
  std::vector<uint8_t> Data;            ///< xbgasNicEvent: Data payload
  XbgasOpcode Opcode;                   ///< xbgasNicEvent: Operation code
  StandardMem::Request::flags_t Flags;  ///< xbgasNicEvent: Memory request flags
public:
  /// xbgasNicEvent: secondary constructor
  xbgasNicEvent() : Event() {}

  /// xbgasNicEvent: event serializer
  void serialize_order(SST::Core::Serialization::serializer &ser) override{
    Event::serialize_order(ser);
    ser & PktId;
    ser & SrcName;
    ser & Src;
    ser & Addr;
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

}; // end XbgasNIC

} // namespace SST::RevCPU

#endif // _SST_XBGASNIC_H_

// EOF
