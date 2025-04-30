
FC := gfortran
FFLAGS := -Wall -std=f2003 -ffree-form -ffree-line-length-none -fimplicit-none -fbackslash

src := ps_saanto.f90
obj := $(patsubst %.f90, %.o, $(src))
exe := ps_saanto

$(exe): $(obj)
	$(FC) $(FFLAGS) $^ -o $@

$(obj): $(src)
	$(FC) $(FFLAGS) -c $^

clean:
	rm -f $(obj) $(wildcard *.mod) $(exe)
