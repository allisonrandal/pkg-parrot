# Copyright (C) 2007-2009, Parrot Foundation.
# $Id: 11_math_ops_self_mod.pir 38369 2009-04-26 12:57:09Z fperrad $

=head1 Math Operations (continued)

There is a second common form of math operations. This form takes
one argument and performs the operation on the result, modifying it in
place.

=cut

.sub main :main

    $I0 = 3
    $I0 *= 2
    say $I0

    $N0 = 22.44
    $N0 /= 4
    say $N0

.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:

