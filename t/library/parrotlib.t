# Copyright (C) 2001-2005 The Perl Foundation.  All rights reserved.
# $Id: parrotlib.t 7803 2005-04-11 13:37:27Z leo $

=head1 NAME

t/library/parrotlib.t - testing library/parrotlib.imc

=head1 SYNOPSIS

	% perl -Ilib t/library/parrotlib.t

=head1 DESCRIPTION

This test program test whether the library 'parrotlib.imc' returns the
expected absolute filenames.

=cut

use strict;

use Parrot::Test tests => 6;
use Parrot::Config;


# Common code in the test files

my $template_top = << 'END_CODE';
.sub _main 

  load_bytecode 'runtime/parrot/include/parrotlib.pbc'
  .local pmc    location_sub
  .local string location
END_CODE

my $template_bottom = << 'END_CODE';
  print location
  print "\n"

  end
.end
END_CODE


# Testing include_file_location 

pir_output_is( << "END_CODE", << 'END_OUT', 'include_file_location' );
$template_top
  location_sub = find_global "_parrotlib", "include_file_location"
  location     = location_sub( 'datatypes.pasm' )
$template_bottom
END_CODE
runtime/parrot/include/datatypes.pasm
END_OUT

pir_output_is( << "END_CODE", << 'END_OUT', 'include_file_location, non-existent' );
$template_top
  location_sub = find_global "_parrotlib", "include_file_location"
  location     = location_sub( 'nonexistent.pasm' )
$template_bottom
END_CODE

END_OUT


# Testing imcc_compile_file_location

pir_output_is( << "END_CODE", << 'END_OUT', 'imcc_compile_file_location' );
$template_top
  location_sub = find_global "_parrotlib", "imcc_compile_file_location"
  location     = location_sub( 'parrotlib.pbc' )
$template_bottom
END_CODE
runtime/parrot/include/parrotlib.pbc
END_OUT

pir_output_is( << "END_CODE", << 'END_OUT', 'imcc_compile_file_location, non-existent' );
$template_top
  location_sub = find_global "_parrotlib", "imcc_compile_file_location"
  location     = location_sub( 'nonexistent.pbc' )
$template_bottom
END_CODE

END_OUT


# Testing dynext_location

pir_output_is( << "END_CODE", << "END_OUT", 'dynext_location' );
$template_top
  location_sub = find_global "_parrotlib", "dynext_location"
  location     = location_sub( 'libnci_test', '$PConfig{load_ext}' )
$template_bottom
END_CODE
runtime/parrot/dynext/libnci_test$PConfig{load_ext}
END_OUT

pir_output_is( << "END_CODE", << 'END_OUT', 'dynext_location, non-existent' );
$template_top
  location_sub = find_global "_parrotlib", "imcc_compile_file_location"
  location     = location_sub( 'nonexistent', '$PConfig{load_ext}' )
$template_bottom
END_CODE

END_OUT

=head1 AUTHOR

Bernhard Schmalhofer <Bernhard.Schmalhofer@gmx.de>

=head1 SEE ALSO

F<runtime/parrot/library/parrotlib.imc>