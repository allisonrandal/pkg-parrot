# Copyright: 2005 The Perl Foundation.  All Rights Reserved.
# $Id: msys.pm 9954 2005-11-13 22:06:22Z jhoblitt $

{
	my %args;
	@args{@args}=@_;

	Parrot::Configure::Data->set(
		ld => '$(PERL) /bin/perlld',
		ld_load_flags => '-shared ',
		libs => '-lmsvcrt -lmoldname -lkernel32 -luser32 -lgdi32 -lwinspool -lcomdlg32 -ladvapi32 -lshell32 -lole32 -loleaut32 -lnetapi32 -luuid -lws2_32 -lmpr -lwinmm -lversion -lodbc32 ',
		ncilib_link_extra => 'src/libnci_test.def',
	);

}
