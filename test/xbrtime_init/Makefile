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

CC=riscv64-unknown-linux-gnu-gcc
ARCH=rv64imafd
XBRTIME_INCLUDE=-I../../src/xbgas_runtime
XBRTIME_LIB=-L../../src/xbgas_runtime -lxbrtime

all: $(EXEC)

%.exe:%.c
	$(CC) -march=$(ARCH) $(XBRTIME_INCLUDE) -o $@ $< $(XBRTIME_LIB)

clean:
	rm -Rf *.exe

#-- EOF