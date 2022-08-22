#
# Makefile
#
# makefile: ex1
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

CC=riscv64-unknown-linux-gnu-gcc
ARCH=rv64imafd

all: $(EXEC)
%.exe: %.c
	$(CC) -march=$(ARCH) -o $@ $<;
clean:
	rm -Rf *.exe *.asm *.s

#-- EOF