//
// _XbgasAddr_h_
//
// Copyright (C) 2017-2021 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#ifndef _XBGASADDR_H_
#define _XBGASADDR_H_

#define _REV_PAGE_SIZE                       4096           //Page Size (in Bytes), i.e., 4KB
#define _REV_MEM_SIZE                        0x100000000    //4GB

#define _XBGAS_FIRMWARE_                     0x80000000     //2GB
#define _XBGAS_MY_PE_ADDR_                   _XBGAS_FIRMWARE_
#define _XBGAS_TOTAL_NPE_ADDR_               _XBGAS_FIRMWARE_ + 8
#define _XBGAS_BARRIER_                      _XBGAS_FIRMWARE_ + 16
#define _XBGAS_BARRIER_END_                  _XBGAS_BARRIER_ + 20 * 8  // MAX_PE_NUM = 1024, thus, MAX_Barrier buffer space = log2^1024 = 10
#define _XBGAS_FIRMWARE_END_                 _XBGAS_FIRMWARE_ + _REV_PAGE_SIZE

// Simulated memory heap
#define _REV_HEAP_START_                     (uint64_t)((int64_t)((_XBGAS_FIRMWARE_END_ - 1)/_REV_PAGE_SIZE) * _REV_PAGE_SIZE + _REV_PAGE_SIZE)
#define _REV_HEAP_END_                       _REV_MEM_SIZE
#define _REV_HEAP_SIZE_                      _REV_MEM_SIZE - _REV_HEAP_START_

typedef struct{
    uint64_t nmspace;
    int64_t ID;
}NamespaceTbEntry;

#endif

// EOF
