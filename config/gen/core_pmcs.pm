# Copyright (C) 2001-2009, Parrot Foundation.
# $Id: core_pmcs.pm 38777 2009-05-14 19:43:11Z petdance $

=head1 NAME

config/gen/core_pmcs.pm - Core PMC List

=head1 DESCRIPTION

Generates the core PMC list F<include/parrot/core_pmcs.h>.

=cut

package gen::core_pmcs;

use strict;
use warnings;


use base qw(Parrot::Configure::Step);

use Parrot::Configure::Utils ':gen';

sub _init {
    my $self = shift;
    my %data;
    $data{description} = q{Generate core pmc list};
    $data{result}      = q{};
    return \%data;
}

sub runstep {
    my ( $self, $conf ) = @_;

    $self->generate_h($conf);
    $self->generate_c($conf);
    $self->generate_pm($conf);

    return 1;
}

sub generate_h {
    my ( $self, $conf ) = @_;

    my $file = 'include/parrot/core_pmcs.h';
    $conf->append_configure_log($file);
    open( my $OUT, '>', "$file.tmp" );

    print {$OUT} <<'END_H';
/*
 * DO NOT EDIT THIS FILE
 *
 * Automatically generated by config/gen/core_pmcs.pm
 */

#ifndef PARROT_CORE_PMCS_H_GUARD
#define PARROT_CORE_PMCS_H_GUARD

/* &gen_from_enum(pmctypes.pasm) subst(s/enum_class_(\w+)/$1/e) */
enum {
END_H

    my @pmcs = split( qr/ /, $conf->data->get('pmc_names') );
    my $i = 0;
    foreach (@pmcs) {
        print {$OUT} "    enum_class_$_,\t/*  $i */\n";
        $i++;
    }
    print {$OUT} <<'END_H';
    enum_class_core_max
};

/* &end_gen */

#endif /* PARROT_CORE_PMCS_H_GUARD */
END_H
    print {$OUT} coda();

    close $OUT or die "Can't close file: $!";;

    move_if_diff( "$file.tmp", $file );

    return;
}

sub generate_c {
    my ( $self, $conf ) = @_;

    my $file = "src/core_pmcs.c";
    my @pmcs = split( qr/ /, $conf->data->get('pmc_names') );

    $conf->append_configure_log($file);
    open( my $OUT, '>', "$file.tmp" );

    print {$OUT} <<'END_C';
/*
 * DO NOT EDIT THIS FILE
 *
 * Automatically generated by config/gen/core_pmcs.pm
 */

/* HEADERIZER HFILE: none */
/* HEADERIZER STOP */

#include "parrot/parrot.h"

END_C

    print {$OUT} "extern void Parrot_${_}_class_init(PARROT_INTERP, int, int);\n" foreach (@pmcs);

    print {$OUT} <<'END_C';

/* This isn't strictly true, but the headerizer should not bother */

void Parrot_register_core_pmcs(PARROT_INTERP, NOTNULL(PMC *registry))
    __attribute__nonnull__(1)
    __attribute__nonnull__(2);

extern void Parrot_initialize_core_pmcs(PARROT_INTERP)
    __attribute__nonnull__(1);

void Parrot_initialize_core_pmcs(PARROT_INTERP)
{
    int pass;
    for (pass = 0; pass <= 1; ++pass) {
        /* first the PMC with the highest enum
         * this reduces MMD table resize action */
END_C

    print {$OUT} "        Parrot_${_}_class_init(interp, enum_class_${_}, pass);\n"
        foreach ( @pmcs[ -1 .. -1 ] );
    print {$OUT} "        Parrot_${_}_class_init(interp, enum_class_${_}, pass);\n"
        foreach ( @pmcs[ 0 .. $#pmcs - 1 ] );
    print {$OUT} <<'END_C';
        if (!pass) {
            parrot_global_setup_2(interp);
        }
    }
}

static void register_pmc(PARROT_INTERP, NOTNULL(PMC *registry), int pmc_id)
{
    STRING * const key = interp->vtables[pmc_id]->whoami;
    VTABLE_set_integer_keyed_str(interp, registry, key, pmc_id);
}

void
Parrot_register_core_pmcs(PARROT_INTERP, NOTNULL(PMC *registry))
{
END_C

    print {$OUT} "    register_pmc(interp, registry, enum_class_$_);\n" foreach (@pmcs);
    print {$OUT} <<'END_C';
}

END_C
    print {$OUT} coda();

    close $OUT or die "Can't close file: $!";

    move_if_diff( "$file.tmp", $file );

    return;
}

sub generate_pm {
    my ( $self, $conf ) = @_;

    my $file = "lib/Parrot/PMC.pm";
    my @pmcs = split( qr/ /, $conf->data->get('pmc_names') );

    $conf->append_configure_log($file);
    open( my $OUT, '>', "$file.tmp" );

    print $OUT <<'END_PM';
# DO NOT EDIT THIS FILE
#
# Automatically generated by config/gen/core_pmcs.pm

package Parrot::PMC;

use strict;
use warnings;

use vars qw(@ISA %pmc_types @EXPORT_OK);

@ISA = qw( Exporter );
@EXPORT_OK = qw( %pmc_types);

%pmc_types = (
END_PM

    for my $num ( 0 .. $#pmcs ) {
        my $id = $num + 1;
        print {$OUT} "\t$pmcs[$num] => $id,\n";
    }

    print {$OUT} <<'END_PM';
);

1;
END_PM

    close $OUT or die "Can't close file: $!";

    move_if_diff( "$file.tmp", $file );

    return;
}

sub coda {
    my $v = 'vim';

    # Translate it in code so vim doesn't think this file itself is readonly
    return <<"HERE"
/*
 * Local variables:
 *   c-file-style: "parrot"
 * End:
 * ${v}: readonly expandtab shiftwidth=4:
 */
HERE
}

1;

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
