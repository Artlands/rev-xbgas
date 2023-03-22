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
  int numpes, my_pe, root_pe, *b_val;
  root_pe = 3;

  // Initializing xBGAS Runtime
  xbrtime_init();
  
  my_pe = xbrtime_mype();
  numpes = xbrtime_num_pes();
  revprintf("PE %d initializes xBGAS Runtime\n", my_pe);

  b_val = (int*)xbrtime_malloc(sizeof(int));
  *b_val = my_pe + 12;

  revprintf("Pre-Broadcast - PE:%d Val: %d\n", my_pe, b_val[0]);

  if (my_pe == root_pe)
    revprintf("PE %d BROADCASTs a value to other PEs\n", root_pe);
  
  xbrtime_int_broadcast(b_val, b_val, 1, 1, root_pe);

  revprintf("Post-Broadcast - PE:%d Val: %d\n", my_pe, b_val[0]);

  xbrtime_free( b_val );

  revprintf("PE %d closes xBGAS Runtime\n", my_pe);
  // Closing xBGAS
  xbrtime_close();
}

/* EOF */
