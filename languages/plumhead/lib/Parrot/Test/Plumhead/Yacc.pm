# $Id: /parrotcode/trunk/languages/plumhead/lib/Parrot/Test/Plumhead/Yacc.pm 3304 2007-04-25T17:50:24.116328Z bernhard  $

package Parrot::Test::Plumhead::Yacc;

# pragmata
use strict;
use warnings;

use base 'Parrot::Test::Plumhead';

sub get_out_fn {
    my $self = shift;
    my ( $count, $options ) = @_;

    return Parrot::Test::per_test( '_yacc.out', $count );
}

# Use PHP on the command line
sub get_test_prog {
    my $self = shift;
    my ( $count, $options ) = @_;

    my $lang_fn = Parrot::Test::per_test( '.php', $count );

    return "./parrot languages/plumhead/plumhead.pbc --variant=yacc languages/${lang_fn}";
}

# never skip the reference implementation
sub skip_why {
    my $self = shift;
    my ($options) = @_;

    return;
}

1;

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
