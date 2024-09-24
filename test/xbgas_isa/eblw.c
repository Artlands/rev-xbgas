/*
 * elb.c
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

extern int  __xbrtime_asm_get_id();
extern int  __xbrtime_asm_get_npes();
extern void wait_for_bulk_completion();

int main( int argc, char** argv ) {

  int id    = __xbrtime_asm_get_id();
  int npes  = __xbrtime_asm_get_npes();
  int nelem = 8;

  printf( "Hello from PE %d of %d\n", id, npes );

  uint64_t namespace;
  uint32_t* dest = malloc( sizeof( uint32_t ) * nelem );

  // print address of dest
  printf( "Address of dest: %p\n", dest );

  // Initialize the source arrays
  uint32_t src1[] = { 0x00ff00ff, 0x00ff01ff, 0x00ff02ff, 0x00ff03ff, 0x00ff04ff, 0x00ff05ff, 0x00ff06ff, 0x00ff07ff };
  uint32_t src2[] = { 0xff00fff8, 0xff00fff9, 0xff00fffa, 0xff00fffb, 0xff00fffc, 0xff00fffd, 0xff00fffe, 0xff00ffff };

  if( id == 0 ) {
    namespace = 2;
  } else if( id == 1 ) {
    namespace = 1;
  }

  // Set the remote namespace
  asm volatile( " eaddie e14, %0, 0 \n\t " : : "r"( namespace ) );

  // Load the source address
  if( id == 0 ) {
    // Remote bulk load
    asm volatile( " eblw %0, %1, %2, %3 \n\t " : : "r"( dest ), "r"( src2 ), "r"( nelem ), "r"( sizeof( uint32_t ) ) );
    wait_for_bulk_completion();
    for( int i = 0; i < nelem; i++ ) {
      printf( "PE %d: dest[%d] = 0x%02x\n", id, i, dest[i] );
      assert( dest[i] == src2[i] );
    }
  }

  // Free the allocated memory
  free( dest );
  return 0;
}
