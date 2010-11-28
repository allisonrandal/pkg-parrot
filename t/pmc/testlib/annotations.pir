# Copyright (C) 2009-2010, Parrot Foundation.
# $Id: annotations.pir 48562 2010-08-18 13:09:42Z NotFound $

# This file is used from Packfile PMCs tests

.sub 'main'
.annotate "file", "annotations.pir"
.annotate "creator", "Parrot Foundation"
.annotate "line", 1
    say "Hi"
    say "line"
.annotate "line", 2
    .return ()
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:
