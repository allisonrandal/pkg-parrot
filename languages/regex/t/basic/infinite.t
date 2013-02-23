# $Id: /local/languages/regex/t/basic/infinite.t 11501 2006-02-10T18:27:13.457666Z particle  $

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
