//
// SysCallMkdir.cc
//
// Copyright (C) 2017-2021 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//
#include "SysCallMkdir.h"

#include <unistd.h>
#include <signal.h>
#include <sys/stat.h>

namespace SST { namespace RevCPU {

template<>
template<>
void MkdirSystemCall<Riscv32>::invoke<int>(MkdirSystemCall<Riscv32>::SystemCallParameterInterfaceType & parameters, int & value) {
    if(parameters.count() == 2) {

        std::string pth;
        mode_t mode;

        bool has_values[2] = { false, false };
        has_values[0] = parameters.get<std::string>(0, pth);
        has_values[1] = parameters.get<mode_t>(0, mode);

        if(has_values[0] && has_values[1]) {
            success = true;
            value = mkdir(pth.c_str(), mode);
        }
    }
}

template<>
template<>
void MkdirSystemCall<Riscv64>::invoke<int>(MkdirSystemCall<Riscv64>::SystemCallParameterInterfaceType & parameters, int & value) {
    if(parameters.count() == 2) {

        std::string pth;
        mode_t mode;

        bool has_values[2] = { false, false };
        has_values[0] = parameters.get<std::string>(0, pth);
        has_values[1] = parameters.get<mode_t>(0, mode);

        if(has_values[0] && has_values[1]) {
            success = true;
            value = mkdir(pth.c_str(), mode);
        }
    }
}

template<>
template<>
void MkdirSystemCall<Riscv128>::invoke<int>(MkdirSystemCall<Riscv128>::SystemCallParameterInterfaceType & parameters, int & value) {
    if(parameters.count() == 2) {

        std::string pth;
        mode_t mode;

        bool has_values[2] = { false, false };
        has_values[0] = parameters.get<std::string>(0, pth);
        has_values[1] = parameters.get<mode_t>(0, mode);

        if(has_values[0] && has_values[1]) {
            success = true;
            value = mkdir(pth.c_str(), mode);
        }
    }
}

} /* end namespace RevCPU */ } // end namespace SST