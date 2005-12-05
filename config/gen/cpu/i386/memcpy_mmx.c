/*
 * DO NOT EDIT THIS FILE
 *
 * Generated from memcpy_mmx_in.c via memcpy_mmx_in.s
 * by '../../../../tools/dev/as2c.pl memcpy_mmx_in'
 */

/*
 * GAS LISTING /home/chip/tmp/cci2hVe3.s 			page 1
 * 
 * 
 *    1              		.file	"memcpy_mmx_in.c"
 *    2              		.text
 *    3              		.p2align 4,,15
 *    4              	.globl Parrot_memcpy_aligned_mmx
 *
 */
static const char Parrot_memcpy_aligned_mmx_code[] = {
                           /* Parrot_memcpy_aligned_mmx: */
    0x57,                       /* pushl %edi */
    0x56,                       /* pushl %esi */
    0x53,                       /* pushl %ebx */
    0x83, 0xEC, 0x10,           /* subl $16, %esp */
    0x8B, 0x44, 0x24, 0x20,     /* movl 32(%esp), %eax */
    0x8B, 0x5C, 0x24, 0x24,     /* movl 36(%esp), %ebx */
    0x8B, 0x54, 0x24, 0x28,     /* movl 40(%esp), %edx */
    0xDD, 0x5C, 0x24, 0x08,     /* fstpl 8(%esp) */
    0x89, 0xC7,                 /* mov %eax, %edi */
    0x89, 0xDE,                 /* mov %ebx, %esi */
    0x89, 0xD1,                 /* mov %edx, %ecx */
    0xC1, 0xE9, 0x04,           /* shr $4, %ecx */
                           /* 1: */
    0x0F, 0x6F, 0x06,           /* movq 0(%esi), %mm0 */
    0x0F, 0x6F, 0x4E, 0x08,     /* movq 8(%esi), %mm1 */
    0x83, 0xC6, 0x10,           /* add $16, %esi */
    0x0F, 0x7F, 0x07,           /* movq %mm0, 0(%edi) */
    0x0F, 0x7F, 0x4F, 0x08,     /* movq %mm1, 8(%edi) */
    0x83, 0xC7, 0x10,           /* add $16, %edi */
    0x49,                       /* dec %ecx */
    0x75, 0xE9,                 /* jnz 1b */
    0x0F, 0x77,                 /* emms */
    0xDD, 0x44, 0x24, 0x08,     /* fldl 8(%esp) */
    0x83, 0xC4, 0x10,           /* addl $16, %esp */
    0x5B,                       /* popl %ebx */
    0x5E,                       /* popl %esi */
    0x5F,                       /* popl %edi */
    0xC3,                       /* ret */
    0x00
};

#include <stdlib.h>
typedef void* (*Parrot_memcpy_aligned_mmx_t)(void *dest, const void *src, size_t);

#ifndef NDEBUG
#include <assert.h>
static void*
Parrot_memcpy_aligned_mmx_debug(void* d, const void* s, size_t n)
{
    assert( (n & 0xf) == 0);
    assert( ((unsigned long) d & 7) == 0);
    assert( ((unsigned long) s & 7) == 0);
    return ((Parrot_memcpy_aligned_mmx_t)Parrot_memcpy_aligned_mmx_code)(d, s, n);
}

Parrot_memcpy_aligned_mmx_t Parrot_memcpy_aligned_mmx = Parrot_memcpy_aligned_mmx_debug;

#else
Parrot_memcpy_aligned_mmx_t Parrot_memcpy_aligned_mmx =
    (Parrot_memcpy_aligned_mmx_t) Parrot_memcpy_aligned_mmx_code;
#endif

#ifdef PARROT_CONFIG_TEST
#include <string.h>
#include <stdio.h>
int main(int argc, char *argv[]) {
    unsigned char *s, *d;
    size_t i, n;

    n = 640;	/* sizeof(reg_store) */

    s = malloc(n);
    for (i = 0; i < n; ++i)
	s[i] = i & 0xff;
    d = malloc(n);
    for (i = 0; i < n; ++i)
	d[i] = 0xff;
    Parrot_memcpy_aligned_mmx(d, s, n);
    for (i = 0; i < n; ++i)
	if (d[i] != (i & 0xff)) {
	    printf("error s[%d] = %d d = %d\n", i, s[i], d[i]);
	    exit(1);
	}
    puts("ok");
    return 0;
}
#endif /* PARROT_CONFIG_TEST */
