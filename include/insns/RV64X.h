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

#include "../RevInstTable.h"

using namespace SST::RevCPU;

namespace SST {
  namespace RevCPU {
    class RV64X : public RevExt {

      static bool eld(RevFeature *F, RevRegFile *R, RevMem *M,RevInst Inst) {
        uint64_t Tmp;
        SEXT(Tmp, Inst.imm, 12);
        uint64_t Nmspace = (uint64_t)(R->ERV64[Inst.rs1]);
        uint64_t SrcAddr = (uint64_t)(R->RV64[Inst.rs1] + Tmp);
        if( Nmspace != 0x00ull) {
          M->RmtReadMem(Nmspace, SrcAddr, 8, &R->RV64[Inst.rd]);
        } else {
          M->ReadVal(SrcAddr, &R->RV64[Inst.rd], REVMEM_FLAGS(0x00));
          R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
        }
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
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("eld %rd, $imm(%rs1)"      ).SetCost(1).SetOpcode(0b1110111).SetFunct3(0b011).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &eld ).InstEntry}
      };

    public:
      /// RV64X: standard constructor
      RV64X(RevFeature *Feature,
            RevRegFile *RegFile,
            RevMem *RevMem,
            SST::Output *Output )
        : RevExt( "RV64X", Feature, RegFile, RevMem, Output ){
        this->SetTable(RV64XTable);
      }

      /// RV64X: standard destructor
      ~RV64X() { }

    }; // class RV64X
  } // namespace RevCPU
} // namespace SST

#endif