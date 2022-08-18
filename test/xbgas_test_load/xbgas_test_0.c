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
  int16_t  S_16  = -16;
  uint8_t  S_U8  = 8;
  int8_t   S_8   = -8;

  /* pointers to source data */
  uint64_t *PS_U64 = &S_U64;
  uint32_t *PS_U32 = &S_U32;
  uint16_t *PS_U16 = &S_U16;
  int16_t  *PS_16  = &S_16;
  uint8_t  *PS_U8  = &S_U8;
  int8_t   *PS_8   = &S_8;

  /* destination data */
  uint64_t D_U64 = 64;
  uint32_t D_U32 = 32;
  uint16_t D_U16 = 16;
  int16_t  D_S16 = -16;
  uint8_t  D_U8  = 8;
  int8_t   D_S8  = -8;

  /* pointers to destination data */
  uint64_t *PD_U64 = &D_U64;
  uint32_t *PD_U32 = &D_U32;
  uint16_t *PD_U16 = &D_U16;
  int16_t  *PD_16  = &D_S16;
  uint8_t  *PD_U8  = &D_U8;
  int8_t   *PD_8   = &D_S8;

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
    : [z] "=r" (S_U64)
    : [x] "r"  (PD_U64)
  );

    /* ERLW */
  asm volatile
  (
    " erlw x10, %[x], e10 \n\t"
    : [z] "=r" (S_U32)
    : [x] "r"  (PD_U32)
  );

  /* ERLH */
  asm volatile
  (
    " erlh x10, %[x], e10 \n\t"
    : [z] "=r" (S_U16)
    : [x] "r"  (PD_U16)
  );

  /* ERLHU */
  asm volatile
  (
    " erlhu x10, %[x], e10 \n\t"
    : [z] "=r" (S_16)
    : [x] "r"  (PD_16)
  );

  /* ERLB */
  asm volatile
  (
    " erlb x10, %[x], e10 \n\t"
    : [z] "=r" (S_U8)
    : [x] "r"  (PD_U8)
  );

  /* ERLBU */
  asm volatile
  (
    " erlbu x10, %[x], e10 \n\t"
    : [z] "=r" (S_8)
    : [x] "r"  (PD_8)
  );

  return 0;
}