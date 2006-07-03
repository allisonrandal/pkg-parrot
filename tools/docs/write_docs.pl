#! perl -w
# Copyright (C) 2001-2003, The Perl Foundation.
# $Id: write_docs.pl 12841 2006-05-30 15:23:20Z coke $

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
