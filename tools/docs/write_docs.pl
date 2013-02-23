#! perl -w
# Copyright: 2001-2003 The Perl Foundation.  All Rights Reserved.
# $Id: write_docs.pl 5507 2004-03-03 11:17:29Z mikescott $

=head1 NAME

tools/docs/write_docs.pl - Write HTML documentation

=head1 SYNOPSIS

    % perl tools/docs/write_docs.pl [--silent] [--delete]

=head1 DESCRIPTION

This script writes the HTML documentation for Parrot.

=cut

use lib 'lib';
use Getopt::Long;
use Parrot::Docs::Section::Parrot;

my ($silent, $delete);

die unless GetOptions('silent' => \$silent, 'delete' => \$delete);

my $docs = Parrot::Docs::Section::Parrot->new;

$docs->write_docs($silent, $delete);

exit 0;
