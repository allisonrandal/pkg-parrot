# $Id: /parrotcode/trunk/languages/m4/t/basic/008_two_tests.t 470 2006-12-05T03:30:45.414067Z svm  $

use strict;
use warnings;
use lib qw( lib ../lib ../../lib m4/lib );

use Parrot::Test tests => 2;

language_output_is( 'm4', <<'CODE', <<'OUT', 'hello' );
Hello World
Hallo Welt
CODE
Hello World
Hallo Welt
OUT


language_output_is( 'm4', <<'CODE', <<'OUT', 'hello' );
Hello Earth
Hallo Erde
CODE
Hello Earth
Hallo Erde
OUT
