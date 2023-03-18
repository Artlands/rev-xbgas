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

  // Initializing xBGAS Runtime
  rtn = xbrtime_init();

  int my_pe = xbrtime_mype();
	int numpes = xbrtime_num_pes();
  
  // Allocating sz bytes
  ptr = (int *)(xbrtime_malloc( sz ));
  // Putting a value in the first element
  ptr[0] = (int)(xbrtime_mype() + 5);
  // perform a barrier
  xbrtime_barrier();

  if( xbrtime_mype() == 0 ){
    // perform an operation
    xbrtime_int_put((int *)(ptr),
                    (int *)(ptr),
                    1,
                    1,
                    ((my_pe+2)%numpes) );
  }

  // // perform a barrier
  xbrtime_barrier();
  xbrtime_free( ptr );
  // Closing xBGAS
  xbrtime_close();
  return rtn;
}

/* EOF */
