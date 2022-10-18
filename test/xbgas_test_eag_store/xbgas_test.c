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
  
  int nelem = 4;
  int stride = 1;

  /* source data */
  int SRC32[10] = {10, 200, 3000, 40000, 50000, 600000, 7000000, 80000000, 900000000, 1000000000};

  uint64_t *PT_SRC32 = (uint64_t *)(SRC32);
  uint64_t **PPT_SRC32 = &PT_SRC32;

  /* destination data*/
  int DEST32[10] = {0, -1, -2, -3, -4, -5, -6, -7, -8, -9};

  uint64_t *PT_DEST32 = (uint64_t *)(DEST32);
  uint64_t **PPT_DEST32 = &PT_DEST32;

  /* EADDIE */
  asm volatile // Set the remote node id
	(
		" eaddie e10, %[x], 0 \n\t"
		:
		: [x] 	"r"  (NMSPACE)
	);

  /* ELD */
  asm volatile // set source address
  (
    "ld x10, 0(%[z]) \n\t"
    :
    : [z] "r" (PPT_DEST32)
  );

  asm volatile
  (
    " eag %[d], %[n], %[s] "
    :
    : [d] "r" (SRC32), [n] "r" (nelem), [s] "r" (stride) 
  );

  asm volatile
  (
    " esw x11, 0(x10) "
  );

  return 0;
}