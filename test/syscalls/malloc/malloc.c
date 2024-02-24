#include "../../../common/syscalls/syscalls.h"
#include "malloc.h"
#include "printf.h"


void *malloc(size_t size) {
  if( size <= 0 ) {
    return NULL;
  }

  // Align size to include the metadata structure and achieve proper alignment
  size_t total_size = align8(BLOCK_SIZE + size);

  // printf("malloc: requested %lu bytes\n", size);
  // printf("malloc: BLOCK_SIZE = %lu\n", BLOCK_SIZE);
  // printf("malloc: allocating %lu bytes\n", total_size);

  // Request memory from the REV system call
  void *block = (void *)rev_mmap(0,
                                 total_size,
                                 PROT_READ | PROT_WRITE,
                                 MAP_PRIVATE | MAP_ANONYMOUS,
                                 -1,
                                 0);
  
  // Initialize the block metadata
  mem_block *block_header = (mem_block *)block;
  // Since the memory allocation is actually managed by the REV system call,
  // we only need to record the size of the block that is used when freeing the block
  block_header->size = size;

  // Return the pointer to the user data
  return (void *)((char *)block + BLOCK_SIZE);
}

void free(void *ptr) {
  if( !ptr ) {
    return;
  }

  // Get the block metadata
  mem_block *block_header = (mem_block *)((char *)ptr - BLOCK_SIZE);

  // Total size of the block
  size_t total_size = align8(BLOCK_SIZE + block_header->size);

  // Free the block using the REV system call
  rev_munmap((uint64_t)block_header, total_size);
}

int main () {
  void *ptr1 = malloc( 1022 );
  printf( "ptr1: %p\n", ptr1);
  free( ptr1 );

  void *ptr2 = malloc( 8000 );
  printf( "ptr2: %p\n", ptr2);
  free( ptr2 );
}