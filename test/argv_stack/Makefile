#
# Makefile
#
# makefile: argv_stack
#
# Copyright (C) 2017-2024 Tactical Computing Laboratories, LLC
# All Rights Reserved
# contact@tactcomplabs.com
#
# See LICENSE in the top level directory for licensing details
#

.PHONY: src

EXAMPLE=argv_stack
CC=${RVCC}
ARCH=rv64imafdc

all: $(EXAMPLE).exe
$(EXAMPLE).exe: $(EXAMPLE).c
	$(CC) -march=$(ARCH) -O3 -static -o $(EXAMPLE).exe $(EXAMPLE).c
clean:
	rm -Rf $(EXAMPLE).exe

#-- EOF
