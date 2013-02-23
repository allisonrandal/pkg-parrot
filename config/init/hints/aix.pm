# Copyright: 2005 The Perl Foundation.  All Rights Reserved.
# $Id: aix.pm 10637 2005-12-24 11:00:22Z jhoblitt $

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
