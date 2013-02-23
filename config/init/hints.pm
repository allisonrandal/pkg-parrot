# Copyright: 2001-2003 The Perl Foundation.  All Rights Reserved.
# $Id: hints.pm 10204 2005-11-28 07:45:03Z fperrad $

=head1 NAME

config/init/hints.pm - Platform Hints

=head1 DESCRIPTION

Loads the platform and local hints files, modifying the defaults set up
in F<config/init/default.pm>.

=cut

package Configure::Step;

use strict;
use vars qw($description $result @args);

use base qw(Parrot::Configure::Step::Base);

use Parrot::Configure::Step;

$description="Loading platform and local hints files...";

@args = qw( cc verbose define );

sub runstep {
    my $self = shift;
  my $hints = "config/init/hints/" . lc($^O) . ".pm";
  my $hints_used = 0;
  print "[ " if $_[1];
  if(-e $hints) {
    print "$hints " if $_[1];
    do $hints;
    die $@ if $@;
    $hints_used++;
  }
  $hints = "config/init/hints/local.pm";
  if(-e $hints) {
    print "$hints " if $_[1];
    do $hints;
    die $@ if $@;
    $hints_used++;
  }
  if ($hints_used == 0) {
    print "(no hints) " if $_[1];
  }
  print "]" if $_[1];
}

1;