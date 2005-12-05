# Copyright: 2001-2005 The Perl Foundation.  All Rights Reserved.
# $Id: RunSteps.pm 10117 2005-11-20 22:25:22Z jhoblitt $

=head1 NAME

Parrot::Configure::RunSteps - Configuration Steps

=head1 DESCRIPTION

This module lists, in order, the configuration steps that will be run by
F<Configure.pl>. It should be edited when adding a new step. For more
information on Parrot's configuration system, and how to add new steps,
see F<docs/configuration.pod>.

=head2 Functions

=over 4

=cut

package Parrot::Configure::RunSteps;

use strict;
use vars qw(@steps);

use Parrot::Configure::Data;

# EDIT HERE TO ADD NEW TESTS
@steps = qw(
    init/manifest.pm
    init/defaults.pm
    init/miniparrot.pm
    init/hints.pm
    init/headers.pm
    inter/progs.pm
    inter/make.pm
    inter/lex.pm
    inter/yacc.pm
    auto/gcc.pm
    init/optimize.pm
    inter/shlibs.pm
    inter/charset.pm
    inter/encoding.pm
    inter/types.pm
    inter/ops.pm
    inter/exp.pm
    inter/pmc.pm
    auto/alignptrs.pm
    auto/headers.pm
    auto/sizes.pm
    auto/byteorder.pm
    auto/va_ptr.pm
    auto/pack.pm
    auto/format.pm
    auto/isreg.pm
    auto/jit.pm
    gen/cpu.pm
    auto/funcptr.pm
    auto/cgoto.pm
    auto/inline.pm
    auto/gc.pm
    auto/memalign.pm
    auto/signal.pm
    auto/env.pm
    auto/aio.pm
    auto/gmp.pm
    auto/gdbm.pm
    auto/snprintf.pm
    auto/perldoc.pm
    auto/python.pm
    auto/antlr.pm
    auto/bc.pm
    auto/m4.pm
    gen/icu.pm
    gen/revision.pm
    gen/config_h.pm
    gen/core_pmcs.pm
    gen/parrot_include.pm
    gen/makefiles.pm
    gen/platform.pm
    gen/config_pm.pm
);

=item C<runsteps()>

Loops over the configuration steps, running each one in turn.

=cut

sub runsteps {
    shift;
    my %args=@_;

    my $step = 'Configure::Step';

    local $SIG{__WARN__} = sub {
        warn $_[0] unless $_[0] =~ /^Subroutine runstep redefined at config/
    };

    my $verbose = $args{verbose};
    my $n = 0;

    for (@steps) {
        # FIXME the steps still all live in the same namespace so the value of
        # result has to be reset
        undef $Configure::Step::result;
        my $result;

        die "No config/$_" unless -e "config/$_";
        require "config/$_";

        my $description = $step->description;

        print "\n", $description;
        print '...';
        ++$n;

        if ($args{'verbose-step'}) {
            if ($args{'verbose-step'} =~ /^\d+$/ &&
                $n == $args{'verbose-step'}) {
                $args{verbose} = 2;
            }
            elsif ($description =~ /$args{'verbose-step'}/) {
                $args{verbose} = 2;
            }
        }

        # cc_build uses this verbose setting
        Parrot::Configure::Data->set('verbose' => $args{verbose}) if $n > 2;

        print "\n" if $args{verbose} && $args{verbose} == 2;

        {
            local $_;
            $step->runstep(@args{@Configure::Step::args});
        }

        $result = $step->result || 'done';

        print "..." if $args{verbose} && $args{verbose} == 2;
        print "." x (71 - length($description)
                        - length($result));
        print "$result." unless m{^inter/} && $args{ask};

        $args{verbose} = $verbose;
    }
}

=back

=head1 SEE ALSO

=over 4

=item C<Parrot::Configure::Step>

=item F<docs/configuration.pod>

=back

=cut

1;
