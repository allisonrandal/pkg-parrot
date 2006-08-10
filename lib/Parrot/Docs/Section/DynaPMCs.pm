# Copyright (C) 2004, The Perl Foundation.
# $Id: /local/lib/Parrot/Docs/Section/DynaPMCs.pm 12996 2006-06-21T18:44:31.111564Z bernhard  $

=head1 NAME

Parrot::Docs::Section::DynaPMCs - Dynamic PMCs documentation section

=head1 SYNOPSIS

	use Parrot::Docs::Section::DynaPMCs;

=head1 DESCRIPTION

A documentation section describing all the dynamic PMCs.

=head2 Class Methods

=over

=cut

package Parrot::Docs::Section::DynaPMCs;

use strict;
use warnings;

use base qw( Parrot::Docs::Section );

=item C<new()>

Returns a new section.

=cut

sub new
{
	my $self = shift;
	
	return $self->SUPER::new(
		'Dynamic PMCs', 'dynapmc.html', '',
		$self->new_group('Loading', '', 'src/dynpmc'),
		$self->new_group('Runtime', '', 'runtime/parrot/include'),
	);
}

=back

=cut

1;
