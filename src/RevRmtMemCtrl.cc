//
// _RevRmtMemCtrl_h_
//
// Copyright (C) 2017-2024 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#include "RevInstTable.h"
#include "RevRmtMemCtrl.h"

namespace SST::RevCPU {

// ----------------------------------------
// RevRmtMemOp
// ----------------------------------------
RevRmtMemOp::RevRmtMemOp( unsigned Hart, uint64_t Nmspace, uint64_t SrcAddr, size_t Size, RmtMemOp Op, RevFlag Flags )
  : Hart( Hart ), Nmspace( Nmspace ), SrcAddr( SrcAddr ), Size( Size ), Op( Op ), Flags( Flags ) {}

RevRmtMemOp::RevRmtMemOp( unsigned Hart, uint64_t Nmspace, uint64_t SrcAddr, size_t Size, void* Target, RmtMemOp Op, RevFlag Flags )
  : Hart( Hart ), Nmspace( Nmspace ), SrcAddr( SrcAddr ), Size( Size ), Nelem( 1 ), Stride( Size ), Op( Op ), Flags( Flags ),
    Target( Target ) {}

RevRmtMemOp::RevRmtMemOp(
  unsigned Hart,
  uint64_t Nmspace,
  uint64_t DestAddr,
  size_t   Size,
  uint32_t Nelem,
  uint32_t Stride,
  uint8_t* Buffer,
  RmtMemOp Op,
  RevFlag  Flags
)
  : Hart( Hart ), Nmspace( Nmspace ), DestAddr( DestAddr ), Size( Size ), Nelem( Nelem ), Stride( Stride ), Op( Op ),
    Flags( Flags ) {
  for( uint32_t i = 0; i < Size * Nelem; ++i ) {
    Membuf.push_back( Buffer[i] );
  }
}

RevRmtMemOp::RevRmtMemOp(
  unsigned Hart,
  uint64_t Nmspace,
  uint64_t SrcAddr,
  size_t   Size,
  uint32_t Nelem,
  uint32_t Stride,
  uint64_t DestAddr,
  RmtMemOp Op,
  RevFlag  Flags
)
  : Hart( Hart ), Nmspace( Nmspace ), SrcAddr( SrcAddr ), DestAddr( DestAddr ), Size( Size ), Nelem( Nelem ), Stride( Stride ),
    Op( Op ), Flags( Flags ) {}

RevRmtMemOp::RevRmtMemOp(
  unsigned Hart, uint64_t Nmspace, uint64_t SrcAddr, size_t Size, void* Target, RmtMemOp Op, RevFlag Flags, uint8_t Aq, uint8_t Rl
)
  : Hart( Hart ), Nmspace( Nmspace ), SrcAddr( SrcAddr ), Size( Size ), Nelem( 1 ), Stride( Size ), Op( Op ), Flags( Flags ),
    Aq( Aq ), Rl( Rl ), Target( Target ) {}

RevRmtMemOp::RevRmtMemOp(
  unsigned Hart,
  uint64_t Nmspace,
  uint64_t DestAddr,
  size_t   Size,
  void*    Target,
  uint8_t* Buffer,
  RmtMemOp Op,
  RevFlag  Flags,
  uint8_t  Aq,
  uint8_t  Rl
)
  : Hart( Hart ), Nmspace( Nmspace ), DestAddr( DestAddr ), Size( Size ), Nelem( 1 ), Stride( Size ), Op( Op ), Flags( Flags ),
    Aq( Aq ), Rl( Rl ), Target( Target ) {
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

  virtualHart = params.find<uint16_t>( "numHarts", "1" );
  max_loads   = params.find<uint32_t>( "max_loads", 64 );
  max_stores  = params.find<uint32_t>( "max_stores", 64 );
  max_ops     = params.find<uint32_t>( "ops_per_cycle", 2 );

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
  for( auto* stat : {
         "RmtReadInFlight",
         "RmtReadPending",
         "RmtReadBytes",
         "RmtWriteInFlight",
         "RmtWritePending",
         "RmtWritesBytes",
       } ) {
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
  uint8_t  Aq        = ev->getAq();
  uint8_t  Rl        = ev->getRl();
  uint64_t RmtHartId = HartHash( virtualHart, Hart, SrcId );
  RmtMemOp ReqPurp;
  MemOp    LocalMemOp;
  bool     rtn;

#ifdef XBGAS_DEBUG
  std::cout << "XBGAS_DEBUG : PE " << getPEID() << " handle Read Rqst, ";
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
    LocalMemOp = MemOp::MemOpAMO;
    break;
  default:
    ReqPurp    = RmtMemOp::READResp;
    LocalMemOp = MemOp::MemOpAMO;
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
    } else if( LocalMemOp == MemOp::MemOpAMO ) {
      // Send the load-reserve operation.
      rtn = Mem->LRBase( RmtHartId, SrcAddr + i * Stride, Size, (void*) ( &Buffer[i * Size] ), Aq, Rl, std::move( Req ), Flags );
      // If rtn is false, then the load-reserve operation failed.
      // The buffer has been filled with 0x01ul by Mem->LRBase. Generate a response immediately.
      if( rtn == false ) {
        xbgasNicEvent* RmtEvent = new xbgasNicEvent( getName() );
        RmtEvent->buildREADLOCKResp( Id, Size, Buffer );
        xbgasNic->send( RmtEvent, SrcId );
        LocalLoadTrack.erase( RmtOpIDHash( SrcId, Id ) );
        LocalLoadCount.erase( RmtOpIDHash( SrcId, Id ) );
        LocalLoadOpMap.erase( SrcAddr + i * Stride );
      } else {
        // Do nothing. The response will be generated by the callback function.
      }
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
  uint8_t  Aq        = ev->getAq();
  uint8_t  Rl        = ev->getRl();
  uint64_t RmtHartId = HartHash( virtualHart, Hart, SrcId );

  uint8_t* Buffer    = new uint8_t[Size * Nelem];
  uint8_t* TmpTarget = new uint8_t[Size];

  // Copy the data to the buffer
  ev->getData( Buffer );

  xbgasNicEvent* RmtEvent = new xbgasNicEvent( getName() );

  if( Opcode == RmtMemOp::WRITEUNLOCKRqst ) {
    Mem->SCBase( RmtHartId, DestAddr, Size, (void*) ( Buffer ), (void*) ( TmpTarget ), Aq, Rl, Flags );
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

void RevBasicRmtMemCtrl::handleReadResp( xbgasNicEvent* ev ) {
  RmtMemOp Opcode = ev->getOp();
  uint32_t Id     = ev->getID();

#ifdef XBGAS_DEBUG
  std::cout << "XBGAS_DEBUG : PE " << getPEID() << " handle Read Resp, "
            << "Event ID: " << ev->getID() << ", SrcId: " << ev->getSrcId() << ", SrcAddr: 0x" << std::hex << ev->getSrcAddr()
            << ", DestAddr: 0x" << std::hex << ev->getDestAddr() << ", Size: " << ev->getSize() << ", Nelem: " << ev->getNelem()
            << ", Stride: " << ev->getStride() << std::endl;
#endif

  if( std::find( requests.begin(), requests.end(), Id ) != requests.end() ) {
    requests.erase( std::find( requests.begin(), requests.end(), Id ) );
    if( ( Opcode == RmtMemOp::READResp ) || ( Opcode == RmtMemOp::READLOCKResp ) ) {
      RevRmtMemOp*     Op     = outstanding[Id];
      const RmtMemReq& r      = Op->getRmtMemReq();
      uint8_t*         Target = static_cast<uint8_t*>( Op->getTarget() );
      ev->getData( Target );    // Copy the data to the target register
      r.MarkRmtLoadComplete();  // Mark the remote load complete
    } else if( Opcode == RmtMemOp::BulkREADResp ) {
      uint64_t DestAddr = ev->getDestAddr();
      size_t   Size     = ev->getSize();
      uint32_t Nelem    = ev->getNelem();
      uint32_t Stride   = ev->getStride();
      RevFlag  Flags    = ev->getFlags();

      uint8_t* Buffer   = new uint8_t[Size * Nelem];
      ev->getData( Buffer );

      for( uint32_t i = 0; i < Nelem; i++ ) {
        Mem->WriteMem( virtualHart, DestAddr + i * Stride, Size, (void*) ( &Buffer[i * Size] ), Flags );
      }
      delete[] Buffer;
    } else {
      output->fatal( CALL_INFO, -1, "Error: unknown remote memory response\n" );
    }
    outstanding.erase( Id );
    delete ev;
  } else {
    output->fatal( CALL_INFO, -1, "Error: found unknown ReadResp\n" );
  }
  num_read--;
  return;
}

void RevBasicRmtMemCtrl::handleWriteResp( xbgasNicEvent* ev ) {
  RmtMemOp Opcode = ev->getOp();
  uint32_t Id     = ev->getID();
#ifdef XBGAS_DEBUG
  std::cout << "XBGAS_DEBUG : PE " << getPEID() << " handle Write Resp, "
            << "Event ID: " << ev->getID() << ", SrcId: " << ev->getSrcId() << ", SrcAddr: 0x" << std::hex << ev->getSrcAddr()
            << ", DestAddr: 0x" << std::hex << ev->getDestAddr() << ", Size: " << ev->getSize() << ", Nelem: " << ev->getNelem()
            << ", Stride: " << ev->getStride() << std::endl;
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
    } else {
      // Do nothing
    }
    outstanding.erase( Id );
    delete ev;
  } else {
    output->fatal( CALL_INFO, -1, "Error: found unknown WriteResp\n" );
  }
  num_write--;
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
      break;
    case RmtMemOp::BulkWRITERqst:
      Op = new RevRmtMemOp( Hart, Nmspace, DestAddr, Size, Nelem, Stride, Buffer, RmtMemOp::BulkWRITERqst, Flags );
      // Remote memory operations are not cached
      // RevFlag TmpFlags = Op->getNonCacheFlags();
      // Op->setFlags( TmpFlags );
      rqstQ.push_back( Op );
      recordStat( RevBasicRmtMemCtrl::RmtMemCtrlStats::RmtWritePending, 1 );
      break;
    default:
      // Send the write request to the local memory
      for( uint32_t i = 0; i < Nelem; i++ ) {
        Mem->WriteMem( virtualHart, DestAddr + i * Stride, Size, (void*) ( &Buffer[i * Size] ), Flags );
      }
      break;
    }
    // Remove Buffer and the entry from the local load track
    delete Buffer;
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

#ifdef XBGAS_DEBUG
  std::cout << "XBGAS_DEBUG : Namespace Lookaside Buffer of PE " << myPEid << ":" << std::endl;
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
  RevRmtMemOp* Op = new RevRmtMemOp( Hart, Nmspace, SrcAddr, Size, Target, RmtMemOp::READRqst, Flags );
  // To be decided if Remote memory operations need to be not cached
  // RevFlag TmpFlags = Op->getNonCacheFlags();
  // Op->setFlags( TmpFlags );
  Op->setRmtMemReq( Req );
  rqstQ.push_back( Op );
  recordStat( RevBasicRmtMemCtrl::RmtMemCtrlStats::RmtReadPending, 1 );
  return true;
}

bool RevBasicRmtMemCtrl::sendRmtReadLockRqst(
  unsigned         Hart,
  uint64_t         Nmspace,
  uint64_t         SrcAddr,
  size_t           Size,
  void*            Target,
  const RmtMemReq& Req,
  RevFlag          Flags,
  uint8_t          Aq,
  uint8_t          Rl
) {
  if( Size == 0 )
    return true;
  RevRmtMemOp* Op = new RevRmtMemOp( Hart, Nmspace, SrcAddr, Size, Target, RmtMemOp::READLOCKRqst, Flags, Aq, Rl );
  // To be decided if Remote memory operations need to be not cached
  // RevFlag TmpFlags = Op->getNonCacheFlags();
  // Op->setFlags( TmpFlags );
  Op->setRmtMemReq( Req );
  rqstQ.push_back( Op );
  recordStat( RevBasicRmtMemCtrl::RmtMemCtrlStats::RmtReadPending, 1 );
  return true;
}

bool RevBasicRmtMemCtrl::sendRmtWriteUnLockRqst(
  unsigned         Hart,
  uint64_t         Nmspace,
  uint64_t         DestAddr,
  size_t           Size,
  uint8_t*         Buffer,
  void*            Target,
  const RmtMemReq& Req,
  RevFlag          Flags,
  uint8_t          Aq,
  uint8_t          Rl
) {
  if( Size == 0 )
    return true;
  RevRmtMemOp* Op = new RevRmtMemOp( Hart, Nmspace, DestAddr, Size, Target, Buffer, RmtMemOp::WRITEUNLOCKRqst, Flags, Aq, Rl );
  // To be decided if Remote memory operations need to be not cached
  // RevFlag TmpFlags = Op->getNonCacheFlags();
  // Op->setFlags(TmpFlags);
  Op->setRmtMemReq( Req );
  rqstQ.push_back( Op );
  recordStat( RevBasicRmtMemCtrl::RmtMemCtrlStats::RmtWritePending, 1 );
  return true;
}

bool RevBasicRmtMemCtrl::sendRmtBulkReadRqst(
  unsigned Hart, uint64_t Nmspace, uint64_t SrcAddr, size_t Size, uint32_t Nelem, uint32_t Stride, uint64_t DestAddr, RevFlag Flags
) {
  if( Size == 0 )
    return true;
  RevRmtMemOp* Op = new RevRmtMemOp( Hart, Nmspace, SrcAddr, Size, Nelem, Stride, DestAddr, RmtMemOp::BulkREADRqst, Flags );
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
  uint32_t     Nelem  = 1;
  uint32_t     Stride = Size;
  RevRmtMemOp* Op     = new RevRmtMemOp( Hart, Nmspace, DestAddr, Size, Nelem, Stride, Buffer, RmtMemOp::WRITERqst, Flags );
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
  return true;
}

bool RevBasicRmtMemCtrl::sendFENCE( unsigned Hart ) {
  RevRmtMemOp* Op = new RevRmtMemOp( Hart, 0x00ull, 0x00ull, 0, RmtMemOp::FENCE, RevFlag::F_NONE );
  rqstQ.push_back( Op );
  recordStat( RevBasicRmtMemCtrl::RmtMemCtrlStats::RmtFencePending, 1 );
  return true;
}

bool RevBasicRmtMemCtrl::clockTick( Cycle_t cycle ) {
  // process the remote memory requests
  bool     done         = false;
  unsigned t_max_ops    = 0;
  unsigned t_max_loads  = 0;
  unsigned t_max_stores = 0;

  while( !done ) {
    if( !processNextRqst( t_max_loads, t_max_stores, t_max_ops ) ) {
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

bool RevBasicRmtMemCtrl::processNextRqst( unsigned& t_max_loads, unsigned& t_max_stores, unsigned& t_max_ops ) {
  if( rqstQ.size() == 0 ) {
    // nothing to do, saturate and exit this cycle
    t_max_ops = max_ops;
    return true;
  }

  bool success = false;
  // retrieve the next candidate remote memory operation
  for( unsigned i = 0; i < rqstQ.size(); i++ ) {
    RevRmtMemOp* op = rqstQ[i];
    if( isRmtMemOpAvailable( op, t_max_loads, t_max_stores ) ) {
      // op is good to execute, build a remote memory request packet
      t_max_ops++;

      if( op->getOp() == RmtMemOp::FENCE ) {
        // time to fence!
        // saturate and exit this cycle
        // no need to build a remote memory request
        t_max_ops = max_ops;
        rqstQ.erase( rqstQ.begin() + i );
        num_fence++;
        delete op;
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

bool RevBasicRmtMemCtrl::isRmtMemOpAvailable( RevRmtMemOp* Op, unsigned& t_max_loads, unsigned& t_max_stores ) {
  switch( Op->getOp() ) {
  case RmtMemOp::READRqst:
  case RmtMemOp::BulkREADRqst:
  case RmtMemOp::READLOCKRqst:
    if( t_max_loads < max_loads ) {
      t_max_loads++;
      return true;
    }
    break;
  case RmtMemOp::WRITERqst:
  case RmtMemOp::BulkWRITERqst:
  case RmtMemOp::WRITEUNLOCKRqst:
    if( t_max_stores < max_stores ) {
      t_max_stores++;
      return true;
    }
    break;
  case RmtMemOp::FENCE: return true; break;
  default: output->fatal( CALL_INFO, -1, "Error: unknown remote memory operation\n" ); break;
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
  uint8_t              Aq       = Op->getAq();
  uint8_t              Rl       = Op->getRl();

  switch( Op->getOp() ) {
  case RmtMemOp::READRqst:
  case RmtMemOp::BulkREADRqst:
    RmtEvent->buildREADRqst( SrcAddr, DestAddr, Size, Nelem, Stride, Flags );
    Id = RmtEvent->getID();
    xbgasNic->send( RmtEvent, DestId );
    requests.push_back( Id );
    outstanding[Id] = Op;
    recordStat( RmtReadInFlight, 1 );
    num_read++;
    break;
  case RmtMemOp::READLOCKRqst:
    RmtEvent->buildREADLOCKRqst( SrcAddr, Size, Flags, Aq, Rl );
    RmtEvent->setHart( Hart );
    Id = RmtEvent->getID();
    xbgasNic->send( RmtEvent, DestId );
    requests.push_back( Id );
    outstanding[Id] = Op;
    recordStat( RmtReadInFlight, 1 );
    num_read++;
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
    num_write++;
    delete[] Buffer;
    break;
  case RmtMemOp::WRITEUNLOCKRqst:
    Buffer = new uint8_t[Size];
    for( unsigned i = 0; i < Size; ++i ) {
      Buffer[i] = tmpBuf[i];
    }
    RmtEvent->buildWRITEUNLOCKRqst( DestAddr, Size, Flags, Buffer, Aq, Rl );
    RmtEvent->setHart( Hart );
    Id = RmtEvent->getID();
    xbgasNic->send( RmtEvent, DestId );
    requests.push_back( Id );
    outstanding[Id] = Op;
    recordStat( RmtWriteInFlight, 1 );
    num_write++;
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

std::string RevBasicRmtMemCtrl::rmtMemOpToString( RmtMemOp OpType ) {
  switch( OpType ) {
  case RmtMemOp::READRqst: return "READRqst";
  case RmtMemOp::BulkREADRqst: return "BulkREADRqst";
  case RmtMemOp::WRITERqst: return "WRITERqst";
  case RmtMemOp::BulkWRITERqst: return "BulkWRITERqst";
  case RmtMemOp::READResp: return "READResp";
  case RmtMemOp::BulkREADResp: return "BulkREADResp";
  case RmtMemOp::WRITEResp: return "WRITEResp";
  case RmtMemOp::BulkWRITEResp: return "BulkWRITEResp";
  case RmtMemOp::READLOCKRqst: return "READLOCKRqst";
  case RmtMemOp::FENCE: return "FENCE";
  default: return "Unknown";
  }
}

}  // namespace SST::RevCPU

// EOF
