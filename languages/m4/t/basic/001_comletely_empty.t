# $Id: /parrotcode/trunk/languages/m4/t/basic/001_comletely_empty.t 470 2006-12-05T03:30:45.414067Z svm  $

use strict;
use warnings;
use lib qw( lib ../lib ../../lib m4/lib );

use Parrot::Test tests => 1;

language_output_is( 'm4', <<'CODE', <<'OUT', 'completely empty' );
CODE
OUT
