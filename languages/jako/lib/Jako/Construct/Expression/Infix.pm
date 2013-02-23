#
# Infix.pm
#
# Copyright (C) 2002-2005, The Perl Foundation.
# This program is free software. It is subject to the same license
# as the Parrot interpreter.
#
# $Id: /local/languages/jako/lib/Jako/Construct/Expression/Infix.pm 12840 2006-05-30T15:08:05.048089Z coke  $
#

use strict;
eval "use warnings";

package Jako::Construct::Expression::Infix;

use base qw(Jako::Construct::Expression);

sub new
{
  my $class = shift;
  my ($left, $op, $right);

  return bless {
    LEFT  => $left,
    OP    => $op,
    RIGHT => $right,
  }, $class;
}

1;
