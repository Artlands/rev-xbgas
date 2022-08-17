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
  uint64_t S_U64 = 1;
  uint32_t S_U32 = 1;
  uint16_t S_U16 = 1;
  uint8_t S_U8   = 1;

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

	/* Remote Node ID*/
	uint64_t EXT = 1;


  /* EADDI */
  asm volatile 
	(
		" eaddi %[z], 0, e10 \n\t"
		: [z] 	"=r"	(U64)
		: [e10] "r" 	(EXT) 
	);

  /* EADDIE */
  asm volatile // Set the remote node id
	(
		" eaddie e10, 0, %[x] \n\t"
		: [e10] "=r"	(U64)
		: [x] 	"r" 	(EXT) 
	);

  /* EADDIE */
  asm volatile 
	(
		" eaddie e8, 1, %[x] \n\t"
		: [e8] 	"=r"	(U64)
		: [x] 	"r" 	(EXT) 
	);

  /* EADDIX */
  asm volatile // Set the remote node id
	(
		" eaddix e8, 1, e10 \n\t"
		: [e8] 	"=r"	(U64)
		: [e10] "r" 	(EXT) 
	);

  // /* ERSW */
  // asm volatile
  // (
  //   " ersw %[x], %[z], e10 \n\t"
  //   : 
  //   : [x] "r" (U32), [z] "r" (P_U32), [e10] "r" (EXT)
  // );

  // /* ERSH */
  // asm volatile
  // (
  //   " ersh %[x], %[z], e10 \n\t"
  //   : 
  //   : [x] "r" (U16), [z] "r" (P_U16), [e10] "r" (EXT)
  // );

  // /* ERSB */
  // asm volatile
  // (
  //   " ersb %[x], %[z], e10 \n\t"
  //   : 
  //   : [x] "r" (U8), [z] "r" (P_U8), [e10] "r" (EXT)
  // );

  // /* ERSE */
  // asm volatile
  // (
  //   " erse e8, %[z], e10 \n\t"
  //   : 
  //   : [e8] "r" (U32), [z] "r" (P_U32), [e10] "r" (EXT)
  // );

  // /* ERLW */
  // asm volatile
  // (
  //   " erlw %[z],%[x],e10 \n\t"
  //   : [z] "=r" (U32)
  //   : [x] "r"  (P_U32), [e10] "r" (1)
  // );

  // /* ERLH */
  // asm volatile
  // (
  //   " erlh %[z],%[x],e10 \n\t"
  //   : [z] "=r" (U16)
  //   : [x] "r"  (P_U16), [e10] "r" (1)
  // );

  // /* ERLHU */
  // asm volatile
  // (
  //   " erlhu %[z],%[x],e10 \n\t"
  //   : [z] "=r" (U16)
  //   : [x] "r"  (P_U16), [e10] "r" (1)
  // );

  // /* ERLB */
  // asm volatile
  // (
  //   " erlb %[z],%[x],e10 \n\t"
  //   : [z] "=r" (U8)
  //   : [x] "r"  (P_U8), [e10] "r" (1)
  // );

  // /* ERLBU */
  // asm volatile
  // (
  //   " erlbu %[z],%[x],e10 \n\t"
  //   : [z] "=r" (U8)
  //   : [x] "r"  (P_U8), [e10] "r" (1)
  // );

  /*
  asm("erlw a5,a6,e10");
  asm("erlh a5,a6,e10");
  asm("erlb a5,a6,e10");
  asm("erlhu a5,a6,e10");
  asm("erlbu a5,a6,e10");
	*/
  //asm("ersd a5,a5,e10");
  //asm("ersw a5,a5,e10");
  //asm("ersh a5,a5,e10");
  //asm("ersb a5,a5,e10");
  //asm("erse e10,a5,e11");
  //asm("eaddi a5,0,e10");
  //asm("eaddie e10,0,a5");
  //asm("eaddix e21,0,e10");
  return 0;
}