#
# Copyright (C) 2017-2020 Tactical Computing Laboratories, LLC
# All Rights Reserved
# contact@tactcomplabs.com
#
# See LICENSE in the top level directory for licensing details
#
# rev-xbgas-test.py
#

# ---------------------------------------------------------------
#
#  xbgas_host0           xbgas_host1
#      |                     |
#     nic0                  nic1
#      |                     |
#    iface0 <-> router <-> iface1
#                  |
#               topology
#
#   <-> is a link
#   | is a subcomponent relationship

import os
import sst

# Define SST core optionss
sst.setProgramOption("timebase", "1ps")
sst.setProgramOption("stopAtCycle", "0s")

# Tell SST what statistics handling we want
sst.setStatisticLoadLevel(4)

# Define the simulation components
xbgas_cpu0 = sst.Component("cpu0", "revcpu.RevCPU")
xbgas_cpu0.addParams({
          "verbose" : 5,                                # Verbosity
          "numCores" : 1,                               # Number of cores
          "clock" : "1.0GHz",                           # Clock
          "memSize" : 1*1024*1024*1024,                   # Memory size in bytes
          "machine" : "[0:RV64IMAFDX]",                 # Core:Config; 
          "startAddr" : "[0:0x00000000]",               # Starting address for core 0
          "memCost" : "[0:1:10]",                       # Memory loads required 1-10 cycles
          "xbgas_nic" : "revcpu.XbgasNIC",
          "enable_xbgas" : 0,
          "enable_xbgas_test" : 0,                      # Enable the XBGAS test harness
          "msgPerCycle": 10,
          "program" : os.getenv("REV_EXE", "print_test_1.exe"),  # Target executable
          "splash" : 1                                  # Display the splash message
})

# setup the NICs
nic0 = xbgas_cpu0.setSubComponent("xbgas_nic", "revcpu.XbgasNIC")

# EOF
