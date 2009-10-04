#! perl
# Copyright (C) 2007-2008, Parrot Foundation.
# $Id: opengl-01.t 39967 2009-07-10 00:16:41Z jkeenan $
# auto/opengl-01.t

use strict;
use warnings;
use Test::More tests => 43;
use Carp;
use lib qw( lib );
use_ok('config::init::defaults');
use_ok('config::auto::opengl');
use Parrot::Configure;
use Parrot::Configure::Options qw( process_options );
use Parrot::Configure::Test qw(
    test_step_thru_runstep
    rerun_defaults_for_testing
    test_step_constructor_and_description
);
use IO::CaptureOutput qw| capture |;

########## --without-opengl ##########

my ($args, $step_list_ref) = process_options(
    {
        argv => [ q{--without-opengl} ],
        mode => q{configure},
    }
);

my $conf = Parrot::Configure->new;

my $serialized = $conf->pcfreeze();

test_step_thru_runstep( $conf, q{init::defaults}, $args );

my $pkg = q{auto::opengl};

$conf->add_steps($pkg);
$conf->options->set( %{$args} );
my $step = test_step_constructor_and_description($conf);
ok( $step->runstep($conf), "runstep() returned true value");
is( $step->result(), 'no', "Got expected result" );
is( $conf->data->get( 'has_opengl' ), 0,
    "Got expected value for 'has_opengl'");

$conf->replenish($serialized);

########## _select_lib() ##########

($args, $step_list_ref) = process_options(
    {
        argv => [ ],
        mode => q{configure},
    }
);
rerun_defaults_for_testing($conf, $args );
$conf->add_steps($pkg);
$conf->options->set( %{$args} );
$step = test_step_constructor_and_description($conf);

# Mock OS/C-compiler combinations
my ($osname, $cc, $initial_libs);
$initial_libs = $conf->data->get('libs');
$osname = 'mswin32';
$cc = 'gcc';
is($step->_select_lib( {
    conf            => $conf,
    osname          => $osname,
    cc              => $cc,
    win32_gcc       => '-lglut32 -lglu32 -lopengl32',
    win32_nongcc    => 'glut.lib glu.lib gl.lib',
    darwin          => '-framework OpenGL -framework GLUT',
    default         => '-lglut -lGLU -lGL',
} ),
    '-lglut32 -lglu32 -lopengl32',
   "_select_lib() returned expected value");

$osname = 'mswin32';
$cc = 'cc';
$initial_libs = $conf->data->get('libs');
is($step->_select_lib( {
    conf            => $conf,
    osname          => $osname,
    cc              => $cc,
    win32_gcc       => '-lglut32 -lglu32 -lopengl32',
    win32_nongcc    => 'glut.lib glu.lib gl.lib',
    darwin          => '-framework OpenGL -framework GLUT',
    default         => '-lglut -lGLU -lGL',
} ),
   'glut.lib glu.lib gl.lib',
   "_select_lib() returned expected value");

$osname = 'darwin';
$cc = 'cc';
$initial_libs = $conf->data->get('libs');
is($step->_select_lib( {
    conf            => $conf,
    osname          => $osname,
    cc              => $cc,
    win32_gcc       => '-lglut32 -lglu32 -lopengl32',
    win32_nongcc    => 'glut.lib glu.lib gl.lib',
    darwin          => '-framework OpenGL -framework GLUT',
    default         => '-lglut -lGLU -lGL',
} ),
   '-framework OpenGL -framework GLUT',
   "_select_lib() returned expected value");

$osname = 'foobar';
$cc = 'cc';
$initial_libs = $conf->data->get('libs');
is($step->_select_lib( {
    conf            => $conf,
    osname          => $osname,
    cc              => $cc,
    win32_gcc       => '-lglut32 -lglu32 -lopengl32',
    win32_nongcc    => 'glut.lib glu.lib gl.lib',
    darwin          => '-framework OpenGL -framework GLUT',
    default         => '-lglut -lGLU -lGL',
} ),
   '-lglut -lGLU -lGL',
   "_select_lib() returned expected value");

$conf->replenish($serialized);

########## --verbose; _evaluate_cc_run() ##########

($args, $step_list_ref) = process_options(
    {
        argv => [ q{--verbose} ],
        mode => q{configure},
    }
);
rerun_defaults_for_testing($conf, $args );
$conf->add_steps($pkg);
$conf->options->set( %{$args} );
$step = test_step_constructor_and_description($conf);

my @try = qw( 4 freeglut );
my $test = qq{$try[0] $try[1]\n};

{
    my ($stdout, $stderr);
    my ($glut_api_version, $glut_brand);
    capture(
        sub { ($glut_api_version, $glut_brand) = $step->_evaluate_cc_run(
            $test,
            0,
        ); },
        \$stdout,
        \$stderr,
    );
    is( $glut_api_version, $try[0],
        "Got first expected return value for _evaluate_cc_run()." );
    is( $glut_brand, $try[1],
        "Got first expected return value for _evaluate_cc_run()." );
    ok(! $stdout, "Nothing captured on STDOUT, as expected");
}

{
    my ($stdout, $stderr);
    my ($glut_api_version, $glut_brand);
    capture(
        sub { ($glut_api_version, $glut_brand) = $step->_evaluate_cc_run(
            $test,
            $conf->options->get( 'verbose' )
        ); },
        \$stdout,
        \$stderr,
    );
    is( $glut_api_version, $try[0],
        "Got first expected return value for _evaluate_cc_run()." );
    is( $glut_brand, $try[1],
        "Got first expected return value for _evaluate_cc_run()." );
    like(
        $stdout,
        qr/yes, $glut_brand API version $glut_api_version/,
        "Got expected verbose output for _evaluate_cc_run()"
    );
}

########## _handle_glut() ##########

{
    my $glut_api_version = '4';
    my $glut_brand = 'freeglut';
    ok(auto::opengl::_handle_glut( $conf, 'lib', $glut_api_version, $glut_brand ),
        "_handle_glut() returned true value");
    is( $conf->data->get( 'opengl' ),  'define',
        "Got expected value for opengl");
    is( $conf->data->get( 'has_opengl' ),  1,
        "Got expected value for has_opengl");
    is( $conf->data->get( 'HAS_OPENGL' ),  1,
        "Got expected value for HAS_OPENGL");
    is( $conf->data->get( 'glut' ),  'define',
        "Got expected value for glut");
    is( $conf->data->get( 'glut_brand' ),  $glut_brand,
        "Got expected value for glut_brand");
    is( $conf->data->get( 'has_glut' ),  $glut_api_version,
        "Got expected value for has_glut");
    is( $conf->data->get( 'HAS_GLUT' ),  $glut_api_version,
        "Got expected value for HAS_GLUT");
}

pass("Completed all tests in $0");

################### DOCUMENTATION ###################

=head1 NAME

  auto/opengl-01.t - test auto::opengl

=head1 SYNOPSIS

    % prove t/steps/auto/opengl-01.t

=head1 DESCRIPTION

The files in this directory test functionality used by F<Configure.pl>.

The tests in this file test configuration step class auto::opengl.

=head1 AUTHOR

Geoffrey Broadwell; modified from a similar file by James E Keenan

=head1 SEE ALSO

config::auto::opengl, F<Configure.pl>.

=cut

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4: