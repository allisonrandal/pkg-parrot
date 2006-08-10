#
# Bare.pm
#
# Copyright (C) 2002-2005, The Perl Foundation.
# This program is free software. It is subject to the same license
# as the Parrot interpreter.
#
# $Id: /local/languages/jako/lib/Jako/Construct/Block/Bare.pm 12840 2006-05-30T15:08:05.048089Z coke  $
#

use strict;
eval "use warnings";

package Jako::Construct::Block::Bare;

use Carp;

use Jako::Compiler;

use base qw(Jako::Construct::Block);


#
# compile()
#

sub compile
{
  my $self = shift;
  my ($compiler) = @_;

  my $namespace = "BARE"; # TODO: Don't we need to do better than this?

  if ($self->content) {
    $compiler->emit(".namespace ${namespace}");
    $compiler->indent;
    $self->SUPER::compile($compiler);
    $compiler->outdent;
    $compiler->emit(".endnamespace ${namespace}");
  }

  return 1;
}


#
# sax()
#

sub sax
{
  my $self = shift;
  my ($handler) = @_;

  $handler->start_element({ Name => 'block', Attributes => { kind => $self->kind } });
  $_->sax($handler) foreach $self->content;
  $handler->end_element({ Name => 'block' });
}


1;
