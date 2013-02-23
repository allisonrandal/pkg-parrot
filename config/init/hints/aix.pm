# Copyright (C) 2005, The Perl Foundation.
# $Id: aix.pm 12827 2006-05-30 02:28:15Z coke $

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
