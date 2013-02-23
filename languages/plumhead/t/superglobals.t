# $Id: /parrotcode/local/languages/plumhead/t/superglobals.t 2657 2007-03-31T01:57:48.733769Z chromatic  $

=head1 NAME

plumhead/t/superglobals.t - tests for Plumhead

=head1 DESCRIPTION

Test PHP superglobal variables.

=cut

# pragmata
use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../lib", "$FindBin::Bin/../../../lib";

use Parrot::Config (); 
use Parrot::Test;
use Test::More     tests => 3;

language_output_is( 'Plumhead', <<'END_CODE', <<'END_EXPECTED', 'php_sapi_name' );
<?php
echo php_sapi_name();
echo "\n";
?>
END_CODE
cgi-fcgi
END_EXPECTED

$ENV{REQUEST_TYPE} = 'GET';
$ENV{QUERY_STRING} = 'as=df';

language_output_is( 'Plumhead', <<'END_CODE', <<'END_EXPECTED', '$_GET' );
<?php
echo $_GET['as'];
echo "\n";
?>
END_CODE
df
END_EXPECTED

language_output_is( 'Plumhead', <<'END_CODE', <<'END_EXPECTED', 'var_dump( $_GET )' );
<?php
var_dump( $_GET );
echo "\n";
?>
END_CODE
array(1) {
  ["as"]=>
  string(2) "df"
}

END_EXPECTED
