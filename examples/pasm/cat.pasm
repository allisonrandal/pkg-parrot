# Copyright (C) 2001-2003, The Perl Foundation.
# $Id: /local/examples/pasm/cat.pasm 12835 2006-05-30T13:32:26.641316Z coke  $

=head1 NAME

examples/pasm/cat.pasm - cat-like utility

=head1 SYNOPSIS

    % ./parrot examples/pasm/cat.pasm

=head1 DESCRIPTION

Simple C<cat>-like utility to test PIO read/write. Does not use STDIO.

Echoes what you type once you hit return. 

You'll have to Ctl-C to exit.

=cut

	getstdin P0
	getstdout P1
REDO:
	readline S0, P0
	print S0
	if S0, REDO
	end
