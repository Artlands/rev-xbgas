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
  int src_array[6] = {2, 2, 2, 2, 2, 2};
  // int *src_array = NULL;
  int *dst_array = NULL;

  revprintf("Initializing xBGAS Runtime\n");
  
  // Initializing xBGAS Runtime
  xbrtime_init();

  int my_pe = xbrtime_mype();
	int numpes = xbrtime_num_pes();
  int target = 1;
  
  // src_array = (int *)(xbrtime_malloc( 6 * sizeof(int) ));
  dst_array = (int *)(xbrtime_malloc( 6 * sizeof(int) ));

  for(int i = 0; i < 6; i++) {
    // src_array[i] = my_pe;
    dst_array[i] = my_pe + i;
  }

  // revprintf("Pre-Bulk Put - PE:%d - ", my_pe);
  // for (int i = 0; i < 6; i++) {
  //   revprintf("[%d] = %d ", i, dst_array[i]);
  // }
  // revprintf("\n");

  // perform a barrier
  xbrtime_barrier();

  if( xbrtime_mype() == 0 ){
    // perform an operation
    revprintf("PE %d Puts values to PE %d\n", xbrtime_mype(), target);

    // xbrtime_ulonglong_get((unsigned long long *)(ptr),
    //                       (unsigned long long *)(ptr),
    //                       1,
    //                       1,
    //                       target );
    xbrtime_int_put(dst_array,
                    src_array,
                    3,
                    2,
                    target );
  }

  // perform a barrier
  xbrtime_barrier();

  revprintf("Post-Bulk Put - PE:%d -", my_pe);
  for (int i = 0; i < 6; i++) {
    revprintf("[%d] = %d ", i, dst_array[i]);
  }
  revprintf("\n");

  xbrtime_free(src_array);
  // Closing xBGAS
  xbrtime_close();
}

/* EOF */
