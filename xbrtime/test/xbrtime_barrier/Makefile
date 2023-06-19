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
EXEC = $(SRCS:.c=.exe)
ASM = $(SRCS:.c=.asm)

CC=riscv64-unknown-elf-gcc
OBJDUMP=riscv64-unknown-elf-objdump

ARCH=rv64imafd
XBRTIME_INCLUDE=-I../../include
XBRTIME_LIB=-L../../ -lxbrtime -lm

all: $(EXEC)

%.exe:%.c
	$(CC) -march=$(ARCH) -mabi=lp64d $(XBRTIME_INCLUDE) -o $@ $< $(XBRTIME_LIB)

objdump:
	$(OBJDUMP) -d $(EXEC) > $(ASM)

clean:
	rm -Rf *.exe *.s *.o *.i *.csv *.asm

#-- EOF