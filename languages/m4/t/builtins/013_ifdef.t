# $Id: 013_ifdef.t 8317 2005-06-12 09:50:50Z bernhard $

use strict;
use FindBin;
use lib "$FindBin::Bin/../../lib", "$FindBin::Bin/../../../../lib";

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