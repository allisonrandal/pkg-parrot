=head1 NAME

js -- A compiler for js ECMAScript-262

=head1 SYNOPSIS

  $ ./parrot languages/emcascript/js.pir script.js

=head1 DESCRIPTION

js is a compiler for ECMAScript-262, running on Parrot. Its parser is
a PGE grammar (a subclass of PGE::Grammar). The compilation is a series of
tree transformations using TGE: from match tree to abstract syntax tree
(AST), from AST to opcode syntax tree (OST), and finally from OST to
bytecode (actually to PIR, at first).

=cut
.HLL 'js', 'js_group'
.include 'errors.pasm'
.include 'library/dumper.pir'

.sub _main :main
    .param pmc args
    
    errorson .PARROT_ERRORS_PARAM_COUNT_FLAG
    
    load_bytecode 'PGE.pbc'
    load_bytecode 'dumper.pbc'
    load_bytecode 'PGE/Dumper.pbc'
    load_bytecode 'PGE/Text.pbc'
    load_bytecode 'Getopt/Obj.pbc'
    
    print "Hello World from JS\n"
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4: