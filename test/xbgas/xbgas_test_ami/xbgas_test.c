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
  /* Namespace*/
	uint64_t NMSPACE = 0x1;

  /* EADDIE */
  asm volatile // Set the remote node id
	(
		" eaddie e10, %[x], 0 \n\t"
		:
		: [x]  "r" 	(NMSPACE)
	);

  /* EADDI */
  asm volatile
	(
		" eaddi a1, e10, 1 \n\t"
	);

  /* EADDIX */
  asm volatile
	(
		" eaddix e12, e10, 2 \n\t"
	);

  return 0;
}