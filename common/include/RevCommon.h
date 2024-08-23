//
// _Rev_Common_h_
//
// Copyright (C) 2017-2024 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#ifndef __REV_COMMON__
#define __REV_COMMON__

#include <cstddef>
#include <cstdint>
#include <functional>
#include <ostream>
#include <type_traits>
#include <utility>

#ifndef _REV_NUM_REGS_
#define _REV_NUM_REGS_ 32
#endif

#ifndef _REV_INVALID_HART_ID_
#define _REV_INVALID_HART_ID_ ( unsigned( ~0 ) )
#endif

#define _INVALID_ADDR_   ( ~uint64_t{ 0 } )

#define _INVALID_TID_    ( uint32_t{ 0 } )

#define _MAX_HARTS_      4096

// FNV-1a 64-bit hash constants
#define FNV_OFFSET_BASIS 0xcbf29ce484222325
#define FNV_PRIME        0x100000001b3

namespace SST::RevCPU {

// using float16 = _Float16;

/// Zero-extend value of bits size
template<typename T>
constexpr auto ZeroExt( T val, size_t bits ) {
  return static_cast<std::make_unsigned_t<T>>( val ) & ~( ~std::make_unsigned_t<T>{ 0 } << bits );
}

/// Sign-extend value of bits size
template<typename T>
constexpr auto SignExt( T val, size_t bits ) {
  auto signbit = std::make_unsigned_t<T>{ 1 } << ( bits - 1 );
  return static_cast<std::make_signed_t<T>>( ( ZeroExt( val, bits ) ^ signbit ) - signbit );
}

/// Base-2 logarithm of integers
template<typename T>
constexpr int lg( T x ) {
  static_assert( std::is_integral_v<T> );

  // We select the __builtin_clz which takes integers no smaller than x
  if constexpr( sizeof( x ) <= sizeof( int ) ) {
    return x ? 8 * sizeof( int ) - 1 - __builtin_clz( x ) : -1;
  } else if constexpr( sizeof( x ) <= sizeof( long ) ) {
    return x ? 8 * sizeof( long ) - 1 - __builtin_clzl( x ) : -1;
  } else {
    return x ? 8 * sizeof( long long ) - 1 - __builtin_clzll( x ) : -1;
  }
}

enum class RevRegClass : uint8_t {  ///< Rev CPU Register Classes
  RegUNKNOWN = 0,                   ///< RevRegClass: Unknown register file
  RegIMM     = 1,                   ///< RevRegClass: Treat the reg class like an immediate: S-Format
  RegGPR     = 2,                   ///< RevRegClass: GPR reg file
  RegCSR     = 3,                   ///< RevRegClass: CSR reg file
  RegFLOAT   = 4,                   ///< RevRegClass: Float register file
};

enum class MemOp : uint8_t {
  MemOpREAD        = 0,
  MemOpWRITE       = 1,
  MemOpFLUSH       = 2,
  MemOpREADLOCK    = 3,
  MemOpWRITEUNLOCK = 4,
  MemOpLOADLINK    = 5,
  MemOpSTORECOND   = 6,
  MemOpCUSTOM      = 7,
  MemOpFENCE       = 8,
  MemOpAMO         = 9,
};

enum class RmtMemOp : uint8_t {
  READRqst        = 0,   ///< xbgasNicEvent: READ request
  BulkREADRqst    = 1,   ///< xbgasNicEvent: Bulk READ request
  WRITERqst       = 2,   ///< xbgasNicEvent: WRITE request
  BulkWRITERqst   = 3,   ///< xbgasNicEvent: Bulk WRITE request
  READResp        = 4,   ///< xbgasNicEvent: READ response
  BulkREADResp    = 5,   ///< xbgasNicEvent: Bulk READ response
  WRITEResp       = 6,   ///< xbgasNicEvent: WRITE response
  BulkWRITEResp   = 7,   ///< xbgasNicEvent: Bulk WRITE response
  READLOCKRqst    = 8,   ///< xbgasNicEvent: Load-reserved request
  WRITEUNLOCKRqst = 9,   ///< xbgasNicEvent: Store-conditional request
  READLOCKResp    = 10,  ///< xbgasNicEvent: Load-reserved response
  WRITEUNLOCKResp = 11,  ///< xbgasNicEvent: Store-conditional response
  AMORqst         = 12,  ///< xbgasNicEvent: Atomic Memory Operation request
  AMOResp         = 13,  ///< xbgasNicEvent: Atomic Memory Operation response
  FENCE           = 14,  ///< xbgasNicEvent: Fence operation
  Finish          = 15,  ///< xbgasNicEvent: Finish notification
  Unknown         = 16   ///< xbgasNicEvent: Unknown operation
};

std::ostream& operator<<( std::ostream& os, MemOp op );

template<typename T>
constexpr uint64_t LSQHash( T DestReg, RevRegClass RegType, unsigned Hart ) {
  return static_cast<uint64_t>( RegType ) << ( 16 + 8 ) | static_cast<uint64_t>( DestReg ) << 16 | Hart;
}

constexpr uint64_t RmtOpIDHash( uint32_t SrcId, uint32_t PktId ) {
  return static_cast<uint64_t>( SrcId ) << 32 | PktId;
}

constexpr uint64_t fnv1a_hash( uint64_t hash, const void* data, size_t len ) {
  const unsigned char* bytes = (const unsigned char*) data;
  for( size_t i = 0; i < len; ++i ) {
    hash ^= (uint64_t) bytes[i];
    hash *= FNV_PRIME;
  }
  return hash;
}

constexpr uint64_t LocalReadHash( uint64_t Nmspace, uint64_t SrcAddr, size_t Size, uint32_t Nelem, uint32_t Stride ) {
  uint64_t hash = FNV_OFFSET_BASIS;
  hash          = fnv1a_hash( hash, &Nmspace, sizeof( Nmspace ) );
  hash          = fnv1a_hash( hash, &SrcAddr, sizeof( SrcAddr ) );
  hash          = fnv1a_hash( hash, &Size, sizeof( Size ) );
  hash          = fnv1a_hash( hash, &Nelem, sizeof( Nelem ) );
  hash          = fnv1a_hash( hash, &Stride, sizeof( Stride ) );
  return hash;
}

constexpr uint64_t HartHash( unsigned virtualHart, unsigned Hart, uint32_t SrcId ) {
  uint64_t hash = FNV_OFFSET_BASIS;
  hash          = fnv1a_hash( hash, &virtualHart, sizeof( virtualHart ) );
  hash          = fnv1a_hash( hash, &Hart, sizeof( Hart ) );
  hash          = fnv1a_hash( hash, &SrcId, sizeof( SrcId ) );
  return hash;
}

struct MemReq {
  MemReq()                           = default;
  MemReq( const MemReq& )            = default;
  MemReq( MemReq&& )                 = default;
  MemReq& operator=( const MemReq& ) = default;
  MemReq& operator=( MemReq&& )      = default;
  ~MemReq()                          = default;

  template<typename T>
  MemReq(
    uint64_t                             Addr,
    T                                    DestReg,
    RevRegClass                          RegType,
    unsigned                             Hart,
    MemOp                                ReqType,
    bool                                 isOutstanding,
    std::function<void( const MemReq& )> MarkLoadCompleteFunc
  )
    : Addr( Addr ), DestReg( uint16_t( DestReg ) ), RegType( RegType ), Hart( Hart ), ReqType( ReqType ),
      isOutstanding( isOutstanding ), MarkLoadCompleteFunc( std::move( MarkLoadCompleteFunc ) ) {}

  void MarkLoadComplete() const { MarkLoadCompleteFunc( *this ); }

  auto LSQHash() const { return SST::RevCPU::LSQHash( DestReg, RegType, Hart ); }

  auto LSQHashPair() const { return std::make_pair( LSQHash(), *this ); }

  uint64_t    Addr                                          = _INVALID_ADDR_;
  uint16_t    DestReg                                       = 0;
  RevRegClass RegType                                       = RevRegClass::RegUNKNOWN;
  unsigned    Hart                                          = _REV_INVALID_HART_ID_;
  MemOp       ReqType                                       = MemOp::MemOpCUSTOM;
  bool        isOutstanding                                 = false;

  std::function<void( const MemReq& )> MarkLoadCompleteFunc = nullptr;

};  //struct MemReq

// xBGAS remote memory request
struct RmtMemReq {
  RmtMemReq()                              = default;
  RmtMemReq( const RmtMemReq& )            = default;
  RmtMemReq( RmtMemReq&& )                 = default;
  RmtMemReq& operator=( const RmtMemReq& ) = default;
  RmtMemReq& operator=( RmtMemReq&& )      = default;
  ~RmtMemReq()                             = default;

  template<typename T>
  RmtMemReq(
    uint64_t                                Nmspace,
    uint64_t                                SrcAddr,
    uint32_t                                Nelem,
    uint32_t                                Stride,
    uint64_t                                DestAddr,
    T                                       DestReg,
    RevRegClass                             RegType,
    unsigned                                Hart,
    RmtMemOp                                ReqType,
    bool                                    isOutstanding,
    std::function<void( const RmtMemReq& )> MarkRmtLoadCompleteFunc
  )
    : Nmspace( Nmspace ), SrcAddr( SrcAddr ), Nelem( Nelem ), Stride( Stride ), DestAddr( DestAddr ),
      DestReg( uint16_t( DestReg ) ), RegType( RegType ), Hart( Hart ), ReqType( ReqType ), isOutstanding( isOutstanding ),
      MarkRmtLoadCompleteFunc( std::move( MarkRmtLoadCompleteFunc ) ) {}

  template<typename T>
  RmtMemReq(
    uint64_t                                Nmspace,
    uint64_t                                SrcAddr,
    T                                       DestReg,
    RevRegClass                             RegType,
    unsigned                                Hart,
    RmtMemOp                                ReqType,
    bool                                    isOutstanding,
    std::function<void( const RmtMemReq& )> MarkRmtLoadCompleteFunc
  )
    : Nmspace( Nmspace ), SrcAddr( SrcAddr ), DestReg( uint16_t( DestReg ) ), RegType( RegType ), Hart( Hart ), ReqType( ReqType ),
      isOutstanding( isOutstanding ), MarkRmtLoadCompleteFunc( std::move( MarkRmtLoadCompleteFunc ) ) {}

  void MarkRmtLoadComplete() const { MarkRmtLoadCompleteFunc( *this ); }

  auto LSQHash() const { return SST::RevCPU::LSQHash( DestReg, RegType, Hart ); }

  auto LSQHashPair() const { return std::make_pair( LSQHash(), *this ); }

  uint64_t    Nmspace                                             = 0;
  uint64_t    SrcAddr                                             = _INVALID_ADDR_;
  uint32_t    Nelem                                               = 1;
  uint32_t    Stride                                              = 0;
  uint64_t    DestAddr                                            = _INVALID_ADDR_;
  uint16_t    DestReg                                             = 0;
  RevRegClass RegType                                             = RevRegClass::RegUNKNOWN;
  unsigned    Hart                                                = _REV_INVALID_HART_ID_;
  RmtMemOp    ReqType                                             = RmtMemOp::Unknown;
  bool        isOutstanding                                       = false;

  std::function<void( const RmtMemReq& )> MarkRmtLoadCompleteFunc = nullptr;
};  //struct RmtMemReq

// Enum for tracking the state of a RevThread.
// Ex. Possible flow of thread state:
//    1)  New RevThread is created via rev_pthread_create (ThreadState::START)
//    2)  The Proc that created the new thread puts it in its `ThreadsThatChangedState` queue
//    3)  RevCPU sees there is a new thread in Procs[i]->ThreadsThatChangedState with status START
//    4)  RevCPU changes thread's state to READY and moves it to ReadyThreads as it can be scheduled
//    5)  Thread is scheduled on a Hart (ThreadState::RUNNING)
//    6)  Thread encounters a call to `rev_pthread_join` (ThreadState::BLOCKED)
//    7)  The Proc that owns the RevHart the thread was executing on puts the blocked thread
//        in its `ThreadsThatChangedState` queue
//    8)  RevCPU sees there is a blocked thread and moves it to BlockedThreads
//    9)  Once the thread that the blocked thread is waiting on completes, it is
//        moved back to ReadyThreads (ThreadState::READY)
//    10) Thread is done (ie. PC = 0x0) so ensure there are no dependencies
//    11) The Proc that owns the RevHart the thread was executing on puts the finished thread
//        in its ThreadsThatChangedState queue (ThreadState::DONE)
//    12) RevCPU sees there is a completed thread and moves it to its CompletedThreads map
enum class ThreadState {
  START,    // Indicates this thread is new
  RUNNING,  // Thread is assigned and executing on a Proc/HART (NOTE: This does NOT change if a Thread is stalled)
  BLOCKED,  // Waiting for thread synchronization at this point (Currently only triggered by call to `rev_pthread_join`)
  READY,    // Indicates this thread is ready to be scheduled
  DONE,     // Thread has finished; deallocate resources.
};

}  //namespace SST::RevCPU

#endif
