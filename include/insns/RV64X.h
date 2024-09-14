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

  // xBGAS remote loads
  static constexpr auto& eld = eload<int64_t>;

  static bool ele( const RevFeature* F, RevRegFile* R, RevMem* M, const RevInst& Inst ) { return true; }

  // xBGAS remote stores
  static constexpr auto& esd = estore<uint64_t>;

  static bool ese( const RevFeature* F, RevRegFile* R, RevMem* M, const RevInst& Inst ) { return true; }

  // xBGAS remote raw loads
  static constexpr auto& erld = erload<int64_t>;

  static bool erle( const RevFeature* F, RevRegFile* R, RevMem* M, const RevInst& Inst ) { return true; }

  // xBGAS remote raw stores
  static constexpr auto& ersd = erstore<uint64_t>;

  static bool erse( const RevFeature* F, RevRegFile* R, RevMem* M, const RevInst& Inst ) { return true; }

  // xBGAS remote bulk loads
  static constexpr auto& ebld = ebload<int64_t>;

  // xBGAS remote bulk stores
  static constexpr auto& ebsd = ebstore<uint64_t>;

  // ----------------------------------------------------------------------
  //
  // RISC-V RV64X Instructions
  //
  // ----------------------------------------------------------------------
  // clang-format off
  std::vector<RevInstEntry> RV64XTable = {
    // Load instructions are encoded in the I-type format
    RevInstDefaults().SetMnemonic( "eld %rd, $imm(%rs1)"         ).SetOpcode( 0b1110111 ).SetFunct3( 0b011 ).Setrs2Class( RevRegClass::RegUNKNOWN ).Setimm( RevImmFunc::FImm ).SetFormat( RVTypeI ).SetImplFunc( eld ),
    RevInstDefaults().SetMnemonic( "ele %extd, $imm(%rs1)"       ).SetOpcode( 0b1110111 ).SetFunct3( 0b111 ).Setrs2Class( RevRegClass::RegUNKNOWN ).Setimm( RevImmFunc::FImm ).SetFormat( RVTypeI ).SetImplFunc( ele ),
    // Store instructions are encoded in the S-type format
    RevInstDefaults().SetMnemonic( "esd %rs1, $imm(%rs2)"        ).SetOpcode( 0b1111011 ).SetFunct3( 0b011 ).SetrdClass( RevRegClass::RegUNKNOWN ).Setimm( RevImmFunc::FImm ).SetFormat( RVTypeS ).SetImplFunc( esd ),
    RevInstDefaults().SetMnemonic( "ese %ext1, $imm(%rs2)"       ).SetOpcode( 0b1111011 ).SetFunct3( 0b111 ).SetrdClass( RevRegClass::RegUNKNOWN ).Setimm( RevImmFunc::FImm ).SetFormat( RVTypeS ).SetImplFunc( ese ),
    // Raw Load instructions are encoded in the R-type format
    RevInstDefaults().SetMnemonic( "erld %rd, %rs1, %ext2"       ).SetOpcode( 0b0110011 ).SetFunct3( 0b011 ).SetFunct2or7( 0b1010110 ).SetFormat( RVTypeR ).SetImplFunc( erld ),
    RevInstDefaults().SetMnemonic( "erle %extd, %rs1, %ext2"     ).SetOpcode( 0b0110011 ).SetFunct3( 0b111 ).SetFunct2or7( 0b1010110 ).SetrdClass( RevRegClass::RegUNKNOWN ).SetFormat( RVTypeR ).SetImplFunc( erle ),
    // Raw Store instructions are encoded in the R-type format
    RevInstDefaults().SetMnemonic( "ersd %rs1, %rs2, %ext3"      ).SetOpcode( 0b0110011 ).SetFunct3( 0b011 ).SetFunct2or7( 0b0100010 ).SetFormat( RVTypeR ).SetImplFunc( ersd ),
    RevInstDefaults().SetMnemonic( "erse %ext1, %rs2, %ext3"     ).SetOpcode( 0b0110011 ).SetFunct3( 0b111 ).SetFunct2or7( 0b0100011 ).SetFormat( RVTypeR ).SetImplFunc( erse ),
    // Bulk Load instruction is encoded in the R4-type format
    RevInstDefaults().SetMnemonic( "ebld  %rd, %rs1, %rs2, %rs3" ).SetOpcode( 0b1011011 ).SetFunct3( 0b011 ).SetFunct2or7( 0b11 ).Setrs3Class( RevRegClass::RegGPR ).SetFormat( RVTypeR4 ).SetImplFunc( ebld ),
    // Bulk Store instruction is encoded in the R4-type format
    RevInstDefaults().SetMnemonic( "ebsd  %rd, %rs1, %rs2, %rs3" ).SetOpcode( 0b1011011 ).SetFunct3( 0b011 ).SetFunct2or7( 0b10 ).Setrs3Class( RevRegClass::RegGPR ).SetFormat( RVTypeR4 ).SetImplFunc( ebsd ),
  };
  // clang-format on

public:
  /// RV64X: standard constructor
  RV64X( const RevFeature* Feature, RevMem* RevMem, SST::Output* Output ) : RevExt( "RV64X", Feature, RevMem, Output ) {
    SetTable( std::move( RV64XTable ) );
  }

};  // end class RV64X
}  // namespace SST::RevCPU

#endif
