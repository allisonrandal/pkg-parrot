#! perl
# Copyright (C) 2007, The Perl Foundation.
# $Id: /parrotcode/trunk/t/configure/19-version.t 3387 2007-05-05T17:23:25.185052Z jkeenan  $
# 19-version.t

use strict;
use warnings;

use Test::More tests => 10;
use Carp;
use_ok( 'Cwd' );
use_ok( 'File::Copy' );
use_ok( 'File::Temp', qw| tempdir | );
use lib qw( . lib ../lib ../../lib );

my $cwd = cwd();
my $errstr;
{
    my $tdir = tempdir();
    ok(chdir $tdir, "Changed to temporary directory for testing");
    ok((mkdir "lib"), "Able to make directory lib");
    ok((mkdir "lib/Parrot"), "Able to make directory lib/Parrot");
    ok(copy ("$cwd/lib/Parrot/BuildUtil.pm", "lib/Parrot/"),
        "Able to copy Parrot::BuildUtil for testing");
    unshift(@INC, "lib");

    require Parrot::BuildUtil;

    # Case 1:  No VERSION file
    eval { my $pv = Parrot::BuildUtil::parrot_version(); };
    like($@, qr/Could not open VERSION file!/,
        "Absence of VERSION file correctly detected");

    ok(chdir $cwd, "Able to change back to directory after testing");
}

pass("Completed all tests in $0");

################### DOCUMENTATION ###################

=head1 NAME

19-version.t - test C<Parrot::BuildUtil::parrot_version()>

=head1 SYNOPSIS

    % prove t/configure/19-version.t

=head1 DESCRIPTION

The files in this directory test functionality used by F<Configure.pl>.

The tests in this file test Parrot::BuildUtil (F<lib/Parrot/BuildUtil.pm>).

=head1 AUTHOR

James E Keenan

=head1 SEE ALSO

Parrot::BuildUtil, F<Configure.pl>.

=cut

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
