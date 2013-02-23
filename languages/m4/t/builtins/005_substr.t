# $Id: /parrotcode/trunk/languages/m4/t/builtins/005_substr.t 470 2006-12-05T03:30:45.414067Z svm  $

use strict;
use warnings;
use lib qw( lib ../lib ../../lib m4/lib );

use Parrot::Test tests => 4;

{
  language_output_is( 'm4', <<'CODE', <<'OUT', 'substring at end of string' );
substr(`012345SUB', `6')
CODE
SUB
OUT
}

{
  language_output_is( 'm4', <<'CODE', <<'OUT', 'substring in middle of string' );
substr(`012345SUB', `0')
CODE
012345SUB
OUT
}

{
  language_output_is( 'm4', <<'CODE', <<'OUT', 'substring in middle of string' );
substr(`012345SUB', `1', `1')
CODE
1
OUT
}

{
  language_output_is( 'm4', <<'CODE', <<'OUT', 'substring in middle of string' );
substr(`012345SUB', `1', `2')
CODE
12
OUT
}

