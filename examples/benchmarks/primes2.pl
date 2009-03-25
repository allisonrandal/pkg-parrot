#! perl

# Copyright (C) 2004-2006, Parrot Foundation.
# $Id: primes2.pl 37201 2009-03-08 12:07:48Z fperrad $

use strict;
use warnings;

my $i   = 0;
my $max = 5000;
my $i6  = 0;
my $i7;

while (1) {
    if ( &isprime1($i) ) {
        $i7 = $i;
        $i6++;
    }
    $i++;
    if ( $i == $max ) {
        last;
    }
}
printf( "N primes calculated to %d is %d\nlast is: %d\n", $max, $i6, $i7 );

sub isprime1 {
    my ($input) = @_;
    my $n;

    if ( $input < 1 ) {
        return 0;
    }
    $n = $input - 1;

    while ( $n > 1 ) {
        if ( $input % $n == 0 ) { return 0; }
        $n--;
    }
    return 1;
}

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
