# Copyright (C) 2005, The Perl Foundation.
# $Id: /local/config/init/hints/openbsd.pm 12827 2006-05-30T02:28:15.110975Z coke  $

package init::hints::openbsd;

use strict;
use Config;

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

	if ((split('-', $Config{archname}))[0] eq 'powerpc') {
		$conf->data->set(as => 'as -mregnames');
	}

}

1;
