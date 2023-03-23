//
// _XBRTIME_ALLOC_C_
//
// Copyright (C) 2017-2021 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#include "xbrtime.h"
#include "xbrtime_alloc.h"

void *global_base  = NULL;
// void *rev_heap_top = (void *)(*(uint64_t *)(_REV_HEAP_START_ADDR_));

// /* ------------------------------------------------- FUNCTION PROTOTYPES */
uint64_t __xbrtime_get_remote_alloc( uint64_t slot, int pe );
int xbrtime_decode_pe( int pe );
void __xbrtime_asm_quiet_fence();


extern void *revmalloc( size_t size ){
  int32_t heap_end = (int32_t)(_REV_HEAP_END_);
  mem_block *current_block, *new_block;
  
  if ( global_base ) {
    /* Search for a free block in the heap */
    current_block = global_base;

    while ( current_block != NULL ){
      if( current_block->free && current_block->size >= size ){
        /* Found a block that is free and big enough */
        if (current_block->size > size + sizeof(mem_block)){
          /* Split the block into two blocks */
          new_block = (mem_block*)((void *)(current_block + sizeof(mem_block) + size));
          new_block->size = current_block->size - sizeof(mem_block) - size;
          new_block->free = 1;
          new_block->prev = current_block;
          new_block->next = current_block->next;
          current_block->size = size;
          current_block->next = new_block;
        }
        current_block->free = 0;
        return ((void *)(current_block + 1));
      }
      current_block = current_block->next;
    }

    /* if no free block is found, return NULL */
    if (current_block == NULL) { 
      // *((uint64_t*)(_XBGAS_DEBUG_ERROR1_)) = 0b01;  // Debug
      revprintf("revmalloc fails\n");
      return NULL;
    }

  } else {
    /* First malloc*/
    current_block = (mem_block*)((void *)(*(uint64_t*)(_REV_HEAP_START_ADDR_)));
    current_block->size = size;
    current_block->free = 0;
    current_block->prev = NULL;
    
    /* Split the remaining block */
    new_block = (mem_block*)((void*)(current_block) + sizeof(mem_block) + size);
    new_block->size = heap_end - (int32_t)(sizeof(mem_block) + size);
    new_block->free = 1;
    new_block->prev = current_block;
    new_block->next = NULL;
    
    // *((uint64_t*)(_XBGAS_DEBUG_ERROR0_)) = (uint64_t)(new_block->size);  // Debug
    /* Update the current block*/
    current_block->next = new_block;

    /* Set global base */
    global_base = current_block;
    return ((void *)(current_block + 1));
  }
}

extern void revfree( void *ptr ) {
  char *tmp = ptr;
  mem_block *current_block, *prev_block;
  if( ptr == NULL ){
    return;
  }
  /* Check if the pointer is valid and get the block if it is valid */
  if (global_base == NULL){
    return;
  } else {
    /* Find the block corresponding to the given pointer */
    current_block = (mem_block*)((void *)(tmp - sizeof(mem_block)));
    prev_block = current_block->prev;

    /* Mark the block as free */
    current_block->free = 1;

    /* Reset the data in the block*/
    for( unsigned long i=0; i<(int32_t)(current_block->size); i++ ){
      *(char *)(tmp + i) = 0;
      // *((uint64_t*)(_XBGAS_DEBUG_ERROR0_)) = (uint64_t)(tmp + i);  // Debug
    }

    /* Merge adjacent free blocks */
    while( current_block->next != NULL && current_block->next->free){
      current_block->size += sizeof(mem_block) + current_block->next->size;
      current_block->next = current_block->next->next;
    }

    if (prev_block != NULL && prev_block->free) {
      prev_block->size += sizeof(mem_block) + current_block->size;
      prev_block->next = current_block->next;
    }
  }
}

void *__xbrtime_shared_malloc( size_t sz ){
  void *ptr = NULL;
  int slot  = -1;
  int i     = 0;
  int done  = 0;

  /* align the requested size to 8-byte boundary */
  sz = (sz + 7) & ~7;

  /* find an open slot */
  while( (slot == -1) && (done != 1) ){
    if( (uint64_t)(*(uint64_t*)(_XBGAS_MMAP_ + (uint64_t)(i * 16 + 8))) == 0){
      slot = i;
      done = 1;
    }
    i++;
    if( i == _XBRTIME_MEM_SLOTS_ ){
      done = 1;
    }
  }

  /* no open slots */
  if( slot == -1 ) {
    return NULL;
  }

  /* attempt to create an allocation */
  ptr = revmalloc( sz );
  // ptr = malloc( sz );
  if( ptr == NULL ) {
    return NULL;
  }

  /* memory is good, register the block */
  *((uint64_t*)(_XBGAS_MMAP_ + (uint64_t)(slot * 16 + 8))) = (uint64_t)(sz);   // size
  *((uint64_t*)(_XBGAS_MMAP_ + (uint64_t)(slot * 16)))     = (uint64_t)(ptr);  // start address

  /* write sz and ptr to xbgas firmware */
  int64_t tmp = (int64_t)(*(uint64_t *)(_XBGAS_SHARED_MEM_SIZE_));
  *(uint64_t *)(_XBGAS_SHARED_MEM_SIZE_) = (uint64_t)((int64_t)sz + tmp);
  *(uint64_t *)(_XBGAS_SHARED_MEM_START_ADDR_) = (uint64_t)(ptr);

  return ptr;
}

void __xbrtime_shared_free(void *ptr){
  uint64_t mem = (uint64_t)(ptr);
  int i = 0;

  /*
   * walk the allocated blocks and attempt to free
   * the allocation
   *
   */
  for( i=0; i<_XBRTIME_MEM_SLOTS_; i++ ){
      if( (mem >= (int64_t)(*(uint64_t*)(_XBGAS_MMAP_ + (uint64_t)(i * 16)))) &&
          (mem < ((int64_t)(*(uint64_t*)(_XBGAS_MMAP_ + (uint64_t)(i * 16))) + 
                  (int64_t)(*(uint64_t*)(_XBGAS_MMAP_ + (uint64_t)(i * 16 + 8))))) ){
      /* found the allocation */
      revfree( ptr );
      // free(ptr);

      /* update values of sz and ptr in xbgas firmware */
      int64_t tmp = (int64_t)(*(uint64_t*)(_XBGAS_SHARED_MEM_SIZE_));
      int64_t sz  = (int64_t)(*(uint64_t*)(_XBGAS_MMAP_ + (uint64_t)(i * 16 + 8)));
      *(uint64_t *)(_XBGAS_SHARED_MEM_SIZE_) = (uint64_t)(tmp - sz);
      *(uint64_t *)(_XBGAS_SHARED_MEM_START_ADDR_) = 0x00ull;

      *((uint64_t*)(_XBGAS_MMAP_ + (uint64_t)(i * 16)))     = 0x00ull;   // start address
      *((uint64_t*)(_XBGAS_MMAP_ + (uint64_t)(i * 16 + 8))) = 0x00ull;   // size
      return ;
    }
  }
}

extern void *xbrtime_malloc( size_t sz ){
  void *ptr = NULL;

  /* sanity check */
  if( sz == 0 ){
    return NULL;
  }
  ptr = __xbrtime_shared_malloc( sz );
  __xbrtime_asm_quiet_fence();

  return ptr;
}

extern void xbrtime_free( void *ptr ){
  if( ptr == NULL ) {
    return;
  } 
  __xbrtime_shared_free(ptr);
  __xbrtime_asm_quiet_fence();
}

uint64_t __xbrtime_ltor(uint64_t remote, int pe){
  int i               = 0;
  uint64_t base_slot  = 0x00ull;
  uint64_t offset     = 0x00ull;
  uint64_t new_addr   = 0x00ull;

  if( xbrtime_mype() == pe ){
    /* return the same address block */
    return remote;
  }else{
    /* perform the address translation */
    for( i=0; i<_XBRTIME_MEM_SLOTS_; i++ ){
        if( (remote >= (int64_t)(*(uint64_t*)(_XBGAS_MMAP_ + (uint64_t)(i * 16)))) &&
            (remote < ((int64_t)(*(uint64_t*)(_XBGAS_MMAP_ + (uint64_t)(i * 16))) + 
                       (int64_t)(*(uint64_t*)(_XBGAS_MMAP_ + (uint64_t)(i * 16 + 8))))) ){
        /* found our slot */
        base_slot = (uint64_t)(_XBGAS_MMAP_ + (uint64_t)(i * 16));

        /* calculate the local offset */
        offset = remote - (int64_t)(*(uint64_t*)(_XBGAS_MMAP_ + (uint64_t)(i * 16)));

        new_addr = __xbrtime_get_remote_alloc(base_slot, xbrtime_decode_pe(pe))
                                             +offset;

        return new_addr;
      }
    }
  }
  /*
   * if we reach this point, there is an error in translation
   * return 0x00ull will cause a user access violation on the
   * memory operation and raise a segmentation fault
   *
   */
  return 0x00ull;
}

