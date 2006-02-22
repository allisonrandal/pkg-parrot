# $Id: PIR.pm 11544 2006-02-14 21:00:57Z bernhard $

package Parrot::Test::M4::PIR;

use strict;
use warnings;
use 5.008;

use base 'Parrot::Test::M4';

our $VERSION = 0.01;

sub get_out_fn {
    my $self = shift;
    my ( $count ) = @_;

    return Parrot::Test::per_test( '.pir_out', $count );
}

sub get_test_prog {
    my $self = shift;
    my ( $count ) = @_;

    my $lang_fn        = Parrot::Test::per_test( '.m4', $count );
    my $test_prog_args = $ENV{TEST_PROG_ARGS} || q{};

    return ( "$self->{parrot} languages/m4/m4.pbc $test_prog_args languages/${lang_fn}" );
}
 
1;
