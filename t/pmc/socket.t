#!./parrot
# Copyright (C) 2006-2009, Parrot Foundation.
# $Id: socket.t 46007 2010-04-25 11:44:15Z fperrad $

=head1 NAME

t/pmc/socket.t - test the Socket PMC

=head1 SYNOPSIS

    % prove t/pmc/socket.t

=head1 DESCRIPTION

Tests the Socket PMC.

=cut

.sub main :main
    .include 'test_more.pir'

    plan(1)

    new $P0, ['Socket']
    ok(1, 'Instantiated a Socket PMC')
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:
