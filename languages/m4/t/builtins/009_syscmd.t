# $Id: 009_syscmd.t 12226 2006-04-14 15:02:50Z bernhard $

use strict;
use warnings;
use lib qw( lib ../lib ../../lib m4/lib );

use Parrot::Test tests => 1;

{
  language_output_is( 'm4', <<'CODE', <<'OUT', 'substring in middle of string' );
syscmd(`touch /tmp/touched_by_Parrot_m4')
CODE

OUT
}
