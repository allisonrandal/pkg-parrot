# Copyright (C) 2001-2005 The Perl Foundation.  All rights reserved.
# $Id: stack.pasm 9765 2005-11-03 22:30:08Z bernhard $

=head1 NAME

examples/assembly/stack.pasm - User Stack

=head1 SYNOPSIS

    % ./parrot examples/assembly/stack.pasm

=head1 DESCRIPTION

Shows you how to C<set>, C<save>, C<restore> and C<print>.

=cut

	set I1, 0
	save I1
	set I1, 1
	save I1
	set I1, 2
	save I1
	set I1, 3
	save I1
	set I1, 4
	save I1
	set I1, 5
	save I1
	set I1, 6
	save I1
	set I1, 7
	save I1
	set I1, 8
	save I1
	set I1, 9
	save I1
	set I1, 0
	save I1
	set I1, 1
	save I1
	set I1, 2
	save I1
	set I1, 3
	save I1
	set I1, 4
	save I1
	set I1, 5
	save I1
	set I1, 6
	save I1
	set I1, 7
	save I1
	set I1, 8
	save I1
	set I1, 9
	restore I1
	print I1
	restore I1
	print I1
	restore I1
	print I1
	restore I1
	print I1
	restore I1
	print I1
	restore I1
	print I1
	restore I1
	print I1
	restore I1
	print I1
	restore I1
	print I1
	restore I1
	print I1
	restore I1
	print I1
	restore I1
	print I1
	restore I1
	print I1
	restore I1
	print I1
	restore I1
	print I1
	restore I1
	print I1
	restore I1
	print I1
	restore I1
	print I1
	restore I1
	print I1
	set I1, 0
	print I1
	save I1
	set I1, 1
	print I1
	save I1
	set I1, 2
	print I1
	save I1
	set I1, 3
	print I1
	save I1
	set I1, 4
	print I1
	save I1
	set I1, 5
	print I1
	save I1
	set I1, 6
	print I1
	save I1
	set I1, 7
	print I1
	save I1
	set I1, 8
	print I1
	save I1
	set I1, 9
	print I1
	save I1
	set I1, 0
	print I1
	save I1
	set I1, 1
	print I1
	save I1
	set I1, 2
	print I1
	save I1
	set I1, 3
	print I1
	save I1
	set I1, 4
	print I1
	save I1
	set I1, 5
	print I1
	save I1
	set I1, 6
	print I1
	save I1
	set I1, 7
	print I1
	save I1
	set I1, 8
	print I1
	save I1
	set I1, 9
	print I1
	print I1
	restore I1
	print I1
	restore I1
	print I1
	restore I1
	print I1
	restore I1
	print I1
	restore I1
	print I1
	restore I1
	print I1
	restore I1
	print I1
	restore I1
	print I1
	restore I1
	print I1
	restore I1
	print I1
	restore I1
	print I1
	restore I1
	print I1
	restore I1
	print I1
	restore I1
	print I1
	restore I1
	print I1
	restore I1
	print I1
	restore I1
	print I1
	restore I1
	print I1
	restore I1
	print I1
	print "\n"
 	end
