#!perl
# Copyright (C) 2006-2007, The Perl Foundation.
# $Id: /parrotcode/trunk/t/op/load_bytecode.t 3479 2007-05-14T01:12:54.049559Z chromatic  $

use strict;
use warnings;
use lib qw( . lib ../lib ../../lib );
use Test::More;
use Parrot::Test tests => 2;

=head1 NAME

t/op/load_bytecode.t - loading bytecode tests

=head1 SYNOPSIS

        % prove t/op/load_bytecode.t

=head1 DESCRIPTION

Tests the C<load_bytecode> operation.

=cut

pir_error_output_like( <<'CODE', <<'OUTPUT', "load_bytecode on directory" );
.sub main :main
    load_bytecode 't'
.end
CODE
/t' is a directory/
OUTPUT

pir_error_output_like( <<'CODE', <<'OUTPUT', "load_bytecode on non-existent file" );
.sub main :main
        load_bytecode 'no_file_by_this_name'
.end
CODE
/"load_bytecode" couldn't find file 'no_file_by_this_name'/
OUTPUT

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
