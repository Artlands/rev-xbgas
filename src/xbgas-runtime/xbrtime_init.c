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

void __xbrtime_asm_fence();

extern int xbrtime_init(){
  int i = 0;
  int npe = xbrtime_num_pes();

  /* too many total PEs */
  if( npe > _XBRTIME_PE_MAP_MAX_ENTRIES_ ){
    return -1;
  }

  /* init the PE mapping structure */
  for( i=0; i < npe; i++ ){
    uint64_t _LOGICAL_ADDR_ = _XBRTIME_PE_MAP_ADDR_ + i * 16;
    uint64_t _PHYSICAL_ADDR_ = _LOGICAL_ADDR_ + 4;
    *((uint64_t *)_LOGICAL_ADDR_) = i;
    *((uint64_t *)_PHYSICAL_ADDR_) = i+1;
  }

  /* init the memory allocation slots */
  for( i=0; i < _XBRTIME_MEM_SLOTS_; i++ ){
    uint64_t _STARTADDR_ADDR_ = _XBRTIME_MEM_T_ADDR_ + i * 16;
    uint64_t _SIZE_ADDR = _STARTADDR_ADDR_ + 8;
    *((uint64_t *)_STARTADDR_ADDR_) = 0x00ull;
    *((uint64_t *)_SIZE_ADDR) = 0;
  }
  
  return 0;
}

extern void xbrtime_close(){
  int i = 0;

  /* hard fence */
  __xbrtime_asm_fence();

  /* free all the remaining shared blocks */
  for( i=0; i<_XBRTIME_MEM_SLOTS_; i++ ){
    uint64_t _STARTADDR_ADDR_ = _XBRTIME_MEM_T_ADDR_ + i * 16;
    uint64_t _SIZE_ADDR = _STARTADDR_ADDR_ + 8;
    if( *((uint64_t *)_SIZE_ADDR) != 0 ){
      xbrtime_free( (void*)((uint64_t *)_STARTADDR_ADDR_) );
    }
  }
}

extern int xbrtime_mype(){
  int MYPE = (int)(*(uint64_t *)(_XBGAS_MY_PE_ADDR_));
  return MYPE;
}

extern int xbrtime_num_pes(){
  int PES = (int)(*(uint64_t *)(_XBGAS_TOTAL_NPE_ADDR_));
  return PES;
}

/* EOF */