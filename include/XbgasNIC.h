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
#include <map>
#include <unistd.h>

// -- SST Headers
#include <sst/core/sst_config.h>
#include <sst/core/component.h>
#include <sst/core/event.h>
#include <sst/core/link.h>
#include <sst/core/timeConverter.h>
#include <sst/core/interfaces/simpleNetwork.h>

// -- SST Headers
#include <RevNIC.h>

namespace SST {
  namespace RevCPU {
    /**
     * xbgasNicEvent: inherited class to handle the individual network events for xBGAS
     */
    class xbgasNicEvent : public SST::Event {
    public:
      typedef enum {
        GetRqst     = 0b0000,     ///< xbgasNicEvent: Get request
        PutRqst     = 0b0001,     ///< xbgasNicEvent: Put request
        BulkGetRqst  = 0b0010,     ///< xbgasNicEvent: bulk Get request
        BulkPutRqst  = 0b0011,     ///< xbgasNicEvent: bulk Put request
        GetResp     = 0b0100,     ///< xbgasNicEvent: Get response
        PutResp     = 0b0101,     ///< xbgasNicEvent: Put response
        BulkGetResp  = 0b0110,     ///< xbgasNicEvent: bulk Get response
        BulkPutResp  = 0b0111,     ///< xbgasNicEvent: bulk Put response
        Unknown     = 0b1000      ///< xbgasNicEvent: Unknown operation
      } XbgasOpcode;

      /// xbgasNicEvent: standard constructor
      xbgasNicEvent(std::string name) 
      : Event(), PktId(0), SrcName(name), Src(0),
        Size(0), Nelem(1), Stride(0), 
        Addr(0), Opcode(Unknown){ }

      /// xbgasNicEvent: rerieve the source name
      std::string getSource() { return SrcName; }

      /// xbgasNicEvent: retrieve the packet Id
      uint64_t getPktId() { return PktId; }
      
      /// xbgasNicEvent: retrieve the source ID
      int getSrc() { return Src; }

      /// xbgasNicEvent: retrieve the packet operation code
      XbgasOpcode getOpcode() { return Opcode; }

      /// xbgasNicEvent: return the opcode type as a string
      std::string getOpcodeStr();

      /// xbgasNicEvent: retrieve the packet size
      uint32_t getSize() { return Size; }

      /// xbgasNicEvent: retrieve the # of elements value
      uint32_t getNelem() { return Nelem; }

      /// xbgasNicEvent: retrieve the stride value
      uint32_t getStride() { return Stride; }

      /// xbgasNicEvent: retrieve the source/destination address
      uint64_t getAddr() { return Addr; }

      /// xbgasNicEvent: retrieve the packet data
      void getData(uint8_t *Buffer);

      /// xbgasNicEvent: get the number of data blocks for the target size
      unsigned getNumBlocks(uint32_t Size);

      /// xbgasNicEvent: set the source ID
      bool setSrc(int S) { Src = S; return true; }

      /// xbgasNicEvent: set the Id for the target packet
      bool setPktId(uint64_t PktId) {PktId = PktId; return true; }

      /// xbgasNicEvent: set the size of each element in the packet
      bool setSize(uint32_t Sz) {Size = Sz; return true; }

      /// xbgasNicEvent: set the # of elements in the packet
      bool setNelem(uint32_t Ne) {Nelem = Ne; return true; }

      /// xbgasNicEvent: set the stride of elements in the packet
      bool setStride(uint32_t Sd) {Stride = Sd; return true; }

      /// xbgasNicEvent: set the source/destination address
      bool setAddr(uint64_t SAddr) {Addr = SAddr; return true; }

      /// xbgasNicEvent: set the packet data
      bool setData(uint8_t *Buffer, uint32_t Sz);

      // ------------------------------------------------
      // Packet Building Functions
      // ------------------------------------------------

      /// xbgasNicEvent: build a Get request packet
      bool buildGetRqst(uint64_t PktId, uint64_t Addr, uint32_t Size);
      
      /// xbgasNicEvent: build a bulk Get request packet
      bool buildBulkGetRqst(uint64_t PktId, uint64_t Addr, uint32_t Size, 
                            uint32_t Nelem, uint32_t Stride);
      
      /// xbgasNicEvent: build a Put request packet
      bool buildPutRqst(uint64_t PktId, uint64_t Addr, 
                        uint32_t Size, uint8_t *Buffer);
      
      /// xbgasNicEvent: build a bulk Put request packet
      bool buildBulkPutRqst(uint64_t PktId, uint64_t Addr, uint32_t Size, 
                            uint32_t Nelem, uint32_t Stride, uint8_t *Buffer);
      
      /// xbgasNicEvent: build a Get respond packet
      bool buildGetResp(uint64_t PktId, uint32_t Size, uint8_t *Buffer);

      /// xbgasNicEvent: build a bulk Get respond packet
      bool buildBulkGetResp(uint64_t PktId, uint32_t Size, 
                            uint32_t Nelem, uint8_t *Buffer);
      
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
      uint64_t PktId;             ///< xbgasNicEvent: Id for the packet
      std::string SrcName;        ///< xbgasNicEvent: Name of the sending device
      int Src;                    ///< xbgasNicEvent: Source node ID
      uint32_t Size;              ///< xbgasNicEvent: Size of each data element, in bytes
      uint32_t Nelem;             ///< xbgasNicEvent: Number of elements
      uint32_t Stride;            ///< xbgasNicEvent: Stride for bulk transfers
      uint64_t Addr;              ///< xbgasNicEvent: Source/Destination address
      std::vector<uint8_t> Data;  ///< xbgasNicEvent: Data payload
      XbgasOpcode Opcode;         ///< xbgasNicEvent: Operation code 
    public:
      /// xbgasNicEvent: secondary constructor
      xbgasNicEvent() : Event() { }

      /// xbgasNicEvent: event serializer
      void serialize_order(SST::Core::Serialization::serializer &ser) override {
        Event::serialize_order(ser);
        ser & PktId;
        ser & SrcName;
        ser & Src;
        ser & Size;
        ser & Nelem;
        ser & Stride;
        ser & Addr;
        ser & Data;
        ser & Opcode;
      }

      /// xbgasNicEvent: implements the NIC serialization
      ImplementSerializable(SST::RevCPU::xbgasNicEvent);
    };  // end xbgasNicEvent

    /**
     * xbgasNicAPI: Handles the subcomponet API for the xBGAS NIC
     */
    class xbgasNicAPI : public SST::SubComponent{
    public:
      SST_ELI_REGISTER_SUBCOMPONENT_API(SST::RevCPU::xbgasNicAPI)

      /// xbgasNicAPI: default constructor
      xbgasNicAPI(ComponentId_t id, Params& params) : SubComponent(id) { }

      /// xbgasNicAPI: default destructor
      virtual ~xbgasNicAPI() { }

      /// xbgasNicAPI: registers the event handler with the core
      virtual void setMsgHandler(Event::HandlerBase* handler) = 0;

      /// xbgasNicAPI: initializes the network
      virtual void init(unsigned int phase) = 0;

      /// xbgasNicAPI: setup the network
      virtual void setup() { }

      /// xbgasNicAPI: send a message on the network
      virtual void send(xbgasNicEvent *ev, int dest) = 0;

      /// xbgasNicAPI: retrieve the number of potential destinations
      virtual int getNumDestinations() = 0;

      /// xbgasNicAPI: returns the NIC's network address
      virtual SST::Interfaces::SimpleNetwork::nid_t getAddress() = 0;

      /// xbgasNicAPI: retrieve the number of hosts
      virtual unsigned getNumPEs()  = 0;

      virtual std::vector<SST::Interfaces::SimpleNetwork::nid_t> getXbgasHosts() = 0;
    }; // end xbgasNicAPI

    /**
     * XbgasNIC: the Rev network interface controller subcomponent
     */
    class XbgasNIC : public xbgasNicAPI {
    public:
      // Register with the SST Core
      SST_ELI_REGISTER_SUBCOMPONENT_DERIVED(
        XbgasNIC,
        "revcpu",
        "XbgasNIC",
        SST_ELI_ELEMENT_VERSION(1,0,0),
        "RISC-V SST xBGAS NIC",
        SST::RevCPU::xbgasNicAPI
      )

      // Register the parameters
      SST_ELI_DOCUMENT_PARAMS(
        {"port", "Port to use, if loaded as an anonymous subcomponent", "network"},
        {"verbose", "Verbosity for output (0 = nothing)", "0"}
      )

      // Register the ports
      SST_ELI_DOCUMENT_PORTS(
        {"network", "Port to network", {"simpleNetworkExample.nicEvent"} }
      )

      // Register the subcomponent slots
      SST_ELI_DOCUMENT_SUBCOMPONENT_SLOTS(
        {"iface", "SimpleNetwork interface to a network", "SST::Interfaces::SimpleNetwork"}
      )

      /// XbgasNIC: default constructor
      XbgasNIC(ComponentId_t id, Params& params);

      /// XbgasNIC: default destructor
      virtual ~XbgasNIC();

      /// XbgasNIC: Callback to parent on received messages
      virtual void setMsgHandler(Event::HandlerBase* handler);

      /// XbgasNIC: initialization function
      virtual void init(unsigned int phase);

      /// XbgasNIC: setup function
      virtual void setup();

      /// XbgasNIC: send event to the destination id
      virtual void send(xbgasNicEvent *ev, int dest);

      /// XbgasNIC: retrieve the number of destinations
      virtual int getNumDestinations();

      /// XbgasNIC: get the endpoint's network address
      virtual SST::Interfaces::SimpleNetwork::nid_t getAddress();

      /// XbgasNIC: callback function for the SimpleNetwork interface
      bool msgNotify(int virtualNetwork);

      /// XbgasNIC: clock function
      virtual bool clockTick(Cycle_t cycle);

      /// XbgasNIC: retrieve the number of hosts
      virtual unsigned getNumPEs() { return (unsigned)(xbgasHosts.size()); }

      virtual std::vector<SST::Interfaces::SimpleNetwork::nid_t> getXbgasHosts() {return xbgasHosts;}
      
    protected:
      SST::Output *output;                    ///< XbgasNIC: SST output object
      SST::Interfaces::SimpleNetwork * iFace; ///< XbgasNIC: SST network interface
      SST::Event::HandlerBase *msgHandler;    ///< XbgasNIC: SST message handler
      bool initBroadcastSent;                 ///< XbgasNIC: has the init bcast been sent?
      int numDest;                            ///< XbgasNIC: number of SST destinations
      std::queue<SST::Interfaces::SimpleNetwork::Request*> sendQ; ///< XbgasNIC: buffered send queue

    private:
      std::vector<SST::Interfaces::SimpleNetwork::nid_t> xbgasHosts; ///< XbgasNIC: xbgas hosts list
    }; // end XbgasNIC
  } // namespace RevCPU
} // namespace SST

#endif