# Copyright: 2001-2003 The Perl Foundation.  All Rights Reserved.
# $Id: manifest.pm 10710 2005-12-28 00:25:21Z jhoblitt $

=head1 NAME

config/init/manifest.pm - MANIFEST Check

=head1 DESCRIPTION

Uses C<ExtUtils::Manifest> to check that the distribution is complete.

=cut

package init::manifest;

use strict;
use vars qw($description $result @args);

use base qw(Parrot::Configure::Step::Base);

use Parrot::Configure::Step;
use ExtUtils::Manifest qw(manicheck);

$description = "Checking MANIFEST...";

@args = qw(nomanicheck);

sub runstep
{
    my ($self, $conf) = @_;

    if ($conf->options->get('nomanicheck')) {
        $result = 'skipped';
        return;
    }

    my @missing = ExtUtils::Manifest::manicheck();

    if (@missing) {
        print <<"END";

Ack, some files were missing!  I can't continue running
without everything here.  Please try to find the above
files and then try running Configure again.

END

        exit 1;
    }
}

1;
