#define CLASS 'S'
#define NUM_PROCS 64
/*
   This file is generated automatically by the setparams utility.
   It sets the number of processors and the class of the NPB
   in this directory. Do not modify it by hand.   */
   
#define COMPILETIME "27 Jun 2023"
#define NPBVERSION "3.2"
#define SHMEMCC "riscv64-unknown-elf-gcc"
#define CFLAGS "-I$(XBGAS_RUNTIME) -std=c11"
#define CLINK "$(SHMEMCC)"
#define CLINKFLAGS "-lm"
#define CSHMEM_LIB "-L$(XBGAS_RUNTIME)-lxbrtime -lm"
#define CSHMEM_INC "-I$(XBGAS_RUNTIME)/include"
#define CMPI_LIB "-L$(XBGAS_RUNTIME) -lxbrtime -lm"
#define CMPI_INC "-I$(XBGAS_RUNTIME)/include"
#define CRANDFILE "randi8"
