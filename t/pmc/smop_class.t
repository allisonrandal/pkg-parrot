#!./parrot
# Copyright (C) 2007, The Perl Foundation.
# $Id: /parrotcode/local/t/pmc/smop_class.t 2657 2007-03-31T01:57:48.733769Z chromatic  $

=head1 NAME

t/pmc/smop_class.t - test the new SMOP Class PMC


=head1 SYNOPSIS

    % prove t/pmc/smop_class.t

=head1 DESCRIPTION

Tests the SMOP_Class PMC.

=cut

.sub _main :main
    load_bytecode 'library/Test/More.pir'

    # import test routines
    .local pmc exports, curr_namespace, test_namespace
    curr_namespace = get_namespace
    test_namespace = get_namespace [ "Test::More" ]
    exports = split " ", "plan ok is isa_ok"
    test_namespace.export_to(curr_namespace, exports)

    plan( 1 )

    $P0 = new 'SMOP_Class'
    isa_ok($P0, 'SMOP_Class')
.end


# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
