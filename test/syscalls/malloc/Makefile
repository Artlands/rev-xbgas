#
# Makefile
#
# makefile: ex2
#
# Copyright (C) 2017-2025 Tactical Computing Laboratories, LLC
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

RISCV_GCC_OPTS ?= -DPREALLOCATE=1 -mcmodel=medany -static  -std=gnu17 -O0 -ffast-math -fno-common -fno-builtin-printf -march=$(ARCH) -mabi=lp64d -fsignaling-nans -frounding-math -fno-associative-math

all: $(EXAMPLE).exe
$(EXAMPLE).exe: $(EXAMPLE).c
	$(CC) $(RISCV_GCC_OPTS) -o $@ $^ -static -lm -Wl,-e,main
clean:
	rm -Rf $(EXAMPLE).exe

dump: $(EXAMPLE).exe
	$(foreach var,$(EXAMPLE).exe,$(RV_OBJDUMP) -d $(var) > $(var).dump;)

#-- EOF
