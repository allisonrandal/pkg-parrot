# $Id: Makefile 37201 2009-03-08 12:07:48Z fperrad $

# Generate shared libs, which will be used as loadable compilers

all: japhc

japhc: japhc.c
	$(CC) -shared -fpic japhc.c -o ../../runtime/parrot/dynext/japhc.so -g -Wall -I../../include
