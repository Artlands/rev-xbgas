//
// _RevHart_h_
//
// Copyright (C) 2017-2024 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#ifndef _SST_REVCPU_REVHART_H_
#define _SST_REVCPU_REVHART_H_

// -- SST Headers
#include "RevSysCalls.h"
#include "RevThread.h"
#include "SST.h"

namespace SST::RevCPU {

class RevHart {
  ///< RevHart: Id for the Hart (0,1,2,3,etc)
  unsigned ID{};

  ///< RevHart: State management object when a Hart is executing a system call
  EcallState Ecall{};

  ///< RevHart: Pointer to the Proc's LSQueue
  const std::shared_ptr<std::unordered_multimap<uint64_t, MemReq>>& LSQueue;

  ///< RevHart: Pointer to the Proc's RmtLSQueue for xBGAS
  const std::shared_ptr<std::unordered_multimap<uint64_t, RmtMemReq>>& RmtLSQueue;

  ///< RevHart: Pointer to the Proc's MarkLoadCompleteFunc
  std::function<void( const MemReq& )> MarkLoadCompleteFunc{};

  ///< RevHart: Pointer to the Proc's MarkRmtOpCompleteFunc for xBGAS
  std::function<void( const RmtMemReq& )> MarkRmtOpCompleteFunc{};

  ///< RevHart: Thread currently executing on this Hart
  std::unique_ptr<RevThread>  Thread  = nullptr;
  std::unique_ptr<RevRegFile> RegFile = nullptr;

  ///< RevHart: Make RevCore a friend of this
  friend class RevCore;

public:
  ///< RevHart: Constructor
  RevHart(
    unsigned                                                             ID,
    const std::shared_ptr<std::unordered_multimap<uint64_t, MemReq>>&    LSQueue,
    const std::shared_ptr<std::unordered_multimap<uint64_t, RmtMemReq>>& RmtLSQueue,
    std::function<void( const MemReq& )>                                 MarkLoadCompleteFunc,
    std::function<void( const RmtMemReq& )>                              MarkRmtOpCompleteFunc
  )
    : ID( ID ), LSQueue( LSQueue ), RmtLSQueue( RmtLSQueue ), MarkLoadCompleteFunc( std::move( MarkLoadCompleteFunc ) ),
      MarkRmtOpCompleteFunc( std::move( MarkRmtOpCompleteFunc ) ) {}

  ///< RevHart: Destructor
  ~RevHart() = default;

  ///< RevHart: Get the EcallState
  EcallState& GetEcallState() { return Ecall; }

  const EcallState& GetEcallState() const { return Ecall; }

  ///< RevHart: Get Hart's ID
  uint16_t GetID() const { return ID; }

  ///< RevHart: Returns the ID of the assigned thread
  uint32_t GetAssignedThreadID() const { return Thread ? Thread->GetID() : _INVALID_TID_; }

  ///< RevHart: Load the register file from the RevThread
  void LoadRegFile( std::unique_ptr<RevRegFile> regFile ) {
    RegFile = std::move( regFile );
    RegFile->SetMarkLoadComplete( MarkLoadCompleteFunc );
    RegFile->SetMarkRmtOpComplete( MarkRmtOpCompleteFunc );
    RegFile->SetLSQueue( LSQueue );
    RegFile->SetRmtLSQueue( RmtLSQueue );
  }

  ///< RevHart: Assigns a RevThread to this Hart
  void AssignThread( std::unique_ptr<RevThread> ThreadToAssign ) {
    Thread = std::move( ThreadToAssign );
    Thread->SetState( ThreadState::RUNNING );
    LoadRegFile( Thread->TransferVirtRegState() );
  }

  ///< RevHart: Removed a RevThread from this Hart
  std::unique_ptr<RevThread> PopThread() {
    // return the register file to the thread
    Thread->UpdateVirtRegState( std::move( RegFile ) );
    // return the thread
    return std::move( Thread );
  }
};  // class RevHart

}  // namespace SST::RevCPU
#endif
