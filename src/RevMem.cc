//
// _RevMem_cc_
//
// Copyright (C) 2017-2021 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#include "RevMem.h"
#include <math.h>

RevMem::RevMem( unsigned long MemSize, RevOpts *Opts, SST::Output *Output )
  : memSize(MemSize), opts(Opts), output(Output), physMem(nullptr), stacktop(0x00ull) {

  // allocate the backing memory
  physMem = new char [memSize];
  pageSize = 262144; //Page Size (in Bytes)
  // pageSize = 65536; //Page Size (in Bytes)
  addrShift = int(log(pageSize) / log(2.0));
  nextPage = 0;

  if( !physMem )
    output->fatal(CALL_INFO, -1, "Error: could not allocate backing memory");

  // zero the memory
  for( unsigned long i=0; i<memSize; i++ ){
    physMem[i] = 0;
  }

  stacktop = _REVMEM_BASE_ + memSize;

  memStats.bytesRead = 0;
  memStats.bytesWritten = 0;
  memStats.doublesRead = 0;
  memStats.doublesWritten = 0;
  memStats.floatsRead = 0;
  memStats.floatsWritten = 0;
}

RevMem::~RevMem(){
  delete[] physMem;
}

void RevMem::HandleMemFault(unsigned width){
  // build up the fault payload
  srand(time(NULL));
  uint64_t rval = rand() % (2^(width));

  // find an address to fault
  std::random_device rd; // obtain a random number from hardware
  std::mt19937 gen(rd()); // seed the generator
  std::uniform_int_distribution<> distr(0, memSize-8); // define the range
  unsigned NBytes = distr(gen);
  uint64_t *Addr = (uint64_t *)(&physMem[0] + NBytes);

  // write the fault (read-modify-write)
  *Addr |= rval;
  output->verbose(CALL_INFO, 5, 0,
                  "FAULT:MEM: Memory fault %d bits at address : 0x%" PRIu64 "\n",
                 width, (uint64_t)(Addr));
}

bool RevMem::SetFuture(uint64_t Addr){
  FutureRes.push_back(Addr);
  std::sort( FutureRes.begin(), FutureRes.end() );
  FutureRes.erase( std::unique( FutureRes.begin(), FutureRes.end() ), FutureRes.end() );
  return true;
}

bool RevMem::RevokeFuture(uint64_t Addr){
  for( unsigned i=0; i<FutureRes.size(); i++ ){
    if( FutureRes[i] == Addr ){
      FutureRes.erase( FutureRes.begin() + i );
      return true;
    }
  }
  // nothing found
  return false;
}

bool RevMem::StatusFuture(uint64_t Addr){
  for( unsigned i=0; i<FutureRes.size(); i++ ){
    if( FutureRes[i] == Addr )
      return true;
  }
  return false;
}

bool RevMem::LR(unsigned Hart, uint64_t Addr){
  std::pair<unsigned,uint64_t> Entry = std::make_pair(Hart,Addr);
  LRSC.push_back(Entry);
  return true;
}

bool RevMem::SC(unsigned Hart, uint64_t Addr){
  // search the LRSC vector for the entry pair
  std::pair<unsigned,uint64_t> Entry = std::make_pair(Hart,Addr);
  std::vector<std::pair<unsigned,uint64_t>>::iterator it;

  for( it = LRSC.begin(); it != LRSC.end(); ++it ){
    if( (Hart == std::get<0>(*it)) &&
        (Addr == std::get<1>(*it)) ){
      LRSC.erase(it);
      return true;
    }
  }

  return false;
}

unsigned RevMem::RandCost( unsigned Min, unsigned Max ){
  unsigned R = 0;

  srand(time(NULL));

  R = (unsigned)((rand() % Max) + Min);

  return R;
}

int64_t RevMem::CalcPhysAddr(uint64_t Addr){
  int64_t physAddr = 0;
  uint64_t pageNum = Addr >> addrShift;
  if(pageMap.count(pageNum) == 0){
    // First touch of this page, mark it as in use
    pageMap[pageNum] = std::pair<uint32_t, bool>(nextPage, true);
    physAddr = (nextPage << addrShift) | ((pageSize - 1) & Addr);
    nextPage++;
  }else if(pageMap.count(pageNum) == 1){
    //We've accessed this page before, just get the physical address 
    physAddr = (pageMap[pageNum].first << addrShift) | ((pageSize - 1) & Addr);
  }else{
    output->fatal(CALL_INFO, -1, "Error: Page allocated multiple times");
  }
  return physAddr;
}

bool RevMem::WriteMem( uint64_t Addr, size_t Len, void *Data ){
  if (Len > 0) {
    if(Addr == 0xDEADBEEF){
      std::cout << "Found special write. Val = " << std::hex << *(int*)(Data) << std::dec << std::endl;
    }
    RevokeFuture(Addr); // revoke the future if it is present; ignore the return
    
    uint64_t physAddr = CalcPhysAddr(Addr);
    uint32_t firstPageNum = Addr >> addrShift;
    uint64_t firstPageEnd = (firstPageNum << addrShift) | (pageSize - 1);

    char *BaseMem = &physMem[physAddr]; 
    char *DataMem = (char *)(Data);
    
    uint32_t tmpLen = 0;
    uint32_t lenCount = 0;
    uint64_t tmpPhysAddr = 0;
    uint32_t tmpPageNum = 0;
    uint64_t tmpPageEnd = 0;
    uint64_t tmpStartAddr = 0;

    uint64_t endAddr = Addr + Len - 1;
    uint32_t lastPageNum   = endAddr >> addrShift;

    //check to see if we're about to walk off the page....
    if((Addr + Len - 1) > firstPageEnd){
      tmpStartAddr = Addr;
      while ( tmpStartAddr < endAddr ){
        tmpPhysAddr = CalcPhysAddr(tmpStartAddr);

        // Current page
        tmpPageNum  = tmpStartAddr >> addrShift;
        tmpPageEnd  = (tmpPageNum << addrShift) | (pageSize - 1);
        
        if (tmpPageNum == lastPageNum) {
          // Reach to the last page, adjust tmpLen
          tmpLen = endAddr - tmpStartAddr + 1;
        } else {
          tmpLen = tmpPageEnd - tmpStartAddr + 1;
        }
        // Write data
        BaseMem = &physMem[tmpPhysAddr];
        for( unsigned j=0; j< tmpLen; j++ ){
            BaseMem[j] = DataMem[j + lenCount];
        }
        // Move to the next page
        tmpStartAddr = tmpStartAddr + tmpLen;
        lenCount = lenCount + tmpLen;
      }
  #ifdef _REV_DEBUG_
      std::cout << "Warning: Reading off end of page... " << std::endl;
  #endif
    }else{
      for( unsigned i=0; i<Len; i++ ){
        BaseMem[i] = DataMem[i];
      }
    }
    memStats.bytesWritten += Len;
  }
  return true;
}

bool RevMem::ReadMem( uint64_t Addr, size_t Len, void *Data ){
#ifdef _REV_DEBUG_
  std::cout << "Reading " << Len << " Bytes Starting at 0x" << std::hex << Addr << std::endl;
#endif
  uint64_t physAddr = CalcPhysAddr(Addr);
  uint32_t firstPageNum = Addr >> addrShift;
  uint64_t firstPageEnd = (firstPageNum << addrShift) | (pageSize - 1);

  char *BaseMem = &physMem[physAddr]; 
  char *DataMem = (char *)(Data);

  uint32_t tmpLen = 0;
  uint32_t lenCount = 0;
  uint64_t tmpPhysAddr = 0;
  uint32_t tmpPageNum = 0;
  uint64_t tmpPageEnd = 0;
  uint64_t tmpStartAddr = 0;

  uint64_t endAddr = Addr + Len - 1;
  uint32_t lastPageNum   = endAddr >> addrShift;
  
  //check to see if we're about to walk off the page....
  if((Addr + Len - 1) > firstPageEnd){
    tmpStartAddr = Addr;
    while ( tmpStartAddr < endAddr ){
      tmpPhysAddr = CalcPhysAddr(tmpStartAddr);

      // Current page
      tmpPageNum  = tmpStartAddr >> addrShift;
      tmpPageEnd  = (tmpPageNum << addrShift) | (pageSize - 1);
      
      if (tmpPageNum == lastPageNum) {
        // Reach to the last page, adjust tmpLen
        tmpLen = endAddr - tmpStartAddr + 1;
      } else {
        tmpLen = tmpPageEnd - tmpStartAddr + 1;
      }

      // Read data
      BaseMem = &physMem[tmpPhysAddr];
      for( unsigned j=0; j< tmpLen; j++ ){
          DataMem[j] = BaseMem[j + lenCount];
      }
      // Move to the next page
      tmpStartAddr = tmpStartAddr + tmpLen;
      lenCount = lenCount + tmpLen;
    }
#ifdef _REV_DEBUG_
    std::cout << "Warning: Reading off end of page... " << std::endl;
#endif
  }else{
    for( unsigned i=0; i<Len; i++ ){
      DataMem[i] = BaseMem[i];
    }
  }
  memStats.bytesRead += Len;
  return true;
}

uint8_t RevMem::ReadU8( uint64_t Addr ){
  uint8_t Value;
  if( !ReadMem( Addr, 1, (void *)(&Value) ) )
    output->fatal(CALL_INFO, -1, "Error: could not read memory (U8)");
  return Value;
}

uint16_t RevMem::ReadU16( uint64_t Addr ){
  uint16_t Value;
  if( !ReadMem( Addr, 2, (void *)(&Value) ) )
    output->fatal(CALL_INFO, -1, "Error: could not read memory (U16)");
  return Value;
}

uint32_t RevMem::ReadU32( uint64_t Addr ){
  uint32_t Value;
  if( !ReadMem( Addr, 4, (void *)(&Value) ) )
    output->fatal(CALL_INFO, -1, "Error: could not read memory (U32)");
  return Value;
}

uint64_t RevMem::ReadU64( uint64_t Addr ){
  uint64_t Value;
  if( !ReadMem( Addr, 8, (void *)(&Value) ) )
    output->fatal(CALL_INFO, -1, "Error: could not read memory (U64)");
  return Value;
}

float RevMem::ReadFloat( uint64_t Addr ){
  float Value = 0.;
  uint32_t Tmp = 0x00;
  if( !ReadMem( Addr, 4, (void *)(&Tmp) ) )
    output->fatal(CALL_INFO, -1, "Error: could not read memory (FLOAT)");
  std::memcpy(&Value,&Tmp,sizeof(float));
  memStats.floatsRead++;
  return Value;
}

double RevMem::ReadDouble( uint64_t Addr ){
  double Value = 0.;
  uint64_t Tmp = 0x00;
  if( !ReadMem( Addr, 8, (void *)(&Tmp) ) )
    output->fatal(CALL_INFO, -1, "Error: could not read memory (DOUBLE)");
  std::memcpy(&Value,&Tmp,sizeof(double));
  memStats.doublesRead++;
  return Value;
}

void RevMem::WriteU8( uint64_t Addr, uint8_t Value ){
  uint8_t Tmp = Value;
  if( !WriteMem(Addr,1,(void *)(&Tmp)) )
    output->fatal(CALL_INFO, -1, "Error: could not write memory (U8)");
}

void RevMem::WriteU16( uint64_t Addr, uint16_t Value ){
  uint16_t Tmp = Value;
  if( !WriteMem(Addr,2,(void *)(&Tmp)) )
    output->fatal(CALL_INFO, -1, "Error: could not write memory (U16)");
}

void RevMem::WriteU32( uint64_t Addr, uint32_t Value ){
  uint32_t Tmp = Value;
  if( !WriteMem(Addr,4,(void *)(&Tmp)) )
    output->fatal(CALL_INFO, -1, "Error: could not write memory (U32)");
}

void RevMem::WriteU64( uint64_t Addr, uint64_t Value ){
  uint64_t Tmp = Value;
  if( !WriteMem(Addr,8,(void *)(&Tmp)) )
    output->fatal(CALL_INFO, -1, "Error: could not write memory (U64)");
}

void RevMem::WriteFloat( uint64_t Addr, float Value ){
  uint32_t Tmp = 0x00;
  std::memcpy(&Tmp,&Value,sizeof(float));
  memStats.floatsWritten++;
  if( !WriteMem(Addr,4,(void *)(&Tmp)) )
    output->fatal(CALL_INFO, -1, "Error: could not write memory (FLOAT)");
}

void RevMem::WriteDouble( uint64_t Addr, double Value ){
  uint64_t Tmp = 0x00;
  std::memcpy(&Tmp,&Value,sizeof(double));
  memStats.doublesWritten++;
  if( !WriteMem(Addr,8,(void *)(&Tmp)) )
    output->fatal(CALL_INFO, -1, "Error: could not write memory (DOUBLE)");
}

// EOF
