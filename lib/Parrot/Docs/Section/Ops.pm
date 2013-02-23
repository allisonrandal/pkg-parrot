# Copyright: 2004 The Perl Foundation.  All Rights Reserved.
# $Id: Ops.pm 10425 2005-12-10 01:51:41Z particle $

=head1 NAME

Parrot::Docs::Section::Ops - Parrot ops documentation section

=head1 SYNOPSIS

	use Parrot::Docs::Section::Ops;

=head1 DESCRIPTION

A documentation section describing the Parrot ops.

=head2 Class Methods

=over

=cut

package Parrot::Docs::Section::Ops;

use strict;

use Parrot::Docs::Section;
@Parrot::Docs::Section::Ops::ISA = qw(Parrot::Docs::Section);

=item C<new()>

Returns a new section.

=cut

sub new
{
	my $self = shift;
	
	return $self->SUPER::new(
		'Ops', 'ops.html', '',
		$self->new_group('Tools', '',
			$self->new_item('', 'tools/build/ops2c.pl'),
			$self->new_item('', 'src/ops/ops.num'),
			$self->new_item('', 'tools/build/ops2pm.pl'),
		),
		$self->new_group('Op Libs', '', 'ops'),
	);
}

=back

=cut

1;