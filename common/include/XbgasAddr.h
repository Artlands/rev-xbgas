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

#define _REV_PAGE_SIZE                       262144         //Page Size (in Bytes)
#define _REV_MEM_SIZE                        0x100000000    //4GB

#define _XBGAS_MEM_BASE_                     0x80000000     //2GB
#define _XBGAS_MY_PE_ADDR_                   _XBGAS_MEM_BASE_
#define _XBGAS_TOTAL_NPE_ADDR_               _XBGAS_MEM_BASE_ + 8

// Simulated memory heap
#define _REV_HEAP_START_                     (uint64_t)((int64_t)((_XBGAS_MEM_BASE_ + 16 - 1)/_REV_PAGE_SIZE) * _REV_PAGE_SIZE + _REV_PAGE_SIZE)
#define _REV_HEAP_END_                       _REV_MEM_SIZE
#define _REV_HEAP_SIZE_                      _REV_MEM_SIZE - _REV_HEAP_START_

typedef struct{
    uint64_t nmspace;
    int64_t ID;
}NamespaceTbEntry;

#endif

// EOF
