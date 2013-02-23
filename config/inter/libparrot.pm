# Copyright (C) 2005-2007, Parrot Foundation.
# $Id: libparrot.pm 37201 2009-03-08 12:07:48Z fperrad $

=head1 NAME

config/inter/libparrot.pm - Determines build information for libparrot

=head1 DESCRIPTION

libparrot is the library containing the parrot VM. This configuration
step determines whether it should be build static or shared.

=cut

package inter::libparrot;

use strict;
use warnings;

use base qw(Parrot::Configure::Step);

use File::Spec ();
use Parrot::Configure::Utils ':inter';


sub _init {
    my $self = shift;
    my %data;
    $data{description} = q{Should parrot link against a shared library};
    $data{result}      = q{};
    return \%data;
}

sub runstep {
    my ( $self, $conf ) = @_;
    my $parrot_is_shared = $conf->options->get('parrot_is_shared');

    $parrot_is_shared = integrate(
        $conf->data->get('parrot_is_shared'),
        $parrot_is_shared
    );

    $parrot_is_shared = 0 unless $conf->data->get('has_dynamic_linking');

    # Parrot can't necessarily handle a pre-existing installed shared
    # libparrot.so. At this point, we don't know the actual name
    # of the shared parrot library. So we try some candidates.
    # See RT #52288: the check for old_versions should be improved
    my @libs = ('libparrot.so');
    my @libpaths = ('/usr/local/lib', '/usr/lib', $conf->data->get('libdir'));
    if ($^O eq 'MSWin32') {
        push @libpaths, (split /;/, $ENV{PATH});
        @libs = ('libparrot.dll', 'libparrot.lib', 'libparrot.dll.a');
    }
    if ($^O eq 'cygwin') {
        @libs = ('libparrot.dll.a');
    }
    if (defined $ENV{LD_LIBRARY_PATH}) {
        push @libpaths, (split /:/, $ENV{LD_LIBRARY_PATH});
    }
    if (defined $ENV{LD_RUN_PATH}) {
        push @libpaths, (split /:/, $ENV{LD_RUN_PATH});
    }
    if (defined $ENV{DYLD_LIBRARY_PATH}) {
        push @libpaths, (split /:/, $ENV{DYLD_LIBRARY_PATH});
    }
    foreach my $f (@libs) {
        foreach my $d (@libpaths) {
            my $oldversion = File::Spec->catfile($d, $f);
            if (-e $oldversion) {
                warn("\nWarning: Building a shared parrot library may conflict " .
                     "with your previously-installed $oldversion\n");
            }
        }
    }

    if (
        $conf->options->get('ask')
        &&
        $conf->data->get('has_dynamic_linking')
    ) {
        $parrot_is_shared = prompt(
            "\nShould parrot be built using a shared library?",
            $parrot_is_shared ? 'y' : 'n'
        );

        $parrot_is_shared = lc($parrot_is_shared) eq 'y';
    }

    $conf->data->set(
        parrot_is_shared => $parrot_is_shared,

        libparrot => $parrot_is_shared
        ? '$(LIBPARROT_SHARED)'
        : '$(LIBPARROT_STATIC)',
    );

    # Set -rpath (or equivalent) for executables to find the
    # shared libparrot in the build directory.
    $conf->data->set(
        rpath_blib => ( $parrot_is_shared && $conf->data->get('rpath') )
        ? $conf->data->get('rpath')
            . $conf->data->get('build_dir')
            . $conf->data->get('slash')
            . $conf->data->get('blib_dir')
        : ''
    );

    # Set -rpath (or equivalent) for the installed executables to find the
    # installed shared libparrot.
    $conf->data->set(
        rpath_lib => ( $parrot_is_shared && $conf->data->get('rpath') )
        ? $conf->data->get('rpath')
            . $conf->data->get('libdir')
        : ''
    );

    unless ( defined( $conf->data->get('libparrot_ldflags') ) ) {
        $conf->data->set(libparrot_ldflags =>
        '-L'
        . $conf->data->get('build_dir')
        . $conf->data->get('slash')
        . $conf->data->get('blib_dir')
        . ' -lparrot'
        );
    }

    $self->set_result( $parrot_is_shared ? 'yes' : 'no' );

    return 1;
}

1;

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4: