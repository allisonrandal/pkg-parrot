#!./parrot-nqp
# Copyright (C) 2010, Parrot Foundation.

# Checking Ops::Op

pir::load_bytecode("opsc.pbc");

plan(9);

my $op := Ops::Op.new(
    code => 42,
    name => 'set',
    type => 'inline',
    args => <foo bar baz>,
    flags => hash( deprecated => 1, flow => 1 ),
    arg_types => <i i ic>,
);

ok( 1, "Op created");

ok( $op.code == 42,         "... with proper code");
ok( $op.name eq 'set',      "... with proper name");
ok( $op.type eq 'inline',   "... with proper type");
ok( +$op.arg_types == 3,    "... with proper arg_types");
say('# ' ~ $op.arg_types);

ok( $op.full_name eq 'set_i_i_ic', "full_name is correct");
ok( $op.deprecated, "Op is :deprecated");

$op := Ops::Op.new(
    name => 'set',
    type => 'inline',
);
ok( $op.full_name eq 'set', "Argless op's full_name is correct");
ok( !$op.deprecated, "Op is not :deprecated");


# vim: expandtab shiftwidth=4 ft=perl6:
