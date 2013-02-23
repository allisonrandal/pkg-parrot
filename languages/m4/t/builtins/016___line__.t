# $Id: 016___line__.t 8317 2005-06-12 09:50:50Z bernhard $

use strict;
use FindBin;
use lib "$FindBin::Bin/../../lib", "$FindBin::Bin/../../../../lib";

use Parrot::Test tests => 1;

SKIP:
{
  skip( "builtin macro __line__ is not implemented yet", 1 );
  language_output_is( 'm4', <<'CODE', <<'OUT', '__line__' );
1
2
__line__
4
CODE
1
2
3
4
OUT
}