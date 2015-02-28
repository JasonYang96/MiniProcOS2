
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
  100014:	e8 a5 01 00 00       	call   1001be <start>
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
  10006d:	e8 db 00 00 00       	call   10014d <interrupt>

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
  10009d:	83 ec 2c             	sub    $0x2c,%esp
	pid_t pid = current->p_pid;
  1000a0:	a1 20 7a 10 00       	mov    0x107a20,%eax
  1000a5:	8b 18                	mov    (%eax),%ebx
	int k = 0, index = 0;
	int priority[NPROCS];
	memset(priority, -1, sizeof(priority));
  1000a7:	6a 14                	push   $0x14
  1000a9:	6a ff                	push   $0xffffffff
  1000ab:	8d 44 24 18          	lea    0x18(%esp),%eax
  1000af:	50                   	push   %eax
  1000b0:	e8 5f 05 00 00       	call   100614 <memset>

	if (scheduling_algorithm == 0)
  1000b5:	8b 15 24 7a 10 00    	mov    0x107a24,%edx
  1000bb:	83 c4 10             	add    $0x10,%esp
  1000be:	85 d2                	test   %edx,%edx
  1000c0:	75 1e                	jne    1000e0 <schedule+0x44>
		while (1) {
			pid = (pid + 1) % NPROCS;
  1000c2:	b9 05 00 00 00       	mov    $0x5,%ecx
  1000c7:	8d 43 01             	lea    0x1(%ebx),%eax
  1000ca:	99                   	cltd   
  1000cb:	f7 f9                	idiv   %ecx

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000cd:	6b c2 54             	imul   $0x54,%edx,%eax
	int priority[NPROCS];
	memset(priority, -1, sizeof(priority));

	if (scheduling_algorithm == 0)
		while (1) {
			pid = (pid + 1) % NPROCS;
  1000d0:	89 d3                	mov    %edx,%ebx

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000d2:	83 b8 5c 70 10 00 01 	cmpl   $0x1,0x10705c(%eax)
  1000d9:	75 ec                	jne    1000c7 <schedule+0x2b>
				run(&proc_array[pid]);
  1000db:	83 ec 0c             	sub    $0xc,%esp
  1000de:	eb 42                	jmp    100122 <schedule+0x86>
		}

	if (scheduling_algorithm == 1)
  1000e0:	83 fa 01             	cmp    $0x1,%edx
  1000e3:	75 48                	jne    10012d <schedule+0x91>
	{
		//run highest priority first based on pid
		for (pid = 0; pid < NPROCS; pid++)
		{
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000e5:	31 c0                	xor    %eax,%eax
  1000e7:	83 3d 5c 70 10 00 01 	cmpl   $0x1,0x10705c
  1000ee:	74 2c                	je     10011c <schedule+0x80>
  1000f0:	83 3d b0 70 10 00 01 	cmpl   $0x1,0x1070b0
  1000f7:	b0 01                	mov    $0x1,%al
  1000f9:	74 21                	je     10011c <schedule+0x80>
  1000fb:	83 3d 04 71 10 00 01 	cmpl   $0x1,0x107104
  100102:	b0 02                	mov    $0x2,%al
  100104:	74 16                	je     10011c <schedule+0x80>
  100106:	83 3d 58 71 10 00 01 	cmpl   $0x1,0x107158
  10010d:	b0 03                	mov    $0x3,%al
  10010f:	74 0b                	je     10011c <schedule+0x80>
  100111:	83 3d ac 71 10 00 01 	cmpl   $0x1,0x1071ac
  100118:	75 13                	jne    10012d <schedule+0x91>
  10011a:	b0 04                	mov    $0x4,%al
				run(&proc_array[pid]);
  10011c:	6b c0 54             	imul   $0x54,%eax,%eax
  10011f:	83 ec 0c             	sub    $0xc,%esp
  100122:	05 14 70 10 00       	add    $0x107014,%eax
  100127:	50                   	push   %eax
  100128:	e8 a4 03 00 00       	call   1004d1 <run>
		}
	}


	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  10012d:	a1 00 80 19 00       	mov    0x198000,%eax
  100132:	52                   	push   %edx
  100133:	68 90 0a 10 00       	push   $0x100a90
  100138:	68 00 01 00 00       	push   $0x100
  10013d:	50                   	push   %eax
  10013e:	e8 33 09 00 00       	call   100a76 <console_printf>
  100143:	83 c4 10             	add    $0x10,%esp
  100146:	a3 00 80 19 00       	mov    %eax,0x198000
  10014b:	eb fe                	jmp    10014b <schedule+0xaf>

0010014d <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  10014d:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  10014e:	a1 20 7a 10 00       	mov    0x107a20,%eax
  100153:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  100158:	56                   	push   %esi
  100159:	53                   	push   %ebx
  10015a:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  10015e:	8d 78 04             	lea    0x4(%eax),%edi
  100161:	89 de                	mov    %ebx,%esi
  100163:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  100165:	8b 53 28             	mov    0x28(%ebx),%edx
  100168:	83 fa 31             	cmp    $0x31,%edx
  10016b:	74 1f                	je     10018c <interrupt+0x3f>
  10016d:	77 0c                	ja     10017b <interrupt+0x2e>
  10016f:	83 fa 20             	cmp    $0x20,%edx
  100172:	74 43                	je     1001b7 <interrupt+0x6a>
  100174:	83 fa 30             	cmp    $0x30,%edx
  100177:	74 0e                	je     100187 <interrupt+0x3a>
  100179:	eb 41                	jmp    1001bc <interrupt+0x6f>
  10017b:	83 fa 32             	cmp    $0x32,%edx
  10017e:	74 23                	je     1001a3 <interrupt+0x56>
  100180:	83 fa 33             	cmp    $0x33,%edx
  100183:	74 29                	je     1001ae <interrupt+0x61>
  100185:	eb 35                	jmp    1001bc <interrupt+0x6f>

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  100187:	e8 10 ff ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  10018c:	a1 20 7a 10 00       	mov    0x107a20,%eax
		current->p_exit_status = reg->reg_eax;
  100191:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100194:	c7 40 48 03 00 00 00 	movl   $0x3,0x48(%eax)
		current->p_exit_status = reg->reg_eax;
  10019b:	89 50 4c             	mov    %edx,0x4c(%eax)
		schedule();
  10019e:	e8 f9 fe ff ff       	call   10009c <schedule>

	case INT_SYS_PRIORITY:
		// The 'sys_priority' system call initializes the p_priority var
		// of a process.
		current->p_priority = reg->reg_eax;
  1001a3:	a1 20 7a 10 00       	mov    0x107a20,%eax
  1001a8:	8b 53 1c             	mov    0x1c(%ebx),%edx
  1001ab:	89 50 50             	mov    %edx,0x50(%eax)
		run(current);

	case INT_SYS_USER2:
		/* Your code here (if you want). */
		run(current);
  1001ae:	83 ec 0c             	sub    $0xc,%esp
  1001b1:	50                   	push   %eax
  1001b2:	e8 1a 03 00 00       	call   1004d1 <run>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  1001b7:	e8 e0 fe ff ff       	call   10009c <schedule>
  1001bc:	eb fe                	jmp    1001bc <interrupt+0x6f>

001001be <start>:
 *
 *****************************************************************************/

void
start(void)
{
  1001be:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1001bf:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  1001c4:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1001c5:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  1001c7:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1001c8:	bb 68 70 10 00       	mov    $0x107068,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  1001cd:	e8 de 00 00 00       	call   1002b0 <segments_init>
	interrupt_controller_init(0);
  1001d2:	83 ec 0c             	sub    $0xc,%esp
  1001d5:	6a 00                	push   $0x0
  1001d7:	e8 cf 01 00 00       	call   1003ab <interrupt_controller_init>
	console_clear();
  1001dc:	e8 53 02 00 00       	call   100434 <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  1001e1:	83 c4 0c             	add    $0xc,%esp
  1001e4:	68 a4 01 00 00       	push   $0x1a4
  1001e9:	6a 00                	push   $0x0
  1001eb:	68 14 70 10 00       	push   $0x107014
  1001f0:	e8 1f 04 00 00       	call   100614 <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1001f5:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1001f8:	c7 05 14 70 10 00 00 	movl   $0x0,0x107014
  1001ff:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100202:	c7 05 5c 70 10 00 00 	movl   $0x0,0x10705c
  100209:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10020c:	c7 05 68 70 10 00 01 	movl   $0x1,0x107068
  100213:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100216:	c7 05 b0 70 10 00 00 	movl   $0x0,0x1070b0
  10021d:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100220:	c7 05 bc 70 10 00 02 	movl   $0x2,0x1070bc
  100227:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10022a:	c7 05 04 71 10 00 00 	movl   $0x0,0x107104
  100231:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100234:	c7 05 10 71 10 00 03 	movl   $0x3,0x107110
  10023b:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10023e:	c7 05 58 71 10 00 00 	movl   $0x0,0x107158
  100245:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100248:	c7 05 64 71 10 00 04 	movl   $0x4,0x107164
  10024f:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100252:	c7 05 ac 71 10 00 00 	movl   $0x0,0x1071ac
  100259:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  10025c:	83 ec 0c             	sub    $0xc,%esp
  10025f:	53                   	push   %ebx
  100260:	e8 83 02 00 00       	call   1004e8 <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100265:	58                   	pop    %eax
  100266:	5a                   	pop    %edx
  100267:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  10026a:	89 7b 40             	mov    %edi,0x40(%ebx)

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  10026d:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100273:	50                   	push   %eax
  100274:	56                   	push   %esi

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100275:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100276:	e8 a9 02 00 00       	call   100524 <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  10027b:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  10027e:	c7 43 48 01 00 00 00 	movl   $0x1,0x48(%ebx)
  100285:	83 c3 54             	add    $0x54,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100288:	83 fe 04             	cmp    $0x4,%esi
  10028b:	75 cf                	jne    10025c <start+0x9e>

	// Initialize the scheduling algorithm.
	scheduling_algorithm = 1;

	// Switch to the first process.
	run(&proc_array[1]);
  10028d:	83 ec 0c             	sub    $0xc,%esp
  100290:	68 68 70 10 00       	push   $0x107068
		proc->p_state = P_RUNNABLE;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  100295:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  10029c:	80 0b 00 

	// Initialize the scheduling algorithm.
	scheduling_algorithm = 1;
  10029f:	c7 05 24 7a 10 00 01 	movl   $0x1,0x107a24
  1002a6:	00 00 00 

	// Switch to the first process.
	run(&proc_array[1]);
  1002a9:	e8 23 02 00 00       	call   1004d1 <run>
  1002ae:	90                   	nop
  1002af:	90                   	nop

001002b0 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002b0:	b8 b8 71 10 00       	mov    $0x1071b8,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002b5:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002ba:	89 c2                	mov    %eax,%edx
  1002bc:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  1002bf:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002c0:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  1002c5:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002c8:	66 a3 3a 10 10 00    	mov    %ax,0x10103a
  1002ce:	c1 e8 18             	shr    $0x18,%eax
  1002d1:	88 15 3c 10 10 00    	mov    %dl,0x10103c
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002d7:	ba 20 72 10 00       	mov    $0x107220,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002dc:	a2 3f 10 10 00       	mov    %al,0x10103f
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002e1:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002e3:	66 c7 05 38 10 10 00 	movw   $0x68,0x101038
  1002ea:	68 00 
  1002ec:	c6 05 3e 10 10 00 40 	movb   $0x40,0x10103e
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  1002f3:	c6 05 3d 10 10 00 89 	movb   $0x89,0x10103d

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  1002fa:	c7 05 bc 71 10 00 00 	movl   $0x180000,0x1071bc
  100301:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  100304:	66 c7 05 c0 71 10 00 	movw   $0x10,0x1071c0
  10030b:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10030d:	66 89 0c c5 20 72 10 	mov    %cx,0x107220(,%eax,8)
  100314:	00 
  100315:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  10031c:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100321:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  100326:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  10032b:	40                   	inc    %eax
  10032c:	3d 00 01 00 00       	cmp    $0x100,%eax
  100331:	75 da                	jne    10030d <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100333:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100338:	ba 20 72 10 00       	mov    $0x107220,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  10033d:	66 a3 20 73 10 00    	mov    %ax,0x107320
  100343:	c1 e8 10             	shr    $0x10,%eax
  100346:	66 a3 26 73 10 00    	mov    %ax,0x107326
  10034c:	b8 30 00 00 00       	mov    $0x30,%eax
  100351:	66 c7 05 22 73 10 00 	movw   $0x8,0x107322
  100358:	08 00 
  10035a:	c6 05 24 73 10 00 00 	movb   $0x0,0x107324
  100361:	c6 05 25 73 10 00 8e 	movb   $0x8e,0x107325

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100368:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  10036f:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100376:	66 89 0c c5 20 72 10 	mov    %cx,0x107220(,%eax,8)
  10037d:	00 
  10037e:	c1 e9 10             	shr    $0x10,%ecx
  100381:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100386:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  10038b:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  100390:	40                   	inc    %eax
  100391:	83 f8 3a             	cmp    $0x3a,%eax
  100394:	75 d2                	jne    100368 <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  100396:	b0 28                	mov    $0x28,%al
  100398:	0f 01 15 00 10 10 00 	lgdtl  0x101000
  10039f:	0f 00 d8             	ltr    %ax
  1003a2:	0f 01 1d 08 10 10 00 	lidtl  0x101008
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  1003a9:	5b                   	pop    %ebx
  1003aa:	c3                   	ret    

001003ab <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  1003ab:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  1003ac:	b0 ff                	mov    $0xff,%al
  1003ae:	57                   	push   %edi
  1003af:	56                   	push   %esi
  1003b0:	53                   	push   %ebx
  1003b1:	bb 21 00 00 00       	mov    $0x21,%ebx
  1003b6:	89 da                	mov    %ebx,%edx
  1003b8:	ee                   	out    %al,(%dx)
  1003b9:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  1003be:	89 ca                	mov    %ecx,%edx
  1003c0:	ee                   	out    %al,(%dx)
  1003c1:	be 11 00 00 00       	mov    $0x11,%esi
  1003c6:	bf 20 00 00 00       	mov    $0x20,%edi
  1003cb:	89 f0                	mov    %esi,%eax
  1003cd:	89 fa                	mov    %edi,%edx
  1003cf:	ee                   	out    %al,(%dx)
  1003d0:	b0 20                	mov    $0x20,%al
  1003d2:	89 da                	mov    %ebx,%edx
  1003d4:	ee                   	out    %al,(%dx)
  1003d5:	b0 04                	mov    $0x4,%al
  1003d7:	ee                   	out    %al,(%dx)
  1003d8:	b0 03                	mov    $0x3,%al
  1003da:	ee                   	out    %al,(%dx)
  1003db:	bd a0 00 00 00       	mov    $0xa0,%ebp
  1003e0:	89 f0                	mov    %esi,%eax
  1003e2:	89 ea                	mov    %ebp,%edx
  1003e4:	ee                   	out    %al,(%dx)
  1003e5:	b0 28                	mov    $0x28,%al
  1003e7:	89 ca                	mov    %ecx,%edx
  1003e9:	ee                   	out    %al,(%dx)
  1003ea:	b0 02                	mov    $0x2,%al
  1003ec:	ee                   	out    %al,(%dx)
  1003ed:	b0 01                	mov    $0x1,%al
  1003ef:	ee                   	out    %al,(%dx)
  1003f0:	b0 68                	mov    $0x68,%al
  1003f2:	89 fa                	mov    %edi,%edx
  1003f4:	ee                   	out    %al,(%dx)
  1003f5:	be 0a 00 00 00       	mov    $0xa,%esi
  1003fa:	89 f0                	mov    %esi,%eax
  1003fc:	ee                   	out    %al,(%dx)
  1003fd:	b0 68                	mov    $0x68,%al
  1003ff:	89 ea                	mov    %ebp,%edx
  100401:	ee                   	out    %al,(%dx)
  100402:	89 f0                	mov    %esi,%eax
  100404:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  100405:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  10040a:	89 da                	mov    %ebx,%edx
  10040c:	19 c0                	sbb    %eax,%eax
  10040e:	f7 d0                	not    %eax
  100410:	05 ff 00 00 00       	add    $0xff,%eax
  100415:	ee                   	out    %al,(%dx)
  100416:	b0 ff                	mov    $0xff,%al
  100418:	89 ca                	mov    %ecx,%edx
  10041a:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  10041b:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  100420:	74 0d                	je     10042f <interrupt_controller_init+0x84>
  100422:	b2 43                	mov    $0x43,%dl
  100424:	b0 34                	mov    $0x34,%al
  100426:	ee                   	out    %al,(%dx)
  100427:	b0 9c                	mov    $0x9c,%al
  100429:	b2 40                	mov    $0x40,%dl
  10042b:	ee                   	out    %al,(%dx)
  10042c:	b0 2e                	mov    $0x2e,%al
  10042e:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  10042f:	5b                   	pop    %ebx
  100430:	5e                   	pop    %esi
  100431:	5f                   	pop    %edi
  100432:	5d                   	pop    %ebp
  100433:	c3                   	ret    

00100434 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  100434:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100435:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  100437:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100438:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  10043f:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  100442:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100448:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  10044e:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  100451:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  100456:	75 ea                	jne    100442 <console_clear+0xe>
  100458:	be d4 03 00 00       	mov    $0x3d4,%esi
  10045d:	b0 0e                	mov    $0xe,%al
  10045f:	89 f2                	mov    %esi,%edx
  100461:	ee                   	out    %al,(%dx)
  100462:	31 c9                	xor    %ecx,%ecx
  100464:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  100469:	88 c8                	mov    %cl,%al
  10046b:	89 da                	mov    %ebx,%edx
  10046d:	ee                   	out    %al,(%dx)
  10046e:	b0 0f                	mov    $0xf,%al
  100470:	89 f2                	mov    %esi,%edx
  100472:	ee                   	out    %al,(%dx)
  100473:	88 c8                	mov    %cl,%al
  100475:	89 da                	mov    %ebx,%edx
  100477:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  100478:	5b                   	pop    %ebx
  100479:	5e                   	pop    %esi
  10047a:	c3                   	ret    

0010047b <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  10047b:	ba 64 00 00 00       	mov    $0x64,%edx
  100480:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  100481:	a8 01                	test   $0x1,%al
  100483:	74 45                	je     1004ca <console_read_digit+0x4f>
  100485:	b2 60                	mov    $0x60,%dl
  100487:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  100488:	8d 50 fe             	lea    -0x2(%eax),%edx
  10048b:	80 fa 08             	cmp    $0x8,%dl
  10048e:	77 05                	ja     100495 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  100490:	0f b6 c0             	movzbl %al,%eax
  100493:	48                   	dec    %eax
  100494:	c3                   	ret    
	else if (data == 0x0B)
  100495:	3c 0b                	cmp    $0xb,%al
  100497:	74 35                	je     1004ce <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  100499:	8d 50 b9             	lea    -0x47(%eax),%edx
  10049c:	80 fa 02             	cmp    $0x2,%dl
  10049f:	77 07                	ja     1004a8 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  1004a1:	0f b6 c0             	movzbl %al,%eax
  1004a4:	83 e8 40             	sub    $0x40,%eax
  1004a7:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  1004a8:	8d 50 b5             	lea    -0x4b(%eax),%edx
  1004ab:	80 fa 02             	cmp    $0x2,%dl
  1004ae:	77 07                	ja     1004b7 <console_read_digit+0x3c>
		return data - 0x4B + 4;
  1004b0:	0f b6 c0             	movzbl %al,%eax
  1004b3:	83 e8 47             	sub    $0x47,%eax
  1004b6:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  1004b7:	8d 50 b1             	lea    -0x4f(%eax),%edx
  1004ba:	80 fa 02             	cmp    $0x2,%dl
  1004bd:	77 07                	ja     1004c6 <console_read_digit+0x4b>
		return data - 0x4F + 1;
  1004bf:	0f b6 c0             	movzbl %al,%eax
  1004c2:	83 e8 4e             	sub    $0x4e,%eax
  1004c5:	c3                   	ret    
	else if (data == 0x53)
  1004c6:	3c 53                	cmp    $0x53,%al
  1004c8:	74 04                	je     1004ce <console_read_digit+0x53>
  1004ca:	83 c8 ff             	or     $0xffffffff,%eax
  1004cd:	c3                   	ret    
  1004ce:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  1004d0:	c3                   	ret    

001004d1 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  1004d1:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  1004d5:	a3 20 7a 10 00       	mov    %eax,0x107a20

	asm volatile("movl %0,%%esp\n\t"
  1004da:	83 c0 04             	add    $0x4,%eax
  1004dd:	89 c4                	mov    %eax,%esp
  1004df:	61                   	popa   
  1004e0:	07                   	pop    %es
  1004e1:	1f                   	pop    %ds
  1004e2:	83 c4 08             	add    $0x8,%esp
  1004e5:	cf                   	iret   
  1004e6:	eb fe                	jmp    1004e6 <run+0x15>

001004e8 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  1004e8:	53                   	push   %ebx
  1004e9:	83 ec 0c             	sub    $0xc,%esp
  1004ec:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  1004f0:	6a 44                	push   $0x44
  1004f2:	6a 00                	push   $0x0
  1004f4:	8d 43 04             	lea    0x4(%ebx),%eax
  1004f7:	50                   	push   %eax
  1004f8:	e8 17 01 00 00       	call   100614 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  1004fd:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  100503:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  100509:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  10050f:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  100515:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  10051c:	83 c4 18             	add    $0x18,%esp
  10051f:	5b                   	pop    %ebx
  100520:	c3                   	ret    
  100521:	90                   	nop
  100522:	90                   	nop
  100523:	90                   	nop

00100524 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  100524:	55                   	push   %ebp
  100525:	57                   	push   %edi
  100526:	56                   	push   %esi
  100527:	53                   	push   %ebx
  100528:	83 ec 1c             	sub    $0x1c,%esp
  10052b:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  10052f:	83 f8 03             	cmp    $0x3,%eax
  100532:	7f 04                	jg     100538 <program_loader+0x14>
  100534:	85 c0                	test   %eax,%eax
  100536:	79 02                	jns    10053a <program_loader+0x16>
  100538:	eb fe                	jmp    100538 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  10053a:	8b 34 c5 40 10 10 00 	mov    0x101040(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  100541:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  100547:	74 02                	je     10054b <program_loader+0x27>
  100549:	eb fe                	jmp    100549 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10054b:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  10054e:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100552:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  100554:	c1 e5 05             	shl    $0x5,%ebp
  100557:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  10055a:	eb 3f                	jmp    10059b <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  10055c:	83 3b 01             	cmpl   $0x1,(%ebx)
  10055f:	75 37                	jne    100598 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  100561:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100564:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  100567:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  10056a:	01 c7                	add    %eax,%edi
	memsz += va;
  10056c:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  10056e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  100573:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  100577:	52                   	push   %edx
  100578:	89 fa                	mov    %edi,%edx
  10057a:	29 c2                	sub    %eax,%edx
  10057c:	52                   	push   %edx
  10057d:	8b 53 04             	mov    0x4(%ebx),%edx
  100580:	01 f2                	add    %esi,%edx
  100582:	52                   	push   %edx
  100583:	50                   	push   %eax
  100584:	e8 27 00 00 00       	call   1005b0 <memcpy>
  100589:	83 c4 10             	add    $0x10,%esp
  10058c:	eb 04                	jmp    100592 <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  10058e:	c6 07 00             	movb   $0x0,(%edi)
  100591:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  100592:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  100596:	72 f6                	jb     10058e <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  100598:	83 c3 20             	add    $0x20,%ebx
  10059b:	39 eb                	cmp    %ebp,%ebx
  10059d:	72 bd                	jb     10055c <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  10059f:	8b 56 18             	mov    0x18(%esi),%edx
  1005a2:	8b 44 24 34          	mov    0x34(%esp),%eax
  1005a6:	89 10                	mov    %edx,(%eax)
}
  1005a8:	83 c4 1c             	add    $0x1c,%esp
  1005ab:	5b                   	pop    %ebx
  1005ac:	5e                   	pop    %esi
  1005ad:	5f                   	pop    %edi
  1005ae:	5d                   	pop    %ebp
  1005af:	c3                   	ret    

001005b0 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  1005b0:	56                   	push   %esi
  1005b1:	31 d2                	xor    %edx,%edx
  1005b3:	53                   	push   %ebx
  1005b4:	8b 44 24 0c          	mov    0xc(%esp),%eax
  1005b8:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  1005bc:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1005c0:	eb 08                	jmp    1005ca <memcpy+0x1a>
		*d++ = *s++;
  1005c2:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  1005c5:	4e                   	dec    %esi
  1005c6:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  1005c9:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1005ca:	85 f6                	test   %esi,%esi
  1005cc:	75 f4                	jne    1005c2 <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  1005ce:	5b                   	pop    %ebx
  1005cf:	5e                   	pop    %esi
  1005d0:	c3                   	ret    

001005d1 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  1005d1:	57                   	push   %edi
  1005d2:	56                   	push   %esi
  1005d3:	53                   	push   %ebx
  1005d4:	8b 44 24 10          	mov    0x10(%esp),%eax
  1005d8:	8b 7c 24 14          	mov    0x14(%esp),%edi
  1005dc:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  1005e0:	39 c7                	cmp    %eax,%edi
  1005e2:	73 26                	jae    10060a <memmove+0x39>
  1005e4:	8d 34 17             	lea    (%edi,%edx,1),%esi
  1005e7:	39 c6                	cmp    %eax,%esi
  1005e9:	76 1f                	jbe    10060a <memmove+0x39>
		s += n, d += n;
  1005eb:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  1005ee:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  1005f0:	eb 07                	jmp    1005f9 <memmove+0x28>
			*--d = *--s;
  1005f2:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  1005f5:	4a                   	dec    %edx
  1005f6:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  1005f9:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  1005fa:	85 d2                	test   %edx,%edx
  1005fc:	75 f4                	jne    1005f2 <memmove+0x21>
  1005fe:	eb 10                	jmp    100610 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  100600:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  100603:	4a                   	dec    %edx
  100604:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  100607:	41                   	inc    %ecx
  100608:	eb 02                	jmp    10060c <memmove+0x3b>
  10060a:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  10060c:	85 d2                	test   %edx,%edx
  10060e:	75 f0                	jne    100600 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  100610:	5b                   	pop    %ebx
  100611:	5e                   	pop    %esi
  100612:	5f                   	pop    %edi
  100613:	c3                   	ret    

00100614 <memset>:

void *
memset(void *v, int c, size_t n)
{
  100614:	53                   	push   %ebx
  100615:	8b 44 24 08          	mov    0x8(%esp),%eax
  100619:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  10061d:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  100621:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  100623:	eb 04                	jmp    100629 <memset+0x15>
		*p++ = c;
  100625:	88 1a                	mov    %bl,(%edx)
  100627:	49                   	dec    %ecx
  100628:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  100629:	85 c9                	test   %ecx,%ecx
  10062b:	75 f8                	jne    100625 <memset+0x11>
		*p++ = c;
	return v;
}
  10062d:	5b                   	pop    %ebx
  10062e:	c3                   	ret    

0010062f <strlen>:

size_t
strlen(const char *s)
{
  10062f:	8b 54 24 04          	mov    0x4(%esp),%edx
  100633:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100635:	eb 01                	jmp    100638 <strlen+0x9>
		++n;
  100637:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100638:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  10063c:	75 f9                	jne    100637 <strlen+0x8>
		++n;
	return n;
}
  10063e:	c3                   	ret    

0010063f <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  10063f:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  100643:	31 c0                	xor    %eax,%eax
  100645:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100649:	eb 01                	jmp    10064c <strnlen+0xd>
		++n;
  10064b:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  10064c:	39 d0                	cmp    %edx,%eax
  10064e:	74 06                	je     100656 <strnlen+0x17>
  100650:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  100654:	75 f5                	jne    10064b <strnlen+0xc>
		++n;
	return n;
}
  100656:	c3                   	ret    

00100657 <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100657:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  100658:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  10065d:	53                   	push   %ebx
  10065e:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  100660:	76 05                	jbe    100667 <console_putc+0x10>
  100662:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  100667:	80 fa 0a             	cmp    $0xa,%dl
  10066a:	75 2c                	jne    100698 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  10066c:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  100672:	be 50 00 00 00       	mov    $0x50,%esi
  100677:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  100679:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  10067c:	99                   	cltd   
  10067d:	f7 fe                	idiv   %esi
  10067f:	89 de                	mov    %ebx,%esi
  100681:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  100683:	eb 07                	jmp    10068c <console_putc+0x35>
			*cursor++ = ' ' | color;
  100685:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100688:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  100689:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  10068c:	83 f8 50             	cmp    $0x50,%eax
  10068f:	75 f4                	jne    100685 <console_putc+0x2e>
  100691:	29 d0                	sub    %edx,%eax
  100693:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  100696:	eb 0b                	jmp    1006a3 <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  100698:	0f b6 d2             	movzbl %dl,%edx
  10069b:	09 ca                	or     %ecx,%edx
  10069d:	66 89 13             	mov    %dx,(%ebx)
  1006a0:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  1006a3:	5b                   	pop    %ebx
  1006a4:	5e                   	pop    %esi
  1006a5:	c3                   	ret    

001006a6 <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  1006a6:	56                   	push   %esi
  1006a7:	53                   	push   %ebx
  1006a8:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  1006ac:	8d 58 ff             	lea    -0x1(%eax),%ebx
  1006af:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  1006b3:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  1006b8:	75 04                	jne    1006be <fill_numbuf+0x18>
  1006ba:	85 d2                	test   %edx,%edx
  1006bc:	74 10                	je     1006ce <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  1006be:	89 d0                	mov    %edx,%eax
  1006c0:	31 d2                	xor    %edx,%edx
  1006c2:	f7 f1                	div    %ecx
  1006c4:	4b                   	dec    %ebx
  1006c5:	8a 14 16             	mov    (%esi,%edx,1),%dl
  1006c8:	88 13                	mov    %dl,(%ebx)
			val /= base;
  1006ca:	89 c2                	mov    %eax,%edx
  1006cc:	eb ec                	jmp    1006ba <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  1006ce:	89 d8                	mov    %ebx,%eax
  1006d0:	5b                   	pop    %ebx
  1006d1:	5e                   	pop    %esi
  1006d2:	c3                   	ret    

001006d3 <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  1006d3:	55                   	push   %ebp
  1006d4:	57                   	push   %edi
  1006d5:	56                   	push   %esi
  1006d6:	53                   	push   %ebx
  1006d7:	83 ec 38             	sub    $0x38,%esp
  1006da:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  1006de:	8b 7c 24 54          	mov    0x54(%esp),%edi
  1006e2:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  1006e6:	e9 60 03 00 00       	jmp    100a4b <console_vprintf+0x378>
		if (*format != '%') {
  1006eb:	80 fa 25             	cmp    $0x25,%dl
  1006ee:	74 13                	je     100703 <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  1006f0:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1006f4:	0f b6 d2             	movzbl %dl,%edx
  1006f7:	89 f0                	mov    %esi,%eax
  1006f9:	e8 59 ff ff ff       	call   100657 <console_putc>
  1006fe:	e9 45 03 00 00       	jmp    100a48 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100703:	47                   	inc    %edi
  100704:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  10070b:	00 
  10070c:	eb 12                	jmp    100720 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  10070e:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  10070f:	8a 11                	mov    (%ecx),%dl
  100711:	84 d2                	test   %dl,%dl
  100713:	74 1a                	je     10072f <console_vprintf+0x5c>
  100715:	89 e8                	mov    %ebp,%eax
  100717:	38 c2                	cmp    %al,%dl
  100719:	75 f3                	jne    10070e <console_vprintf+0x3b>
  10071b:	e9 3f 03 00 00       	jmp    100a5f <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100720:	8a 17                	mov    (%edi),%dl
  100722:	84 d2                	test   %dl,%dl
  100724:	74 0b                	je     100731 <console_vprintf+0x5e>
  100726:	b9 b4 0a 10 00       	mov    $0x100ab4,%ecx
  10072b:	89 d5                	mov    %edx,%ebp
  10072d:	eb e0                	jmp    10070f <console_vprintf+0x3c>
  10072f:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  100731:	8d 42 cf             	lea    -0x31(%edx),%eax
  100734:	3c 08                	cmp    $0x8,%al
  100736:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  10073d:	00 
  10073e:	76 13                	jbe    100753 <console_vprintf+0x80>
  100740:	eb 1d                	jmp    10075f <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  100742:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  100747:	0f be c0             	movsbl %al,%eax
  10074a:	47                   	inc    %edi
  10074b:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  10074f:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  100753:	8a 07                	mov    (%edi),%al
  100755:	8d 50 d0             	lea    -0x30(%eax),%edx
  100758:	80 fa 09             	cmp    $0x9,%dl
  10075b:	76 e5                	jbe    100742 <console_vprintf+0x6f>
  10075d:	eb 18                	jmp    100777 <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  10075f:	80 fa 2a             	cmp    $0x2a,%dl
  100762:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  100769:	ff 
  10076a:	75 0b                	jne    100777 <console_vprintf+0xa4>
			width = va_arg(val, int);
  10076c:	83 c3 04             	add    $0x4,%ebx
			++format;
  10076f:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  100770:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100773:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  100777:	83 cd ff             	or     $0xffffffff,%ebp
  10077a:	80 3f 2e             	cmpb   $0x2e,(%edi)
  10077d:	75 37                	jne    1007b6 <console_vprintf+0xe3>
			++format;
  10077f:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  100780:	31 ed                	xor    %ebp,%ebp
  100782:	8a 07                	mov    (%edi),%al
  100784:	8d 50 d0             	lea    -0x30(%eax),%edx
  100787:	80 fa 09             	cmp    $0x9,%dl
  10078a:	76 0d                	jbe    100799 <console_vprintf+0xc6>
  10078c:	eb 17                	jmp    1007a5 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  10078e:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  100791:	0f be c0             	movsbl %al,%eax
  100794:	47                   	inc    %edi
  100795:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  100799:	8a 07                	mov    (%edi),%al
  10079b:	8d 50 d0             	lea    -0x30(%eax),%edx
  10079e:	80 fa 09             	cmp    $0x9,%dl
  1007a1:	76 eb                	jbe    10078e <console_vprintf+0xbb>
  1007a3:	eb 11                	jmp    1007b6 <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  1007a5:	3c 2a                	cmp    $0x2a,%al
  1007a7:	75 0b                	jne    1007b4 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  1007a9:	83 c3 04             	add    $0x4,%ebx
				++format;
  1007ac:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  1007ad:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  1007b0:	85 ed                	test   %ebp,%ebp
  1007b2:	79 02                	jns    1007b6 <console_vprintf+0xe3>
  1007b4:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  1007b6:	8a 07                	mov    (%edi),%al
  1007b8:	3c 64                	cmp    $0x64,%al
  1007ba:	74 34                	je     1007f0 <console_vprintf+0x11d>
  1007bc:	7f 1d                	jg     1007db <console_vprintf+0x108>
  1007be:	3c 58                	cmp    $0x58,%al
  1007c0:	0f 84 a2 00 00 00    	je     100868 <console_vprintf+0x195>
  1007c6:	3c 63                	cmp    $0x63,%al
  1007c8:	0f 84 bf 00 00 00    	je     10088d <console_vprintf+0x1ba>
  1007ce:	3c 43                	cmp    $0x43,%al
  1007d0:	0f 85 d0 00 00 00    	jne    1008a6 <console_vprintf+0x1d3>
  1007d6:	e9 a3 00 00 00       	jmp    10087e <console_vprintf+0x1ab>
  1007db:	3c 75                	cmp    $0x75,%al
  1007dd:	74 4d                	je     10082c <console_vprintf+0x159>
  1007df:	3c 78                	cmp    $0x78,%al
  1007e1:	74 5c                	je     10083f <console_vprintf+0x16c>
  1007e3:	3c 73                	cmp    $0x73,%al
  1007e5:	0f 85 bb 00 00 00    	jne    1008a6 <console_vprintf+0x1d3>
  1007eb:	e9 86 00 00 00       	jmp    100876 <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  1007f0:	83 c3 04             	add    $0x4,%ebx
  1007f3:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  1007f6:	89 d1                	mov    %edx,%ecx
  1007f8:	c1 f9 1f             	sar    $0x1f,%ecx
  1007fb:	89 0c 24             	mov    %ecx,(%esp)
  1007fe:	31 ca                	xor    %ecx,%edx
  100800:	55                   	push   %ebp
  100801:	29 ca                	sub    %ecx,%edx
  100803:	68 bc 0a 10 00       	push   $0x100abc
  100808:	b9 0a 00 00 00       	mov    $0xa,%ecx
  10080d:	8d 44 24 40          	lea    0x40(%esp),%eax
  100811:	e8 90 fe ff ff       	call   1006a6 <fill_numbuf>
  100816:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  10081a:	58                   	pop    %eax
  10081b:	5a                   	pop    %edx
  10081c:	ba 01 00 00 00       	mov    $0x1,%edx
  100821:	8b 04 24             	mov    (%esp),%eax
  100824:	83 e0 01             	and    $0x1,%eax
  100827:	e9 a5 00 00 00       	jmp    1008d1 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  10082c:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  10082f:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100834:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100837:	55                   	push   %ebp
  100838:	68 bc 0a 10 00       	push   $0x100abc
  10083d:	eb 11                	jmp    100850 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  10083f:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  100842:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100845:	55                   	push   %ebp
  100846:	68 d0 0a 10 00       	push   $0x100ad0
  10084b:	b9 10 00 00 00       	mov    $0x10,%ecx
  100850:	8d 44 24 40          	lea    0x40(%esp),%eax
  100854:	e8 4d fe ff ff       	call   1006a6 <fill_numbuf>
  100859:	ba 01 00 00 00       	mov    $0x1,%edx
  10085e:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100862:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  100864:	59                   	pop    %ecx
  100865:	59                   	pop    %ecx
  100866:	eb 69                	jmp    1008d1 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  100868:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  10086b:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10086e:	55                   	push   %ebp
  10086f:	68 bc 0a 10 00       	push   $0x100abc
  100874:	eb d5                	jmp    10084b <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  100876:	83 c3 04             	add    $0x4,%ebx
  100879:	8b 43 fc             	mov    -0x4(%ebx),%eax
  10087c:	eb 40                	jmp    1008be <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  10087e:	83 c3 04             	add    $0x4,%ebx
  100881:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100884:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  100888:	e9 bd 01 00 00       	jmp    100a4a <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  10088d:	83 c3 04             	add    $0x4,%ebx
  100890:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  100893:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  100897:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  10089c:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  1008a0:	88 44 24 24          	mov    %al,0x24(%esp)
  1008a4:	eb 27                	jmp    1008cd <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  1008a6:	84 c0                	test   %al,%al
  1008a8:	75 02                	jne    1008ac <console_vprintf+0x1d9>
  1008aa:	b0 25                	mov    $0x25,%al
  1008ac:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  1008b0:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  1008b5:	80 3f 00             	cmpb   $0x0,(%edi)
  1008b8:	74 0a                	je     1008c4 <console_vprintf+0x1f1>
  1008ba:	8d 44 24 24          	lea    0x24(%esp),%eax
  1008be:	89 44 24 04          	mov    %eax,0x4(%esp)
  1008c2:	eb 09                	jmp    1008cd <console_vprintf+0x1fa>
				format--;
  1008c4:	8d 54 24 24          	lea    0x24(%esp),%edx
  1008c8:	4f                   	dec    %edi
  1008c9:	89 54 24 04          	mov    %edx,0x4(%esp)
  1008cd:	31 d2                	xor    %edx,%edx
  1008cf:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1008d1:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  1008d3:	83 fd ff             	cmp    $0xffffffff,%ebp
  1008d6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1008dd:	74 1f                	je     1008fe <console_vprintf+0x22b>
  1008df:	89 04 24             	mov    %eax,(%esp)
  1008e2:	eb 01                	jmp    1008e5 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  1008e4:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1008e5:	39 e9                	cmp    %ebp,%ecx
  1008e7:	74 0a                	je     1008f3 <console_vprintf+0x220>
  1008e9:	8b 44 24 04          	mov    0x4(%esp),%eax
  1008ed:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  1008f1:	75 f1                	jne    1008e4 <console_vprintf+0x211>
  1008f3:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1008f6:	89 0c 24             	mov    %ecx,(%esp)
  1008f9:	eb 1f                	jmp    10091a <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  1008fb:	42                   	inc    %edx
  1008fc:	eb 09                	jmp    100907 <console_vprintf+0x234>
  1008fe:	89 d1                	mov    %edx,%ecx
  100900:	8b 14 24             	mov    (%esp),%edx
  100903:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100907:	8b 44 24 04          	mov    0x4(%esp),%eax
  10090b:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  10090f:	75 ea                	jne    1008fb <console_vprintf+0x228>
  100911:	8b 44 24 08          	mov    0x8(%esp),%eax
  100915:	89 14 24             	mov    %edx,(%esp)
  100918:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  10091a:	85 c0                	test   %eax,%eax
  10091c:	74 0c                	je     10092a <console_vprintf+0x257>
  10091e:	84 d2                	test   %dl,%dl
  100920:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  100927:	00 
  100928:	75 24                	jne    10094e <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  10092a:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  10092f:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  100936:	00 
  100937:	75 15                	jne    10094e <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100939:	8b 44 24 14          	mov    0x14(%esp),%eax
  10093d:	83 e0 08             	and    $0x8,%eax
  100940:	83 f8 01             	cmp    $0x1,%eax
  100943:	19 c9                	sbb    %ecx,%ecx
  100945:	f7 d1                	not    %ecx
  100947:	83 e1 20             	and    $0x20,%ecx
  10094a:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  10094e:	3b 2c 24             	cmp    (%esp),%ebp
  100951:	7e 0d                	jle    100960 <console_vprintf+0x28d>
  100953:	84 d2                	test   %dl,%dl
  100955:	74 40                	je     100997 <console_vprintf+0x2c4>
			zeros = precision - len;
  100957:	2b 2c 24             	sub    (%esp),%ebp
  10095a:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  10095e:	eb 3f                	jmp    10099f <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100960:	84 d2                	test   %dl,%dl
  100962:	74 33                	je     100997 <console_vprintf+0x2c4>
  100964:	8b 44 24 14          	mov    0x14(%esp),%eax
  100968:	83 e0 06             	and    $0x6,%eax
  10096b:	83 f8 02             	cmp    $0x2,%eax
  10096e:	75 27                	jne    100997 <console_vprintf+0x2c4>
  100970:	45                   	inc    %ebp
  100971:	75 24                	jne    100997 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  100973:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100975:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100978:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  10097d:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100980:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100983:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100987:	7d 0e                	jge    100997 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100989:	8b 54 24 0c          	mov    0xc(%esp),%edx
  10098d:	29 ca                	sub    %ecx,%edx
  10098f:	29 c2                	sub    %eax,%edx
  100991:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100995:	eb 08                	jmp    10099f <console_vprintf+0x2cc>
  100997:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  10099e:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  10099f:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  1009a3:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009a5:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  1009a9:	2b 2c 24             	sub    (%esp),%ebp
  1009ac:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1009b1:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009b4:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  1009b7:	29 c5                	sub    %eax,%ebp
  1009b9:	89 f0                	mov    %esi,%eax
  1009bb:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009bf:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  1009c3:	eb 0f                	jmp    1009d4 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  1009c5:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009c9:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009ce:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  1009cf:	e8 83 fc ff ff       	call   100657 <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009d4:	85 ed                	test   %ebp,%ebp
  1009d6:	7e 07                	jle    1009df <console_vprintf+0x30c>
  1009d8:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  1009dd:	74 e6                	je     1009c5 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  1009df:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1009e4:	89 c6                	mov    %eax,%esi
  1009e6:	74 23                	je     100a0b <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  1009e8:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  1009ed:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009f1:	e8 61 fc ff ff       	call   100657 <console_putc>
  1009f6:	89 c6                	mov    %eax,%esi
  1009f8:	eb 11                	jmp    100a0b <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  1009fa:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009fe:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100a03:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100a04:	e8 4e fc ff ff       	call   100657 <console_putc>
  100a09:	eb 06                	jmp    100a11 <console_vprintf+0x33e>
  100a0b:	89 f0                	mov    %esi,%eax
  100a0d:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100a11:	85 f6                	test   %esi,%esi
  100a13:	7f e5                	jg     1009fa <console_vprintf+0x327>
  100a15:	8b 34 24             	mov    (%esp),%esi
  100a18:	eb 15                	jmp    100a2f <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100a1a:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100a1e:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100a1f:	0f b6 11             	movzbl (%ecx),%edx
  100a22:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a26:	e8 2c fc ff ff       	call   100657 <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100a2b:	ff 44 24 04          	incl   0x4(%esp)
  100a2f:	85 f6                	test   %esi,%esi
  100a31:	7f e7                	jg     100a1a <console_vprintf+0x347>
  100a33:	eb 0f                	jmp    100a44 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100a35:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a39:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a3e:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a3f:	e8 13 fc ff ff       	call   100657 <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a44:	85 ed                	test   %ebp,%ebp
  100a46:	7f ed                	jg     100a35 <console_vprintf+0x362>
  100a48:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100a4a:	47                   	inc    %edi
  100a4b:	8a 17                	mov    (%edi),%dl
  100a4d:	84 d2                	test   %dl,%dl
  100a4f:	0f 85 96 fc ff ff    	jne    1006eb <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100a55:	83 c4 38             	add    $0x38,%esp
  100a58:	89 f0                	mov    %esi,%eax
  100a5a:	5b                   	pop    %ebx
  100a5b:	5e                   	pop    %esi
  100a5c:	5f                   	pop    %edi
  100a5d:	5d                   	pop    %ebp
  100a5e:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100a5f:	81 e9 b4 0a 10 00    	sub    $0x100ab4,%ecx
  100a65:	b8 01 00 00 00       	mov    $0x1,%eax
  100a6a:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100a6c:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100a6d:	09 44 24 14          	or     %eax,0x14(%esp)
  100a71:	e9 aa fc ff ff       	jmp    100720 <console_vprintf+0x4d>

00100a76 <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100a76:	8d 44 24 10          	lea    0x10(%esp),%eax
  100a7a:	50                   	push   %eax
  100a7b:	ff 74 24 10          	pushl  0x10(%esp)
  100a7f:	ff 74 24 10          	pushl  0x10(%esp)
  100a83:	ff 74 24 10          	pushl  0x10(%esp)
  100a87:	e8 47 fc ff ff       	call   1006d3 <console_vprintf>
  100a8c:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100a8f:	c3                   	ret    
