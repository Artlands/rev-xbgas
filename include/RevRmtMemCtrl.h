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
#include "../common/include/RevCommon.h"

namespace SST::RevCPU{

class RevMem;
class xbgasNicAPI;
class xbgasNicEvent;

// ----------------------------------------
// RevRmtMemOp
// ----------------------------------------
class RevRmtMemOp : public RevMemOp{
public:

  /// RevRmtMemOp: constructor
  RevRmtMemOp( unsigned Hart, uint64_t Nmspace, uint64_t Addr, size_t Size, 
               MemOp Op, StandardMem::Request::flags_t Flags );

  /// RevRmtMemOp: overloaded constructor - read
  RevRmtMemOp( unsigned Hart, uint64_t Nmspace, uint64_t Addr, size_t Size, 
               void *target, MemOp Op, StandardMem::Request::flags_t Flags );
  
  /// RevRmtMemOp: overloaded constructor - bulk read
  RevRmtMemOp( unsigned Hart, uint64_t Nmspace, uint64_t SAddr, size_t Size,
               uint32_t Nelem, uint32_t Stride, uint64_t DAddr, 
               MemOp Op, StandardMem::Request::flags_t Flags );
  
  /// RevRmtMemOp: overloaded constructor - write
  RevRmtMemOp( unsigned Hart, uint64_t Nmspace, uint64_t Addr, size_t Size, 
               char *buffer, MemOp Op, StandardMem::Request::flags_t Flags );

  /// RevRmtMemOp: overloaded constructor - bulk write
  RevRmtMemOp( unsigned Hart, uint64_t Nmspace, uint64_t DAddr, size_t Size,
               uint32_t Nelem, uint32_t Stride, uint64_t SAddr, 
               MemOp Op, StandardMem::Request::flags_t Flags );

  /// RevRmtMemOp: destructor
  ~RevRmtMemOp() = default;

  /// RevRmtMemOp: retrieve the target namespace
  uint64_t getNmspace() const { return Nmspace; }

  /// RevRmtMemOp: retrieve the destination address
  uint64_t getDstAddr() const { return DstAddr; }

  /// RevRmtMemOp: retrieve the number of elements
  uint32_t getNelem() const { return Nelem; } 

  /// RevRmtMemOp: retrieve the stride
  uint32_t getStride() const { return Stride; }

  /// RevRmtMemOp: set the Namespace
  void setNmspace( uint64_t N ) { Nmspace = N; }

  /// RevRmtMemOp: set the destination address
  void setDstAddr( uint64_t P ) { DstAddr = P; }

  /// RevRmtMemOp: set the number of elements
  void setNelem( uint32_t N ) { Nelem = N; }

  /// RevRmtMemOp: set the stride
  void setStride( uint32_t S ) { Stride = S; }

private:
  uint64_t Nmspace;                        ///< RevRmtMemOp: target namespace
  uint64_t DstAddr;                        ///< RevRmtMemOp: destination address
  uint32_t Nelem;                          ///< RevRmtMemOp: number of elements
  uint32_t Stride;                         ///< RevRmtMemOp: stride between elements
}

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

  /// RevRmtMemCtrl: determines if outstanding requests exist
  virtual bool outstandingRqsts() = 0;

  /// RevRmtMemCtrl: set the local memory object
  virtual void setMem(RevMem *Mem) = 0;

  /// RevRmtMemCtrl: set the xBGAS NIC interface
  virtual void setNic(xbgasNicAPI *Nic) = 0;

  /// RevRmtMemCtrl: send a remote memory read request
  virtual bool sendRmtReadRqst( unsigned Hart, uint64_t Nmspace, 
                                uint64_t SrcAddr, size_t Size, 
                                void *Target,
                                const RmtMemReq& req, 
                                StandardMem::Request::flags_t flags ) = 0;

  /// RevRmtMemCtrl: send a remote bulk memory read request
  virtual bool sendRmtBulkReadRqst( unsigned Hart, uint64_t Nmspace, 
                                    uint64_t SrcAddr, size_t Size, 
                                    uint32_t Nelem, uint32_t Stride, 
                                    uint64_t DestAddr,
                                    const RmtMemReq& req, 
                                    StandardMem::Request::flags_t flags ) = 0;
  
  /// RevRmtMemCtrl: send a remote memory write request
  virtual bool sendRmtWriteRqst( unsigned Hart, uint64_t Nmspace, 
                                 uint64_t DestAddr, size_t Size, 
                                 std::vector<uint8_t> Data ) = 0;

  /// RevRmtMemCtrl: send a remote bulk memory write request
  virtual bool sendRmtBulkWriteRqst( unsigned Hart, uint64_t Nmspace, 
                                     uint64_t DestAddr, size_t Size, 
                                     uint32_t Nelem, uint32_t Stride, 
                                     uint64_t SrcAddr ) = 0;

  /// RevRmtMemCtrl: handle a remote memory read request
  virtual void handleRmtReadRqst( xbgasNicEvent *ev ) = 0;
  
  /// RevRmtMemCtrl: handle a remote memory write request
  virtual bool handleRmtWriteRqst( xbgasNicEvent *ev ) = 0;

  /// RevRmtMemCtrl: handle a read response
  virtual void handleRmtReadResp( xbgasNicEvent *ev ) = 0;

  /// RevRmtMemCtrl: handle a bulk read response
  virtual void handleRmtBulkReadResp( xbgasNicEvent *ev ) = 0;

  /// RevRmtMemCtrl: handle a write response
  virtual void handleRmtWriteResp( xbgasNicEvent *ev ) = 0;

  /// RevRmtMemCtrl: handle a bulk write response
  virtual void handleRmtBulkWriteResp( xbgasNicEvent *ev ) = 0;

protected:
  SST::Output *output;        ///< RevRmtMemCtrl: sst output object
}; // class RevRmtMemCtrl

// ----------------------------------------
// RevBasicRmtMemCtrl
// ----------------------------------------
class RevBasicRmtMemCtrl : public RevRmtMemCtrl{
public:
  SST_ELI_REGISTER_SUBCOMPONENT_DERIVED(RevBasicRmtMemCtrl, "revcpu",
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

  SST_ELI_DOCUMENT_SUBCOMPONENT_SLOTS()

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
  }RmtMemCtrlStat;

  /// RevBasicRmtMemCtrl: constructor
  RevBasicRmtMemCtrl( ComponentId_t id, Params& params );

  /// RevBasicRmtMemCtrl: destructor
  virtual ~RevBasicRmtMemCtrl();

  /// RevBasicRmtMemCtrl: initialization function
  virtual void init(unsigned int phase) override;

  /// RevBasicRmtMemCtrl: setup function
  virtual void setup() override;

  /// RevBasicRmtMemCtrl: finish function
  virtual void finish() override;

  /// RevBasicRmtMemCtrl: clock tick function
  virtual bool clockTick( Cycle_t cycle );

  /// RevBasicRmtMemCtrl: determines if outstanding requests exist
  bool outstandingRqsts() override;

  /// RevBasicRmtMemCtrl: xBGAS event processing handler
  void processEvent( xbgasNicEvent *ev );

  /// RevBasicRmtMemCtrl: send a remote memory read request
  virtual bool sendRmtReadRqst( unsigned Hart, uint64_t Nmspace, 
                                uint64_t SrcAddr, size_t Size, 
                                void *Target,
                                const RmtMemReq& req, 
                                StandardMem::Request::flags_t flags) override;

  /// RevBasicRmtMemCtrl: send a remote bulk memory read request
  virtual bool sendRmtBulkReadRqst( unsigned Hart, uint64_t Nmspace, 
                                    uint64_t SrcAddr, size_t Size, 
                                    uint32_t Nelem, uint32_t Stride, 
                                    uint64_t DestAddr,
                                    const RmtMemReq& req, 
                                    StandardMem::Request::flags_t flags ) override;
  
  /// RevBasicRmtMemCtrl: send a remote memory write request
  virtual bool sendRmtWriteRqst( unsigned Hart, uint64_t Nmspace, 
                                 uint64_t DestAddr, size_t Size, 
                                 std::vector<uint8_t> Data ) override;

  /// RevBasicRmtMemCtrl: send a remote bulk memory write request
  virtual bool sendRmtBulkWriteRqst( unsigned Hart, uint64_t Nmspace, 
                                     uint64_t DestAddr, size_t Size, 
                                     uint32_t Nelem, uint32_t Stride, 
                                     uint64_t SrcAddr ) override;

  /// RevBasicRmtMemCtrl: handle a remote memory read request
  virtual void handleRmtReadRqst( xbgasNicEvent *ev ) override;
  
  /// RevBasicRmtMemCtrl: handle a remote memory write request
  virtual bool handleRmtWriteRqst( xbgasNicEvent *ev ) override;

  /// RevBasicRmtMemCtrl: handle a read response
  virtual void handleRmtReadResp( xbgasNicEvent *ev ) override;

  /// RevBasicRmtMemCtrl: handle a bulk read response
  virtual void handleRmtBulkReadResp( xbgasNicEvent *ev ) override;

  /// RevBasicRmtMemCtrl: handle a write response
  virtual void handleRmtWriteResp( xbgasNicEvent *ev ) override;

  /// RevBasicRmtMemCtrl: handle a bulk write response
  virtual void handleRmtBulkWriteResp( xbgasNicEvent *ev ) override;

private:
  /// RevBasicRmtMemCtrl: process the next memory request
  bool processNextRqst(unsigned &t_max_loads, unsigned &t_max_stores, unsigned &t_max_ops);

  /// RevBasicRmtMemCtrl: register statistics
  void registerStats();

  /// RevBasicRmtMemCtrl: inject statistics data for the target metric
  void recordStat( RmtMemCtrlStats stat, uint64_t Data );

  /// RevBasicRmtMemCtrl: return the total number of outstanding requests
  uint64_t getTotalRqsts();

  // -- private data members;
  unsigned max_loads;                         ///< RevBasicRmtMemCtrl: maximum number of outstanding loads
  unsigned max_stores;                        ///< RevBasicRmtMemCtrl: maximum number of outstanding stores
  unsigned max_ops;                           ///< RevBasicRmtMemCtrl: maximum number of operations per cycle

  uint64_t num_read;                          ///< RevBasicRmtMemCtrl: number of remote read requests
  uint64_t num_write;                         ///< RevBasicRmtMemCtrl: number of remote write requests

}; // class RevBasicRmtMemCtrl

} // namespace SST::RevCPU

#endif // _SST_REVCPU_REVRMTMEMCTRL_H_