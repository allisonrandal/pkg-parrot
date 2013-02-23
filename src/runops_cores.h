/* runops_cores.h
 *  Copyright (C) 2001-2006, The Perl Foundation.
 *  SVN Info
 *     $Id: /parrotcode/trunk/src/runops_cores.h 3385 2007-05-05T14:41:57.057265Z bernhard  $
 *  Overview:
 *     Header for runops cores.
 *  Data Structure and Algorithms:
 *  History:
 *  Notes:
 *  References:
 */

#ifndef PARROT_RUNOPS_CORES_H_GUARD
#define PARROT_RUNOPS_CORES_H_GUARD

#include "parrot/parrot.h"
#include "parrot/op.h"

opcode_t *runops_fast_core(Interp *, opcode_t *);

opcode_t *runops_cgoto_core(Interp *, opcode_t *);

opcode_t *runops_slow_core(Interp *, opcode_t *);

opcode_t *runops_profile_core(Interp *, opcode_t *);

#endif /* PARROT_RUNOPS_CORES_H_GUARD */


/*
 * Local variables:
 *   c-file-style: "parrot"
 * End:
 * vim: expandtab shiftwidth=4:
 */
