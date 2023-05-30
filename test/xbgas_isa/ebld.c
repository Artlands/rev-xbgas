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

  int total_nelem = 1024;
  int nelem = 512;
  int stride = 16; // stride in bytes

  /* destination data */
  uint64_t src_array[total_nelem];
  uint64_t dest_array[total_nelem];
  
  uint64_t NMSPACE;
  if (MYPE == 0){
    NMSPACE = 2;
    for (int i = 0; i < total_nelem; i++) {
      src_array[i] = i;
      dest_array[i] = 0;
    }
  }
  else if (MYPE == 1) {
    NMSPACE = 1;
    for (int i = 0; i < total_nelem; i++) {
      src_array[i] = total_nelem - i;
      dest_array[i] = 0;
    }
  }

  /* EADDIE */
  asm volatile // Set the remote namespace
	(
		" eaddie e15, %[x], 0 \n\t"
		:
		: [x] 	"r"  (NMSPACE)
	);

  /* EBLD */
  while(1) {
    asm volatile
    ( 
      "ebld %[dest], %[src], %[nelem], %[stride] \n\t"
      :
      : [dest] "r" (&dest_array), 
        [src] "r" (&src_array), 
        [nelem] "r" (nelem), 
        [stride] "r" (stride)
    );
  }

  return 0;
}