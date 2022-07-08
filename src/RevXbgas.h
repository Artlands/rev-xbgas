//
// _RevXbgas_h_
//
// Copyright (C) 2017-2021 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#ifndef _SST_REVXBGAS_H_
#define _SST_REVXBGAS_H_

// -- SST Headers
#include <sst/core/sst_config.h>
#include <sst/core/component.h>

// -- RevCPU headers
#include "RevOpts.h"
#include "RevMem.h"
#include "XbgasNIC.h"

namespace SST::RevCPU {
  class RevXbgas;
}

using namespace SST::RevCPU;

namespace SST {
  namespace RevCPU {
    class RevXbgas {
    public:
      /// RevXbgas: standard constructor
      RevXbgas(xbgasNicAPI *XNic, RevOpts *Opts, RevMem *Mem, SST::Output *Output);

      /// RevMem: standard destructor
      ~RevXbgas();

      /// RevXbgas: XbgasNIC message handler
      void handleXbgasMessage(SST::Event *ev);

      /// RevXbgas: clock function
      bool clockTick(Cycle_t currentCycle, unsigned msgPerCycle );

      bool checkGetRequests( uint64_t Nmspace, uint64_t Addr, uint8_t *Tag );

      // bool checkGetResponses( uint8_t Tag );
      bool readGetResponses( uint8_t Tag, void *Data );

      // Remote memory operation interfaces
      void WriteU8( uint64_t Nmspace, uint64_t Addr, uint8_t Value);
      void WriteU16( uint64_t Nmspace, uint64_t Addr, uint16_t Value);
      void WriteU32( uint64_t Nmspace, uint64_t Addr, uint32_t Value);
      void WriteU64( uint64_t Nmspace, uint64_t Addr, uint64_t Value);
      void WriteFloat( uint64_t Nmspace, uint64_t Addr, float Value);
      void WriteDouble( uint64_t Nmspace, uint64_t Addr, double Value);

      void ReadU8( uint64_t Nmspace, uint64_t Addr );
      void ReadU16( uint64_t Nmspace, uint64_t Addr );
      void ReadU32( uint64_t Nmspace, uint64_t Addr );
      void ReadU64( uint64_t Nmspace, uint64_t Addr );
      void ReadFloat( uint64_t Nmspace, uint64_t Addr );
      void ReadDouble( uint64_t Nmspace, uint64_t Addr );

    private:
      xbgasNicAPI *xnic;                              ///< RevXbgas: XbgasNic object
      RevOpts *opts;                                  ///< RevXbgas: options object
      RevMem *mem;                                    ///< RevXbgas: memory object
      SST::Output *output;                            ///< RevXbgas: output handler
      uint8_t PrivTag;                                ///< RevXbgas: private tag locator
      std::vector<std::pair<uint64_t, 
                            SST::Interfaces::SimpleNetwork::nid_t>> NLB;      ///< RevXbgas: namespace lookaside buffer; pair<Namespace, Dest>
      std::list<std::pair<uint8_t,int>> TrackTags;    ///< RevXbgas: tracks the outgoing remote memory request; pair<Tag,Dest>
      
      std::vector<std::tuple<uint8_t,
                             int,
                             uint64_t>> TrackGets;    ///< RevXbgas: tracks the outstanding get messages; tuple<Tag,Dest,Addr>
      
      std::vector<std::tuple<uint8_t, 
                             uint64_t *, 
                             uint32_t>> GetResponses; ///< RevXbgas: tracks the get responses; tuple<Tag,*Data,Sz>
      
      std::vector<std::tuple<uint8_t,
                             uint32_t,
                             unsigned,
                             int,
                             uint64_t>> ReadQueue;    ///< RevXbgas: xbgas remote memory requests queue
                                                      ///<        - Tag
                                                      ///<        - Size
                                                      ///<        - Cost
                                                      ///<        - Src
                                                      ///<        - Addr

      std::queue<std::pair<xbgasNicEvent *, int>> SendMB;///< RevXbgas: xbgas outgoing command mailbox; pair<Cmd,Dest>
      
      /// RevXbgas: Event handlers, called when an event is received
      void handleSuccess(xbgasNicEvent *event);
      void handleFailed(xbgasNicEvent *event);
      void handleGet(xbgasNicEvent *event);
      void handlePut(xbgasNicEvent *event);

      void buildSuccessResp(xbgasNicEvent *event);
      void buildFailedResp(xbgasNicEvent *event);
      
      /// RevXbgas: Creates a unique tag for this message
      uint8_t createTag();

      /// RevXbgas: Retrieve a random memory cost value
      unsigned RandCost();

      int findDest( uint64_t nmspace );
      
      unsigned getNumBlocks(uint32_t Sz);

      bool processXBGASMemRead();
      bool sendXBGASMessage();

      bool WriteMem( uint64_t Nmspace, uint64_t Addr, size_t Len, void *Data );
      bool ReadMem( uint64_t Nmspace, uint64_t Addr, size_t Len );

    }; // class RevXbgas
  } // namespace RevCPU
} // namespace SSt

#endif // _SST_REVXBGAS_H_

// EOF