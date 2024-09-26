#include "isa_test_macros.h"
#include "malloc.h"
#include "syscalls.h"
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#define printf rev_fast_printf

extern int __xbrtime_asm_get_id();
extern int __xbrtime_asm_get_npes();
#define DEBUG 0

int main( int argc, char** argv ) {
  struct __kernel_timespec s, e, e0, e1, e2, e3, e4;
  rev_clock_gettime( 0, &s );

  // Get the PE ID and number of PEs
  int id   = __xbrtime_asm_get_id();
  int npes = __xbrtime_asm_get_npes();
  if( DEBUG ) {
    printf( "Hello from PE %d of %d\n", id, npes );
  }

  // Get the number of elements and the assembly instruction from the command line argument
  int  nelem           = 8;       // default value
  char instruction[10] = "eblh";  // default instruction

  if( argc > 1 ) {
    nelem = atoi( argv[1] );  // Convert argument to integer
  }

  if( argc > 2 ) {
    strncpy( instruction, argv[2], 9 );  // Copy the assembly instruction from the command line
    instruction[9] = '\0';               // Ensure null termination
  }

  if( DEBUG ) {
    printf( "Number of elements to be transferred: %d\n", nelem );
    printf( "Assembly instruction: %s\n", instruction );
  }

  // Set the remote namespace
  uint64_t namespace;

  if( id == 0 ) {
    namespace = 2;
  } else if( id == 1 ) {
    namespace = 1;
  }

  asm volatile( " eaddie e14, %0, 0 \n\t " : : "r"( namespace ) );
  rev_clock_gettime( 0, &e0 );
  printf( "PE %d Setup Took %ld nanoseconds before transfer", id, e0.tv_nsec - s.tv_nsec );
  // Declare src2 and dest based on the chosen assembly instruction
  if( strcmp( instruction, "eblb" ) == 0 || strcmp( instruction, "eblbu" ) == 0 ) {
    // For int8_t
    int8_t* dest = malloc( sizeof( int8_t ) * nelem );
    int8_t* src2 = malloc( sizeof( int8_t ) * nelem );
    for( int i = 0; i < nelem; i++ ) {
      src2[i] = 0x01;  // Fill with 0x01 as per the example
    }
    if( id == 0 ) {
      int ret = rev_clock_gettime( 0, &s );
      assert( ret == 0 );

      asm volatile( " eblb %0, %1, %2, %3 \n\t " : : "r"( dest ), "r"( src2 ), "r"( nelem ), "r"( sizeof( int8_t ) ) );
      __xbrtime_wait_bulk_comp();

      ret = rev_clock_gettime( 0, &e );
      assert( ret == 0 );
      printf( "Took %ld nanoseconds", e.tv_nsec - s.tv_nsec );
    }
    //free( dest );
    //free( src2 );
  } else if( strcmp( instruction, "eblb" ) == 0 || strcmp( instruction, "eblbu" ) == 0 ) {
    // For uint8_t
    uint8_t* dest = malloc( sizeof( uint8_t ) * nelem );
    uint8_t* src2 = malloc( sizeof( uint8_t ) * nelem );
    for( int i = 0; i < nelem; i++ ) {
      src2[i] = 0x01;  // Fill with 0x01 as per the example
    }
    if( id == 0 ) {
      int ret = rev_clock_gettime( 0, &s );
      assert( ret == 0 );

      asm volatile( " eblb %0, %1, %2, %3 \n\t " : : "r"( dest ), "r"( src2 ), "r"( nelem ), "r"( sizeof( uint8_t ) ) );
      __xbrtime_wait_bulk_comp();

      ret = rev_clock_gettime( 0, &e );
      assert( ret == 0 );
      printf( "Took %ld nanoseconds", e.tv_nsec - s.tv_nsec );
    }
    //free( dest );
    //free( src2 );
  } else if( strcmp( instruction, "eblh" ) == 0 ) {
    // For int16_t
    int16_t* dest = malloc( sizeof( int16_t ) * nelem );
    int16_t* src2 = malloc( sizeof( int16_t ) * nelem );
    for( int i = 0; i < nelem; i++ ) {
      src2[i] = 0x01ff;  // Fill with 0x01ff as per the example
    }
    if( id == 0 ) {
      int ret = rev_clock_gettime( 0, &s );
      assert( ret == 0 );

      asm volatile( " eblh %0, %1, %2, %3 \n\t " : : "r"( dest ), "r"( src2 ), "r"( nelem ), "r"( sizeof( int16_t ) ) );
      __xbrtime_wait_bulk_comp();

      ret = rev_clock_gettime( 0, &e );
      assert( ret == 0 );
      printf( "Took %ld nanoseconds", e.tv_nsec - s.tv_nsec );
    }
    //free( dest );
    //free( src2 );
  } else if( strcmp( instruction, "eblhu" ) == 0 ) {
    // For uint16_t
    uint16_t* dest = malloc( sizeof( uint16_t ) * nelem );
    uint16_t* src2 = malloc( sizeof( uint16_t ) * nelem );
    for( int i = 0; i < nelem; i++ ) {
      src2[i] = 0x01ff;  // Fill with 0x01ff as per the example
    }
    if( id == 0 ) {
      int ret = rev_clock_gettime( 0, &s );
      assert( ret == 0 );

      asm volatile( " eblhu %0, %1, %2, %3 \n\t " : : "r"( dest ), "r"( src2 ), "r"( nelem ), "r"( sizeof( uint16_t ) ) );
      __xbrtime_wait_bulk_comp();

      ret = rev_clock_gettime( 0, &e );
      assert( ret == 0 );
      printf( "Took %ld nanoseconds", e.tv_nsec - s.tv_nsec );
    }
  } else if( strcmp( instruction, "eblw" ) == 0 ) {
    rev_clock_gettime( 0, &e1 );
    // For uint32_t
    uint32_t* dest = malloc( sizeof( uint32_t ) * nelem );
    uint32_t* src2 = malloc( sizeof( uint32_t ) * nelem );
    for( int i = 0; i < nelem; i++ ) {
      src2[i] = 0x00ff01ff;  // Fill with 0x00ff01ff as per the example
    }

    rev_clock_gettime( 0, &e2 );
    printf( "PE %d src/dest allocation Took %ld nanoseconds", id, e2.tv_nsec - e1.tv_nsec );
    if( id == 0 ) {
      int ret = rev_clock_gettime( 0, &s );
      assert( ret == 0 );

      asm volatile( " eblw %0, %1, %2, %3 \n\t " : : "r"( dest ), "r"( src2 ), "r"( nelem ), "r"( sizeof( uint32_t ) ) );

      ret = rev_clock_gettime( 0, &e3 );
      printf( "PE %d eblw Took %ld nanoseconds", id, e3.tv_nsec - e2.tv_nsec );
      __xbrtime_wait_bulk_comp();
      ret = rev_clock_gettime( 0, &e4 );
      printf( "PE %d wait_bulk_comp Took %ld nanoseconds", id, e4.tv_nsec - e3.tv_nsec );
    }
    //free( dest );
    //free( src2 );
  } else if( strcmp( instruction, "ebld" ) == 0 ) {
    // For uint64_t
    uint64_t* dest = malloc( sizeof( uint64_t ) * nelem );
    uint64_t* src2 = malloc( sizeof( uint64_t ) * nelem );
    for( int i = 0; i < nelem; i++ ) {
      src2[i] = 0x10ff00ff00ff00ff;  // Fill with 0x10ff00ff00ff00ff as per the example
    }
    if( id == 0 ) {
      int ret = rev_clock_gettime( 0, &s );
      assert( ret == 0 );

      asm volatile( " ebld %0, %1, %2, %3 \n\t " : : "r"( dest ), "r"( src2 ), "r"( nelem ), "r"( sizeof( uint64_t ) ) );
      __xbrtime_wait_bulk_comp();

      ret = rev_clock_gettime( 0, &e );
      assert( ret == 0 );
      printf( "Took %ld nanoseconds", e.tv_nsec - s.tv_nsec );
    }
    //free( dest );
    //free( src2 );
  } else {
    printf( "Unsupported instruction: %s\n", instruction );
    return 1;
  }

  // for( int i = 0; i < nelem; i++ ) {
  //   if( id == 0 ) {
  //     if (DEBUG) {
  //       printf( "PE %d: dest[%d] = 0x%02x\n", id, i, dest[i] );
  //     }
  //   }
  // }

  // // Free the allocated memory
  rev_clock_gettime( 0, &e );
  printf( "PE %d Took %ld nanoseconds in total", id, e.tv_nsec - s.tv_nsec );
  return 0;
}
