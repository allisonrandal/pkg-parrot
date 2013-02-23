/* global_setup.h
 *  Copyright (C) 2001-2003, The Perl Foundation.
 *  SVN Info
 *     $Id: /local/include/parrot/global_setup.h 12834 2006-05-30T13:17:39.723584Z coke  $
 *  Overview:
 *      Contains declarations of global data and the functions
 *      that initialize that data.
 *  Data Structure and Algorithms:
 *  History:
 *  Notes:
 *  References:
 */

#if !defined(PARROT_GLOBAL_SETUP_H_GUARD)
#define PARROT_GLOBAL_SETUP_H_GUARD

#include "parrot/config.h"
#include "parrot/interpreter.h"


void init_world(Interp *);
void parrot_global_setup_2(Interp *);

#endif /* PARROT_GLOBAL_SETUP_H_GUARD */

/*
 * Local variables:
 * c-indentation-style: bsd
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 *
 * vim: expandtab shiftwidth=4:
*/
