#include "../../../common/syscalls/syscalls.h"
#include "../printf/printf.h"
#include "malloc.h"

int main() {
  int* array = (int*) malloc( 1 * sizeof( int ) );
  array[0]   = 1;
  printf( "Array: %d", array[0] );
}
