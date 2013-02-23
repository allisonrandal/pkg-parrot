# Copyright (C) 2006-2008, Parrot Foundation.
# $Id: 01-sub.pir 36833 2009-02-17 20:09:26Z allison $

=for doc

The PAST that is set up in this example
roughly represents following Perl 6 code:

    sub foo
    {
        my $a = 4;
        my $b = $a + 1;
	say($b);
    }

=cut

.include "library/dumper.pir"

.namespace []

.sub '__onload' :init
    load_bytecode 'PGE.pbc'
    load_bytecode 'PGE/Text.pbc'
    load_bytecode 'PGE/Util.pbc'
    load_bytecode 'PGE/Dumper.pbc'
    load_bytecode 'PCT.pbc'
.end

.sub 'main' :main
    .param pmc args

    .local pmc block
    block = new ['PAST';'Block']
    block.'init'( 'blocktype' => 'declaration', 'name' => 'foo' )
    block.'symbol'( '$a', 'scope' => 'lexical' )
    block.'symbol'( '$b', 'scope' => 'lexical' )

    .local pmc stmts
    stmts = new ['PAST';'Stmts']
    stmts.'init'()
    stmts.'attr'( 'source', 'my $a = 4; my $b = $a + 1; say( $b );', 1 )
    block.'push'(stmts)

    # $a = 4
    $P0 = new ['PAST';'Val']
    $P0.'init'( 'value' => '4', 'returns' => 'Integer' )
    $P0.'attr'( 'source', '4', 1 )
    $P1 = new ['PAST';'Var']
    $P1.'init'( 'name' => '$a', 'viviself' => 'Undef', 'isdecl' => 1 )
    $P1.'attr'( 'source', '$a', 1 )
    $P2 = new ['PAST';'Op']
    $P2.'init'( $P1, $P0, 'pasttype' => 'copy', 'name' => 'infix:=', 'lvalue' => 1 )
    $P2.'attr'( 'source', '=', 1 )
    stmts.'push'($P2)

    # $b = $a + 1
    $P0 = new ['PAST';'Var']
    $P0.'init'( 'name' => '$a', 'viviself' => 'Undef' )
    $P1 = new ['PAST';'Val']
    $P1.'init'( 'value' => '1', 'returns' => 'Integer')
    $P2 = new ['PAST';'Op']
    $P2.'init'( $P0, $P1, 'name' => 'infix:+', 'pirop' => 'add')
    $P3 = new ['PAST';'Var']
    $P3.'init'( 'name' => '$b', 'viviself' => 'Undef', 'isdecl' => 1 )
    $P4 = new ['PAST';'Op']
    $P4.'init'( $P3, $P2, 'name' => 'infix:=', 'pasttype' => 'copy')
    $P4.'attr'( 'source', '=', 1 )
    stmts.'push'($P4)

    # say($b)
    $P0 = new ['PAST';'Var']
    $P0.'init'( 'name' => '$b' )
    $P1 = new ['PAST';'Op']
    $P1.'init'( $P0, 'name' => 'say', 'pasttype' => 'call' )
    stmts.'push'($P1)

    # set up compiler, preliminary stages are removed because we
    # already have a PAST data structure
    .local pmc astcompiler
    astcompiler = new [ 'PCT';'HLLCompiler' ]
    astcompiler.'removestage'('parse')
    astcompiler.'removestage'('past')

=for development

    # _dumper( block, 'block' )

    # compile to PIR and display
    $S99 = astcompiler.'compile'(block, 'target' => 'pir')
    print $S99

=cut

    #compile to bytecode and execute
    $P99 = astcompiler.'compile'(block)
    $P99()
.end


.sub 'say'
    .param pmc args :slurpy
    if null args goto end
    .local pmc iter
    iter = new 'Iterator', args
  loop:
    unless iter goto end
    $P0 = shift iter
    print $P0
    goto loop
  end:
    print "\n"
    .return ()
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir: