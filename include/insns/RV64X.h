//
// _RV64X_h_
//
// Copyright (C) 2017-2024 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#ifndef _SST_REVCPU_RV64X_H_
#define _SST_REVCPU_RV64X_H_

#include "../RevExt.h"
#include "../RevInstHelpers.h"

namespace SST::RevCPU {

class RV64X : public RevExt {

  // static bool elrd(RevFeature *F, RevRegFile *R, RevMem *M, const RevInst& Inst) {
  //   RmtMemReq req(
  //     R->RV64(Inst.rs1), Inst.rd, RevRegClass::RegGPR, F->GetHartToExecID(), MemOp::MemOpAMO, true, R->GetMarkLoadComplete()
  //   );
  //   R->LSQueue->insert(req.LSQHashPair());
  //   M->LR(F->GetHartToExecID(), R->RV64(Inst.rs1), &R->RV64[Inst.rd], Inst.aq, Inst.rl, req, RevFlag::F_SEXT64);
  //   R->AdvancePC(Inst);
  //   return true;
  // }

  // xBGAS remote loads
  static constexpr auto& eld = eload<int64_t>;

  static bool ele( RevFeature* F, RevRegFile* R, RevMem* M, const RevInst& Inst ) { return true; }

  // xBGAS remote stores
  static constexpr auto& esd = estore<uint64_t>;

  static bool ese( RevFeature* F, RevRegFile* R, RevMem* M, const RevInst& Inst ) { return true; }

  // xBGAS remote raw loads
  static constexpr auto& erld = erload<int64_t>;

  static bool erle( RevFeature* F, RevRegFile* R, RevMem* M, const RevInst& Inst ) { return true; }

  // xBGAS remote raw stores
  static constexpr auto& ersd = erstore<uint64_t>;

  static bool erse( RevFeature* F, RevRegFile* R, RevMem* M, const RevInst& Inst ) { return true; }

  // xBGAS remote bulk loads
  static constexpr auto& ebld = ebload<int64_t>;

  // xBGAS remote bulk stores
  static constexpr auto& ebsd = ebstore<uint64_t>;

  // xBGAS remote atomic operations
  static bool elrd( RevFeature* F, RevRegFile* R, RevMem* M, const RevInst& Inst ) {
    auto Nmspace = R->GetE<uint64_t>( Inst.rs1 );
    if( Nmspace == 0 ) {
      MemReq req(
        R->RV64[Inst.rs1], Inst.rd, RevRegClass::RegGPR, F->GetHartToExecID(), MemOp::MemOpAMO, true, R->GetMarkLoadComplete()
      );
      R->LSQueue->insert( req.LSQHashPair() );
      M->LR( F->GetHartToExecID(), R->RV64[Inst.rs1], &R->RV64[Inst.rd], Inst.aq, Inst.rl, req, RevFlag::F_SEXT64 );
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
      R->RmtLSQueue->insert( req.LSQHashPair() );
      M->RmtLR( F->GetHartToExecID(), Nmspace, R->RV64[Inst.rs1], &R->RV64[Inst.rd], Inst.aq, Inst.rl, req, RevFlag::F_SEXT64 );
    }
    R->cost += M->RandCost( F->GetMinCost(), F->GetMaxCost() );
    R->AdvancePC( Inst );
    return true;
  }

  static bool escd( RevFeature* F, RevRegFile* R, RevMem* M, const RevInst& Inst ) {
    auto Nmspace = R->GetE<uint64_t>( Inst.rs1 );
    if( Nmspace == 0 ) {
      M->SC( F->GetHartToExecID(), R->RV64[Inst.rs1], &R->RV64[Inst.rs2], &R->RV64[Inst.rd], Inst.aq, Inst.rl, RevFlag::F_SEXT64 );
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
      R->RmtLSQueue->insert( req.LSQHashPair() );
      // Send store-conditional request to the remote node
      M->RmtSC(
        F->GetHartToExecID(),
        Nmspace,
        R->RV64[Inst.rs1],
        &R->RV64[Inst.rs2],
        &R->RV64[Inst.rd],
        Inst.aq,
        Inst.rl,
        req,
        RevFlag::F_SEXT64
      );
    }
    R->AdvancePC( Inst );
    return true;
  }

  // ----------------------------------------------------------------------
  //
  // RISC-V RV64X Instructions
  //
  // ----------------------------------------------------------------------
  // clang-format off
  std::vector<RevInstEntry> RV64XTable = {
    // Load instructions are encoded in the I-type format
    { RevInstDefaults().SetMnemonic( "eld %rd, $imm(%rs1)"         ).SetOpcode( 0b1110111 ).SetFunct3( 0b011 ).Setrs2Class( RevRegClass::RegUNKNOWN ).Setimm( FImm ).SetFormat( RVTypeI ).SetImplFunc( eld ) },
    { RevInstDefaults().SetMnemonic( "ele %extd, $imm(%rs1)"       ).SetOpcode( 0b1110111 ).SetFunct3( 0b111 ).Setrs2Class( RevRegClass::RegUNKNOWN ).Setimm( FImm ).SetFormat( RVTypeI ).SetImplFunc( ele ) },
    // Store instructions are encoded in the S-type format
    { RevInstDefaults().SetMnemonic( "esd %rs1, $imm(%rs2)"        ).SetOpcode( 0b1111011 ).SetFunct3( 0b011 ).SetrdClass( RevRegClass::RegUNKNOWN ).Setimm( FImm ).SetFormat( RVTypeS ).SetImplFunc( esd ) },
    { RevInstDefaults().SetMnemonic( "ese %ext1, $imm(%rs2)"       ).SetOpcode( 0b1111011 ).SetFunct3( 0b111 ).SetrdClass( RevRegClass::RegUNKNOWN ).Setimm( FImm ).SetFormat( RVTypeS ).SetImplFunc( ese ) },
    // Raw Load instructions are encoded in the R-type format
    { RevInstDefaults().SetMnemonic( "erld %rd, %rs1, %ext2"       ).SetOpcode( 0b0110011 ).SetFunct3( 0b011 ).SetFunct2or7( 0b1010110 ).SetFormat( RVTypeR ).SetImplFunc( erld ) },
    { RevInstDefaults().SetMnemonic( "erle %extd, %rs1, %ext2"     ).SetOpcode( 0b0110011 ).SetFunct3( 0b111 ).SetFunct2or7( 0b1010110 ).SetrdClass( RevRegClass::RegUNKNOWN ).SetFormat( RVTypeR ).SetImplFunc( erle ) },
    // Raw Store instructions are encoded in the R-type format
    { RevInstDefaults().SetMnemonic( "ersd %rs1, %rs2, %ext3"      ).SetOpcode( 0b0110011 ).SetFunct3( 0b011 ).SetFunct2or7( 0b0100010 ).SetFormat( RVTypeR ).SetImplFunc( ersd ) },
    { RevInstDefaults().SetMnemonic( "erse %ext1, %rs2, %ext3"     ).SetOpcode( 0b0110011 ).SetFunct3( 0b111 ).SetFunct2or7( 0b0100011 ).SetFormat( RVTypeR ).SetImplFunc( erse ) },
    // Bulk Load instruction is encoded in the R4-type format
    { RevInstDefaults().SetMnemonic( "ebld  %rd, %rs1, %rs2, %rs3" ).SetOpcode( 0b1011011 ).SetFunct3( 0b011 ).SetFunct2or7( 0b11 ).Setrs3Class( RevRegClass::RegGPR ).SetFormat( RVTypeR4 ).SetImplFunc( ebld ) },
    // Bulk Store instruction is encoded in the R4-type format
    { RevInstDefaults().SetMnemonic( "ebsd  %rd, %rs1, %rs2, %rs3" ).SetOpcode( 0b1011011 ).SetFunct3( 0b011 ).SetFunct2or7( 0b10 ).Setrs3Class( RevRegClass::RegGPR ).SetFormat( RVTypeR4 ).SetImplFunc( ebsd ) },
    // Remote Atomic operations
    { RevInstDefaults().SetMnemonic("elr.d %rd, (%rs1)"            ).SetOpcode( 0b1101011 ).SetFunct3( 0b011 ).SetFunct2or7(0b0000010).Setrs2Class(RevRegClass::RegUNKNOWN).SetImplFunc( elrd ) },
    { RevInstDefaults().SetMnemonic("esc.d %rd, %rs1, %rs2"        ).SetOpcode( 0b1101011 ).SetFunct3( 0b011 ).SetFunct2or7(0b0000011).SetImplFunc( escd ) },

  };
  // clang-format on

public:
  /// RV64X: standard constructor
  RV64X( RevFeature* Feature, RevMem* RevMem, SST::Output* Output ) : RevExt( "RV64X", Feature, RevMem, Output ) {
    SetTable( std::move( RV64XTable ) );
  }

};  // end class RV64X
}  // namespace SST::RevCPU

#endif
