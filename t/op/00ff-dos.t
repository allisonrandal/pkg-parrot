#!perl
# Copyright (C) 2001-2005, The Perl Foundation.
# $Id: 00ff-dos.t 12838 2006-05-30 14:19:10Z coke $

use strict;
use warnings;
use lib qw( . lib ../lib ../../lib );
use Test::More;
use Parrot::Test;


=head1 NAME

t/op/00ff-dos.t - DOS File Format

=head1 SYNOPSIS

	% prove t/op/00ff-dos.t

=head1 DESCRIPTION

Tests file formats.

=cut


my $code = qq(print "ok\\n"\r\nend\r\n);
pasm_output_is($code, <<'OUT', "fileformat dos");
ok
OUT

$code = qq(print "ok\\n"\r\nend\r\n\cZ\r\n);
pasm_output_is($code, <<'OUT', "fileformat dos w ctrl-z");
ok
OUT


## remember to change the number of tests :-)
BEGIN { plan tests => 2; }

