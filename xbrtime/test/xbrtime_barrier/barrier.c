/* _XFER_GET_TEST_1_C_
 *
 * Copyright (C) 2017-2018 Tactical Computing Laboratories, LLC
 * All Rights Reserved
 * contact@tactcomplabs.com
 *
 * This file is a part of the XBGAS-RUNTIME package.  For license
 * information, see the LICENSE file in the top level directory
 * of the distribution.
 *
 */

#include <inttypes.h>
#include "xbrtime.h"

#define _XBGAS_ALLOC_SIZE_ 8

int main( int argc, char **argv ){
  int rtn = 0;

  // Initializing xBGAS Runtime
  rtn = xbrtime_init();
  
  // perform a barrier
  xbrtime_barrier();

  // perform a barrier
  xbrtime_barrier();

  // Closing xBGAS
  xbrtime_close();
  return rtn;
}

/* EOF */
