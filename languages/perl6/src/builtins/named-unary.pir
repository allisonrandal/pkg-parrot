## $Id: /parrotcode/trunk/languages/perl6/src/builtins/named-unary.pir 3064 2007-04-09T22:02:45.461387Z paultcochrane  $

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
