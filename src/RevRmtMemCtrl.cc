//
// _RevRmtMemCtrl_h_
//
// Copyright (C) 2017-2024 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#include "RevMem.h"
#include "RevRmtMemCtrl.h"

#define _XBGAS_DEBUG_

std::atomic<uint32_t> SST::RevCPU::RevBasicRmtMemCtrl::local_read_id( 0 );

namespace SST::RevCPU {

/// MemOp: Formatted Output
std::ostream& operator<<( std::ostream& os, RmtMemOp op ) {
  // clang-format off
  switch(op){
    case RmtMemOp::READRqst:         return os << "READRqst";
    case RmtMemOp::BulkREADRqst:     return os << "BulkREADRqst";
    case RmtMemOp::WRITERqst:        return os << "WRITERqst";
    case RmtMemOp::BulkWRITERqst:    return os << "BulkWRITERqst";
    case RmtMemOp::READResp:         return os << "READResp";
    case RmtMemOp::BulkREADResp:     return os << "BulkREADResp";
    case RmtMemOp::WRITEResp:        return os << "WRITEResp";
    case RmtMemOp::BulkWRITEResp:    return os << "BulkWRITEResp";
    case RmtMemOp::READLOCKRqst:     return os << "READLOCKRqst";
    case RmtMemOp::WRITEUNLOCKRqst:  return os << "WRITEUNLOCKRqst";
    case RmtMemOp::READLOCKResp:     return os << "READLOCKResp";
    case RmtMemOp::WRITEUNLOCKResp:  return os << "WRITEUNLOCKResp";
    case RmtMemOp::AMORqst:          return os << "AMORqst";
    case RmtMemOp::AMOResp:          return os << "AMOResp";
    case RmtMemOp::FENCE:            return os << "FENCE";
    case RmtMemOp::Unknown:          return os << "Unknown";
  }
  // clang-format on
  return os;
}

// ----------------------------------------
// RevRmtMemOp
// ----------------------------------------

RevRmtMemOp::RevRmtMemOp( unsigned Hart, RmtMemOp Op ) : Hart( Hart ), Op( Op ) {}

RevRmtMemOp::RevRmtMemOp( unsigned Hart, uint64_t Nmspace, uint64_t SrcAddr, size_t Size, RmtMemOp Op, RevFlag Flags, void* Target )
  : Hart( Hart ), Nmspace( Nmspace ), SrcAddr( SrcAddr ), Size( Size ), Nelem( 1 ), Op( Op ), Flags( Flags ), Target( Target ) {}

RevRmtMemOp::RevRmtMemOp(
  unsigned Hart,
  uint64_t Nmspace,
  uint64_t SrcAddr,
  uint64_t DestAddr,
  size_t   Size,
  uint32_t Nelem,
  RmtMemOp Op,
  RevFlag  Flags,
  void*    Target
)
  : Hart( Hart ), Nmspace( Nmspace ), SrcAddr( SrcAddr ), DestAddr( DestAddr ), Size( Size ), Nelem( Nelem ), Op( Op ),
    Flags( Flags ), Target( Target ) {}

RevRmtMemOp::RevRmtMemOp(
  unsigned Hart, uint64_t Nmspace, uint64_t DestAddr, size_t Size, RmtMemOp Op, RevFlag Flags, uint8_t* Buffer
)
  : Hart( Hart ), Nmspace( Nmspace ), DestAddr( DestAddr ), Size( Size ), Nelem( 1 ), Op( Op ), Flags( Flags ) {
  for( uint32_t i = 0; i < Size; ++i ) {
    Membuf.push_back( Buffer[i] );
  }
}

RevRmtMemOp::RevRmtMemOp(
  unsigned Hart,
  uint64_t Nmspace,
  uint64_t DestAddr,
  size_t   Size,
  uint32_t Nelem,
  RmtMemOp Op,
  RevFlag  Flags,
  void*    Target,
  uint8_t* Buffer
)
  : Hart( Hart ), Nmspace( Nmspace ), DestAddr( DestAddr ), Size( Size ), Nelem( Nelem ), Op( Op ), Flags( Flags ),
    Target( Target ) {
  for( uint32_t i = 0; i < Size * Nelem; ++i ) {
    Membuf.push_back( Buffer[i] );
  }
}

RevRmtMemOp::RevRmtMemOp(
  unsigned Hart, uint64_t Nmspace, uint64_t Addr, size_t Size, RmtMemOp Op, RevFlag Flags, void* Target, uint8_t* Buffer
)
  : Hart( Hart ), Nmspace( Nmspace ), SrcAddr( Addr ), DestAddr( Addr ), Size( Size ), Nelem( 1 ), Op( Op ), Flags( Flags ),
    Target( Target ) {
  for( uint32_t i = 0; i < Size; ++i ) {
    Membuf.push_back( Buffer[i] );
  }
}

// ----------------------------------------
// RevRmtMemCtrl
// ----------------------------------------
RevRmtMemCtrl::RevRmtMemCtrl( ComponentId_t id, const Params& params ) : SubComponent( id ), output( nullptr ) {
  uint32_t verbosity = params.find<uint32_t>( "verbose" );
  output             = new SST::Output( "[RevRmtMemCtrl @t]: ", verbosity, 0, SST::Output::STDOUT );
}

RevRmtMemCtrl::~RevRmtMemCtrl() {
  delete output;
}

// ----------------------------------------
// RevBasicRmtMemCtrl
// ----------------------------------------
RevBasicRmtMemCtrl::RevBasicRmtMemCtrl( ComponentId_t id, const Params& params ) : RevRmtMemCtrl( id, params ) {

  std::string ClockFreq = params.find<std::string>( "clock", "1Ghz" );

  xbgasNic              = loadUserSubComponent<RevCPU::xbgasNicAPI>( "xbgasNicIface" );

  if( !xbgasNic ) {
    output->fatal( CALL_INFO, -1, "Error: unable to load xbgasNicAPI\n" );
  }

  xbgasNic->setMsgHandler( new Event::Handler<RevBasicRmtMemCtrl>( this, &RevBasicRmtMemCtrl::rmtMemEventHandler ) );

  virtualHart     = params.find<uint16_t>( "numHarts", 1 );
  max_loads       = params.find<uint32_t>( "max_loads", 64 );
  max_stores      = params.find<uint32_t>( "max_stores", 64 );
  max_readlock    = params.find<uint32_t>( "max_readlock", 64 );
  max_writeunlock = params.find<uint32_t>( "max_writeunlock", 64 );
  max_ops         = params.find<uint32_t>( "ops_per_cycle", 2 );

  rqstQ.reserve( max_ops );

  registerStats();

  registerClock( ClockFreq, new Clock::Handler<RevBasicRmtMemCtrl>( this, &RevBasicRmtMemCtrl::clockTick ) );
}

RevBasicRmtMemCtrl::~RevBasicRmtMemCtrl() {
  for( auto* p : rqstQ )
    delete p;
  rqstQ.clear();
}

void RevBasicRmtMemCtrl::registerStats() {
  for( auto* stat :
       { "RmtReadInFlight",
         "RmtReadPending",
         "RmtReadBytes",
         "RmtWriteInFlight",
         "RmtWritePending",
         "RmtWritesBytes",
         "RmtReadLockInFlight",
         "RmtReadLockPending",
         "RmtReadLockBytes",
         "RmtWriteUnlockInFlight",
         "RmtWriteUnlockPending",
         "RmtWriteUnlockBytes",
         "RmtAMOInFlight",
         "RmtAMOPending",
         "RmtAMOBytes",
         "RmtFencePending" } ) {
    stats.push_back( registerStatistic<uint64_t>( stat ) );
  }
}

void RevBasicRmtMemCtrl::recordStat( RevBasicRmtMemCtrl::RmtMemCtrlStats Stat, uint64_t Data ) {
  stats[Stat]->addData( Data );
}

void RevBasicRmtMemCtrl::rmtMemEventHandler( Event* ev ) {
  xbgasNicEvent* event = static_cast<xbgasNicEvent*>( ev );
  switch( event->getOp() ) {
  case RmtMemOp::READRqst: handleReadRqst( event ); break;
  case RmtMemOp::BulkREADRqst: handleBulkReadRqst( event ); break;
  case RmtMemOp::READLOCKRqst: handleReadLockRqst( event ); break;
  case RmtMemOp::WRITERqst: handleWriteRqst( event ); break;
  case RmtMemOp::BulkWRITERqst: handleBulkWriteRqst( event ); break;
  case RmtMemOp::WRITEUNLOCKRqst: handleWriteUnlockRqst( event ); break;
  case RmtMemOp::READResp: handleReadResp( event ); break;
  case RmtMemOp::BulkREADResp: handleBulkReadResp( event ); break;
  case RmtMemOp::READLOCKResp: handleReadLockResp( event ); break;
  case RmtMemOp::WRITEResp: handleWriteResp( event ); break;
  case RmtMemOp::BulkWRITEResp: handleBulkWriteResp( event ); break;
  case RmtMemOp::WRITEUNLOCKResp: handleWriteUnlockResp( event ); break;
  case RmtMemOp::AMORqst: handleAMORqst( event ); break;
  case RmtMemOp::AMOResp: handleAMOResp( event ); break;
  default: output->fatal( CALL_INFO, -1, "Error : unknown remote memory operation type\n" ); break;
  }
}

void RevBasicRmtMemCtrl::handleReadRqst( xbgasNicEvent* ev ) {
  uint32_t Id       = ev->getID();
  uint32_t SrcId    = ev->getSrcId();
  uint64_t SrcAddr  = ev->getSrcAddr();
  uint64_t DestAddr = ev->getDestAddr();
  size_t   Size     = ev->getSize();
  RevFlag  Flags    = ev->getFlags();
  RmtMemOp ReqPurp  = RmtMemOp::READResp;

#ifdef _XBGAS_DEBUG_
  std::cout << "_XBGAS_DEBUG_ : PE " << getPEID() << " handle READ Rqst, ";
  std::cout << "Event ID: " << Id << ", SrcId: " << SrcId << ", SrcAddr: 0x" << std::hex << SrcAddr << ", DestAddr: 0x" << std::hex
            << DestAddr << std::dec << ", Size: " << Size << std::endl;
#endif

  uint8_t* Buffer = new uint8_t[Size];

  LocalLoadTrack.insert(
    { RmtOpIDHash( SrcId, Id ), LocalLoadRecord( virtualHart, 0, Id, SrcId, SrcAddr, DestAddr, Size, Flags, Buffer, ReqPurp ) }
  );

  LocalLoadCount.insert( { RmtOpIDHash( SrcId, Id ), 0 } );

  MemReq Req(
    SrcAddr,                       // Memory address
    SrcId,                         // Source ID
    Id,                            // Packet ID
    MemOp::MemOpREAD,              // Memory operation
    true,                          // Outstanding
    [this]( const MemReq& Req ) {  // Lambda function as a callback
      RevBasicRmtMemCtrl::MarkLocalLoadComplete( Req );
    }
  );
  // Send the request to the local memory
  Mem->ReadMem( virtualHart, SrcAddr, Size, (void*) ( Buffer ), std::move( Req ), Flags );
}

void RevBasicRmtMemCtrl::handleBulkReadRqst( xbgasNicEvent* ev ) {
  uint32_t Id       = ev->getID();
  uint32_t SrcId    = ev->getSrcId();
  uint64_t SrcAddr  = ev->getSrcAddr();
  uint64_t DestAddr = ev->getDestAddr();
  size_t   Size     = ev->getSize();
  RevFlag  Flags    = ev->getFlags();
  uint32_t Nelem    = ev->getNelem();
  RmtMemOp ReqPurp  = RmtMemOp::BulkREADResp;

#ifdef _XBGAS_DEBUG_
  std::cout << "_XBGAS_DEBUG_ : PE " << getPEID() << " handle BULK-READ Rqst, ";
  std::cout << "Event ID: " << Id << ", SrcId: " << SrcId << ", SrcAddr: 0x" << std::hex << SrcAddr << ", DestAddr: 0x" << std::hex
            << DestAddr << std::dec << ", Size: " << Size << ", Nelem: " << Nelem << std::endl;
#endif

  uint8_t* Buffer = new uint8_t[Size * Nelem];

  LocalLoadTrack.insert(
    { RmtOpIDHash( SrcId, Id ), LocalLoadRecord( virtualHart, 0, Id, SrcId, SrcAddr, DestAddr, Size, Nelem, Flags, Buffer, ReqPurp )
    }
  );

  LocalLoadCount.insert( { RmtOpIDHash( SrcId, Id ), 0 } );

  for( unsigned i = 0; i < Nelem; i++ ) {
    MemReq Req(
      SrcAddr + i * Size,            // Memory address
      SrcId,                         // Source ID
      Id,                            // Packet ID
      MemOp::MemOpREAD,              // Memory operation
      true,                          // Outstanding
      [this]( const MemReq& Req ) {  // Lambda function as a callback
        RevBasicRmtMemCtrl::MarkLocalLoadComplete( Req );
      }
    );
    // Send the request to the local memory
    Mem->ReadMem( virtualHart, SrcAddr + i * Size, Size, (void*) ( &Buffer[i * Size] ), std::move( Req ), Flags );
  }
}

void RevBasicRmtMemCtrl::handleReadLockRqst( xbgasNicEvent* ev ) {
  uint64_t SrcAddr = ev->getSrcAddr();
  size_t   Size    = ev->getSize();

  // Check if an (Addr, Size) range is locked by another PE. If locked, this event will be put in the pending queue.
  if( checkRangeOverlap( RmtLRSC, SrcAddr, Size ) ) {
    PendingRmtLRSC.push_back( ev );
  } else {
    applyReadLockRqst( ev );
    // Push the (Addr, Size) range to the locked range list. It will be unlocked when a write unlock request is received.
    RmtLRSC.push_back( { SrcAddr, Size } );
  }
}

bool RevBasicRmtMemCtrl::processReadLockRqst( xbgasNicEvent* ev ) {
  uint64_t SrcAddr = ev->getSrcAddr();
  size_t   Size    = ev->getSize();

  // Check if an (Addr, Size) range is locked by another PE. If locked, this event will be processed later.
  if( checkRangeOverlap( RmtLRSC, SrcAddr, Size ) ) {
    return false;
  } else {
    applyReadLockRqst( ev );
    return true;
  }
}

void RevBasicRmtMemCtrl::applyReadLockRqst( xbgasNicEvent* ev ) {
  unsigned Hart      = ev->getHart();
  uint32_t Id        = ev->getID();
  uint32_t SrcId     = ev->getSrcId();
  uint64_t SrcAddr   = ev->getSrcAddr();
  uint64_t DestAddr  = ev->getDestAddr();
  size_t   Size      = ev->getSize();
  RevFlag  Flags     = ev->getFlags();
  unsigned RmtHartId = HartHash( virtualHart, Hart, SrcId );
  RmtMemOp ReqPurp   = RmtMemOp::READLOCKResp;

  uint8_t* Buffer    = new uint8_t[Size];

  LocalLoadTrack.insert(
    { RmtOpIDHash( SrcId, Id ), LocalLoadRecord( RmtHartId, 0, Id, SrcId, SrcAddr, DestAddr, Size, Flags, Buffer, ReqPurp ) }
  );

  LocalLoadCount.insert( { RmtOpIDHash( SrcId, Id ), 0 } );

  MemReq Req(
    SrcAddr,                       // Memory address
    SrcId,                         // Source ID
    Id,                            // Packet ID
    MemOp::MemOpREAD,              // Memory operation
    true,                          // Outstanding
    [this]( const MemReq& Req ) {  // Lambda function as a callback
      RevBasicRmtMemCtrl::MarkLocalLoadComplete( Req );
    }
  );

  Mem->LR( RmtHartId, SrcAddr, Size, (void*) ( Buffer ), std::move( Req ), Flags );

#ifdef _XBGAS_DEBUG_LR_SC_
  std::cout << "_XBGAS_DEBUG_ : PE " << getPEID() << " apply READ-LOCK Rqst, ";
  std::cout << "Event ID: " << Id << ", SrcId: " << SrcId << ", SrcAddr: 0x" << std::hex << SrcAddr << ", DestAddr: 0x" << std::hex
            << DestAddr << ", Size: " << Size << ", RmtHartId: 0x" << RmtHartId << ", RmtOpIDHash( SrcId, Id ): 0x"
            << RmtOpIDHash( SrcId, Id ) << std::endl;
#endif
}

void RevBasicRmtMemCtrl::handleWriteRqst( xbgasNicEvent* ev ) {
  uint32_t Id       = ev->getID();
  uint32_t SrcId    = ev->getSrcId();
  uint64_t DestAddr = ev->getDestAddr();
  size_t   Size     = ev->getSize();
  RevFlag  Flags    = ev->getFlags();

  uint8_t* Buffer   = new uint8_t[Size];

  // Copy the data to the buffer
  ev->getData( Buffer );
  Mem->WriteMem( virtualHart, DestAddr, Size, (void*) ( Buffer ), Flags );

  xbgasNicEvent* RmtEvent = new xbgasNicEvent( getName() );
  RmtEvent->buildWRITEResp( Id );
  xbgasNic->send( RmtEvent, SrcId );
  delete[] Buffer;
}

void RevBasicRmtMemCtrl::handleBulkWriteRqst( xbgasNicEvent* ev ) {
  uint32_t Id       = ev->getID();
  uint32_t SrcId    = ev->getSrcId();
  uint64_t DestAddr = ev->getDestAddr();
  size_t   Size     = ev->getSize();
  uint32_t Nelem    = ev->getNelem();
  RevFlag  Flags    = ev->getFlags();

  uint8_t* Buffer   = new uint8_t[Size * Nelem];

  // Copy the data to the buffer
  ev->getData( Buffer );

  Mem->WriteMem( virtualHart, DestAddr, Size * Nelem, (void*) ( Buffer ), Flags );

  bool isSeg = ev->isSegmented();
  if( !isSeg ) {
    xbgasNicEvent* RmtEvent = new xbgasNicEvent( getName() );

#ifdef _XBGAS_DEBUG_
    std::cout << "_XBGAS_DEBUG_ : PE " << getPEID() << " Build Bulk-WRITE response" << std::endl;
#endif

    RmtEvent->buildBulkWRITEResp( Id );
    xbgasNic->send( RmtEvent, SrcId );
  } else {
    if( PacketSegCount.find( Id ) != PacketSegCount.end() ) {
      PacketSegCount[Id]++;
      // Check if all the segments have been received
      if( PacketSegCount[Id] == ev->getSegSz() ) {
        PacketSegCount.erase( Id );
        xbgasNicEvent* RmtEvent = new xbgasNicEvent( getName() );

#ifdef _XBGAS_DEBUG_
        std::cout << "_XBGAS_DEBUG_ : PE " << getPEID() << " Build Bulk-WRITE response (Segmented)" << std::endl;
#endif

        RmtEvent->buildSegBulkWRITEResp( Id, ev->getSegSz() );
        xbgasNic->send( RmtEvent, SrcId );
      }
    } else {
      PacketSegCount.insert( { Id, 1 } );
    }
  }
  delete[] Buffer;
}

void RevBasicRmtMemCtrl::handleWriteUnlockRqst( xbgasNicEvent* ev ) {
  unsigned Hart      = ev->getHart();
  uint32_t Id        = ev->getID();
  uint32_t SrcId     = ev->getSrcId();
  uint64_t DestAddr  = ev->getDestAddr();
  size_t   Size      = ev->getSize();
  uint32_t Nelem     = ev->getNelem();
  RevFlag  Flags     = ev->getFlags();
  unsigned RmtHartId = HartHash( virtualHart, Hart, SrcId );
  bool     rtn;

  uint8_t* Buffer    = new uint8_t[Size * Nelem];
  uint8_t* TmpTarget = new uint8_t[Size];

  // Copy the data to the buffer
  ev->getData( Buffer );

  xbgasNicEvent* RmtEvent = new xbgasNicEvent( getName() );

  rtn                     = Mem->SC( RmtHartId, DestAddr, Size, (void*) ( Buffer ), Flags );
  // Update TmpTarget with 0 if rtn is true, 1 if rtn is false.
  for( size_t i = 0; i < Size; i++ ) {
    TmpTarget[i] = !rtn;
  }
  RmtEvent->buildWRITEUNLOCKResp( Id, Size, TmpTarget );
  xbgasNic->send( RmtEvent, SrcId );

  delete[] Buffer;
  delete[] TmpTarget;

  // Remove the (Addr, Size) range from the locked range list
  if( !RmtLRSC.empty() ) {
    uint64_t EndAddr = DestAddr + Size;
    RmtLRSC.erase(
      std::remove_if(
        RmtLRSC.begin(),
        RmtLRSC.end(),
        [DestAddr, EndAddr]( const auto& range ) {
          uint64_t endAddr = range.first + range.second;
          return ( DestAddr < endAddr && EndAddr > range.first );
        }
      ),
      RmtLRSC.end()
    );
  }
}

void RevBasicRmtMemCtrl::handleAMORqst( xbgasNicEvent* ev ) {
  unsigned Hart      = ev->getHart();
  uint32_t Id        = ev->getID();
  uint32_t SrcId     = ev->getSrcId();
  uint64_t SrcAddr   = ev->getSrcAddr();
  size_t   Size      = ev->getSize();
  RevFlag  Flags     = ev->getFlags();
  unsigned RmtHartId = HartHash( virtualHart, Hart, SrcId );
  RmtMemOp ReqPurp   = RmtMemOp::AMOResp;

  uint8_t* Buffer    = new uint8_t[Size];
  uint8_t* TmpTarget = new uint8_t[Size];

  // Copy the data to the buffer
  ev->getData( Buffer );

  LocalLoadTrack.insert(
    { RmtOpIDHash( SrcId, Id ), LocalLoadRecord( RmtHartId, 0, Id, SrcId, SrcAddr, 0, Size, Flags, TmpTarget, ReqPurp ) }
  );

  LocalLoadCount.insert( { RmtOpIDHash( SrcId, Id ), 0 } );

  MemReq Req(
    SrcAddr,                       // Memory address
    SrcId,                         // Source ID
    Id,                            // Packet ID
    MemOp::MemOpAMO,               // Memory operation
    true,                          // Outstanding
    [this]( const MemReq& Req ) {  // Lambda function as a callback
      RevBasicRmtMemCtrl::MarkLocalLoadComplete( Req );
    }
  );

  Mem->AMOMem( RmtHartId, SrcAddr, Size, (void*) ( Buffer ), (void*) ( TmpTarget ), Req, Flags );
}

void RevBasicRmtMemCtrl::handleReadResp( xbgasNicEvent* ev ) {
  uint32_t Id = ev->getID();

  if( std::find( requests.begin(), requests.end(), Id ) != requests.end() ) {
    RevRmtMemOp* Op = outstanding[Id];
    if( !Op )
      output->fatal( CALL_INFO, -1, "RevRmtMemOp is null in handleReadResp\n" );
    const RmtMemReq& r      = Op->getRmtMemReq();
    uint8_t*         Target = static_cast<uint8_t*>( Op->getTarget() );
    ev->getData( Target );  // Copy the data to the target register
    handleFlagResp( Op );   // determine if we need to sign/zero extend
    r.MarkRmtOpComplete();  // Mark the remote load complete
    requests.erase( std::find( requests.begin(), requests.end(), Id ) );
    outstanding.erase( Id );
    // Update the stats
    num_read_rqst--;
  } else {
    output->fatal( CALL_INFO, -1, "Error: found unknown ReadResp\n" );
  }
  delete ev;
  return;
}

void RevBasicRmtMemCtrl::handleBulkReadResp( xbgasNicEvent* ev ) {
  uint32_t Id = ev->getID();

  if( std::find( requests.begin(), requests.end(), Id ) != requests.end() ) {
    RevRmtMemOp* Op = outstanding[Id];
    if( !Op )
      output->fatal( CALL_INFO, -1, "RevRmtMemOp is null in handleBulkReadResp\n" );

    const RmtMemReq& r        = Op->getRmtMemReq();
    uint8_t*         Target   = static_cast<uint8_t*>( Op->getTarget() );
    uint64_t         DestAddr = ev->getDestAddr();
    size_t           Size     = ev->getSize();
    uint32_t         Nelem    = ev->getNelem();
    RevFlag          Flags    = ev->getFlags();
    uint8_t*         Buffer   = new uint8_t[Size * Nelem];

    ev->getData( Buffer );

    for( unsigned i = 0; i < Nelem; i++ ) {
      Mem->WriteMem( virtualHart, DestAddr + i * Size, Size, (void*) ( &Buffer[i * Size] ), Flags );
    }

    delete[] Buffer;

    bool isSeg = ev->isSegmented();
    if( !isSeg ) {
      // Update Target register to non-zero values
      for( size_t i = 0; i < Size; i++ ) {
        Target[i] = 1;
      }
      r.MarkRmtOpComplete();  // Mark the remote bulk load complete

#ifdef _XBGAS_DEBUG_
      std::cout << "_XBGAS_DEBUG_ : PE " << getPEID() << " Mark Bulk READ Complete" << std::endl;
#endif

      requests.erase( std::find( requests.begin(), requests.end(), Id ) );
      outstanding.erase( Id );
      num_read_rqst--;
    } else {
      if( PacketSegCount.find( Id ) != PacketSegCount.end() ) {
        PacketSegCount[Id]++;
        // Check if all the segments have been received
        if( PacketSegCount[Id] == ev->getSegSz() ) {
          PacketSegCount.erase( Id );
          // Update Target register to non-zero values
          for( size_t i = 0; i < Size; i++ ) {
            Target[i] = 1;
          }
          r.MarkRmtOpComplete();  // Mark the remote bulk load complete

#ifdef _XBGAS_DEBUG_
          std::cout << "_XBGAS_DEBUG_ : PE " << getPEID() << ", Mark Bulk READ (Segmented) Complete" << std::endl;
#endif

          requests.erase( std::find( requests.begin(), requests.end(), Id ) );
          outstanding.erase( Id );
          num_read_rqst--;
        }
      } else {
        PacketSegCount.insert( { Id, 1 } );
      }
    }
  } else {
    output->fatal( CALL_INFO, -1, "Error: found unknown ReadResp\n" );
  }
  delete ev;
  return;
}

void RevBasicRmtMemCtrl::handleReadLockResp( xbgasNicEvent* ev ) {
  uint32_t Id = ev->getID();

  if( std::find( requests.begin(), requests.end(), Id ) != requests.end() ) {
    RevRmtMemOp* Op = outstanding[Id];
    if( !Op )
      output->fatal( CALL_INFO, -1, "RevRmtMemOp is null in handleReadLockResp\n" );

    const RmtMemReq& r      = Op->getRmtMemReq();
    uint8_t*         Target = static_cast<uint8_t*>( Op->getTarget() );
    ev->getData( Target );  // Copy the data to the target register
    handleFlagResp( Op );   // determine if we need to sign/zero extend
    r.MarkRmtOpComplete();  // Mark the remote load complete
    requests.erase( std::find( requests.begin(), requests.end(), Id ) );
    outstanding.erase( Id );
    // Update the stats
    num_read_lock_rqst--;
  } else {
    output->fatal( CALL_INFO, -1, "Error: found unknown ReadResp\n" );
  }
  delete ev;
  return;
}

void RevBasicRmtMemCtrl::handleWriteResp( xbgasNicEvent* ev ) {
  uint32_t Id = ev->getID();

  if( std::find( requests.begin(), requests.end(), Id ) != requests.end() ) {
    requests.erase( std::find( requests.begin(), requests.end(), Id ) );
    RevRmtMemOp* Op = outstanding[Id];
    if( !Op )
      output->fatal( CALL_INFO, -1, "RevRmtMemOp is null in handleWriteResp\n" );
    num_write_rqst--;
    outstanding.erase( Id );
  } else {
    output->fatal( CALL_INFO, -1, "Error: found unknown response\n" );
  }
  delete ev;
  return;
}

void RevBasicRmtMemCtrl::handleBulkWriteResp( xbgasNicEvent* ev ) {
  uint32_t Id   = ev->getID();
  size_t   Size = ev->getSize();

  if( std::find( requests.begin(), requests.end(), Id ) != requests.end() ) {
    requests.erase( std::find( requests.begin(), requests.end(), Id ) );
    RevRmtMemOp* Op = outstanding[Id];
    if( !Op )
      output->fatal( CALL_INFO, -1, "RevRmtMemOp is null in handleBulkWriteResp\n" );
    // Bulk Write Response
    const RmtMemReq& r      = Op->getRmtMemReq();
    uint8_t*         Target = static_cast<uint8_t*>( Op->getTarget() );

#ifdef _XBGAS_DEBUG_
    std::cout << "_XBGAS_DEBUG_ : PE " << getPEID() << " Mark Bulk WRITE Complete" << std::endl;
#endif

    // Update Target register to non-zero values
    for( size_t i = 0; i < Size; i++ ) {
      Target[i] = 1;
    }
    r.MarkRmtOpComplete();  // Mark the remote bulk write complete
    num_write_rqst--;
    outstanding.erase( Id );
  } else {
    output->fatal( CALL_INFO, -1, "Error: found unknown response\n" );
  }
  delete ev;
  return;
}

void RevBasicRmtMemCtrl::handleWriteUnlockResp( xbgasNicEvent* ev ) {
  uint32_t Id = ev->getID();

  if( std::find( requests.begin(), requests.end(), Id ) != requests.end() ) {
    requests.erase( std::find( requests.begin(), requests.end(), Id ) );
    RevRmtMemOp* Op = outstanding[Id];
    if( !Op )
      output->fatal( CALL_INFO, -1, "RevRmtMemOp is null in handleWriteUnlockResp\n" );
    const RmtMemReq& r      = Op->getRmtMemReq();
    uint8_t*         Target = static_cast<uint8_t*>( Op->getTarget() );
    ev->getData( Target );  // Copy the data to the target register
    handleFlagResp( Op );   // determine if we need to sign/zero extend
    r.MarkRmtOpComplete();  // Mark the remote write complete
    num_write_unlock_rqst--;
    outstanding.erase( Id );
  } else {
    output->fatal( CALL_INFO, -1, "Error: found unknown response\n" );
  }
  delete ev;
  return;
}

void RevBasicRmtMemCtrl::handleAMOResp( xbgasNicEvent* ev ) {
  RmtMemOp Opcode = ev->getOp();
  uint32_t Id     = ev->getID();

  if( std::find( requests.begin(), requests.end(), Id ) != requests.end() ) {
    requests.erase( std::find( requests.begin(), requests.end(), Id ) );
    if( Opcode == RmtMemOp::AMOResp ) {
      RevRmtMemOp*     Op     = outstanding[Id];
      const RmtMemReq& r      = Op->getRmtMemReq();
      uint8_t*         Target = static_cast<uint8_t*>( Op->getTarget() );
      ev->getData( Target );  // Copy the data to the target register
      handleFlagResp( Op );   // determine if we need to sign/zero extend
      r.MarkRmtOpComplete();  // Mark the remote load complete
      num_amo_rqst--;
    } else {
      output->fatal( CALL_INFO, -1, "Error: unknown remote memory response\n" );
    }
    outstanding.erase( Id );
  } else {
    output->fatal( CALL_INFO, -1, "Error: found unknown AMOResp\n" );
  }
  delete ev;
  return;
}

void RevBasicRmtMemCtrl::MarkLocalLoadComplete( const MemReq& Req ) {
  uint64_t hashedId = RmtOpIDHash( Req.SrcId, Req.PktId );

#ifdef _XBGAS_DEBUG_LL_
  std::cout << "_XBGAS_DEBUG_ : PE " << getPEID() << " Mark Local Load Complete, ";
  std::cout << "Addr: 0x" << std::hex << Req.Addr << ", hashedId: " << std::hex << hashedId << std::endl;
#endif

  auto           Record   = LocalLoadTrack.find( hashedId )->second;
  uint32_t       Id       = Record.Id;
  uint32_t       SrcId    = Record.SrcId;
  uint32_t       DestId   = Record.DestId;
  uint64_t       DestAddr = Record.DestAddr;
  size_t         Size     = Record.Size;
  uint32_t       Nelem    = Record.Nelem;
  RevFlag        Flags    = Record.Flags;
  uint8_t*       Buffer   = Record.Buffer;
  RevRmtMemOp*   Op       = Record.Op;
  RmtMemOp       ReqPurp  = Record.ReqPurp;
  RmtMemReq      RmtReq   = Record.RmtReq;
  xbgasNicEvent* RmtEvent;

  if( LocalLoadCount.find( hashedId ) != LocalLoadCount.end() ) {
    LocalLoadCount[hashedId]++;
  } else {
    output->fatal( CALL_INFO, -1, "Error: unable to find the load count entry\n" );
  }

  // Check if all the elements have been loaded
  if( LocalLoadCount[hashedId] == Nelem ) {
    switch( ReqPurp ) {
    case RmtMemOp::READResp:
      RmtEvent = new xbgasNicEvent( getName() );
      RmtEvent->buildREADResp( Id, DestAddr, Size, Nelem, Flags, Buffer );
      // Destination is the source of the request
      xbgasNic->send( RmtEvent, SrcId );
      break;
    case RmtMemOp::BulkREADResp:
      // If the payload is larger than _MAX_PAYLOAD_ (4KB), segment the response
      if( Size * Nelem > _MAX_PAYLOAD_ ) {
        uint32_t SegSz = ( Size * Nelem ) / _MAX_PAYLOAD_;
        uint32_t Rem   = ( Size * Nelem ) % _MAX_PAYLOAD_;
        if( Rem != 0 )
          SegSz++;

        for( uint32_t i = 0; i < SegSz; i++ ) {
          uint32_t SegPayload = ( Rem == 0 ) ? _MAX_PAYLOAD_ : ( i == SegSz - 1 ) ? Rem : _MAX_PAYLOAD_;
          uint32_t SegNelem   = SegPayload / Size;

#ifdef _XBGAS_DEBUG_
          std::cout << "_XBGAS_DEBUG_ : PE " << getPEID() << " Segmented READ Resp, ";
          std::cout << "SegPayload: " << std::dec << SegPayload << ", SegNelem: " << SegNelem << std::endl;
#endif
          uint8_t* SegBuf = new uint8_t[SegPayload];
          for( uint32_t j = 0; j < SegPayload; j++ ) {
            SegBuf[j] = Buffer[i * _MAX_PAYLOAD_ + j];
          }
          RmtEvent = new xbgasNicEvent( getName() );
          RmtEvent->buildSegBulkREADResp( Id, DestAddr + i * _MAX_PAYLOAD_, Size, SegNelem, Flags, SegSz, SegBuf );
          xbgasNic->send( RmtEvent, SrcId );
          delete[] SegBuf;
        }
      } else {
        RmtEvent = new xbgasNicEvent( getName() );
        RmtEvent->buildBulkREADResp( Id, DestAddr, Size, Nelem, Flags, Buffer );
        // Destination is the source of the request
        xbgasNic->send( RmtEvent, SrcId );
      }
      break;
    case RmtMemOp::READLOCKResp:
      RmtEvent = new xbgasNicEvent( getName() );
      RmtEvent->buildREADLOCKResp( Id, Size, Buffer );
      xbgasNic->send( RmtEvent, SrcId );

#ifdef _XBGAS_DEBUG_LR_SC_
      std::cout << "_XBGAS_DEBUG_ : PE " << getPEID() << " READ-LOCK succeeded, generate a response"
                << " SrcId: " << std::dec << SrcId << " Id: " << Id << " Size: " << Size << std::endl;
#endif
      break;
    case RmtMemOp::BulkWRITERqst:

#ifdef _XBGAS_DEBUG_
      std::cout << "_XBGAS_DEBUG_ : PE " << getPEID() << " Mark Local Load Complete for BulkWRITERqst " << std::endl;
#endif

      // If the payload is larger than _MAX_PAYLOAD_ (4KB), segment the request
      if( Size * Nelem > _MAX_PAYLOAD_ ) {
        uint32_t SegSz = ( Size * Nelem ) / _MAX_PAYLOAD_;
        uint32_t Rem   = ( Size * Nelem ) % _MAX_PAYLOAD_;
        if( Rem != 0 )
          SegSz++;
        for( uint32_t i = 0; i < SegSz; i++ ) {
          uint32_t SegPayload = ( Rem == 0 ) ? _MAX_PAYLOAD_ : ( i == SegSz - 1 ) ? Rem : _MAX_PAYLOAD_;
          uint32_t SegNelem   = SegPayload / Size;
          uint8_t* SegBuf     = new uint8_t[SegPayload];
          for( uint32_t j = 0; j < SegPayload; j++ ) {
            SegBuf[j] = Buffer[i * _MAX_PAYLOAD_ + j];
          }
          RmtEvent = new xbgasNicEvent( getName() );
          RmtEvent->buildSegBulkWRITERqst( i, DestAddr + i * _MAX_PAYLOAD_, Size, SegNelem, Flags, SegSz, SegBuf );
          if( i == 0 ) {
            Id = RmtEvent->getID();
            requests.push_back( Id );
            outstanding[Id] = Op;
          } else {
            RmtEvent->setId( Id );
          }

#ifdef _XBGAS_DEBUG_
          std::cout << "_XBGAS_DEBUG_ : PE " << getPEID() << " Send out the Bulk-WRITE request (segmented)" << std::endl;
#endif

          xbgasNic->send( RmtEvent, DestId );
          recordStat( RmtWriteInFlight, 1 );
          delete[] SegBuf;
        }
      } else {
        RmtEvent = new xbgasNicEvent( getName() );
        RmtEvent->buildBulkWRITERqst( DestAddr, Size, Nelem, Flags, Buffer );
        Id = RmtEvent->getID();
#ifdef _XBGAS_DEBUG_
        std::cout << "_XBGAS_DEBUG_ : PE " << getPEID() << " Send out the Bulk-WRITE request" << std::endl;
#endif
        xbgasNic->send( RmtEvent, DestId );
        requests.push_back( Id );
        outstanding[Id] = Op;
        recordStat( RmtWriteInFlight, 1 );
      }
      break;
    case RmtMemOp::AMOResp:
      RmtEvent = new xbgasNicEvent( getName() );
      RmtEvent->buildAMOResp( Id, Size, Buffer );
      xbgasNic->send( RmtEvent, SrcId );
      break;
    default: break;
    }
    delete[] Buffer;
    LocalLoadTrack.erase( hashedId );
    LocalLoadCount.erase( hashedId );
  }
}

void RevBasicRmtMemCtrl::init( unsigned int phase ) {
  xbgasNic->init( phase );
}

void RevBasicRmtMemCtrl::setup() {
  if( xbgasNic == nullptr )
    output->fatal( CALL_INFO, -1, "Error: xBGAS NIC Inferface is null\n" );
  xbgasNic->setup();

  xbgasHosts       = xbgasNic->getXbgasHosts();
  myPEid           = xbgasNic->getAddress();
  numPEs           = xbgasHosts.size();

  // Namespece Lookaside Buffer Initialization. Now using a naive implementation,
  // i.e, the first entry is reserved for the local PE and the rest of namespace id
  // is calculated by adding 1 to the PE id.
  uint64_t nmspace = 0;

  if( xbgasHosts.size() != 0 ) {
    // The first entry is reserved for the local PE
    nmspaceLB[nmspace] = myPEid;
    for( unsigned i = 1; i < numPEs; i++ ) {
      nmspace            = (uint64_t) ( xbgasHosts[i] + 1 );
      nmspaceLB[nmspace] = xbgasHosts[i];
    }
  }

#ifdef _XBGAS_DEBUG_
  std::cout << "_XBGAS_DEBUG_ : Namespace Lookaside Buffer of PE " << myPEid << ":" << std::endl;
  std::cout << "|" << std::string( 23, '-' ) << "|"
            << "\n";
  std::cout << "|"
            << " Namespace "
            << "|"
            << "Physical ID"
            << "|"
            << "\n";
  for( auto it = nmspaceLB.begin(); it != nmspaceLB.end(); ++it ) {
    std::cout << "|" << std::string( 11, '-' ) << "+" << std::string( 11, '-' ) << "|"
              << "\n";
    std::cout << "|" << std::string( 5, ' ' ) << it->first << std::string( 5, ' ' ) << "|" << std::string( 5, ' ' ) << it->second
              << std::string( 5, ' ' ) << "|" << '\n';
  }
  std::cout << "|" << std::string( 23, '-' ) << "|"
            << "\n";
#endif
}

void RevBasicRmtMemCtrl::finish() {}

bool RevBasicRmtMemCtrl::sendRmtReadRqst(
  unsigned Hart, uint64_t Nmspace, uint64_t SrcAddr, size_t Size, void* Target, const RmtMemReq& Req, RevFlag Flags
) {

  if( Size == 0 )
    return true;
  RevRmtMemOp* Op = new RevRmtMemOp( Hart, Nmspace, SrcAddr, Size, RmtMemOp::READRqst, Flags, Target );
  // Remote memory operations are not cached
  // RevFlag TmpFlags = Op->getNonCacheFlags();
  // Op->setFlags( TmpFlags );
  Op->setRmtMemReq( Req );
  rqstQ.push_back( Op );
  recordStat( RevBasicRmtMemCtrl::RmtMemCtrlStats::RmtReadPending, 1 );
  return true;
}

bool RevBasicRmtMemCtrl::sendRmtBulkReadRqst(
  unsigned         Hart,
  uint64_t         Nmspace,
  uint64_t         SrcAddr,
  size_t           Size,
  uint32_t         Nelem,
  uint64_t         DestAddr,
  void*            Target,
  const RmtMemReq& Req,
  RevFlag          Flags
) {
  if( Size == 0 )
    return true;

  RevRmtMemOp* Op = new RevRmtMemOp( Hart, Nmspace, SrcAddr, DestAddr, Size, Nelem, RmtMemOp::BulkREADRqst, Flags, Target );
  // Remote memory operations are not cached
  // RevFlag TmpFlags = Op->getNonCacheFlags();
  // Op->setFlags( TmpFlags );
  // Set Target to zero values

#ifdef _XBGAS_DEBUG_
  std::cout << "_XBGAS_DEBUG_ : PE " << getPEID() << " Mark BULK-READ Complete to false" << std::endl;
#endif

  for( size_t i = 0; i < Size; i++ ) {
    static_cast<uint8_t*>( Target )[i] = 0;
  }
  Op->setRmtMemReq( Req );
  rqstQ.push_back( Op );
  recordStat( RevBasicRmtMemCtrl::RmtMemCtrlStats::RmtReadPending, 1 );
  return true;
}

bool RevBasicRmtMemCtrl::sendRmtWriteRqst(
  unsigned Hart, uint64_t Nmspace, uint64_t DestAddr, size_t Size, uint8_t* Buffer, RevFlag Flags
) {
  if( Size == 0 )
    return true;
  RevRmtMemOp* Op = new RevRmtMemOp( Hart, Nmspace, DestAddr, Size, RmtMemOp::WRITERqst, Flags, Buffer );
  // Remote memory operations are not cached
  // RevFlag TmpFlags = Op->getNonCacheFlags();
  // Op->setFlags( TmpFlags );
  rqstQ.push_back( Op );
  recordStat( RevBasicRmtMemCtrl::RmtMemCtrlStats::RmtWritePending, 1 );
  return true;
}

bool RevBasicRmtMemCtrl::sendRmtBulkWriteRqst(
  unsigned         Hart,
  uint64_t         Nmspace,
  uint64_t         DestAddr,
  size_t           Size,
  uint32_t         Nelem,
  uint64_t         SrcAddr,
  void*            Target,
  const RmtMemReq& Req,
  RevFlag          Flags
) {
  if( Size == 0 )
    return true;

#ifdef _XBGAS_DEBUG_
  std::cout << "_XBGAS_DEBUG_ : PE " << getPEID() << " Mark BULK-WRITE Complete to false" << std::endl;
#endif

  // Set Target to zero values
  for( size_t i = 0; i < Size; i++ ) {
    static_cast<uint8_t*>( Target )[i] = 0;
  }

  RevRmtMemOp* Op = new RevRmtMemOp( Hart, Nmspace, SrcAddr, DestAddr, Size, Nelem, RmtMemOp::BulkWRITERqst, Flags, Target );
  Op->setRmtMemReq( Req );
  rqstQ.push_back( Op );
  recordStat( RevBasicRmtMemCtrl::RmtMemCtrlStats::RmtWritePending, 1 );
  return true;
}

bool RevBasicRmtMemCtrl::sendRmtReadLockRqst(
  unsigned Hart, uint64_t Nmspace, uint64_t SrcAddr, size_t Size, void* Target, const RmtMemReq& Req, RevFlag Flags
) {
  if( Size == 0 )
    return true;
  RevRmtMemOp* Op = new RevRmtMemOp( Hart, Nmspace, SrcAddr, Size, RmtMemOp::READLOCKRqst, Flags, Target );
  // Remote memory operations are not cached
  // RevFlag TmpFlags = Op->getNonCacheFlags();
  // Op->setFlags( TmpFlags );
  Op->setRmtMemReq( Req );
  rqstQ.push_back( Op );
  recordStat( RevBasicRmtMemCtrl::RmtMemCtrlStats::RmtReadLockPending, 1 );
  return true;
}

bool RevBasicRmtMemCtrl::sendRmtWriteUnLockRqst(
  unsigned         Hart,
  uint64_t         Nmspace,
  uint64_t         DestAddr,
  size_t           Size,
  const RmtMemReq& Req,
  RevFlag          Flags,
  uint8_t*         Buffer,
  void*            Target
) {
  if( Size == 0 )
    return true;
  RevRmtMemOp* Op = new RevRmtMemOp( Hart, Nmspace, DestAddr, Size, RmtMemOp::WRITEUNLOCKRqst, Flags, Target, Buffer );
  // Remote memory operations are not cached
  // RevFlag TmpFlags = Op->getNonCacheFlags();
  // Op->setFlags( TmpFlags );
  Op->setRmtMemReq( Req );
  rqstQ.push_back( Op );
  recordStat( RevBasicRmtMemCtrl::RmtMemCtrlStats::RmtWriteUnlockPending, 1 );
  return true;
}

bool RevBasicRmtMemCtrl::sendRmtAMORqst(
  unsigned Hart, uint64_t Nmspace, uint64_t SrcAddr, size_t Size, uint8_t* Buffer, void* Target, const RmtMemReq& Req, RevFlag Flags
) {
  if( Size == 0 )
    return true;
  RevRmtMemOp* Op = new RevRmtMemOp( Hart, Nmspace, SrcAddr, Size, RmtMemOp::AMORqst, Flags, Target, Buffer );
  Op->setRmtMemReq( Req );
  rqstQ.push_back( Op );
  return true;
}

bool RevBasicRmtMemCtrl::sendFENCE( unsigned Hart ) {
  RevRmtMemOp* Op = new RevRmtMemOp( Hart, RmtMemOp::FENCE );
  rqstQ.push_back( Op );
  recordStat( RevBasicRmtMemCtrl::RmtMemCtrlStats::RmtFencePending, 1 );
  return true;
}

bool RevBasicRmtMemCtrl::clockTick( Cycle_t cycle ) {
  // Check to see if the top request is a FENCE request
  if( num_fence > 0 ) {

#ifdef _XBGAS_DEBUG_FENCE_
    std::cout << "_XBGAS_DEBUG_ : PE " << getPEID() << " FENCE request, num_fence: " << std::dec << num_fence
              << ", num_read_rqst: " << num_read_rqst << ", num_write_rqst: " << num_write_rqst
              << ", num_read_lock_rqst: " << num_read_lock_rqst << ", num_write_unlock_rqst: " << num_write_unlock_rqst
              << std::endl;
#endif

    if( ( num_read_rqst + num_write_rqst + num_read_lock_rqst + num_write_unlock_rqst ) != 0 ) {
      recordStat( RevBasicRmtMemCtrl::RmtMemCtrlStats::RmtFencePending, 1 );
      return false;
    } else {
      num_fence--;
#ifdef _XBGAS_DEBUG_FENCE_
      std::cout << "_XBGAS_DEBUG_ : PE " << getPEID() << " FENCE request, num_fence: " << std::dec << num_fence << std::endl;
#endif
    }
  }

  // Check if there is any pending LR operation in PendingRmtLRSC
  for( auto it = PendingRmtLRSC.begin(); it != PendingRmtLRSC.end(); ) {
    if( processReadLockRqst( *it ) ) {
      it = PendingRmtLRSC.erase( it );
    } else {
      ++it;
    }
  }

  // process the remote memory requests
  bool     done              = false;
  unsigned t_max_ops         = 0;
  unsigned t_max_loads       = 0;
  unsigned t_max_stores      = 0;
  unsigned t_max_readlock    = 0;
  unsigned t_max_writeunlock = 0;

  while( !done ) {
    if( !processNextRqst( t_max_loads, t_max_stores, t_max_readlock, t_max_writeunlock, t_max_ops ) ) {
      // error occurred
      output->fatal( CALL_INFO, -1, "Error: unable to process next remote memory request\n" );
    }
    if( t_max_ops == max_ops )
      done = true;
  }

  return false;
}

bool RevBasicRmtMemCtrl::isDone() {
  return requests.size() == 0;
}

bool RevBasicRmtMemCtrl::processNextRqst(
  unsigned& t_max_loads, unsigned& t_max_stores, unsigned& t_max_readlock, unsigned& t_max_writeunlock, unsigned& t_max_ops

) {
  if( rqstQ.size() == 0 ) {
    // nothing to do, saturate and exit this cycle
    t_max_ops = max_ops;
    return true;
  }

  bool success = false;

  // retrieve the next candidate remote memory operation
  for( unsigned i = 0; i < rqstQ.size(); i++ ) {
    RevRmtMemOp* op = rqstQ[i];
    if( isRmtMemOpAvailable( op, t_max_loads, t_max_stores, t_max_readlock, t_max_writeunlock ) ) {
      // op is good to execute, build a remote memory request packet
      t_max_ops++;

      if( op->getOp() == RmtMemOp::FENCE ) {
        // time to fence! Saturate and exit this cycle
        // no need to build a remote memory request
        // We only consider the fence is done when the xBGAS NIC queue does not contain messages
        t_max_ops = max_ops;
        if( xbgasNic->isQueueEmpty() ) {
          rqstQ.erase( rqstQ.begin() + i );
          num_fence++;
          delete op;
        }
        return true;
      }

      // build the remote memory request
      if( !buildRmtMemRqst( op, success ) ) {
        output->fatal( CALL_INFO, -1, "Error: unable to build remote memory request\n" );
        return false;
      }

      // sent the request, remove it
      if( success ) {
        rqstQ.erase( rqstQ.begin() + i );
      } else {
        // go ahead and max out our current request window
        // otherwise, this request for induce an infinite loop
        // we also leave the current (failed) request in the queue
        t_max_ops = max_ops;
      }
      return true;
    }
  }

  // if we reach this point, then we've attempted to process all the potential requests.
  // None exist that can be dispatched at this time.
  t_max_ops = max_ops;
  return true;
}

bool RevBasicRmtMemCtrl::isRmtMemOpAvailable(
  RevRmtMemOp* Op, unsigned& t_max_loads, unsigned& t_max_stores, unsigned& t_max_readlock, unsigned& t_max_writeunlock
) {
  switch( Op->getOp() ) {
  case RmtMemOp::READRqst:
  case RmtMemOp::BulkREADRqst:
  case RmtMemOp::AMORqst:
    if( t_max_loads < max_loads ) {
      t_max_loads++;
      return true;
    }
    return false;
    break;
  case RmtMemOp::READLOCKRqst:
    if( t_max_readlock < max_readlock ) {
      t_max_readlock++;
      return true;
    }
    return false;
    break;
  case RmtMemOp::WRITERqst:
  case RmtMemOp::BulkWRITERqst:
    if( t_max_stores < max_stores ) {
      t_max_stores++;
      return true;
    }
    return false;
    break;
  case RmtMemOp::WRITEUNLOCKRqst:
    if( t_max_writeunlock < max_writeunlock ) {
      t_max_writeunlock++;
      return true;
    }
    return false;
    break;
  case RmtMemOp::FENCE: return true; break;
  default:
    output->fatal( CALL_INFO, -1, "Error: unknown remote memory operation\n" );
    return false;
    break;
  }
  return false;
}

bool RevBasicRmtMemCtrl::buildRmtMemRqst( RevRmtMemOp* Op, bool& Success ) {
  uint32_t       SrcId      = (uint32_t) ( xbgasNic->getAddress() );
  uint64_t       Nmspace    = Op->getNmspace();
  uint32_t       DestId     = findDest( Nmspace );
  uint32_t       localId    = 0;
  uint8_t*       Buffer     = nullptr;
  xbgasNicEvent* RmtEvent   = nullptr;

  unsigned             Hart = Op->getHart();
  uint32_t             Id;  // Event ID is updated after the request is built
  uint64_t             SrcAddr  = Op->getSrcAddr();
  uint64_t             DestAddr = Op->getDestAddr();
  size_t               Size     = Op->getSize();
  uint32_t             Nelem    = Op->getNelem();
  RevFlag              Flags    = Op->getFlags();
  std::vector<uint8_t> tmpBuf   = Op->getBuf();

  switch( Op->getOp() ) {
  case RmtMemOp::READRqst:
    RmtEvent = new xbgasNicEvent( getName() );
    RmtEvent->setSrcId( SrcId );
    RmtEvent->buildREADRqst( SrcAddr, DestAddr, Size, Flags );
    Id = RmtEvent->getID();
    xbgasNic->send( RmtEvent, DestId );
    requests.push_back( Id );
    outstanding[Id] = Op;
    recordStat( RmtReadInFlight, 1 );
    num_read_rqst += 1;
#ifdef _XBGAS_DEBUG_
    std::cout << "_XBGAS_DEBUG_ : PE " << getPEID() << " Sending READ Rqst to PE " << DestId << " from PE " << SrcId
              << " with Event ID " << Id << std::endl;
#endif
    break;
  case RmtMemOp::BulkREADRqst:
    RmtEvent = new xbgasNicEvent( getName() );
    RmtEvent->setSrcId( SrcId );
    RmtEvent->buildBulkREADRqst( SrcAddr, DestAddr, Size, Nelem, Flags );
    Id = RmtEvent->getID();
    xbgasNic->send( RmtEvent, DestId );
    requests.push_back( Id );
    outstanding[Id] = Op;
    recordStat( RmtReadInFlight, 1 );
    num_read_rqst += 1;
#ifdef _XBGAS_DEBUG_
    std::cout << "_XBGAS_DEBUG_ : PE " << getPEID() << " Sending Bulk-READ Rqst to PE " << DestId << " from PE " << SrcId
              << " with Event ID " << Id << std::endl;
#endif
    break;
  case RmtMemOp::READLOCKRqst:
    RmtEvent = new xbgasNicEvent( getName() );
    RmtEvent->setSrcId( SrcId );
    RmtEvent->buildREADLOCKRqst( SrcAddr, Size, Flags );
    RmtEvent->setHart( Hart );
    Id = RmtEvent->getID();
    xbgasNic->send( RmtEvent, DestId );
    requests.push_back( Id );
    outstanding[Id] = Op;
    recordStat( RmtReadLockInFlight, 1 );
    num_read_lock_rqst += 1;
#ifdef _XBGAS_DEBUG_LR_SC_
    std::cout << "_XBGAS_DEBUG_ : PE " << getPEID() << " Sending READ-LOCK Rqst to PE " << DestId << " from PE " << SrcId
              << " with Event ID " << Id << std::endl;
#endif
    break;
  case RmtMemOp::WRITERqst:
    Buffer = new uint8_t[Size];
    for( unsigned i = 0; i < Size; ++i ) {
      Buffer[i] = tmpBuf[i];
    }
    RmtEvent = new xbgasNicEvent( getName() );
    RmtEvent->setSrcId( SrcId );
    RmtEvent->buildWRITERqst( DestAddr, Size, Flags, Buffer );
    Id = RmtEvent->getID();
    xbgasNic->send( RmtEvent, DestId );
    requests.push_back( Id );
    outstanding[Id] = Op;
    recordStat( RmtWriteInFlight, 1 );
    delete[] Buffer;
    num_write_rqst += 1;
#ifdef _XBGAS_DEBUG_
    std::cout << "_XBGAS_DEBUG_ : PE " << getPEID() << " Sending WRITE Rqst to PE " << DestId << " from PE " << SrcId
              << " with Event ID " << Id << std::endl;
#endif
    break;
  case RmtMemOp::BulkWRITERqst:
    // The bulk write request will be sent out once the data is read from the local memory
    localId = local_read_id++;
    Buffer  = new uint8_t[Size * Nelem];

    LocalLoadTrack.insert(
      { RmtOpIDHash( SrcId, localId ),
        LocalLoadRecord(
          Hart, Nmspace, localId, DestId, SrcAddr, DestAddr, Size, Nelem, Flags, Buffer, Op, RmtMemOp::BulkWRITERqst
        ) }
    );

    LocalLoadCount.insert( { RmtOpIDHash( SrcId, localId ), 0 } );

    for( unsigned i = 0; i < Nelem; i++ ) {
      MemReq LocalReq(
        SrcAddr + i * Size,            // Memory address
        SrcId,                         // Source ID
        localId,                       // Packet ID
        MemOp::MemOpREAD,              // Memory operation
        true,                          // Outstanding
        [this]( const MemReq& Req ) {  // Lambda function as a callback
          RevBasicRmtMemCtrl::MarkLocalLoadComplete( Req );
        }
      );
      Mem->ReadMem( virtualHart, SrcAddr + i * Size, Size, (void*) ( &Buffer[i * Size] ), std::move( LocalReq ), Flags );
    }

    // Decide if the Write request should be segmented
    num_write_rqst += 1;
    break;
  case RmtMemOp::WRITEUNLOCKRqst:
    Buffer = new uint8_t[Size];
    for( unsigned i = 0; i < Size; ++i ) {
      Buffer[i] = tmpBuf[i];
    }
    RmtEvent = new xbgasNicEvent( getName() );
    RmtEvent->setSrcId( SrcId );
    RmtEvent->buildWRITEUNLOCKRqst( DestAddr, Size, Flags, Buffer );
    RmtEvent->setHart( Hart );
    Id = RmtEvent->getID();
    xbgasNic->send( RmtEvent, DestId );
    requests.push_back( Id );
    outstanding[Id] = Op;
    recordStat( RmtWriteUnlockInFlight, 1 );
    delete[] Buffer;
    num_write_unlock_rqst += 1;
#ifdef _XBGAS_DEBUG_LR_SC_
    std::cout << "_XBGAS_DEBUG_ : PE " << getPEID() << " Sending WRITE-UNLOCK Rqst to PE " << DestId << " from PE " << SrcId
              << " with Event ID " << Id << std::endl;
#endif
    break;
  case RmtMemOp::AMORqst:
    Buffer = new uint8_t[Size];
    for( unsigned i = 0; i < Size; ++i ) {
      Buffer[i] = tmpBuf[i];
    }
    RmtEvent = new xbgasNicEvent( getName() );
    RmtEvent->setSrcId( SrcId );
    RmtEvent->buildAMORqst( SrcAddr, Size, Flags, Buffer );
    Id = RmtEvent->getID();
    xbgasNic->send( RmtEvent, DestId );
    requests.push_back( Id );
    outstanding[Id] = Op;
    recordStat( RmtAMOInFlight, 1 );
    num_amo_rqst += 1;
    delete[] Buffer;
    break;
  default: return false; break;
  }
  Success = true;
  return true;
}

bool RevBasicRmtMemCtrl::checkRangeOverlap( const std::vector<std::pair<uint64_t, size_t>>& RmtLRSC, uint64_t Addr, size_t Size ) {
  if( RmtLRSC.empty() || Size == 0 ) {
    return false;
  }
  // Calculate end address
  uint64_t EndAddr    = Addr + Size;
  bool     hasOverlap = std::any_of( RmtLRSC.begin(), RmtLRSC.end(), [Addr, EndAddr]( const auto& range ) {
    uint64_t endAddr = range.first + range.second;
    return Addr < endAddr && EndAddr > range.first;
  } );
  return hasOverlap;
}

uint32_t RevBasicRmtMemCtrl::findDest( uint64_t Nmspace ) {
  auto it = nmspaceLB.find( Nmspace );
  if( it == nmspaceLB.end() )
    return -1;
  else
    return it->second;
}

}  // namespace SST::RevCPU

// EOF
