/*
 * $Id: interp_guts.h 37201 2009-03-08 12:07:48Z fperrad $
 * Copyright (C) 2001-2007, Parrot Foundation.
 */

/*
** interp_guts.h
*/

#ifndef PARROT_INTERP_GUTS_H_GUARD
#define PARROT_INTERP_GUTS_H_GUARD

#  define DO_OP(PC, INTERP) ((PC) = (((INTERP)->op_func_table)[*(PC)])((PC), (INTERP)))

#endif /* PARROT_INTERP_GUTS_H_GUARD */


/*
 * Local variables:
 *   c-file-style: "parrot"
 * End:
 * vim: expandtab shiftwidth=4:
 */
