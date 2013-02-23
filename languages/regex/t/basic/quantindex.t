# $Id: /parrotcode/trunk/languages/regex/t/basic/quantindex.t 470 2006-12-05T03:30:45.414067Z svm  $

use strict;
use FindBin;
use lib "$FindBin::Bin/../../lib";

use Parrot::Test::Regex;
use Regex;
use Regex::Driver;

use Test::More;

Parrot::Test::Regex::run_spec( \*DATA );


__END__
(a)+
INPUT:
aaa
OUTPUT:
Match found
0: 0..2
1: 2..2
INPUT:
aa
OUTPUT:
Match found
0: 0..1
1: 1..1
INPUT:
aab
OUTPUT:
Match found
0: 0..1
1: 1..1
INPUT:
a
OUTPUT:
Match found
0: 0..0
1: 0..0
INPUT:
b
OUTPUT:
Match failed
