# Copyright (C) 2005, The Perl Foundation.
# $Id: hpux.pm 12827 2006-05-30 02:28:15Z coke $

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
