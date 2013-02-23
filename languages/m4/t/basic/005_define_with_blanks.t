# $Id: /parrotcode/trunk/languages/m4/t/basic/005_define_with_blanks.t 470 2006-12-05T03:30:45.414067Z svm  $

use strict;
use warnings;
use lib qw( lib ../lib ../../lib m4/lib );

use Parrot::Test tests => 5;

{
  language_output_is( 'm4', <<'CODE', <<'OUT', 'two valid defines' );
define( `foo',  `Hello World')
define(`furcht',       `Hallo Welt')
In German foo is furcht.
CODE


In German Hello World is Hallo Welt.
OUT
}

{
  language_output_is( 'm4', <<'CODE', <<'OUT', 'space in substitution' );
define( `foo',  `Hello World ')
define(`furcht',       `Hallo Welt')
In German foo is furcht.
CODE


In German Hello World  is Hallo Welt.
OUT
}

{
  language_output_is( 'm4', <<'CODE', <<'OUT', 'space in substitution 2' );
define( `foo',                       `Hello World ')
define(`furcht',       `Hallo Welt')
In German foo is furcht.
CODE


In German Hello World  is Hallo Welt.
OUT
}

{
  language_output_is( 'm4', <<'CODE', <<'OUT', 'not a macro' );
define ( `foo',                       `Hello World ')
CODE
define ( foo,                       Hello World )
OUT
}

{
  language_output_is( 'm4', <<'CODE', <<'OUT', 'only one macro' );
define ( `foo',                       `Hello World ')
define(`furcht',       `Hallo Welt')
In German foo is furcht.
CODE
define ( foo,                       Hello World )

In German foo is Hallo Welt.
OUT
}
