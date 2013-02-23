# $Id: /parrotcode/local/languages/plumhead/lib/Parrot/Test/Plumhead/Phc.pm 1502 2007-01-22T17:06:21.889089Z chromatic  $

package Parrot::Test::Plumhead::Phc;

# pragmata
use strict;
use warnings;

use base 'Parrot::Test::Plumhead';

sub get_out_fn {
    my $self = shift;
    my ( $count, $options ) = @_;

    return Parrot::Test::per_test( '_php.out', $count );
}

# Use PHP on the command line
sub get_test_prog {
    my $self = shift;
    my ( $count, $options ) = @_;

    my $lang_fn = Parrot::Test::per_test( '.php', $count );

    return ("./parrot languages/plumhead/plumhead.pbc --variant=phc languages/${lang_fn}");
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