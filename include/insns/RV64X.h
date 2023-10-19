//
// _RV64X_h_
//
// Copyright (C) 2017-2023 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#ifndef _SST_REVCPU_RV64X_H_
#define _SST_REVCPU_RV64X_H_

#include "../RevInstHelpers.h"

namespace SST::RevCPU{

class RV64X : public RevExt {

  // xBGAS remote loads
  static constexpr auto& eld  = eload<int64_t>;
  static constexpr auto& elw  = eload<int32_t>;
  static constexpr auto& elh  = eload<int16_t>;
  static constexpr auto& elhu = eload<uint16_t>;
  static constexpr auto& elb  = eload<int8_t>;
  static constexpr auto& elbu = eload<uint8_t>;

  static bool ele(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
    return true;
  }

  // xBGAS remote stores
  static constexpr auto& esd  = estore<uint64_t>;
  static constexpr auto& esw  = estore<uint32_t>;
  static constexpr auto& esh  = estore<uint16_t>;
  static constexpr auto& esb  = estore<uint8_t>;

  static bool ese(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
    return true;
  }

  // xBGAS remote raw loads
  static constexpr auto& erld  = erload<int64_t>;
  static constexpr auto& erlw  = erload<int32_t>;
  static constexpr auto& erlh  = erload<int16_t>;
  static constexpr auto& erlhu = erload<uint16_t>;
  static constexpr auto& erlb  = erload<int8_t>;
  static constexpr auto& erlbu = erload<uint8_t>;

  static bool erle(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
    return true;
  }

  // xBGAS remote raw stores
  static constexpr auto& ersd  = erstore<uint64_t>;
  static constexpr auto& ersw  = erstore<uint32_t>;
  static constexpr auto& ersh  = erstore<uint16_t>;
  static constexpr auto& ersb  = erstore<uint8_t>;

  static bool erse(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
    return true;
  }

  // xBGAS register operations
  static bool eaddi(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
    return true;
  }

  static bool eaddie(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
    return true;
  }

  static bool eaddix(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
    return true;
  }

  // xBGAS remote bulk loads
  static constexpr auto& ebld  = ebload<int64_t>;
  static constexpr auto& eblw  = ebload<int32_t>;
  static constexpr auto& eblh  = ebload<int16_t>;
  static constexpr auto& eblhu = ebload<uint16_t>;
  static constexpr auto& eblb  = ebload<int8_t>;
  static constexpr auto& eblbu = ebload<uint8_t>;

  // xBGAS remote bulk stores
  static constexpr auto& ebsd  = ebstore<uint64_t>;
  static constexpr auto& ebsw  = ebstore<uint32_t>;
  static constexpr auto& ebsh  = ebstore<uint16_t>;
  static constexpr auto& ebsb  = ebstore<uint8_t>;

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
    // {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("elq %rd, $imm(%rs1)"      ).SetCost(1).SetOpcode(0b1110111).SetFunct3(0b110).SetFunct7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &elq ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("eld %rd, $imm(%rs1)"       ).SetCost(1).SetOpcode(0b1110111).SetFunct3(0b011).SetFunct7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &eld ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("elw %rd, $imm(%rs1)"       ).SetCost(1).SetOpcode(0b1110111).SetFunct3(0b010).SetFunct7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &elw ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("elh %rd, $imm(%rs1)"       ).SetCost(1).SetOpcode(0b1110111).SetFunct3(0b001).SetFunct7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &elh ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("elhu %rd, $imm(%rs1)"      ).SetCost(1).SetOpcode(0b1110111).SetFunct3(0b101).SetFunct7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &elhu).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("elb %rd, $imm(%rs1)"       ).SetCost(1).SetOpcode(0b1110111).SetFunct3(0b000).SetFunct7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &elb ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("elbu %rd, $imm(%rs1)"      ).SetCost(1).SetOpcode(0b1110111).SetFunct3(0b100).SetFunct7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &elbu).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("ele %extd, $imm(%rs1)"     ).SetCost(1).SetOpcode(0b1110111).SetFunct3(0b111).SetFunct7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &ele ).InstEntry},

    // Store instructions are encoded in the S-type format
    // {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("esq %rs1, $imm(%rs2)"     ).SetCost(1).SetOpcode(0b1111011).SetFunct3(0b100).SetFunct7(0b0      ).SetrdClass(RevRegClass::RegUNKNOWN).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeS).SetImplFunc( &esq ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("esd %rs1, $imm(%rs2)"      ).SetCost(1).SetOpcode(0b1111011).SetFunct3(0b011).SetFunct7(0b0      ).SetrdClass(RevRegClass::RegUNKNOWN).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeS).SetImplFunc( &esd ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("esw %rs1, $imm(%rs2)"      ).SetCost(1).SetOpcode(0b1111011).SetFunct3(0b010).SetFunct7(0b0      ).SetrdClass(RevRegClass::RegUNKNOWN).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeS).SetImplFunc( &esw ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("esh %rs1, $imm(%rs2)"      ).SetCost(1).SetOpcode(0b1111011).SetFunct3(0b001).SetFunct7(0b0      ).SetrdClass(RevRegClass::RegUNKNOWN).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeS).SetImplFunc( &esh ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("esb %rs1, $imm(%rs2)"      ).SetCost(1).SetOpcode(0b1111011).SetFunct3(0b000).SetFunct7(0b0      ).SetrdClass(RevRegClass::RegUNKNOWN).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeS).SetImplFunc( &esb ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("ese %ext1, $imm(%rs2)"     ).SetCost(1).SetOpcode(0b1111011).SetFunct3(0b101).SetFunct7(0b0      ).SetrdClass(RevRegClass::RegUNKNOWN).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeS).SetImplFunc( &ese ).InstEntry},
    
    // Raw Load instructions are encoded in the R-type format
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("erld %rd, %rs1, %ext2"     ).SetCost(1).SetOpcode(0b0110011).SetFunct3(0b011).SetFunct7(0b1010101).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &erld ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("erlw %rd, %rs1, %ext2"     ).SetCost(1).SetOpcode(0b0110011).SetFunct3(0b010).SetFunct7(0b1010101).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &erlw ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("erlh %rd, %rs1, %ext2"     ).SetCost(1).SetOpcode(0b0110011).SetFunct3(0b001).SetFunct7(0b1010101).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &erlh ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("erlhu %rd, %rs1, %ext2"    ).SetCost(1).SetOpcode(0b0110011).SetFunct3(0b101).SetFunct7(0b1010101).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &erlhu).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("erlb %rd, %rs1, %ext2"     ).SetCost(1).SetOpcode(0b0110011).SetFunct3(0b000).SetFunct7(0b1010101).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &erlb ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("erlbu %rd, %rs1, %ext2"    ).SetCost(1).SetOpcode(0b0110011).SetFunct3(0b100).SetFunct7(0b1010101).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &erlbu).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("erle %extd, %rs1, %ext2"   ).SetCost(1).SetOpcode(0b0110011).SetFunct3(0b100).SetFunct7(0b0100001).SetrdClass(RevRegClass::RegUNKNOWN).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &erle ).InstEntry},

    // Raw Store instructions are encoded in the R-type format
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("ersd %rs1, %rs2, %ext3"    ).SetCost(1).SetOpcode(0b0110011).SetFunct3(0b011).SetFunct7(0b0100010).SetrdClass(RevRegClass::RegUNKNOWN).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &ersd ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("ersw %rs1, %rs2, %ext3"    ).SetCost(1).SetOpcode(0b0110011).SetFunct3(0b010).SetFunct7(0b0100010).SetrdClass(RevRegClass::RegUNKNOWN).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &ersw ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("ersh %rs1, %rs2, %ext3"    ).SetCost(1).SetOpcode(0b0110011).SetFunct3(0b001).SetFunct7(0b0100010).SetrdClass(RevRegClass::RegUNKNOWN).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &ersh ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("ersb %rs1, %rs2, %ext3"    ).SetCost(1).SetOpcode(0b0110011).SetFunct3(0b000).SetFunct7(0b0100010).SetrdClass(RevRegClass::RegUNKNOWN).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &ersb ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("erse %ext1, %rs2, %ext3"   ).SetCost(1).SetOpcode(0b0110011).SetFunct3(0b011).SetFunct7(0b0100011).SetrdClass(RevRegClass::RegUNKNOWN).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &erse ).InstEntry},

    // Aggreagtion instruction is encoded in the R-type format.
    // {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("eag %rd, %rs1, %rs2"      ).SetCost(1).SetOpcode(0b0110011).SetFunct3(0b001).SetFunct7(0b0100011).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &eag  ).InstEntry},

    // Address Management Instructions are encoded in the I-type format
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("eaddi %rd, %ext1, $imm"    ).SetCost(1).SetOpcode(0b1111011).SetFunct3(0b110).SetFunct7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &eaddi ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("eaddie %extd, %rs1, $imm"  ).SetCost(1).SetOpcode(0b1111011).SetFunct3(0b111).SetFunct7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &eaddie).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("eaddix %extd, %ext1, $imm" ).SetCost(1).SetOpcode(0b0000011).SetFunct3(0b111).SetFunct7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &eaddix).InstEntry},

    // Bulk Load instruction is encoded in the R4-type format
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("ebld  %rd, %rs1, %rs2, %rs3").SetCost(1).SetOpcode(0b1000011).SetFunct2(0b11).SetFunct3(0b011).SetFunct7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegGPR    ).SetFormat(RVTypeR4).SetImplFunc(&ebld ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("eblw  %rd, %rs1, %rs2, %rs3").SetCost(1).SetOpcode(0b1000011).SetFunct2(0b11).SetFunct3(0b010).SetFunct7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegGPR    ).SetFormat(RVTypeR4).SetImplFunc(&eblw ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("eblh  %rd, %rs1, %rs2, %rs3").SetCost(1).SetOpcode(0b1000011).SetFunct2(0b11).SetFunct3(0b001).SetFunct7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegGPR    ).SetFormat(RVTypeR4).SetImplFunc(&eblh ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("eblhu %rd, %rs1, %rs2, %rs3").SetCost(1).SetOpcode(0b1000011).SetFunct2(0b11).SetFunct3(0b101).SetFunct7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegGPR    ).SetFormat(RVTypeR4).SetImplFunc(&eblhu).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("eblb  %rd, %rs1, %rs2, %rs3").SetCost(1).SetOpcode(0b1000011).SetFunct2(0b11).SetFunct3(0b000).SetFunct7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegGPR    ).SetFormat(RVTypeR4).SetImplFunc(&eblb ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("eblbu %rd, %rs1, %rs2, %rs3").SetCost(1).SetOpcode(0b1000011).SetFunct2(0b11).SetFunct3(0b100).SetFunct7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegGPR    ).SetFormat(RVTypeR4).SetImplFunc(&eblbu).InstEntry},

    // Bulk Store instruction is encoded in the R4-type format
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("ebsd  %rd, %rs1, %rs2, %rs3").SetCost(1).SetOpcode(0b1000011).SetFunct2(0b10).SetFunct3(0b011).SetFunct7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegGPR    ).SetFormat(RVTypeR4).SetImplFunc(&ebsd ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("ebsw  %rd, %rs1, %rs2, %rs3").SetCost(1).SetOpcode(0b1000011).SetFunct2(0b10).SetFunct3(0b010).SetFunct7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegGPR    ).SetFormat(RVTypeR4).SetImplFunc(&ebsw ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("ebsh  %rd, %rs1, %rs2, %rs3").SetCost(1).SetOpcode(0b1000011).SetFunct2(0b10).SetFunct3(0b001).SetFunct7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegGPR    ).SetFormat(RVTypeR4).SetImplFunc(&ebsh ).InstEntry},
    {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("ebsb  %rd, %rs1, %rs2, %rs3").SetCost(1).SetOpcode(0b1000011).SetFunct2(0b10).SetFunct3(0b000).SetFunct7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegGPR    ).SetFormat(RVTypeR4).SetImplFunc(&ebsb ).InstEntry},
  };

public:
  /// RV64X: standard constructor
  RV64X(RevFeature *Feature,
        RevMem *RevMem,
        SST::Output *Output )
    : RevExt( "RV64X", Feature, RevMem, Output ){
    SetTable(std::move(RV64XTable));
  }

}; // end class RV64X
} // namespace SST::RevCPU

#endif
