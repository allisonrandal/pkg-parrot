# Copyright (C) 2007-2009, Parrot Foundation.
# $Id: 20_string_ops.pir 40124 2009-07-16 21:36:57Z allison $

=head1 String Operations

Some operations are specifically for strings. Concatenation
is an example of this type of operation; it joins two
strings together to form a larger string. Like the other
operations we've seen, concatenation also has one form that
returns the result, and one form that modifies the result in
place.

=cut

.sub main :main

    $S0 = "Hello"
    $S1 = $S0 . ", "

    $S1 .= "Zaphod!"
    say $S1

.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:

