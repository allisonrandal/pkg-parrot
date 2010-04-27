/* core_types.h
 *  Copyright (C) 2009, Parrot Foundation.
 *  SVN Info
 *     $Id: core_types.h 36847 2009-02-17 23:49:48Z NotFound $
 *  Overview:
 *     Forward declaration of the interpreter basic types
 */

#ifndef PARROT_CORE_TYPES_H_GUARD
#define PARROT_CORE_TYPES_H_GUARD

typedef struct PMC PMC;
typedef PMC *Parrot_PMC;

struct parrot_string_t;
typedef struct parrot_string_t *Parrot_String;

struct parrot_interp_t;
typedef struct parrot_interp_t *Parrot_Interp;

#endif   /* PARROT_CORE_TYPES_H_GUARD */

/*
 * Local variables:
 *   c-file-style: "parrot"
 * End:
 * vim: expandtab shiftwidth=4:
 */
