# Copyright (C) 2009, Parrot Foundation.
# $Id: string.pasm 42885 2009-12-03 19:31:31Z mikehh $

    set S1, "abc"
    set S2, "EE"
    bors S0, S1, S2
    print S0
    print "\n"
    print S1
    print "\n"
    print S2
    print "\n"
    end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:
