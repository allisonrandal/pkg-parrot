# Copyright (C) 2001-2003, The Perl Foundation.
# $Id: /parrotcode/trunk/examples/io/pioctl.pasm 470 2006-12-05T03:30:45.414067Z svm  $

=head1 NAME

examples/io/pioctl.pasm - "pioctl" Examples

=head1 SYNOPSIS

    % ./parrot examples/io/pioctl.pasm

=head1 DESCRIPTION

Examples of use of the C<pioctl> op.

Currently just gets and sets the buffer size of F</etc/paswd>. 

=cut

# add lots of samples here

   open P0, "/etc/passwd", "<"
   pioctl I0, P0, 6, 0
   print "Bufsize "
   print I0
   print "\n"
   pioctl I0, P0, 5, 2222 
   pioctl I0, P0, 6, 0
   print "Bufsize "
   print I0
   print "\n"
   end
