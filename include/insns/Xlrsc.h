//
// _RV32X_h_
//
// Copyright (C) 2017-2024 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#ifndef _SST_REVCPU_XLRSC_H_
#define _SST_REVCPU_XLRSC_H_

#include "../RevExt.h"
#include "../RevInstHelpers.h"

namespace SST::RevCPU {

class Xlrsc : public RevExt {

  // xBGAS remote Load Resreved instruction
  template<typename XLEN>
  static bool elr( RevFeature* F, RevRegFile* R, RevMem* M, const RevInst& Inst ) {
    static_assert( std::is_unsigned_v<XLEN>, "XLEN must be unsigned integral type" );
    auto nmspace  = R->GetE<uint64_t>( Inst.rs1 );
    auto addr     = R->GetX<uint64_t>( Inst.rs1 );

    // Flags for LR memory load
    RevFlag flags = RevFlag::F_NONE;
    if( sizeof( XLEN ) < sizeof( int64_t ) && R->IsRV64 )
      RevFlagSet( flags, RevFlag::F_SEXT64 );
    if( Inst.aq )
      RevFlagSet( flags, RevFlag::F_AQ );
    if( Inst.rl )
      RevFlagSet( flags, RevFlag::F_RL );

    // Where the data will eventually end up
    void* target;
    if( sizeof( XLEN ) >= sizeof( int64_t ) || R->IsRV64 ) {
      target = &R->RV64[Inst.rd];
    } else {
      target = &R->RV32[Inst.rd];
    }

    if( nmspace == 0 ) {
      MemReq req( addr, Inst.rd, RevRegClass::RegGPR, F->GetHartToExecID(), MemOp::MemOpREADLOCK, true, R->GetMarkLoadComplete() );
      R->LSQueue->insert( req.LSQHashPair() );
      M->LR( F->GetHartToExecID(), addr, sizeof( XLEN ), target, req, flags );
    } else {
      // Send load-reserve (Remote READLOCK) request to the remote node
      RmtMemReq req(
        nmspace, addr, Inst.rd, RevRegClass::RegGPR, F->GetHartToExecID(), RmtMemOp::READLOCKRqst, true, R->GetMarkRmtLoadComplete()
      );
      R->RmtLSQueue->insert( req.LSQHashPair() );
      M->RmtLR( F->GetHartToExecID(), nmspace, addr, sizeof( XLEN ), target, req, flags );
    }

    R->cost += M->RandCost( F->GetMinCost(), F->GetMaxCost() );
    R->AdvancePC( Inst );
    return true;
  }

  // xBGAS remote Store Conditional instruction
  template<typename XLEN>
  static bool esc( RevFeature* F, RevRegFile* R, RevMem* M, const RevInst& Inst ) {
    static_assert( std::is_unsigned_v<XLEN>, "TYPE must be unsigned integral type" );
    auto nmspace  = R->GetE<uint64_t>( Inst.rs1 );
    auto addr     = R->GetX<uint64_t>( Inst.rs1 );
    auto val      = R->GetX<XLEN>( Inst.rs2 );

    // Flags for SC Store Conditional
    RevFlag flags = RevFlag::F_NONE;
    if( Inst.aq )
      RevFlagSet( flags, RevFlag::F_AQ );
    if( Inst.rl )
      RevFlagSet( flags, RevFlag::F_RL );

    // Where the data will eventually end up
    void* target;
    if( sizeof( XLEN ) >= sizeof( int64_t ) || R->IsRV64 ) {
      target = &R->RV64[Inst.rd];
    } else {
      target = &R->RV32[Inst.rd];
    }

    if( nmspace == 0 ) {
      bool sc = M->SC( F->GetHartToExecID(), addr, sizeof( XLEN ), &val, flags );
      R->SetX( Inst.rd, !sc );
    } else {
      RmtMemReq req(
        nmspace,
        addr,
        Inst.rd,
        RevRegClass::RegGPR,
        F->GetHartToExecID(),
        RmtMemOp::WRITEUNLOCKRqst,
        true,
        R->GetMarkRmtLoadComplete()
      );
      R->RmtLSQueue->insert( req.LSQHashPair() );
      // Send store-conditional request to the remote node
      M->RmtSC( F->GetHartToExecID(), nmspace, addr, sizeof( XLEN ), &val, target, req, flags );
    }
    R->AdvancePC( Inst );
    return true;
  }

  static constexpr auto& elrw = elr<uint32_t>;
  static constexpr auto& escw = esc<uint32_t>;
  static constexpr auto& elrd = elr<uint64_t>;
  static constexpr auto& escd = esc<uint64_t>;

  // ----------------------------------------------------------------------
  //
  // RISC-V RV32Xlrsc Instructions
  //
  // ----------------------------------------------------------------------

  struct XlrscInstDefaults : RevInstDefaults {
    XlrscInstDefaults() { SetOpcode( 0b1101011 ); }
  };

  // clang-format off
  std::vector<RevInstEntry> XlrscTable = {
    // Remote Atomic operations
    XlrscInstDefaults().SetMnemonic("elr.w %rd, (%rs1)"            ).SetFunct3( 0b010 ).SetFunct2or7(0b0000010).Setrs2Class(RevRegClass::RegUNKNOWN).SetImplFunc( elrw ),
    XlrscInstDefaults().SetMnemonic("esc.w %rd, %rs1, %rs2"        ).SetFunct3( 0b010 ).SetFunct2or7(0b0000011).SetImplFunc( escw ),
  };

  std::vector<RevInstEntry> RV64XlrscTable() { return {
    XlrscInstDefaults().SetMnemonic("elr.d %rd, (%rs1)"            ).SetFunct3( 0b011 ).SetFunct2or7(0b0000010).Setrs2Class(RevRegClass::RegUNKNOWN).SetImplFunc( elrd ),
    XlrscInstDefaults().SetMnemonic("esc.d %rd, %rs1, %rs2"        ).SetFunct3( 0b011 ).SetFunct2or7(0b0000011).SetImplFunc( escd ),
  }; }

  // clang-format on

public:
  /// Xlrsc: standard constructor
  Xlrsc( RevFeature* Feature, RevMem* RevMem, SST::Output* Output ) : RevExt( "Xlrsc", Feature, RevMem, Output ) {
    if( Feature->IsRV64() ) {
      auto Table{ RV64XlrscTable() };
      XlrscTable.insert( XlrscTable.end(), std::move_iterator( Table.begin() ), std::move_iterator( Table.end() ) );
    }
    SetTable( std::move( XlrscTable ) );
  }

};  // end class Xlrsc

}  // namespace SST::RevCPU

#endif
