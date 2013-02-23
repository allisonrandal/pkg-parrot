#! perl
# Copyright: 2005 The Perl Foundation.  All Rights Reserved.
# $Id: subs.t 10183 2005-11-26 11:05:39Z bernhard $

use strict;
use warnings;
use lib qw( . lib ../lib ../../lib );
use Test::More;
use Parrot::Test tests => 7;
use Parrot::Config;


=head1 NAME

t/examples/subs.t - Test examples in F<examples/subs>

=head1 SYNOPSIS

	% prove t/examples/subs.t

=head1 DESCRIPTION

Test the examples in F<examples/subs>.

=head1 SEE ALSO

F<t/examples/japh.t>
F<t/examples/pasm.t>
F<t/examples/pir.t>

=cut


# Set up expected output for examples
my %expected
  = (
    'bsr_ret.pasm'        =>  << 'END_EXPECTED',
Main
TestSub
NestSub
TestSub: Ret from NestSub
Main: Return from TestSub
END_EXPECTED

    'coroutine.pasm'        =>  << 'END_EXPECTED',
Calling 1st co-routine
Entry
Resumed
Done
Calling 2nd co-routine
Entry
Resumed
Done
END_EXPECTED

    'jsr_ret.pasm'        =>  << 'END_EXPECTED',
Example of the jump op.

Jumping to subroutine SUB_1.
Entered subroutine SUB_1.
Returning from subroutine SUB_1.
Returned from subroutine SUB_1.
Jumping to subroutine SUB_2.
Entered subroutine SUB_2.
Returning from subroutine SUB_2.
Returned from subroutine SUB_2.
END_EXPECTED

    'pasm_sub1.pasm'        =>  << 'END_EXPECTED',
Hello from subroutine
Hello from main
END_EXPECTED

    'sub1.imc'        =>  << 'END_EXPECTED',
7 8 nine
return: 10
END_EXPECTED

    'sub2.imc'        =>  << 'END_EXPECTED',
return: 10 11 12
END_EXPECTED

    'sub3.imc'        =>  << 'END_EXPECTED',
7 8 nine
END_EXPECTED
   );

while ( my ( $example, $expected ) = each %expected ) {
    example_output_is( "examples/subs/$example", $expected );
}