# $Id: hello.pasm 37201 2009-03-08 12:07:48Z fperrad $

=head1 NAME

hello.pasm - Hello World

=head1 DESCRIPTION

This is also used in the top Makefile,
for showing how to create an executable from PASM.

=cut

    # Get @ARGV as a ResizableStringArray
    get_params "0", P0

    # Discard the program name
    shift S0, P0

    # Look for additional args
    if P0, FOUND_EXTRA_ARG
        print "Hello World\n"
        end

FOUND_EXTRA_ARG:
    shift S1, P0
    print "Hello "
    print S1
    print "\n"
    end
