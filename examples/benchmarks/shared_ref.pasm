# Copyright (C) 2001-2003 The Perl Foundation.  All rights reserved.
# $Id: shared_ref.pasm 5175 2004-01-31 13:16:08Z mikescott $

=head1 NAME

examples/benchmarks/shared_ref.pasm - Shared reference between threads

=head1 SYNOPSIS

    % time ./parrot examples/benchmarks/shared_ref.pasm

=head1 DESCRIPTION

Shares references between threads.

=cut

      set I0, 100000
      set I1, 0
lp:
      new P0, .PerlInt
      new P1, .SharedRef, P0  # or .Ref
      set P1, I1
      inc I1
      lt I1, I0, lp
      end

=head1 SEE ALSO

F<examples/benchmarks/shared_ref.pl>.

=cut