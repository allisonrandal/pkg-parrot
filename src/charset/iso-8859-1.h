/* iso_8859_1.h
 *  Copyright (C) 2004, The Perl Foundation.
 *  SVN Info
 *     $Id: /parrotcode/trunk/src/charset/iso-8859-1.h 3385 2007-05-05T14:41:57.057265Z bernhard  $
 *  Overview:
 *     This is the header for the iso_8859-1 charset functions
 *  Data Structure and Algorithms:
 *  History:
 *  Notes:
 *  References:
 */

#ifndef PARROT_CHARSET_ISO_8859_1_H_GUARD
#define PARROT_CHARSET_ISO_8859_1_H_GUARD

STRING *charset_cvt_iso_8859_1_to_ascii(Interp *, STRING *src, STRING *dest);

CHARSET *Parrot_charset_iso_8859_1_init(Interp *);

#endif /* PARROT_CHARSET_ISO_8859_1_H_GUARD */

/*
 * Local variables:
 *   c-file-style: "parrot"
 * End:
 * vim: expandtab shiftwidth=4:
 */
