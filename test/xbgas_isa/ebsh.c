/*
 * ebsh.c
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

  int id    = __xbrtime_asm_get_id();
  int npes  = __xbrtime_asm_get_npes();
  int nelem = 8;
  int flag  = 0;

  uint64_t namespace;
  int16_t* dest  = malloc( sizeof( int16_t ) * nelem );

  // Initialize the source arrays
  int16_t src1[] = { 0x00ff, 0x01ff, 0x02ff, 0x03ff, 0x04ff, 0x05ff, 0x06ff, 0x07ff };
  int16_t src2[] = { 0xfff8, 0xfff9, 0xfffa, 0xfffb, 0xfffc, 0xfffd, 0xfffe, 0xffff };

  if( id == 0 ) {
    namespace = 2;
  } else if( id == 1 ) {
    namespace = 1;
  }

  // Set the remote namespace
  asm volatile( " eaddie e14, %0, 0 \n\t " : : "r"( namespace ) );

  // Load the source address
  if( id == 0 ) {
    // Remote bulk store
    asm volatile( " ebsh %0, %1, %2, %3 \n\t " : "=r"( flag ) : "r"( src2 ), "r"( dest ), "r"( nelem ) );
  }

  // Wait for a few cycles
  for( int i = 0; i < 100; i++ ) {
    asm( "nop" );
  }

  for( int i = 0; i < nelem; i++ ) {
    if( id == 1 ) {
      printf( "PE %d: dest[%d] = 0x%02x", id, i, dest[i] );
      assert( dest[i] == src2[i] );
    }
  }
  // Free the allocated memory
  free( dest );
  return 0;
}
