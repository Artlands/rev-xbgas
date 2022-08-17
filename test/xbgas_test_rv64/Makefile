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

PE0=xbgas_test
PE1=xbgas_test_1
CC=riscv64-unknown-linux-gnu-gcc
ARCH=rv64imafd

all: $(PE0).exe $(PE1).exe
$(PE0).exe: $(PE0).c
	$(CC) -march=$(ARCH) -o $(PE0).exe $(PE0).c
$(PE1).exe: $(PE1).c
	$(CC) -march=$(ARCH) -o $(PE1).exe $(PE1).c
clean:
	rm -Rf *.exe

#-- EOF