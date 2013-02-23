# Copyright (C) 2001-2003, Parrot Foundation.
# $Id: trace.pasm 37201 2009-03-08 12:07:48Z fperrad $

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
