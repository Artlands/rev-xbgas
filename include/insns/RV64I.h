//
// _RV64I_h_
//
// Copyright (C) 2017-2023 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#ifndef _SST_REVCPU_RV64I_H_
#define _SST_REVCPU_RV64I_H_

#include "../RevInstHelpers.h"

#include <vector>

namespace SST::RevCPU{

class RV64I : public RevExt{
  // Standard instructions
  static constexpr auto& ld    = load<int64_t>;
  static constexpr auto& lwu   = load<uint32_t>;
  static constexpr auto& sd    = store<uint64_t>;

  // 32-bit arithmetic operators
  static constexpr auto& addw  = oper<std::plus,   OpKind::Reg, std::make_signed_t,   true>;
  static constexpr auto& subw  = oper<std::minus,  OpKind::Reg, std::make_signed_t,   true>;
  static constexpr auto& addiw = oper<std::plus,   OpKind::Imm, std::make_signed_t,   true>;

  // Shift operators
  static constexpr auto& slliw = oper<ShiftLeft,  OpKind::Imm, std::make_unsigned_t, true>;
  static constexpr auto& srliw = oper<ShiftRight, OpKind::Imm, std::make_unsigned_t, true>;
  static constexpr auto& sraiw = oper<ShiftRight, OpKind::Imm, std::make_signed_t,   true>;
  static constexpr auto& sllw  = oper<ShiftLeft,  OpKind::Reg, std::make_unsigned_t, true>;
  static constexpr auto& srlw  = oper<ShiftRight, OpKind::Reg, std::make_unsigned_t, true>;
  static constexpr auto& sraw  = oper<ShiftRight, OpKind::Reg, std::make_signed_t,   true>;

  // Compressed instructions
  // c.ldsp %rd, $imm = ld %rd, x2, $imm
  static constexpr auto& cldsp = ld;

  // c.sdsp %rs2, $imm = sd %rs2, x2, $imm
  static constexpr auto& csdsp = sd;

  // c.ld %rd, %rs1, $imm = ld %rd, %rs1, $$imm
  static constexpr auto& cld = ld;

  // c.sd %rs2, %rs1, $imm = sd %rs2, $imm(%rs1)
  static constexpr auto& csd = sd;

  // c.addiw %rd, $imm = addiw %rd, %rd, $imm
  static constexpr auto& caddiw = addiw;

  // c.addw %rd, %rs2 = addw %rd, %rd, %rs2
  static constexpr auto& caddw = addw;

  // c.subw %rd, %rs2 = subw %rd, %rd, %rs2
  static constexpr auto& csubw = subw;

  // ----------------------------------------------------------------------
  //
  // RISC-V RV64I Instructions
  //
  // Format:
  // <mnemonic> <cost> <opcode> <funct3> <funct7> <rdClass> <rs1Class>
  //            <rs2Class> <rs3Class> <format> <func> <nullEntry>
  // ----------------------------------------------------------------------
  std::vector<RevInstEntry > RV64ITable = {
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("lwu %rd, $imm(%rs1)"  ).SetCost(1).SetOpcode( 0b0000011).SetFunct3(0b110).SetFunct2or7(0b0      ).SetrdClass(RevRegClass::RegGPR).Setrs1Class(RevRegClass::RegGPR).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc(&lwu ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("ld %rd, $imm(%rs1)"   ).SetCost(1).SetOpcode( 0b0000011).SetFunct3(0b011).SetFunct2or7(0b0      ).SetrdClass(RevRegClass::RegGPR).Setrs1Class(RevRegClass::RegGPR).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc(&ld ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("sd %rs2, $imm(%rs1)"  ).SetCost(1).SetOpcode( 0b0100011).SetFunct3(0b011).SetFunct2or7(0b0      ).SetrdClass(RevRegClass::RegIMM).Setrs1Class(RevRegClass::RegGPR).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm(FUnk).SetFormat(RVTypeS).SetImplFunc(&sd ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("addiw %rd, %rs1, $imm").SetCost(1).SetOpcode( 0b0011011).SetFunct3(0b000).SetFunct2or7(0b0      ).SetrdClass(RevRegClass::RegGPR).Setrs1Class(RevRegClass::RegGPR).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc(&addiw ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("slliw %rd, %rs1, $imm").SetCost(1).SetOpcode( 0b0011011).SetFunct3(0b001).SetFunct2or7(0b0000000).SetrdClass(RevRegClass::RegGPR).Setrs1Class(RevRegClass::RegGPR).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc(&slliw ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("srliw %rd, %rs1, $imm").SetCost(1).SetOpcode( 0b0011011).SetFunct3(0b101).SetFunct2or7(0b0000000).SetrdClass(RevRegClass::RegGPR).Setrs1Class(RevRegClass::RegGPR).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeR).SetImplFunc(&srliw ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("sraiw %rd, %rs1, $imm").SetCost(1).SetOpcode( 0b0011011).SetFunct3(0b101).SetFunct2or7(0b0100000).SetrdClass(RevRegClass::RegGPR).Setrs1Class(RevRegClass::RegGPR).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeR).SetImplFunc(&sraiw ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("addw %rd, %rs1, %rs2" ).SetCost(1).SetOpcode( 0b0111011).SetFunct3(0b000).SetFunct2or7(0b0000000).SetrdClass(RevRegClass::RegGPR).Setrs1Class(RevRegClass::RegGPR).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc(&addw ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("subw %rd, %rs1, %rs2" ).SetCost(1).SetOpcode( 0b0111011).SetFunct3(0b000).SetFunct2or7(0b0100000).SetrdClass(RevRegClass::RegGPR).Setrs1Class(RevRegClass::RegGPR).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc(&subw ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("sllw %rd, %rs1, %rs2" ).SetCost(1).SetOpcode( 0b0111011).SetFunct3(0b001).SetFunct2or7(0b0000000).SetrdClass(RevRegClass::RegGPR).Setrs1Class(RevRegClass::RegGPR).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc(&sllw ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("srlw %rd, %rs1, %rs2" ).SetCost(1).SetOpcode( 0b0111011).SetFunct3(0b101).SetFunct2or7(0b0000000).SetrdClass(RevRegClass::RegGPR).Setrs1Class(RevRegClass::RegGPR).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc(&srlw ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("sraw %rd, %rs1, %rs2" ).SetCost(1).SetOpcode( 0b0111011).SetFunct3(0b101).SetFunct2or7(0b0100000).SetrdClass(RevRegClass::RegGPR).Setrs1Class(RevRegClass::RegGPR).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc(&sraw ).InstEntry},
  };

  std::vector<RevInstEntry> RV64ICTable = {
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.ldsp %rd, $imm").SetCost(1).SetOpcode(0b10).SetFunct3(0b011).SetrdClass(RevRegClass::RegGPR).Setrs1Class(RevRegClass::RegGPR).Setimm(FVal).SetFormat(RVCTypeCI).SetImplFunc(&cldsp).SetCompressed(true).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.sdsp %rs2, $imm").SetCost(1).SetOpcode(0b10).SetFunct3(0b111).Setrs2Class(RevRegClass::RegGPR).Setrs1Class(RevRegClass::RegGPR).Setimm(FVal).SetFormat(RVCTypeCSS).SetImplFunc(&csdsp).SetCompressed(true).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.ld %rd, %rs1, $imm").SetCost(1).SetOpcode(0b00).SetFunct3(0b011).SetrdClass(RevRegClass::RegGPR).Setrs1Class(RevRegClass::RegGPR).Setimm(FVal).SetFormat(RVCTypeCL).SetImplFunc(&cld).SetCompressed(true).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.sd %rs2, %rs1, $imm").SetCost(1).SetOpcode(0b00).SetFunct3(0b111).Setrs1Class(RevRegClass::RegGPR).Setrs2Class(RevRegClass::RegGPR).Setimm(FVal).SetFormat(RVCTypeCS).SetImplFunc(&csd).SetCompressed(true).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.addiw %rd, $imm").SetCost(1).SetOpcode(0b01).SetFunct3(0b001).Setrs1Class(RevRegClass::RegGPR).SetrdClass(RevRegClass::RegGPR).Setimm(FVal).SetFormat(RVCTypeCI).SetImplFunc(&caddiw).SetCompressed(true).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.addw %rd, %rs1").SetCost(1).SetOpcode(0b01).SetFunct6(0b100111).SetFunct2(0b01).SetrdClass(RevRegClass::RegGPR).Setrs2Class(RevRegClass::RegGPR).SetFormat(RVCTypeCA).SetImplFunc(&caddw).SetCompressed(true).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.subw %rd, %rs1").SetCost(1).SetOpcode(0b01).SetFunct6(0b100111).SetFunct2(0b00).SetrdClass(RevRegClass::RegGPR).Setrs2Class(RevRegClass::RegGPR).SetFormat(RVCTypeCA).SetImplFunc(&csubw).SetCompressed(true).InstEntry},
  };

public:
  /// RV64I: standard constructor
  RV64I( RevFeature *Feature,
         RevMem *RevMem,
         SST::Output *Output )
    : RevExt( "RV64I", Feature, RevMem, Output ) {
    SetTable(std::move(RV64ITable));
    SetCTable(std::move(RV64ICTable));
  }
}; // end class RV64I
} // namespace SST::RevCPU

#endif
