# Copyright: 2005 The Perl Foundation.  All Rights Reserved.
# $Id: hpux.pm 9954 2005-11-13 22:06:22Z jhoblitt $

my $libs = Parrot::Configure::Data->get('libs');
if ( $libs !~ /-lpthread/ ) {
    $libs .= ' -lpthread';
}

Parrot::Configure::Data->set(
    libs => $libs,
);
