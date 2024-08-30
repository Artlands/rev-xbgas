//
// _RV32X_h_
//
// Copyright (C) 2017-2024 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#ifndef _SST_REVCPU_XAMO_H_
#define _SST_REVCPU_XAMO_H_

#include "../RevExt.h"
#include "../RevInstHelpers.h"

namespace SST::RevCPU {

class Xamo : public RevExt {

  template<typename XLEN, RevFlag F_AMO>
  static bool eamooper( RevFeature* F, RevRegFile* R, RevMem* M, const RevInst& Inst ) {
    static_assert( std::is_unsigned_v<XLEN>, "XLEN must be unsigned integral type" );

    RevFlag flags{ F_AMO };

    if( Inst.aq ) {
      flags = RevFlag{ uint32_t( flags ) | uint32_t( RevFlag::F_AQ ) };
    }
    if( Inst.rl ) {
      flags = RevFlag{ uint32_t( flags ) | uint32_t( RevFlag::F_RL ) };
    }

    if( !R->IsRV64 ) {
      auto Nmspace = R->GetE<uint32_t>( Inst.rs1 );
      if( Nmspace == 0 ) {
        MemReq req(
          R->RV32[Inst.rs1], Inst.rd, RevRegClass::RegGPR, F->GetHartToExecID(), MemOp::MemOpAMO, true, R->GetMarkLoadComplete()
        );
        R->LSQueue->insert( req.LSQHashPair() );
        M->AMOVal( F->GetHartToExecID(), R->RV32[Inst.rs1], &R->RV32[Inst.rs2], &R->RV32[Inst.rd], req, flags );
      } else {
        RmtMemReq req(
          Nmspace,
          R->RV32[Inst.rs1],
          Inst.rd,
          RevRegClass::RegGPR,
          F->GetHartToExecID(),
          RmtMemOp::AMORqst,
          true,
          R->GetMarkRmtLoadComplete()
        );
        R->RmtLSQueue->insert( req.LSQHashPair() );
        M->RmtAMOVal( F->GetHartToExecID(), Nmspace, R->RV32[Inst.rs1], &R->RV32[Inst.rs2], &R->RV32[Inst.rd], req, flags );
      }

    } else {
      flags        = RevFlag{ uint32_t( flags ) | uint32_t( RevFlag::F_SEXT64 ) };
      auto Nmspace = R->GetE<uint64_t>( Inst.rs1 );
      if( Nmspace == 0 ) {
        MemReq req(
          R->RV64[Inst.rs1], Inst.rd, RevRegClass::RegGPR, F->GetHartToExecID(), MemOp::MemOpAMO, true, R->GetMarkLoadComplete()
        );
        R->LSQueue->insert( req.LSQHashPair() );
        M->AMOVal(
          F->GetHartToExecID(),
          R->RV64[Inst.rs1],
          reinterpret_cast<std::make_signed_t<XLEN>*>( &R->RV64[Inst.rs2] ),
          reinterpret_cast<std::make_signed_t<XLEN>*>( &R->RV64[Inst.rd] ),
          req,
          flags
        );
      } else {
        RmtMemReq req(
          Nmspace,
          R->RV64[Inst.rs1],
          Inst.rd,
          RevRegClass::RegGPR,
          F->GetHartToExecID(),
          RmtMemOp::AMORqst,
          true,
          R->GetMarkRmtLoadComplete()
        );
        R->RmtLSQueue->insert( req.LSQHashPair() );
        M->RmtAMOVal(
          F->GetHartToExecID(),
          Nmspace,
          R->RV64[Inst.rs1],
          reinterpret_cast<std::make_signed_t<XLEN>*>( &R->RV64[Inst.rs2] ),
          reinterpret_cast<std::make_signed_t<XLEN>*>( &R->RV64[Inst.rd] ),
          req,
          flags
        );
      }
    }
    // update the cost
    R->cost += M->RandCost( F->GetMinCost(), F->GetMaxCost() );
    R->AdvancePC( Inst );
    return true;
  }

  static constexpr auto& eamoswapw = eamooper<uint32_t, RevFlag::F_AMOSWAP>;
  static constexpr auto& eamoaddw  = eamooper<uint32_t, RevFlag::F_AMOADD>;
  static constexpr auto& eamoxorw  = eamooper<uint32_t, RevFlag::F_AMOXOR>;
  static constexpr auto& eamoandw  = eamooper<uint32_t, RevFlag::F_AMOAND>;
  static constexpr auto& eamoorw   = eamooper<uint32_t, RevFlag::F_AMOOR>;
  static constexpr auto& eamominw  = eamooper<uint32_t, RevFlag::F_AMOMIN>;
  static constexpr auto& eamomaxw  = eamooper<uint32_t, RevFlag::F_AMOMAX>;
  static constexpr auto& eamominuw = eamooper<uint32_t, RevFlag::F_AMOMINU>;
  static constexpr auto& eamomaxuw = eamooper<uint32_t, RevFlag::F_AMOMAXU>;

  static constexpr auto& eamoswapd = eamooper<uint64_t, RevFlag::F_AMOSWAP>;
  static constexpr auto& eamoaddd  = eamooper<uint64_t, RevFlag::F_AMOADD>;
  static constexpr auto& eamoxord  = eamooper<uint64_t, RevFlag::F_AMOXOR>;
  static constexpr auto& eamoandd  = eamooper<uint64_t, RevFlag::F_AMOAND>;
  static constexpr auto& eamoord   = eamooper<uint64_t, RevFlag::F_AMOOR>;
  static constexpr auto& eamomind  = eamooper<uint64_t, RevFlag::F_AMOMIN>;
  static constexpr auto& eamomaxd  = eamooper<uint64_t, RevFlag::F_AMOMAX>;
  static constexpr auto& eamominud = eamooper<uint64_t, RevFlag::F_AMOMINU>;
  static constexpr auto& eamomaxud = eamooper<uint64_t, RevFlag::F_AMOMAXU>;

  // ----------------------------------------------------------------------
  //
  // RISC-V xBGAS AMO Instructions
  //
  // ----------------------------------------------------------------------

  struct XamoInstDefaults : RevInstDefaults {
    XamoInstDefaults() { SetOpcode( 0b1101011 ); }
  };

  // clang-format off
  std::vector<RevInstEntry> XamoTable = {
    // Remote Atomic operations
    XamoInstDefaults().SetMnemonic("eamoswap.w %rd, %rs1, %rs2"   ).SetFunct3( 0b010 ).SetFunct2or7(0b0000001).SetImplFunc( eamoswapw) ,
    XamoInstDefaults().SetMnemonic("eamoadd.w %rd, %rs1, %rs2"    ).SetFunct3( 0b010 ).SetFunct2or7(0b0000000).SetImplFunc( eamoaddw  ),
    XamoInstDefaults().SetMnemonic("eamoxor.w %rd, %rs1, %rs2"    ).SetFunct3( 0b010 ).SetFunct2or7(0b0000100).SetImplFunc( eamoxorw  ),
    XamoInstDefaults().SetMnemonic("eamoand.w %rd, %rs1, %rs2"    ).SetFunct3( 0b010 ).SetFunct2or7(0b0001100).SetImplFunc( eamoandw  ),
    XamoInstDefaults().SetMnemonic("eamoor.w %rd, %rs1, %rs2"     ).SetFunct3( 0b010 ).SetFunct2or7(0b0001000).SetImplFunc( eamoorw   ),
    XamoInstDefaults().SetMnemonic("eamomin.w %rd, %rs1, %rs2"    ).SetFunct3( 0b010 ).SetFunct2or7(0b0010000).SetImplFunc( eamominw  ),
    XamoInstDefaults().SetMnemonic("eamomax.w %rd, %rs1, %rs2"    ).SetFunct3( 0b010 ).SetFunct2or7(0b0010100).SetImplFunc( eamomaxw  ),
    XamoInstDefaults().SetMnemonic("eamominu.w %rd, %rs1, %rs2"   ).SetFunct3( 0b010 ).SetFunct2or7(0b0011000).SetImplFunc( eamominuw ),
    XamoInstDefaults().SetMnemonic("eamomaxu.w %rd, %rs1, %rs2"   ).SetFunct3( 0b010 ).SetFunct2or7(0b0011100).SetImplFunc( eamomaxuw ),
  };

  static std::vector<RevInstEntry> RV64XamoTable() { return {
    XamoInstDefaults().SetMnemonic("eamoswap.d %rd, %rs1, %rs2"   ).SetFunct3( 0b011 ).SetFunct2or7(0b0000001).SetImplFunc( eamoswapd ),
    XamoInstDefaults().SetMnemonic("eamoadd.d %rd, %rs1, %rs2"    ).SetFunct3( 0b011 ).SetFunct2or7(0b0000000).SetImplFunc( eamoaddd  ),
    XamoInstDefaults().SetMnemonic("eamoxor.d %rd, %rs1, %rs2"    ).SetFunct3( 0b011 ).SetFunct2or7(0b0000100).SetImplFunc( eamoxord  ),
    XamoInstDefaults().SetMnemonic("eamoand.d %rd, %rs1, %rs2"    ).SetFunct3( 0b011 ).SetFunct2or7(0b0001100).SetImplFunc( eamoandd  ),
    XamoInstDefaults().SetMnemonic("eamoor.d %rd, %rs1, %rs2"     ).SetFunct3( 0b011 ).SetFunct2or7(0b0001000).SetImplFunc( eamoord   ),
    XamoInstDefaults().SetMnemonic("eamomin.d %rd, %rs1, %rs2"    ).SetFunct3( 0b011 ).SetFunct2or7(0b0010000).SetImplFunc( eamomind  ),
    XamoInstDefaults().SetMnemonic("eamomax.d %rd, %rs1, %rs2"    ).SetFunct3( 0b011 ).SetFunct2or7(0b0010100).SetImplFunc( eamomaxd  ),
    XamoInstDefaults().SetMnemonic("eamominu.d %rd, %rs1, %rs2"   ).SetFunct3( 0b011 ).SetFunct2or7(0b0011000).SetImplFunc( eamominud ),
    XamoInstDefaults().SetMnemonic("eamomaxu.d %rd, %rs1, %rs2"   ).SetFunct3( 0b011 ).SetFunct2or7(0b0011100).SetImplFunc( eamomaxud ),
  }; }

  // clang-format on

public:
  /// Xamo: standard constructor
  Xamo( RevFeature* Feature, RevMem* RevMem, SST::Output* Output ) : RevExt( "Xamo", Feature, RevMem, Output ) {
    if( Feature->IsRV64() ) {
      auto Table{ RV64XamoTable() };
      XamoTable.insert( XamoTable.end(), std::move_iterator( Table.begin() ), std::move_iterator( Table.end() ) );
    }
    SetTable( std::move( XamoTable ) );
  }

};  // end class Xamo

}  // namespace SST::RevCPU

#endif
