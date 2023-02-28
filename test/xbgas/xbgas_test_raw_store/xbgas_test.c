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
  uint64_t S_U64 = -64;
  uint32_t S_U32 = -32;
  uint16_t S_U16 = -16;
  uint8_t S_U8   = -8;

  /* pointers to source data */
  uint64_t *PS_U64 = &S_U64;
  uint32_t *PS_U32 = &S_U32;
  uint16_t *PS_U16 = &S_U16;
  uint8_t *PS_U8   = &S_U8;

  /* pointers to pointers*/
  uint64_t **APS_U64 = &PS_U64;
  uint32_t **APS_U32 = &PS_U32;
  uint16_t **APS_U16 = &PS_U16;
  uint8_t **APS_U8 = &PS_U8;
   
  /* destination data */
  uint64_t U64 = 8;
  uint32_t U32 = 16;
  uint16_t U16 = 32;
  uint8_t  U8  = 64;

  /* pointers to destination data */
  uint64_t *P_U64 = &U64;
  uint32_t *P_U32 = &U32;
  uint16_t *P_U16 = &U16;
  uint8_t *P_U8   = &U8;

  /* pointers to pointers*/
  uint64_t **AP_U64 = &P_U64;
  uint32_t **AP_U32 = &P_U32;
  uint16_t **AP_U16 = &P_U16;
  uint8_t **AP_U8 = &P_U8;

  /* EADDIE */
  asm volatile // Set the remote node id
	(
		" eaddie e18, %[x], 0 \n\t"
		: 
		: [x] 	"r" 	(NMSPACE)
	);

  /* ------- ERSD ------- */
  asm volatile // set source data
  (
    "ld x10, 0(%[z]) \n\t"
    :
    : [z] "r" (PS_U64)
  );

    asm volatile // set destination address
  (
    "ld x11, 0(%[z]) \n\t"
    :
    : [z] "r" (AP_U64)
  );

  asm volatile
  (
    " ersd x10, x11, e18 \n\t"
  );

  /* ------- ERSW ------- */
  asm volatile // set source data
  (
    "lw x10, 0(%[z]) \n\t"
    :
    : [z] "r" (PS_U32)
  );

    asm volatile // set destination address
  (
    "lw x11, 0(%[z]) \n\t"
    :
    : [z] "r" (AP_U32)
  );

  asm volatile
  (
    " ersw x10, x11, e18 \n\t"
  );

  /* ------- ERSH ------- */
  asm volatile // set source data
  (
    "lh x10, 0(%[z]) \n\t"
    :
    : [z] "r" (PS_U16)
  );

    asm volatile // set destination address
  (
    "lh x11, 0(%[z]) \n\t"
    :
    : [z] "r" (AP_U16)
  );

  asm volatile
  (
    " ersh x10, x11, e18 \n\t"
  );

  /* ------- ERSB ------- */
  asm volatile // set source data
  (
    "lb x10, 0(%[z]) \n\t"
    :
    : [z] "r" (PS_U8)
  );

    asm volatile // set destination address
  (
    "lb x11, 0(%[z]) \n\t"
    :
    : [z] "r" (AP_U8)
  );

  asm volatile
  (
    " ersb x10, x11, e18 \n\t"
  );

  /* ------- ERSE ------- */

  /* EADDIE */
  asm volatile // Set the remote node id
	(
		" eaddie e11, %[x], 0 \n\t"
		: 
		: [x] 	"r" 	(S_U64)
	);

  asm volatile // set source data
  (
    "ld x10, 0(%[z]) \n\t"
    :
    : [z] "r" (PS_U64)
  );

    asm volatile // set destination address
  (
    "ld x11, 0(%[z]) \n\t"
    :
    : [z] "r" (AP_U64)
  );

  asm volatile
  (
    " erse e11, x11, e18 \n\t"
  );

  return 0;
}