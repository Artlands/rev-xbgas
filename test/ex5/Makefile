#
# Makefile
#
# makefile: ex5
#
# Copyright (C) 2017-2020 Tactical Computing Laboratories, LLC
# All Rights Reserved
# contact@tactcomplabs.com
#
# See LICENSE in the top level directory for licensing details
#

.PHONY: src

EXAMPLE=ex5
CC=riscv64-unknown-elf-gcc
OBJDUMP=riscv64-unknown-elf-objdump
ARCH=rv64imafd

all: $(EXAMPLE).exe
$(EXAMPLE).exe: $(EXAMPLE).c
	$(CC) -march=$(ARCH) -o $(EXAMPLE).exe $(EXAMPLE).c

objdump:
	$(OBJDUMP) -d $(EXAMPLE).exe > $(EXAMPLE).asm
	
clean:
	rm -Rf $(EXAMPLE).exe

#-- EOF
