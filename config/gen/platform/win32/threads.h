/*
 * $Id: threads.h 39999 2009-07-11 10:57:23Z fperrad $
 * Copyright (C) 2005-2007, Parrot Foundation.
 */

#ifndef PARROT_PLATFORM_WIN32_THREADS_H_GUARD
#define PARROT_PLATFORM_WIN32_THREADS_H_GUARD

#undef CONST
#include <windows.h>
#undef CONST

#ifdef PARROT_HAS_THREADS

#  include "parrot/thr_windows.h"

#endif /* PARROT_HAS_THREADS */

#endif /* PARROT_PLATFORM_WIN32_THREADS_H_GUARD */

/*
 * Local variables:
 *   c-file-style: "parrot"
 * End:
 * vim: expandtab shiftwidth=4:
 */

