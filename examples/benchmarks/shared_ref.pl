#! perl -w
# Copyright (C) 2001-2003, The Perl Foundation.
# $Id: /local/examples/benchmarks/shared_ref.pl 12835 2006-05-30T13:32:26.641316Z coke  $

=head1 NAME

examples/benchmarks/shared_ref.pl - Shared reference between threads

=head1 SYNOPSIS

    % time perl examples/benchmarks/shared_ref.pl

=head1 DESCRIPTION

Shares references between threads.

=cut

use strict;
use threads;
use threads::shared;

for my $i (0..99_999) {
    my $r :shared;
    my $j :shared;
    $r = \$j;
    $$r = $i;
}

=head1 SEE ALSO

F<examples/benchmarks/shared_ref.pasm>.

=cut
