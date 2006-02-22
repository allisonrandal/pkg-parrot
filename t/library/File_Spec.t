#!perl
# Copyright: 2001-2005 The Perl Foundation.  All Rights Reserved.
# $Id: File_Spec.t 11595 2006-02-16 19:58:01Z particle $

use strict;
use warnings;
use lib qw( t . lib ../lib ../../lib );
use Test::More;
use Parrot::Test;


=head1 NAME

t/library/File-Spec.t - test File::Spec module

=head1 SYNOPSIS

	% prove t/library/File-Spec.t

=head1 DESCRIPTION

Tests file specifications.

=cut


##############################
# File::Spec


my $PRE= <<'PRE';
.sub 'main' :main
	load_bytecode 'library/File/Spec.pir'

	.local int classtype
	.local pmc spec

	find_type classtype, 'File::Spec'
	new spec, classtype

PRE
my $POST= <<'POST';
	goto OK
NOK:
	print "not "
OK:
	print "ok"
END:
	print "\n"
.end
POST


## 1
pir_output_is(<<'CODE'.$POST, <<'OUT', "load_bytecode");
.sub 'main' :main
	load_bytecode 'File/Spec.pir'
CODE
ok
OUT


pir_output_is($PRE.<<'CODE'.$POST, <<'OUT', "new");
CODE
ok
OUT


my @meths= (qw/
	__isa VERSION devnull tmpdir case_tolerant file_name_is_absolute catfile
	catdir path canonpath splitpath splitdir catpath abs2rel rel2abs
/);
pir_output_is($PRE.<<"CODE".$POST, <<'OUT', "can ($_)") for @meths;
	.local pmc meth
	\$I0 = can spec, "$_"
	unless \$I0, NOK
CODE
ok
OUT


pir_output_like($PRE.<<'CODE'.$POST, <<'OUT', "isa");
	.local pmc class
	class= new String

	class= spec.'__isa'()
	print class
	print "\n"
CODE
/^File::Spec::.+/
OUT


pir_output_is($PRE.<<'CODE'.$POST, <<'OUT', "version");
	.local pmc version
	version= spec.'VERSION'()
	print version
	goto END
CODE
0.1
OUT


## testing private subs
pir_output_is($PRE.<<'CODE'.$POST, <<"OUT", "_get_osname");
	.local string osname
	.local pmc get_osname
	get_osname = find_global 'File::Spec', '_get_osname'
	osname= get_osname()
	print osname
	goto END
CODE
$^O
OUT


pir_output_is($PRE.<<'CODE'.$POST, <<'OUT', "_get_module");
	.local string module
	.local pmc get_module
	get_module = find_global 'File::Spec', '_get_module'
	module= get_module( 'MSWin32' )
	print module
	print "\n"
	module= get_module( 'foobar' )
	print module
	goto END
CODE
Win32
Unix
OUT


# remember to change the number of tests! :-)
BEGIN {
	if( $^O eq 'MSWin32' ) {
		plan tests => 21;
	} else {
		plan skip_all => 'win32 implementation only' unless $^O =~ m/MSWin32/;
	}
}
