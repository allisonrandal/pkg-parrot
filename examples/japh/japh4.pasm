# $Id: japh4.pasm 9150 2005-09-07 19:51:21Z bernhard $

# JaPH utilizing a class
    newclass P0, "Japh"
    print P0
    end
.namespace ["Japh"]
.pcc_sub __get_string:
    set S5, "Just another Parrot Hacker\n"
    invoke P1

