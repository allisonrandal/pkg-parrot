# $Id: literal.t 10005 2005-11-15 22:47:26Z bernhard $

use strict;
use FindBin;
use lib "$FindBin::Bin/../../lib";

use Parrot::Test::Regex;
use Regex;
use Regex::Driver;

use Test::More;

Parrot::Test::Regex::run_spec( \*DATA );


__END__
abc
INPUT:
ababc
OUTPUT:
Match found
0: 2..4