#! perl -w
# Copyright (C) 2006, The Perl Foundation.
# $Id: /local/languages/WMLScript/t/expr.t 13523 2006-07-24T15:49:07.843920Z chip  $

=head1 NAME

t/expr.t - WMLScript expressions

=head1 SYNOPSIS

    % perl -I../lib -IWMLScript/t WMLScript/t/expr.t

=head1 DESCRIPTION


=cut

use strict;
use FindBin;
use lib "$FindBin::Bin";

use Parrot::Test tests => 2;
use Test::More;

language_output_is( 'WMLScript', <<'CODE', <<'OUT', 'assign', cflags => '-On');
extern function main()
{
    var a = "abc";
    var b = a;
    b = "def";
    Console.println(a);
    Console.println(b);
}
CODE
abc
def
OUT

language_output_is( 'WMLScript', <<'CODE', <<'OUT', 'incr', cflags => '-On');
extern function main()
{
    var a = 10;
    var b = a;
    b ++;
    Console.println(a);
    Console.println(b);
}
CODE
10
11
OUT

