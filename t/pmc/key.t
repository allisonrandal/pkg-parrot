#! perl -w
# Copyright: 2001-2003 The Perl Foundation.  All Rights Reserved.
# $Id: key.t 7803 2005-04-11 13:37:27Z leo $

=head1 NAME

t/pmc/key.t - Keys

=head1 SYNOPSIS

	% perl -Ilib t/pmc/key.t

=head1 DESCRIPTION

Tests the C<Key> PMC.

=cut

use Parrot::Test tests => 1;
use Test::More;

output_is(<<'CODE', <<'OUT', 'traverse key chain');
    new P0, .Key
    set P0, "1"
    new P1, .Key
    set P1, "2"
    push P0, P1
    new P2, .Key
    set P2, "3"
    push P1, P2

    set P4, P0
l1:
    defined I0, P0
    unless I0, e1
    print P0
    shift P0, P0
    branch l1
e1:
    print "\n"

    set P0, P4
l2:
    defined I0, P0
    unless I0, e2
    print P0
    shift P0, P0
    branch l2
e2:
    print "\n"
    end
CODE
123
123
OUT
