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
    NMSPACE = 1;
  else if (MYPE == 1)
    NMSPACE = 0;
   
  /* destination data */
  uint64_t U64 = -8;
  uint32_t U32 = -16;
  uint16_t U16 = -32;
  uint8_t  U8  = -64;

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
		" eaddie e10, %[x], 0 \n\t"
		:
		: [x] 	"r"  (NMSPACE)
	);

  /* ELD */
  asm volatile // set destination address
  (
    "ld x10, 0(%[z]) \n\t"
    :
    : [z] "r" (AP_U64)
  );

  asm volatile
  (
    " eld x10, 0(x10) "
  );

  // /* ELW */
  // asm volatile // set destination address
  // (
  //   "ld x10, 0(%[z]) \n\t"
  //   :
  //   : [z] "r" (AP_U32)
  // );

  // asm volatile
  // (
  //   " elw x11, 0(x10) "
  // );

  // /* ELH */
  // asm volatile // set destination address
  // (
  //   "ld x10, 0(%[z]) \n\t"
  //   :
  //   : [z] "r" (AP_U16)
  // );

  // asm volatile
  // (
  //   " elh x11, 0(x10) "
  // );

  // /* ELHU */
  // asm volatile
  // (
  //   " elhu x11, 0(x10) "
  // );

  // /* ELB */
  // asm volatile // set destination address
  // (
  //   "ld x10, 0(%[z]) \n\t"
  //   :
  //   : [z] "r" (AP_U8)
  // );

  // asm volatile
  // (
  //   " elb x11, 0(x10) "
  // );

  // /* ELBU */
  // asm volatile
  // (
  //   " elbu x11, 0(x10) "
  // );

  // /* ELE */
  // asm volatile // set destination address
  // (
  //   "ld x10, 0(%[z]) \n\t"
  //   :
  //   : [z] "r" (AP_U64)
  // );

  // asm volatile
  // (
  //   " ele e12, 0(x10) "
  // );

  return 0;
}