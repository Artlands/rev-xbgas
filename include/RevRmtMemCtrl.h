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
#include <stdio.h>
#include <stdlib.h>

// -- SST Headers
#include <sst/core/sst_config.h>
#include <sst/core/output.h>
#include <sst/core/subcomponent.h>

// -- RevCPU Headers
#include "RevOpts.h"
#include "RevMem.h"
#include "XbgasNIC.h"

namespace SST::RevCPU {
  class RevRmtMemCtrl;
}

using namespace SST::RevCPU;

namespace SST {
  namespace RevCPU {
    // ----------------------------------------
    // RevRmtMemCtrl
    // ----------------------------------------
    class RevRmtMemCtrl : public SST::SubComponent {
    public:

      SST_ELI_REGISTER_SUBCOMPONENT_API(SST::RevCPU::RevRmtMemCtrl)
      
      SST_ELI_DOCUMENT_PARAMS({ "verbose", "Verbosity for the remote memory controller", "0" })

      /// RevRmtMemCtrl: default constructor
      RevRmtMemCtrl( ComponentId_t id, Params& params );

      /// RevRmtMemCtrl: default destructor
      virtual ~RevRmtMemCtrl();

      /// RevRmtMemCtrl: initialization function
      virtual void init(unsigned int phase) = 0;

      /// RevRmtMemCtrl: setup function
      virtual void setup() = 0;

      /// RevRmtMemCtrl: send a remote memory read request
      virtual bool sendRmtReadRqst( uint64_t Nmspace, uint64_t SrcAddr, 
                                    uint32_t Size, void *Target) = 0;

      /// RevRmtMemCtrl: send a remote direct memory read request
      virtual bool sendRmtDmaReadRqst( uint64_t Nmspace, uint64_t SrcAddr, 
                                       uint32_t Size, uint32_t Nelem, 
                                       uint32_t Stride, uint64_t DmaDestAddr ) = 0;
      
      /// RevRmtMemCtrl: send a remote memory write request
      virtual bool sendRmtWriteRqst( uint64_t Nmspace, uint64_t DestAddr, 
                                     uint32_t Size, uint8_t *Buffer) = 0;

      /// RevRmtMemCtrl: send a remote direct memory write request
      virtual bool sendRmtDmaWriteRqst( uint64_t Nmspace, uint64_t DestAddr, 
                                        uint32_t Size, uint32_t Nelem, 
                                        uint32_t Stride, uint64_t DmaSrcAddr ) = 0;
    
    protected:
      SST::Output *output;  ///< RevRmtMemCtrl: sst output object
    }; // class RevRmtMemCtrl
  
    // ----------------------------------------
    // RevBasicRmtMemCtrl
    // ----------------------------------------
    class RevBasicRmtMemCtrl : public RevRmtMemCtrl {
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
                              { "max_responses", "Set the maximum number of outstanding responses per cycle",    "2"},
                              { "ops_per_cycle", "Set the maximum number of operations to issue per cycle",      "2"})

      SST_ELI_DOCUMENT_SUBCOMPONENT_SLOTS({ "nicIface", "Set the interface to the NIC", "SST::Interfaces::SimpleNetwork" })

      SST_ELI_DOCUMENT_PORTS()

      SST_ELI_DOCUMENT_STATISTICS(
        { "RmtReadInFlight",  "Counts the number of remote reads in flight",  "count", 1 },
        { "RmtReadPending",   "Counts the number of remote reads pending",    "count", 1 },
        { "RmtReads",         "Counts the number of bytes of remote reads",   "bytes", 1 },
        { "RmtWriteInFlight", "Counts the number of remote writes in flight", "count", 1 },
        { "RmtWritePending",  "Counts the number of remote writes pending",   "count", 1 },
        { "RmtWrites",        "Counts the number of bytes of remote writes",  "bytes", 1 }
      )

      typedef enum{
        RmtReadInFlight  = 0,
        RmtReadPending   = 1,
        RmtReads         = 2,
        RmtWriteInFlight = 3,
        RmtWritePending  = 4,
        RmtWrites        = 5
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
      virtual bool isFinished();

      /// RevBasicRmtMemCtrl: clock tick function
      virtual bool clockTick( Cycle_t cycle );

      /// RevBasicRmtMemCtrl: remote memory event processing handler
      void rmtMemEventHandler( Event *ev );

      /// RevBasicRmtMemCtrl: send a remote memory read request
      virtual bool sendRmtReadRqst( uint64_t Nmspace, uint64_t SrcAddr, 
                                    uint32_t Size, void *Target) override;

      /// RevBasicRmtMemCtrl: send a remote direct memory read request
      virtual bool sendRmtDmaReadRqst( uint64_t Nmspace, uint64_t SrcAddr, 
                                       uint32_t Size, uint32_t Nelem,
                                       uint32_t Stride, uint64_t DmaDestAddr ) override;
      
      /// RevBasicRmtMemCtrl: send a remote memory write request
      virtual bool sendRmtWriteRqst( uint64_t Nmspace, uint64_t DestAddr, 
                                     uint32_t Size, uint8_t *Buffer) override;

      /// RevBasicRmtMemCtrl: send a remote direct memory write request
      virtual bool sendRmtDmaWriteRqst( uint64_t Nmspace, uint64_t DestAddr, 
                                        uint32_t Size, uint32_t Nelem, 
                                        uint32_t Stride, uint64_t DmaSrcAddr ) override;

    private:
      /// RevBasicRmtMemCtrl: determine if we can instantiate the target remote memory operation
      bool isRmtMemOpAvail(xbgasNicEvent *ev, unsigned &t_max_loads, unsigned &t_max_stores);

      /// RevBasicRmtMemCtrl: handle a remote memory read request
      virtual bool handleRmtReadRqst( xbgasNicEvent *ev );
      
      /// RevBasicRmtMemCtrl: handle a remote memory write request
      virtual bool handleRmtWriteRqst( xbgasNicEvent *ev );

      /// RevBasicRmtMemCtrl: handle a read response
      virtual void handleRmtReadResp( xbgasNicEvent *ev );

      /// RevBasicRmtMemCtrl: handle a write response
      virtual void handleRmtWriteResp( xbgasNicEvent *ev );

      /// RevBasicRmtMemCtrl: Namespace Lookaside Buffer translation
      int findDest( uint64_t Nmspace );

      /// RevBasicRmtMemCtrl: process the next remote memory request
      bool sendRmtMemRqsts(unsigned &t_max_loads, 
                           unsigned &t_max_stores, 
                           unsigned &t_max_ops);
                          
      /// RevBasicRmtMemCtrl: process the next remote memory response
      bool sendRmtMemResps(unsigned &t_max_responses);

      /// RevBasicRmtMemCtrl: register statistics
      void registerStats();

      /// RevBasicRmtMemCtrl: register statistics
      void recordStat(RmtMemCtrlStat Stat, uint64_t Data);

      /// RevBasicRmtMemCtrl: set the local memory object
      bool setMem(RevMem *Mem) { mem = Mem; return true; };

      // -- private data members
      RevMem *mem;                               ///< RevBasicRmtMemCtrl: pointer to the memory object
      xbgasNicAPI *xbgas_nic;                    ///< RevBasicRmtMemCtrl: xBGAS NIC interface
      
      unsigned max_loads;                        ///< RevBasicRmtMemCtrl: maximum number of outstanding loads
      unsigned max_stores;                       ///< RevBasicRmtMemCtrl: maximum number of outstanding stores
      unsigned max_responses;                    ///< RevBasicRmtMemCtrl: maximum number of responses to issue per cycle
      unsigned max_ops;                          ///< RevBasicRmtMemCtrl: maximum number of operations to issue per cycle


      uint64_t num_read;                         ///< RevBasicRmtMemCtrl: number of remote read requests
      uint64_t num_write;                        ///< RevBasicRmtMemCtrl: number of remote write requests

      std::vector<uint64_t> requests;                               ///< RevBasicRmtMemCtrl: outstanding requests
      std::map<uint64_t, xbgasNicEvent *> outstanding;              ///< RevBasicRmtMemCtrl: map of outstanding requests, <PktID, Event>
      std::vector<std::pair<xbgasNicEvent *, int>> rqstQ;           ///< RevBasicRmtMemCtrl: queued remote memory requests to be sent out, <Event, Dest>
      std::vector<std::pair<xbgasNicEvent *, int>> respQ;           ///< RevBasicRmtMemCtrl: queued remote memory responses to be sent out, <Event, Dest>
      std::vector<std::pair<uint64_t, int>> nmspaceLB;              ///< RevBasicRmtMemCtrl: namespace lookaside Buffer; pair<Namespace, Dest>
      std::vector<Statistic<uint64_t> *> stats;                     ///< RevBasicRmtMemCtrl: statistics vector
      static std::atomic<uint64_t> main_id;                         ///< RevBasicRmtMemCtrl: main request id counter
    }; // class RevBasicRmtMemCtrl
  } // namespace RevCPU
} // namespace SST


#endif  // _SST_REVCPU_REVRMTMEMCTRL_H_