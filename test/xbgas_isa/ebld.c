/*
 * ebld.c
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
  uint64_t* dest  = malloc( sizeof( uint64_t ) * nelem );

  // Initialize the source arrays
  uint64_t src1[] = {
    0x10ff00ff00ff00ff,
    0x20ff00ff00ff00ff,
    0x30ff00ff00ff00ff,
    0x40ff00ff00ff00ff,
    0x50ff00ff00ff00ff,
    0x60ff00ff00ff00ff,
    0x70ff00ff00ff00ff,
    0x80ff00ff00ff00ff
  };
  uint64_t src2[] = {
    0xff00ff00ff00ff01,
    0xff00ff00ff00ff02,
    0xff00ff00ff00ff03,
    0xff00ff00ff00ff04,
    0xff00ff00ff00ff05,
    0xff00ff00ff00ff06,
    0xff00ff00ff00ff07,
    0xff00ff00ff00ff08
  };

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
    asm volatile( " ebld %0, %1, %2, %3 \n\t " : "=r"( flag ) : "r"( dest ), "r"( src2 ), "r"( nelem ) );
    if( flag != 0 ) {
      for( int i = 0; i < nelem; i++ ) {
        printf( "PE %d: dest[%d] = 0x%lx", id, i, dest[i] );
        assert( dest[i] == src2[i] );
      }
    }
  }

  // Free the allocated memory
  free( dest );
  return 0;
}
