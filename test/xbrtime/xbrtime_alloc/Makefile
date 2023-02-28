#
# Makefile
#
# makefile: init_test_1
#
# Copyright (C) 2017-2020 Tactical Computing Laboratories, LLC
# All Rights Reserved
# contact@tactcomplabs.com
#
# See LICENSE in the top level directory for licensing details
#

.PHONY: src

SRCS = $(wildcard *.c)
# EXEC = $(SRCS:.c=.exe)
EXAMPLE=alloc_test_1

CC=riscv64-unknown-elf-gcc
# CC=riscv64-unknown-linux-gnu-gcc
OBJDUMP=riscv64-unknown-elf-objdump
ARCH=rv64imafd
XBRTIME_INCLUDE=-I../../../src/xbgas_runtime
XBRTIME_LIB=-L../../../src/xbgas_runtime -lxbrtime

all: $(EXAMPLE).exe

%.exe:%.c
	$(CC) -march=$(ARCH) -mabi=lp64d $(XBRTIME_INCLUDE) -o $@ $< $(XBRTIME_LIB)

objdump:
	$(OBJDUMP) -d $(EXAMPLE).exe > $(EXAMPLE).asm

clean:
	rm -Rf *.exe *.s *.o *.i *.csv *.asm

#-- EOF