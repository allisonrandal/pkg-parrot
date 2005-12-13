# Copyright: 2004 The Perl Foundation.  All Rights Reserved.
# $Id: Libs.pm 10474 2005-12-13 00:01:37Z particle $

=head1 NAME

Parrot::Docs::Libs - Parrot libraries documentation section

=head1 SYNOPSIS

	use Parrot::Docs::Libs;

=head1 DESCRIPTION

A documentation section describing libraries in Parrot.

=head2 Class Methods

=over

=cut

package Parrot::Docs::Section::Libs;

use strict;

use Parrot::Docs::Section;
@Parrot::Docs::Section::Libs::ISA = qw(Parrot::Docs::Section);

=item C<new()>

Returns a new section.

=cut

sub new
{
	my $self = shift;
	
	return $self->SUPER::new(
		'Libraries', 'libs.html', '',
		$self->new_group('Parrot Core Libraries', '', 'runtime/parrot/library'),
		$self->new_group('Dynamic Libraries', '', 'src/dynoplibs'),
	);
}

=back

=cut

1;
