#!perl
# Copyright (C) 2001-2005, The Perl Foundation.
# $Id: /parrotcode/local/t/op/jitn.t 2657 2007-03-31T01:57:48.733769Z chromatic  $

use strict;
use warnings;
use lib qw( . lib ../lib ../../lib );
use Test::More;
use Parrot::Test tests => 14;

=head1 NAME

t/op/jitn.t - JIT register allocation

=head1 SYNOPSIS

        % prove t/op/jitn.t

=head1 DESCRIPTION

Tests JIT register allocation. These tests are written for four mappable
registers.

=cut

pasm_output_is( <<'CODE', <<'OUTPUT', "sub_n_n_n 1,2,3 mapped" );
set N0,0
set N1,1
set N2,2
sub N0,N1,N2
print N0
print "\n"
print N1
print "\n"
print N2
print "\n"
end
CODE
-1.000000
1.000000
2.000000
OUTPUT

pasm_output_is( <<'CODE', <<'OUTPUT', "sub_n_n_i 1,2,3 mapped" );
set N0,0
set N1,1
set I2,2
sub N0,N1,I2
print N0
print "\n"
print N1
print "\n"
end
CODE
-1.000000
1.000000
OUTPUT

pasm_output_is( <<'CODE', <<'OUTPUT', "sub_n_n_n 1,2 mapped" );
set N0,0
set N1,1
set N2,2
set N3,3
set N4,4
set N0,N1
set N2,N3
set N0,N1
set N2,N3
sub N0,N1,N4
print N0
print "\n"
print N1
print "\n"
print N4
print "\n"
end
CODE
-3.000000
1.000000
4.000000
OUTPUT

pasm_output_is( <<'CODE', <<'OUTPUT', "sub_n_n_n 1,3 mapped" );
set N0,0
set N1,1
set N2,2
set N3,3
set N4,4
set N0,N1
set N2,N3
set N0,N1
set N2,N3
sub N0,N4,N1
print N0
print "\n"
print N4
print "\n"
print N1
print "\n"
end
CODE
3.000000
4.000000
1.000000
OUTPUT

pasm_output_is( <<'CODE', <<'OUTPUT', "sub_n_n_i 1,3 mapped" );
set N0,0
set I1,1
set N1,1
set N2,2
set N3,3
set N4,4
set N0,N1
set N2,N3
set N0,N1
set N2,N3
sub N0,N4,I1
print N0
print "\n"
print N4
print "\n"
end
CODE
3.000000
4.000000
OUTPUT

pasm_output_is( <<'CODE', <<'OUTPUT', "sub_n_n_n 2,3 mapped" );
set N0,0
set N1,1
set N2,2
set N3,3
set N4,4
set N0,N1
set N2,N3
set N0,N1
set N2,N3
sub N4,N0,N1
print N4
print "\n"
print N0
print "\n"
print N1
print "\n"
end
CODE
0.000000
1.000000
1.000000
OUTPUT

pasm_output_is( <<'CODE', <<'OUTPUT', "sub_n_n_i 2,3 mapped" );
set N0,0
set N1,1
set I1,1
set N2,2
set N3,3
set N4,4
set N0,N1
set N2,N3
set N0,N1
set N2,N3
sub N4,N0,I1
print N4
print "\n"
print N0
print "\n"
print N1
print "\n"
end
CODE
0.000000
1.000000
1.000000
OUTPUT

pasm_output_is( <<'CODE', <<'OUTPUT', "sub_n_n_n 1 mapped" );
set N0,0
set N1,1
set N2,2
set N3,3
set N4,4
set N5,0
set N0,N1
set N2,N3
set N0,N1
set N2,N3
sub N1,N5,N4
print N1
print "\n"
print N5
print "\n"
print N4
print "\n"
end
CODE
-4.000000
0.000000
4.000000
OUTPUT

pasm_output_is( <<'CODE', <<'OUTPUT', "sub_n_n_n 2 mapped" );
set N0,0
set N1,1
set N2,2
set N3,3
set N4,4
set N0,N1
set N2,N3
set N0,N1
set N2,N3
sub N5,N1,N4
print N5
print "\n"
print N1
print "\n"
print N4
print "\n"
end
CODE
-3.000000
1.000000
4.000000
OUTPUT

pasm_output_is( <<'CODE', <<'OUTPUT', "sub_n_n_n 3 mapped" );
set N0,0
set N1,1
set N2,2
set N3,3
set N4,4
set N0,N1
set N2,N3
set N0,N1
set N2,N3
sub N5,N4,N1
print N5
print "\n"
print N1
print "\n"
print N4
print "\n"
end
CODE
3.000000
1.000000
4.000000
OUTPUT

pasm_output_is( <<'CODE', <<'OUTPUT', "sub_n_n_n 0 mapped" );
set N0,0
set N1,1
set N2,2
set N3,3
set N4,4
set N6,0
set N0,N1
set N2,N3
set N0,N1
set N2,N3
sub N5,N6,N4
print N5
print "\n"
print N6
print "\n"
print N4
print "\n"
end
CODE
-4.000000
0.000000
4.000000
OUTPUT

pasm_output_is( <<'CODE', <<'OUTPUT', "sub_n_n_n mapped same" );
set N2, 1
add N2, N2, N2  # reserve first reg
add N2, N2, N2
set N0, 10.0
set N1, 20.0
sub N0, N0, N1
sub N1, N1
print N2
print "\n"
print N1
print "\n"
print N0
print "\n"
end
CODE
4.000000
0.000000
-10.000000
OUTPUT

# rounding behavior
pir_output_is( <<'CODE', <<'OUT', "set_i_n testing" );

.sub _main
    .local num n
    .local int i

    n = 1.4
    i = n
    print i

    n = 2.5
    i = n
    print i

    n = 3.6
    i = n
    print i

    print "\n"
    end
.end
CODE
123
OUT

pasm_output_is( <<'CODE', <<'OUTPUT', "rounding due to mapped" );
    set N0, 15
    mul N0, N0, 0.1
    sub N0, 1.5
    unless N0, z
    print "not "
z:
    print "zero\n"
    end
CODE
zero
OUTPUT

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
