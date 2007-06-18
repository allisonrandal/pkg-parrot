#! perl
# Copyright (C) 2001-2003, The Perl Foundation.
# $Id: /parrotcode/local/examples/benchmarks/shared_ref.pl 733 2006-12-17T23:24:17.491923Z chromatic  $

=head1 NAME

examples/benchmarks/shared_ref.pl - Shared reference between threads

=head1 SYNOPSIS

    % time perl examples/benchmarks/shared_ref.pl

=head1 DESCRIPTION

Shares references between threads.

=cut

use strict;
use warnings;
use threads;
use threads::shared;

for my $i ( 0 .. 99_999 ) {
    my $r : shared;
    my $j : shared;
    $r  = \$j;
    $$r = $i;
}

=head1 SEE ALSO

F<examples/benchmarks/shared_ref.pasm>.

=cut

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
