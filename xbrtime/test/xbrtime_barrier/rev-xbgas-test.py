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

PROGRAM = "barrier.exe"
MEMSIZE = 1024*1024*1024
ENABLE_XBGAS = 1
VERBOSE0 = 2
VERBOSE1 = 2

cpu0_params = {
  "verbose" : VERBOSE0,                                # Verbosity
  "clock" : "1.0GHz",                           # Clock
  "program" : os.getenv("REV_EXE", PROGRAM),    # Target executable
  "memSize" : MEMSIZE,                          # Memory size in bytes
  "startAddr" : "[0:0x00000000]",               # Starting address for core 0
  "machine" : "[0:RV64IMAFDX]",
  "memCost" : "[0:1:10]",                       # Memory loads required 1-10 cycles
  "enable_xbgas" : ENABLE_XBGAS,                           # Enable XBGAS support  
  "splash" : 1                                  # Display the splash message
}

cpu1_params = {
  "verbose" : VERBOSE1,                                # Verbosity
  "clock" : "1.0GHz",                           # Clock
  "program" : os.getenv("REV_EXE", PROGRAM),    # Target executable
  "memSize" : MEMSIZE,                          # Memory size in bytes
  "startAddr" : "[0:0x00000000]",               # Starting address for core 0
  "machine" : "[0:RV64IMAFDX]",
  "memCost" : "[0:1:10]",                       # Memory loads required 1-10 cycles
  "enable_xbgas" : ENABLE_XBGAS,                           # Enable XBGAS support  
  "splash" : 0                                  # Display the splash message
} 

# Define the simulation components
xbgas_cpu0 = sst.Component("cpu0", "revcpu.RevCPU")
xbgas_cpu0.addParams(cpu0_params)

xbgas_cpu1 = sst.Component("cpu1", "revcpu.RevCPU")
xbgas_cpu1.addParams(cpu1_params)

if( ENABLE_XBGAS == 1 ):
  # setup the remote memory controllers
  rmt_mem_ctr0 = xbgas_cpu0.setSubComponent("remote_memory", "revcpu.RevBasicRmtMemCtrl")
  rmt_mem_ctr1 = xbgas_cpu1.setSubComponent("remote_memory", "revcpu.RevBasicRmtMemCtrl")

  # setup the xBGAS NICs
  nic0 = xbgas_cpu0.setSubComponent("xbgas_nic", "revcpu.XbgasNIC")
  nic1 = xbgas_cpu1.setSubComponent("xbgas_nic", "revcpu.XbgasNIC")

  iface0 = nic0.setSubComponent("iface", "merlin.linkcontrol")
  iface1 = nic1.setSubComponent("iface", "merlin.linkcontrol")

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
  nic1.addParams(verb_params)

  iface0.addParams(net_params)
  iface1.addParams(net_params)
  router.addParams(net_params)

  router.addParams({
      "xbar_bw" : "10GB/s",
      "flit_size" : "32B",
      "num_ports" : "2",
      "id" : 0
  })

  # setup the links
  link0 = sst.Link("link0")
  link0.connect( (iface0, "rtr_port", "2us"), (router, "port0", "2us") )

  link1 = sst.Link("link1")
  link1.connect( (iface1, "rtr_port", "2us"), (router, "port1", "2us") )

# EOF
