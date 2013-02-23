/* unicode.h
 *  Copyright (C) 2005, The Perl Foundation.
 *  SVN Info
 *     $Id: /local/src/charset/unicode.h 12826 2006-05-30T01:36:30.308856Z coke  $
 *  Overview:
 *     This is the header for the unicode charset functions
 *  Data Structure and Algorithms:
 *  History:
 *  Notes:
 *  References:
 */

#if !defined(PARROT_CHARSET_UNICODE_H_GUARD)
#define PARROT_CHARSET_UNICODE_H_GUARD

/*
 * init function
 */

CHARSET *Parrot_charset_unicode_init(Interp *);


#endif /* PARROT_CHARSET_UNICODE_H_GUARD */
/*
 * Local variables:
 * c-indentation-style: bsd
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 *
 * vim: expandtab shiftwidth=4:
*/
