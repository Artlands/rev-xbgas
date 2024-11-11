/*
 * ersb.c
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
#include "isa_test_macros.h"
#include "malloc.h"
#include "syscalls.h"
#include <stdbool.h>
#include <unistd.h>
#define printf rev_fast_printf

extern int __xbrtime_asm_get_id();
extern int __xbrtime_asm_get_npes();

int main( int argc, char** argv ) {

  int id   = __xbrtime_asm_get_id();
  int npes = __xbrtime_asm_get_npes();

  uint64_t namespace;
  uint8_t dest = 0xdd;

  uint8_t src1 = 0x0f;
  uint8_t src2 = 0xf0;

  if( id == 0 ) {
    namespace = 2;
  } else if( id == 1 ) {
    namespace = 1;
  }

  // Set the remote namespace
  asm volatile( " eaddie e6, %0, 0 \n\t " : : "r"( namespace ) );

  // Load the source value
  if( id == 0 ) {
    asm volatile( " mv x5, %0 \n\t " : : "r"( src2 ) );
  } else if( id == 1 ) {
    asm volatile( " mv x5, %0 \n\t " : : "r"( src1 ) );
  }

  // Remote store
  asm volatile( " ersb x5, %0, e6 \n\t " : : "r"( &dest ) );

  // Wait for a few cycles
  for( int i = 0; i < 100; i++ ) {
    asm( "nop" );
  }

  // Print the value in dest
  printf( "PE %d: dest = 0x%x", id, dest );

  if( id == 0 ) {
    assert( dest == src1 );
  } else if( id == 1 ) {
    assert( dest == src2 );
  }

  return 0;
}
