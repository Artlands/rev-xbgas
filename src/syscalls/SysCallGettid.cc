//
// SysCallGettid.cc
//
// Copyright (C) 2017-2021 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//
#include "SysCallGettid.h"

namespace SST { namespace RevCPU {

template<typename RiscvArchType>
template<>
bool GettidParameters<RiscvArchType>::get(const size_t parameter_index, void_t& param) {
    return true;
}

template<>
template<>
void Gettid<Riscv32>::invoke<int>(Gettid<Riscv32>::SystemCallParameterInterfaceType & parameters, int & value) {
    success = true;
    value = gettid();
}

template<>
template<>
void Gettid<Riscv64>::invoke<int>(Gettid<Riscv64>::SystemCallParameterInterfaceType & parameters, int & value) {
    success = true;
    value = gettid();
}

template<>
template<>
void Gettid<Riscv128>::invoke<int>(Gettid<Riscv128>::SystemCallParameterInterfaceType & parameters, int & value) {
    success = true;
    value = gettid();
}

} /* end namespace RevCPU */ } // end namespace SST
