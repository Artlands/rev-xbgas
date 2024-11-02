#include "../../../common/syscalls/syscalls.h"
#include <stdlib.h>
#define printf rev_fast_printf

int main() {
  int* array = (int*) malloc( 1 * sizeof( int ) );
  array[0]   = 1;
  printf( "Array: %d", array[0] );
}
