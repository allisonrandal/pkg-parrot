# $Id: /parrotcode/trunk/languages/m4/t/builtins/013_ifdef.t 470 2006-12-05T03:30:45.414067Z svm  $

use strict;
use warnings;
use lib qw( lib ../lib ../../lib m4/lib );

use Parrot::Test tests => 1;

{
  language_output_is( 'm4', <<'CODE', <<'OUT', 'simple define' );
define(`foo', `Hello World')
ifdef(`foo', `f o o is defined', `f o o is not defined')
ifdef(`foo2', `f o o 2 is defined', `f o o 2 is not defined')
CODE

f o o is defined
f o o 2 is not defined
OUT
}
