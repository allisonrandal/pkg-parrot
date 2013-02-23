#! perl
# $Id: /parrotcode/local/languages/scheme/t/io/basic.t 1502 2007-01-22T17:06:21.889089Z chromatic  $

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../..";

use Scheme::Test tests => 2;

output_is( <<'CODE', '0', "basic write" );
(write 0)
CODE

output_is( <<'CODE', '01', "basic write" );
(write 0 1)
CODE

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
