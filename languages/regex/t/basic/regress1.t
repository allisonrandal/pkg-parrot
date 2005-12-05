# $Id: regress1.t 10005 2005-11-15 22:47:26Z bernhard $

use strict;
use FindBin;
use lib "$FindBin::Bin/../../lib";

use Parrot::Test::Regex;
use Regex;
use Regex::Driver;

use Test::More;

Parrot::Test::Regex::run_spec( \*DATA );


__END__
^(?:r|s)r
INPUT:
r
OUTPUT:
Match failed
