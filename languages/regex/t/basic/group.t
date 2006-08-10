# $Id: /local/languages/regex/t/basic/group.t 11501 2006-02-10T18:27:13.457666Z particle  $

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
