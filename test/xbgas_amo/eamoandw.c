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
  uint32_t          val;  // Value to and

  if( id == 0 ) {
    namespace = 2;
    test_val  = 0b1110;
    val       = 0b0000;
  } else if( id == 1 ) {
    namespace = 1;
    test_val  = 0b1010;
    val       = 0b1001;
  }

  // Before AMO
  printf( "Before AMO And: PE %d: test_val = 0x%x, ret = 0x%x, val = 0x%x\n", id, test_val, ret, val );

  // Set the remote namespace
  asm volatile( " eaddie e13, %0, 0 \n\t " : : "r"( namespace ) );

  // Execute EAMOAND instruction
  // Puts the value in the memory address pointed to by the value in the test_val (rs1) register (in the extended address space) into the ret (rd) register,
  // then ANDs the data in val (rs2) to the data in the memory unit pointed to by test_val (rs1) (in the extended address space), and writes the result to the memory unit at that address.
  // For id = 0, the ret should be changed to 0xa (0x1010 test_val on PE 1) and test_val should be 0x8 (val on PE 1 AND test_val on PE 0, i.e. 0b1001 AND 0b1110 = 0b1000).
  asm volatile( "eamoand.w %1, %2, %0" : "+A"( test_val ), "+r"( ret ) : "r"( val ) : "memory" );

  printf( "After AMO And: PE %d: test_val = 0x%x, ret = 0x%x, val = 0x%x\n", id, test_val, ret, val );
}
