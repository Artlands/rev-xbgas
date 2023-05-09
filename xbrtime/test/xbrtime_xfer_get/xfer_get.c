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
  int *ptr = NULL;
  size_t sz = _XBGAS_ALLOC_SIZE_;

  // Initializing xBGAS Runtime
  xbrtime_init();

  int my_pe = xbrtime_mype();
	int numpes = xbrtime_num_pes();
  int target = (my_pe+2)%numpes;

  // Allocating sz bytes
  ptr = (int *)(xbrtime_malloc( sz ));
  // Putting a value in the first element
  ptr[0] = (int)(my_pe + 10);

  revprintf("Pre-Get - PE:%d Val: %d\n", my_pe, ptr[0]);

  // perform a barrier
  xbrtime_barrier();

  if( xbrtime_mype() == 0 ){
    // perform an operation
    revprintf("PE %d GETs a value from PE %d\n", xbrtime_mype(), target);

    xbrtime_ulonglong_get((unsigned long long *)(ptr),
                          (unsigned long long *)(ptr),
                          1,
                          1,
                          target );
  }

  // perform a barrier
  xbrtime_barrier();

  revprintf("Post-Get - PE:%d Val: %d\n", my_pe, ptr[0]);

  xbrtime_free( ptr );

  // Closing xBGAS
  xbrtime_close();
}

/* EOF */
