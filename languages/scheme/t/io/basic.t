#! perl -w
# $Id: /local/languages/scheme/t/io/basic.t 11501 2006-02-10T18:27:13.457666Z particle  $

use FindBin;
use lib "$FindBin::Bin/../..";

use Scheme::Test tests => 2;

output_is(<<'CODE', '0', "basic write");
(write 0)
CODE

output_is(<<'CODE', '01', "basic write");
(write 0 1)
CODE
