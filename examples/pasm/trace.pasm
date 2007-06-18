# Copyright (C) 2001-2003, The Perl Foundation.
# $Id: /parrotcode/trunk/examples/pasm/trace.pasm 470 2006-12-05T03:30:45.414067Z svm  $

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
