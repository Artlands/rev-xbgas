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

#define _XBGAS_ALLOC_SIZE_ 4

int main( int argc, char **argv ){
  int rtn = 0;
  int *ptr = NULL;
  size_t sz = _XBGAS_ALLOC_SIZE_;

  int my_pe = xbrtime_mype();
	int numpes = xbrtime_num_pes();
  int target = (my_pe+1)%numpes;

  // Initializing xBGAS Runtime
  rtn = xbrtime_init();

  // Allocating sz bytes
  ptr = (int *)(xbrtime_malloc( sz ));
  // Putting a value in the first element
  ptr[0] = (int)(my_pe + 5);

  revprintf("Pre-Get - PE:%d Val: %d\n", my_pe, ptr[0]);

  // perform a barrier
  xbrtime_barrier();

  if( my_pe == 0 ){
    revprintf("PE %d PUTs a value to PE %d\n", xbrtime_mype(), target);
    // perform an operation
    xbrtime_int_put((int *)(ptr),
                    (int *)(ptr),
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
  return rtn;
}

/* EOF */
