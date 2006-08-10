#! perl
# Copyright (C) 2005, The Perl Foundation.
# $Id: /local/languages/jako/t/examples.t 12840 2006-05-30T15:08:05.048089Z coke  $

use strict;
use warnings;
use lib qw( . lib ../lib ../../lib );
use Test::More;
use Parrot::Test tests => 15;
use Parrot::Config;


=head1 NAME

jako/t/examples.t - Test examples in F<jako/examples>

=head1 SYNOPSIS

	% prove languages/jako/t/examples.t

=head1 DESCRIPTION

Test the examples in F<jako/examples>.

=head1 SEE ALSO

F<t/examples/pir.t>

=head1 AUTHOR

Bernhard Schmalhofer - <Bernhard.Schmalhofer@gmx.de>

=cut


# Set up expected output for examples
my %expected
    = (
    'board.pir'        =>  << 'END_EXPECTED',
  +---+---+---+---+---+---+---+---+
8 |   | * |   | * |   | * |   | * |
  +---+---+---+---+---+---+---+---+
7 | * |   | * |   | * |   | * |   |
  +---+---+---+---+---+---+---+---+
6 |   | * |   | * |   | * |   | * |
  +---+---+---+---+---+---+---+---+
5 | * |   | * |   | * |   | * |   |
  +---+---+---+---+---+---+---+---+
4 |   | * |   | * |   | * |   | * |
  +---+---+---+---+---+---+---+---+
3 | * |   | * |   | * |   | * |   |
  +---+---+---+---+---+---+---+---+
2 |   | * |   | * |   | * |   | * |
  +---+---+---+---+---+---+---+---+
1 | * |   | * |   | * |   | * |   |
  +---+---+---+---+---+---+---+---+
    A   B   C   D   E   F   G   H  
END_EXPECTED

    'euclid.pir'        =>  << 'END_EXPECTED',
Algorithm E (Euclid's algorithm)
  Calculating gcd(96, 64) = ...
  ... = 32
END_EXPECTED

    'fact.pir'        =>  << 'END_EXPECTED',
Algorithm F1 (The factorial function)
    Calculating fact(15) = ...
    ... = 2004189184
END_EXPECTED

    'fib.pir'        =>  << 'END_EXPECTED',
Algorithm F2 (Fibonacci's function)
  Calculating fib(24) = ...
  ... = 46368
END_EXPECTED

    'hello.pir'        =>  << 'END_EXPECTED',
Hello, world!
END_EXPECTED

    'leibniz.pir'        =>  << 'END_EXPECTED',
PI is (very) approximately: 3.14159
END_EXPECTED

    'mandelbrot.pir'        =>  << 'END_EXPECTED',
................::::::::::::::::::::::::::::::::::::::::::::...............
...........::::::::::::::::::::::::::::::::::::::::::::::::::::::..........
........::::::::::::::::::::::::::::::::::,,,,,,,:::::::::::::::::::.......
.....:::::::::::::::::::::::::::::,,,,,,,,,,,,,,,,,,,,,,:::::::::::::::....
...::::::::::::::::::::::::::,,,,,,,,,,,,;;;!:H!!;;;,,,,,,,,:::::::::::::..
:::::::::::::::::::::::::,,,,,,,,,,,,,;;;;!!/>&*|& !;;;,,,,,,,:::::::::::::
::::::::::::::::::::::,,,,,,,,,,,,,;;;;;!!//)|.*#|>/!;;;;;,,,,,,:::::::::::
::::::::::::::::::,,,,,,,,,,,,;;;;;;!!!!//>|:    !:|//!!;;;;;,,,,,:::::::::
:::::::::::::::,,,,,,,,,,;;;;;;;!!/>>I>>)||I#     H&))>////*!;;,,,,::::::::
::::::::::,,,,,,,,,,;;;;;;;;;!!!!/>H:  #|              IH&*I#/;;,,,,:::::::
::::::,,,,,,,,,;;;;;!!!!!!!!!!//>|.H:                     #I>!!;;,,,,::::::
:::,,,,,,,,,;;;;!/||>///>>///>>)|H                         %|&/;;,,,,,:::::
:,,,,,,,,;;;;;!!//)& :;I*,H#&||&/                           *)/!;;,,,,,::::
,,,,,,;;;;;!!!//>)IH:,        ##                            #&!!;;,,,,,::::
,;;;;!!!!!///>)H%.**           *                            )/!;;;,,,,,::::
                                                          &)/!!;;;,,,,,::::
,;;;;!!!!!///>)H%.**           *                            )/!;;;,,,,,::::
,,,,,,;;;;;!!!//>)IH:,        ##                            #&!!;;,,,,,::::
:,,,,,,,,;;;;;!!//)& :;I*,H#&||&/                           *)/!;;,,,,,::::
:::,,,,,,,,,;;;;!/||>///>>///>>)|H                         %|&/;;,,,,,:::::
::::::,,,,,,,,,;;;;;!!!!!!!!!!//>|.H:                     #I>!!;;,,,,::::::
::::::::::,,,,,,,,,,;;;;;;;;;!!!!/>H:  #|              IH&*I#/;;,,,,:::::::
:::::::::::::::,,,,,,,,,,;;;;;;;!!/>>I>>)||I#     H&))>////*!;;,,,,::::::::
::::::::::::::::::,,,,,,,,,,,,;;;;;;!!!!//>|:    !:|//!!;;;;;,,,,,:::::::::
::::::::::::::::::::::,,,,,,,,,,,,,;;;;;!!//)|.*#|>/!;;;;;,,,,,,:::::::::::
:::::::::::::::::::::::::,,,,,,,,,,,,,;;;;!!/>&*|& !;;;,,,,,,,:::::::::::::
...::::::::::::::::::::::::::,,,,,,,,,,,,;;;!:H!!;;;,,,,,,,,:::::::::::::..
.....:::::::::::::::::::::::::::::,,,,,,,,,,,,,,,,,,,,,,:::::::::::::::....
........::::::::::::::::::::::::::::::::::,,,,,,,:::::::::::::::::::.......
...........::::::::::::::::::::::::::::::::::::::::::::::::::::::..........
END_EXPECTED

    'primes.pir'        =>  << 'END_EXPECTED',
Algorithm P (Naiive primality test)
  Printing primes up to 100...
2  3  5  7  11  13  17  19  23  29  31  37  41  43  47  53  59  61  67  71  73  79  83  89  97  
END_EXPECTED

    'queens.pir'        =>  << 'END_EXPECTED',
Making new board with 8 ranks and 8 files...
Board length is 64.
  +---+---+---+---+---+---+---+---+
8 |   | * | Q | * |   | * |   | * |
  +---+---+---+---+---+---+---+---+
7 | * |   | * |   | * | Q | * |   |
  +---+---+---+---+---+---+---+---+
6 |   | * |   | Q |   | * |   | * |
  +---+---+---+---+---+---+---+---+
5 | * | Q | * |   | * |   | * |   |
  +---+---+---+---+---+---+---+---+
4 |   | * |   | * |   | * |   | Q |
  +---+---+---+---+---+---+---+---+
3 | * |   | * |   | Q |   | * |   |
  +---+---+---+---+---+---+---+---+
2 |   | * |   | * |   | * | Q | * |
  +---+---+---+---+---+---+---+---+
1 | Q |   | * |   | * |   | * |   |
  +---+---+---+---+---+---+---+---+
    A   B   C   D   E   F   G   H  
END_EXPECTED

    'sub.pir'        =>  << 'END_EXPECTED',
x = 42; y = 137
x = 1234; y = 137
END_EXPECTED

    );

while ( my ( $example, $expected ) = each %expected ) {
    example_output_is( "jako/examples/$example", $expected );
}

TODO:
{
    local $TODO = 'some examples not testable yet';

    fail( 'bench.pir' );
    fail( 'life.pir' );
    fail( 'mandelzoom.pir' );
    fail( 'mops.pir' );
    fail( 'nci.pir' );
};
