/* nci.h
 *  Copyright: 2001-2003 The Perl Foundation.  All Rights Reserved.
 *  CVS Info
 *     $Id: nci.h 6853 2004-10-18 01:35:33Z brentdax $
 *  Overview:
 *     The nci api handles building native call frames
 *  Data Structure and Algorithms:
 *  History:
 *  Notes:
 *  References:
 */

#if !defined(PARROT_NCI_H_GUARD)
#define PARROT_NCI_H_GUARD

#include "parrot/parrot.h"

void *build_call_func(Interp *, PMC *, String *);

#endif /* PARROT_NCI_H_GUARD */

/*
 * Local variables:
 * c-indentation-style: bsd
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 *
 * vim: expandtab shiftwidth=4:
*/