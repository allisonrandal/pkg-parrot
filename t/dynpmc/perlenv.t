#!perl
# Copyright (C) 2006, The Perl Foundation.
# $Id: perlenv.t 12937 2006-06-14 06:57:39Z fperrad $

use strict;
use warnings;
use lib qw( . lib ../lib ../../lib );

use Test::More;
use Parrot::Test;

=head1 NAME

t/dynpmc/perlenv.t - test the PerlEnv PMC


=head1 SYNOPSIS

    % prove t/dynpmc/perlenv.t

=head1 DESCRIPTION

Tests the PerlEnv PMC.

=cut

my $load_perl = <<'END_PASM';
    loadlib P20, 'perl_group'
    find_type I22, 'PerlEnv'
END_PASM


pir_output_is(<<"CODE", <<'OUT', 'new');
.sub 'test' :main
$load_perl
    new P0, I22
    print "ok 1\\n"
.end
CODE
ok 1
OUT


# remember to change the number of tests :-)
BEGIN { plan tests => 1; }
