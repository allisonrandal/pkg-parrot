# Copyright (C) 2004-2009, Parrot Foundation.
# $Id: japh1.pasm 38369 2009-04-26 12:57:09Z fperrad $

	newclass P0, "Japh"
	new P0, "Japh"
	set I0, 0
	set S0, P0[I0]
	print S0
	inc I0
	set S0, P0[I0]
	print S0
	end
.namespace ["Japh"]
.pcc_sub :vtable get_string_keyed:
	get_params "0,0", P1, I1
	unless I1, x
	set S1, "Parrot Hacker\n"
	set_returns "0", S1
	returncc
x:
	set S1, "Just another "
	set_returns "0", S1
	returncc

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:
