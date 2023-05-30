CXX=$(shell sst-config --CXX)
CXXFLAGS=$(shell sst-config --ELEMENT_CXXFLAGS) -fno-stack-protector
LDFLAGS=$(shell sst-config --ELEMENT_LDFLAGS) -fno-stack-protector

PROGS=softfp

all: $(PROGS)

softfp: softfp.o softfloat.o
	$(CXX) $(LDFLAGS) -o $@ $^ -lm

%.o: %.c
	$(CXX) $(CXXFLAGS) -c -o $@ $<

clean:
	rm -f *.o *.d *~ $(PROGS)

# EOF
