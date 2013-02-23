#! perl
# Copyright (C) 2007, The Perl Foundation.
# $Id: /parrotcode/trunk/languages/lua/t/alarm.t 3437 2007-05-09T11:01:53.500408Z fperrad  $

=head1 NAME

t/alarm.t - Lua Alarm Library

=head1 SYNOPSIS

    % perl -I../lib -Ilua/t lua/t/alarm.t

=head1 DESCRIPTION

Tests Lua Alarm Library
(implemented in F<languages/lua/lib/alarm.pir>).

=cut

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin";

use Parrot::Test;
use Test::More;

if ( exists $ENV{PARROT_LUA_TEST_PROG} ) {
    plan skip_all => "parrot only";
}
else {
    plan tests => 6;
}

language_output_is( 'lua', << 'CODE', << 'OUTPUT', 'function alarm' );
require "alarm"
print(type(alarm))
CODE
function
OUTPUT

language_output_is( 'lua', << 'CODE', << 'OUTPUT', 'function alarm' );
require "alarm"

function myalarm ()
    print("in alarm!")
end

local function delay (d)
    local s = os.time()
    local e = s
    while (os.difftime(e, s) < d) do
        e = os.time()
    end
end

print("hello")
alarm(2, myalarm)
alarm(2)
delay(3)
CODE
hello
in alarm!
in alarm!
OUTPUT

language_output_like( 'lua', << 'CODE', << 'OUTPUT', 'function alarm (repeat)' );
require "alarm"

function myalarm()
    print("in alarm!",os.date"%H:%M:%S",a,math.floor(100*a/N).."%")
    alarm(1)
end

N=100000

print"hello"
alarm(1,myalarm)
a=0
for i=1,N do
    a=a+1
    math.sin(a) -- waste some time...
end
print(a)
print"bye"
CODE
/^hello\n(in alarm!\t\d\d:\d\d:\d\d\t\d+\t\d+%\n)+100000\nbye/gm
OUTPUT

language_output_like( 'lua', << 'CODE', << 'OUTPUT', 'function alarm (bad delay)' );
require "alarm"
alarm("bad")
CODE
/^[^:]+: [^:]+:\d+: bad argument #1 to 'alarm' \(number expected, got string\)\nstack traceback:\n/
OUTPUT

language_output_like( 'lua', << 'CODE', << 'OUTPUT', 'function alarm (no handler)' );
require "alarm"
alarm(1)
CODE
/^[^:]+: [^:]+:\d+: no alarm handler set\nstack traceback:\n/
OUTPUT

language_output_like( 'lua', << 'CODE', << 'OUTPUT', 'function alarm (bad handler)' );
require "alarm"
alarm(1, {})
CODE
/^[^:]+: [^:]+:\d+: bad argument #2 to 'alarm' \(function expected, got table\)\nstack traceback:\n/
OUTPUT

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
