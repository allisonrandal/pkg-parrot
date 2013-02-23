#
# While.pm
#
# Copyright: 2002-2005 The Perl Foundation.  All Rights Reserved.
# This program is free software. It is subject to the same license
# as the Parrot interpreter.
#
# $Id: While.pm 7819 2005-04-13 00:20:52Z gregor $
#

use strict;
eval "use warnings";

package Jako::Construct::Block::Loop::While;

use Carp;

use base qw(Jako::Construct::Block::Loop);


#
# new()
#

sub new
{
  my $class = shift;

  confess "Expected 5 args!" unless @_ == 5;

  my ($block, $prefix, $left, $op, $right) = @_;

  my $self = bless {
    BLOCK     => $block,

    PREFIX    => $prefix,
    KIND      => 'while',
    LEFT      => $left,
    OP        => $op,
    RIGHT     => $right,

    CONTENT   => [ ]
  }, $class;

  $block->push_content($self);

  return $self;
}


1;