#
# Makefile
#
# makefile: xbgas_isa
#
# Copyright (C) 2017-2020 Tactical Computing Laboratories, LLC
# All Rights Reserved
# contact@tactcomplabs.com
#
# See LICENSE in the top level directory for licensing details
#

.PHONY: src

EXAMPLE=ebld

CC=riscv64-unknown-elf-gcc
OBJDUMP=riscv64-unknown-elf-objdump

ARCH=rv64imafd

all: $(EXAMPLE).exe
$(EXAMPLE).exe:$(EXAMPLE).c
	$(CC) -march=$(ARCH) -o $(EXAMPLE).exe $(EXAMPLE).c

objdump:
	$(OBJDUMP) -d -t -r $(EXAMPLE).exe > $(EXAMPLE).obj

clean:
	rm -Rf $(EXAMPLE).exe $(EXAMPLE).obj

#-- EOF