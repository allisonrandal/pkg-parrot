# $Id: /local/languages/m4/src/output.pir 11903 2006-03-14T20:49:11.779219Z bernhard  $

=head1 NAME 

output.pir - handle output for Parrot m4

=head1 DESCRIPTION

Copyright:  2004 Bernhard Schmalhofer. All Rights Reserved.
SVN Info:   $Id: /local/languages/m4/src/output.pir 11903 2006-03-14T20:49:11.779219Z bernhard  $
Overview:   output
History:    Ported from GNU m4 1.4
References: http://www.gnu.org/software/m4/m4.html

=head1 SUBROUTINES

=head2 void shipout_text( Hash state )

Does only a simple print rightnow.

TODO: Support for sync lines.

=cut

.sub shipout_text 
  .param pmc      state 
  .param string   text 

  print text
.end
