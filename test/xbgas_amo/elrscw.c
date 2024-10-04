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

// Function to perform an atomic compare-and-swap using elr.w and esc.w
// Compares the value at a memory address with an expected value, and if they match, it updates
// the value at the address with a new value. The function returns 1 if the operation was successful,
int atomic_cas( volatile uint32_t* ptr, uint32_t expected, uint32_t desired ) {
  uint32_t old_val;
  uint32_t success;

  asm volatile( "retry:\n"
                "elr.w %[old_val], (%[ptr])\n"              // Load reserved word from the address
                "bne  %[old_val], %[expected], done\n"      // If the loaded value != expected, exit
                "esc.w %[success], %[desired], (%[ptr])\n"  // Try to store the desired value conditionally
                "bnez %[success], retry\n"                  // If store-conditional failed, retry
                "done:\n"
                : [old_val] "=&r"( old_val ), [success] "=&r"( success )
                : [ptr] "r"( ptr ), [expected] "r"( expected ), [desired] "r"( desired )
                : "memory" );

  return ( old_val == expected );
}

int main( int argc, char** argv ) {

  int id   = __xbrtime_asm_get_id();
  int npes = __xbrtime_asm_get_npes();

  // printf( "Hello from PE %d of %d\n", id, npes );

  uint64_t namespace;
  volatile uint32_t test_val;
  uint32_t          expected;
  uint32_t          desired;
  int               cas_result;

  if( id == 0 ) {
    namespace = 2;
    test_val  = 0xff00;
    expected  = 0xf1f1;
    desired   = 0xf8f8;
  } else if( id == 1 ) {
    namespace = 1;
    test_val  = 0xf2f2;
    expected  = 0xff00;
    desired   = 0xf55f;
  }

  // Before CAS
  if( id == 0 ) {
    printf( "Before CAS: PE %d: test_val = 0x%x ", id, test_val );
  }

  // Set the remote namespace
  asm volatile( " eaddie e13, %0, 0 \n\t " : : "r"( namespace ) );

  if( id == 1 ) {
    cas_result = atomic_cas( &test_val, expected, desired );
    printf( "PE %d: cas_result = %d ", id, cas_result );
    printf( "PE %d: desired = 0x%x ", id, desired );
  } else {
    //Wait for a few cycles
    for( int i = 0; i < 100; i++ ) {
      asm volatile( "" );
    }
    printf( "After CAS: PE %d: test_val = 0x%x ", id, test_val );
  }
}
