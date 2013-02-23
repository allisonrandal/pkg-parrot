#! perl
# Copyright (C) 2001-2003, The Perl Foundation.
# $Id: /local/tools/docs/write_docs.pl 13529 2006-07-24T17:20:02.191389Z chip  $

=head1 NAME

tools/docs/write_docs.pl - Write HTML documentation

=head1 SYNOPSIS

    % perl tools/docs/write_docs.pl [--silent] [--delete]

=head1 DESCRIPTION

This script writes the HTML documentation for Parrot.

=cut

use strict;
use warnings;
use lib 'lib';
use Getopt::Long;
use Parrot::Docs::Section::Parrot;

my ($silent, $delete);

die unless GetOptions('silent' => \$silent, 'delete' => \$delete);

my $docs = Parrot::Docs::Section::Parrot->new;

$docs->write_docs($silent, $delete);

exit 0;
