# $Id: /parrotcode/trunk/examples/japh/japh17.pasm 470 2006-12-05T03:30:45.414067Z svm  $

    newclass P1, "JaPH"
    find_global P2, "get_s"
    store_global "JaPH", "__get_string", P2
    find_type I1, "JaPH"
    new P3, I1
    print P3
    end
.pcc_sub get_s:
    set S5, "Just another Parrot Hacker\n"
    invoke P1


