//
// SysCallUname.cc
//
// Copyright (C) 2017-2021 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//
#include "SysCallUname.h"
#include <algorithm>

#include <unistd.h>
#include <signal.h>

namespace SST { namespace RevCPU {


template<typename RiscvArchType>
template<>
bool UnameParameters<RiscvArchType>::get(const size_t parameter_index, utsname * & param) {
    if(parameter_index == 0) {
        param = name;
        return true;
    }

    return false;
}

template<>
template<>
void Uname<Riscv32>::invoke<int>(Uname<Riscv32>::SystemCallParameterInterfaceType & parameters, int & value) {
    if(parameters.count() == 1) {
        utsname * name;
        
        const bool has_values = parameters.get<utsname *>(0, name);
        if(has_values) {
            success = true;
            value = uname(name);
        }
    }
}

template<>
template<>
void Uname<Riscv64>::invoke<int>(Uname<Riscv64>::SystemCallParameterInterfaceType & parameters, int & value) {
    if(parameters.count() == 1) {
        utsname * name;
        
        const bool has_values = parameters.get<utsname *>(0, name);
        if(has_values) {
            success = true;
            value = uname(name);
        }
    }
}

template<>
template<>
void Uname<Riscv128>::invoke<int>(Uname<Riscv128>::SystemCallParameterInterfaceType & parameters, int & value) {
    if(parameters.count() == 1) {
        utsname * name;
        
        const bool has_values = parameters.get<utsname *>(0, name);
        if(has_values) {
            success = true;
            value = uname(name);
        }
    }
}

} /* end namespace RevCPU */ } // end namespace SST
