//
// _RV32F_h_
//
// Copyright (C) 2017-2021 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#ifndef _SST_REVCPU_RV32F_H_
#define _SST_REVCPU_RV32F_H_

#define F32_SIZE 32
#define F32_HIGH 0

#include "RevInstTable.h"
#include "RevExt.h"

#include "../softfp/cutils.h"
#include "../softfp/softfloat.h"
#include "../softfp/softfp.h"

using namespace SST::RevCPU;

namespace SST{
  namespace RevCPU{
    class RV32F : public RevExt {

      // Compressed instructions
      static bool cflwsp(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // c.flwsp rd, $imm = lw rd, x2, $imm
        Inst.rs1  = 2;

        return flw(F,R,M,Xbgas,Inst);
      }

      static bool cfswsp(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // c.swsp rs2, $imm = sw rs2, x2, $imm
        Inst.rs1  = 2;

        return fsw(F,R,M,Xbgas,Inst);
      }

      static bool cflw(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // c.flw %rd, %rs1, $imm = flw %rd, %rs1, $imm
        Inst.rd  = CRegMap[Inst.rd];
        Inst.rs1 = CRegMap[Inst.rs1];

        return flw(F,R,M,Xbgas,Inst);
      }

      static bool cfsw(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // c.fsw rs2, rs1, $imm = fsw rs2, $imm(rs1)
        Inst.rs2 = CRegMap[Inst.rd];
        Inst.rs1 = CRegMap[Inst.rs1];

        return fsw(F,R,M,Xbgas,Inst);
      }

      // Standard instructions
      static bool flw(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
          R->SFP[Inst.rd] = M->ReadU32((uint64_t)(R->RV32[Inst.rs1]+(int32_t)(td_u32(Inst.imm,12))));
          R->RV32_PC += Inst.instSize;
        }else{
          R->SFP[Inst.rd] = M->ReadU32((uint64_t)(R->RV64[Inst.rs1]+(int32_t)(td_u32(Inst.imm,12))));
          R->RV64_PC += Inst.instSize;
        }
        R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
        return true;
      }

      static bool fsw(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
           M->WriteU32((uint64_t)(R->RV32[Inst.rs1]+(int32_t)(td_u32(Inst.imm,12))), R->SFP[Inst.rs2]);
          R->RV32_PC += Inst.instSize;
        }else{
          M->WriteU32((uint64_t)(R->RV64[Inst.rs1]+(int32_t)(td_u32(Inst.imm,12))), R->SFP[Inst.rs2]);
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool fmadds(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        RoundingModeEnum rm = static_cast<RoundingModeEnum>(get_insn_rm(R, Inst.rm));
        R->SFP[Inst.rd] = fma_sf32(R->SFP[Inst.rs1], R->SFP[Inst.rs2],
                                   R->SFP[Inst.rs3], rm, &R->fflags) | F32_HIGH;

        if( F->IsRV32() ){
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool fmsubs(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        RoundingModeEnum rm = static_cast<RoundingModeEnum>(get_insn_rm(R, Inst.rm));
        R->SFP[Inst.rd] = fma_sf32(R->SFP[Inst.rs1], 
                                   R->SFP[Inst.rs2],
                                   R->SFP[Inst.rs3] ^ FSIGN_MASK32, 
                                   rm, &R->fflags) | F32_HIGH;

        if( F->IsRV32() ){
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      // Be Careful: FNMSUB.S computes -(rs1×rs2)+rs3.
      static bool fnmsubs(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        RoundingModeEnum rm = static_cast<RoundingModeEnum>(get_insn_rm(R, Inst.rm));
        R->SFP[Inst.rd] = fma_sf32(R->SFP[Inst.rs1] ^ FSIGN_MASK32,
                                   R->SFP[Inst.rs2],
                                   R->SFP[Inst.rs3], 
                                   rm, &R->fflags) | F32_HIGH;

        if( F->IsRV32() ){
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      // Be Careful: FNMADD.S computes -(rs1×rs2)-rs3.
      static bool fnmadds(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        RoundingModeEnum rm = static_cast<RoundingModeEnum>(get_insn_rm(R, Inst.rm));
        R->SFP[Inst.rd] = fma_sf32(R->SFP[Inst.rs1] ^ FSIGN_MASK32,
                                   R->SFP[Inst.rs2],
                                   R->SFP[Inst.rs3] ^ FSIGN_MASK32,
                                   rm, &R->fflags) | F32_HIGH;
          
        if( F->IsRV32() ){
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool fadds(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        RoundingModeEnum rm = static_cast<RoundingModeEnum>(get_insn_rm(R, Inst.rm));
        R->SFP[Inst.rd] = glue(add_sf, F32_SIZE)(R->SFP[Inst.rs1],
                                                 R->SFP[Inst.rs2],
                                                 rm, 
                                                 &R->fflags) | F32_HIGH;
        if( F->IsRV32() ){
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool fsubs(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        RoundingModeEnum rm = static_cast<RoundingModeEnum>(get_insn_rm(R, Inst.rm));
        R->SFP[Inst.rd] = glue(sub_sf, F32_SIZE)(R->SFP[Inst.rs1],
                                                 R->SFP[Inst.rs2],
                                                 rm, 
                                                 &R->fflags) | F32_HIGH;
        if( F->IsRV32() ){
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool fmuls(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        RoundingModeEnum rm = static_cast<RoundingModeEnum>(get_insn_rm(R, Inst.rm));
        R->SFP[Inst.rd] = glue(mul_sf, F32_SIZE)(R->SFP[Inst.rs1],
                                                 R->SFP[Inst.rs2],
                                                 rm, 
                                                 &R->fflags) | F32_HIGH;
        if( F->IsRV32() ){
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool fdivs(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        RoundingModeEnum rm = static_cast<RoundingModeEnum>(get_insn_rm(R, Inst.rm));
        R->SFP[Inst.rd] = glue(div_sf, F32_SIZE)(R->SFP[Inst.rs1],
                                                 R->SFP[Inst.rs2],
                                                 rm, 
                                                 &R->fflags) | F32_HIGH;
        if( F->IsRV32() ){
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool fsqrts(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        RoundingModeEnum rm = static_cast<RoundingModeEnum>(get_insn_rm(R, Inst.rm));
        R->SFP[Inst.rd] = glue(sqrt_sf, F32_SIZE)(R->SFP[Inst.rs1],
                                                  rm, 
                                                  &R->fflags) | F32_HIGH;
        if( F->IsRV32() ){
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool fsgnjs(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        R->SFP[Inst.rd] = (R->SFP[Inst.rs1] & ~FSIGN_MASK32) |
                          (R->SFP[Inst.rs2] & FSIGN_MASK32);

        if( F->IsRV32() ){
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      // FSGNJN, the result’s sign bit is the opposite of rs2’s sign bit
      static bool fsgnjns(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        R->SFP[Inst.rd] = (R->SFP[Inst.rs1] & ~FSIGN_MASK32) |
                         ((R->SFP[Inst.rs2] & FSIGN_MASK32) ^ FSIGN_MASK32);

        if( F->IsRV32() ){
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool fsgnjxs(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        R->SFP[Inst.rd] = R->SFP[Inst.rs1] ^
                         (R->SFP[Inst.rs2] & FSIGN_MASK32);
        
        if( F->IsRV32() ){
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool fmins(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        R->SFP[Inst.rd] = glue(min_sf, F32_SIZE)(R->SFP[Inst.rs1],
                                                 R->SFP[Inst.rs2],
                                                 &R->fflags);

        if( F->IsRV32() ){
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool fmaxs(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        R->SFP[Inst.rd] = glue(max_sf, F32_SIZE)(R->SFP[Inst.rs1],
                                                 R->SFP[Inst.rs2],
                                                 &R->fflags);
        
        if( F->IsRV32() ){
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool fcvtws(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        RoundingModeEnum rm = static_cast<RoundingModeEnum>(get_insn_rm(R, Inst.rm));
        if( F->IsRV32() ){
          R->RV32[Inst.rd] = (int32_t)glue(glue(cvt_sf, F32_SIZE), _i32)(R->SFP[Inst.rs1], rm,
                                                                        &R->fflags);
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64[Inst.rd] = (int32_t)glue(glue(cvt_sf, F32_SIZE), _i32)(R->SFP[Inst.rs1], rm,
                                                                        &R->fflags);
          R->RV64_PC += Inst.instSize;
        }

        return true;
      }

      static bool fcvtwus(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        RoundingModeEnum rm = static_cast<RoundingModeEnum>(get_insn_rm(R, Inst.rm));
        if( F->IsRV32() ){
          R->RV32[Inst.rd] = (int32_t)glue(glue(cvt_sf, F32_SIZE), _u32)(R->SFP[Inst.rs1], rm,
                                                                      &R->fflags);
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64[Inst.rd] = (int32_t)glue(glue(cvt_sf, F32_SIZE), _u32)(R->SFP[Inst.rs1], rm,
                                                                      &R->fflags);
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool fmvxw(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
          R->RV32[Inst.rd] = (int32_t)R->SFP[Inst.rs1];
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64[Inst.rd] = (int32_t)R->SFP[Inst.rs1];
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool feqs(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
          R->RV32[Inst.rd] = glue(eq_quiet_sf, F32_SIZE)(R->SFP[Inst.rs1], R->SFP[Inst.rs2],
                                                        &R->fflags);
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64[Inst.rd] = glue(eq_quiet_sf, F32_SIZE)(R->SFP[Inst.rs1], R->SFP[Inst.rs2],
                                                        &R->fflags);
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool flts(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
          R->RV32[Inst.rd] = glue(lt_sf, F32_SIZE)(R->SFP[Inst.rs1], R->SFP[Inst.rs2],
                                                  &R->fflags);
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64[Inst.rd] = glue(lt_sf, F32_SIZE)(R->SFP[Inst.rs1], R->SFP[Inst.rs2],
                                                  &R->fflags);
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool fles(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
          R->RV32[Inst.rd] = glue(le_sf, F32_SIZE)(R->SFP[Inst.rs1], R->SFP[Inst.rs2],
                                                  &R->fflags);
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64[Inst.rd] = glue(le_sf, F32_SIZE)(R->SFP[Inst.rs1], R->SFP[Inst.rs2],
                                                  &R->fflags);
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool fclasss(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // see: https://github.com/riscv/riscv-isa-sim/blob/master/softfloat/f32_classify.c
        if( F->IsRV32() ) {
          R->RV32[Inst.rd] = glue(fclass_sf, F32_SIZE)(R->SFP[Inst.rs1]);
          R->RV32_PC += Inst.instSize;
        } else {
          R->RV64[Inst.rd] = glue(fclass_sf, F32_SIZE)(R->SFP[Inst.rs1]);
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool fcvtsw(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        RoundingModeEnum rm = static_cast<RoundingModeEnum>(get_insn_rm(R, Inst.rm));
        if( F->IsRV32() ){
          R->SFP[Inst.rd] = glue(cvt_i32_sf, F32_SIZE)(R->RV32[Inst.rs1], rm,
                                                      &R->fflags) | F32_HIGH;
          R->RV32_PC += Inst.instSize;
        }else{
          R->SFP[Inst.rd] = glue(cvt_i32_sf, F32_SIZE)(R->RV64[Inst.rs1], rm,
                                                    &R->fflags) | F32_HIGH;
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool fcvtswu(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        RoundingModeEnum rm = static_cast<RoundingModeEnum>(get_insn_rm(R, Inst.rm));
        if( F->IsRV32() ){
          R->SFP[Inst.rd] = glue(cvt_u32_sf, F32_SIZE)(R->RV32[Inst.rs1], rm,
                                                    &R->fflags) | F32_HIGH;
          R->RV32_PC += Inst.instSize;
        }else{
          R->SFP[Inst.rd] = glue(cvt_u32_sf, F32_SIZE)(R->RV64[Inst.rs1], rm,
                                                    &R->fflags) | F32_HIGH;
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool fmvwx(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
          R->SFP[Inst.rd] = (int32_t)R->RV32[Inst.rs1];
          R->RV32_PC += Inst.instSize;
        }else{
          R->SFP[Inst.rd] = (int32_t)R->RV64[Inst.rs1];
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      // ----------------------------------------------------------------------
      //
      // RISC-V RV32F Instructions
      //
      // Format:
      // <mnemonic> <cost> <opcode> <funct3> <funct7> <rdClass> <rs1Class>
      //            <rs2Class> <rs3Class> <format> <func> <nullEntry>
      // ----------------------------------------------------------------------
      class Rev32FInstDefaults : public RevInstDefaults {
        public:
        RevRegClass rdClass   = RegFLOAT;
        RevRegClass rs1Class  = RegFLOAT;
        RevRegClass rs2Class  = RegFLOAT;
        RevRegClass rs3Class  = RegFLOAT;
      };

      std::vector<RevInstEntry>RV32FTable = {
        {RevInstEntryBuilder<Rev32FInstDefaults>().SetMnemonic("flw %rd, $imm(%rs1)"	         ).SetCost(1).SetOpcode( 0b0000111 ).SetFunct3( 0b010 ).SetFunct7( 0b0       ).SetrdClass(RegFLOAT  ).Setrs1Class(RegGPR  ).Setrs2Class(RegUNKNOWN).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI ).SetImplFunc( &flw ).InstEntry},
        {RevInstEntryBuilder<Rev32FInstDefaults>().SetMnemonic("fsw %rs2, $imm(%rs1)"	         ).SetCost(1).SetOpcode( 0b0100111 ).SetFunct3( 0b010 ).SetFunct7( 0b0       ).SetrdClass(RegIMM    ).Setrs1Class(RegGPR  ).Setrs2Class(RegFLOAT  ).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeS ).SetImplFunc( &fsw ).InstEntry},
        
        {RevInstEntryBuilder<Rev32FInstDefaults>().SetMnemonic("fmadd.s %rd, %rs1, %rs2, %rs3" ).SetCost(1).SetOpcode( 0b1000011 ).SetFunct3( 0b0   ).SetFunct7( 0b0       ).SetrdClass(RegFLOAT  ).Setrs1Class(RegFLOAT).Setrs2Class(RegFLOAT  ).Setrs3Class(RegFLOAT  ).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR4).SetImplFunc( &fmadds ).InstEntry},
        {RevInstEntryBuilder<Rev32FInstDefaults>().SetMnemonic("fmsub.s %rd, %rs1, %rs2, %rs3" ).SetCost(1).SetOpcode( 0b1000111 ).SetFunct3( 0b0   ).SetFunct7( 0b0       ).SetrdClass(RegFLOAT  ).Setrs1Class(RegFLOAT).Setrs2Class(RegFLOAT  ).Setrs3Class(RegFLOAT  ).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR4).SetImplFunc( &fmsubs ).InstEntry},
        {RevInstEntryBuilder<Rev32FInstDefaults>().SetMnemonic("fnmsub.s %rd, %rs1, %rs2, %rs3").SetCost(1).SetOpcode( 0b1001011 ).SetFunct3( 0b0   ).SetFunct7( 0b0       ).SetrdClass(RegFLOAT  ).Setrs1Class(RegFLOAT).Setrs2Class(RegFLOAT  ).Setrs3Class(RegFLOAT  ).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR4).SetImplFunc( &fnmsubs ).InstEntry},
        {RevInstEntryBuilder<Rev32FInstDefaults>().SetMnemonic("fnmadd.s %rd, %rs1, %rs2, %rs3").SetCost(1).SetOpcode( 0b1001111 ).SetFunct3( 0b0   ).SetFunct7( 0b0       ).SetrdClass(RegFLOAT  ).Setrs1Class(RegFLOAT).Setrs2Class(RegFLOAT  ).Setrs3Class(RegFLOAT  ).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR4).SetImplFunc( &fnmadds ).InstEntry},
        
        {RevInstEntryBuilder<Rev32FInstDefaults>().SetMnemonic("fadd.s %rd, %rs1, %rs2"	       ).SetCost(1).SetOpcode( 0b1010011 ).SetFunct3( 0b0   ).SetFunct7( 0b0000000 ).SetrdClass(RegFLOAT  ).Setrs1Class(RegFLOAT).Setrs2Class(RegFLOAT  ).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR ).SetImplFunc( &fadds ).InstEntry},
        {RevInstEntryBuilder<Rev32FInstDefaults>().SetMnemonic("fsub.s %rd, %rs1, %rs2"	       ).SetCost(1).SetOpcode( 0b1010011 ).SetFunct3( 0b0   ).SetFunct7( 0b0000100 ).SetrdClass(RegFLOAT  ).Setrs1Class(RegFLOAT).Setrs2Class(RegFLOAT  ).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR ).SetImplFunc( &fsubs ).InstEntry},
        {RevInstEntryBuilder<Rev32FInstDefaults>().SetMnemonic("fmul.s %rd, %rs1, %rs2"	       ).SetCost(1).SetOpcode( 0b1010011 ).SetFunct3( 0b0   ).SetFunct7( 0b0001000 ).SetrdClass(RegFLOAT  ).Setrs1Class(RegFLOAT).Setrs2Class(RegFLOAT  ).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR ).SetImplFunc( &fmuls ).InstEntry},
        {RevInstEntryBuilder<Rev32FInstDefaults>().SetMnemonic("fdiv.s %rd, %rs1, %rs2"	       ).SetCost(1).SetOpcode( 0b1010011 ).SetFunct3( 0b0   ).SetFunct7( 0b0001100 ).SetrdClass(RegFLOAT  ).Setrs1Class(RegFLOAT).Setrs2Class(RegFLOAT  ).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR ).SetImplFunc( &fdivs ).InstEntry},
        {RevInstEntryBuilder<Rev32FInstDefaults>().SetMnemonic("fsqrt.s %rd, %rs1"	           ).SetCost(1).SetOpcode( 0b1010011 ).SetFunct3( 0b0   ).SetFunct7( 0b0101100 ).SetrdClass(RegFLOAT  ).Setrs1Class(RegFLOAT).Setrs2Class(RegUNKNOWN).Setrs3Class(RegUNKNOWN).Setimm12(0b010110000000).Setimm(FEnc).SetFormat(RVTypeR ).SetImplFunc( &fsqrts ).InstEntry},
        
        {RevInstEntryBuilder<Rev32FInstDefaults>().SetMnemonic("fsgnj.s %rd, %rs1, %rs2"	     ).SetCost(1).SetOpcode( 0b1010011 ).SetFunct3( 0b000	).SetFunct7( 0b0010000 ).SetrdClass(RegFLOAT  ).Setrs1Class(RegFLOAT).Setrs2Class(RegFLOAT  ).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &fsgnjs ).InstEntry},
        {RevInstEntryBuilder<Rev32FInstDefaults>().SetMnemonic("fsgnjn.s %rd, %rs1, %rs2"	     ).SetCost(1).SetOpcode( 0b1010011 ).SetFunct3( 0b001	).SetFunct7( 0b0010000 ).SetrdClass(RegFLOAT  ).Setrs1Class(RegFLOAT).Setrs2Class(RegFLOAT  ).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &fsgnjns ).InstEntry},
        {RevInstEntryBuilder<Rev32FInstDefaults>().SetMnemonic("fsgnjx.s %rd, %rs1, %rs2"	     ).SetCost(1).SetOpcode( 0b1010011 ).SetFunct3( 0b010	).SetFunct7( 0b0010000 ).SetrdClass(RegFLOAT  ).Setrs1Class(RegFLOAT).Setrs2Class(RegFLOAT  ).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &fsgnjxs ).InstEntry},
        {RevInstEntryBuilder<Rev32FInstDefaults>().SetMnemonic("fmin.s %rd, %rs1, %rs2"	       ).SetCost(1).SetOpcode( 0b1010011 ).SetFunct3( 0b000	).SetFunct7( 0b0010100 ).SetrdClass(RegFLOAT  ).Setrs1Class(RegFLOAT).Setrs2Class(RegFLOAT  ).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &fmins ).InstEntry},
        {RevInstEntryBuilder<Rev32FInstDefaults>().SetMnemonic("fmax.s %rd, %rs1, %rs2"	       ).SetCost(1).SetOpcode( 0b1010011 ).SetFunct3( 0b001	).SetFunct7( 0b0010100 ).SetrdClass(RegFLOAT  ).Setrs1Class(RegFLOAT).Setrs2Class(RegFLOAT  ).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &fmaxs ).InstEntry},
        
        {RevInstEntryBuilder<Rev32FInstDefaults>().SetMnemonic("fcvt.w.s %rd, %rs1"	           ).SetCost(1).SetOpcode( 0b1010011 ).SetFunct3( 0b0   ).SetFunct7( 0b1100000 ).SetrdClass(RegGPR    ).Setrs1Class(RegFLOAT).Setrs2Class(RegUNKNOWN).Setrs3Class(RegUNKNOWN).Setimm12(0b110000000000).Setimm(FEnc).SetFormat(RVTypeR).SetImplFunc( &fcvtws  ).InstEntry},
        {RevInstEntryBuilder<Rev32FInstDefaults>().SetMnemonic("fcvt.wu.s %rd, %rs1"           ).SetCost(1).SetOpcode( 0b1010011 ).SetFunct3( 0b0   ).SetFunct7( 0b1100000 ).SetrdClass(RegGPR    ).Setrs1Class(RegFLOAT).Setrs2Class(RegUNKNOWN).Setrs3Class(RegUNKNOWN).Setimm12(0b110000000001).Setimm(FEnc).SetFormat(RVTypeR).SetImplFunc( &fcvtwus ).InstEntry},
        {RevInstEntryBuilder<Rev32FInstDefaults>().SetMnemonic("fmv.x.w %rd, %rs1"	           ).SetCost(1).SetOpcode( 0b1010011 ).SetFunct3( 0b000 ).SetFunct7( 0b1110000 ).SetrdClass(RegGPR    ).Setrs1Class(RegFLOAT).Setrs2Class(RegUNKNOWN).Setrs3Class(RegUNKNOWN).Setimm12(0b111000000000).Setimm(FEnc).SetFormat(RVTypeR).SetImplFunc( &fmvxw   ).InstEntry},
        
        {RevInstEntryBuilder<Rev32FInstDefaults>().SetMnemonic("feq.s %rd, %rs1, %rs2"	       ).SetCost(1).SetOpcode( 0b1010011 ).SetFunct3( 0b010	).SetFunct7( 0b1010000 ).SetrdClass(RegGPR    ).Setrs1Class(RegFLOAT).Setrs2Class(RegFLOAT  ).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &feqs ).InstEntry},
        {RevInstEntryBuilder<Rev32FInstDefaults>().SetMnemonic("flt.s %rd, %rs1, %rs2"	       ).SetCost(1).SetOpcode( 0b1010011 ).SetFunct3( 0b001	).SetFunct7( 0b1010000 ).SetrdClass(RegGPR    ).Setrs1Class(RegFLOAT).Setrs2Class(RegFLOAT  ).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &flts ).InstEntry},
        {RevInstEntryBuilder<Rev32FInstDefaults>().SetMnemonic("fle.s %rd, %rs1, %rs2"	       ).SetCost(1).SetOpcode( 0b1010011 ).SetFunct3( 0b000	).SetFunct7( 0b1010000 ).SetrdClass(RegGPR    ).Setrs1Class(RegFLOAT).Setrs2Class(RegFLOAT  ).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &fles ).InstEntry},
        
        {RevInstEntryBuilder<Rev32FInstDefaults>().SetMnemonic("fclass.s %rd, %rs1"	           ).SetCost(1).SetOpcode( 0b1010011 ).SetFunct3( 0b001	).SetFunct7( 0b1110000 ).SetrdClass(RegGPR    ).Setrs1Class(RegFLOAT).Setrs2Class(RegUNKNOWN).Setrs3Class(RegUNKNOWN).Setimm12(0b111000000000).Setimm(FEnc).SetFormat(RVTypeR).SetImplFunc( &fclasss ).InstEntry},
        
        {RevInstEntryBuilder<Rev32FInstDefaults>().SetMnemonic("fcvt.s.w %rd, %rs1"	           ).SetCost(1).SetOpcode( 0b1010011 ).SetFunct3( 0b0   ).SetFunct7( 0b1101000 ).SetrdClass(RegFLOAT  ).Setrs1Class(RegGPR  ).Setrs2Class(RegUNKNOWN).Setrs3Class(RegUNKNOWN).Setimm12(0b110100000000).Setimm(FEnc).SetFormat(RVTypeR).SetImplFunc( &fcvtsw ).InstEntry},
        {RevInstEntryBuilder<Rev32FInstDefaults>().SetMnemonic("fcvt.s.wu %rd, %rs1"	         ).SetCost(1).SetOpcode( 0b1010011 ).SetFunct3( 0b0   ).SetFunct7( 0b1101000 ).SetrdClass(RegFLOAT  ).Setrs1Class(RegGPR  ).Setrs2Class(RegUNKNOWN).Setrs3Class(RegUNKNOWN).Setimm12(0b110100000001).Setimm(FEnc).SetFormat(RVTypeR).SetImplFunc( &fcvtswu).InstEntry},
        {RevInstEntryBuilder<Rev32FInstDefaults>().SetMnemonic("fmv.w.x %rd, %rs1"	           ).SetCost(1).SetOpcode( 0b1010011 ).SetFunct3( 0b000 ).SetFunct7( 0b1111000 ).SetrdClass(RegFLOAT  ).Setrs1Class(RegGPR  ).Setrs3Class(RegUNKNOWN).Setrs3Class(RegUNKNOWN).Setimm12(0b111100000000).Setimm(FEnc).SetFormat(RVTypeR).SetImplFunc( &fmvwx  ).InstEntry}
      };

      std::vector<RevInstEntry> RV32FCOTable = {
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.flwsp %rd, $imm"                ).SetCost(1).SetOpcode( 0b10      ).SetFunct3( 0b011 ).SetFunct7( 0b0      ).SetrdClass(RegFLOAT  ).Setrs1Class(RegUNKNOWN).Setrs2Class(RegUNKNOWN).Setimm(FVal).SetFormat(RVCTypeCSS).SetImplFunc( &cflwsp ).SetCompressed(true).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.fswsp %rs2, $imm"               ).SetCost(1).SetOpcode( 0b10      ).SetFunct3( 0b111 ).SetFunct7( 0b0      ).SetrdClass(RegUNKNOWN).Setrs1Class(RegUNKNOWN).Setrs2Class(RegFLOAT  ).Setimm(FVal).SetFormat(RVCTypeCSS).SetImplFunc( &cfswsp ).SetCompressed(true).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.flw %rd, %rs1, $imm"            ).SetCost(1).SetOpcode( 0b00      ).SetFunct3( 0b011 ).SetFunct7( 0b0      ).SetrdClass(RegFLOAT  ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVCTypeCL ).SetImplFunc( &cflw   ).SetCompressed(true).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.fsw %rs2, %rs1, $imm"           ).SetCost(1).SetOpcode( 0b00      ).SetFunct3( 0b111 ).SetFunct7( 0b0      ).SetrdClass(RegUNKNOWN).Setrs1Class(RegGPR    ).Setrs2Class(RegFLOAT  ).Setimm(FImm).SetFormat(RVCTypeCL ).SetImplFunc( &cfsw   ).SetCompressed(true).InstEntry}
      };

    public:
      /// RV32F: standard constructor
      RV32F( RevFeature *Feature,
             RevRegFile *RegFile,
             RevMem *RevMem,
             RevXbgas *RevXbgas,
             SST::Output *Output )
        : RevExt( "RV32F", Feature, RegFile, RevMem, RevXbgas, Output) {
          this->SetTable(RV32FTable);
          this->SetOTable(RV32FCOTable);
        }

      /// RV32F: standard destructor
      ~RV32F() { }

    }; // end class RV32F
  } // namespace RevCPU
} // namespace SST

#endif
