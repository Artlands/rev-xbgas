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
  static bool eaddi( const RevFeature* F, RevRegFile* R, RevMem* M, const RevInst& Inst ) {
    auto rs1 = R->GetE<uint64_t>( Inst.rs1 );
    R->SetX( Inst.rd, rs1 + Inst.ImmSignExt( 12 ) );
    R->AdvancePC( Inst );
    return true;
  }

  static bool eaddie( const RevFeature* F, RevRegFile* R, RevMem* M, const RevInst& Inst ) {
    auto rs1 = R->GetX<uint64_t>( Inst.rs1 );
    R->SetE( Inst.rd, rs1 + Inst.ImmSignExt( 12 ) );
    R->AdvancePC( Inst );
    return true;
  }

  static bool eaddix( const RevFeature* F, RevRegFile* R, RevMem* M, const RevInst& Inst ) {
    auto rs1 = R->GetX<uint64_t>( Inst.rs1 );
    R->SetE( Inst.rd, rs1 + Inst.ImmSignExt( 12 ) );
    R->AdvancePC( Inst );
    return true;
  }

  // xBGAS remote bulk loads
  static constexpr auto& eblw = ebload<uint32_t>;
  static constexpr auto& eblh = ebload<uint16_t>;
  static constexpr auto& eblb = ebload<uint8_t>;

  // xBGAS remote bulk stores
  static constexpr auto& ebsw = ebstore<uint32_t>;
  static constexpr auto& ebsh = ebstore<uint16_t>;
  static constexpr auto& ebsb = ebstore<uint8_t>;

  // ----------------------------------------------------------------------
  //
  // RISC-V RV32X Instructions
  //
  // ----------------------------------------------------------------------

  // clang-format off
  std::vector<RevInstEntry> RV32XTable = {
    // Load instructions are encoded in the I-type format
    RevInstDefaults().SetMnemonic( "elw %rd, $imm(%rs1)"         ).SetOpcode( 0b1110111 ).SetFunct3( 0b010 ).Setrs2Class( RevRegClass::RegUNKNOWN ).Setimm( RevImmFunc::FImm ).SetFormat( RVTypeI ).SetImplFunc( elw  ),
    RevInstDefaults().SetMnemonic( "elh %rd, $imm(%rs1)"         ).SetOpcode( 0b1110111 ).SetFunct3( 0b001 ).Setrs2Class( RevRegClass::RegUNKNOWN ).Setimm( RevImmFunc::FImm ).SetFormat( RVTypeI ).SetImplFunc( elh  ),
    RevInstDefaults().SetMnemonic( "elhu %rd, $imm(%rs1)"        ).SetOpcode( 0b1110111 ).SetFunct3( 0b101 ).Setrs2Class( RevRegClass::RegUNKNOWN ).Setimm( RevImmFunc::FImm ).SetFormat( RVTypeI ).SetImplFunc( elhu ),
    RevInstDefaults().SetMnemonic( "elb %rd, $imm(%rs1)"         ).SetOpcode( 0b1110111 ).SetFunct3( 0b000 ).Setrs2Class( RevRegClass::RegUNKNOWN ).Setimm( RevImmFunc::FImm ).SetFormat( RVTypeI ).SetImplFunc( elb  ),
    RevInstDefaults().SetMnemonic( "elbu %rd, $imm(%rs1)"        ).SetOpcode( 0b1110111 ).SetFunct3( 0b100 ).Setrs2Class( RevRegClass::RegUNKNOWN ).Setimm( RevImmFunc::FImm ).SetFormat( RVTypeI ).SetImplFunc( elbu ),
    // Store instructions are encoded in the S-type format
    RevInstDefaults().SetMnemonic( "esw %rs1, $imm(%rs2)"        ).SetOpcode( 0b1111011 ).SetFunct3( 0b010 ).SetrdClass( RevRegClass::RegUNKNOWN ).Setimm( RevImmFunc::FImm ).SetFormat( RVTypeS ).SetImplFunc( esw ),
    RevInstDefaults().SetMnemonic( "esh %rs1, $imm(%rs2)"        ).SetOpcode( 0b1111011 ).SetFunct3( 0b001 ).SetrdClass( RevRegClass::RegUNKNOWN ).Setimm( RevImmFunc::FImm ).SetFormat( RVTypeS ).SetImplFunc( esh ),
    RevInstDefaults().SetMnemonic( "esb %rs1, $imm(%rs2)"        ).SetOpcode( 0b1111011 ).SetFunct3( 0b000 ).SetrdClass( RevRegClass::RegUNKNOWN ).Setimm( RevImmFunc::FImm ).SetFormat( RVTypeS ).SetImplFunc( esb ),
    // Raw Load instructions are encoded in the R-type format
    RevInstDefaults().SetMnemonic( "erlw %rd, %rs1, %ext2"       ).SetOpcode( 0b0110011 ).SetFunct3( 0b010 ).SetFunct2or7( 0b1010101 ).SetFormat( RVTypeR ).SetImplFunc( erlw  ),
    RevInstDefaults().SetMnemonic( "erlh %rd, %rs1, %ext2"       ).SetOpcode( 0b0110011 ).SetFunct3( 0b001 ).SetFunct2or7( 0b1010101 ).SetFormat( RVTypeR ).SetImplFunc( erlh  ),
    RevInstDefaults().SetMnemonic( "erlhu %rd, %rs1, %ext2"      ).SetOpcode( 0b0110011 ).SetFunct3( 0b101 ).SetFunct2or7( 0b1010101 ).SetFormat( RVTypeR ).SetImplFunc( erlhu ),
    RevInstDefaults().SetMnemonic( "erlb %rd, %rs1, %ext2"       ).SetOpcode( 0b0110011 ).SetFunct3( 0b000 ).SetFunct2or7( 0b1010101 ).SetFormat( RVTypeR ).SetImplFunc( erlb  ),
    RevInstDefaults().SetMnemonic( "erlbu %rd, %rs1, %ext2"      ).SetOpcode( 0b0110011 ).SetFunct3( 0b100 ).SetFunct2or7( 0b1010101 ).SetFormat( RVTypeR ).SetImplFunc( erlbu ),
    // Raw Store instructions are encoded in the R-type format
    RevInstDefaults().SetMnemonic( "ersw %rs1, %rs2, %ext3"      ).SetOpcode( 0b0110011 ).SetFunct3( 0b010 ).SetFunct2or7( 0b0100010 ).SetFormat( RVTypeR ).SetImplFunc( ersw ),
    RevInstDefaults().SetMnemonic( "ersh %rs1, %rs2, %ext3"      ).SetOpcode( 0b0110011 ).SetFunct3( 0b001 ).SetFunct2or7( 0b0100010 ).SetFormat( RVTypeR ).SetImplFunc( ersh ),
    RevInstDefaults().SetMnemonic( "ersb %rs1, %rs2, %ext3"      ).SetOpcode( 0b0110011 ).SetFunct3( 0b000 ).SetFunct2or7( 0b0100010 ).SetFormat( RVTypeR ).SetImplFunc( ersb ),
    // Address Management Instructions are encoded in the I-type format
    RevInstDefaults().SetMnemonic( "eaddi %rd, %ext1, $imm"      ).SetOpcode( 0b1111011 ).SetFunct3( 0b110 ).Setrs2Class( RevRegClass::RegUNKNOWN ).Setimm( RevImmFunc::FImm ).SetFormat( RVTypeI ).SetImplFunc( eaddi  ),
    RevInstDefaults().SetMnemonic( "eaddie %extd, %rs1, $imm"    ).SetOpcode( 0b1111011 ).SetFunct3( 0b101 ).Setrs2Class( RevRegClass::RegUNKNOWN ).Setimm( RevImmFunc::FImm ).SetFormat( RVTypeI ).SetImplFunc( eaddie ),
    RevInstDefaults().SetMnemonic( "eaddix %extd, %ext1, $imm"   ).SetOpcode( 0b0000011 ).SetFunct3( 0b111 ).Setrs2Class( RevRegClass::RegUNKNOWN ).Setimm( RevImmFunc::FImm ).SetFormat( RVTypeI ).SetImplFunc( eaddix ),
    // Bulk Load instruction is encoded in the R4-type format
    RevInstDefaults().SetMnemonic( "eblw  %rd, %rs1, %rs2, %rs3" ).SetOpcode( 0b1011011 ).SetFunct3( 0b010 ).SetFunct2or7( 0b11 ).Setrs3Class( RevRegClass::RegGPR ).SetFormat( RVTypeR4 ).SetImplFunc( eblw  ),
    RevInstDefaults().SetMnemonic( "eblh  %rd, %rs1, %rs2, %rs3" ).SetOpcode( 0b1011011 ).SetFunct3( 0b001 ).SetFunct2or7( 0b11 ).Setrs3Class( RevRegClass::RegGPR ).SetFormat( RVTypeR4 ).SetImplFunc( eblh  ),
    RevInstDefaults().SetMnemonic( "eblb  %rd, %rs1, %rs2, %rs3" ).SetOpcode( 0b1011011 ).SetFunct3( 0b000 ).SetFunct2or7( 0b11 ).Setrs3Class( RevRegClass::RegGPR ).SetFormat( RVTypeR4 ).SetImplFunc( eblb  ),
    // Bulk Store instruction is encoded in the R4-type format
    RevInstDefaults().SetMnemonic( "ebsw  %rd, %rs1, %rs2, %rs3" ).SetOpcode( 0b1011011 ).SetFunct3( 0b010 ).SetFunct2or7( 0b10 ).Setrs3Class( RevRegClass::RegGPR ).SetFormat( RVTypeR4 ).SetImplFunc( ebsw ),
    RevInstDefaults().SetMnemonic( "ebsh  %rd, %rs1, %rs2, %rs3" ).SetOpcode( 0b1011011 ).SetFunct3( 0b001 ).SetFunct2or7( 0b10 ).Setrs3Class( RevRegClass::RegGPR ).SetFormat( RVTypeR4 ).SetImplFunc( ebsh ),
    RevInstDefaults().SetMnemonic( "ebsb  %rd, %rs1, %rs2, %rs3" ).SetOpcode( 0b1011011 ).SetFunct3( 0b000 ).SetFunct2or7( 0b10 ).Setrs3Class( RevRegClass::RegGPR ).SetFormat( RVTypeR4 ).SetImplFunc( ebsb ),
  };
  // clang-format on

public:
  /// RV32X: standard constructor
  RV32X( const RevFeature* Feature, RevMem* RevMem, SST::Output* Output ) : RevExt( "RV32X", Feature, RevMem, Output ) {
    SetTable( std::move( RV32XTable ) );
  }

};  // end class RV32X
}  // namespace SST::RevCPU

#endif
