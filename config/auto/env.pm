# Copyright (C) 2001-2003, The Perl Foundation.
# $Id: env.pm 16144 2006-12-17 18:42:49Z paultcochrane $

=head1 NAME

config/auto/env.pm - System Environment

=head1 DESCRIPTION

Determining if the C library has C<setenv()> and C<unsetenv()>.

=cut

package auto::env;

use strict;
use warnings;
use vars qw($description @args);

use base qw(Parrot::Configure::Step::Base);

use Parrot::Configure::Step ':auto';

$description = 'Determining if your C library has setenv / unsetenv';
@args        = qw(verbose);

sub runstep {
    my ( $self, $conf ) = ( shift, shift );

    my $verbose = $conf->options->get('verbose');

    my ( $setenv, $unsetenv ) = ( 0, 0 );

    cc_gen('config/auto/env/test_setenv.in');
    eval { cc_build(); };
    unless ( $@ || cc_run() !~ /ok/ ) {
        $setenv = 1;
    }
    cc_clean();
    cc_gen('config/auto/env/test_unsetenv.in');
    eval { cc_build(); };
    unless ( $@ || cc_run() !~ /ok/ ) {
        $unsetenv = 1;
    }
    cc_clean();

    $conf->data->set(
        setenv   => $setenv,
        unsetenv => $unsetenv
    );

    if ( $setenv && $unsetenv ) {
        print " (both) " if $verbose;
        $self->set_result('both');
    }
    elsif ($setenv) {
        print " (setenv) " if $verbose;
        $self->set_result('setenv');
    }
    elsif ($unsetenv) {
        print " (unsetenv) " if $verbose;
        $self->set_result('unsetenv');
    }
    else {
        print " (no) " if $verbose;
        $self->set_result('no');
    }

    return $self;
}

1;

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
