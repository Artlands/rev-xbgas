#!/bin/bash
#
# Copyright (C) 2017-2024 Tactical Computing Laboratories, LLC
# All Rights Reserved
# contact@tactcomplabs.com
#
# See LICENSE in the top level directory for licensing details
#

#Build the test
make clean && make

# Check that the exec was built...
if [[ -x unordered_map_obj.exe ]]; then
  sst --add-lib-path=../../../../build/src/ ./rev-test.py
else
  echo "Test STL CXX unordered_map_obj: unordered_map_obj.exe not Found - likely build failed"
  exit 1
fi
