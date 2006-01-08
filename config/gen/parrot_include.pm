# Copyright: 2001-2003 The Perl Foundation.  All Rights Reserved.
# $Id: parrot_include.pm 10653 2005-12-25 08:55:48Z jhoblitt $

=head1 NAME

config/gen/parrot_include.pm - Runtime Includes

=head1 DESCRIPTION

Generates the F<runtime/parrot/include> files.

=cut

package gen::parrot_include;

use strict;
use vars qw($description $result @args);

use base qw(Parrot::Configure::Step::Base);

use Parrot::Configure::Step ':gen';

$description = "Generating runtime/parrot/include...";

my @files = qw(
    include/parrot/cclass.h
    include/parrot/core_pmcs.h
    include/parrot/datatypes.h
    include/parrot/enums.h
    include/parrot/exceptions.h
    include/parrot/interpreter.h
    include/parrot/io.h
    include/parrot/longopt.h
    include/parrot/mmd.h
    include/parrot/resources.h
    include/parrot/stat.h
    include/parrot/string.h
    include/parrot/vtable.h
    include/parrot/warnings.h
    src/classes/timer.pmc
    src/utils.c
);
my $destdir = 'runtime/parrot/include';

@args = qw(verbose);

sub runstep
{
    my ($self, $conf) = @_;

    # need vtable.h now
    system($^X, "tools/build/vtable_h.pl");
    my @generated = ();
    for my $f (@files) {
        my $in_def = ''; # in #define='def', in enum='enum'
        my ($inc, $prefix, $last_val, $subst, %values);
        my (%var, $match, $block);
        open F, "<$f" or die "Can't open $f\n";
        while (<F>) {
            if (
                m!
	        &gen_from_(enum|def|template)\((.*?)\)
		(\s+prefix\((\w+)\))?
		(\s+subst\((s/.*?/.*?/\w*)\))?
		!x
                ) {
                $inc = $2;
                print "$2 " if $conf->options->get('verbose');
                $prefix = ($4 || '');
                $subst  = ($6 || '');
                $in_def = $1;
                $last_val = -1;
                %values   = ();
                open INC, ">$inc.tmp" or die "Can't write $inc.tmp";
                print INC "/*\n" if $inc =~ /\.h/;
                print INC <<"EOF";
# DO NOT EDIT THIS FILE.
#
# This file is generated automatically from
# $f by config/gen/parrot_include.pl
#
# Any changes made here will be lost.
#
EOF
                print INC "*/\n" if $inc =~ /\.h/;
                next;
            }
            if (/&end_gen/) {
                close INC;
                my $destfile = ($inc =~ m[/]) ? "$inc" : "$destdir/$inc";

                #move_if_diff("$inc.tmp", "$destdir/$inc");
                #push(@generated, "$destdir/$inc");
                move_if_diff("$inc.tmp", "$destfile");
                push(@generated, "$destfile");
                $in_def = '';
                next;
            }
            if ($in_def eq 'def') {
                if (/#define\s+(\w+)\s+(-?\w+|".*?")/) {
                    local $_ = "$prefix$1\t$2";
                    eval $subst if ($subst ne '');
                    print INC ".constant $_\n";
                }
            } elsif ($in_def eq 'enum') {
                if (/(\w+)\s+=\s+(-?\w+)/) {
                    local $_;
                    if (defined($values{$2})) {
                        $_        = "$prefix$1\t" . $values{$2};
                        $last_val = $values{$2};
                    } else {
                        $_        = "$prefix$1\t$2";
                        $last_val = $2;
                    }
                    $values{$1} = $2;
                    eval $subst if ($subst ne '');
                    print INC ".constant $_\n";
                } elsif (/^\s+(\w+)\s*(?!=)/) {
                    $last_val++;
                    $values{$1} = $last_val;
                    local $_ = "$prefix$1\t$last_val";
                    eval $subst if ($subst ne '');
                    print INC ".constant $_\n";
                }
            } elsif ($in_def eq 'template') {
                if (/match{(.*)}/) {
                    $match = $1;
                    next;
                }
                if (/eval{{/) {
                    while (<F>) {
                        last if /}}/;
                        $block .= $_;
                    }
                    next;
                }
                if (/$match/) {
                    select INC;
                    eval $block;
                    select STDOUT;
                    die $@ if $@;
                }
            }

        }
        if ($in_def ne '') {
            die "Missing '&end_gen' in $f\n";
        }
        close(F);
    }
    $conf->data->set(TEMP_gen_pasm_includes => join("\t\\\n\t", @generated));
}

1;
