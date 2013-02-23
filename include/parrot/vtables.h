/* vtables.h
 *  Copyright (C) 2001-2003, The Perl Foundation.
 *  SVN Info
 *     $Id: vtables.h 12834 2006-05-30 13:17:39Z coke $
 *  Overview:
 *     Vtable manipulation code. Not to be confused with vtable.h
 *  Data Structure and Algorithms:
 *  History:
 *  Notes:
 *  References:
 */

#if !defined(PARROT_VTABLES_H_GUARD)
#define PARROT_VTABLES_H_GUARD

PARROT_API VTABLE *Parrot_new_vtable(Interp*);
PARROT_API VTABLE *Parrot_clone_vtable(Interp*, const VTABLE *base_vtable);
PARROT_API void Parrot_destroy_vtable(Interp*, VTABLE *vtable);

void parrot_alloc_vtables(Interp *);
void parrot_realloc_vtables(Interp *);
void parrot_free_vtables(Interp *);

#endif /* PARROT_VTABLES_H_GUARD */

/*
 * Local variables:
 * c-indentation-style: bsd
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 *
 * vim: expandtab shiftwidth=4:
*/
