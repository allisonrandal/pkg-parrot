# $Id: /parrotcode/trunk/examples/japh/japh16.pasm 470 2006-12-05T03:30:45.414067Z svm  $

# see 'examples/compilers/Makefile' for instructions to generate japhc.$(SO)

# a JapH compiler japhc.so compiles this program:
    set S6, "pJ pa pP pH pn e "
# into executable bytecode and runs it
    # load compiler
    loadlib P0, "japhc"
    # get compiler
    compreg P1, "JaPH_Compiler"
    # compile program
    compile P0, P1, S6
    # run program
    tailcall P0
