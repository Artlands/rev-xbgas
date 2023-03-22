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
  int i, my_pe, numpes, nelems, root_pe, nelems_pe;
  int *src_array, *dest_array;
  // Initializing xBGAS Runtime
  xbrtime_init();
  
  my_pe = xbrtime_mype();
  numpes = xbrtime_num_pes();
  root_pe = 2;

  nelems = 8;
  nelems_pe = (int)(nelems/numpes);
  src_array = (int*) xbrtime_malloc(nelems * sizeof(int));
  dest_array = (int*) xbrtime_malloc((int)(nelems_pe) * sizeof(int));

  if(my_pe == root_pe) {
    for(i = 0; i <= nelems; i++) {
        src_array[i] = i+1;
    }
  }
  else {
    for(i = 0; i < nelems; i++) {
        src_array[i] = 0;
    }
  }

  for( i=0; i < nelems_pe; i++) {
    dest_array[i] = 99;
  }

  int pe_msg_sz[4] = {2, 2, 2, 2};
	int pe_disp[4] = {0, 2, 4, 6};

	revprintf("Pre-Scatter\nPE %d src_array = %d %d %d %d %d %d %d %d\n", 
             my_pe, src_array[0], src_array[1], src_array[2], src_array[3],
                    src_array[4], src_array[5], src_array[6], src_array[7]);

  xbrtime_barrier();

  xbrtime_int_scatter(dest_array, src_array, pe_msg_sz, pe_disp, nelems, root_pe);
  
  xbrtime_barrier();

  revprintf("Post-Scatter\nPE %d dest_array = %d %d\n", 
             my_pe, dest_array[0], dest_array[1]);

  xbrtime_free( src_array );
  xbrtime_free( dest_array );
  // Closing xBGAS
  xbrtime_close();
}

/* EOF */
