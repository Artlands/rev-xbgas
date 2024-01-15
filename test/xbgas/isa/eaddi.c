/*
 * eaddi.c
 *
 * RISC-V ISA: RV64GX
 *
 * Copyright (C) 2017-2023 Tactical Computing Laboratories, LLC
 * All Rights Reserved
 * contact@tactcomplabs.com
 *
 * See LICENSE in the top level directory for licensing details
 *
 */

#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include "../../isa/isa_test_macros.h"

int main(int argc, char **argv){
  uint64_t namespace = 5;

  asm volatile(
    " eaddie e12, %[x], 0 \n\t "
    :
    : [x] "r" (namespace)
  );

  asm volatile(
    " eaddi x5, e12, 0 \n\t "
  );

  asm volatile(" beq x5, %[x], pass \n\t "
                 : 
                 : [x] "r" (namespace)
  );

  asm volatile("pass:" );
  asm volatile("j continue");

  asm volatile("fail:" );
  assert(false);

  asm volatile("continue:");
  asm volatile("li ra, 0x0");

  return 0;
}
