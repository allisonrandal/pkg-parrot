#! perl -w
# $Id: /local/languages/scheme/t/arith/nested.t 11501 2006-02-10T18:27:13.457666Z particle  $

use FindBin;
use lib "$FindBin::Bin/../..";

use Scheme::Test tests => 8;

###
### Add
###

output_is(<<'CODE', 12, 'write (+ (+ 5 7))');
(write (+ (+ 5 7)))
CODE

output_is(<<'CODE', 11, 'write (+ (+ 3 -1) (+ 2 7))');
(write (+ (+ 3 -1) (+ 2 7)))
CODE

###
### Subtract
###

output_is(<<'CODE', 2, 'write (- (- 5 7))');
(write (- (- 5 7)))
CODE

output_is(<<'CODE', 9, 'write (- (- 3 -1) (- 2 7))');
(write (- (- 3 -1) (- 2 7)))
CODE

###
### Multiply
###

output_is(<<'CODE', 35, 'write (* (* 5 7))');
(write (* (* 5 7)))
CODE

output_is(<<'CODE', -42, 'write (* (* 3 -1) (* 2 7))');
(write (* (* 3 -1) (* 2 7)))
CODE

###
### Divide
###

###
### Abs
###

output_is(<<'CODE', 8, 'abs (+ 3 5)');
(write (abs (+ 3 5)))
CODE

output_is(<<'CODE', 2, 'abs (- 3 5)');
(write (abs (- 3 5)))
CODE
