# $Id: /local/languages/m4/t/builtins/017_printerr.t 12226 2006-04-14T15:02:50.254463Z bernhard  $

use strict;
use warnings;
use lib qw( lib ../lib ../../lib m4/lib );

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
