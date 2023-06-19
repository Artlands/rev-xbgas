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
  int *array_1, *array_2, *array_3, *array_4;

  xbrtime_init();
  array_1 = (int*) xbrtime_malloc(24);
  array_2 = (int*) xbrtime_malloc(56);
  array_3 = (int*) xbrtime_malloc(124);

  xbrtime_free( array_1 );
  xbrtime_free( array_2 );
  xbrtime_free( array_3 );


  array_4 = (int*) xbrtime_malloc(241);

  xbrtime_free( array_4 );

  xbrtime_close();

}

/* EOF */