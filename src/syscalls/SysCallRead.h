//
// SysCallRead.h
//
// Copyright (C) 2017-2021 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//
#pragma once
#ifndef __SYSTEMCALLREAD_H__
#define __SYSTEMCALLREAD_H__

#include "SystemCallInterface.h"
#include <type_traits>
#include <sys/types.h>

namespace SST { namespace RevCPU {

class ReadSystemCallParameters : public virtual SystemCallParameterInterface {

    private:

    int fd;
    void * buf;
    size_t bcount;
    
    public:

    ReadSystemCallParameters(int fd_i, void *buf_i, size_t count_i) : SystemCallParameterInterface(), fd(fd_i), buf(buf_i), bcount(count_i) {}

    size_t count() override;

    template<typename ParameterType>
    bool get(const size_t parameter_index, ParameterType & param);
};

template<typename RiscvArchType=Riscv32>
class ReadSystemCall : public virtual SystemCallInterface<RiscvArchType> {

    using RiscvModeIntegerType = typename SystemCallInterface<RiscvArchType>::RiscvModeIntegerType;

    public:

    const static RiscvModeIntegerType code_value = static_cast<RiscvModeIntegerType>(63);

    ReadSystemCall() {}

    RiscvModeIntegerType code() override;
    
    // always returns false
    //
    template<typename ReturnType>
    void invoke(SystemCallParameterInterface & parameters, ReturnType & value);

    // returns true
    //
    template<>
    void invoke(SystemCallParameterInterface & parameters, int & value);
};

} /* end namespace RevCPU */ } // end namespace SST

#endif

// EOF