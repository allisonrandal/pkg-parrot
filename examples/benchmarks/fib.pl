#! perl -w
# Copyright (C) 2001-2003, The Perl Foundation.
# $Id: /local/examples/benchmarks/fib.pl 12835 2006-05-30T13:32:26.641316Z coke  $

=head1 NAME

examples/benchmarks/fib.pl - Fibonacci Benchmark

=head1 SYNOPSIS

    % time perl examples/benchmarks/fib.pl n

=head1 DESCRIPTION

Calculates the Fibonacci Number for C<n> (defaults to 28 if
unspecified).

=cut

use strict;

sub fib {
	my $n = shift;
	return $n if ($n < 2);
	return fib($n-1) + fib($n-2);
}
my $N = shift || 28;

print "fib($N) = ", fib($N), "\n";

=head1 SEE ALSO

F<examples/benchmarks/fib.pir>.

=cut
