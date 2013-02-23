#
# Else.pm
#
# Copyright (C) 2002-2005, The Perl Foundation.
# This program is free software. It is subject to the same license
# as the Parrot interpreter.
#
# $Id: /parrotcode/local/languages/jako/lib/Jako/Construct/Block/Conditional/Else.pm 880 2006-12-25T21:27:41.153122Z chromatic  $
#

use strict;
use warnings;

package Jako::Construct::Block::Conditional::Else;

use Carp;

use base qw(Jako::Construct::Block::Conditional);

#
# new()
#

sub new {
    my $class = shift;

    confess "Expected parent block and peer block!" unless @_ == 2;

    my ( $block, $peer ) = @_;

    my $self = bless {
        BLOCK => $block,
        PEER  => $peer,

        KIND => 'else',

        CONTENT => []
    }, $class;

    $block->push_content($self);

    return $self;
}

sub peer { return shift->{PEER}; }

1;


# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
