# $Id: infinite.t 10034 2005-11-16 20:38:30Z bernhard $

use strict;
use FindBin;
use lib "$FindBin::Bin/../../lib";

use Parrot::Test::Regex;
use Regex;
use Regex::Driver;

use Test::More  skip_all => 'memory is exhausted';


# Parrot::Test::Regex::run_spec( \*DATA );


__END__
(a?)*
INPUT:
bbb
OUTPUT:
Match found
0: 0..-1
1: 0..-1
