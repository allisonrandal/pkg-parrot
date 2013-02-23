# Copyright (C) 2005-2007, The Perl Foundation.
# $Id: /parrotcode/trunk/languages/unlambda/t/hello.t 470 2006-12-05T03:30:45.414067Z svm  $

=head1 NAME

unlambda/t/hello.t - testing hello.unl


=head1 SYNOPSIS

	% cd languages && perl unlambda/t/hello.t

=head1 DESCRIPTION

Test hello.unl.

=head1 AUTHOR

Bernhard Schmalhofer - C<Bernhard.Schmalhofer@gmx.de>

=cut

use strict;
use FindBin;
use lib "$FindBin::Bin/../../../lib";

use Test::More tests => 1;
use Parrot::Config;
use File::Spec();

my $parrot    = File::Spec->catfile( File::Spec->updir(), $PConfig{test_prog} );
my $unlamba   = $parrot . q{ } . File::Spec->catfile( 'unlambda', 'unl.pir' );

my $hello_unl = File::Spec->catfile( 'unlambda', 'hello.unl' ); 
is ( `$unlamba $hello_unl`, "Hello world\n", 'hello.unl' );
