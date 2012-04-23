/*
 * Copyright (C) 2005-2010, Parrot Foundation.
 *
 * DO NOT EDIT THIS FILE DIRECTLY!
 * please update the tools/dev/gen_charset_tables.pl script instead.
 *
 * This file contains various charset tables.
 */

/* HEADERIZER HFILE: none */


#ifndef PARROT_CHARSET_TABLES_H_GUARD
#define PARROT_CHARSET_TABLES_H_GUARD
#include "parrot/cclass.h"
#include "parrot/parrot.h"
#define WHITESPACE  enum_cclass_whitespace
#define WORDCHAR    enum_cclass_word
#define PUNCTUATION enum_cclass_punctuation
#define DIGIT       enum_cclass_numeric
extern const INTVAL Parrot_iso_8859_1_typetable[256];
#endif /* PARROT_CHARSET_TABLES_H_GUARD */
/*
 * Local variables:
 *   c-file-style: "parrot"
 * End:
 * vim: expandtab shiftwidth=4 cinoptions='\:2=2' :
 */
