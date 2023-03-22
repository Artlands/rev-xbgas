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
  int i, numpes, my_pe, root_pe, nelems, stride, *b_val;
  root_pe = 0;

  // Initializing xBGAS Runtime
  xbrtime_init();
  
  my_pe = xbrtime_mype();
  numpes = xbrtime_num_pes();
  nelems = 8;
  stride = 1;

  b_val = (int*)xbrtime_malloc(nelems * sizeof(int));

  for (i = 0; i < nelems; i++){
    b_val[i] = i + my_pe;
  }

  revprintf("Pre-Broadcast - PE:%d Val: %d %d %d %d %d %d %d %d\n", 
            my_pe, b_val[0], b_val[1], b_val[2], b_val[3],
                   b_val[4], b_val[5], b_val[6], b_val[7]);

  if (my_pe == root_pe)
    revprintf("PE %d BROADCASTs values to other PEs\n", root_pe);
  
  xbrtime_int_broadcast(b_val, b_val, nelems, stride, root_pe);

  revprintf("Post-Broadcast - PE:%d Val: %d %d %d %d %d %d %d %d\n", 
            my_pe, b_val[0], b_val[1], b_val[2], b_val[3],
                   b_val[4], b_val[5], b_val[6], b_val[7]);

  xbrtime_free( b_val );

  // Closing xBGAS
  xbrtime_close();
}

/* EOF */
