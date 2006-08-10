# Copyright (C) 2005, The Perl Foundation.
# $Id: /local/config/init/hints/hpux.pm 12827 2006-05-30T02:28:15.110975Z coke  $

package init::hints::hpux;

use strict;

sub runstep
{
    my ($self, $conf) = @_;

    my $libs = $conf->data->get('libs');
    if ($libs !~ /-lpthread/) {
        $libs .= ' -lpthread';
    }

    $conf->data->set(libs => $libs);
}

1;
