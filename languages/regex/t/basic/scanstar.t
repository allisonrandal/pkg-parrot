# $Id: /parrotcode/trunk/languages/regex/t/basic/scanstar.t 470 2006-12-05T03:30:45.414067Z svm  $

use strict;
use FindBin;
use lib "$FindBin::Bin/../../lib";

use Parrot::Test::Regex;
use Regex;
use Regex::Driver;

use Test::More;

Parrot::Test::Regex::run_spec( \*DATA );


__END__
a*
INPUT:
aaax
OUTPUT:
Match found
0: 0..2
INPUT:
aaa
OUTPUT:
Match found
0: 0..2
INPUT:
xaaa
OUTPUT:
Match found
0: 0..-1
