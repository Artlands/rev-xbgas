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
  xbrtime_init();
	int numpes, my_pe, *b_val;
	numpes = xbrtime_num_pes(); 
	my_pe = xbrtime_mype();
	b_val = (int*) xbrtime_malloc(sizeof(int));
	*b_val = my_pe + 10;

	xbrtime_barrier();

	xbrtime_int_broadcast(b_val, b_val, 1, 0, 0);

	xbrtime_barrier();

	xbrtime_close();
}

/* EOF */
