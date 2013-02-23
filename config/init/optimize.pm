# Copyright (C) 2001-2010, Parrot Foundation.
# $Id: optimize.pm 44649 2010-03-05 16:20:00Z tene $

=head1 NAME

config/init/optimize.pm - Optimization

=head1 DESCRIPTION

Enables optimization by adding the appropriate flags for the local platform to
the C<CCFLAGS>. Should this be part of config/inter/progs.pm ? XXX

=cut

package init::optimize;

use strict;
use warnings;

use base qw(Parrot::Configure::Step);

sub _init {
    my $self = shift;
    return {
        'description', 'Enable optimization',
        'result',      '',
    };
}

our $verbose;

sub runstep {
    my ( $self, $conf ) = @_;

    $verbose = $conf->options->get( 'verbose' );
    print "\n" if $verbose;

    print "(optimization options: init::optimize)\n"
        if $verbose;

    # A plain --optimize means use perl5's $Config{optimize}.  If an argument
    # is given, however, use that instead.
    my $optimize = $conf->options->get('optimize');

    if (! defined $optimize) {
        $self->set_result('no');
        print "(none requested) " if $conf->options->get('verbose');
        return 1;
    }

    $self->set_result('yes');
    my $gccversion = $conf->data->get( 'gccversion' );

    my $options;
    if ( $optimize eq "1" ) {
        # start with perl5's flags ...
        $options = $conf->data->get('optimize_provisional');

        # ... but gcc 4.1 doesn't like -mcpu=xx, i.e. it's deprecated
        if ( defined $gccversion and $gccversion > 3.3 ) {
            $options =~ s/-mcpu=/-march=/;
        }
    }
    else {
        # use the command line verbatim
        $options = $optimize;
    }

    # save the options, however we got them.
    $conf->data->set( optimize => $options );
    print "optimize options: ", $options, "\n" if $verbose;

    # disable debug flags.
    $conf->data->set( cc_debug => '' );
    $conf->data->add( ' ', ccflags => "-DDISABLE_GC_DEBUG=1 -DNDEBUG" );

    # per file overrides - not every compiler can optimize every file.

    # The src/ops/core_ops*.c files are challenging to optimize.
    # gcc can usually handle it, but don't assume any other compilers can,
    # until there is specific evidence otherwise.
    if ( ! defined($gccversion)) {
        $conf->data->set('optimize::src/ops/core_ops_cg.c','');
        $conf->data->set('optimize::src/ops/core_ops_cgp.c','');
        $conf->data->set('optimize::src/ops/core_ops_switch.c','');
    }

    # TT #405
    if ($conf->data->get('cpuarch') eq 'amd64') {
        $conf->data->set('optimize::src/gc/system.c','');
    }

    return 1;
}

1;

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
