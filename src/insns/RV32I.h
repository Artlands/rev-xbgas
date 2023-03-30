//
// _RV32I_h_
//
// Copyright (C) 2017-2021 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#ifndef _SST_REVCPU_RV32I_H_
#define _SST_REVCPU_RV32I_H_

#include "RevInstTable.h"
#include "RevExt.h"
#include "RevSysCalls.h"

using namespace SST::RevCPU;

namespace SST{
  namespace RevCPU{
    class RV32I : public RevExt {

      // Compressed instructions
      static bool caddi4spn(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // c.addi4spn rd, $imm == addi rd, x2, $imm
        uint32_t Tmp32;
        uint64_t Tmp64;
        Inst.rs1  = 2;
        Inst.rd   = CRegMap[Inst.crd];
        if( (Inst.imm != 0) && (Inst.rd != 0)) {
          if( F->IsRV32() ){
            ZEXT(Tmp32, Inst.imm, 10);
            R->RV32[Inst.rd] = R->RV32[Inst.rs1] + Tmp32;
            R->RV32_PC += Inst.instSize;
          }else{
            ZEXT(Tmp64, Inst.imm, 10);
            R->RV64[Inst.rd] = R->RV64[Inst.rs1] + Tmp64;
            R->RV64_PC += Inst.instSize;
          }
          return true;
        }
        return false;
      }

      static bool cnop(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        //C.NOP does not change any user-visible state, except for advancing the pc
        if( F->IsRV32() ){
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool clwsp(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // c.lwsp rd, $imm = lw rd, offset[7:2](x2).
        uint32_t Tmp32;
        uint64_t Tmp64;
        Inst.rs1  = 2;
        if( F->IsRV32() ){
          ZEXT(Tmp32, Inst.imm, 8);
          SEXT(R->RV32[Inst.rd], M->ReadU32((uint64_t)(R->RV32[Inst.rs1] + Tmp32)), 32);
          R->RV32_PC += Inst.instSize;
        }else{
          ZEXT(Tmp64, Inst.imm, 8);
          SEXT(R->RV64[Inst.rd], M->ReadU32((uint64_t)(R->RV64[Inst.rs1] + Tmp64)), 32);
          R->RV64_PC += Inst.instSize;
        }
        // update the cost
        R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
        return true;
      }

      static bool cswsp(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // c.swsp rs2, $imm = sw rs2, x2, $imm
        uint32_t Tmp32;
        uint64_t Tmp64;
        Inst.rs1  = 2;
        if( F->IsRV32() ){
          ZEXT(Tmp32, Inst.imm, 8);
          M->WriteU32((uint64_t)(R->RV32[Inst.rs1] + Tmp32), (R->RV32[Inst.rs2] & MASK32));
          R->RV32_PC += Inst.instSize;
        }else{
          ZEXT(Tmp64, Inst.imm, 8);
          M->WriteU32((uint64_t)(R->RV64[Inst.rs1] + Tmp64), (R->RV64[Inst.rs2] & MASK32));
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool clw(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // c.lw rd, rs1, $imm = lw rd, $imm(rs1)
        uint32_t Tmp32;
        uint64_t Tmp64;
        Inst.rd  = CRegMap[Inst.crd];
        Inst.rs1 = CRegMap[Inst.crs1];
        if( F->IsRV32() ){
          ZEXT(Tmp32, Inst.imm, 7);
          SEXT(R->RV32[Inst.rd], M->ReadU32((uint64_t)(R->RV32[Inst.rs1] + Tmp32)), 32);
          R->RV32_PC += Inst.instSize;
        }else{
          ZEXT(Tmp64, Inst.imm, 7);
          SEXT(R->RV64[Inst.rd], M->ReadU32((uint64_t)(R->RV64[Inst.rs1] + Tmp64)), 32);
          R->RV64_PC += Inst.instSize;
        }
        // update the cost
        R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
        return true;
      }

      static bool csw(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // c.sw rs2, rs1, $imm = sw rs2, $imm(rs1)
        uint32_t Tmp32;
        uint64_t Tmp64;
        Inst.rs2 = CRegMap[Inst.crs2];
        Inst.rs1 = CRegMap[Inst.crs1];
        if( F->IsRV32() ){
          ZEXT(Tmp32, Inst.imm, 7);
          M->WriteU32((uint64_t)(R->RV32[Inst.rs1] + Tmp32), (R->RV32[Inst.rs2] & MASK32));
          R->RV32_PC += Inst.instSize;
        }else{
          ZEXT(Tmp64, Inst.imm, 7);
          M->WriteU32((uint64_t)(R->RV64[Inst.rs1] + Tmp64), (R->RV64[Inst.rs2] & MASK32));
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool cj(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // c.j $imm = jal x0, $imm
        uint32_t Tmp32;
        uint64_t Tmp64;
        Inst.imm = Inst.jumpTarget;
        if( F->IsRV32() ){
          SEXT(Tmp32, Inst.imm, 12);
          R->RV32_PC = R->RV32_PC + Tmp32;
        }else{
          SEXT(Tmp64, Inst.imm, 12);
          R->RV64_PC = R->RV64_PC + Tmp64;
        }
        return true;
      }

      static bool cjal(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // RV32 only; c.jal $imm = jal x1, $imm
        uint32_t Tmp32;
        Inst.rd = 1;
        Inst.imm = Inst.jumpTarget;
        if( F->IsRV32() ){
          SEXT(Tmp32, Inst.imm, 12);
          R->RV32[Inst.rd] = R->RV32_PC + Inst.instSize;;  // PC following return
          R->RV32_PC = R->RV32_PC + Tmp32;
          return true;
        }
        return false;
      }

      static bool cjr(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // c.jr %rs1 = jalr x0, 0(%rs1)
        if(Inst.rs1 != 0){
          if( F->IsRV32() ){
            R->RV32_PC = R->RV32[Inst.rs1] & (~1);
          }else{
            R->RV64_PC = R->RV64[Inst.rs1] & (~(uint64_t)1);
          }
          return true;
        }
        return false;
      }

      static bool cmv(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // add rd, x0, rs2
        if((Inst.rd != 0) && (Inst.rs2 !=0)) {
          if( F->IsRV32() ){
            R->RV32[Inst.rd] = R->RV32[Inst.rs2];
            R->RV32_PC += Inst.instSize;
          }else{
            R->RV64[Inst.rd] = R->RV64[Inst.rs2];
            R->RV64_PC += Inst.instSize;
          }
          return true;
        }
        return false;
      }

      static bool cebreak(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        return ebreak(F,R,M,Xbgas,Inst);
      }

      static bool cadd(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if((Inst.rd != 0) && (Inst.rs2 !=0))
          return add(F,R,M,Xbgas,Inst);
        return false;
      }

      static bool cjalr(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // c.jalr %rs1 = jalr x1, 0(%rs1)
        Inst.rd = 1;
        uint32_t TMP32PC = 0x00;
        uint64_t TMP64PC = 0x00ull;
        if( F->IsRV32() ){
          TMP32PC = R->RV32_PC + 2;
          R->RV32_PC = R->RV32[Inst.rs1] & (~1);
          R->RV32[Inst.rd] = TMP32PC;
          R->RV32[0] = 0x00;  // ensure that x0 = 0
        }else{
          TMP64PC = R->RV64_PC + 2;
          R->RV64_PC = R->RV64[Inst.rs1] & (~(uint64_t)1);
          R->RV64[Inst.rd] = TMP64PC;
          R->RV64[0] = 0x00ull;  // ensure that x0 = 0
        }
        return true;
      }

      static bool cbeqz(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // c.beqz %rs1, $imm = beq %rs1, x0, $imm
        uint32_t Tmp32;
        uint64_t Tmp64;
        Inst.rs1 = CRegMap[Inst.crs1];
        Inst.imm = Inst.offset;
        if( F->IsRV32() ){
          if( R->RV32[Inst.rs1] == 0 ){
            SEXT(Tmp32, Inst.imm, 9);
            R->RV32_PC = R->RV32_PC + Tmp32;
          }else{
            R->RV32_PC = R->RV32_PC + Inst.instSize;
          }
        }else{
          if( R->RV64[Inst.rs1] == 0 ){
            SEXT(Tmp64, Inst.imm, 9);
            R->RV64_PC = R->RV64_PC + Tmp64;
          }else{
            R->RV64_PC = R->RV64_PC + Inst.instSize;
          }
        }
        return true;
      }

      static bool cbnez(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // c.bnez %rs1, $imm = bne %rs1, x0, $imm
        uint32_t Tmp32;
        uint64_t Tmp64;
        Inst.rs1 = CRegMap[Inst.crs1];
        Inst.imm = Inst.offset;
        if( F->IsRV32() ){
          if( R->RV32[Inst.rs1] != 0 ){
            SEXT(Tmp32, Inst.imm, 9);
            R->RV32_PC = R->RV32_PC + Tmp32;
          }else{
            R->RV32_PC = R->RV32_PC + Inst.instSize;
          }
        }else{
          if( R->RV64[Inst.rs1] != 0 ){
            SEXT(Tmp64, Inst.imm, 9);
            R->RV64_PC = R->RV64_PC + Tmp64;
          }else{
            R->RV64_PC = R->RV64_PC + Inst.instSize;
          }
        }
        return true;
      }

      static bool cli(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // c.li %rd, $imm = addi %rd, x0, $imm
        Inst.rs1 = 0;
        if(Inst.rd != 0) {
          if( F->IsRV32() ){
            SEXT(R->RV32[Inst.rd], Inst.imm, 6);
            R->RV32_PC += Inst.instSize;
          }else{
            SEXT(R->RV64[Inst.rd], Inst.imm, 6);
            R->RV64_PC += Inst.instSize;
          }
          return true;
        }
        return false;
      }

      static bool caddi16sp(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // addi x2, x2, nzimm[9:4]
        uint32_t Tmp32;
        uint64_t Tmp64;
        Inst.rd = 2;
        Inst.rs1 = Inst.rd;
        if( (Inst.rd != 0) && (Inst.imm != 0) ) {
          if( F->IsRV32() ){
            SEXT(Tmp32, Inst.imm, 10);
            R->RV32[Inst.rd] = R->RV32[Inst.rs1] + Tmp32;
            R->RV32_PC += Inst.instSize;
          }else{
            SEXT(Tmp64, Inst.imm, 10);
            R->RV64[Inst.rd] = R->RV64[Inst.rs1] + Tmp64;
            R->RV64_PC += Inst.instSize;
          } 
          return true;
        }
        return false;
      }

      static bool clui(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // lui rd, nzimm[17:12]. Cannot use lui directly
        uint32_t Tmp = Inst.imm << 12;
        if ( (Inst.rd != 0) && (Inst.rd != 2) && (Inst.imm != 0)) {
          if( F->IsRV32() ){
            SEXT(R->RV32[Inst.rd], Tmp, 18);
            R->RV32_PC += Inst.instSize;
          }else{
            SEXT(R->RV64[Inst.rd], Tmp, 18);
            R->RV64_PC += Inst.instSize;
          }
          return true;
        }
        return false;
      }

      static bool caddi(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // c.addi %rd, $imm = addi %rd, %rd, $imm
        uint32_t Tmp32;
        uint64_t Tmp64;
        if ( (Inst.rd != 0) && (Inst.imm != 0) ){
          if( F->IsRV32() ){
            SEXT(Tmp32, Inst.imm, 6);
            R->RV32[Inst.rd] = R->RV32[Inst.rs1] + Tmp32;
            R->RV32_PC += Inst.instSize;
          }else{
            SEXT(Tmp64, Inst.imm, 6);
            R->RV64[Inst.rd] = R->RV64[Inst.rs1] + Tmp64;
            R->RV64_PC += Inst.instSize;
          }
          return true;
        }
        return false;
      }

      static bool cslli(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // c.slli %rd, $imm = slli %rd, %rd, $imm
        return slli(F,R,M,Xbgas,Inst);
      }

      static bool csrli(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // c.srli %rd, $imm = srli %rd, %rd, $imm
        Inst.rd  = CRegMap[Inst.crd];
        Inst.rs1 = Inst.rd;
        Inst.imm = Inst.offset;
        return srli(F,R,M,Xbgas,Inst);
      }

      static bool csrai(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // c.srai %rd, $imm = srai %rd, %rd, $imm
        Inst.rd  = CRegMap[Inst.crd];
        Inst.rs1 = Inst.rd;
        Inst.imm = Inst.offset;
        return srai(F,R,M,Xbgas,Inst);
      }

      static bool candi(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // c.andi %rd, $imm = sandi %rd, %rd, $imm
        uint32_t Tmp32;
        uint64_t Tmp64;
        Inst.rd   = CRegMap[Inst.crd];
        Inst.rs1  = Inst.rd;
        Inst.imm = Inst.offset;
        if( F->IsRV32() ){
          SEXT(Tmp32, Inst.imm, 6);
          R->RV32[Inst.rd] = R->RV32[Inst.rs1] & Tmp32;
          R->RV32_PC += Inst.instSize;
        }else{
          SEXT(Tmp64, Inst.imm, 6);
          R->RV64[Inst.rd] = R->RV64[Inst.rs1] & Tmp64;
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool cand(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // c.and %rd, %rs2 = and %rd, %rd, %rs2
        Inst.rd   = CRegMap[Inst.crd];
        Inst.rs1  = Inst.rd;
        Inst.rs2  = CRegMap[Inst.crs2];
        return f_and(F,R,M,Xbgas,Inst);
      }

      static bool cor(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // c.or %rd, %rs2 = or %rd, %rd, %rs2
        Inst.rd   = CRegMap[Inst.crd];
        Inst.rs1  = Inst.rd;
        Inst.rs2  = CRegMap[Inst.crs2];
        return f_or(F,R,M,Xbgas,Inst);
      }

      static bool cxor(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // c.xor %rd, %rs2 = xor %rd, %rd, %rs2
        Inst.rd   = CRegMap[Inst.crd];
        Inst.rs1  = Inst.rd;
        Inst.rs2  = CRegMap[Inst.crs2];
        return f_xor(F,R,M,Xbgas,Inst);
      }

      static bool csub(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // c.sub %rd, %rs2 = sub %rd, %rd, %rs2
        Inst.rd   = CRegMap[Inst.crd];
        Inst.rs1  = Inst.rd;
        Inst.rs2  = CRegMap[Inst.crs2];
        return sub(F,R,M,Xbgas,Inst);
      }

      // Standard instructions
      static bool lui(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint32_t Tmp = Inst.imm << 12;
        if( F->IsRV32() ){
          R->RV32[Inst.rd] = Tmp;
          R->RV32_PC += Inst.instSize;
        }else{
          SEXT(R->RV64[Inst.rd], Tmp, 32);
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool auipc(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint32_t Tmp = Inst.imm << 12;
        uint64_t Tmp64;
        if( F->IsRV32() ){
          R->RV32[Inst.rd] = 0x00;
          R->RV32[Inst.rd] = R->RV32_PC + Tmp;
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64[Inst.rd] = 0x00;
          SEXT(Tmp64, Tmp, 32);
          R->RV64[Inst.rd] = R->RV64_PC + Tmp64;
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool jal(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint32_t Tmp32;
        uint64_t Tmp64;
        if( F->IsRV32() ){
          R->RV32[Inst.rd] = R->RV32_PC + Inst.instSize;  // PC following return
          SEXT(Tmp32, Inst.imm, 21);
          R->RV32_PC = R->RV32_PC + Tmp32;
          R->RV32[0] = 0x00;  // ensure that x0 = 0
        }else{
          R->RV64[Inst.rd] = R->RV64_PC + Inst.instSize;  // PC following return
          SEXT(Tmp64, Inst.imm, 21);
          R->RV64_PC = R->RV64_PC + Tmp64;
          R->RV64[0] = 0x00ull;  // ensure that x0 = 0
        }
        return true;
      }

      static bool jalr(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint32_t Tmp32;
        uint64_t Tmp64;
        uint32_t TMP32PC = 0x00;
        uint64_t TMP64PC = 0x00ull;
        if( F->IsRV32() ){
          SEXT(Tmp32, Inst.imm, 12);
          TMP32PC = R->RV32_PC + Inst.instSize;
          R->RV32_PC = (R->RV32[Inst.rs1] + Tmp32) & (~1);
          R->RV32[Inst.rd] = TMP32PC;
          R->RV32[0] = 0x00;  // ensure that x0 = 0
        }else{
          SEXT(Tmp64, Inst.imm, 12);
          TMP64PC = R->RV64_PC + Inst.instSize;
          R->RV64_PC = (R->RV64[Inst.rs1] + Tmp64) & (~(uint64_t)1);
          R->RV64[Inst.rd] = TMP64PC;
          R->RV64[0] = 0x00ull;  // ensure that x0 = 0
        }
        return true;
      }

      static bool beq(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint32_t Tmp32;
        uint64_t Tmp64;
        if( F->IsRV32() ){
          if( R->RV32[Inst.rs1] == R->RV32[Inst.rs2] ){
            SEXT(Tmp32, Inst.imm, 13);
            R->RV32_PC = R->RV32_PC + Tmp32;
          }else{
            R->RV32_PC = R->RV32_PC + Inst.instSize;
          }
        }else{
          if( R->RV64[Inst.rs1] == R->RV64[Inst.rs2] ){
            SEXT(Tmp64, Inst.imm, 13);
            R->RV64_PC = R->RV64_PC + Tmp64;
          }else{
            R->RV64_PC = R->RV64_PC + Inst.instSize;
          }
        }
        return true;
      }

      static bool bne(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint32_t Tmp32;
        uint64_t Tmp64;
        if( F->IsRV32() ){
          if( R->RV32[Inst.rs1] != R->RV32[Inst.rs2] ){
            SEXT(Tmp32, Inst.imm, 13);
            R->RV32_PC = R->RV32_PC + Tmp32;
          }else{
            R->RV32_PC = R->RV32_PC + Inst.instSize;
          }
        }else{
          if( R->RV64[Inst.rs1] != R->RV64[Inst.rs2] ){
            SEXT(Tmp64, Inst.imm, 13);
            R->RV64_PC = R->RV64_PC + Tmp64;
          }else{
            R->RV64_PC = R->RV64_PC + Inst.instSize;
          }
        }
        return true;
      }

      static bool blt(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint32_t Tmp32;
        uint64_t Tmp64;
        if( F->IsRV32() ){
          if( (int32_t)(R->RV32[Inst.rs1]) < (int32_t)(R->RV32[Inst.rs2]) ){
            SEXT(Tmp32, Inst.imm, 13);
            R->RV32_PC = R->RV32_PC + Tmp32;
          }else{
            R->RV32_PC = R->RV32_PC + Inst.instSize;
          }
        }else{
          if( (int64_t)(R->RV64[Inst.rs1]) < (int64_t)(R->RV64[Inst.rs2]) ){
            SEXT(Tmp64, Inst.imm, 13);
            R->RV64_PC = R->RV64_PC + Tmp64;
          }else{
            R->RV64_PC = R->RV64_PC + Inst.instSize;
          }
        }
        return true;
      }

      static bool bge(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint32_t Tmp32;
        uint64_t Tmp64;
        if( F->IsRV32() ){
          if( (int32_t)(R->RV32[Inst.rs1]) >= (int32_t)(R->RV32[Inst.rs2]) ){
            SEXT(Tmp32, Inst.imm, 13);
            R->RV32_PC = R->RV32_PC + Tmp32;
          }else{
            R->RV32_PC = R->RV32_PC + Inst.instSize;
          }
        }else{
          if( (int64_t)(R->RV64[Inst.rs1]) >= (int64_t)(R->RV64[Inst.rs2]) ){
            SEXT(Tmp64, Inst.imm, 13);
            R->RV64_PC = R->RV64_PC + Tmp64;
          }else{
            R->RV64_PC = R->RV64_PC + Inst.instSize;
          }
        }
        return true;
      }

      static bool bltu(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint32_t Tmp32;
        uint64_t Tmp64;
        if( F->IsRV32() ){
          if( R->RV32[Inst.rs1] < R->RV32[Inst.rs2] ){
            SEXT(Tmp32, Inst.imm, 13);
            R->RV32_PC = R->RV32_PC + Tmp32;
          }else{
            R->RV32_PC = R->RV32_PC + Inst.instSize;
          }
        }else{
          if( R->RV64[Inst.rs1] < R->RV64[Inst.rs2] ){
            SEXT(Tmp64, Inst.imm, 13);
            R->RV64_PC = R->RV64_PC + Tmp64;
          }else{
            R->RV64_PC = R->RV64_PC + Inst.instSize;
          }
        }
        return true;
      }

      static bool bgeu(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint32_t Tmp32;
        uint64_t Tmp64;
        if( F->IsRV32() ){
          if( R->RV32[Inst.rs1] >= R->RV32[Inst.rs2] ){
            SEXT(Tmp32, Inst.imm, 13);
            R->RV32_PC = R->RV32_PC + Tmp32;
          }else{
            R->RV32_PC = R->RV32_PC + Inst.instSize;
          }
        }else{
          if( R->RV64[Inst.rs1] >= R->RV64[Inst.rs2] ){
            SEXT(Tmp64, Inst.imm, 13);
            R->RV64_PC = R->RV64_PC + Tmp64;
          }else{
            R->RV64_PC = R->RV64_PC + Inst.instSize;
          }
        }
        return true;
      }

      static bool lb(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint32_t Tmp32;
        uint64_t Tmp64;
        if( F->IsRV32() ){
          SEXT(Tmp32, Inst.imm, 12);
          SEXT(R->RV32[Inst.rd], M->ReadU8((uint64_t)(R->RV32[Inst.rs1] + Tmp32)), 8);
          R->RV32_PC += Inst.instSize;
        }else{
          SEXT(Tmp64, Inst.imm, 12);
          SEXT(R->RV64[Inst.rd], M->ReadU8((uint64_t)(R->RV64[Inst.rs1] + Tmp64)), 8);
          R->RV64_PC += Inst.instSize;
        }
        // update the cost
        R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
        return true;
      }

      static bool lh(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint32_t Tmp32;
        uint64_t Tmp64;
        if( F->IsRV32() ){
          SEXT(Tmp32, Inst.imm, 12);
          SEXT(R->RV32[Inst.rd], M->ReadU16((uint64_t)(R->RV32[Inst.rs1] + Tmp32)), 16);
          R->RV32_PC += Inst.instSize;
        }else{
          SEXT(Tmp64, Inst.imm, 12);
          SEXT(R->RV64[Inst.rd], M->ReadU16((uint64_t)(R->RV64[Inst.rs1] + Tmp64)), 16);
          R->RV64_PC += Inst.instSize;
        }
        // update the cost
        R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
        return true;
      }

      static bool lw(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint32_t Tmp32;
        uint64_t Tmp64;
        if( F->IsRV32() ){
          SEXT(Tmp32, Inst.imm, 12);
          SEXT(R->RV32[Inst.rd], M->ReadU32((uint64_t)(R->RV32[Inst.rs1] + Tmp32)), 32);
          R->RV32_PC += Inst.instSize;
        }else{
          SEXT(Tmp64, Inst.imm, 12);
          SEXT(R->RV64[Inst.rd], M->ReadU32((uint64_t)(R->RV64[Inst.rs1] + Tmp64)), 32);
          R->RV64_PC += Inst.instSize;
        }
        // update the cost
        R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
        return true;
      }

      static bool lbu(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint32_t Tmp32;
        uint64_t Tmp64;
        if( F->IsRV32() ){
          SEXT(Tmp32, Inst.imm, 12);
          R->RV32[Inst.rd] = M->ReadU8((uint64_t)(R->RV32[Inst.rs1] + Tmp32));
          R->RV32_PC += Inst.instSize;
        }else{
          SEXT(Tmp64, Inst.imm, 12);
          R->RV64[Inst.rd] = M->ReadU8((uint64_t)(R->RV64[Inst.rs1] + Tmp64));
          R->RV64_PC += Inst.instSize;
        }
        // update the cost
        R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
        return true;
      }

      static bool lhu(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint32_t Tmp32;
        uint64_t Tmp64;
        if( F->IsRV32() ){
          SEXT(Tmp32, Inst.imm, 12);
          R->RV32[Inst.rd] = M->ReadU16((uint64_t)(R->RV32[Inst.rs1] + Tmp32));            
          R->RV32_PC += Inst.instSize;
        }else{
          SEXT(Tmp64, Inst.imm, 12);
          R->RV64[Inst.rd] = M->ReadU16((uint64_t)(R->RV64[Inst.rs1] + Tmp64));
          R->RV64_PC += Inst.instSize;
        }
        // update the cost
        R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
        return true;
      }

      static bool sb(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint32_t Tmp32;
        uint64_t Tmp64;
        if( F->IsRV32() ){
          SEXT(Tmp32, Inst.imm, 12);
          M->WriteU8((uint64_t)(R->RV32[Inst.rs1] + Tmp32), (R->RV32[Inst.rs2] & MASK8));
          R->RV32_PC += Inst.instSize;
        }else{
          SEXT(Tmp64, Inst.imm, 12);
          M->WriteU8((uint64_t)(R->RV64[Inst.rs1] + Tmp64), (R->RV64[Inst.rs2] & MASK8));
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool sh(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint32_t Tmp32;
        uint64_t Tmp64;
        if( F->IsRV32() ){
          SEXT(Tmp32, Inst.imm, 12);
          M->WriteU16((uint64_t)(R->RV32[Inst.rs1] + Tmp32), (R->RV32[Inst.rs2] & MASK16));
          R->RV32_PC += Inst.instSize;
        }else{
          SEXT(Tmp64, Inst.imm, 12);
          M->WriteU16((uint64_t)(R->RV64[Inst.rs1] + Tmp64), (R->RV64[Inst.rs2] & MASK16));
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool sw(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint32_t Tmp32;
        uint64_t Tmp64;
        if( F->IsRV32() ){
          SEXT(Tmp32, Inst.imm, 12);
          M->WriteU32((uint64_t)(R->RV32[Inst.rs1] + Tmp32), (R->RV32[Inst.rs2] & MASK32));
          R->RV32_PC += Inst.instSize;
        }else{
          SEXT(Tmp64, Inst.imm, 12);
          M->WriteU32((uint64_t)(R->RV64[Inst.rs1] + Tmp64), (R->RV64[Inst.rs2] & MASK32));
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool addi(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint32_t Tmp32;
        uint64_t Tmp64;
        if( F->IsRV32() ){
          SEXT(Tmp32, Inst.imm, 12);
          R->RV32[Inst.rd] = R->RV32[Inst.rs1] + Tmp32;
          R->RV32_PC += Inst.instSize;
        }else{
          SEXT(Tmp64, Inst.imm, 12);
          R->RV64[Inst.rd] = R->RV64[Inst.rs1] + Tmp64;
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool slti(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint32_t Tmp32;
        uint64_t Tmp64;
        if( F->IsRV32() ){
          SEXT(Tmp32, Inst.imm, 12);
          if( (int32_t)(R->RV32[Inst.rs1]) < (int32_t)(Tmp32)){
            R->RV32[Inst.rd] = 1;
          }else{
            R->RV32[Inst.rd] = 0;
          }
          R->RV32_PC += Inst.instSize;
        }else{
          SEXT(Tmp64, Inst.imm, 12);
          if( (int64_t)(R->RV64[Inst.rs1]) < (int64_t)(Tmp64)){
            R->RV64[Inst.rd] = 1;
          }else{
            R->RV64[Inst.rd] = 0;
          }
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool sltiu(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint32_t Tmp32;
        uint64_t Tmp64;
        if( F->IsRV32() ){
          SEXT(Tmp32, Inst.imm, 12);
          if( R->RV32[Inst.rs1] < Tmp32 ){
            R->RV32[Inst.rd] = 1;
          }else{
            R->RV32[Inst.rd] = 0;
          }
          R->RV32_PC += Inst.instSize;
        }else{
          SEXT(Tmp64, Inst.imm, 12);
          if( R->RV64[Inst.rs1] < Tmp64 ){
            R->RV64[Inst.rd] = 1;
          }else{
            R->RV64[Inst.rd] = 0;
          }
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool xori(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint32_t Tmp32;
        uint64_t Tmp64;
        if( F->IsRV32() ){
          SEXT(Tmp32, Inst.imm, 12);
          R->RV32[Inst.rd] = R->RV32[Inst.rs1] ^ Tmp32;
          R->RV32_PC += Inst.instSize;
        }else{
          SEXT(Tmp64, Inst.imm, 12);
          R->RV64[Inst.rd] = R->RV64[Inst.rs1] ^ Tmp64;
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool ori(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint32_t Tmp32;
        uint64_t Tmp64;
        if( F->IsRV32() ){
          SEXT(Tmp32, Inst.imm, 12);
          R->RV32[Inst.rd] = R->RV32[Inst.rs1] | Tmp32;
          R->RV32_PC += Inst.instSize;
        }else{
          SEXT(Tmp64, Inst.imm, 12);
          R->RV64[Inst.rd] = R->RV64[Inst.rs1] | Tmp64;
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool andi(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint32_t Tmp32;
        uint64_t Tmp64;
        if( F->IsRV32() ){
          SEXT(Tmp32, Inst.imm, 12);
          R->RV32[Inst.rd] = R->RV32[Inst.rs1] & Tmp32;
          R->RV32_PC += Inst.instSize;
        }else{
          SEXT(Tmp64, Inst.imm, 12);
          R->RV64[Inst.rd] = R->RV64[Inst.rs1] & Tmp64;
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool slli(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
          R->RV32[Inst.rd] = R->RV32[Inst.rs1] << (Inst.imm & 0b011111);
          R->RV32_PC += Inst.instSize;
        }else{
          // In RV64, bit-25 is used to shamt[5]
          R->RV64[Inst.rd] = R->RV64[Inst.rs1] << (Inst.imm & 0b111111);
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool srli(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
          R->RV32[Inst.rd] = R->RV32[Inst.rs1] >> (Inst.imm & 0b011111);
          R->RV32_PC += Inst.instSize;
        }else{
          // In RV64, bit-25 is used to shamt[5]
          R->RV64[Inst.rd] = R->RV64[Inst.rs1] >> (Inst.imm & 0b111111);
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool srai(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
          R->RV32[Inst.rd] = (int32_t)(R->RV32[Inst.rs1]) >> (Inst.imm & 0b011111);
          R->RV32_PC += Inst.instSize;
        }else{
          // In RV64, bit-25 is used to shamt[5]. Cast to int_t will keep the sign bit after right shifting.
          R->RV64[Inst.rd] = (int64_t)(R->RV64[Inst.rs1]) >> (Inst.imm & 0b111111);
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool add(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
          R->RV32[Inst.rd] = R->RV32[Inst.rs1] + R->RV32[Inst.rs2];
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64[Inst.rd] = R->RV64[Inst.rs1] + R->RV64[Inst.rs2];
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool sub(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
          R->RV32[Inst.rd] = R->RV32[Inst.rs1] - R->RV32[Inst.rs2];
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64[Inst.rd] = R->RV64[Inst.rs1] - R->RV64[Inst.rs2];
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool sll(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
          R->RV32[Inst.rd] = R->RV32[Inst.rs1] << (R->RV32[Inst.rs2] & 0b011111);
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64[Inst.rd] = R->RV64[Inst.rs1] << (R->RV64[Inst.rs2] & 0b111111);
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool slt(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
          if( (int32_t)(R->RV32[Inst.rs1]) < (int32_t)(R->RV32[Inst.rs2]) ){
            R->RV32[Inst.rd] = 1;
          }else{
            R->RV32[Inst.rd] = 0;
          }
          R->RV32_PC += Inst.instSize;
        }else{
          if( (int64_t)(R->RV64[Inst.rs1]) < (int64_t)(R->RV64[Inst.rs2]) ){
            R->RV64[Inst.rd] = 1;
          }else{
            R->RV64[Inst.rd] = 0;
          }
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool sltu(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
          if( R->RV32[Inst.rs1] < R->RV32[Inst.rs2] ){
            R->RV32[Inst.rd] = 1;
          }else{
            R->RV32[Inst.rd] = 0;
          }
          R->RV32_PC += Inst.instSize;
        }else{
          if( R->RV64[Inst.rs1] < R->RV64[Inst.rs2] ){
            R->RV64[Inst.rd] = 1;
          }else{
            R->RV64[Inst.rd] = 0;
          }
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool f_xor(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
          R->RV32[Inst.rd] = R->RV32[Inst.rs1] ^ R->RV32[Inst.rs2];
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64[Inst.rd] = R->RV64[Inst.rs1] ^ R->RV64[Inst.rs2];
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool srl(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
          R->RV32[Inst.rd] = R->RV32[Inst.rs1] >> (R->RV32[Inst.rs2] & 0b011111);
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64[Inst.rd] = R->RV64[Inst.rs1] >> (R->RV64[Inst.rs2] & 0b111111);
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool sra(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
          R->RV32[Inst.rd] = (int32_t)(R->RV32[Inst.rs1]) >> (R->RV64[Inst.rs2] & 0b011111);
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64[Inst.rd] = (int64_t)(R->RV64[Inst.rs1]) >> (R->RV64[Inst.rs2] & 0b111111);
          R->RV64_PC += Inst.instSize;
        }
      }

      static bool f_or(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
          R->RV32[Inst.rd] = R->RV32[Inst.rs1] | R->RV32[Inst.rs2];
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64[Inst.rd] = R->RV64[Inst.rs1] | R->RV64[Inst.rs2];
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool f_and(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
          R->RV32[Inst.rd] = R->RV32[Inst.rs1] & R->RV32[Inst.rs2];
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64[Inst.rd] = R->RV64[Inst.rs1] & R->RV64[Inst.rs2];
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool fence(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64_PC += Inst.instSize;
        }
        return true;  // temporarily disabled
      }

      static bool fencei(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64_PC += Inst.instSize;
        }
        return true;  // temporarily disabled
      }

      static bool ecall(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // x17 (a7) is the code for ecall
        // std::cout << "FOUND AN ECALL" << std::endl;
        if( F->IsRV32() ){
          uint32_t code = R->RV32[17];
          std::cout << "32-bit ECALL CODE: " + std::to_string(code) << std::endl;
          switch( code ){
          case 49: 
            // -- CHDIR
            RevChdir<Riscv32>(R, M, Inst);
            break;
          default:
            break;
          }
          R->RV32_PC += Inst.instSize;
        }
        else{ // F->IsRV64
          uint64_t code = R->RV64[17];

#if 0
// #ifdef _XBGAS_DEBUG_
          int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_));
          if(id == 0) 
          {
            std::cout << "64-Bit ECALL CODE: " + std::to_string(code) << std::endl;
            std::cout << "|----- Register file -----|" << std::endl;

            for(int i=0; i<32; i++) {
              std::cout << "|e" <<std::dec << +i
                        << ": 0x" << std::hex << R->ERV64[i]
                        << "\t|x" <<std::dec << +i
                        << ": 0x" << std::hex << R->RV64[i]
                        << std::endl;
            }
            std::cout << "|----- Register file -----|" << std::endl;
          
          }
#endif    
          // uint64_t
          switch( code ){
            
          case 49:
            // std::cout << "ABOUT TO EXECUTE CHDIR" << std::endl;
            // RevChdir<Riscv64>(R, M, Inst);
            std::cout << "ECALL: chdir" << std::endl;
            break;
          case 214: 
            // RevBrk<Riscv64>(R, M, Inst);
            std::cout << "ECALL: brk" << std::endl;
            break;
          case 169: {
            // gettimeofday
            std::cout << "ECALL: gettimeofday" << std::endl;
            SST::Cycle_t currentCycleTmp = Xbgas->GetCurrentCycle();
            uint64_t kloc[2];
            kloc[0] = currentCycleTmp / 1000000000;
            kloc[1] = (currentCycleTmp % 1000000000)/(1000000000/1000000);
            if( !M->WriteMem(R->RV64[10], 16, (void *)(kloc)) ) {
              R->RV64[10] = -1;
            } else {
              R->RV64[10] = 0;
            }
            break;
          }
          default:
            std::cout << "ECALL" << std::endl;
            break;
          }
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool ebreak(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool csrrw(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool csrrs(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool csrrc(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool csrrwi(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool csrrsi(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool csrrci(RevFeature *F, RevRegFile *R,RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
          R->RV32_PC += Inst.instSize;
        }else{
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      // ----------------------------------------------------------------------
      //
      // RISC-V RV32I Instructions
      //
      // Format:
      // <mnemonic> <cost> <opcode> <funct3> <funct7> <rdClass> <rs1Class>
      //            <rs2Class> <rs3Class> <format> <func> <nullEntry>
      // ----------------------------------------------------------------------
      std::vector<RevInstEntry> RV32ITable = {
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("lui %rd, $imm"         ).SetCost(1).SetOpcode(0b0110111).SetFunct3(0b0  ).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegUNKNOWN).Setrs2Class(RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeU).SetImplFunc( &lui  ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("auipc %rd, $imm"       ).SetCost(1).SetOpcode(0b0010111).SetFunct3(0b0  ).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegUNKNOWN).Setrs2Class(RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeU).SetImplFunc( &auipc).InstEntry},

        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("jal %rd, $imm"         ).SetCost(1).SetOpcode(0b1101111).SetFunct3(0b0  ).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegUNKNOWN).Setrs2Class(RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeJ).SetImplFunc( &jal ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("jalr %rd, %rs1, $imm"  ).SetCost(1).SetOpcode(0b1100111).SetFunct3(0b000).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &jalr).InstEntry},

        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("beq %rs1, %rs2, $imm"  ).SetCost(1).SetOpcode(0b1100011).SetFunct3(0b000).SetFunct7(0b0      ).SetrdClass(RegIMM    ).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeB).SetImplFunc( &beq ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("bne %rs1, %rs2, $imm"  ).SetCost(1).SetOpcode(0b1100011).SetFunct3(0b001).SetFunct7(0b0      ).SetrdClass(RegIMM    ).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeB).SetImplFunc( &bne ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("blt %rs1, %rs2, $imm"  ).SetCost(1).SetOpcode(0b1100011).SetFunct3(0b100).SetFunct7(0b0      ).SetrdClass(RegIMM    ).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeB).SetImplFunc( &blt ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("bge %rs1, %rs2, $imm"  ).SetCost(1).SetOpcode(0b1100011).SetFunct3(0b101).SetFunct7(0b0      ).SetrdClass(RegIMM    ).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeB).SetImplFunc( &bge ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("bltu %rs1, %rs2, $imm" ).SetCost(1).SetOpcode(0b1100011).SetFunct3(0b110).SetFunct7(0b0      ).SetrdClass(RegIMM    ).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeB).SetImplFunc( &bltu).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("bgeu %rs1, %rs2, $imm" ).SetCost(1).SetOpcode(0b1100011).SetFunct3(0b111).SetFunct7(0b0      ).SetrdClass(RegIMM    ).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeB).SetImplFunc( &bgeu).InstEntry},

        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("lb %rd, $imm(%rs1)"    ).SetCost(1).SetOpcode(0b0000011).SetFunct3(0b000).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &lb  ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("lh %rd, $imm(%rs1)"    ).SetCost(1).SetOpcode(0b0000011).SetFunct3(0b001).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &lh  ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("lw %rd, $imm(%rs1)"    ).SetCost(1).SetOpcode(0b0000011).SetFunct3(0b010).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &lw  ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("lbu %rd, $imm(%rs1)"   ).SetCost(1).SetOpcode(0b0000011).SetFunct3(0b100).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &lbu ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("lhu %rd, $imm(%rs1)"   ).SetCost(1).SetOpcode(0b0000011).SetFunct3(0b101).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &lhu ).InstEntry},

        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("sb %rs2, $imm(%rs1)"   ).SetCost(1).SetOpcode(0b0100011).SetFunct3(0b000).SetFunct7(0b0      ).SetrdClass(RegIMM    ).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeS).SetImplFunc( &sb  ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("sh %rs2, $imm(%rs1)"   ).SetCost(1).SetOpcode(0b0100011).SetFunct3(0b001).SetFunct7(0b0      ).SetrdClass(RegIMM    ).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeS).SetImplFunc( &sh  ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("sw %rs2, $imm(%rs1)"   ).SetCost(1).SetOpcode(0b0100011).SetFunct3(0b010).SetFunct7(0b0      ).SetrdClass(RegIMM    ).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeS).SetImplFunc( &sw  ).InstEntry},

        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("addi %rd, %rs1, $imm"  ).SetCost(1).SetOpcode(0b0010011).SetFunct3(0b000).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &addi ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("slti %rd, %rs1, $imm"  ).SetCost(1).SetOpcode(0b0010011).SetFunct3(0b010).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &slti ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("sltiu %rd, %rs1, $imm" ).SetCost(1).SetOpcode(0b0010011).SetFunct3(0b011).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &sltiu).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("xori %rd, %rs1, $imm"  ).SetCost(1).SetOpcode(0b0010011).SetFunct3(0b100).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &xori ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("ori %rd, %rs1, $imm"   ).SetCost(1).SetOpcode(0b0010011).SetFunct3(0b110).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &ori  ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("andi %rd, %rs1, $imm"  ).SetCost(1).SetOpcode(0b0010011).SetFunct3(0b111).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &andi ).InstEntry},

        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("slli %rd, %rs1, $imm"  ).SetCost(1).SetOpcode(0b0010011).SetFunct3(0b001).SetFunct7(0b0000000).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &slli ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("srli %rd, %rs1, $imm"  ).SetCost(1).SetOpcode(0b0010011).SetFunct3(0b101).SetFunct7(0b0000000).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &srli ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("srai %rd, %rs1, $imm"  ).SetCost(1).SetOpcode(0b0010011).SetFunct3(0b101).SetFunct7(0b0100000).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &srai ).InstEntry},

        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("add %rd, %rs1, %rs2"   ).SetCost(1).SetOpcode(0b0110011).SetFunct3(0b000).SetFunct7(0b0000000).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &add  ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("sub %rd, %rs1, %rs2"   ).SetCost(1).SetOpcode(0b0110011).SetFunct3(0b000).SetFunct7(0b0100000).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &sub  ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("sll %rd, %rs1, %rs2"   ).SetCost(1).SetOpcode(0b0110011).SetFunct3(0b001).SetFunct7(0b0000000).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &sll  ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("slt %rd, %rs1, %rs2"   ).SetCost(1).SetOpcode(0b0110011).SetFunct3(0b010).SetFunct7(0b0000000).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &slt  ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("sltu %rd, %rs1, %rs2"  ).SetCost(1).SetOpcode(0b0110011).SetFunct3(0b011).SetFunct7(0b0000000).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &sltu ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("xor %rd, %rs1, %rs2"   ).SetCost(1).SetOpcode(0b0110011).SetFunct3(0b100).SetFunct7(0b0000000).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &f_xor).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("srl %rd, %rs1, %rs2"   ).SetCost(1).SetOpcode(0b0110011).SetFunct3(0b101).SetFunct7(0b0000000).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &srl  ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("sra %rd, %rs1, %rs2"   ).SetCost(1).SetOpcode(0b0110011).SetFunct3(0b101).SetFunct7(0b0100000).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &sra  ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("or %rd, %rs1, %rs2"    ).SetCost(1).SetOpcode(0b0110011).SetFunct3(0b110).SetFunct7(0b0000000).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &f_or ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("and %rd, %rs1, %rs2"   ).SetCost(1).SetOpcode(0b0110011).SetFunct3(0b111).SetFunct7(0b0000000).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &f_and).InstEntry},

        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("fence"                 ).SetCost(1).SetOpcode(0b0001111).SetFunct3(0b000).SetFunct7(0b0      ).SetrdClass(RegUNKNOWN).Setrs1Class(RegUNKNOWN).Setrs2Class(RegUNKNOWN).Setimm12(0b0).Setimm(FVal).SetFormat(RVTypeI).SetImplFunc( &fence ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("fence.i"               ).SetCost(1).SetOpcode(0b0001111).SetFunct3(0b001).SetFunct7(0b0      ).SetrdClass(RegUNKNOWN).Setrs1Class(RegUNKNOWN).Setrs2Class(RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeI).SetImplFunc( &fencei).InstEntry},

        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("ecall"                 ).SetCost(1).SetOpcode(0b1110011).SetFunct3(0b000).SetFunct7(0b0      ).SetrdClass(RegUNKNOWN).Setrs1Class(RegUNKNOWN).Setrs2Class(RegUNKNOWN).Setimm12(0b000000000000).Setimm(FEnc).SetFormat(RVTypeI).SetImplFunc( &ecall ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("ebreak"                ).SetCost(1).SetOpcode(0b1110011).SetFunct3(0b000).SetFunct7(0b0      ).SetrdClass(RegUNKNOWN).Setrs1Class(RegUNKNOWN).Setrs2Class(RegUNKNOWN).Setimm12(0b000000000001).Setimm(FEnc).SetFormat(RVTypeI).SetImplFunc( &ebreak).InstEntry},

        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("csrrw %rd, %rs1, $imm" ).SetCost(1).SetOpcode(0b1110011).SetFunct3(0b001).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setimm12(0b0).Setimm(FVal).SetFormat(RVTypeI).SetImplFunc( &csrrw ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("csrrs %rd, %rs1, $imm" ).SetCost(1).SetOpcode(0b1110011).SetFunct3(0b010).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setimm12(0b0).Setimm(FVal).SetFormat(RVTypeI).SetImplFunc( &csrrs ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("csrrc %rd, %rs1, $imm" ).SetCost(1).SetOpcode(0b1110011).SetFunct3(0b011).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setimm12(0b0).Setimm(FVal).SetFormat(RVTypeI).SetImplFunc( &csrrc ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("csrrwi %rd, %rs1, $imm").SetCost(1).SetOpcode(0b1110011).SetFunct3(0b101).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegUNKNOWN).Setrs2Class(RegUNKNOWN).Setimm12(0b0).Setimm(FVal).SetFormat(RVTypeI).SetImplFunc( &csrrwi).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("csrrsi %rd, %rs1, $imm").SetCost(1).SetOpcode(0b1110011).SetFunct3(0b110).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegUNKNOWN).Setrs2Class(RegUNKNOWN).Setimm12(0b0).Setimm(FVal).SetFormat(RVTypeI).SetImplFunc( &csrrsi).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("csrrci %rd, %rs1, $imm").SetCost(1).SetOpcode(0b1110011).SetFunct3(0b111).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegUNKNOWN).Setrs2Class(RegUNKNOWN).Setimm12(0b0).Setimm(FVal).SetFormat(RVTypeI).SetImplFunc( &csrrci).InstEntry}
      };

      // RV32C table
      std::vector<RevInstEntry> RV32ICTable = {
        //----- Quadrant 0
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.addi4spn %rd, $imm" ).SetCost(1).SetOpcode(0b00).SetFunct6(0b0     ).SetFunct4(0b0   ).SetFunct3(0b000).SetFunct2(0b0 ).SetrdClass(RegGPR    ).Setrs1Class(RegUNKNOWN).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVCTypeCIW).SetImplFunc(&caddi4spn).SetCompressed(true).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.lw %rd, $rs1, $imm" ).SetCost(1).SetOpcode(0b00).SetFunct6(0b0     ).SetFunct4(0b0   ).SetFunct3(0b010).SetFunct2(0b0 ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVCTypeCL ).SetImplFunc(&clw      ).SetCompressed(true).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.sw %rs2, %rs1, $imm").SetCost(1).SetOpcode(0b00).SetFunct6(0b0     ).SetFunct4(0b0   ).SetFunct3(0b110).SetFunct2(0b0 ).SetrdClass(RegUNKNOWN).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setimm(FImm).SetFormat(RVCTypeCS ).SetImplFunc(&csw      ).SetCompressed(true).InstEntry},
        //----- Quadrant 1
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.nop"                ).SetCost(1).SetOpcode(0b01).SetFunct6(0b0     ).SetFunct4(0b0   ).SetFunct3(0b000).SetFunct2(0b0 ).SetrdClass(RegUNKNOWN).Setrs1Class(RegUNKNOWN).Setrs2Class(RegUNKNOWN).Setimm(FUnk).SetFormat(RVCTypeCI ).SetImplFunc(&cnop     ).SetCompressed(true).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.addi %rd, $imm"     ).SetCost(1).SetOpcode(0b01).SetFunct6(0b0     ).SetFunct4(0b0001).SetFunct3(0b000).SetFunct2(0b0 ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVCTypeCI ).SetImplFunc(&caddi    ).SetCompressed(true).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.li %rd, $imm"       ).SetCost(1).SetOpcode(0b01).SetFunct6(0b0     ).SetFunct4(0b0   ).SetFunct3(0b010).SetFunct2(0b0 ).SetrdClass(RegGPR    ).Setrs1Class(RegUNKNOWN).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVCTypeCI ).SetImplFunc(&cli      ).SetCompressed(true).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.addi16sp %rd, $imm" ).SetCost(1).SetOpcode(0b01).SetFunct6(0b0     ).SetFunct4(0b0111).SetFunct3(0b011).SetFunct2(0b0 ).SetrdClass(RegGPR    ).Setrs1Class(RegUNKNOWN).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVCTypeCI ).SetImplFunc(&caddi16sp).SetCompressed(true).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.lui %rd, $imm"      ).SetCost(1).SetOpcode(0b01).SetFunct6(0b0     ).SetFunct4(0b0110).SetFunct3(0b011).SetFunct2(0b0 ).SetrdClass(RegGPR    ).Setrs1Class(RegUNKNOWN).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVCTypeCI ).SetImplFunc(&clui     ).SetCompressed(true).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.srli %rd, $imm"     ).SetCost(1).SetOpcode(0b01).SetFunct6(0b100000).SetFunct4(0b0   ).SetFunct3(0b100).SetFunct2(0b0 ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVCTypeCB ).SetImplFunc(&csrli    ).SetCompressed(true).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.srai %rd, $imm"     ).SetCost(1).SetOpcode(0b01).SetFunct6(0b100001).SetFunct4(0b0   ).SetFunct3(0b100).SetFunct2(0b0 ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVCTypeCB ).SetImplFunc(&csrai    ).SetCompressed(true).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.andi %rd, $imm"     ).SetCost(1).SetOpcode(0b01).SetFunct6(0b100010).SetFunct4(0b0   ).SetFunct3(0b100).SetFunct2(0b0 ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVCTypeCB ).SetImplFunc(&candi    ).SetCompressed(true).InstEntry},
        
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.sub %rd,%rs1"       ).SetCost(1).SetOpcode(0b01).SetFunct6(0b100011).SetFunct4(0b0   ).SetFunct3(0b100).SetFunct2(0b00).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setimm(FUnk).SetFormat(RVCTypeCR ).SetImplFunc(&csub     ).SetCompressed(true).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.xor %rd,%rs1"       ).SetCost(1).SetOpcode(0b01).SetFunct6(0b100011).SetFunct4(0b0   ).SetFunct3(0b100).SetFunct2(0b01).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setimm(FUnk).SetFormat(RVCTypeCR ).SetImplFunc(&cxor     ).SetCompressed(true).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.or %rd,%rs1"        ).SetCost(1).SetOpcode(0b01).SetFunct6(0b100011).SetFunct4(0b0   ).SetFunct3(0b100).SetFunct2(0b10).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setimm(FUnk).SetFormat(RVCTypeCR ).SetImplFunc(&cor      ).SetCompressed(true).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.and %rd,%rs1"       ).SetCost(1).SetOpcode(0b01).SetFunct6(0b100011).SetFunct4(0b0   ).SetFunct3(0b100).SetFunct2(0b11).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setimm(FUnk).SetFormat(RVCTypeCR ).SetImplFunc(&cand     ).SetCompressed(true).InstEntry},
        
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.j $imm"             ).SetCost(1).SetOpcode(0b01).SetFunct6(0b0     ).SetFunct4(0b0   ).SetFunct3(0b101).SetFunct2(0b0 ).SetrdClass(RegUNKNOWN).Setrs1Class(RegUNKNOWN).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVCTypeCJ ).SetImplFunc(&cj       ).SetCompressed(true).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.beqz %rs1, $imm"    ).SetCost(1).SetOpcode(0b01).SetFunct6(0b0     ).SetFunct4(0b0   ).SetFunct3(0b110).SetFunct2(0b0 ).SetrdClass(RegUNKNOWN).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVCTypeCB ).SetImplFunc(&cbeqz    ).SetCompressed(true).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.bnez %rs1, $imm"    ).SetCost(1).SetOpcode(0b01).SetFunct6(0b0     ).SetFunct4(0b0   ).SetFunct3(0b111).SetFunct2(0b0 ).SetrdClass(RegUNKNOWN).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVCTypeCB ).SetImplFunc(&cbnez    ).SetCompressed(true).InstEntry},
        //----- Quadrant 2
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.slli %rd, $imm"     ).SetCost(1).SetOpcode(0b10).SetFunct6(0b0     ).SetFunct4(0b0   ).SetFunct3(0b000).SetFunct2(0b0 ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVCTypeCI ).SetImplFunc(&cslli    ).SetCompressed(true).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.lwsp %rd, $imm"     ).SetCost(1).SetOpcode(0b10).SetFunct6(0b0     ).SetFunct4(0b0   ).SetFunct3(0b010).SetFunct2(0b0 ).SetrdClass(RegGPR    ).Setrs1Class(RegUNKNOWN).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVCTypeCI ).SetImplFunc(&clwsp    ).SetCompressed(true).InstEntry},
        
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.jr %rs1"            ).SetCost(1).SetOpcode(0b10).SetFunct6(0b100010).SetFunct4(0b0   ).SetFunct3(0b100).SetFunct2(0b0 ).SetrdClass(RegUNKNOWN).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setimm(FUnk).SetFormat(RVCTypeCR ).SetImplFunc(&cjr      ).SetCompressed(true).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.mv %rd,%rs2"        ).SetCost(1).SetOpcode(0b10).SetFunct6(0b100011).SetFunct4(0b0   ).SetFunct3(0b100).SetFunct2(0b0 ).SetrdClass(RegGPR    ).Setrs1Class(RegUNKNOWN).Setrs2Class(RegGPR    ).Setimm(FUnk).SetFormat(RVCTypeCR ).SetImplFunc(&cmv      ).SetCompressed(true).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.ebreak"             ).SetCost(1).SetOpcode(0b10).SetFunct6(0b100100).SetFunct4(0b0   ).SetFunct3(0b100).SetFunct2(0b0 ).SetrdClass(RegUNKNOWN).Setrs1Class(RegUNKNOWN).Setrs2Class(RegUNKNOWN).Setimm(FUnk).SetFormat(RVCTypeCR ).SetImplFunc(&cebreak  ).SetCompressed(true).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.jalr %rs1"          ).SetCost(1).SetOpcode(0b10).SetFunct6(0b100110).SetFunct4(0b0   ).SetFunct3(0b100).SetFunct2(0b0 ).SetrdClass(RegUNKNOWN).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setimm(FUnk).SetFormat(RVCTypeCR ).SetImplFunc(&cjalr    ).SetCompressed(true).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.add %rd,%rd,%rs2"   ).SetCost(1).SetOpcode(0b10).SetFunct6(0b100111).SetFunct4(0b0   ).SetFunct3(0b100).SetFunct2(0b0 ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setimm(FUnk).SetFormat(RVCTypeCR ).SetImplFunc(&cadd     ).SetCompressed(true).InstEntry},
        
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.swsp %rs2, $imm"    ).SetCost(1).SetOpcode(0b10).SetFunct6(0b0     ).SetFunct4(0b0   ).SetFunct3(0b110).SetFunct2(0b0 ).SetrdClass(RegUNKNOWN).Setrs1Class(RegUNKNOWN).Setrs2Class(RegGPR    ).Setimm(FImm).SetFormat(RVCTypeCSS).SetImplFunc(&cswsp    ).SetCompressed(true).InstEntry},
      };

      // RV32C-Only table
      std::vector<RevInstEntry> RV32ICOTable = {
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.jal $imm"           ).SetCost(1).SetOpcode(0b01).SetFunct6(0b0     ).SetFunct4(0b0   ).SetFunct3(0b001).SetFunct2(0b0 ).SetrdClass(RegUNKNOWN).Setrs1Class(RegUNKNOWN).Setrs2Class(RegUNKNOWN).Setimm(FVal).SetFormat(RVCTypeCJ ).SetImplFunc(&cjal     ).SetCompressed(true).InstEntry}
      };

    public:
      /// RV32I: standard constructor
      RV32I( RevFeature *Feature,
             RevRegFile *RegFile,
             RevMem *RevMem,
             RevXbgas *RevXbgas,
             SST::Output *Output )
        : RevExt( "RV32I", Feature, RegFile, RevMem, RevXbgas, Output ) {
          this->SetTable(RV32ITable);
          this->SetCTable(RV32ICTable);
          this->SetOTable(RV32ICOTable);
        }

      /// RV32I: standard destructor
      ~RV32I() { }

    }; // end class RV32I
  } // namespace RevCPU
} // namespace SST

#endif
