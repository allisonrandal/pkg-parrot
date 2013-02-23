# $Id: /parrotcode/trunk/languages/m4/t/basic/012_eval.t 470 2006-12-05T03:30:45.414067Z svm  $

use strict;
use warnings;
use lib qw( lib ../lib ../../lib m4/lib );

use Parrot::Config;
use Parrot::Test tests => 1; 
use Test::More;

my $real_out;
my $path_to_parrot = Parrot::Test::path_to_parrot();
my $parrot         = "cd $path_to_parrot && .$PConfig{slash}parrot$PConfig{exe}";

$real_out     = `$parrot languages/m4/examples/eval.pir 2>&1`; 
is( $real_out, << 'END_OUT', 'single expression' );
Trying to load shared library 'm4_evaluate'.
Trying to load function 'm4_evaluate'.
Evaluating expression: 1 + 1 * 117
evaluated: 118
END_OUT
