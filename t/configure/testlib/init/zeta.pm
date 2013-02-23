# Copyright (C) 2001-2003, Parrot Foundation.
# $Id: zeta.pm 36833 2009-02-17 20:09:26Z allison $

=head1 NAME

t/configure/testlib/init/zeta.pm - Module used in configuration tests

=cut

package init::zeta;
use strict;
use warnings;

use base qw(Parrot::Configure::Step);

sub _init {
    my $self = shift;
    my %data;
    $data{description} = q{Determining if your computer does zeta};
    $data{args}        = [ qw( ) ];
    $data{result}      = q{};
    return \%data;
}

my $result = q|Goodbye, cruel world|;

sub runstep {
    my ( $self, $conf ) = @_;
    $self->set_result($result);
    return;
}

1;

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
