#! perl
# Copyright (C) 2006-2010, Parrot Foundation.
# $Id: pir_code_coda.t 48544 2010-08-17 03:02:21Z petdance $

use strict;
use warnings;

use lib qw( . lib ../lib ../../lib );
use Test::More tests => 2;
use Parrot::Distribution;

=head1 NAME

t/codingstd/pir_code_coda.t - checks for editor hint coda in PIR source

=head1 SYNOPSIS

    # test all files
    % prove t/codingstd/pir_code_coda.t

    # test specific files
    % perl t/codingstd/pir_code_coda.t src/foo.pir

=head1 DESCRIPTION

Checks that all PIR language source files have the proper editor hints coda,
as specified in PDD07.

=head1 SEE ALSO

L<docs/pdds/pdd07_codingstd.pod>

=cut

## L<PDD07/Smart Editor Style Support/"PIR source files must end with this coda">

my $coda = <<'CODA';
# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:
CODA

my $DIST = Parrot::Distribution->new;
my @files = @ARGV ? <@ARGV> : $DIST->get_pir_language_files();
my @no_coda;
my @extra_coda;

foreach my $file (@files) {

    # if we have command line arguments, the file is the full path
    # otherwise, use the relevant Parrot:: path method
    my $path = @ARGV ? $file : $file->path;

    next unless -f $path;

    my $buf = $DIST->slurp($path);

    # skip autogenerated files (based on the first line of the file)
    next if ( index( $buf, "# THIS IS A GENERATED FILE! DO NOT EDIT!" ) == 0 );

    # append to the no_coda array if the code doesn't match
    push @no_coda => "$path\n"
        unless $buf =~ m{\Q$coda\E\n*\z};

    # append to the extra_coda array if coda-like text appears more than once
    my $vim_many = 0;
    $vim_many++ while $buf =~ m{^ [# \t]* vim[:] }gmx;
    my $emacs_many = 0;
    $emacs_many++ while $buf =~ m{^ [# \t]* Local \s Variables: }gmx;
    push @extra_coda => "$path\n"
        if $vim_many > 1 || $emacs_many > 1;
}

# If we use is_deeply, then the differences will show in the test output.
is_deeply( \@no_coda,    [], 'PIR code coda present' );
is_deeply( \@extra_coda, [], 'PIR code coda appears only once' );

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
