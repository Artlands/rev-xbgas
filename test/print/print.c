/*
 * math_log.c
 *
 * RISC-V ISA: RV64IMAFDC
 *
 * Copyright (C) 2017-2020 Tactical Computing Laboratories, LLC
 * All Rights Reserved
 * contact@tactcomplabs.com
 *
 * See LICENSE in the top level directory for licensing details
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "xbrtime.h"

int main(int argc, char **argv){

  revprintf( "Test\n" );
  char ch = 'A';
  char str[20] = "test";
  double flt = 12.23;
  int no = 465;
  double dbl = 10.15;
  revprintf("Character is %c \n", ch);
  revprintf("String is %s \n" , str);
  revprintf("Float value is %f \n", flt);
  revprintf("Integer value is %d\n" , no);
  revprintf("Double value is %f \n", dbl);
  // revprintf("Octal value is %d \n", no);
  revprintf("Hexadecimal value is 0x%x \n", no); //Hexadecimal value is
  return 0;

}
