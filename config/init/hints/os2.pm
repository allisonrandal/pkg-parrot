# Copyright: 2005 The Perl Foundation.  All Rights Reserved.
# $Id: os2.pm 10637 2005-12-24 11:00:22Z jhoblitt $

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
