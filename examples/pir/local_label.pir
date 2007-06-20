# Copyright (C) 2001-2007, The Perl Foundation.
# $Id: local_label.pir 18563 2007-05-16 00:53:55Z chromatic $

=head1 NAME

examples/pir/local_label.pir - Local labels

=head1 SYNOPSIS

    % ./parrot examples/pir/local_label.pir

=head1 DESCRIPTION

Show the use of a C<.local> label.

=cut

.macro TEST1 ()
    print     "Branching to '$ok' in macro 'TEST1'\n"
    branch    .$ok
    end
.local $ok:  
    print    "Branched to '$ok' in macro 'TEST1'\n"
.endm

.macro TEST2 ()
test2:        # not local
    print     "Branching to '$ok' in macro 'TEST2'\n"
    branch    .$ok
    end
.local $ok:  
    print    "Branched to '$ok' in macro 'TEST2'\n"
    branch   not_local
.endm

.sub "example" :main
    .TEST1 ()
    print "After .TEST1 ()\n"
    .TEST2 ()
    print "After .TEST2 ()\n"
    end
not_local:
    print    "Branched to 'non_local' in sub 'example'\n"
.end


# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
