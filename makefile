CPUS ?= $(shell nproc)
MAKEFLAGS += -j$(CPUS)

OPENSCAD="openscad"

BUILDDIR = build
OUTPUTDIR = dist
SRCDIR = src

_SCAD_FILES = main.scad shower_handle_screw.scad shower_handle_washer.scad shower_handle_nut.scad shower_support.scad
SCAD_FILES = $(addprefix $(SRCDIR)/, $(_SCAD_FILES))
_STL_FILES = $(shell echo "${_SCAD_FILES}" | sed 's/\.scad/.stl/g')
STL_FILES = $(addprefix $(OUTPUTDIR)/, $(_STL_FILES))

# explicit wildcard expansion suppresses errors when no files are found
include $(wildcard *.deps)

.PHONY: directories all clean

all: directories $(STL_FILES)

directories: $(BUILDDIR) $(OUTPUTDIR)

$(BUILDDIR):
	mkdir -p $(BUILDDIR)

$(OUTPUTDIR):
	mkdir -p $(OUTPUTDIR)

$(OUTPUTDIR)/%.stl: $(SRCDIR)/%.scad
	$(OPENSCAD) -m make -o $@ -d $(BUILDDIR)/$(subst $(OUTPUTDIR)/,,$@).deps $<

clean:
	rm -f ${BUILDDIR}/*.deps ${OUTPUTDIR}/*.stl
