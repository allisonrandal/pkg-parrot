# $Id: /parrotcode/trunk/languages/m4/t/builtins/012_undefine.t 470 2006-12-05T03:30:45.414067Z svm  $

use strict;
use warnings;
use lib qw( lib ../lib ../../lib m4/lib );

use Parrot::Test tests => 1;

{
  language_output_is( 'm4', <<'CODE', <<'OUT', 'simple define' );
define(`foo', `Hello World')
define(`furcht', `Hallo Welt')
undefine(  `foo')
In German foo is furcht.
CODE



In German foo is Hallo Welt.
OUT
}
