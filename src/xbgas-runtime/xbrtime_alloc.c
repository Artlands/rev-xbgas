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

void *global_base = NULL;
void *rev_heap_top = (void *)(_REV_HEAP_START_);

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
  new->size = b->size - sz - META_SIZE;
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
  b = (b_meta)(rev_heap_top);
  if ( ((uint64_t)(rev_heap_top) + sz) > (uint64_t)(_REV_HEAP_END_) ) {
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

  rev_heap_top = rev_heap_top + META_SIZE + sz;
  return (b);
}

/* Fusion memory block segments*/
b_meta fusion(b_meta b){
  if( b->next && b->next->free){
    b->size += META_SIZE + b->next->size;
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
  return (p = tmp -= META_SIZE);
}

/* Valid addr for free */
int valid_addr(void *p){
  if( global_base ){
    if( p > global_base && p < rev_heap_top ){
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
      if ( (b->size - sz) >= (META_SIZE + 8) ){
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

// #ifdef _XBGAS_DEBUG_
//   int id = (int)(*(uint64_t *)(_XBGAS_MY_PE_ADDR_));
//   if (id == 0) 
//   { 
//     printf("_XBGAS_DEBUG_ CPU %d: Allocate memory at 0x%"PRIu64", size=%zu\n", id, b->data, size);
//   }
// #endif

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
      rev_heap_top = b;
    }
  }
}

void *__xbrtime_shared_malloc( size_t sz ){
  uint64_t _STARTADDR_ADDR_;
  uint64_t _SIZE_ADDR;
  void *ptr = NULL;
  int slot = -1;
  int i = 0;
  int done = 0;

  /* find an open slot */
  while( (slot == -1) && (done != 1) ){
    _STARTADDR_ADDR_ = _XBRTIME_MEM_T_ADDR_ + i * 16;
    _SIZE_ADDR = _STARTADDR_ADDR_ + 8;
    uint64_t start_addr = *((uint64_t *)_STARTADDR_ADDR_);
    size_t size = (size_t)(*((uint64_t *)_SIZE_ADDR));
    if ( size == 0 ) {
      slot = i;
      done = 1;
    }
    i++;
    if (i == _XBRTIME_MEM_SLOTS_ ){
      done = 1;
    }
  }

  /* no open slots */
  if( slot == -1 ){
    return NULL;
  }

  /* attempt to create an allocation */
  ptr = revmalloc( sz );
  
  _STARTADDR_ADDR_ = _XBRTIME_MEM_T_ADDR_ + slot * 16;
  _SIZE_ADDR = _STARTADDR_ADDR_ + 8;
  *((uint64_t *)_STARTADDR_ADDR_) = (uint64_t)(ptr);
  *((uint64_t *)_SIZE_ADDR) = sz;

  return ptr;
}

void __xbrtime_shared_free( void *ptr ){
  int i = 0;
  uint64_t addr = (uint64_t)(ptr);
  for( i=0; i < _XBRTIME_MEM_SLOTS_; i++ ){
    uint64_t _STARTADDR_ADDR_ = _XBRTIME_MEM_T_ADDR_ + i * 16;
    uint64_t _SIZE_ADDR = _STARTADDR_ADDR_ + 8;
    uint64_t start_addr = *((uint64_t *)_STARTADDR_ADDR_);
    size_t size = (size_t)(*((uint64_t *)_SIZE_ADDR));
    if( (addr >= start_addr) &&
        (addr < start_addr + size )) {
          revfree( ptr );
        }
  }

}

extern void *xbrtime_alloc( size_t sz ){
  void *ptr = NULL;

  /* sanity check */
  if( sz == 0 ){
    return NULL;
  }

  ptr = __xbrtime_shared_malloc( sz );
  return ptr;
}

extern void xbrtime_free( void *ptr ){
  if( ptr == NULL ) {
    return;
  }
  __xbrtime_shared_free(ptr);
  __xbrtime_asm_quiet_fence();
}

