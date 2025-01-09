//
// _RevOpts_h_
//
// Copyright (C) 2017-2025 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#ifndef _SST_REVCPU_REVOPTS_H_
#define _SST_REVCPU_REVOPTS_H_

// -- SST Headers
#include "SST.h"

// -- Standard Headers
#include <cinttypes>
#include <map>
#include <string>
#include <utility>
#include <vector>

namespace SST::RevCPU {

class RevOpts {
public:
  /// RevOpts: options constructor
  RevOpts( uint32_t NumCores, uint32_t NumHarts, const int Verbosity );

  /// RevOpts: options destructor
  ~RevOpts() = default;

  /// RevOpts: retrieve the number of configured cores
  uint32_t GetNumCores() { return numCores; }

  /// RevOpts: retrieve the number of configured harts per core
  uint32_t GetNumHarts() { return numHarts; }

  /// RevOpts: retrieve the verbosity level
  int GetVerbosity() { return verbosity; }

  /// RevOpts: initialize the set of starting addresses
  bool InitStartAddrs( const std::vector<std::string>& StartAddrs );

  /// RevOpts: initialize the set of potential starting symbols
  bool InitStartSymbols( const std::vector<std::string>& StartSymbols );

  /// RevOpts: initialize the set of machine models
  bool InitMachineModels( const std::vector<std::string>& Machines );

  /// RevOpts: initalize the set of instruction tables
  bool InitInstTables( const std::vector<std::string>& InstTables );

  /// RevOpts: initialize the memory latency cost tables
  bool InitMemCosts( const std::vector<std::string>& MemCosts );

  /// RevOpts: initialize the prefetch depths
  bool InitPrefetchDepth( const std::vector<std::string>& Depths );

  /// RevOpts: retrieve the start address for the target core
  bool GetStartAddr( uint32_t Core, uint64_t& StartAddr );

  /// RevOpts: retrieve the start symbol for the target core
  bool GetStartSymbol( uint32_t Core, std::string& Symbol );

  /// RevOpts: retrieve the machine model string for the target core
  bool GetMachineModel( uint32_t Core, std::string& MachModel );

  /// RevOpts: retrieve instruction table for the target core
  bool GetInstTable( uint32_t Core, std::string& Table );

  /// RevOpts: retrieve the memory cost range for the target core
  bool GetMemCost( uint32_t Core, uint32_t& Min, uint32_t& Max );

  /// RevOpts: retrieve the prefetch depth for the target core
  bool GetPrefetchDepth( uint32_t Core, uint32_t& Depth );

  /// RevOpts: set the argv array
  void SetArgs( const SST::Params& params );

  /// RevOpts: retrieve the argv array
  const std::vector<std::string>& GetArgv() const { return Argv; }

  /// RevOpts: splits a string into tokens
  static void splitStr( std::string s, const char* delim, std::vector<std::string>& v ) {
    char* ptr     = s.data();
    char* saveptr = nullptr;
    for( v.clear(); auto token = strtok_r( ptr, delim, &saveptr ); ptr = nullptr )
      v.push_back( token );
  }

private:
  uint32_t numCores{};   ///< RevOpts: number of initialized cores
  uint32_t numHarts{};   ///< RevOpts: number of harts per core
  int      verbosity{};  ///< RevOpts: verbosity level

  std::unordered_map<uint32_t, uint64_t>     startAddr{};      ///< RevOpts: map of core id to starting address
  std::unordered_map<uint32_t, std::string>  startSym{};       ///< RevOpts: map of core id to starting symbol
  std::unordered_map<uint32_t, std::string>  machine{};        ///< RevOpts: map of core id to machine model
  std::unordered_map<uint32_t, std::string>  table{};          ///< RevOpts: map of core id to inst table
  std::unordered_map<uint32_t, uint32_t>     prefetchDepth{};  ///< RevOpts: map of core id to prefretch depth
  std::vector<std::pair<uint32_t, uint32_t>> memCosts{};       ///< RevOpts: vector of memory cost ranges
  std::vector<std::string>                   Argv{};           ///< RevOpts: vector of function arguments
  std::vector<std::string>                   MemDumpRanges{};  ///< RevOpts: vector of function arguments

};  // class RevOpts

}  // namespace SST::RevCPU

#endif

// EOF
