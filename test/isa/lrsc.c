/*
 * add.c
 *
 * RISC-V ISA: RV32I
 *
 * Copyright (C) 2017-2024 Tactical Computing Laboratories, LLC
 * All Rights Reserved
 * contact@tactcomplabs.com
 *
 * See LICENSE in the top level directory for licensing details
 *
 */
#include "../../common/syscalls/syscalls.h"
#include "../syscalls/malloc/malloc.h"
#include "../syscalls/printf/printf.h"
#include "isa_test_macros.h"
#include <stdbool.h>
#include <unistd.h>

// Function to perform an atomic compare-and-swap using lr.w and sc.w
// Compares the value at a memory address with an expected value, and if they match, it updates
// the value at the address with a new value. The function returns 1 if the operation was successful,
int atomic_cas( volatile uint32_t* ptr, uint32_t expected, uint32_t desired ) {
  uint32_t old_val;
  uint32_t success;

  asm volatile( "retry:\n"
                "lr.w %[old_val], (%[ptr])\n"              // Load reserved word from the address
                "bne  %[old_val], %[expected], done\n"     // If the loaded value != expected, exit
                "sc.w %[success], %[desired], (%[ptr])\n"  // Try to store the desired value conditionally
                "bnez %[success], retry\n"                 // If store-conditional failed, retry
                "done:\n"
                : [old_val] "=&r"( old_val ), [success] "=&r"( success )
                : [ptr] "r"( ptr ), [expected] "r"( expected ), [desired] "r"( desired )
                : "memory" );

  return ( old_val == expected );
}

int main() {
  printf( "Hello\n" );
  volatile uint32_t test_val = 42;
  uint32_t          expected = 42;
  uint32_t          desired  = 100;

  // Perform the atomic CAS operation
  int cas_result             = atomic_cas( &test_val, expected, desired );

  // Check if the CAS operation succeeded
  if( cas_result && test_val == desired ) {
    assert( true );
  } else {
    assert( false );
  }
  return 0;
}
