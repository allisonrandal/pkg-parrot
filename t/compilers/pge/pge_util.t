#! perl
# Copyright (C) 2001-2007, Parrot Foundation.
# $Id: pge_util.t 38705 2009-05-11 22:13:04Z NotFound $

use strict;
use warnings;
use lib qw( t . lib ../lib ../../lib );
use Test::More;
use Parrot::Test tests => 8;
use Parrot::Test::PGE;

=head1 NAME

t/library/pge_util.t - Parrot Grammar Engine tests of utility rules

=head1 SYNOPSIS

        % prove -Ilib t/library/pge_util.t

=cut

my $str = "How will this\nstring choose\nto explode?\n\nTest";
p6rule_error_like(
    $str,
    "expl <PGE::Util::die: 'kaboom'>",
    qr/^kaboom at line 3, near "ode\?\\n\\n/, "die"
);

pir_output_is( <<'CODE', <<'OUT', "split /\\:+/, 'Foo::Bar::baz'" );

.sub main :main
  load_bytecode 'PGE.pbc'
  load_bytecode 'PGE/Util.pbc'

  .local pmc split, p6rule, regex
  split  = get_global ['PGE';'Util'], 'split'
  p6rule = compreg 'PGE::Perl6Regex'
  regex  = p6rule('\:+')

  $P0 = split(regex, "Foo::Bar::baz")
  $S0 = join "\n", $P0
  print $S0
  print "\n"
.end

CODE
Foo
Bar
baz
OUT

pir_output_is( <<'CODE', <<'OUT', "split /\\:+/, 'Foo::'" );

.sub main :main
  load_bytecode 'PGE.pbc'
  load_bytecode 'PGE/Util.pbc'

  .local pmc split, p6rule, regex
  split  = get_global ['PGE';'Util'], 'split'
  p6rule = compreg 'PGE::Perl6Regex'
  regex  = p6rule('\:+')

  $P0 = split(regex, "Foo::")
  $S0 = join "\n", $P0
  print $S0
  print "\n"
.end

CODE
Foo
OUT

pir_output_is( <<'CODE', <<'OUT', "split /\\:+/, '::Foo'" );

.sub main :main
  load_bytecode 'PGE.pbc'
  load_bytecode 'PGE/Util.pbc'

  .local pmc split, p6rule, regex
  split  = get_global ['PGE';'Util'], 'split'
  p6rule = compreg 'PGE::Perl6Regex'
  regex  = p6rule('\:+')

  $P0 = split(regex, "::Foo")
  $S0 = join "\n", $P0
  print $S0
  print "\n"
.end

CODE

Foo
OUT

pir_output_is( <<'CODE', <<'OUT', "split /\\:+/, 'Foo'" );

.sub main :main
  load_bytecode 'PGE.pbc'
  load_bytecode 'PGE/Util.pbc'

  .local pmc split, p6rule, regex
  split  = get_global ['PGE';'Util'], 'split'
  p6rule = compreg 'PGE::Perl6Regex'
  regex  = p6rule('\:+')

  $P0 = split(regex, "Foo")
  $S0 = join "\n", $P0
  print $S0
  print "\n"
.end

CODE
Foo
OUT

pir_output_is( <<'CODE', <<'OUT', "split /\\:/, 'Foo::Bar'" );

.sub main :main
  load_bytecode 'PGE.pbc'
  load_bytecode 'PGE/Util.pbc'

  .local pmc split, p6rule, regex
  split  = get_global ['PGE';'Util'], 'split'
  p6rule = compreg 'PGE::Perl6Regex'
  regex  = p6rule('\:')

  $P0 = split(regex, "Foo::Bar")
  $S0 = join "\n", $P0
  print $S0
  print "\n"
.end

CODE
Foo

Bar
OUT

pir_output_is( <<'CODE', <<'OUT', "split /\\:/, 'Foo::Bar::Baz', 2" );

.sub main :main
  load_bytecode 'PGE.pbc'
  load_bytecode 'PGE/Util.pbc'

  .local pmc split, p6rule, regex
  split  = get_global ['PGE';'Util'], 'split'
  p6rule = compreg 'PGE::Perl6Regex'
  regex  = p6rule('\:+')

  $P0 = split(regex, "Foo::Bar::Baz", 2)
  $S0 = join "\n", $P0
  print $S0
  print "\n"
.end

CODE
Foo
Bar::Baz
OUT

pir_output_is( <<'CODE', <<'OUT', "split /(a)(b)/, 'abracadabra'" );

.sub main :main
  load_bytecode 'PGE.pbc'
  load_bytecode 'PGE/Util.pbc'

  .local pmc split, p6rule, regex
  split  = get_global ['PGE';'Util'], 'split'
  p6rule = compreg 'PGE::Perl6Regex'
  regex  = p6rule('(a)(b)')

  $P0 = split(regex, "abracadabra")
  $S0 = join "-", $P0
  print $S0
  print "\n"
.end

CODE
-a-b-racad-a-b-ra
OUT

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
