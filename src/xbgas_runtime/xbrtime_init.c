//
// _XBRTIME_INIT_C_
//
// Copyright (C) 2017-2021 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#include "xbrtime.h"

/* ------------------------------------------------- FUNCTION PROTOTYPES */
int __xbrtime_asm_get_id();
int __xbrtime_asm_get_npes();
size_t __xbrtime_asm_get_memsize();
uint64_t __xbrtime_asm_get_startaddr();
void __xbrtime_asm_fence();

extern int xbrtime_init(){
  /* vars */
  int i = 0;
  
  /* initialize xbrtime configuration in the firmware */
  *((uint64_t*)(_XBGAS_MY_PE_))                 = (uint64_t)(__xbrtime_asm_get_id());
  *((uint64_t*)(_XBGAS_TOTAL_NPE_))             = (uint64_t)(__xbrtime_asm_get_npes());
  *((uint64_t*)(_XBGAS_SHARED_MEM_SIZE_))       = 0x00ull;
  *((uint64_t*)(_XBGAS_SHARED_MEM_START_ADDR_)) = 0x00ull;
  *((uint64_t*)(_XBGAS_SENSE_))                 = 0x01ull;

  if((int64_t)(*(uint64_t*)(_XBGAS_TOTAL_NPE_)) > _XBRTIME_MAX_PE_ ){
    return -1;
  }

  // MAX_PE_NUM = 1024, thus, MAX_Barrier buffer space = log2^1024 = 10
  for( i = 0; i < 10; i++ ){
    *((uint64_t*)(_XBGAS_BARRIER_ + (uint64_t)(i * 8)))      = 0xfffffffffull;
    *((uint64_t*)(_XBGAS_BARRIER_ + (uint64_t)((i+10) * 8))) = 0xaaaaaaaaaull;
  }

  /* init the memory allocation slots */
  for( i = 0; i < _XBRTIME_MEM_SLOTS_; i++ ){ 
    *((uint64_t*)(_XBGAS_MMAP_ + (uint64_t)(i * 16)))     = 0x00ull;   // start address
    *((uint64_t*)(_XBGAS_MMAP_ + (uint64_t)(i * 16 + 8))) = 0x00ull;   // size
  }

  return 0;
}

extern void xbrtime_close(){
  int i = 0;

  /* hard fence */
  __xbrtime_asm_fence();

  /* free all the remaining shared blocks */
  for( i = 0; i < _XBRTIME_MEM_SLOTS_; i++ ){
    if( *(uint64_t*)(_XBGAS_MMAP_ + (uint64_t)(i * 16 + 8)) != 0){             // size
      xbrtime_free((void *)(*(uint64_t*)(_XBGAS_MMAP_ + (uint64_t)(i * 16)))); // start address
    }
  }
}

extern int xbrtime_mype(){
  return *(uint64_t*)(_XBGAS_MY_PE_);
}

extern int xbrtime_num_pes(){
  return *(uint64_t*)(_XBGAS_TOTAL_NPE_);
}

/* EOF */