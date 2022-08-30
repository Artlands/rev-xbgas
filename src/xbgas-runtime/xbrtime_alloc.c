//
// _XBRTIME_ALLOC_C_
//
// Copyright (C) 2017-2021 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#include "xbrtime.h"

void __xbrtime_asm_quiet_fence();

void *__xbrtime_shared_malloc( size_t sz ){
  
}

void __xbrtime_shared_free(void *ptr){

}

extern void *xbrtime_alloc( size_t sz ){
  void *ptr = NULL;

  /* sanity check */
  if( sz == 0 ){
    return NULL;
  }

  ptr = __xbrtime_shared_malloc( sz );
  return ptr;
}

extern void xbrtime_free( void *ptr ){
  if( ptr == NULL ) {
    return;
  }
  __xbrtime_shared_free(ptr);
  __xbrtime_asm_quiet_fence();
}

