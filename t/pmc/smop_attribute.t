#!./parrot
# Copyright (C) 2007, The Perl Foundation.
# $Id: /parrotcode/trunk/t/pmc/smop_attribute.t 3277 2007-04-23T16:38:02.925658Z chromatic  $

=head1 NAME

t/pmc/smop_attribute.t - test the new SMOP Attribute PMC

=head1 SYNOPSIS

    % prove t/pmc/smop_attribute.t

=head1 DESCRIPTION

Tests the SMOP_Attribute PMC.

=cut

.sub _main :main
    load_bytecode 'library/Test/More.pir'

    # import test routines
    .local pmc exports, curr_namespace, test_namespace
    curr_namespace = get_namespace
    test_namespace = get_namespace [ "Test::More" ]
    exports = split " ", "plan ok is isa_ok"
    test_namespace.export_to(curr_namespace, exports)

    plan( 9 )

    $P0 = new 'SMOP_Attribute'
    isa_ok ($P0, 'SMOP_Attribute')

    # SMOP_Attribute used to cause segfaults when GC ran (RT #42408)
    $P1 = getinterp
    $P1.'run_gc'()

    $P0 = new 'SMOP_Attribute'
    $S0 = $P0.'name'("TestClass1")
    is ($S0, 'TestClass1', 'test the SMOP_Attribute name method')

    $S1 = $P0.'name'()
    is ($S1, 'TestClass1', 'test the SMOP_Attribute name method')

    $P0 = new 'SMOP_Attribute'
    $S0 = $P0.'type'("TestTypeClass1")
    is ($S0, 'TestTypeClass1', 'test the SMOP_Attribute name method')
    $S1 = $P0.'type'()
    is ($S1, 'TestTypeClass1', 'test the SMOP_Attribute name method')

    $P1 = new 'ResizableIntegerArray'
    push $P1, 1
    push $P1, 2
    push $P1, 3

    $P0 = new 'SMOP_Attribute'
    $P2 = $P0.'class'($P1)
    get_repr $S0, $P2
    is ($S0, '[ 1, 2, 3 ]', 'test the SMOP_Attribute type method with a ResizableIntegerArray' )
    $P3 = $P0.'class'()
    get_repr $S1, $P3
    is ($S1, '[ 1, 2, 3 ]', 'test the SMOP_Attribute type method with a ResizableIntegerArray' )


    $P1 = new 'FixedIntegerArray'
    set $P1, 3
    $P1[0]= 1
    $P1[1]= 2
    $P1[2]= 3

    $P0 = new 'SMOP_Attribute'
    $P2 = $P0.'class'($P1)
    get_repr $S0, $P2
    is( $S0, '[ 1, 2, 3 ]', 'test the SMOP_Attribute class method with a FixedIntegerArray' )

    $P3 = $P0.'class'()
    get_repr $S1, $P3
    is( $S1, '[ 1, 2, 3 ]', 'test the SMOP_Attribute class method with a FixedIntegerArray' )

.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4: