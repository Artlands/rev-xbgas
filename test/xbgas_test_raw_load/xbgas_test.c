/*
 *
 * _RAW_C_
 *
 * Copyright (C) 2018 Tactical Computing Laboratories, LLC
 * All Rights Reserved
 * contact@tactcomplabs.com
 *
 */

#include <stdio.h>
#include <stdint.h>
#include "../../common/include/XbgasAddr.h"

int main(int argc, char **argv ){
  /* Read my PE and determine namespace for testing*/
  int MYPE = (int)(*(uint64_t *)(_XBGAS_MY_PE_ADDR_));
  uint64_t NMSPACE;

  if (MYPE == 0)
    NMSPACE = 0x2;
  if (MYPE == 1)
    NMSPACE = 0x1;

  /* source data */
  uint64_t S_U64 = 1;
  uint32_t S_U32 = 2;
  uint16_t S_U16 = 3;
  uint8_t S_U8   = 4;

  /* pointers to source data */
  uint64_t *P_U64 = &S_U64;
  uint32_t *P_U32 = &S_U32;
  uint16_t *P_U16 = &S_U16;
  uint8_t *P_U8   = &S_U8;

  /* destination data */
  uint64_t U64 = 10;
  uint32_t U32 = 10;
  uint16_t U16 = 10;
  uint8_t  U8  = 10;

  /* EADDIE */
  asm volatile // Set the remote node id
	(
		" eaddie e10, %[x], 0 \n\t"
		: [e10] "=r" (U64)
		: [x] 	"r"  (NMSPACE)
	);

  /* ERLD */
  asm volatile
  (
    " erld %[z], %[x], e10 \n\t"
    : [z] "=r" (U64)
    : [x] "r"  (P_U64), [e10] "r" (1)
  );

    /* ERLW */
  asm volatile
  (
    " erlw %[z], %[x], e10 \n\t"
    : [z] "=r" (U32)
    : [x] "r"  (P_U32), [e10] "r" (1)
  );

  /* ERLH */
  asm volatile
  (
    " erlh %[z], %[x], e10 \n\t"
    : [z] "=r" (U16)
    : [x] "r"  (P_U16), [e10] "r" (1)
  );

  /* ERLHU */
  asm volatile
  (
    " erlhu %[z], %[x], e10 \n\t"
    : [z] "=r" (U16)
    : [x] "r"  (P_U16), [e10] "r" (1)
  );

  /* ERLB */
  asm volatile
  (
    " erlb %[z], %[x], e10 \n\t"
    : [z] "=r" (U8)
    : [x] "r"  (P_U8), [e10] "r" (1)
  );

  /* ERLBU */
  asm volatile
  (
    " erlbu %[z], %[x], e10 \n\t"
    : [z] "=r" (U8)
    : [x] "r"  (P_U8), [e10] "r" (1)
  );

    /* ERLE */
  asm volatile
  (
    " erle e3, %[x], e10 \n\t"
    : [e3] "=r" (U64)
    : [x] "r"  (P_U64), [e10] "r" (1)
  );

  return 0;
}