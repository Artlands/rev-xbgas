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

NPES = 4

verb_params = {
  "verbose" : 5,
}

net_params = {
  "input_buf_size" : "512B",
  "output_buf_size" : "512B",
  "link_bw" : "10GB/s"
}

# setup the router
router = sst.Component("router", "merlin.hr_router")
router.setSubComponent("topology", "merlin.singlerouter")
router.addParams(net_params)

router.addParams({
    "xbar_bw" : "10GB/s",
    "flit_size" : "32B",
    "num_ports" : str(NPES),
    "id" : 0
})

for i in range(0, NPES):
  if (i == 0):
    verbose = 5
    splash = 1
  else:
    verbose = 4
    splash = 0
  
  # xBGAS CPUs
  sst.pushNamePrefix("cpu" + str(i))
  xbgas_cpu = sst.Component("xbgas", "revcpu.RevCPU")
  xbgas_cpu.addParams({
    "verbose"           : verbose,                              # Verbosity
    "numCores"          : 1,                                    # Number of cores
    "clock"             : "1.0GHz",                             # Clock
    "memSize"           : 2*1024*1024*1024,                     # Memory size in bytes
    "machine"           : "[0:RV64IMAFDCX]",                    # Core:Config; 
    "startAddr"         : "[0:0x00000000]",                     # Starting address for core 0
    "memCost"           : "[0:1:10]",                           # Memory loads required 1-10 cycles
    "xbgas_nic"         : "revcpu.XbgasNIC",
    "enable_xbgas"      : 1,
    "enable_xbgas_test" : 0,                                    # Enable the XBGAS test harness
    "msgPerCycle"       : 10,
    "program"           : os.getenv("REV_EXE", "xfer_alltoall.exe"), # Target executable
    "splash"            : splash                                # Display the splash message
  })
  print("Created xBGAS CPU component " + str(i) + ": " + xbgas_cpu.getFullName())
  sst.popNamePrefix()
  
  # Setup the NICs
  nic   = xbgas_cpu.setSubComponent("xbgas_nic", "revcpu.XbgasNIC")
  iface = nic.setSubComponent("iface", "merlin.linkcontrol")
  nic.addParams(verb_params)
  iface.addParams(net_params)

  # Setup the links
  sst.pushNamePrefix("link" + str(i))
  link = sst.Link("link")
  link.connect( (iface, "rtr_port", "1ms"), (router, f"port{i}", "1ms") )
  sst.popNamePrefix()

# sst.setStatisticOutput("sst.statOutputCSV")
# sst.enableAllStatisticsForAllComponents()

# EOF
