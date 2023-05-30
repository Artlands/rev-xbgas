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
  int MYPE = (int)(*(uint64_t *)(_XBGAS_MY_PE_));

  /* destination data */
  uint64_t U64;
  
  uint64_t NMSPACE;
  if (MYPE == 0){
    NMSPACE = 2;
    U64 = 64;
  }
  else if (MYPE == 1) {
    NMSPACE = 1;
    U64 = 8;
  }

  /* pointers to destination data */
  uint64_t *P_U64 = &U64;

  /* EADDIE */
  asm volatile // Set the remote namespace
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
    : [z] "r" (&P_U64)
  );

  asm volatile
  (
    " eld x10, 0(x10) "
  );

  return 0;
}