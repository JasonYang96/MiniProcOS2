
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
  100014:	e8 18 02 00 00       	call   100231 <start>
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
  10006d:	e8 4e 01 00 00       	call   1001c0 <interrupt>

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
  10009c:	53                   	push   %ebx
  10009d:	83 ec 08             	sub    $0x8,%esp
	pid_t pid = current->p_pid;
  1000a0:	a1 e0 7b 10 00       	mov    0x107be0,%eax
  1000a5:	8b 10                	mov    (%eax),%edx
	int k = 0;
	unsigned int priority = 0xffffffff;

	if (scheduling_algorithm == 0)
  1000a7:	a1 e4 7b 10 00       	mov    0x107be4,%eax
  1000ac:	85 c0                	test   %eax,%eax
  1000ae:	75 24                	jne    1000d4 <schedule+0x38>
	{
		while (1) {
			pid = (pid + 1) % NPROCS;
  1000b0:	b9 05 00 00 00       	mov    $0x5,%ecx
  1000b5:	8d 42 01             	lea    0x1(%edx),%eax
  1000b8:	99                   	cltd   
  1000b9:	f7 f9                	idiv   %ecx

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000bb:	6b c2 54             	imul   $0x54,%edx,%eax
  1000be:	83 b8 1c 72 10 00 01 	cmpl   $0x1,0x10721c(%eax)
  1000c5:	75 ee                	jne    1000b5 <schedule+0x19>
				run(&proc_array[pid]);
  1000c7:	83 ec 0c             	sub    $0xc,%esp
  1000ca:	05 d4 71 10 00       	add    $0x1071d4,%eax
  1000cf:	e9 b8 00 00 00       	jmp    10018c <schedule+0xf0>
		}
	}

	if (scheduling_algorithm == 1)
  1000d4:	83 f8 01             	cmp    $0x1,%eax
  1000d7:	75 37                	jne    100110 <schedule+0x74>
  1000d9:	ba 01 00 00 00       	mov    $0x1,%edx
	{
		while (1) {
			//run highest priority first based on pid
			for (pid = 1; pid < NPROCS; pid++)
			{
				if (proc_array[pid].p_state == P_RUNNABLE)
  1000de:	6b c8 54             	imul   $0x54,%eax,%ecx
  1000e1:	83 b9 1c 72 10 00 01 	cmpl   $0x1,0x10721c(%ecx)
  1000e8:	75 12                	jne    1000fc <schedule+0x60>
					run(&proc_array[pid]);
  1000ea:	6b d2 54             	imul   $0x54,%edx,%edx
  1000ed:	83 ec 0c             	sub    $0xc,%esp
  1000f0:	81 c2 d4 71 10 00    	add    $0x1071d4,%edx
  1000f6:	52                   	push   %edx
  1000f7:	e8 4d 04 00 00       	call   100549 <run>

	if (scheduling_algorithm == 1)
	{
		while (1) {
			//run highest priority first based on pid
			for (pid = 1; pid < NPROCS; pid++)
  1000fc:	40                   	inc    %eax
  1000fd:	83 f8 04             	cmp    $0x4,%eax
			if (proc_array[pid].p_state == P_RUNNABLE)
				run(&proc_array[pid]);
		}
	}

	if (scheduling_algorithm == 1)
  100100:	89 c2                	mov    %eax,%edx
	{
		while (1) {
			//run highest priority first based on pid
			for (pid = 1; pid < NPROCS; pid++)
  100102:	7e da                	jle    1000de <schedule+0x42>
  100104:	ba 01 00 00 00       	mov    $0x1,%edx
  100109:	b8 01 00 00 00       	mov    $0x1,%eax
  10010e:	eb ce                	jmp    1000de <schedule+0x42>
					run(&proc_array[pid]);
			}
		}
	}

	if (scheduling_algorithm == 2)
  100110:	83 f8 02             	cmp    $0x2,%eax
  100113:	0f 85 86 00 00 00    	jne    10019f <schedule+0x103>
  100119:	83 c9 ff             	or     $0xffffffff,%ecx
				{
					priority = proc_array[k].p_priority;
				}
			}
			// search for proc with that priority
			for (pid = (pid + 1) % NPROCS; pid < NPROCS; pid = (pid + 1) % NPROCS)
  10011c:	bb 05 00 00 00       	mov    $0x5,%ebx
	{
		while (1) {
			//run highest priority first based on p_priority
			for (k = 1; k < NPROCS; k++)
			{
				if (proc_array[k].p_state == P_RUNNABLE &&
  100121:	83 3d 70 72 10 00 01 	cmpl   $0x1,0x107270
  100128:	75 0b                	jne    100135 <schedule+0x99>
  10012a:	a1 78 72 10 00       	mov    0x107278,%eax
  10012f:	39 c1                	cmp    %eax,%ecx
  100131:	76 02                	jbe    100135 <schedule+0x99>
  100133:	89 c1                	mov    %eax,%ecx
  100135:	83 3d c4 72 10 00 01 	cmpl   $0x1,0x1072c4
  10013c:	75 0b                	jne    100149 <schedule+0xad>
  10013e:	a1 cc 72 10 00       	mov    0x1072cc,%eax
  100143:	39 c1                	cmp    %eax,%ecx
  100145:	76 02                	jbe    100149 <schedule+0xad>
  100147:	89 c1                	mov    %eax,%ecx
  100149:	83 3d 18 73 10 00 01 	cmpl   $0x1,0x107318
  100150:	75 0b                	jne    10015d <schedule+0xc1>
  100152:	a1 20 73 10 00       	mov    0x107320,%eax
  100157:	39 c1                	cmp    %eax,%ecx
  100159:	76 02                	jbe    10015d <schedule+0xc1>
  10015b:	89 c1                	mov    %eax,%ecx
  10015d:	83 3d 6c 73 10 00 01 	cmpl   $0x1,0x10736c
  100164:	75 2c                	jne    100192 <schedule+0xf6>
  100166:	a1 74 73 10 00       	mov    0x107374,%eax
  10016b:	39 c1                	cmp    %eax,%ecx
  10016d:	76 23                	jbe    100192 <schedule+0xf6>
  10016f:	89 c1                	mov    %eax,%ecx
  100171:	eb 1f                	jmp    100192 <schedule+0xf6>
				}
			}
			// search for proc with that priority
			for (pid = (pid + 1) % NPROCS; pid < NPROCS; pid = (pid + 1) % NPROCS)
			{
				if (proc_array[pid].p_state == P_RUNNABLE &&
  100173:	6b c2 54             	imul   $0x54,%edx,%eax
  100176:	83 b8 1c 72 10 00 01 	cmpl   $0x1,0x10721c(%eax)
  10017d:	75 13                	jne    100192 <schedule+0xf6>
  10017f:	05 d4 71 10 00       	add    $0x1071d4,%eax
  100184:	39 48 50             	cmp    %ecx,0x50(%eax)
  100187:	77 09                	ja     100192 <schedule+0xf6>
					proc_array[pid].p_priority <= priority)
				{
					run(&proc_array[pid]);
  100189:	83 ec 0c             	sub    $0xc,%esp
  10018c:	50                   	push   %eax
  10018d:	e9 65 ff ff ff       	jmp    1000f7 <schedule+0x5b>
				{
					priority = proc_array[k].p_priority;
				}
			}
			// search for proc with that priority
			for (pid = (pid + 1) % NPROCS; pid < NPROCS; pid = (pid + 1) % NPROCS)
  100192:	8d 42 01             	lea    0x1(%edx),%eax
  100195:	99                   	cltd   
  100196:	f7 fb                	idiv   %ebx
  100198:	83 fa 04             	cmp    $0x4,%edx
  10019b:	7f 84                	jg     100121 <schedule+0x85>
  10019d:	eb d4                	jmp    100173 <schedule+0xd7>
		}
	}


	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  10019f:	8b 15 00 80 19 00    	mov    0x198000,%edx
  1001a5:	50                   	push   %eax
  1001a6:	68 08 0b 10 00       	push   $0x100b08
  1001ab:	68 00 01 00 00       	push   $0x100
  1001b0:	52                   	push   %edx
  1001b1:	e8 38 09 00 00       	call   100aee <console_printf>
  1001b6:	83 c4 10             	add    $0x10,%esp
  1001b9:	a3 00 80 19 00       	mov    %eax,0x198000
  1001be:	eb fe                	jmp    1001be <schedule+0x122>

001001c0 <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  1001c0:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  1001c1:	a1 e0 7b 10 00       	mov    0x107be0,%eax
  1001c6:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  1001cb:	56                   	push   %esi
  1001cc:	53                   	push   %ebx
  1001cd:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  1001d1:	8d 78 04             	lea    0x4(%eax),%edi
  1001d4:	89 de                	mov    %ebx,%esi
  1001d6:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  1001d8:	8b 53 28             	mov    0x28(%ebx),%edx
  1001db:	83 fa 31             	cmp    $0x31,%edx
  1001de:	74 1f                	je     1001ff <interrupt+0x3f>
  1001e0:	77 0c                	ja     1001ee <interrupt+0x2e>
  1001e2:	83 fa 20             	cmp    $0x20,%edx
  1001e5:	74 43                	je     10022a <interrupt+0x6a>
  1001e7:	83 fa 30             	cmp    $0x30,%edx
  1001ea:	74 0e                	je     1001fa <interrupt+0x3a>
  1001ec:	eb 41                	jmp    10022f <interrupt+0x6f>
  1001ee:	83 fa 32             	cmp    $0x32,%edx
  1001f1:	74 23                	je     100216 <interrupt+0x56>
  1001f3:	83 fa 33             	cmp    $0x33,%edx
  1001f6:	74 29                	je     100221 <interrupt+0x61>
  1001f8:	eb 35                	jmp    10022f <interrupt+0x6f>

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  1001fa:	e8 9d fe ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  1001ff:	a1 e0 7b 10 00       	mov    0x107be0,%eax
		current->p_exit_status = reg->reg_eax;
  100204:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100207:	c7 40 48 03 00 00 00 	movl   $0x3,0x48(%eax)
		current->p_exit_status = reg->reg_eax;
  10020e:	89 50 4c             	mov    %edx,0x4c(%eax)
		schedule();
  100211:	e8 86 fe ff ff       	call   10009c <schedule>

	case INT_SYS_PRIORITY:
		// The 'sys_priority' system call initializes the p_priority var
		// of a process.
		current->p_priority = reg->reg_eax;
  100216:	a1 e0 7b 10 00       	mov    0x107be0,%eax
  10021b:	8b 53 1c             	mov    0x1c(%ebx),%edx
  10021e:	89 50 50             	mov    %edx,0x50(%eax)
		run(current);

	case INT_SYS_USER2:
		/* Your code here (if you want). */
		run(current);
  100221:	83 ec 0c             	sub    $0xc,%esp
  100224:	50                   	push   %eax
  100225:	e8 1f 03 00 00       	call   100549 <run>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  10022a:	e8 6d fe ff ff       	call   10009c <schedule>
  10022f:	eb fe                	jmp    10022f <interrupt+0x6f>

00100231 <start>:
 *
 *****************************************************************************/

void
start(void)
{
  100231:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100232:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  100237:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100238:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  10023a:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  10023b:	bb 28 72 10 00       	mov    $0x107228,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  100240:	e8 e3 00 00 00       	call   100328 <segments_init>
	interrupt_controller_init(0);
  100245:	83 ec 0c             	sub    $0xc,%esp
  100248:	6a 00                	push   $0x0
  10024a:	e8 d4 01 00 00       	call   100423 <interrupt_controller_init>
	console_clear();
  10024f:	e8 58 02 00 00       	call   1004ac <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  100254:	83 c4 0c             	add    $0xc,%esp
  100257:	68 a4 01 00 00       	push   $0x1a4
  10025c:	6a 00                	push   $0x0
  10025e:	68 d4 71 10 00       	push   $0x1071d4
  100263:	e8 24 04 00 00       	call   10068c <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100268:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10026b:	c7 05 d4 71 10 00 00 	movl   $0x0,0x1071d4
  100272:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100275:	c7 05 1c 72 10 00 00 	movl   $0x0,0x10721c
  10027c:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10027f:	c7 05 28 72 10 00 01 	movl   $0x1,0x107228
  100286:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100289:	c7 05 70 72 10 00 00 	movl   $0x0,0x107270
  100290:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100293:	c7 05 7c 72 10 00 02 	movl   $0x2,0x10727c
  10029a:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10029d:	c7 05 c4 72 10 00 00 	movl   $0x0,0x1072c4
  1002a4:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002a7:	c7 05 d0 72 10 00 03 	movl   $0x3,0x1072d0
  1002ae:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002b1:	c7 05 18 73 10 00 00 	movl   $0x0,0x107318
  1002b8:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002bb:	c7 05 24 73 10 00 04 	movl   $0x4,0x107324
  1002c2:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002c5:	c7 05 6c 73 10 00 00 	movl   $0x0,0x10736c
  1002cc:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  1002cf:	83 ec 0c             	sub    $0xc,%esp
  1002d2:	53                   	push   %ebx
  1002d3:	e8 88 02 00 00       	call   100560 <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1002d8:	58                   	pop    %eax
  1002d9:	5a                   	pop    %edx
  1002da:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  1002dd:	89 7b 40             	mov    %edi,0x40(%ebx)
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;

		proc->p_priority = 0;
  1002e0:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1002e6:	50                   	push   %eax
  1002e7:	56                   	push   %esi

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;

		proc->p_priority = 0;
  1002e8:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1002e9:	e8 ae 02 00 00       	call   10059c <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  1002ee:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  1002f1:	c7 43 48 01 00 00 00 	movl   $0x1,0x48(%ebx)

		proc->p_priority = 0;
  1002f8:	c7 43 50 00 00 00 00 	movl   $0x0,0x50(%ebx)
  1002ff:	83 c3 54             	add    $0x54,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100302:	83 fe 04             	cmp    $0x4,%esi
  100305:	75 c8                	jne    1002cf <start+0x9e>

	// Initialize the scheduling algorithm.
	scheduling_algorithm = 2;

	// Switch to the first process.
	run(&proc_array[1]);
  100307:	83 ec 0c             	sub    $0xc,%esp
  10030a:	68 28 72 10 00       	push   $0x107228
		proc->p_priority = 0;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  10030f:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  100316:	80 0b 00 

	// Initialize the scheduling algorithm.
	scheduling_algorithm = 2;
  100319:	c7 05 e4 7b 10 00 02 	movl   $0x2,0x107be4
  100320:	00 00 00 

	// Switch to the first process.
	run(&proc_array[1]);
  100323:	e8 21 02 00 00       	call   100549 <run>

00100328 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100328:	b8 78 73 10 00       	mov    $0x107378,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10032d:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100332:	89 c2                	mov    %eax,%edx
  100334:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  100337:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100338:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  10033d:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100340:	66 a3 3a 10 10 00    	mov    %ax,0x10103a
  100346:	c1 e8 18             	shr    $0x18,%eax
  100349:	88 15 3c 10 10 00    	mov    %dl,0x10103c
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10034f:	ba e0 73 10 00       	mov    $0x1073e0,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100354:	a2 3f 10 10 00       	mov    %al,0x10103f
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100359:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10035b:	66 c7 05 38 10 10 00 	movw   $0x68,0x101038
  100362:	68 00 
  100364:	c6 05 3e 10 10 00 40 	movb   $0x40,0x10103e
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  10036b:	c6 05 3d 10 10 00 89 	movb   $0x89,0x10103d

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  100372:	c7 05 7c 73 10 00 00 	movl   $0x180000,0x10737c
  100379:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  10037c:	66 c7 05 80 73 10 00 	movw   $0x10,0x107380
  100383:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100385:	66 89 0c c5 e0 73 10 	mov    %cx,0x1073e0(,%eax,8)
  10038c:	00 
  10038d:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100394:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100399:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  10039e:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  1003a3:	40                   	inc    %eax
  1003a4:	3d 00 01 00 00       	cmp    $0x100,%eax
  1003a9:	75 da                	jne    100385 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  1003ab:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003b0:	ba e0 73 10 00       	mov    $0x1073e0,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  1003b5:	66 a3 e0 74 10 00    	mov    %ax,0x1074e0
  1003bb:	c1 e8 10             	shr    $0x10,%eax
  1003be:	66 a3 e6 74 10 00    	mov    %ax,0x1074e6
  1003c4:	b8 30 00 00 00       	mov    $0x30,%eax
  1003c9:	66 c7 05 e2 74 10 00 	movw   $0x8,0x1074e2
  1003d0:	08 00 
  1003d2:	c6 05 e4 74 10 00 00 	movb   $0x0,0x1074e4
  1003d9:	c6 05 e5 74 10 00 8e 	movb   $0x8e,0x1074e5

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003e0:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  1003e7:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1003ee:	66 89 0c c5 e0 73 10 	mov    %cx,0x1073e0(,%eax,8)
  1003f5:	00 
  1003f6:	c1 e9 10             	shr    $0x10,%ecx
  1003f9:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1003fe:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  100403:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  100408:	40                   	inc    %eax
  100409:	83 f8 3a             	cmp    $0x3a,%eax
  10040c:	75 d2                	jne    1003e0 <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  10040e:	b0 28                	mov    $0x28,%al
  100410:	0f 01 15 00 10 10 00 	lgdtl  0x101000
  100417:	0f 00 d8             	ltr    %ax
  10041a:	0f 01 1d 08 10 10 00 	lidtl  0x101008
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  100421:	5b                   	pop    %ebx
  100422:	c3                   	ret    

00100423 <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  100423:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  100424:	b0 ff                	mov    $0xff,%al
  100426:	57                   	push   %edi
  100427:	56                   	push   %esi
  100428:	53                   	push   %ebx
  100429:	bb 21 00 00 00       	mov    $0x21,%ebx
  10042e:	89 da                	mov    %ebx,%edx
  100430:	ee                   	out    %al,(%dx)
  100431:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  100436:	89 ca                	mov    %ecx,%edx
  100438:	ee                   	out    %al,(%dx)
  100439:	be 11 00 00 00       	mov    $0x11,%esi
  10043e:	bf 20 00 00 00       	mov    $0x20,%edi
  100443:	89 f0                	mov    %esi,%eax
  100445:	89 fa                	mov    %edi,%edx
  100447:	ee                   	out    %al,(%dx)
  100448:	b0 20                	mov    $0x20,%al
  10044a:	89 da                	mov    %ebx,%edx
  10044c:	ee                   	out    %al,(%dx)
  10044d:	b0 04                	mov    $0x4,%al
  10044f:	ee                   	out    %al,(%dx)
  100450:	b0 03                	mov    $0x3,%al
  100452:	ee                   	out    %al,(%dx)
  100453:	bd a0 00 00 00       	mov    $0xa0,%ebp
  100458:	89 f0                	mov    %esi,%eax
  10045a:	89 ea                	mov    %ebp,%edx
  10045c:	ee                   	out    %al,(%dx)
  10045d:	b0 28                	mov    $0x28,%al
  10045f:	89 ca                	mov    %ecx,%edx
  100461:	ee                   	out    %al,(%dx)
  100462:	b0 02                	mov    $0x2,%al
  100464:	ee                   	out    %al,(%dx)
  100465:	b0 01                	mov    $0x1,%al
  100467:	ee                   	out    %al,(%dx)
  100468:	b0 68                	mov    $0x68,%al
  10046a:	89 fa                	mov    %edi,%edx
  10046c:	ee                   	out    %al,(%dx)
  10046d:	be 0a 00 00 00       	mov    $0xa,%esi
  100472:	89 f0                	mov    %esi,%eax
  100474:	ee                   	out    %al,(%dx)
  100475:	b0 68                	mov    $0x68,%al
  100477:	89 ea                	mov    %ebp,%edx
  100479:	ee                   	out    %al,(%dx)
  10047a:	89 f0                	mov    %esi,%eax
  10047c:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  10047d:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  100482:	89 da                	mov    %ebx,%edx
  100484:	19 c0                	sbb    %eax,%eax
  100486:	f7 d0                	not    %eax
  100488:	05 ff 00 00 00       	add    $0xff,%eax
  10048d:	ee                   	out    %al,(%dx)
  10048e:	b0 ff                	mov    $0xff,%al
  100490:	89 ca                	mov    %ecx,%edx
  100492:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  100493:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  100498:	74 0d                	je     1004a7 <interrupt_controller_init+0x84>
  10049a:	b2 43                	mov    $0x43,%dl
  10049c:	b0 34                	mov    $0x34,%al
  10049e:	ee                   	out    %al,(%dx)
  10049f:	b0 a9                	mov    $0xa9,%al
  1004a1:	b2 40                	mov    $0x40,%dl
  1004a3:	ee                   	out    %al,(%dx)
  1004a4:	b0 04                	mov    $0x4,%al
  1004a6:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  1004a7:	5b                   	pop    %ebx
  1004a8:	5e                   	pop    %esi
  1004a9:	5f                   	pop    %edi
  1004aa:	5d                   	pop    %ebp
  1004ab:	c3                   	ret    

001004ac <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  1004ac:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1004ad:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  1004af:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1004b0:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  1004b7:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  1004ba:	8b 15 00 80 19 00    	mov    0x198000,%edx
  1004c0:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  1004c6:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  1004c9:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  1004ce:	75 ea                	jne    1004ba <console_clear+0xe>
  1004d0:	be d4 03 00 00       	mov    $0x3d4,%esi
  1004d5:	b0 0e                	mov    $0xe,%al
  1004d7:	89 f2                	mov    %esi,%edx
  1004d9:	ee                   	out    %al,(%dx)
  1004da:	31 c9                	xor    %ecx,%ecx
  1004dc:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  1004e1:	88 c8                	mov    %cl,%al
  1004e3:	89 da                	mov    %ebx,%edx
  1004e5:	ee                   	out    %al,(%dx)
  1004e6:	b0 0f                	mov    $0xf,%al
  1004e8:	89 f2                	mov    %esi,%edx
  1004ea:	ee                   	out    %al,(%dx)
  1004eb:	88 c8                	mov    %cl,%al
  1004ed:	89 da                	mov    %ebx,%edx
  1004ef:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  1004f0:	5b                   	pop    %ebx
  1004f1:	5e                   	pop    %esi
  1004f2:	c3                   	ret    

001004f3 <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  1004f3:	ba 64 00 00 00       	mov    $0x64,%edx
  1004f8:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  1004f9:	a8 01                	test   $0x1,%al
  1004fb:	74 45                	je     100542 <console_read_digit+0x4f>
  1004fd:	b2 60                	mov    $0x60,%dl
  1004ff:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  100500:	8d 50 fe             	lea    -0x2(%eax),%edx
  100503:	80 fa 08             	cmp    $0x8,%dl
  100506:	77 05                	ja     10050d <console_read_digit+0x1a>
		return data - 0x02 + 1;
  100508:	0f b6 c0             	movzbl %al,%eax
  10050b:	48                   	dec    %eax
  10050c:	c3                   	ret    
	else if (data == 0x0B)
  10050d:	3c 0b                	cmp    $0xb,%al
  10050f:	74 35                	je     100546 <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  100511:	8d 50 b9             	lea    -0x47(%eax),%edx
  100514:	80 fa 02             	cmp    $0x2,%dl
  100517:	77 07                	ja     100520 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  100519:	0f b6 c0             	movzbl %al,%eax
  10051c:	83 e8 40             	sub    $0x40,%eax
  10051f:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  100520:	8d 50 b5             	lea    -0x4b(%eax),%edx
  100523:	80 fa 02             	cmp    $0x2,%dl
  100526:	77 07                	ja     10052f <console_read_digit+0x3c>
		return data - 0x4B + 4;
  100528:	0f b6 c0             	movzbl %al,%eax
  10052b:	83 e8 47             	sub    $0x47,%eax
  10052e:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  10052f:	8d 50 b1             	lea    -0x4f(%eax),%edx
  100532:	80 fa 02             	cmp    $0x2,%dl
  100535:	77 07                	ja     10053e <console_read_digit+0x4b>
		return data - 0x4F + 1;
  100537:	0f b6 c0             	movzbl %al,%eax
  10053a:	83 e8 4e             	sub    $0x4e,%eax
  10053d:	c3                   	ret    
	else if (data == 0x53)
  10053e:	3c 53                	cmp    $0x53,%al
  100540:	74 04                	je     100546 <console_read_digit+0x53>
  100542:	83 c8 ff             	or     $0xffffffff,%eax
  100545:	c3                   	ret    
  100546:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  100548:	c3                   	ret    

00100549 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  100549:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  10054d:	a3 e0 7b 10 00       	mov    %eax,0x107be0

	asm volatile("movl %0,%%esp\n\t"
  100552:	83 c0 04             	add    $0x4,%eax
  100555:	89 c4                	mov    %eax,%esp
  100557:	61                   	popa   
  100558:	07                   	pop    %es
  100559:	1f                   	pop    %ds
  10055a:	83 c4 08             	add    $0x8,%esp
  10055d:	cf                   	iret   
  10055e:	eb fe                	jmp    10055e <run+0x15>

00100560 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  100560:	53                   	push   %ebx
  100561:	83 ec 0c             	sub    $0xc,%esp
  100564:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  100568:	6a 44                	push   $0x44
  10056a:	6a 00                	push   $0x0
  10056c:	8d 43 04             	lea    0x4(%ebx),%eax
  10056f:	50                   	push   %eax
  100570:	e8 17 01 00 00       	call   10068c <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  100575:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  10057b:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  100581:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  100587:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  10058d:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  100594:	83 c4 18             	add    $0x18,%esp
  100597:	5b                   	pop    %ebx
  100598:	c3                   	ret    
  100599:	90                   	nop
  10059a:	90                   	nop
  10059b:	90                   	nop

0010059c <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  10059c:	55                   	push   %ebp
  10059d:	57                   	push   %edi
  10059e:	56                   	push   %esi
  10059f:	53                   	push   %ebx
  1005a0:	83 ec 1c             	sub    $0x1c,%esp
  1005a3:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  1005a7:	83 f8 03             	cmp    $0x3,%eax
  1005aa:	7f 04                	jg     1005b0 <program_loader+0x14>
  1005ac:	85 c0                	test   %eax,%eax
  1005ae:	79 02                	jns    1005b2 <program_loader+0x16>
  1005b0:	eb fe                	jmp    1005b0 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  1005b2:	8b 34 c5 40 10 10 00 	mov    0x101040(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  1005b9:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  1005bf:	74 02                	je     1005c3 <program_loader+0x27>
  1005c1:	eb fe                	jmp    1005c1 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1005c3:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  1005c6:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1005ca:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  1005cc:	c1 e5 05             	shl    $0x5,%ebp
  1005cf:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  1005d2:	eb 3f                	jmp    100613 <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  1005d4:	83 3b 01             	cmpl   $0x1,(%ebx)
  1005d7:	75 37                	jne    100610 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  1005d9:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1005dc:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  1005df:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1005e2:	01 c7                	add    %eax,%edi
	memsz += va;
  1005e4:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  1005e6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  1005eb:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  1005ef:	52                   	push   %edx
  1005f0:	89 fa                	mov    %edi,%edx
  1005f2:	29 c2                	sub    %eax,%edx
  1005f4:	52                   	push   %edx
  1005f5:	8b 53 04             	mov    0x4(%ebx),%edx
  1005f8:	01 f2                	add    %esi,%edx
  1005fa:	52                   	push   %edx
  1005fb:	50                   	push   %eax
  1005fc:	e8 27 00 00 00       	call   100628 <memcpy>
  100601:	83 c4 10             	add    $0x10,%esp
  100604:	eb 04                	jmp    10060a <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  100606:	c6 07 00             	movb   $0x0,(%edi)
  100609:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  10060a:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  10060e:	72 f6                	jb     100606 <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  100610:	83 c3 20             	add    $0x20,%ebx
  100613:	39 eb                	cmp    %ebp,%ebx
  100615:	72 bd                	jb     1005d4 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  100617:	8b 56 18             	mov    0x18(%esi),%edx
  10061a:	8b 44 24 34          	mov    0x34(%esp),%eax
  10061e:	89 10                	mov    %edx,(%eax)
}
  100620:	83 c4 1c             	add    $0x1c,%esp
  100623:	5b                   	pop    %ebx
  100624:	5e                   	pop    %esi
  100625:	5f                   	pop    %edi
  100626:	5d                   	pop    %ebp
  100627:	c3                   	ret    

00100628 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  100628:	56                   	push   %esi
  100629:	31 d2                	xor    %edx,%edx
  10062b:	53                   	push   %ebx
  10062c:	8b 44 24 0c          	mov    0xc(%esp),%eax
  100630:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  100634:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100638:	eb 08                	jmp    100642 <memcpy+0x1a>
		*d++ = *s++;
  10063a:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  10063d:	4e                   	dec    %esi
  10063e:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  100641:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100642:	85 f6                	test   %esi,%esi
  100644:	75 f4                	jne    10063a <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  100646:	5b                   	pop    %ebx
  100647:	5e                   	pop    %esi
  100648:	c3                   	ret    

00100649 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  100649:	57                   	push   %edi
  10064a:	56                   	push   %esi
  10064b:	53                   	push   %ebx
  10064c:	8b 44 24 10          	mov    0x10(%esp),%eax
  100650:	8b 7c 24 14          	mov    0x14(%esp),%edi
  100654:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  100658:	39 c7                	cmp    %eax,%edi
  10065a:	73 26                	jae    100682 <memmove+0x39>
  10065c:	8d 34 17             	lea    (%edi,%edx,1),%esi
  10065f:	39 c6                	cmp    %eax,%esi
  100661:	76 1f                	jbe    100682 <memmove+0x39>
		s += n, d += n;
  100663:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  100666:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  100668:	eb 07                	jmp    100671 <memmove+0x28>
			*--d = *--s;
  10066a:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  10066d:	4a                   	dec    %edx
  10066e:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  100671:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  100672:	85 d2                	test   %edx,%edx
  100674:	75 f4                	jne    10066a <memmove+0x21>
  100676:	eb 10                	jmp    100688 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  100678:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  10067b:	4a                   	dec    %edx
  10067c:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  10067f:	41                   	inc    %ecx
  100680:	eb 02                	jmp    100684 <memmove+0x3b>
  100682:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  100684:	85 d2                	test   %edx,%edx
  100686:	75 f0                	jne    100678 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  100688:	5b                   	pop    %ebx
  100689:	5e                   	pop    %esi
  10068a:	5f                   	pop    %edi
  10068b:	c3                   	ret    

0010068c <memset>:

void *
memset(void *v, int c, size_t n)
{
  10068c:	53                   	push   %ebx
  10068d:	8b 44 24 08          	mov    0x8(%esp),%eax
  100691:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  100695:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  100699:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  10069b:	eb 04                	jmp    1006a1 <memset+0x15>
		*p++ = c;
  10069d:	88 1a                	mov    %bl,(%edx)
  10069f:	49                   	dec    %ecx
  1006a0:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  1006a1:	85 c9                	test   %ecx,%ecx
  1006a3:	75 f8                	jne    10069d <memset+0x11>
		*p++ = c;
	return v;
}
  1006a5:	5b                   	pop    %ebx
  1006a6:	c3                   	ret    

001006a7 <strlen>:

size_t
strlen(const char *s)
{
  1006a7:	8b 54 24 04          	mov    0x4(%esp),%edx
  1006ab:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1006ad:	eb 01                	jmp    1006b0 <strlen+0x9>
		++n;
  1006af:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1006b0:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  1006b4:	75 f9                	jne    1006af <strlen+0x8>
		++n;
	return n;
}
  1006b6:	c3                   	ret    

001006b7 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  1006b7:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  1006bb:	31 c0                	xor    %eax,%eax
  1006bd:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1006c1:	eb 01                	jmp    1006c4 <strnlen+0xd>
		++n;
  1006c3:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1006c4:	39 d0                	cmp    %edx,%eax
  1006c6:	74 06                	je     1006ce <strnlen+0x17>
  1006c8:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  1006cc:	75 f5                	jne    1006c3 <strnlen+0xc>
		++n;
	return n;
}
  1006ce:	c3                   	ret    

001006cf <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1006cf:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  1006d0:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1006d5:	53                   	push   %ebx
  1006d6:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  1006d8:	76 05                	jbe    1006df <console_putc+0x10>
  1006da:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  1006df:	80 fa 0a             	cmp    $0xa,%dl
  1006e2:	75 2c                	jne    100710 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1006e4:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  1006ea:	be 50 00 00 00       	mov    $0x50,%esi
  1006ef:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  1006f1:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1006f4:	99                   	cltd   
  1006f5:	f7 fe                	idiv   %esi
  1006f7:	89 de                	mov    %ebx,%esi
  1006f9:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  1006fb:	eb 07                	jmp    100704 <console_putc+0x35>
			*cursor++ = ' ' | color;
  1006fd:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100700:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  100701:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100704:	83 f8 50             	cmp    $0x50,%eax
  100707:	75 f4                	jne    1006fd <console_putc+0x2e>
  100709:	29 d0                	sub    %edx,%eax
  10070b:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  10070e:	eb 0b                	jmp    10071b <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  100710:	0f b6 d2             	movzbl %dl,%edx
  100713:	09 ca                	or     %ecx,%edx
  100715:	66 89 13             	mov    %dx,(%ebx)
  100718:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  10071b:	5b                   	pop    %ebx
  10071c:	5e                   	pop    %esi
  10071d:	c3                   	ret    

0010071e <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  10071e:	56                   	push   %esi
  10071f:	53                   	push   %ebx
  100720:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  100724:	8d 58 ff             	lea    -0x1(%eax),%ebx
  100727:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  10072b:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  100730:	75 04                	jne    100736 <fill_numbuf+0x18>
  100732:	85 d2                	test   %edx,%edx
  100734:	74 10                	je     100746 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  100736:	89 d0                	mov    %edx,%eax
  100738:	31 d2                	xor    %edx,%edx
  10073a:	f7 f1                	div    %ecx
  10073c:	4b                   	dec    %ebx
  10073d:	8a 14 16             	mov    (%esi,%edx,1),%dl
  100740:	88 13                	mov    %dl,(%ebx)
			val /= base;
  100742:	89 c2                	mov    %eax,%edx
  100744:	eb ec                	jmp    100732 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  100746:	89 d8                	mov    %ebx,%eax
  100748:	5b                   	pop    %ebx
  100749:	5e                   	pop    %esi
  10074a:	c3                   	ret    

0010074b <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  10074b:	55                   	push   %ebp
  10074c:	57                   	push   %edi
  10074d:	56                   	push   %esi
  10074e:	53                   	push   %ebx
  10074f:	83 ec 38             	sub    $0x38,%esp
  100752:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  100756:	8b 7c 24 54          	mov    0x54(%esp),%edi
  10075a:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  10075e:	e9 60 03 00 00       	jmp    100ac3 <console_vprintf+0x378>
		if (*format != '%') {
  100763:	80 fa 25             	cmp    $0x25,%dl
  100766:	74 13                	je     10077b <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  100768:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  10076c:	0f b6 d2             	movzbl %dl,%edx
  10076f:	89 f0                	mov    %esi,%eax
  100771:	e8 59 ff ff ff       	call   1006cf <console_putc>
  100776:	e9 45 03 00 00       	jmp    100ac0 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  10077b:	47                   	inc    %edi
  10077c:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  100783:	00 
  100784:	eb 12                	jmp    100798 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  100786:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  100787:	8a 11                	mov    (%ecx),%dl
  100789:	84 d2                	test   %dl,%dl
  10078b:	74 1a                	je     1007a7 <console_vprintf+0x5c>
  10078d:	89 e8                	mov    %ebp,%eax
  10078f:	38 c2                	cmp    %al,%dl
  100791:	75 f3                	jne    100786 <console_vprintf+0x3b>
  100793:	e9 3f 03 00 00       	jmp    100ad7 <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100798:	8a 17                	mov    (%edi),%dl
  10079a:	84 d2                	test   %dl,%dl
  10079c:	74 0b                	je     1007a9 <console_vprintf+0x5e>
  10079e:	b9 2c 0b 10 00       	mov    $0x100b2c,%ecx
  1007a3:	89 d5                	mov    %edx,%ebp
  1007a5:	eb e0                	jmp    100787 <console_vprintf+0x3c>
  1007a7:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  1007a9:	8d 42 cf             	lea    -0x31(%edx),%eax
  1007ac:	3c 08                	cmp    $0x8,%al
  1007ae:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  1007b5:	00 
  1007b6:	76 13                	jbe    1007cb <console_vprintf+0x80>
  1007b8:	eb 1d                	jmp    1007d7 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  1007ba:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  1007bf:	0f be c0             	movsbl %al,%eax
  1007c2:	47                   	inc    %edi
  1007c3:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  1007c7:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  1007cb:	8a 07                	mov    (%edi),%al
  1007cd:	8d 50 d0             	lea    -0x30(%eax),%edx
  1007d0:	80 fa 09             	cmp    $0x9,%dl
  1007d3:	76 e5                	jbe    1007ba <console_vprintf+0x6f>
  1007d5:	eb 18                	jmp    1007ef <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  1007d7:	80 fa 2a             	cmp    $0x2a,%dl
  1007da:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  1007e1:	ff 
  1007e2:	75 0b                	jne    1007ef <console_vprintf+0xa4>
			width = va_arg(val, int);
  1007e4:	83 c3 04             	add    $0x4,%ebx
			++format;
  1007e7:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  1007e8:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1007eb:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  1007ef:	83 cd ff             	or     $0xffffffff,%ebp
  1007f2:	80 3f 2e             	cmpb   $0x2e,(%edi)
  1007f5:	75 37                	jne    10082e <console_vprintf+0xe3>
			++format;
  1007f7:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  1007f8:	31 ed                	xor    %ebp,%ebp
  1007fa:	8a 07                	mov    (%edi),%al
  1007fc:	8d 50 d0             	lea    -0x30(%eax),%edx
  1007ff:	80 fa 09             	cmp    $0x9,%dl
  100802:	76 0d                	jbe    100811 <console_vprintf+0xc6>
  100804:	eb 17                	jmp    10081d <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  100806:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  100809:	0f be c0             	movsbl %al,%eax
  10080c:	47                   	inc    %edi
  10080d:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  100811:	8a 07                	mov    (%edi),%al
  100813:	8d 50 d0             	lea    -0x30(%eax),%edx
  100816:	80 fa 09             	cmp    $0x9,%dl
  100819:	76 eb                	jbe    100806 <console_vprintf+0xbb>
  10081b:	eb 11                	jmp    10082e <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  10081d:	3c 2a                	cmp    $0x2a,%al
  10081f:	75 0b                	jne    10082c <console_vprintf+0xe1>
				precision = va_arg(val, int);
  100821:	83 c3 04             	add    $0x4,%ebx
				++format;
  100824:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  100825:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  100828:	85 ed                	test   %ebp,%ebp
  10082a:	79 02                	jns    10082e <console_vprintf+0xe3>
  10082c:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  10082e:	8a 07                	mov    (%edi),%al
  100830:	3c 64                	cmp    $0x64,%al
  100832:	74 34                	je     100868 <console_vprintf+0x11d>
  100834:	7f 1d                	jg     100853 <console_vprintf+0x108>
  100836:	3c 58                	cmp    $0x58,%al
  100838:	0f 84 a2 00 00 00    	je     1008e0 <console_vprintf+0x195>
  10083e:	3c 63                	cmp    $0x63,%al
  100840:	0f 84 bf 00 00 00    	je     100905 <console_vprintf+0x1ba>
  100846:	3c 43                	cmp    $0x43,%al
  100848:	0f 85 d0 00 00 00    	jne    10091e <console_vprintf+0x1d3>
  10084e:	e9 a3 00 00 00       	jmp    1008f6 <console_vprintf+0x1ab>
  100853:	3c 75                	cmp    $0x75,%al
  100855:	74 4d                	je     1008a4 <console_vprintf+0x159>
  100857:	3c 78                	cmp    $0x78,%al
  100859:	74 5c                	je     1008b7 <console_vprintf+0x16c>
  10085b:	3c 73                	cmp    $0x73,%al
  10085d:	0f 85 bb 00 00 00    	jne    10091e <console_vprintf+0x1d3>
  100863:	e9 86 00 00 00       	jmp    1008ee <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  100868:	83 c3 04             	add    $0x4,%ebx
  10086b:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  10086e:	89 d1                	mov    %edx,%ecx
  100870:	c1 f9 1f             	sar    $0x1f,%ecx
  100873:	89 0c 24             	mov    %ecx,(%esp)
  100876:	31 ca                	xor    %ecx,%edx
  100878:	55                   	push   %ebp
  100879:	29 ca                	sub    %ecx,%edx
  10087b:	68 34 0b 10 00       	push   $0x100b34
  100880:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100885:	8d 44 24 40          	lea    0x40(%esp),%eax
  100889:	e8 90 fe ff ff       	call   10071e <fill_numbuf>
  10088e:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  100892:	58                   	pop    %eax
  100893:	5a                   	pop    %edx
  100894:	ba 01 00 00 00       	mov    $0x1,%edx
  100899:	8b 04 24             	mov    (%esp),%eax
  10089c:	83 e0 01             	and    $0x1,%eax
  10089f:	e9 a5 00 00 00       	jmp    100949 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  1008a4:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  1008a7:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1008ac:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008af:	55                   	push   %ebp
  1008b0:	68 34 0b 10 00       	push   $0x100b34
  1008b5:	eb 11                	jmp    1008c8 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  1008b7:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  1008ba:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008bd:	55                   	push   %ebp
  1008be:	68 48 0b 10 00       	push   $0x100b48
  1008c3:	b9 10 00 00 00       	mov    $0x10,%ecx
  1008c8:	8d 44 24 40          	lea    0x40(%esp),%eax
  1008cc:	e8 4d fe ff ff       	call   10071e <fill_numbuf>
  1008d1:	ba 01 00 00 00       	mov    $0x1,%edx
  1008d6:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1008da:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  1008dc:	59                   	pop    %ecx
  1008dd:	59                   	pop    %ecx
  1008de:	eb 69                	jmp    100949 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  1008e0:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  1008e3:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008e6:	55                   	push   %ebp
  1008e7:	68 34 0b 10 00       	push   $0x100b34
  1008ec:	eb d5                	jmp    1008c3 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  1008ee:	83 c3 04             	add    $0x4,%ebx
  1008f1:	8b 43 fc             	mov    -0x4(%ebx),%eax
  1008f4:	eb 40                	jmp    100936 <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  1008f6:	83 c3 04             	add    $0x4,%ebx
  1008f9:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008fc:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  100900:	e9 bd 01 00 00       	jmp    100ac2 <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100905:	83 c3 04             	add    $0x4,%ebx
  100908:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  10090b:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  10090f:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100914:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100918:	88 44 24 24          	mov    %al,0x24(%esp)
  10091c:	eb 27                	jmp    100945 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  10091e:	84 c0                	test   %al,%al
  100920:	75 02                	jne    100924 <console_vprintf+0x1d9>
  100922:	b0 25                	mov    $0x25,%al
  100924:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100928:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  10092d:	80 3f 00             	cmpb   $0x0,(%edi)
  100930:	74 0a                	je     10093c <console_vprintf+0x1f1>
  100932:	8d 44 24 24          	lea    0x24(%esp),%eax
  100936:	89 44 24 04          	mov    %eax,0x4(%esp)
  10093a:	eb 09                	jmp    100945 <console_vprintf+0x1fa>
				format--;
  10093c:	8d 54 24 24          	lea    0x24(%esp),%edx
  100940:	4f                   	dec    %edi
  100941:	89 54 24 04          	mov    %edx,0x4(%esp)
  100945:	31 d2                	xor    %edx,%edx
  100947:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100949:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  10094b:	83 fd ff             	cmp    $0xffffffff,%ebp
  10094e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100955:	74 1f                	je     100976 <console_vprintf+0x22b>
  100957:	89 04 24             	mov    %eax,(%esp)
  10095a:	eb 01                	jmp    10095d <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  10095c:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  10095d:	39 e9                	cmp    %ebp,%ecx
  10095f:	74 0a                	je     10096b <console_vprintf+0x220>
  100961:	8b 44 24 04          	mov    0x4(%esp),%eax
  100965:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100969:	75 f1                	jne    10095c <console_vprintf+0x211>
  10096b:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  10096e:	89 0c 24             	mov    %ecx,(%esp)
  100971:	eb 1f                	jmp    100992 <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  100973:	42                   	inc    %edx
  100974:	eb 09                	jmp    10097f <console_vprintf+0x234>
  100976:	89 d1                	mov    %edx,%ecx
  100978:	8b 14 24             	mov    (%esp),%edx
  10097b:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  10097f:	8b 44 24 04          	mov    0x4(%esp),%eax
  100983:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  100987:	75 ea                	jne    100973 <console_vprintf+0x228>
  100989:	8b 44 24 08          	mov    0x8(%esp),%eax
  10098d:	89 14 24             	mov    %edx,(%esp)
  100990:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  100992:	85 c0                	test   %eax,%eax
  100994:	74 0c                	je     1009a2 <console_vprintf+0x257>
  100996:	84 d2                	test   %dl,%dl
  100998:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  10099f:	00 
  1009a0:	75 24                	jne    1009c6 <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  1009a2:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  1009a7:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  1009ae:	00 
  1009af:	75 15                	jne    1009c6 <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  1009b1:	8b 44 24 14          	mov    0x14(%esp),%eax
  1009b5:	83 e0 08             	and    $0x8,%eax
  1009b8:	83 f8 01             	cmp    $0x1,%eax
  1009bb:	19 c9                	sbb    %ecx,%ecx
  1009bd:	f7 d1                	not    %ecx
  1009bf:	83 e1 20             	and    $0x20,%ecx
  1009c2:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  1009c6:	3b 2c 24             	cmp    (%esp),%ebp
  1009c9:	7e 0d                	jle    1009d8 <console_vprintf+0x28d>
  1009cb:	84 d2                	test   %dl,%dl
  1009cd:	74 40                	je     100a0f <console_vprintf+0x2c4>
			zeros = precision - len;
  1009cf:	2b 2c 24             	sub    (%esp),%ebp
  1009d2:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  1009d6:	eb 3f                	jmp    100a17 <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009d8:	84 d2                	test   %dl,%dl
  1009da:	74 33                	je     100a0f <console_vprintf+0x2c4>
  1009dc:	8b 44 24 14          	mov    0x14(%esp),%eax
  1009e0:	83 e0 06             	and    $0x6,%eax
  1009e3:	83 f8 02             	cmp    $0x2,%eax
  1009e6:	75 27                	jne    100a0f <console_vprintf+0x2c4>
  1009e8:	45                   	inc    %ebp
  1009e9:	75 24                	jne    100a0f <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  1009eb:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009ed:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  1009f0:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1009f5:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009f8:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  1009fb:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  1009ff:	7d 0e                	jge    100a0f <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100a01:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100a05:	29 ca                	sub    %ecx,%edx
  100a07:	29 c2                	sub    %eax,%edx
  100a09:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a0d:	eb 08                	jmp    100a17 <console_vprintf+0x2cc>
  100a0f:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100a16:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a17:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100a1b:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a1d:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a21:	2b 2c 24             	sub    (%esp),%ebp
  100a24:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a29:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a2c:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a2f:	29 c5                	sub    %eax,%ebp
  100a31:	89 f0                	mov    %esi,%eax
  100a33:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a37:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100a3b:	eb 0f                	jmp    100a4c <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100a3d:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a41:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a46:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a47:	e8 83 fc ff ff       	call   1006cf <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a4c:	85 ed                	test   %ebp,%ebp
  100a4e:	7e 07                	jle    100a57 <console_vprintf+0x30c>
  100a50:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100a55:	74 e6                	je     100a3d <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100a57:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a5c:	89 c6                	mov    %eax,%esi
  100a5e:	74 23                	je     100a83 <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100a60:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100a65:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a69:	e8 61 fc ff ff       	call   1006cf <console_putc>
  100a6e:	89 c6                	mov    %eax,%esi
  100a70:	eb 11                	jmp    100a83 <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100a72:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a76:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100a7b:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100a7c:	e8 4e fc ff ff       	call   1006cf <console_putc>
  100a81:	eb 06                	jmp    100a89 <console_vprintf+0x33e>
  100a83:	89 f0                	mov    %esi,%eax
  100a85:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100a89:	85 f6                	test   %esi,%esi
  100a8b:	7f e5                	jg     100a72 <console_vprintf+0x327>
  100a8d:	8b 34 24             	mov    (%esp),%esi
  100a90:	eb 15                	jmp    100aa7 <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100a92:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100a96:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100a97:	0f b6 11             	movzbl (%ecx),%edx
  100a9a:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a9e:	e8 2c fc ff ff       	call   1006cf <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100aa3:	ff 44 24 04          	incl   0x4(%esp)
  100aa7:	85 f6                	test   %esi,%esi
  100aa9:	7f e7                	jg     100a92 <console_vprintf+0x347>
  100aab:	eb 0f                	jmp    100abc <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100aad:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100ab1:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100ab6:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100ab7:	e8 13 fc ff ff       	call   1006cf <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100abc:	85 ed                	test   %ebp,%ebp
  100abe:	7f ed                	jg     100aad <console_vprintf+0x362>
  100ac0:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100ac2:	47                   	inc    %edi
  100ac3:	8a 17                	mov    (%edi),%dl
  100ac5:	84 d2                	test   %dl,%dl
  100ac7:	0f 85 96 fc ff ff    	jne    100763 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100acd:	83 c4 38             	add    $0x38,%esp
  100ad0:	89 f0                	mov    %esi,%eax
  100ad2:	5b                   	pop    %ebx
  100ad3:	5e                   	pop    %esi
  100ad4:	5f                   	pop    %edi
  100ad5:	5d                   	pop    %ebp
  100ad6:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100ad7:	81 e9 2c 0b 10 00    	sub    $0x100b2c,%ecx
  100add:	b8 01 00 00 00       	mov    $0x1,%eax
  100ae2:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100ae4:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100ae5:	09 44 24 14          	or     %eax,0x14(%esp)
  100ae9:	e9 aa fc ff ff       	jmp    100798 <console_vprintf+0x4d>

00100aee <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100aee:	8d 44 24 10          	lea    0x10(%esp),%eax
  100af2:	50                   	push   %eax
  100af3:	ff 74 24 10          	pushl  0x10(%esp)
  100af7:	ff 74 24 10          	pushl  0x10(%esp)
  100afb:	ff 74 24 10          	pushl  0x10(%esp)
  100aff:	e8 47 fc ff ff       	call   10074b <console_vprintf>
  100b04:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100b07:	c3                   	ret    
