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
  uint64_t S_U64 = 65;
  uint32_t S_U32 = 33;
  uint16_t S_U16 = 17;
  uint8_t S_U8   = 9;

  /* pointers to source data */
  uint64_t *P_U64 = &S_U64;
  uint32_t *P_U32 = &S_U32;
  uint16_t *P_U16 = &S_U16;
  uint8_t *P_U8   = &S_U8;

  /* destination data */
  uint64_t U64 = -64;
  uint32_t U32 = -32;
  uint16_t U16 = -16;
  uint8_t  U8  = -8;

	/* Remote Node ID*/
  /* Namespace*/
	uint64_t NMSPACE = 0x1;


  // /* EADDI */
  // asm volatile
	// (
	// 	" eaddi %[z], e10, 1 \n\t"
	// 	: [z] 	"=r"	(U64)
	// 	: [e10] "r" 	(EXT)
	// );

  /* EADDIE */
  asm volatile // Set the remote node id
	(
		" eaddie e10, %[x], 0 \n\t"
		: [e10] "=r"	(U64)
		: [x] 	"r" 	(NMSPACE)
	);

  // /* EADDIE */
  // asm volatile
	// (
	// 	" eaddie e8, %[x], 1 \n\t"
	// 	: [e8] 	"=r"	(U64)
	// 	: [x] 	"r" 	(EXT)
	// );

  // /* EADDIX */
  // asm volatile // Set the remote node id
	// (
	// 	" eaddix e8, e10, 1 \n\t"
	// 	: [e8] 	"=r"	(U64)
	// 	: [e10] "r" 	(EXT)
	// );

  /* ELW */
  // asm volatile
  // (
  //   " elw [z], e10, 0 \n\t"
  //   : [z] "=r" (U32)
  //   : [e10] "r" (1)
  // );

  // /* ERSD */
  // asm volatile
  // (
  //   " ersd %[x], %[z], e10 \n\t"
  //   :
  //   : [x] "r" (U64), [z] "r" (P_U64), [e10] "r" (EXT)
  // );

  /* ERSW */
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

  // /* ERLD */
  // asm volatile
  // (
  //   " erld %[z],%[x],e10 \n\t"
  //   : [z] "=r" (U64)
  //   : [x] "r"  (P_U64), [e10] "r" (1)
  // );

  /* ERLW */
  asm volatile
  (
    " erlw %[z],%[x],e10 \n\t"
    : [z] "=r" (U32)
    : [x] "r"  (P_U32), [e10] "r" (1)
  );

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

  // /* ERLE */
  // asm volatile
  // (
  //   " erle e3,%[x],e10 \n\t"
  //   : [e3] 	"=r" (U64)
  //   : [x] 	"r"  (P_U64), [e10] "r" (1)
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