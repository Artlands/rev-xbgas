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
  int i, numpes, my_pe, root_pe, nelems, stride, *r_val;

  // Initializing xBGAS Runtime
  xbrtime_init();
  
  my_pe = xbrtime_mype();
  numpes = xbrtime_num_pes();
  nelems = 10;
  stride = 2;
  root_pe = 0;

  r_val = (int*)xbrtime_malloc(nelems * sizeof(int));

  for (i = 0; i < nelems; i++){
    r_val[i] = (int)my_pe;
  }

  revprintf("Pre-Reduction - PE:%d Val: %d %d %d %d %d %d %d %d %d %d\n", 
             my_pe, r_val[0], r_val[1], r_val[2], r_val[3], r_val[4], 
                    r_val[5], r_val[6], r_val[7], r_val[8], r_val[9]);

  if (my_pe == root_pe)
    revprintf("PE %d REDUCEs values from other PEs\n", root_pe);
  
  xbrtime_int_reduce_sum(r_val, r_val, 5, stride, root_pe);

  revprintf("Post-Reduction - PE:%d Val: %d %d %d %d %d %d %d %d %d %d\n", 
             my_pe, r_val[0], r_val[1], r_val[2], r_val[3], r_val[4], 
                    r_val[5], r_val[6], r_val[7], r_val[8], r_val[9]);

  xbrtime_free( r_val );

  // Closing xBGAS
  xbrtime_close();
}

/* EOF */
