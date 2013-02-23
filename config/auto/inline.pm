# Copyright: 2001-2003 The Perl Foundation.  All Rights Reserved.
# $Id: inline.pm 11744 2006-02-26 10:55:39Z bernhard $

=head1 NAME

config/auto/inline.pm - Inline Compiler Support

=head1 DESCRIPTION

Determines whether the compiler supports C<inline>.

=cut

package auto::inline;

use strict;
use vars qw($description @args);

use base qw(Parrot::Configure::Step::Base);

use Parrot::Configure::Step ':auto';

$description = 'Determining if your compiler supports inline';

@args = qw(inline verbose);

sub runstep
{
    my ($self, $conf) = @_;

    my $test;
    my ($inline, $verbose) = $conf->options->get(qw(inline verbose));

    if (defined $inline) {
        $test = $inline;
    } else {
        cc_gen('config/auto/inline/test_1.in');
        eval { cc_build(); };
        if (!$@) {
            $test = cc_run();
            chomp $test if $test;
        }
        cc_clean();
        if (!$test) {
            cc_gen('config/auto/inline/test_2.in');
            eval { cc_build(); };
            if (!$@) {
                $test = cc_run();
                chomp $test if $test;
            }
            cc_clean();
        }
        if ($test) {
            print " ($test) " if $verbose;
            $self->set_result('yes');
        } else {
            print " no " if $verbose;
            $self->set_result('no');
            $test   = '';
        }
    }

    $conf->data->set(inline => $test);

    return $self;
}

1;
