# Copyright: 2005 The Perl Foundation.  All Rights Reserved.
# $Id: revision.pm 10933 2006-01-06 01:43:24Z particle $

=head1 NAME

config/gen/revision.pm - Parrot's configure revision

=head1 DESCRIPTION

Determines parrot's SVN revision.  In a release, there are no .svn directories,
so this field is empty.

=cut

package gen::revision;

use strict;
use vars qw($description $result);

use base qw(Parrot::Configure::Step::Base);

use Parrot::Revision;

$description = "Determining Parrot's revision";

sub runstep
{
    my ($self, $conf) = @_;

    my $revision = $Parrot::Revision::current;
    my $entries  = $Parrot::Revision::svn_entries;

    $conf->data->set(
        revision    => $revision,
        SVN_ENTRIES => $entries
    );

    if ($revision >= 1) {
        $result = "r$revision";
    } else {
        $result = "done";
    }
}

1;
