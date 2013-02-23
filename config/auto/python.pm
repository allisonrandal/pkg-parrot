# Copyright: 2005 The Perl Foundation.  All Rights Reserved.
# $Id: python.pm 10117 2005-11-20 22:25:22Z jhoblitt $

=head1 NAME

config/auto/python - Check whether python is there

=head1 DESCRIPTION

Determines whether python is there.
Checks also whether we have Python 2.4.

=head1 TODO

Store version of Python.

=cut

package Configure::Step;

use strict;
use vars qw($description $result @args);

use base qw(Parrot::Configure::Step::Base);

use Parrot::Configure::Step ':auto';

$description = "Determining whether python is installed...";

@args = qw(verbose);

sub runstep {
    my $self = shift;
    my ( $out, $err ) = capture_output( 'python', '-V' );
    my $output = join( '', $out || '', $err || '' );
    my ($python, $major, $minor, $revision) = 
        $output =~ m/(Python)\s+(\d+).(\d+)(?:.(\d+))?/;
    $revision = 0 unless defined $revision;
    my $has_python = $python ? 1 : 0;

    Parrot::Configure::Data->set(has_python => $has_python);

    my $has_python_2_4 = 0;
    if ( $has_python ) {
        $has_python_2_4 =
            ( $major eq '2' && $minor eq '4' ) ? 1 : 0;
        $result = "yes, $major.$minor.$revision";
    } else {
        $result = 'no';
    }
    Parrot::Configure::Data->set(has_python_2_4 => $has_python_2_4);
}

1;