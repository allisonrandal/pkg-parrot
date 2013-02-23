# $Id: 005_substr.t 8317 2005-06-12 09:50:50Z bernhard $

use strict;
use FindBin;
use lib "$FindBin::Bin/../../lib", "$FindBin::Bin/../../../../lib";

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

