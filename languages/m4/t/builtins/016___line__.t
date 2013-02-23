# $Id: /local/languages/m4/t/builtins/016___line__.t 12226 2006-04-14T15:02:50.254463Z bernhard  $

use strict;
use warnings;
use lib qw( lib ../lib ../../lib m4/lib );

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
