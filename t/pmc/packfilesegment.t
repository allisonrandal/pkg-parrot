#!./parrot
# Copyright (C) 2009-2010, Parrot Foundation.
# $Id: packfilesegment.t 46007 2010-04-25 11:44:15Z fperrad $

=head1 NAME

t/pmc/packfilesegment.t - test the PackfileSegment PMC


=head1 SYNOPSIS

    % prove t/pmc/packfilesegment.t

=head1 DESCRIPTION

Tests the PackfileSegment PMC.

=cut

.sub 'test' :main
.include 'test_more.pir'
    plan(1)

    $P0 = new 'PackfileSegment'
    isa_ok($P0, 'PackfileSegment')
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:
