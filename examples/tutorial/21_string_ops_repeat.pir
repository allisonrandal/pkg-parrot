# Copyright (C) 2007-2009, Parrot Foundation.
# $Id: 21_string_ops_repeat.pir 38369 2009-04-26 12:57:09Z fperrad $

=head1 String Operations (continued)

PIR has a string repeat opcode, that concatenates a string with
itself N times.

=cut

.sub main :main

    $S0 = "Hello "
    $S1 = repeat $S0, 3

    say $S1 # prints "Hello Hello Hello \n"

.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:

