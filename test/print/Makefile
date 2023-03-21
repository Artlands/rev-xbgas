#
# Makefile
#
# makefile: print
#
# Copyright (C) 2017-2020 Tactical Computing Laboratories, LLC
# All Rights Reserved
# contact@tactcomplabs.com
#
# See LICENSE in the top level directory for licensing details
#

.PHONY: src

EXAMPLE=print
# CC=riscv64-unknown-linux-gnu-gcc
CC=riscv64-unknown-elf-gcc
OBJDUMP=riscv64-unknown-elf-objdump
ARCH=rv64imafd

XBRTIME_SST=/home/li29729/SST/rev-xbgas/src/xbgas_runtime

XBRTIME_SST=/home/li29729/SST/rev-xbgas/src/xbgas_runtime
CFLAGS=-std=c11 -O0 -I$(XBRTIME_SST) -L$(XBRTIME_SST)
LIBS=-lxbrtime -lm

all: $(EXAMPLE).exe
$(EXAMPLE).exe: $(EXAMPLE).c
	$(CC) -march=$(ARCH) -mabi=lp64d $(CFLAGS) -o $@ $^  $(LIBS)
# $(CC) -march=$(ARCH) $(EXAMPLE).c -o $(EXAMPLE).exe --save-temps

objdump:
	$(OBJDUMP) -d $(EXAMPLE).exe > $(EXAMPLE).asm


clean:
	rm -Rf $(EXAMPLE).exe $(EXAMPLE).asm *.txt *.s

#-- EOF
