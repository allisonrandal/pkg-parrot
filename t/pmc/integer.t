#!perl
# Copyright (C) 2001-2008, Parrot Foundation.
# $Id: integer.t 37201 2009-03-08 12:07:48Z fperrad $

use strict;
use warnings;
use lib qw( . lib ../lib ../../lib );

use Test::More;
use Parrot::Test tests => 19;

=head1 NAME

t/pmc/integer.t - Integer basic type

=head1 SYNOPSIS

    % prove t/pmc/integer.t

=head1 DESCRIPTION

Tests the Integer PMC.

=cut

pir_output_is( << 'CODE', << 'OUTPUT', "basic math" );

.sub _main
    .local pmc int_1
    int_1 = new ['Integer']
    print int_1
    print "\n"
    int_1 = 1
    print int_1
    print "\n"
    int_1 += 777777
    int_1 -= 777776
    print int_1
    print "\n"
    int_1 *= -333333
    int_1 /= -222222
    print int_1
    print "\n"
    inc int_1
    inc int_1
    dec int_1
    print int_1
    print "\n"
    neg int_1
    dec int_1
    neg int_1
    print int_1
    print "\n"
    end
.end
CODE
0
1
2
3
4
5
OUTPUT

pir_output_is( << 'CODE', << 'OUTPUT', "truth and definedness" );

.sub _main
    .local pmc int_1
    int_1 = new ['Integer']

    print "A newly created Integer is "
    if int_1 goto LABEL_1
    print "not "
LABEL_1:
    print "true.\n"

    .local int is_defined

    is_defined = defined int_1
    print "A newly created Integer is "
    if is_defined goto LABEL_2
    print " not "
LABEL_2:
    print "defined.\n"

    int_1 = -999999999
    print "The Integer "
    print int_1
    print " is "
    if is_defined goto LABEL_3
    print "not "
LABEL_3:
    print "true.\n"

    is_defined = defined int_1
    print "The Integer "
    print int_1
    print " is "
    if is_defined goto LABEL_4
    print "not "
LABEL_4:
    print "defined.\n"
    end
.end
CODE
A newly created Integer is not true.
A newly created Integer is defined.
The Integer -999999999 is true.
The Integer -999999999 is defined.
OUTPUT

pir_output_is( <<'CODE', <<'OUTPUT', "set_string_native" );

.sub _main
    .local pmc pmc1
    pmc1 = new ['Integer']
    pmc1 = "-123456789"
    print pmc1
    print "\n"
    end
.end
CODE
-123456789
OUTPUT

pir_output_is( <<'CODE', <<'OUTPUT', "isa" );

.sub _main
    .local pmc pmc1
    pmc1 = new ['Integer']

    .local int pmc1_is_a
    pmc1_is_a = isa pmc1, "Integer"
    print "A newly created Integer is "
    if pmc1_is_a goto PMC1_IS_A_INTEGER
      print "not "
PMC1_IS_A_INTEGER:
    print "an Integer.\n"

    end
.end
CODE
A newly created Integer is an Integer.
OUTPUT

pir_output_is( << 'CODE', << 'OUTPUT', "check whether interface is done" );

.sub _main
    .local pmc pmc1
    pmc1 = new ['Integer']
    .local int bool1
    does bool1, pmc1, "scalar"
    print bool1
    print "\n"
    does bool1, pmc1, "integer"
    print bool1
    print "\n"
    does bool1, pmc1, "no_interface"
    print bool1
    print "\n"
    end
.end
CODE
1
1
0
OUTPUT

pir_output_is( << 'CODE', << 'OUTPUT', "Comparison ops: ne" );

.sub _main
    .local pmc pmc1
    pmc1 = new ['Integer']
    .local int int1
    pmc1 = 10
    int1 = 20
    ne pmc1, int1, OK1
    print "not "
OK1:
    print "ok 1\n"
    int1 = 10
    ne pmc1, int1, BAD2
    branch OK2
BAD2:
    print "not "
OK2:
    print "ok 2\n"
    end
.end
CODE
ok 1
ok 2
OUTPUT

pir_output_is( << 'CODE', << 'OUTPUT', "Comparison ops: gt" );

.sub _main
    .local pmc pmc1
    pmc1 = new ['Integer']
    .local int int1
    pmc1 = 10
    int1 = 5
    gt pmc1, int1, OK1
    print "not "
OK1:
    print "ok 1\n"
    int1 = 10
    gt pmc1, int1, BAD2
    branch OK2
BAD2:
    print "not "
OK2:
    print "ok 2\n"
    int1 = 20
    gt pmc1, int1, BAD3
    branch OK3
BAD3:
    print "not "
OK3:
    print "ok 3\n"
    end
.end
CODE
ok 1
ok 2
ok 3
OUTPUT

pir_output_is( << 'CODE', << 'OUTPUT', "Comparison ops: ge" );

.sub _main
    .local pmc pmc1
    pmc1 = new ['Integer']
    .local int int1
    pmc1 = 10
    int1 = 5
    ge pmc1, int1, OK1
    print "not "
OK1:
    print "ok 1\n"
    int1 = 10
    ge pmc1, int1, OK2
    print "not "
OK2:
    print "ok 2\n"
    int1 = 20
    ge pmc1, int1, BAD3
    branch OK3
BAD3:
    print "not "
OK3:
    print "ok 3\n"
    end
.end
CODE
ok 1
ok 2
ok 3
OUTPUT

pir_output_is( << 'CODE', << 'OUTPUT', "Logical ops: istrue & isfalse" );

.sub _main
    .local pmc pmc1
    pmc1 = new ['Integer']
    .local int int1
    pmc1 = 10
    istrue int1, pmc1
    print int1
    print "\n"
    isfalse int1, pmc1
    print int1
    print "\n"
    pmc1 = 0
    istrue int1, pmc1
    print int1
    print "\n"
    isfalse int1, pmc1
    print int1
    print "\n"

    end
.end
CODE
1
0
0
1
OUTPUT

pasm_output_is( <<'CODE', <<'OUTPUT', "if/unless with Integer PMC" );
      new P0, ['Integer']
      set P0, 10
      if P0, OK1
      print "not "
OK1:  print "ok 1\n"
      unless P0, BAD2
      branch OK2
BAD2: print "not "
OK2:  print "ok 2\n"
      set P0, 0
      if P0, BAD3
      branch OK3
BAD3: print "not "
OK3:  print "ok 3\n"
      unless P0, OK4
      print "not "
OK4:  print "ok 4\n"
      end
CODE
ok 1
ok 2
ok 3
ok 4
OUTPUT

pasm_output_is( <<'CODE', <<'OUT', "add" );
   new P0, ['Integer']
   set P0, 5
   new P1, ['Integer']
   set P1, 10
   new P2, ['Integer']
   add P2, P0, P1
   set S0, P2
   print S0
   print "\n"
   set P0, "20"
   set P1, "30"
   add P2, P1, P0
   set S0, P2
   print S0
   print "\n"
   end
CODE
15
50
OUT

pir_output_is( << 'CODE', << 'OUTPUT', "<oper>" );
.sub main :main
    $P0 = new ['Integer']
    $P1 = new ['Integer']
    set $P0, 6
    set $P1, 2

    add $P2, $P0, $P1
    print $P2
    print "\n"
    $P2 = add $P0, $P1
    print $P2
    print "\n"
    sub $P2, $P0, $P1
    print $P2
    print "\n"
    mul $P2, $P0, $P1
    print $P2
    print "\n"
    div $P2, $P0, $P1
    print $P2
    print "\n"
    mod $P2, $P0, $P1
    print $P2
    print "\n"
    pow $P2, $P0, $P1
    print $P2
    print "\n"
.end
CODE
8
8
4
12
3
0
36
OUTPUT

pir_output_is( <<'CODE', <<'OUTPUT', "can get_as_base()" );
.sub main :main
    $P0 = new ['Integer']
    $P0 = 42
    $I0 = can $P0, 'get_as_base'
    if $I0, OK
    print "not "
OK: print "ok\n"
.end
CODE
ok
OUTPUT

pir_error_output_like( <<'CODE', <<'OUTPUT', "get_as_base() bounds check" );
.sub main :main
    $P0 = new ['Integer']
    $P0 = 42

    $S0 = $P0.'get_as_base'(1)

    print $S0
    print "\n"
.end
CODE
/get_as_base: base out of bounds
.*/
OUTPUT

pir_error_output_like( <<'CODE', <<'OUTPUT', "get_as_base() bounds check" );
.sub main :main
    $P0 = new ['Integer']
    $P0 = 42

    $S0 = $P0.'get_as_base'(37)

    print $S0
    print "\n"
.end
CODE
/get_as_base: base out of bounds
.*/
OUTPUT

pir_output_is( <<'CODE', <<'OUTPUT', "get_as_base(10)" );
.sub main :main
    $P0 = new ['Integer']
    $P0 = 42

    $S0 = $P0.'get_as_base'(10)

    print $S0
    print "\n"
.end
CODE
42
OUTPUT

pir_output_is( <<'CODE', <<'OUTPUT', "get_as_base(various)" );
.sub main :main
    $P0 = new ['Integer']
    $P0 = 42

    $S0 = $P0.'get_as_base'(2)
    bsr PRINT

    $S0 = $P0.'get_as_base'(3)
    bsr PRINT

    $S0 = $P0.'get_as_base'(5)
    bsr PRINT

    $S0 = $P0.'get_as_base'(7)
    bsr PRINT

    $S0 = $P0.'get_as_base'(11)
    bsr PRINT

    $S0 = $P0.'get_as_base'(13)
    bsr PRINT

    $S0 = $P0.'get_as_base'(17)
    bsr PRINT

    $S0 = $P0.'get_as_base'(19)
    bsr PRINT

    $S0 = $P0.'get_as_base'(23)
    bsr PRINT

    $S0 = $P0.'get_as_base'(29)
    bsr PRINT

    $S0 = $P0.'get_as_base'(31)
    bsr PRINT
    goto END

PRINT:
    print $S0
    print "\n"
    ret
END:
.end
CODE
101010
1120
132
60
39
33
28
24
1j
1d
1b
OUTPUT

pir_output_is( <<'CODE', <<'OUTPUT', 'cmp functions for subclasses' );
.sub main :main
    $P0 = subclass 'Integer', 'Int'

    $P1 = new ['Int']
    $P1 = 1
    $P2 = new ['Int']
    $P2 = 2

    $I0 = cmp $P1, $P2
    say $I0
    $I0 = cmp $P1, $P1
    say $I0
    $I0 = cmp $P2, $P1
    say $I0
.end
CODE
-1
0
1
OUTPUT

pir_output_is( <<'CODE', <<'OUTPUT', 'cmp for Integers more than 2^31 apart, RT #59336' );
.sub 'main' :main
    $P0 = new ['Integer']
    $P0 = 2147483600

  test_10:
    print $P0
    print " is"
    if $P0 > -10 goto skip_10
    print " not"
  skip_10:
    say " greater than -10"

  test_1000:
    print $P0
    print " is"
    if $P0 > -1000 goto skip_1000
    print " not"
  skip_1000:
    say " greater than -1000"
.end
CODE
2147483600 is greater than -10
2147483600 is greater than -1000
OUTPUT

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
