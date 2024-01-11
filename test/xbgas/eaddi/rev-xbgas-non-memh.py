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

PROGRAM = "eaddi.exe"
MEMSIZE = 1024*1024*1024 - 1
ENABLE_XBGAS = 1
VERBOSE0 = 5
VERBOSE1 = 5

cpu0_params = {
  "verbose" : VERBOSE0,                         # Verbosity
  "clock" : "1.0GHz",                           # Clock
  "program" : os.getenv("REV_EXE", PROGRAM),    # Target executable
  "memSize" : MEMSIZE,                          # Memory size in bytes
  "startAddr" : "[0:0x00000000]",               # Starting address for core 0
  "machine" : "[0:RV64GCX]",
  "memCost" : "[0:1:10]",                       # Memory loads required 1-10 cycles
  "enable_xbgas" : ENABLE_XBGAS,                # Enable XBGAS support  
  "enable_memH": 0,                             # Enable memHierarchy support
  "splash" : 1                                  # Display the splash message
}

cpu1_params = {
  "verbose" : VERBOSE1,                         # Verbosity
  "clock" : "1.0GHz",                           # Clock
  "program" : os.getenv("REV_EXE", PROGRAM),    # Target executable
  "memSize" : MEMSIZE,                          # Memory size in bytes
  "startAddr" : "[0:0x00000000]",               # Starting address for core 0
  "machine" : "[0:RV64GCX]",
  "memCost" : "[0:1:10]",                       # Memory loads required 1-10 cycles
  "enable_xbgas" : ENABLE_XBGAS,                # Enable XBGAS support  
  "enable_memH": 0,                             # Enable memHierarchy support
  "splash" : 0                                  # Display the splash message
}

lsq_params = {
  "verbose" : 5,
  "clock" : "2.0GHz",
  "max_loads" : 16,
  "max_stores" : 16,
  "max_flush" : 16,
  "max_llsc" : 16,
  "max_readlock" : 16,
  "max_writeunlock" : 16,
  "max_custom" : 16,
  "ops_per_cycle" : 16
}

memctrl_params = {
  "clock": "2GHz",
  "addr_range_start": 0,
  "addr_range_end": MEMSIZE,
  "backing": "malloc"
}

mem_params = {
  "access_time" : "100ns",
  "mem_size" : "8GB"
}

net_params = {
  "port_name": "port",
  "input_buf_size" : "512B",
  "output_buf_size" : "512B",
  "link_bw" : "10GB/s"
}

router_params = {
  "xbar_bw" : "10GB/s",
  "id" : 0,
  "input_buf_size" : "512B",
  "num_ports" : "2",
  "flit_size" : "32B",
  "output_buf_size" : "512B",
  "link_bw" : "10GB/s",
  "topology" : "merlin.singlerouter"
}

# Define the xBGAS CPU components
xbgas_cpu0 = sst.Component("cpu0", "revcpu.RevCPU")
xbgas_cpu0.addParams(cpu0_params)

xbgas_cpu1 = sst.Component("cpu1", "revcpu.RevCPU")
xbgas_cpu1.addParams(cpu1_params)

################ xBGAS Configuration #####################

# Create remote memory controllers
rmt_lsq0 = xbgas_cpu0.setSubComponent("remote_memory", "revcpu.RevBasicRmtMemCtrl")
rmt_nic0 = rmt_lsq0.setSubComponent("xbgasNicIface", "revcpu.XbgasNIC")
# rmt_nic0_iface = rmt_nic0.setSubComponent("iface", "merlin.linkcontrol")
# rmt_nic0_iface.addParams(net_params)

rmt_lsq1 = xbgas_cpu1.setSubComponent("remote_memory", "revcpu.RevBasicRmtMemCtrl")
rmt_nic1 = rmt_lsq1.setSubComponent("xbgasNicIface", "revcpu.XbgasNIC")
# rmt_nic1_iface = rmt_nic1.setSubComponent("iface", "merlin.linkcontrol")
# rmt_nic1_iface.addParams(net_params)

# setup the router
router = sst.Component("router", "merlin.hr_router")
router.addParams(router_params)
router.setSubComponent("topology", "merlin.singlerouter")

# setup the links
link_if_rtr0 = sst.Link("link_rmt_nic0")
link_if_rtr0.connect( (rmt_nic0, "port", "2us"), (router, "port0", "2us") )
# link_if_rtr0.connect( (rmt_nic0_iface, "rtr_port", "2us"), (router, "port0", "2us") )

link_if_rtr1 = sst.Link("link_rmt_nic1")
link_if_rtr1.connect( (rmt_nic1, "port", "2us"), (router, "port1", "2us") )
# link_if_rtr1.connect( (rmt_nic1_iface, "rtr_port", "2us"), (router, "port1", "2us") )

# EOF
