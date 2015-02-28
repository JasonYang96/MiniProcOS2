
obj/schedos-kern:     file format elf32-i386


Disassembly of section .text:

00100000 <multiboot>:
  100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
  100006:	00 00                	add    %al,(%eax)
  100008:	fe 4f 52             	decb   0x52(%edi)
  10000b:	e4 bc                	in     $0xbc,%al

0010000c <multiboot_start>:
# The multiboot_start routine sets the stack pointer to the top of the
# SchedOS's kernel stack, then jumps to the 'start' routine in schedos-kern.c.

.globl multiboot_start
multiboot_start:
	movl $0x180000, %esp
  10000c:	bc 00 00 18 00       	mov    $0x180000,%esp
	pushl $0
  100011:	6a 00                	push   $0x0
	popfl
  100013:	9d                   	popf   
	call start
  100014:	e8 da 01 00 00       	call   1001f3 <start>
  100019:	90                   	nop

0010001a <clock_int_handler>:
# Interrupt handlers
.align 2

	.globl clock_int_handler
clock_int_handler:
	pushl $0		// error code
  10001a:	6a 00                	push   $0x0
	pushl $32		// trap number
  10001c:	6a 20                	push   $0x20
	jmp _generic_int_handler
  10001e:	eb 40                	jmp    100060 <_generic_int_handler>

00100020 <sys_int48_handler>:

sys_int48_handler:
	pushl $0
  100020:	6a 00                	push   $0x0
	pushl $48
  100022:	6a 30                	push   $0x30
	jmp _generic_int_handler
  100024:	eb 3a                	jmp    100060 <_generic_int_handler>

00100026 <sys_int49_handler>:

sys_int49_handler:
	pushl $0
  100026:	6a 00                	push   $0x0
	pushl $49
  100028:	6a 31                	push   $0x31
	jmp _generic_int_handler
  10002a:	eb 34                	jmp    100060 <_generic_int_handler>

0010002c <sys_int50_handler>:

sys_int50_handler:
	pushl $0
  10002c:	6a 00                	push   $0x0
	pushl $50
  10002e:	6a 32                	push   $0x32
	jmp _generic_int_handler
  100030:	eb 2e                	jmp    100060 <_generic_int_handler>

00100032 <sys_int51_handler>:

sys_int51_handler:
	pushl $0
  100032:	6a 00                	push   $0x0
	pushl $51
  100034:	6a 33                	push   $0x33
	jmp _generic_int_handler
  100036:	eb 28                	jmp    100060 <_generic_int_handler>

00100038 <sys_int52_handler>:

sys_int52_handler:
	pushl $0
  100038:	6a 00                	push   $0x0
	pushl $52
  10003a:	6a 34                	push   $0x34
	jmp _generic_int_handler
  10003c:	eb 22                	jmp    100060 <_generic_int_handler>

0010003e <sys_int53_handler>:

sys_int53_handler:
	pushl $0
  10003e:	6a 00                	push   $0x0
	pushl $53
  100040:	6a 35                	push   $0x35
	jmp _generic_int_handler
  100042:	eb 1c                	jmp    100060 <_generic_int_handler>

00100044 <sys_int54_handler>:

sys_int54_handler:
	pushl $0
  100044:	6a 00                	push   $0x0
	pushl $54
  100046:	6a 36                	push   $0x36
	jmp _generic_int_handler
  100048:	eb 16                	jmp    100060 <_generic_int_handler>

0010004a <sys_int55_handler>:

sys_int55_handler:
	pushl $0
  10004a:	6a 00                	push   $0x0
	pushl $55
  10004c:	6a 37                	push   $0x37
	jmp _generic_int_handler
  10004e:	eb 10                	jmp    100060 <_generic_int_handler>

00100050 <sys_int56_handler>:

sys_int56_handler:
	pushl $0
  100050:	6a 00                	push   $0x0
	pushl $56
  100052:	6a 38                	push   $0x38
	jmp _generic_int_handler
  100054:	eb 0a                	jmp    100060 <_generic_int_handler>

00100056 <sys_int57_handler>:

sys_int57_handler:
	pushl $0
  100056:	6a 00                	push   $0x0
	pushl $57
  100058:	6a 39                	push   $0x39
	jmp _generic_int_handler
  10005a:	eb 04                	jmp    100060 <_generic_int_handler>

0010005c <default_int_handler>:

	.globl default_int_handler
default_int_handler:
	pushl $0
  10005c:	6a 00                	push   $0x0
	jmp _generic_int_handler
  10005e:	eb 00                	jmp    100060 <_generic_int_handler>

00100060 <_generic_int_handler>:
	# When we get here, the processor's interrupt mechanism has
	# pushed the old task status and stack registers onto the kernel stack.
	# Then one of the specific handlers pushed the trap number.
	# Now, we complete the 'registers_t' structure by pushing the extra
	# segment definitions and the general CPU registers.
	pushl %ds
  100060:	1e                   	push   %ds
	pushl %es
  100061:	06                   	push   %es
	pushal
  100062:	60                   	pusha  

	# Load the kernel's data segments into the extra segment registers
	# (although we don't use those extra segments!).
	movl $0x10, %eax
  100063:	b8 10 00 00 00       	mov    $0x10,%eax
	movw %ax, %ds
  100068:	8e d8                	mov    %eax,%ds
	movw %ax, %es
  10006a:	8e c0                	mov    %eax,%es

	# Call the kernel's 'interrupt' function.
	pushl %esp
  10006c:	54                   	push   %esp
	call interrupt
  10006d:	e8 10 01 00 00       	call   100182 <interrupt>

00100072 <sys_int_handlers>:
  100072:	20 00                	and    %al,(%eax)
  100074:	10 00                	adc    %al,(%eax)
  100076:	26 00 10             	add    %dl,%es:(%eax)
  100079:	00 2c 00             	add    %ch,(%eax,%eax,1)
  10007c:	10 00                	adc    %al,(%eax)
  10007e:	32 00                	xor    (%eax),%al
  100080:	10 00                	adc    %al,(%eax)
  100082:	38 00                	cmp    %al,(%eax)
  100084:	10 00                	adc    %al,(%eax)
  100086:	3e 00 10             	add    %dl,%ds:(%eax)
  100089:	00 44 00 10          	add    %al,0x10(%eax,%eax,1)
  10008d:	00 4a 00             	add    %cl,0x0(%edx)
  100090:	10 00                	adc    %al,(%eax)
  100092:	50                   	push   %eax
  100093:	00 10                	add    %dl,(%eax)
  100095:	00 56 00             	add    %dl,0x0(%esi)
  100098:	10 00                	adc    %al,(%eax)
  10009a:	90                   	nop
  10009b:	90                   	nop

0010009c <schedule>:
 *
 *****************************************************************************/

void
schedule(void)
{
  10009c:	56                   	push   %esi
  10009d:	53                   	push   %ebx
  10009e:	83 ec 04             	sub    $0x4,%esp
	pid_t pid = current->p_pid;
  1000a1:	a1 e0 7b 10 00       	mov    0x107be0,%eax
  1000a6:	8b 10                	mov    (%eax),%edx
	unsigned int priority = 0xffffffff;

	if (scheduling_algorithm == 0)
  1000a8:	a1 e4 7b 10 00       	mov    0x107be4,%eax
  1000ad:	85 c0                	test   %eax,%eax
  1000af:	75 1c                	jne    1000cd <schedule+0x31>
	{
		while (1) {
			pid = (pid + 1) % NPROCS;
  1000b1:	b9 05 00 00 00       	mov    $0x5,%ecx
  1000b6:	8d 42 01             	lea    0x1(%edx),%eax
  1000b9:	99                   	cltd   
  1000ba:	f7 f9                	idiv   %ecx

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000bc:	6b c2 54             	imul   $0x54,%edx,%eax
  1000bf:	83 b8 1c 72 10 00 01 	cmpl   $0x1,0x10721c(%eax)
  1000c6:	75 ee                	jne    1000b6 <schedule+0x1a>
				run(&proc_array[pid]);
  1000c8:	83 ec 0c             	sub    $0xc,%esp
  1000cb:	eb 1c                	jmp    1000e9 <schedule+0x4d>
		}
	}

	if (scheduling_algorithm == 1) //priority based on lowest pid
  1000cd:	83 f8 01             	cmp    $0x1,%eax
  1000d0:	75 33                	jne    100105 <schedule+0x69>
  1000d2:	ba 01 00 00 00       	mov    $0x1,%edx
	{
		while (1) {
			for (pid = 1; pid < NPROCS; pid++)
			{
				if (proc_array[pid].p_state == P_RUNNABLE)
  1000d7:	6b ca 54             	imul   $0x54,%edx,%ecx
  1000da:	83 b9 1c 72 10 00 01 	cmpl   $0x1,0x10721c(%ecx)
  1000e1:	75 11                	jne    1000f4 <schedule+0x58>
					run(&proc_array[pid]);
  1000e3:	6b c0 54             	imul   $0x54,%eax,%eax
  1000e6:	83 ec 0c             	sub    $0xc,%esp
  1000e9:	05 d4 71 10 00       	add    $0x1071d4,%eax
  1000ee:	50                   	push   %eax
  1000ef:	e8 19 04 00 00       	call   10050d <run>
	}

	if (scheduling_algorithm == 1) //priority based on lowest pid
	{
		while (1) {
			for (pid = 1; pid < NPROCS; pid++)
  1000f4:	8d 42 01             	lea    0x1(%edx),%eax
  1000f7:	83 f8 04             	cmp    $0x4,%eax
			if (proc_array[pid].p_state == P_RUNNABLE)
				run(&proc_array[pid]);
		}
	}

	if (scheduling_algorithm == 1) //priority based on lowest pid
  1000fa:	89 c2                	mov    %eax,%edx
	{
		while (1) {
			for (pid = 1; pid < NPROCS; pid++)
  1000fc:	7e d9                	jle    1000d7 <schedule+0x3b>
  1000fe:	b8 01 00 00 00       	mov    $0x1,%eax
  100103:	eb cd                	jmp    1000d2 <schedule+0x36>
					run(&proc_array[pid]);
			}
		}
	}

	if (scheduling_algorithm == 2) //priority based on lowerst p_priority
  100105:	83 f8 02             	cmp    $0x2,%eax
  100108:	75 57                	jne    100161 <schedule+0xc5>
  10010a:	bb 01 00 00 00       	mov    $0x1,%ebx
  10010f:	83 ce ff             	or     $0xffffffff,%esi
					priority = proc_array[index].p_priority;
				}
			}
			// search for proc with that priority
			// increment pid by 1 to "alternate"
			for (pid = (pid + 1) % NPROCS; pid < NPROCS; pid = (pid + 1) % NPROCS)
  100112:	b9 05 00 00 00       	mov    $0x5,%ecx
  100117:	eb 19                	jmp    100132 <schedule+0x96>
		int index = 1;
		while (1) {
			//find lowest p_priority
			for (; index < NPROCS; index++)
			{
				if (proc_array[index].p_state == P_RUNNABLE &&
  100119:	6b c3 54             	imul   $0x54,%ebx,%eax
  10011c:	83 b8 1c 72 10 00 01 	cmpl   $0x1,0x10721c(%eax)
  100123:	75 0c                	jne    100131 <schedule+0x95>
  100125:	8b 80 24 72 10 00    	mov    0x107224(%eax),%eax
  10012b:	39 c6                	cmp    %eax,%esi
  10012d:	76 02                	jbe    100131 <schedule+0x95>
  10012f:	89 c6                	mov    %eax,%esi
	if (scheduling_algorithm == 2) //priority based on lowerst p_priority
	{
		int index = 1;
		while (1) {
			//find lowest p_priority
			for (; index < NPROCS; index++)
  100131:	43                   	inc    %ebx
  100132:	83 fb 04             	cmp    $0x4,%ebx
  100135:	7e e2                	jle    100119 <schedule+0x7d>
  100137:	eb 1b                	jmp    100154 <schedule+0xb8>
			}
			// search for proc with that priority
			// increment pid by 1 to "alternate"
			for (pid = (pid + 1) % NPROCS; pid < NPROCS; pid = (pid + 1) % NPROCS)
			{
				if (proc_array[pid].p_state == P_RUNNABLE &&
  100139:	6b c2 54             	imul   $0x54,%edx,%eax
  10013c:	83 b8 1c 72 10 00 01 	cmpl   $0x1,0x10721c(%eax)
  100143:	75 0f                	jne    100154 <schedule+0xb8>
  100145:	05 d4 71 10 00       	add    $0x1071d4,%eax
  10014a:	39 70 50             	cmp    %esi,0x50(%eax)
  10014d:	77 05                	ja     100154 <schedule+0xb8>
					proc_array[pid].p_priority <= priority)
				{
					run(&proc_array[pid]);
  10014f:	83 ec 0c             	sub    $0xc,%esp
  100152:	eb 9a                	jmp    1000ee <schedule+0x52>
					priority = proc_array[index].p_priority;
				}
			}
			// search for proc with that priority
			// increment pid by 1 to "alternate"
			for (pid = (pid + 1) % NPROCS; pid < NPROCS; pid = (pid + 1) % NPROCS)
  100154:	8d 42 01             	lea    0x1(%edx),%eax
  100157:	99                   	cltd   
  100158:	f7 f9                	idiv   %ecx
  10015a:	83 fa 04             	cmp    $0x4,%edx
  10015d:	7e da                	jle    100139 <schedule+0x9d>
  10015f:	eb d1                	jmp    100132 <schedule+0x96>
		}
	}


	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  100161:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100167:	50                   	push   %eax
  100168:	68 cc 0a 10 00       	push   $0x100acc
  10016d:	68 00 01 00 00       	push   $0x100
  100172:	52                   	push   %edx
  100173:	e8 3a 09 00 00       	call   100ab2 <console_printf>
  100178:	83 c4 10             	add    $0x10,%esp
  10017b:	a3 00 80 19 00       	mov    %eax,0x198000
  100180:	eb fe                	jmp    100180 <schedule+0xe4>

00100182 <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  100182:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  100183:	a1 e0 7b 10 00       	mov    0x107be0,%eax
  100188:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  10018d:	56                   	push   %esi
  10018e:	53                   	push   %ebx
  10018f:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  100193:	8d 78 04             	lea    0x4(%eax),%edi
  100196:	89 de                	mov    %ebx,%esi
  100198:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  10019a:	8b 53 28             	mov    0x28(%ebx),%edx
  10019d:	83 fa 31             	cmp    $0x31,%edx
  1001a0:	74 1f                	je     1001c1 <interrupt+0x3f>
  1001a2:	77 0c                	ja     1001b0 <interrupt+0x2e>
  1001a4:	83 fa 20             	cmp    $0x20,%edx
  1001a7:	74 43                	je     1001ec <interrupt+0x6a>
  1001a9:	83 fa 30             	cmp    $0x30,%edx
  1001ac:	74 0e                	je     1001bc <interrupt+0x3a>
  1001ae:	eb 41                	jmp    1001f1 <interrupt+0x6f>
  1001b0:	83 fa 32             	cmp    $0x32,%edx
  1001b3:	74 23                	je     1001d8 <interrupt+0x56>
  1001b5:	83 fa 33             	cmp    $0x33,%edx
  1001b8:	74 29                	je     1001e3 <interrupt+0x61>
  1001ba:	eb 35                	jmp    1001f1 <interrupt+0x6f>

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  1001bc:	e8 db fe ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  1001c1:	a1 e0 7b 10 00       	mov    0x107be0,%eax
		current->p_exit_status = reg->reg_eax;
  1001c6:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  1001c9:	c7 40 48 03 00 00 00 	movl   $0x3,0x48(%eax)
		current->p_exit_status = reg->reg_eax;
  1001d0:	89 50 4c             	mov    %edx,0x4c(%eax)
		schedule();
  1001d3:	e8 c4 fe ff ff       	call   10009c <schedule>

	case INT_SYS_PRIORITY:
		// The 'sys_priority' system call initializes the p_priority var
		// of a process.
		current->p_priority = reg->reg_eax;
  1001d8:	a1 e0 7b 10 00       	mov    0x107be0,%eax
  1001dd:	8b 53 1c             	mov    0x1c(%ebx),%edx
  1001e0:	89 50 50             	mov    %edx,0x50(%eax)
		run(current);

	case INT_SYS_USER2:
		/* Your code here (if you want). */
		run(current);
  1001e3:	83 ec 0c             	sub    $0xc,%esp
  1001e6:	50                   	push   %eax
  1001e7:	e8 21 03 00 00       	call   10050d <run>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  1001ec:	e8 ab fe ff ff       	call   10009c <schedule>
  1001f1:	eb fe                	jmp    1001f1 <interrupt+0x6f>

001001f3 <start>:
 *
 *****************************************************************************/

void
start(void)
{
  1001f3:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1001f4:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  1001f9:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1001fa:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  1001fc:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1001fd:	bb 28 72 10 00       	mov    $0x107228,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  100202:	e8 e5 00 00 00       	call   1002ec <segments_init>
	interrupt_controller_init(0);
  100207:	83 ec 0c             	sub    $0xc,%esp
  10020a:	6a 00                	push   $0x0
  10020c:	e8 d6 01 00 00       	call   1003e7 <interrupt_controller_init>
	console_clear();
  100211:	e8 5a 02 00 00       	call   100470 <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  100216:	83 c4 0c             	add    $0xc,%esp
  100219:	68 a4 01 00 00       	push   $0x1a4
  10021e:	6a 00                	push   $0x0
  100220:	68 d4 71 10 00       	push   $0x1071d4
  100225:	e8 26 04 00 00       	call   100650 <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  10022a:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10022d:	c7 05 d4 71 10 00 00 	movl   $0x0,0x1071d4
  100234:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100237:	c7 05 1c 72 10 00 00 	movl   $0x0,0x10721c
  10023e:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100241:	c7 05 28 72 10 00 01 	movl   $0x1,0x107228
  100248:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10024b:	c7 05 70 72 10 00 00 	movl   $0x0,0x107270
  100252:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100255:	c7 05 7c 72 10 00 02 	movl   $0x2,0x10727c
  10025c:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10025f:	c7 05 c4 72 10 00 00 	movl   $0x0,0x1072c4
  100266:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100269:	c7 05 d0 72 10 00 03 	movl   $0x3,0x1072d0
  100270:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100273:	c7 05 18 73 10 00 00 	movl   $0x0,0x107318
  10027a:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10027d:	c7 05 24 73 10 00 04 	movl   $0x4,0x107324
  100284:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100287:	c7 05 6c 73 10 00 00 	movl   $0x0,0x10736c
  10028e:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  100291:	83 ec 0c             	sub    $0xc,%esp
  100294:	53                   	push   %ebx
  100295:	e8 8a 02 00 00       	call   100524 <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  10029a:	58                   	pop    %eax
  10029b:	5a                   	pop    %edx
  10029c:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  10029f:	89 7b 40             	mov    %edi,0x40(%ebx)
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;

		proc->p_priority = 0;
  1002a2:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1002a8:	50                   	push   %eax
  1002a9:	56                   	push   %esi

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;

		proc->p_priority = 0;
  1002aa:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1002ab:	e8 b0 02 00 00       	call   100560 <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  1002b0:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  1002b3:	c7 43 48 01 00 00 00 	movl   $0x1,0x48(%ebx)

		proc->p_priority = 0;
  1002ba:	c7 43 50 00 00 00 00 	movl   $0x0,0x50(%ebx)
  1002c1:	83 c3 54             	add    $0x54,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  1002c4:	83 fe 04             	cmp    $0x4,%esi
  1002c7:	75 c8                	jne    100291 <start+0x9e>

	// Initialize the scheduling algorithm.
	scheduling_algorithm = 2;

	// Switch to the first process.
	run(&proc_array[1]);
  1002c9:	83 ec 0c             	sub    $0xc,%esp
  1002cc:	68 28 72 10 00       	push   $0x107228
		proc->p_priority = 0;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  1002d1:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  1002d8:	80 0b 00 

	// Initialize the scheduling algorithm.
	scheduling_algorithm = 2;
  1002db:	c7 05 e4 7b 10 00 02 	movl   $0x2,0x107be4
  1002e2:	00 00 00 

	// Switch to the first process.
	run(&proc_array[1]);
  1002e5:	e8 23 02 00 00       	call   10050d <run>
  1002ea:	90                   	nop
  1002eb:	90                   	nop

001002ec <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002ec:	b8 78 73 10 00       	mov    $0x107378,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002f1:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002f6:	89 c2                	mov    %eax,%edx
  1002f8:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  1002fb:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002fc:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  100301:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100304:	66 a3 3a 10 10 00    	mov    %ax,0x10103a
  10030a:	c1 e8 18             	shr    $0x18,%eax
  10030d:	88 15 3c 10 10 00    	mov    %dl,0x10103c
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100313:	ba e0 73 10 00       	mov    $0x1073e0,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100318:	a2 3f 10 10 00       	mov    %al,0x10103f
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10031d:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10031f:	66 c7 05 38 10 10 00 	movw   $0x68,0x101038
  100326:	68 00 
  100328:	c6 05 3e 10 10 00 40 	movb   $0x40,0x10103e
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  10032f:	c6 05 3d 10 10 00 89 	movb   $0x89,0x10103d

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  100336:	c7 05 7c 73 10 00 00 	movl   $0x180000,0x10737c
  10033d:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  100340:	66 c7 05 80 73 10 00 	movw   $0x10,0x107380
  100347:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100349:	66 89 0c c5 e0 73 10 	mov    %cx,0x1073e0(,%eax,8)
  100350:	00 
  100351:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100358:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  10035d:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  100362:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  100367:	40                   	inc    %eax
  100368:	3d 00 01 00 00       	cmp    $0x100,%eax
  10036d:	75 da                	jne    100349 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  10036f:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100374:	ba e0 73 10 00       	mov    $0x1073e0,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100379:	66 a3 e0 74 10 00    	mov    %ax,0x1074e0
  10037f:	c1 e8 10             	shr    $0x10,%eax
  100382:	66 a3 e6 74 10 00    	mov    %ax,0x1074e6
  100388:	b8 30 00 00 00       	mov    $0x30,%eax
  10038d:	66 c7 05 e2 74 10 00 	movw   $0x8,0x1074e2
  100394:	08 00 
  100396:	c6 05 e4 74 10 00 00 	movb   $0x0,0x1074e4
  10039d:	c6 05 e5 74 10 00 8e 	movb   $0x8e,0x1074e5

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003a4:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  1003ab:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1003b2:	66 89 0c c5 e0 73 10 	mov    %cx,0x1073e0(,%eax,8)
  1003b9:	00 
  1003ba:	c1 e9 10             	shr    $0x10,%ecx
  1003bd:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1003c2:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  1003c7:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  1003cc:	40                   	inc    %eax
  1003cd:	83 f8 3a             	cmp    $0x3a,%eax
  1003d0:	75 d2                	jne    1003a4 <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  1003d2:	b0 28                	mov    $0x28,%al
  1003d4:	0f 01 15 00 10 10 00 	lgdtl  0x101000
  1003db:	0f 00 d8             	ltr    %ax
  1003de:	0f 01 1d 08 10 10 00 	lidtl  0x101008
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  1003e5:	5b                   	pop    %ebx
  1003e6:	c3                   	ret    

001003e7 <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  1003e7:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  1003e8:	b0 ff                	mov    $0xff,%al
  1003ea:	57                   	push   %edi
  1003eb:	56                   	push   %esi
  1003ec:	53                   	push   %ebx
  1003ed:	bb 21 00 00 00       	mov    $0x21,%ebx
  1003f2:	89 da                	mov    %ebx,%edx
  1003f4:	ee                   	out    %al,(%dx)
  1003f5:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  1003fa:	89 ca                	mov    %ecx,%edx
  1003fc:	ee                   	out    %al,(%dx)
  1003fd:	be 11 00 00 00       	mov    $0x11,%esi
  100402:	bf 20 00 00 00       	mov    $0x20,%edi
  100407:	89 f0                	mov    %esi,%eax
  100409:	89 fa                	mov    %edi,%edx
  10040b:	ee                   	out    %al,(%dx)
  10040c:	b0 20                	mov    $0x20,%al
  10040e:	89 da                	mov    %ebx,%edx
  100410:	ee                   	out    %al,(%dx)
  100411:	b0 04                	mov    $0x4,%al
  100413:	ee                   	out    %al,(%dx)
  100414:	b0 03                	mov    $0x3,%al
  100416:	ee                   	out    %al,(%dx)
  100417:	bd a0 00 00 00       	mov    $0xa0,%ebp
  10041c:	89 f0                	mov    %esi,%eax
  10041e:	89 ea                	mov    %ebp,%edx
  100420:	ee                   	out    %al,(%dx)
  100421:	b0 28                	mov    $0x28,%al
  100423:	89 ca                	mov    %ecx,%edx
  100425:	ee                   	out    %al,(%dx)
  100426:	b0 02                	mov    $0x2,%al
  100428:	ee                   	out    %al,(%dx)
  100429:	b0 01                	mov    $0x1,%al
  10042b:	ee                   	out    %al,(%dx)
  10042c:	b0 68                	mov    $0x68,%al
  10042e:	89 fa                	mov    %edi,%edx
  100430:	ee                   	out    %al,(%dx)
  100431:	be 0a 00 00 00       	mov    $0xa,%esi
  100436:	89 f0                	mov    %esi,%eax
  100438:	ee                   	out    %al,(%dx)
  100439:	b0 68                	mov    $0x68,%al
  10043b:	89 ea                	mov    %ebp,%edx
  10043d:	ee                   	out    %al,(%dx)
  10043e:	89 f0                	mov    %esi,%eax
  100440:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  100441:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  100446:	89 da                	mov    %ebx,%edx
  100448:	19 c0                	sbb    %eax,%eax
  10044a:	f7 d0                	not    %eax
  10044c:	05 ff 00 00 00       	add    $0xff,%eax
  100451:	ee                   	out    %al,(%dx)
  100452:	b0 ff                	mov    $0xff,%al
  100454:	89 ca                	mov    %ecx,%edx
  100456:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  100457:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  10045c:	74 0d                	je     10046b <interrupt_controller_init+0x84>
  10045e:	b2 43                	mov    $0x43,%dl
  100460:	b0 34                	mov    $0x34,%al
  100462:	ee                   	out    %al,(%dx)
  100463:	b0 a9                	mov    $0xa9,%al
  100465:	b2 40                	mov    $0x40,%dl
  100467:	ee                   	out    %al,(%dx)
  100468:	b0 04                	mov    $0x4,%al
  10046a:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  10046b:	5b                   	pop    %ebx
  10046c:	5e                   	pop    %esi
  10046d:	5f                   	pop    %edi
  10046e:	5d                   	pop    %ebp
  10046f:	c3                   	ret    

00100470 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  100470:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100471:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  100473:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100474:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  10047b:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  10047e:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100484:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  10048a:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  10048d:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  100492:	75 ea                	jne    10047e <console_clear+0xe>
  100494:	be d4 03 00 00       	mov    $0x3d4,%esi
  100499:	b0 0e                	mov    $0xe,%al
  10049b:	89 f2                	mov    %esi,%edx
  10049d:	ee                   	out    %al,(%dx)
  10049e:	31 c9                	xor    %ecx,%ecx
  1004a0:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  1004a5:	88 c8                	mov    %cl,%al
  1004a7:	89 da                	mov    %ebx,%edx
  1004a9:	ee                   	out    %al,(%dx)
  1004aa:	b0 0f                	mov    $0xf,%al
  1004ac:	89 f2                	mov    %esi,%edx
  1004ae:	ee                   	out    %al,(%dx)
  1004af:	88 c8                	mov    %cl,%al
  1004b1:	89 da                	mov    %ebx,%edx
  1004b3:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  1004b4:	5b                   	pop    %ebx
  1004b5:	5e                   	pop    %esi
  1004b6:	c3                   	ret    

001004b7 <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  1004b7:	ba 64 00 00 00       	mov    $0x64,%edx
  1004bc:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  1004bd:	a8 01                	test   $0x1,%al
  1004bf:	74 45                	je     100506 <console_read_digit+0x4f>
  1004c1:	b2 60                	mov    $0x60,%dl
  1004c3:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  1004c4:	8d 50 fe             	lea    -0x2(%eax),%edx
  1004c7:	80 fa 08             	cmp    $0x8,%dl
  1004ca:	77 05                	ja     1004d1 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  1004cc:	0f b6 c0             	movzbl %al,%eax
  1004cf:	48                   	dec    %eax
  1004d0:	c3                   	ret    
	else if (data == 0x0B)
  1004d1:	3c 0b                	cmp    $0xb,%al
  1004d3:	74 35                	je     10050a <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  1004d5:	8d 50 b9             	lea    -0x47(%eax),%edx
  1004d8:	80 fa 02             	cmp    $0x2,%dl
  1004db:	77 07                	ja     1004e4 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  1004dd:	0f b6 c0             	movzbl %al,%eax
  1004e0:	83 e8 40             	sub    $0x40,%eax
  1004e3:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  1004e4:	8d 50 b5             	lea    -0x4b(%eax),%edx
  1004e7:	80 fa 02             	cmp    $0x2,%dl
  1004ea:	77 07                	ja     1004f3 <console_read_digit+0x3c>
		return data - 0x4B + 4;
  1004ec:	0f b6 c0             	movzbl %al,%eax
  1004ef:	83 e8 47             	sub    $0x47,%eax
  1004f2:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  1004f3:	8d 50 b1             	lea    -0x4f(%eax),%edx
  1004f6:	80 fa 02             	cmp    $0x2,%dl
  1004f9:	77 07                	ja     100502 <console_read_digit+0x4b>
		return data - 0x4F + 1;
  1004fb:	0f b6 c0             	movzbl %al,%eax
  1004fe:	83 e8 4e             	sub    $0x4e,%eax
  100501:	c3                   	ret    
	else if (data == 0x53)
  100502:	3c 53                	cmp    $0x53,%al
  100504:	74 04                	je     10050a <console_read_digit+0x53>
  100506:	83 c8 ff             	or     $0xffffffff,%eax
  100509:	c3                   	ret    
  10050a:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  10050c:	c3                   	ret    

0010050d <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  10050d:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  100511:	a3 e0 7b 10 00       	mov    %eax,0x107be0

	asm volatile("movl %0,%%esp\n\t"
  100516:	83 c0 04             	add    $0x4,%eax
  100519:	89 c4                	mov    %eax,%esp
  10051b:	61                   	popa   
  10051c:	07                   	pop    %es
  10051d:	1f                   	pop    %ds
  10051e:	83 c4 08             	add    $0x8,%esp
  100521:	cf                   	iret   
  100522:	eb fe                	jmp    100522 <run+0x15>

00100524 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  100524:	53                   	push   %ebx
  100525:	83 ec 0c             	sub    $0xc,%esp
  100528:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  10052c:	6a 44                	push   $0x44
  10052e:	6a 00                	push   $0x0
  100530:	8d 43 04             	lea    0x4(%ebx),%eax
  100533:	50                   	push   %eax
  100534:	e8 17 01 00 00       	call   100650 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  100539:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  10053f:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  100545:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  10054b:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  100551:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  100558:	83 c4 18             	add    $0x18,%esp
  10055b:	5b                   	pop    %ebx
  10055c:	c3                   	ret    
  10055d:	90                   	nop
  10055e:	90                   	nop
  10055f:	90                   	nop

00100560 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  100560:	55                   	push   %ebp
  100561:	57                   	push   %edi
  100562:	56                   	push   %esi
  100563:	53                   	push   %ebx
  100564:	83 ec 1c             	sub    $0x1c,%esp
  100567:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  10056b:	83 f8 03             	cmp    $0x3,%eax
  10056e:	7f 04                	jg     100574 <program_loader+0x14>
  100570:	85 c0                	test   %eax,%eax
  100572:	79 02                	jns    100576 <program_loader+0x16>
  100574:	eb fe                	jmp    100574 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  100576:	8b 34 c5 40 10 10 00 	mov    0x101040(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  10057d:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  100583:	74 02                	je     100587 <program_loader+0x27>
  100585:	eb fe                	jmp    100585 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100587:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  10058a:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10058e:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  100590:	c1 e5 05             	shl    $0x5,%ebp
  100593:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  100596:	eb 3f                	jmp    1005d7 <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  100598:	83 3b 01             	cmpl   $0x1,(%ebx)
  10059b:	75 37                	jne    1005d4 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  10059d:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1005a0:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  1005a3:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1005a6:	01 c7                	add    %eax,%edi
	memsz += va;
  1005a8:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  1005aa:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  1005af:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  1005b3:	52                   	push   %edx
  1005b4:	89 fa                	mov    %edi,%edx
  1005b6:	29 c2                	sub    %eax,%edx
  1005b8:	52                   	push   %edx
  1005b9:	8b 53 04             	mov    0x4(%ebx),%edx
  1005bc:	01 f2                	add    %esi,%edx
  1005be:	52                   	push   %edx
  1005bf:	50                   	push   %eax
  1005c0:	e8 27 00 00 00       	call   1005ec <memcpy>
  1005c5:	83 c4 10             	add    $0x10,%esp
  1005c8:	eb 04                	jmp    1005ce <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  1005ca:	c6 07 00             	movb   $0x0,(%edi)
  1005cd:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  1005ce:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  1005d2:	72 f6                	jb     1005ca <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  1005d4:	83 c3 20             	add    $0x20,%ebx
  1005d7:	39 eb                	cmp    %ebp,%ebx
  1005d9:	72 bd                	jb     100598 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  1005db:	8b 56 18             	mov    0x18(%esi),%edx
  1005de:	8b 44 24 34          	mov    0x34(%esp),%eax
  1005e2:	89 10                	mov    %edx,(%eax)
}
  1005e4:	83 c4 1c             	add    $0x1c,%esp
  1005e7:	5b                   	pop    %ebx
  1005e8:	5e                   	pop    %esi
  1005e9:	5f                   	pop    %edi
  1005ea:	5d                   	pop    %ebp
  1005eb:	c3                   	ret    

001005ec <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  1005ec:	56                   	push   %esi
  1005ed:	31 d2                	xor    %edx,%edx
  1005ef:	53                   	push   %ebx
  1005f0:	8b 44 24 0c          	mov    0xc(%esp),%eax
  1005f4:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  1005f8:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1005fc:	eb 08                	jmp    100606 <memcpy+0x1a>
		*d++ = *s++;
  1005fe:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  100601:	4e                   	dec    %esi
  100602:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  100605:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100606:	85 f6                	test   %esi,%esi
  100608:	75 f4                	jne    1005fe <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  10060a:	5b                   	pop    %ebx
  10060b:	5e                   	pop    %esi
  10060c:	c3                   	ret    

0010060d <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  10060d:	57                   	push   %edi
  10060e:	56                   	push   %esi
  10060f:	53                   	push   %ebx
  100610:	8b 44 24 10          	mov    0x10(%esp),%eax
  100614:	8b 7c 24 14          	mov    0x14(%esp),%edi
  100618:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  10061c:	39 c7                	cmp    %eax,%edi
  10061e:	73 26                	jae    100646 <memmove+0x39>
  100620:	8d 34 17             	lea    (%edi,%edx,1),%esi
  100623:	39 c6                	cmp    %eax,%esi
  100625:	76 1f                	jbe    100646 <memmove+0x39>
		s += n, d += n;
  100627:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  10062a:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  10062c:	eb 07                	jmp    100635 <memmove+0x28>
			*--d = *--s;
  10062e:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  100631:	4a                   	dec    %edx
  100632:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  100635:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  100636:	85 d2                	test   %edx,%edx
  100638:	75 f4                	jne    10062e <memmove+0x21>
  10063a:	eb 10                	jmp    10064c <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  10063c:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  10063f:	4a                   	dec    %edx
  100640:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  100643:	41                   	inc    %ecx
  100644:	eb 02                	jmp    100648 <memmove+0x3b>
  100646:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  100648:	85 d2                	test   %edx,%edx
  10064a:	75 f0                	jne    10063c <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  10064c:	5b                   	pop    %ebx
  10064d:	5e                   	pop    %esi
  10064e:	5f                   	pop    %edi
  10064f:	c3                   	ret    

00100650 <memset>:

void *
memset(void *v, int c, size_t n)
{
  100650:	53                   	push   %ebx
  100651:	8b 44 24 08          	mov    0x8(%esp),%eax
  100655:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  100659:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  10065d:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  10065f:	eb 04                	jmp    100665 <memset+0x15>
		*p++ = c;
  100661:	88 1a                	mov    %bl,(%edx)
  100663:	49                   	dec    %ecx
  100664:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  100665:	85 c9                	test   %ecx,%ecx
  100667:	75 f8                	jne    100661 <memset+0x11>
		*p++ = c;
	return v;
}
  100669:	5b                   	pop    %ebx
  10066a:	c3                   	ret    

0010066b <strlen>:

size_t
strlen(const char *s)
{
  10066b:	8b 54 24 04          	mov    0x4(%esp),%edx
  10066f:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100671:	eb 01                	jmp    100674 <strlen+0x9>
		++n;
  100673:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100674:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  100678:	75 f9                	jne    100673 <strlen+0x8>
		++n;
	return n;
}
  10067a:	c3                   	ret    

0010067b <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  10067b:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  10067f:	31 c0                	xor    %eax,%eax
  100681:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100685:	eb 01                	jmp    100688 <strnlen+0xd>
		++n;
  100687:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100688:	39 d0                	cmp    %edx,%eax
  10068a:	74 06                	je     100692 <strnlen+0x17>
  10068c:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  100690:	75 f5                	jne    100687 <strnlen+0xc>
		++n;
	return n;
}
  100692:	c3                   	ret    

00100693 <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100693:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  100694:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100699:	53                   	push   %ebx
  10069a:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  10069c:	76 05                	jbe    1006a3 <console_putc+0x10>
  10069e:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  1006a3:	80 fa 0a             	cmp    $0xa,%dl
  1006a6:	75 2c                	jne    1006d4 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1006a8:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  1006ae:	be 50 00 00 00       	mov    $0x50,%esi
  1006b3:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  1006b5:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1006b8:	99                   	cltd   
  1006b9:	f7 fe                	idiv   %esi
  1006bb:	89 de                	mov    %ebx,%esi
  1006bd:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  1006bf:	eb 07                	jmp    1006c8 <console_putc+0x35>
			*cursor++ = ' ' | color;
  1006c1:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1006c4:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  1006c5:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1006c8:	83 f8 50             	cmp    $0x50,%eax
  1006cb:	75 f4                	jne    1006c1 <console_putc+0x2e>
  1006cd:	29 d0                	sub    %edx,%eax
  1006cf:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  1006d2:	eb 0b                	jmp    1006df <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  1006d4:	0f b6 d2             	movzbl %dl,%edx
  1006d7:	09 ca                	or     %ecx,%edx
  1006d9:	66 89 13             	mov    %dx,(%ebx)
  1006dc:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  1006df:	5b                   	pop    %ebx
  1006e0:	5e                   	pop    %esi
  1006e1:	c3                   	ret    

001006e2 <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  1006e2:	56                   	push   %esi
  1006e3:	53                   	push   %ebx
  1006e4:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  1006e8:	8d 58 ff             	lea    -0x1(%eax),%ebx
  1006eb:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  1006ef:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  1006f4:	75 04                	jne    1006fa <fill_numbuf+0x18>
  1006f6:	85 d2                	test   %edx,%edx
  1006f8:	74 10                	je     10070a <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  1006fa:	89 d0                	mov    %edx,%eax
  1006fc:	31 d2                	xor    %edx,%edx
  1006fe:	f7 f1                	div    %ecx
  100700:	4b                   	dec    %ebx
  100701:	8a 14 16             	mov    (%esi,%edx,1),%dl
  100704:	88 13                	mov    %dl,(%ebx)
			val /= base;
  100706:	89 c2                	mov    %eax,%edx
  100708:	eb ec                	jmp    1006f6 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  10070a:	89 d8                	mov    %ebx,%eax
  10070c:	5b                   	pop    %ebx
  10070d:	5e                   	pop    %esi
  10070e:	c3                   	ret    

0010070f <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  10070f:	55                   	push   %ebp
  100710:	57                   	push   %edi
  100711:	56                   	push   %esi
  100712:	53                   	push   %ebx
  100713:	83 ec 38             	sub    $0x38,%esp
  100716:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  10071a:	8b 7c 24 54          	mov    0x54(%esp),%edi
  10071e:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100722:	e9 60 03 00 00       	jmp    100a87 <console_vprintf+0x378>
		if (*format != '%') {
  100727:	80 fa 25             	cmp    $0x25,%dl
  10072a:	74 13                	je     10073f <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  10072c:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100730:	0f b6 d2             	movzbl %dl,%edx
  100733:	89 f0                	mov    %esi,%eax
  100735:	e8 59 ff ff ff       	call   100693 <console_putc>
  10073a:	e9 45 03 00 00       	jmp    100a84 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  10073f:	47                   	inc    %edi
  100740:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  100747:	00 
  100748:	eb 12                	jmp    10075c <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  10074a:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  10074b:	8a 11                	mov    (%ecx),%dl
  10074d:	84 d2                	test   %dl,%dl
  10074f:	74 1a                	je     10076b <console_vprintf+0x5c>
  100751:	89 e8                	mov    %ebp,%eax
  100753:	38 c2                	cmp    %al,%dl
  100755:	75 f3                	jne    10074a <console_vprintf+0x3b>
  100757:	e9 3f 03 00 00       	jmp    100a9b <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  10075c:	8a 17                	mov    (%edi),%dl
  10075e:	84 d2                	test   %dl,%dl
  100760:	74 0b                	je     10076d <console_vprintf+0x5e>
  100762:	b9 f0 0a 10 00       	mov    $0x100af0,%ecx
  100767:	89 d5                	mov    %edx,%ebp
  100769:	eb e0                	jmp    10074b <console_vprintf+0x3c>
  10076b:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  10076d:	8d 42 cf             	lea    -0x31(%edx),%eax
  100770:	3c 08                	cmp    $0x8,%al
  100772:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100779:	00 
  10077a:	76 13                	jbe    10078f <console_vprintf+0x80>
  10077c:	eb 1d                	jmp    10079b <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  10077e:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  100783:	0f be c0             	movsbl %al,%eax
  100786:	47                   	inc    %edi
  100787:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  10078b:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  10078f:	8a 07                	mov    (%edi),%al
  100791:	8d 50 d0             	lea    -0x30(%eax),%edx
  100794:	80 fa 09             	cmp    $0x9,%dl
  100797:	76 e5                	jbe    10077e <console_vprintf+0x6f>
  100799:	eb 18                	jmp    1007b3 <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  10079b:	80 fa 2a             	cmp    $0x2a,%dl
  10079e:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  1007a5:	ff 
  1007a6:	75 0b                	jne    1007b3 <console_vprintf+0xa4>
			width = va_arg(val, int);
  1007a8:	83 c3 04             	add    $0x4,%ebx
			++format;
  1007ab:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  1007ac:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1007af:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  1007b3:	83 cd ff             	or     $0xffffffff,%ebp
  1007b6:	80 3f 2e             	cmpb   $0x2e,(%edi)
  1007b9:	75 37                	jne    1007f2 <console_vprintf+0xe3>
			++format;
  1007bb:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  1007bc:	31 ed                	xor    %ebp,%ebp
  1007be:	8a 07                	mov    (%edi),%al
  1007c0:	8d 50 d0             	lea    -0x30(%eax),%edx
  1007c3:	80 fa 09             	cmp    $0x9,%dl
  1007c6:	76 0d                	jbe    1007d5 <console_vprintf+0xc6>
  1007c8:	eb 17                	jmp    1007e1 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  1007ca:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  1007cd:	0f be c0             	movsbl %al,%eax
  1007d0:	47                   	inc    %edi
  1007d1:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  1007d5:	8a 07                	mov    (%edi),%al
  1007d7:	8d 50 d0             	lea    -0x30(%eax),%edx
  1007da:	80 fa 09             	cmp    $0x9,%dl
  1007dd:	76 eb                	jbe    1007ca <console_vprintf+0xbb>
  1007df:	eb 11                	jmp    1007f2 <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  1007e1:	3c 2a                	cmp    $0x2a,%al
  1007e3:	75 0b                	jne    1007f0 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  1007e5:	83 c3 04             	add    $0x4,%ebx
				++format;
  1007e8:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  1007e9:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  1007ec:	85 ed                	test   %ebp,%ebp
  1007ee:	79 02                	jns    1007f2 <console_vprintf+0xe3>
  1007f0:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  1007f2:	8a 07                	mov    (%edi),%al
  1007f4:	3c 64                	cmp    $0x64,%al
  1007f6:	74 34                	je     10082c <console_vprintf+0x11d>
  1007f8:	7f 1d                	jg     100817 <console_vprintf+0x108>
  1007fa:	3c 58                	cmp    $0x58,%al
  1007fc:	0f 84 a2 00 00 00    	je     1008a4 <console_vprintf+0x195>
  100802:	3c 63                	cmp    $0x63,%al
  100804:	0f 84 bf 00 00 00    	je     1008c9 <console_vprintf+0x1ba>
  10080a:	3c 43                	cmp    $0x43,%al
  10080c:	0f 85 d0 00 00 00    	jne    1008e2 <console_vprintf+0x1d3>
  100812:	e9 a3 00 00 00       	jmp    1008ba <console_vprintf+0x1ab>
  100817:	3c 75                	cmp    $0x75,%al
  100819:	74 4d                	je     100868 <console_vprintf+0x159>
  10081b:	3c 78                	cmp    $0x78,%al
  10081d:	74 5c                	je     10087b <console_vprintf+0x16c>
  10081f:	3c 73                	cmp    $0x73,%al
  100821:	0f 85 bb 00 00 00    	jne    1008e2 <console_vprintf+0x1d3>
  100827:	e9 86 00 00 00       	jmp    1008b2 <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  10082c:	83 c3 04             	add    $0x4,%ebx
  10082f:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  100832:	89 d1                	mov    %edx,%ecx
  100834:	c1 f9 1f             	sar    $0x1f,%ecx
  100837:	89 0c 24             	mov    %ecx,(%esp)
  10083a:	31 ca                	xor    %ecx,%edx
  10083c:	55                   	push   %ebp
  10083d:	29 ca                	sub    %ecx,%edx
  10083f:	68 f8 0a 10 00       	push   $0x100af8
  100844:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100849:	8d 44 24 40          	lea    0x40(%esp),%eax
  10084d:	e8 90 fe ff ff       	call   1006e2 <fill_numbuf>
  100852:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  100856:	58                   	pop    %eax
  100857:	5a                   	pop    %edx
  100858:	ba 01 00 00 00       	mov    $0x1,%edx
  10085d:	8b 04 24             	mov    (%esp),%eax
  100860:	83 e0 01             	and    $0x1,%eax
  100863:	e9 a5 00 00 00       	jmp    10090d <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  100868:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  10086b:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100870:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100873:	55                   	push   %ebp
  100874:	68 f8 0a 10 00       	push   $0x100af8
  100879:	eb 11                	jmp    10088c <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  10087b:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  10087e:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100881:	55                   	push   %ebp
  100882:	68 0c 0b 10 00       	push   $0x100b0c
  100887:	b9 10 00 00 00       	mov    $0x10,%ecx
  10088c:	8d 44 24 40          	lea    0x40(%esp),%eax
  100890:	e8 4d fe ff ff       	call   1006e2 <fill_numbuf>
  100895:	ba 01 00 00 00       	mov    $0x1,%edx
  10089a:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10089e:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  1008a0:	59                   	pop    %ecx
  1008a1:	59                   	pop    %ecx
  1008a2:	eb 69                	jmp    10090d <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  1008a4:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  1008a7:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008aa:	55                   	push   %ebp
  1008ab:	68 f8 0a 10 00       	push   $0x100af8
  1008b0:	eb d5                	jmp    100887 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  1008b2:	83 c3 04             	add    $0x4,%ebx
  1008b5:	8b 43 fc             	mov    -0x4(%ebx),%eax
  1008b8:	eb 40                	jmp    1008fa <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  1008ba:	83 c3 04             	add    $0x4,%ebx
  1008bd:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008c0:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  1008c4:	e9 bd 01 00 00       	jmp    100a86 <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  1008c9:	83 c3 04             	add    $0x4,%ebx
  1008cc:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  1008cf:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  1008d3:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  1008d8:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  1008dc:	88 44 24 24          	mov    %al,0x24(%esp)
  1008e0:	eb 27                	jmp    100909 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  1008e2:	84 c0                	test   %al,%al
  1008e4:	75 02                	jne    1008e8 <console_vprintf+0x1d9>
  1008e6:	b0 25                	mov    $0x25,%al
  1008e8:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  1008ec:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  1008f1:	80 3f 00             	cmpb   $0x0,(%edi)
  1008f4:	74 0a                	je     100900 <console_vprintf+0x1f1>
  1008f6:	8d 44 24 24          	lea    0x24(%esp),%eax
  1008fa:	89 44 24 04          	mov    %eax,0x4(%esp)
  1008fe:	eb 09                	jmp    100909 <console_vprintf+0x1fa>
				format--;
  100900:	8d 54 24 24          	lea    0x24(%esp),%edx
  100904:	4f                   	dec    %edi
  100905:	89 54 24 04          	mov    %edx,0x4(%esp)
  100909:	31 d2                	xor    %edx,%edx
  10090b:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  10090d:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  10090f:	83 fd ff             	cmp    $0xffffffff,%ebp
  100912:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100919:	74 1f                	je     10093a <console_vprintf+0x22b>
  10091b:	89 04 24             	mov    %eax,(%esp)
  10091e:	eb 01                	jmp    100921 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  100920:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100921:	39 e9                	cmp    %ebp,%ecx
  100923:	74 0a                	je     10092f <console_vprintf+0x220>
  100925:	8b 44 24 04          	mov    0x4(%esp),%eax
  100929:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  10092d:	75 f1                	jne    100920 <console_vprintf+0x211>
  10092f:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100932:	89 0c 24             	mov    %ecx,(%esp)
  100935:	eb 1f                	jmp    100956 <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  100937:	42                   	inc    %edx
  100938:	eb 09                	jmp    100943 <console_vprintf+0x234>
  10093a:	89 d1                	mov    %edx,%ecx
  10093c:	8b 14 24             	mov    (%esp),%edx
  10093f:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100943:	8b 44 24 04          	mov    0x4(%esp),%eax
  100947:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  10094b:	75 ea                	jne    100937 <console_vprintf+0x228>
  10094d:	8b 44 24 08          	mov    0x8(%esp),%eax
  100951:	89 14 24             	mov    %edx,(%esp)
  100954:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  100956:	85 c0                	test   %eax,%eax
  100958:	74 0c                	je     100966 <console_vprintf+0x257>
  10095a:	84 d2                	test   %dl,%dl
  10095c:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  100963:	00 
  100964:	75 24                	jne    10098a <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  100966:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  10096b:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  100972:	00 
  100973:	75 15                	jne    10098a <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100975:	8b 44 24 14          	mov    0x14(%esp),%eax
  100979:	83 e0 08             	and    $0x8,%eax
  10097c:	83 f8 01             	cmp    $0x1,%eax
  10097f:	19 c9                	sbb    %ecx,%ecx
  100981:	f7 d1                	not    %ecx
  100983:	83 e1 20             	and    $0x20,%ecx
  100986:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  10098a:	3b 2c 24             	cmp    (%esp),%ebp
  10098d:	7e 0d                	jle    10099c <console_vprintf+0x28d>
  10098f:	84 d2                	test   %dl,%dl
  100991:	74 40                	je     1009d3 <console_vprintf+0x2c4>
			zeros = precision - len;
  100993:	2b 2c 24             	sub    (%esp),%ebp
  100996:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  10099a:	eb 3f                	jmp    1009db <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  10099c:	84 d2                	test   %dl,%dl
  10099e:	74 33                	je     1009d3 <console_vprintf+0x2c4>
  1009a0:	8b 44 24 14          	mov    0x14(%esp),%eax
  1009a4:	83 e0 06             	and    $0x6,%eax
  1009a7:	83 f8 02             	cmp    $0x2,%eax
  1009aa:	75 27                	jne    1009d3 <console_vprintf+0x2c4>
  1009ac:	45                   	inc    %ebp
  1009ad:	75 24                	jne    1009d3 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  1009af:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009b1:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  1009b4:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1009b9:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009bc:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  1009bf:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  1009c3:	7d 0e                	jge    1009d3 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  1009c5:	8b 54 24 0c          	mov    0xc(%esp),%edx
  1009c9:	29 ca                	sub    %ecx,%edx
  1009cb:	29 c2                	sub    %eax,%edx
  1009cd:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009d1:	eb 08                	jmp    1009db <console_vprintf+0x2cc>
  1009d3:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  1009da:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  1009db:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  1009df:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009e1:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  1009e5:	2b 2c 24             	sub    (%esp),%ebp
  1009e8:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1009ed:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009f0:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  1009f3:	29 c5                	sub    %eax,%ebp
  1009f5:	89 f0                	mov    %esi,%eax
  1009f7:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009fb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  1009ff:	eb 0f                	jmp    100a10 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100a01:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a05:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a0a:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a0b:	e8 83 fc ff ff       	call   100693 <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a10:	85 ed                	test   %ebp,%ebp
  100a12:	7e 07                	jle    100a1b <console_vprintf+0x30c>
  100a14:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100a19:	74 e6                	je     100a01 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100a1b:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a20:	89 c6                	mov    %eax,%esi
  100a22:	74 23                	je     100a47 <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100a24:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100a29:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a2d:	e8 61 fc ff ff       	call   100693 <console_putc>
  100a32:	89 c6                	mov    %eax,%esi
  100a34:	eb 11                	jmp    100a47 <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100a36:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a3a:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100a3f:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100a40:	e8 4e fc ff ff       	call   100693 <console_putc>
  100a45:	eb 06                	jmp    100a4d <console_vprintf+0x33e>
  100a47:	89 f0                	mov    %esi,%eax
  100a49:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100a4d:	85 f6                	test   %esi,%esi
  100a4f:	7f e5                	jg     100a36 <console_vprintf+0x327>
  100a51:	8b 34 24             	mov    (%esp),%esi
  100a54:	eb 15                	jmp    100a6b <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100a56:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100a5a:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100a5b:	0f b6 11             	movzbl (%ecx),%edx
  100a5e:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a62:	e8 2c fc ff ff       	call   100693 <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100a67:	ff 44 24 04          	incl   0x4(%esp)
  100a6b:	85 f6                	test   %esi,%esi
  100a6d:	7f e7                	jg     100a56 <console_vprintf+0x347>
  100a6f:	eb 0f                	jmp    100a80 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100a71:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a75:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a7a:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a7b:	e8 13 fc ff ff       	call   100693 <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a80:	85 ed                	test   %ebp,%ebp
  100a82:	7f ed                	jg     100a71 <console_vprintf+0x362>
  100a84:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100a86:	47                   	inc    %edi
  100a87:	8a 17                	mov    (%edi),%dl
  100a89:	84 d2                	test   %dl,%dl
  100a8b:	0f 85 96 fc ff ff    	jne    100727 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100a91:	83 c4 38             	add    $0x38,%esp
  100a94:	89 f0                	mov    %esi,%eax
  100a96:	5b                   	pop    %ebx
  100a97:	5e                   	pop    %esi
  100a98:	5f                   	pop    %edi
  100a99:	5d                   	pop    %ebp
  100a9a:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100a9b:	81 e9 f0 0a 10 00    	sub    $0x100af0,%ecx
  100aa1:	b8 01 00 00 00       	mov    $0x1,%eax
  100aa6:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100aa8:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100aa9:	09 44 24 14          	or     %eax,0x14(%esp)
  100aad:	e9 aa fc ff ff       	jmp    10075c <console_vprintf+0x4d>

00100ab2 <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100ab2:	8d 44 24 10          	lea    0x10(%esp),%eax
  100ab6:	50                   	push   %eax
  100ab7:	ff 74 24 10          	pushl  0x10(%esp)
  100abb:	ff 74 24 10          	pushl  0x10(%esp)
  100abf:	ff 74 24 10          	pushl  0x10(%esp)
  100ac3:	e8 47 fc ff ff       	call   10070f <console_vprintf>
  100ac8:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100acb:	c3                   	ret    
