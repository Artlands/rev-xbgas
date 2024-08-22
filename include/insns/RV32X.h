//
// _RV32X_h_
//
// Copyright (C) 2017-2024 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#ifndef _SST_REVCPU_RV32X_H_
#define _SST_REVCPU_RV32X_H_

#include "../RevExt.h"
#include "../RevInstHelpers.h"

namespace SST::RevCPU {

class RV32X : public RevExt {

  // xBGAS remote loads
  static constexpr auto& elw   = eload<int32_t>;
  static constexpr auto& elh   = eload<int16_t>;
  static constexpr auto& elhu  = eload<uint16_t>;
  static constexpr auto& elb   = eload<int8_t>;
  static constexpr auto& elbu  = eload<uint8_t>;

  // xBGAS remote stores
  static constexpr auto& esw   = estore<uint32_t>;
  static constexpr auto& esh   = estore<uint16_t>;
  static constexpr auto& esb   = estore<uint8_t>;

  // xBGAS remote raw loads
  static constexpr auto& erlw  = erload<int32_t>;
  static constexpr auto& erlh  = erload<int16_t>;
  static constexpr auto& erlhu = erload<uint16_t>;
  static constexpr auto& erlb  = erload<int8_t>;
  static constexpr auto& erlbu = erload<uint8_t>;

  // xBGAS remote raw stores
  static constexpr auto& ersw  = erstore<uint32_t>;
  static constexpr auto& ersh  = erstore<uint16_t>;
  static constexpr auto& ersb  = erstore<uint8_t>;

  // xBGAS register operations
  static bool eaddi( RevFeature* F, RevRegFile* R, RevMem* M, const RevInst& Inst ) {
    if( R->IsRV32 ) {
      auto rs1 = R->GetE<uint32_t>( Inst.rs1 );
      R->SetX( Inst.rd, rs1 + Inst.ImmSignExt( 12 ) );
    } else {
      auto rs1 = R->GetE<uint64_t>( Inst.rs1 );
      R->SetX( Inst.rd, rs1 + Inst.ImmSignExt( 12 ) );
    }
    R->AdvancePC( Inst );
    return true;
  }

  static bool eaddie( RevFeature* F, RevRegFile* R, RevMem* M, const RevInst& Inst ) {
    if( R->IsRV32 ) {
      auto rs1 = R->GetX<uint32_t>( Inst.rs1 );
      R->SetE( Inst.rd, rs1 + Inst.ImmSignExt( 12 ) );
    } else {
      auto rs1 = R->GetX<uint64_t>( Inst.rs1 );
      R->SetE( Inst.rd, rs1 + Inst.ImmSignExt( 12 ) );
    }
    R->AdvancePC( Inst );
    return true;
  }

  static bool eaddix( RevFeature* F, RevRegFile* R, RevMem* M, const RevInst& Inst ) {
    if( R->IsRV32 ) {
      auto rs1 = R->GetX<uint32_t>( Inst.rs1 );
      R->SetE( Inst.rd, rs1 + Inst.ImmSignExt( 12 ) );
    } else {
      auto rs1 = R->GetX<uint64_t>( Inst.rs1 );
      R->SetE( Inst.rd, rs1 + Inst.ImmSignExt( 12 ) );
    }
    R->AdvancePC( Inst );
    return true;
  }

  // xBGAS remote bulk loads
  static constexpr auto& eblw  = ebload<int32_t>;
  static constexpr auto& eblh  = ebload<int16_t>;
  static constexpr auto& eblhu = ebload<uint16_t>;
  static constexpr auto& eblb  = ebload<int8_t>;
  static constexpr auto& eblbu = ebload<uint8_t>;

  // xBGAS remote bulk stores
  static constexpr auto& ebsw  = ebstore<uint32_t>;
  static constexpr auto& ebsh  = ebstore<uint16_t>;
  static constexpr auto& ebsb  = ebstore<uint8_t>;

  // xBGAS remote atomic operations
  static bool elrw( RevFeature* F, RevRegFile* R, RevMem* M, const RevInst& Inst ) {
    if( R->IsRV32 ) {
      auto Nmspace = R->GetE<uint32_t>( Inst.rs1 );
      if( Nmspace == 0 ) {
        MemReq req(
          uint64_t( R->RV32[Inst.rs1] ),
          Inst.rd,
          RevRegClass::RegGPR,
          F->GetHartToExecID(),
          MemOp::MemOpAMO,
          true,
          R->GetMarkLoadComplete()
        );
        R->LSQueue->insert( req.LSQHashPair() );
        M->LR( F->GetHartToExecID(), uint64_t( R->RV32[Inst.rs1] ), &R->RV32[Inst.rd], Inst.aq, Inst.rl, req, RevFlag::F_SEXT32 );
      } else {
        // Send load-reserve (Remote READLOCK) request to the remote node
        RmtMemReq req(
          Nmspace,
          uint64_t( R->RV32[Inst.rs1] ),
          Inst.rd,
          RevRegClass::RegGPR,
          F->GetHartToExecID(),
          RmtMemOp::READLOCKRqst,
          true,
          R->GetMarkRmtLoadComplete()
        );
        M->RmtLR(
          F->GetHartToExecID(), Nmspace, uint64_t( R->RV32[Inst.rs1] ), &R->RV32[Inst.rd], Inst.aq, Inst.rl, req, RevFlag::F_SEXT32
        );
      }
    } else {
      auto Nmspace = R->GetE<uint64_t>( Inst.rs1 );
      if( Nmspace == 0 ) {
        MemReq req(
          R->RV64[Inst.rs1], Inst.rd, RevRegClass::RegGPR, F->GetHartToExecID(), MemOp::MemOpAMO, true, R->GetMarkLoadComplete()
        );
        R->LSQueue->insert( req.LSQHashPair() );
        M->LR(
          F->GetHartToExecID(),
          R->RV64[Inst.rs1],
          reinterpret_cast<uint32_t*>( &R->RV64[Inst.rd] ),
          Inst.aq,
          Inst.rl,
          req,
          RevFlag::F_SEXT64
        );
      } else {
        // Send load-reserve (Remote READLOCK) request to the remote node
        RmtMemReq req(
          Nmspace,
          R->RV64[Inst.rs1],
          Inst.rd,
          RevRegClass::RegGPR,
          F->GetHartToExecID(),
          RmtMemOp::READLOCKRqst,
          true,
          R->GetMarkRmtLoadComplete()
        );
        M->RmtLR(
          F->GetHartToExecID(),
          Nmspace,
          R->RV64[Inst.rs1],
          reinterpret_cast<uint32_t*>( &R->RV64[Inst.rd] ),
          Inst.aq,
          Inst.rl,
          req,
          RevFlag::F_SEXT64
        );
      }
    }
    R->cost += M->RandCost( F->GetMinCost(), F->GetMaxCost() );
    R->AdvancePC( Inst );
    return true;
  }

  static bool escw( RevFeature* F, RevRegFile* R, RevMem* M, const RevInst& Inst ) {
    if( R->IsRV32 ) {
      auto Nmspace = R->GetE<uint32_t>( Inst.rs1 );
      if( Nmspace == 0 ) {
        M->SC(
          F->GetHartToExecID(), R->RV32[Inst.rs1], &R->RV32[Inst.rs2], &R->RV32[Inst.rd], Inst.aq, Inst.rl, RevFlag::F_SEXT32
        );
      } else {
        RmtMemReq req(
          Nmspace,
          R->RV32[Inst.rs1],
          Inst.rd,
          RevRegClass::RegGPR,
          F->GetHartToExecID(),
          RmtMemOp::WRITEUNLOCKRqst,
          true,
          R->GetMarkRmtLoadComplete()
        );
        // Send store-conditional request to the remote node
        M->RmtSC(
          F->GetHartToExecID(),
          Nmspace,
          R->RV32[Inst.rs1],
          &R->RV32[Inst.rs2],
          &R->RV32[Inst.rd],
          Inst.aq,
          Inst.rl,
          req,
          RevFlag::F_SEXT32
        );
      }
    } else {
      auto Nmspace = R->GetE<uint64_t>( Inst.rs1 );
      if( Nmspace == 0 ) {
        M->SC(
          F->GetHartToExecID(),
          R->RV64[Inst.rs1],
          reinterpret_cast<uint32_t*>( &R->RV64[Inst.rs2] ),
          reinterpret_cast<uint32_t*>( &R->RV64[Inst.rd] ),
          Inst.aq,
          Inst.rl,
          RevFlag::F_SEXT64
        );
      } else {
        // We use the Req data structure to update the rd register once the remote store-conditional is finished
        RmtMemReq req(
          Nmspace,
          R->RV64[Inst.rs1],
          Inst.rd,
          RevRegClass::RegGPR,
          F->GetHartToExecID(),
          RmtMemOp::WRITEUNLOCKRqst,
          true,
          R->GetMarkRmtLoadComplete()
        );
        // Send store-conditional request to the remote node
        M->RmtSC(
          F->GetHartToExecID(),
          Nmspace,
          R->RV64[Inst.rs1],
          reinterpret_cast<uint32_t*>( &R->RV64[Inst.rs2] ),
          reinterpret_cast<uint32_t*>( &R->RV64[Inst.rd] ),
          Inst.aq,
          Inst.rl,
          req,
          RevFlag::F_SEXT64
        );
      }
    }
    R->AdvancePC( Inst );
    return true;
  }

  // ----------------------------------------------------------------------
  //
  // RISC-V RV32X Instructions
  //
  // ----------------------------------------------------------------------

  // clang-format off
  std::vector<RevInstEntry> RV32XTable = {
    // Load instructions are encoded in the I-type format
    { RevInstDefaults().SetMnemonic( "elw %rd, $imm(%rs1)"         ).SetOpcode( 0b1110111 ).SetFunct3( 0b110 ).Setrs2Class( RevRegClass::RegUNKNOWN ).Setimm( FImm ).SetFormat( RVTypeI ).SetImplFunc( elw  ) },
    { RevInstDefaults().SetMnemonic( "elh %rd, $imm(%rs1)"         ).SetOpcode( 0b1110111 ).SetFunct3( 0b001 ).Setrs2Class( RevRegClass::RegUNKNOWN ).Setimm( FImm ).SetFormat( RVTypeI ).SetImplFunc( elh  ) },
    { RevInstDefaults().SetMnemonic( "elhu %rd, $imm(%rs1)"        ).SetOpcode( 0b1110111 ).SetFunct3( 0b101 ).Setrs2Class( RevRegClass::RegUNKNOWN ).Setimm( FImm ).SetFormat( RVTypeI ).SetImplFunc( elhu ) },
    { RevInstDefaults().SetMnemonic( "elb %rd, $imm(%rs1)"         ).SetOpcode( 0b1110111 ).SetFunct3( 0b000 ).Setrs2Class( RevRegClass::RegUNKNOWN ).Setimm( FImm ).SetFormat( RVTypeI ).SetImplFunc( elb  ) },
    { RevInstDefaults().SetMnemonic( "elbu %rd, $imm(%rs1)"        ).SetOpcode( 0b1110111 ).SetFunct3( 0b100 ).Setrs2Class( RevRegClass::RegUNKNOWN ).Setimm( FImm ).SetFormat( RVTypeI ).SetImplFunc( elbu ) },
    // Store instructions are encoded in the S-type format
    { RevInstDefaults().SetMnemonic( "esw %rs1, $imm(%rs2)"        ).SetOpcode( 0b1111011 ).SetFunct3( 0b110 ).SetrdClass( RevRegClass::RegUNKNOWN ).Setimm( FImm ).SetFormat( RVTypeS ).SetImplFunc( esw ) },
    { RevInstDefaults().SetMnemonic( "esh %rs1, $imm(%rs2)"        ).SetOpcode( 0b1111011 ).SetFunct3( 0b001 ).SetrdClass( RevRegClass::RegUNKNOWN ).Setimm( FImm ).SetFormat( RVTypeS ).SetImplFunc( esh ) },
    { RevInstDefaults().SetMnemonic( "esb %rs1, $imm(%rs2)"        ).SetOpcode( 0b1111011 ).SetFunct3( 0b000 ).SetrdClass( RevRegClass::RegUNKNOWN ).Setimm( FImm ).SetFormat( RVTypeS ).SetImplFunc( esb ) },
    // Raw Load instructions are encoded in the R-type format
    { RevInstDefaults().SetMnemonic( "erlw %rd, %rs1, %ext2"       ).SetOpcode( 0b0110011 ).SetFunct3( 0b110 ).SetFunct2or7( 0b1010110 ).SetFormat( RVTypeR ).SetImplFunc( erlw  ) },
    { RevInstDefaults().SetMnemonic( "erlh %rd, %rs1, %ext2"       ).SetOpcode( 0b0110011 ).SetFunct3( 0b001 ).SetFunct2or7( 0b1010110 ).SetFormat( RVTypeR ).SetImplFunc( erlh  ) },
    { RevInstDefaults().SetMnemonic( "erlhu %rd, %rs1, %ext2"      ).SetOpcode( 0b0110011 ).SetFunct3( 0b101 ).SetFunct2or7( 0b1010110 ).SetFormat( RVTypeR ).SetImplFunc( erlhu ) },
    { RevInstDefaults().SetMnemonic( "erlb %rd, %rs1, %ext2"       ).SetOpcode( 0b0110011 ).SetFunct3( 0b000 ).SetFunct2or7( 0b1010110 ).SetFormat( RVTypeR ).SetImplFunc( erlb  ) },
    { RevInstDefaults().SetMnemonic( "erlbu %rd, %rs1, %ext2"      ).SetOpcode( 0b0110011 ).SetFunct3( 0b100 ).SetFunct2or7( 0b1010110 ).SetFormat( RVTypeR ).SetImplFunc( erlbu ) },
    // Raw Store instructions are encoded in the R-type format
    { RevInstDefaults().SetMnemonic( "ersw %rs1, %rs2, %ext3"      ).SetOpcode( 0b0110011 ).SetFunct3( 0b110 ).SetFunct2or7( 0b0100010 ).SetFormat( RVTypeR ).SetImplFunc( ersw ) },
    { RevInstDefaults().SetMnemonic( "ersh %rs1, %rs2, %ext3"      ).SetOpcode( 0b0110011 ).SetFunct3( 0b001 ).SetFunct2or7( 0b0100010 ).SetFormat( RVTypeR ).SetImplFunc( ersh ) },
    { RevInstDefaults().SetMnemonic( "ersb %rs1, %rs2, %ext3"      ).SetOpcode( 0b0110011 ).SetFunct3( 0b000 ).SetFunct2or7( 0b0100010 ).SetFormat( RVTypeR ).SetImplFunc( ersb ) },
    // Address Management Instructions are encoded in the I-type format
    { RevInstDefaults().SetMnemonic( "eaddi %rd, %ext1, $imm"      ).SetOpcode( 0b1111011 ).SetFunct3( 0b010 ).Setrs2Class( RevRegClass::RegUNKNOWN ).Setimm( FImm ).SetFormat( RVTypeI ).SetImplFunc( eaddi  ) },
    { RevInstDefaults().SetMnemonic( "eaddie %extd, %rs1, $imm"    ).SetOpcode( 0b1111011 ).SetFunct3( 0b101 ).Setrs2Class( RevRegClass::RegUNKNOWN ).Setimm( FImm ).SetFormat( RVTypeI ).SetImplFunc( eaddie ) },
    { RevInstDefaults().SetMnemonic( "eaddix %extd, %ext1, $imm"   ).SetOpcode( 0b1111011 ).SetFunct3( 0b100 ).Setrs2Class( RevRegClass::RegUNKNOWN ).Setimm( FImm ).SetFormat( RVTypeI ).SetImplFunc( eaddix ) },
    // Bulk Load instruction is encoded in the R4-type format
    { RevInstDefaults().SetMnemonic( "eblw  %rd, %rs1, %rs2, %rs3" ).SetOpcode( 0b1011011 ).SetFunct3( 0b110 ).SetFunct2or7( 0b11 ).Setrs3Class( RevRegClass::RegGPR ).SetFormat( RVTypeR4 ).SetImplFunc( eblw  ) },
    { RevInstDefaults().SetMnemonic( "eblh  %rd, %rs1, %rs2, %rs3" ).SetOpcode( 0b1011011 ).SetFunct3( 0b001 ).SetFunct2or7( 0b11 ).Setrs3Class( RevRegClass::RegGPR ).SetFormat( RVTypeR4 ).SetImplFunc( eblh  ) },
    { RevInstDefaults().SetMnemonic( "eblhu %rd, %rs1, %rs2, %rs3" ).SetOpcode( 0b1011011 ).SetFunct3( 0b101 ).SetFunct2or7( 0b11 ).Setrs3Class( RevRegClass::RegGPR ).SetFormat( RVTypeR4 ).SetImplFunc( eblhu ) },
    { RevInstDefaults().SetMnemonic( "eblb  %rd, %rs1, %rs2, %rs3" ).SetOpcode( 0b1011011 ).SetFunct3( 0b000 ).SetFunct2or7( 0b11 ).Setrs3Class( RevRegClass::RegGPR ).SetFormat( RVTypeR4 ).SetImplFunc( eblb  ) },
    { RevInstDefaults().SetMnemonic( "eblbu %rd, %rs1, %rs2, %rs3" ).SetOpcode( 0b1011011 ).SetFunct3( 0b100 ).SetFunct2or7( 0b11 ).Setrs3Class( RevRegClass::RegGPR ).SetFormat( RVTypeR4 ).SetImplFunc( eblbu ) },
    // Bulk Store instruction is encoded in the R4-type format
    { RevInstDefaults().SetMnemonic( "ebsw  %rd, %rs1, %rs2, %rs3" ).SetOpcode( 0b1011011 ).SetFunct3( 0b110 ).SetFunct2or7( 0b10 ).Setrs3Class( RevRegClass::RegGPR ).SetFormat( RVTypeR4 ).SetImplFunc( ebsw ) },
    { RevInstDefaults().SetMnemonic( "ebsh  %rd, %rs1, %rs2, %rs3" ).SetOpcode( 0b1011011 ).SetFunct3( 0b001 ).SetFunct2or7( 0b10 ).Setrs3Class( RevRegClass::RegGPR ).SetFormat( RVTypeR4 ).SetImplFunc( ebsh ) },
    { RevInstDefaults().SetMnemonic( "ebsb  %rd, %rs1, %rs2, %rs3" ).SetOpcode( 0b1011011 ).SetFunct3( 0b000 ).SetFunct2or7( 0b10 ).Setrs3Class( RevRegClass::RegGPR ).SetFormat( RVTypeR4 ).SetImplFunc( ebsb ) },
    // Remote Atomic operations
    { RevInstDefaults().SetMnemonic("elr.w %rd, (%rs1)"            ).SetOpcode( 0b1101011 ).SetFunct3( 0b010 ).SetFunct2or7(0b0000010).Setrs2Class(RevRegClass::RegUNKNOWN).SetImplFunc( elrw ) },
    { RevInstDefaults().SetMnemonic("esc.w %rd, %rs1, %rs2"        ).SetOpcode( 0b1101011 ).SetFunct3( 0b010 ).SetFunct2or7(0b0000011).SetImplFunc( escw ) },

  };
  // clang-format on

public:
  /// RV32X: standard constructor
  RV32X( RevFeature* Feature, RevMem* RevMem, SST::Output* Output ) : RevExt( "RV32X", Feature, RevMem, Output ) {
    SetTable( std::move( RV32XTable ) );
  }

};  // end class RV32X
}  // namespace SST::RevCPU

#endif
