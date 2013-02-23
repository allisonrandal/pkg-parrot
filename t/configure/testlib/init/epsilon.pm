# Copyright (C) 2001-2003, Parrot Foundation.
# $Id: epsilon.pm 42766 2009-11-21 19:19:43Z jkeenan $

=head1 NAME

t/configure/testlib/init/epsilon.pm - Module used in configuration tests

=head1 DESCRIPTION

Nonsense module used only in testing the configuration system.

=cut

package init::epsilon;
use strict;
use warnings;

use base qw(Parrot::Configure::Step);

sub _init {
    my $self = shift;
    my %data;
    $data{description} = q{Determining if your computer does epsilon};
    $data{args}        = [ qw( ) ];
    $data{result}      = q{};
    return \%data;
}

sub runstep {
    my ( $self, $conf ) = @_;
}

1;

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
