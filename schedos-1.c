#include "schedos-app.h"
#include "x86sync.h"

/*****************************************************************************
 * schedos-1
 *
 *   This tiny application prints red "1"s to the console.
 *   It yields the CPU to the kernel after each "1" using the sys_yield()
 *   system call.  This lets the kernel (schedos-kern.c) pick another
 *   application to run, if it wants.
 *
 *   The other schedos-* processes simply #include this file after defining
 *   PRINTCHAR appropriately.
 *
 *****************************************************************************/

#ifndef PRINTCHAR
#define PRINTCHAR	('1' | 0x0C00)
#endif

//for Exercise 4A
#ifndef PRIORITY
#define PRIORITY 4
#endif

//for Exercise 4B
#ifndef SHARE
#define SHARE 1
#endif

//comment out if you want to use lock system
//include if you want to use write as a system call
//for Exercise 8
#define LOCK

void
start(void)
{
	sys_share(SHARE);
	sys_priority(PRIORITY);
	sys_yield();
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
		//The code for exercise 8 starts
		#ifndef LOCK
			sys_print(PRINTCHAR);
		#endif
		//The code for exercise 8 ends
		//the code for exercise 6 starts
		#ifdef LOCK
			while (compare_and_swap(&lock, 0, 1) != 0)
				continue;
			// Write characters to the console, yielding after each one.
			*cursorpos++ = PRINTCHAR;
			atomic_swap(&lock, 0);
		#endif
		//the code for exercise 6 ends
		sys_yield();
	}

	sys_exit(0);
}
