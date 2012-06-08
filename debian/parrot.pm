#!/usr/bin/perl
# debhelper sequence file for dh_parrot

use strict;
use warnings;

use Debian::Debhelper::Dh_Lib;

insert_after("dh_perl", "dh_parrot");

1;
