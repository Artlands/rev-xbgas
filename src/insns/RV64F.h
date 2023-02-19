//
// _RV64F_h_
//
// Copyright (C) 2017-2021 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#ifndef _SST_REVCPU_RV64F_H_
#define _SST_REVCPU_RV64F_H_

#define F32_SIZE 32
#define F32_HIGH 0

#include "RevInstTable.h"
#include "RevExt.h"

using namespace SST::RevCPU;

namespace SST{
  namespace RevCPU{
    class RV64F : public RevExt {

      static bool fcvtls(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        RoundingModeEnum rm = static_cast<RoundingModeEnum>(get_insn_rm(R, Inst.rm));
        R->RV64[Inst.rd] = (int32_t)glue(glue(cvt_sf, F32_SIZE), _i64)(R->SFP[Inst.rs1], rm,
                                                                      &R->fflags);
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool fcvtlus(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        RoundingModeEnum rm = static_cast<RoundingModeEnum>(get_insn_rm(R, Inst.rm));
        R->RV64[Inst.rd] = (int32_t)glue(glue(cvt_sf, F32_SIZE), _u64)(R->SFP[Inst.rs1], rm,
                                                                      &R->fflags);
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool fcvtsl(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        RoundingModeEnum rm = static_cast<RoundingModeEnum>(get_insn_rm(R, Inst.rm));
        R->SPF[Inst.rd] = glue(cvt_i64_sf, F32_SIZE)(R->RV64[Inst.rs1], rm,
                                                    &R->fflags) | F32_HIGH;
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool fcvtslu(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        RoundingModeEnum rm = static_cast<RoundingModeEnum>(get_insn_rm(R, Inst.rm));
        R->SPF[Inst.rd] = glue(cvt_u64_sf, F32_SIZE)(R->RV64[Inst.rs1], rm,
                                                    &R->fflags) | F32_HIGH;
        R->RV64_PC += Inst.instSize;
        return true;
      }

      // ----------------------------------------------------------------------
      //
      // RISC-V RV64F Instructions
      //
      // Format:
      // <mnemonic> <cost> <opcode> <funct3> <funct7> <rdClass> <rs1Class>
      //            <rs2Class> <rs3Class> <format> <func> <nullEntry>
      // ----------------------------------------------------------------------
      class Rev64FInstDefaults : public RevInstDefaults {
        public:
        uint8_t opcode = 0b1010011;
        RevRegClass rdClass = RegFLOAT;
        RevRegClass rs1Class = RegFLOAT;
        RevRegClass rs2Class = RegUNKNOWN;
        RevRegClass rs3Class = RegUNKNOWN;
      };

      std::vector<RevInstEntry > RV64FTable = {
      {RevInstEntryBuilder<Rev64FInstDefaults>().SetMnemonic("fcvt.l.s  %rd, %rs1").SetCost(1).SetFunct3( 0b0   ).SetFunct7( 0b1100000 ).Setimm12(0b110000000010).Setimm(FEnc).SetImplFunc( &fcvtls  ).InstEntry},
      {RevInstEntryBuilder<Rev64FInstDefaults>().SetMnemonic("fcvt.lu.s %rd, %rs1").SetCost(1).SetFunct3( 0b0   ).SetFunct7( 0b1100000 ).Setimm12(0b110000000011).Setimm(FEnc).SetImplFunc( &fcvtlus ).InstEntry},
      {RevInstEntryBuilder<Rev64FInstDefaults>().SetMnemonic("fcvt.s.l %rd, %rs1" ).SetCost(1).SetFunct3( 0b0   ).SetFunct7( 0b1101000 ).Setimm12(0b110100000010).Setimm(FEnc).SetImplFunc( &fcvtsl  ).InstEntry},
      {RevInstEntryBuilder<Rev64FInstDefaults>().SetMnemonic("fcvt.s.lu %rd, %rs1").SetCost(1).SetFunct3( 0b0   ).SetFunct7( 0b1101000 ).Setimm12(0b110100000011).Setimm(FEnc).SetImplFunc( &fcvtslu ) .InstEntry}
      };


    public:
      /// RV364F: standard constructor
      RV64F( RevFeature *Feature,
             RevRegFile *RegFile,
             RevMem *RevMem,
             RevXbgas *RevXbgas,
             SST::Output *Output )
        : RevExt( "RV64F", Feature, RegFile, RevMem, RevXbgas, Output) {
          this->SetTable(RV64FTable);
        }

      /// RV64F: standard destructor
      ~RV64F() { }

    }; // end class RV32I
  } // namespace RevCPU
} // namespace SST

#endif
