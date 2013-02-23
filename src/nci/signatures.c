/*
Copyright (C) 2010-2011, Parrot Foundation.

=head1 NAME

src/nci/signatures.c - Native Call Interface signature processing routines

=head1 DESCRIPTION

This file implements functionality for parsing NCI signatures and generating PCC
signatures.

=head2 Functions

=over 4

=cut

*/

#include "parrot/parrot.h"
#include "parrot/nci.h"
#include "signatures.str"

/* HEADERIZER HFILE: include/parrot/nci.h */

/*

=item C<PMC * Parrot_nci_parse_signature(PARROT_INTERP, STRING *sig_str)>

Parse a signature string to a NCI signature PMC.

=cut

*/

PARROT_CANNOT_RETURN_NULL
PARROT_EXPORT
PMC *
Parrot_nci_parse_signature(PARROT_INTERP, ARGIN(STRING *sig_str))
{
    ASSERT_ARGS(Parrot_nci_parse_signature)

    const size_t sig_length = Parrot_str_byte_length(interp, sig_str);

    size_t i;

    PMC * const sig_pmc = Parrot_pmc_new(interp, enum_class_ResizableIntegerArray);

    for (i = 0; i < sig_length; ++i) {
        const INTVAL c = Parrot_str_indexed(interp, sig_str, i);
        nci_sig_elem_t e;

        PARROT_ASSERT(c == (char)c);

        switch ((char)c) {
          case '0':    /* null ptr or such - doesn't consume a reg */
            e = enum_nci_sig_null;
            break;

          case 'f':
            e = enum_nci_sig_float;
            break;
          case 'd':
            e = enum_nci_sig_double;
            break;
          case 'N':
            e = enum_nci_sig_numval;
            break;

          case 'c':   /* char */
            e = enum_nci_sig_char;
            break;
          case 's':   /* short */
            e = enum_nci_sig_short;
            break;
          case 'i':   /* int */
            e = enum_nci_sig_int;
            break;
          case 'l':   /* long */
            e = enum_nci_sig_long;
            break;
          case 'I':   /* INTVAL */
            e = enum_nci_sig_intval;
            break;

          case 'S':
            e = enum_nci_sig_string;
            break;
          case 't':   /* string, pass a cstring */
            e = enum_nci_sig_cstring;
            break;

          case 'J':   /* interpreter */
            e = enum_nci_sig_interp;
            break;

          case 'p':   /* push pmc->data */
            e = enum_nci_sig_ptr;
            break;
          case 'P':   /* push PMC * */
            e = enum_nci_sig_pmc;
            break;
          case 'V':   /* push PMC * */
            e = enum_nci_sig_ptrref;
            break;
          case '2':
            e = enum_nci_sig_shortref;
            break;
          case '3':
            e = enum_nci_sig_intref;
            break;
          case '4':
            e = enum_nci_sig_longref;
            break;

          case 'O':   /* push PMC * invocant */
            e = enum_nci_sig_pmcinv;
            break;
          case '@':   /* push PMC * slurpy */
            e = enum_nci_sig_pmcslurp;
            break;

          case 'b': /* buffer (void*) pass Buffer_bufstart(SReg) */
            e = enum_nci_sig_cstringref;
            break;
          case 'B': /* buffer (void**) pass &Buffer_bufstart(SReg) */
            e = enum_nci_sig_bufref;
            break;

          case 'v':
            e = enum_nci_sig_void;
            break;
          default:
            Parrot_ex_throw_from_c_args(interp, NULL,
                    EXCEPTION_JIT_ERROR,
                    "Unknown param Signature %c\n", (char)c);
            break;
        }

        VTABLE_push_integer(interp, sig_pmc, e);
    }

    if (VTABLE_elements(interp, sig_pmc) < 1)
        VTABLE_push_integer(interp, sig_pmc, enum_nci_sig_void);

    return sig_pmc;
}


/*

=item C<void Parrot_nci_sig_to_pcc(PARROT_INTERP, PMC *sig_pmc, STRING
**params_sig, STRING **ret_sig)>

Determine the PCC signatures for a given NCI signature PMC.

=cut

*/

void
Parrot_nci_sig_to_pcc(PARROT_INTERP, ARGIN(PMC *sig_pmc), ARGOUT(STRING **params_sig),
    ARGOUT(STRING **ret_sig))
{
    ASSERT_ARGS(Parrot_nci_sig_to_pcc)

    const size_t sig_len = VTABLE_elements(interp, sig_pmc);

    /* PCC sigs are 1 char long except for array slurpy, named slurpy (not possible with NCI),
       and invocant */
    const size_t buf_len = sig_len + 2 + 1;

    /* avoid malloc churn on common signatures */
    char         static_buf[16];
    char * const sig_buf = sig_len <= sizeof static_buf ?
                            static_buf :
                            (char *)mem_sys_allocate(buf_len);

    size_t i, j;

    for (i = 0, j = 0; i < sig_len; i++) {
        const nci_sig_elem_t e = (nci_sig_elem_t)VTABLE_get_integer_keyed_int(interp, sig_pmc, i);

        PARROT_ASSERT(j < buf_len - 1);

        switch (e) {
          case enum_nci_sig_void:
            /* null return */
            if (j == 0)
                sig_buf[j++] = '\0';
            break;
          case enum_nci_sig_null:
          case enum_nci_sig_interp:
            break;
          case enum_nci_sig_float:
          case enum_nci_sig_double:
          case enum_nci_sig_numval:
            sig_buf[j++] = 'N';
            break;
          case enum_nci_sig_char:
          case enum_nci_sig_short:
          case enum_nci_sig_int:
          case enum_nci_sig_long:
          case enum_nci_sig_intval:
            sig_buf[j++] = 'I';
            break;
          case enum_nci_sig_string:
          case enum_nci_sig_cstring:
          case enum_nci_sig_cstringref:
          case enum_nci_sig_bufref:
            sig_buf[j++] = 'S';
            break;
          case enum_nci_sig_ptr:
          case enum_nci_sig_pmc:
          case enum_nci_sig_ptrref:
          case enum_nci_sig_shortref:
          case enum_nci_sig_intref:
          case enum_nci_sig_longref:
            sig_buf[j++] = 'P';
            break;
          case enum_nci_sig_pmcinv:
            sig_buf[j++] = 'P';
            sig_buf[j++] = 'i';
            break;
          case enum_nci_sig_pmcslurp:
            sig_buf[j++] = 'P';
            sig_buf[j++] = 's';
            break;
          default:
            break;
        }
    }

    PARROT_ASSERT(j < buf_len);
    sig_buf[j + 1] = '\0';

    *ret_sig    = Parrot_str_new(interp, sig_buf, 1);
    *params_sig = j - 1 ?
                Parrot_str_new(interp, &sig_buf[1], j - 1) :
                CONST_STRING(interp, "");

    if (sig_buf != static_buf)
        mem_sys_free(sig_buf);
}

/*

=back

=cut

*/

/*
 * Local variables:
 *   c-file-style: "parrot"
 * End:
 * vim: expandtab shiftwidth=4 cinoptions='\:2=2' :
 */
