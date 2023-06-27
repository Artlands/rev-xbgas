## Getting Started
The xBGAS runtime library is a set of C and assembly language routines that provide simple interfaces to the xBGAS APIs. It is ported from [the original xBGAS runtime library](https://github.com/tactcomplabs/xbgas-runtime) and made changes to be able to run in the REV-CPU SST environment. 

## Prerequisites
The xBGAS runtime library requires the following softwares to be installed on the system:
* [RISC-V xBGAS GNU Toolchain](https://github.com/rrtlands/riscv-gnu-toolchain-xbgas/tree/xbgas)
* [REV xBGAS SST Component](https://github.com/Artlands/rev-xbgas/tree/refactor-xbrtime)

## Building
The xBGAS runtime library can be built by running the following commands (CMake is required):
```bash
mkdir build
cd build
cmake ../
make
```
The built library will be located at `xbrtime/libxbrtime.a`. The default build will print out status messages, such as barrier touches.

## Usage
Please refer to the examples in the `test` directory for how to use the xBGAS runtime library and run the SST simulation. In general, the following steps are needed to run the SST simulation, in each of the test directories:
```
make
sst rev-xbgas-xfer.py
```

Note that the current xBGAS SST simulation uses marcos that specify a special memory region for the xBGAS metadata (PE IDs, # of PEs, shared memory metadata, etc.) and the default simulated memory size is set to 1GB. Therefore, in the SST configuration script, the simulated memory size should be set to 1GB. If larger memory size is needed, you may change the `_REV_MEM_SIZE_` in `common/include/XbgasAddr.h.` and recompile the REV-CPU SST component. Please also note that the **MemHierarchy** component is not working properly with the REV-CPU SST component, so the `enable_memH` option should NOT be set to 1 and the simulator will use the built-in memory backend instead.