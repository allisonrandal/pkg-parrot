# Copyright (C) 2003-2009, Parrot Foundation.
# $Id: ext.pir 38369 2009-04-26 12:57:09Z fperrad $

.sub _ext_main
    print "in ext.pir\n"
    new P2, 'Undef'
    print P2
    .begin_return
    .end_return
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:
