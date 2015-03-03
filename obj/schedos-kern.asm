
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
  100014:	e8 98 02 00 00       	call   1002b1 <start>
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
  10006d:	e8 aa 01 00 00       	call   10021c <interrupt>

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
  1000a1:	a1 24 84 10 00       	mov    0x108424,%eax
  1000a6:	8b 10                	mov    (%eax),%edx
	unsigned int priority = 0xffffffff;
	int index = 1;

	if (scheduling_algorithm == 0) //round robin scheduling
  1000a8:	a1 28 84 10 00       	mov    0x108428,%eax
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
  1000bc:	6b c2 5c             	imul   $0x5c,%edx,%eax
  1000bf:	83 b8 30 7a 10 00 01 	cmpl   $0x1,0x107a30(%eax)
  1000c6:	75 ee                	jne    1000b6 <schedule+0x1a>
  1000c8:	e9 c0 00 00 00       	jmp    10018d <schedule+0xf1>
				run(&proc_array[pid]);
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
  1000d7:	6b ca 5c             	imul   $0x5c,%edx,%ecx
  1000da:	83 b9 30 7a 10 00 01 	cmpl   $0x1,0x107a30(%ecx)
  1000e1:	75 11                	jne    1000f4 <schedule+0x58>
					run(&proc_array[pid]);
  1000e3:	6b c0 5c             	imul   $0x5c,%eax,%eax
  1000e6:	83 ec 0c             	sub    $0xc,%esp
  1000e9:	05 e8 79 10 00       	add    $0x1079e8,%eax
  1000ee:	50                   	push   %eax
  1000ef:	e8 e5 04 00 00       	call   1005d9 <run>
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
	{
		while (1) {
			//find lowest p_priority
			for (; index < NPROCS; index++)
			{
				if (proc_array[index].p_state == P_RUNNABLE &&
  100119:	6b c3 5c             	imul   $0x5c,%ebx,%eax
  10011c:	83 b8 30 7a 10 00 01 	cmpl   $0x1,0x107a30(%eax)
  100123:	75 0c                	jne    100131 <schedule+0x95>
  100125:	8b 80 38 7a 10 00    	mov    0x107a38(%eax),%eax
  10012b:	39 c6                	cmp    %eax,%esi
  10012d:	76 02                	jbe    100131 <schedule+0x95>
  10012f:	89 c6                	mov    %eax,%esi

	if (scheduling_algorithm == 2) //priority based on lowerst p_priority
	{
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
  100139:	6b c2 5c             	imul   $0x5c,%edx,%eax
  10013c:	83 b8 30 7a 10 00 01 	cmpl   $0x1,0x107a30(%eax)
  100143:	75 0f                	jne    100154 <schedule+0xb8>
  100145:	05 e8 79 10 00       	add    $0x1079e8,%eax
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
		}
	}

	if (scheduling_algorithm == 3) //priority based on highest share
  100161:	83 f8 03             	cmp    $0x3,%eax
  100164:	ba 01 00 00 00       	mov    $0x1,%edx
  100169:	75 5f                	jne    1001ca <schedule+0x12e>
  10016b:	eb 29                	jmp    100196 <schedule+0xfa>
	{
		while (1) {
			//for each proc, run until iterations == share
			for (pid = 1; pid < NPROCS; pid++)
			{
				if (proc_array[pid].p_state == P_RUNNABLE &&
  10016d:	6b c2 5c             	imul   $0x5c,%edx,%eax
  100170:	8d 88 f0 79 10 00    	lea    0x1079f0(%eax),%ecx
  100176:	83 79 40 01          	cmpl   $0x1,0x40(%ecx)
  10017a:	75 19                	jne    100195 <schedule+0xf9>
					proc_array[pid].p_iteration < proc_array[pid].p_share)
  10017c:	8d 59 50             	lea    0x50(%ecx),%ebx
  10017f:	8b 49 50             	mov    0x50(%ecx),%ecx
	{
		while (1) {
			//for each proc, run until iterations == share
			for (pid = 1; pid < NPROCS; pid++)
			{
				if (proc_array[pid].p_state == P_RUNNABLE &&
  100182:	3b 88 3c 7a 10 00    	cmp    0x107a3c(%eax),%ecx
  100188:	73 0b                	jae    100195 <schedule+0xf9>
					proc_array[pid].p_iteration < proc_array[pid].p_share)
				{
					proc_array[pid].p_iteration++;
  10018a:	41                   	inc    %ecx
  10018b:	89 0b                	mov    %ecx,(%ebx)
					run(&proc_array[pid]);
  10018d:	83 ec 0c             	sub    $0xc,%esp
  100190:	e9 54 ff ff ff       	jmp    1000e9 <schedule+0x4d>

	if (scheduling_algorithm == 3) //priority based on highest share
	{
		while (1) {
			//for each proc, run until iterations == share
			for (pid = 1; pid < NPROCS; pid++)
  100195:	42                   	inc    %edx
  100196:	83 fa 04             	cmp    $0x4,%edx
  100199:	7e d2                	jle    10016d <schedule+0xd1>
				}
			}
			//reset iterations
			for (pid = 1; pid < NPROCS; pid++)
			{
				proc_array[pid].p_iteration = 0;
  10019b:	c7 05 9c 7a 10 00 00 	movl   $0x0,0x107a9c
  1001a2:	00 00 00 
  1001a5:	ba 01 00 00 00       	mov    $0x1,%edx
  1001aa:	c7 05 f8 7a 10 00 00 	movl   $0x0,0x107af8
  1001b1:	00 00 00 
  1001b4:	c7 05 54 7b 10 00 00 	movl   $0x0,0x107b54
  1001bb:	00 00 00 
  1001be:	c7 05 b0 7b 10 00 00 	movl   $0x0,0x107bb0
  1001c5:	00 00 00 
  1001c8:	eb a3                	jmp    10016d <schedule+0xd1>
			}
		}
	}

	if (scheduling_algorithm == 4) //lottery scheduling
  1001ca:	83 f8 04             	cmp    $0x4,%eax
  1001cd:	75 2c                	jne    1001fb <schedule+0x15f>
	{
		while(1) {
			do {
				pid = rand()%NPROCS;
  1001cf:	bb 05 00 00 00       	mov    $0x5,%ebx
  1001d4:	e8 9a 05 00 00       	call   100773 <rand>
  1001d9:	99                   	cltd   
  1001da:	f7 fb                	idiv   %ebx
			} while (pid == 0);
  1001dc:	85 d2                	test   %edx,%edx
  1001de:	74 f4                	je     1001d4 <schedule+0x138>

			if (proc_array[pid].p_state == P_RUNNABLE)
  1001e0:	6b d2 5c             	imul   $0x5c,%edx,%edx
  1001e3:	83 ba 30 7a 10 00 01 	cmpl   $0x1,0x107a30(%edx)
  1001ea:	75 e8                	jne    1001d4 <schedule+0x138>
				run(&proc_array[pid]);
  1001ec:	83 ec 0c             	sub    $0xc,%esp
  1001ef:	81 c2 e8 79 10 00    	add    $0x1079e8,%edx
  1001f5:	52                   	push   %edx
  1001f6:	e9 f4 fe ff ff       	jmp    1000ef <schedule+0x53>
		}
	}


	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  1001fb:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100201:	50                   	push   %eax
  100202:	68 e4 0b 10 00       	push   $0x100be4
  100207:	68 00 01 00 00       	push   $0x100
  10020c:	52                   	push   %edx
  10020d:	e8 b7 09 00 00       	call   100bc9 <console_printf>
  100212:	83 c4 10             	add    $0x10,%esp
  100215:	a3 00 80 19 00       	mov    %eax,0x198000
  10021a:	eb fe                	jmp    10021a <schedule+0x17e>

0010021c <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  10021c:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  10021d:	a1 24 84 10 00       	mov    0x108424,%eax
  100222:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  100227:	56                   	push   %esi
  100228:	53                   	push   %ebx
  100229:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  10022d:	8d 78 04             	lea    0x4(%eax),%edi
  100230:	89 de                	mov    %ebx,%esi
  100232:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  100234:	8b 53 28             	mov    0x28(%ebx),%edx
  100237:	83 fa 32             	cmp    $0x32,%edx
  10023a:	74 3d                	je     100279 <interrupt+0x5d>
  10023c:	77 0e                	ja     10024c <interrupt+0x30>
  10023e:	83 fa 30             	cmp    $0x30,%edx
  100241:	74 15                	je     100258 <interrupt+0x3c>
  100243:	77 18                	ja     10025d <interrupt+0x41>
  100245:	83 fa 20             	cmp    $0x20,%edx
  100248:	74 2a                	je     100274 <interrupt+0x58>
  10024a:	eb 63                	jmp    1002af <interrupt+0x93>
  10024c:	83 fa 33             	cmp    $0x33,%edx
  10024f:	74 35                	je     100286 <interrupt+0x6a>
  100251:	83 fa 34             	cmp    $0x34,%edx
  100254:	74 42                	je     100298 <interrupt+0x7c>
  100256:	eb 57                	jmp    1002af <interrupt+0x93>

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  100258:	e8 3f fe ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  10025d:	a1 24 84 10 00       	mov    0x108424,%eax
		current->p_exit_status = reg->reg_eax;
  100262:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100265:	c7 40 48 03 00 00 00 	movl   $0x3,0x48(%eax)
		current->p_exit_status = reg->reg_eax;
  10026c:	89 50 4c             	mov    %edx,0x4c(%eax)
		schedule();
  10026f:	e8 28 fe ff ff       	call   10009c <schedule>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  100274:	e8 23 fe ff ff       	call   10009c <schedule>

	case INT_SYS_PRIORITY:
		//Set current process' priority.
		current->p_priority = reg->reg_eax;
  100279:	a1 24 84 10 00       	mov    0x108424,%eax
  10027e:	8b 53 1c             	mov    0x1c(%ebx),%edx
  100281:	89 50 50             	mov    %edx,0x50(%eax)
  100284:	eb 09                	jmp    10028f <interrupt+0x73>
		run(current);

	case INT_SYS_SHARE:
		//Set current process' share.
		current->p_share = reg->reg_eax;
  100286:	8b 53 1c             	mov    0x1c(%ebx),%edx
		current->p_iteration--;
  100289:	ff 48 58             	decl   0x58(%eax)
		current->p_priority = reg->reg_eax;
		run(current);

	case INT_SYS_SHARE:
		//Set current process' share.
		current->p_share = reg->reg_eax;
  10028c:	89 50 54             	mov    %edx,0x54(%eax)
		current->p_iteration--;
		run(current);
  10028f:	83 ec 0c             	sub    $0xc,%esp
  100292:	50                   	push   %eax
  100293:	e8 41 03 00 00       	call   1005d9 <run>

	case INT_SYS_PRINT:
		//print next char
		*cursorpos++ = reg->reg_eax;
  100298:	8b 15 00 80 19 00    	mov    0x198000,%edx
  10029e:	8b 4b 1c             	mov    0x1c(%ebx),%ecx
  1002a1:	66 89 0a             	mov    %cx,(%edx)
  1002a4:	83 c2 02             	add    $0x2,%edx
  1002a7:	89 15 00 80 19 00    	mov    %edx,0x198000
  1002ad:	eb e0                	jmp    10028f <interrupt+0x73>
  1002af:	eb fe                	jmp    1002af <interrupt+0x93>

001002b1 <start>:
 *
 *****************************************************************************/

void
start(void)
{
  1002b1:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1002b2:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  1002b7:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1002b8:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  1002ba:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1002bb:	bb 44 7a 10 00       	mov    $0x107a44,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  1002c0:	e8 f3 00 00 00       	call   1003b8 <segments_init>
	interrupt_controller_init(0);
  1002c5:	83 ec 0c             	sub    $0xc,%esp
  1002c8:	6a 00                	push   $0x0
  1002ca:	e8 e4 01 00 00       	call   1004b3 <interrupt_controller_init>
	console_clear();
  1002cf:	e8 68 02 00 00       	call   10053c <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  1002d4:	83 c4 0c             	add    $0xc,%esp
  1002d7:	68 cc 01 00 00       	push   $0x1cc
  1002dc:	6a 00                	push   $0x0
  1002de:	68 e8 79 10 00       	push   $0x1079e8
  1002e3:	e8 34 04 00 00       	call   10071c <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1002e8:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002eb:	c7 05 e8 79 10 00 00 	movl   $0x0,0x1079e8
  1002f2:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002f5:	c7 05 30 7a 10 00 00 	movl   $0x0,0x107a30
  1002fc:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002ff:	c7 05 44 7a 10 00 01 	movl   $0x1,0x107a44
  100306:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100309:	c7 05 8c 7a 10 00 00 	movl   $0x0,0x107a8c
  100310:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100313:	c7 05 a0 7a 10 00 02 	movl   $0x2,0x107aa0
  10031a:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10031d:	c7 05 e8 7a 10 00 00 	movl   $0x0,0x107ae8
  100324:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100327:	c7 05 fc 7a 10 00 03 	movl   $0x3,0x107afc
  10032e:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100331:	c7 05 44 7b 10 00 00 	movl   $0x0,0x107b44
  100338:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10033b:	c7 05 58 7b 10 00 04 	movl   $0x4,0x107b58
  100342:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100345:	c7 05 a0 7b 10 00 00 	movl   $0x0,0x107ba0
  10034c:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  10034f:	83 ec 0c             	sub    $0xc,%esp
  100352:	53                   	push   %ebx
  100353:	e8 98 02 00 00       	call   1005f0 <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100358:	58                   	pop    %eax
  100359:	5a                   	pop    %edx
  10035a:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  10035d:	89 7b 40             	mov    %edi,0x40(%ebx)
		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;

		proc->p_priority = 0;
		proc->p_share = 1;
		proc->p_iteration = 0;
  100360:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100366:	50                   	push   %eax
  100367:	56                   	push   %esi
		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;

		proc->p_priority = 0;
		proc->p_share = 1;
		proc->p_iteration = 0;
  100368:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100369:	e8 be 02 00 00       	call   10062c <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  10036e:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100371:	c7 43 48 01 00 00 00 	movl   $0x1,0x48(%ebx)

		proc->p_priority = 0;
  100378:	c7 43 50 00 00 00 00 	movl   $0x0,0x50(%ebx)
		proc->p_share = 1;
  10037f:	c7 43 54 01 00 00 00 	movl   $0x1,0x54(%ebx)
		proc->p_iteration = 0;
  100386:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  10038d:	83 c3 5c             	add    $0x5c,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100390:	83 fe 04             	cmp    $0x4,%esi
  100393:	75 ba                	jne    10034f <start+0x9e>

	// Initialize the scheduling algorithm.
	scheduling_algorithm = 4;

	// Switch to the first process.
	run(&proc_array[1]);
  100395:	83 ec 0c             	sub    $0xc,%esp
  100398:	68 44 7a 10 00       	push   $0x107a44
		proc->p_iteration = 0;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  10039d:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  1003a4:	80 0b 00 

	// Initialize the scheduling algorithm.
	scheduling_algorithm = 4;
  1003a7:	c7 05 28 84 10 00 04 	movl   $0x4,0x108428
  1003ae:	00 00 00 

	// Switch to the first process.
	run(&proc_array[1]);
  1003b1:	e8 23 02 00 00       	call   1005d9 <run>
  1003b6:	90                   	nop
  1003b7:	90                   	nop

001003b8 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003b8:	b8 b4 7b 10 00       	mov    $0x107bb4,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003bd:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003c2:	89 c2                	mov    %eax,%edx
  1003c4:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  1003c7:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003c8:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  1003cd:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003d0:	66 a3 3a 10 10 00    	mov    %ax,0x10103a
  1003d6:	c1 e8 18             	shr    $0x18,%eax
  1003d9:	88 15 3c 10 10 00    	mov    %dl,0x10103c
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003df:	ba 1c 7c 10 00       	mov    $0x107c1c,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003e4:	a2 3f 10 10 00       	mov    %al,0x10103f
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003e9:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003eb:	66 c7 05 38 10 10 00 	movw   $0x68,0x101038
  1003f2:	68 00 
  1003f4:	c6 05 3e 10 10 00 40 	movb   $0x40,0x10103e
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  1003fb:	c6 05 3d 10 10 00 89 	movb   $0x89,0x10103d

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  100402:	c7 05 b8 7b 10 00 00 	movl   $0x180000,0x107bb8
  100409:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  10040c:	66 c7 05 bc 7b 10 00 	movw   $0x10,0x107bbc
  100413:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100415:	66 89 0c c5 1c 7c 10 	mov    %cx,0x107c1c(,%eax,8)
  10041c:	00 
  10041d:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100424:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100429:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  10042e:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  100433:	40                   	inc    %eax
  100434:	3d 00 01 00 00       	cmp    $0x100,%eax
  100439:	75 da                	jne    100415 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  10043b:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100440:	ba 1c 7c 10 00       	mov    $0x107c1c,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100445:	66 a3 1c 7d 10 00    	mov    %ax,0x107d1c
  10044b:	c1 e8 10             	shr    $0x10,%eax
  10044e:	66 a3 22 7d 10 00    	mov    %ax,0x107d22
  100454:	b8 30 00 00 00       	mov    $0x30,%eax
  100459:	66 c7 05 1e 7d 10 00 	movw   $0x8,0x107d1e
  100460:	08 00 
  100462:	c6 05 20 7d 10 00 00 	movb   $0x0,0x107d20
  100469:	c6 05 21 7d 10 00 8e 	movb   $0x8e,0x107d21

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100470:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  100477:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  10047e:	66 89 0c c5 1c 7c 10 	mov    %cx,0x107c1c(,%eax,8)
  100485:	00 
  100486:	c1 e9 10             	shr    $0x10,%ecx
  100489:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  10048e:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  100493:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  100498:	40                   	inc    %eax
  100499:	83 f8 3a             	cmp    $0x3a,%eax
  10049c:	75 d2                	jne    100470 <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  10049e:	b0 28                	mov    $0x28,%al
  1004a0:	0f 01 15 00 10 10 00 	lgdtl  0x101000
  1004a7:	0f 00 d8             	ltr    %ax
  1004aa:	0f 01 1d 08 10 10 00 	lidtl  0x101008
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  1004b1:	5b                   	pop    %ebx
  1004b2:	c3                   	ret    

001004b3 <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  1004b3:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  1004b4:	b0 ff                	mov    $0xff,%al
  1004b6:	57                   	push   %edi
  1004b7:	56                   	push   %esi
  1004b8:	53                   	push   %ebx
  1004b9:	bb 21 00 00 00       	mov    $0x21,%ebx
  1004be:	89 da                	mov    %ebx,%edx
  1004c0:	ee                   	out    %al,(%dx)
  1004c1:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  1004c6:	89 ca                	mov    %ecx,%edx
  1004c8:	ee                   	out    %al,(%dx)
  1004c9:	be 11 00 00 00       	mov    $0x11,%esi
  1004ce:	bf 20 00 00 00       	mov    $0x20,%edi
  1004d3:	89 f0                	mov    %esi,%eax
  1004d5:	89 fa                	mov    %edi,%edx
  1004d7:	ee                   	out    %al,(%dx)
  1004d8:	b0 20                	mov    $0x20,%al
  1004da:	89 da                	mov    %ebx,%edx
  1004dc:	ee                   	out    %al,(%dx)
  1004dd:	b0 04                	mov    $0x4,%al
  1004df:	ee                   	out    %al,(%dx)
  1004e0:	b0 03                	mov    $0x3,%al
  1004e2:	ee                   	out    %al,(%dx)
  1004e3:	bd a0 00 00 00       	mov    $0xa0,%ebp
  1004e8:	89 f0                	mov    %esi,%eax
  1004ea:	89 ea                	mov    %ebp,%edx
  1004ec:	ee                   	out    %al,(%dx)
  1004ed:	b0 28                	mov    $0x28,%al
  1004ef:	89 ca                	mov    %ecx,%edx
  1004f1:	ee                   	out    %al,(%dx)
  1004f2:	b0 02                	mov    $0x2,%al
  1004f4:	ee                   	out    %al,(%dx)
  1004f5:	b0 01                	mov    $0x1,%al
  1004f7:	ee                   	out    %al,(%dx)
  1004f8:	b0 68                	mov    $0x68,%al
  1004fa:	89 fa                	mov    %edi,%edx
  1004fc:	ee                   	out    %al,(%dx)
  1004fd:	be 0a 00 00 00       	mov    $0xa,%esi
  100502:	89 f0                	mov    %esi,%eax
  100504:	ee                   	out    %al,(%dx)
  100505:	b0 68                	mov    $0x68,%al
  100507:	89 ea                	mov    %ebp,%edx
  100509:	ee                   	out    %al,(%dx)
  10050a:	89 f0                	mov    %esi,%eax
  10050c:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  10050d:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  100512:	89 da                	mov    %ebx,%edx
  100514:	19 c0                	sbb    %eax,%eax
  100516:	f7 d0                	not    %eax
  100518:	05 ff 00 00 00       	add    $0xff,%eax
  10051d:	ee                   	out    %al,(%dx)
  10051e:	b0 ff                	mov    $0xff,%al
  100520:	89 ca                	mov    %ecx,%edx
  100522:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  100523:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  100528:	74 0d                	je     100537 <interrupt_controller_init+0x84>
  10052a:	b2 43                	mov    $0x43,%dl
  10052c:	b0 34                	mov    $0x34,%al
  10052e:	ee                   	out    %al,(%dx)
  10052f:	b0 a9                	mov    $0xa9,%al
  100531:	b2 40                	mov    $0x40,%dl
  100533:	ee                   	out    %al,(%dx)
  100534:	b0 04                	mov    $0x4,%al
  100536:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  100537:	5b                   	pop    %ebx
  100538:	5e                   	pop    %esi
  100539:	5f                   	pop    %edi
  10053a:	5d                   	pop    %ebp
  10053b:	c3                   	ret    

0010053c <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  10053c:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  10053d:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  10053f:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100540:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  100547:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  10054a:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100550:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  100556:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  100559:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  10055e:	75 ea                	jne    10054a <console_clear+0xe>
  100560:	be d4 03 00 00       	mov    $0x3d4,%esi
  100565:	b0 0e                	mov    $0xe,%al
  100567:	89 f2                	mov    %esi,%edx
  100569:	ee                   	out    %al,(%dx)
  10056a:	31 c9                	xor    %ecx,%ecx
  10056c:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  100571:	88 c8                	mov    %cl,%al
  100573:	89 da                	mov    %ebx,%edx
  100575:	ee                   	out    %al,(%dx)
  100576:	b0 0f                	mov    $0xf,%al
  100578:	89 f2                	mov    %esi,%edx
  10057a:	ee                   	out    %al,(%dx)
  10057b:	88 c8                	mov    %cl,%al
  10057d:	89 da                	mov    %ebx,%edx
  10057f:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  100580:	5b                   	pop    %ebx
  100581:	5e                   	pop    %esi
  100582:	c3                   	ret    

00100583 <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  100583:	ba 64 00 00 00       	mov    $0x64,%edx
  100588:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  100589:	a8 01                	test   $0x1,%al
  10058b:	74 45                	je     1005d2 <console_read_digit+0x4f>
  10058d:	b2 60                	mov    $0x60,%dl
  10058f:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  100590:	8d 50 fe             	lea    -0x2(%eax),%edx
  100593:	80 fa 08             	cmp    $0x8,%dl
  100596:	77 05                	ja     10059d <console_read_digit+0x1a>
		return data - 0x02 + 1;
  100598:	0f b6 c0             	movzbl %al,%eax
  10059b:	48                   	dec    %eax
  10059c:	c3                   	ret    
	else if (data == 0x0B)
  10059d:	3c 0b                	cmp    $0xb,%al
  10059f:	74 35                	je     1005d6 <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  1005a1:	8d 50 b9             	lea    -0x47(%eax),%edx
  1005a4:	80 fa 02             	cmp    $0x2,%dl
  1005a7:	77 07                	ja     1005b0 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  1005a9:	0f b6 c0             	movzbl %al,%eax
  1005ac:	83 e8 40             	sub    $0x40,%eax
  1005af:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  1005b0:	8d 50 b5             	lea    -0x4b(%eax),%edx
  1005b3:	80 fa 02             	cmp    $0x2,%dl
  1005b6:	77 07                	ja     1005bf <console_read_digit+0x3c>
		return data - 0x4B + 4;
  1005b8:	0f b6 c0             	movzbl %al,%eax
  1005bb:	83 e8 47             	sub    $0x47,%eax
  1005be:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  1005bf:	8d 50 b1             	lea    -0x4f(%eax),%edx
  1005c2:	80 fa 02             	cmp    $0x2,%dl
  1005c5:	77 07                	ja     1005ce <console_read_digit+0x4b>
		return data - 0x4F + 1;
  1005c7:	0f b6 c0             	movzbl %al,%eax
  1005ca:	83 e8 4e             	sub    $0x4e,%eax
  1005cd:	c3                   	ret    
	else if (data == 0x53)
  1005ce:	3c 53                	cmp    $0x53,%al
  1005d0:	74 04                	je     1005d6 <console_read_digit+0x53>
  1005d2:	83 c8 ff             	or     $0xffffffff,%eax
  1005d5:	c3                   	ret    
  1005d6:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  1005d8:	c3                   	ret    

001005d9 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  1005d9:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  1005dd:	a3 24 84 10 00       	mov    %eax,0x108424

	asm volatile("movl %0,%%esp\n\t"
  1005e2:	83 c0 04             	add    $0x4,%eax
  1005e5:	89 c4                	mov    %eax,%esp
  1005e7:	61                   	popa   
  1005e8:	07                   	pop    %es
  1005e9:	1f                   	pop    %ds
  1005ea:	83 c4 08             	add    $0x8,%esp
  1005ed:	cf                   	iret   
  1005ee:	eb fe                	jmp    1005ee <run+0x15>

001005f0 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  1005f0:	53                   	push   %ebx
  1005f1:	83 ec 0c             	sub    $0xc,%esp
  1005f4:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  1005f8:	6a 44                	push   $0x44
  1005fa:	6a 00                	push   $0x0
  1005fc:	8d 43 04             	lea    0x4(%ebx),%eax
  1005ff:	50                   	push   %eax
  100600:	e8 17 01 00 00       	call   10071c <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  100605:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  10060b:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  100611:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  100617:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  10061d:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  100624:	83 c4 18             	add    $0x18,%esp
  100627:	5b                   	pop    %ebx
  100628:	c3                   	ret    
  100629:	90                   	nop
  10062a:	90                   	nop
  10062b:	90                   	nop

0010062c <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  10062c:	55                   	push   %ebp
  10062d:	57                   	push   %edi
  10062e:	56                   	push   %esi
  10062f:	53                   	push   %ebx
  100630:	83 ec 1c             	sub    $0x1c,%esp
  100633:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  100637:	83 f8 03             	cmp    $0x3,%eax
  10063a:	7f 04                	jg     100640 <program_loader+0x14>
  10063c:	85 c0                	test   %eax,%eax
  10063e:	79 02                	jns    100642 <program_loader+0x16>
  100640:	eb fe                	jmp    100640 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  100642:	8b 34 c5 40 10 10 00 	mov    0x101040(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  100649:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  10064f:	74 02                	je     100653 <program_loader+0x27>
  100651:	eb fe                	jmp    100651 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100653:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  100656:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10065a:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  10065c:	c1 e5 05             	shl    $0x5,%ebp
  10065f:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  100662:	eb 3f                	jmp    1006a3 <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  100664:	83 3b 01             	cmpl   $0x1,(%ebx)
  100667:	75 37                	jne    1006a0 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  100669:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  10066c:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  10066f:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100672:	01 c7                	add    %eax,%edi
	memsz += va;
  100674:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  100676:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  10067b:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  10067f:	52                   	push   %edx
  100680:	89 fa                	mov    %edi,%edx
  100682:	29 c2                	sub    %eax,%edx
  100684:	52                   	push   %edx
  100685:	8b 53 04             	mov    0x4(%ebx),%edx
  100688:	01 f2                	add    %esi,%edx
  10068a:	52                   	push   %edx
  10068b:	50                   	push   %eax
  10068c:	e8 27 00 00 00       	call   1006b8 <memcpy>
  100691:	83 c4 10             	add    $0x10,%esp
  100694:	eb 04                	jmp    10069a <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  100696:	c6 07 00             	movb   $0x0,(%edi)
  100699:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  10069a:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  10069e:	72 f6                	jb     100696 <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  1006a0:	83 c3 20             	add    $0x20,%ebx
  1006a3:	39 eb                	cmp    %ebp,%ebx
  1006a5:	72 bd                	jb     100664 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  1006a7:	8b 56 18             	mov    0x18(%esi),%edx
  1006aa:	8b 44 24 34          	mov    0x34(%esp),%eax
  1006ae:	89 10                	mov    %edx,(%eax)
}
  1006b0:	83 c4 1c             	add    $0x1c,%esp
  1006b3:	5b                   	pop    %ebx
  1006b4:	5e                   	pop    %esi
  1006b5:	5f                   	pop    %edi
  1006b6:	5d                   	pop    %ebp
  1006b7:	c3                   	ret    

001006b8 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  1006b8:	56                   	push   %esi
  1006b9:	31 d2                	xor    %edx,%edx
  1006bb:	53                   	push   %ebx
  1006bc:	8b 44 24 0c          	mov    0xc(%esp),%eax
  1006c0:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  1006c4:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1006c8:	eb 08                	jmp    1006d2 <memcpy+0x1a>
		*d++ = *s++;
  1006ca:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  1006cd:	4e                   	dec    %esi
  1006ce:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  1006d1:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1006d2:	85 f6                	test   %esi,%esi
  1006d4:	75 f4                	jne    1006ca <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  1006d6:	5b                   	pop    %ebx
  1006d7:	5e                   	pop    %esi
  1006d8:	c3                   	ret    

001006d9 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  1006d9:	57                   	push   %edi
  1006da:	56                   	push   %esi
  1006db:	53                   	push   %ebx
  1006dc:	8b 44 24 10          	mov    0x10(%esp),%eax
  1006e0:	8b 7c 24 14          	mov    0x14(%esp),%edi
  1006e4:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  1006e8:	39 c7                	cmp    %eax,%edi
  1006ea:	73 26                	jae    100712 <memmove+0x39>
  1006ec:	8d 34 17             	lea    (%edi,%edx,1),%esi
  1006ef:	39 c6                	cmp    %eax,%esi
  1006f1:	76 1f                	jbe    100712 <memmove+0x39>
		s += n, d += n;
  1006f3:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  1006f6:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  1006f8:	eb 07                	jmp    100701 <memmove+0x28>
			*--d = *--s;
  1006fa:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  1006fd:	4a                   	dec    %edx
  1006fe:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  100701:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  100702:	85 d2                	test   %edx,%edx
  100704:	75 f4                	jne    1006fa <memmove+0x21>
  100706:	eb 10                	jmp    100718 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  100708:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  10070b:	4a                   	dec    %edx
  10070c:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  10070f:	41                   	inc    %ecx
  100710:	eb 02                	jmp    100714 <memmove+0x3b>
  100712:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  100714:	85 d2                	test   %edx,%edx
  100716:	75 f0                	jne    100708 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  100718:	5b                   	pop    %ebx
  100719:	5e                   	pop    %esi
  10071a:	5f                   	pop    %edi
  10071b:	c3                   	ret    

0010071c <memset>:

void *
memset(void *v, int c, size_t n)
{
  10071c:	53                   	push   %ebx
  10071d:	8b 44 24 08          	mov    0x8(%esp),%eax
  100721:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  100725:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  100729:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  10072b:	eb 04                	jmp    100731 <memset+0x15>
		*p++ = c;
  10072d:	88 1a                	mov    %bl,(%edx)
  10072f:	49                   	dec    %ecx
  100730:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  100731:	85 c9                	test   %ecx,%ecx
  100733:	75 f8                	jne    10072d <memset+0x11>
		*p++ = c;
	return v;
}
  100735:	5b                   	pop    %ebx
  100736:	c3                   	ret    

00100737 <strlen>:

size_t
strlen(const char *s)
{
  100737:	8b 54 24 04          	mov    0x4(%esp),%edx
  10073b:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  10073d:	eb 01                	jmp    100740 <strlen+0x9>
		++n;
  10073f:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100740:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  100744:	75 f9                	jne    10073f <strlen+0x8>
		++n;
	return n;
}
  100746:	c3                   	ret    

00100747 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  100747:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  10074b:	31 c0                	xor    %eax,%eax
  10074d:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100751:	eb 01                	jmp    100754 <strnlen+0xd>
		++n;
  100753:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100754:	39 d0                	cmp    %edx,%eax
  100756:	74 06                	je     10075e <strnlen+0x17>
  100758:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  10075c:	75 f5                	jne    100753 <strnlen+0xc>
		++n;
	return n;
}
  10075e:	c3                   	ret    

0010075f <srand>:

static int rand_seed_set;
static unsigned rand_seed;

void srand(unsigned seed) {
    rand_seed = seed;
  10075f:	8b 44 24 04          	mov    0x4(%esp),%eax
    rand_seed_set = 1;
  100763:	c7 05 1c 84 10 00 01 	movl   $0x1,0x10841c
  10076a:	00 00 00 

static int rand_seed_set;
static unsigned rand_seed;

void srand(unsigned seed) {
    rand_seed = seed;
  10076d:	a3 20 84 10 00       	mov    %eax,0x108420
    rand_seed_set = 1;
}
  100772:	c3                   	ret    

00100773 <rand>:

int rand(void) {
    if (!rand_seed_set)
  100773:	83 3d 1c 84 10 00 00 	cmpl   $0x0,0x10841c
  10077a:	75 14                	jne    100790 <rand+0x1d>

static int rand_seed_set;
static unsigned rand_seed;

void srand(unsigned seed) {
    rand_seed = seed;
  10077c:	c7 05 20 84 10 00 9e 	movl   $0x30d4879e,0x108420
  100783:	87 d4 30 
    rand_seed_set = 1;
  100786:	c7 05 1c 84 10 00 01 	movl   $0x1,0x10841c
  10078d:	00 00 00 
}

int rand(void) {
    if (!rand_seed_set)
        srand(819234718U);
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100790:	69 05 20 84 10 00 0d 	imul   $0x19660d,0x108420,%eax
  100797:	66 19 00 
  10079a:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  10079f:	a3 20 84 10 00       	mov    %eax,0x108420
  1007a4:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
    return rand_seed & 0x7FFFFFFF;
}
  1007a9:	c3                   	ret    

001007aa <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1007aa:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  1007ab:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1007b0:	53                   	push   %ebx
  1007b1:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  1007b3:	76 05                	jbe    1007ba <console_putc+0x10>
  1007b5:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  1007ba:	80 fa 0a             	cmp    $0xa,%dl
  1007bd:	75 2c                	jne    1007eb <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1007bf:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  1007c5:	be 50 00 00 00       	mov    $0x50,%esi
  1007ca:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  1007cc:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1007cf:	99                   	cltd   
  1007d0:	f7 fe                	idiv   %esi
  1007d2:	89 de                	mov    %ebx,%esi
  1007d4:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  1007d6:	eb 07                	jmp    1007df <console_putc+0x35>
			*cursor++ = ' ' | color;
  1007d8:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1007db:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  1007dc:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1007df:	83 f8 50             	cmp    $0x50,%eax
  1007e2:	75 f4                	jne    1007d8 <console_putc+0x2e>
  1007e4:	29 d0                	sub    %edx,%eax
  1007e6:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  1007e9:	eb 0b                	jmp    1007f6 <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  1007eb:	0f b6 d2             	movzbl %dl,%edx
  1007ee:	09 ca                	or     %ecx,%edx
  1007f0:	66 89 13             	mov    %dx,(%ebx)
  1007f3:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  1007f6:	5b                   	pop    %ebx
  1007f7:	5e                   	pop    %esi
  1007f8:	c3                   	ret    

001007f9 <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  1007f9:	56                   	push   %esi
  1007fa:	53                   	push   %ebx
  1007fb:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  1007ff:	8d 58 ff             	lea    -0x1(%eax),%ebx
  100802:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  100806:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  10080b:	75 04                	jne    100811 <fill_numbuf+0x18>
  10080d:	85 d2                	test   %edx,%edx
  10080f:	74 10                	je     100821 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  100811:	89 d0                	mov    %edx,%eax
  100813:	31 d2                	xor    %edx,%edx
  100815:	f7 f1                	div    %ecx
  100817:	4b                   	dec    %ebx
  100818:	8a 14 16             	mov    (%esi,%edx,1),%dl
  10081b:	88 13                	mov    %dl,(%ebx)
			val /= base;
  10081d:	89 c2                	mov    %eax,%edx
  10081f:	eb ec                	jmp    10080d <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  100821:	89 d8                	mov    %ebx,%eax
  100823:	5b                   	pop    %ebx
  100824:	5e                   	pop    %esi
  100825:	c3                   	ret    

00100826 <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  100826:	55                   	push   %ebp
  100827:	57                   	push   %edi
  100828:	56                   	push   %esi
  100829:	53                   	push   %ebx
  10082a:	83 ec 38             	sub    $0x38,%esp
  10082d:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  100831:	8b 7c 24 54          	mov    0x54(%esp),%edi
  100835:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100839:	e9 60 03 00 00       	jmp    100b9e <console_vprintf+0x378>
		if (*format != '%') {
  10083e:	80 fa 25             	cmp    $0x25,%dl
  100841:	74 13                	je     100856 <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  100843:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100847:	0f b6 d2             	movzbl %dl,%edx
  10084a:	89 f0                	mov    %esi,%eax
  10084c:	e8 59 ff ff ff       	call   1007aa <console_putc>
  100851:	e9 45 03 00 00       	jmp    100b9b <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100856:	47                   	inc    %edi
  100857:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  10085e:	00 
  10085f:	eb 12                	jmp    100873 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  100861:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  100862:	8a 11                	mov    (%ecx),%dl
  100864:	84 d2                	test   %dl,%dl
  100866:	74 1a                	je     100882 <console_vprintf+0x5c>
  100868:	89 e8                	mov    %ebp,%eax
  10086a:	38 c2                	cmp    %al,%dl
  10086c:	75 f3                	jne    100861 <console_vprintf+0x3b>
  10086e:	e9 3f 03 00 00       	jmp    100bb2 <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100873:	8a 17                	mov    (%edi),%dl
  100875:	84 d2                	test   %dl,%dl
  100877:	74 0b                	je     100884 <console_vprintf+0x5e>
  100879:	b9 08 0c 10 00       	mov    $0x100c08,%ecx
  10087e:	89 d5                	mov    %edx,%ebp
  100880:	eb e0                	jmp    100862 <console_vprintf+0x3c>
  100882:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  100884:	8d 42 cf             	lea    -0x31(%edx),%eax
  100887:	3c 08                	cmp    $0x8,%al
  100889:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100890:	00 
  100891:	76 13                	jbe    1008a6 <console_vprintf+0x80>
  100893:	eb 1d                	jmp    1008b2 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  100895:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  10089a:	0f be c0             	movsbl %al,%eax
  10089d:	47                   	inc    %edi
  10089e:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  1008a2:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  1008a6:	8a 07                	mov    (%edi),%al
  1008a8:	8d 50 d0             	lea    -0x30(%eax),%edx
  1008ab:	80 fa 09             	cmp    $0x9,%dl
  1008ae:	76 e5                	jbe    100895 <console_vprintf+0x6f>
  1008b0:	eb 18                	jmp    1008ca <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  1008b2:	80 fa 2a             	cmp    $0x2a,%dl
  1008b5:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  1008bc:	ff 
  1008bd:	75 0b                	jne    1008ca <console_vprintf+0xa4>
			width = va_arg(val, int);
  1008bf:	83 c3 04             	add    $0x4,%ebx
			++format;
  1008c2:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  1008c3:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008c6:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  1008ca:	83 cd ff             	or     $0xffffffff,%ebp
  1008cd:	80 3f 2e             	cmpb   $0x2e,(%edi)
  1008d0:	75 37                	jne    100909 <console_vprintf+0xe3>
			++format;
  1008d2:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  1008d3:	31 ed                	xor    %ebp,%ebp
  1008d5:	8a 07                	mov    (%edi),%al
  1008d7:	8d 50 d0             	lea    -0x30(%eax),%edx
  1008da:	80 fa 09             	cmp    $0x9,%dl
  1008dd:	76 0d                	jbe    1008ec <console_vprintf+0xc6>
  1008df:	eb 17                	jmp    1008f8 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  1008e1:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  1008e4:	0f be c0             	movsbl %al,%eax
  1008e7:	47                   	inc    %edi
  1008e8:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  1008ec:	8a 07                	mov    (%edi),%al
  1008ee:	8d 50 d0             	lea    -0x30(%eax),%edx
  1008f1:	80 fa 09             	cmp    $0x9,%dl
  1008f4:	76 eb                	jbe    1008e1 <console_vprintf+0xbb>
  1008f6:	eb 11                	jmp    100909 <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  1008f8:	3c 2a                	cmp    $0x2a,%al
  1008fa:	75 0b                	jne    100907 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  1008fc:	83 c3 04             	add    $0x4,%ebx
				++format;
  1008ff:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  100900:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  100903:	85 ed                	test   %ebp,%ebp
  100905:	79 02                	jns    100909 <console_vprintf+0xe3>
  100907:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  100909:	8a 07                	mov    (%edi),%al
  10090b:	3c 64                	cmp    $0x64,%al
  10090d:	74 34                	je     100943 <console_vprintf+0x11d>
  10090f:	7f 1d                	jg     10092e <console_vprintf+0x108>
  100911:	3c 58                	cmp    $0x58,%al
  100913:	0f 84 a2 00 00 00    	je     1009bb <console_vprintf+0x195>
  100919:	3c 63                	cmp    $0x63,%al
  10091b:	0f 84 bf 00 00 00    	je     1009e0 <console_vprintf+0x1ba>
  100921:	3c 43                	cmp    $0x43,%al
  100923:	0f 85 d0 00 00 00    	jne    1009f9 <console_vprintf+0x1d3>
  100929:	e9 a3 00 00 00       	jmp    1009d1 <console_vprintf+0x1ab>
  10092e:	3c 75                	cmp    $0x75,%al
  100930:	74 4d                	je     10097f <console_vprintf+0x159>
  100932:	3c 78                	cmp    $0x78,%al
  100934:	74 5c                	je     100992 <console_vprintf+0x16c>
  100936:	3c 73                	cmp    $0x73,%al
  100938:	0f 85 bb 00 00 00    	jne    1009f9 <console_vprintf+0x1d3>
  10093e:	e9 86 00 00 00       	jmp    1009c9 <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  100943:	83 c3 04             	add    $0x4,%ebx
  100946:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  100949:	89 d1                	mov    %edx,%ecx
  10094b:	c1 f9 1f             	sar    $0x1f,%ecx
  10094e:	89 0c 24             	mov    %ecx,(%esp)
  100951:	31 ca                	xor    %ecx,%edx
  100953:	55                   	push   %ebp
  100954:	29 ca                	sub    %ecx,%edx
  100956:	68 10 0c 10 00       	push   $0x100c10
  10095b:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100960:	8d 44 24 40          	lea    0x40(%esp),%eax
  100964:	e8 90 fe ff ff       	call   1007f9 <fill_numbuf>
  100969:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  10096d:	58                   	pop    %eax
  10096e:	5a                   	pop    %edx
  10096f:	ba 01 00 00 00       	mov    $0x1,%edx
  100974:	8b 04 24             	mov    (%esp),%eax
  100977:	83 e0 01             	and    $0x1,%eax
  10097a:	e9 a5 00 00 00       	jmp    100a24 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  10097f:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  100982:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100987:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10098a:	55                   	push   %ebp
  10098b:	68 10 0c 10 00       	push   $0x100c10
  100990:	eb 11                	jmp    1009a3 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  100992:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  100995:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100998:	55                   	push   %ebp
  100999:	68 24 0c 10 00       	push   $0x100c24
  10099e:	b9 10 00 00 00       	mov    $0x10,%ecx
  1009a3:	8d 44 24 40          	lea    0x40(%esp),%eax
  1009a7:	e8 4d fe ff ff       	call   1007f9 <fill_numbuf>
  1009ac:	ba 01 00 00 00       	mov    $0x1,%edx
  1009b1:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1009b5:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  1009b7:	59                   	pop    %ecx
  1009b8:	59                   	pop    %ecx
  1009b9:	eb 69                	jmp    100a24 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  1009bb:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  1009be:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1009c1:	55                   	push   %ebp
  1009c2:	68 10 0c 10 00       	push   $0x100c10
  1009c7:	eb d5                	jmp    10099e <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  1009c9:	83 c3 04             	add    $0x4,%ebx
  1009cc:	8b 43 fc             	mov    -0x4(%ebx),%eax
  1009cf:	eb 40                	jmp    100a11 <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  1009d1:	83 c3 04             	add    $0x4,%ebx
  1009d4:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1009d7:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  1009db:	e9 bd 01 00 00       	jmp    100b9d <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  1009e0:	83 c3 04             	add    $0x4,%ebx
  1009e3:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  1009e6:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  1009ea:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  1009ef:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  1009f3:	88 44 24 24          	mov    %al,0x24(%esp)
  1009f7:	eb 27                	jmp    100a20 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  1009f9:	84 c0                	test   %al,%al
  1009fb:	75 02                	jne    1009ff <console_vprintf+0x1d9>
  1009fd:	b0 25                	mov    $0x25,%al
  1009ff:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100a03:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  100a08:	80 3f 00             	cmpb   $0x0,(%edi)
  100a0b:	74 0a                	je     100a17 <console_vprintf+0x1f1>
  100a0d:	8d 44 24 24          	lea    0x24(%esp),%eax
  100a11:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a15:	eb 09                	jmp    100a20 <console_vprintf+0x1fa>
				format--;
  100a17:	8d 54 24 24          	lea    0x24(%esp),%edx
  100a1b:	4f                   	dec    %edi
  100a1c:	89 54 24 04          	mov    %edx,0x4(%esp)
  100a20:	31 d2                	xor    %edx,%edx
  100a22:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100a24:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  100a26:	83 fd ff             	cmp    $0xffffffff,%ebp
  100a29:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100a30:	74 1f                	je     100a51 <console_vprintf+0x22b>
  100a32:	89 04 24             	mov    %eax,(%esp)
  100a35:	eb 01                	jmp    100a38 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  100a37:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100a38:	39 e9                	cmp    %ebp,%ecx
  100a3a:	74 0a                	je     100a46 <console_vprintf+0x220>
  100a3c:	8b 44 24 04          	mov    0x4(%esp),%eax
  100a40:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100a44:	75 f1                	jne    100a37 <console_vprintf+0x211>
  100a46:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100a49:	89 0c 24             	mov    %ecx,(%esp)
  100a4c:	eb 1f                	jmp    100a6d <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  100a4e:	42                   	inc    %edx
  100a4f:	eb 09                	jmp    100a5a <console_vprintf+0x234>
  100a51:	89 d1                	mov    %edx,%ecx
  100a53:	8b 14 24             	mov    (%esp),%edx
  100a56:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100a5a:	8b 44 24 04          	mov    0x4(%esp),%eax
  100a5e:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  100a62:	75 ea                	jne    100a4e <console_vprintf+0x228>
  100a64:	8b 44 24 08          	mov    0x8(%esp),%eax
  100a68:	89 14 24             	mov    %edx,(%esp)
  100a6b:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  100a6d:	85 c0                	test   %eax,%eax
  100a6f:	74 0c                	je     100a7d <console_vprintf+0x257>
  100a71:	84 d2                	test   %dl,%dl
  100a73:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  100a7a:	00 
  100a7b:	75 24                	jne    100aa1 <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  100a7d:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  100a82:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  100a89:	00 
  100a8a:	75 15                	jne    100aa1 <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100a8c:	8b 44 24 14          	mov    0x14(%esp),%eax
  100a90:	83 e0 08             	and    $0x8,%eax
  100a93:	83 f8 01             	cmp    $0x1,%eax
  100a96:	19 c9                	sbb    %ecx,%ecx
  100a98:	f7 d1                	not    %ecx
  100a9a:	83 e1 20             	and    $0x20,%ecx
  100a9d:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100aa1:	3b 2c 24             	cmp    (%esp),%ebp
  100aa4:	7e 0d                	jle    100ab3 <console_vprintf+0x28d>
  100aa6:	84 d2                	test   %dl,%dl
  100aa8:	74 40                	je     100aea <console_vprintf+0x2c4>
			zeros = precision - len;
  100aaa:	2b 2c 24             	sub    (%esp),%ebp
  100aad:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100ab1:	eb 3f                	jmp    100af2 <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100ab3:	84 d2                	test   %dl,%dl
  100ab5:	74 33                	je     100aea <console_vprintf+0x2c4>
  100ab7:	8b 44 24 14          	mov    0x14(%esp),%eax
  100abb:	83 e0 06             	and    $0x6,%eax
  100abe:	83 f8 02             	cmp    $0x2,%eax
  100ac1:	75 27                	jne    100aea <console_vprintf+0x2c4>
  100ac3:	45                   	inc    %ebp
  100ac4:	75 24                	jne    100aea <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  100ac6:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100ac8:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100acb:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100ad0:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100ad3:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100ad6:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100ada:	7d 0e                	jge    100aea <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100adc:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100ae0:	29 ca                	sub    %ecx,%edx
  100ae2:	29 c2                	sub    %eax,%edx
  100ae4:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100ae8:	eb 08                	jmp    100af2 <console_vprintf+0x2cc>
  100aea:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100af1:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100af2:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100af6:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100af8:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100afc:	2b 2c 24             	sub    (%esp),%ebp
  100aff:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100b04:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b07:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100b0a:	29 c5                	sub    %eax,%ebp
  100b0c:	89 f0                	mov    %esi,%eax
  100b0e:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b12:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100b16:	eb 0f                	jmp    100b27 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100b18:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b1c:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b21:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100b22:	e8 83 fc ff ff       	call   1007aa <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b27:	85 ed                	test   %ebp,%ebp
  100b29:	7e 07                	jle    100b32 <console_vprintf+0x30c>
  100b2b:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100b30:	74 e6                	je     100b18 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100b32:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100b37:	89 c6                	mov    %eax,%esi
  100b39:	74 23                	je     100b5e <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100b3b:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100b40:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b44:	e8 61 fc ff ff       	call   1007aa <console_putc>
  100b49:	89 c6                	mov    %eax,%esi
  100b4b:	eb 11                	jmp    100b5e <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100b4d:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b51:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100b56:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100b57:	e8 4e fc ff ff       	call   1007aa <console_putc>
  100b5c:	eb 06                	jmp    100b64 <console_vprintf+0x33e>
  100b5e:	89 f0                	mov    %esi,%eax
  100b60:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100b64:	85 f6                	test   %esi,%esi
  100b66:	7f e5                	jg     100b4d <console_vprintf+0x327>
  100b68:	8b 34 24             	mov    (%esp),%esi
  100b6b:	eb 15                	jmp    100b82 <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100b6d:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100b71:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100b72:	0f b6 11             	movzbl (%ecx),%edx
  100b75:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b79:	e8 2c fc ff ff       	call   1007aa <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100b7e:	ff 44 24 04          	incl   0x4(%esp)
  100b82:	85 f6                	test   %esi,%esi
  100b84:	7f e7                	jg     100b6d <console_vprintf+0x347>
  100b86:	eb 0f                	jmp    100b97 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100b88:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b8c:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100b91:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100b92:	e8 13 fc ff ff       	call   1007aa <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100b97:	85 ed                	test   %ebp,%ebp
  100b99:	7f ed                	jg     100b88 <console_vprintf+0x362>
  100b9b:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100b9d:	47                   	inc    %edi
  100b9e:	8a 17                	mov    (%edi),%dl
  100ba0:	84 d2                	test   %dl,%dl
  100ba2:	0f 85 96 fc ff ff    	jne    10083e <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100ba8:	83 c4 38             	add    $0x38,%esp
  100bab:	89 f0                	mov    %esi,%eax
  100bad:	5b                   	pop    %ebx
  100bae:	5e                   	pop    %esi
  100baf:	5f                   	pop    %edi
  100bb0:	5d                   	pop    %ebp
  100bb1:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100bb2:	81 e9 08 0c 10 00    	sub    $0x100c08,%ecx
  100bb8:	b8 01 00 00 00       	mov    $0x1,%eax
  100bbd:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100bbf:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100bc0:	09 44 24 14          	or     %eax,0x14(%esp)
  100bc4:	e9 aa fc ff ff       	jmp    100873 <console_vprintf+0x4d>

00100bc9 <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100bc9:	8d 44 24 10          	lea    0x10(%esp),%eax
  100bcd:	50                   	push   %eax
  100bce:	ff 74 24 10          	pushl  0x10(%esp)
  100bd2:	ff 74 24 10          	pushl  0x10(%esp)
  100bd6:	ff 74 24 10          	pushl  0x10(%esp)
  100bda:	e8 47 fc ff ff       	call   100826 <console_vprintf>
  100bdf:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100be2:	c3                   	ret    
