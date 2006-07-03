#
# Construct.pm
#
# Abstract base class for parsed constructs (blocks, etc.).
#
# Copyright (C) 2002-2005, The Perl Foundation.
# This program is free software. It is subject to the same license
# as the Parrot interpreter.
#
# $Id: Construct.pm 12840 2006-05-30 15:08:05Z coke $
#

use strict;
eval "use warnings";

package Jako::Construct;

use base qw(Jako::Processor);

sub block  { return shift->{BLOCK};  }

1;

