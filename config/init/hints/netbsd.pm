# Copyright (C) 2006, The Perl Foundation.
# $Id: /local/config/init/hints/netbsd.pm 13278 2006-07-13T13:40:14.092490Z coke  $

package init::hints::netbsd;

use strict;

sub runstep
{
    my ($self, $conf) = @_;

    my $ccflags = $conf->data->get('ccflags');
    if ($ccflags !~ /-pthread/) {
        $ccflags .= ' -pthread';
    }
    $conf->data->set(ccflags => $ccflags);

    my $libs = $conf->data->get('libs');
    if ($libs !~ /-lpthread/) {
        $libs .= ' -lpthread';
    }
    $conf->data->set(libs => $libs);
}

1;
