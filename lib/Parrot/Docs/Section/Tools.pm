# Copyright: 2004 The Perl Foundation.  All Rights Reserved.
# $Id: Tools.pm 10368 2005-12-06 01:04:53Z particle $

=head1 NAME

Parrot::Docs::Section::Tools - Tools documentation section

=head1 SYNOPSIS

	use Parrot::Docs::Section::Tools;

=head1 DESCRIPTION

A documentation section describing Parrot tools.

=head2 Class Methods

=over

=cut

package Parrot::Docs::Section::Tools;

use strict;

use Parrot::Docs::Section;
@Parrot::Docs::Section::Tools::ISA = qw(Parrot::Docs::Section);

use Parrot::Docs::Item;

=item C<new()>

Returns a new section.

=cut

sub new
{
	my $self = shift;
	
	return $self->SUPER::new(
		'Tools', 'tools.html', '',
		$self->new_group('Configuration', '',
			$self->new_item('', 'tools/dev/cc_flags.pl'),
			$self->new_item('', 'tools/build/nativecall.pl'),
			$self->new_item('', 'tools/build/jit2h.pl'),
			$self->new_item('', 'tools/build/vtable_h.pl'),
		),
		$self->new_group('Bytecode', '',
			$self->new_item('', 'tools/build/fingerprint_c.pl'),
			$self->new_item('', 'tools/build/pbc2c.pl'),
			$self->new_item('', 'tools/dev/nm.pl'),
			$self->new_item('', 'tools/dev/symlink.pl'),
		),
		$self->new_group('QA', '',
			$self->new_item('', 'parrotbug'),
			$self->new_item('', 'tools/dev/parrotbench.pl'),
			$self->new_item('', 'tools/dev/check_source_standards.pl'),
			$self->new_item('', 'tools/dev/run_indent.pl'),
			$self->new_item('', 'tools/docs/pod_errors.pl'),
		),
		$self->new_group('Documentation', '',
			$self->new_item('', 'tools/dev/extract_file_descriptions.pl'),
			$self->new_item('', 'tools/dev/lib_deps.pl'),
			$self->new_item('', 'tools/dev/parrot_coverage.pl'),
			$self->new_item('', 'tools/docs/write_docs.pl'),
		),
		$self->new_group('Building', '',
			$self->new_item('', 'tools/dev/manicheck.pl'),
			$self->new_item('', 'tools/dev/genrpt.pl'),
			$self->new_item('', 'tools/dev/mk_manifests.pl'),
			$self->new_item('', 'tools/dev/install_files.pl'),
			$self->new_item('', 'tools/dev/rebuild_miniparrot.pl'),
		),
		$self->new_group('Testing', '',
			$self->new_item('', 'tools/dev/mk_native_pbc'),
		),
		$self->new_group('Utilities', '',
			$self->new_item('', 'util'),
		),
	);
}

=back

=cut

1;