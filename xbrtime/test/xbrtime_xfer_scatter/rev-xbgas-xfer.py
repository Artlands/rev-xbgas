#
# Copyright (C) 2017-2023 Tactical Computing Laboratories, LLC
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
#  rmt_mem_ctrl0        rmt_mem_ctrl1    
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

NPES = 4
PROGRAM = "xfer_scatter.exe"
MEMSIZE = 1024*1024*1024
ENABLE_XBGAS = 1
VERBOSE = 2

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
    splash = 1
  else:
    splash = 0
    
  # xBGAS CPUs
  sst.pushNamePrefix("cpu" + str(i))
  xbgas_cpu = sst.Component("xbgas", "revcpu.RevCPU")
  xbgas_cpu.addParams({
    "verbose" : VERBOSE,                                # Verbosity
    "clock" : "1.0GHz",                           # Clock
    "program" : os.getenv("REV_EXE", PROGRAM),    # Target executable
    "memSize" : MEMSIZE,                          # Memory size in bytes
    "startAddr" : "[0:0x00000000]",               # Starting address for core 0
    "machine" : "[0:RV64IMAFDX]",
    "memCost" : "[0:1:10]",                       # Memory loads required 1-10 cycles
    "enable_xbgas" : ENABLE_XBGAS,                # Enable XBGAS support  
    "splash" : splash                             # Display the splash message
  })
  # print("Created xBGAS CPU component " + str(i) + ": " + xbgas_cpu.getFullName())
  
  xbgas_cpu.enableAllStatistics()
  sst.popNamePrefix()
  
  # setup the remote memory controllers
  rmt_mem_ctrl = xbgas_cpu.setSubComponent("remote_memory", "revcpu.RevBasicRmtMemCtrl")

  # setup the xBGAS NICs
  nic = xbgas_cpu.setSubComponent("xbgas_nic", "revcpu.XbgasNIC")
  iface = nic.setSubComponent("iface", "merlin.linkcontrol")
  nic.addParams(verb_params)
  iface.addParams(net_params)
  
  # Setup the links
  sst.pushNamePrefix("link" + str(i))
  link = sst.Link("link")
  link.connect( (iface, "rtr_port", "25us"), (router, f"port{i}", "25us") )
  sst.popNamePrefix()


# Tell SST what statistics handling we want
# sst.setStatisticLoadLevel(2)
# sst.setStatisticOutput("sst.statOutputCSV")

# EOF
