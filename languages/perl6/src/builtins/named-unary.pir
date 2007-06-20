## $Id: named-unary.pir 18087 2007-04-09 22:02:45Z paultcochrane $

=head1 NAME

src/builtins/named-unary.pir - Perl6 named unary builtins

=head1 Functions

=over 4

=cut

.namespace

.sub 'defined'
    .param pmc x
    $I0 = defined x
    .return ($I0)
.end


=back

=cut

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
