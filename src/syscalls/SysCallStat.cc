//
// SysCallStat.cc
//
// Copyright (C) 2017-2021 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//
#include "SysCallStat.h"

#include <unistd.h>
#include <sys/stat.h>

namespace SST { namespace RevCPU {

template<>
template<>
void Stat<Riscv32>::invoke<int>(Stat<Riscv32>::SystemCallParameterInterfaceType & parameters, int & value) {
    if(parameters.count() == 2) {

        std::string pth; 
        stat * buf;
        
        bool has_values[2] = { false, false };
        has_values[0] = parameters.get<std::string>(0, pth);
        has_values[1] = parameters.get<stat *>(1, buf);

        if(has_values[0] && has_values[1]) {
            success = true;
            value = stat(fil.c_str(), buf);
        }
    }
}

template<>
template<>
void Stat<Riscv64>::invoke<int>(Stat<Riscv64>::SystemCallParameterInterfaceType & parameters, int & value) {
    if(parameters.count() == 2) {

        std::string pth; 
        stat * buf;
        
        bool has_values[2] = { false, false };
        has_values[0] = parameters.get<std::string>(0, pth);
        has_values[1] = parameters.get<stat *>(1, buf);

        if(has_values[0] && has_values[1]) {
            success = true;
            value = stat(fil.c_str(), buf);
        }
    }
}

template<>
template<>
void Stat<Riscv128>::invoke<int>(Stat<Riscv128>::SystemCallParameterInterfaceType & parameters, int & value) {
    if(parameters.count() == 2) {

        std::string pth; 
        stat * buf;
        
        bool has_values[2] = { false, false };
        has_values[0] = parameters.get<std::string>(0, pth);
        has_values[1] = parameters.get<stat *>(1, buf);

        if(has_values[0] && has_values[1]) {
            success = true;
            value = stat(fil.c_str(), buf);
        }
    }
}

} /* end namespace RevCPU */ } // end namespace SST