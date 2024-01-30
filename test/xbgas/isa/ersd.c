/*
 * ersd.c
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
#include "../../../common/syscalls/syscalls.h"
#include "../../syscalls/printf/printf.h"
#include "../../isa/isa_test_macros.h"
#include <unistd.h>
#include <stdbool.h>


extern int __xbrtime_asm_get_id();
extern int __xbrtime_asm_get_npes();

int main(int argc, char **argv){

  int id = __xbrtime_asm_get_id();
  int npes = __xbrtime_asm_get_npes();

  printf("Hello from PE %d of %d\n", id, npes);

  uint64_t namespace;
  uint64_t dest = 0xdeadbeefdeadbeef;

  uint64_t src1 = 0x00ff00ff00ff00ff;
  uint64_t src2 = 0xff00ff00ff00ff00;


  if (id == 0) {
    namespace = 2;
  } else if (id == 1) {
    namespace = 1;
  }

  // Set the remote namespace
  asm volatile(
    " eaddie e6, %0, 0 \n\t "
    :
    : "r" (namespace)
  );

  // Load the source value
  if (id == 0) {
    asm volatile(
      " mv x5, %0 \n\t "
      :
      : "r" (src2)
    );
  } else if (id == 1) {
    asm volatile(
      " mv x5, %0 \n\t "
      :
      : "r" (src1)
    );
  }

  // Remote store
  asm volatile(
    " ersd x5, %0, e6 \n\t "
    :
    : "r" (&dest)
  );

  // Wait in a loop
  while (dest == 0xdeadbeefdeadbeef) {
    asm volatile(" nop ");
  }

  // Print the value in dest
  printf("PE %d: dest = 0x%lx\n", id, dest);

  if (id == 0) {
    assert(dest == src1);
  } else if (id == 1) {
    assert(dest == src2);
  }

  return 0;
}
