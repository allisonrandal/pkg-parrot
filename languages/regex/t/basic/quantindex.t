# $Id: /local/languages/regex/t/basic/quantindex.t 11501 2006-02-10T18:27:13.457666Z particle  $

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
