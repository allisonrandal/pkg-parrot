# Copyright (C) 2009, Parrot Foundation.
# $Id: annotations.pir 38183 2009-04-17 21:58:24Z bacek $

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
