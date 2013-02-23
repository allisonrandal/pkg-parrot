#! ./parrot-nqp
# Copyright (C) 2010-2012, Parrot Foundation.


# "Comprehensive" test for creating PAST for op.
# Parse single op and check various aspects of created PAST.

pir::load_bytecode('opsc.pbc');
pir::load_bytecode('dumper.pbc');

Q:PIR{ .include "test_more.pir" };

my $buf := q|
BEGIN_OPS_PREAMBLE
/*
THE HEADER
*/
END_OPS_PREAMBLE

op bar() {
    /* Nothing here */
}

inline op foo(out INT, in PMC, inconst NUM) :flow :deprecated {
    foo();
}

inline op bar(out PMC) {
    foo();
}

inline op bar(out PMC, in INT) {
    foo();
}


|;
my $compiler := pir::compreg__Ps('Ops');
my $past     := $compiler.compile($buf, target => 'past');
my $trans    := Ops::Trans::C.new;

ok(1, "PAST::Node created");

my $preambles := $past<preamble>;

ok(~$preambles[0] ~~ /HEADER/, 'Header parsed');

my @ops := @($past<ops>);
# One "bar" and two "foo"
is(+@ops, 6, 'We have 6 ops');

my $op := @ops[1];
ok($op.name == 'foo', "Name parsed");

my %flags := $op<flags>;
ok(%flags<flow>, ':flow flag parsed');
ok(%flags<deprecated>, ':deprecated flag parsed');
ok(%flags == 2, "And there are only 2 flags");

# Check op params
my @args := $op<args>;
ok(+@args == 3, "Got 3 parameters");

my $arg;

$arg := @args[0];
ok($arg<direction> eq 'out', 'First direction is correct');
ok($arg<type> eq 'INT', 'First type is correct');

$arg := @args[1];
ok($arg<direction> eq 'in', 'Second direction is correct');
ok($arg<type> eq 'PMC', 'Second type is correct');

$arg := @args[2];
ok($arg<direction> eq 'inconst', 'Third direction is correct');
ok($arg<type> eq 'NUM', 'Third type is correct');

# Check normalization
@args := $op<normalized_args>;
$arg := @args[0];
ok($arg<direction> eq 'o', 'First direction is correct');
ok($arg<type> eq 'i', 'First type is correct');
ok(!($arg<variant>), 'First arg without variant');

$arg := @args[1];
ok($arg<direction> eq 'i', 'Second direction is correct');
ok($arg<type> eq 'p', 'Second type is correct');
ok($arg<variant> eq 'pc', 'Second variant is correct');

$arg := @args[2];
ok($arg<direction> eq 'i', 'Third direction is correct');
ok($arg<type> eq 'nc', 'Third type is correct');
ok(!($arg<variant>), 'Third arg without variant');

ok( ($op.arg_types).join('_') eq 'i_p_nc', "First variant correct");


# Second created op should have _pc_
$op := @ops[2];
ok( $op.arg_types.join('_') eq 'i_pc_nc', "Second variant correct");

# Check body munching.
$op := @ops[0];
ok( $op.get_body($trans) ~~ /'return cur_opcode + 1'/ , "goto NEXT appended for non :flow ops");

# Check write barriers.
ok( !$op.need_write_barrier, "Write Barrier is not required");

$op := @ops[3];
ok( $op.need_write_barrier, "'out PMC' Write Barrier");
$op := @ops[4];
ok( $op.need_write_barrier, "'inout STR' Write Barrier");
$op := @ops[5];
ok( $op.need_write_barrier, "Write Barrier calculated properly");

ok( $op.get_body($trans) ~~ /PARROT_GC_WRITE_BARRIER/, "We have Write Barrier inserted into op");

done_testing();

# Don't forget to update plan!

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=perl6:
