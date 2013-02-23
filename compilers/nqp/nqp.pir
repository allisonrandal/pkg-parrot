# Copyright (C) 2007-2008, Parrot Foundation.
# $Id: nqp.pir 43593 2010-01-26 02:39:50Z jkeenan $

.namespace [ 'NQP';'Compiler' ]

.sub '__onload' :load :init
    load_bytecode 'PGE.pbc'
    load_bytecode 'PCT.pbc'

    $P0 = new [ 'PCT';'HLLCompiler' ]
    $P0.'language'('NQP')
    $P0.'parsegrammar'('NQP::Grammar')
    $P0.'parseactions'('NQP::Grammar::Actions')

    $P0 = new 'Integer'
    set_hll_global ['NQP';'Grammar'], '$!endstmt', $P0
.end

.sub 'main' :main
    .param pmc args
    $P0 = compreg 'NQP'
    .tailcall $P0.'command_line'(args, 'encoding'=>'utf8', 'transcode'=>'ascii')
.end

.include 'compilers/nqp/src/Grammar_gen.pir'

.include 'compilers/nqp/src/Grammar/Actions.pir'

.include 'compilers/nqp/src/builtins.pir'

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:
