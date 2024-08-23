//
// _RevRmtMemCtrl_h_
//
// Copyright (C) 2017-2024 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#ifndef _SST_REVCPU_REVRMTMEMCTRL_H_
#define _SST_REVCPU_REVRMTMEMCTRL_H_

// -- C++ Headers
#include <list>
#include <stdio.h>
#include <stdlib.h>
#include <tuple>
#include <vector>

// -- SST Headers
#include "SST.h"

// -- RevCPU Headers
#include "../common/include/RevCommon.h"
#include "RevMemCtrl.h"
#include "RevOpts.h"
#include "XbgasNIC.h"

namespace SST::RevCPU {

class RevMem;

// xBGAS memory local load records
struct LocalLoadRecord {
  unsigned Hart;      // xBGAS Hart ID
  uint64_t Nmspace;   // xBGAS namespace
  uint32_t Id;        // xBGAS NIC event ID
  uint32_t SrcId;     // xBGAS NIC source ID
  uint64_t SrcAddr;   // xBGAS source address of this load
  uint64_t DestAddr;  // xBGAS destination address of this load
  size_t   Size;      // xBGAS size of this load
  uint32_t Nelem;     // xBGAS number of elements
  uint32_t Stride;    // xBGAS stride
  RevFlag  Flags;     // xBGAS flag
  uint8_t* Buffer;    // xBGAS buffer pointer
  RmtMemOp ReqPurp;   // xBGAS the purpose of this local load

  LocalLoadRecord(
    unsigned H,
    uint64_t N,
    uint32_t I,
    uint32_t S,
    uint64_t Sr,
    uint64_t D,
    size_t   Sz,
    uint32_t Ne,
    uint32_t St,
    RevFlag  F,
    uint8_t* B,
    RmtMemOp P
  )
    : Hart( H ), Nmspace( N ), Id( I ), SrcId( S ), SrcAddr( Sr ), DestAddr( D ), Size( Sz ), Nelem( Ne ), Stride( St ), Flags( F ),
      Buffer( B ), ReqPurp( P ) {}
};

// ----------------------------------------
// RevRmtMemOp
// ----------------------------------------
class RevRmtMemOp {
public:
  /// RevRmtMemOp: constructor
  RevRmtMemOp( unsigned Hart, uint64_t Nmspace, uint64_t SrcAddr, size_t Size, RmtMemOp Op, RevFlag Flags );

  /// RevRmtMemOp: overloaded constructor - read
  RevRmtMemOp( unsigned Hart, uint64_t Nmspace, uint64_t SrcAddr, size_t Size, void* Target, RmtMemOp Op, RevFlag Flags );

  /// RevRmtMemOp: overloaded constructor - write/bulk write
  RevRmtMemOp(
    unsigned Hart,
    uint64_t Nmspace,
    uint64_t DestAddr,
    size_t   Size,
    uint32_t Nelem,
    uint32_t Stride,
    uint8_t* Buffer,
    RmtMemOp Op,
    RevFlag  Flags
  );

  /// RevRmtMemOp: overloaded constructor - bulk read
  RevRmtMemOp(
    unsigned Hart,
    uint64_t Nmspace,
    uint64_t SrcAddr,
    size_t   Size,
    uint32_t Nelem,
    uint32_t Stride,
    uint64_t DestAddr,
    RmtMemOp Op,
    RevFlag  Flags
  );

  /// RevRmtMemOp: overloaded constructor - AMO- Read lock
  RevRmtMemOp(
    unsigned Hart, uint64_t Nmspace, uint64_t SrcAddr, size_t Size, void* Target, RmtMemOp Op, RevFlag Flags, uint8_t Aq, uint8_t Rl
  );

  /// RevRmtMemOp: overloaded constructor - AMO- Write unlock
  RevRmtMemOp(
    unsigned Hart,
    uint64_t Nmspace,
    uint64_t DestAddr,
    size_t   Size,
    void*    Target,
    uint8_t* Buffer,
    RmtMemOp Op,
    RevFlag  Flags,
    uint8_t  Aq,
    uint8_t  Rl
  );

  /// RevRmtMemOp: destructor
  ~RevRmtMemOp()                               = default;

  /// Disallow copying and assignment
  RevRmtMemOp( const RevRmtMemOp& )            = delete;
  RevRmtMemOp& operator=( const RevRmtMemOp& ) = delete;

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
  std::vector<uint8_t> getBuf() const { return Membuf; }

  /// RevRmtMemOp: retrieve the memory operation flags
  RevFlag getFlags() const { return Flags; }

  /// RevRmtMemOp: retrieve the acquire flag
  uint8_t getAq() const { return Aq; }

  /// RevRmtMemOp: retrieve the release flag
  uint8_t getRl() const { return Rl; }

  /// RevRmtMemOp: retrieve the standard set of memory flags for MemEventBase
  RevFlag getStdFlags() const { return RevFlag{ static_cast<uint32_t>( Flags ) & 0xFFFF }; }

  /// RevRmtMemOp: retrieve the flags for MemEventBase without caching enable
  RevFlag getNonCacheFlags() const { return RevFlag{ static_cast<uint32_t>( Flags ) & 0xFFFD }; }

  /// RevRmtMemOp: retrieve the target address
  void* getTarget() const { return Target; }

  /// RevRmtMemOp: retrieve the remote memory request
  const RmtMemReq& getRmtMemReq() const { return ProcReq; }

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

  /// RevRmtMemOp: set the acquire flag
  void setAq( uint8_t A ) { Aq = A; }

  /// RevRmtMemOp: set the release flag
  void setRl( uint8_t R ) { Rl = R; }

  /// RevRmtMemOp: set the memory operation request
  void setRmtMemReq( const RmtMemReq& Req ) { ProcReq = Req; }

private:
  unsigned             Hart{};      ///< RevRmtMemOp: hart id
  uint64_t             Nmspace{};   ///< RevRmtMemOp: target namespace
  uint64_t             SrcAddr{};   ///< RevRmtMemOp: source address
  uint64_t             DestAddr{};  ///< RevRmtMemOp: destination address
  size_t               Size{};      ///< RevRmtMemOp: size of each data element in bytes
  uint32_t             Nelem{};     ///< RevRmtMemOp: number of elements
  uint32_t             Stride{};    ///< RevRmtMemOp: stride between elements
  RmtMemOp             Op{};        ///< RevRmtMemOp: memory operation
  std::vector<uint8_t> Membuf{};    ///< RevRmtMemOp: Buffer
  RevFlag              Flags{};     ///< RevRmtMemOp: request Flags
  uint8_t              Aq{};        ///< RevRmtMemOp: acquire flag
  uint8_t              Rl{};        ///< RevRmtMemOp: release flag
  void*                Target{};    ///< RevRmtMemOp: Target register pointer
  RmtMemReq            ProcReq{};   ///< RevRmtMemOp: remote memory request from RevProc
};

// ----------------------------------------
// RevRmtMemCtrl
// ----------------------------------------
class RevRmtMemCtrl : public SST::SubComponent {
public:
  SST_ELI_REGISTER_SUBCOMPONENT_API( SST::RevCPU::RevRmtMemCtrl )

  SST_ELI_DOCUMENT_PARAMS( { "verbose", "Set the verbosity of output for the memory controller", "0" } )

  /// RevRmtMemCtrl: constructor
  RevRmtMemCtrl( ComponentId_t id, const Params& params );

  /// RevRmtMemCtrl: destructor
  virtual ~RevRmtMemCtrl();

  /// RevRmtMemCtrl: initialization function
  virtual void init( unsigned int phase ) = 0;

  /// RevRmtMemCtrl: setup function
  virtual void setup()                    = 0;

  /// RevRmtMemCtrl: finish function
  virtual void finish()                   = 0;

  /// RevRmtMemCtrl: clock tick function
  virtual bool clockTick( Cycle_t cycle ) = 0;

  /// RevRmtMemCtrl: get PE id
  virtual unsigned getPEID()              = 0;

  /// RevRmtMemCtrl: get the number of PEs
  virtual unsigned getNumPEs()            = 0;

  /// RevRmtMemCtrl: check is remote memory operation is done
  virtual bool isDone()                   = 0;

  /// RevRmtMemCtrl: determines if outstanding requests exist
  // virtual bool outstandingRqsts() = 0;

  /// RevRmtMemCtrl: set the local memory object
  virtual void setMem( RevMem* mem )      = 0;

  // /// RevRmtMemCtrl: set the xBGAS NIC interface
  // virtual void setNic(xbgasNicAPI *Nic) = 0;

  /// RevRmtMemCtrl: send a remote memory read request
  virtual bool sendRmtReadRqst(
    unsigned Hart, uint64_t Nmspace, uint64_t SrcAddr, size_t Size, void* Target, const RmtMemReq& Req, RevFlag Flags
  ) = 0;

  /// RevRmtMemCtrl: send a remote memory read lock request
  virtual bool sendRmtReadLockRqst(
    unsigned         Hart,
    uint64_t         Nmspace,
    uint64_t         SrcAddr,
    size_t           Size,
    void*            Target,
    const RmtMemReq& Req,
    RevFlag          Flags,
    uint8_t          aq,
    uint8_t          rl
  ) = 0;

  virtual bool sendRmtWriteUnLockRqst(
    unsigned         Hart,
    uint64_t         Nmspace,
    uint64_t         DestAddr,
    size_t           Size,
    uint8_t*         Buffer,
    void*            Target,
    const RmtMemReq& Req,
    RevFlag          Flags,
    uint8_t          aq,
    uint8_t          rl
  ) = 0;

  /// RevRmtMemCtrl: send a remote bulk memory read request
  virtual bool sendRmtBulkReadRqst(
    unsigned Hart,
    uint64_t Nmspace,
    uint64_t SrcAddr,
    size_t   Size,
    uint32_t Nelem,
    uint32_t Stride,
    uint64_t DestAddr,
    RevFlag  Flags
  ) = 0;

  /// RevRmtMemCtrl: send a remote memory write request
  virtual bool
    sendRmtWriteRqst( unsigned Hart, uint64_t Nmspace, uint64_t DestAddr, size_t Size, uint8_t* Buffer, RevFlag Flags ) = 0;

  /// RevRmtMemCtrl: send a remote bulk memory write request
  virtual bool sendRmtBulkWriteRqst(
    unsigned Hart,
    uint64_t Nmspace,
    uint64_t DestAddr,
    size_t   Size,
    uint32_t Nelem,
    uint32_t Stride,
    uint64_t SrcAddr,
    RevFlag  Flags
  )                                                 = 0;

  /// RevRmtMemCtrl: send a FENCE request
  virtual bool sendFENCE( unsigned Hart )           = 0;

  /// RevRmtMemCtrl: handle a remote memory read request
  virtual void handleReadRqst( xbgasNicEvent* ev )  = 0;

  /// RevRmtMemCtrl: handle a remote memory write request
  virtual void handleWriteRqst( xbgasNicEvent* ev ) = 0;

  /// RevRmtMemCtrl: handle a remote memory read response
  virtual void handleReadResp( xbgasNicEvent* ev )  = 0;

  /// RevRmtMemCtrl: handle a remote memory write response
  virtual void handleWriteResp( xbgasNicEvent* ev ) = 0;

protected:
  SST::Output* output;  ///< RevRmtMemCtrl: sst output object
};  // class RevRmtMemCtrl

// ----------------------------------------
// RevBasicRmtMemCtrl
// ----------------------------------------
class RevBasicRmtMemCtrl : public RevRmtMemCtrl {
public:
  SST_ELI_REGISTER_SUBCOMPONENT(
    RevBasicRmtMemCtrl,
    "revcpu",
    "RevBasicRmtMemCtrl",
    SST_ELI_ELEMENT_VERSION( 1, 0, 0 ),
    "RISCV-V Rev xBGAS basic remote memory controller",
    SST::RevCPU::RevRmtMemCtrl
  )

  SST_ELI_DOCUMENT_PARAMS(
    { "verbose", "Set the verbosity of output for the remote memory controller", "0" },
    { "clock", "Set the clock frequency of the remote memory controller", "1Ghz" },
    { "max_loads", "Set the maximum number of outstanding loads", "64" },
    { "max_stores", "Set the maximum number of outstanding stores", "64" },
    { "ops_per_cycle", "Set the maximum number of operations to issue per cycle", "2" }
  )

  SST_ELI_DOCUMENT_SUBCOMPONENT_SLOTS( { "xbgasNicIface", "xBGAS Network interface to a network", "SST::RevCPU::xbgasNicAPI" } )

  SST_ELI_DOCUMENT_PORTS()

  SST_ELI_DOCUMENT_STATISTICS(
    { "RmtReadInFlight", "Counts the number of remote reads in flight", "count", 1 },
    { "RmtReadPending", "Counts the number of remote reads pending", "count", 1 },
    { "RmtReadBytes", "Counts the number of bytes of remote reads", "bytes", 1 },
    { "RmtWriteInFlight", "Counts the number of remote writes in flight", "count", 1 },
    { "RmtWritePending", "Counts the number of remote writes pending", "count", 1 },
    { "RmtWritesBytes", "Counts the number of bytes of remote writes", "bytes", 1 },
    { "RmtFenceInFlight", "Counts the number of FENCE requests in flight", "count", 1 },
    { "RmtFencePending", "Counts the number of FENCE requests pending", "count", 1 }
  )

  enum RmtMemCtrlStats : uint32_t {
    RmtReadInFlight  = 0,
    RmtReadPending   = 1,
    RmtReadBytes     = 2,
    RmtWriteInFlight = 3,
    RmtWritePending  = 4,
    RmtWritesBytes   = 5,
    RmtFenceInFlight = 6,
    RmtFencePending  = 7
  };

  /// RevBasicRmtMemCtrl: constructor
  RevBasicRmtMemCtrl( ComponentId_t id, const Params& params );

  /// RevBasicRmtMemCtrl: destructor
  ~RevBasicRmtMemCtrl();

  /// RevBasicRmtMemCtrl: initialization function
  void init( unsigned int phase ) override;

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

  /// RevBasicRmtMemCtrl: check is remote memory operation is done
  bool isDone() override;

  /// RevBasicRmtMemCtrl: determines if outstanding requests exist
  // bool outstandingRqsts() override;

  /// RevBasicRmtMemCtrl: xBGAS event processing handler
  // void processEvent( xbgasNicEvent *ev );

  /// RevBasicRmtMemCtrl: set the local memory object
  void setMem( RevMem* mem ) { Mem = mem; };

  /// RevBasicRmtMemCtrl: remote memory event processing handler
  void rmtMemEventHandler( Event* ev );

  /// RevBasicRmtMemCtrl: send a remote memory read request
  bool sendRmtReadRqst(
    unsigned Hart, uint64_t Nmspace, uint64_t SrcAddr, size_t Size, void* Target, const RmtMemReq& Req, RevFlag Flags
  ) override;

  /// RevRmtMemCtrl: send a remote memory read lock request
  bool sendRmtReadLockRqst(
    unsigned         Hart,
    uint64_t         Nmspace,
    uint64_t         SrcAddr,
    size_t           Size,
    void*            Target,
    const RmtMemReq& Req,
    RevFlag          Flags,
    uint8_t          aq,
    uint8_t          rl
  ) override;

  // RevRmtMemCtrl: send a remote memory store conditional request
  bool sendRmtWriteUnLockRqst(
    unsigned         Hart,
    uint64_t         Nmspace,
    uint64_t         DestAddr,
    size_t           Size,
    uint8_t*         Buffer,
    void*            Target,
    const RmtMemReq& Req,
    RevFlag          Flags,
    uint8_t          aq,
    uint8_t          rl
  ) override;

  /// RevBasicRmtMemCtrl: send a remote bulk memory read request
  bool sendRmtBulkReadRqst(
    unsigned Hart,
    uint64_t Nmspace,
    uint64_t SrcAddr,
    size_t   Size,
    uint32_t Nelem,
    uint32_t Stride,
    uint64_t DestAddr,
    RevFlag  Flags
  ) override;

  /// RevBasicRmtMemCtrl: send a remote memory write request
  bool sendRmtWriteRqst( unsigned Hart, uint64_t Nmspace, uint64_t DestAddr, size_t Size, uint8_t* Buffer, RevFlag Flags ) override;

  /// RevBasicRmtMemCtrl: send a remote bulk memory write request
  bool sendRmtBulkWriteRqst(
    unsigned Hart,
    uint64_t Nmspace,
    uint64_t DestAddr,
    size_t   Size,
    uint32_t Nelem,
    uint32_t Stride,
    uint64_t SrcAddr,
    RevFlag  Flags
  ) override;

  /// RevRmtMemCtrl: send a FENCE request
  bool sendFENCE( unsigned Hart ) override;

  /// RevBasicRmtMemCtrl: handle a remote memory read request
  void handleReadRqst( xbgasNicEvent* ev ) override;

  /// RevBasicRmtMemCtrl: handle a remote memory write request
  void handleWriteRqst( xbgasNicEvent* ev ) override;

  /// RevBasicRmtMemCtrl: handle a remote memory read response
  void handleReadResp( xbgasNicEvent* ev ) override;

  /// RevRmtMemCtrl: handle a remote memory write response
  void handleWriteResp( xbgasNicEvent* ev ) override;

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
  bool processNextRqst( unsigned& t_max_loads, unsigned& t_max_stores, unsigned& t_max_ops );

  /// RevBasicRmtMemCtrl: determine if we can instantiate the target remote memory operation
  bool isRmtMemOpAvailable( RevRmtMemOp* Op, unsigned& t_max_loads, unsigned& t_max_stores );

  /// RevBasicRmtMemCtrl: build a remote memory request packet
  bool buildRmtMemRqst( RevRmtMemOp* Op, bool& Success );

  /// RevBasicRmtMemCtrl: Namespace Lookaside Buffer translation
  uint32_t findDest( uint64_t Nmspace );

  /// RevBasicRmtMemCtrl: register statistics
  void registerStats();

  /// RevBasicRmtMemCtrl: inject statistics data for the target metric
  void recordStat( RmtMemCtrlStats stat, uint64_t Data );

  /// RevBasicRmtMemCtrl: function to mark a local load as complete
  void MarkLocalLoadComplete( const MemReq& Req );

  /// RevBasicRmtMemCtrl: return the total number of outstanding requests
  // uint64_t getTotalRqsts();

  // -- private data members;
  RevMem*                      Mem{};       ///< RevBasicRmtMemCtrl: pointer to the memory object
  xbgasNicAPI*                 xbgasNic{};  ///< RevBasicRmtMemCtrl: xBGAS NIC interface
  std::map<uint64_t, uint32_t> nmspaceLB{
  };  ///< RevBasicRmtMemCtrl: TODO: track in the LRU policy. namespace lookaside Buffer map; <Namespace, Dest>
  std::vector<SST::Interfaces::SimpleNetwork::nid_t> xbgasHosts{};   ///< RevBasicRmtMemCtrl: xbgas hosts list
  unsigned                                           virtualHart{};  ///< RevBasicRmtMemCtrl: virtual hart id
  unsigned                                           myPEid{};       ///< RevBasicRmtMemCtrl: My PE id
  unsigned                                           numPEs{};       ///< RevBasicRmtMemCtrl: number of PEs on distinct nodes

  unsigned max_loads{};   ///< RevBasicRmtMemCtrl: maximum number of outstanding loads
  unsigned max_stores{};  ///< RevBasicRmtMemCtrl: maximum number of outstanding stores
  unsigned max_ops{};     ///< RevBasicRmtMemCtrl: maximum number of operations per cycle

  uint64_t num_read{};   ///< RevBasicRmtMemCtrl: number of remote read requests
  uint64_t num_write{};  ///< RevBasicRmtMemCtrl: number of remote write requests
  uint64_t num_fence{};  ///< RevBasicRmtMemCtrl: number of FENCE requests

  std::vector<uint32_t>            requests{};     ///< RevBasicRmtMemCtrl: vector of outstanding remote memory requests
  std::vector<RevRmtMemOp*>        rqstQ{};        ///< RevBasicRmtMemCtrl: queued remote memory requests
  std::map<uint32_t, RevRmtMemOp*> outstanding{};  ///< RevBasicRmtMemCtrl: map of remote write requests

  std::unordered_map<uint64_t, LocalLoadRecord> LocalLoadTrack{
  };  ///< RevBasicRmtMemCtrl: the association between hashed id and local load record
  std::unordered_map<uint64_t, uint32_t> LocalLoadCount{};  ///< RevBasicRmtMemCtrl: the number of local load operations
  std::unordered_map<uint64_t, uint64_t> LocalLoadOpMap{};  ///< RevBasicRmtMemCtrl: the association between address and SrcId+Id

  std::vector<Statistic<uint64_t>*> stats{};  ///< RevBasicRmtMemCtrl: vector of statistics
};  // class RevBasicRmtMemCtrl

}  // namespace SST::RevCPU

#endif  // _SST_REVCPU_REVRMTMEMCTRL_H_
