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

int main(int argc, char **argv){
  int i = 9;
  i = i + argc;
  return i;
}
