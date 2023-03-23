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
          "machine" : "[0:RV64IMAFDCX]",                 # Core:Config; 
          "startAddr" : "[0:0x00000000]",               # Starting address for core 0
          "memCost" : "[0:1:10]",                       # Memory loads required 1-10 cycles
          "xbgas_nic" : "revcpu.XbgasNIC",
          "enable_xbgas" : 1,
          "enable_xbgas_test" : 0,                      # Enable the XBGAS test harness
          "msgPerCycle": 10,
          "program" : os.getenv("REV_EXE", "init_test_1.exe"),  # Target executable
          "splash" : 1                                  # Display the splash message
})

# setup the NICs
nic0 = xbgas_cpu0.setSubComponent("xbgas_nic", "revcpu.XbgasNIC")

iface0 = nic0.setSubComponent("iface", "merlin.linkcontrol")

# setup the router
router = sst.Component("router", "merlin.hr_router")
router.setSubComponent("topology", "merlin.singlerouter")

verb_params = {
  "verbose" : 6,
}

net_params = {
  "input_buf_size" : "512B",
  "output_buf_size" : "512B",
  "link_bw" : "10GB/s"
}

nic0.addParams(verb_params)

iface0.addParams(net_params)
router.addParams(net_params)

router.addParams({
    "xbar_bw" : "10GB/s",
    "flit_size" : "32B",
    "num_ports" : "2",
    "id" : 0
})

# setup the links
link0 = sst.Link("link0")
link0.connect( (iface0, "rtr_port", "1ms"), (router, "port0", "1ms") )

# EOF
