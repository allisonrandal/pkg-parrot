# Copyright (C) 2008, Parrot Foundation.
# $Id: nto.pm 36833 2009-02-17 20:09:26Z allison $

package init::hints::nto;

use strict;
use warnings;

sub runstep {
    my ( $self, $conf ) = @_;

    $conf->data->set( memalign => 'posix_memalign' );
}

1;

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4: