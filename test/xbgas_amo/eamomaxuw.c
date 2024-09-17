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
#include "../../common/syscalls/syscalls.h"
#include "../isa/isa_test_macros.h"
#include "../syscalls/printf/printf.h"
#include <stdbool.h>
#include <unistd.h>

extern int __xbrtime_asm_get_id();
extern int __xbrtime_asm_get_npes();

int main( int argc, char** argv ) {

  int id   = __xbrtime_asm_get_id();
  int npes = __xbrtime_asm_get_npes();

  // printf( "Hello from PE %d of %d\n", id, npes );

  uint64_t namespace;
  volatile uint32_t test_val;
  uint32_t          ret = 0;
  uint32_t          val;  // Value to Max

  if( id == 0 ) {
    namespace = 2;
    test_val  = 0xff00;
    val       = 2;
  } else if( id == 1 ) {
    namespace = 1;
    test_val  = 1;
    val       = 0xf0f0;
  }

  // Before AMO
  printf( "Before AMO MaxU: PE %d: test_val = 0x%x, ret = 0x%x, val = 0x%x\n", id, test_val, ret, val );

  // Set the remote namespace
  asm volatile( " eaddie e13, %0, 0 \n\t " : : "r"( namespace ) );

  // Execute EAMOMAXU instruction
  // Puts the value in the memory address pointed to by the value in the test_val (rs1) register (in the extended address space) into the ret (rd) register,
  // then Min the data in val (rs2) to the data in the memory unit pointed to by test_val (rs1) (in the extended address space), and writes the result to the memory unit at that address.
  // For id = 0, the ret should be changed to 1 (test_val on PE 1) and test_val should be 0xff00 (max(val on PE 1, test_val on PE 0)).
  asm volatile( "eamomaxu.w %1, %2, %0" : "+A"( test_val ), "+r"( ret ) : "r"( val ) : "memory" );

  printf( "After AMO MaxU: PE %d: test_val = 0x%x, ret = 0x%x, val = 0x%x\n", id, test_val, ret, val );
}
