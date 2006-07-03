#! perl
# Copyright (C) 2001-2005, The Perl Foundation.
# $Id: hash.t 12884 2006-06-05 13:29:13Z audreyt $

use strict;
use warnings;
use lib qw( . lib ../lib ../../lib );
use Test::More;
use Parrot::Test;

plan $^O =~ m/MSWin32/ ? (skip_all => 'broken on win32') : (tests => 11);

=head1 NAME

t/src/hash.t - Hashes

=head1 SYNOPSIS

	% prove t/src/hash.t

=head1 DESCRIPTION

Tests the hash.h API without reference to PMCs.

=cut


my $main = <<'CODE';
#include <parrot/parrot.h>
#include <parrot/embed.h>

static opcode_t *the_test(Parrot_Interp, opcode_t *, opcode_t *);

int exit_value = 0;

int main(int argc, char* argv[])
{
    Parrot_Interp interpreter = Parrot_new(NULL);
    Parrot_init_stacktop(interpreter, &interpreter);

    Parrot_run_native(interpreter, the_test);

    Parrot_exit(exit_value);
    return exit_value;
}

CODE

c_output_is($main . <<'CODE', <<'OUTPUT', "parrot_new_hash");

static opcode_t*
the_test(Interp *interpreter,
	opcode_t *cur_op, opcode_t *start)
{
    Hash *hash;
    STRING *key;
    HashEntry value;

    UNUSED(cur_op);
    UNUSED(start);

    parrot_new_hash(interpreter, &hash);

    if ( hash == NULL ) {
	PIO_eprintf(interpreter, "hash creation failed\n");
	exit_value = 1;
	return NULL;
    }

    PIO_eprintf(interpreter, "ok\n");

    return NULL;
}

CODE
ok
OUTPUT

c_output_is($main . <<'CODE', <<'OUTPUT', "parrot_hash_put");

static opcode_t*
the_test(Interp *interpreter,
	opcode_t *cur_op, opcode_t *start)
{
    Hash *hash;
    STRING *key;
    /* FIXME this is wrong - hash takes pointers only
       when DOD is triggered, this fails
    */
    HashEntry value;

    UNUSED(cur_op);
    UNUSED(start);

    parrot_new_hash(interpreter, &hash);

    if ( hash == NULL ) {
	PIO_eprintf(interpreter, "hash creation failed\n");
	exit_value = 1;
	return NULL;
    }

    key = string_from_cstring(interpreter, "fortytwo", 0);
    value.type = enum_hash_int;
    UVal_int(value.val) = 42;
    parrot_hash_put(interpreter, hash, key, &value);

    PIO_eprintf(interpreter, "ok\n");

    return NULL;
}

CODE
ok
OUTPUT

c_output_is($main . <<'CODE', <<'OUTPUT', "parrot_hash_get");

static opcode_t*
the_test(Interp *interpreter,
	opcode_t *cur_op, opcode_t *start)
{
    Hash *hash;
    STRING *key;
    HashEntry _value;
    HashEntry *value = &_value;

    UNUSED(cur_op);
    UNUSED(start);

    parrot_new_hash(interpreter, &hash);

    if ( hash == NULL ) {
	PIO_eprintf(interpreter, "hash creation failed\n");
	exit_value = 1;
	return NULL;
    }

    key = string_from_cstring(interpreter, "fortytwo", 0);
    value->type = enum_hash_int;
    UVal_int(value->val) = 42;
    parrot_hash_put(interpreter, hash, key, value);
    value = parrot_hash_get(interpreter, hash, key);

    PIO_eprintf(interpreter, "%i\n", (int) UVal_int(value->val));

    return NULL;
}

CODE
42
OUTPUT

c_output_is($main . <<'CODE', <<'OUTPUT', "parrot_hash_get with NULL key");

static opcode_t*
the_test(Interp *interpreter,
	opcode_t *cur_op, opcode_t *start)
{
    Hash *hash;
    STRING *key;
    HashEntry _value;
    HashEntry *value = &_value;

    UNUSED(cur_op);
    UNUSED(start);

    parrot_new_hash(interpreter, &hash);

    if ( hash == NULL ) {
	PIO_eprintf(interpreter, "hash creation failed\n");
	exit_value = 1;
	return NULL;
    }

    /*
     * It might be worth finding out where this fails to work,
     * no key? fail to put? fail to get?
     *
     * string_from_cstring did segfault
     * it works now exactly as the next (empty key) case
     */

    key = string_from_cstring(interpreter, NULL, 0);
    value->type = enum_hash_int;
    UVal_int(value->val) = 42;
    parrot_hash_put(interpreter, hash, key, value);
    value = parrot_hash_get(interpreter, hash, key);

    PIO_eprintf(interpreter, "%i\n", (int) UVal_int(value->val));

    return NULL;
}

CODE
42
OUTPUT

c_output_is($main . <<'CODE', <<'OUTPUT', "parrot_hash_get with empty string key");

static opcode_t*
the_test(Interp *interpreter,
	opcode_t *cur_op, opcode_t *start)
{
    Hash *hash;
    STRING *key;
    HashEntry _value;
    HashEntry *value = &_value;

    UNUSED(cur_op);
    UNUSED(start);

    parrot_new_hash(interpreter, &hash);

    if ( hash == NULL ) {
	PIO_eprintf(interpreter, "hash creation failed\n");
	exit_value = 1;
	return NULL;
    }

    key = string_from_cstring(interpreter, "", 0);
    value->type = enum_hash_int;
    UVal_int(value->val) = 42;
    parrot_hash_put(interpreter, hash, key, value);
    value = parrot_hash_get(interpreter, hash, key);

    PIO_eprintf(interpreter, "%i\n", UVal_int(value->val));

    return NULL;
}

CODE
42
OUTPUT

c_output_is($main . <<'CODE', <<'OUTPUT', "parrot_hash_get with big key");

#define BIGLEN 999999

static opcode_t*
the_test(Interp *interpreter,
	opcode_t *cur_op, opcode_t *start)
{
    Hash *hash;
    PMC *h;
    STRING *key;
    char *big;
    PMC *i, *j;

    UNUSED(cur_op);
    UNUSED(start);

    h = pmc_new(interpreter, enum_class_Hash);
    hash = PMC_struct_val(h);
    i = pmc_new(interpreter, enum_class_Integer);

    if ( hash == NULL ) {
	PIO_eprintf(interpreter, "hash creation failed\n");
	exit_value = 1;
	return NULL;
    }

    big = calloc(BIGLEN, sizeof(char));
    big = memset(big, 'x', BIGLEN - 1);

    key = string_from_cstring(interpreter, big, 0);

    VTABLE_set_integer_native(interpreter, i, 42);
    parrot_hash_put(interpreter, hash, key, i);
    j = parrot_hash_get(interpreter, hash, key);

    PIO_eprintf(interpreter, "%Pi\n", j);

    return NULL;
}

CODE
42
OUTPUT

c_output_is($main . <<'CODE', <<'OUTPUT', "parrot_hash_size");

static opcode_t*
the_test(Interp *interpreter,
	opcode_t *cur_op, opcode_t *start)
{
    Hash *hash;
    STRING *key;
    HashEntry value;

    UNUSED(cur_op);
    UNUSED(start);

    parrot_new_hash(interpreter, &hash);

    if ( hash == NULL ) {
	PIO_eprintf(interpreter, "hash creation failed\n");
	exit_value = 1;
	return NULL;
    }

    key = string_from_cstring(interpreter, "fortytwo", 0);
    value.type = enum_hash_int;
    UVal_int(value.val) = 42;
    parrot_hash_put(interpreter, hash, key, &value);

    key = string_from_cstring(interpreter, "twocents", 0);
    value.type = enum_hash_num;
    UVal_num(value.val) = 0.02;
    parrot_hash_put(interpreter, hash, key, &value);

    key = string_from_cstring(interpreter, "blurb", 0);
    value.type = enum_hash_string;
    UVal_str(value.val) = key;
    parrot_hash_put(interpreter, hash, key, &value);

    PIO_eprintf(interpreter, "%i\n", parrot_hash_size(interpreter, hash));

    return NULL;
}

CODE
3
OUTPUT

c_output_is($main . <<'CODE', <<'OUTPUT', "parrot_hash_delete");

static opcode_t*
the_test(Interp *interpreter,
	opcode_t *cur_op, opcode_t *start)
{
    Hash *hash;
    STRING *key;
    PMC *value;

    UNUSED(cur_op);
    UNUSED(start);

    parrot_new_hash(interpreter, &hash);

    if ( hash == NULL ) {
	PIO_eprintf(interpreter, "hash creation failed\n");
	exit_value = 1;
	return NULL;
    }

    key = string_from_cstring(interpreter, "fortytwo", 0);
    value = pmc_new(interpreter, enum_class_Integer);
    VTABLE_set_integer_native(interpreter, value, 42);
    parrot_hash_put(interpreter, hash, key, value);

    key = string_from_cstring(interpreter, "twocents", 0);
    value = pmc_new(interpreter, enum_class_Float);
    VTABLE_set_number_native(interpreter, value, 0.02);
    parrot_hash_put(interpreter, hash, key, value);

    key = string_from_cstring(interpreter, "blurb", 0);
    value = pmc_new(interpreter, enum_class_String);
    VTABLE_set_string_native(interpreter, value, key);
    parrot_hash_put(interpreter, hash, key, value);

    PIO_eprintf(interpreter, "%i\n", parrot_hash_size(interpreter, hash));

    parrot_hash_delete(interpreter, hash, key);

    PIO_eprintf(interpreter, "%i\n", parrot_hash_size(interpreter, hash));

    return NULL;
}

CODE
3
2
OUTPUT

c_output_is($main . <<'CODE', <<'OUTPUT', "parrot_hash_clone");

static opcode_t*
the_test(Interp *interpreter,
	opcode_t *cur_op, opcode_t *start)
{
    Hash *hash;
    Hash *hash2;
    STRING *key;
    PMC *value;

    UNUSED(cur_op);
    UNUSED(start);

    parrot_new_hash(interpreter, &hash);

    if ( hash == NULL ) {
	PIO_eprintf(interpreter, "hash creation failed\n");
	exit_value = 1;
	return NULL;
    }

    key = string_from_cstring(interpreter, "fortytwo", 0);
    value = pmc_new(interpreter, enum_class_Integer);
    VTABLE_set_integer_native(interpreter, value, 42);
    parrot_hash_put(interpreter, hash, key, value);

    value = parrot_hash_get(interpreter, hash, key);

    PIO_eprintf(interpreter, "%i\n", (int)VTABLE_get_integer(interpreter, value));

    parrot_hash_clone(interpreter, hash, &hash2);

    value = parrot_hash_get(interpreter, hash2, key);

    PIO_eprintf(interpreter, "%i\n", (int)VTABLE_get_integer(interpreter, value));

    return NULL;
}

CODE
42
42
OUTPUT

my $code_setup = <<'CODE';

static opcode_t*
the_test(Interp *interpreter,
	opcode_t *cur_op, opcode_t *start)
{
    PMC *hash, *iter;
    STRING *k;
    INTVAL b, v;

    UNUSED(cur_op);
    UNUSED(start);

    hash = pmc_new(interpreter, enum_class_Hash);

CODE

my $code_loop_top = <<'CODE';

    iter = VTABLE_get_iter(interpreter, hash);

    for (;;) {
	b = VTABLE_get_bool(interpreter, iter);
	if (!b)
	    break;
	k = VTABLE_shift_string(interpreter, iter);
	v = VTABLE_get_integer_keyed_str(interpreter, hash, k);
	/* a few keys are in add order */

CODE

my $code_loop_end = <<'CODE';

    }
    PIO_eprintf(interpreter, "\nok\n");
    return NULL;
}

CODE

c_output_is($main . $code_setup . <<'CODE1' . $code_loop_top . <<'CODE2' . $code_loop_end, <<'OUTPUT', "hash iteration");

    k    = const_string(interpreter, "a");
    VTABLE_set_integer_keyed_str(interpreter, hash, k, 10);

    k    = const_string(interpreter, "b");
    VTABLE_set_integer_keyed_str(interpreter, hash, k, 20);

    k    = const_string(interpreter, "c");
    VTABLE_set_integer_keyed_str(interpreter, hash, k, 30);

CODE1
	PIO_eprintf(interpreter, "%vd", v);
CODE2
102030
ok
OUTPUT

c_output_is($main . $code_setup . $code_loop_top . <<'CODE2' . $code_loop_end, <<'OUTPUT', "hash iteration on empty hash");
	PIO_eprintf(interpreter, "%p,%vd", k, v);
CODE2

ok
OUTPUT
