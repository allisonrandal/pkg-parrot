# $Id: /local/languages/regex/t/basic/a.t 11501 2006-02-10T18:27:13.457666Z particle  $

use strict;
use FindBin;
use lib "$FindBin::Bin/../../lib";

use Parrot::Test::Regex;
use Regex;
use Regex::Driver;

use Test::More;

Parrot::Test::Regex::run_spec( \*DATA );

__END__
a
INPUT:
aa
OUTPUT:
Match found
0: 0..0
INPUT:
xxxaa
OUTPUT:
Match found
0: 3..3
INPUT:
xyz
OUTPUT:
Match failed
