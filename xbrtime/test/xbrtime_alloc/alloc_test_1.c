/* _INIT_TEST_1_C_
 *
 * Copyright (C) 2017-2030 Tactical Computing Laboratories, LLC
 * All Rights Reserved
 * contact@tactcomplabs.com
 *
 * This file is a part of the XBGAS-RUNTIME package.  For license
 * information, see the LICENSE file in the top level directory
 * of the distribution.
 *
 */

#include <stdio.h>
#include "xbrtime.h"

#define _XBGAS_ALLOC_SIZE_ 8

int main( int argc, char **argv ){
  int rtn = 0;
  void *ptr = NULL;
  size_t sz = _XBGAS_ALLOC_SIZE_;

  // printf( "Initializing xBGAS Runtime\n" );
  rtn = xbrtime_init();

  ptr = xbrtime_malloc( sz );

  xbrtime_free( ptr );

  xbrtime_close();

  return rtn;
}

/* EOF */
