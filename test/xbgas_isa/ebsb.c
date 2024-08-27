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
#include "../../common/syscalls/syscalls.h"
#include "../isa/isa_test_macros.h"
#include "../syscalls/malloc/malloc.h"
#include "../syscalls/printf/printf.h"
#include <stdbool.h>
#include <unistd.h>

extern int __xbrtime_asm_get_id();
extern int __xbrtime_asm_get_npes();

int main( int argc, char** argv ) {

  int id    = __xbrtime_asm_get_id();
  int npes  = __xbrtime_asm_get_npes();
  int nelem = 8;

  printf( "Hello from PE %d of %d\n", id, npes );

  uint64_t namespace;
  int8_t* dest  = malloc( sizeof( int8_t ) * nelem );

  // Initialize the source arrays
  int8_t src1[] = { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07 };
  int8_t src2[] = { 0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff };

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
    asm volatile( " ebsb %0, %1, %2, %3 \n\t " : : "r"( src2 ), "r"( dest ), "r"( nelem ), "r"( sizeof( int8_t ) ) );
  }

  for( int i = 0; i < nelem; i++ ) {
    if( id == 1 ) {
      printf( "PE %d: dest[%d] = 0x%02x\n", id, i, dest[i] );
      assert( dest[i] == src2[i] );
    }
  }
  // Free the allocated memory
  free( dest );
  return 0;
}
