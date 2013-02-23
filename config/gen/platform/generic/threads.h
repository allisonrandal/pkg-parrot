/*
 * $Id: threads.h 37201 2009-03-08 12:07:48Z fperrad $
 * Copyright (C) 2004-2007, Parrot Foundation.
 */

#ifndef PARROT_PLATFORM_GENERIC_THREADS_H_GUARD
#define PARROT_PLATFORM_GENERIC_THREADS_H_GUARD
/*
 * POSIX threading stuff
 */

#ifdef PARROT_HAS_HEADER_PTHREAD
#  include "parrot/thr_pthread.h"
#endif

#ifdef PARROT_HAS_HEADER_UNISTD
#  include <unistd.h>
#  ifdef _POSIX_PRIORITY_SCHEDULING
#    define YIELD sched_yield()
#  endif
#endif

#endif /* PARROT_PLATFORM_GENERIC_THREADS_H_GUARD */

/*
 * Local variables:
 *   c-file-style: "parrot"
 * End:
 * vim: expandtab shiftwidth=4:
 */
