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

/* ------------------------------------------------- FUNCTION PROTOTYPES */
void __xbrtime_asm_fence();
int xbrtime_decode_pe( int pe );
void __xbrtime_remote_touch( uint64_t addr, uint64_t target, uint64_t sense);

extern void xbrtime_barrier() {
  int64_t i                   = 0;
  int64_t stride              = 1;
  uint64_t target         = 0x00ull;
  uint64_t addr           = 0x00ull;
  volatile uint64_t sense = *((uint64_t*)(_XBGAS_SENSE_));

  int64_t num_pe = xbrtime_num_pes();

  /* sanity check */
  if( num_pe == 1 ) {
    return;
  }

  /* Get the total iterations */
  int64_t my_pe = xbrtime_mype();
  int64_t iter = (int64_t)(log(num_pe)/log(2));
  
  if (iter < log(num_pe)/log(2))
		iter++;
  
  /* force a heavy fence */
  __xbrtime_asm_fence();


#ifdef _XBGAS_DEBUG_
  revprintf("\033[31mPE \033[1m%d\033[0m \033[31mEnters Barrier\033[0m\n", my_pe);
#endif
  /* Enter barrier */
  while( i < iter ){
    /* derive the correct target pe */
    target = (my_pe + stride)%num_pe;

    target = (uint64_t)(xbrtime_decode_pe((int)(target)));
    addr = (uint64_t)(_XBGAS_BARRIER_ + (uint64_t)((sense*10 + i) * 8));

    __xbrtime_remote_touch(addr, target, (uint64_t)stride);

#ifdef _XBGAS_DEBUG_
    revprintf("\033[35mBarrier-iteration-%d: PE \033[1m%d\033[0m \033[35mTouches PE \033[1m%d\033[0m\033[0m\n", i, my_pe, target);
#endif

    while( *((uint64_t*)(_XBGAS_BARRIER_ + (uint64_t)((sense*10 + i) * 8))) != stride ) {
      // debug
    }

    stride *= 2;
    i++;
  }

#ifdef _XBGAS_DEBUG_
  revprintf("\033[32mPE \033[1m%d\033[0m \033[32mExits Barrier\033[0m\n", my_pe);
#endif
  /* reset the sense */
  for( i = 0; i < iter; i++ ) {
    *((uint64_t*)(_XBGAS_BARRIER_ + (uint64_t)((sense*10 + i) * 8))) = 0xdeadbeefull;
  }

  // Flip the sense
   *((uint64_t*)(_XBGAS_SENSE_)) = 1 - sense;

}

/* EOF */