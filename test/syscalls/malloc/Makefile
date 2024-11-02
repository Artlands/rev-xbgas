#
# Makefile
#
# makefile: ex2
#
# Copyright (C) 2017-2024 Tactical Computing Laboratories, LLC
# All Rights Reserved
# contact@tactcomplabs.com
#
# See LICENSE in the top level directory for licensing details
#

.PHONY: src

EXAMPLE=malloc
#CC=riscv64-unknown-elf-gcc
CC="${RVCC}"
#ARCH=rv64g
ARCH=rv64imafdc
RV_OBJDUMP=riscv64-unknown-elf-objdump

all: $(EXAMPLE).exe
$(EXAMPLE).exe: $(EXAMPLE).c
	$(CC) -march=$(ARCH) -O0 -o $(EXAMPLE).exe $(EXAMPLE).c -static
clean:
	rm -Rf $(EXAMPLE).exe

dump: $(EXAMPLE).exe
	$(foreach var,$(EXAMPLE).exe,$(RV_OBJDUMP) -d $(var) > $(var).dump;)

#-- EOF
