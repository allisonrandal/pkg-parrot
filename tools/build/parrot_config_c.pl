#! perl
# Copyright (C) 2001-2006, The Perl Foundation.
# $Id: parrot_config_c.pl 17580 2007-03-17 22:53:00Z paultcochrane $

use warnings;
use strict;

my ($svnid) =
    '$Id: parrot_config_c.pl 17580 2007-03-17 22:53:00Z paultcochrane $' =~ /^\$[iI][dD]:\s(.*)\$$/;

=head1 NAME

tools/build/parrot_config_c.pl - Create src/parrot_config.c and variants

=head1 SYNOPSIS

    % perl tools/build/parrot_config_c.pl --mini > src/null_config.c
    % perl tools/build/parrot_config_c.pl --install > src/install_config.c
    % perl tools/build/parrot_config_c.pl > src/parrot_config.c

=head1 DESCRIPTION

Create F<src/parrot_config.c> with relevant runtime for the config
process.

The data in the generated configuration file is a serialised hash
which can be passed to the parrot VM by calling Parrot_set_config_hash
and will in turn be used to provide the config environment for
subsequently created Interpreters.

=cut

use strict;

my ( $mini_parrot, $install_parrot );

$mini_parrot    = 1 if @ARGV && $ARGV[0] =~ /mini/;
$install_parrot = 1 if @ARGV && $ARGV[0] =~ /install/;

print << "EOF";
/* ex: set ro:
 * !!!!!!!   DO NOT EDIT THIS FILE   !!!!!!!
 *
 * This file is generated automatically by $0.
 *
 * Any changes made here will be lost!
 *
 */

#include "parrot/parrot.h"

/* proto is in embed.h, but we don't include anything here, which
 * could pull in some globals
 */
void Parrot_set_config_hash(void);

void
Parrot_set_config_hash_internal (const unsigned char* parrot_config,
                                 unsigned int parrot_config_size);


static const unsigned char parrot_config[] = {
EOF

if ($mini_parrot) {
    print "    0\n";
}
else {

    my $image_file = $install_parrot ? 'install_config.fpmc' : 'runtime/parrot/include/config.fpmc';
    open my $F, '<', $image_file or die "Can't read '$image_file': $!";
    my $image;
    local $/;
    binmode $F;
    $_ = <$F>;
    close $F;

    my @c = split '';
    die "'$image_file' is truncated. Remove it and rerun make\n" if !@c;

    print '    ';
    my $i;
    for (@c) {
        printf "0x%02x", ord($_);
        ++$i;
        print ', ', if ( $i < scalar(@c) );
        print "\n    " unless $i % 8;
    }
    print "\n";
}

print << "EOF";
}; /* parrot_config */

void
Parrot_set_config_hash(void)
{
    Parrot_set_config_hash_internal(parrot_config, sizeof(parrot_config));
}
EOF

# append the C code coda
print << "EOC";

/*
 * Local variables:
 *   c-file-style: "parrot"
 * End:
 * vim: expandtab shiftwidth=4:
 */
EOC

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
