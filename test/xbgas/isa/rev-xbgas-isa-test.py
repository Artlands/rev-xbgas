#
# Copyright (C) 2017-2023 Tactical Computing Laboratories, LLC
# All Rights Reserved
# contact@tactcomplabs.com
#
# See LICENSE in the top level directory for licensing details
#
# rev-test-xbgas-isa.py
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
import sys

if len(sys.argv) != 2:
    sys.stderr.write("Usage: You must pass the executable you wish to simulate using the '--model-options' option with sst")
    raise SystemExit(1)

# Define SST core options
sst.setProgramOption("timebase", "1ps")

# Tell SST what statistics handling we want
sst.setStatisticLoadLevel(4)

cpu0_params = {
  "verbose" : 1,                                  # Verbosity
  "clock" : "1.0GHz",                             # Clock
  "program" : os.getenv("REV_EXE",  sys.argv[1]), # Target executable
  "memSize" : 1024*1024*1024,                     # Memory size in bytes
  "startAddr" : "[0:0x00000000]",                 # Starting address for core 0
  "machine" : "[0:RV64GCX]",
  "memCost" : "[0:1:10]",                         # Memory loads required 1-10 cycles
  "enable_xbgas" : 1,                             # Enable XBGAS support  
  "enable_memH": 1,                               # Enable memHierarchy support
  "splash" : 1                                    # Display the splash message
}

cpu1_params = {
  "verbose" : 5,                                  # Verbosity
  "clock" : "1.0GHz",                             # Clock
  "program" : os.getenv("REV_EXE",  sys.argv[1]), # Target executable
  "memSize" : 1024*1024*1024,                     # Memory size in bytes
  "startAddr" : "[0:0x00000000]",                 # Starting address for core 0
  "machine" : "[0:RV64GCX]",
  "memCost" : "[0:1:10]",                         # Memory loads required 1-10 cycles
  "enable_xbgas" : 1,                             # Enable XBGAS support  
  "enable_memH": 1,                               # Enable memHierarchy support
  "splash" : 0                                    # Display the splash message
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
  "addr_range_end": 1024*1024*1024-1,
  "backing": "malloc"
}

mem_params = {
  "access_time" : "100ns",
  "mem_size" : "1GB"
}

net_params = {
  "input_buf_size" : "512B",
  "output_buf_size" : "512B",
  "link_bw" : "10GB/s"
}

router_params = {
  "xbar_bw" : "10GB/s",
  "flit_size" : "32B",
  "num_ports" : "2",
  "id" : 0
}

# Define the xBGAS CPU components
xbgas_cpu0 = sst.Component("cpu0", "revcpu.RevCPU")
xbgas_cpu0.addParams(cpu0_params)

xbgas_cpu1 = sst.Component("cpu1", "revcpu.RevCPU")
xbgas_cpu1.addParams(cpu1_params)

# Create the RevMemCtrl subcomponent
lsq0 = xbgas_cpu0.setSubComponent("memory", "revcpu.RevBasicMemCtrl")
lsq0.addParams(lsq_params)

lsq1 = xbgas_cpu1.setSubComponent("memory", "revcpu.RevBasicMemCtrl")
lsq1.addParams(lsq_params)

# Create the memHierarchy subcomponent
miface0 = lsq0.setSubComponent("memIface", "memHierarchy.standardInterface")
miface1 = lsq1.setSubComponent("memIface", "memHierarchy.standardInterface")

# Create the memory controller in memHierarchy
memctrl0 = sst.Component("memory0", "memHierarchy.MemController")
memctrl0.addParams(memctrl_params)

memctrl1 = sst.Component("memory1", "memHierarchy.MemController")
memctrl1.addParams(memctrl_params)

# Create the memory backend subcomponent
memory0 = memctrl0.setSubComponent("backend", "memHierarchy.simpleMem")
memory0.addParams(mem_params)

memory1 = memctrl1.setSubComponent("backend", "memHierarchy.simpleMem")
memory1.addParams(mem_params)

# setup the links
link_miface_mem0 = sst.Link("link_miface_mem0")
link_miface_mem0.connect( (miface0, "port", "50ps"), (memctrl0, "direct_link", "50ps") )

link_miface_mem1 = sst.Link("link_miface_mem1")
link_miface_mem1.connect( (miface1, "port", "50ps"), (memctrl1, "direct_link", "50ps") )

################ xBGAS Configuration #####################

# Create remote memory controllers
rmt_lsq0 = xbgas_cpu0.setSubComponent("remote_memory", "revcpu.RevBasicRmtMemCtrl")
rmt_nic0 = rmt_lsq0.setSubComponent("xbgasNicIface", "revcpu.XbgasNIC")
rmt_nic0_iface = rmt_nic0.setSubComponent("iface", "merlin.linkcontrol")

rmt_lsq1 = xbgas_cpu1.setSubComponent("remote_memory", "revcpu.RevBasicRmtMemCtrl")
rmt_nic1 = rmt_lsq1.setSubComponent("xbgasNicIface", "revcpu.XbgasNIC")
rmt_nic1_iface = rmt_nic1.setSubComponent("iface", "merlin.linkcontrol")

rmt_nic0_iface.addParams(net_params)
rmt_nic1_iface.addParams(net_params)

# setup the router
router = sst.Component("router", "merlin.hr_router")
router.setSubComponent("topology", "merlin.singlerouter")
router.addParams(net_params)
router.addParams(router_params)

# setup the links
link_if_rtr0 = sst.Link("link_rmt_nic0")
link_if_rtr0.connect( (rmt_nic0_iface, "rtr_port", "2us"), (router, "port0", "2us") )
link_if_rtr0.setNoCut()

link_if_rtr1 = sst.Link("link_rmt_nic1")
link_if_rtr1.connect( (rmt_nic1_iface, "rtr_port", "2us"), (router, "port1", "2us") )
link_if_rtr1.setNoCut()

sst.setStatisticOutput("sst.statOutputCSV")
sst.enableAllStatisticsForAllComponents()

# EOF
