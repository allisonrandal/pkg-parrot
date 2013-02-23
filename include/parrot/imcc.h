/*
 * Copyright (C) 2007-2008, Parrot Foundation.
 * $Id: imcc.h 37257 2009-03-10 04:22:07Z Util $
 */

#ifndef PARROT_IMCC_H_GUARD
#define PARROT_IMCC_H_GUARD

PARROT_EXPORT void imcc_initialize(PARROT_INTERP);
PARROT_EXPORT const char * parseflags(PARROT_INTERP, int *argc, char **argv[]);
PARROT_EXPORT int imcc_run(PARROT_INTERP, const char *sourcefile, int argc, char **argv);

#endif /* PARROT_IMCC_H_GUARD */

/*
 * Local variables:
 *   c-file-style: "parrot"
 * End:
 * vim: expandtab shiftwidth=4:
 */
