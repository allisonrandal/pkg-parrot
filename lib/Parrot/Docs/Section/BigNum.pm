# Copyright: 2004 The Perl Foundation.  All Rights Reserved.
# $Id: BigNum.pm 10425 2005-12-10 01:51:41Z particle $

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

use Parrot::Docs::Section;
@Parrot::Docs::Section::BigNum::ISA = qw(Parrot::Docs::Section);

=item C<new()>

Returns a new section.

=cut

sub new
{
	my $self = shift;
	
	return $self->SUPER::new(
		'Big Number Arithmetic', 'bignum.html', '',
		$self->new_group('Decimal Arithmetic', '',
			$self->new_item('', 'src/types/bignum.c', 'src/types/bignum.h'),
		),
		$self->new_group('Testing', '',
			$self->new_item('', 'src/types/bignum_atest.pl', 'src/types/bignum_test.pl'),
		),
	);
}

=back

=cut

1;