# Copyright (C) 2001-2003, The Perl Foundation.
# $Id: /local/examples/pasm/trace.pasm 12835 2006-05-30T13:32:26.641316Z coke  $

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
