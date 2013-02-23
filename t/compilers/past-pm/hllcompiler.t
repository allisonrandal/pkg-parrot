#!perl
# Copyright (C) 2005-2006, The Perl Foundation.
# $Id: /parrotcode/local/t/compilers/past-pm/hllcompiler.t 2657 2007-03-31T01:57:48.733769Z chromatic  $

use strict;
use warnings;
use lib qw(t . lib ../lib ../../lib ../../../lib);
use Test::More;
use Parrot::Test tests => 3;

=head1 NAME

t/hllcompiler.t - testing the features of the HLLCompiler module

=head1 SYNOPSIS

        $ prove t/compilers/past-pm/hllcompiler.t

=cut

pir_output_is( <<'CODE', <<'OUT', 'some of the auxiliary methods' );

.sub _main :main
    load_bytecode 'Parrot/HLLCompiler.pbc'
    $P0 = new [ 'HLLCompiler' ]

    # parse_name method
    $P1 = $P0.'parse_name'('None::Module')
    $S1 = $P1[0]
    say $S1
    $S1 = $P1[1]
    say $S1

    $P0.'parsegrammar'('None::Parser')
    $S1 = $P0.'parsegrammar'()
    say $S1

    $P0.'astgrammar'('None::Grammar')
    $S1 = $P0.'astgrammar'()
    say $S1

    $P0.'ostgrammar'('None::Grammar')
    $S1 = $P0.'ostgrammar'()
    say $S1

    end
.end
CODE
None
Module
None::Parser
None::Grammar
None::Grammar
OUT

pir_output_is( <<'CODE', <<'OUT', 'one complete start-to-end compiler' );

.namespace [ 'None::Compiler' ]

.sub _main :main
    load_bytecode 'Parrot/HLLCompiler.pbc'
    load_bytecode 'PGE.pbc'
    load_bytecode 'PAST-pm.pbc'

    # These are currently loaded as separate modules, but will move into
    # test file after HLLCompiler is refactored a little more.
    load_bytecode 't/compilers/past-pm/NoneGrammar.pir'
    load_bytecode 't/compilers/past-pm/NoneParser.pir'

    $P0 = new [ 'HLLCompiler' ]
    $P0.'language'('None')
    $P0.'parsegrammar'('NoneParser')
    $P0.'astgrammar'('NoneGrammar')

    .local pmc args
    args = new ResizableStringArray
    push args, "dummy"
    push args, "t/compilers/past-pm/script.source"
    $P1 = $P0.'command_line'(args)

    .return()
.end


CODE
thingy
OUT

pir_output_is( <<'CODE', <<'OUT', 'inserting and removing stages' );
.sub _main :main
    load_bytecode 'Parrot/HLLCompiler.pbc'

    .local pmc hllcompiler
    hllcompiler = new [ 'HLLCompiler' ]

    hllcompiler.removestage('parse')
    hllcompiler.addstage('foo')
    hllcompiler.addstage('bar', 'before' => 'run')
    hllcompiler.addstage('optimize', 'after' => 'past')
    hllcompiler.addstage('optimize', 'after' => 'post')
    hllcompiler.addstage('peel', 'after' => 'optimize')
    $P0 = getattribute hllcompiler, "@stages"
    $S0 = join " ", $P0
    say $S0
    .return()
.end

CODE
past optimize peel post optimize peel pir bar run foo
OUT

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4: