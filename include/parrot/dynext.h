/* dynext.h
*
* $Id: dynext.h 6571 2004-08-23 09:10:02Z leo $
*
*   Parrot dynamic extensions
*/

#if !defined(PARROT_DYNEXT_H_GUARD)
#define PARROT_DYNEXT_H_GUARD


/* dynamic lib/oplib/PMC loading */
PMC *Parrot_load_lib(Interp *interpreter, STRING *lib, PMC *initializer);

/* dynamic lib/oplib/PMC init */
PMC *
Parrot_init_lib(Interp *interpreter,
                PMC *(*load_func)(Interp *),
                void (*init_func)(Interp *, PMC *));

#endif /* PARROT_DYNEXT_H_GUARD */

