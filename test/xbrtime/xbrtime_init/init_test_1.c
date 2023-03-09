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

int main( int argc, char **argv ){
  int rtn = 0;
  void *ptr = NULL;

  // printf( "Initializing xBGAS Runtime\n" );
  rtn = xbrtime_init();
  
  int my_pe = xbrtime_mype();
  // printf( "xBGAS is Initialized; Closing xBGAS\n" );
  xbrtime_close();
  // printf( "xBGAS is Closed\n" );

  return rtn;
}

/* EOF */