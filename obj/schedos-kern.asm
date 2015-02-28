
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
  100014:	e8 8e 01 00 00       	call   1001a7 <start>
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
  10006d:	e8 c4 00 00 00       	call   100136 <interrupt>

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
  10009c:	83 ec 0c             	sub    $0xc,%esp
	pid_t pid = current->p_pid;

	if (scheduling_algorithm == 0)
  10009f:	8b 0d 10 7a 10 00    	mov    0x107a10,%ecx
 *****************************************************************************/

void
schedule(void)
{
	pid_t pid = current->p_pid;
  1000a5:	a1 0c 7a 10 00       	mov    0x107a0c,%eax

	if (scheduling_algorithm == 0)
  1000aa:	85 c9                	test   %ecx,%ecx
 *****************************************************************************/

void
schedule(void)
{
	pid_t pid = current->p_pid;
  1000ac:	8b 10                	mov    (%eax),%edx

	if (scheduling_algorithm == 0)
  1000ae:	75 19                	jne    1000c9 <schedule+0x2d>
		while (1) {
			pid = (pid + 1) % NPROCS;
  1000b0:	b1 05                	mov    $0x5,%cl
  1000b2:	8d 42 01             	lea    0x1(%edx),%eax
  1000b5:	99                   	cltd   
  1000b6:	f7 f9                	idiv   %ecx

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000b8:	6b c2 50             	imul   $0x50,%edx,%eax
  1000bb:	83 b8 5c 70 10 00 01 	cmpl   $0x1,0x10705c(%eax)
  1000c2:	75 ee                	jne    1000b2 <schedule+0x16>
				run(&proc_array[pid]);
  1000c4:	83 ec 0c             	sub    $0xc,%esp
  1000c7:	eb 42                	jmp    10010b <schedule+0x6f>
		}

	if (scheduling_algorithm == 1)
  1000c9:	83 f9 01             	cmp    $0x1,%ecx
  1000cc:	75 48                	jne    100116 <schedule+0x7a>
	{
		//run highest priority first
		for (pid = 0; pid < NPROCS; pid++)
		{
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000ce:	31 c0                	xor    %eax,%eax
  1000d0:	83 3d 5c 70 10 00 01 	cmpl   $0x1,0x10705c
  1000d7:	74 2c                	je     100105 <schedule+0x69>
  1000d9:	83 3d ac 70 10 00 01 	cmpl   $0x1,0x1070ac
  1000e0:	b0 01                	mov    $0x1,%al
  1000e2:	74 21                	je     100105 <schedule+0x69>
  1000e4:	83 3d fc 70 10 00 01 	cmpl   $0x1,0x1070fc
  1000eb:	b0 02                	mov    $0x2,%al
  1000ed:	74 16                	je     100105 <schedule+0x69>
  1000ef:	83 3d 4c 71 10 00 01 	cmpl   $0x1,0x10714c
  1000f6:	b0 03                	mov    $0x3,%al
  1000f8:	74 0b                	je     100105 <schedule+0x69>
  1000fa:	83 3d 9c 71 10 00 01 	cmpl   $0x1,0x10719c
  100101:	75 13                	jne    100116 <schedule+0x7a>
  100103:	b0 04                	mov    $0x4,%al
				run(&proc_array[pid]);
  100105:	6b c0 50             	imul   $0x50,%eax,%eax
  100108:	83 ec 0c             	sub    $0xc,%esp
  10010b:	05 14 70 10 00       	add    $0x107014,%eax
  100110:	50                   	push   %eax
  100111:	e8 a3 03 00 00       	call   1004b9 <run>
		}
	}


	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  100116:	a1 00 80 19 00       	mov    0x198000,%eax
  10011b:	51                   	push   %ecx
  10011c:	68 78 0a 10 00       	push   $0x100a78
  100121:	68 00 01 00 00       	push   $0x100
  100126:	50                   	push   %eax
  100127:	e8 32 09 00 00       	call   100a5e <console_printf>
  10012c:	83 c4 10             	add    $0x10,%esp
  10012f:	a3 00 80 19 00       	mov    %eax,0x198000
  100134:	eb fe                	jmp    100134 <schedule+0x98>

00100136 <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  100136:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  100137:	a1 0c 7a 10 00       	mov    0x107a0c,%eax
  10013c:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  100141:	56                   	push   %esi
  100142:	53                   	push   %ebx
  100143:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  100147:	8d 78 04             	lea    0x4(%eax),%edi
  10014a:	89 de                	mov    %ebx,%esi
  10014c:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  10014e:	8b 53 28             	mov    0x28(%ebx),%edx
  100151:	83 fa 31             	cmp    $0x31,%edx
  100154:	74 1f                	je     100175 <interrupt+0x3f>
  100156:	77 0c                	ja     100164 <interrupt+0x2e>
  100158:	83 fa 20             	cmp    $0x20,%edx
  10015b:	74 43                	je     1001a0 <interrupt+0x6a>
  10015d:	83 fa 30             	cmp    $0x30,%edx
  100160:	74 0e                	je     100170 <interrupt+0x3a>
  100162:	eb 41                	jmp    1001a5 <interrupt+0x6f>
  100164:	83 fa 32             	cmp    $0x32,%edx
  100167:	74 23                	je     10018c <interrupt+0x56>
  100169:	83 fa 33             	cmp    $0x33,%edx
  10016c:	74 29                	je     100197 <interrupt+0x61>
  10016e:	eb 35                	jmp    1001a5 <interrupt+0x6f>

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  100170:	e8 27 ff ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100175:	a1 0c 7a 10 00       	mov    0x107a0c,%eax
		current->p_exit_status = reg->reg_eax;
  10017a:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  10017d:	c7 40 48 03 00 00 00 	movl   $0x3,0x48(%eax)
		current->p_exit_status = reg->reg_eax;
  100184:	89 50 4c             	mov    %edx,0x4c(%eax)
		schedule();
  100187:	e8 10 ff ff ff       	call   10009c <schedule>

	case INT_SYS_USER1:
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		/* Your code here (if you want). */
		run(current);
  10018c:	83 ec 0c             	sub    $0xc,%esp
  10018f:	ff 35 0c 7a 10 00    	pushl  0x107a0c
  100195:	eb 04                	jmp    10019b <interrupt+0x65>

	case INT_SYS_USER2:
		/* Your code here (if you want). */
		run(current);
  100197:	83 ec 0c             	sub    $0xc,%esp
  10019a:	50                   	push   %eax
  10019b:	e8 19 03 00 00       	call   1004b9 <run>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  1001a0:	e8 f7 fe ff ff       	call   10009c <schedule>
  1001a5:	eb fe                	jmp    1001a5 <interrupt+0x6f>

001001a7 <start>:
 *
 *****************************************************************************/

void
start(void)
{
  1001a7:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1001a8:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  1001ad:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1001ae:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  1001b0:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1001b1:	bb 64 70 10 00       	mov    $0x107064,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  1001b6:	e8 dd 00 00 00       	call   100298 <segments_init>
	interrupt_controller_init(0);
  1001bb:	83 ec 0c             	sub    $0xc,%esp
  1001be:	6a 00                	push   $0x0
  1001c0:	e8 ce 01 00 00       	call   100393 <interrupt_controller_init>
	console_clear();
  1001c5:	e8 52 02 00 00       	call   10041c <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  1001ca:	83 c4 0c             	add    $0xc,%esp
  1001cd:	68 90 01 00 00       	push   $0x190
  1001d2:	6a 00                	push   $0x0
  1001d4:	68 14 70 10 00       	push   $0x107014
  1001d9:	e8 1e 04 00 00       	call   1005fc <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1001de:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1001e1:	c7 05 14 70 10 00 00 	movl   $0x0,0x107014
  1001e8:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1001eb:	c7 05 5c 70 10 00 00 	movl   $0x0,0x10705c
  1001f2:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1001f5:	c7 05 64 70 10 00 01 	movl   $0x1,0x107064
  1001fc:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1001ff:	c7 05 ac 70 10 00 00 	movl   $0x0,0x1070ac
  100206:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100209:	c7 05 b4 70 10 00 02 	movl   $0x2,0x1070b4
  100210:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100213:	c7 05 fc 70 10 00 00 	movl   $0x0,0x1070fc
  10021a:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10021d:	c7 05 04 71 10 00 03 	movl   $0x3,0x107104
  100224:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100227:	c7 05 4c 71 10 00 00 	movl   $0x0,0x10714c
  10022e:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100231:	c7 05 54 71 10 00 04 	movl   $0x4,0x107154
  100238:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10023b:	c7 05 9c 71 10 00 00 	movl   $0x0,0x10719c
  100242:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  100245:	83 ec 0c             	sub    $0xc,%esp
  100248:	53                   	push   %ebx
  100249:	e8 82 02 00 00       	call   1004d0 <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  10024e:	58                   	pop    %eax
  10024f:	5a                   	pop    %edx
  100250:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  100253:	89 7b 40             	mov    %edi,0x40(%ebx)

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100256:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  10025c:	50                   	push   %eax
  10025d:	56                   	push   %esi

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  10025e:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  10025f:	e8 a8 02 00 00       	call   10050c <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100264:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100267:	c7 43 48 01 00 00 00 	movl   $0x1,0x48(%ebx)
  10026e:	83 c3 50             	add    $0x50,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100271:	83 fe 04             	cmp    $0x4,%esi
  100274:	75 cf                	jne    100245 <start+0x9e>

	// Initialize the scheduling algorithm.
	scheduling_algorithm = 1;

	// Switch to the first process.
	run(&proc_array[1]);
  100276:	83 ec 0c             	sub    $0xc,%esp
  100279:	68 64 70 10 00       	push   $0x107064
		proc->p_state = P_RUNNABLE;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  10027e:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  100285:	80 0b 00 

	// Initialize the scheduling algorithm.
	scheduling_algorithm = 1;
  100288:	c7 05 10 7a 10 00 01 	movl   $0x1,0x107a10
  10028f:	00 00 00 

	// Switch to the first process.
	run(&proc_array[1]);
  100292:	e8 22 02 00 00       	call   1004b9 <run>
  100297:	90                   	nop

00100298 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100298:	b8 a4 71 10 00       	mov    $0x1071a4,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10029d:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002a2:	89 c2                	mov    %eax,%edx
  1002a4:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  1002a7:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002a8:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  1002ad:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002b0:	66 a3 3a 10 10 00    	mov    %ax,0x10103a
  1002b6:	c1 e8 18             	shr    $0x18,%eax
  1002b9:	88 15 3c 10 10 00    	mov    %dl,0x10103c
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002bf:	ba 0c 72 10 00       	mov    $0x10720c,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002c4:	a2 3f 10 10 00       	mov    %al,0x10103f
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002c9:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002cb:	66 c7 05 38 10 10 00 	movw   $0x68,0x101038
  1002d2:	68 00 
  1002d4:	c6 05 3e 10 10 00 40 	movb   $0x40,0x10103e
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  1002db:	c6 05 3d 10 10 00 89 	movb   $0x89,0x10103d

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  1002e2:	c7 05 a8 71 10 00 00 	movl   $0x180000,0x1071a8
  1002e9:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  1002ec:	66 c7 05 ac 71 10 00 	movw   $0x10,0x1071ac
  1002f3:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002f5:	66 89 0c c5 0c 72 10 	mov    %cx,0x10720c(,%eax,8)
  1002fc:	00 
  1002fd:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100304:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100309:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  10030e:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  100313:	40                   	inc    %eax
  100314:	3d 00 01 00 00       	cmp    $0x100,%eax
  100319:	75 da                	jne    1002f5 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  10031b:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100320:	ba 0c 72 10 00       	mov    $0x10720c,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100325:	66 a3 0c 73 10 00    	mov    %ax,0x10730c
  10032b:	c1 e8 10             	shr    $0x10,%eax
  10032e:	66 a3 12 73 10 00    	mov    %ax,0x107312
  100334:	b8 30 00 00 00       	mov    $0x30,%eax
  100339:	66 c7 05 0e 73 10 00 	movw   $0x8,0x10730e
  100340:	08 00 
  100342:	c6 05 10 73 10 00 00 	movb   $0x0,0x107310
  100349:	c6 05 11 73 10 00 8e 	movb   $0x8e,0x107311

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100350:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  100357:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  10035e:	66 89 0c c5 0c 72 10 	mov    %cx,0x10720c(,%eax,8)
  100365:	00 
  100366:	c1 e9 10             	shr    $0x10,%ecx
  100369:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  10036e:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  100373:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  100378:	40                   	inc    %eax
  100379:	83 f8 3a             	cmp    $0x3a,%eax
  10037c:	75 d2                	jne    100350 <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  10037e:	b0 28                	mov    $0x28,%al
  100380:	0f 01 15 00 10 10 00 	lgdtl  0x101000
  100387:	0f 00 d8             	ltr    %ax
  10038a:	0f 01 1d 08 10 10 00 	lidtl  0x101008
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  100391:	5b                   	pop    %ebx
  100392:	c3                   	ret    

00100393 <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  100393:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  100394:	b0 ff                	mov    $0xff,%al
  100396:	57                   	push   %edi
  100397:	56                   	push   %esi
  100398:	53                   	push   %ebx
  100399:	bb 21 00 00 00       	mov    $0x21,%ebx
  10039e:	89 da                	mov    %ebx,%edx
  1003a0:	ee                   	out    %al,(%dx)
  1003a1:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  1003a6:	89 ca                	mov    %ecx,%edx
  1003a8:	ee                   	out    %al,(%dx)
  1003a9:	be 11 00 00 00       	mov    $0x11,%esi
  1003ae:	bf 20 00 00 00       	mov    $0x20,%edi
  1003b3:	89 f0                	mov    %esi,%eax
  1003b5:	89 fa                	mov    %edi,%edx
  1003b7:	ee                   	out    %al,(%dx)
  1003b8:	b0 20                	mov    $0x20,%al
  1003ba:	89 da                	mov    %ebx,%edx
  1003bc:	ee                   	out    %al,(%dx)
  1003bd:	b0 04                	mov    $0x4,%al
  1003bf:	ee                   	out    %al,(%dx)
  1003c0:	b0 03                	mov    $0x3,%al
  1003c2:	ee                   	out    %al,(%dx)
  1003c3:	bd a0 00 00 00       	mov    $0xa0,%ebp
  1003c8:	89 f0                	mov    %esi,%eax
  1003ca:	89 ea                	mov    %ebp,%edx
  1003cc:	ee                   	out    %al,(%dx)
  1003cd:	b0 28                	mov    $0x28,%al
  1003cf:	89 ca                	mov    %ecx,%edx
  1003d1:	ee                   	out    %al,(%dx)
  1003d2:	b0 02                	mov    $0x2,%al
  1003d4:	ee                   	out    %al,(%dx)
  1003d5:	b0 01                	mov    $0x1,%al
  1003d7:	ee                   	out    %al,(%dx)
  1003d8:	b0 68                	mov    $0x68,%al
  1003da:	89 fa                	mov    %edi,%edx
  1003dc:	ee                   	out    %al,(%dx)
  1003dd:	be 0a 00 00 00       	mov    $0xa,%esi
  1003e2:	89 f0                	mov    %esi,%eax
  1003e4:	ee                   	out    %al,(%dx)
  1003e5:	b0 68                	mov    $0x68,%al
  1003e7:	89 ea                	mov    %ebp,%edx
  1003e9:	ee                   	out    %al,(%dx)
  1003ea:	89 f0                	mov    %esi,%eax
  1003ec:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  1003ed:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  1003f2:	89 da                	mov    %ebx,%edx
  1003f4:	19 c0                	sbb    %eax,%eax
  1003f6:	f7 d0                	not    %eax
  1003f8:	05 ff 00 00 00       	add    $0xff,%eax
  1003fd:	ee                   	out    %al,(%dx)
  1003fe:	b0 ff                	mov    $0xff,%al
  100400:	89 ca                	mov    %ecx,%edx
  100402:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  100403:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  100408:	74 0d                	je     100417 <interrupt_controller_init+0x84>
  10040a:	b2 43                	mov    $0x43,%dl
  10040c:	b0 34                	mov    $0x34,%al
  10040e:	ee                   	out    %al,(%dx)
  10040f:	b0 9c                	mov    $0x9c,%al
  100411:	b2 40                	mov    $0x40,%dl
  100413:	ee                   	out    %al,(%dx)
  100414:	b0 2e                	mov    $0x2e,%al
  100416:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  100417:	5b                   	pop    %ebx
  100418:	5e                   	pop    %esi
  100419:	5f                   	pop    %edi
  10041a:	5d                   	pop    %ebp
  10041b:	c3                   	ret    

0010041c <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  10041c:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  10041d:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  10041f:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100420:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  100427:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  10042a:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100430:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  100436:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  100439:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  10043e:	75 ea                	jne    10042a <console_clear+0xe>
  100440:	be d4 03 00 00       	mov    $0x3d4,%esi
  100445:	b0 0e                	mov    $0xe,%al
  100447:	89 f2                	mov    %esi,%edx
  100449:	ee                   	out    %al,(%dx)
  10044a:	31 c9                	xor    %ecx,%ecx
  10044c:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  100451:	88 c8                	mov    %cl,%al
  100453:	89 da                	mov    %ebx,%edx
  100455:	ee                   	out    %al,(%dx)
  100456:	b0 0f                	mov    $0xf,%al
  100458:	89 f2                	mov    %esi,%edx
  10045a:	ee                   	out    %al,(%dx)
  10045b:	88 c8                	mov    %cl,%al
  10045d:	89 da                	mov    %ebx,%edx
  10045f:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  100460:	5b                   	pop    %ebx
  100461:	5e                   	pop    %esi
  100462:	c3                   	ret    

00100463 <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  100463:	ba 64 00 00 00       	mov    $0x64,%edx
  100468:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  100469:	a8 01                	test   $0x1,%al
  10046b:	74 45                	je     1004b2 <console_read_digit+0x4f>
  10046d:	b2 60                	mov    $0x60,%dl
  10046f:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  100470:	8d 50 fe             	lea    -0x2(%eax),%edx
  100473:	80 fa 08             	cmp    $0x8,%dl
  100476:	77 05                	ja     10047d <console_read_digit+0x1a>
		return data - 0x02 + 1;
  100478:	0f b6 c0             	movzbl %al,%eax
  10047b:	48                   	dec    %eax
  10047c:	c3                   	ret    
	else if (data == 0x0B)
  10047d:	3c 0b                	cmp    $0xb,%al
  10047f:	74 35                	je     1004b6 <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  100481:	8d 50 b9             	lea    -0x47(%eax),%edx
  100484:	80 fa 02             	cmp    $0x2,%dl
  100487:	77 07                	ja     100490 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  100489:	0f b6 c0             	movzbl %al,%eax
  10048c:	83 e8 40             	sub    $0x40,%eax
  10048f:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  100490:	8d 50 b5             	lea    -0x4b(%eax),%edx
  100493:	80 fa 02             	cmp    $0x2,%dl
  100496:	77 07                	ja     10049f <console_read_digit+0x3c>
		return data - 0x4B + 4;
  100498:	0f b6 c0             	movzbl %al,%eax
  10049b:	83 e8 47             	sub    $0x47,%eax
  10049e:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  10049f:	8d 50 b1             	lea    -0x4f(%eax),%edx
  1004a2:	80 fa 02             	cmp    $0x2,%dl
  1004a5:	77 07                	ja     1004ae <console_read_digit+0x4b>
		return data - 0x4F + 1;
  1004a7:	0f b6 c0             	movzbl %al,%eax
  1004aa:	83 e8 4e             	sub    $0x4e,%eax
  1004ad:	c3                   	ret    
	else if (data == 0x53)
  1004ae:	3c 53                	cmp    $0x53,%al
  1004b0:	74 04                	je     1004b6 <console_read_digit+0x53>
  1004b2:	83 c8 ff             	or     $0xffffffff,%eax
  1004b5:	c3                   	ret    
  1004b6:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  1004b8:	c3                   	ret    

001004b9 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  1004b9:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  1004bd:	a3 0c 7a 10 00       	mov    %eax,0x107a0c

	asm volatile("movl %0,%%esp\n\t"
  1004c2:	83 c0 04             	add    $0x4,%eax
  1004c5:	89 c4                	mov    %eax,%esp
  1004c7:	61                   	popa   
  1004c8:	07                   	pop    %es
  1004c9:	1f                   	pop    %ds
  1004ca:	83 c4 08             	add    $0x8,%esp
  1004cd:	cf                   	iret   
  1004ce:	eb fe                	jmp    1004ce <run+0x15>

001004d0 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  1004d0:	53                   	push   %ebx
  1004d1:	83 ec 0c             	sub    $0xc,%esp
  1004d4:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  1004d8:	6a 44                	push   $0x44
  1004da:	6a 00                	push   $0x0
  1004dc:	8d 43 04             	lea    0x4(%ebx),%eax
  1004df:	50                   	push   %eax
  1004e0:	e8 17 01 00 00       	call   1005fc <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  1004e5:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  1004eb:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  1004f1:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  1004f7:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  1004fd:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  100504:	83 c4 18             	add    $0x18,%esp
  100507:	5b                   	pop    %ebx
  100508:	c3                   	ret    
  100509:	90                   	nop
  10050a:	90                   	nop
  10050b:	90                   	nop

0010050c <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  10050c:	55                   	push   %ebp
  10050d:	57                   	push   %edi
  10050e:	56                   	push   %esi
  10050f:	53                   	push   %ebx
  100510:	83 ec 1c             	sub    $0x1c,%esp
  100513:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  100517:	83 f8 03             	cmp    $0x3,%eax
  10051a:	7f 04                	jg     100520 <program_loader+0x14>
  10051c:	85 c0                	test   %eax,%eax
  10051e:	79 02                	jns    100522 <program_loader+0x16>
  100520:	eb fe                	jmp    100520 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  100522:	8b 34 c5 40 10 10 00 	mov    0x101040(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  100529:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  10052f:	74 02                	je     100533 <program_loader+0x27>
  100531:	eb fe                	jmp    100531 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100533:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  100536:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10053a:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  10053c:	c1 e5 05             	shl    $0x5,%ebp
  10053f:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  100542:	eb 3f                	jmp    100583 <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  100544:	83 3b 01             	cmpl   $0x1,(%ebx)
  100547:	75 37                	jne    100580 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  100549:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  10054c:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  10054f:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100552:	01 c7                	add    %eax,%edi
	memsz += va;
  100554:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  100556:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  10055b:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  10055f:	52                   	push   %edx
  100560:	89 fa                	mov    %edi,%edx
  100562:	29 c2                	sub    %eax,%edx
  100564:	52                   	push   %edx
  100565:	8b 53 04             	mov    0x4(%ebx),%edx
  100568:	01 f2                	add    %esi,%edx
  10056a:	52                   	push   %edx
  10056b:	50                   	push   %eax
  10056c:	e8 27 00 00 00       	call   100598 <memcpy>
  100571:	83 c4 10             	add    $0x10,%esp
  100574:	eb 04                	jmp    10057a <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  100576:	c6 07 00             	movb   $0x0,(%edi)
  100579:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  10057a:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  10057e:	72 f6                	jb     100576 <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  100580:	83 c3 20             	add    $0x20,%ebx
  100583:	39 eb                	cmp    %ebp,%ebx
  100585:	72 bd                	jb     100544 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  100587:	8b 56 18             	mov    0x18(%esi),%edx
  10058a:	8b 44 24 34          	mov    0x34(%esp),%eax
  10058e:	89 10                	mov    %edx,(%eax)
}
  100590:	83 c4 1c             	add    $0x1c,%esp
  100593:	5b                   	pop    %ebx
  100594:	5e                   	pop    %esi
  100595:	5f                   	pop    %edi
  100596:	5d                   	pop    %ebp
  100597:	c3                   	ret    

00100598 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  100598:	56                   	push   %esi
  100599:	31 d2                	xor    %edx,%edx
  10059b:	53                   	push   %ebx
  10059c:	8b 44 24 0c          	mov    0xc(%esp),%eax
  1005a0:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  1005a4:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1005a8:	eb 08                	jmp    1005b2 <memcpy+0x1a>
		*d++ = *s++;
  1005aa:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  1005ad:	4e                   	dec    %esi
  1005ae:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  1005b1:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1005b2:	85 f6                	test   %esi,%esi
  1005b4:	75 f4                	jne    1005aa <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  1005b6:	5b                   	pop    %ebx
  1005b7:	5e                   	pop    %esi
  1005b8:	c3                   	ret    

001005b9 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  1005b9:	57                   	push   %edi
  1005ba:	56                   	push   %esi
  1005bb:	53                   	push   %ebx
  1005bc:	8b 44 24 10          	mov    0x10(%esp),%eax
  1005c0:	8b 7c 24 14          	mov    0x14(%esp),%edi
  1005c4:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  1005c8:	39 c7                	cmp    %eax,%edi
  1005ca:	73 26                	jae    1005f2 <memmove+0x39>
  1005cc:	8d 34 17             	lea    (%edi,%edx,1),%esi
  1005cf:	39 c6                	cmp    %eax,%esi
  1005d1:	76 1f                	jbe    1005f2 <memmove+0x39>
		s += n, d += n;
  1005d3:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  1005d6:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  1005d8:	eb 07                	jmp    1005e1 <memmove+0x28>
			*--d = *--s;
  1005da:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  1005dd:	4a                   	dec    %edx
  1005de:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  1005e1:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  1005e2:	85 d2                	test   %edx,%edx
  1005e4:	75 f4                	jne    1005da <memmove+0x21>
  1005e6:	eb 10                	jmp    1005f8 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  1005e8:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  1005eb:	4a                   	dec    %edx
  1005ec:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  1005ef:	41                   	inc    %ecx
  1005f0:	eb 02                	jmp    1005f4 <memmove+0x3b>
  1005f2:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  1005f4:	85 d2                	test   %edx,%edx
  1005f6:	75 f0                	jne    1005e8 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  1005f8:	5b                   	pop    %ebx
  1005f9:	5e                   	pop    %esi
  1005fa:	5f                   	pop    %edi
  1005fb:	c3                   	ret    

001005fc <memset>:

void *
memset(void *v, int c, size_t n)
{
  1005fc:	53                   	push   %ebx
  1005fd:	8b 44 24 08          	mov    0x8(%esp),%eax
  100601:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  100605:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  100609:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  10060b:	eb 04                	jmp    100611 <memset+0x15>
		*p++ = c;
  10060d:	88 1a                	mov    %bl,(%edx)
  10060f:	49                   	dec    %ecx
  100610:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  100611:	85 c9                	test   %ecx,%ecx
  100613:	75 f8                	jne    10060d <memset+0x11>
		*p++ = c;
	return v;
}
  100615:	5b                   	pop    %ebx
  100616:	c3                   	ret    

00100617 <strlen>:

size_t
strlen(const char *s)
{
  100617:	8b 54 24 04          	mov    0x4(%esp),%edx
  10061b:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  10061d:	eb 01                	jmp    100620 <strlen+0x9>
		++n;
  10061f:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100620:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  100624:	75 f9                	jne    10061f <strlen+0x8>
		++n;
	return n;
}
  100626:	c3                   	ret    

00100627 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  100627:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  10062b:	31 c0                	xor    %eax,%eax
  10062d:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100631:	eb 01                	jmp    100634 <strnlen+0xd>
		++n;
  100633:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100634:	39 d0                	cmp    %edx,%eax
  100636:	74 06                	je     10063e <strnlen+0x17>
  100638:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  10063c:	75 f5                	jne    100633 <strnlen+0xc>
		++n;
	return n;
}
  10063e:	c3                   	ret    

0010063f <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  10063f:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  100640:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100645:	53                   	push   %ebx
  100646:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  100648:	76 05                	jbe    10064f <console_putc+0x10>
  10064a:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  10064f:	80 fa 0a             	cmp    $0xa,%dl
  100652:	75 2c                	jne    100680 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100654:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  10065a:	be 50 00 00 00       	mov    $0x50,%esi
  10065f:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  100661:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100664:	99                   	cltd   
  100665:	f7 fe                	idiv   %esi
  100667:	89 de                	mov    %ebx,%esi
  100669:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  10066b:	eb 07                	jmp    100674 <console_putc+0x35>
			*cursor++ = ' ' | color;
  10066d:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100670:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  100671:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100674:	83 f8 50             	cmp    $0x50,%eax
  100677:	75 f4                	jne    10066d <console_putc+0x2e>
  100679:	29 d0                	sub    %edx,%eax
  10067b:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  10067e:	eb 0b                	jmp    10068b <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  100680:	0f b6 d2             	movzbl %dl,%edx
  100683:	09 ca                	or     %ecx,%edx
  100685:	66 89 13             	mov    %dx,(%ebx)
  100688:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  10068b:	5b                   	pop    %ebx
  10068c:	5e                   	pop    %esi
  10068d:	c3                   	ret    

0010068e <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  10068e:	56                   	push   %esi
  10068f:	53                   	push   %ebx
  100690:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  100694:	8d 58 ff             	lea    -0x1(%eax),%ebx
  100697:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  10069b:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  1006a0:	75 04                	jne    1006a6 <fill_numbuf+0x18>
  1006a2:	85 d2                	test   %edx,%edx
  1006a4:	74 10                	je     1006b6 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  1006a6:	89 d0                	mov    %edx,%eax
  1006a8:	31 d2                	xor    %edx,%edx
  1006aa:	f7 f1                	div    %ecx
  1006ac:	4b                   	dec    %ebx
  1006ad:	8a 14 16             	mov    (%esi,%edx,1),%dl
  1006b0:	88 13                	mov    %dl,(%ebx)
			val /= base;
  1006b2:	89 c2                	mov    %eax,%edx
  1006b4:	eb ec                	jmp    1006a2 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  1006b6:	89 d8                	mov    %ebx,%eax
  1006b8:	5b                   	pop    %ebx
  1006b9:	5e                   	pop    %esi
  1006ba:	c3                   	ret    

001006bb <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  1006bb:	55                   	push   %ebp
  1006bc:	57                   	push   %edi
  1006bd:	56                   	push   %esi
  1006be:	53                   	push   %ebx
  1006bf:	83 ec 38             	sub    $0x38,%esp
  1006c2:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  1006c6:	8b 7c 24 54          	mov    0x54(%esp),%edi
  1006ca:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  1006ce:	e9 60 03 00 00       	jmp    100a33 <console_vprintf+0x378>
		if (*format != '%') {
  1006d3:	80 fa 25             	cmp    $0x25,%dl
  1006d6:	74 13                	je     1006eb <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  1006d8:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1006dc:	0f b6 d2             	movzbl %dl,%edx
  1006df:	89 f0                	mov    %esi,%eax
  1006e1:	e8 59 ff ff ff       	call   10063f <console_putc>
  1006e6:	e9 45 03 00 00       	jmp    100a30 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1006eb:	47                   	inc    %edi
  1006ec:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  1006f3:	00 
  1006f4:	eb 12                	jmp    100708 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  1006f6:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  1006f7:	8a 11                	mov    (%ecx),%dl
  1006f9:	84 d2                	test   %dl,%dl
  1006fb:	74 1a                	je     100717 <console_vprintf+0x5c>
  1006fd:	89 e8                	mov    %ebp,%eax
  1006ff:	38 c2                	cmp    %al,%dl
  100701:	75 f3                	jne    1006f6 <console_vprintf+0x3b>
  100703:	e9 3f 03 00 00       	jmp    100a47 <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100708:	8a 17                	mov    (%edi),%dl
  10070a:	84 d2                	test   %dl,%dl
  10070c:	74 0b                	je     100719 <console_vprintf+0x5e>
  10070e:	b9 9c 0a 10 00       	mov    $0x100a9c,%ecx
  100713:	89 d5                	mov    %edx,%ebp
  100715:	eb e0                	jmp    1006f7 <console_vprintf+0x3c>
  100717:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  100719:	8d 42 cf             	lea    -0x31(%edx),%eax
  10071c:	3c 08                	cmp    $0x8,%al
  10071e:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100725:	00 
  100726:	76 13                	jbe    10073b <console_vprintf+0x80>
  100728:	eb 1d                	jmp    100747 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  10072a:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  10072f:	0f be c0             	movsbl %al,%eax
  100732:	47                   	inc    %edi
  100733:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  100737:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  10073b:	8a 07                	mov    (%edi),%al
  10073d:	8d 50 d0             	lea    -0x30(%eax),%edx
  100740:	80 fa 09             	cmp    $0x9,%dl
  100743:	76 e5                	jbe    10072a <console_vprintf+0x6f>
  100745:	eb 18                	jmp    10075f <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  100747:	80 fa 2a             	cmp    $0x2a,%dl
  10074a:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  100751:	ff 
  100752:	75 0b                	jne    10075f <console_vprintf+0xa4>
			width = va_arg(val, int);
  100754:	83 c3 04             	add    $0x4,%ebx
			++format;
  100757:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  100758:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10075b:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  10075f:	83 cd ff             	or     $0xffffffff,%ebp
  100762:	80 3f 2e             	cmpb   $0x2e,(%edi)
  100765:	75 37                	jne    10079e <console_vprintf+0xe3>
			++format;
  100767:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  100768:	31 ed                	xor    %ebp,%ebp
  10076a:	8a 07                	mov    (%edi),%al
  10076c:	8d 50 d0             	lea    -0x30(%eax),%edx
  10076f:	80 fa 09             	cmp    $0x9,%dl
  100772:	76 0d                	jbe    100781 <console_vprintf+0xc6>
  100774:	eb 17                	jmp    10078d <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  100776:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  100779:	0f be c0             	movsbl %al,%eax
  10077c:	47                   	inc    %edi
  10077d:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  100781:	8a 07                	mov    (%edi),%al
  100783:	8d 50 d0             	lea    -0x30(%eax),%edx
  100786:	80 fa 09             	cmp    $0x9,%dl
  100789:	76 eb                	jbe    100776 <console_vprintf+0xbb>
  10078b:	eb 11                	jmp    10079e <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  10078d:	3c 2a                	cmp    $0x2a,%al
  10078f:	75 0b                	jne    10079c <console_vprintf+0xe1>
				precision = va_arg(val, int);
  100791:	83 c3 04             	add    $0x4,%ebx
				++format;
  100794:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  100795:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  100798:	85 ed                	test   %ebp,%ebp
  10079a:	79 02                	jns    10079e <console_vprintf+0xe3>
  10079c:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  10079e:	8a 07                	mov    (%edi),%al
  1007a0:	3c 64                	cmp    $0x64,%al
  1007a2:	74 34                	je     1007d8 <console_vprintf+0x11d>
  1007a4:	7f 1d                	jg     1007c3 <console_vprintf+0x108>
  1007a6:	3c 58                	cmp    $0x58,%al
  1007a8:	0f 84 a2 00 00 00    	je     100850 <console_vprintf+0x195>
  1007ae:	3c 63                	cmp    $0x63,%al
  1007b0:	0f 84 bf 00 00 00    	je     100875 <console_vprintf+0x1ba>
  1007b6:	3c 43                	cmp    $0x43,%al
  1007b8:	0f 85 d0 00 00 00    	jne    10088e <console_vprintf+0x1d3>
  1007be:	e9 a3 00 00 00       	jmp    100866 <console_vprintf+0x1ab>
  1007c3:	3c 75                	cmp    $0x75,%al
  1007c5:	74 4d                	je     100814 <console_vprintf+0x159>
  1007c7:	3c 78                	cmp    $0x78,%al
  1007c9:	74 5c                	je     100827 <console_vprintf+0x16c>
  1007cb:	3c 73                	cmp    $0x73,%al
  1007cd:	0f 85 bb 00 00 00    	jne    10088e <console_vprintf+0x1d3>
  1007d3:	e9 86 00 00 00       	jmp    10085e <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  1007d8:	83 c3 04             	add    $0x4,%ebx
  1007db:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  1007de:	89 d1                	mov    %edx,%ecx
  1007e0:	c1 f9 1f             	sar    $0x1f,%ecx
  1007e3:	89 0c 24             	mov    %ecx,(%esp)
  1007e6:	31 ca                	xor    %ecx,%edx
  1007e8:	55                   	push   %ebp
  1007e9:	29 ca                	sub    %ecx,%edx
  1007eb:	68 a4 0a 10 00       	push   $0x100aa4
  1007f0:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1007f5:	8d 44 24 40          	lea    0x40(%esp),%eax
  1007f9:	e8 90 fe ff ff       	call   10068e <fill_numbuf>
  1007fe:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  100802:	58                   	pop    %eax
  100803:	5a                   	pop    %edx
  100804:	ba 01 00 00 00       	mov    $0x1,%edx
  100809:	8b 04 24             	mov    (%esp),%eax
  10080c:	83 e0 01             	and    $0x1,%eax
  10080f:	e9 a5 00 00 00       	jmp    1008b9 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  100814:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  100817:	b9 0a 00 00 00       	mov    $0xa,%ecx
  10081c:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10081f:	55                   	push   %ebp
  100820:	68 a4 0a 10 00       	push   $0x100aa4
  100825:	eb 11                	jmp    100838 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  100827:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  10082a:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10082d:	55                   	push   %ebp
  10082e:	68 b8 0a 10 00       	push   $0x100ab8
  100833:	b9 10 00 00 00       	mov    $0x10,%ecx
  100838:	8d 44 24 40          	lea    0x40(%esp),%eax
  10083c:	e8 4d fe ff ff       	call   10068e <fill_numbuf>
  100841:	ba 01 00 00 00       	mov    $0x1,%edx
  100846:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10084a:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  10084c:	59                   	pop    %ecx
  10084d:	59                   	pop    %ecx
  10084e:	eb 69                	jmp    1008b9 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  100850:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  100853:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100856:	55                   	push   %ebp
  100857:	68 a4 0a 10 00       	push   $0x100aa4
  10085c:	eb d5                	jmp    100833 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  10085e:	83 c3 04             	add    $0x4,%ebx
  100861:	8b 43 fc             	mov    -0x4(%ebx),%eax
  100864:	eb 40                	jmp    1008a6 <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  100866:	83 c3 04             	add    $0x4,%ebx
  100869:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10086c:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  100870:	e9 bd 01 00 00       	jmp    100a32 <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100875:	83 c3 04             	add    $0x4,%ebx
  100878:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  10087b:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  10087f:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100884:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100888:	88 44 24 24          	mov    %al,0x24(%esp)
  10088c:	eb 27                	jmp    1008b5 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  10088e:	84 c0                	test   %al,%al
  100890:	75 02                	jne    100894 <console_vprintf+0x1d9>
  100892:	b0 25                	mov    $0x25,%al
  100894:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100898:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  10089d:	80 3f 00             	cmpb   $0x0,(%edi)
  1008a0:	74 0a                	je     1008ac <console_vprintf+0x1f1>
  1008a2:	8d 44 24 24          	lea    0x24(%esp),%eax
  1008a6:	89 44 24 04          	mov    %eax,0x4(%esp)
  1008aa:	eb 09                	jmp    1008b5 <console_vprintf+0x1fa>
				format--;
  1008ac:	8d 54 24 24          	lea    0x24(%esp),%edx
  1008b0:	4f                   	dec    %edi
  1008b1:	89 54 24 04          	mov    %edx,0x4(%esp)
  1008b5:	31 d2                	xor    %edx,%edx
  1008b7:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1008b9:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  1008bb:	83 fd ff             	cmp    $0xffffffff,%ebp
  1008be:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1008c5:	74 1f                	je     1008e6 <console_vprintf+0x22b>
  1008c7:	89 04 24             	mov    %eax,(%esp)
  1008ca:	eb 01                	jmp    1008cd <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  1008cc:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1008cd:	39 e9                	cmp    %ebp,%ecx
  1008cf:	74 0a                	je     1008db <console_vprintf+0x220>
  1008d1:	8b 44 24 04          	mov    0x4(%esp),%eax
  1008d5:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  1008d9:	75 f1                	jne    1008cc <console_vprintf+0x211>
  1008db:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1008de:	89 0c 24             	mov    %ecx,(%esp)
  1008e1:	eb 1f                	jmp    100902 <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  1008e3:	42                   	inc    %edx
  1008e4:	eb 09                	jmp    1008ef <console_vprintf+0x234>
  1008e6:	89 d1                	mov    %edx,%ecx
  1008e8:	8b 14 24             	mov    (%esp),%edx
  1008eb:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1008ef:	8b 44 24 04          	mov    0x4(%esp),%eax
  1008f3:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  1008f7:	75 ea                	jne    1008e3 <console_vprintf+0x228>
  1008f9:	8b 44 24 08          	mov    0x8(%esp),%eax
  1008fd:	89 14 24             	mov    %edx,(%esp)
  100900:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  100902:	85 c0                	test   %eax,%eax
  100904:	74 0c                	je     100912 <console_vprintf+0x257>
  100906:	84 d2                	test   %dl,%dl
  100908:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  10090f:	00 
  100910:	75 24                	jne    100936 <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  100912:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  100917:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  10091e:	00 
  10091f:	75 15                	jne    100936 <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100921:	8b 44 24 14          	mov    0x14(%esp),%eax
  100925:	83 e0 08             	and    $0x8,%eax
  100928:	83 f8 01             	cmp    $0x1,%eax
  10092b:	19 c9                	sbb    %ecx,%ecx
  10092d:	f7 d1                	not    %ecx
  10092f:	83 e1 20             	and    $0x20,%ecx
  100932:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100936:	3b 2c 24             	cmp    (%esp),%ebp
  100939:	7e 0d                	jle    100948 <console_vprintf+0x28d>
  10093b:	84 d2                	test   %dl,%dl
  10093d:	74 40                	je     10097f <console_vprintf+0x2c4>
			zeros = precision - len;
  10093f:	2b 2c 24             	sub    (%esp),%ebp
  100942:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100946:	eb 3f                	jmp    100987 <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100948:	84 d2                	test   %dl,%dl
  10094a:	74 33                	je     10097f <console_vprintf+0x2c4>
  10094c:	8b 44 24 14          	mov    0x14(%esp),%eax
  100950:	83 e0 06             	and    $0x6,%eax
  100953:	83 f8 02             	cmp    $0x2,%eax
  100956:	75 27                	jne    10097f <console_vprintf+0x2c4>
  100958:	45                   	inc    %ebp
  100959:	75 24                	jne    10097f <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  10095b:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  10095d:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100960:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100965:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100968:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  10096b:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  10096f:	7d 0e                	jge    10097f <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100971:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100975:	29 ca                	sub    %ecx,%edx
  100977:	29 c2                	sub    %eax,%edx
  100979:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  10097d:	eb 08                	jmp    100987 <console_vprintf+0x2cc>
  10097f:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100986:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100987:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  10098b:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  10098d:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100991:	2b 2c 24             	sub    (%esp),%ebp
  100994:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100999:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  10099c:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  10099f:	29 c5                	sub    %eax,%ebp
  1009a1:	89 f0                	mov    %esi,%eax
  1009a3:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009a7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  1009ab:	eb 0f                	jmp    1009bc <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  1009ad:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009b1:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009b6:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  1009b7:	e8 83 fc ff ff       	call   10063f <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009bc:	85 ed                	test   %ebp,%ebp
  1009be:	7e 07                	jle    1009c7 <console_vprintf+0x30c>
  1009c0:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  1009c5:	74 e6                	je     1009ad <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  1009c7:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1009cc:	89 c6                	mov    %eax,%esi
  1009ce:	74 23                	je     1009f3 <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  1009d0:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  1009d5:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009d9:	e8 61 fc ff ff       	call   10063f <console_putc>
  1009de:	89 c6                	mov    %eax,%esi
  1009e0:	eb 11                	jmp    1009f3 <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  1009e2:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009e6:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  1009eb:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  1009ec:	e8 4e fc ff ff       	call   10063f <console_putc>
  1009f1:	eb 06                	jmp    1009f9 <console_vprintf+0x33e>
  1009f3:	89 f0                	mov    %esi,%eax
  1009f5:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  1009f9:	85 f6                	test   %esi,%esi
  1009fb:	7f e5                	jg     1009e2 <console_vprintf+0x327>
  1009fd:	8b 34 24             	mov    (%esp),%esi
  100a00:	eb 15                	jmp    100a17 <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100a02:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100a06:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100a07:	0f b6 11             	movzbl (%ecx),%edx
  100a0a:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a0e:	e8 2c fc ff ff       	call   10063f <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100a13:	ff 44 24 04          	incl   0x4(%esp)
  100a17:	85 f6                	test   %esi,%esi
  100a19:	7f e7                	jg     100a02 <console_vprintf+0x347>
  100a1b:	eb 0f                	jmp    100a2c <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100a1d:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a21:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a26:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a27:	e8 13 fc ff ff       	call   10063f <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a2c:	85 ed                	test   %ebp,%ebp
  100a2e:	7f ed                	jg     100a1d <console_vprintf+0x362>
  100a30:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100a32:	47                   	inc    %edi
  100a33:	8a 17                	mov    (%edi),%dl
  100a35:	84 d2                	test   %dl,%dl
  100a37:	0f 85 96 fc ff ff    	jne    1006d3 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100a3d:	83 c4 38             	add    $0x38,%esp
  100a40:	89 f0                	mov    %esi,%eax
  100a42:	5b                   	pop    %ebx
  100a43:	5e                   	pop    %esi
  100a44:	5f                   	pop    %edi
  100a45:	5d                   	pop    %ebp
  100a46:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100a47:	81 e9 9c 0a 10 00    	sub    $0x100a9c,%ecx
  100a4d:	b8 01 00 00 00       	mov    $0x1,%eax
  100a52:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100a54:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100a55:	09 44 24 14          	or     %eax,0x14(%esp)
  100a59:	e9 aa fc ff ff       	jmp    100708 <console_vprintf+0x4d>

00100a5e <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100a5e:	8d 44 24 10          	lea    0x10(%esp),%eax
  100a62:	50                   	push   %eax
  100a63:	ff 74 24 10          	pushl  0x10(%esp)
  100a67:	ff 74 24 10          	pushl  0x10(%esp)
  100a6b:	ff 74 24 10          	pushl  0x10(%esp)
  100a6f:	e8 47 fc ff ff       	call   1006bb <console_vprintf>
  100a74:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100a77:	c3                   	ret    
