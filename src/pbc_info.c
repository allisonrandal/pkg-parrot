/*
Copyright: 2001-2003 The Perl Foundation.  All Rights Reserved.
$Id: pbc_info.c 12076 2006-03-29 22:22:22Z bernhard $

=head1 NAME

pbc_info - PacFile demo

=head1 SYNOPSIS

 pbc_info file.pbc

=head1 DESCRIPTION

Sample program for dumping PackFile segment names by iterating
over the main directory.

=over 4

=cut

*/

#include "parrot/parrot.h"
#include "parrot/embed.h"

/*

=item C<static INTVAL iter(Interp*, struct PackFile_Segment *seg, void
 *user_data)>

This function is passed the callback to PackFile_map_segments() to print out
the name of each segment in the directory.

=cut

*/

static INTVAL
iter(Interp* interpreter,
		struct PackFile_Segment *seg, void *user_data)
{
    int ident = (int)user_data;
    printf("%*.0s%s\n", ident, "", seg->name);
    if (seg->type == PF_DIR_SEG)
	PackFile_map_segments(interpreter, (struct PackFile_Directory*)seg,
		iter, (void*)(ident+2));
    return 0;
}

/*

=item C<int main(int argc, char **argv)>

Reads the PBC from argv[1], adds a few extra sections, and then iterates over
the directory using PackFile_map_segments() and iter().

=cut

*/

int
main(int argc, char * argv[] )
{
    struct PackFile *pf;
    Interp *interpreter;
    struct PackFile_Segment *seg;

    interpreter = Parrot_new(NULL);
    Parrot_init(interpreter);

    pf = Parrot_readbc(interpreter, argv[1]);

    /*
     * add some more segments
     */
    seg = PackFile_Segment_new_seg(interpreter,
		    &pf->directory, PF_DIR_SEG, "dir2", 1);
    seg = PackFile_Segment_new_seg(interpreter,
		    (struct PackFile_Directory*)seg, PF_BYTEC_SEG, "code", 1);
    seg = PackFile_Segment_new_seg(interpreter,
		    &pf->directory, PF_DIR_SEG, "dir3", 1);

    /*
     * show these
     */
    printf("%s\n", pf->directory.base.name);
    PackFile_map_segments(interpreter, &pf->directory, iter, (void*)2);

    Parrot_exit(0);
    return 0;
}

/*

=back

=head1 SEE ALSO

F<src/pbc.c>, F<include/parrot/pbc.h>.

=cut

*/

