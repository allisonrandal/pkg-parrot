# Copyright (C) 2005, The Perl Foundation.
# $Id: /local/config/init/hints/os2.pm 12827 2006-05-30T02:28:15.110975Z coke  $

package init::hints::os2;

use strict;

sub runstep
{
    my ($self, $conf) = @_;

    # This hints file is very specific to a particular os/2 configuration.
    # A more general one would be appreciated, should anyone actually be
    # using OS/2
    $conf->data->set(
        libs     => "-lm -lsocket -lcExt -lbsd",
        iv       => "long",
        nv       => "double",
        opcode_t => "long",
        ccflags  => "-I. -fno-strict-aliasing -mieee-fp -I./include",
        ldflags  => "-Zexe",
        perl     => "perl"                                              # avoids case-mangling in make
    );
}

1;
