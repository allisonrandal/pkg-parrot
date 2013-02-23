/* dynext.h
*
* $Id: dynext.h 19018 2007-06-15 03:48:26Z petdance $
*
*   Parrot dynamic extensions
*/

#ifndef PARROT_DYNEXT_H_GUARD
#define PARROT_DYNEXT_H_GUARD

/* HEADERIZER BEGIN: src/dynext.c */

PARROT_API PMC * Parrot_clone_lib_into( Interp *d, Interp *s, PMC *lib_pmc );
PARROT_API PMC * Parrot_init_lib( Interp *interp,
    PMC *(*load_func)(Interp *) /*NULLOK*/,
    void (*init_func)(Interp *,
    PMC *) /*NULLOK*/ );

PARROT_API PMC * Parrot_load_lib( Interp *interp /*NN*/,
    STRING *lib /*NULLOK*/,
    PMC *initializer )
        __attribute__nonnull__(1);

/* HEADERIZER END: src/dynext.c */

#endif /* PARROT_DYNEXT_H_GUARD */

/*
 * Local variables:
 *   c-file-style: "parrot"
 * End:
 * vim: expandtab shiftwidth=4:
 */
