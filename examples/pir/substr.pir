# Copyright (C) 2001-2003, The Perl Foundation.
# $Id: /local/examples/pir/substr.pir 12835 2006-05-30T13:32:26.641316Z coke  $

=head1 NAME

examples/pir/substr.pir - playing with substr

=head1 SYNOPSIS

    % ./parrot examples/pir/substr.pir

=head1 DESCRIPTION

A excuberating C<substr> version of "Hello World".

=cut

.sub "example" :main
        I2 = 1
        I1 = 0
        S1 = "Hello World"
        I3 = 0
        I4 = 0
        I5 = length S1
WAX:    S2 = substr S1, I3, I4
        print  S2
        print  "\n"
        I4 = I4 + I2
        if I4 == I5 goto WANE
	branch WAX
WANE:   I1 = length S1
        print  S1
        print  "\n"
        chopn  S1, 1
        unless I1 == I3 goto WANE
DONE:   
.end
