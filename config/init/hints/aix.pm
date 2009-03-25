# Copyright (C) 2005, Parrot Foundation.
# $Id: aix.pm 37201 2009-03-08 12:07:48Z fperrad $

package init::hints::aix;

use strict;
use warnings;

sub runstep {
    my ( $self, $conf ) = @_;

    $conf->data->set(
        cc           => 'cc_r',
        link         => 'cc_r',
        platform_asm => 1,
    );
}

1;

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
