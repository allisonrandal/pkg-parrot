# $Id: /parrotcode/trunk/languages/plumhead/t/relops.t 470 2006-12-05T03:30:45.414067Z svm  $

=head1 NAME

plumhead/t/relops.t - tests for Plumhead

=head1 DESCRIPTION

Test relational ops.

=head1 TODO

Set up tests in an array, like in arithmetics.t

=cut

# pragmata
use strict;
use warnings;
use 5.006_001;

use FindBin;
use lib "$FindBin::Bin/../lib", "$FindBin::Bin/../../../lib";

use Parrot::Config (); 
use Parrot::Test;
use Test::More     tests => 12;

# True tests
my $expected = "Condition is true.\n";

language_output_is( 'Plumhead', <<'END_CODE', $expected, 'less than' );
<?php
if ( 1 < 2 )
{
?>
Condition is true.
<?php
}
else
{
?>
Condition is false.
<?php
}
?>
END_CODE


language_output_is( 'Plumhead', <<'END_CODE', $expected, 'less equal' );
<?php
if ( 1 <= 1 )
{
?>
Condition is true.
<?php
}
else
{
?>
Condition is false.
<?php
}
?>
END_CODE


language_output_is( 'Plumhead', <<'END_CODE', $expected, 'equal' );
<?php
if ( 1 == 1 )
{
?>
Condition is true.
<?php
}
else
{
?>
Condition is false.
<?php
}
?>
END_CODE


language_output_is( 'Plumhead', <<'END_CODE', $expected, 'greater equal' );
<?php
if ( 1 >= 1 )
{
?>
Condition is true.
<?php
}
else
{
?>
Condition is false.
<?php
}
?>
END_CODE


language_output_is( 'Plumhead', <<'END_CODE', $expected, 'greater than' );
<?php
if ( 2 > 1 )
{
?>
Condition is true.
<?php
}
else
{
?>
Condition is false.
<?php
}
?>
END_CODE


language_output_is( 'Plumhead', <<'END_CODE', $expected, 'unequal' );
<?php
if ( 1 != 2 )
{
?>
Condition is true.
<?php
}
else
{
?>
Condition is false.
<?php
}
?>
END_CODE

$expected = "Condition is false.\n";

language_output_is( 'Plumhead', <<'END_CODE', $expected, 'not less than' );
<?php
if ( 2 < 1 )
{
?>
Condition is true.
<?php
}
else
{
?>
Condition is false.
<?php
}
?>
END_CODE


language_output_is( 'Plumhead', <<'END_CODE', $expected, 'not less equal' );
<?php
if ( 2 <= 1 )
{
?>
Condition is true.
<?php
}
else
{
?>
Condition is false.
<?php
}
?>
END_CODE


language_output_is( 'Plumhead', <<'END_CODE', $expected, 'not equal' );
<?php
if ( 1 == 2 )
{
?>
Condition is true.
<?php
}
else
{
?>
Condition is false.
<?php
}
?>
END_CODE


language_output_is( 'Plumhead', <<'END_CODE', $expected, 'not greater equal' );
<?php
if ( 1 >= 2 )
{
?>
Condition is true.
<?php
}
else
{
?>
Condition is false.
<?php
}
?>
END_CODE


language_output_is( 'Plumhead', <<'END_CODE', $expected, 'not greater than' );
<?php
if ( 2 > 2 )
{
?>
Condition is true.
<?php
}
else
{
?>
Condition is false.
<?php
}
?>
END_CODE


language_output_is( 'Plumhead', <<'END_CODE', $expected, 'not unequal' );
<?php
if ( 1 != 1 )
{
?>
Condition is true.
<?php
}
else
{
?>
Condition is false.
<?php
}
?>
END_CODE
