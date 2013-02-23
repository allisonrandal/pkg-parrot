# $Id: 011_recursion.t 8317 2005-06-12 09:50:50Z bernhard $

use strict;
use FindBin;
use lib "$FindBin::Bin/../../lib", "$FindBin::Bin/../../../../lib";

use Parrot::Test tests => 1 + 1;

my $parrot_m4 = '../../parrot m4.pbc';

{
  language_output_is( 'm4', <<'CODE', <<'OUT', 'hello' );
define(`foo', `bar')
define(`bar', `baz')
asdf
bar
foo
baz
CODE


asdf
baz
baz
baz
OUT
}

SKIP:
{
  skip( "problems with nested strings", 1 );
  my $parrot_out = `$parrot_m4 examples/nesting.m4 2>&1`; 
  is( $parrot_out, << 'OUT', 'default nesting limit' );
Hello
OUT
}
