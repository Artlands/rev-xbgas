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

#define _XBGAS_BASE_                         0x30000000
#define _XBGAS_MY_PE_ADDR_                   _XBGAS_BASE_
#define _XBGAS_TOTAL_NPE_ADDR_               _XBGAS_BASE_ + 8

// PE mapping: [int Logical node ID, int Physical node ID, uint64_t Base Physical address]
#define _XBRTIME_PE_MAP_ADDR_                _XBGAS_BASE_ + 16
#define _XBRTIME_PE_MAP_MAX_ENTRIES_         1024

// Allocated memory map: [uint64_t start_addr, size_t size]
#define _XBRTIME_MEM_T_ADDR_                 _XBRTIME_PE_MAP_ADDR_ + (_XBRTIME_PE_MAP_MAX_ENTRIES_ + 1) * 16
#define _XBRTIME_MEM_SLOTS_                  2048
            
#define _XBRTIME_START_ADDR_                 _XBRTIME_MEM_T_ADDR_ + (_XBRTIME_MEM_SLOTS_ + 1) * 16
#define _XBRTIME_MEMSIZE_                    0x40000000 - _XBGAS_START_ADDR_

               

typedef struct{
    uint64_t nmspace;
    int64_t ID;
}NamespaceTbEntry;

#endif

// EOF
