
//
// SysCallGetrlimit.cc
//
// Copyright (C) 2017-2021 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//
#include "SysCallGetrlimit.h"

#include <unistd.h>
#include <signal.h>
#include <sys/stat.h>

namespace SST { namespace RevCPU {

template<>
template<>
void GetrlimitSystemCall<Riscv32>::invoke<int>(GetrlimitSystemCall<Riscv32>::SystemCallParameterInterfaceType & parameters, int & value) {
    if(parameters.count() == 2) {

        int resource;
        rlimit * rlp;

        bool has_values[2] = { false, false };
        has_values[0] = parameters.get<int>(0, resource);
        has_values[1] = parameters.get<rlimit *>(1, rlp);

        if(has_values[0] && has_values[1]) {
            success = true;
            value = getrlimit(resource, rlp);
        }
    }
}


template<>
template<>
void GetrlimitSystemCall<Riscv64>::invoke<int>(GetrlimitSystemCall<Riscv64>::SystemCallParameterInterfaceType & parameters, int & value) {
    if(parameters.count() == 2) {

        int resource;
        rlimit * rlp;

        bool has_values[2] = { false, false };
        has_values[0] = parameters.get<int>(0, resource);
        has_values[1] = parameters.get<rlimit *>(1, rlp);

        if(has_values[0] && has_values[1]) {
            success = true;
            value = getrlimit(resource, rlp);
        }
    }
}

template<>
template<>
void GetrlimitSystemCall<Riscv128>::invoke<int>(GetrlimitSystemCall<Riscv128>::SystemCallParameterInterfaceType & parameters, int & value) {
    if(parameters.count() == 2) {

        int resource;
        rlimit * rlp;

        bool has_values[2] = { false, false };
        has_values[0] = parameters.get<int>(0, resource);
        has_values[1] = parameters.get<rlimit *>(1, rlp);

        if(has_values[0] && has_values[1]) {
            success = true;
            value = getrlimit(resource, rlp);
        }
    }
}

} /* end namespace RevCPU */ } // end namespace SST