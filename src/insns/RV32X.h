//
// _RV32X_h_
//
// Copyright (C) 2017-2021 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#ifndef _SST_REVCPU_RV32X_H_
#define _SST_REVCPU_RV32X_H_

#include <bitset>

#include "RevInstTable.h"
#include "RevExt.h"
#include "../common/include/XbgasAddr.h"

#define DEBUG
// #undef DEBUG

//EXT1, EXT2, EXT3 refer to https://github.com/tactcomplabs/xbgas-tools/blob/24227c929ea6c0bbe61a44156dc75ab6234eab3b/riscv-isa-sim/riscv/decode.h

using namespace SST::RevCPU;

namespace SST{
  namespace RevCPU{
    class RV32X : public RevExt {

      static bool elw(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint8_t Tag = 0;

        // Search in TrackGets, if found, the request has been sent;
        // Use the corresponding Tag to get the data from GetResponse;
        // Send remote memory request otherwise.
        if( F->IsRV32() ){
          uint64_t EXT1 = (uint64_t)(R->ERV32[Inst.rs1]);
          uint64_t Addr = (uint64_t)(R->RV32[Inst.rs1]+(int32_t)(td_u32(Inst.imm,12)));

          if (EXT1 != 0x0) {
            if ( !Xbgas->checkGetRequests(EXT1, Addr, &Tag) ) {
              Xbgas->ReadU32(EXT1, Addr);
            } else {
              uint32_t Value;
              if( Xbgas->readGetResponses(Tag, (void *)(&Value)) ) {
                SEXT(R->RV32[Inst.rd], Value, 32);
                R->RV32_PC += Inst.instSize;
              }
            }
          } else {
            SEXT(R->RV32[Inst.rd], M->ReadU32(Addr), 32);
            R->RV32_PC += Inst.instSize;
            R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
          }
          
        }else{
          uint64_t EXT1 = (uint64_t)(R->ERV64[Inst.rs1]);
          uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]+(int32_t)(td_u32(Inst.imm,12)));

#ifdef DEBUG 
          int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
          if(id == 0) {
            std::cout << "CPU" << id
                      << ": [elw] RV64[" << std::dec << Inst.rd
                      << "] (" << std::dec << R->RV64[Inst.rd]
                      << ") = ERV64[" << std::dec << +Inst.rs1
                      << "](" << std::hex << R->ERV64[Inst.rs1]
                      << ") + IMM(" << std::dec << (int32_t)(td_u32(Inst.imm,12))
                      << ")" << std::endl;
          }
#endif
          if (EXT1 != 0x0) {
            if ( !Xbgas->checkGetRequests(EXT1, Addr, &Tag) ) {
              Xbgas->ReadU32(EXT1, Addr);
            } else {
              uint32_t Value;
              if( Xbgas->readGetResponses(Tag, (void *)(&Value)) ) {
                SEXT(R->RV64[Inst.rd], Value, 64);
                R->RV64_PC += Inst.instSize;
              }
            }
          } else {
            SEXT(R->RV64[Inst.rd], M->ReadU32(Addr), 64);
            R->RV64_PC += Inst.instSize;
            R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
          }
          
        }
        return true;
      }

      static bool elh(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint8_t Tag = 0;

        // Search in TrackGets, if found, the request has been sent;
        // Use the corresponding Tag to get the data from GetResponse;
        // Send remote memory request otherwise.
        if( F->IsRV32() ){
          uint64_t EXT1 = (uint64_t)(R->ERV32[Inst.rs1]);
          uint64_t Addr = (uint64_t)(R->RV32[Inst.rs1]+(int32_t)(td_u32(Inst.imm,12)));

          if (EXT1 != 0x0) {
            if ( !Xbgas->checkGetRequests(EXT1, Addr, &Tag) ) {
              Xbgas->ReadU16(EXT1, Addr);
            } else {
              uint16_t Value;
              if( Xbgas->readGetResponses(Tag, (void *)(&Value)) ) {
                SEXT(R->RV32[Inst.rd], Value, 32);
                R->RV32_PC += Inst.instSize;
              }
            }
          } else {
            SEXT(R->RV32[Inst.rd], M->ReadU16(Addr), 32);
            R->RV32_PC += Inst.instSize;
            R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
          }
          
        }else{
          uint64_t EXT1 = (uint64_t)(R->ERV64[Inst.rs1]);
          uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]+(int32_t)(td_u32(Inst.imm,12)));

          if (EXT1 != 0x0){
            if ( !Xbgas->checkGetRequests(EXT1, Addr, &Tag) ) {
              Xbgas->ReadU16(EXT1, Addr);
            } else {
              uint16_t Value;
              if( Xbgas->readGetResponses(Tag, (void *)(&Value)) ) {
                SEXT(R->RV64[Inst.rd], Value, 64);
                R->RV64_PC += Inst.instSize;
              }
            }
          } else {
            SEXT(R->RV64[Inst.rd], M->ReadU16(Addr), 64);
            R->RV64_PC += Inst.instSize;
            R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
          }
          
        }
        return true;
      }

      static bool elhu(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint8_t Tag = 0;

        // Search in TrackGets, if found, the request has been sent;
        // Use the corresponding Tag to get the data from GetResponse;
        // Send remote memory request otherwise.
        if( F->IsRV32() ){
          uint64_t EXT1 = (uint64_t)(R->ERV32[Inst.rs1]);
          uint64_t Addr = (uint64_t)(R->RV32[Inst.rs1]+(int32_t)(td_u32(Inst.imm,12)));

          if (EXT1 != 0x0) {
            if ( !Xbgas->checkGetRequests(EXT1, Addr, &Tag) ) {
              Xbgas->ReadU16(EXT1, Addr);
            } else {
              uint16_t Value;
              if( Xbgas->readGetResponses(Tag, (void *)(&Value)) ) {
                R->RV32[Inst.rd] = Value;
                R->RV32_PC += Inst.instSize;
              }
            }
          } else {
            R->RV32[Inst.rd] = M->ReadU16(Addr);
            R->RV32_PC += Inst.instSize;
            R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
          }
          
        }else{
          uint64_t EXT1 = (uint64_t)(R->ERV64[Inst.rs1]);
          uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]+(int32_t)(td_u32(Inst.imm,12)));

          if (EXT1 != 0x0) {
            if ( !Xbgas->checkGetRequests(EXT1, Addr, &Tag) ) {
              Xbgas->ReadU16(EXT1, Addr);
            } else {
              uint16_t Value;
              if( Xbgas->readGetResponses(Tag, (void *)(&Value)) ) {
                ZEXT(R->RV64[Inst.rd], Value, 64);
                R->RV64_PC += Inst.instSize;
              }
            }
          } else {
            R->RV64[Inst.rd] = M->ReadU16(Addr);
            R->RV64_PC += Inst.instSize;
            R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
          }
          
        }
        return true;
      }

      static bool elb(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint8_t Tag = 0;

        // Search in TrackGets, if found, the request has been sent;
        // Use the corresponding Tag to get the data from GetResponse;
        // Send remote memory request otherwise.
        if( F->IsRV32() ){
          uint64_t EXT1 = (uint64_t)(R->ERV32[Inst.rs1]);
          uint64_t Addr = (uint64_t)(R->RV32[Inst.rs1]+(int32_t)(td_u32(Inst.imm,12)));

          if (EXT1 != 0x0) {
            if ( !Xbgas->checkGetRequests(EXT1, Addr, &Tag) ) {
              Xbgas->ReadU8(EXT1, Addr);
            } else {
              uint16_t Value;
              if( Xbgas->readGetResponses(Tag, (void *)(&Value)) ) {
                SEXT(R->RV32[Inst.rd], Value, 32);
                R->RV32_PC += Inst.instSize;
              }
            }
          } else {
            SEXT(R->RV32[Inst.rd], M->ReadU8(Addr), 32);
            R->RV32_PC += Inst.instSize;
            R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
          }
          
        }else{
          uint64_t EXT1 = (uint64_t)(R->ERV64[Inst.rs1]);
          uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]+(int32_t)(td_u32(Inst.imm,12)));
          
          if (EXT1 != 0x0) {
            if ( !Xbgas->checkGetRequests(EXT1, Addr, &Tag) ) {
              Xbgas->ReadU8(EXT1, Addr);
            } else {
              uint16_t Value;
              if( Xbgas->readGetResponses(Tag, (void *)(&Value)) ) {
                SEXT(R->RV64[Inst.rd], Value, 64);
                R->RV64_PC += Inst.instSize;
              }
            }
          } else {
            SEXT(R->RV64[Inst.rd], M->ReadU8(Addr), 64);
            R->RV64_PC += Inst.instSize;
            R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
          }
          
        }
        return true;
      }

      static bool elbu(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint8_t Tag = 0;

        // Search in TrackGets, if found, the request has been sent;
        // Use the corresponding Tag to get the data from GetResponse;
        // Send remote memory request otherwise.
        if( F->IsRV32() ){
          uint64_t EXT1 = (uint64_t)(R->ERV32[Inst.rs1]);
          uint64_t Addr = (uint64_t)(R->RV32[Inst.rs1]+(int32_t)(td_u32(Inst.imm,12)));
          
          if (EXT1 != 0x0) {
            if ( !Xbgas->checkGetRequests(EXT1, Addr, &Tag) ) {
              Xbgas->ReadU8(EXT1, Addr);
            } else {
              uint16_t Value;
              if( Xbgas->readGetResponses(Tag, (void *)(&Value)) ) {
                R->RV32[Inst.rd]= Value;
                R->RV32_PC += Inst.instSize;
              }
            }
          } else {
            R->RV32[Inst.rd] = M->ReadU8(Addr);
            R->RV32_PC += Inst.instSize;
            R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
          }
          
        }else{
          uint64_t EXT1 = (uint64_t)(R->ERV64[Inst.rs1]);
          uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]+(int32_t)(td_u32(Inst.imm,12)));
          
          if (EXT1 != 0x0) {
            if ( !Xbgas->checkGetRequests(EXT1, Addr, &Tag) ) {
              Xbgas->ReadU8(EXT1, Addr);
            } else {
              uint16_t Value;
              if( Xbgas->readGetResponses(Tag, (void *)(&Value)) ) {
                R->RV64[Inst.rd] = Value;
                R->RV64_PC += Inst.instSize;
              }
            }
          } else {
            R->RV64[Inst.rd] = M->ReadU8(Addr);
            R->RV64_PC += Inst.instSize;
            R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
          }
        }
        return true;
      }

      static bool esw(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
          uint64_t EXT1 = (uint64_t)(R->ERV32[Inst.rs1]);
          uint64_t Addr = (uint64_t)(R->RV32[Inst.rs1]+(int32_t)(td_u32(Inst.imm,12)));
          
          if (EXT1 != 0x0) {
            Xbgas->WriteU32( EXT1, Addr, (uint32_t)(R->RV32[Inst.rs2]) );
          } else {
            M->WriteU32( Addr, (uint32_t)(R->RV32[Inst.rs2]));
          }
          
          R->RV32_PC += Inst.instSize;
        }else {
          uint64_t EXT1 = (uint64_t)(R->ERV64[Inst.rs1]);
          uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]+(int32_t)(td_u32(Inst.imm,12)));
          
          if (EXT1 != 0x0) {
            Xbgas->WriteU32( EXT1, Addr, (uint32_t)(R->RV64[Inst.rs2]) );
          } else {
            M->WriteU32( Addr, (uint32_t)(R->RV64[Inst.rs2]));
          }

          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool esh(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
          uint64_t EXT1 = (uint64_t)(R->ERV32[Inst.rs1]);
          uint64_t Addr = (uint64_t)(R->RV32[Inst.rs1]+(int32_t)(td_u32(Inst.imm,12)));
          
          if (EXT1 != 0x0) {
            Xbgas->WriteU16( EXT1, Addr, (uint16_t)(R->RV32[Inst.rs2]) );
          } else {
            M->WriteU16( Addr, (uint16_t)(R->RV32[Inst.rs2]));
          }
          
          R->RV32_PC += Inst.instSize;
        }else {
          uint64_t EXT1 = (uint64_t)(R->ERV64[Inst.rs1]);
          uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]+(int32_t)(td_u32(Inst.imm,12)));
          
          if (EXT1 != 0x0) {
            Xbgas->WriteU16( EXT1, Addr, (uint16_t)(R->RV64[Inst.rs2]) );
          } else {
            M->WriteU16( Addr, (uint16_t)(R->RV64[Inst.rs2]));
          }
          
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool esb(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
          uint64_t EXT1 = (uint64_t)(R->ERV32[Inst.rs1]);
          uint64_t Addr = (uint64_t)(R->RV32[Inst.rs1]+(int32_t)(td_u32(Inst.imm,12)));
          
          if (EXT1 != 0x0) {
            Xbgas->WriteU8( EXT1, Addr, (uint8_t)(R->RV32[Inst.rs2]) );
          } else {
            M->WriteU8( Addr, (uint8_t)(R->RV32[Inst.rs2]));
          }

          R->RV32_PC += Inst.instSize;
        }else {
          uint64_t EXT1 = (uint64_t)(R->ERV64[Inst.rs1]);
          uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]+(int32_t)(td_u32(Inst.imm,12)));
          
          if (EXT1 != 0x0) {
            Xbgas->WriteU8( EXT1, Addr, (uint8_t)(R->RV64[Inst.rs2]) );
          } else {
            M->WriteU8( Addr, (uint8_t)(R->RV64[Inst.rs2]));
          }

          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool erlw(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint8_t Tag = 0;

        // Search in TrackGets, if found, the request has been sent;
        // Use the corresponding Tag to get the data from GetResponse;
        // Send remote memory request otherwise.
        
        if( F->IsRV32() ){
          uint64_t EXT2 = (uint64_t)(R->ERV32[Inst.rs2]);
          uint64_t Addr = (uint64_t)(R->RV32[Inst.rs1]);

          if (EXT2 != 0x0) {
            if ( !Xbgas->checkGetRequests(EXT2, Addr, &Tag) ) {
              Xbgas->ReadU32(EXT2, Addr);
            } else {
              uint32_t Value;
              if( Xbgas->readGetResponses(Tag, (void *)(&Value)) ) {
                SEXT(R->RV32[Inst.rd], Value, 32);
                R->RV32_PC += Inst.instSize;
              }
            }
          } else {
            SEXT(R->RV32[Inst.rd], M->ReadU32(Addr), 32);
            R->RV32_PC += Inst.instSize;
            R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
          }
        }else{
          uint64_t EXT2 = (uint64_t)(R->ERV64[Inst.rs2]);
          uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]);
          if (EXT2 != 0x0) {
            if ( !Xbgas->checkGetRequests(EXT2, Addr, &Tag) ) {
              Xbgas->ReadU32(EXT2, Addr);
            } else {
              uint32_t Value;
              if( Xbgas->readGetResponses(Tag, (void *)(&Value)) ) {
                SEXT(R->RV64[Inst.rd], Value, 64);
                R->RV64_PC += Inst.instSize;
#ifdef DEBUG 
          int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
          {
            // std::cout << "CPU" << id << " Registers --- erlw" << std::endl;
            // for(int i=0; i < 32; i++) {
            //   std::cout << "e" << std::dec << i << ": " << std::hex << R->ERV64[i]
            //             << " | r" << std::dec << i << ": " << std::hex << R->RV64[i] << std::endl;
            // }
            std::cout << "CPU" << id << ": erlw rd, rs1, ext2" << std::endl;
            std::cout << "CPU" << id << ": rd = " << std::hex << R->RV64[Inst.rd] 
                      << ", rs1 = " << std::hex << R->RV64[Inst.rs1] 
                      << ", ext2 = " << std::hex << R->ERV64[Inst.rs2] << std::endl;
            std::cout << "CPU" << id << ": loads Value = " << (int)(Value) << std::endl;
            // std::cout << "CPU" << id
            //           << ": [erlw] RV64[" << std::dec << +Inst.rd
            //           << "] (" << std::hex << R->RV64[Inst.rd]
            //           << ") = ERV64[" << std::dec << +Inst.rs2
            //           << "](" << std::hex << R->ERV64[Inst.rs2]
            //           << ") + RV64[" << std::dec << +Inst.rs1
            //           << "](Memory[" << std::hex << R->RV64[Inst.rs1]
            //           << "])"<< std::endl;
          }
#endif
              }
            }
          } else {
            SEXT(R->RV64[Inst.rd], M->ReadU32(Addr), 64);
            R->RV64_PC += Inst.instSize;
            R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
#ifdef DEBUG 
          int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
          {
            std::cout << "CPU" << id << ": erlw rd, rs1, ext2" << std::endl;
            std::cout << "CPU" << id << ": rd = " << std::hex << R->RV64[Inst.rd] 
                      << ", rs1 = " << std::hex << R->RV64[Inst.rs1] 
                      << ", ext2 = " << std::hex << R->ERV64[Inst.rs2] << std::endl;
            std::cout << "CPU" << id << ": loads Value = " << (int)(M->ReadU32(Addr)) << std::endl;
          }
#endif
          }
        }
        return true;
      }

      static bool erlh(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint8_t Tag = 0;

        // Search in TrackGets, if found, the request has been sent;
        // Use the corresponding Tag to get the data from GetResponse;
        // Send remote memory request otherwise.
        if( F->IsRV32() ){
          uint64_t EXT2 = (uint64_t)(R->ERV32[Inst.rs2]);
          uint64_t Addr = (uint64_t)(R->RV32[Inst.rs1]);

          if (EXT2 != 0x0) {
            if ( !Xbgas->checkGetRequests(EXT2, Addr, &Tag) ) {
              Xbgas->ReadU16(EXT2, Addr);
            } else {
              uint16_t Value;
              if( Xbgas->readGetResponses(Tag, (void *)(&Value)) ) {
                SEXT(R->RV32[Inst.rd], Value, 32);
                R->RV32_PC += Inst.instSize;
              }
            }
          } else {
            SEXT(R->RV32[Inst.rd], M->ReadU16(Addr), 32);
            R->RV32_PC += Inst.instSize;
            R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
          }
          
        }else{
          uint64_t EXT2 = (uint64_t)(R->ERV64[Inst.rs2]);
          uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]);

          if (EXT2 != 0x0) {
            if ( !Xbgas->checkGetRequests(EXT2, Addr, &Tag) ) {
              Xbgas->ReadU16(EXT2, Addr);
            } else {
              uint16_t Value;
              if( Xbgas->readGetResponses(Tag, (void *)(&Value)) ) {
                SEXT(R->RV64[Inst.rd], Value, 64);
                R->RV64_PC += Inst.instSize;
              }
            }
          } else {
            SEXT(R->RV64[Inst.rd], M->ReadU16(Addr), 64);
            R->RV64_PC += Inst.instSize;
            R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
          }
          
        }
        return true;
      }

      static bool erlhu(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint8_t Tag = 0;

        // Search in TrackGets, if found, the request has been sent;
        // Use the corresponding Tag to get the data from GetResponse;
        // Send remote memory request otherwise.
        if( F->IsRV32() ){
          uint64_t EXT2 = (uint64_t)(R->ERV32[Inst.rs2]);
          uint64_t Addr = (uint64_t)(R->RV32[Inst.rs1]);

          if (EXT2 != 0x0) {
            if ( !Xbgas->checkGetRequests(EXT2, Addr, &Tag) ) {
              Xbgas->ReadU16(EXT2, Addr);
            } else {
              uint16_t Value;
              if( Xbgas->readGetResponses(Tag, (void *)(&Value)) ) {
                R->RV32[Inst.rd] = Value;
                R->RV32_PC += Inst.instSize;
              }
            }
          } else {
            R->RV32[Inst.rd] = M->ReadU16(Addr);
            R->RV32_PC += Inst.instSize;
            R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
          }
          
        }else{
          uint64_t EXT2 = (uint64_t)(R->ERV64[Inst.rs2]);
          uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]);

          if (EXT2 != 0x0) {
            if ( !Xbgas->checkGetRequests(EXT2, Addr, &Tag) ) {
              Xbgas->ReadU16(EXT2, Addr);
            } else {
              uint16_t Value;
              if( Xbgas->readGetResponses(Tag, (void *)(&Value)) ) {
                R->RV64[Inst.rd] = Value;
                R->RV64_PC += Inst.instSize;
              }
            }
          } else {
            R->RV64[Inst.rd] = M->ReadU16(Addr);
            R->RV64_PC += Inst.instSize;
            R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
          }
          
        }
        return true;
      }

      static bool erlb(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint8_t Tag = 0;

        // Search in TrackGets, if found, the request has been sent;
        // Use the corresponding Tag to get the data from GetResponse;
        // Send remote memory request otherwise.
        if( F->IsRV32() ){
          uint64_t EXT2 = (uint64_t)(R->ERV32[Inst.rs2]);
          uint64_t Addr = (uint64_t)(R->RV32[Inst.rs1]);

          if (EXT2 != 0x0) {
            if ( !Xbgas->checkGetRequests(EXT2, Addr, &Tag) ) {
              Xbgas->ReadU8(EXT2, Addr);
            } else {
              uint16_t Value;
              if( Xbgas->readGetResponses(Tag, (void *)(&Value)) ) {
                SEXT(R->RV32[Inst.rd], Value, 32);
                R->RV32_PC += Inst.instSize;
              }
            }
          } else {
            SEXT(R->RV32[Inst.rd], M->ReadU8(Addr), 32);
            R->RV32_PC += Inst.instSize;
            R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
          }
          
        }else{
          uint64_t EXT2 = (uint64_t)(R->ERV64[Inst.rs2]);
          uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]);

          if (EXT2 != 0x0) {
            if ( !Xbgas->checkGetRequests(EXT2, Addr, &Tag) ) {
              Xbgas->ReadU8(EXT2, Addr);
            } else {
              uint16_t Value;
              if( Xbgas->readGetResponses(Tag, (void *)(&Value)) ) {
                SEXT(R->RV64[Inst.rd], Value, 64);
                R->RV64_PC += Inst.instSize;
              }
            }
          } else {
            SEXT(R->RV64[Inst.rd], M->ReadU8(Addr), 64);
            R->RV64_PC += Inst.instSize;
            R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
          }
          
        }
        return true;
      }

      static bool erlbu(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        uint8_t Tag = 0;

        // Search in TrackGets, if found, the request has been sent;
        // Use the corresponding Tag to get the data from GetResponse;
        // Send remote memory request otherwise.
        if( F->IsRV32() ){
          uint64_t EXT2 = (uint64_t)(R->ERV32[Inst.rs2]);
          uint64_t Addr = (uint64_t)(R->RV32[Inst.rs1]);

          if (EXT2 != 0x0) {
            if ( !Xbgas->checkGetRequests(EXT2, Addr, &Tag) ) {
              Xbgas->ReadU8(EXT2, Addr);
            } else {
              uint16_t Value;
              if( Xbgas->readGetResponses(Tag, (void *)(&Value)) ) {
                R->RV32[Inst.rd] = Value;
                R->RV32_PC += Inst.instSize;
              }
            }
          } else {
            R->RV32[Inst.rd] = M->ReadU8(Addr);
            R->RV32_PC += Inst.instSize;
            R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
          }
          
        }else{
          uint64_t EXT2 = (uint64_t)(R->ERV64[Inst.rs2]);
          uint64_t Addr = (uint64_t)(R->RV64[Inst.rs1]);

          if (EXT2 != 0x0) {
            if ( !Xbgas->checkGetRequests(EXT2, Addr, &Tag) ) {
              Xbgas->ReadU8(EXT2, Addr);
            } else {
              uint16_t Value;
              if( Xbgas->readGetResponses(Tag, (void *)(&Value)) ) {
                R->RV64[Inst.rd]= Value;
                R->RV64_PC += Inst.instSize;
              }
            }
          } else {
            R->RV64[Inst.rd] = M->ReadU8(Addr);
            R->RV64_PC += Inst.instSize;
            R->cost += M->RandCost(F->GetMinCost(),F->GetMaxCost());
          }
          
        }
        return true;
      }

      static bool ersw(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
          uint64_t EXT3 = (uint64_t)(R->ERV32[Inst.rd]);
          uint64_t Addr = (uint64_t)(R->RV32[Inst.rs2]);
          uint32_t Val = (uint32_t)(R->RV32[Inst.rs1]);

          if (EXT3 != 0x0) {
            Xbgas->WriteU32( EXT3, Addr, Val );
          } else {
            M->WriteU32( Addr, Val);
          }
          
          R->RV32_PC += Inst.instSize;
        }else {
          uint64_t EXT3 = (uint64_t)(R->ERV64[Inst.rd]);
          uint64_t Addr = (uint64_t)(R->RV64[Inst.rs2]);
          uint32_t Val = (uint32_t)(R->RV64[Inst.rs1]);

          // M->WriteU32((uint64_t)(R->RV64[Inst.rs1]+(int32_t)(td_u32(Inst.imm,12))), (uint32_t)(R->RV64[Inst.rs2]));
          // SEXT(R->RV32[Inst.rd],M->ReadU32( (uint64_t)(R->RV32[Inst.rs1]+(int32_t)(td_u32(Inst.imm,12)))),32);

#ifdef DEBUG     
          int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
          if(id == 0) {
            // std::cout << "CPU" << id << " Registers --- ersw" << std::endl;
            // for(int i=0; i < 32; i++) {
            //   std::cout << "e" << std::dec << i << ": " << std::hex << R->ERV64[i]
            //             << " | r" << std::dec << i << ": " << std::hex << R->RV64[i] << std::endl;
            // }
            std::cout << "CPU" << id
                      << ": [ersw] Source: RV64[" << std::dec << +Inst.rs1
                      << "] = " << std::hex << R->RV64[Inst.rs1]
                      << ", Value = " << std::hex << Val
                      << ", Dest: ERV64[" << std::dec << +Inst.rd
                      << "](" << std::hex << R->ERV64[Inst.rd]
                      << ") + RV64[" << std::dec << +Inst.rs2
                      << "](" << std::hex << R->RV64[Inst.rs2] << ")"<< std::endl;
          }
#endif

          // if (EXT3 != 0x0) {
          //   Xbgas->WriteU32( EXT3, Addr, Val );
          // } else {
          //   M->WriteU32( Addr, Val );
          // }
          
          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool ersh(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
          uint64_t EXT3 = (uint64_t)(R->ERV32[Inst.rd]);
          uint64_t Addr = (uint64_t)(R->RV32[Inst.rs2]);

          if (EXT3 != 0x0) {
            Xbgas->WriteU16( EXT3, Addr, (uint16_t)(R->RV32[Inst.rs1]) );
          } else {
            M->WriteU16( Addr, (uint16_t)(R->RV32[Inst.rs1]));
          }
          
          R->RV32_PC += Inst.instSize;
        }else {
          uint64_t EXT3 = (uint64_t)(R->ERV64[Inst.rd]);
          uint64_t Addr = (uint64_t)(R->RV64[Inst.rs2]);

          if (EXT3 != 0x0) {
            Xbgas->WriteU16( EXT3, Addr, (uint16_t)(R->RV64[Inst.rs1]) );
          } else {
            M->WriteU16( Addr, (uint16_t)(R->RV64[Inst.rs1]));
          }

          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool ersb(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
          uint64_t EXT3 = (uint64_t)(R->ERV32[Inst.rd]);
          uint64_t Addr = (uint64_t)(R->RV32[Inst.rs2]);

          if (EXT3 != 0x0) {
            Xbgas->WriteU8( EXT3, Addr, (uint8_t)(R->RV32[Inst.rs1]) );
          } else {
            M->WriteU8( Addr, (uint8_t)(R->RV32[Inst.rs1]));
          }

          R->RV32_PC += Inst.instSize;
        }else {
          uint64_t EXT3 = (uint64_t)(R->ERV64[Inst.rd]);
          uint64_t Addr = (uint64_t)(R->RV64[Inst.rs2]);

          if (EXT3 != 0x0) {
            Xbgas->WriteU8( EXT3, Addr, (uint8_t)(R->RV64[Inst.rs1]) );
          } else {
            M->WriteU8( Addr, (uint8_t)(R->RV64[Inst.rs1]));
          }

          R->RV64_PC += Inst.instSize;
        }
        return true;
      }

      static bool eaddi(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
          R->RV32[Inst.rd] = dt_u32((int32_t)(td_u32(R->ERV32[Inst.rs1], 32)) + (int32_t)(td_u32(Inst.imm,12)), 32);
          R->RV32_PC += Inst.instSize;
#ifdef DEBUG
          int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
          if(id == 0) {
            std::cout << "CPU" << id
                      << ": [eaddi] RV32[" << std::dec << +Inst.rd
                      << "] (" << std::hex << R->RV32[Inst.rd]
                      << ") = ERV32[" << std::dec << +Inst.rs1
                      << "] (" << std::hex << R->ERV32[Inst.rs1]
                      << ") + IMM (" << std::hex << td_u32(Inst.imm, 12)
                      << ")" << std::endl;
          }
#endif
        }else {
          R->RV64[Inst.rd] = dt_u64((int64_t)(td_u64(R->ERV64[Inst.rs1], 64)) + (int64_t)(td_u64(Inst.imm, 12)), 64);
          R->RV64_PC += Inst.instSize;
#ifdef DEBUG
          int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
          if(id == 0) {
            // std::cout << "CPU" << id << " Registers --- eaddi" << std::endl;
            // for(int i=0; i < 32; i++) {
            //   std::cout << "e" << std::dec << i << ": " << std::hex << R->ERV64[i]
            //             << " | r" << std::dec << i << ": " << std::hex << R->RV64[i] << std::endl;
            // }
            std::cout << "CPU" << id
                      << ": [eaddi] RV64[" << std::dec << +Inst.rd
                      << "] (" << std::hex << R->RV64[Inst.rd]
                      << ") = ERV64[" << std::dec << +Inst.rs1
                      << "] (" << std::hex << R->ERV64[Inst.rs1]
                      << ") + IMM (" << std::hex << (int64_t)(td_u64(Inst.imm, 12))
                      << ")" << std::endl;
          }
#endif
        }
        return true;
      }

      static bool eaddie(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {      
        if( F->IsRV32() ){
          R->ERV32[Inst.rd] = dt_u32((int32_t)(td_u32(R->RV32[Inst.rs1], 32)) + (int32_t)(td_u32(Inst.imm,12)), 32);
          R->RV32_PC += Inst.instSize;
#ifdef DEBUG
          int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
          if(id == 0) {
            std::cout << "CPU" << id
                      << ": [eaddie] ERV32[" << std::dec << +Inst.rd
                      << "] (" << std::hex << R->ERV32[Inst.rd]
                      << ") = RV32[" << std::dec << +Inst.rs1
                      << "] (" << std::hex << R->RV32[Inst.rs1]
                      << ") + IMM (" << std::hex << td_u32(Inst.imm, 12)
                      << ")" << std::endl;
          }
#endif
        }else {
          R->ERV64[Inst.rd] = dt_u64((int64_t)(td_u64(R->RV64[Inst.rs1], 64)) + (int64_t)(td_u64(Inst.imm,12)), 64);
          R->RV64_PC += Inst.instSize;
#ifdef DEBUG
          int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
          if(id == 0) {
            // std::cout << "CPU" << id << " Registers --- eaddie" << std::endl;
            // for(int i=0; i < 32; i++) {
            //   std::cout << "e" << std::dec << i << ": " << std::hex << R->ERV64[i]
            //             << " | r" << std::dec << i << ": " << std::hex << R->RV64[i] << std::endl;
            // }
            std::cout << "CPU" << id
                      << ": [eaddie] ERV64[" << std::dec << +Inst.rd
                      << "] (" << std::hex << R->ERV64[Inst.rd]
                      << ") = RV64[" << std::dec << +Inst.rs1
                      << "] (" << std::hex << R->RV64[Inst.rs1]
                      << ") + IMM (" << std::hex << td_u64(Inst.imm, 12)
                      << ")" << std::endl;
          }
#endif
        }
        return true;
      }

      static bool eaddix(RevFeature *F, RevRegFile *R, RevMem *M, RevXbgas *Xbgas, RevInst Inst) {
        if( F->IsRV32() ){
          R->ERV32[Inst.rd] = dt_u32((int32_t)(td_u32(R->ERV32[Inst.rs1], 32)) + (int32_t)(td_u32(Inst.imm,12)), 32);
          R->RV32_PC += Inst.instSize;
#ifdef DEBUG
          int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
          if(id == 0) {
            std::cout << "CPU" << id
                      << ": [eaddix] ERV32[" << std::dec << +Inst.rd
                      << "] (" << std::hex << R->ERV32[Inst.rd]
                      << ") = ERV32[" << std::dec << +Inst.rs1
                      << "] (" << std::hex << R->ERV32[Inst.rs1]
                      << ") + IMM (" << std::hex << td_u32(Inst.imm, 12)
                      << ")" << std::endl;
          }
#endif
        }else {
          R->ERV64[Inst.rd] = dt_u64((int64_t)(td_u64(R->ERV64[Inst.rs1], 64)) + (int64_t)(td_u64(Inst.imm,12)), 64);
          R->RV64_PC += Inst.instSize;
#ifdef DEBUG
          int64_t id = (int64_t)(M->ReadU64(_XBGAS_MY_PE_ADDR_));
          if(id == 0) {
            // std::cout << "CPU" << id << " Registers --- eaddix" << std::endl;
            // for(int i=0; i < 32; i++) {
            //   std::cout << "e" << std::dec << i << ": " << std::hex << R->ERV64[i]
            //             << " | r" << std::dec << i << ": " << std::hex << R->RV64[i] << std::endl;
            // }
            std::cout << "CPU" << id
                      << ": [eaddix] ERV64[" << std::dec << +Inst.rd
                      << "] (" << std::hex << R->ERV64[Inst.rd]
                      << ") = ERV64[" << std::dec << +Inst.rs1
                      << "] (" << std::hex << R->ERV64[Inst.rs1]
                      << ") + IMM (" << std::hex << td_u64(Inst.imm, 12)
                      << ")" << std::endl;
          }
#endif
        }
        return true;
      }
    
      // ----------------------------------------------------------------------
      //
      // RISC-V RV32X Instructions
      //
      // Format:
      // <mnemonic> <cost> <opcode> <funct3> <funct7> <rdClass> <rs1Class>
      //            <rs2Class> <rs3Class> <format> <func> <nullEntry>
      // ----------------------------------------------------------------------
      std::vector<RevInstEntry> RV32XTable = {
      // Load instructions are encoded in the I-type format
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("elw %rd, $imm(%rs1)").SetCost(          1).SetOpcode(0b1110111).SetFunct3(0b010).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &elw).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("elh %rd, $imm(%rs1)").SetCost(          1).SetOpcode(0b1110111).SetFunct3(0b001).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &elh).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("elhu %rd, $imm(%rs1)").SetCost(         1).SetOpcode(0b1110111).SetFunct3(0b101).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &elhu).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("elb %rd, $imm(%rs1)").SetCost(          1).SetOpcode(0b1110111).SetFunct3(0b000).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &elb).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("elbu %rd, $imm(%rs1)").SetCost(         1).SetOpcode(0b1110111).SetFunct3(0b100).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &elbu).InstEntry},
      
      // // Store instructions are encoded in the S-type format
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("esw %rs2, $imm(%rs1)").SetCost(         1).SetOpcode(0b1111011).SetFunct3(0b010).SetrdClass(RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeS).SetImplFunc( &esw).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("esh %rs2, $imm(%rs1)").SetCost(         1).SetOpcode(0b1111011).SetFunct3(0b001).SetrdClass(RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeS).SetImplFunc( &esh).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("esb %rs2, $imm(%rs1)").SetCost(         1).SetOpcode(0b1111011).SetFunct3(0b000).SetrdClass(RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeS).SetImplFunc( &esb).InstEntry},
      
      // // Raw Load instructions are encoded in the R-type format
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("erlw %rd, %rs1, %ext2").SetCost(        1).SetOpcode(0b0110011).SetFunct3(0b010).SetFunct7(0b1010101).SetFormat(RVTypeR).SetImplFunc( &erlw).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("erlh %rd, %rs1, %ext2").SetCost(        1).SetOpcode(0b0110011).SetFunct3(0b001).SetFunct7(0b1010101).SetFormat(RVTypeR).SetImplFunc( &erlh).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("erlhu %rd, %rs1, %ext2").SetCost(       1).SetOpcode(0b0110011).SetFunct3(0b101).SetFunct7(0b1010101).SetFormat(RVTypeR).SetImplFunc( &erlhu).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("erlb %rd, %rs1, %ext2").SetCost(        1).SetOpcode(0b0110011).SetFunct3(0b000).SetFunct7(0b1010101).SetFormat(RVTypeR).SetImplFunc( &erlb).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("erlbu %rd, %rs1, %ext2").SetCost(       1).SetOpcode(0b0110011).SetFunct3(0b100).SetFunct7(0b1010101).SetFormat(RVTypeR).SetImplFunc( &erlbu).InstEntry},

      // // Raw Store instructions are encoded in the R-type format
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("ersw %rs1, %rs2, %ext3").SetCost(       1).SetOpcode(0b0110011).SetFunct3(0b010).SetFunct7(0b0100010).SetFormat(RVTypeR).SetImplFunc( &ersw).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("ersh %rs1, %rs2, %ext3").SetCost(       1).SetOpcode(0b0110011).SetFunct3(0b001).SetFunct7(0b0100010).SetFormat(RVTypeR).SetImplFunc( &ersh).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("ersb %rs1, %rs2, %ext3").SetCost(       1).SetOpcode(0b0110011).SetFunct3(0b000).SetFunct7(0b0100010).SetFormat(RVTypeR).SetImplFunc( &ersb).InstEntry},
      
      // // Address Management Instructions are encoded in the I-type format
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("eaddi %rd, %ext1, $imm").SetCost(      1).SetOpcode(0b1111011).SetFunct3(0b110).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &eaddi).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("eaddie %extd, %rs1, $imm").SetCost(    1).SetOpcode(0b1111011).SetFunct3(0b111).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &eaddie).InstEntry},
      {RevInstEntryBuilder<RevInstDefaults>().SetMnemonic("eaddix %extd, %ext1, $imm").SetCost(   1).SetOpcode(0b0000011).SetFunct3(0b111).Setrs2Class(RegUNKNOWN).Setimm(FImm).SetFormat(RVTypeI).SetImplFunc( &eaddix).InstEntry}
      };

    public:
      /// RV32X: standard constructor
      RV32X( RevFeature *Feature,
             RevRegFile *RegFile,
             RevMem *RevMem,
             RevXbgas *RevXbgas,
             SST::Output *Output )
        : RevExt( "RV32X", Feature, RegFile, RevMem, RevXbgas, Output) {
          this->SetTable(RV32XTable);
        }

      /// RV32X: standard destructor
      ~RV32X() { }

    }; // end class RV32I
  } // namespace RevCPU
} // namespace SST

#endif
