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

#include "xbrtime.h"

int main( int argc, char **argv ){
  int i, my_pe, numpes, *my_array;

  // Initializing xBGAS Runtime
  xbrtime_init();
  
  my_pe = xbrtime_mype();
  numpes = xbrtime_num_pes();
  revprintf("PE %d initializes xBGAS Runtime\n", my_pe);

  my_array = (int*) xbrtime_malloc(8 * sizeof(int));

  for(i = 0; i < 4; i++)
  {
    my_array[i] = my_pe;
  }

  revprintf("Pre-AlltoAll\nPE:%d src_array: %d %d %d %d\n",
                            my_pe, my_array[0], my_array[1], my_array[2], my_array[3]);
  
  xbrtime_int_alltoall(my_array, my_array, 1, 1, 1);
  
  revprintf("Post-AlltoAll\nPE:%d src_array: %d %d %d %d\n",
                            my_pe, my_array[0], my_array[1], my_array[2], my_array[3]);

  xbrtime_free( my_array );

  revprintf("PE %d closes xBGAS Runtime\n", my_pe);
  // Closing xBGAS
  xbrtime_close();
}

/* EOF */
