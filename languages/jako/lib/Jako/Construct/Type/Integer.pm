#
# Integer.pm
#
# Copyright (C) 2002-2005, The Perl Foundation.
# This program is free software. It is subject to the same license
# as the Parrot interpreter.
#
# $Id: Integer.pm 12840 2006-05-30 15:08:05Z coke $
#

use strict;
eval "use warnings";

package Jako::Construct::Type::Integer;

use base qw(Jako::Construct::Type);

sub new
{
  my $class = shift;
  my ($token) = @_;

  return bless {
    TOKEN    => $token,
    CODE     => 'I',
    NAME     => 'int',
    IMCC     => 'int',
    IMCC_PMC => 'Integer'
  }, $class;
}

1;

