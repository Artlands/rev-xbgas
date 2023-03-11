//
// _RV64I_h_
//
// Copyright (C) 2017-2021 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#ifndef _SST_REVCPU_RV64I_H_
#define _SST_REVCPU_RV64I_H_

#include "RevInstTable.h"
#include "RevExt.h"

using namespace SST::RevCPU;

namespace SST{
  namespace RevCPU{
    class RV64I : public RevExt {

      // Compressed instructions
      static bool cldsp(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // c.ldsp rd, $imm = lw rd, x2, $imm
        Inst.rs1  = 2;
        if(Inst.rd != 0)
          R->RV64[Inst.rd] = M->ReadU64( (uint64_t)(R->RV64[Inst.rs1]+(int32_t)(Inst.imm)));
        R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool csdsp(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // c.sdsp rs2, $imm = sd rs2, x2, $imm
        Inst.rs1  = 2;

// #ifdef _XBGAS_DEBUG_
//         std::cout << "_XBGAS_DEBUG_ csd: x2 = " << std::hex << R->RV64[Inst.rs1] << std::endl;
//         std::cout << "_XBGAS_DEBUG_ csd: imm = " << std::hex << (int32_t)(Inst.imm) << std::endl;
// #endif

        M->WriteU64((uint64_t)(R->RV64[Inst.rs1]+(int32_t)(Inst.imm)), (uint64_t)(R->RV64[Inst.rs2]));
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool cld(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // c.ld %rd, %rs1, $imm = ld %rd, %rs1, $imm
        Inst.rd  = CRegMap[Inst.crd];
        Inst.rs1 = CRegMap[Inst.crs1];
        if(Inst.rd != 0)
          R->RV64[Inst.rd] = M->ReadU64( (uint64_t)(R->RV64[Inst.rs1]+(int32_t)(Inst.imm)));
        R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool csd(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // c.sd rs2, rs1, $imm = sd rs2, $imm(rs1)
        Inst.rs2 = CRegMap[Inst.crd];
        Inst.rs1 = CRegMap[Inst.crs1];
        M->WriteU64((uint64_t)(R->RV64[Inst.rs1]+(int32_t)(Inst.imm)), (uint64_t)(R->RV64[Inst.rs2]));
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool caddiw(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // c.addiw %rd, $imm = addiw %rd, %rd, $imm
        if(Inst.rd != 0){
          R->RV64[Inst.rd] = (int32_t)(R->RV64[Inst.rs1] + (int32_t)(td_u32(Inst.imm,6)));
          R->RV64_PC += Inst.instSize;
          return true;
        }
        return false;
      }

      static bool caddw(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // c.addw %rd, %rs2 = addw %rd, %rd, %rs2
        Inst.rd   = CRegMap[Inst.crd];
        Inst.rs1  = Inst.rd;
        Inst.rs2  = CRegMap[Inst.crs2];
        return addw(F,R,M,Xbgas,Inst);
      }

      static bool csubw(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // c.subw %rd, %rs2 = subw %rd, %rd, %rs2
        Inst.rd   = CRegMap[Inst.crd];
        Inst.rs1  = Inst.rd;
        Inst.rs2  = CRegMap[Inst.crs2];
        return subw(F,R,M,Xbgas,Inst);
      }

      // Standard instructions
      static bool lwu(RevFeature *F, RevRegFile *R,RevMem *M,RevXbgas *Xbgas,RevInst Inst){
        if(Inst.rd != 0)
          ZEXT(R->RV64[Inst.rd], M->ReadU32( (uint64_t)(R->RV64[Inst.rs1]+(int32_t)(td_u32(Inst.imm,12)))),64);
        R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool ld(RevFeature *F, RevRegFile *R,RevMem *M,RevXbgas *Xbgas,RevInst Inst) {
        if(Inst.rd != 0)
          R->RV64[Inst.rd] = M->ReadU64( (uint64_t)(R->RV64[Inst.rs1]+(int32_t)(td_u32(Inst.imm,12))));
        R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool sd(RevFeature *F, RevRegFile *R,RevMem *M,RevXbgas *Xbgas,RevInst Inst) {
        M->WriteU64((uint64_t)(R->RV64[Inst.rs1]+(int32_t)(td_u32(Inst.imm,12))), (uint64_t)(R->RV64[Inst.rs2]));
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool addiw(RevFeature *F, RevRegFile *R,RevMem *M,RevXbgas *Xbgas,RevInst Inst) {

// #ifdef _XBGAS_DEBUG_
//           int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
//           if (id == 0)
//           {
//           std::cout << "_XBGAS_DEBUG_ CPU" << id
//                           << ": Before ADDIW" << std::endl;
//           }
//           std::cout << "|x" <<std::dec << +Inst.rd
//                     << "|: 0x" << std::hex << R->RV64[Inst.rd]
//                     << " = |x" <<std::dec << +Inst.rs1
//                     << "|: 0x" << std::hex << R->ERV64[Inst.rs1]
//                     << " + imm (" << std::hex << (int32_t)(td_u32(Inst.imm,12))
//                     << ")" << std::endl;
// #endif

        if(Inst.rd != 0)
          R->RV64[Inst.rd] = (int32_t)(R->RV64[Inst.rs1] + (int32_t)(td_u32(Inst.imm,12)));

// #ifdef _XBGAS_DEBUG_
//           if (id == 0)
//           {
//           std::cout << "_XBGAS_DEBUG_ CPU" << id
//                           << ": After ADDIW" << std::endl;
//           }
//           std::cout << "|x" <<std::dec << +Inst.rd
//                     << "|: 0x" << std::hex << R->RV64[Inst.rd]
//                     << " = |x" <<std::dec << +Inst.rs1
//                     << "|: 0x" << std::hex << R->ERV64[Inst.rs1]
//                     << " + imm (" << std::hex << (int32_t)(td_u32(Inst.imm,12))
//                     << ")" << std::endl;
// #endif

        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool slliw(RevFeature *F, RevRegFile *R,RevMem *M,RevXbgas *Xbgas,RevInst Inst) {
        if(Inst.rd != 0)
          R->RV64[Inst.rd] = (int32_t)(R->RV64[Inst.rs1] << (Inst.imm & 0b11111));
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool srliw(RevFeature *F, RevRegFile *R,RevMem *M,RevXbgas *Xbgas,RevInst Inst) {
        if(Inst.rd != 0)
          R->RV64[Inst.rd] = (int32_t)((uint32_t)(R->RV64[Inst.rs1]) >> (Inst.imm & 0b11111));
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool sraiw(RevFeature *F, RevRegFile *R,RevMem *M,RevXbgas *Xbgas,RevInst Inst) {
        if(Inst.rd != 0)
          R->RV64[Inst.rd] = (int32_t)(R->RV64[Inst.rs1]) >> (Inst.imm & 0b11111);
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool addw(RevFeature *F, RevRegFile *R,RevMem *M,RevXbgas *Xbgas,RevInst Inst) {
        if(Inst.rd != 0)
          R->RV64[Inst.rd] = (int32_t)(R->RV64[Inst.rs1] + R->RV64[Inst.rs2]);
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool subw(RevFeature *F, RevRegFile *R,RevMem *M,RevXbgas *Xbgas,RevInst Inst) {
        if(Inst.rd != 0)
          R->RV64[Inst.rd] = (int32_t)(R->RV64[Inst.rs1] - R->RV64[Inst.rs2]);
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool sllw(RevFeature *F, RevRegFile *R,RevMem *M,RevXbgas *Xbgas,RevInst Inst) {
        if(Inst.rd != 0)
          R->RV64[Inst.rd] = (int32_t)((uint32_t)(R->RV64[Inst.rs1]) << (R->RV64[Inst.rs2] & 0b11111));
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool srlw(RevFeature *F, RevRegFile *R,RevMem *M,RevXbgas *Xbgas,RevInst Inst) {
        if(Inst.rd != 0)
          R->RV64[Inst.rd] = (int32_t)((uint32_t)(R->RV64[Inst.rs1]) >> (R->RV64[Inst.rs2] & 0b11111));
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool sraw(RevFeature *F, RevRegFile *R,RevMem *M,RevXbgas *Xbgas,RevInst Inst) {
        if(Inst.rd != 0)
          R->RV64[Inst.rd] = (int32_t)(R->RV64[Inst.rs1]) >> (R->RV64[Inst.rs2] & 0b11111);
        R->RV64_PC += Inst.instSize;
        return true;
      }

      // ----------------------------------------------------------------------
      //
      // RISC-V RV64I Instructions
      //
      // Format:
      // <mnemonic> <cost> <opcode> <funct3> <funct7> <rdClass> <rs1Class>
      //            <rs2Class> <rs3Class> <format> <func> <nullEntry>
      // ----------------------------------------------------------------------
      std::vector<RevInstEntry > RV64ITable = {
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("lwu %rd, $imm(%rs1)"   ).SetCost(1).SetOpcode( 0b0000011 ).SetFunct3( 0b110 ).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR).Setrs2Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &lwu   ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("ld %rd, $imm(%rs1)"    ).SetCost(1).SetOpcode( 0b0000011 ).SetFunct3( 0b011 ).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR).Setrs2Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &ld    ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("sd %rs2, $imm(%rs1)"   ).SetCost(1).SetOpcode( 0b0100011 ).SetFunct3( 0b011 ).SetFunct7(0b0      ).SetrdClass(RegIMM    ).Setrs1Class(RegGPR).Setrs2Class(RegGPR    ).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeS).SetImplFunc( &sd    ).InstEntry},
              
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("addiw %rd, %rs1, $imm" ).SetCost(1).SetOpcode( 0b0011011 ).SetFunct3( 0b000 ).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR).Setrs2Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &addiw ).InstEntry},
        
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("slliw %rd, %rs1, $imm" ).SetCost(1).SetOpcode( 0b0011011 ).SetFunct3( 0b001 ).SetFunct7(0b0000000).SetrdClass(RegGPR    ).Setrs1Class(RegGPR).Setrs2Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &slliw ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("srliw %rd, %rs1, $imm" ).SetCost(1).SetOpcode( 0b0011011 ).SetFunct3( 0b101 ).SetFunct7(0b0000000).SetrdClass(RegGPR    ).Setrs1Class(RegGPR).Setrs2Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &srliw ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("sraiw %rd, %rs1, $imm" ).SetCost(1).SetOpcode( 0b0011011 ).SetFunct3( 0b101 ).SetFunct7(0b0100000).SetrdClass(RegGPR    ).Setrs1Class(RegGPR).Setrs2Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &sraiw ).InstEntry},
        
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("addw %rd, %rs1, %rs2"  ).SetCost(1).SetOpcode( 0b0111011 ).SetFunct3( 0b000 ).SetFunct7(0b0000000).SetrdClass(RegGPR    ).Setrs1Class(RegGPR).Setrs2Class(RegGPR    ).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &addw  ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("subw %rd, %rs1, %rs2"  ).SetCost(1).SetOpcode( 0b0111011 ).SetFunct3( 0b000 ).SetFunct7(0b0100000).SetrdClass(RegGPR    ).Setrs1Class(RegGPR).Setrs2Class(RegGPR    ).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &subw  ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("sllw %rd, %rs1, %rs2"  ).SetCost(1).SetOpcode( 0b0111011 ).SetFunct3( 0b001 ).SetFunct7(0b0000000).SetrdClass(RegGPR    ).Setrs1Class(RegGPR).Setrs2Class(RegGPR    ).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &sllw  ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("srlw %rd, %rs1, %rs2"  ).SetCost(1).SetOpcode( 0b0111011 ).SetFunct3( 0b101 ).SetFunct7(0b0000000).SetrdClass(RegGPR    ).Setrs1Class(RegGPR).Setrs2Class(RegGPR    ).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &srlw  ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("sraw %rd, %rs1, %rs2"  ).SetCost(1).SetOpcode( 0b0111011 ).SetFunct3( 0b101 ).SetFunct7(0b0100000).SetrdClass(RegGPR    ).Setrs1Class(RegGPR).Setrs2Class(RegGPR    ).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &sraw  ).InstEntry},
      };

    std::vector<RevInstEntry> RV64ICTable = {
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.ld %rd, %rs1, $imm"  ).SetCost(1).SetOpcode(0b00).SetFunct6(0b0     ).SetFunct4(0b0   ).SetFunct3(0b011).SetFunct2(0b0 ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVCTypeCL ).SetImplFunc(&cld   ).SetCompressed(true).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.sd %rs2, %rs1, $imm" ).SetCost(1).SetOpcode(0b00).SetFunct6(0b0     ).SetFunct4(0b0   ).SetFunct3(0b111).SetFunct2(0b0 ).SetrdClass(RegUNKNOWN).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setimm(FImm).SetFormat(RVCTypeCS ).SetImplFunc(&csd   ).SetCompressed(true).InstEntry},
        
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.addiw %rd, $imm"     ).SetCost(1).SetOpcode(0b01).SetFunct6(0b0     ).SetFunct4(0b0   ).SetFunct3(0b001).SetFunct2(0b0 ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVCTypeCI ).SetImplFunc(&caddiw).SetCompressed(true).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.subw %rd,%rs1"       ).SetCost(1).SetOpcode(0b01).SetFunct6(0b100111).SetFunct4(0b0   ).SetFunct3(0b100).SetFunct2(0b00).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setimm(FUnk).SetFormat(RVCTypeCR ).SetImplFunc(&csubw ).SetCompressed(true).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.addw %rd,%rs1"       ).SetCost(1).SetOpcode(0b01).SetFunct6(0b100111).SetFunct4(0b0   ).SetFunct3(0b100).SetFunct2(0b01).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setimm(FUnk).SetFormat(RVCTypeCR ).SetImplFunc(&caddw ).SetCompressed(true).InstEntry},
        
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.ldsp %rd, $imm"      ).SetCost(1).SetOpcode(0b10).SetFunct6(0b0     ).SetFunct4(0b0   ).SetFunct3(0b011).SetFunct2(0b0 ).SetrdClass(RegGPR    ).Setrs1Class(RegUNKNOWN).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVCTypeCI ).SetImplFunc(&cldsp ).SetCompressed(true).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("c.sdsp %rs2, $imm"     ).SetCost(1).SetOpcode(0b10).SetFunct6(0b0     ).SetFunct4(0b0   ).SetFunct3(0b111).SetFunct2(0b0 ).SetrdClass(RegUNKNOWN).Setrs1Class(RegUNKNOWN).Setrs2Class(RegGPR    ).Setimm(FImm).SetFormat(RVCTypeCSS).SetImplFunc(&csdsp ).SetCompressed(true).InstEntry},
      };

    public:
      /// RV64I: standard constructor
      RV64I( RevFeature *Feature,
             RevRegFile *RegFile,
             RevMem *RevMem,
             RevXbgas *RevXbgas,
             SST::Output *Output )
        : RevExt( "RV64I", Feature, RegFile, RevMem, RevXbgas, Output ) {
          this->SetTable(RV64ITable);
          this->SetCTable(RV64ICTable);
        }

      /// RV64I: standard destructor
      ~RV64I() { }

    }; // end class RV64I
  } // namespace RevCPU
} // namespace SST

#endif
