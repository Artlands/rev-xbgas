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
        "enable_memH" : 1,                            # Enable memHierarchy support
        "splash" : 1                                  # Display the splash message
})

# Create the RevMemCtrl subcomponent
comp_lsq = comp_cpu.setSubComponent("memory", "revcpu.RevBasicMemCtrl")
comp_lsq.addParams({
      "clock"           : "2.0Ghz",
      "max_loads"       : 64,
      "max_stores"      : 64,
      "max_flush"       : 64,
      "max_llsc"        : 64,
      "max_readlock"    : 64,
      "max_writeunlock" : 64,
      "max_custom"      : 64,
      "ops_per_cycle"   : 64
})

iface = comp_lsq.setSubComponent("memIface", "memHierarchy.standardInterface")

l1cache = sst.Component("l1cache", "memHierarchy.Cache")
l1cache.addParams({
    "access_latency_cycles" : "4",
    "cache_frequency" : "2 Ghz",
    "replacement_policy" : "lru",
    "coherence_protocol" : "MESI",
    "associativity" : "4",
    "cache_line_size" : "64",
    "L1" : "1",
    "cache_size" : "16KiB"
})

memctrl = sst.Component("memory", "memHierarchy.MemController")
memctrl.addParams({
    "clock" : "2GHz",
    "addr_range_start" : 0,
    "addr_range_end" : MEM_SIZE,
    "backing" : "mmap",
})

memory = memctrl.setSubComponent("backend", "memHierarchy.simpleMem")
memory.addParams({
    "access_time" : "100ns",
    "mem_size" : "8GB"
})

link1 = sst.Link("link1")
link1.connect( (iface, "port", "1ns"), (l1cache, "high_network_0", "1ns") )
link2 = sst.Link("link2")
link2.connect( (l1cache, "low_network_0", "1ns"), (memctrl, "direct_link", "1ns") )

# EOF
