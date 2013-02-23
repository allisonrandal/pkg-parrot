#! parrot
# Copyright (C) 2006-2007, The Perl Foundation.
# $Id: /parrotcode/trunk/t/pmc/pointer.t 3298 2007-04-24T21:11:04.820703Z coke  $

=head1 NAME

t/pmc/pointer.t - test the Pointer PMC

=head1 SYNOPSIS

    % prove t/pmc/pointer.t

=head1 DESCRIPTION

Tests the Pointer PMC.

=cut

.sub main :main
    # load this library
    load_bytecode 'library/Test/More.pir'

    # get the testing functions
    .local pmc exports, curr_namespace, test_namespace
    curr_namespace = get_namespace
    test_namespace = get_namespace [ "Test::More" ]
    exports = split " ", "plan diag ok is is_deeply like isa_ok"

    test_namespace."export_to"(curr_namespace, exports)

    plan(1)

    new P0, .Pointer
    ok(1, 'Instantiated .Pointer')
.end

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
