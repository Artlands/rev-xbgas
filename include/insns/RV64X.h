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
#include "../RevExt.h"

namespace SST::RevCPU{

class RV64X : public RevExt {

  // xBGAS remote loads
  static constexpr auto& eld  = eload<int64_t>;
  static constexpr auto& elw  = eload<int32_t>;
  static constexpr auto& elh  = eload<int16_t>;
  static constexpr auto& elhu = eload<uint16_t>;
  static constexpr auto& elb  = eload<int8_t>;
  static constexpr auto& elbu = eload<uint8_t>;

  static bool ele(RevFeature *F, RevRegFile *R, RevMem *M, const RevInst& Inst) {
    return true;
  }

  // xBGAS remote stores
  static constexpr auto& esd  = estore<uint64_t>;
  static constexpr auto& esw  = estore<uint32_t>;
  static constexpr auto& esh  = estore<uint16_t>;
  static constexpr auto& esb  = estore<uint8_t>;

  static bool ese(RevFeature *F, RevRegFile *R, RevMem *M, const RevInst& Inst) {
    return true;
  }

  // xBGAS remote raw loads
  static constexpr auto& erld  = erload<int64_t>;
  static constexpr auto& erlw  = erload<int32_t>;
  static constexpr auto& erlh  = erload<int16_t>;
  static constexpr auto& erlhu = erload<uint16_t>;
  static constexpr auto& erlb  = erload<int8_t>;
  static constexpr auto& erlbu = erload<uint8_t>;

  static bool erle(RevFeature *F, RevRegFile *R, RevMem *M, const RevInst& Inst) {
    return true;
  }

  // xBGAS remote raw stores
  static constexpr auto& ersd  = erstore<uint64_t>;
  static constexpr auto& ersw  = erstore<uint32_t>;
  static constexpr auto& ersh  = erstore<uint16_t>;
  static constexpr auto& ersb  = erstore<uint8_t>;

  static bool erse(RevFeature *F, RevRegFile *R, RevMem *M, const RevInst& Inst) {
    return true;
  }

  // xBGAS register operations
  static bool eaddi(RevFeature *F, RevRegFile *R, RevMem *M, const RevInst& Inst) {
    uint64_t rs1 = R->GetE(Inst.rs1);
    R->SetX(Inst.rd, rs1 + Inst.ImmSignExt(12));
    R->AdvancePC(Inst);
    return true;
  }

  static bool eaddie(RevFeature *F, RevRegFile *R, RevMem *M, const RevInst& Inst) {
    uint64_t rs1 = R->GetX<uint64_t>(Inst.rs1);
    R->SetE(Inst.rd, rs1 + Inst.ImmSignExt(12));
    R->AdvancePC(Inst);
    return true;
  }

  static bool eaddix(RevFeature *F, RevRegFile *R, RevMem *M, const RevInst& Inst) {
    uint64_t rs1 = R->GetE(Inst.rs1);
    R->SetE(Inst.rd, rs1 + Inst.ImmSignExt(12));
    R->AdvancePC(Inst);
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
    // {RevInstDefaults().SetMnemonic("elq %rd, $imm(%rs1)"      ).SetOpcode(0b1110111).SetFunct3(0b110).SetFunct2or7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( elq )},
    {RevInstDefaults().SetMnemonic("eld %rd, $imm(%rs1)"       ).SetOpcode(0b1110111).SetFunct3(0b011).SetFunct2or7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( eld )},
    {RevInstDefaults().SetMnemonic("elw %rd, $imm(%rs1)"       ).SetOpcode(0b1110111).SetFunct3(0b010).SetFunct2or7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( elw )},
    {RevInstDefaults().SetMnemonic("elh %rd, $imm(%rs1)"       ).SetOpcode(0b1110111).SetFunct3(0b001).SetFunct2or7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( elh )},
    {RevInstDefaults().SetMnemonic("elhu %rd, $imm(%rs1)"      ).SetOpcode(0b1110111).SetFunct3(0b101).SetFunct2or7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( elhu)},
    {RevInstDefaults().SetMnemonic("elb %rd, $imm(%rs1)"       ).SetOpcode(0b1110111).SetFunct3(0b000).SetFunct2or7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( elb )},
    {RevInstDefaults().SetMnemonic("elbu %rd, $imm(%rs1)"      ).SetOpcode(0b1110111).SetFunct3(0b100).SetFunct2or7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( elbu)},
    {RevInstDefaults().SetMnemonic("ele %extd, $imm(%rs1)"     ).SetOpcode(0b1110111).SetFunct3(0b111).SetFunct2or7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( ele )},

    // Store instructions are encoded in the S-type format
    // {RevInstDefaults().SetMnemonic("esq %rs1, $imm(%rs2)"     ).SetOpcode(0b1111011).SetFunct3(0b100).SetFunct2or7(0b0      ).SetrdClass(RevRegClass::RegUNKNOWN).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeS).SetImplFunc( esq )},
    {RevInstDefaults().SetMnemonic("esd %rs1, $imm(%rs2)"      ).SetOpcode(0b1111011).SetFunct3(0b011).SetFunct2or7(0b0      ).SetrdClass(RevRegClass::RegUNKNOWN).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeS).SetImplFunc( esd )},
    {RevInstDefaults().SetMnemonic("esw %rs1, $imm(%rs2)"      ).SetOpcode(0b1111011).SetFunct3(0b010).SetFunct2or7(0b0      ).SetrdClass(RevRegClass::RegUNKNOWN).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeS).SetImplFunc( esw )},
    {RevInstDefaults().SetMnemonic("esh %rs1, $imm(%rs2)"      ).SetOpcode(0b1111011).SetFunct3(0b001).SetFunct2or7(0b0      ).SetrdClass(RevRegClass::RegUNKNOWN).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeS).SetImplFunc( esh )},
    {RevInstDefaults().SetMnemonic("esb %rs1, $imm(%rs2)"      ).SetOpcode(0b1111011).SetFunct3(0b000).SetFunct2or7(0b0      ).SetrdClass(RevRegClass::RegUNKNOWN).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeS).SetImplFunc( esb )},
    {RevInstDefaults().SetMnemonic("ese %ext1, $imm(%rs2)"     ).SetOpcode(0b1111011).SetFunct3(0b101).SetFunct2or7(0b0      ).SetrdClass(RevRegClass::RegUNKNOWN).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeS).SetImplFunc( ese )},
    
    // Raw Load instructions are encoded in the R-type format
    {RevInstDefaults().SetMnemonic("erld %rd, %rs1, %ext2"     ).SetOpcode(0b0110011).SetFunct3(0b011).SetFunct2or7(0b1010101).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( erld )},
    {RevInstDefaults().SetMnemonic("erlw %rd, %rs1, %ext2"     ).SetOpcode(0b0110011).SetFunct3(0b010).SetFunct2or7(0b1010101).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( erlw )},
    {RevInstDefaults().SetMnemonic("erlh %rd, %rs1, %ext2"     ).SetOpcode(0b0110011).SetFunct3(0b001).SetFunct2or7(0b1010101).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( erlh )},
    {RevInstDefaults().SetMnemonic("erlhu %rd, %rs1, %ext2"    ).SetOpcode(0b0110011).SetFunct3(0b101).SetFunct2or7(0b1010101).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( erlhu)},
    {RevInstDefaults().SetMnemonic("erlb %rd, %rs1, %ext2"     ).SetOpcode(0b0110011).SetFunct3(0b000).SetFunct2or7(0b1010101).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( erlb )},
    {RevInstDefaults().SetMnemonic("erlbu %rd, %rs1, %ext2"    ).SetOpcode(0b0110011).SetFunct3(0b100).SetFunct2or7(0b1010101).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( erlbu)},
    {RevInstDefaults().SetMnemonic("erle %extd, %rs1, %ext2"   ).SetOpcode(0b0110011).SetFunct3(0b100).SetFunct2or7(0b0100001).SetrdClass(RevRegClass::RegUNKNOWN).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( erle )},

    // Raw Store instructions are encoded in the R-type format
    {RevInstDefaults().SetMnemonic("ersd %rs1, %rs2, %ext3"    ).SetOpcode(0b0110011).SetFunct3(0b011).SetFunct2or7(0b0100010).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( ersd )},
    {RevInstDefaults().SetMnemonic("ersw %rs1, %rs2, %ext3"    ).SetOpcode(0b0110011).SetFunct3(0b010).SetFunct2or7(0b0100010).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( ersw )},
    {RevInstDefaults().SetMnemonic("ersh %rs1, %rs2, %ext3"    ).SetOpcode(0b0110011).SetFunct3(0b001).SetFunct2or7(0b0100010).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( ersh )},
    {RevInstDefaults().SetMnemonic("ersb %rs1, %rs2, %ext3"    ).SetOpcode(0b0110011).SetFunct3(0b000).SetFunct2or7(0b0100010).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( ersb )},
    {RevInstDefaults().SetMnemonic("erse %ext1, %rs2, %ext3"   ).SetOpcode(0b0110011).SetFunct3(0b011).SetFunct2or7(0b0100011).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( erse )},

    // Aggreagtion instruction is encoded in the R-type format.
    // {RevInstDefaults().SetMnemonic("eag %rd, %rs1, %rs2"      ).SetOpcode(0b0110011).SetFunct3(0b001).SetFunct2or7(0b0100011).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( eag  )},

    // Address Management Instructions are encoded in the I-type format
    {RevInstDefaults().SetMnemonic("eaddi %rd, %ext1, $imm"    ).SetOpcode(0b1111011).SetFunct3(0b110).SetFunct2or7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( eaddi )},
    {RevInstDefaults().SetMnemonic("eaddie %extd, %rs1, $imm"  ).SetOpcode(0b1111011).SetFunct3(0b111).SetFunct2or7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( eaddie)},
    {RevInstDefaults().SetMnemonic("eaddix %extd, %ext1, $imm" ).SetOpcode(0b0000011).SetFunct3(0b111).SetFunct2or7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegUNKNOWN).Setrs3Class(RevRegClass::RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( eaddix)},

    // Bulk Load instruction is encoded in the R4-type format
    {RevInstDefaults().SetMnemonic("ebld  %rd, %rs1, %rs2, %rs3").SetOpcode(0b1000011).SetFunct2(0b11).SetFunct3(0b011).SetFunct2or7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegGPR    ).SetFormat(RVTypeR4).SetImplFunc(ebld )},
    {RevInstDefaults().SetMnemonic("eblw  %rd, %rs1, %rs2, %rs3").SetOpcode(0b1000011).SetFunct2(0b11).SetFunct3(0b010).SetFunct2or7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegGPR    ).SetFormat(RVTypeR4).SetImplFunc(eblw )},
    {RevInstDefaults().SetMnemonic("eblh  %rd, %rs1, %rs2, %rs3").SetOpcode(0b1000011).SetFunct2(0b11).SetFunct3(0b001).SetFunct2or7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegGPR    ).SetFormat(RVTypeR4).SetImplFunc(eblh )},
    {RevInstDefaults().SetMnemonic("eblhu %rd, %rs1, %rs2, %rs3").SetOpcode(0b1000011).SetFunct2(0b11).SetFunct3(0b101).SetFunct2or7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegGPR    ).SetFormat(RVTypeR4).SetImplFunc(eblhu)},
    {RevInstDefaults().SetMnemonic("eblb  %rd, %rs1, %rs2, %rs3").SetOpcode(0b1000011).SetFunct2(0b11).SetFunct3(0b000).SetFunct2or7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegGPR    ).SetFormat(RVTypeR4).SetImplFunc(eblb )},
    {RevInstDefaults().SetMnemonic("eblbu %rd, %rs1, %rs2, %rs3").SetOpcode(0b1000011).SetFunct2(0b11).SetFunct3(0b100).SetFunct2or7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegGPR    ).SetFormat(RVTypeR4).SetImplFunc(eblbu)},

    // Bulk Store instruction is encoded in the R4-type format
    {RevInstDefaults().SetMnemonic("ebsd  %rd, %rs1, %rs2, %rs3").SetOpcode(0b1000011).SetFunct2(0b10).SetFunct3(0b011).SetFunct2or7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegGPR    ).SetFormat(RVTypeR4).SetImplFunc(ebsd )},
    {RevInstDefaults().SetMnemonic("ebsw  %rd, %rs1, %rs2, %rs3").SetOpcode(0b1000011).SetFunct2(0b10).SetFunct3(0b010).SetFunct2or7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegGPR    ).SetFormat(RVTypeR4).SetImplFunc(ebsw )},
    {RevInstDefaults().SetMnemonic("ebsh  %rd, %rs1, %rs2, %rs3").SetOpcode(0b1000011).SetFunct2(0b10).SetFunct3(0b001).SetFunct2or7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegGPR    ).SetFormat(RVTypeR4).SetImplFunc(ebsh )},
    {RevInstDefaults().SetMnemonic("ebsb  %rd, %rs1, %rs2, %rs3").SetOpcode(0b1000011).SetFunct2(0b10).SetFunct3(0b000).SetFunct2or7(0b0      ).SetrdClass(RevRegClass::RegGPR    ).Setrs1Class(RevRegClass::RegGPR    ).Setrs2Class(RevRegClass::RegGPR    ).Setrs3Class(RevRegClass::RegGPR    ).SetFormat(RVTypeR4).SetImplFunc(ebsb )},
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
