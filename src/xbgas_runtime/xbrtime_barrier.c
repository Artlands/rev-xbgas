//
// _XBRTIME_BARRIER_C_
//
// Copyright (C) 2017-2021 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#include "xbrtime.h"
#define SENSE __XBRTIME_CONFIG->_SENSE

/* ------------------------------------------------- FUNCTION PROTOTYPES */
void __xbrtime_asm_fence();
int xbrtime_decode_pe( int pe );
void __xbrtime_remote_touch( uint64_t addr, uint64_t target, uint64_t sense);

extern void xbrtime_barrier() {
  int64_t i                   = 0;
  int64_t stride              = 1;
  uint64_t target         = 0x00ull;
  uint64_t addr           = 0x00ull;
  volatile uint64_t sense = SENSE;

  int64_t num_pe = xbrtime_num_pes();

  /* sanity check */
  if( num_pe == 1 ) {
    return;
  }

  /* Get the total iterations */
  int64_t mype = xbrtime_mype();
  int64_t iter = (int64_t)(log(num_pe)/log(2));
  
  if (iter < log(num_pe)/log(2))
		iter++;
  
  /* force a heavy fence */
  __xbrtime_asm_fence();

  while( i < iter ){
    /* derive the correct target pe */
    target = (mype + stride)%num_pe;

    target = (uint64_t)(xbrtime_decode_pe((int)(target)));
    addr   = (uint64_t)(&__XBRTIME_CONFIG->_BARRIER[sense*10 + i]);

    __xbrtime_remote_touch(addr, target, (uint64_t)stride);

    /* spinwait on local value */
    while( __XBRTIME_CONFIG->_BARRIER[sense*10 + i] != stride ) {
      // debug
    }

    stride *= 2;
    i++;
  }
  
  /* switch the sense */
  for( i = 0; i < iter; i++ ) {
    __XBRTIME_CONFIG->_BARRIER[sense*10 + i] = 0xdeadbeefull;
  }
  // Flip the sense
  sense = 1 - sense;

}

/* EOF */