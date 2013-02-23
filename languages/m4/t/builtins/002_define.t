# $Id: /parrotcode/trunk/languages/m4/t/builtins/002_define.t 470 2006-12-05T03:30:45.414067Z svm  $

use strict;
use warnings;
use lib qw( lib ../lib ../../lib m4/lib );

use Parrot::Test tests => 1;

# define
{
  language_output_is( 'm4', <<'CODE', <<'OUT', 'hello' );
define(`foo', `Hello World')
define(`furcht', `Hallo Welt')
In German foo is furcht.
CODE


In German Hello World is Hallo Welt.
OUT
}

