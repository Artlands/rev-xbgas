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

  // // xBGAS register operations
  // static bool eaddi(RevFeature *F, RevRegFile *R, RevMem *M, const RevInst& Inst) {
  //   uint64_t rs1 = R->GetE(Inst.rs1);
  //   R->SetX(Inst.rd, rs1 + Inst.ImmSignExt(12));
  //   R->AdvancePC(Inst);
  //   return true;
  // }

  // static bool eaddie(RevFeature *F, RevRegFile *R, RevMem *M, const RevInst& Inst) {
  //   uint64_t rs1 = R->GetX<uint64_t>(Inst.rs1);
  //   R->SetE(Inst.rd, rs1 + Inst.ImmSignExt(12));
  //   R->AdvancePC(Inst);
  //   return true;
  // }

  // static bool eaddix(RevFeature *F, RevRegFile *R, RevMem *M, const RevInst& Inst) {
  //   uint64_t rs1 = R->GetE(Inst.rs1);
  //   R->SetE(Inst.rd, rs1 + Inst.ImmSignExt(12));
  //   R->AdvancePC(Inst);
  //   return true;
  // }

  // xBGAS remote bulk loads
  static constexpr auto& ebld          = ebload<int64_t>;

  // xBGAS remote bulk stores
  static constexpr auto& ebsd          = ebstore<uint64_t>;

  // ----------------------------------------------------------------------
  //
  // RISC-V RV64X Instructions
  //
  // Format:
  // <mnemonic> <cost> <opcode> <funct3> <funct7> <rdClass> <rs1Class>
  //            <rs2Class> <rs3Class> <format> <func> <nullEntry>
  // ----------------------------------------------------------------------

  std::vector<RevInstEntry> RV64XTable = {
    // Load instructions are encoded in the I-type format
    // {RevInstDefaults().SetMnemonic("elq %rd, $imm(%rs1)"      ).SetOpcode(0b1110111).SetFunct3(0b110).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( elq )},
    { RevInstDefaults()
        .SetMnemonic( "eld %rd, $imm(%rs1)" )
        .SetOpcode( 0b1110111 )
        .SetFunct3( 0b011 )
        .SetrdClass( RevRegClass::RegGPR )
        .Setrs1Class( RevRegClass::RegGPR )
        .Setrs2Class( RevRegClass::RegUNKNOWN )
        .Setrs3Class( RevRegClass::RegUNKNOWN )
        .Setimm12( 0b0 )
        .Setimm( FImm )
        .SetFormat( RVTypeI )
        .SetImplFunc( eld ) },
    { RevInstDefaults()
        .SetMnemonic( "ele %extd, $imm(%rs1)" )
        .SetOpcode( 0b1110111 )
        .SetFunct3( 0b111 )
        .SetrdClass( RevRegClass::RegGPR )
        .Setrs1Class( RevRegClass::RegGPR )
        .Setrs2Class( RevRegClass::RegUNKNOWN )
        .Setrs3Class( RevRegClass::RegUNKNOWN )
        .Setimm12( 0b0 )
        .Setimm( FImm )
        .SetFormat( RVTypeI )
        .SetImplFunc( ele ) },

    // Store instructions are encoded in the S-type format
    // {RevInstDefaults().SetMnemonic("esq %rs1, $imm(%rs2)"     ).SetOpcode(0b1111011).SetFunct3(0b100).SetrdClass(RevRegClass::RegUNKNOWN).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeS).SetImplFunc( esq )},
    { RevInstDefaults()
        .SetMnemonic( "esd %rs1, $imm(%rs2)" )
        .SetOpcode( 0b1111011 )
        .SetFunct3( 0b011 )
        .SetrdClass( RevRegClass::RegUNKNOWN )
        .Setrs1Class( RevRegClass::RegGPR )
        .Setrs2Class( RevRegClass::RegGPR )
        .Setrs3Class( RevRegClass::RegUNKNOWN )
        .Setimm12( 0b0 )
        .Setimm( FImm )
        .SetFormat( RVTypeS )
        .SetImplFunc( esd ) },
    { RevInstDefaults()
        .SetMnemonic( "ese %ext1, $imm(%rs2)" )
        .SetOpcode( 0b1111011 )
        .SetFunct3( 0b111 )
        .SetrdClass( RevRegClass::RegUNKNOWN )
        .Setrs1Class( RevRegClass::RegGPR )
        .Setrs2Class( RevRegClass::RegGPR )
        .Setrs3Class( RevRegClass::RegUNKNOWN )
        .Setimm12( 0b0 )
        .Setimm( FImm )
        .SetFormat( RVTypeS )
        .SetImplFunc( ese ) },

    // Raw Load instructions are encoded in the R-type format
    { RevInstDefaults()
        .SetMnemonic( "erld %rd, %rs1, %ext2" )
        .SetOpcode( 0b0110011 )
        .SetFunct3( 0b011 )
        .SetFunct2or7( 0b1010110 )
        .SetrdClass( RevRegClass::RegGPR )
        .Setrs1Class( RevRegClass::RegGPR )
        .Setrs2Class( RevRegClass::RegGPR )
        .Setrs3Class( RevRegClass::RegUNKNOWN )
        .Setimm12( 0b0 )
        .Setimm( FUnk )
        .SetFormat( RVTypeR )
        .SetImplFunc( erld ) },
    { RevInstDefaults()
        .SetMnemonic( "erle %extd, %rs1, %ext2" )
        .SetOpcode( 0b0110011 )
        .SetFunct3( 0b111 )
        .SetFunct2or7( 0b1010110 )
        .SetrdClass( RevRegClass::RegUNKNOWN )
        .Setrs1Class( RevRegClass::RegGPR )
        .Setrs2Class( RevRegClass::RegGPR )
        .Setrs3Class( RevRegClass::RegUNKNOWN )
        .Setimm12( 0b0 )
        .Setimm( FUnk )
        .SetFormat( RVTypeR )
        .SetImplFunc( erle ) },

    // Raw Store instructions are encoded in the R-type format
    { RevInstDefaults()
        .SetMnemonic( "ersd %rs1, %rs2, %ext3" )
        .SetOpcode( 0b0110011 )
        .SetFunct3( 0b011 )
        .SetFunct2or7( 0b0100010 )
        .SetrdClass( RevRegClass::RegGPR )
        .Setrs1Class( RevRegClass::RegGPR )
        .Setrs2Class( RevRegClass::RegGPR )
        .Setrs3Class( RevRegClass::RegUNKNOWN )
        .Setimm12( 0b0 )
        .Setimm( FUnk )
        .SetFormat( RVTypeR )
        .SetImplFunc( ersd ) },
    { RevInstDefaults()
        .SetMnemonic( "erse %ext1, %rs2, %ext3" )
        .SetOpcode( 0b0110011 )
        .SetFunct3( 0b111 )
        .SetFunct2or7( 0b0100011 )
        .SetrdClass( RevRegClass::RegGPR )
        .Setrs1Class( RevRegClass::RegGPR )
        .Setrs2Class( RevRegClass::RegGPR )
        .Setrs3Class( RevRegClass::RegUNKNOWN )
        .Setimm12( 0b0 )
        .Setimm( FUnk )
        .SetFormat( RVTypeR )
        .SetImplFunc( erse ) },

    // Aggreagtion instruction is encoded in the R-type format.
    // {RevInstDefaults().SetMnemonic("eag %rd, %rs1, %rs2"      ).SetOpcode(0b0110011).SetFunct3(0b001).SetFunct2or7(0b0100011).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( eag  )},

    // Address Management Instructions are encoded in the I-type format
    // {RevInstDefaults().SetMnemonic("eaddi %rd, %ext1, $imm"    ).SetOpcode(0b1111011).SetFunct3(0b010).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( eaddi )},
    // {RevInstDefaults().SetMnemonic("eaddie %extd, %rs1, $imm"  ).SetOpcode(0b1111011).SetFunct3(0b101).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( eaddie)},
    // {RevInstDefaults().SetMnemonic("eaddix %extd, %ext1, $imm" ).SetOpcode(0b1111011).SetFunct3(0b100).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( eaddix)},

    // Bulk Load instruction is encoded in the R4-type format
    { RevInstDefaults()
        .SetMnemonic( "ebld  %rd, %rs1, %rs2, %rs3" )
        .SetOpcode( 0b1011011 )
        .SetFunct2( 0b11 )
        .SetFunct3( 0b011 )
        .SetrdClass( RevRegClass::RegGPR )
        .Setrs1Class( RevRegClass::RegGPR )
        .Setrs2Class( RevRegClass::RegGPR )
        .Setrs3Class( RevRegClass::RegGPR )
        .SetFormat( RVTypeR4 )
        .SetImplFunc( ebld ) },

    // Bulk Store instruction is encoded in the R4-type format
    { RevInstDefaults()
        .SetMnemonic( "ebsd  %rd, %rs1, %rs2, %rs3" )
        .SetOpcode( 0b1011011 )
        .SetFunct2( 0b10 )
        .SetFunct3( 0b011 )
        .SetrdClass( RevRegClass::RegGPR )
        .Setrs1Class( RevRegClass::RegGPR )
        .Setrs2Class( RevRegClass::RegGPR )
        .Setrs3Class( RevRegClass::RegGPR )
        .SetFormat( RVTypeR4 )
        .SetImplFunc( ebsd ) },
  };

public:
  /// RV64X: standard constructor
  RV64X( RevFeature* Feature, RevMem* RevMem, SST::Output* Output ) : RevExt( "RV64X", Feature, RevMem, Output ) {
    SetTable( std::move( RV64XTable ) );
  }

};  // end class RV64X
}  // namespace SST::RevCPU

#endif
