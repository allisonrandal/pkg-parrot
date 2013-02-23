#!perl

# $Id: m4.pl 5896 2004-04-20 08:36:57Z leo $

# pragmata
use strict;
use 5.005;
use lib './Perl5/lib';

use Language::m4;

exit( Language::m4::main() );
