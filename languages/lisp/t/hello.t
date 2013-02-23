# $Id: /parrotcode/trunk/languages/lisp/t/hello.t 3466 2007-05-12T12:19:34.157429Z bernhard  $

=head1 NAME

lisp/t/hello.t - tests for Parrot Common Lisp

=head1 DESCRIPTION

A couple of 'Hello World' tests.

=cut

# pragmata
use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../lib", "$FindBin::Bin/../../../lib";

# core Perl modules
use Test::More     tests => 1;

# Parrot modules
use Parrot::Test;

language_output_is( 'Lisp', <<'END_CODE', 'Hello, World!', 'hello 1' );
( print "Hello, World!" )
END_CODE