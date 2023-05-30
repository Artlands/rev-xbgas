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

// #define _XBGAS_DEBUG_

using namespace SST::RevCPU;

namespace SST {
  namespace RevCPU {
    class RV64X : public RevExt {
      
      static bool elq(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
        // Todo
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool eld(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
        uint64_t Imm;
        SEXT(Imm, Inst.imm, 12);
        uint64_t Nmspace = (uint64_t)(R->ERV64[Inst.rs1]);
        uint64_t SrcAddr = (uint64_t)(R->RV64[Inst.rs1] + Imm);
        if (R->RV64_Tag[Inst.rd] == 0) {
  #ifdef _XBGAS_DEBUG_
          std::cout << "Before eld: Namespace: " << std::dec << Nmspace
                    << ", Source Addr: " << std::hex << SrcAddr
                    << ", RV64[" << std::dec << (int)(Inst.rd) << "] = " 
                    << std::dec << R->RV64[Inst.rd] << std::endl;
  #endif
          if( Nmspace != 0x00ull) {
            M->RmtReadMem(Nmspace, SrcAddr, 8, &R->RV64[Inst.rd], &R->RV64_Tag[Inst.rd]);
          } else {
            // M->ReadVal(SrcAddr, &R->RV64[Inst.rd], REVMEM_FLAGS(0x00));
            M->ReadMem(SrcAddr, 8, &R->RV64[Inst.rd]);
            R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
            R->RV64_PC += Inst.instSize;
          }
        } else if (R->RV64_Tag[Inst.rd] == 1) {
          R->RV64_PC += Inst.instSize;
          R->RV64_Tag[Inst.rd] = 0;

#ifdef _XBGAS_DEBUG_
        std::cout << "After eld: RV64[" << std::dec << (int)(Inst.rd) << "] = " 
                  << std::dec << R->RV64[Inst.rd] << std::endl;
#endif

        } else {
          // Do nothing. Waiting for the remote memory response
        }

        return true;
      }

      static bool elw(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
        uint64_t Imm;
        uint32_t Tmp;
        SEXT(Imm, Inst.imm, 12);
        uint64_t Nmspace = (uint64_t)(R->ERV64[Inst.rs1]);
        uint64_t SrcAddr = (uint64_t)(R->RV64[Inst.rs1] + Imm);
        if (R->RV64_Tag[Inst.rd] == 0) {
          if( Nmspace != 0x00ull) {
            M->RmtReadMem(Nmspace, SrcAddr, 4, &Tmp, &R->RV64_Tag[Inst.rd]);
          } else {
            M->ReadMem(SrcAddr, 4, &Tmp);
            SEXT(R->RV64[Inst.rd], Tmp, 32);
            R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
            R->RV64_PC += Inst.instSize;
          }
        } else if (R->RV64_Tag[Inst.rd] == 1) {
          SEXT(R->RV64[Inst.rd], Tmp, 32);
          R->RV64_PC += Inst.instSize;
          R->RV64_Tag[Inst.rd] = 0;
        } 
        return true;
      }

      static bool elh(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
        uint64_t Imm;
        uint16_t Tmp;
        SEXT(Imm, Inst.imm, 12);
        uint64_t Nmspace = (uint64_t)(R->ERV64[Inst.rs1]);
        uint64_t SrcAddr = (uint64_t)(R->RV64[Inst.rs1] + Imm);
        if (R->RV64_Tag[Inst.rd] == 0) {
          if( Nmspace != 0x00ull) {
            M->RmtReadMem(Nmspace, SrcAddr, 2, &Tmp, &R->RV64_Tag[Inst.rd]);
          } else {
            M->ReadMem(SrcAddr, 2, &Tmp);
            SEXT(R->RV64[Inst.rd], Tmp, 16);
            R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
            R->RV64_PC += Inst.instSize;
          }
        } else if (R->RV64_Tag[Inst.rd] == 1) {
          SEXT(R->RV64[Inst.rd], Tmp, 16);
          R->RV64_PC += Inst.instSize;
          R->RV64_Tag[Inst.rd] = 0;
        } 
        return true;
      }

      static bool elhu(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
        uint64_t Imm;
        uint16_t Tmp;
        SEXT(Imm, Inst.imm, 12);
        uint64_t Nmspace = (uint64_t)(R->ERV64[Inst.rs1]);
        uint64_t SrcAddr = (uint64_t)(R->RV64[Inst.rs1] + Imm);
        if (R->RV64_Tag[Inst.rd] == 0) {
          if( Nmspace != 0x00ull) {
            M->RmtReadMem(Nmspace, SrcAddr, 2, &Tmp, &R->RV64_Tag[Inst.rd]);
          } else {
            M->ReadMem(SrcAddr, 2, &Tmp);
            ZEXT(R->RV64[Inst.rd], Tmp, 16);
            R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
            R->RV64_PC += Inst.instSize;
          }
        } else if (R->RV64_Tag[Inst.rd] == 1) {
          ZEXT(R->RV64[Inst.rd], Tmp, 16);
          R->RV64_PC += Inst.instSize;
          R->RV64_Tag[Inst.rd] = 0;
        } 
        return true;
      }

      static bool elb(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
        uint8_t Tmp;
        uint64_t Imm;
        SEXT(Imm, Inst.imm, 12);
        uint64_t Nmspace = (uint64_t)(R->ERV64[Inst.rs1]);
        uint64_t SrcAddr = (uint64_t)(R->RV64[Inst.rs1] + Imm);
        if (R->RV64_Tag[Inst.rd] == 0) {
          if( Nmspace != 0x00ull) {
            M->RmtReadMem(Nmspace, SrcAddr, 1, &Tmp, &R->RV64_Tag[Inst.rd]);
          } else {
            M->ReadMem(SrcAddr, 1, &Tmp);
            SEXT(R->RV64[Inst.rd], Tmp, 8);
            R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
            R->RV64_PC += Inst.instSize;
          }
        } else if (R->RV64_Tag[Inst.rd] == 1) {
          SEXT(R->RV64[Inst.rd], Tmp, 8);
          R->RV64_PC += Inst.instSize;
          R->RV64_Tag[Inst.rd] = 0;
        } 
        return true;
      }

      static bool elbu(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
        uint8_t Tmp;
        uint64_t Imm;
        SEXT(Imm, Inst.imm, 12);
        uint64_t Nmspace = (uint64_t)(R->ERV64[Inst.rs1]);
        uint64_t SrcAddr = (uint64_t)(R->RV64[Inst.rs1] + Imm);
        if (R->RV64_Tag[Inst.rd] == 0) {
          if( Nmspace != 0x00ull) {
            M->RmtReadMem(Nmspace, SrcAddr, 1, &Tmp, &R->RV64_Tag[Inst.rd]);
          } else {
            M->ReadMem(SrcAddr, 1, &Tmp);
            ZEXT(R->RV64[Inst.rd], Tmp, 8);
            R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
            R->RV64_PC += Inst.instSize;
          }
        } else if (R->RV64_Tag[Inst.rd] == 1) {
          ZEXT(R->RV64[Inst.rd], Tmp, 8);
          R->RV64_PC += Inst.instSize;
          R->RV64_Tag[Inst.rd] = 0;
        } 
        return true;
      }

      static bool ele(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
        uint64_t Imm;
        SEXT(Imm, Inst.imm, 12);
        uint64_t SrcAddr = (uint64_t)(R->RV64[Inst.rs1] + Imm);
        M->ReadMem(SrcAddr, 8, &R->ERV64[Inst.rd]);
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool esq(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
        // Todo
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool esd(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
        uint64_t Imm;
        SEXT(Imm, Inst.imm, 12);
        uint64_t Nmspace = (uint64_t)(R->ERV64[Inst.rs2]);
        uint64_t DestAddr = (uint64_t)(R->RV64[Inst.rs2] + Imm);

  #ifdef _XBGAS_DEBUG_
        std::cout << " esd: Namespace: " << std::dec << Nmspace
                  << ", Dest Addr: " << std::hex << DestAddr
                  << ", RV64[" << std::dec << (int)(Inst.rs2) << "] = " 
                  << std::dec << R->RV64[Inst.rs2] << std::endl;
  #endif
          
        if( Nmspace != 0x00ull) {
          M->RmtWriteMem(Nmspace, DestAddr, 8, &R->RV64[Inst.rs1]);
        } else {
          M->WriteMem(DestAddr, 8, &R->RV64[Inst.rs1]);
          R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
        }
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool esw(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
        uint64_t Imm;
        SEXT(Imm, Inst.imm, 12);
        uint64_t Nmspace = (uint64_t)(R->ERV64[Inst.rs2]);
        uint64_t DestAddr = (uint64_t)(R->RV64[Inst.rs2] + Imm);
        if( Nmspace != 0x00ull) {
          M->RmtWriteMem(Nmspace, DestAddr, 4, &R->RV64[Inst.rs1]);
        } else {
          M->WriteMem(DestAddr, 4, &R->RV64[Inst.rs1]);
          R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
        }
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool esh(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
        uint64_t Imm;
        SEXT(Imm, Inst.imm, 12);
        uint64_t Nmspace = (uint64_t)(R->ERV64[Inst.rs2]);
        uint64_t DestAddr = (uint64_t)(R->RV64[Inst.rs2] + Imm);
        if( Nmspace != 0x00ull) {
          M->RmtWriteMem(Nmspace, DestAddr, 2, &R->RV64[Inst.rs1]);
        } else {
          M->WriteMem(DestAddr, 2, &R->RV64[Inst.rs1]);
          R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
        }
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool esb(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
        uint64_t Imm;
        SEXT(Imm, Inst.imm, 12);
        uint64_t Nmspace = (uint64_t)(R->ERV64[Inst.rs2]);
        uint64_t DestAddr = (uint64_t)(R->RV64[Inst.rs2] + Imm);
        if( Nmspace != 0x00ull) {
          M->RmtWriteMem(Nmspace, DestAddr, 1, &R->RV64[Inst.rs1]);
        } else {
          M->WriteMem(DestAddr, 1, &R->RV64[Inst.rs1]);
          R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
        }
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool ese(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
        uint64_t Imm;
        SEXT(Imm, Inst.imm, 12);
        uint64_t DestAddr = (uint64_t)(R->RV64[Inst.rs2] + Imm);
        M->WriteMem(DestAddr, 8, &R->ERV64[Inst.rs1]);
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool erld(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
        uint64_t Nmspace = (uint64_t)(R->ERV64[Inst.rs2]);
        uint64_t SrcAddr = (uint64_t)(R->RV64[Inst.rs1]);
        if (R->RV64_Tag[Inst.rd] == 0) {
  #ifdef _XBGAS_DEBUG_
          std::cout << "Before erld: Namespace: " << std::dec << Nmspace
                    << ", Source Addr: " << std::hex << SrcAddr
                    << ", RV64[" << std::dec << (int)(Inst.rd) << "] = " 
                    << std::dec << R->RV64[Inst.rd] << std::endl;
  #endif
          
          if( Nmspace != 0x00ull) {
            M->RmtReadMem(Nmspace, SrcAddr, 8, &R->RV64[Inst.rd], &R->RV64_Tag[Inst.rd]);
          } else {
            // M->ReadVal(SrcAddr, &R->RV64[Inst.rd], REVMEM_FLAGS(0x00));
            M->ReadMem(SrcAddr, 8, &R->RV64[Inst.rd]);
            R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
            R->RV64_PC += Inst.instSize;
          }
        } else if (R->RV64_Tag[Inst.rd] == 1) {
          R->RV64_PC += Inst.instSize;
          R->RV64_Tag[Inst.rd] = 0;

#ifdef _XBGAS_DEBUG_
        std::cout << "After eld: RV64[" << std::dec << (int)(Inst.rd) << "] = " 
                  << std::dec << R->RV64[Inst.rd] << std::endl;
#endif

        } else {
          // Do nothing. Waiting for the remote memory response
        }

        return true;
      }

      static bool erlw(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
        uint32_t Tmp;
        uint64_t Nmspace = (uint64_t)(R->ERV64[Inst.rs2]);
        uint64_t SrcAddr = (uint64_t)(R->RV64[Inst.rs1]);
        if (R->RV64_Tag[Inst.rd] == 0) {
          if( Nmspace != 0x00ull) {
            M->RmtReadMem(Nmspace, SrcAddr, 4, &Tmp, &R->RV64_Tag[Inst.rd]);
          } else {
            M->ReadMem(SrcAddr, 4, &Tmp);
            SEXT(R->RV64[Inst.rd], Tmp, 32);
            R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
            R->RV64_PC += Inst.instSize;
          }
        } else if (R->RV64_Tag[Inst.rd] == 1) {
          SEXT(R->RV64[Inst.rd], Tmp, 32);
          R->RV64_PC += Inst.instSize;
          R->RV64_Tag[Inst.rd] = 0;
        } 
        return true;
      }

      static bool erlh(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
        uint16_t Tmp;
        uint64_t Nmspace = (uint64_t)(R->ERV64[Inst.rs2]);
        uint64_t SrcAddr = (uint64_t)(R->RV64[Inst.rs1]);
        if (R->RV64_Tag[Inst.rd] == 0) {
          if( Nmspace != 0x00ull) {
            M->RmtReadMem(Nmspace, SrcAddr, 2, &Tmp, &R->RV64_Tag[Inst.rd]);
          } else {
            M->ReadMem(SrcAddr, 2, &Tmp);
            SEXT(R->RV64[Inst.rd], Tmp, 16);
            R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
            R->RV64_PC += Inst.instSize;
          }
        } else if (R->RV64_Tag[Inst.rd] == 1) {
          SEXT(R->RV64[Inst.rd], Tmp, 16);
          R->RV64_PC += Inst.instSize;
          R->RV64_Tag[Inst.rd] = 0;
        } 
        return true;
      }

      static bool erlhu(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
        uint16_t Tmp;
        uint64_t Nmspace = (uint64_t)(R->ERV64[Inst.rs2]);
        uint64_t SrcAddr = (uint64_t)(R->RV64[Inst.rs1]);
        if (R->RV64_Tag[Inst.rd] == 0) {
          if( Nmspace != 0x00ull) {
            M->RmtReadMem(Nmspace, SrcAddr, 2, &Tmp, &R->RV64_Tag[Inst.rd]);
          } else {
            M->ReadMem(SrcAddr, 2, &Tmp);
            ZEXT(R->RV64[Inst.rd], Tmp, 16);
            R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
            R->RV64_PC += Inst.instSize;
          }
        } else if (R->RV64_Tag[Inst.rd] == 1) {
          ZEXT(R->RV64[Inst.rd], Tmp, 16);
          R->RV64_PC += Inst.instSize;
          R->RV64_Tag[Inst.rd] = 0;
        } 
        return true;
      }

      static bool erlb(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
        uint8_t Tmp;
        uint64_t Nmspace = (uint64_t)(R->ERV64[Inst.rs2]);
        uint64_t SrcAddr = (uint64_t)(R->RV64[Inst.rs1]);
        if (R->RV64_Tag[Inst.rd] == 0) {
          if( Nmspace != 0x00ull) {
            M->RmtReadMem(Nmspace, SrcAddr, 1, &Tmp, &R->RV64_Tag[Inst.rd]);
          } else {
            M->ReadMem(SrcAddr, 1, &Tmp);
            SEXT(R->RV64[Inst.rd], Tmp, 8);
            R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
            R->RV64_PC += Inst.instSize;
          }
        } else if (R->RV64_Tag[Inst.rd] == 1) {
          SEXT(R->RV64[Inst.rd], Tmp, 8);
          R->RV64_PC += Inst.instSize;
          R->RV64_Tag[Inst.rd] = 0;
        } 
        return true;
      }

      static bool erlbu(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
        uint8_t Tmp;
        uint64_t Nmspace = (uint64_t)(R->ERV64[Inst.rs2]);
        uint64_t SrcAddr = (uint64_t)(R->RV64[Inst.rs1]);
        if (R->RV64_Tag[Inst.rd] == 0) {
          if( Nmspace != 0x00ull) {
            M->RmtReadMem(Nmspace, SrcAddr, 1, &Tmp, &R->RV64_Tag[Inst.rd]);
          } else {
            M->ReadMem(SrcAddr, 1, &Tmp);
            ZEXT(R->RV64[Inst.rd], Tmp, 8);
            R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
            R->RV64_PC += Inst.instSize;
          }
        } else if (R->RV64_Tag[Inst.rd] == 1) {
          ZEXT(R->RV64[Inst.rd], Tmp, 8);
          R->RV64_PC += Inst.instSize;
          R->RV64_Tag[Inst.rd] = 0;
        } 
        return true;
      }

      static bool erle(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
        uint64_t Nmspace = (uint64_t)(R->ERV64[Inst.rs2]);
        uint64_t SrcAddr = (uint64_t)(R->RV64[Inst.rs1]);
        if (R->RV64_Tag[Inst.rd] == 0) {
          if( Nmspace != 0x00ull) {
            M->RmtReadMem(Nmspace, SrcAddr, 8, &R->ERV64[Inst.rd], &R->RV64_Tag[Inst.rd]);
          } else {
            // M->ReadVal(SrcAddr, &R->RV64[Inst.rd], REVMEM_FLAGS(0x00));
            M->ReadMem(SrcAddr, 8, &R->ERV64[Inst.rd]);
            R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
            R->RV64_PC += Inst.instSize;
          }
        } else if (R->RV64_Tag[Inst.rd] == 1) {
          R->RV64_PC += Inst.instSize;
          R->RV64_Tag[Inst.rd] = 0;
        } else {
          // Do nothing. Waiting for the remote memory response
        }
        return true;
      }

      static bool ersd(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
        uint64_t Nmspace = (uint64_t)(R->ERV64[Inst.rd]);
        uint64_t DestAddr = (uint64_t)(R->RV64[Inst.rs2]);
  #ifdef _XBGAS_DEBUG_
        std::cout << " ersd: Namespace: " << std::dec << Nmspace
                  << ", Dest Addr: " << std::hex << DestAddr
                  << ", RV64[" << std::dec << (int)(Inst.rd) << "] = " 
                  << std::dec << R->RV64[Inst.rd] << std::endl;
  #endif
          
        if( Nmspace != 0x00ull) {
          M->RmtWriteMem(Nmspace, DestAddr, 8, &R->RV64[Inst.rs1]);
        } else {
          M->WriteMem(DestAddr, 8, &R->RV64[Inst.rs1]);
          R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
        }
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool ersw(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
        uint64_t Nmspace = (uint64_t)(R->ERV64[Inst.rd]);
        uint64_t DestAddr = (uint64_t)(R->RV64[Inst.rs2]);
        if( Nmspace != 0x00ull) {
          M->RmtWriteMem(Nmspace, DestAddr, 4, &R->RV64[Inst.rs1]);
        } else {
          M->WriteMem(DestAddr, 4, &R->RV64[Inst.rs1]);
          R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
        }
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool ersh(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
        uint64_t Nmspace = (uint64_t)(R->ERV64[Inst.rd]);
        uint64_t DestAddr = (uint64_t)(R->RV64[Inst.rs2]);
        if( Nmspace != 0x00ull) {
          M->RmtWriteMem(Nmspace, DestAddr, 2, &R->RV64[Inst.rs1]);
        } else {
          M->WriteMem(DestAddr, 2, &R->RV64[Inst.rs1]);
          R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
        }
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool ersb(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
        uint64_t Nmspace = (uint64_t)(R->ERV64[Inst.rd]);
        uint64_t DestAddr = (uint64_t)(R->RV64[Inst.rs2]);
        if( Nmspace != 0x00ull) {
          M->RmtWriteMem(Nmspace, DestAddr, 1, &R->RV64[Inst.rs1]);
        } else {
          M->WriteMem(DestAddr, 1, &R->RV64[Inst.rs1]);
          R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
        }
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool erse(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
        uint64_t Nmspace = (uint64_t)(R->ERV64[Inst.rd]);
        uint64_t DestAddr = (uint64_t)(R->RV64[Inst.rs2]);

  #ifdef _XBGAS_DEBUG_
        std::cout << " erse: Namespace: " << std::dec << Nmspace
                  << ", Dest Addr: " << std::hex << DestAddr
                  << ", RV64[" << std::dec << (int)(Inst.rs2) << "] = " 
                  << std::dec << R->ERV64[Inst.rd] << std::endl;
  #endif
          
        if( Nmspace != 0x00ull) {
          M->RmtWriteMem(Nmspace, DestAddr, 8, &R->ERV64[Inst.rs1]);
        } else {
          M->WriteMem(DestAddr, 8, &R->ERV64[Inst.rs1]);
          R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
        }
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool eaddi(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
        uint64_t Tmp;
        SEXT(Tmp, Inst.imm, 12);
        R->RV64[Inst.rd] = (uint64_t)(R->ERV64[Inst.rs1] + Tmp);
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool eaddie(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
        uint64_t Tmp;
        SEXT(Tmp, Inst.imm, 12);
        R->ERV64[Inst.rd] = (uint64_t)(R->RV64[Inst.rs1] + Tmp);
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool eaddix(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
        uint64_t Tmp;
        SEXT(Tmp, Inst.imm, 12);
        R->ERV64[Inst.rd] = (uint64_t)(R->ERV64[Inst.rs1] + Tmp);
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool ebld(RevFeature *F, RevRegFile *R, RevMem *M, RevInst Inst) {
        uint64_t Nmspace = (uint64_t)(R->ERV64[Inst.rd]);
        uint64_t DestAddr = (uint64_t)(R->RV64[Inst.rd]);
        uint64_t SrcAddr = (uint64_t)(R->RV64[Inst.rs1]);
        uint32_t Nelem = (uint32_t)(R->RV64[Inst.rs2]);
        uint32_t Stride = (uint32_t)(R->RV64[Inst.rs3]);

  // #ifdef _XBGAS_DEBUG_
  //         std::cout << "Before ebld: Namespace: " << std::dec << Nmspace
  //                   << ", Dest Addr: " << std::hex << DestAddr
  //                   << ", Source Addr: " << std::hex << SrcAddr
  //                   << ", Nelem: " << std::dec << (int)(Nelem)
  //                   << ", Stride: " << std::dec << (int)(Stride)
  //                   << std::endl;
  // #endif
        if( Nmspace != 0x00ull) {
          M->RmtBulkReadMem(Nmspace, SrcAddr, 8, Nelem, Stride, R->RV64[Inst.rd]);
        }
        R->RV64_PC += Inst.instSize;

        // update the cost
        R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());

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
        // {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("elq %rd, $imm(%rs1)"      ).SetCost(1).SetOpcode(0b1110111).SetFunct3(0b110).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &elq ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("eld %rd, $imm(%rs1)"       ).SetCost(1).SetOpcode(0b1110111).SetFunct3(0b011).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &eld ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("elw %rd, $imm(%rs1)"       ).SetCost(1).SetOpcode(0b1110111).SetFunct3(0b010).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &elw ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("elh %rd, $imm(%rs1)"       ).SetCost(1).SetOpcode(0b1110111).SetFunct3(0b001).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &elh ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("elhu %rd, $imm(%rs1)"      ).SetCost(1).SetOpcode(0b1110111).SetFunct3(0b101).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &elhu).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("elb %rd, $imm(%rs1)"       ).SetCost(1).SetOpcode(0b1110111).SetFunct3(0b000).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &elb ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("elbu %rd, $imm(%rs1)"      ).SetCost(1).SetOpcode(0b1110111).SetFunct3(0b100).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &elbu).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("ele %extd, $imm(%rs1)"     ).SetCost(1).SetOpcode(0b1110111).SetFunct3(0b111).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &ele ).InstEntry},

        // Store instructions are encoded in the S-type format
        // {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("esq %rs1, $imm(%rs2)"     ).SetCost(1).SetOpcode(0b1111011).SetFunct3(0b100).SetFunct7(0b0      ).SetrdClass(RegUNKNOWN).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeS).SetImplFunc( &esq ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("esd %rs1, $imm(%rs2)"      ).SetCost(1).SetOpcode(0b1111011).SetFunct3(0b011).SetFunct7(0b0      ).SetrdClass(RegUNKNOWN).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeS).SetImplFunc( &esd ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("esw %rs1, $imm(%rs2)"      ).SetCost(1).SetOpcode(0b1111011).SetFunct3(0b010).SetFunct7(0b0      ).SetrdClass(RegUNKNOWN).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeS).SetImplFunc( &esw ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("esh %rs1, $imm(%rs2)"      ).SetCost(1).SetOpcode(0b1111011).SetFunct3(0b001).SetFunct7(0b0      ).SetrdClass(RegUNKNOWN).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeS).SetImplFunc( &esh ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("esb %rs1, $imm(%rs2)"      ).SetCost(1).SetOpcode(0b1111011).SetFunct3(0b000).SetFunct7(0b0      ).SetrdClass(RegUNKNOWN).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeS).SetImplFunc( &esb ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("ese %ext1, $imm(%rs2)"     ).SetCost(1).SetOpcode(0b1111011).SetFunct3(0b101).SetFunct7(0b0      ).SetrdClass(RegUNKNOWN).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeS).SetImplFunc( &ese ).InstEntry},
        
        // Raw Load instructions are encoded in the R-type format
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("erld %rd, %rs1, %ext2"     ).SetCost(1).SetOpcode(0b0110011).SetFunct3(0b011).SetFunct7(0b1010101).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &erld ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("erlw %rd, %rs1, %ext2"     ).SetCost(1).SetOpcode(0b0110011).SetFunct3(0b010).SetFunct7(0b1010101).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &erlw ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("erlh %rd, %rs1, %ext2"     ).SetCost(1).SetOpcode(0b0110011).SetFunct3(0b001).SetFunct7(0b1010101).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &erlh ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("erlhu %rd, %rs1, %ext2"    ).SetCost(1).SetOpcode(0b0110011).SetFunct3(0b101).SetFunct7(0b1010101).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &erlhu).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("erlb %rd, %rs1, %ext2"     ).SetCost(1).SetOpcode(0b0110011).SetFunct3(0b000).SetFunct7(0b1010101).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &erlb ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("erlbu %rd, %rs1, %ext2"    ).SetCost(1).SetOpcode(0b0110011).SetFunct3(0b100).SetFunct7(0b1010101).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &erlbu).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("erle %extd, %rs1, %ext2"   ).SetCost(1).SetOpcode(0b0110011).SetFunct3(0b100).SetFunct7(0b0100001).SetrdClass(RegUNKNOWN).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &erle ).InstEntry},

        // Raw Store instructions are encoded in the R-type format
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("ersd %rs1, %rs2, %ext3"    ).SetCost(1).SetOpcode(0b0110011).SetFunct3(0b011).SetFunct7(0b0100010).SetrdClass(RegUNKNOWN).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &ersd ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("ersw %rs1, %rs2, %ext3"    ).SetCost(1).SetOpcode(0b0110011).SetFunct3(0b010).SetFunct7(0b0100010).SetrdClass(RegUNKNOWN).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &ersw ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("ersh %rs1, %rs2, %ext3"    ).SetCost(1).SetOpcode(0b0110011).SetFunct3(0b001).SetFunct7(0b0100010).SetrdClass(RegUNKNOWN).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &ersh ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("ersb %rs1, %rs2, %ext3"    ).SetCost(1).SetOpcode(0b0110011).SetFunct3(0b000).SetFunct7(0b0100010).SetrdClass(RegUNKNOWN).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &ersb ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("erse %ext1, %rs2, %ext3"   ).SetCost(1).SetOpcode(0b0110011).SetFunct3(0b011).SetFunct7(0b0100011).SetrdClass(RegUNKNOWN).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &erse ).InstEntry},

        // Aggreagtion instruction is encoded in the R-type format.
        // {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("eag %rd, %rs1, %rs2"      ).SetCost(1).SetOpcode(0b0110011).SetFunct3(0b001).SetFunct7(0b0100011).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FUnk).SetFormat(RVTypeR).SetImplFunc( &eag  ).InstEntry},

        // Address Management Instructions are encoded in the I-type format
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("eaddi %rd, %ext1, $imm"    ).SetCost(1).SetOpcode(0b1111011).SetFunct3(0b110).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &eaddi ).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("eaddie %extd, %rs1, $imm"  ).SetCost(1).SetOpcode(0b1111011).SetFunct3(0b111).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &eaddie).InstEntry},
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("eaddix %extd, %ext1, $imm" ).SetCost(1).SetOpcode(0b0000011).SetFunct3(0b111).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegUNKNOWN).Setrs3Class(RegUNKNOWN).Setimm12(0b0).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &eaddix).InstEntry},

        // Bulk Load instruction is encoded in the R4-type format
        {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("ebld %rd, %rs1, %rs2, %rs3").SetCost(1).SetOpcode(0b1000011).SetFunct2(0b11).SetFunct3(0b011).SetFunct7(0b0      ).SetrdClass(RegGPR    ).Setrs1Class(RegGPR    ).Setrs2Class(RegGPR    ).Setrs3Class(RegGPR    ).SetFormat(RVTypeR4).SetImplFunc(&ebld ).InstEntry},

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