# Copyright (C) 2005, Parrot Foundation.
# $Id: hpux.pm 40811 2009-08-26 04:57:21Z dukeleto $

package init::hints::hpux;

use strict;
use warnings;

sub runstep {
    my ( $self, $conf ) = @_;

    my $libs = $conf->data->get('libs');
    if ( $libs !~ /-lpthread\b/ ) {
        $libs .= ' -lpthread';
    }

    $conf->data->set( libs => $libs );
}

1;

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
