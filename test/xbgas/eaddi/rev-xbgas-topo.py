#
# Copyright (C) 2017-2023 Tactical Computing Laboratories, LLC
# All Rights Reserved
# contact@tactcomplabs.com
#
# See LICENSE in the top level directory for licensing details
#
#

import sst
import argparse
from utils import *
from sst import merlin

# Parse command line arguments
parser = argparse.ArgumentParser(description='Run XBGAS test')
parser.add_argument('--config', '-c', default='xbgas.cfg', help='Config file')
parser.add_argument('--verbose', '-v', default=0, help='Verbose output')

args = parser.parse_args()

cfgFile = args.config
verbose = int(args.verbose)

# Build Configuration Information
config = Config(cfgFile, verbose=verbose)

class EndpointCreator(merlin.EndPoint):  
  def __init__(self, config):
    merlin.EndPoint.__init__(self)
    self.config = config

  def getName(self):
    return "Torus Endpoint Creator"
  
  def build(self, nID, extraKeys):
    print(f"Building xBGAS CPU {nID}")
    xbgas_cpu = sst.Component(f"xbgasCPU{nID}", "revcpu.RevCPU")
    xbgas_cpu.addParams(self.config.getCpuConfig())
    
    # Create the RevMemCtrl subcomponent
    lsq = xbgas_cpu.setSubComponent("memory", "revcpu.RevBasicMemCtrl")
    lsq.addParams(self.config.getLSQConfig())
    # Create the memHierarchy intreface subcomponent
    miface = lsq.setSubComponent("memIface", "memHierarchy.standardInterface")
    # Create the memory controller in memHierarchy
    memctrl = sst.Component(f"memory{nID}", "memHierarchy.MemController")
    memctrl.addParams(self.config.getMemCtrlConfig())
    # Create the memory backend subcomponent
    memory = memctrl.setSubComponent("backend", "memHierarchy.simpleMem")
    memory.addParams(self.config.getMemoryConfig())
    # Setup the links
    link_miface_mem = sst.Link(f"link_miface_mem{nID}")
    link_miface_mem.connect( (miface, "port", self.config.cpu_memctrl_latency), 
                             (memctrl, "direct_link", self.config.cpu_memctrl_latency) )
    
    # Setup the remote memory controllers
    rmt_lsq = xbgas_cpu.setSubComponent("remote_memory", "revcpu.RevBasicRmtMemCtrl")
    rmt_nic = rmt_lsq.setSubComponent("xbgasNicIface", "revcpu.XbgasNIC")
    rmt_nic_iface = rmt_nic.setSubComponent("iface", "merlin.linkcontrol")

    rmt_nic_iface.addParam("link_bw", self.config.bandwidth)
    rmt_nic_iface.addParam("input_buf_size", self.config.input_buf_size)
    rmt_nic_iface.addParam("output_buf_size", self.config.output_buf_size)
        
    return(rmt_nic_iface, "rtr_port", self.config.latency)


sst.merlin._params.update(config.getNetworkConfig())

topoGen = merlin.topoFatTree()
sst.merlin._params.update(config.getFatTreeParams())

topoGen.prepParams()
topoGen.setEndPoint(EndpointCreator(config))
topoGen.build()
