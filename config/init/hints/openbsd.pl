# Copyright: 2005 The Perl Foundation.  All Rights Reserved.
# $Id: openbsd.pl 7525 2005-02-02 12:23:31Z leo $


my $ccflags = Configure::Data->get('ccflags');
if ( $ccflags !~ /-pthread/ ) {
    $ccflags .= ' -pthread';
}
Configure::Data->set(
    ccflags => $ccflags,
);

my $libs = Configure::Data->get('libs');
if ( $libs !~ /-lpthread/ ) {
    $libs .= ' -lpthread';
}
Configure::Data->set(
    libs => $libs,
);
