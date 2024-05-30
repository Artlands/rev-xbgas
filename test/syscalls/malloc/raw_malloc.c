#include "../../../common/syscalls/syscalls.h"
#include "printf.h"
#include <stdlib.h>

int main() {
  void* ptr1 = malloc( 1024 );
  printf( "ptr1: %p\n", ptr1 );

  void* ptr2 = malloc( 4096 );
  printf( "ptr2: %p\n", ptr2 );

  void* ptr3 = malloc( 2048 );
  printf( "ptr3: %p\n", ptr3 );

  printf( "Freeing ptr1: %p\n", ptr1 );
  free( ptr1 );

  printf( "Freeing ptr3: %p\n", ptr3 );
  free( ptr3 );

  printf( "Freeing ptr2: %p\n", ptr2 );
  free( ptr2 );
}
