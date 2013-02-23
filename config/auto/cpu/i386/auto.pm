# Copyright (C) 2001-2007, The Perl Foundation.
# $Id: /parrotcode/local/config/auto/cpu/i386/auto.pm 733 2006-12-17T23:24:17.491923Z chromatic  $

=head1 NAME

config/auto/cpu/i386/auto.pm

=head1 DESCRIPTION

Test

=cut

package auto::cpu::i386::auto;

use strict;
use warnings;

use Parrot::Configure::Step qw(cc_gen cc_build cc_run cc_clean);

sub runstep {
    my ( $self, $conf ) = @_;

    my $verbose = $conf->options->get('verbose');

    my @files = qw( test_gcc_cmpxchg.in );
    for my $f (@files) {
        print " $f " if $verbose;
        my ($suffix) = $f =~ /test_(\w+)/;
        $f = "config/auto/cpu/i386/$f";
        cc_gen($f);
        eval { cc_build("-DPARROT_CONFIG_TEST") };
        if ($@) {
            print " $@ " if $verbose;
        }
        else {
            if ( cc_run() =~ /ok/ ) {
                $conf->data->set(
                    "i386_has_$suffix" => '1',
                    "HAS_i386_$suffix" => '1',
                );
                print " (\U$suffix) " if ($verbose);
                $conf->data->add( ' ', TEMP_generated => $f );
            }
        }
        cc_clean();
    }
}

1;

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4: