# Copyright: 2001-2003 The Perl Foundation.  All Rights Reserved.
# $Id: encoding.pm 10472 2005-12-12 22:12:28Z particle $

=head1 NAME

config/inter/encoding.pm - encoding files

=head1 DESCRIPTION

Asks the user to select which encoding files to include.

=cut

package Configure::Step;

use strict;
use vars qw($description $result @args);

use base qw(Parrot::Configure::Step::Base);

use Parrot::Configure::Step ':inter';

$description = 'Determining what encoding files should be compiled in...';

@args=qw(ask encoding);

sub runstep {
    my $self = shift;
  my @encoding=(
    sort
    map  { m{\./src/encodings/(.*)} }
    glob "./src/encodings/*.c"
  );

  my $encoding_list = $_[1] || join(' ', grep {defined $_} @encoding);

  if($_[0]) {
  print <<"END";


The following encodings are available:
  @encoding
END
    {
      $encoding_list = prompt('Which encodings would you like?', $encoding_list);
    }
  }
  # names of class files for src/classes/Makefile
  (my $TEMP_encoding_o = $encoding_list) =~ s/\.c/\$(O)/g;

  my $TEMP_encoding_build = <<"E_NOTE";

# the following part of the Makefile was built by 'config/inter/encoding.pl'

E_NOTE

  foreach my $encoding (split(/\s+/, $encoding_list)) {
      $encoding =~ s/\.c$//;
      $TEMP_encoding_build .= <<END
src/encodings/$encoding\$(O): src/encodings/$encoding.h src/encodings/$encoding.c \$(NONGEN_HEADERS)


END
  }

  # build list of libraries for link line in Makefile
  my $slash = Parrot::Configure::Data->get('slash');
  $TEMP_encoding_o  =~ s/^| / src${slash}encodings${slash}/g;

  Parrot::Configure::Data->set(
    encoding             => $encoding_list,
    TEMP_encoding_o           => $TEMP_encoding_o,
    TEMP_encoding_build       => $TEMP_encoding_build,
  );
}

1;