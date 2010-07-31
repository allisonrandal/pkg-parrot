#!./parrot
# Copyright (C) 2001-2010, Parrot Foundation.
# $Id: scope.t 46007 2010-04-25 11:44:15Z fperrad $

.sub main :main
    .include 'test_more.pir'
    plan(2)

    test_global_const()
.end

.sub test_global_const
	.globalconst string ok1 = "ok\n"
	ok(1, 'global const')
	_global_const_sub()
.end

.sub _global_const_sub
	ok(1, 'global const')
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:

