# Copyright: 2005 The Perl Foundation.  All Rights Reserved.
# $Id: hpux.pl 7525 2005-02-02 12:23:31Z leo $

my $libs = Configure::Data->get('libs');
if ( $libs !~ /-lpthread/ ) {
    $libs .= ' -lpthread';
}

Configure::Data->set(
    libs => $libs,
);
