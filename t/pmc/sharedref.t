#! parrot
# Copyright (C) 2006-2008, Parrot Foundation.
# $Id: sharedref.t 37200 2009-03-08 11:46:01Z fperrad $

=head1 NAME

t/pmc/sharedref.t - test the SharedRef PMC

=head1 SYNOPSIS

    % prove t/pmc/sharedref.t

=head1 DESCRIPTION

Tests the SharedRef PMC.

=cut

.sub main :main
    .include 'test_more.pir'

    plan(1)

    new $P0, ['SharedRef']
    ok(1, 'Instantiated a SharedRef PMC')
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:
