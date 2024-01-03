import os
import sst
import configparser
 

class Config:
  def __init__(self, cfgFile, **kwargs):
    cp = configparser.ConfigParser()
    if not cp.read(cfgFile):
      raise Exception("Failed to read config file: " + cfgFile)
    
    self.verbose = "verbose" in kwargs and kwargs["verbose"]
    
    # CPU Config
    self.verbose      = cp.get('CPU', 'verbose')
    self.clock        = cp.get('CPU', 'clock')
    self.program      = cp.get('CPU', 'program')
    self.memSize      = cp.get('CPU', 'memSize')
    self.startAddr    = cp.get('CPU', 'startAddr')
    self.machine      = cp.get('CPU', 'machine')
    self.memCost      = cp.get('CPU', 'memCost')
    self.enable_xbgas = cp.get('CPU', 'enable_xbgas')
    self.enable_memH  = cp.get('CPU', 'enable_memH')
    
    # CPU Memory Controller latency
    self.cpu_memctrl_latency = cp.get('CPU', 'cpu_memctrl_latency')
    
    # LSQ Config
    self.max_loads       = cp.get('LSQ', 'max_loads')
    self.max_stores      = cp.get('LSQ', 'max_stores')
    self.max_flush       = cp.get('LSQ', 'max_flush')
    self.max_llsc        = cp.get('LSQ', 'max_llsc')
    self.max_readlock    = cp.get('LSQ', 'max_readlock')
    self.max_writeunlock = cp.get('LSQ', 'max_writeunlock')
    self.max_custom      = cp.get('LSQ', 'max_custom')
    self.ops_per_cycle   = cp.get('LSQ', 'ops_per_cycle')
    
    # MemCtrl Config
    self.addr_range_start = cp.get('MemoryCtrl', 'addr_range_start')
    self.addr_range_end   = cp.get('MemoryCtrl', 'addr_range_end')
    self.backing          = cp.get('MemoryCtrl', 'backing')
    
    # Memory Config
    self.access_time = cp.get('Memory', 'access_time')
    self.mem_size    = cp.get('Memory', 'mem_size')
    
    # Network Config
    self.latency         = cp.get('Network', 'latency')
    self.bandwidth       = cp.get('Network', 'bandwidth')
    self.flit_size       = cp.get('Network', 'flit_size')
    self.input_latency   = cp.get('Network', 'input_latency')
    self.output_latency  = cp.get('Network', 'output_latency')
    self.input_buf_size  = cp.get('Network', 'input_buf_size')
    self.output_buf_size = cp.get('Network', 'output_buf_size')
    
    if cp.has_section('FatTree'):
      self.shape = cp.get('FatTree', 'shape')
    
    if cp.has_section('Torus'):
      self.num_dims    = cp.get('Torus', 'num_dims')
      self.shape       = cp.get('Torus', 'shape')
      self.width       = cp.get('Torus', 'width')
      self.local_ports = cp.get('Torus', 'local_ports')
      self.cpus_per_group = self.local_ports
    
    if cp.has_section('DragonFly'):
      self.groups            = cp.get('DragonFly', 'group_count')
      self.hosts_per_router  = cp.get('DragonFly', 'hosts_per_router')
      self.routers_per_group = cp.get('DragonFly', 'routers_per_group')
      self.intergroup_links  = cp.get('DragonFly', 'intergroup_links')
    
  def getCpuConfig(self):
    params = dict({
      "verbose"      : int(self.verbose),             # Verbosity
      "clock"        : self.clock,                    # Clock
      "program"      : self.program,                  # Target executable
      "memSize"      : int(self.memSize),             # Memory size in bytes
      "startAddr"    : self.startAddr,                # Starting address for core 0
      "machine"      : self.machine,                  # Machine type
      "memCost"      : self.memCost,                  # Memory loads required 1-10 cycles
      "enable_xbgas" : int(self.enable_xbgas),        # Enable XBGAS support
      "enable_memH"  : int(self.enable_memH),         # Enable memH support
      "splash"       : 0                              # Display the splash message
    })
    return params
  
  def getLSQConfig(self):
    params = dict({
      "verbose"         : int(self.verbose),
      "clock"           : self.clock,
      "max_loads"       : int(self.max_loads),
      "max_stores"      : int(self.max_stores),
      "max_flush"       : int(self.max_flush),
      "max_llsc"        : int(self.max_llsc),
      "max_readlock"    : int(self.max_readlock),
      "max_writeunlock" : int(self.max_writeunlock),
      "max_custom"      : int(self.max_custom),
      "ops_per_cycle"   : int(self.ops_per_cycle)
    })
    return params
  
  def getMemCtrlConfig(self):
    params = dict({
      "verbose"          : int(self.verbose),
      "clock"            : self.clock,
      "addr_range_start" : int(self.addr_range_start),
      "addr_range_end"   : int(self.addr_range_end),
      "backing"          : self.backing,
      "debug"            : 0,
      "debug_level"      : 10
    })
    return params

  def getMemoryConfig(self):
    params = dict({
      "access_time" : self.access_time,
      "mem_size"    : self.mem_size
    })
    return params

  def getNetworkConfig(self):
    params = dict({
      "link_bw"         : self.bandwidth,
      "link_lat"        : self.latency,
      "flit_size"       : self.flit_size,
      "xbar_bw"         : self.bandwidth,
      "input_latency"   : self.input_latency,
      "output_latency"  : self.output_latency,
      "input_buf_size"  : self.input_buf_size,
      "output_buf_size" : self.output_buf_size,
      "xbar_arb"        : "merlin.xbar_arb_lru"
    })
    return params
  
  def getFatTreeParams(self):
    params = dict({
      "fattree.shape" : self.shape,
    })
    return params
    
  def getTorusParams(self):
    params = dict({
      "num_dims"          : self.num_dims,
      "torus.shape"       : self.shape,
      "torus.width"       : self.width,
      "torus.local_ports" : self.local_ports,
    })
    return params
  
  def getDragonFlyParams(self):
    params = dict({
      "dragonfly.hosts_per_router" : self.hosts_per_router,
      "dragonfly.routers_per_group": self.routers_per_group,
      "dragonfly.intergroup_links" : self.intergroup_links,
      "dragonfly.num_groups"       : self.groups,
      "dragonfly.algorithm"        : "minimal",
    })
    return params
  