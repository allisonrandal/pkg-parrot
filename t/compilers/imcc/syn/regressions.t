#!perl
# Copyright (C) 2008, Parrot Foundation.
# $Id: regressions.t 36833 2009-02-17 20:09:26Z allison $

use strict;
use warnings;
use lib qw( . lib ../lib ../../lib );
use Test::More;
use Parrot::Test tests => 9;

pir_error_output_like( <<'CODE', <<'OUT', 'invalid get_results syntax');
.sub main :main
    get_results '(0)'
.end
CODE
/syntax error/
OUT

pir_output_is( <<'CODE', <<'OUT', 'cannot constant fold div by 0');
.sub fold_by_zero
  push_eh ok1
    $I1 = 1/0
  pop_eh
  print "not "
 ok1:
  say "ok 1 - caught div_i_ic_ic exception"

  push_eh ok2
    $N1 = 1.0/0.0
  pop_eh
  print "not "
 ok2:
  say "ok 2 - caught div_n_nc_nc exception"
.end
CODE
ok 1 - caught div_i_ic_ic exception
ok 2 - caught div_n_nc_nc exception
OUT

pir_output_is( <<'CODE', <<'OUT', 'comments before .param(RT #46499)');
.sub main :main
  comments(1,2)
.end
.sub comments
  # Testing
  .param pmc a
  .param pmc b
  say 'hello'
.end
CODE
hello
OUT

pir_output_is( <<'CODE', <<'OUT', 'comments between .param(RT #46499)', todo => 'broken');
.sub main :main
  comments(1,2)
.end
.sub comments
  .param pmc a
  # Testing
  .param pmc b
  say 'hello'
.end
CODE
hello
OUT

pir_output_is( <<'CODE', <<'OUT', 'whitespace before .param(RT #46499)');
.sub main :main
  comments(1,2)
.end
.sub comments

  .param pmc a
  .param pmc b
  say 'hello'
.end
CODE
hello
OUT

pir_output_is( <<'CODE', <<'OUT', 'whitespace between .param(RT #46499)', todo => 'broken');
.sub main :main
  comments(1,2)
.end
.sub comments
  .param pmc a

  .param pmc b
  say 'hello'
.end
CODE
hello
OUT

pir_error_output_like( <<'CODE', <<'OUT', 'off by one error message (RT #40204)', todo=>'broken');
.sub foo :main
  $P0 = new 'Hash'
  $P1 = $P0['x']
  unless $P1 goto no
  print "yes\n"
no:
.end
CODE
/(?s:Null PMC access in get_bool.*current instr.*:4\))/
OUT

pir_error_output_like( <<'CODE', <<'OUT', 'bare method names not allowed (RT #45859)');
.sub foo :main
  $P0 = new 'String'
  $P0 = 'HI'
  $P0.lower()
  say $P0
.end
CODE
/Bareword method name 'lower' not allowed/
OUT

pir_error_output_like( <<'CODE', <<'OUT', ':: not allowed in identifiers (RT #48735)');
.sub foo :main
  .local string a::b
  a::b = 'HI' 
  say a::b
.end
CODE
/syntax error/
OUT

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4: