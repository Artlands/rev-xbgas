/* _XFER_ALLTOALL_C_
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

#include "xbrtime.h"

int main( int argc, char **argv ){
  int *src_array, *dest_array;
  
  int my_pe = xbrtime_mype();

  src_array = (int*) xbrtime_malloc(5 * sizeof(int));
  dest_array = (int*) xbrtime_malloc(5 * sizeof(int));

  for(int i = 0; i < 5; i++) {
    src_array[i] = (int) my_pe;
    // dest_array[i] = 10;
  }

  revprintf("PE: %d src_array: %d %d %d %d %d, dest_array: %d %d %d %d %d\n",
                            my_pe, src_array[0], src_array[1], src_array[2], src_array[3], src_array[4],
                            dest_array[0], dest_array[1], dest_array[2], dest_array[3], dest_array[4]);
  
  xbrtime_free( src_array );
  xbrtime_free( dest_array );
  
}

/* EOF */
