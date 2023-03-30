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

      /// RevXbgas: NLB initialization
      void initXbgasMem(xbgasNicAPI *XNic);
      
      /// RevXbgas: check finish status
      bool isFinished();

      /// RevXbgas: clock function
      void clockTick(Cycle_t currentCycle, unsigned msgPerCycle );
      
      // void clockTickTest(Cycle_t currentCycle);
      // void clockTickWriteTest(Cycle_t currentCycle);
      // void clockTickReadTest(Cycle_t currentCycle);

      bool checkGetRequests( uint64_t Nmspace, uint64_t Addr, uint8_t *Tag );

      bool checkDmaResponses( uint8_t Tag );

      bool readGetResponses( uint8_t Tag, void *Data );

      bool checkTrackTags () { return TrackTags.empty();}

      // Remote memory operation interfaces
      void WriteU8( uint64_t Nmspace, uint64_t Addr, uint8_t Value);
      void WriteU16( uint64_t Nmspace, uint64_t Addr, uint16_t Value);
      void WriteU32( uint64_t Nmspace, uint64_t Addr, uint32_t Value);
      void WriteU64( uint64_t Nmspace, uint64_t Addr, uint64_t Value);
      void WriteFloat( uint64_t Nmspace, uint64_t Addr, float Value);
      void WriteDouble( uint64_t Nmspace, uint64_t Addr, double Value);

      // Bulk write
      void WriteBulkU8( uint64_t Nmspace, uint64_t DestAddr, 
                        uint32_t Nelem, uint32_t Stride, uint64_t SrcAddr);
      void WriteBulkU16( uint64_t Nmspace, uint64_t DestAddr, 
                         uint32_t Nelem, uint32_t Stride, uint64_t SrcAddr);
      void WriteBulkU32( uint64_t Nmspace, uint64_t DestAddr, 
                         uint32_t Nelem, uint32_t Stride, uint64_t SrcAddr);
      void WriteBulkU64( uint64_t Nmspace, uint64_t DestAddr, 
                         uint32_t Nelem, uint32_t Stride, uint64_t SrcAddr);
      void WriteBulkFloat( uint64_t Nmspace, uint64_t DestAddr, 
                           uint32_t Nelem, uint32_t Stride, uint64_t SrcAddr);
      void WriteBulkDouble( uint64_t Nmspace, uint64_t DestAddr, 
                            uint32_t Nelem, uint32_t Stride, uint64_t SrcAddr);

      void ReadU8( uint64_t Nmspace, uint64_t Addr );
      void ReadU16( uint64_t Nmspace, uint64_t Addr );
      void ReadU32( uint64_t Nmspace, uint64_t Addr );
      void ReadU64( uint64_t Nmspace, uint64_t Addr );
      void ReadFloat( uint64_t Nmspace, uint64_t Addr );
      void ReadDouble( uint64_t Nmspace, uint64_t Addr );

      // Bulk read
      void ReadBulkU8( uint64_t Nmspace, uint64_t SrcAddr, 
                       uint32_t Nelem, uint32_t Stride, uint64_t DestAddr);
      void ReadBulkU16( uint64_t Nmspace, uint64_t SrcAddr, 
                       uint32_t Nelem, uint32_t Stride, uint64_t DestAddr);
      void ReadBulkU32( uint64_t Nmspace, uint64_t SrcAddr, 
                        uint32_t Nelem, uint32_t Stride, uint64_t DestAddr);
      void ReadBulkU64( uint64_t Nmspace, uint64_t SrcAddr, 
                        uint32_t Nelem, uint32_t Stride, uint64_t DestAddr);
      void ReadBulkFloat( uint64_t Nmspace, uint64_t SrcAddr, 
                          uint32_t Nelem, uint32_t Stride, uint64_t DestAddr);
      void ReadBulkDouble( uint64_t Nmspace, uint64_t SrcAddr, 
                           uint32_t Nelem, uint32_t Stride, uint64_t DestAddr);

      class RevXbgasStats{
        public:
          uint64_t remoteGet;
          uint64_t remotePut;
          uint64_t remoteMemoryRead;
          uint64_t remoteMemoryWrite;
      };

      RevXbgasStats GetStats() {return Stats;}
      SST::Cycle_t GetCurrentCycle() {return currentCycleTmp;}
    private:
      xbgasNicAPI *xnic;                              ///< RevXbgas: XbgasNic object
      RevOpts *opts;                                  ///< RevXbgas: options object
      RevMem *mem;                                    ///< RevXbgas: memory object
      RevXbgasStats Stats;                            ///< RevXbgas: statistics object
      SST::Output *output;                            ///< RevXbgas: output handler
      // unsigned testStage;                          ///< RevXbgas: controls the XBGAS Test harness staging
      SST::Cycle_t currentCycleTmp;                   ///< RevXbgas: temporary variable for current cycle
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
      
      std::vector<uint8_t> DmaResponses;              ///< RevXbgas: tracks the DMA responses; Tags exist in the vector if the corresponding DMA operations finished. 
      std::vector<std::tuple<uint8_t,
                             unsigned,
                             uint32_t,
                             uint32_t,
                             uint32_t,
                             int,
                             uint64_t,
                             bool,
                             uint64_t>> ReadQueue;    ///< RevXbgas: xbgas remote memory requests queue
                                                      ///<        - Tag
                                                      ///<        - Cost
                                                      ///<        - Size
                                                      ///<        - Nelem
                                                      ///<        - Stride
                                                      ///<        - Src
                                                      ///<        - Addr
                                                      ///<        - DmaFlag
                                                      ///<        - DmaDestAddr

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

      bool WriteMem( uint64_t Nmspace, uint64_t Addr, size_t Len, 
                     uint32_t Nelem, uint32_t Stride, 
                     bool Dma, void *Data);
      bool ReadMem( uint64_t Nmspace, uint64_t Addr, size_t Len, 
                    uint32_t Nelem, uint32_t Stride, 
                    bool Dma, uint64_t DmaDestAddr);

      // /// RevXbgas: execute tests
      // void execReadTest();
      // void execWriteTest();

    }; // class RevXbgas
  } // namespace RevCPU
} // namespace SSt

#endif // _SST_REVXBGAS_H_

// EOF