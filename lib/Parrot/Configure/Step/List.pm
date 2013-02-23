# Copyright (C) 2001-2006, The Perl Foundation.
# $Id: /parrotcode/trunk/lib/Parrot/Configure/Step/List.pm 3134 2007-04-12T00:32:35.049658Z jkeenan  $
package Parrot::Configure::Step::List;
use strict;
use warnings;
use base qw( Exporter );
our @EXPORT_OK = qw( get_steps_list );

# EDIT HERE TO ADD NEW TESTS
my @steps = qw(
    init::manifest
    init::defaults
    init::install
    init::miniparrot
    init::hints
    init::headers
    inter::progs
    inter::make
    inter::lex
    inter::yacc
    auto::gcc
    auto::msvc
    init::optimize
    inter::shlibs
    inter::libparrot
    inter::charset
    inter::encoding
    inter::types
    inter::ops
    inter::pmc
    auto::alignptrs
    auto::headers
    auto::sizes
    auto::byteorder
    auto::va_ptr
    auto::pack
    auto::format
    auto::isreg
    auto::jit
    gen::cpu
    auto::funcptr
    auto::cgoto
    auto::inline
    auto::gc
    auto::memalign
    auto::signal
    auto::socklen_t
    auto::env
    auto::aio
    auto::gmp
    auto::readline
    auto::gdbm
    auto::snprintf
    auto::perldoc
    auto::python
    auto::m4
    auto::cpu
    gen::icu
    gen::revision
    gen::config_h
    gen::core_pmcs
    gen::parrot_include
    gen::languages
    gen::makefiles
    gen::platform
    gen::config_pm
);

sub get_steps_list { return @steps; }

1;

#################### DOCUMENTATION ####################

=head1 NAME

Parrot::Configure::Step::List - Get sequence of configuration steps

=head1 SYNOPSIS

    use Parrot::Configure::Step::List qw( get_steps_list );

    @steps = get_steps_list();

=head1 DESCRIPTION

Parrot::Configure::Step::List exports on demand a single subroutine,
C<get_steps_list()>.  This subroutine returns a list of Parrot's configuration
steps in the order in which they are to be executed.  To change the order in
which the steps are executed, edit C<@steps> inside this module.

=head1 SUBROUTINE

=head2 C<get_steps_list()>

=over 4

=item * Purpose

Provide Parrot configuration steps in their order of execution.

=item * Arguments

None.

=item * Return Value

List holding strings representing the configuration steps.

=item * Comment

=back

=head1 NOTES

The functionality in this package was transferred from F<Configure.pl> by Jim
Keenan.

=head1 SEE ALSO

F<Configure.pl>.

=cut

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4: