#!./parrot
# Copyright (C) 2006-2008, Parrot Foundation.
# $Id: parrotthread.t 46170 2010-04-30 03:48:43Z tewk $

=head1 NAME

t/pmc/parrotthread.t - test the ParrotThread PMC

=head1 SYNOPSIS

    % prove t/pmc/parrotthread.t

=head1 DESCRIPTION

Tests the ParrotThread PMC.

=cut

.sub 'main' :main
    .include 'test_more.pir'

    plan(1)

    new $P0, ['ParrotThread']
    ok(1, 'Instantiated a ParrotThread PMC')

.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:
