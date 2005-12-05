# Copyright: 2005 The Perl Foundation.  All Rights Reserved.
# $Id: os2.pm 9954 2005-11-13 22:06:22Z jhoblitt $

# This hints file is very specific to a particular os/2 configuration.
# A more general one would be appreciated, should anyone actually be
# using OS/2
Parrot::Configure::Data->set(
  libs => "-lm -lsocket -lcExt -lbsd",
  iv => "long",
  nv => "double",
  opcode_t =>"long",
  ccflags => "-I. -fno-strict-aliasing -mieee-fp -I./include",
  ldflags => "-Zexe",
  perl => "perl" # avoids case-mangling in make
);
