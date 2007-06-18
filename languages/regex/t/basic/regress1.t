# $Id: /parrotcode/trunk/languages/regex/t/basic/regress1.t 470 2006-12-05T03:30:45.414067Z svm  $

use strict;
use FindBin;
use lib "$FindBin::Bin/../../lib";

use Parrot::Test::Regex;
use Regex;
use Regex::Driver;

use Test::More;

Parrot::Test::Regex::run_spec( \*DATA );


__END__
^(?:r|s)r
INPUT:
r
OUTPUT:
Match failed
