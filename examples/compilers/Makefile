# $Id: /parrotcode/trunk/examples/compilers/Makefile 470 2006-12-05T03:30:45.414067Z svm  $

# Generate shared libs, which will be used as loadable compilers

all: japhc

japhc: japhc.c
	$(CC) -shared -fpic japhc.c -o ../../runtime/parrot/dynext/japhc.so -g -Wall -I../../include
