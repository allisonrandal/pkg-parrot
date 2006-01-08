# Copyright: 2001-2003 The Perl Foundation.  All Rights Reserved.
# $Id: core_pmcs.pm 10653 2005-12-25 08:55:48Z jhoblitt $

=head1 NAME

config/gen/core_pmcs.pm - Core PMC List

=head1 DESCRIPTION

Generates the core PMC list F<include/parrot/core_pmcs.h>.

=cut

package gen::core_pmcs;

use strict;
use vars qw($description $result @args);

use base qw(Parrot::Configure::Step::Base);

use Parrot::Configure::Step ':gen';

$description = "Generating core pmc list...";

@args = ();

sub runstep
{
    my ($self, $conf) = @_;

    $self->generate_h($conf);
    $self->generate_c($conf);
    $self->generate_pm($conf);
}

sub generate_h
{
    my ($self, $conf) = @_;

    my $file = "include/parrot/core_pmcs.h";
    open(OUT, ">$file.tmp");

    print OUT <<"END";
/*
 * DO NOT EDIT THIS FILE
 *
 * Automatically generated by config/gen/core_pmcs.pl
 */

/* &gen_from_enum(pmctypes.pasm) subst(s/enum_class_(\\w+)/\$1/e) */
enum {
END

    my @pmcs = split(/ /, $conf->data->get('pmc_names'));
    print OUT "    enum_class_default,\n";
    my $i = 1;
    foreach (@pmcs) {
        print OUT "    enum_class_$_,\t/*  $i */ \n";
        $i++;
    }
    print OUT <<"END";
    enum_class_core_max
};

/* &end_gen */
END

    close OUT;

    move_if_diff("$file.tmp", $file);
}

sub generate_c
{
    my ($self, $conf) = @_;

    my $file = "src/core_pmcs.c";
    my @pmcs = split(/ /, $conf->data->get('pmc_names'));

    open(OUT, ">$file.tmp");

    print OUT <<"END";
/*
 * DO NOT EDIT THIS FILE
 *
 * Automatically generated by config/gen/core_pmcs.pl
 */

#include "parrot/parrot.h"

END

    print OUT "extern void Parrot_${_}_class_init(Interp *, int, int);\n" foreach (@pmcs);

    print OUT <<"END";

static void Parrot_register_core_pmcs(Interp *interp, PMC* registry);
extern void Parrot_initialize_core_pmcs(Interp *interp);
void Parrot_initialize_core_pmcs(Interp *interp)
{
    int pass;
    for (pass = 0; pass <= 1; ++pass) {
	/* first the PMC with the highest enum
	 * this reduces MMD table resize action
 	 */
END

    print OUT "        Parrot_${_}_class_init(interp, enum_class_${_}, pass);\n" foreach (@pmcs[-1 .. -1]);
    print OUT "        Parrot_${_}_class_init(interp, enum_class_${_}, pass);\n"
        foreach (@pmcs[0 .. $#pmcs - 1]);
    print OUT <<"END";
	if (!pass) {
	    PMC *classname_hash, *iglobals;
	    int i;
	    /* Need an empty stash */
	    interp->globals = mem_sys_allocate(sizeof(struct Stash));
	    interp->globals->stash_hash =
		pmc_new(interp, enum_class_Hash);
	    interp->globals->parent_stash = NULL;
            /* We need a class hash */
            interp->class_hash = classname_hash =
                pmc_new(interp, enum_class_Hash);
	    Parrot_register_core_pmcs(interp, classname_hash);
	    /* init the interpreter globals array */
	    iglobals = pmc_new(interp, enum_class_SArray);
	    interp->iglobals = iglobals;
	    VTABLE_set_integer_native(interp, iglobals, (INTVAL)IGLOBALS_SIZE);
	    /* clear the array */
	    for (i = 0; i < (INTVAL)IGLOBALS_SIZE; i++)
		VTABLE_set_pmc_keyed_int(interp, iglobals, i, NULL);
	}
    }
}

static void register_pmc(Interp *interp, PMC* registry, int pmc_id)
{
    STRING* key = Parrot_base_vtables[pmc_id]->whoami;
    VTABLE_set_integer_keyed_str(interp, registry, key, pmc_id);
}

static void
Parrot_register_core_pmcs(Interp *interp, PMC* registry)
{
END

    print OUT "    register_pmc(interp, registry, enum_class_$_);\n" foreach (@pmcs);
    print OUT <<"END";
}
END

    close OUT;

    move_if_diff("$file.tmp", $file);
}

sub generate_pm
{
    my ($self, $conf) = @_;

    my $file = "lib/Parrot/PMC.pm";
    my @pmcs = split(/ /, $conf->data->get('pmc_names'));

    open(OUT, ">$file.tmp");

    print OUT <<'END';
# DO NOT EDIT THIS FILE
#
# Automatically generated by config/gen/core_pmcs.pl

package Parrot::PMC;
use vars qw(@ISA %pmc_types @EXPORT_OK);

@ISA = qw( Exporter );
@EXPORT_OK = qw( %pmc_types);

%pmc_types = (
END

    for my $num (0 .. $#pmcs) {
        my $id = $num + 1;
        print OUT "\t$pmcs[$num] => $id,\n";
    }

    print OUT <<"END";
);

1;
END

    close OUT;

    move_if_diff("$file.tmp", $file);
}

1;
