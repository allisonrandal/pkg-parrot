#!perl
# Copyright (C) 2005-2006, The Perl Foundation.
# $Id: /parrotcode/trunk/t/examples/shootout.t 3128 2007-04-11T21:06:01.894856Z paultcochrane  $

use strict;
use warnings;
use lib qw( . lib ../lib ../../lib );
use Test::More;
use Parrot::Config;
use vars qw($EXT $DIR @shootouts);

# find dynamically all shootouts from dir listing
BEGIN {    # to be run before declaring the number of tests
    $EXT = '.output';
    $DIR = "examples/shootout";
    opendir( DIR, $DIR ) or die "can’t opendir $DIR: $!";
    @shootouts = grep { -e "$DIR/$_$EXT" } sort grep { /\.pir$/ } readdir(DIR);
    closedir DIR;
}

use Parrot::Test tests => scalar(@shootouts);

=head1 NAME

t/examples/shootout.t - Test the shootout examples in "examples/shootout/*.pir".

=head1 SYNOPSIS

    % prove t/examples/shootout.t

=head1 DESCRIPTION

Test the PIR shootout examples in 'examples/shootout/*.pir'.

To add a new test, you do not have to modify this script:

 1. add your script (toto.pir) to examples/shootout
 2. put parrot options in the first line (e.g  "#!./parrot -Oc -Cj")
 3. make sure you have default argument values
 4. put the expected output as a file : toto.pir.output
 5. if you need an input file (to be read from stdin), call it toto.pir.input

See the explanation of benchmarks and sample data for reduced N benches at
http://shootout.alioth.debian.org/sandbox/

=head1 SEE ALSO

#40064: [TODO] shootout example testing in Parrot RT

L<"https://rt.perl.org/rt3/Public/Bug/Display.html?id=40064">

=cut

my %skips = (
    'pidigits.pir'    => [ 'not exists $PConfig{HAS_GMP}', 'needs GMP' ],
    'recursive.pir'   => [ '$PConfig{cpuarch} !~ /86/',    'float JIT broken on non-x86' ],
    'recursive-2.pir' => [ '$PConfig{cpuarch} !~ /86/',    'float JIT broken on non-x86' ],
);
my $INPUT_EXT = '.input';
foreach my $script (@shootouts) {
    my $skip = $skips{$script};
    if ($skip) {
        my ( $cond, $reason ) = @{$skip};
        if ( eval "$cond" ) {
            Test::More->builder->skip("$script $reason");
            next;
        }
    }
    my $file = "$DIR/$script";

    # parse first line
    open( FILE, '<', $file ) or die "unable to open file [$file] : $!";
    my $shebang = <FILE>;
    close FILE;
    my $expected = slurp_file("$file$EXT");

    my $args = "";
    if ( $shebang =~ /^\#.+parrot\s+(.+)$/ ) {
        $args = $1;    # parrot options
    }
    unless ( $PConfig{jitcapable} ) {
        $args =~ s/-j/-C/;
        $args =~ s/-Cj/-C/;
    }
    unless ( $PConfig{cg_flag} =~ /HAVE/ ) {
        $args =~ s/-Cj/-j/;

        # Remove any plain -C option.
        $args =~ s/(^|\s)-C(\s|$)/$1$2/;

        # Remove any extra Cs still floating around
        $args =~ s/C//;
    }

    # look for input files
    my $input = "$file$INPUT_EXT";
    if ( -e $input ) {
        $args .= " < $input ";
    }

    $ENV{TEST_PROG_ARGS} = $args;
    example_output_is( $file, $expected );
}

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4: