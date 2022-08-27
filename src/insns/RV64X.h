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

#include <bitset>

#include "RevInstTable.h"

using namespace SST::RevCPU;

namespace SST{
  namespace RevCPU{
    class RV64X : public RevExt {

      static bool elq(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // TODO
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool eld(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint8_t Tag = 0;
        // Search in TrackGets, if found, the request has been sent;
        // Use the corresponding Tag to get the data from GetResponse;
        // Send remote memory request otherwise.
        uint64_t EXT1 = (uint64_t)(R->ERV64[Inst.rs1]);
        uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]+(int32_t)(td_u32(Inst.imm,12)));
        if (EXT1 != 0x0) {
          if ( !Xbgas->checkGetRequests(EXT1, Addr, &Tag) ) {
            Xbgas->ReadU64(EXT1, Addr);
          } else {
            uint64_t Value;
            if( Xbgas->readGetResponses(Tag, (void *)(&Value)) ) {
              R->RV64[Inst.rd] = Value;
              R->RV64_PC += Inst.instSize;

#ifdef _XBGAS_DEBUG_
            int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
            if (id == 0) 
            { 
              std::cout << "_XBGAS_DEBUG_ CPU" << id
                        << ": [eld]\tRV64[" << std::dec << +Inst.rd
                        << "](0x" << std::hex << R->RV64[Inst.rd]
                        << ") = Nmspace(0x"<< std::hex << EXT1
                        << ") @ Addr(0x" << std::hex << Addr
                        << ")" << std::endl;
              
            }
#endif
            }
          }
        } else {
          R->RV64[Inst.rd] = M->ReadU64(Addr);
          R->RV64_PC += Inst.instSize;
          R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
        }

        return true;
      }

      static bool elw(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint8_t Tag = 0;
        uint64_t EXT1 = (uint64_t)(R->ERV64[Inst.rs1]);
        uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]+(int32_t)(td_u32(Inst.imm,12)));
        if (EXT1 != 0x0) {
          if ( !Xbgas->checkGetRequests(EXT1, Addr, &Tag) ) {
            Xbgas->ReadU32(EXT1, Addr);
          } else {
            uint32_t Value;
            if( Xbgas->readGetResponses(Tag, (void *)(&Value)) ) {
              SEXT(R->RV64[Inst.rd], Value, 32);
              R->RV64_PC += Inst.instSize;
#ifdef _XBGAS_DEBUG_
            int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
            if (id == 0) 
            {
              std::cout << "_XBGAS_DEBUG_ CPU" << id
                        << ": [elw]\tRV64[" << std::dec << +Inst.rd
                        << "](0x" << std::hex << R->RV64[Inst.rd]
                        << ") = Nmspace(0x"<< std::hex << EXT1
                        << ") @ Addr(0x" << std::hex << Addr
                        << ")" << std::endl;
              
            }
#endif
            }
          }
        } else {
          SEXT(R->RV64[Inst.rd], M->ReadU32(Addr), 32);
          R->RV64_PC += Inst.instSize;
          R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
        }
        return true;
      }

      static bool elh(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint8_t Tag = 0;
        uint64_t EXT1 = (uint64_t)(R->ERV64[Inst.rs1]);
        uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]+(int32_t)(td_u32(Inst.imm,12)));
        if (EXT1 != 0x0){
          if ( !Xbgas->checkGetRequests(EXT1, Addr, &Tag) ) {
            Xbgas->ReadU16(EXT1, Addr);
          } else {
            uint16_t Value;
            if( Xbgas->readGetResponses(Tag, (void *)(&Value)) ) {
              SEXT(R->RV64[Inst.rd], Value, 16);
              R->RV64_PC += Inst.instSize;
#ifdef _XBGAS_DEBUG_
            int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
            if (id == 0) 
            {
              std::cout << "_XBGAS_DEBUG_ CPU" << id
                        << ": [elh]\tRV64[" << std::dec << +Inst.rd
                        << "](0x" << std::hex << R->RV64[Inst.rd]
                        << ") = Nmspace(0x"<< std::hex << EXT1
                        << ") @ Addr(0x" << std::hex << Addr
                        << ")" << std::endl;
              
            }
#endif
            }
          }
        } else {
          SEXT(R->RV64[Inst.rd], M->ReadU16(Addr), 16);
          R->RV64_PC += Inst.instSize;
          R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
        }
        return true;
      }

      static bool elhu(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint8_t Tag = 0;
        uint64_t EXT1 = (uint64_t)(R->ERV64[Inst.rs1]);
        uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]+(int32_t)(td_u32(Inst.imm,12)));
        if (EXT1 != 0x0){
          if ( !Xbgas->checkGetRequests(EXT1, Addr, &Tag) ) {
            Xbgas->ReadU16(EXT1, Addr);
          } else {
            uint16_t Value;
            if( Xbgas->readGetResponses(Tag, (void *)(&Value)) ) {
              R->RV64[Inst.rd] = Value;
              R->RV64_PC += Inst.instSize;
#ifdef _XBGAS_DEBUG_
            int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
            if (id == 0) 
            {
              std::cout << "_XBGAS_DEBUG_ CPU" << id
                        << ": [elhu]\tRV64[" << std::dec << +Inst.rd
                        << "](0x" << std::hex << R->RV64[Inst.rd]
                        << ") = Nmspace(0x"<< std::hex << EXT1
                        << ") @ Addr(0x" << std::hex << Addr
                        << ")" << std::endl;
              
            }
#endif
            }
          }
        } else {
          R->RV64[Inst.rd] = M->ReadU16(Addr);
          R->RV64_PC += Inst.instSize;
          R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
        }
        return true;
      }

      static bool elb(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint8_t Tag = 0;
        uint64_t EXT1 = (uint64_t)(R->ERV64[Inst.rs1]);
        uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]+(int32_t)(td_u32(Inst.imm,12)));
        if (EXT1 != 0x0){
          if ( !Xbgas->checkGetRequests(EXT1, Addr, &Tag) ) {
            Xbgas->ReadU8(EXT1, Addr);
          } else {
            uint8_t Value;
            if( Xbgas->readGetResponses(Tag, (void *)(&Value)) ) {
              SEXT(R->RV64[Inst.rd], Value, 8);
              R->RV64_PC += Inst.instSize;
#ifdef _XBGAS_DEBUG_
            int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
            if (id == 0) 
            {
              std::cout << "_XBGAS_DEBUG_ CPU" << id
                        << ": [elb]\tRV64[" << std::dec << +Inst.rd
                        << "](0x" << std::hex << R->RV64[Inst.rd]
                        << ") = Nmspace(0x"<< std::hex << EXT1
                        << ") @ Addr(0x" << std::hex << Addr
                        << ")" << std::endl;
              
            }
#endif
            }
          }
        } else {
          SEXT(R->RV64[Inst.rd], M->ReadU8(Addr), 8);
          R->RV64_PC += Inst.instSize;
          R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
        }
        return true;
      }

      static bool elbu(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint8_t Tag = 0;
        uint64_t EXT1 = (uint64_t)(R->ERV64[Inst.rs1]);
        uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]+(int32_t)(td_u32(Inst.imm,12)));
        if (EXT1 != 0x0){
          if ( !Xbgas->checkGetRequests(EXT1, Addr, &Tag) ) {
            Xbgas->ReadU8(EXT1, Addr);
          } else {
            uint8_t Value;
            if( Xbgas->readGetResponses(Tag, (void *)(&Value)) ) {
              R->RV64[Inst.rd] = Value;
              R->RV64_PC += Inst.instSize;
#ifdef _XBGAS_DEBUG_
            int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
            if (id == 0) 
            {
              std::cout << "_XBGAS_DEBUG_ CPU" << id
                        << ": [elbu]\tRV64[" << std::dec << +Inst.rd
                        << "](0x" << std::hex << R->RV64[Inst.rd]
                        << ") = Nmspace(0x"<< std::hex << EXT1
                        << ") @ Addr(0x" << std::hex << Addr
                        << ")" << std::endl;
              
            }
#endif
            }
          }
        } else {
          R->RV64[Inst.rd] = M->ReadU8(Addr);
          R->RV64_PC += Inst.instSize;
          R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
        }
        return true;
      }

      static bool ele(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]+(int32_t)(td_u32(Inst.imm,12)));
        R->ERV64[Inst.rd] = M->ReadU64(Addr);
        R->RV64_PC += Inst.instSize;
#ifdef _XBGAS_DEBUG_
            int64_t id = (int64_t)(M->ReadU32(_XBGAS_MY_PE_ADDR_));
            if (id == 0) 
            { 
              std::cout << "_XBGAS_DEBUG_ CPU" << id
                        << ": [ele]\tERV64[" << std::dec << +Inst.rd
                        << "](0x" << std::hex << R->ERV64[Inst.rd]
                        << ") = @ Addr(0x" << std::hex << Addr
                        << ")" << std::endl;
              
            }
#endif
        return true;
      }

      static bool esq(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // TODO
        R->RV64_PC += Inst.instSize;
        return true;
      }

      static bool esd(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        
        /* The following implementation is based on xBGAS 0.0.6*/
        // esd rs1, imm(rs2)
        // uint64_t EXT2 = R->ERV64[Inst.rs2];
        // uint64_t Addr = (uint64_t)(R->RV32[Inst.rs2]+(int32_t)(td_u32(Inst.imm,12)));

        // if (EXT2 != 0x0) {
        //   Xbgas->WriteU64( EXT2, Addr, R->RV64[Inst.rs1] );
        // } else {
        //   M->WriteU64( Addr, R->RV64[Inst.rs1]);
        // }
        // R->RV64_PC += Inst.instSize;

        /* The following implementation is based on xbgas-tool (branch: test)*/
        // esd rs2, imm(rs1)

        uint64_t EXT2 = R->ERV64[Inst.rs1];
        uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]+(int64_t)(td_u64(Inst.imm,12)));

        if (EXT2 != 0x0) {
          Xbgas->WriteU64( EXT2, Addr, R->RV64[Inst.rs2] );
        } else {
          M->WriteU64( Addr, R->RV64[Inst.rs2]);
        }
        R->RV64_PC += Inst.instSize;

#ifdef _XBGAS_DEBUG_
          int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
          if(id == 0) 
          {
            std::cout << "_XBGAS_DEBUG_ CPU" << id
                      << ": [esd]\tNamespace(0x" << EXT2
                      << ") @ Addr(0x" << std::hex << Addr
                      << ") = RV64[" << std::dec << +Inst.rs2
                      << "](0x" << std::hex << R->RV64[Inst.rs2]
                      << ")" << std::endl;
          }
#endif

        return true;
      }

      static bool esw(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // uint64_t EXT2 = R->ERV64[Inst.rs2];
        // uint64_t Addr = (uint64_t)(R->RV64[Inst.rs2]+(int64_t)(td_u64(Inst.imm,12)));

        // if (EXT2 != 0x0) {
        //   Xbgas->WriteU32( EXT2, Addr, (uint32_t)(R->RV64[Inst.rs1]) );
        // } else {
        //   M->WriteU32( Addr, (uint32_t)(R->RV64[Inst.rs1]) );
        // }
        // R->RV64_PC += Inst.instSize;

        /* The following implementation is based on xbgas-tool (branch: test)*/
        // esw rs2, imm(rs1)
        uint64_t EXT2 = R->ERV64[Inst.rs1];
        uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]+(int64_t)(td_u64(Inst.imm,12)));

        if (EXT2 != 0x0) {
          Xbgas->WriteU32( EXT2, Addr, (uint32_t)(R->RV64[Inst.rs2]) );
        } else {
          M->WriteU32( Addr, (uint32_t)(R->RV64[Inst.rs2]));
        }
        R->RV64_PC += Inst.instSize;

#ifdef _XBGAS_DEBUG_
          int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
          if(id == 0) {
            std::cout << "_XBGAS_DEBUG_ CPU" << id
                      << ": [esw]\tNamespace(0x" << EXT2
                      << ") @ Addr(0x" << std::hex << Addr
                      << ") = RV64[" << std::dec << +Inst.rs2
                      << "](0x" << std::hex << R->RV64[Inst.rs2]
                      << ")" << std::endl;
          }
#endif

        
        return true;
      }

      static bool esh(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // uint64_t EXT2 = R->ERV64[Inst.rs2];
        // uint64_t Addr = (uint64_t)(R->RV32[Inst.rs2]+(int32_t)(td_u32(Inst.imm,12)));

        // if (EXT2 != 0x0) {
        //   Xbgas->WriteU16( EXT2, Addr, (uint16_t)(R->RV64[Inst.rs1]) );
        // } else {
        //   M->WriteU16( Addr, (uint16_t)(R->RV64[Inst.rs1]) );
        // }
        // R->RV64_PC += Inst.instSize;

        /* The following implementation is based on xbgas-tool (branch: test)*/
        // esh rs2, imm(rs1)
        uint64_t EXT2 = R->ERV64[Inst.rs1];
        uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]+(int64_t)(td_u64(Inst.imm,12)));

        if (EXT2 != 0x0) {
          Xbgas->WriteU16( EXT2, Addr, (uint16_t)(R->RV64[Inst.rs2]) );
        } else {
          M->WriteU16( Addr, (uint16_t)(R->RV64[Inst.rs2]));
        }
        R->RV64_PC += Inst.instSize;

#ifdef _XBGAS_DEBUG_
          int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
          if(id == 0) {
            std::cout << "_XBGAS_DEBUG_ CPU" << id
                      << ": [esh]\tNamespace(0x" << EXT2
                      << ") @ Addr(0x" << std::hex << Addr
                      << ") = RV64[" << std::dec << +Inst.rs2
                      << "](0x" << std::hex << R->RV64[Inst.rs2]
                      << ")" << std::endl;
          }
#endif  
        return true;
      }

      static bool esb(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // uint64_t EXT2 = R->ERV64[Inst.rs2];
        // uint64_t Addr = (uint64_t)(R->RV32[Inst.rs2]+(int32_t)(td_u32(Inst.imm,12)));

        // if (EXT2 != 0x0) {
        //   Xbgas->WriteU8( EXT2, Addr, (uint8_t)(R->RV64[Inst.rs1]) );
        // } else {
        //   M->WriteU8( Addr, (uint8_t)(R->RV64[Inst.rs1]) );
        // }
        // R->RV64_PC += Inst.instSize;

        /* The following implementation is based on xbgas-tool (branch: test)*/
        // esb rs2, imm(rs1)
        uint64_t EXT2 = R->ERV64[Inst.rs1];
        uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]+(int64_t)(td_u64(Inst.imm,12)));

        if (EXT2 != 0x0) {
          Xbgas->WriteU8( EXT2, Addr, (uint8_t)(R->RV64[Inst.rs2]) );
        } else {
          M->WriteU8( Addr, (uint8_t)(R->RV64[Inst.rs2]));
        }
        R->RV64_PC += Inst.instSize;

#ifdef _XBGAS_DEBUG_
          int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
          if(id == 0) {
            std::cout << "_XBGAS_DEBUG_ CPU" << id
                      << ": [esb]\tNamespace(0x" << EXT2
                      << ") @ Addr(0x" << std::hex << Addr
                      << ") = RV64[" << std::dec << +Inst.rs2
                      << "](0x" << std::hex << R->RV64[Inst.rs2]
                      << ")" << std::endl;
          }
#endif
        
        return true;
      }
      
      static bool ese(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // uint64_t EXT1 = R->ERV64[Inst.rs1];
        // uint64_t Addr = (uint64_t)(R->RV64[Inst.rs2]+(int64_t)(td_u64(Inst.imm,12)));
        // M->WriteU64(Addr, EXT1);
        // R->RV64_PC += Inst.instSize;

        /* The following implementation is based on xbgas-tool (branch: test)*/
        // ese ext1, imm(rs1)
        uint64_t EXT1 = R->ERV64[Inst.rs2];
        uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]+(int64_t)(td_u64(Inst.imm,12)));
        M->WriteU64(Addr, EXT1);
        R->RV64_PC += Inst.instSize;

#ifdef _XBGAS_DEBUG_
          int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
          if(id == 0) {
            std::cout << "_XBGAS_DEBUG_ CPU" << id
                      << ": [ese]\tAddr(0x" << std::hex << Addr
                      << ") = ERV64[" << std::dec << +Inst.rs2
                      << "](0x" << std::hex << EXT1
                      << ")" << std::endl;        
          }
#endif

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
            R->RV64[Inst.rd] = Value;
            R->RV64_PC += Inst.instSize;

#ifdef _XBGAS_DEBUG_
            int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
            if (id == 0) {
              std::cout << "_XBGAS_DEBUG_ CPU" << id
                        << ": [erld]\tRV64[" << std::dec << +Inst.rd
                        << "](0x" << std::hex << R->RV64[Inst.rd]
                        << ") = Nmspace(0x"<< std::hex << EXT2
                        << ") @ Addr(0x" << std::hex << Addr
                        << ")" << std::endl;
            }
#endif
          }
        }
        return true;
      }

      static bool erlw(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint8_t Tag = 0;
        uint64_t EXT2 = (uint64_t)(R->ERV64[Inst.rs2]);
        uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]);
        if ( !Xbgas->checkGetRequests(EXT2, Addr, &Tag) ) {
          Xbgas->ReadU32(EXT2, Addr);
        } else {
          uint32_t Value;
          if( Xbgas->readGetResponses(Tag, (void *)(&Value)) ) {
            SEXT(R->RV64[Inst.rd], Value, 32);
            R->RV64_PC += Inst.instSize;
#ifdef _XBGAS_DEBUG_
            int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
            if (id == 0) {
              std::cout << "_XBGAS_DEBUG_ CPU" << id
                        << ": [erlw]\tRV64[" << std::dec << +Inst.rd
                        << "](0x" << std::hex << R->RV64[Inst.rd]
                        << ") = Nmspace(0x"<< std::hex << EXT2
                        << ") @ Addr(0x" << std::hex << Addr
                        << ")" << std::endl;
            }
#endif
          }
        }
        return true;
      }

      static bool erlh(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint8_t Tag = 0;
        uint64_t EXT2 = (uint64_t)(R->ERV64[Inst.rs2]);
        uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]);
        if ( !Xbgas->checkGetRequests(EXT2, Addr, &Tag) ) {
          Xbgas->ReadU16(EXT2, Addr);
        } else {
          uint16_t Value;
          if( Xbgas->readGetResponses(Tag, (void *)(&Value)) ) {
            SEXT(R->RV64[Inst.rd], Value, 16);
            R->RV64_PC += Inst.instSize;
#ifdef _XBGAS_DEBUG_
            int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
            if (id == 0) {
              std::cout << "_XBGAS_DEBUG_ CPU" << id
                        << ": [erlh]\tRV64[" << std::dec << +Inst.rd
                        << "](0x" << std::hex << R->RV64[Inst.rd]
                        << ") = Nmspace(0x"<< std::hex << EXT2
                        << ") @ Addr(0x" << std::hex << Addr
                        << ")" << std::endl;
            }
#endif
          }
        }
        return true;
      }

      static bool erlhu(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint8_t Tag = 0;
        uint64_t EXT2 = (uint64_t)(R->ERV64[Inst.rs2]);
        uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]);
        if ( !Xbgas->checkGetRequests(EXT2, Addr, &Tag) ) {
          Xbgas->ReadU16(EXT2, Addr);
        } else {
          uint16_t Value;
          if( Xbgas->readGetResponses(Tag, (void *)(&Value)) ) {
            R->RV64[Inst.rd] = Value;
            R->RV64_PC += Inst.instSize;
#ifdef _XBGAS_DEBUG_
            int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
            if (id == 0) {
              std::cout << "_XBGAS_DEBUG_ CPU" << id
                        << ": [erlhu]\tRV64[" << std::dec << +Inst.rd
                        << "](0x" << std::hex << R->RV64[Inst.rd]
                        << ") = Nmspace(0x"<< std::hex << EXT2
                        << ") @ Addr(0x" << std::hex << Addr
                        << ")" << std::endl;
            }
#endif
          }
        }
        return true;
      }

      static bool erlb(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint8_t Tag = 0;
        uint64_t EXT2 = (uint64_t)(R->ERV64[Inst.rs2]);
        uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]);
        if ( !Xbgas->checkGetRequests(EXT2, Addr, &Tag) ) {
          Xbgas->ReadU8(EXT2, Addr);
        } else {
          uint8_t Value;
          if( Xbgas->readGetResponses(Tag, (void *)(&Value)) ) {
            SEXT(R->RV64[Inst.rd], Value, 8);
            R->RV64_PC += Inst.instSize;
#ifdef _XBGAS_DEBUG_
            int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
            if (id == 0) {
              std::cout << "_XBGAS_DEBUG_ CPU" << id
                        << ": [erlb]\tRV64[" << std::dec << +Inst.rd
                        // << "](0x" << std::bitset<64>(R->RV64[Inst.rd])
                        << "](0x" << std::hex << R->RV64[Inst.rd]
                        << ") = Nmspace(0x"<< std::hex << EXT2
                        << ") @ Addr(0x" << std::hex << Addr
                        << ")" << std::endl;
            }
#endif
          }
        }
        return true;
      }

      static bool erlbu(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint8_t Tag = 0;
        uint64_t EXT2 = (uint64_t)(R->ERV64[Inst.rs2]);
        uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]);
        if ( !Xbgas->checkGetRequests(EXT2, Addr, &Tag) ) {
          Xbgas->ReadU8(EXT2, Addr);
        } else {
          uint8_t Value;
          if( Xbgas->readGetResponses(Tag, (void *)(&Value)) ) {
            R->RV64[Inst.rd] = Value;
            R->RV64_PC += Inst.instSize;
#ifdef _XBGAS_DEBUG_
            int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
            if (id == 0) {
              std::cout << "_XBGAS_DEBUG_ CPU" << id
                        << ": [erlbu]\tRV64[" << std::dec << +Inst.rd
                        // << "](0x" << std::bitset<64>(R->RV64[Inst.rd])
                        << "](0x" << std::hex << R->RV64[Inst.rd]
                        << ") = Nmspace(0x"<< std::hex << EXT2
                        << ") @ Addr(0x" << std::hex << Addr
                        << ")" << std::endl;
            }
#endif
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
            R->ERV64[Inst.rd] = Value;
            R->RV64_PC += Inst.instSize;
#ifdef _XBGAS_DEBUG_
            int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
            if (id == 0) {
              std::cout << "_XBGAS_DEBUG_ CPU" << id
                        << ": [erle]\tERV64[" << std::dec << +Inst.rd
                        << "](0x" << std::hex << R->ERV64[Inst.rd]
                        << ") = Nmspace(0x"<< std::hex << EXT2
                        << ") @ Addr(0x" << std::hex << Addr
                        << ")" << std::endl;
            }
#endif
          }
        }
        return true;
      }

      static bool ersd(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        
        /* The following implementation is based on xBGAS 0.0.6*/
        // uint64_t EXT3 = (uint64_t)(R->ERV64[Inst.rd]);
        // uint64_t Addr = (uint64_t)(R->RV64[Inst.rs2]);
        // if( EXT3 != 0x0 ) {
        //   Xbgas->WriteU64( EXT3, Addr, R->RV64[Inst.rs1] );
        // } else {
        //   M->WriteU64( Addr, R->RV64[Inst.rs1] );
        // }
        // R->RV64_PC += Inst.instSize;

// #ifdef _XBGAS_DEBUG_
//           int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
//           if(id == 0) {
//             std::cout << "_XBGAS_DEBUG_ CPU" << id
//                       << ": [ersd]\tStore (0x" << std::hex << R->RV64[Inst.rs1]
//                       << ") to Namespace(0x" << EXT3
//                       << ") @ Addr(0x" << std::hex << Addr
//                       << ")" << std::endl;
//             std::cout << "rs1: " << std::dec << +Inst.rs1
//                       << ", rs2: " << std::dec << +Inst.rs2
//                       << ", rd: " << std::dec << +Inst.rd << std::endl;
//             std::cout << "|---- Register file -----|" << std::endl;
//             for(int i=0; i<32; i++) {
//               std::cout << "|e" <<std::dec << +i
//                         << ": 0x" << std::hex << R->ERV64[i]
//                         << "\t|x" <<std::dec << +i
//                         << ": 0x" << std::hex << R->RV64[i]
//                         << std::endl;
//             }
//             std::cout << "|----- Register file -----|" << std::endl;
//           }
// #endif

        /* The following implementation is based on xbgas-tool (branch: test)*/
        // ersd rd, rs1, rs2
        uint64_t EXT3 = (uint64_t)(R->ERV64[Inst.rs2]);
        uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]);
        if( EXT3 != 0x0 ) {
          Xbgas->WriteU64( EXT3, Addr, R->RV64[Inst.rd] );
        } else {
          M->WriteU64( Addr, R->RV64[Inst.rd] );
        }
        R->RV64_PC += Inst.instSize;

#ifdef _XBGAS_DEBUG_
          int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
          if(id == 0) {
            std::cout << "_XBGAS_DEBUG_ CPU" << id
                      << ": [ersd]\tNamespace(0x" << EXT3
                      << ") @ Addr(0x" << std::hex << Addr
                      << ") = RV64[" << std::dec << +Inst.rd
                      << "](0x" << std::hex << R->RV64[Inst.rd]
                      << ")" << std::endl;
          }
#endif
        return true;
      }

      static bool ersw(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // uint64_t EXT3 = (uint64_t)(R->ERV64[Inst.rd]);
        // uint64_t Addr = (uint64_t)(R->RV64[Inst.rs2]);
        // if( EXT3 != 0x0 ) {
        //   Xbgas->WriteU32( EXT3, Addr, (uint32_t)(R->RV64[Inst.rs1]) );
        // } else {
        //   M->WriteU32( Addr, (uint32_t)(R->RV64[Inst.rs1]) );
        // }
        // R->RV64_PC += Inst.instSize;

        /* The following implementation is based on xbgas-tool (branch: test)*/
        // ersw rd, rs1, rs2
        uint64_t EXT3 = (uint64_t)(R->ERV64[Inst.rs2]);
        uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]);
        if( EXT3 != 0x0 ) {
          Xbgas->WriteU32( EXT3, Addr, R->RV64[Inst.rd] );
        } else {
          M->WriteU32( Addr, R->RV64[Inst.rd] );
        }
        R->RV64_PC += Inst.instSize;

#ifdef _XBGAS_DEBUG_
          int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
          if(id == 0) {
            std::cout << "_XBGAS_DEBUG_ CPU" << id
                      << ": [ersw]\tNamespace(0x" << EXT3
                      << ") @ Addr(0x" << std::hex << Addr
                      << ") = RV64[" << std::dec << +Inst.rd
                      << "](0x" << std::hex << R->RV64[Inst.rd]
                      << ")" << std::endl;
          }
#endif

        return true;
      }

      static bool ersh(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // uint64_t EXT3 = (uint64_t)(R->ERV64[Inst.rd]);
        // uint64_t Addr = (uint64_t)(R->RV64[Inst.rs2]);
        // if( EXT3 != 0x0 ) {
        //   Xbgas->WriteU16( EXT3, Addr, (uint16_t)(R->RV64[Inst.rs1]) );
        // } else {
        //   M->WriteU16( Addr, (uint16_t)(R->RV64[Inst.rs1]) );
        // }
        // R->RV64_PC += Inst.instSize;

        /* The following implementation is based on xbgas-tool (branch: test)*/
        // ersh rd, rs1, rs2
        uint64_t EXT3 = (uint64_t)(R->ERV64[Inst.rs2]);
        uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]);
        if( EXT3 != 0x0 ) {
          Xbgas->WriteU16( EXT3, Addr, R->RV64[Inst.rd] );
        } else {
          M->WriteU16( Addr, R->RV64[Inst.rd] );
        }
        R->RV64_PC += Inst.instSize;

#ifdef _XBGAS_DEBUG_
          int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
          if(id == 0) {
            std::cout << "_XBGAS_DEBUG_ CPU" << id
                      << ": [ersh]\tNamespace(0x" << EXT3
                      << ") @ Addr(0x" << std::hex << Addr
                      << ") = RV64[" << std::dec << +Inst.rd
                      << "](0x" << std::hex << R->RV64[Inst.rd]
                      << ")" << std::endl;        
          }
#endif

        return true;
      }

      static bool ersb(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // uint64_t EXT3 = (uint64_t)(R->ERV64[Inst.rd]);
        // uint64_t Addr = (uint64_t)(R->RV64[Inst.rs2]);
        // if( EXT3 != 0x0 ) {
        //   Xbgas->WriteU8( EXT3, Addr, (uint8_t)(R->RV64[Inst.rs1]) );
        // } else {
        //   M->WriteU8( Addr, (uint8_t)(R->RV64[Inst.rs1]) );
        // }
        // R->RV64_PC += Inst.instSize;

        /* The following implementation is based on xbgas-tool (branch: test)*/
        // ersb rd, rs1, rs2
        uint64_t EXT3 = (uint64_t)(R->ERV64[Inst.rs2]);
        uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]);
        if( EXT3 != 0x0 ) {
          Xbgas->WriteU8( EXT3, Addr, R->RV64[Inst.rd] );
        } else {
          M->WriteU8( Addr, R->RV64[Inst.rd] );
        }
        R->RV64_PC += Inst.instSize;

#ifdef _XBGAS_DEBUG_
          int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
          if(id == 0) {
            std::cout << "_XBGAS_DEBUG_ CPU" << id
                      << ": [ersb]\tNamespace(0x" << EXT3
                      << ") @ Addr(0x" << std::hex << Addr
                      << ") = RV64[" << std::dec << +Inst.rd
                      << "](0x" << std::hex << R->RV64[Inst.rd]
                      << ")" << std::endl;        
          }
#endif

        return true;
      }

      static bool erse(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        // uint64_t EXT3 = (uint64_t)(R->ERV64[Inst.rd]);
        // uint64_t Addr = (uint64_t)(R->RV64[Inst.rs2]);
        // if( EXT3 != 0x0 ) {
        //   Xbgas->WriteU64( EXT3, Addr, R->ERV64[Inst.rs1] );
        // } else {
        //   M->WriteU64( Addr, R->ERV64[Inst.rs1] );
        // }
        // R->RV64_PC += Inst.instSize;

        /* The following implementation is based on xbgas-tool (branch: test)*/
        // erse rd, rs1, rs2
        uint64_t EXT3 = (uint64_t)(R->ERV64[Inst.rs2]);
        uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]);
        if( EXT3 != 0x0 ) {
          Xbgas->WriteU64( EXT3, Addr, R->ERV64[Inst.rd] );
        } else {
          M->WriteU64( Addr, R->ERV64[Inst.rd] );
        }
        R->RV64_PC += Inst.instSize;

#ifdef _XBGAS_DEBUG_
          int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
          if(id == 0) 
          {
            std::cout << "_XBGAS_DEBUG_ CPU" << id
                      << ": [erse]\tNamespace(0x" << EXT3
                      << ") @ Addr(0x" << std::hex << Addr
                      << ") = ERV64[" << std::dec << +Inst.rd
                      << "](0x" << std::hex << R->ERV64[Inst.rd]
                      << ")" << std::endl;        
          }
#endif

        return true;
      }

      static bool eaddi(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        R->RV64[Inst.rd] = dt_u64((int64_t)(td_u64(R->ERV64[Inst.rs1], 64)) + (int64_t)(td_u64(Inst.imm, 12)), 64);
        R->RV64_PC += Inst.instSize;
#ifdef _XBGAS_DEBUG_
          int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
          if(id == 0) 
          {
            std::cout << "_XBGAS_DEBUG_ CPU" << id
                      << ": [eaddi]\tRV64[" << std::dec << +Inst.rd
                      << "](0x" << std::hex <<(int64_t)(td_u64(R->RV64[Inst.rd], 64))
                      << ") = ERV64[" << std::dec << +Inst.rs1
                      << "] (0x" << std::hex << (int64_t)(td_u64(R->ERV64[Inst.rs1], 64))
                      << ") + IMM (" << std::dec << (int64_t)(td_u64(Inst.imm, 12))
                      << ")" << std::endl;
          }
#endif
        return true;
      }

      static bool eaddie(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        R->ERV64[Inst.rd] = dt_u64((int64_t)(td_u64(R->RV64[Inst.rs1], 64)) + (int64_t)(td_u64(Inst.imm, 12)), 64);
        R->RV64_PC += Inst.instSize;
#ifdef _XBGAS_DEBUG_
          int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
          if(id == 0) 
          {
            std::cout << "_XBGAS_DEBUG_ CPU" << id
                      << ": [eaddie]\tERV64[" << std::dec << +Inst.rd
                      << "](0x" << std::hex <<(int64_t)(td_u64(R->ERV64[Inst.rd], 64))
                      << ") = RV64[" << std::dec << +Inst.rs1
                      << "] (0x" << std::hex << (int64_t)(td_u64(R->RV64[Inst.rs1], 64))
                      << ") + IMM (" << std::dec << (int64_t)(td_u64(Inst.imm, 12))
                      << ")" << std::endl;
          }
#endif
        return true;
      }

      static bool eaddix(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        R->ERV64[Inst.rd] = dt_u64((int64_t)(td_u64(R->ERV64[Inst.rs1], 64)) + (int64_t)(td_u64(Inst.imm, 12)), 64);
        R->RV64_PC += Inst.instSize;
#ifdef _XBGAS_DEBUG_
          int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
          if(id == 0) 
          {
            std::cout << "_XBGAS_DEBUG_ CPU" << id
                      << ": [eaddix]\tERV64[" << std::dec << +Inst.rd
                      << "](0x" << std::hex <<(int64_t)(td_u64(R->ERV64[Inst.rd], 64))
                      << ") = ERV64[" << std::dec << +Inst.rs1
                      << "] (0x" << std::hex << (int64_t)(td_u64(R->ERV64[Inst.rs1], 64))
                      << ") + IMM (" << std::dec << (int64_t)(td_u64(Inst.imm, 12))
                      << ")" << std::endl;
          }
#endif
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
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("elq %rd, $imm(%rs1)").SetCost(          1).SetOpcode(0b1110111).SetFunct3(0b110).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &elq).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("eld %rd, $imm(%rs1)").SetCost(          1).SetOpcode(0b1110111).SetFunct3(0b011).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &eld).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("elw %rd, $imm(%rs1)").SetCost(          1).SetOpcode(0b1110111).SetFunct3(0b010).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &elw).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("elh %rd, $imm(%rs1)").SetCost(          1).SetOpcode(0b1110111).SetFunct3(0b001).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &elh).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("elhu %rd, $imm(%rs1)").SetCost(         1).SetOpcode(0b1110111).SetFunct3(0b101).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &elhu).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("elb %rd, $imm(%rs1)").SetCost(          1).SetOpcode(0b1110111).SetFunct3(0b000).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &elb).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("elbu %rd, $imm(%rs1)").SetCost(         1).SetOpcode(0b1110111).SetFunct3(0b100).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &elbu).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("ele %extd, $imm(%rs1)").SetCost(        1).SetOpcode(0b1110111).SetFunct3(0b111).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &ele).InstEntry},

      // Store instructions are encoded in the S-type format
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("esq %rs1, $imm(%rs2)").SetCost(         1).SetOpcode(0b1111011).SetFunct3(0b100).SetrdClass(RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeS).SetImplFunc( &esq).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("esd %rs1, $imm(%rs2)").SetCost(         1).SetOpcode(0b1111011).SetFunct3(0b011).SetrdClass(RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeS).SetImplFunc( &esd).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("esw %rs1, $imm(%rs2)").SetCost(         1).SetOpcode(0b1111011).SetFunct3(0b010).SetrdClass(RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeS).SetImplFunc( &esw).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("esh %rs1, $imm(%rs2)").SetCost(         1).SetOpcode(0b1111011).SetFunct3(0b001).SetrdClass(RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeS).SetImplFunc( &esh).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("esb %rs1, $imm(%rs2)").SetCost(         1).SetOpcode(0b1111011).SetFunct3(0b000).SetrdClass(RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeS).SetImplFunc( &esb).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("ese %ext1, $imm(%rs2)").SetCost(        1).SetOpcode(0b1111011).SetFunct3(0b101).SetrdClass(RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeS).SetImplFunc( &ese).InstEntry},
      
      // Raw Load instructions are encoded in the R-type format
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("erld %rd, %rs1, %ext2").SetCost(        1).SetOpcode(0b0110011).SetFunct3(0b011).SetFunct7(0b1010101).SetFormat(RVTypeR).SetImplFunc( &erld).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("erlw %rd, %rs1, %ext2").SetCost(        1).SetOpcode(0b0110011).SetFunct3(0b010).SetFunct7(0b1010101).SetFormat(RVTypeR).SetImplFunc( &erlw).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("erlh %rd, %rs1, %ext2").SetCost(        1).SetOpcode(0b0110011).SetFunct3(0b001).SetFunct7(0b1010101).SetFormat(RVTypeR).SetImplFunc( &erlh).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("erlhu %rd, %rs1, %ext2").SetCost(       1).SetOpcode(0b0110011).SetFunct3(0b101).SetFunct7(0b1010101).SetFormat(RVTypeR).SetImplFunc( &erlhu).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("erlb %rd, %rs1, %ext2").SetCost(        1).SetOpcode(0b0110011).SetFunct3(0b000).SetFunct7(0b1010101).SetFormat(RVTypeR).SetImplFunc( &erlb).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("erlbu %rd, %rs1, %ext2").SetCost(       1).SetOpcode(0b0110011).SetFunct3(0b100).SetFunct7(0b1010101).SetFormat(RVTypeR).SetImplFunc( &erlbu).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("erle %extd, %rs1, %ext2").SetCost(      1).SetOpcode(0b0110011).SetFunct3(0b100).SetFunct7(0b0100001).SetFormat(RVTypeR).SetImplFunc( &erle).InstEntry},

      // Raw Store instructions are encoded in the R-type format
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("ersd %rs1, %rs2, %ext3").SetCost(       1).SetOpcode(0b0110011).SetFunct3(0b011).SetFunct7(0b0100010).SetFormat(RVTypeR).SetImplFunc( &ersd).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("ersw %rs1, %rs2, %ext3").SetCost(       1).SetOpcode(0b0110011).SetFunct3(0b010).SetFunct7(0b0100010).SetFormat(RVTypeR).SetImplFunc( &ersw).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("ersh %rs1, %rs2, %ext3").SetCost(       1).SetOpcode(0b0110011).SetFunct3(0b001).SetFunct7(0b0100010).SetFormat(RVTypeR).SetImplFunc( &ersh).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("ersb %rs1, %rs2, %ext3").SetCost(       1).SetOpcode(0b0110011).SetFunct3(0b000).SetFunct7(0b0100010).SetFormat(RVTypeR).SetImplFunc( &ersb).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("erse %ext1, %rs2, %ext3").SetCost(      1).SetOpcode(0b0110011).SetFunct3(0b011).SetFunct7(0b0100011).SetFormat(RVTypeR).SetImplFunc( &erse).InstEntry},

      // Address Management Instructions are encoded in the I-type format
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("eaddi %rd, %ext1, $imm").SetCost(      1).SetOpcode(0b1111011).SetFunct3(0b110).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &eaddi).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("eaddie %extd, %rs1, $imm").SetCost(    1).SetOpcode(0b1111011).SetFunct3(0b111).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &eaddie).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("eaddix %extd, %ext1, $imm").SetCost(   1).SetOpcode(0b0000011).SetFunct3(0b111).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &eaddix).InstEntry}
      
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
