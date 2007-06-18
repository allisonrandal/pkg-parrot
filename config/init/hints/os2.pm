# Copyright (C) 2005, The Perl Foundation.
# $Id: /parrotcode/local/config/init/hints/os2.pm 733 2006-12-17T23:24:17.491923Z chromatic  $

package init::hints::os2;

use strict;
use warnings;

sub runstep {
    my ( $self, $conf ) = @_;

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
        perl     => "perl"                                            # avoids case-mangling in make
    );
}

1;

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
