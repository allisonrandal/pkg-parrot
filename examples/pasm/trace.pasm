# Copyright (C) 2001-2003, The Perl Foundation.
# $Id: trace.pasm 12835 2006-05-30 13:32:26Z coke $

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
