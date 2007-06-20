#! parrot
# Copyright (C) 2006-2007, The Perl Foundation.
# $Id: unmanagedstruct.t 18327 2007-04-24 21:11:04Z coke $

=head1 NAME

t/pmc/unmanagedstruct.t - test the UnManagedStruct PMC

=head1 SYNOPSIS

    % prove t/pmc/unmanagedstruct.t

=head1 DESCRIPTION

Tests the UnManagedStruct PMC.

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

    new P0, .UnManagedStruct
    ok(1, 'Instantiated .UnManagedStruct')
.end

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
