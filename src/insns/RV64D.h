//
// _RV64D_h_
//
// Copyright (C) 2017-2021 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#ifndef _SST_REVCPU_RV64D_H_
#define _SST_REVCPU_RV64D_H_

#include "RevInstTable.h"
#include "RevExt.h"

#define F64_SIZE 64
#define F64_HIGH ((uint64_t)-1 << 32)

using namespace SST::RevCPU;

namespace SST{
  namespace RevCPU{
    class RV64D : public RevExt {

      static bool fcvtld(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        RoundingModeEnum rm = static_cast<RoundingModeEnum>(get_insn_rm(R, Inst.rm));
        R->DPF[Inst.rd] = (int64_t)glue(glue(cvt_sf, F64_SIZE), _i64)(R->RV64[Inst.rs1], rm,
                                                                     &R->fflags);
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool fcvtlud(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        RoundingModeEnum rm = static_cast<RoundingModeEnum>(get_insn_rm(R, Inst.rm));
        R->DPF[Inst.rd] = (int64_t)glue(glue(cvt_sf, F64_SIZE), _u64)(R->RV64[Inst.rs1], rm,
                                                                     &R->fflags);
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool fmvxd(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // std::memcpy(&R->RV64[Inst.rd],&R->DPF[Inst.rs1],sizeof(double));
        R->RV64[Inst.rd] = (int64_t)(R->DPF[Inst.rs1]);
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool fcvtdl(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        RoundingModeEnum rm = static_cast<RoundingModeEnum>(get_insn_rm(R, Inst.rm));
        R->DPF[Inst.rd] = glue(cvt_i64_sf, F64_SIZE)(R->RV64[Inst.rs1], rm,
                                                    &R->fflags) | F64_HIGH;
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool fcvtdlu(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        RoundingModeEnum rm = static_cast<RoundingModeEnum>(get_insn_rm(R, Inst.rm));
        R->DPF[Inst.rd] = glue(cvt_u64_sf, F64_SIZE)(R->RV64[Inst.rs1], rm,
                                                    &R->fflags) | F64_HIGH;
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool fmvdx(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // std::memcpy(&R->DPF[Inst.rd],&R->RV64[Inst.rs1],sizeof(double));
        R->DPF[Inst.rd] = (int64_t)(R->RV64[Inst.rd]);
        R->RV64_PC += Inst.instSize;
        return true;
      }

      // ----------------------------------------------------------------------
      //
      // RISC-V RV64D Instructions
      //
      // Format:
      // <mnemonic> <cost> <opcode> <funct3> <funct7> <rdClass> <rs1Class>
      //            <rs2Class> <rs3Class> <format> <func> <nullEntry>
      // ----------------------------------------------------------------------
      class Rev64DInstDefaults : public RevInstDefaults {
        public:
        uint8_t opcode = 0b1010011;
        RevRegClass rdClass = RegFLOAT;
        RevRegClass rs1Class = RegFLOAT;
        RevRegClass rs2Class = RegUNKNOWN;
        RevRegClass rs3Class = RegUNKNOWN;
      };
      std::vector<RevInstEntry> RV64DTable = {
        {RevInstEntryBuilder<Rev64DInstDefaults>().SetMnemonic("fcvt.l.d %rd, %rs1"  ).SetCost(1).SetFunct3( 0b0   ).SetFunct7( 0b1100001 ).Setimm12(0b110000100010).Setimm(FEnc).SetImplFunc( &fcvtld  ).InstEntry},
        {RevInstEntryBuilder<Rev64DInstDefaults>().SetMnemonic("fcvt.lu.d %rd, %rs1" ).SetCost(1).SetFunct3( 0b0   ).SetFunct7( 0b1100001 ).Setimm12(0b110000100011).Setimm(FEnc).SetImplFunc( &fcvtlud ).InstEntry},
        {RevInstEntryBuilder<Rev64DInstDefaults>().SetMnemonic("fmv.x.d %rd, %rs1"   ).SetCost(1).SetFunct3( 0b000 ).SetFunct7( 0b1110001 ).Setimm12(0b111000100000).Setimm(FEnc).SetImplFunc( &fmvxd   ).InstEntry},
        {RevInstEntryBuilder<Rev64DInstDefaults>().SetMnemonic("fcvt.d.l %rd, %rs1"  ).SetCost(1).SetFunct3( 0b0   ).SetFunct7( 0b1101001 ).Setimm12(0b110100100010).Setimm(FEnc).SetImplFunc( &fcvtdl  ).InstEntry},
        {RevInstEntryBuilder<Rev64DInstDefaults>().SetMnemonic("fcvt.d.lu %rd, %rs1" ).SetCost(1).SetFunct3( 0b0   ).SetFunct7( 0b1101001 ).Setimm12(0b110100100011).Setimm(FEnc).SetImplFunc( &fcvtdlu ).InstEntry},
        {RevInstEntryBuilder<Rev64DInstDefaults>().SetMnemonic("fmv.d.x %rd, %rs1"   ).SetCost(1).SetFunct3( 0b000 ).SetFunct7( 0b1111001 ).Setimm12(0b111100100000).Setimm(FEnc).SetImplFunc( &fmvdx   ).InstEntry},
      };


    public:
      /// RV364D: standard constructor
      RV64D( RevFeature *Feature,
             RevRegFile *RegFile,
             RevMem *RevMem,
             RevXbgas *RevXbgas,
             SST::Output *Output )
        : RevExt( "RV64D", Feature, RegFile, RevMem, RevXbgas, Output) {
          this->SetTable(RV64DTable);
        }

      /// RV364D: standard destructor
      ~RV64D() { }

    }; // end class RV32I
  } // namespace RevCPU
} // namespace SST

#endif
