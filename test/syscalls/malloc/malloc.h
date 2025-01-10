#include "../../../common/syscalls/syscalls.h"
#include <stddef.h>
#include <stdlib.h>

#define _DEFAULT_ALIGNMENT_ 8
#define _MEM_META_SIZE_     32

void* __malloc_align( size_t size, size_t alignment ) {
  if( size <= 0 ) {
    return NULL;
  }
  // Calculate the total size to be allocated from REV system call.
  // The total size includes the requested size, the size of the original pointer
  // and the size of the aligned memory address, and it is aligned to the alignment.
  size_t    total_size = ( ( size + 2 * sizeof( uintptr_t ) - 1 ) / alignment + 1 ) * alignment;
  uintptr_t original   = (uintptr_t) rev_mmap( 0, total_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0 );
  if( original == 0 ) {
    return NULL;
  }
  // Find the aligned memory address after original
  uintptr_t aligned            = ( original + 2 * sizeof( uintptr_t ) + alignment - 1 ) & ~( alignment - 1 );

  // Store the original pointer and size just before the aligned memory
  ( (uintptr_t*) aligned )[-2] = original;
  ( (uintptr_t*) aligned )[-1] = total_size;

#ifdef _ALLOC_DEBUG_
  printf(
    "_XBRTIME_DEBUG_ : Allocate a new segment on private heap. Aligned pointer %p, Original pointer: %p, Size: %lu",
    (void*) aligned,
    (void*) original,
    total_size
  );
#endif

  return (void*) aligned;
}

void __free_align( void* ptr, size_t alignment ) {
  if( !ptr ) {
    return;
  }
  // Call the REV system call to free memory
  rev_munmap( (unsigned long) ( ( (uintptr_t*) ptr )[-2] ), ( (uintptr_t*) ptr )[-1] );

#ifdef _ALLOC_DEBUG_
  printf(
    "_XBRTIME_DEBUG_ : Free the memory on private heap. Aligned pointer: %p, Original pointer: %p, Size: %lu",
    ptr,
    (unsigned long) ( ( (uintptr_t*) ptr )[-2] ),
    ( (uintptr_t*) ptr )[-1]
  );
#endif

  return;
}

void* malloc( size_t size ) {
  return __malloc_align( size, _DEFAULT_ALIGNMENT_ );
}

void* realloc( void* ptr, size_t new_size ) {
  void*  new_ptr  = NULL;
  size_t old_size = 0;

  if( ptr == NULL ) {
    return malloc( new_size );
  }

  if( new_size == 0 ) {
    free( ptr );
    return NULL;
  }

  old_size = ( (uintptr_t*) ptr )[-1];
  if( old_size >= new_size ) {
    return ptr;
  }

  new_ptr = __malloc_align( new_size, _DEFAULT_ALIGNMENT_ );
  if( new_ptr == NULL ) {
    return NULL;
  }

  // Copy the old data to the new location
  for( size_t i = 0; i < old_size; i++ ) {
    ( (char*) new_ptr )[i] = ( (char*) ptr )[i];
  }

  // Free the old memory
  __free_align( ptr, _DEFAULT_ALIGNMENT_ );

  return new_ptr;
}

void free( void* ptr ) {
  __free_align( ptr, _DEFAULT_ALIGNMENT_ );
}

/* EOF */
