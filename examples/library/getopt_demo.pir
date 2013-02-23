# Copyright (C) 2004-2005 The Perl Foundation.  All rights reserved.
# $Id: getopt_demo.pir 10106 2005-11-20 11:50:40Z bernhard $

=head1 NAME

examples/library/getopt_demo.imc - demonstrating library/Getopt/Long.pir

=head1 SYNOPSIS

    % ./parrot examples/library/getopt_demo.imc --help
    % ./parrot examples/library/getopt_demo.imc --version
    % ./parrot examples/library/getopt_demo.imc --string=asdf --bool --integer=42 some thing

=head1 DESCRIPTION

This demo program shows how to handle command line arguments with the
PIR library F<runtime/parrot/library/Getopt/Long.pir>.

=cut

=head1 SUBROUTINES

=head2 main

This is executed when you call F<getopt_demo.imc>.

=cut

.sub main @MAIN 
  .param pmc argv

  load_bytecode "Getopt/Long.pbc"
  .local pmc get_options
  find_global get_options, "Getopt::Long", "get_options"

  # Assemble specification for get_options
  # in an array of format specifiers
  .local pmc opt_spec    
  opt_spec = new ResizableStringArray 
  # --version, boolean
  push opt_spec, "version"
  # --help, boolean
  push opt_spec, "help"
  # --bool, boolean
  push opt_spec, "bool"
  # --string, string
  push opt_spec, "string=s"
  # --integer, integer
  push opt_spec, "integer=i"

  # the program name is the first element in argv
  .local string program_name
  program_name = shift argv

  # Make a copy of argv, because this can easier be handled in get_options()
  # TODO: remove need for cloning
  .local pmc argv_clone
  argv_clone = clone argv

  .local pmc opt
  ( opt ) = get_options( argv_clone, opt_spec )

  # Now we do what the passed options tell
  .local int is_defined

  # Was '--version' passed ?
  is_defined = defined opt["version"]
  unless is_defined goto NO_VERSION_FLAG
    print "getopt_demo.imc 0.03\n"
    end
  NO_VERSION_FLAG:

  # Was '--help' passed ?
  is_defined = defined opt["help"]
  unless is_defined goto NO_HELP_FLAG
    usage( program_name )
    end
  NO_HELP_FLAG:

  # Say Hi
  print "Hi, I am 'getopt_demo.imc'.\n"
  print "\n"

  # handle the bool option
  is_defined = defined opt["bool"]
  unless is_defined goto NO_BOOL_OPTION
    print "You have passed the option '--bool'.\n"
    goto END_BOOL_OPTION
  NO_BOOL_OPTION:
    print "You haven't passed the option '--bool'. This is fine with me.\n"
  END_BOOL_OPTION:

  # handle the string option
  is_defined = defined opt["string"]
  unless is_defined goto NO_STRING_OPTION
    .local string string_option
    string_option = opt["string"]
    print "You have passed the option '--string'. The value is '"
    print string_option
    print "'.\n"
    goto END_STRING_OPTION
  NO_STRING_OPTION:
    print "You haven't passed the option '--string'. This is fine with me.\n"
  END_STRING_OPTION:

  # handle the integer option
  is_defined = defined opt["integer"]
  unless is_defined goto NO_INTEGER_OPTION
    .local string integer_option
    integer_option = opt["integer"]
    print "You have passed the option '--integer'. The value is '"
    print integer_option
    print "'.\n"
    goto END_INTEGER_OPTION
  NO_INTEGER_OPTION:
    print "You haven't passed the option '--integer'. This is fine with me.\n"
  END_INTEGER_OPTION:

  # For some reason I can't shift from argv_clone
  .local string other_arg
  .local int    cnt_other_args
  cnt_other_args = 0
  .local int num_other_args
  num_other_args = argv_clone
  goto CHECK_OTHER_ARG_LOOP
  REDO_OTHER_ARG_LOOP:
    other_arg = argv_clone[cnt_other_args]
    print "You have passed the additional argument: '"
    print other_arg
    print "'.\n"
    inc cnt_other_args
  CHECK_OTHER_ARG_LOOP:
  if cnt_other_args < num_other_args goto REDO_OTHER_ARG_LOOP
  print "All args have been parsed.\n"
.end

=head2 usage

Print the usage message.

TODO: Pass a flag for EXIT_FAILURE and EXIT_SUCCESS

=cut

.sub usage 
  .param string program_name

  print "Usage: ./parrot "
  print program_name
  print " [OPTION]... [STRING]...\n"
  print "\n"
  print "Currently only long options are available.\n"
  print "\n"
  print "Operation modes:\n"
  print "      --help                   display this help and exit\n"
  print "      --version                output version information and exit\n"
  print "\n"
  print "For demo of option parsing:\n"
  print "      --string=STRING          a string option\n"
  print "      --integer=INTEGER        an integer option\n"
  print "      --bool                   a boolean option\n"
.end

=head1 AUTHOR

Bernhard Schmalhofer - C<Bernhard.Schmalhofer@gmx.de>

=head1 SEE ALSO

F<runtime/parrot/library/Getopt/Long.pir>

=cut