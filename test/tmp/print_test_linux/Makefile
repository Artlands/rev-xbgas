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

CC=riscv64-unknown-linux-gnu-gcc
OBJDUMP=riscv64-unknown-linux-gnu-objdump
ARCH=rv64imafd

all: $(EXEC)

%.exe:%.c
	$(CC) -march=$(ARCH) -o $@ $< 

objdump:
	$(OBJDUMP) -D $(EXEC) > $(ASM)

clean:
	rm -Rf *.exe *.asm

#-- EOF