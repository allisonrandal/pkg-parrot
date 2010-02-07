/*
 * $Id$
 * Copyright (C) 2008-2009, Parrot Foundation.
 */

#include <stdio.h>
#include "parrot/parrot.h"

/*

=head1 Functions

=over 4

=item C<int
main(int argc, char *argv[])>

Entry point of the heredoc pre-processor.

=back

=cut

*/
int
main(int argc, char *argv[]) {
    FILE *outfile;
    char *outputfile = "heredoc.out";

    /* check for proper usage */
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <file>\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    outfile = fopen(outputfile, "w");

    if (outfile == NULL) {
        fprintf(stderr, "Failed to open file '%s' for output. Aborting.\n", outputfile);
        exit(EXIT_FAILURE);
    }

    fprintf(outfile, "# output generated by %s\n", argv[0]);

    process_heredocs(argv[1], outfile);

    fclose(outfile);

    fprintf(stderr, "heredoc pre-processed successfully.\n");

    return 0;
}



/*
 * Local variables:
 *   c-file-style: "parrot"
 * End:
 * vim: expandtab shiftwidth=4:
 */
