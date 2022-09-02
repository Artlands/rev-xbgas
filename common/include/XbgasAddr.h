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
#define _REV_MEM_SIZE                        0x40000000

#define _XBGAS_MEM_BASE_                     0x30000000
#define _XBGAS_MY_PE_ADDR_                   _XBGAS_MEM_BASE_
#define _XBGAS_TOTAL_NPE_ADDR_               _XBGAS_MEM_BASE_ + 8

// PE mapping: [int Logical node ID, int Physical node ID, uint64_t Base Physical address]
#define _XBRTIME_PE_MAP_ADDR_                _XBGAS_MEM_BASE_ + 16
#define _XBRTIME_PE_MAP_MAX_ENTRIES_         1024

// Allocated memory map: [uint64_t start_addr, size_t size]
#define _XBRTIME_MEM_T_ADDR_                 _XBRTIME_PE_MAP_ADDR_ + (_XBRTIME_PE_MAP_MAX_ENTRIES_ + 1) * 16
#define _XBRTIME_MEM_SLOTS_                  2048

// Simulated memory heap
#define _REV_HEAP_START_                     (uint64_t)((int)((_XBRTIME_MEM_T_ADDR_ + (_XBRTIME_MEM_SLOTS_ + 1) * 16 - 1)/_REV_PAGE_SIZE) * _REV_PAGE_SIZE + _REV_PAGE_SIZE)
#define _REV_HEAP_END_                       _REV_MEM_SIZE
#define _REV_HEAP_SIZE_                      _REV_MEM_SIZE - _REV_HEAP_START_

typedef struct{
    uint64_t nmspace;
    int64_t ID;
}NamespaceTbEntry;

#endif

// EOF
