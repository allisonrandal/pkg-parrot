/* string.h
 *  Copyright (C) 2001-2003, The Perl Foundation.
 *  SVN Info
 *     $Id: string.h 12834 2006-05-30 13:17:39Z coke $
 *  Overview:
 *     This is the api header for the string subsystem
 *  Data Structure and Algorithms:
 *  History:
 *  Notes:
 *  References:
 */

#if !defined(PARROT_STRING_H_GUARD)
#define PARROT_STRING_H_GUARD

#include "parrot/config.h"
#include "parrot/pobj.h"

struct parrot_string_t;

#ifdef PARROT_IN_CORE

#include "parrot/parrot.h"

typedef struct parrot_string_t String;

typedef enum Forward_flag {
    Buffer_moved_FLAG = 1 << 0
} Forward_flags;

/* String iterator */
typedef struct string_iterator_t {
    const String *str;
    UINTVAL bytepos;
    UINTVAL charpos;
    UINTVAL (*get_and_advance)(Interp *, struct string_iterator_t *i);
    void (*set_and_advance)(Interp *, struct string_iterator_t *i, UINTVAL c);
    void (*set_position)(Interp *, struct string_iterator_t *i, UINTVAL pos);
} String_iter;

void string_iter_init(Interp *, const String *str, String_iter *);

/* stringinfo parameters */

/* &gen_from_def(stringinfo.pasm) */

#define STRINGINFO_HEADER   1
#define STRINGINFO_STRSTART 2
#define STRINGINFO_BUFLEN   3
#define STRINGINFO_FLAGS    4
#define STRINGINFO_BUFUSED  5
#define STRINGINFO_STRLEN   6

/* &end_gen */
typedef struct parrot_string_t STRING;

#endif /* PARROT_IN_CORE */
#endif /* PARROT_STRING_H_GUARD */

/*
 * Local variables:
 * c-indentation-style: bsd
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 *
 * vim: expandtab shiftwidth=4:
*/
