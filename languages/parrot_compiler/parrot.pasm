# Copyright (C) 2002-2005, The Perl Foundation.
# $Id: /local/languages/parrot_compiler/parrot.pasm 12840 2006-05-30T15:08:05.048089Z coke  $

  # Get the input as a string, don't care about buffer overflow yet
  read S0, 1000000

  # Get a handle on the builtin PASM compiler
  compreg P1, "PASM"

  # compile the code
  set_args "(0)", S0
  get_results "(0)", P0
  invokecc P1	

  # evaluate the compiled code
  invokecc P0	
 
  end
