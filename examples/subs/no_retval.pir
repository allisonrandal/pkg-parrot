# Copyright (C) 2001-2007, The Perl Foundation.
# $Id: /parrotcode/local/examples/subs/no_retval.pir 2657 2007-03-31T01:57:48.733769Z chromatic  $

=head1 NAME

examples/subs/no_retval.pir - Subroutine example

=head1 SYNOPSIS

    % ./parrot examples/subs/no_retval.pir

=head1 DESCRIPTION

Call a sub with no return values.

=head1 SEE ALSO

F<docs/imcc/syntax.pod>
F<docs/imcc/calling_conventions.pod>

=cut

.sub example :main
  foo(7, 8, "nine")
.end

.sub foo
  .param int i
  .param int j
  .param string s

  print i
  print " "
  print j
  print " "
  print s
  print "\n"
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
