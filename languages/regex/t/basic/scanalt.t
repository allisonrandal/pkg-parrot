# $Id: /local/languages/regex/t/basic/scanalt.t 11501 2006-02-10T18:27:13.457666Z particle  $

use strict;
use FindBin;
use lib "$FindBin::Bin/../../lib";

use Parrot::Test::Regex;
use Regex;
use Regex::Driver;

use Test::More;

Parrot::Test::Regex::run_spec( \*DATA );


__END__
a|b
INPUT:
a
OUTPUT:
Match found
0: 0..0
INPUT:
baa baa black sheep
OUTPUT:
Match found
0: 0..0
INPUT:
zebra
OUTPUT:
Match found
0: 2..2
INPUT:
hello
OUTPUT:
Match failed
