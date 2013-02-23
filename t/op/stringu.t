#!perl
# Copyright: 2001-2005 The Perl Foundation.  All Rights Reserved.
# $Id: stringu.t 10228 2005-11-28 22:52:05Z particle $

use strict;
use warnings;
use lib qw( . lib ../lib ../../lib );
use Test::More;
use Parrot::Test;


=head1 NAME

t/op/stringu.t - Unicode String Test

=head1 SYNOPSIS

	% prove t/op/stringu.t

=head1 DESCRIPTION

Tests Parrot unicode string system.

=cut


output_is( <<'CODE', <<OUTPUT, "angstrom" );
    getstdout P0
    push P0, "utf8"
    chr S0, 0x212B
    print P0, S0
    print P0, "\n"
    end
CODE
\xe2\x84\xab
OUTPUT

output_is( <<'CODE', <<OUTPUT, "escaped angstrom" );
    getstdout P0
    push P0, "utf8"
    set S0, unicode:"\x{212b}"
    print S0
    print "\n"
    end
CODE
\xe2\x84\xab
OUTPUT

output_is( <<'CODE', <<OUTPUT, "escaped angstrom 2" );
    getstdout P0
    push P0, "utf8"
    set S0, unicode:"aaaaaa\x{212b}"
    print S0
    print "\n"
    end
CODE
aaaaaa\xe2\x84\xab
OUTPUT

output_is( <<'CODE', <<OUTPUT, "escaped angstrom 3" );
    getstdout P0
    push P0, "utf8"
    set S0, unicode:"aaaaaa\x{212b}-aaaaaa"
    print S0
    print "\n"
    end
CODE
aaaaaa\xe2\x84\xab-aaaaaa
OUTPUT

output_is( <<'CODE', <<OUTPUT, 'escaped angstrom 3 \uhhhh' );
    getstdout P0
    push P0, "utf8"
    set S0, unicode:"aaaaaa\u212b-aaaaaa"
    print S0
    print "\n"
    end
CODE
aaaaaa\xe2\x84\xab-aaaaaa
OUTPUT

output_is( <<'CODE', <<OUTPUT, "MATHEMATICAL BOLD CAPITAL A");
    getstdout P0
    push P0, "utf8"
    set S0, unicode:"aaaaaa\x{1d400}-aaaaaa"
    print S0
    print "\n"
    end
CODE
aaaaaa\xf0\x9d\x90\x80-aaaaaa
OUTPUT

output_is( <<'CODE', <<OUTPUT, 'MATHEMATICAL BOLD CAPITAL A \U');
    getstdout P0
    push P0, "utf8"
    set S0, unicode:"aaaaaa\U0001d400-aaaaaa"
    print S0
    print "\n"
    end
CODE
aaaaaa\xf0\x9d\x90\x80-aaaaaa
OUTPUT

output_is( <<'CODE', <<OUTPUT, "two upscales");
    getstdout P0
    push P0, "utf8"
    set S0, unicode:"aaaaaa\x{212b}-bbbbbb\x{1d400}-cccccc"
    print S0
    print "\n"
    length I0, S0
    print I0
    print "\n"
    end
CODE
aaaaaa\xe2\x84\xab-bbbbbb\xf0\x9d\x90\x80-cccccc
22
OUTPUT

output_is( <<'CODE', <<OUTPUT, "two upscales - don't downscale");
    getstdout P0
    push P0, "utf8"
    set S0, unicode:"aaaaaa\x{1d400}-bbbbbb\x{212b}-cccccc"
    print S0
    print "\n"
    length I0, S0
    print I0
    print "\n"
    end
CODE
aaaaaa\xf0\x9d\x90\x80-bbbbbb\xe2\x84\xab-cccccc
22
OUTPUT

output_is( <<'CODE', <<OUTPUT, '\cX, \ooo');
    getstdout P0
    push P0, "utf8"
    set S0, "ok 1\cJ"
    print S0
    set S0, "ok 2\012"
    print S0
    set S0, "ok 3\12"
    print S0
    set S0, "ok 4\x0a"
    print S0
    set S0, "ok 5\xa"
    print S0
    end
CODE
ok 1
ok 2
ok 3
ok 4
ok 5
OUTPUT

output_like( <<'CODE', <<OUTPUT, 'illegal \u');
    set S0, "x\uy"
    print "never\n"
    end
CODE
/Illegal escape sequence in/
OUTPUT

output_like( <<'CODE', <<OUTPUT, 'illegal \u123');
    set S0, "x\u123y"
    print "never\n"
    end
CODE
/Illegal escape sequence in/
OUTPUT

output_like( <<'CODE', <<OUTPUT, 'illegal \U123');
    set S0, "x\U123y"
    print "never\n"
    end
CODE
/Illegal escape sequence in/
OUTPUT

output_like( <<'CODE', <<OUTPUT, 'illegal \x');
    set S0, "x\xy"
    print "never\n"
    end
CODE
/Illegal escape sequence in/
OUTPUT

output_is( <<'CODE', <<OUTPUT, "UTF8 literals" );
    set S0, utf8:unicode:"«"
    length I0, S0
    print I0
    print "\n"
    print S0
    print "\n"
    end
CODE
1
\xc2\xab
OUTPUT

output_is( <<'CODE', <<OUTPUT, "UTF8 literals" );
    set S0, utf8:unicode:"\xc2\xab"
    length I0, S0
    print I0
    print "\n"
    print S0
    print "\n"
    end
CODE
1
\xc2\xab
OUTPUT

output_like( <<'CODE', <<OUTPUT, "UTF8 literals - illegal" );
    set S0, utf8:unicode:"\xf2\xab"
    length I0, S0
    print I0
    print "\n"
    print S0
    print "\n"
    end
CODE
/Malformed UTF-8 string/
OUTPUT

output_like( <<'CODE', <<OUTPUT, "UTF8 as malformed ascii" );
    set S0, ascii:"«"
    length I0, S0
    print I0
    print "\n"
    end
CODE
/Malformed string/
OUTPUT

output_is( <<'CODE', <<OUTPUT, "substr with a UTF8 replacement #36794" );
    set S0, "AAAAAAAAAA\\u666"
    set I0, 0x666
    chr S1, I0
    substr S0, 10, 5, S1
    print S0
    print "\n"
    end
CODE
AAAAAAAAAA\xd9\xa6
OUTPUT


## remember to change the number of tests :-)
BEGIN { plan tests => 19; }
