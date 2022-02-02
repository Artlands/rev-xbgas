//
// SysCallPrlimit64.cc
//
// Copyright (C) 2017-2021 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//
#include "SysCallPrlimit64.h"
#include <stdlib.h>

namespace SST { namespace RevCPU {

template<>
template<>
void Prlimit64SystemCall<Riscv32>::invoke<int>(Prlimit64SystemCall<Riscv32>::SystemCallParameterInterfaceType & parameters, int & value) {

    if(parameters.count() == 4) {

        pid_t pid; 
        int resource;
        const rlimit *new_limit;
        rlimit *old_limit;

        bool hasargs[4] = { false, false, false, false };

        hasargs[0] = parameters.get<pid_t>(pid);
        hasargs[1] = parameters.get<int>(resource);
        hasargs[2] = parameters.get<rlimit *>(new_limit);
        hasargs[3] = parameters.get<rlimit *>(old_limit);

        if(hasargs[0] && hasargs[1] && hasargs[2] && hasargs[3]) {
            success = true;
            value = prlimit64(pid, resoure, new_limit, old_limit);
        }
    }
}

template<>
template<>
void Prlimit64SystemCall<Riscv64>::invoke<int>(Prlimit64SystemCall<Riscv64>::SystemCallParameterInterfaceType & parameters, int & value) {

    if(parameters.count() == 4) {

        pid_t pid; 
        int resource;
        const rlimit *new_limit;
        rlimit *old_limit;

        bool hasargs[4] = { false, false, false, false };

        hasargs[0] = parameters.get<pid_t>(pid);
        hasargs[1] = parameters.get<int>(resource);
        hasargs[2] = parameters.get<rlimit *>(new_limit);
        hasargs[3] = parameters.get<rlimit *>(old_limit);

        if(hasargs[0] && hasargs[1] && hasargs[2] && hasargs[3]) {
            success = true;
            value = prlimit64(pid, resoure, new_limit, old_limit);
        }
    }
}

template<>
template<>
void Prlimit64SystemCall<Riscv128>::invoke<int>(Prlimit64SystemCall<Riscv128>::SystemCallParameterInterfaceType & parameters, int & value) {

    if(parameters.count() == 4) {

        pid_t pid; 
        int resource;
        const rlimit *new_limit;
        rlimit *old_limit;

        bool hasargs[4] = { false, false, false, false };

        hasargs[0] = parameters.get<pid_t>(pid);
        hasargs[1] = parameters.get<int>(resource);
        hasargs[2] = parameters.get<rlimit *>(new_limit);
        hasargs[3] = parameters.get<rlimit *>(old_limit);

        if(hasargs[0] && hasargs[1] && hasargs[2] && hasargs[3]) {
            success = true;
            value = prlimit64(pid, resoure, new_limit, old_limit);
        }
    }
}

} /* end namespace RevCPU */ } // end namespace SST