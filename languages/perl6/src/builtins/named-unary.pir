## $Id: /local/languages/perl6/src/builtins/named-unary.pir 13523 2006-07-24T15:49:07.843920Z chip  $

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


## vim: expandtab sw=4
