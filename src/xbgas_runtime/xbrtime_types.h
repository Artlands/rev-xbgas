//
// _XBRTIME_TYPES_H_
//
// Copyright (C) 2017-2021 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#ifndef _XBRTIME_TYPES_H_
#define _XBRTIME_TYPES_H_

#ifdef __cplusplus
extern "C" {
#endif

#include <stdlib.h>
#include <stdint.h>

#define __XBRTIME_MAX_PE 1024

typedef struct _XBRTIME_MEM_T{
  uint64_t start_addr;
  size_t size;
}XBRTIME_MEM_T;

typedef struct{
  int _LOGICAL;           /*! XBRTIME_PE_MAP: Logical node ID */
  int _PHYSICAL;          /*! XBRTIME_PE_MAP: Physical node ID */
  uint64_t _BASE;         /*! XBRTIME_PE_MAP: Base physical address */
}XBRTIME_PE_MAP;

typedef struct{
  size_t    _MEMSIZE;     /*! XBRTIME_DATA: Size of the shared memory region (in bytes) */
  int       _ID;          /*! XBRTIME_DATA: Local node ID */
  int       _NPES;        /*! XBRTIME_DATA: Number of parallel elements */
  uint64_t  _START_ADDR;  /*! XBRTIME_DATA: Starting address of the shared memory region */
  uint64_t  _SENSE;       /*! XBRTIME_DATA: Sense of the barrier sync stage */
  uint64_t *_BARRIER;     /*! XBRTIME_DATA: Barrier value */
  XBRTIME_MEM_T *_MMAP;   /*! XBRTIME_DATA: Allocated memory map */
  XBRTIME_PE_MAP *_MAP;   /*! XBRTIME_DATA: PE Mappings */
}XBRTIME_DATA;

extern XBRTIME_DATA *__XBRTIME_CONFIG;

#ifdef __cplusplus
}
#endif  /* extern "C" */

#endif /* _XBRTIME_ALLOC_H_ */

/* EOF */