# $Id: 017_printerr.t 8317 2005-06-12 09:50:50Z bernhard $

use strict;
use FindBin;
use lib "$FindBin::Bin/../../lib", "$FindBin::Bin/../../../../lib";

use Parrot::Test tests => 1;

# STDERR is not buffered.
# The arguments of errprint are seperated by ' ' when printed
{
  language_output_is( 'm4', <<'CODE', <<'OUT', 'errprint with three args' );
before errprint(   `Should',     `be', `printed on STDERR') after
CODE
Should be printed on STDERRbefore  after
OUT
}