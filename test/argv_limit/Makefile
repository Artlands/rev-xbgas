#
# Makefile
#
# makefile: argv_limit
#
# Copyright (C) 2017-2024 Tactical Computing Laboratories, LLC
# All Rights Reserved
# contact@tactcomplabs.com
#
# See LICENSE in the top level directory for licensing details
#

.PHONY: src
EXAMPLE=argv_limit
CC=${RVCC}
ARCH=rv64gc

all: $(EXAMPLE).exe
$(EXAMPLE).exe: $(EXAMPLE).c
	$(CC) -march=$(ARCH) -static -o $(EXAMPLE).exe $(EXAMPLE).c
clean:
	rm -Rf $(EXAMPLE).exe

#-- EOF
