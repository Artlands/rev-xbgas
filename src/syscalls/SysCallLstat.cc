//
// SysCallLstat.cc
//
// Copyright (C) 2017-2021 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//
#include "SysCallLstat.h"

namespace SST { namespace RevCPU {

template<>
template<>
void Lstat<Riscv32>::invoke<int>(Lstat<Riscv32>::SystemCallParameterInterfaceType & parameters, int & value) {
    if(parameters.count() == 2) {

        std::string pth; 
        stat_t * buf;
        
        bool has_values[2] = { false, false };
        has_values[0] = parameters.get<std::string>(0, pth);
        has_values[1] = parameters.get<stat_t *>(1, buf);

        if(has_values[0] && has_values[1]) {
            success = true;
            value = lstat(pth.c_str(), buf);
        }
    }
}

template<>
template<>
void Lstat<Riscv64>::invoke<int>(Lstat<Riscv64>::SystemCallParameterInterfaceType & parameters, int & value) {
    if(parameters.count() == 2) {

        std::string pth; 
        stat_t * buf;
        
        bool has_values[2] = { false, false };
        has_values[0] = parameters.get<std::string>(0, pth);
        has_values[1] = parameters.get<stat_t *>(1, buf);

        if(has_values[0] && has_values[1]) {
            success = true;
            value = lstat(pth.c_str(), buf);
        }
    }
}

template<>
template<>
void Lstat<Riscv128>::invoke<int>(Lstat<Riscv128>::SystemCallParameterInterfaceType & parameters, int & value) {
    if(parameters.count() == 2) {

        std::string pth; 
        stat_t * buf;
        
        bool has_values[2] = { false, false };
        has_values[0] = parameters.get<std::string>(0, pth);
        has_values[1] = parameters.get<stat_t *>(1, buf);

        if(has_values[0] && has_values[1]) {
            success = true;
            value = lstat(pth.c_str(), buf);
        }
    }
}

} /* end namespace RevCPU */ } // end namespace SST