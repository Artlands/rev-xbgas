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
  int i, my_pe, numpes, nelems, root_pe;
  int *src_array;
  // Initializing xBGAS Runtime
  xbrtime_init();
  
  my_pe = xbrtime_mype();
  numpes = xbrtime_num_pes();
  root_pe = 0;

  nelems = 10;
  src_array = (int*) xbrtime_malloc(nelems * sizeof(int));

  if(my_pe == root_pe) {
    for(i = 0; i < nelems; i++) {
        src_array[i] = i + my_pe;
    }
  } else {
    for(i = 0; i < nelems; i++) {
        src_array[i] = 0;
    }
  }

  int pe_msg_sz[5]  = {2, 2, 2, 2, 2};
	int pe_disp[5]    = {0, 2, 4, 6, 8};
  int dest_array[2] = {99, 99};

  if (my_pe == root_pe) {
    revprintf("Pre-Scatter PE %d src_array = %d %d %d %d %d %d %d %d %d %d\n", 
             my_pe, src_array[0], src_array[1], src_array[2], src_array[3], src_array[4], 
                    src_array[5], src_array[6], src_array[7], src_array[8], src_array[9]);
  }
	

  // pe_msg: contains the number of data elements that are to be scattered to each 
  // PE indexed by PE logical rank.
  // pe_disp: provides the offsets that each PE's values begin at relative to src.
  xbrtime_int_scatter(dest_array, src_array, pe_msg_sz, pe_disp, nelems, root_pe);
  
  revprintf("Post-Scatter PE %d dest_array = %d %d\n", 
             my_pe, dest_array[0], dest_array[1]);

  xbrtime_free( src_array );
  // Closing xBGAS
  xbrtime_close();
}

/* EOF */
