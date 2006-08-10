/* nci.h
 *  Copyright (C) 2001-2003, The Perl Foundation.
 *  SVN Info
 *     $Id: /local/include/parrot/nci.h 12834 2006-05-30T13:17:39.723584Z coke  $
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
