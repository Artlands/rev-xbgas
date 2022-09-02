//
// _XBRTIME_H_
//
// Copyright (C) 2017-2021 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#ifndef _XBRTIME_H_
#define _XBRTIME_H_

#ifdef __cplusplus
extern "C" {
#endif

#include <stdlib.h>
#include <inttypes.h>
#include <stdio.h>

#include "../../common/include/XbgasAddr.h"

extern int xbrtime_init();
extern void xbrtime_close();
extern void *xbrtime_malloc( size_t sz );
extern void xbrtime_free( void *ptr );
extern void *revmalloc( size_t sz );
extern void revfree( void *ptr );
extern int xbrtime_mype();
extern int xbrtime_num_pes();
extern void xbrtime_barrier();
extern int xbrtime_addr_accessible( const void *addr, int pe );

#ifdef __cplusplus
}
#endif  /* extern "C" */

#endif /* _XBRTIME_H_ */