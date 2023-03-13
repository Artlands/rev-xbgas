#
# src/Makefile
#
# Integrated makefile to build the XBRTIME library
#
# Copyright (C) 2017-2021 Tactical Computing Laboratories, LLC
# All Rights Reserved
# contact@tactcomplabs.com
#
# See LICENSE in the top level directory for licensing details
#

# CXX=riscv64-unknown-linux-gnu-gcc
CXX=riscv64-unknown-elf-gcc
ARCH=rv64imafd

C_FLAGS=-std=c11

XBRTIME_SOURCES := $(wildcard *.c)

XBRTIME_HEADERS := $(wildcard *.h)

XBRTIME_ASM := $(wildcard *.s)

XBRTIME_OBJS := $(patsubst %.c,%.o,$(wildcard *.c))

all: libxbrtime.a

debug: C_FLAGS += -D_XBGAS_DEBUG_ -g
debug: libxbrtime.a

libxbrtime.a: $(XBRTIME_OBJS)
	ar rcs $@ *.o
%.o:%.c
	$(CXX) -march=$(ARCH) $(C_FLAGS) $(XBRTIME_HEADERS) $(XBRTIME_ASM) -c $<
clean:
	rm -Rf *.o libxbrtime.a *.h.gch

#-- EOF
