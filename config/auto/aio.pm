# Copyright: 2001-2003 The Perl Foundation.  All Rights Reserved.
# $Id: aio.pm 10337 2005-12-04 02:53:32Z jhoblitt $

=head1 NAME

config/auto/aio.pm - Test for AIO

=head1 DESCRIPTION

Determines whether the platform supports AIO.

=cut

package Configure::Step;

use strict;
use vars qw($description $result @args);

use base qw(Parrot::Configure::Step::Base);

use Parrot::Configure::Step ':auto';

$description="Determining if your platform supports AIO...";

@args=qw(verbose);

sub runstep {
    my $self = shift;
    my $test;
    my ($verbose) = @_;
    my $libs = Parrot::Configure::Data->get('libs');
    Parrot::Configure::Data->add(' ', libs => '-lrt');

    cc_gen('config/auto/aio/aio.in');
    eval { cc_build(); };
    if (! $@) {
	$test = cc_run(35);
	# if the test is failing with sigaction err
	# we should repeat it with a different signal number
	if ($test =~ /SIGRTMIN=(\d+)\sSIGRTMAX=(\d+)\n
		INFO=42\n
		ok/x) {
	    print " (yes) " if $verbose;
            $result = 'yes';

	    Parrot::Configure::Data->set(
		aio => 'define',
		HAS_AIO => 1,
		D_SIGRTMIN => $1,
		D_SIGRTMAX => $2,
	    );
	}

    }
    else {
	Parrot::Configure::Data->set(libs => $libs);
	print " (no) " if $verbose;
        $result = 'no';
    }
}