#! perl -w

# Copyright: 2001-2004 The Perl Foundation.  All Rights Reserved.
# $Id: array.t 8074 2005-05-12 12:56:29Z leo $

=head1 NAME

t/pmc/array.t - Array PMC

=head1 SYNOPSIS

	% perl -Ilib t/pmc/array.t

=head1 DESCRIPTION

Tests C<Array> PMC. Checks size, sets various elements, including
out-of-bounds test. Checks INT and PMC keys.

=cut

use Parrot::Test tests => 13;
use Test::More;

my $fp_equality_macro = <<'ENDOFMACRO';
.macro fp_eq (	J, K, L )
	save	N0
	save	N1
	save	N2

	set	N0, .J
	set	N1, .K
	sub	N2, N1,N0
	abs	N2, N2
	gt	N2, 0.000001, .$FPEQNOK

	restore N2
	restore	N1
	restore	N0
	branch	.L
.local $FPEQNOK:
	restore N2
	restore	N1
	restore	N0
.endm
.macro fp_ne(	J,K,L)
	save	N0
	save	N1
	save	N2

	set	N0, .J
	set	N1, .K
	sub	N2, N1,N0
	abs	N2, N2
	lt	N2, 0.000001, .$FPNENOK

	restore	N2
	restore	N1
	restore	N0
	branch	.L
.local $FPNENOK:
	restore	N2
	restore	N1
	restore	N0
.endm
ENDOFMACRO

output_is(<<'CODE', <<'OUTPUT', "Setting array size");
	new P0,.Array

	set I0,P0
	eq I0,0,OK_1
	print "not "
OK_1:	print "ok 1\n"

	set P0,1
	set I0,P0
	eq I0,1,OK_2
	print "not "
OK_2:	print "ok 2\n"

	set P0,2
	set I0,P0
	eq I0,2,OK_3
	print "not "
OK_3:	print "ok 3\n"

        new P1, .Integer
        set P1, 3
	set P0,P1
	set I0,P0
	eq I0,3,OK_4
	print "not "
OK_4:	print "ok 4\n"


        end
CODE
ok 1
ok 2
ok 3
ok 4
OUTPUT

output_is(<<'CODE', <<'OUTPUT', "Setting first element");
        new P0, .Array
        set P0, 1

	set P0[0],-7
	set I0,P0[0]
	eq I0,-7,OK_1
	print "not "
OK_1:	print "ok 1\n"

	set P0[0],3.7
	set N0,P0[0]
	eq N0,3.7,OK_2
	print "not "
OK_2:	print "ok 2\n"

	set P0[0],"Buckaroo"
	set S0,P0[0]
	eq S0,"Buckaroo",OK_3
	print "not "
OK_3:	print "ok 3\n"

	end
CODE
ok 1
ok 2
ok 3
OUTPUT

output_is(<<'CODE', <<'OUTPUT', "Setting second element");
        new P0, .Array
        set P0, 2

	set P0[1], -7
	set I0, P0[1]
	eq I0,-7,OK_1
	print "not "
OK_1:	print "ok 1\n"

	set P0[1], 3.7
	set N0, P0[1]
	eq N0,3.7,OK_2
	print "not "
OK_2:	print "ok 2\n"

	set P0[1],"Buckaroo"
	set S0, P0[1]
	eq S0,"Buckaroo",OK_3
	print "not "
OK_3:	print "ok 3\n"

	end
CODE
ok 1
ok 2
ok 3
OUTPUT

output_like(<<'CODE', <<'OUTPUT', "Setting out-of-bounds elements");
        new P0, .Array
        set P0, 1

	set P0[1], -7

	end
CODE
/^Array index out of bounds!
current instr/
OUTPUT

output_like(<<'CODE', <<'OUTPUT', "Getting out-of-bounds elements");
        new P0, .Array
        set P0, 1

	set I0, P0[1]
	end
CODE
/^Array index out of bounds!
current instr/
OUTPUT

output_is(<<'CODE', <<OUTPUT, "defined");
    new P0, .Array
    defined I0, P0
    print I0
    print "\n"
    defined I0, P1
    print I0
    print "\n"
    set P0, 5
    set P0[0], 1
    defined I0, P0[0]
    print I0
    print "\n"
    defined I0, P0[1]
    print I0
    print "\n"
    defined I0, P0[100]
    print I0
    print "\n"
    new P1, .Undef
    set P0[2], P1
    defined I0, P0[2]
    print I0
    print "\n"
    new P2, .Key
    set P2, 3
    set P0[3], 4
    defined I0, P0[P2]
    print I0
    print "\n"
    set P2, 4
    defined I0, P0[P2]
    print I0
    print "\n"
    end
CODE
1
0
1
0
0
0
1
0
OUTPUT

output_is(<<'CODE', <<OUTPUT, "exists");
    new P0, .Array
    set P0, 5
    set P0[0], 1
    exists I0, P0[0]
    print I0
    print "\n"
    exists I0, P0[1]
    print I0
    print "\n"
    exists I0, P0[100]
    print I0
    print "\n"
    new P1, .Undef
    set P0[2], P1
    exists I0, P0[2]
    print I0
    print "\n"
    new P2, .Key
    set P2, 3
    set P0[3], 4
    exists I0, P0[P2]
    print I0
    print "\n"
    set P2, 4
    exists I0, P0[P2]
    print I0
    print "\n"
    end
CODE
1
0
0
1
1
0
OUTPUT

output_is(<<"CODE", <<'OUTPUT', "Set via PMC keys, access via INTs");
@{[ $fp_equality_macro ]}
     new P0, .Array
     set P0, 4
     new P1, .Key

     set P1, 0
     set P0[P1], 25

     set P1, 1
     set P0[P1], 2.5

     set P1, 2
     set P0[P1], "Squeek"

     set P1, 3
     new P2, .Hash
     set P2["a"], "apple"
     set P0[P1], P2

     set I0, P0[0]
     eq I0, 25, OK1
     print "not "
OK1: print "ok 1\\n"

     set N0, P0[1]
     .fp_eq(N0, 2.5, OK2)
     print "not "
OK2: print "ok 2\\n"

     set S0, P0[2]
     eq S0, "Squeek", OK3
     print "not "
OK3: print "ok 3\\n"

     set P3, P0[3]
     set S1, P3["a"]
     eq S1, "apple", OK4
     print "not "
OK4: print "ok 4\\n"

     end
CODE
ok 1
ok 2
ok 3
ok 4
OUTPUT

output_is(<<"CODE", <<'OUTPUT', "Set via INTs, access via PMC Keys");
@{[ $fp_equality_macro ]}
     new P0, .Array
     set P0, 1024

     set P0[25], 125
     set P0[128], -9.9
     set P0[513], "qwertyuiopasdfghjklzxcvbnm"
     new P1, .Integer
     set P1, 123456
     set P0[1023], P1

     new P2, .Key
     set P2, 25
     set I0, P0[P2]
     eq I0, 125, OK1
     print "not "
OK1: print "ok 1\\n"

     set P2, 128
     set N0, P0[P2]
     .fp_eq(N0, -9.9, OK2)
     print "not "
OK2: print "ok 2\\n"

     set P2, 513
     set S0, P0[P2]
     eq S0, "qwertyuiopasdfghjklzxcvbnm", OK3
     print "not "
OK3: print "ok 3\\n"

     set P2, 1023
     set P3, P0[P2]
     set I1, P3
     eq I1, 123456, OK4
     print "not "
OK4: print "ok 4\\n"

     end
CODE
ok 1
ok 2
ok 3
ok 4
OUTPUT

output_is(<<'CODE', <<OUT, "multikeyed access I arg");
	new P0, .Array
	set P0, 1
	new P1, .Array
	set P1, 1
	set P0[0], P1
	set P0[0;0], 20
	set P2, P0[0]
	typeof S0, P2
	print S0
	print "\n"
	set I2, P0[0;0]
	print I2
	set I3, 0
	set I2, P0[I3;0]
	print I2
	set I2, P0[0;I3]
	print I2
	set I2, P0[I3;I3]
	print I2
	print "\n"
	end
CODE
Array
20202020
OUT

output_is(<<'CODE', <<OUT, "multikeyed access P arg");
	new P0, .Array
	set P0, 1
	new P1, .Array
	set P1, 1
	new P3, .Integer
	set P3, 20
	set P0[0], P1
	set P0[0;0], P3
	set P2, P0[0]
	typeof S0, P2
	print S0
	print "\n"
	set I2, P0[0;0]
	print I2
	set I3, 0
	set I2, P0[I3;0]
	print I2
	set I2, P0[0;I3]
	print I2
	set I2, P0[I3;I3]
	print I2
	print "\n"
	end
CODE
Array
20202020
OUT

output_is(<<'CODE', <<OUT, "delete");
	new P0, .Array
	set P0, 3
	set P0[0], 10
	set P0[1], 20
	set P0[2], 30

	delete P0[1]
	set I0, P0
	print I0

	set I0, P0[0]
	print I0
	set I0, P0[1]
	print I0
	print "\n"
	end
CODE
21030
OUT

pir_output_is(<< 'CODE', << 'OUTPUT', "check whether interface is done");

.sub _main
    .local pmc pmc1
    pmc1 = new Array
    .local int bool1
    does bool1, pmc1, "scalar"
    print bool1
    print "\n"
    does bool1, pmc1, "array"
    print bool1
    print "\n"
    does bool1, pmc1, "no_interface"
    print bool1
    print "\n"
    end
.end
CODE
0
1
0
OUTPUT

1;