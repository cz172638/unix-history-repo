/*-
 * Copyright (c) 1990, 1993
 *	The Regents of the University of California.  All rights reserved.
 *
 * This code is derived from software contributed to Berkeley by
 * the Systems Programming Group of the University of Utah Computer
 * Science Department.
 *
 * %sccs.include.redist.c%
 */

#if defined(LIBC_SCCS) && !defined(lint)
	.asciz "@(#)brk.s	8.1 (Berkeley) %G%"
#endif /* LIBC_SCCS and not lint */

#include "SYS.h"

#define	SYS_brk		17

	.globl	curbrk
	.globl	minbrk
ENTRY(brk)
	movl	minbrk,d0
	cmpl	sp@(4),d0
	jle	ok
	movl	d0,sp@(4)
ok:
	movl	#SYS_brk,d0
	trap	#0
	jcs	err
	movl	sp@(4),curbrk
	clrl	d0
	rts
err:
	jmp	cerror
