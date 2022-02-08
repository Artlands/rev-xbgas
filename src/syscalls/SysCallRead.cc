//
// SysCallRead.cc
//
// Copyright (C) 2017-2021 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//
#include "SysCallRead.h"
#include <algorithm>

#include <unistd.h>
#include <signal.h>

namespace SST { namespace RevCPU {

template<typename RiscvArchType>
template<>
bool Read<RiscvArchType>::get(const size_t parameter_index, int& param) {
    if(parameter_index == 0) {
        param = fd;
        return true;
    }

    return false;
}

template<typename RiscvArchType>
template<>
bool Read<RiscvArchType>::get(const size_t parameter_index, void_ptr & param) {
    if(parameter_index == 0) {
        param = buf;
        return true;
    }

    return false;
}

template<typename RiscvArchType>
template<>
bool Read<RiscvArchType>::get(const size_t parameter_index, size_t & param) {
    if(parameter_index == 0) {
        param = bcount;
        return true;
    }

    return false;
}

template<typename RiscvArchType>
template<>
void Read<RiscvArchType>::invoke<ssize_t>(Read<RiscvArchType>::SystemCallParameterInterfaceType & parameters, ssize_t & value) {
    if(parameters.count() == 3) {
        int fd = -1;
        void * buf = 0;
        size_t count = 0;

        bool has_values[3] = { false, false, false };
        has_values[0] = parameters.get<int>(0, fd);
        has_values[1] = parameters.get<void_ptr>(1, buf);
        has_values[2] = parameters.get<size_t>(2, count);

        if(has_values[0] && has_values[1] && has_values[2]) {
            success = true;
            value = read(fd, buf, count);
        }
    }
}

} /* end namespace RevCPU */ } // end namespace SST
