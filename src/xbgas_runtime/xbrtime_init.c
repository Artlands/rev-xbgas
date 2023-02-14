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

/* ------------------------------------------------- GLOBALS */
XBRTIME_DATA *__XBRTIME_CONFIG;

/* ------------------------------------------------- FUNCTION PROTOTYPES */
int __xbrtime_asm_get_id();
int __xbrtime_asm_get_npes();
size_t __xbrtime_asm_get_memsize();
uint64_t __xbrtime_asm_get_startaddr();
void __xbrtime_asm_fence();

extern int xbrtime_init(){
  /* vars */
  int i = 0;
  
  /* allocate the structure in the local heap */
  __XBRTIME_CONFIG = NULL;
  __XBRTIME_CONFIG = revmalloc( sizeof( XBRTIME_DATA) );
  if( __XBRTIME_CONFIG == NULL ){
    return -1;
  }

  __XBRTIME_CONFIG->_MMAP       = revmalloc(sizeof(XBRTIME_MEM_T) * _XBRTIME_MEM_SLOTS_);
  __XBRTIME_CONFIG->_ID         = __xbrtime_asm_get_id();
  __XBRTIME_CONFIG->_MEMSIZE    = __xbrtime_asm_get_memsize();
  __XBRTIME_CONFIG->_NPES       = __xbrtime_asm_get_npes();
  __XBRTIME_CONFIG->_START_ADDR = __xbrtime_asm_get_startaddr();
  __XBRTIME_CONFIG->_SENSE      = 0x01ull;
  __XBRTIME_CONFIG->_BARRIER 		= (uint64_t *)(_XBGAS_BARRIER_);
	// MAX_PE_NUM = 1024, thus, MAX_Barrier buffer space = log2^1024 = 10
	for( i = 0; i < 10; i++){
  	__XBRTIME_CONFIG->_BARRIER[i] 		= 0xfffffffffull;
  	__XBRTIME_CONFIG->_BARRIER[10+i] 	= 0xaaaaaaaaaull;
	}

  /* too many total PEs */
  if( __XBRTIME_CONFIG->_NPES > __XBRTIME_MAX_PE ){
    revfree( __XBRTIME_CONFIG );
    return -1;
  }

  /* init the pe mapping block */
  __XBRTIME_CONFIG->_MAP = revmalloc( sizeof( XBRTIME_PE_MAP ) *
                                      __XBRTIME_CONFIG->_NPES );
  if( __XBRTIME_CONFIG->_MAP == NULL ){
    revfree( __XBRTIME_CONFIG );
    return -1;
  }

  /* init the memory allocation slots */
  for( i=0;i<_XBRTIME_MEM_SLOTS_; i++ ){
    __XBRTIME_CONFIG->_MMAP[i].start_addr = 0x00ull;
    __XBRTIME_CONFIG->_MMAP[i].size       = 0;
  }

  /* init the PE mapping structure */
  for( i=0; i<__XBRTIME_CONFIG->_NPES; i++ ){
    __XBRTIME_CONFIG->_MAP[i]._LOGICAL   = i;
    // __XBRTIME_CONFIG->_MAP[i]._PHYSICAL  = i+1;
    __XBRTIME_CONFIG->_MAP[i]._PHYSICAL  = i;
  }
  
  return 0;
}

extern void xbrtime_close(){
  int i = 0;

  if( __XBRTIME_CONFIG != NULL ){
    /* hard fence */
    __xbrtime_asm_fence();

    /* free all the remaining shared blocks */
    for( i=0; i<_XBRTIME_MEM_SLOTS_; i++ ){
      if( __XBRTIME_CONFIG->_MMAP[i].size != 0 ){
        xbrtime_free((void *)(__XBRTIME_CONFIG->_MMAP[i].start_addr));
      }
    }

    if( __XBRTIME_CONFIG->_MAP != NULL ){
      revfree( __XBRTIME_CONFIG->_MAP );
      __XBRTIME_CONFIG->_MAP = NULL;
    }

    revfree( __XBRTIME_CONFIG );
  }
}

extern int xbrtime_mype(){
  if( __XBRTIME_CONFIG == NULL ){
    return -1;
  }
  return __XBRTIME_CONFIG->_ID;
}

extern int xbrtime_num_pes(){
  if( __XBRTIME_CONFIG == NULL ){
    return -1;
  }
  return __XBRTIME_CONFIG->_NPES;
}

/* EOF */