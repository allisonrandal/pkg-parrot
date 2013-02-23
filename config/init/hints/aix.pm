# Copyright (C) 2005, The Perl Foundation.
# $Id: /parrotcode/local/config/init/hints/aix.pm 733 2006-12-17T23:24:17.491923Z chromatic  $

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
