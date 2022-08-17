//
// _RV64X_h_
//
// Copyright (C) 2017-2021 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#ifndef _SST_REVCPU_RV64X_H_
#define _SST_REVCPU_RV64X_H_

#include "RevInstTable.h"
#include "RevExt.h"

using namespace SST::RevCPU;

namespace SST{
  namespace RevCPU{
    class RV64X : public RevExt {

      static bool elq(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint8_t Tag = 0;
        uint64_t EXT1 = (uint64_t)(R->ERV64[Inst.rs1]);
        uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1] + Inst.imm);
        if ( !Xbgas->checkGetRequests(EXT1, Addr, &Tag) ) {
          Xbgas->ReadU128(EXT1, Addr);
        } else {
          // uint128_t Value;
          // if( Xbgas->readGetResponses(Tag, (void *)(&Value)) ) {
          //   SEXT(R->RV64[Inst.rd], Value, 64);
          //   R->RV64_PC += Inst.instSize;
          // }
        }
        return true;
      }

      static bool eld(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint8_t Tag = 0;
        uint64_t EXT1 = (uint64_t)(R->ERV64[Inst.rs1]);
        uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1] + Inst.imm);
        if ( !Xbgas->checkGetRequests(EXT1, Addr, &Tag) ) {
          Xbgas->ReadU64(EXT1, Addr);
        } else {
          uint64_t Value;
          if( Xbgas->readGetResponses(Tag, (void *)(&Value)) ) {
            SEXT(R->RV64[Inst.rd], Value, 64);
            R->RV64_PC += Inst.instSize;
          }
        }
      return true;
      }

      static bool ese(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint64_t EXT1 = (uint64_t)(R->ERV64[Inst.rs1]);
        uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1] + Inst.imm);
        Xbgas->WriteU64( EXT1, Addr, (uint8_t)(R->RV64[Inst.rs2]) );
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool erld(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint8_t Tag = 0;
        uint64_t EXT2 = (uint64_t)(R->ERV64[Inst.rs2]);
        uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]);
        if ( !Xbgas->checkGetRequests(EXT2, Addr, &Tag) ) {
          Xbgas->ReadU64(EXT2, Addr);
        } else {
          uint64_t Value;
          if( Xbgas->readGetResponses(Tag, (void *)(&Value)) ) {
            SEXT(R->RV64[Inst.rd], Value, 64);
            R->RV64_PC += Inst.instSize;
          }
        }
        return true;
      }

      static bool erle(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint8_t Tag = 0;
        uint64_t EXT2 = (uint64_t)(R->ERV64[Inst.rs2]);
        uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]);
        if ( !Xbgas->checkGetRequests(EXT2, Addr, &Tag) ) {
          Xbgas->ReadU64(EXT2, Addr);
        } else {
          uint64_t Value;
          if( Xbgas->readGetResponses(Tag, (void *)(&Value)) ) {
            ZEXT(R->RV64[Inst.rd], Value, 64);
            R->RV64_PC += Inst.instSize;
          }
        }
        return true;
      }

      static bool ersd(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint64_t EXT3 = (uint64_t)(R->ERV64[Inst.rd]);
        uint64_t Addr = (uint64_t)(R->RV64[Inst.rs2]);
        Xbgas->WriteU64( EXT3, Addr, (uint32_t)(R->RV64[Inst.rs1]) );
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool erse(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint64_t EXT3 = (uint64_t)(R->ERV64[Inst.rd]);
        uint64_t Addr = (uint64_t)(R->RV64[Inst.rs2]);
        Xbgas->WriteU64( EXT3, Addr, (uint8_t)(R->RV64[Inst.rs1]) );
        R->RV64_PC += Inst.instSize;
        return true;
      }    
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
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("elq %rd, $imm(%rs1)").SetCost(          1).SetOpcode(0b1110111).SetFunct3(0b010).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &elq).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("eld %rd, $imm(%rs1)").SetCost(          1).SetOpcode(0b1110111).SetFunct3(0b001).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &eld).InstEntry},
      
      // // Store instructions are encoded in the S-type format
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("ese %rs2, $imm(%rs1)").SetCost(         1).SetOpcode(0b1111011).SetFunct3(0b010).SetrdClass(RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeS).SetImplFunc( &ese).InstEntry},
      
      // // Raw Load instructions are encoded in the R-type format
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("erld %rd, %rs1, %ext2").SetCost(        1).SetOpcode(0b0110011).SetFunct3(0b010).SetFunct7(0b1010101).SetFormat(RVTypeR).SetImplFunc( &erld).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("erle %rd, %rs1, %ext2").SetCost(        1).SetOpcode(0b0110011).SetFunct3(0b001).SetFunct7(0b1010101).SetFormat(RVTypeR).SetImplFunc( &erle).InstEntry},

      // // Raw Store instructions are encoded in the R-type format
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("ersd %rs1, %rs2, %ext3").SetCost(       1).SetOpcode(0b0110011).SetFunct3(0b010).SetFunct7(0b0100010).SetFormat(RVTypeR).SetImplFunc( &ersd).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("erse %rs1, %rs2, %ext3").SetCost(       1).SetOpcode(0b0110011).SetFunct3(0b001).SetFunct7(0b0100010).SetFormat(RVTypeR).SetImplFunc( &erse).InstEntry},

      };

    public:
      /// RV64X: standard constructor
      RV64X( RevFeature *Feature,
             RevRegFile *RegFile,
             RevMem *RevMem,
             RevXbgas *RevXbgas,
             SST::Output *Output )
        : RevExt( "RV64X", Feature, RegFile, RevMem, RevXbgas, Output) {
          this->SetTable(RV64XTable);
        }

      /// RV64X: standard destructor
      ~RV64X() { }

    }; // end class RV32I
  } // namespace RevCPU
} // namespace SST

#endif
