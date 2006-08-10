#
# Number.pm
#
# Copyright (C) 2002-2005, The Perl Foundation.
# This program is free software. It is subject to the same license
# as the Parrot interpreter.
#
# $Id: /local/languages/jako/lib/Jako/Construct/Type/Number.pm 12840 2006-05-30T15:08:05.048089Z coke  $
#

use strict;
eval "use warnings";

package Jako::Construct::Type::Number;

use base qw(Jako::Construct::Type);

sub new
{
  my $class = shift;
  my ($token) = @_;

  return bless {
    TOKEN    => $token,
    CODE     => 'N',
    NAME     => 'num',
    IMCC     => 'num',
    IMCC_PMC => 'Float'
  }, $class;
}

1;

