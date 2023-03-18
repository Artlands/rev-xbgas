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

#define align8(x) ((((x)-1)>>3)<<3 + 8)   // align the pointers to 8 bytes/64 bits

typedef struct block_meta *b_meta;

struct block_meta{
  size_t size;            // 8 bytes in RV64
  b_meta next;            // 8 bytes
  b_meta prev;            // 8 bytes
  long free;              // 8 bytes
  void *ptr;              // 8 bytes in RV64
  char data[1];           // starting of the memory block
};

#ifdef __cplusplus
}
#endif  /* extern "C" */

#endif /* _XBRTIME_ALLOC_H_ */

/* EOF */