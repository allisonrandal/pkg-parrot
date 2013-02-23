# Copyright (C) 2001-2003 The Perl Foundation.  All rights reserved.
# $Id: trace.pasm 10798 2005-12-30 19:22:44Z particle $

=head1 NAME

examples/pasm/trace.pasm - Tracing

=head1 SYNOPSIS

    % ./parrot examples/pasm/trace.pasm

=head1 DESCRIPTION

Shows you what happens when you turn on tracing.

=cut

sweepoff
print "Howdy!\n"
trace 1
print "There!\n"
trace 0
print "Partner!\n"
end
