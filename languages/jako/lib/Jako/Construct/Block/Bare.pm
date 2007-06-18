#
# Bare.pm
#
# Copyright (C) 2002-2005, The Perl Foundation.
# This program is free software. It is subject to the same license
# as the Parrot interpreter.
#
# $Id: /parrotcode/local/languages/jako/lib/Jako/Construct/Block/Bare.pm 880 2006-12-25T21:27:41.153122Z chromatic  $
#

use strict;
use warnings;

package Jako::Construct::Block::Bare;

use Carp;

use Jako::Compiler;

use base qw(Jako::Construct::Block);

#
# compile()
#

sub compile {
    my $self = shift;
    my ($compiler) = @_;

    my $namespace = "BARE";    # TODO: Don't we need to do better than this?

    if ( $self->content ) {
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

sub sax {
    my $self = shift;
    my ($handler) = @_;

    $handler->start_element( { Name => 'block', Attributes => { kind => $self->kind } } );
    $_->sax($handler) foreach $self->content;
    $handler->end_element( { Name => 'block' } );
}

1;

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
