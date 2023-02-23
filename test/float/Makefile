#
# Makefile
#
# makefile: float
#
# Copyright (C) 2017-2020 Tactical Computing Laboratories, LLC
# All Rights Reserved
# contact@tactcomplabs.com
#
# See LICENSE in the top level directory for licensing details
#

.PHONY: src

EXAMPLE=float
# CC=riscv64-unknown-linux-gnu-gcc
CC=riscv64-unknown-elf-gcc
OBJDUMP=riscv64-unknown-elf-objdump
ARCH=rv64imafdc

all: $(EXAMPLE).exe
$(EXAMPLE).exe: $(EXAMPLE).c
	$(CC) -march=$(ARCH) $(EXAMPLE).c -o $(EXAMPLE).exe
# $(CC) -march=$(ARCH) $(EXAMPLE).c -o $(EXAMPLE).exe --save-temps

objdump:
	$(OBJDUMP) -d $(EXAMPLE).exe > $(EXAMPLE).asm

clean:
	rm -Rf $(EXAMPLE).exe $(EXAMPLE).asm *.txt

#-- EOF
