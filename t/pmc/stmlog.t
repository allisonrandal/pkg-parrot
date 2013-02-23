#! parrot
# Copyright (C) 2007, The Perl Foundation.
# $Id: /parrotcode/trunk/t/pmc/stmlog.t 3298 2007-04-24T21:11:04.820703Z coke  $

=head1 NAME

t/pmc/stmlog.t - test the STMLog PMC

=head1 SYNOPSIS

    % prove t/pmc/stmlog.t

=head1 DESCRIPTION

Tests the STMLog PMC.

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

    new P0, .STMLog
    ok(1, 'Instantiated .STMLog')
.end

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4: