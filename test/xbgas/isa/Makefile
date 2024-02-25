#
# Makefile
#
# makefile: ex1
#
# Copyright (C) 2017-2023 Tactical Computing Laboratories, LLC
# All Rights Reserved
# contact@tactcomplabs.com
#
# See LICENSE in the top level directory for licensing details
#

.PHONY: src

CC=${RVCC}
AS=${RVAS}
ARCH=rv64imafdc
RV_OBJDUMP=riscv64-unknown-elf-objdump

ISA_SOURCES := $(wildcard *.c)
ISA_HEADERS := $(wildcard *.h)
ISA_EXES=$(ISA_SOURCES:.c=.exe)
RISCV_GCC_OPTS ?= -mcmodel=medany -static -std=gnu99 -O0 -ffast-math -fno-common -fno-builtin-printf -march=$(ARCH) -mabi=lp64d -w

ifeq "$(RVCC)" "riscv64-unknown-elf-gcc"
	RISCV_GCC_OPTS += -fno-tree-loop-distribute-patterns
endif

all:$(ISA_EXES)
$(ISA_TESTS): $(ISA_EXES)
%.exe:%.c $(ISA_HEADERS) xbrtime_util_asm.o
#	@echo "RISCV_GCC_OPTS = $(RISCV_GCC_OPTS)"
	$(CC) $(RISCV_GCC_OPTS)  -o $@ $^ -static -lm -Wl,-e,main
xbrtime_util_asm.o: xbrtime_util_asm.s
	$(AS) -o $@ $^

dump: $(ISA_EXES)
	$(foreach var,$(ISA_EXES),$(RV_OBJDUMP) -d $(var) > $(var).dump;)

clean:
	rm -Rf *.exe *.dump *.o

#-- EOF
