/*
 * _XBRTIME_COLLECTIVES_C_
 *
 * Copyright (C) 2017-2018 Tactical Computing Laboratories, LLC
 * All Rights Reserved
 * contact@tactcomplabs.com
 *
 * This file is a part of the XBGAS-RUNTIME package.  For license
 * information, see the LICENSE file in the top level directory
 * of the distribution.
 *
 */

#include "xbrtime.h"

void test_broadcast1();
void test_broadcast2();
void test_broadcast3();
void test_reduce1();
void test_reduce2();
void test_reduce3();
void test_reduce4();
void test_reduce5();
void test_reduce6();
void test_reduce7();
void test_reduce8();
void test_reduce9();
void test_scatter1();
void test_scatter2();
void test_gather1();
void test_gather2();
void test_alltoall1();
void test_alltoall2();
void test_alltoall3();
void barrier_test();
void ld_get_test();

int main()
{
	barrier_test();

  // ld_get_test();
  // test_broadcast1();
  // test_broadcast3();

	// test_reduce1();

  // test_scatter1();

  // test_gather2();

	// test_alltoall3();
}

void barrier_test()
{
	xbrtime_init();
	int my_pe = xbrtime_mype();
	int b = 1;

	// printf("PE %d arriving at barrier %d!\n", my_pe, b);
	// xbrtime_barrier();
	// printf("PE %d leaving barrier %d!\n", my_pe, b);

	// b++;

	// // printf("PE %d arriving at barrier %d!\n", my_pe, b);
	// xbrtime_barrier();
	// // printf("PE %d leaving barrier %d!\n", my_pe, b);

	// b++;

	// // printf("PE %d arriving at barrier %d!\n", my_pe, b);
	// xbrtime_barrier();
	// // printf("PE %d leaving barrier %d!\n", my_pe, b);

	xbrtime_close();
}

void ld_get_test()
{
	xbrtime_init();
	int my_pe = xbrtime_mype();
	int numpes = xbrtime_num_pes();
	long double *x = (long double *) xbrtime_malloc(sizeof(long double));
	*x = (long double) my_pe;
	long double *y = (long double *) xbrtime_malloc(sizeof(long double));
	*y = (long double) 99;

	// printf("Size of long double %d\n", sizeof(long double));

	// printf("PE %d intial value %Lf\n", my_pe, *x);

	xbrtime_barrier();

	xbrtime_longdouble_put_nb(y,x,1,1,((my_pe+1)%numpes));

	xbrtime_barrier();

	// printf("PE %d final value %Lf\n", my_pe, *y);

	xbrtime_close();
}

// Single value, non-zero root
void test_broadcast1()
{
	xbrtime_init();
	int numpes, my_pe, *b_val;
	numpes = xbrtime_num_pes();
	my_pe = xbrtime_mype();
	b_val = (int*) xbrtime_malloc(sizeof(int));
	*b_val = my_pe;

	// printf("Pre-Broadcast - PE:%d B_Val: %d\n", my_pe, *b_val);

	xbrtime_barrier();

	xbrtime_int_broadcast(b_val, b_val, 1, 0, 3);

	xbrtime_barrier();

	// printf("Post-Broadcast - PE:%d B_Val: %d\n", my_pe, *b_val);

	xbrtime_barrier();

	xbrtime_close();
}

// Multiple values, stride = 1, non-zero root, double type
void test_broadcast2()
{
	xbrtime_init();
	int i, numpes, stride, my_pe, nelems;
        double *b_val;
	numpes = xbrtime_num_pes();
	my_pe = xbrtime_mype();
        nelems = 5;
        stride = 1;
	b_val = (double*) xbrtime_malloc(nelems * sizeof(double));

        for(i = 0; i < nelems; i++)
        {
            b_val[i] = ((double) my_pe * .25);
        }

	// printf("Pre-Broadcast - PE:%d B_Val: %f %f %f %f %f\n", my_pe, b_val[0], b_val[1], b_val[2], b_val[3], b_val[4]);

	xbrtime_barrier();

	xbrtime_double_broadcast(b_val, b_val, 5, stride, 2);

	xbrtime_barrier();

        // printf("Post-Broadcast - PE:%d B_Val: %f %f %f %f %f\n", my_pe, b_val[0], b_val[1], b_val[2], b_val[3], b_val[4]);

	xbrtime_close();
}

// Multiple values, stride = 2, non-zero root, long long type
void test_broadcast3()
{
	xbrtime_init();
	int i, numpes, stride, my_pe, nelems;
    long long *b_val;
	numpes = xbrtime_num_pes();
	my_pe = xbrtime_mype();
    nelems = 10;
    stride = 2;
	b_val = (long long*) xbrtime_malloc(nelems * sizeof(long long));

    for(i = 0; i < nelems; i++)
    {
        b_val[i] = (long long) my_pe;
    }

	// printf("Pre-Broadcast - PE:%d B_Val: %d %d %d %d %d %d %d %d %d %d\n", my_pe, b_val[0], b_val[1], b_val[2], b_val[3], b_val[4], b_val[5], b_val[6], b_val[7], b_val[8], b_val[9]);

	xbrtime_barrier();

	xbrtime_longlong_broadcast(b_val, b_val, 5, stride, 7);

	xbrtime_barrier();

    // printf("Post-Broadcast - PE:%d B_Val: %d %d %d %d %d %d %d %d %d %d\n", my_pe, b_val[0], b_val[1], b_val[2], b_val[3], b_val[4], b_val[5], b_val[6], b_val[7], b_val[8], b_val[9]);

	xbrtime_close();
}

// Sum with single int value, zero root
void test_reduce1()
{
	xbrtime_init();
	int numpes, my_pe, stride, nelems;
	int *r_val;
	numpes = xbrtime_num_pes();
	my_pe = xbrtime_mype();
    nelems = 1;
    stride = 1;
	r_val = (int*) xbrtime_malloc(sizeof(int));
	*r_val = my_pe;

	// printf("Pre-Reduce - PE:%d R_Val: %d\n", my_pe, *r_val);

	xbrtime_barrier();

	xbrtime_int_reduce_sum(r_val, r_val, 1, stride, 3);

	xbrtime_barrier();

	// printf("Post-Reduce - PE:%d R_Val: %d\n", my_pe, *r_val);

	xbrtime_close();
}

// Product with multiple int values, strided, zero root
void test_reduce2()
{
	xbrtime_init();
	int i, numpes, my_pe, nelems, stride;
	int *r_val;
	numpes = xbrtime_num_pes();
	my_pe = xbrtime_mype();
    nelems = 10;
    stride = 2;
	r_val = (int*) xbrtime_malloc(nelems * sizeof(int));

    for(i = 0; i < nelems; i++)
    {
        r_val[i] = my_pe+1;
    }

	// printf("Pre-Reduce - PE:%d R_Val: %d %d %d %d %d %d %d %d %d %d\n", my_pe, r_val[0], r_val[1], r_val[2], r_val[3], r_val[4], r_val[5], r_val[6], r_val[7], r_val[8], r_val[9]);

	xbrtime_barrier();

	xbrtime_int_reduce_product(r_val, r_val, 5, stride, 0);

	xbrtime_barrier();

	// printf("Post-Reduce - PE:%d R_Val: %d %d %d %d %d %d %d %d %d %d\n", my_pe, r_val[0], r_val[1], r_val[2], r_val[3], r_val[4], r_val[5], r_val[6], r_val[7], r_val[8], r_val[9]);

	xbrtime_close();
}

// Sum with single double value, non-zero root
void test_reduce3()
{
	xbrtime_init();
	int i, numpes, my_pe, nelems, stride;
	double *r_val;
	numpes = xbrtime_num_pes();
	my_pe = xbrtime_mype();
    nelems = 1;
    stride = 1;
	r_val = (double*) xbrtime_malloc(nelems * sizeof(double));

    for(i = 0; i < nelems; i++)
    {
        r_val[i] = (double)(my_pe) * .25;
    }

	// printf("Pre-Reduce - PE:%d R_Val: %f\n", my_pe, r_val[0]);

	xbrtime_barrier();

	xbrtime_double_reduce_sum(r_val, r_val, nelems, stride, 4);

	xbrtime_barrier();

	// printf("Post-Reduce - PE:%d R_Val: %f\n", my_pe, r_val[0]);

	xbrtime_close();
}

// Product with double values, strided, non-zero root
void test_reduce4()
{
	xbrtime_init();
	int i, numpes, my_pe, nelems, stride;
	double *r_val;
	numpes = xbrtime_num_pes();
	my_pe = xbrtime_mype();
    nelems = 10;
    stride = 2;
	r_val = (double*) xbrtime_malloc(nelems * sizeof(double));

    for(i = 0; i < nelems; i++)
    {
        r_val[i] = (double)(my_pe+1) * .25;
    }

	// printf("Pre-Reduce - PE:%d R_Val: %f %f %f %f %f %f %f %f %f %f\n", my_pe, r_val[0], r_val[1], r_val[2], r_val[3], r_val[4], r_val[5], r_val[6], r_val[7], r_val[8], r_val[9]);

	xbrtime_barrier();

	xbrtime_double_reduce_product(r_val, r_val, 5, stride, 2);

	xbrtime_barrier();

	// printf("Post-Reduce - PE:%d R_Val: %f %f %f %f %f %f %f %f %f %f\n", my_pe, r_val[0], r_val[1], r_val[2], r_val[3], r_val[4], r_val[5], r_val[6], r_val[7], r_val[8], r_val[9]);

	xbrtime_close();
}

// Xor with single short value, non-zero root
void test_reduce5()
{
	xbrtime_init();
	int i, numpes, my_pe, nelems, stride;
	short *r_val;
	numpes = xbrtime_num_pes();
	my_pe = xbrtime_mype();
    nelems = 1;
    stride = 1;
	r_val = (short*) xbrtime_malloc(nelems * sizeof(long double));

    for(i = 0; i < nelems; i++)
    {
        r_val[i] = (short)my_pe;
    }

	// printf("Pre-Reduce - PE:%d R_Val: %d\n", my_pe, r_val[0]);

	xbrtime_barrier();

	xbrtime_short_reduce_xor(r_val, r_val, 1, stride, 5);

	xbrtime_barrier();

	// printf("Post-Reduce - PE:%d R_Val: %d\n", my_pe, r_val[0]);

	xbrtime_close();
}

// And with multiple int values, strided, non-zero root
void test_reduce6()
{
	xbrtime_init();
	int i, numpes, my_pe, nelems, stride;
	int *r_val;
	numpes = xbrtime_num_pes();
	my_pe = xbrtime_mype();
    nelems = 10;
    stride = 2;
	r_val = (int*) xbrtime_malloc(nelems * sizeof(int));

    for(i = 0; i < nelems; i++)
    {
        r_val[i] = (int)my_pe * i;
    }

	// printf("Pre-Reduce - PE:%d R_Val: %d %d %d %d %d %d %d %d %d %d\n", my_pe, r_val[0], r_val[1], r_val[2], r_val[3], r_val[4], r_val[5], r_val[6], r_val[7], r_val[8], r_val[9]);

	xbrtime_barrier();

	xbrtime_int_reduce_and(r_val, r_val, 5, stride, 5);

	xbrtime_barrier();

	// printf("Post-Reduce - PE:%d R_Val: %d %d %d %d %d %d %d %d %d %d\n", my_pe, r_val[0], r_val[1], r_val[2], r_val[3], r_val[4], r_val[5], r_val[6], r_val[7], r_val[8], r_val[9]);

	xbrtime_close();
}

// Or with single long value, zero root
void test_reduce7()
{
	xbrtime_init();
	int i, numpes, my_pe, nelems, stride;
	long *r_val;
	numpes = xbrtime_num_pes();
	my_pe = xbrtime_mype();
    nelems = 1;
    stride = 1;
	r_val = (long*) xbrtime_malloc(nelems * sizeof(long));

    for(i = 0; i < nelems; i++)
    {
        r_val[i] = (long)my_pe;
    }

	// printf("Pre-Reduce - PE:%d R_Val: %d\n", my_pe, r_val[0]);

	xbrtime_barrier();

	xbrtime_long_reduce_or(r_val, r_val, 1, stride, 0);

	xbrtime_barrier();

	// printf("Post-Reduce - PE:%d R_Val: %d\n", my_pe, r_val[0]);

	xbrtime_close();
}

// Min with double values, non-strided, non-zero root
void test_reduce8()
{
	xbrtime_init();
	int i, numpes, my_pe, nelems, stride;
	double *r_val;
	numpes = xbrtime_num_pes();
	my_pe = xbrtime_mype();
    nelems = 3;
    stride = 1;
	r_val = (double*) xbrtime_malloc(nelems * sizeof(double));

    for(i = 0; i < nelems; i++)
    {
        r_val[i] = (double)my_pe/10;
    }

	// printf("Pre-Reduce - PE:%d R_Val: %f %f %f\n", my_pe, r_val[0], r_val[1], r_val[2]);

	xbrtime_barrier();

	xbrtime_double_reduce_min(r_val, r_val, 3, stride, 5);

	xbrtime_barrier();

	// printf("Post-Reduce - PE:%d R_Val: %f %f %f\n", my_pe, r_val[0], r_val[1], r_val[2]);

	xbrtime_close();
}

// Max with long long values, strided, zero root
void test_reduce9()
{
	xbrtime_init();
	int i, numpes, my_pe, nelems, stride;
	long long *r_val;
	numpes = xbrtime_num_pes();
	my_pe = xbrtime_mype();
    nelems = 6;
    stride = 2;
	r_val = (long long*) xbrtime_malloc(nelems * sizeof(long long));

    for(i = 0; i < nelems; i++)
    {
        r_val[i] = (long long) pow(my_pe, my_pe);
    }

	// printf("Pre-Reduce - PE:%d R_Val: %d %d %d %d %d %d\n", my_pe, r_val[0], r_val[1], r_val[2], r_val[3], r_val[4], r_val[5]);

	xbrtime_barrier();

	xbrtime_longlong_reduce_max(r_val, r_val, 3, stride, 0);

	xbrtime_barrier();

	// printf("Post-Reduce - PE:%d R_Val: %d %d %d %d %d %d\n", my_pe, r_val[0], r_val[1], r_val[2], r_val[3], r_val[4], r_val[5]);

	xbrtime_close();
}

// Scatter two short values to each PE, zero root
void test_scatter1()
{
	xbrtime_init();
	int i, numpes, my_pe, nelems;
	short *src_array;
	numpes = xbrtime_num_pes();
	my_pe = xbrtime_mype();
    nelems = 8;
    src_array = (short*) xbrtime_malloc(nelems * sizeof(short));

    if(my_pe == 0)
    {
        for(i = 0; i < nelems; i++)
        {
            src_array[i] = i;
        }
    }
    else
    {
        for(i = 0; i < nelems; i++)
        {
            src_array[i] = 0;
        }
    }

	int pe_msg_sz[4] = {2, 2, 2, 2};
	int pe_disp[4] = {0, 2, 4, 6};
	short dest_array[2] = {99};


	// printf("PE %d src_array = %d %d %d %d %d %d %d %d\n", my_pe, src_array[0], src_array[1], src_array[2], src_array[3],
								// src_array[4], src_array[5], src_array[6], src_array[7]);

	xbrtime_barrier();

	xbrtime_short_scatter(dest_array, src_array, pe_msg_sz, pe_disp, 8, 0);

	xbrtime_barrier();

	// printf("PE %d dest_array = %d %d\n", my_pe, dest_array[0], dest_array[1]);

	xbrtime_close();
}

// Scatter distinct number of double values to each PE, non-zero root
void test_scatter2()
{
	xbrtime_init();
	int i, numpes, my_pe, nelems;
    int *src_array;
	numpes = xbrtime_num_pes();
	my_pe = xbrtime_mype();
    nelems = 15;
    src_array = (int*) xbrtime_malloc(nelems * sizeof(int));

    if(my_pe == 4)
    {
        for(i = 0; i <= nelems; i++)
        {
            src_array[i] = i+1;
        }
    }
    else
    {
        for(i = 0; i < nelems; i++)
        {
            src_array[i] = 0;
        }
    }

	int pe_msg_sz[5] = {3, 2, 1, 5, 4};
	int pe_disp[5] = {0, 3, 5, 6, 11};
	int dest_array[5] = {99};

	// printf("PE %d src_array = %d %d %d %d %d %d %d %d %d %d %d %d %d %d %\n", my_pe, src_array[0], src_array[1], src_array[2], src_array[3],
                                            					// 	src_array[4], src_array[5], src_array[6], src_array[7],
                                            					// 	src_array[8], src_array[9], src_array[10], src_array[11],
                                           	 					// src_array[12], src_array[13], src_array[14], src_array[15]);

	xbrtime_barrier();

	xbrtime_int_scatter(dest_array, src_array, pe_msg_sz, pe_disp, nelems, 4);

	xbrtime_barrier();

	// printf("PE %d dest_array = %d %d %d %d %d\n", my_pe, dest_array[0], dest_array[1], dest_array[2], dest_array[3], dest_array[4]);

	xbrtime_close();
}

// Gather one double value from each PE, zero root
void test_gather1()
{
	xbrtime_init();
	int i, numpes, my_pe, nelems;
    double *dest_array;
	numpes = xbrtime_num_pes();
	my_pe = xbrtime_mype();
    nelems = 8;
    dest_array = (double*) xbrtime_malloc(nelems*sizeof(double));
	double src_array[1] = {my_pe};

	for(i = 0; i < nelems; i++)
	{
	       dest_array[i] = 99;
	}

	int pe_msg_sz[8] = {1, 1, 1, 1, 1, 1, 1, 1};
	int pe_disp[8] = {0, 1, 2, 3, 4, 5, 6, 7};

	// printf("PE %d src_array = %f\n", my_pe, src_array[0]);

	xbrtime_barrier();

	xbrtime_double_gather(dest_array, src_array, pe_msg_sz, pe_disp, 8, 0);

	xbrtime_barrier();

	// printf("PE %d dest_array = %f %f %f %f %f %f %f %f\n", my_pe, dest_array[0], dest_array[1], dest_array[2], dest_array[3],
                                                                    // dest_array[4], dest_array[5], dest_array[6], dest_array[7]);

	xbrtime_close();
}

// Gather distinct number of int values from each PE, non-zero root
void test_gather2()
{
	xbrtime_init();
	int i, numpes, my_pe, nelems;
    	int *dest_array;
	numpes = xbrtime_num_pes();
	my_pe = xbrtime_mype();
    nelems = 15;
    dest_array = (int*) xbrtime_malloc(nelems*sizeof(int));
	int src_array[5] = {my_pe, my_pe, my_pe, my_pe, my_pe};

	for(i = 0; i < nelems; i++)
	{
	       dest_array[i] = 99;
	}

    int pe_msg_sz[6] = {3, 2, 4, 1, 2, 3};
    int pe_disp[6] = {0, 3, 5, 9, 10, 12};

    // printf("PE %d src_array = %d %d %d %d %d\n", my_pe, src_array[0], src_array[1], src_array[2], src_array[3], src_array[4]);

	xbrtime_barrier();

	xbrtime_int_gather(dest_array, src_array, pe_msg_sz, pe_disp, 15, 3);

	xbrtime_barrier();

    // printf("PE %d dest_array = %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d\n", my_pe, dest_array[0], dest_array[1], dest_array[2], dest_array[3],
                                                // dest_array[4], dest_array[5], dest_array[6], dest_array[7],
                                                // dest_array[8], dest_array[9], dest_array[10], dest_array[11],
                                                // dest_array[12], dest_array[13], dest_array[14]);

	xbrtime_close();

}

// Single int all to all with PE ID
void test_alltoall1()
{
	xbrtime_init();
	int i, numpes, my_pe, nelems, src_stride, dest_stride;
    int *src_array, *dest_array;
	numpes = xbrtime_num_pes();
	my_pe = xbrtime_mype();
    nelems = 1;
    src_stride = 1;
    dest_stride = 1;
    src_array = (int*) xbrtime_malloc(numpes * nelems * sizeof(int));
    dest_array = (int*) xbrtime_malloc(numpes * nelems * sizeof(int));

    for(i = 0; i < (numpes*nelems); i++)
    {
        src_array[i] = (int) my_pe;
        dest_array[i] = 99;
    }

    // printf("Pre-AlltoAll\nPE:%d src_array: %d %d %d %d %d %d %d %d\nPE: %d dest_array: %d %d %d %d %d %d %d %d\n",
                            // my_pe, src_array[0], src_array[1], src_array[2], src_array[3], src_array[4], src_array[5], src_array[6], src_array[7],
                            // my_pe, dest_array[0], dest_array[1], dest_array[2], dest_array[3], dest_array[4], dest_array[5], dest_array[6], dest_array[7]);

    xbrtime_barrier();

	  xbrtime_int_alltoall(dest_array, src_array, src_stride, dest_stride, nelems);

	  xbrtime_barrier();

    // printf("Post-AlltoAll\nPE:%d src_array: %d %d %d %d %d %d %d %d\nPE %d dest_array: %d %d %d %d %d %d %d %d\n",
                            // my_pe, src_array[0], src_array[1], src_array[2], src_array[3], src_array[4], src_array[5], src_array[6], src_array[7],
                            // my_pe, dest_array[0], dest_array[1], dest_array[2], dest_array[3], dest_array[4], dest_array[5], dest_array[6], dest_array[7]);

    xbrtime_close();
}

// Multiple double values to each PE, dest = src
void test_alltoall2()
{
	xbrtime_init();
	int i, numpes, my_pe, nelems, src_stride, dest_stride;
    double *src_array, *dest_array;
	numpes = xbrtime_num_pes();
	my_pe = xbrtime_mype();
    nelems = 2;
    src_stride = 1;
    dest_stride = 1;
    src_array = (double *) xbrtime_malloc(numpes * nelems * sizeof(double));
    dest_array = src_array;

    for(i = 0; i < (numpes*nelems); i++)
    {
        src_array[i] = (double) my_pe;
    }

    // printf("Pre-AlltoAll\nPE:%d src_array: %f %f %f %f %f %f %f %f %f %f %f %f\n\
                           PE: %d dest_array: %f %f %f %f %f %f %f %f %f %f %f %f\n",
                            // my_pe, src_array[0], src_array[1], src_array[2], src_array[3], src_array[4], src_array[5], src_array[6], src_array[7],
                            // src_array[8], src_array[9], src_array[10], src_array[11],
                            // my_pe,dest_array[0], dest_array[1], dest_array[2], dest_array[3], dest_array[4], dest_array[5], dest_array[6], dest_array[7],
                            // dest_array[8], dest_array[9], dest_array[10], dest_array[11]);

    xbrtime_barrier();

	xbrtime_double_alltoall(dest_array, src_array, src_stride, dest_stride, nelems);

	xbrtime_barrier();

	// printf("Post-AlltoAll\nPE:%d src_array: %f %f %f %f %f %f %f %f %f %f %f %f\n\
                           PE: %d dest_array: %f %f %f %f %f %f %f %f %f %f %f %f\n",
                            // my_pe, src_array[0], src_array[1], src_array[2], src_array[3], src_array[4], src_array[5], src_array[6], src_array[7],
                            // src_array[8], src_array[9], src_array[10], src_array[11],
                            // my_pe,dest_array[0], dest_array[1], dest_array[2], dest_array[3], dest_array[4], dest_array[5], dest_array[6], dest_array[7],
                            // dest_array[8], dest_array[9], dest_array[10], dest_array[11]);

    xbrtime_close();
}

// Multiple shorts to each PE with different source and dest strides
void test_alltoall3()
{
	xbrtime_init();
	int i, j, numpes, my_pe, nelems, src_stride, dest_stride;
    short *src_array, *dest_array;
	numpes = xbrtime_num_pes();
	my_pe = xbrtime_mype();
    nelems = 3;
    src_stride = 2;
    dest_stride = 3;
    src_array = (short*) xbrtime_malloc(numpes  * src_stride * nelems * sizeof(short));
    dest_array = (short*) xbrtime_malloc(numpes * nelems * dest_stride * sizeof(short));

    int k = 0;
    for(i = 0; i < numpes; i++)
    {
	for(j = 0; j < nelems; j++)
	{
            src_array[k] = (short) (i+1);
	    k += src_stride;
	}
    }

    for(i = 0; i < (numpes * dest_stride * nelems); i++)
    {
	dest_array[i] = 99;
    }

	// printf("Pre-AlltoAll\nPE:%d src_array: %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d\n\
                PE: %d dest_array: %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d\n",
          //                   my_pe, src_array[0], src_array[1], src_array[2], src_array[3], src_array[4], src_array[5], src_array[6], src_array[7],
          //                   src_array[8], src_array[9], src_array[10], src_array[11], src_array[12], src_array[13],src_array[14],src_array[15],src_array[16],src_array[17],
          //                   my_pe,dest_array[0], dest_array[1], dest_array[2], dest_array[3], dest_array[4], dest_array[5], dest_array[6], dest_array[7],
          //                   dest_array[8], dest_array[9], dest_array[10], dest_array[11], dest_array[12], dest_array[13], dest_array[14], dest_array[15], dest_array[16],
			    // dest_array[17], dest_array[18], dest_array[19], dest_array[20], dest_array[21], dest_array[22],dest_array[23], dest_array[24], dest_array[25],
			    // dest_array[26]);

    xbrtime_barrier();

	xbrtime_short_alltoall(dest_array, src_array, src_stride, dest_stride, nelems);

	xbrtime_barrier();

	// printf("Post-AlltoAll\nPE:%d src_array: %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d\n\
                PE: %d dest_array: %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d\n",
          //                   my_pe, src_array[0], src_array[1], src_array[2], src_array[3], src_array[4], src_array[5], src_array[6], src_array[7],
          //                   src_array[8], src_array[9], src_array[10], src_array[11], src_array[12], src_array[13],src_array[14],src_array[15],src_array[16],src_array[17],
          //                   my_pe,dest_array[0], dest_array[1], dest_array[2], dest_array[3], dest_array[4], dest_array[5], dest_array[6], dest_array[7],
          //                   dest_array[8], dest_array[9], dest_array[10], dest_array[11], dest_array[12], dest_array[13], dest_array[14], dest_array[15], dest_array[16],
			    // dest_array[17], dest_array[18], dest_array[19], dest_array[20], dest_array[21], dest_array[22],dest_array[23], dest_array[24], dest_array[25],
			    // dest_array[26]);

    xbrtime_close();
}
