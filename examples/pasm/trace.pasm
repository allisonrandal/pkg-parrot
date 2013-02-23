# Copyright (C) 2001-2003 The Perl Foundation.  All rights reserved.
# $Id: trace.pasm 9780 2005-11-04 17:52:59Z bernhard $

=head1 NAME

examples/assembly/trace.pasm - Tracing

=head1 SYNOPSIS

    % ./parrot examples/assembly/trace.pasm

=head1 DESCRIPTION

Shows you what happens when you turn on tracing.

=cut

print "Howdy!\n"
trace 1
print "There!\n"
trace 0
print "Partner!\n"
end
