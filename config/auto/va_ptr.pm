# Copyright: 2001-2003 The Perl Foundation.  All Rights Reserved.
# $Id: va_ptr.pm 10204 2005-11-28 07:45:03Z fperrad $

=head1 NAME

config/auto/va_ptr.pm - va_list to va_ptr conversion test

=head1 DESCRIPTION

Tests which kind of PARROT_VA_TO_VAPTR to use.

=cut

package Configure::Step;

use strict;
use vars qw($description $result @args);

use base qw(Parrot::Configure::Step::Base);

use Parrot::Configure::Step ':auto';

$description="Test the type of va_ptr (this test is likely to segfault)...";

@args=qw(verbose);

sub runstep {
    my $self = shift;
    my $va_type;
    cc_gen('config/auto/va_ptr/test_c.in');
    eval { cc_build('-DVA_TYPE_X86'); };

    if ($@ || cc_run() !~ /^ok/) {
	eval { cc_build('-DVA_TYPE_PPC'); };
	if ($@ || cc_run() !~ /^ok/) {
	    die "Unknown va_ptr type";
	}
	$va_type = 'ppc';
    }
    else  {
	$va_type = 'x86';
    }
    cc_clean();
    $result = $va_type;
    Parrot::Configure::Data->set(
	va_ptr_type => $va_type,
    );
}

1;