# $Id: /parrotcode/trunk/languages/m4/t/basic/002_hello.t 470 2006-12-05T03:30:45.414067Z svm  $

use strict;
use warnings;
use lib qw( lib ../lib ../../lib m4/lib );

use Parrot::Test tests => 3;

language_output_is( 'm4', <<'CODE', <<'OUT', 'hello language_output_is' );
Hello World!
This m4 input contains no macro calls.
This m4 input contains three empty lines.


This m4 input contains a line with only whitespace.
   			
The last line is empty.

CODE
Hello World!
This m4 input contains no macro calls.
This m4 input contains three empty lines.


This m4 input contains a line with only whitespace.
   			
The last line is empty.

OUT

language_output_like( 'm4', <<'CODE', '/ello/', 'hello language_output_like' );
Hello World!
CODE


language_output_isnt( 'm4', <<'CODE', <<'OUT', 'hello language_output_isnt' );
Hello World!
CODE
Hallo Welt!
OUT
