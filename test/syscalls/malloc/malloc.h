// See LICENSE for license details.

#include "../../../common/syscalls/syscalls.h"
#include <stddef.h>

#define SYS_write    64
#define align8( x )  ( ( ( ( ( x ) - 1 ) >> 3 ) << 3 ) + 8 )
#define PAGE_SIZE    4096
#define MAX_SEGMENTS 1024

typedef struct mem_block {
  // The order of the members should not be changed
  int               free;
  size_t            size;
  struct mem_block* next;
  struct mem_block* prev;
} mem_block;

typedef struct mem_segment {
  uint64_t start;
  uint64_t end;
} mem_segment;

#define BLOCK_SIZE sizeof( mem_block )

// base stores the head of the memory block list
void*       base                   = NULL;
int         num_segments           = 0;
mem_segment segments[MAX_SEGMENTS] = { 0 };

void* alloc_new_block( size_t size ) {
  // Request memory from the REV system call
  mem_block* block = (mem_block*) rev_mmap( 0, size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0 );
  // Initialize the block metadata
  block->free      = 1;
  block->size      = size - ( align8( BLOCK_SIZE ) );
  block->next      = NULL;
  block->prev      = NULL;

  // Add the memory segment to the list
  if( num_segments < MAX_SEGMENTS ) {
    segments[num_segments].start = (unsigned long) block;
    segments[num_segments].end   = (unsigned long) block + size - 1;
    num_segments++;
  } else {
    return NULL;
  }

  // add the new block to the list
  if( !base ) {
    base = block;
  } else {
    mem_block* last = base;
    // Add the block to the end of the list
    while( last->next ) {
      last = last->next;
    }
    last->next  = block;
    block->prev = last;
  }
  return block;
}

int in_same_segment( mem_block* block1, mem_block* block2 ) {
  for( int i = 0; i < num_segments; i++ ) {
    if( segments[i].start <= (unsigned long) block1 && segments[i].end >= (unsigned long) block1 &&
        segments[i].start <= (unsigned long) block2 && segments[i].end >= (unsigned long) block2 ) {
      return 1;
    }
  }
  return 0;
}

mem_block* merge_blocks( mem_block* block ) {
  // Merge the block with its neighbor blocks if any of them is free and
  // within the same memory segment
  if( block->next && block->next->free && in_same_segment( block, block->next ) ) {
    block->free = 1;
    block->size += align8( BLOCK_SIZE ) + block->next->size;
    block->next = block->next->next;
    if( block->next ) {
      block->next->prev = block;
    }
  }
  if( block->prev && block->prev->free && in_same_segment( block, block->prev ) ) {
    block->prev->free = 1;
    block->prev->size += align8( BLOCK_SIZE ) + block->size;
    block->prev->next = block->next;
    if( block->next ) {
      block->next->prev = block->prev;
    }
    return block->prev;
  }
  return block;
}

void split_block( mem_block* block, size_t size ) {
  // Split the block
  mem_block* new_block = (mem_block*) ( (char*) block + align8( BLOCK_SIZE ) + align8( size ) );
  new_block->free      = 1;
  new_block->size      = block->size - align8( size ) - align8( BLOCK_SIZE );
  new_block->next      = block->next;
  new_block->prev      = block;

  block->free          = 0;
  block->size          = align8( size );
  block->next          = new_block;
  if( new_block->next ) {
    new_block->next->prev = new_block;
  }
}

mem_block* find_block( mem_block* base, size_t size ) {
  mem_block* current = base;
  while( current && !( current->free && current->size >= size ) ) {
    current = current->next;
  }
  return current;
}

void* malloc( size_t size ) {
  if( size <= 0 ) {
    return NULL;
  }
  mem_block* block;

  // Align size to include the metadata structure and achieve proper alignment
  size_t total_size         = align8( BLOCK_SIZE ) + align8( size );
  // Round the total size to the page size
  size_t rounded_total_size = ( ( total_size - 1 ) / PAGE_SIZE + 1 ) * PAGE_SIZE;

  if( !base ) {
    // If the list is empty, allocate a new block with the rounded page size
    block = alloc_new_block( rounded_total_size );
    if( block ) {
      split_block( block, size );
      return (void*) ( (char*) block + align8( BLOCK_SIZE ) );
    } else {
      return NULL;
    }
  } else {
    // If the list is not empty, find a free block
    block = find_block( base, total_size );
    if( block ) {
      split_block( block, size );
      return (void*) ( (char*) block + align8( BLOCK_SIZE ) );
    } else {
      // If no block is found, allocate a new block with the page size
      block = alloc_new_block( rounded_total_size );
      if( block ) {
        split_block( block, size );
        return (void*) ( (char*) block + align8( BLOCK_SIZE ) );
      } else {
        return NULL;
      }
    }
  }
}

void free( void* ptr ) {
  if( !ptr ) {
    return;
  }
  // Find the block corresponding to the pointer
  mem_block* block = (mem_block*) ( (char*) ptr - align8( BLOCK_SIZE ) );
  // Mark the block as free
  block->free      = 1;

  // Merge the block with the neighbor blocks, block will be updated to the
  // start of the merged block
  block            = merge_blocks( block );

  // If the block is at the start of the memory segment and the size is equal to
  // the segment size, unmap the segment
  for( int i = 0; i < num_segments; i++ ) {
    if( segments[i].start == (unsigned long) block &&
        segments[i].end == (unsigned long) block + block->size + align8( BLOCK_SIZE ) - 1 ) {
      // This block can be unmapped, before unmapping, remove the block from the list
      if( block->prev ) {
        block->prev->next = block->next;
      } else {
        base = block->next;
      }
      if( block->next ) {
        block->next->prev = block->prev;
      }
      // Unmap the block
      rev_munmap( (unsigned long) block, block->size + align8( BLOCK_SIZE ) );
      // Remove the segment from the list if the segment is at the end
      if( i == num_segments - 1 ) {
        segments[i].start = 0;
        segments[i].end   = 0;
        num_segments--;
      } else {
        // If the segment is not at the end, move the last segment to the current position
        segments[i].start                = segments[num_segments - 1].start;
        segments[i].end                  = segments[num_segments - 1].end;
        segments[num_segments - 1].start = 0;
        segments[num_segments - 1].end   = 0;
        num_segments--;
      }
      break;
    }
  }

  return;
}
