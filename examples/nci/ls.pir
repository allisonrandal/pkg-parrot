# Copyright: 2005 The Perl Foundation.  All Rights Reserved.
# $Id: ls.pir 10412 2005-12-09 00:47:03Z particle $

=head1 NAME

examples/nci/ls.pir - a directory lister

=head1 DESCRIPTION

List the content of the directory 'docs'.

=cut

.sub _main @MAIN
     .local pmc libc
     .local pmc opendir
     .local pmc readdir
     .local pmc closedir
     null libc
     dlfunc opendir, libc, 'opendir', 'pt'
     dlfunc readdir, libc, 'readdir', 'pp'
     dlfunc closedir, libc, 'closedir', 'ip'
     store_global 'libc::opendir', opendir
     store_global 'libc::readdir', readdir
     store_global 'libc::closedir', closedir
     .local pmc curdir
     curdir = libc::opendir("docs")
     .local OrderedHash entry

     .include "datatypes.pasm"
     new $P2, .OrderedHash
     set $P2["d_fileno"], .DATATYPE_INT64
     push $P2, 0
     push $P2, 0
     set $P2["d_reclen"], .DATATYPE_SHORT
     push $P2, 0
     push $P2, 0
     set $P2["d_type"], .DATATYPE_CHAR
     push $P2, 0
     push $P2, 0
     set $P2["d_name"], .DATATYPE_CHAR
     push $P2, 256
     push $P2, 0           # 11
lp_dir:
     entry = libc::readdir(curdir)
     $I0 = get_addr entry
     unless $I0 goto done
     assign entry, $P2

    $I1 = 0
loop:
     $I0 = entry["d_name";$I1]
     unless $I0 goto ex
     chr $S0, $I0
     print $S0
     inc $I1
     goto loop
 ex:
     print "\n"
     goto lp_dir
done:
     libc::closedir(curdir)
.end