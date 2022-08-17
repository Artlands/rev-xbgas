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

#define _XBGAS_MY_PE_ADDR_                   0x30000000
#define _XBGAS_TOTAL_PE_ADDR_                0x30000008
#define _XBGAS_MEM_SIZE_                     0x30000010
#define _XBGAS_START_ADDR_                   0x30000018
#define _XBGAS_NAMESPACE_TABLE_ADDR_         0x30000020
#define _XBGAS_NAMESPACE_TABLE_MAX_ENTRIES_  1024

#define _XBGAS_RTIME_DATA_ADDR_ 

typedef struct{
    uint64_t nmspace;
    int64_t ID;
}NamespaceTbEntry;

#endif

// EOF
