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

b_meta find_block(b_meta *last, size_t size){
  b_meta b = global_base;
  while(b && !(b->free && b->size >=size)) {
    *last = b;
    b = b->next;
  }
  return (b);
}

/* Split block according to size */
void split_block( b_meta b, size_t sz){
  b_meta new;
  new = (b_meta)(b->data + sz);
  new->size = b->size - sz - sizeof(b_meta);
  new->next = b->next;
  new->prev = b;
  new->free = 1;
  new->ptr = new->data;
  b->size = sz;
  b->next = new;
  if( new->next ){
    new->next->prev = new;
  }
}

/* Add a new block at the end of heap */
b_meta extend_heap(b_meta last, size_t sz){
  b_meta b;
  uint64_t heap_top = (uint64_t)(*(uint64_t*)(_REV_HEAP_START_ADDR_));
  // b = (b_meta)(rev_heap_top);
  b = (b_meta)((void *)(heap_top));
  if ( ((int64_t)(*((uint64_t*)_REV_HEAP_START_ADDR_)) + sz) > (int64_t)(_REV_HEAP_END_) ) {
    return NULL;
  }
  b->size = sz;
  b->next = NULL;
  b->prev = last;
  b->ptr = b->data;

  if( last ){
    last->next = b;
  }
  b->free = 0;

  // rev_heap_top = rev_heap_top + sizeof(b_meta) + sz;
  *((uint64_t*)_REV_HEAP_START_ADDR_) = heap_top + (uint64_t)(sizeof(b_meta) + sz);
  return (b);
}

/* Fusion memory block segments*/
b_meta fusion(b_meta b){
  if( b->next && b->next->free){
    b->size += sizeof(b_meta) + b->next->size;
    b->next = b->next->next;
    if (b->next){
      b->next->prev = b;
    }
  }
  return b;
}

/* Get the block from addr */
b_meta get_block(void *p){
  char *tmp;
  tmp = p;
  return (p = tmp -= sizeof(b_meta));
}

/* Valid addr for free */
int valid_addr(void *p){
  if( global_base ){
    // if( p > global_base && p < rev_heap_top ){ 
    if( p > global_base && p < (void *)(*((uint64_t*)_REV_HEAP_START_ADDR_))){
      return (p == (get_block(p))-> ptr);
    }
  }
  return 0;
}

extern void *revmalloc( size_t size ){
  b_meta b, last;
  size_t sz;
  sz = align8(size);
  if ( global_base ) {
    last = global_base;
    b = find_block(&last, sz);
    if (b){
      if ( (b->size - sz) >= (sizeof(b_meta)) ){
        split_block(b, sz);
      }
      b->free = 0;
    } else {
      /* No fitting block, extend the heap */
      b = extend_heap(last, sz);
      if ( !b ){
        return NULL;
      }
    }
  } else {
    /* first malloc*/
    b = extend_heap(NULL, sz);
    if ( !b ){
      return NULL;
    }
    global_base = b;
  }

  return( b->data );
}

extern void revfree( void *p ) {
  b_meta b;
  if( valid_addr(p) ){
    b = get_block(p);
    b->free = 1;
    if( b->prev && b->prev->free){
      b = fusion(b->prev);
    }
    if( b->next ){
      fusion(b);
    } else {
      /* free the end of the heap */
      if( b->prev ){
        b->prev->next = NULL;
      } else {
        global_base = NULL;
      }
      // rev_heap_top = b;
      *((uint64_t*)_REV_HEAP_START_ADDR_) = (uint64_t)(b);
    }
  }
}

void *__xbrtime_shared_malloc( size_t sz ){
  void *ptr = NULL;
  int slot  = -1;
  int i     = 0;
  int done  = 0;

  /* find an open slot */
  while( (slot == -1) && (done != 1) ){
    // if( __XBRTIME_CONFIG->_MMAP[i].size == 0 ){
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
  // __XBRTIME_CONFIG->_MMAP[slot].size = sz;
  // __XBRTIME_CONFIG->_MMAP[slot].start_addr = (uint64_t)(ptr);
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
    // if( (mem >= __XBRTIME_CONFIG->_MMAP[i].start_addr) &&
    //     (mem < (__XBRTIME_CONFIG->_MMAP[i].start_addr+
    //             __XBRTIME_CONFIG->_MMAP[i].size)) ){
      if( (mem >= (int64_t)(*(uint64_t*)(_XBGAS_MMAP_ + (uint64_t)(i * 16)))) &&
          (mem < ((int64_t)(*(uint64_t*)(_XBGAS_MMAP_ + (uint64_t)(i * 16))) + 
                  (int64_t)(*(uint64_t*)(_XBGAS_MMAP_ + (uint64_t)(i * 16 + 8))))) ){
      /* found the allocation */
      revfree( ptr );
      // free(ptr);
      // __XBRTIME_CONFIG->_MMAP[i].start_addr = 0x00ull;
      // __XBRTIME_CONFIG->_MMAP[i].size = 0;

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
  // else if( __XBRTIME_CONFIG == NULL ){
  //   return;
  // } else if(__XBRTIME_CONFIG->_MMAP == NULL ) {
  //   return;
  // }
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
      // if( (remote >= __XBRTIME_CONFIG->_MMAP[i].start_addr) &&
      //     (remote < (__XBRTIME_CONFIG->_MMAP[i].start_addr+
      //                __XBRTIME_CONFIG->_MMAP[i].size)) ){
        if( (remote >= (int64_t)(*(uint64_t*)(_XBGAS_MMAP_ + (uint64_t)(i * 16)))) &&
            (remote < ((int64_t)(*(uint64_t*)(_XBGAS_MMAP_ + (uint64_t)(i * 16))) + 
                       (int64_t)(*(uint64_t*)(_XBGAS_MMAP_ + (uint64_t)(i * 16 + 8))))) ){
        /* found our slot */
        // base_slot = (uint64_t)(&__XBRTIME_CONFIG->_MMAP[i].start_addr);
        base_slot = (uint64_t)(_XBGAS_MMAP_ + (uint64_t)(i * 16));

        /* calculate the local offset */
        // offset = remote - __XBRTIME_CONFIG->_MMAP[i].start_addr;
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

