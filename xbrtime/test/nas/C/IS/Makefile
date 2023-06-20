SHELL=/bin/sh
BENCHMARK=is
BENCHMARKU=IS

include ../config/make.def

include ../sys/make.common

OBJS = is.o ${COMMON}/c_print_results.o ${COMMON}/c_timers.o
ARCH=rv64imafdc

${PROGRAM}: config ${OBJS}
	${CLINK} -march=$(ARCH) -mabi=lp64d $(XBRTIME_INCLUDE) -o ${PROGRAM} ${OBJS} ${CMPI_LIB} ${C_LINK_FLAGS} $(XBRTIME_LIB)

.c.o:
	${CCOMPILE} $<

is.o:             is.c  npbparams.h


clean:
	- rm -f *.o *~ mputil*
	- rm -f is npbparams.h core
