# Copyright (C) 2001-2006, The Perl Foundation.
# $Id: /local/config/init/headers.pm 13029 2006-06-26T19:26:45.696181Z bernhard  $

=head1 NAME

config/init/headers.pm - Nongenerated Headers

=head1 DESCRIPTION

Uses C<ExtUtils::Manifest> to determine which headers are nongenerated.

=cut

package init::headers;

use strict;

use base qw(Parrot::Configure::Step::Base);

use Parrot::Configure::Step;
use ExtUtils::Manifest qw(maniread);

our $description = 'Determining nongenerated header files';
our @args;

sub runstep
{
    my ($self, $conf) = @_;

    my $inc = 'include/parrot';

    my @headers = (
        sort
            map { m{^$inc/(.*\.h)\z} }
            keys %{maniread()}
    );

    $_ = "\$(INC_DIR)/$_" for @headers;
    my $TEMP_nongen_headers = join("\\\n	", @headers);

    $conf->data->set(
        inc                 => $inc,
        TEMP_nongen_headers => $TEMP_nongen_headers,
    );

    return $self;
}

1;
