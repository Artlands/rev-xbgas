//
// _XBRTIME_ALLOC_H_
//
// Copyright (C) 2017-2021 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#ifndef _XBRTIME_ALLOC_H_
#define _XBRTIME_ALLOC_H_

#ifdef __cplusplus
extern "C" {
#endif

#include <stdlib.h>

typedef struct mem_block {
  struct mem_block *next;
  struct mem_block *prev;
  size_t size;
  int free;
} mem_block;

#ifdef __cplusplus
}
#endif  /* extern "C" */

#endif /* _XBRTIME_ALLOC_H_ */

/* EOF */