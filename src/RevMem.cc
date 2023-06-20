//
// _RevMem_cc_
//
// Copyright (C) 2017-2023 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#include "../include/RevMem.h"
#include "../include/RevRmtMemCtrl.h"
#include <math.h>
#include <mutex>

// #define _XBGAS_DEBUG_

RevMem::RevMem( unsigned long MemSize, RevOpts *Opts,
                RevMemCtrl *Ctrl, SST::Output *Output )
  : physMem(nullptr), memSize(MemSize), opts(Opts), 
    ctrl(Ctrl), rmtCtrl(nullptr),
    output(Output),  stacktop(0x00ull),
    brk(0x00ull), brk_min(0x00ull), brk_max(_REV_HEAP_END_) {
  // Note: this constructor assumes the use of the memHierarchy backend
  pageSize = _XBGAS_PAGE_SIZE_; //262144; //Page Size (in Bytes)
  addrShift = int(log(pageSize) / log(2.0));
  nextPage = 0;

  stacktop = _REVMEM_BASE_ + memSize;

  memStats.bytesRead = 0;
  memStats.bytesWritten = 0;
  memStats.doublesRead = 0;
  memStats.doublesWritten = 0;
  memStats.floatsRead = 0;
  memStats.floatsWritten = 0;
}

RevMem::RevMem( unsigned long MemSize, RevOpts *Opts, SST::Output *Output )
  : physMem(nullptr), memSize(MemSize), opts(Opts), 
    ctrl(nullptr), rmtCtrl(nullptr),
    output(Output), stacktop(0x00ull),
    brk(0x00ull), brk_min(0x00ull), brk_max(_REV_HEAP_END_) {

  // allocate the backing memory
  physMem = new char [memSize];
  pageSize = _XBGAS_PAGE_SIZE_; //262144; //Page Size (in Bytes)
  addrShift = int(log(pageSize) / log(2.0));
  nextPage = 0;

  if( !physMem )
    output->fatal(CALL_INFO, -1, "Error: could not allocate backing memory\n");

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
  if( physMem )
    delete[] physMem;
}

bool RevMem::outstandingRqsts(){
  bool rtn = false;
  
  if( ctrl ){
    // return ctrl->outstandingRqsts();
    rtn = ctrl->outstandingRqsts();
  }

  if( rmtCtrl ){
    return (rtn || (rmtCtrl->outstandingRqsts()));
  }

  // RevMemCtrl is not enabled; no outstanding requests
  return rtn;
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

uint64_t RevMem::CalcPhysAddr(uint64_t Addr){
  uint64_t physAddr = 0;
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

// #ifdef _XBGAS_DEBUG_
//   std::cout << "Addr: 0x" << std::hex << Addr 
//             << ", PhysAddr: 0x" << std::hex << physAddr << std::endl;
// #endif

  return physAddr;
}

bool RevMem::FenceMem(){
  if( ctrl ){
    return ctrl->sendFENCE();
  }
  return true;  // base RevMem support does nothing here
}

bool RevMem::WriteMem( uint64_t Addr, size_t Len, void *Data,
                       StandardMem::Request::flags_t flags){
#ifdef _REV_DEBUG_
  std::cout << "Writing " << Len << " Bytes Starting at 0x" << std::hex << Addr << std::dec << std::endl;
#endif

  if(Addr == 0xDEADBEEF){
    std::cout << "Found special write. Val = " << std::hex << *(int*)(Data) << std::dec << std::endl;
  }
  RevokeFuture(Addr); // revoke the future if it is present; ignore the return
  
  uint64_t physAddr = CalcPhysAddr(Addr);
  char *DataMem = (char *)(Data);

  uint64_t firstPageNum = Addr >> addrShift;
  uint64_t firstPageEnd = (firstPageNum << addrShift) | (pageSize - 1);

  uint32_t tmpLen = 0;
  uint32_t lenCount = 0;
  uint64_t tmpPhysAddr = 0;
  uint64_t tmpPageNum = 0;
  uint64_t tmpPageEnd = 0;
  uint64_t tmpStartAddr = 0;

  uint64_t endAddr = Addr + Len - 1;
  uint64_t lastPageNum   = endAddr >> addrShift;

  //check to see if we're about to walk off the page....
  if((Addr + Len - 1) > firstPageEnd){
    tmpStartAddr = Addr;
    while( tmpStartAddr < endAddr ){
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
      if( ctrl ){
        ctrl->sendWRITERequest(tmpStartAddr,
                               tmpPhysAddr,
                               tmpLen,
                               &DataMem[lenCount],
                               flags);
      } else{
        char *BaseMem = &physMem[tmpPhysAddr];
        for( unsigned j=0; j< tmpLen; j++ ){
            BaseMem[j] = DataMem[j + lenCount];
        }
      }
      // Move to the next page
      tmpStartAddr = tmpStartAddr + tmpLen;
      lenCount = lenCount + tmpLen;
    }
  } else {
    if( ctrl ) {
      ctrl->sendWRITERequest(Addr,
                             physAddr,
                             Len,
                             DataMem,
                             flags);
    } else {
      char *BaseMem = &physMem[physAddr];
      for( unsigned i=0; i<Len; i++ ){
        BaseMem[i] = DataMem[i];
      }
    }
  }
  memStats.bytesWritten += Len;
  return true;
}

bool RevMem::WriteMem( uint64_t Addr, size_t Len, void *Data ){
// #ifdef _REV_DEBUG_
#ifdef _XBGAS_DEBUG_
  std::cout << "Writing " << Len << " Bytes Starting at 0x" << std::hex << Addr << std::dec << std::endl;
#endif

  if(Addr == 0xDEADBEEF){
    std::cout << "Found special write. Val = " << std::hex << *(int*)(Data) << std::dec << std::endl;
  }
  RevokeFuture(Addr); // revoke the future if it is present; ignore the return
  
  uint64_t physAddr = CalcPhysAddr(Addr);
  char *DataMem = (char *)(Data);

  uint64_t firstPageNum = Addr >> addrShift;
  uint64_t firstPageEnd = (firstPageNum << addrShift) | (pageSize - 1);

  uint32_t tmpLen = 0;
  uint32_t lenCount = 0;
  uint64_t tmpPhysAddr = 0;
  uint64_t tmpPageNum = 0;
  uint64_t tmpPageEnd = 0;
  uint64_t tmpStartAddr = 0;

  uint64_t endAddr = Addr + Len - 1;
  uint64_t lastPageNum   = endAddr >> addrShift;

  //check to see if we're about to walk off the page....
  if((Addr + Len - 1) > firstPageEnd){
    tmpStartAddr = Addr;
    while( tmpStartAddr < endAddr ){
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
      if( ctrl ){
        ctrl->sendWRITERequest(tmpStartAddr,
                               tmpPhysAddr,
                               tmpLen,
                               &DataMem[lenCount],
                               0x00);
      } else{
        char *BaseMem = &physMem[tmpPhysAddr];
        for( unsigned j=0; j< tmpLen; j++ ){
            BaseMem[j] = DataMem[j + lenCount];
        }
      }
      // Move to the next page
      tmpStartAddr = tmpStartAddr + tmpLen;
      lenCount = lenCount + tmpLen;
    }
  } else {
    if( ctrl ) {
      ctrl->sendWRITERequest(Addr,
                             physAddr,
                             Len,
                             DataMem,
                             0x00);
    } else {
      char *BaseMem = &physMem[physAddr];
      for( unsigned i=0; i<Len; i++ ){
        BaseMem[i] = DataMem[i];
      }
    }
  }
  memStats.bytesWritten += Len;
  return true;
}

bool RevMem::ReadMem( uint64_t Addr, size_t Len, void *Data ){
// #ifdef _REV_DEBUG_
#ifdef _XBGAS_DEBUG_
  std::cout << "Reading " << Len << " Bytes Starting at 0x" << std::hex << Addr << std::endl;
#endif
  uint64_t physAddr = CalcPhysAddr(Addr);
  char *DataMem = (char *)(Data);

  uint64_t firstPageNum = Addr >> addrShift;
  uint64_t firstPageEnd = (firstPageNum << addrShift) | (pageSize - 1);

  uint32_t tmpLen = 0;
  uint32_t lenCount = 0;
  uint64_t tmpPhysAddr = 0;
  uint64_t tmpPageNum = 0;
  uint64_t tmpPageEnd = 0;
  uint64_t tmpStartAddr = 0;

  uint64_t endAddr = Addr + Len - 1;
  uint64_t lastPageNum   = endAddr >> addrShift;
  
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
      char *BaseMem = &physMem[tmpPhysAddr];
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
    char *BaseMem = &physMem[physAddr]; 
    for( unsigned i=0; i<Len; i++ ){
      DataMem[i] = BaseMem[i];
    }
  }

  memStats.bytesRead += Len;
  return true;
}

bool RevMem::ReadMem(uint64_t Addr, size_t Len, void *Target,
                     StandardMem::Request::flags_t flags){
#ifdef _REV_DEBUG_
  std::cout << "NEW READMEM: Reading " << Len << " Bytes Starting at 0x" << std::hex << Addr << std::dec << std::endl;
#endif
  uint64_t physAddr = CalcPhysAddr(Addr);
  uint64_t firstPageNum = Addr >> addrShift;
  uint64_t firstPageEnd = (firstPageNum << addrShift) | (pageSize - 1);

  char *DataMem = (char *)(Target);

  uint32_t tmpLen = 0;
  uint32_t lenCount = 0;
  uint64_t tmpPhysAddr = 0;
  uint64_t tmpPageNum = 0;
  uint64_t tmpPageEnd = 0;
  uint64_t tmpStartAddr = 0;

  uint64_t endAddr = Addr + Len - 1;
  uint64_t lastPageNum   = endAddr >> addrShift;

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
      if( ctrl ){
        ctrl->sendREADRequest(tmpStartAddr, tmpPhysAddr, tmpLen, 
                              &DataMem[lenCount], flags);
      } else { 
        char *BaseMem = &physMem[physAddr]; 
        for( unsigned j=0; j< tmpLen; j++ ){
            DataMem[j] = BaseMem[j + lenCount];
        }
      }
      // Move to the next page
      tmpStartAddr = tmpStartAddr + tmpLen;
      lenCount = lenCount + tmpLen;
    }
#ifdef _REV_DEBUG_
    std::cout << "Warning: Reading off end of page... " << std::endl;
#endif
  }else{
    if( ctrl ) {
      ctrl->sendREADRequest(Addr, physAddr, Len, Target, flags);
    }else{
      char *BaseMem = &physMem[physAddr]; 
      for( unsigned i=0; i<Len; i++ ){
        DataMem[i] = BaseMem[i];
      }
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

bool RevMem::RmtReadMem( uint64_t Nmspace, uint64_t SrcAddr, 
                         uint32_t Size, void *Target, int *RegisterTag){

#ifdef _XBGAS_DEBUG_
        std::cout << "--> Remote Memory Read: Namespace: " << std::dec << Nmspace
                  << ", Source Addr: " << std::hex << SrcAddr
                  << ", Size: " << std::dec << Size << std::endl; 
#endif

  bool rtn = rmtCtrl->sendRmtReadRqst(Nmspace, SrcAddr, Size, Target, RegisterTag);
  return rtn;
}

bool RevMem::RmtBulkReadMem( uint64_t Nmspace, uint64_t SrcAddr, uint32_t Size, 
                     uint32_t Nelem, uint32_t Stride, uint64_t DestAddr, int *RegisterTag) {
#ifdef _XBGAS_DEBUG_
        std::cout << "--> Remote Bulk Memory Read: Namespace: " << std::dec << Nmspace
                  << ", Source Addr: " << std::hex << SrcAddr
                  << ", Size: " << std::dec << Size 
                  << ", Nelem: "<< std::dec << Nelem
                  << ", Stride: "<< std::dec << Stride << std::endl; 
#endif
  bool rtn = rmtCtrl->sendRmtBulkReadRqst(Nmspace, SrcAddr, Size, 
                                          Nelem, Stride, DestAddr, RegisterTag);
  return rtn;
}

bool RevMem::RmtWriteMem( uint64_t Nmspace, uint64_t DestAddr, uint32_t Size, void *Data ){
  uint8_t *Buffer = new uint8_t[Size];
  std::memcpy(Buffer, Data, Size);
  bool rtn = rmtCtrl->sendRmtWriteRqst(Nmspace, DestAddr, Size, Buffer);
  delete [] Buffer;
  return rtn;
}

bool RevMem::RmtBulkWriteMem( uint64_t Nmspace, uint64_t DestAddr, uint32_t Size, 
                      uint32_t Nelem, uint32_t Stride, uint64_t SrcAddr ) {
  bool rtn = rmtCtrl->sendRmtBulkWriteRqst(Nmspace, DestAddr, Size, 
                                           Nelem, Stride, SrcAddr);
  return rtn;
}

/*
* Func: GetNewThreadPID
* - This function is used to interact with the global 
*   PID counter inside of RevMem
* - When a new RevThreadCtx is created, it is assigned 
*   the value of PIDCount++
* - This ensures no collisions because all RevProcs access
*   the same RevMem instance
*/
uint32_t RevMem::GetNewThreadPID(){

  #ifdef _REV_DEBUG_
  std::cout << "RevMem: New PID being given: " << PIDCount+1 << std::endl; 
  #endif
  /*
  * NOTE: A mutex is acquired solely to prevent race conditions
  *       if multiple RevProc's create new Ctx objects at the 
  *       same time
  */
  std::unique_lock<std::mutex> lock(m_mtx);
  PIDCount++;
  lock.unlock();
  return PIDCount;
}

// EOF
