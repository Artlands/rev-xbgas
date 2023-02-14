//
// _XBRTIME_UTIL_C_
//
// Copyright (C) 2017-2021 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#include "xbrtime.h"

extern int xbrtime_decode_pe( int pe ) {
  int raw_pe = 0;
  int i = 0;

  if( __XBRTIME_CONFIG == NULL ) {
    return raw_pe;
  }

  for ( i=0; i<__XBRTIME_CONFIG->_NPES; i++ ) {
    if( __XBRTIME_CONFIG->_MAP[i]._LOGICAL == pe ){
      return __XBRTIME_CONFIG->_MAP[i]._PHYSICAL;
    }
  }
  return raw_pe;
}

extern int xbrtime_addr_accessible( const void *addr, int pe ){
  if( pe > (__XBRTIME_CONFIG->_NPES-1) ){
    return 0;
  }

  if( ((uint64_t)(addr) >
      (__XBRTIME_CONFIG->_START_ADDR + __XBRTIME_CONFIG->_MEMSIZE)) ||
      ((uint64_t)(addr) < (__XBRTIME_CONFIG->_START_ADDR)) ){
        return 0;
  }
  return 1;
}

/* EOF */