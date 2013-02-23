#! perl
# Copyright (C) 2006-2007, The Perl Foundation.
# $Id: /parrotcode/local/languages/WMLScript/t/logical.t 733 2006-12-17T23:24:17.491923Z chromatic  $

=head1 NAME

t/logical.t - Logical operators

=head1 SYNOPSIS

    % perl -I../lib WMLScript/t/logical.t

=head1 DESCRIPTION

Test opcodes C<SCAND> and C<SCOR>.

=cut

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin";

use Parrot::Test tests => 18;
use Test::More;

language_output_is( 'WMLScript', <<'CODE', <<'OUT', '3 && 2', cflags => '-On' );
extern function main()
{
    var a = 3 && 2;

    Console.println(a);
    Console.println(typeof a);
}
CODE
true
3
OUT

language_output_is( 'WMLScript', <<'CODE', <<'OUT', '1 && 0', cflags => '-On' );
extern function main()
{
    var a = 1 && 0;

    Console.println(a);
    Console.println(typeof a);
}
CODE
false
3
OUT

language_output_is( 'WMLScript', <<'CODE', <<'OUT', '1 && invalid', cflags => '-On' );
extern function main()
{
    var a = 1 && invalid;

    Console.println(typeof a);
}
CODE
4
OUT

language_output_is( 'WMLScript', <<'CODE', <<'OUT', '0 && 2', cflags => '-On' );
extern function main()
{
    var a = 0 && 2;

    Console.println(a);
    Console.println(typeof a);
}
CODE
false
3
OUT

language_output_is( 'WMLScript', <<'CODE', <<'OUT', '0 && 0', cflags => '-On' );
extern function main()
{
    var a = 0 && 0;

    Console.println(a);
    Console.println(typeof a);
}
CODE
false
3
OUT

language_output_is( 'WMLScript', <<'CODE', <<'OUT', '0 && invalid', cflags => '-On' );
extern function main()
{
    var a = 0 && invalid;

    Console.println(a);
    Console.println(typeof a);
}
CODE
false
3
OUT

language_output_is( 'WMLScript', <<'CODE', <<'OUT', 'invalid && 2', cflags => '-On' );
extern function main()
{
    var a = invalid && 2;

    Console.println(typeof a);
}
CODE
4
OUT

language_output_is( 'WMLScript', <<'CODE', <<'OUT', 'invalid && 0', cflags => '-On' );
extern function main()
{
    var a = invalid && 0;

    Console.println(typeof a);
}
CODE
4
OUT

language_output_is( 'WMLScript', <<'CODE', <<'OUT', 'invalid && invalid', cflags => '-On' );
extern function main()
{
    var a = invalid && invalid;

    Console.println(typeof a);
}
CODE
4
OUT

language_output_is( 'WMLScript', <<'CODE', <<'OUT', '3 || 2', cflags => '-On' );
extern function main()
{
    var a = 3 || 2;

    Console.println(a);
    Console.println(typeof a);
}
CODE
true
3
OUT

language_output_is( 'WMLScript', <<'CODE', <<'OUT', '1 || 0', cflags => '-On' );
extern function main()
{
    var a = 1 || 0;

    Console.println(a);
    Console.println(typeof a);
}
CODE
true
3
OUT

language_output_is( 'WMLScript', <<'CODE', <<'OUT', '1 || invalid', cflags => '-On' );
extern function main()
{
    var a = 1 || invalid;

    Console.println(a);
    Console.println(typeof a);
}
CODE
true
3
OUT

language_output_is( 'WMLScript', <<'CODE', <<'OUT', '0 || 2', cflags => '-On' );
extern function main()
{
    var a = 0 || 2;

    Console.println(a);
    Console.println(typeof a);
}
CODE
true
3
OUT

language_output_is( 'WMLScript', <<'CODE', <<'OUT', '0 || 0', cflags => '-On' );
extern function main()
{
    var a = 0 || 0;

    Console.println(a);
    Console.println(typeof a);
}
CODE
false
3
OUT

language_output_is( 'WMLScript', <<'CODE', <<'OUT', '0 || invalid', cflags => '-On' );
extern function main()
{
    var a = 0 || invalid;

    Console.println(typeof a);
}
CODE
4
OUT

language_output_is( 'WMLScript', <<'CODE', <<'OUT', 'invalid || 2', cflags => '-On' );
extern function main()
{
    var a = invalid || 2;

    Console.println(typeof a);
}
CODE
4
OUT

language_output_is( 'WMLScript', <<'CODE', <<'OUT', 'invalid || 0', cflags => '-On' );
extern function main()
{
    var a = invalid || 0;

    Console.println(typeof a);
}
CODE
4
OUT

language_output_is( 'WMLScript', <<'CODE', <<'OUT', 'invalid || invalid', cflags => '-On' );
extern function main()
{
    var a = invalid || invalid;

    Console.println(typeof a);
}
CODE
4
OUT

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
