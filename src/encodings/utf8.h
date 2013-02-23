/* utf8.h
 *  Copyright: 2004 The Perl Foundation.  All Rights Reserved.
 *  SVN Info
 *     $Id: utf8.h 11903 2006-03-14 20:49:11Z bernhard $
 *  Overview:
 *     This is the header for the utf8 variable-width encoding.
 *  Data Structure and Algorithms:
 *  History:
 *  Notes:
 *  References:
 */

#if !defined(PARROT_ENCODING_UTF8_H_GUARD)
#define PARROT_ENCODING_UTF8_H_GUARD

ENCODING *Parrot_encoding_utf8_init(Interp *);

#endif /* PARROT_ENCODING_UTF8_H_GUARD */
/*
 * Local variables:
 * c-indentation-style: bsd
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 *
 * vim: expandtab shiftwidth=4:
*/
