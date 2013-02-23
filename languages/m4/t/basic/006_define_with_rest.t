# $Id: /parrotcode/trunk/languages/m4/t/basic/006_define_with_rest.t 470 2006-12-05T03:30:45.414067Z svm  $

use strict;
use warnings;
use lib qw( lib ../lib ../../lib m4/lib );

use Parrot::Test tests => 2;

{
  language_output_is( 'm4', <<'CODE', <<'OUT', 'hello' );
define(`foo', `Hello World, heute ist der 15. August')
define(`furcht', `Hallo Welt')sagt regina und fangt Fliegen
In German foo is furcht.
CODE

sagt regina und fangt Fliegen
In German Hello World, heute ist der 15. August is Hallo Welt.
OUT
}
{
  language_output_is( 'm4', <<'CODE', <<'OUT', 'hello' );
:::asdf
define(`foo', `Hello World, heute ist der 15. August')
define(`furcht', `Hallo Welt')sagt regina und fangt Fliegen
In German foo is furcht.
CODE
:::asdf

sagt regina und fangt Fliegen
In German Hello World, heute ist der 15. August is Hallo Welt.
OUT
}
