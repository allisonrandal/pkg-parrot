# $Id: /parrotcode/trunk/languages/regex/t/basic/group.t 470 2006-12-05T03:30:45.414067Z svm  $

use strict;
use FindBin;
use lib "$FindBin::Bin/../../lib";

use Parrot::Test::Regex;
use Regex;
use Regex::Driver;

use Test::More;

Parrot::Test::Regex::run_spec( \*DATA );


__END__
((a*)a)
INPUT:
aaa
OUTPUT:
Match found
0: 0..2
1: 0..2
2: 0..1
INPUT:
xxxaaaxxx
OUTPUT:
Match found
0: 3..5
1: 3..5
2: 3..4
