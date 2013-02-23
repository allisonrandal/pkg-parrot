#
# PMC.pm
#
# Copyright: 2002-2005 The Perl Foundation.  All Rights Reserved.
# This program is free software. It is subject to the same license
# as the Parrot interpreter.
#
# $Id: PMC.pm 10644 2005-12-24 18:06:41Z gregor $
#

use strict;
eval "use warnings";

package Jako::Construct::Type::PMC;

use base qw(Jako::Construct::Type);

sub new
{
  my $class = shift;
  my ($token) = @_;

  return bless {
    TOKEN    => $token,
    CODE     => 'P',
    NAME     => 'pmc',
    IMCC     => 'pmc',
    IMCC_PMC => 'PMC'
  }, $class;
}

1;
