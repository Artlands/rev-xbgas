//
// SysCalls.h
//
// Copyright (C) 2017-2021 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//
#pragma once
#ifndef __SYSTEMCALLS_H__
#define __SYSTEMCALLS_H__

#include <unordered_map>
#include <type_traits>
#include <cstddef>
#include <cstdint>
#include <sys/types.h>
#include <unistd.h>
#include "RevInstTable.h"
#include "RevMem.h"
#include "../common/include/XbgasAddr.h"
// how to support uint128_t? that's not supported in c++11 compilers...
//
// https://stackoverflow.com/questions/34588650/uint128-t-does-not-name-a-type
//
typedef unsigned int uint128_t __attribute__((mode(TI)));
using cvoid_ptr = const void *;
using cchar_ptr = const char *;
using void_ptr = void *;
using char_ptr = char *;
/*
 * void_t
 *
 * tag-type representing return type for system calls that return void
 */
struct void_t {};
namespace SST { namespace RevCPU {
// type tags for each riscv architecture supported in REV
//
struct RiscvArch {
    using int_type = std::uint32_t;
};
struct Riscv32 : RiscvArch {
    using int_type = std::uint32_t;
};
struct Riscv64 : RiscvArch {
    using int_type = std::uint64_t;
};
struct Riscv128 : RiscvArch {
    using int_type = uint128_t;
};
template<typename RiscvArchType>
struct SystemArch {
    
    using RiscvArch = RiscvArchType;
    using IsRiscv32  = typename std::conditional< std::is_same<RiscvArchType, Riscv32>::value, std::true_type, std::false_type>::type;
    using IsRiscv64  = typename std::conditional< std::is_same<RiscvArchType, Riscv64>::value, std::true_type, std::false_type>::type;
    using IsRiscv128 = typename std::conditional< std::is_same<RiscvArchType, Riscv128>::value, std::true_type, std::false_type>::type;
    using RiscvModeIntegerType = typename std::conditional< IsRiscv32::value,
        Riscv32::int_type, // TRUE
        typename std::conditional< IsRiscv64::value, // FALSE
                Riscv32::int_type, // TRUE
                typename std::conditional< IsRiscv128::value, // FALSE
                        Riscv128::int_type, // TRUE
                        Riscv32::int_type // FALSE - we fall back on Riscv32
                >::type
            >::type
        >::type;
};
template<typename RiscvArchType, typename SystemArch<RiscvArchType>::RiscvModeIntegerType Code>
struct SystemCallInterfaceCode {
    using SystemCallCodeType = std::integral_constant<typename SystemArch<RiscvArchType>::RiscvModeIntegerType, static_cast<typename SystemArch<RiscvArchType>::RiscvModeIntegerType>(Code)>;
};
using systemcall_t = std::function<int(RevRegFile const&, RevMem const&, RevInst const&)>;
template<typename RiscvArchType=Riscv32>
class SystemCalls : public SystemArch<RiscvArchType> {
    public:
    using RiscvArch = typename SystemArch<RiscvArchType>::RiscvArch;
    using IsRiscv32  = typename SystemArch<RiscvArchType>::IsRiscv32;
    using IsRiscv64  = typename SystemArch<RiscvArchType>::IsRiscv64;
    using IsRiscv128 = typename SystemArch<RiscvArchType>::IsRiscv128;
    using RiscvModeIntegerType = typename SystemArch<RiscvArchType>::RiscvModeIntegerType;
    // enum Codes : RiscvModeIntegerType {
        // EXIT             = ExitInterfaceType<RiscvArchType>::value,
        // EXITGROUP        = ExitgroupInterfaceType<RiscvArchType>::value,
        // GETPID           = GetpidInterfaceType<RiscvArchType>::value,
        // KILL             = KillInterfaceType<RiscvArchType>::value,
        // TGKILL           = TgkillInterfaceType<RiscvArchType>::value,
        // READ             = ReadInterfaceType<RiscvArchType>::value,
        // WRITE            = WriteInterfaceType<RiscvArchType>::value,
        // OPENAT           = OpenatInterfaceType<RiscvArchType>::value,
        // CLOSE            = CloseInterfaceType<RiscvArchType>::value,
        // LSEEK            = LseekInterfaceType<RiscvArchType>::value,
        // BRK              = LseekInterfaceType<RiscvArchType>::value,
        // LINKAT           = LinkatInterfaceType<RiscvArchType>::value,
        // UNLINKAT         = UnlinkatInterfaceType<RiscvArchType>::value,
        // LINK             = LinkInterfaceType<RiscvArchType>::value,
        // UNLINK           = UnlinkInterfaceType<RiscvArchType>::value,
        // RENAMEAT         = RenameatInterfaceType<RiscvArchType>::value,
        // MKDIRAT          = MkdiratInterfaceType<RiscvArchType>::value,
        // MKDIR            = MkdirInterfaceType<RiscvArchType>::value,
        // CHDIR            = ChdirInterfaceType<RiscvArchType>::value,
        // GETCWD           = GetcwdInterfaceType<RiscvArchType>::value,
        // FSTAT            = FstatInterfaceType<RiscvArchType>::value,
        // FSTATAT          = FstatatInterfaceType<RiscvArchType>::value,
        // FACCESSAT        = FaccessatInterfaceType<RiscvArchType>::value,
        // PREAD            = PreadInterfaceType<RiscvArchType>::value,
        // PWRITE           = PwriteInterfaceType<RiscvArchType>::value,
        // UNAME            = UnameInterfaceType<RiscvArchType>::value,
        // GETUID           = GetuidInterfaceType<RiscvArchType>::value,
        // GETEUID          = GeteuidInterfaceType<RiscvArchType>::value,
        // GETGID           = GetgidInterfaceType<RiscvArchType>::value,
        // GETEGID          = GetegidInterfaceType<RiscvArchType>::value,
        // GETTID           = GettidInterfaceType<RiscvArchType>::value,
        // MMAP             = MmapInterfaceType<RiscvArchType>::value,
        // MUMAP            = MunmapInterfaceType<RiscvArchType>::value,
        // MREMAP           = MremapInterfaceType<RiscvArchType>::value,
        // MPROTECT         = MprotectInterfaceType<RiscvArchType>::value,
        // PRLIMIT64        = Prlimit64InterfaceType<RiscvArchType>::value,
        // SIGACTION        = SigactionInterfaceType<RiscvArchType>::value,
        // WRITEV           = WritevInterfaceType<RiscvArchType>::value,
        // GETTOD           = GettimeofdayInterfaceType<RiscvArchType>::value,
        // TIMES            = TimesInterfaceType<RiscvArchType>::value,
        // FCNTL            = FcntlInterfaceType<RiscvArchType>::value,
        // FTRUNCATE        = FtruncateInterfaceType<RiscvArchType>::value,
        // GETDENTS         = GetdentsInterfaceType<RiscvArchType>::value,
        // DUP              = DupInterfaceType<RiscvArchType>::value,
        // DUP3             = Dup3InterfaceType<RiscvArchType>::value,        
        // READLINKAT       = ReadlinkatInterfaceType<RiscvArchType>::value,        
        // SIGPROCMASK      = SigprocmaskInterfaceType<RiscvArchType>::value,                
        // IOCTL            = IoctlInterfaceType<RiscvArchType>::value,                
        // GETRLIMIT        = GetrlimitInterfaceType<RiscvArchType>::value,                
        // SETRLIMIT        = SetrlimitInterfaceType<RiscvArchType>::value,                
        // GETRUSAGE        = GetrusageInterfaceType<RiscvArchType>::value,                
        // CLOCKGETTIME     = ClockgettimeInterfaceType<RiscvArchType>::value,
        // SETTIDADDRESS    = SettidaddressInterfaceType<RiscvArchType>::value,
        // SETROBUSTLIST    = SetrobustlistInterfaceType<RiscvArchType>::value,
        // MADVISE          = MadviseInterfaceType<RiscvArchType>::value,
        // STATX            = StatxInterfaceType<RiscvArchType>::value,        
        // OPEN             = OpenInterfaceType<RiscvArchType>::value,        
        // ACCESS           = AccessInterfaceType<RiscvArchType>::value,        
        // STAT             = StatInterfaceType<RiscvArchType>::value,        
        // LSTAT            = LstatInterfaceType<RiscvArchType>::value,        
        // TIME             = TimeInterfaceType<RiscvArchType>::value,
    };
    static std::unordered_map< int, systemcall_t > jump_table;
// template<typename RiscvArchType = Riscv32>
// using RevChdirCode = SystemCallInterfaceCode<RiscvArchType, 49>;
template<typename RiscvArchType>
int RevChdir(RevRegFile* regFile, RevMem* mem, RevInst inst) {
  // if constexpr (std::is_same<RiscvArchType, Riscv32>::value){
  //   std::size_t strlen = 0;
  //   mem->FindStringTerminator(td_u32(regFile->RV32[inst.rs1],32), strlen);
  //   char addr[strlen];
  //   mem->ReadMem(td_u32(regFile->RV32[inst.rs1],32), sizeof(char)*strlen, &addr);
  //   const int rc = chdir(addr);
  //   regFile->RV32[inst.rd] = rc;
  //   regFile->RV32_PC += inst.instSize;
  //   return rc+1;
  // }
  // else if (std::is_same<RiscvArchType, Riscv64>::value){
  //  std::size_t strlen = 0;
  //  mem->FindStringTerminator(td_u64(regFile->RV64[inst.rs1],64), strlen);
  //  char addr[strlen];
  //  mem->ReadMem(td_u64(regFile->RV64[inst.rs1],64), sizeof(char)*strlen, &addr);
  //  const int rc = chdir(addr);
  //  regFile->RV64[inst.rd] = rc;
  //  regFile->RV64_PC += inst.instSize;
  //  return rc+1; 
  // }
  // return -1;
  }

template<typename RiscvArchType>
int RevBrk(RevRegFile* regFile, RevMem* mem, RevInst inst) {
  if constexpr (std::is_same<RiscvArchType, Riscv32>::value){
    
  } else if (std::is_same<RiscvArchType, Riscv64>::value){
    uint64_t rtn;
    uint64_t addr = (uint64_t)(regFile->RV64[10]);
    uint64_t newbrk = addr;
    
    uint64_t brk = mem->GetBrk();
    uint64_t brk_min = mem->GetBrkMin();
    uint64_t brk_max = mem->GetBrkMax();
    if( addr < brk_min )
      newbrk = brk_min;
    else if( addr > brk_max)
      newbrk = brk_max;

#ifdef _XBGAS_DEBUG_
    std::cout << "Old heap Addr: 0x" << std::hex << (brk_min) << std::endl;
#endif

    if(brk == 0)
      mem->SetBrk(ROUNDUP(brk_min, _REV_PAGE_SIZE_));

    uint64_t newbrk_page = ROUNDUP(newbrk, _REV_PAGE_SIZE_);
    mem->SetBrk(newbrk_page);
    rtn = newbrk;

#ifdef _XBGAS_DEBUG_
    std::cout << "New heap Addr: 0x" << std::hex << (newbrk_page) << std::endl;
#endif

    regFile->RV64[10] = rtn;
    return true;
    }
    return false;
  }

template<typename RiscvArchType>
int RevFstat(RevRegFile* regFile, RevMem* mem, RevInst inst) {
  if constexpr (std::is_same<RiscvArchType, Riscv32>::value){
    
  } else if (std::is_same<RiscvArchType, Riscv64>::value){
    uint64_t rtn;
    int fd = (int)(regFile->RV64[10]);
    if( fd == 1){
      rtn = 1;
    } else {
      rtn = 0;
    }

    regFile->RV64[10] = rtn;
    return true;
    }
    return false;
  }

template<typename RiscvArchType>
int PrintString(RevRegFile* regFile, RevMem* mem, RevInst inst) {
  if constexpr (std::is_same<RiscvArchType, Riscv32>::value){
    
  } else if (std::is_same<RiscvArchType, Riscv64>::value){
    uint64_t ptr = regFile->RV64[11];

#ifdef _XBGAS_DEBUG_
  int64_t id = (int64_t)(mem->ReadU64(_XBGAS_MY_PE_));
  if(id == 0)
    std::cout << "Print String Start Addr: 0x" << std::hex << (ptr) << std::endl;
#endif

    for( uint64_t ptr;; ptr += 8) {
      uint64_t data = mem->ReadU64(ptr);
      if( mem->DumpDataAsString(data) ){
        std::cout << std::endl;
        break;
      }
    }
    return true;
  }
    return false;
  }

} /* end namespace RevCPU */ } // end namespace SST
#endif
// // EOF