#!perl
# Copyright: 2001-2005 The Perl Foundation.  All Rights Reserved.
# $Id: interp.t 10228 2005-11-28 22:52:05Z particle $

use strict;
use warnings;
use lib qw( . lib ../lib ../../lib );
use Test::More;
use Parrot::Test;


=head1 NAME

t/op/interp.t - Running the Interpreter

=head1 SYNOPSIS

	% prove t/op/interp.t

=head1 DESCRIPTION

Tests the old and new styles of running the Parrot interpreter and the
C<interpinfo> opcode.

=cut


SKIP: {
	skip("we really shouldn't run just a label - use a sub", 1);
output_is(<<'CODE', <<'OUTPUT', "runinterp - new style");
	new P0, .ParrotInterpreter
	print "calling\n"
	# set_addr/invoke ?
	runinterp P0, foo
	print "ending\n"
	end
	print "bad things!\n"
foo:
	print "In 2\n"
	end
CODE
calling
In 2
ending
OUTPUT
}

# Need to disable DOD while trace is on, as there's a non-zero chance that a
# DOD sweep would occur, causing a bonus "DOD" line in the output, which makes
# the test fail.
output_like(<<'CODE', <<'OUTPUT', "restart trace");
	printerr "ok 1\n"
	sweepoff
	set I0, 1
	trace I0
	printerr "ok 2\n"
	dec I0
	trace I0
	sweepon
	printerr "ok 3\n"
	end
CODE
/^ok\s1\n
(?:\s+8.*)?\n
ok\s2\n
(?:\s+10.*)?\n
(?:\s+12.*)?\n
ok\s3\n$/x
OUTPUT

output_like(<<'CODE', <<'OUTPUT', "interp - warnings");
	new P0, .PerlUndef
	set I0, P0
	printerr "nada:"
	warningson 1
	new P1, .PerlUndef
	set I0, P1
	end
CODE
/^nada:Use of uninitialized value in integer context/
OUTPUT

output_is(<<'CODE', <<'OUTPUT', "getinterp");
    .include "interpinfo.pasm"
    getinterp P0
    print "ok 1\n"
    set I0, P0[.INTERPINFO_ACTIVE_PMCS]
    interpinfo I1, .INTERPINFO_ACTIVE_PMCS
    eq I0, I1, ok2
    print "not "
ok2:
    print "ok 2\n"
    end
CODE
ok 1
ok 2
OUTPUT

output_is(<<'CODE', <<'OUTPUT', "access argv");
    get_params "(0)", P5
    .include "iglobals.pasm"
    getinterp P1
    set P2, P1[.IGLOBALS_ARGV_LIST]
    set I0, P5
    set I1, P2
    eq I0, I1, ok1
    print "not "
ok1:
    print "ok 1\n"
    set S0, P5[0]
    set S1, P2[0]
    eq S0, S1, ok2
    print "not "
ok2:
    print "ok 2\n"
    end
CODE
ok 1
ok 2
OUTPUT

output_is(<<'CODE', <<'OUTPUT', "check_events");
    print "before\n"
    check_events
    print "after\n"
    end
CODE
before
after
OUTPUT


## remember to change the number of tests :-)
BEGIN { plan tests => 6; }