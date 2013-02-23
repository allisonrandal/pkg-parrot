# Copyright (C) 2005-2007, The Perl Foundation.
# $Id: /parrotcode/local/config/auto/m4.pm 733 2006-12-17T23:24:17.491923Z chromatic  $

=head1 NAME

config/auto/m4 - Check whether GNU m4 works

=head1 DESCRIPTION

Determines whether GNU m4 exists on the system. It is OK when it doesn't exist.
Currently GNU m4 is only used for doublechecking Parrot m4.

=cut

package auto::m4;

use strict;
use warnings;
use vars qw($description @args);

use base qw(Parrot::Configure::Step::Base);

use Config;
use Parrot::Configure::Step ':auto', 'capture_output';

$description = 'Determining whether GNU m4 is installed';

@args = qw();

sub runstep {
    my ( $self, $conf ) = @_;

    my $archname = $Config{archname};
    my ( $cpuarch, $osname ) = split( '-', $archname );
    if ( !defined $osname ) {
        ( $osname, $cpuarch ) = ( $cpuarch, "" );
    }

    my $has_gnu_m4;

    # Calling 'm4 --version' hangs under FreeBSD
    my %m4_hangs = ( freebsd => 1 );

    if ( $m4_hangs{$osname} ) {
        $has_gnu_m4 = 0;
    }
    else {

        # This seems to work for GNU m4 1.4.2
        my $output = capture_output( 'm4', '--version' ) || '';
        $has_gnu_m4 = ( $output =~ m/^GNU [mM]4 / ) ? 1 : 0;
    }

    $conf->data->set( has_gnu_m4 => $has_gnu_m4 );
    $self->set_result( $has_gnu_m4 ? 'yes' : 'no' );

    return $self;
}

1;

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
