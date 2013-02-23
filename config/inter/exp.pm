# Copyright: 2001-2003 The Perl Foundation.  All Rights Reserved.
# $Id: exp.pm 10204 2005-11-28 07:45:03Z fperrad $

=head1 NAME

config/inter/exp.pm - Experimental Systems

=head1 DESCRIPTION

Asks the user whether to set up experimental networking.

=cut

package Configure::Step;

use strict;
use vars qw($description $result @args);

use base qw(Parrot::Configure::Step::Base);

use Parrot::Configure::Step ':inter';

$description="Setting up experimental systems...";

@args=qw(ask expnetwork);

sub runstep {
    my $self = shift;
  my $net=$_[1] || 'n';

  if($_[0]) {
    $net=prompt("\n\nEnable experimental networking?", $net) if $_[0];
  }

  if($net =~ /n/i || !$net) {
    $net=0;
  }
  else {
    $net=1;
  }
  
  Parrot::Configure::Data->set(expnetworking => $net);
}

1;