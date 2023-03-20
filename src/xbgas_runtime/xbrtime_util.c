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
  return pe;
}

extern int xbrtime_addr_accessible( const void *addr, int pe ){
  return 1;
}

/* EOF */