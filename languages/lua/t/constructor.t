#! perl -w
# Copyright: 2005 The Perl Foundation.  All Rights Reserved.
# $Id: constructor.t 10933 2006-01-06 01:43:24Z particle $

=head1 NAME

t/constructor.t - Lua Table Constructors

=head1 SYNOPSIS

    % perl -I../lib -Ilua/t lua/t/constructor.t

=head1 DESCRIPTION

See "Lua 5.0 Reference Manual", section 2.5.6 "Table Constructors".

See "Programming in Lua", section 3.6 "Table Constructors".

=cut

use strict;
use FindBin;
use lib "$FindBin::Bin";

use Parrot::Test tests => 5;

language_output_is( 'lua', <<'CODE', <<'OUT', 'list-style init' );
days = {"Sunday", "Monday", "Tuesday", "Wednesday",
        "Thursday", "Friday", "Saturday"}
print(days[4])
CODE
Wednesday
OUT

language_output_is( 'lua', <<'CODE', <<'OUT', 'record-style init' );
a = {x=0, y=0}
print(a.x, a.y)
CODE
0	0
OUT

language_output_is( 'lua', <<'CODE', <<'OUT', '' );
w = {x=0, y=0, label="console"}
x = {0, 1, 2}
w[1] = "another field"
x.f = w
print(w["x"])
print(w[1])
print(x.f[1])
w.x = nil
CODE
0
another field
another field
OUT

language_output_is( 'lua', <<'CODE', <<'OUT', 'mix record-style and list-style init' );
polyline = {color="blue", thickness=2, npoints=4,
             {x=0,   y=0},
             {x=-10, y=0},
             {x=-10, y=1},
             {x=0,   y=1}
           }
print(polyline[2].x)
CODE
-10
OUT

language_output_is( 'lua', <<'CODE', <<'OUT', '' );
opnames = {["+"] = "add", ["-"] = "sub",
           ["*"] = "mul", ["/"] = "div"}
i = 20; s = "-"
a = {[i+0] = s, [i+1] = s..s, [i+2] = s..s..s}
print(opnames[s])
print(a[22])
CODE
sub
---
OUT
