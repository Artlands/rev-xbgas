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
    case RmtMemOp::Finish:           return os << "Finish";
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
  : Hart( Hart ), Nmspace( Nmspace ), SrcAddr( SrcAddr ), Size( Size ), Nelem( 1 ), Stride( Size ), Op( Op ), Flags( Flags ),
    Target( Target ) {}

RevRmtMemOp::RevRmtMemOp(
  unsigned Hart,
  uint64_t Nmspace,
  uint64_t SrcAddr,
  uint64_t DestAddr,
  size_t   Size,
  uint32_t Nelem,
  uint32_t Stride,
  RmtMemOp Op,
  RevFlag  Flags
)
  : Hart( Hart ), Nmspace( Nmspace ), SrcAddr( SrcAddr ), DestAddr( DestAddr ), Size( Size ), Nelem( Nelem ), Stride( Stride ),
    Op( Op ), Flags( Flags ) {}

RevRmtMemOp::RevRmtMemOp(
  unsigned Hart, uint64_t Nmspace, uint64_t DestAddr, size_t Size, RmtMemOp Op, RevFlag Flags, uint8_t* Buffer
)
  : Hart( Hart ), Nmspace( Nmspace ), DestAddr( DestAddr ), Size( Size ), Nelem( 1 ), Stride( Size ), Op( Op ), Flags( Flags ) {
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
  uint32_t Stride,
  RmtMemOp Op,
  RevFlag  Flags,
  uint8_t* Buffer
)
  : Hart( Hart ), Nmspace( Nmspace ), DestAddr( DestAddr ), Size( Size ), Nelem( Nelem ), Stride( Stride ), Op( Op ),
    Flags( Flags ) {
  for( uint32_t i = 0; i < Size * Nelem; ++i ) {
    Membuf.push_back( Buffer[i] );
  }
}

RevRmtMemOp::RevRmtMemOp(
  unsigned Hart, uint64_t Nmspace, uint64_t Addr, size_t Size, RmtMemOp Op, RevFlag Flags, void* Target, uint8_t* Buffer
)
  : Hart( Hart ), Nmspace( Nmspace ), SrcAddr( Addr ), DestAddr( Addr ), Size( Size ), Nelem( 1 ), Stride( Size ), Op( Op ),
    Flags( Flags ), Target( Target ) {
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
  case RmtMemOp::READRqst:
  case RmtMemOp::BulkREADRqst:
  case RmtMemOp::READLOCKRqst: handleReadRqst( event ); break;
  case RmtMemOp::WRITERqst:
  case RmtMemOp::BulkWRITERqst:
  case RmtMemOp::WRITEUNLOCKRqst: handleWriteRqst( event ); break;
  case RmtMemOp::READResp:
  case RmtMemOp::BulkREADResp:
  case RmtMemOp::READLOCKResp: handleReadResp( event ); break;
  case RmtMemOp::WRITEResp:
  case RmtMemOp::BulkWRITEResp:
  case RmtMemOp::WRITEUNLOCKResp: handleWriteResp( event ); break;
  case RmtMemOp::AMORqst: handleAMORqst( event ); break;
  case RmtMemOp::AMOResp: handleAMOResp( event ); break;
  // case RmtMemOp::Finish:
  //   handleFinish( event );
  //   break;
  default: output->fatal( CALL_INFO, -1, "Error : unknown remote memory operation type\n" ); break;
  }
}

void RevBasicRmtMemCtrl::handleReadRqst( xbgasNicEvent* ev ) {
  unsigned Hart      = ev->getHart();
  uint32_t Id        = ev->getID();
  uint32_t SrcId     = ev->getSrcId();
  uint64_t SrcAddr   = ev->getSrcAddr();
  uint64_t DestAddr  = ev->getDestAddr();
  size_t   Size      = ev->getSize();
  uint32_t Nelem     = ev->getNelem();
  uint32_t Stride    = ev->getStride();
  RmtMemOp Opcode    = ev->getOp();
  RevFlag  Flags     = ev->getFlags();
  uint64_t RmtHartId = HartHash( virtualHart, Hart, SrcId );
  RmtMemOp ReqPurp;
  MemOp    LocalMemOp;

#ifdef _XBGAS_DEBUG_
  std::cout << "_XBGAS_DEBUG_ : PE " << getPEID() << " handle Read Rqst, ";
  std::cout << "Event ID: " << Id << ", SrcId: " << SrcId << ", SrcAddr: 0x" << std::hex << SrcAddr << ", DestAddr: 0x" << std::hex
            << DestAddr << ", Size: " << Size << ", Nelem: " << Nelem << ", Stride: " << Stride << std::endl;
#endif

  switch( Opcode ) {
  case RmtMemOp::READRqst:
    ReqPurp    = RmtMemOp::READResp;
    LocalMemOp = MemOp::MemOpREAD;
    break;
  case RmtMemOp::BulkREADRqst:
    ReqPurp    = RmtMemOp::BulkREADResp;
    LocalMemOp = MemOp::MemOpREAD;
    break;
  case RmtMemOp::READLOCKRqst:
    ReqPurp    = RmtMemOp::READLOCKResp;
    LocalMemOp = MemOp::MemOpREADLOCK;
    break;
  default:
    ReqPurp    = RmtMemOp::READResp;
    LocalMemOp = MemOp::MemOpREAD;
    break;
  }

  uint8_t* Buffer = new uint8_t[Size * Nelem];

  LocalLoadTrack.insert(
    { RmtOpIDHash( SrcId, Id ),
      LocalLoadRecord( virtualHart, 0, Id, SrcId, SrcAddr, DestAddr, Size, Nelem, Stride, Flags, Buffer, ReqPurp ) }
  );

  LocalLoadCount.insert( { RmtOpIDHash( SrcId, Id ), 0 } );

  for( uint32_t i = 0; i < Nelem; i++ ) {
    MemReq Req(
      SrcAddr + i * Stride,          // Memory address
      0,                             // Destination register (ignored)
      RevRegClass::RegUNKNOWN,       // Register class (ignored)
      virtualHart,                   // Virtual Hart ID
      LocalMemOp,                    // Memory operation
      true,                          // Outstanding
      [this]( const MemReq& Req ) {  // Lambda function as a callback
        RevBasicRmtMemCtrl::MarkLocalLoadComplete( Req );
      }
    );
    LocalLoadOpMap.insert( { SrcAddr + i * Stride, RmtOpIDHash( SrcId, Id ) } );
    if( LocalMemOp == MemOp::MemOpREAD ) {
      // Send the request to the local memory
      Mem->ReadMem( virtualHart, SrcAddr + i * Stride, Size, (void*) ( &Buffer[i * Size] ), std::move( Req ), Flags );
    } else if( LocalMemOp == MemOp::MemOpREADLOCK ) {
      // Send the load-reserve operation.
      Mem->LR( RmtHartId, SrcAddr, Size, (void*) ( &Buffer[0] ), std::move( Req ), Flags );
    }
  }
}

void RevBasicRmtMemCtrl::handleWriteRqst( xbgasNicEvent* ev ) {
  unsigned Hart      = ev->getHart();
  uint32_t Id        = ev->getID();
  uint32_t SrcId     = ev->getSrcId();
  uint64_t DestAddr  = ev->getDestAddr();
  size_t   Size      = ev->getSize();
  uint32_t Nelem     = ev->getNelem();
  uint32_t Stride    = ev->getStride();
  RmtMemOp Opcode    = ev->getOp();
  RevFlag  Flags     = ev->getFlags();
  uint64_t RmtHartId = HartHash( virtualHart, Hart, SrcId );
  bool     rtn;

  uint8_t* Buffer    = new uint8_t[Size * Nelem];
  uint8_t* TmpTarget = new uint8_t[Size];

#ifdef _XBGAS_DEBUG_
  std::cout << "_XBGAS_DEBUG_ : PE " << getPEID() << " handle write Rqst, ";
  std::cout << "Event ID: " << Id << ", SrcId: " << SrcId << ", DestAddr: 0x" << std::hex << DestAddr << ", Size: " << Size
            << ", Nelem: " << Nelem << ", Stride: " << Stride << std::endl;
#endif

  // Copy the data to the buffer
  ev->getData( Buffer );

  xbgasNicEvent* RmtEvent = new xbgasNicEvent( getName() );

  if( Opcode == RmtMemOp::WRITEUNLOCKRqst ) {
    rtn          = Mem->SC( RmtHartId, DestAddr, Size, (void*) ( Buffer ), Flags );
    // Update TmpTarget with 0 if rtn is true, 1 if rtn is false.
    TmpTarget[0] = !rtn;
    RmtEvent->buildWRITEUNLOCKResp( Id, Size, TmpTarget );
  } else {
    for( uint32_t i = 0; i < Nelem; i++ ) {
      Mem->WriteMem( virtualHart, DestAddr + i * Stride, Size, (void*) ( &Buffer[i * Size] ), Flags );
    }
    RmtEvent->buildWRITEResp( Id );
  }
  xbgasNic->send( RmtEvent, SrcId );
  delete[] Buffer;
  delete[] TmpTarget;
}

void RevBasicRmtMemCtrl::handleAMORqst( xbgasNicEvent* ev ) {
  unsigned Hart      = ev->getHart();
  uint32_t Id        = ev->getID();
  uint32_t SrcId     = ev->getSrcId();
  uint64_t SrcAddr   = ev->getSrcAddr();
  size_t   Size      = ev->getSize();
  RevFlag  Flags     = ev->getFlags();
  uint64_t RmtHartId = HartHash( virtualHart, Hart, SrcId );
  RmtMemOp ReqPurp   = RmtMemOp::AMOResp;

  uint8_t* Buffer    = new uint8_t[Size];
  uint8_t* TmpTarget = new uint8_t[Size];

  // Copy the data to the buffer
  ev->getData( Buffer );

  LocalLoadTrack.insert(
    { RmtOpIDHash( SrcId, Id ), LocalLoadRecord( virtualHart, 0, Id, SrcId, SrcAddr, 0, Size, 1, Size, Flags, TmpTarget, ReqPurp ) }
  );

  LocalLoadCount.insert( { RmtOpIDHash( SrcId, Id ), 0 } );

  MemReq Req(
    SrcAddr,
    0,
    RevRegClass::RegUNKNOWN,
    RmtHartId,
    MemOp::MemOpAMO,
    true,
    [this]( const MemReq& Req ) {  // Lambda function as a callback
      RevBasicRmtMemCtrl::MarkLocalLoadComplete( Req );
    }
  );

  LocalLoadOpMap.insert( { SrcAddr, RmtOpIDHash( SrcId, Id ) } );

  Mem->AMOMem( RmtHartId, SrcAddr, Size, (void*) ( Buffer ), (void*) ( TmpTarget ), Req, Flags );
}

void RevBasicRmtMemCtrl::handleReadResp( xbgasNicEvent* ev ) {
  uint32_t Id = ev->getID();

  if( std::find( requests.begin(), requests.end(), Id ) != requests.end() ) {
    RevRmtMemOp* Op = outstanding[Id];
    if( !Op )
      output->fatal( CALL_INFO, -1, "RevRmtMemOp is null in handleReadResp\n" );
    RmtMemOp Opcode = ev->getOp();
    requests.erase( std::find( requests.begin(), requests.end(), Id ) );
    if( ( Opcode == RmtMemOp::READResp ) || ( Opcode == RmtMemOp::READLOCKResp ) ) {
      const RmtMemReq& r      = Op->getRmtMemReq();
      uint8_t*         Target = static_cast<uint8_t*>( Op->getTarget() );
      ev->getData( Target );    // Copy the data to the target register
      r.MarkRmtLoadComplete();  // Mark the remote load complete
    } else if( Opcode == RmtMemOp::BulkREADResp ) {

      uint64_t DestAddr = Op->getDestAddr();
      size_t   Size     = Op->getSize();
      uint32_t Nelem    = Op->getNelem();
      uint32_t Stride   = Op->getStride();
      RevFlag  Flags    = Op->getFlags();
      uint8_t* Buffer   = new uint8_t[Size * Nelem];
      ev->getData( Buffer );

      for( uint32_t i = 0; i < Nelem; i++ ) {
        Mem->WriteMem( virtualHart, DestAddr + i * Stride, Size, (void*) ( &Buffer[i * Size] ), Flags );
      }
      // Update the memory-mapped flag/CSR to indicate the remote memory bulk read operation is complete
      Mem->SetBulkCompleted( true );
      delete[] Buffer;
    } else {
      output->fatal( CALL_INFO, -1, "Error: unknown remote memory response\n" );
    }
    outstanding.erase( Id );
    // Update the stats
    if( ( Opcode == RmtMemOp::READResp ) || ( Opcode == RmtMemOp::BulkREADResp ) )
      num_read--;
    else if( Opcode == RmtMemOp::READLOCKResp )
      num_readlock--;
  } else {
    output->fatal( CALL_INFO, -1, "Error: found unknown ReadResp\n" );
  }
  delete ev;
  return;
}

void RevBasicRmtMemCtrl::handleWriteResp( xbgasNicEvent* ev ) {
  RmtMemOp Opcode = ev->getOp();
  uint32_t Id     = ev->getID();

#ifdef _XBGAS_DEBUG_
  std::cout << "_XBGAS_DEBUG_ : PE " << getPEID() << " handle Write Resp, "
            << "Event ID: " << ev->getID() << ", SrcId: " << ev->getSrcId() << ", Size: " << ev->getSize()
            << ", Nelem: " << ev->getNelem() << ", Stride: " << ev->getStride() << std::endl;
#endif

  if( std::find( requests.begin(), requests.end(), Id ) != requests.end() ) {
    requests.erase( std::find( requests.begin(), requests.end(), Id ) );
    RevRmtMemOp* Op = outstanding[Id];
    if( !Op )
      output->fatal( CALL_INFO, -1, "RevRmtMemOp is null in handleWriteResp\n" );
    if( Opcode == RmtMemOp::WRITEUNLOCKResp ) {
      // Update the target register
      const RmtMemReq& r      = Op->getRmtMemReq();
      uint8_t*         Target = static_cast<uint8_t*>( Op->getTarget() );
      ev->getData( Target );    // Copy the data to the target register
      r.MarkRmtLoadComplete();  // Mark the remote load complete
      num_writeunlock--;
    } else {
      num_write--;
    }
    outstanding.erase( Id );
  } else {
    output->fatal( CALL_INFO, -1, "Error: found unknown WriteResp\n" );
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
      ev->getData( Target );    // Copy the data to the target register
      r.MarkRmtLoadComplete();  // Mark the remote load complete
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
  auto     it       = LocalLoadOpMap.find( Req.Addr );
  uint64_t hashedId = it->second;

  if( LocalLoadCount.find( hashedId ) != LocalLoadCount.end() ) {
    LocalLoadCount[hashedId]++;
  } else {
    output->fatal( CALL_INFO, -1, "Error: unable to find the load count entry\n" );
  }

  auto           Record   = LocalLoadTrack.find( hashedId )->second;
  unsigned       Hart     = Record.Hart;
  uint64_t       Nmspace  = Record.Nmspace;
  uint32_t       Id       = Record.Id;
  uint32_t       SrcId    = Record.SrcId;
  uint64_t       DestAddr = Record.DestAddr;
  size_t         Size     = Record.Size;
  uint32_t       Nelem    = Record.Nelem;
  uint32_t       Stride   = Record.Stride;
  RevFlag        Flags    = Record.Flags;
  uint8_t*       Buffer   = Record.Buffer;
  RmtMemOp       ReqPurp  = Record.ReqPurp;
  xbgasNicEvent* RmtEvent;
  RevRmtMemOp*   Op;

  // Check if all the elements have been loaded
  if( LocalLoadCount[hashedId] == Nelem ) {
    switch( ReqPurp ) {
    case RmtMemOp::READResp:
    case RmtMemOp::BulkREADResp:
      RmtEvent = new xbgasNicEvent( getName() );
      RmtEvent->buildREADResp( Id, DestAddr, Size, Nelem, Stride, Buffer );
      // Destination is the source of the request
      xbgasNic->send( RmtEvent, SrcId );
      break;
    case RmtMemOp::READLOCKResp:
      RmtEvent = new xbgasNicEvent( getName() );
      RmtEvent->buildREADLOCKResp( Id, Size, Buffer );
      xbgasNic->send( RmtEvent, SrcId );
#ifdef _XBGAS_DEBUG_
      std::cout << "_XBGAS_DEBUG_ : PE " << getPEID() << " LRBase succeeded, generate a response"
                << " SrcId: " << SrcId << " Id: " << Id << " Size: " << Size << std::endl;
#endif
      break;
    case RmtMemOp::BulkWRITERqst:
      Op = new RevRmtMemOp( Hart, Nmspace, DestAddr, Size, Nelem, Stride, RmtMemOp::BulkWRITERqst, Flags, Buffer );
      // Remote memory operations are not cached
      // RevFlag TmpFlags = Op->getNonCacheFlags();
      // Op->setFlags( TmpFlags );
      rqstQ.push_back( Op );
      recordStat( RevBasicRmtMemCtrl::RmtMemCtrlStats::RmtWritePending, 1 );
      break;
    case RmtMemOp::AMOResp:
      RmtEvent = new xbgasNicEvent( getName() );
      RmtEvent->buildAMOResp( Id, Size, Buffer );
      xbgasNic->send( RmtEvent, SrcId );
      break;
    default: break;
    }
    // Remove Buffer and the entry from the local load track
    delete[] Buffer;
    LocalLoadTrack.erase( hashedId );
    LocalLoadCount.erase( hashedId );
  }
  LocalLoadOpMap.erase( it );
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
  // To be decided if Remote memory operations need to be not cached
  // RevFlag TmpFlags = Op->getNonCacheFlags();
  // Op->setFlags( TmpFlags );
  Op->setRmtMemReq( Req );
  rqstQ.push_back( Op );
  recordStat( RevBasicRmtMemCtrl::RmtMemCtrlStats::RmtReadPending, 1 );
  return true;
}

bool RevBasicRmtMemCtrl::sendRmtReadLockRqst(
  unsigned Hart, uint64_t Nmspace, uint64_t SrcAddr, size_t Size, void* Target, const RmtMemReq& Req, RevFlag Flags
) {
  if( Size == 0 )
    return true;
  RevRmtMemOp* Op = new RevRmtMemOp( Hart, Nmspace, SrcAddr, Size, RmtMemOp::READLOCKRqst, Flags, Target );
  // To be decided if Remote memory operations need to be not cached
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
  // To be decided if Remote memory operations need to be not cached
  // RevFlag TmpFlags = Op->getNonCacheFlags();
  // Op->setFlags(TmpFlags);
  Op->setRmtMemReq( Req );
  rqstQ.push_back( Op );
  recordStat( RevBasicRmtMemCtrl::RmtMemCtrlStats::RmtWriteUnlockPending, 1 );
  return true;
}

bool RevBasicRmtMemCtrl::sendRmtBulkReadRqst(
  unsigned Hart, uint64_t Nmspace, uint64_t SrcAddr, size_t Size, uint32_t Nelem, uint32_t Stride, uint64_t DestAddr, RevFlag Flags
) {
  if( Size == 0 )
    return true;
  Mem->SetBulkCompleted( false );
  RevRmtMemOp* Op = new RevRmtMemOp( Hart, Nmspace, SrcAddr, DestAddr, Size, Nelem, Stride, RmtMemOp::BulkREADRqst, Flags );
  // To be decided if Remote memory operations need to be not cached
  // RevFlag      TmpFlags = Op->getNonCacheFlags();
  // Op->setFlags( TmpFlags );
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
  // To be decided if Remote memory operations need to be not cached
  // RevFlag TmpFlags = Op->getNonCacheFlags();
  // Op->setFlags( TmpFlags );
  rqstQ.push_back( Op );
  recordStat( RevBasicRmtMemCtrl::RmtMemCtrlStats::RmtWritePending, 1 );
  return true;
}

bool RevBasicRmtMemCtrl::sendRmtBulkWriteRqst(
  unsigned Hart, uint64_t Nmspace, uint64_t DestAddr, size_t Size, uint32_t Nelem, uint32_t Stride, uint64_t SrcAddr, RevFlag Flags
) {
  if( Size == 0 )
    return true;

  // The bulk write request will be put into the rqstQ after the data is read from the local memory
  uint8_t* Buffer = new uint8_t[Size * Nelem];
  LocalLoadTrack.insert(
    { LocalReadHash( Nmspace, SrcAddr, Size, Nelem, Stride ),
      LocalLoadRecord( Hart, Nmspace, 0, 0, SrcAddr, DestAddr, Size, Nelem, Stride, Flags, Buffer, RmtMemOp::BulkWRITERqst ) }
  );

  LocalLoadCount.insert( { LocalReadHash( Nmspace, SrcAddr, Size, Nelem, Stride ), 0 } );
  for( uint32_t i = 0; i < Nelem; i++ ) {
    MemReq Req(
      SrcAddr + i * Stride,          // Memory address
      0,                             // Destination register (ignored)
      RevRegClass::RegUNKNOWN,       // Register class (ignored)
      virtualHart,                   // Virtual Hart ID
      MemOp::MemOpREAD,              // Memory operation
      true,                          // Outstanding
      [this]( const MemReq& Req ) {  // Lambda function as a callback
        RevBasicRmtMemCtrl::MarkLocalLoadComplete( Req );
      }
    );
    LocalLoadOpMap.insert( { SrcAddr + i * Stride, LocalReadHash( Nmspace, SrcAddr, Size, Nelem, Stride ) } );
    Mem->ReadMem( virtualHart, SrcAddr + i * Stride, Size, (void*) ( &Buffer[i * Size] ), std::move( Req ), Flags );
  }
  recordStat( RevBasicRmtMemCtrl::RmtMemCtrlStats::RmtWritePending, 1 );
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
    if( ( num_read + num_write + num_readlock + num_writeunlock ) != 0 ) {
      recordStat( RevBasicRmtMemCtrl::RmtMemCtrlStats::RmtFencePending, 1 );
      return false;
    } else {
      num_fence--;
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
        // time to fence!
        // saturate and exit this cycle
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
  uint32_t SrcId          = (uint32_t) ( xbgasNic->getAddress() );
  uint64_t Nmspace        = Op->getNmspace();
  uint32_t DestId         = findDest( Nmspace );
  uint8_t* Buffer         = nullptr;

  // Build the remote memory read request packet; remote memory write request
  // is built after the data is read from the local memory, which is implemented
  // in the callback function
  xbgasNicEvent* RmtEvent = new xbgasNicEvent( getName() );
  RmtEvent->setSrcId( SrcId );

  unsigned             Hart = Op->getHart();
  uint32_t             Id;  // Event ID is updated after the request is built
  uint64_t             SrcAddr  = Op->getSrcAddr();
  uint64_t             DestAddr = Op->getDestAddr();
  size_t               Size     = Op->getSize();
  uint32_t             Nelem    = Op->getNelem();
  uint32_t             Stride   = Op->getStride();
  RevFlag              Flags    = Op->getFlags();
  std::vector<uint8_t> tmpBuf   = Op->getBuf();

  switch( Op->getOp() ) {
  case RmtMemOp::READRqst:
  case RmtMemOp::BulkREADRqst:
    RmtEvent->buildREADRqst( SrcAddr, DestAddr, Size, Nelem, Stride, Flags );
    Id = RmtEvent->getID();
    xbgasNic->send( RmtEvent, DestId );
    requests.push_back( Id );
    outstanding[Id] = Op;
    recordStat( RmtReadInFlight, 1 );
    num_read += 1;
    break;
  case RmtMemOp::READLOCKRqst:
    RmtEvent->buildREADLOCKRqst( SrcAddr, Size, Flags );
    RmtEvent->setHart( Hart );
    Id = RmtEvent->getID();
#ifdef _XBGAS_DEBUG_
    std::cout << "_XBGAS_DEBUG_ : PE " << getPEID() << " Sending READLOCKRqst to PE " << DestId << " from PE " << SrcId
              << " with Event ID " << Id << std::endl;
#endif
    xbgasNic->send( RmtEvent, DestId );
    requests.push_back( Id );
    outstanding[Id] = Op;
    recordStat( RmtReadLockInFlight, 1 );
    num_readlock += 1;
    break;
  case RmtMemOp::WRITERqst:
  case RmtMemOp::BulkWRITERqst:
    Buffer = new uint8_t[Size * Nelem];
    for( unsigned i = 0; i < Size * Nelem; ++i ) {
      Buffer[i] = tmpBuf[i];
    }
    RmtEvent->buildWRITERqst( DestAddr, Size, Nelem, Stride, Flags, Buffer );
    Id = RmtEvent->getID();
    xbgasNic->send( RmtEvent, DestId );
    requests.push_back( Id );
    outstanding[Id] = Op;
    recordStat( RmtWriteInFlight, 1 );
    num_write += 1;
    delete[] Buffer;
    break;
  case RmtMemOp::WRITEUNLOCKRqst:
    Buffer = new uint8_t[Size];
    for( unsigned i = 0; i < Size; ++i ) {
      Buffer[i] = tmpBuf[i];
    }
    RmtEvent->buildWRITEUNLOCKRqst( DestAddr, Size, Flags, Buffer );
    RmtEvent->setHart( Hart );
    Id = RmtEvent->getID();
    xbgasNic->send( RmtEvent, DestId );
    requests.push_back( Id );
    outstanding[Id] = Op;
    recordStat( RmtWriteUnlockInFlight, 1 );
    num_writeunlock += 1;
    delete[] Buffer;
    break;
  case RmtMemOp::AMORqst:
    Buffer = new uint8_t[Size];
    for( unsigned i = 0; i < Size; ++i ) {
      Buffer[i] = tmpBuf[i];
    }
    RmtEvent->buildAMORqst( SrcAddr, Size, Buffer, Flags );
    Id = RmtEvent->getID();
    xbgasNic->send( RmtEvent, DestId );
    requests.push_back( Id );
    outstanding[Id] = Op;
    delete[] Buffer;
    break;
  default: return false; break;
  }
  Success = true;
  return true;
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
