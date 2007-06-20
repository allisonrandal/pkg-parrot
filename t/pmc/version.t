#! parrot
# Copyright (C) 2006-2007, The Perl Foundation.
# $Id: version.t 18314 2007-04-24 14:24:25Z coke $

=head1 NAME

t/pmc/version.t - test the Version PMC

=head1 SYNOPSIS

    % prove t/pmc/version.t

=head1 DESCRIPTION

Tests the Version PMC.

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

    new P0, .Version
    ok(1, 'Instantiated .Version')
.end

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
