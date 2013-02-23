# $Id: japh13.pasm 12193 2006-04-12 20:04:06Z bernhard $

=head1 NAME

  japh13.pasm - yet another JAPH

=head1 DESCRIPTION

2 threads, synced by sleeping time only
This is unreliable,
especially on multiprocessor or heavily-loaded systems.

=cut

    find_global P5, "_th"
    new P2, .ParrotThread
    find_method P0, P2, "thread3"

    # run first thread
    new P6, .String
    set P6, "Js nte artHce\n"
    set I3, 2
    invoke

    # Give first thread some tim to print the first character
    sleep 0.25

    # run second thread
    new P2, .ParrotThread
    set P6, "utaohrPro akr"
    invoke
    end

.pcc_sub _th:
    set S5, P6
l:
    substr S9, S5, I10, 1
    print S9
    getstdout P2
    callmethod "flush"
    inc I10
    sleep 0.5
    if S9, l
    invoke P1
