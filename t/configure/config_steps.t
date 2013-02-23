#!perl
# Copyright (C) 2001-2005, The Perl Foundation.
# $Id: /parrotcode/local/t/configure/config_steps.t 733 2006-12-17T23:24:17.491923Z chromatic  $

use strict;
use warnings;

use lib qw( . lib ../lib ../../lib );

use Test::More;
use File::Find;

=head1 NAME

t/configure/config_steps.t - tests step modules under the config dir

=head1 SYNOPSIS

    prove t/configure/config_steps.t

=head1 DESCRIPTION

Regressions tests for configure steps that live under the config directory.

=cut

my @steps;
sub wanted { /^.*\.pm\z/s && push @steps, $File::Find::name; }
find( { wanted => \&wanted }, 'config' );

if ( $^O !~ /win32/i ) {
    @steps = grep { $_ !~ /win32/i } @steps;
}

plan tests => scalar @steps;
foreach my $step (@steps) {
    require_ok($step);
}

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
