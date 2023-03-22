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
  int i, my_pe, numpes, nelems;
  int *src_array;
  // Initializing xBGAS Runtime
  xbrtime_init();
  
  my_pe = xbrtime_mype();
  numpes = xbrtime_num_pes();

  nelems = 15;
  src_array = (int*) xbrtime_malloc(nelems * sizeof(int));

  if(my_pe == 2)
  {
    for(i = 0; i <= nelems; i++)
    {
        src_array[i] = i+1;
    }
  }
  else
  {
    for(i = 0; i < nelems; i++)
    {
        src_array[i] = 0;
    }
  }

  int pe_msg_sz[5] = {3, 2, 1, 5, 4};
	int pe_disp[5] = {0, 3, 5, 6, 11};
	int dest_array[5] = {99};

	revprintf("Pre-Scatter\nPE %d src_array = %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d\n", my_pe, src_array[0], src_array[1], src_array[2], src_array[3],
                                            						src_array[4], src_array[5], src_array[6], src_array[7],
                                            						src_array[8], src_array[9], src_array[10], src_array[11],
                                           	 					  src_array[12], src_array[13], src_array[14], src_array[15]);

  xbrtime_barrier();

  xbrtime_int_scatter(dest_array, src_array, pe_msg_sz, pe_disp, nelems, 2);
  
  xbrtime_barrier();

  revprintf("Post-Scatter\nPE %d dest_array = %d %d %d %d %d\n", my_pe, dest_array[0], dest_array[1], dest_array[2], dest_array[3], dest_array[4]);

  xbrtime_free( src_array );

  // Closing xBGAS
  xbrtime_close();
}

/* EOF */
