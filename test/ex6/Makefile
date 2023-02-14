#
# Makefile
#
# makefile: ex5
#
# Copyright (C) 2017-2020 Tactical Computing Laboratories, LLC
# All Rights Reserved
# contact@tactcomplabs.com
#
# See LICENSE in the top level directory for licensing details
#

.PHONY: src

EXAMPLE=ex6
CC=riscv64-unknown-linux-gnu-gcc
# CC=riscv64-unknown-elf-gcc
ARCH=rv64imafdc

all: $(EXAMPLE).exe
$(EXAMPLE).exe: $(EXAMPLE).c
	$(CC) -march=$(ARCH) $(EXAMPLE).c -o $(EXAMPLE).exe --save-temps
clean:
	rm -Rf $(EXAMPLE).exe

#-- EOF
