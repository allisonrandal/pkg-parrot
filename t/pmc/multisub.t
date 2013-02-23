#! perl
# Copyright: 2001-2005 The Perl Foundation.  All Rights Reserved.
# $Id: multisub.t 10706 2005-12-27 23:03:52Z particle $

use strict;
use warnings;
use lib qw( . lib ../lib ../../lib );
use Test::More;
use Parrot::Test tests => 1;

=head1 NAME

t/pmc/multisub.t - Multi Sub PMCs

=head1 SYNOPSIS

	% prove t/pmc/multisub.t

=head1 DESCRIPTION

Tests the creation and invocation of Perl6 multi subs.

=cut

output_is(<<'CODE', <<'OUTPUT', "create PMC");
    new P0, .MultiSub
    print "ok 1\n"
    elements I0, P0
    print I0
    print "\n"
    end
CODE
ok 1
0
OUTPUT

