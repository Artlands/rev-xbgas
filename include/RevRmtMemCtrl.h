//
// _RevRmtMemCtrl_h_
//
// Copyright (C) 2017-2023 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#ifndef _SST_REVCPU_REVRMTMEMCTRL_H_
#define _SST_REVCPU_REVRMTMEMCTRL_H_

// -- C++ Headers
#include <vector>
#include <list>
#include <tuple>
#include <stdio.h>
#include <stdlib.h>

// -- SST Headers
#include "SST.h"

// -- RevCPU Headers
#include "RevOpts.h"
#include "RevMemCtrl.h"
#include "XbgasNIC.h"
#include "../common/include/RevCommon.h"

namespace SST::RevCPU{

class RevMem;

// ----------------------------------------
// RevRmtMemOp
// ----------------------------------------
class RevRmtMemOp {
public:

  /// RevRmtMemOp: constructor
  RevRmtMemOp( unsigned Hart, uint64_t Nmspace, uint64_t SrcAddr, size_t Size, 
               RmtMemOp Op, RevFlag Flags );

  /// RevRmtMemOp: overloaded constructor - read
  RevRmtMemOp( unsigned Hart, uint64_t Nmspace, uint64_t SrcAddr, size_t Size, 
               void *target, RmtMemOp Op, RevFlag Flags );

  /// RevRmtMemOp: overloaded constructor - write
  RevRmtMemOp( unsigned Hart, uint64_t Nmspace, uint64_t DestAddr, size_t Size, 
               char *buffer, RmtMemOp Op, RevFlag Flags );
  
  /// RevRmtMemOp: overloaded constructor - bulk read/write
  RevRmtMemOp( unsigned Hart, uint64_t Nmspace, uint64_t SrcAddr, size_t Size,
               uint32_t Nelem, uint32_t Stride, uint64_t DestAddr, 
               RmtMemOp Op, RevFlag Flags );

  /// RevRmtMemOp: destructor
  ~RevRmtMemOp() = default;

  /// RevRmtMemOp: retrieve the hart id
  unsigned getHart() const { return Hart; }

  /// RevRmtMemOp: retrieve the target namespace
  uint64_t getNmspace() const { return Nmspace; }

  /// RevRmtMemOp: retrieve the source address
  uint64_t getSrcAddr() const { return SrcAddr; }

  /// RevRmtMemOp: retrieve the destination address
  uint64_t getDestAddr() const { return DestAddr; }

  /// RevRmtMemOp: retrieve the size of each data element in bytes
  size_t getSize() const { return Size; }

  /// RevRmtMemOp: retrieve the number of elements
  uint32_t getNelem() const { return Nelem; } 

  /// RevRmtMemOp: retrieve the stride
  uint32_t getStride() const { return Stride; }

  /// RevRmtMemOp: retrieve the memory operation opcode
  RmtMemOp getOp() const { return Op; }

  /// RevRmtMemOp: retrieve the memory buffer
  std::vector<uint8_t> getBuf() const { return membuf; }

  /// RevRmtMemOp: retrieve the memory operation flags
  RevFlag getFlags() const { return Flags; }

  /// RevRmtMemOp: retrieve the standard set of memory flags for MemEventBase
  RevFlag getStdFlags() const { return RevFlag{static_cast<uint32_t>(Flags) & 0xFFFF}; }

  /// RevRmtMemOp: retrieve the flags for MemEventBase without caching enable
  RevFlag getNonCacheFlags() const { return RevFlag{static_cast<uint32_t>(Flags) & 0xFFFD}; }

  /// RevRmtMemOp: retrieve the target address
  void *getTarget() const { return target; }

  /// RevRmtMemOp: retrieve the remote memory request
  const RmtMemReq& getRmtMemReq() const { return procReq; }

  /// RevRmtMemOp: set the hart id
  void setHart( unsigned H ) { Hart = H; }

  /// RevRmtMemOp: set the Namespace
  void setNmspace( uint64_t N ) { Nmspace = N; }

  /// RevRmtMemOp: set the source address
  void setSrcAddr( uint64_t S ) { SrcAddr = S; }

  /// RevRmtMemOp: set the destination address
  void setDestAddr( uint64_t D ) { DestAddr = D; }

  /// RevRmtMemOp: set the number of elements
  void setNelem( uint32_t N ) { Nelem = N; }

  /// RevRmtMemOp: set the stride
  void setStride( uint32_t S ) { Stride = S; }

  /// RevRmtMemOp: set the flags
  void setFlags( RevFlag F ) { Flags = F; }

  /// RevRmtMemOp: set the memory operation request
  void setRmtMemReq( const RmtMemReq& req) { procReq = req; }

private:
  unsigned Hart;                           ///< RevRmtMemOp: hart id
  uint64_t Nmspace;                        ///< RevRmtMemOp: target namespace
  uint64_t SrcAddr;                        ///< RevRmtMemOp: source address
  uint64_t DestAddr;                       ///< RevRmtMemOp: destination address
  size_t Size;                             ///< RevRmtMemOp: size of each data element in bytes
  uint32_t Nelem;                          ///< RevRmtMemOp: number of elements
  uint32_t Stride;                         ///< RevRmtMemOp: stride between elements
  RmtMemOp Op;                             ///< RevRmtMemOp: memory operation
  std::vector<uint8_t> membuf;             ///< RevRmtMemOp: buffer
  RevFlag Flags;                           ///< RevRmtMemOp: request flags
  void *target;                            ///< RevRmtMemOp: target register pointer
  RmtMemReq procReq;                       ///< RevRmtMemOp: remote memory request from RevProc
};

// ----------------------------------------
// RevRmtMemCtrl
// ----------------------------------------
class RevRmtMemCtrl : public SST::SubComponent {
public:

  SST_ELI_REGISTER_SUBCOMPONENT_API(SST::RevCPU::RevRmtMemCtrl)

  SST_ELI_DOCUMENT_PARAMS({ "verbose", "Set the verbosity of output for the memory controller", "0" } )

  /// RevRmtMemCtrl: constructor
  RevRmtMemCtrl( ComponentId_t id, const Params& params);

  /// RevRmtMemCtrl: destructor
  virtual ~RevRmtMemCtrl();

  /// RevRmtMemCtrl: initialization function
  virtual void init(unsigned int phase) = 0;

  /// RevRmtMemCtrl: setup function
  virtual void setup() = 0;

  /// RevRmtMemCtrl: finish function
  virtual void finish() = 0;

  /// RevRmtMemCtrl: clock tick function
  virtual bool clockTick( Cycle_t cycle ) = 0;

  /// RevRmtMemCtrl: get PE id
  virtual unsigned getPEID() = 0;

  /// RevRmtMemCtrl: get the number of PEs
  virtual unsigned getNumPEs() = 0;

  /// RevRmtMemCtrl: determines if outstanding requests exist
  // virtual bool outstandingRqsts() = 0;

  /// RevRmtMemCtrl: set the local memory object
  virtual void setMem(RevMem *mem) = 0;

  // /// RevRmtMemCtrl: set the xBGAS NIC interface
  // virtual void setNic(xbgasNicAPI *Nic) = 0;

  /// RevRmtMemCtrl: send a remote memory read request
  virtual bool sendRmtReadRqst( unsigned Hart, uint64_t Nmspace, 
                                uint64_t SrcAddr, size_t Size, 
                                void *Target, const RmtMemReq& req, 
                                RevFlag flags ) = 0;

  /// RevRmtMemCtrl: send a remote bulk memory read request
  virtual bool sendRmtBulkReadRqst( unsigned Hart, uint64_t Nmspace, 
                                    uint64_t SrcAddr, size_t Size, 
                                    uint32_t Nelem, uint32_t Stride, 
                                    uint64_t DestAddr,
                                    const RmtMemReq& req, RevFlag flags ) = 0;
  
  /// RevRmtMemCtrl: send a remote memory write request
  virtual bool sendRmtWriteRqst( unsigned Hart, uint64_t Nmspace, 
                                 uint64_t DestAddr, size_t Size, char *buffer, 
                                 RevFlag flags ) = 0;

  /// RevRmtMemCtrl: send a remote bulk memory write request
  virtual bool sendRmtBulkWriteRqst( unsigned Hart, uint64_t Nmspace, 
                                     uint64_t DestAddr, size_t Size, 
                                     uint32_t Nelem, uint32_t Stride, 
                                     uint64_t SrcAddr, RevFlag flags) = 0;

  /// RevRmtMemCtrl: handle a remote memory read request
  virtual void handleReadRqst( xbgasNicEvent *ev ) = 0;

  /// RevRmtMemCtrl: handle a remote memory write request
  virtual void handleWriteRqst( xbgasNicEvent *ev ) = 0;
  
  /// RevRmtMemCtrl: handle a remote memory read response
  virtual void handleReadResp( xbgasNicEvent *ev ) = 0;

  /// RevRmtMemCtrl: handle a remote memory write response
  virtual void handleWriteResp( xbgasNicEvent *ev ) = 0;

protected:
  SST::Output *output;        ///< RevRmtMemCtrl: sst output object
}; // class RevRmtMemCtrl

// ----------------------------------------
// RevBasicRmtMemCtrl
// ----------------------------------------
class RevBasicRmtMemCtrl : public RevRmtMemCtrl{
public:
  SST_ELI_REGISTER_SUBCOMPONENT(RevBasicRmtMemCtrl, "revcpu",
                                "RevBasicRmtMemCtrl",
                                SST_ELI_ELEMENT_VERSION(1,0,0),
                                "RISCV-V Rev xBGAS basic remote memory controller",
                                SST::RevCPU::RevRmtMemCtrl
                                )
  
  SST_ELI_DOCUMENT_PARAMS({ "verbose",       "Set the verbosity of output for the remote memory controller", "0" },
                          { "clock",         "Set the clock frequency of the remote memory controller",      "1Ghz"  },
                          { "max_loads",     "Set the maximum number of outstanding loads",                  "64"},
                          { "max_stores",    "Set the maximum number of outstanding stores",                 "64"},
                          { "ops_per_cycle", "Set the maximum number of operations to issue per cycle",      "2"})

  SST_ELI_DOCUMENT_SUBCOMPONENT_SLOTS(
    { "xbgasNicIface", "xBGAS Network interface to a network", "SST::RevCPU::xbgasNicAPI"}
  )

  SST_ELI_DOCUMENT_PORTS()

  SST_ELI_DOCUMENT_STATISTICS(
    { "RmtReadInFlight",  "Counts the number of remote reads in flight",  "count", 1 },
    { "RmtReadPending",   "Counts the number of remote reads pending",    "count", 1 },
    { "RmtReadBytes",     "Counts the number of bytes of remote reads",   "bytes", 1 },
    { "RmtWriteInFlight", "Counts the number of remote writes in flight", "count", 1 },
    { "RmtWritePending",  "Counts the number of remote writes pending",   "count", 1 },
    { "RmtWritesBytes",   "Counts the number of bytes of remote writes",  "bytes", 1 }
  )

  enum RmtMemCtrlStats: uint32_t {
    RmtReadInFlight  = 0,
    RmtReadPending   = 1,
    RmtReadBytes     = 2,
    RmtWriteInFlight = 3,
    RmtWritePending  = 4,
    RmtWritesBytes   = 5
  };

  /// RevBasicRmtMemCtrl: constructor
  RevBasicRmtMemCtrl( ComponentId_t id, const Params& params);

  /// RevBasicRmtMemCtrl: destructor
  ~RevBasicRmtMemCtrl();

  /// RevBasicRmtMemCtrl: initialization function
  void init(unsigned int phase) override;

  /// RevBasicRmtMemCtrl: setup function
  void setup() override;

  /// RevBasicRmtMemCtrl: finish function
  void finish() override;

  /// RevBasicRmtMemCtrl: clock tick function
  bool clockTick( Cycle_t cycle ) override;

  /// RevBasicRmtMemCtrl: get PE id
  unsigned getPEID() { return myPEid; };

  /// RevBasicRmtMemCtrl: get the number of PEs
  unsigned getNumPEs() { return numPEs; };

  /// RevBasicRmtMemCtrl: determines if outstanding requests exist
  // bool outstandingRqsts() override;

  /// RevBasicRmtMemCtrl: xBGAS event processing handler
  // void processEvent( xbgasNicEvent *ev );

  /// RevBasicRmtMemCtrl: set the local memory object
  void setMem(RevMem *mem) { Mem = mem; };

  /// RevBasicRmtMemCtrl: remote memory event processing handler
  void rmtMemEventHandler( Event *ev );

  /// RevBasicRmtMemCtrl: send a remote memory read request
  bool sendRmtReadRqst( unsigned Hart, uint64_t Nmspace, 
                        uint64_t SrcAddr, size_t Size, 
                        void *Target, const RmtMemReq& req, 
                        RevFlag flags ) override;

  /// RevBasicRmtMemCtrl: send a remote bulk memory read request
  bool sendRmtBulkReadRqst( unsigned Hart, uint64_t Nmspace, 
                            uint64_t SrcAddr, size_t Size, 
                            uint32_t Nelem, uint32_t Stride, 
                            uint64_t DestAddr,
                            const RmtMemReq& req, RevFlag flags ) override;
  
  /// RevBasicRmtMemCtrl: send a remote memory write request
  bool sendRmtWriteRqst( unsigned Hart, uint64_t Nmspace, 
                         uint64_t DestAddr, size_t Size, char *buffer, 
                         RevFlag flags ) override;

  /// RevBasicRmtMemCtrl: send a remote bulk memory write request
  bool sendRmtBulkWriteRqst( unsigned Hart, uint64_t Nmspace, 
                             uint64_t DestAddr, size_t Size, 
                             uint32_t Nelem, uint32_t Stride, 
                             uint64_t SrcAddr, RevFlag flags) override;

  /// RevBasicRmtMemCtrl: handle a remote memory read request
  void handleReadRqst( xbgasNicEvent *ev ) override;

  /// RevBasicRmtMemCtrl: handle a remote memory write request
  void handleWriteRqst( xbgasNicEvent *ev ) override;
  
  /// RevBasicRmtMemCtrl: handle a remote memory read response
  void handleReadResp( xbgasNicEvent *ev ) override;

  /// RevRmtMemCtrl: handle a remote memory write response
  void handleWriteResp( xbgasNicEvent *ev ) override;

// protected:
//   class RevRmtMemHandlers : public Event::HandlerBase {
//   public:
//     friend class RevBasicRmtMemCtrl;

//     /// RevRmtMemHandlers: constructor
//     RevRmtMemHandlers( RevBasicRmtMemCtrl* Ctrl, SST::Output* Output );

//     /// RevRmtMemHandlers: destructor
//     virtual ~RevRmtMemHandlers();

//     /// RevRmtMemHandlers: handle remote memory operation events
//     virtual void handle(xbgasNicEvent* ev);
  
//   private:
//     RevBasicRmtMemCtrl* Ctrl;   ///< RevRmtMemHandlers: pointer to the parent controller
//   }; // class RevRmtMemHandlers

private:
  /// RevBasicRmtMemCtrl: process the next memory request
  bool processNextRqst(unsigned &t_max_loads, unsigned &t_max_stores, unsigned &t_max_ops);
  
  /// RevBasicRmtMemCtrl: determine if we can instantiate the target remote memory operation
  bool isRmtMemOpAvailable( RevRmtMemOp *Op, unsigned &t_max_loads, unsigned &t_max_stores );

  /// RevBasicRmtMemCtrl: build a remote memory request packet
  bool buildRmtMemRqst( RevRmtMemOp *Op, bool &Success );

  /// RevBasicRmtMemCtrl: Namespace Lookaside Buffer translation
  uint32_t findDest( uint64_t Nmspace );

  /// RevBasicRmtMemCtrl: register statistics
  void registerStats();

  /// RevBasicRmtMemCtrl: inject statistics data for the target metric
  void recordStat( RmtMemCtrlStats stat, uint64_t Data );

  /// RevBasicRmtMemCtrl: function to mark a local load as complete
  void MarkLocalLoadComplete( const MemReq& req );

  /// RevBasicRmtMemCtrl: return the total number of outstanding requests
  // uint64_t getTotalRqsts();

  // -- private data members;
  RevMem *Mem;                                ///< RevBasicRmtMemCtrl: pointer to the memory object
  xbgasNicAPI* xbgasNic;                      ///< RevBasicRmtMemCtrl: xBGAS NIC interface
  std::map<uint64_t, uint32_t> nmspaceLB;          ///< RevBasicRmtMemCtrl: namespace lookaside Buffer map; <Namespace, Dest>
  std::vector<SST::Interfaces::SimpleNetwork::nid_t> xbgasHosts; ///< RevBasicRmtMemCtrl: xbgas hosts list
  unsigned virtualHart;                       ///< RevBasicRmtMemCtrl: virtual hart id
  unsigned myPEid;                            ///< RevBasicRmtMemCtrl: My PE id
  unsigned numPEs;                            ///< RevBasicRmtMemCtrl: number of PEs on distinct nodes

  unsigned max_loads;                         ///< RevBasicRmtMemCtrl: maximum number of outstanding loads
  unsigned max_stores;                        ///< RevBasicRmtMemCtrl: maximum number of outstanding stores
  unsigned max_ops;                           ///< RevBasicRmtMemCtrl: maximum number of operations per cycle

  uint64_t num_read;                          ///< RevBasicRmtMemCtrl: number of remote read requests
  uint64_t num_write;                         ///< RevBasicRmtMemCtrl: number of remote write requests

  std::vector<uint64_t> requests;                    ///< RevBasicRmtMemCtrl: vector of outstanding remote memory requests
  std::vector<RevRmtMemOp *> rqstQ;                  ///< RevBasicRmtMemCtrl: queued remote memory requests
  std::map<uint64_t, RevRmtMemOp *> outstanding;     ///< RevBasicRmtMemCtrl: map of remote write requests

#define LOAD_RECORD_SRCID    0
#define LOAD_RECORD_DESTID   0
#define LOAD_RECORD_ID       1
#define LOAD_RECORD_DESTADDR 2
#define LOAD_RECORD_SIZE     3
#define LOAD_RECORD_NELEM    4
#define LOAD_RECORD_STRIDE   5
#define LOAD_RECORD_FLAGS    6
#define LOAD_RECORD_BUFFER   7

  std::unordered_map<uint64_t, std::tuple<uint32_t,   // SrcId or DestId
                                          uint32_t,   // Id
                                          uint64_t,   // DestAddr
                                          size_t,     // Size
                                          uint32_t,   // Nelem
                                          uint32_t,   // Stride
                                          RevFlag,    // Flags
                                          uint8_t *>  // Buffer
                                          > LocalLoadRecord;         ///< RevBasicRmtMemCtrl: record the number of elements
  std::unordered_map<uint64_t, uint32_t> LocalLoadCount;             ///< RevBasicRmtMemCtrl: the number of local load operations
  std::unordered_map<uint64_t, uint64_t> LocalLoadTrack;             ///< RevBasicRmtMemCtrl: the association between address and SrcId+Id
  std::unordered_map<uint64_t, RmtMemOp> LocalLoadType;              ///< RevBasicRmtMemCtrl: the purpose of the local load operation
  std::unordered_map<uint64_t, xbgasNicEvent *> EventsToSend;        ///< RevBasicRmtMemCtrl: event to send

  std::vector<Statistic<uint64_t> *> stats;          ///< RevBasicRmtMemCtrl: vector of statistics
}; // class RevBasicRmtMemCtrl

} // namespace SST::RevCPU

#endif // _SST_REVCPU_REVRMTMEMCTRL_H_