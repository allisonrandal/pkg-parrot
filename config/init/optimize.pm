# Copyright: 2001-2005 The Perl Foundation.  All Rights Reserved.
# $Id: optimize.pm 10881 2006-01-04 05:04:38Z jhoblitt $

=head1 NAME

config/init/optimize.pm - Optimization

=head1 DESCRIPTION

Enables optimization by adding the appropriate flags for the local platform to
the C<CCFLAGS>. Should this be part of config/inter/progs.pm ? XXX

=cut

package init::optimize;

use strict;
use vars qw($description $result @args);

use base qw(Parrot::Configure::Step::Base);

use Config;
use Parrot::Configure::Step;

$description = "Enabling optimization...";

@args = qw(verbose optimize);

sub runstep
{
    my ($self, $conf) = @_;

    # A plain --optimize means use perl5's $Config{optimize}.  If an argument
    # is given, however, use that instead. 
    my $optimize = $conf->options->get('optimize');
    if (defined $optimize) {
        $result = 'yes';
        # disable debug flags
        $conf->data->set(cc_debug => '');
        $conf->data->add(' ', ccflags => "-DDISABLE_GC_DEBUG=1 -DNDEBUG");
        if ($optimize eq "1") {
            # use perl5's value
            $conf->data->add(' ', ccflags => $Config{optimize});
            # record what optimization was enabled
            $conf->data->set(optimize => $Config{optimize});
        } else {
            # use what was passed to --optimize on the CLI
            $conf->data->add(' ', ccflags => $optimize);
            # record what optimization was enabled
            $conf->data->set(optimize => $optimize);
        }
    } else {
        $result = 'no';
        print "(none requested) " if $conf->options->get('verbose');
    }
}

1;
