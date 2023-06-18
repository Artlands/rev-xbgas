#
# Makefile
#
# makefile: ex2
#
# Copyright (C) 2017-2023 Tactical Computing Laboratories, LLC
# All Rights Reserved
# contact@tactcomplabs.com
#
# See LICENSE in the top level directory for licensing details
#

.PHONY: src

EXAMPLE=ld
CC=riscv64-unknown-elf-gcc
#ARCH=rv64g
ARCH=rv64imafd

OBJDUMP=riscv64-unknown-elf-objdump

all: $(EXAMPLE).exe
$(EXAMPLE).exe:$(EXAMPLE).c
	$(CC) -march=$(ARCH) -o $(EXAMPLE).exe $(EXAMPLE).c

objdump:
	$(OBJDUMP) -d -t -r $(EXAMPLE).exe > $(EXAMPLE).obj

clean:
	rm -Rf $(EXAMPLE).exe

#-- EOF