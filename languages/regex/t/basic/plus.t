# $Id: /parrotcode/trunk/languages/regex/t/basic/plus.t 470 2006-12-05T03:30:45.414067Z svm  $

use strict;
use FindBin;
use lib "$FindBin::Bin/../../lib";

use Parrot::Test::Regex;
use Regex;
use Regex::Driver;

use Test::More;

Parrot::Test::Regex::run_spec( \*DATA );


__END__
a+
INPUT:
x
OUTPUT:
Match failed
INPUT:
a
OUTPUT:
Match found
0: 0..0
INPUT:
aaaaax
OUTPUT:
Match found
0: 0..4
INPUT:
aaaaa
OUTPUT:
Match found
0: 0..4
INPUT:
yaaaaaay!!!
OUTPUT:
Match found
0: 1..6
