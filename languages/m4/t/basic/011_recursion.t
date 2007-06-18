# $Id: /parrotcode/trunk/languages/m4/t/basic/011_recursion.t 470 2006-12-05T03:30:45.414067Z svm  $

use strict;
use warnings;
use lib qw( lib ../lib ../../lib m4/lib );

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
