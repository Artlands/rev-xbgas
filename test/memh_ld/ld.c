/*
 * ld.c
 *
 * RISC-V ISA: RV32I
 *
 * Copyright (C) 2017-2023 Tactical Computing Laboratories, LLC
 * All Rights Reserved
 * contact@tactcomplabs.com
 *
 * See LICENSE in the top level directory for licensing details
 *
 */

// #include <stdlib.h>
// #include <unistd.h>

int main(int argc, char **argv){
  int i = 9;
  int j = 10;
  i = i + j;
  if( i == 19 )
    while(1);
  else
    return i;
}