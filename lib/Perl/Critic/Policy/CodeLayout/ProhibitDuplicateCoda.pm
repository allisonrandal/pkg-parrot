# $Id: /parrotcode/local/lib/Perl/Critic/Policy/CodeLayout/ProhibitDuplicateCoda.pm 2657 2007-03-31T01:57:48.733769Z chromatic  $
package Perl::Critic::Policy::CodeLayout::ProhibitDuplicateCoda;

use strict;
use warnings;
use Perl::Critic::Utils;
use Perl::Critic::Violation;
use base 'Perl::Critic::Policy';

=head1 NAME

Perl::Critic::Policy::CodeLayout::ProhibitDuplicateCoda

=head1 DESCRIPTION

Prohibit duplicate Parrot coda declarations.

=cut

our $VERSION = '0.1';
$VERSION = eval $VERSION;    ## no critic

my $desc = q{Found duplicate coda};
my $expl = q{One should not have more than one Parrot coda declaration per file};

#----------------------------------------------------------------------------

sub default_severity { return $SEVERITY_LOW }
sub applies_to       { return 'PPI::Document' }

#----------------------------------------------------------------------------

sub violates {
    my ( $self, $elem, $doc ) = @_;

    # search all comment nodes which match 'vim:' or 'Local Variables:'
    my $vim_count   = 0;
    my $emacs_count = 0;
    for ( my $node = $doc->first_element ; $node ; $node = $node->next_sibling ) {

        if ( $node->isa('PPI::Token::Comment') ) {
            $vim_count   += grep /vim:/,             $node;
            $emacs_count += grep /Local Variables:/, $node;

            return $self->violation( $desc, $expl, $node || $doc )
                if ( $vim_count > 1 or $emacs_count > 1 );
        }
        else {
            next;
        }

    }

    # we made it the whole way through, return success
    return;
}

1;

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4: