# $Id: 002_define.t 8317 2005-06-12 09:50:50Z bernhard $

use strict;
use FindBin;
use lib "$FindBin::Bin/../../lib", "$FindBin::Bin/../../../../lib";

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
