/*
 * $Id: pirheredoc.h 36665 2009-02-13 10:20:10Z kjs $
 * Copyright (C) 2008-2009, Parrot Foundation.
 */


#ifndef PARROT_PIR_PIRHEREDOC_H_GUARD
#define PARROT_PIR_PIRHEREDOC_H_GUARD

#include <stdio.h> /* for FILE */

void process_heredocs(PARROT_INTERP, char * const filename, FILE *outputfile);

#endif /* PARROT_PIR_PIRHEREDOC_H_GUARD */

/*
 * Local variables:
 *   c-file-style: "parrot"
 * End:
 * vim: expandtab shiftwidth=4:
 */

