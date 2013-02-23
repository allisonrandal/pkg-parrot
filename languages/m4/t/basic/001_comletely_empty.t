# $Id: 001_comletely_empty.t 12226 2006-04-14 15:02:50Z bernhard $

use strict;
use warnings;
use lib qw( lib ../lib ../../lib m4/lib );

use Parrot::Test tests => 1;

language_output_is( 'm4', <<'CODE', <<'OUT', 'completely empty' );
CODE
OUT
