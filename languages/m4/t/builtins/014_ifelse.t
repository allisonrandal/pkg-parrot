# $Id: /local/languages/m4/t/builtins/014_ifelse.t 12226 2006-04-14T15:02:50.254463Z bernhard  $

use strict;
use warnings;
use lib qw( lib ../lib ../../lib m4/lib );

use Parrot::Test tests => 1;

{
  language_output_is( 'm4', <<'CODE', <<'OUT', 'simple define' );
ifelse(`equal', `equal', `the first two arguments are equal', `the first two arguments are not equal')
ifelse(`not_equal', `not equal', `the first two arguments are equal', `the first two arguments are not equal')
ifelse(
This 
is
a 
multi 
line 
comment
)no comment
CODE
the first two arguments are equal
the first two arguments are not equal
no comment
OUT
}
