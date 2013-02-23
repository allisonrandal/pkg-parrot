# Copyright (C) 2004-2006, The Perl Foundation.
# $Id: BigNum.pm 16245 2006-12-25 22:15:39Z paultcochrane $

=head1 NAME

Parrot::Docs::Section::BigNum - Big Number documentation section

=head1 SYNOPSIS

        use Parrot::Docs::Section::BigNum;

=head1 DESCRIPTION

A documentation section describing Parrot's big number subsystem.

=head2 Class Methods

=over

=cut

package Parrot::Docs::Section::BigNum;

use strict;
use warnings;

use base qw( Parrot::Docs::Section );

=item C<new()>

Returns a new section.

=cut

sub new {
    my $self = shift;

    return $self->SUPER::new(
        'Big Number Arithmetic',
        'bignum.html',
        '',
        $self->new_group(
            'Decimal Arithmetic',
            '', $self->new_item( '', 'src/bignum.c', 'src/bignum.h' ),
        ),
        $self->new_group( 'Testing', '', $self->new_item( '', 't/pmc/bignum.t' ), ),
    );
}

=back

=cut

1;

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
