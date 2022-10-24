//
// _XbgasNIC_h_
//
// Copyright (C) 2017-2021 Tactical Computing Laboratories, LLC
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
#include <unistd.h>

// -- SST Headers
#include <sst/core/sst_config.h>
#include <sst/core/component.h>
#include <sst/core/event.h>
#include <sst/core/link.h>
#include <sst/core/timeConverter.h>
#include <sst/core/interfaces/simpleNetwork.h>

// #include "xbgasNicEvent.h"

namespace SST {
  namespace RevCPU {
    class xbgasNicEvent : public SST::Event {
    public:
      typedef enum{
        Get,          ///< XbgasOp: Get
        Put,          ///< XbgasOp: Put
        Success,      ///< XbgasOp: Request success
        Failed        ///< XbgasOp: Request failed
      } XbgasOpcode;

      /// xbgasNicEvent: standard constructor
      xbgasNicEvent(std::string name)
      : Event(), SrcName(name),
        Tag(0), Opcode(0),
        Size(0), Addr(0), Stride(0){ }
      
      /// xbgasNicEvent: retrieve the source name;
      std::string getSource() { return SrcName; }

      /// xbgasNicEvent: retrieve the source ID
      int getSrc() { return Src; }

      /// xbgasNicEvent: retrieve the packet Tag
      uint8_t getTag() { return Tag; }

      /// xbgasNicEvent: retrieve the packet DMA flag
      bool getDMA() {return DmaFlag; }

      /// xbgasNicEvent: retrieve the packet operation code
      int getOpcode() { return Opcode; }

      /// xbgasNicEvent: return the opcode type as a string
      std::string getOpcodeStr();

      /// xbgasNicEvent: retrieve the packet size
      uint32_t getSize() { return Size; }

      /// xbgasNicEvent: retrieve the # of elements value
      uint32_t getNelem() { return Nelem; }

      /// xbgasNicEvent: retrieve the stride value
      uint32_t getStride() { return Stride; }

      /// xbgasNicEvent: retrieve the packet address
      uint64_t getAddr() { return Addr; }

      /// xbgasNicEvent: retrieve DMA destination address
      uint64_t getDestAddr() { return DestAddr ;}

      /// xbgasNicEvent: retrieve the packet data
      void getData(uint64_t *Out);

      /// xbgasNicEvent: get the number of data blocks for the target size
      unsigned getNumBlocks(uint32_t Size);

      /// xbgasNicEvent: set the source ID
      bool setSrc(int S) { Src = S; return true; }

      /// xbgasNicEvent: set the Tag for the target packet
      bool setTag(uint32_t T);

      /// xbgasNicEvent: set the size in the packet
      bool setSize(uint32_t Sz);

      /// xbgasNicEvent: set the address for the packet
      bool setAddr(uint64_t A);

      /// xbgasNicEvent: set the # of elements in the packet
      bool setNelem(uint32_t Ne);

      /// xbgasNicEvent: set the stride in the packet
      bool setStride(uint32_t Sd);

      /// xbgasNicEvent: set the DMA flag for the packet
      bool setDMA(bool Dma);

      /// xbgasNicEvent: set the DMA destination address
      bool setDestAddr( uint64_t DAddr );

      /// xbgasNicEvent: set the packet data
      bool setData(uint64_t *In, uint32_t Sz);

      // ------------------------------------------------
      // Packet Building Functions
      // ------------------------------------------------

      /// xbgasNicEvent: build a get packet
      bool buildGet(uint8_t Tag, uint64_t SrcAddr, uint32_t Size, 
                    uint32_t Nelem, uint32_t Stride, 
                    bool Dma, uint64_t DmaDestAddr);

      /// xbgasNicEvent: build a put packet
      bool buildPut(uint8_t Tag, uint64_t DestAddr, uint32_t Size, 
                    uint32_t Nelem, uint32_t Stride, 
                    bool Dma, uint64_t *Data);

      /// xbgasNicEvent: build a success packet
      bool buildSuccess(uint8_t Tag);

      /// xbgasNicEvent: build a failed packet
      bool buildFailed(uint8_t Tag);

      /// xbgasNicEvent: virtual function to clone an event
      virtual Event* clone(void) override{
        xbgasNicEvent* ev = new xbgasNicEvent(*this);
        return ev;
      }

      /// xbgasNicEvent: second constructor
      xbgasNicEvent() : Event() {}

      /// xbgasNicEvent: Serializ all data members of the event
      void serialize_order(SST::Core::Serialization::serializer &ser) override {
        Event::serialize_order(ser);
        ser & SrcName;
        ser & Src;
        ser & Tag;
        ser & DmaFlag;
        ser & Opcode;
        ser & Size;
        ser & Addr;
        ser & Nelem;
        ser & Stride;
        ser & DestAddr;
        ser & Data;
      }

      /// xbgasNicEvent: Register this event as serializable
      ImplementSerializable(SST::RevCPU::xbgasNicEvent);

    private:
      std::string SrcName;                  ///< xbgasNicEvent: Name of the sending device
      int Src;                              ///< xbgasNicEvent: Source ID
      uint8_t Tag;                          ///< xbgasNicEvent: Tag value of the packet
      bool DmaFlag;                         ///< xbgasNicEvent: if the event is a DMA operation
      int Opcode;                           ///< xbgasNicEvent: Operation code of the packet
      uint32_t Size;                        ///< xbgasNicEvent: Size value of the packet
      uint64_t Addr;                        ///< xbgasNicEvent: Address field
      uint32_t Nelem;                       ///< xbgasNicEvent: Number of elements of the packet
      uint32_t Stride;                      ///< xbgasNicEvent: Stride for bulk transfer
      uint64_t DestAddr;                    ///< xbgasNicEvent: Destination address for DMA
      std::vector<uint64_t> Data;           ///< xbgasNicEvent: Data field                  

    }; // end xbgasNicEvent
    /**
     * xbgasNicAPI : Handles the subcomponent NIC API
     */
    class xbgasNicAPI: public SST::SubComponent{
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
      
    }; /// end xbgasNicAPI

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
        "RISC-V SST XBGAS NIC",
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

#endif // _SST_XBGASNIC_H_

// EOF
