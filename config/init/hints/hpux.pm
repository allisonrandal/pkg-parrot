# Copyright (C) 2005, The Perl Foundation.
# $Id: hpux.pm 16144 2006-12-17 18:42:49Z paultcochrane $

package init::hints::hpux;

use strict;
use warnings;

sub runstep {
    my ( $self, $conf ) = @_;

    my $libs = $conf->data->get('libs');
    if ( $libs !~ /-lpthread/ ) {
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
