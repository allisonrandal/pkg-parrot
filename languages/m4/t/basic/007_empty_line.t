# $Id: 007_empty_line.t 8317 2005-06-12 09:50:50Z bernhard $

use strict;
use FindBin;
use lib "$FindBin::Bin/../../lib", "$FindBin::Bin/../../../../lib";

use Parrot::Test tests => 1;

language_output_is( 'm4', <<'CODE', <<'OUT', 'hello' );

Hello World



Hallo Welt
CODE

Hello World



Hallo Welt
OUT