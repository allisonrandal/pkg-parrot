# Copyright (C) 2005, The Perl Foundation.
# $Id: /local/config/init/hints/aix.pm 12827 2006-05-30T02:28:15.110975Z coke  $

package init::hints::aix;

use strict;

sub runstep
{
    my ($self, $conf) = @_;

    $conf->data->set(
        cc           => 'cc_r',
        link         => 'cc_r',
        platform_asm => 1,
    );
}

1;
