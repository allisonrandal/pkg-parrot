# Copyright (C) 2004-2009, Parrot Foundation.
# $Id: japh4.pasm 38369 2009-04-26 12:57:09Z fperrad $

newclass P1, "Japh"
new P2, "Japh"
print P2
end

.namespace ["Japh"]
.pcc_sub :vtable get_string:
	set S3, "Just another Parrot Hacker\n"
	set_returns "0", S3
	returncc

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:
