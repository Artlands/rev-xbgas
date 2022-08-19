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

int main(int argc, char **argv ){

  /* source data */
  uint64_t S_U64 = 64;
  uint32_t S_U32 = 32;
  uint16_t S_U16 = 16;
  uint8_t  S_U8  = 8;

  /* pointers to source data */
  uint64_t *PS_U64 = &S_U64;
  uint32_t *PS_U32 = &S_U32;
  uint16_t *PS_U16 = &S_U16;
  uint8_t  *PS_U8  = &S_U8;

  /* destination data */
  uint64_t D_U64 = 64;
  uint32_t D_U32 = 32;
  uint16_t D_U16 = 16;
  uint8_t  D_U8  = 8;

  /* pointers to destination data */
  uint64_t *PD_U64 = &D_U64;
  uint32_t *PD_U32 = &D_U32;
  uint16_t *PD_U16 = &D_U16;
  uint8_t  *PD_U8  = &D_U8;

  /* Namespace*/
	uint64_t NMSPACE = 0x2;

  /* EADDIE */
  asm volatile // Set the remote node id
	(
		" eaddie e10, %[x], 0 \n\t"
		:
		: [x] 	"r" 	(NMSPACE)
	);

  /* ERLD */
  asm volatile
  (
    " erld x10, %[x], e10 \n\t"
    :
    : [x] "r"  (PD_U64)
  );

    /* ERLW */
  asm volatile
  (
    " erlw x11, %[x], e10 \n\t"
    :
    : [x] "r"  (PD_U32)
  );

  /* ERLH */
  asm volatile
  (
    " erlh x12, %[x], e10 \n\t"
    :
    : [x] "r"  (PD_U16)
  );

  /* ERLHU */
  asm volatile
  (
    " erlhu x13, %[x], e10 \n\t"
    :
    : [x] "r"  (PD_U16)
  );

  /* ERLB */
  asm volatile
  (
    " erlb x14, %[x], e10 \n\t"
    :
    : [x] "r"  (PD_U8)
  );

  /* ERLBU */
  asm volatile
  (
    " erlbu x15, %[x], e10 \n\t"
    :
    : [x] "r"  (PD_U8)
  );

    /* ERLE */
  asm volatile
  (
    " erle e11, %[x], e10 \n\t"
    :
    : [x] "r"  (PD_U64)
  );

  return 0;
}