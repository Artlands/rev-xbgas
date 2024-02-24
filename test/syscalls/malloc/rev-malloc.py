#
# Copyright (C) 2017-2023 Tactical Computing Laboratories, LLC
# All Rights Reserved
# contact@tactcomplabs.com
#
# See LICENSE in the top level directory for licensing details
#
# rev-backingstore.py
#

import os
import sst

VERBOSE = 1
MEM_SIZE = 1024*1024*1024-1

# Define the simulation components
comp_cpu = sst.Component("cpu", "revcpu.RevCPU")
comp_cpu.addParams({
        "verbose" : VERBOSE,                                # Verbosity
        "numCores" : 1,                               # Number of cores
        "clock" : "2.0GHz",                           # Clock
        "memSize" : MEM_SIZE,                         # Memory size in bytes
        "machine" : "[0:RV64GC]",                      # Core:Config; RV64G for core 0
        "startAddr" : "[0:0x00000000]",               # Starting address for core 0
        "memCost" : "[0:1:10]",                       # Memory loads required 1-10 cycles
        "program" : os.getenv("REV_EXE", "malloc.exe"),  # Target executable
        "enable_memH" : 0,                            # Enable memHierarchy support
        "splash" : 1                                  # Display the splash message
})
