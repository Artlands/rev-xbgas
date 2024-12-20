/*
 * elw.c
 *
 * RISC-V ISA: RV64GX
 *
 * Copyright (C) 2017-2024 Tactical Computing Laboratories, LLC
 * All Rights Reserved
 * contact@tactcomplabs.com
 *
 * See LICENSE in the top level directory for licensing details
 *
 */
#include "syscalls.h"
#include <stdbool.h>
#include <unistd.h>
#define printf rev_fast_printf

extern int __xbrtime_asm_get_id();
extern int __xbrtime_asm_get_npes();

int main( int argc, char** argv ) {

  int id   = __xbrtime_asm_get_id();
  int npes = __xbrtime_asm_get_npes();

  // printf( "Hello from PE %d of %d\n", id, npes );

  uint64_t namespace;
  volatile uint32_t test_val;
  uint32_t          ret = 0;
  uint32_t          val;  // Value to swap

  if( id == 0 ) {
    namespace = 2;
    test_val  = 2;
    val       = 2;
  } else if( id == 1 ) {
    namespace = 1;
    test_val  = 1;
    val       = 1;
  }

  // Before AMO
  printf( "Before AMO Swap: PE %d: test_val = %d, ret = %d val = %d ", id, test_val, ret, val );

  // Set the remote namespace
  asm volatile( " eaddie e13, %0, 0 \n\t " : : "r"( namespace ) );

  // Execute EAMOSWAP instruction
  // Puts the value in the memory address pointed to by the value in the test_val (rs1) register (in the extended address space) into the ret (rd) register,
  // then swaps the data in rs2 (val) to the data in the memory unit pointed to by test_val (rs1) (in the extended address space), and writes the result to the memory unit at that address.
  // For id = 0, the ret should be changed to 1 (test_val on PE 1) and val should be 1 (val on PE 1).
  asm volatile( "eamoswap.w %1, %2, %0" : "+A"( test_val ), "+r"( ret ) : "r"( val ) : "memory" );

  printf( "After AMO Swap: PE %d: test_val = %d, ret = %d, val = %d ", id, test_val, ret, val );
}
