/* runops_cores.h
 *  Copyright (C) 2001-2006, The Perl Foundation.
 *  SVN Info
 *     $Id: runops_cores.h 12826 2006-05-30 01:36:30Z coke $
 *  Overview:
 *     Header for runops cores.
 *  Data Structure and Algorithms:
 *  History:
 *  Notes:
 *  References:
 */

#if !defined(PARROT_RUNOPS_CORES_H_GUARD)
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
 * c-indentation-style: bsd
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 *
 * vim: expandtab shiftwidth=4:
*/