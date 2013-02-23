#! perl
# Copyright (C) 2007, Parrot Foundation.
# $Id: 04-alt_file.t 36833 2009-02-17 20:09:26Z allison $
# 04-alt_file.t

use strict;
use warnings;

use Test::More;
plan( skip_all => "\nRelevant only when working in checkout from repository" )
    unless (-e 'DEVELOPING');
plan( tests =>  6 );
use Carp;
use lib (qw| lib |);
use_ok('Parrot::Manifest');

my $script = $0;
my $g      = q{something_other_than_MANIFEST};

my $mani = Parrot::Manifest->new(
    {
        script => $script,
        file   => $g,
    }
);
isa_ok( $mani, 'Parrot::Manifest' );

my $manifest_lines_ref = $mani->prepare_manifest();
ok( $manifest_lines_ref, "prepare_manifest_skip() returned" );

ok( !-f $g, "No $g found" );
my $need_for_file = $mani->determine_need_for_manifest($manifest_lines_ref);
ok( $need_for_file, "Need to regenerate $g" );

pass("Completed all tests in $0");

################### DOCUMENTATION ###################

=head1 NAME

04-alt_file.t - What happens when MANIFEST has a different name

=head1 SYNOPSIS

    % prove t/manifest/04-alt_file.t

=head1 DESCRIPTION

The files in this directory test the publicly callable methods of
F<lib/Parrot/Manifest.pm> and packages which inherit from that package.

F<04-alt_file.t> tests whether Parrot::Manifest correctly determines
whether we could, in principal, supply a file other than MANIFEST to
C<Parrot::Manifest::new()>.

=head1 AUTHOR

James E Keenan (jkeenan@cpan.org)

=head1 SEE ALSO

Parrot::Manifest, Parrot::Manifest::Files, Parrot::Manifest::Skip,
F<tools/dev/mk_manifest_and_skip.pl>.

=cut

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
