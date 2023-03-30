/*****************************************************************/
/******     C  _  P  R  I  N  T  _  R  E  S  U  L  T  S     ******/
/*****************************************************************/
#include <stdlib.h>
#include <stdio.h>
#include "xbrtime.h"

void c_print_results( char   *name,
                      char   class,
                      int    n1, 
                      int    n2,
                      int    n3,
                      int    niter,
                      int    nprocs_compiled,
                      int    nprocs_total,
                      double t,
                      double mops,
		      char   *optype,
                      int    passed_verification,
                      char   *npbversion,
                      char   *compiletime,
                      char   *shmemcc,
                      char   *clink,
                      char   *cshmem_lib,
                      char   *cshmem_inc,
                      char   *cmpi_lib,
                      char   *cmpi_inc,
                      char   *cflags,
                      char   *clinkflags )
{
    char *evalue="1000";

    revprintf( "\n\n %s Benchmark Completed\n", name ); 

    revprintf( " Class           =                        %c\n", class );

    if( n2 == 0 && n3 == 0 )
        revprintf( " Size            =             %d\n", n1 );   /* as in IS */
    else
        revprintf( " Size            =              %dx %dx %d\n", n1,n2,n3 );

    revprintf( " Iterations      =             %d\n", niter );
 
    revprintf( " Time in seconds =             %f\n", t );

    revprintf( " Total processes =             %d\n", nprocs_total );

    if ( nprocs_compiled != 0 )
        revprintf( " Compiled procs  =             %d\n", nprocs_compiled );

    revprintf( " Mop/s total     =             %f\n", mops );

    revprintf( " Mop/s/process   =             %f\n", mops/((float) nprocs_total) );

    revprintf( " Operation type  = %s\n", optype);

    if( passed_verification )
        revprintf( " Verification    =               SUCCESSFUL\n" );
    else
        revprintf( " Verification    =             UNSUCCESSFUL\n" );

    revprintf( " Version         =             %s\n", npbversion );

    revprintf( " Compile date    =             %s\n", compiletime );

    revprintf( "\n Compile options:\n" );

    revprintf( "    SHMEMCC      = %s\n", shmemcc );

    revprintf( "    CLINK        = %s\n", clink );

    revprintf( "    CSHMEM_LIB   = %s\n", cshmem_lib );

    revprintf( "    CSHMEM_INC   = %s\n", cshmem_inc );

    revprintf( "    CMPI_LIB     = %s\n", cmpi_lib );

    revprintf( "    CMPI_INC     = %s\n", cmpi_inc );

    revprintf( "    CFLAGS       = %s\n", cflags );

    revprintf( "    CLINKFLAGS   = %s\n", clinkflags );
#ifdef SMP
    evalue = getenv("MP_SET_NUMTHREADS");
    revprintf( "   MULTICPUS = %s\n", evalue );
#endif

    revprintf( "\n\n" );
    revprintf( " Please send the results of this run to:\n\n" );
    revprintf( " NPB Development Team\n" );
    revprintf( " Internet: npb@nas.nasa.gov\n \n" );
    revprintf( " If email is not available, send this to:\n\n" );
    revprintf( " MS T27A-1\n" );
    revprintf( " NASA Ames Research Center\n" );
    revprintf( " Moffett Field, CA  94035-1000\n\n" );
    revprintf( " Fax: 650-604-3957\n\n" );
}
 
