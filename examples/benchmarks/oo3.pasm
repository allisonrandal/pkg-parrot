# $Id: /local/examples/benchmarks/oo3.pasm 12177 2006-04-11T19:56:05.232596Z bernhard  $

    newclass P1, "Foo"
    find_global P2, "init"
    store_global "Foo", "__init", P2
    addattribute P1, ".i"
    addattribute P1, ".j"

    set I10, 0
    set I11, 500000
    find_type I12, "Foo"
    new P3, I12
loop:
    classoffset I0, P3, "Foo"
    getattribute P2, P3, I0
    new P10, .Integer	# x = Foo.i
    assign P10, P2
    inc I0
    getattribute P2, P3, I0
    new P11, .Integer	# y = Foo.j
    assign P11, P2
    inc I10
    lt I10, I11, loop

    classoffset I0, P3, "Foo"
    getattribute P2, P3, I0
    print P2
    print "\n"
    typeof I0, P3
    end

.pcc_sub init:
.include "interpinfo.pasm"
    interpinfo P2, .INTERPINFO_CURRENT_OBJECT
    classoffset I0, P2, "Foo"
    new P10, .Integer
    set P10, 10
    setattribute P2, I0, P10
    inc I0
    new P10, .Integer
    set P10, 20
    setattribute P2, I0, P10
    returncc
