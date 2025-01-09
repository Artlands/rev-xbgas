//
// _RevOpts_cc_
//
// Copyright (C) 2017-2025 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#include "RevOpts.h"

namespace SST::RevCPU {

RevOpts::RevOpts( uint32_t NumCores, uint32_t NumHarts, const int Verbosity )
  : numCores( NumCores ), numHarts( NumHarts ), verbosity( Verbosity ) {

  std::pair<uint32_t, uint32_t> InitialPair;
  InitialPair.first  = 0;
  InitialPair.second = 10;

  // init all the standard options
  // -- startAddr = 0x00000000
  // -- machine = "G" aka, "IMAFD"
  // -- pipeLine = 5
  // -- table = internal
  // -- memCosts[core] = 0:10
  // -- prefetch depth = 16
  for( uint32_t i = 0; i < numCores; i++ ) {
    startAddr.insert( std::pair<uint32_t, uint64_t>( i, 0 ) );
    machine.insert( std::pair<uint32_t, std::string>( i, "G" ) );
    table.insert( std::pair<uint32_t, std::string>( i, "_REV_INTERNAL_" ) );
    memCosts.push_back( InitialPair );
    prefetchDepth.insert( std::pair<uint32_t, uint32_t>( i, 16 ) );
  }
}

void RevOpts::SetArgs( const SST::Params& params ) {
  static constexpr char delim[] = " \t\n";

  // If the "args" param does not start with a left bracket, split it up at whitespace
  // Otherwise interpet it as an array
  std::string args              = params.find<std::string>( "args" );
  auto        nonspace          = args.find_first_not_of( delim );
  if( nonspace == args.npos || args[nonspace] != '[' ) {
    RevOpts::splitStr( args, delim, Argv );
  } else {
    params.find_array( "args", Argv );
  }
}

bool RevOpts::InitPrefetchDepth( const std::vector<std::string>& Depths ) {
  std::vector<std::string> vstr;
  for( uint32_t i = 0; i < Depths.size(); i++ ) {
    std::string s = Depths[i];
    splitStr( s, ":", vstr );
    if( vstr.size() != 2 )
      return false;

    uint32_t Core = std::stoul( vstr[0], nullptr, 0 );
    if( Core > numCores )
      return false;

    std::string::size_type sz          = 0;
    uint32_t               Depth       = std::stoul( vstr[1], &sz, 0 );

    prefetchDepth.find( Core )->second = Depth;
    vstr.clear();
  }
  return true;
}

bool RevOpts::InitStartAddrs( const std::vector<std::string>& StartAddrs ) {
  std::vector<std::string> vstr;

  // check to see if we expand into multiple cores
  if( StartAddrs.size() == 1 ) {
    std::string s = StartAddrs[0];
    splitStr( s, ":", vstr );
    if( vstr.size() != 2 )
      return false;

    if( vstr[0] == "CORES" ) {
      // set all cores to the target machine model
      std::string::size_type sz   = 0;
      uint64_t               Addr = std::stoull( vstr[1], &sz, 0 );
      for( uint32_t i = 0; i < numCores; i++ ) {
        startAddr.find( i )->second = Addr;
      }
      return true;
    }
  }

  for( uint32_t i = 0; i < StartAddrs.size(); i++ ) {
    std::string s = StartAddrs[i];
    splitStr( s, ":", vstr );
    if( vstr.size() != 2 )
      return false;

    uint32_t Core = std::stoul( vstr[0], nullptr, 0 );
    if( Core > numCores )
      return false;

    std::string::size_type sz      = 0;
    uint64_t               Addr    = std::stoull( vstr[1], &sz, 0 );

    startAddr.find( Core )->second = Addr;
    vstr.clear();
  }
  return true;
}

bool RevOpts::InitStartSymbols( const std::vector<std::string>& StartSymbols ) {
  std::vector<std::string> vstr;
  for( uint32_t i = 0; i < StartSymbols.size(); i++ ) {
    std::string s = StartSymbols[i];
    splitStr( s, ":", vstr );
    if( vstr.size() != 2 )
      return false;

    uint32_t Core = std::stoul( vstr[0], nullptr, 0 );
    if( Core > numCores )
      return false;

    startSym.insert( std::pair<uint32_t, std::string>( Core, vstr[1] ) );
    vstr.clear();
  }
  return true;
}

bool RevOpts::InitMachineModels( const std::vector<std::string>& Machines ) {
  std::vector<std::string> vstr;

  // check to see if we expand into multiple cores
  if( Machines.size() == 1 ) {
    std::string s = Machines[0];
    splitStr( s, ":", vstr );
    if( vstr.size() != 2 )
      return false;

    if( vstr[0] == "CORES" ) {
      // set all cores to the target machine model
      for( uint32_t i = 0; i < numCores; i++ ) {
        machine.at( i ) = vstr[1];
      }
      return true;
    }
  }

  // parse individual core configs
  for( uint32_t i = 0; i < Machines.size(); i++ ) {
    std::string s = Machines[i];
    splitStr( s, ":", vstr );
    if( vstr.size() != 2 )
      return false;

    uint32_t Core = std::stoul( vstr[0], nullptr, 0 );
    if( Core > numCores )
      return false;

    machine.at( Core ) = vstr[1];
    vstr.clear();
  }
  return true;
}

bool RevOpts::InitInstTables( const std::vector<std::string>& InstTables ) {
  std::vector<std::string> vstr;
  for( uint32_t i = 0; i < InstTables.size(); i++ ) {
    std::string s = InstTables[i];
    splitStr( s, ":", vstr );
    if( vstr.size() != 2 )
      return false;

    uint32_t Core = std::stoul( vstr[0], nullptr, 0 );
    if( Core > numCores )
      return false;

    table.at( Core ) = vstr[1];
    vstr.clear();
  }
  return true;
}

bool RevOpts::InitMemCosts( const std::vector<std::string>& MemCosts ) {
  std::vector<std::string> vstr;

  for( uint32_t i = 0; i < MemCosts.size(); i++ ) {
    std::string s = MemCosts[i];
    splitStr( s, ":", vstr );
    if( vstr.size() != 3 )
      return false;

    uint32_t Core         = std::stoul( vstr[0], nullptr, 0 );
    uint32_t Min          = std::stoul( vstr[1], nullptr, 0 );
    uint32_t Max          = std::stoul( vstr[2], nullptr, 0 );
    memCosts[Core].first  = Min;
    memCosts[Core].second = Max;
    if( ( Min == 0 ) || ( Max == 0 ) ) {
      return false;
    }
    vstr.clear();
  }

  return true;
}

bool RevOpts::GetPrefetchDepth( uint32_t Core, uint32_t& Depth ) {
  if( Core > numCores )
    return false;

  if( prefetchDepth.find( Core ) == prefetchDepth.end() )
    return false;

  Depth = prefetchDepth.at( Core );
  return true;
}

bool RevOpts::GetStartAddr( uint32_t Core, uint64_t& StartAddr ) {
  if( Core > numCores )
    return false;

  if( startAddr.find( Core ) == startAddr.end() )
    return false;

  StartAddr = startAddr.at( Core );
  return true;
}

bool RevOpts::GetStartSymbol( uint32_t Core, std::string& Symbol ) {
  if( Core > numCores )
    return false;

  if( startSym.find( Core ) == startSym.end() )
    return false;

  Symbol = startSym.at( Core );
  return true;
}

bool RevOpts::GetMachineModel( uint32_t Core, std::string& MachModel ) {
  if( Core > numCores )
    return false;

  MachModel = machine.at( Core );
  return true;
}

bool RevOpts::GetInstTable( uint32_t Core, std::string& Table ) {
  if( Core > numCores )
    return false;

  Table = table.at( Core );
  return true;
}

bool RevOpts::GetMemCost( uint32_t Core, uint32_t& Min, uint32_t& Max ) {
  if( Core > numCores )
    return false;

  Min = memCosts[Core].first;
  Max = memCosts[Core].second;

  return true;
}

// bool RevOpts::GetMemDumpRanges() {

// return true;
// }

}  // namespace SST::RevCPU

// EOF
