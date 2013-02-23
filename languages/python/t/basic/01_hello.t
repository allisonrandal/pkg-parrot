# $Id: /local/languages/python/t/basic/01_hello.t 11501 2006-02-10T18:27:13.457666Z particle  $

use strict;
use lib '../../lib';

use Parrot::Test tests => 6;

language_output_is( 'python', <<'CODE', '', 'hello' );
print "hello pie-thon"
CODE

language_output_is( 'python', <<'CODE', '', 'print_i 1' );
print 1
CODE

language_output_is( 'python', <<'CODE', '', 'print_item' );
print "hello", "pie-thon"
CODE

language_output_is( 'python', <<'CODE', '', 'print_i 1, 2' );
print 1, 2
CODE

language_output_is( 'python', <<'CODE', '', 'print_n' );
print 0.1, 0.2
CODE

language_output_is( 'python', <<'CODE', '', 'print_n big' );
print 1.1e4, 2.2e6, 3.3e8, 4.4e10, 5.5e12
CODE
