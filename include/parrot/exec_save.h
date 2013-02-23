/*
 * exec.h
 *
 * CVS Info
 *    $Id: exec_save.h 5911 2004-04-22 08:55:40Z leo $
 * Overview:
 *    Exec header file.
 * History:
 *      Initial version by Daniel Grunblatt on 2003.6.9
 * Notes:
 * References:
 */

#if !defined(PARROT_EXEC_SAVE_H_GUARD)
#  define PARROT_EXEC_SAVE_H_GUARD

void Parrot_exec_save(Parrot_exec_objfile_t *obj, const char *file);

#endif /* PARROT_EXEC_SAVE_H_GUARD */

/*
 * Local variables:
 * c-indentation-style: bsd
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 *
 * vim: expandtab shiftwidth=4:
 */