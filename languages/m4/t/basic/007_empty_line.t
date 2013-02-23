# $Id: /local/languages/m4/t/basic/007_empty_line.t 12226 2006-04-14T15:02:50.254463Z bernhard  $

use strict;
use warnings;
use lib qw( lib ../lib ../../lib m4/lib );

use Parrot::Test tests => 1;

language_output_is( 'm4', <<'CODE', <<'OUT', 'hello' );

Hello World



Hallo Welt
CODE

Hello World



Hallo Welt
OUT
