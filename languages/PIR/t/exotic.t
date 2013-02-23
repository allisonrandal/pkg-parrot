#!perl

use strict;
use warnings;
use lib qw(t . lib ../lib ../../lib ../../../lib);
use Parrot::Test tests => 4;
use Test::More;

# I have never seen this syntax *anywhere*...
# 
# 
#

language_output_is( 'PIR_PGE', <<'CODE', <<'OUT', '' );
.sub main			
	
	x = y[0 .. 1]
	x = y[.. 1]
	x = y[1 ..]
	x = y[x,y;x,y]	

.end
CODE
"parse" => PMC 'PIR::Grammar' { ... }
Parse successful!
OUT

language_output_is( 'PIR_PGE', <<'CODE', <<'OUT', '' );

.sub main			
	x->hello()
	x->'hello'()
.end

CODE
"parse" => PMC 'PIR::Grammar' { ... }
Parse successful!
OUT

language_output_is( 'PIR_PGE', <<'CODE', <<'OUT', '' );
.sub main			


.end
CODE
"parse" => PMC 'PIR::Grammar' { ... }
Parse successful!
OUT

language_output_is( 'PIR_PGE', <<'CODE', <<'OUT', '' );
.sub main			


.end
CODE
"parse" => PMC 'PIR::Grammar' { ... }
Parse successful!
OUT