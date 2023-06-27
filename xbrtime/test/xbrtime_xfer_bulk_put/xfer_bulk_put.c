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
  int dst_array[6] = {2, 2, 2, 2, 2, 2};
  int *src_array = NULL;
  
  // Initializing xBGAS Runtime
  xbrtime_init();

  int my_pe = xbrtime_mype();
	int numpes = xbrtime_num_pes();
  int target = 1;
  
  src_array = (int *)(xbrtime_malloc( 6 * sizeof(int) ));

  for(int i = 0; i < 6; i++) {
    src_array[i] = my_pe + i;
  }

  // perform a barrier
  xbrtime_barrier();

  if (my_pe == 1) {
    revprintf("Pre-Bulk Put - PE:%d DstArray = [%d, %d, %d, %d, %d, %d]\n", 
              my_pe, dst_array[0], dst_array[1], dst_array[2], dst_array[3], dst_array[4], dst_array[5]);
  } else {
    revprintf("Pre-Bulk Put - PE:%d SrcArray = [%d, %d, %d, %d, %d, %d]\n", 
              my_pe, src_array[0], src_array[1], src_array[2], src_array[3], src_array[4], src_array[5]);
  }

  if( xbrtime_mype() == 0 ){
    // perform an operation
    revprintf("PE %d PUTs values to PE %d\n", xbrtime_mype(), target);

    xbrtime_int_put(dst_array,
                    src_array,
                    6,
                    1,
                    target );
  }

  // perform a barrier
  xbrtime_barrier();

  if (my_pe == 1) {
    revprintf("Post-Bulk Put - PE:%d DstArray = [%d, %d, %d, %d, %d, %d]\n", 
              my_pe, dst_array[0], dst_array[1], dst_array[2], dst_array[3], dst_array[4], dst_array[5]);
  }

  xbrtime_free(src_array);
  // Closing xBGAS
  xbrtime_close();
}

/* EOF */
