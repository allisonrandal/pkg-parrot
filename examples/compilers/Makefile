# $Id: Makefile 11501 2006-02-10 18:27:13Z particle $

# Generate shared libs, which will be used as loadable compilers

all: japhc

japhc: japhc.c
	$(CC) -shared -fpic japhc.c -o ../../runtime/parrot/dynext/japhc.so -g -Wall -I../../include
