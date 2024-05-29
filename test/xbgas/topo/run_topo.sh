#!/bin/bash

#Build the test
make clean && make

# Check that the exec was built...
if [ -x multi-pes.exe ]; then
	sst --add-lib-path=../../build/src/ ./fattree-memh.py
else
	echo "Test XBGAS-TOPO: multi-pes.exe not Found - likely build failed"
	exit 1
fi
