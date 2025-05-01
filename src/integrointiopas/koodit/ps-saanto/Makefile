
FC := gfortran
FFLAGS := -Wall -std=f2003 -ffree-form -ffree-line-length-none -fimplicit-none -fbackslash

srcdir := src
objdir := obj

main_file := ps_saanto.f90
main_src = $(patsubst %.f90, $(srcdir)/%.f90, $(main_file))
mod_files := lajimaareet.f90 funktiot.f90
mod_src := $(patsubst %.f90, $(srcdir)/%.f90, $(mod_files))
src_files := $(mod_src) $(main_src) 
obj_files := $(patsubst $(srcdir)/%.f90, $(objdir)/%.o, $(src_files))
mod_files := $(patsubst $(srcdir)/%.f90, $(objdir)/%.mod, $(mod_src))
exe := ps_saanto

$(exe): $(obj_files)
	$(FC) $(FFLAGS) -I$(objdir) -J$(objdir) $^ -o $@

$(objdir)/%.o: $(srcdir)/%.f90
	-mkdir $(objdir)
	$(FC) $(FFLAGS) -I$(objdir) -J$(objdir) -c $^ -o $@

clean:
	@echo $(mod_files)
	rm -f $(obj_files) $(mod_files) $(exe)
