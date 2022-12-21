#CPUS ?= $(getconf _NPROCESSORS_ONLN)
CPUS ?= $(shell nproc)
MAKEFLAGS += --jobs=$(CPUS)


UNAME_S := $(shell uname -s)
OPENSCAD="openscad"

OPENSCAD_FLAGS=""
OPENSCADPATH=$(shell pwd)

SCAD_FILES = $(wildcard *.scad)

BUILDDIR = build
OUTPUTDIR = dist
SRCDIR = src

# explicit wildcard expansion suppresses errors when no files are found
include $(wildcard *.deps)

.PHONY: all clean
all: main.stl

$(BUILDDIR):
	mkdir -p $(BUILDDIR)

$(OUTPUTDIR):
	mkdir -p $(OUTPUTDIR)

%.stl: %.scad $(BUILDDIR) $(OUTPUTDIR) $(wildcard $(SRCDIR)/*.scad)
	openscad -m make -o $(OUTPUTDIR)/$@ -d $(BUILDDIR)/$@.deps $<

clean:
	rm -f ${BUILDDIR}/*.deps ${OUTPUTDIR}/*.stl
