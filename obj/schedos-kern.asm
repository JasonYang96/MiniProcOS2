
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
  100014:	e8 67 02 00 00       	call   100280 <start>
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
  10006d:	e8 79 01 00 00       	call   1001eb <interrupt>

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
  1000a1:	a1 d4 8f 10 00       	mov    0x108fd4,%eax
  1000a6:	8b 10                	mov    (%eax),%edx
	unsigned int priority = 0xffffffff;
	int index = 1;

	if (scheduling_algorithm == 0) //round robin scheduling
  1000a8:	a1 d8 8f 10 00       	mov    0x108fd8,%eax
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
  1000bf:	83 b8 e8 85 10 00 01 	cmpl   $0x1,0x1085e8(%eax)
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
  1000da:	83 b9 e8 85 10 00 01 	cmpl   $0x1,0x1085e8(%ecx)
  1000e1:	75 11                	jne    1000f4 <schedule+0x58>
					run(&proc_array[pid]);
  1000e3:	6b c0 5c             	imul   $0x5c,%eax,%eax
  1000e6:	83 ec 0c             	sub    $0xc,%esp
  1000e9:	05 a0 85 10 00       	add    $0x1085a0,%eax
  1000ee:	50                   	push   %eax
  1000ef:	e8 b5 04 00 00       	call   1005a9 <run>
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
  10011c:	83 b8 e8 85 10 00 01 	cmpl   $0x1,0x1085e8(%eax)
  100123:	75 0c                	jne    100131 <schedule+0x95>
  100125:	8b 80 f0 85 10 00    	mov    0x1085f0(%eax),%eax
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
  10013c:	83 b8 e8 85 10 00 01 	cmpl   $0x1,0x1085e8(%eax)
  100143:	75 0f                	jne    100154 <schedule+0xb8>
  100145:	05 a0 85 10 00       	add    $0x1085a0,%eax
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
				if (proc_array[pid].p_state == P_RUNNABLE)
  10016d:	6b c2 5c             	imul   $0x5c,%edx,%eax
  100170:	8d 88 a8 85 10 00    	lea    0x1085a8(%eax),%ecx
  100176:	83 79 40 01          	cmpl   $0x1,0x40(%ecx)
  10017a:	75 19                	jne    100195 <schedule+0xf9>
				{
					if(proc_array[pid].p_iteration < proc_array[pid].p_share)
  10017c:	8d 59 50             	lea    0x50(%ecx),%ebx
  10017f:	8b 49 50             	mov    0x50(%ecx),%ecx
  100182:	3b 88 f4 85 10 00    	cmp    0x1085f4(%eax),%ecx
  100188:	73 0b                	jae    100195 <schedule+0xf9>
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
  10019b:	c7 05 54 86 10 00 00 	movl   $0x0,0x108654
  1001a2:	00 00 00 
  1001a5:	ba 01 00 00 00       	mov    $0x1,%edx
  1001aa:	c7 05 b0 86 10 00 00 	movl   $0x0,0x1086b0
  1001b1:	00 00 00 
  1001b4:	c7 05 0c 87 10 00 00 	movl   $0x0,0x10870c
  1001bb:	00 00 00 
  1001be:	c7 05 68 87 10 00 00 	movl   $0x0,0x108768
  1001c5:	00 00 00 
  1001c8:	eb a3                	jmp    10016d <schedule+0xd1>
		}
	}


	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  1001ca:	8b 15 00 80 19 00    	mov    0x198000,%edx
  1001d0:	50                   	push   %eax
  1001d1:	68 68 0b 10 00       	push   $0x100b68
  1001d6:	68 00 01 00 00       	push   $0x100
  1001db:	52                   	push   %edx
  1001dc:	e8 6d 09 00 00       	call   100b4e <console_printf>
  1001e1:	83 c4 10             	add    $0x10,%esp
  1001e4:	a3 00 80 19 00       	mov    %eax,0x198000
  1001e9:	eb fe                	jmp    1001e9 <schedule+0x14d>

001001eb <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  1001eb:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  1001ec:	a1 d4 8f 10 00       	mov    0x108fd4,%eax
  1001f1:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  1001f6:	56                   	push   %esi
  1001f7:	53                   	push   %ebx
  1001f8:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  1001fc:	8d 78 04             	lea    0x4(%eax),%edi
  1001ff:	89 de                	mov    %ebx,%esi
  100201:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  100203:	8b 53 28             	mov    0x28(%ebx),%edx
  100206:	83 fa 32             	cmp    $0x32,%edx
  100209:	74 3d                	je     100248 <interrupt+0x5d>
  10020b:	77 0e                	ja     10021b <interrupt+0x30>
  10020d:	83 fa 30             	cmp    $0x30,%edx
  100210:	74 15                	je     100227 <interrupt+0x3c>
  100212:	77 18                	ja     10022c <interrupt+0x41>
  100214:	83 fa 20             	cmp    $0x20,%edx
  100217:	74 2a                	je     100243 <interrupt+0x58>
  100219:	eb 63                	jmp    10027e <interrupt+0x93>
  10021b:	83 fa 33             	cmp    $0x33,%edx
  10021e:	74 35                	je     100255 <interrupt+0x6a>
  100220:	83 fa 34             	cmp    $0x34,%edx
  100223:	74 42                	je     100267 <interrupt+0x7c>
  100225:	eb 57                	jmp    10027e <interrupt+0x93>

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  100227:	e8 70 fe ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  10022c:	a1 d4 8f 10 00       	mov    0x108fd4,%eax
		current->p_exit_status = reg->reg_eax;
  100231:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100234:	c7 40 48 03 00 00 00 	movl   $0x3,0x48(%eax)
		current->p_exit_status = reg->reg_eax;
  10023b:	89 50 4c             	mov    %edx,0x4c(%eax)
		schedule();
  10023e:	e8 59 fe ff ff       	call   10009c <schedule>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  100243:	e8 54 fe ff ff       	call   10009c <schedule>

	case INT_SYS_PRIORITY:
		//Set current process' priority.
		current->p_priority = reg->reg_eax;
  100248:	a1 d4 8f 10 00       	mov    0x108fd4,%eax
  10024d:	8b 53 1c             	mov    0x1c(%ebx),%edx
  100250:	89 50 50             	mov    %edx,0x50(%eax)
  100253:	eb 09                	jmp    10025e <interrupt+0x73>
		run(current);

	case INT_SYS_SHARE:
		//Set current process' share.
		current->p_share = reg->reg_eax;
  100255:	8b 53 1c             	mov    0x1c(%ebx),%edx
		current->p_iteration--;
  100258:	ff 48 58             	decl   0x58(%eax)
		current->p_priority = reg->reg_eax;
		run(current);

	case INT_SYS_SHARE:
		//Set current process' share.
		current->p_share = reg->reg_eax;
  10025b:	89 50 54             	mov    %edx,0x54(%eax)
		current->p_iteration--;
		run(current);
  10025e:	83 ec 0c             	sub    $0xc,%esp
  100261:	50                   	push   %eax
  100262:	e8 42 03 00 00       	call   1005a9 <run>

	case INT_SYS_PRINT:
		//print next char
		*cursorpos++ = reg->reg_eax;
  100267:	8b 15 00 80 19 00    	mov    0x198000,%edx
  10026d:	8b 4b 1c             	mov    0x1c(%ebx),%ecx
  100270:	66 89 0a             	mov    %cx,(%edx)
  100273:	83 c2 02             	add    $0x2,%edx
  100276:	89 15 00 80 19 00    	mov    %edx,0x198000
  10027c:	eb e0                	jmp    10025e <interrupt+0x73>
  10027e:	eb fe                	jmp    10027e <interrupt+0x93>

00100280 <start>:
 *
 *****************************************************************************/

void
start(void)
{
  100280:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100281:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  100286:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100287:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  100289:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  10028a:	bb fc 85 10 00       	mov    $0x1085fc,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  10028f:	e8 f4 00 00 00       	call   100388 <segments_init>
	interrupt_controller_init(0);
  100294:	83 ec 0c             	sub    $0xc,%esp
  100297:	6a 00                	push   $0x0
  100299:	e8 e5 01 00 00       	call   100483 <interrupt_controller_init>
	console_clear();
  10029e:	e8 69 02 00 00       	call   10050c <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  1002a3:	83 c4 0c             	add    $0xc,%esp
  1002a6:	68 cc 01 00 00       	push   $0x1cc
  1002ab:	6a 00                	push   $0x0
  1002ad:	68 a0 85 10 00       	push   $0x1085a0
  1002b2:	e8 35 04 00 00       	call   1006ec <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1002b7:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002ba:	c7 05 a0 85 10 00 00 	movl   $0x0,0x1085a0
  1002c1:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002c4:	c7 05 e8 85 10 00 00 	movl   $0x0,0x1085e8
  1002cb:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002ce:	c7 05 fc 85 10 00 01 	movl   $0x1,0x1085fc
  1002d5:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002d8:	c7 05 44 86 10 00 00 	movl   $0x0,0x108644
  1002df:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002e2:	c7 05 58 86 10 00 02 	movl   $0x2,0x108658
  1002e9:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002ec:	c7 05 a0 86 10 00 00 	movl   $0x0,0x1086a0
  1002f3:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002f6:	c7 05 b4 86 10 00 03 	movl   $0x3,0x1086b4
  1002fd:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100300:	c7 05 fc 86 10 00 00 	movl   $0x0,0x1086fc
  100307:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10030a:	c7 05 10 87 10 00 04 	movl   $0x4,0x108710
  100311:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100314:	c7 05 58 87 10 00 00 	movl   $0x0,0x108758
  10031b:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  10031e:	83 ec 0c             	sub    $0xc,%esp
  100321:	53                   	push   %ebx
  100322:	e8 99 02 00 00       	call   1005c0 <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100327:	58                   	pop    %eax
  100328:	5a                   	pop    %edx
  100329:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  10032c:	89 7b 40             	mov    %edi,0x40(%ebx)
		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;

		proc->p_priority = 0;
		proc->p_share = 0xffffffff;
		proc->p_iteration = 0;
  10032f:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100335:	50                   	push   %eax
  100336:	56                   	push   %esi
		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;

		proc->p_priority = 0;
		proc->p_share = 0xffffffff;
		proc->p_iteration = 0;
  100337:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100338:	e8 bf 02 00 00       	call   1005fc <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  10033d:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100340:	c7 43 48 01 00 00 00 	movl   $0x1,0x48(%ebx)

		proc->p_priority = 0;
  100347:	c7 43 50 00 00 00 00 	movl   $0x0,0x50(%ebx)
		proc->p_share = 0xffffffff;
  10034e:	c7 43 54 ff ff ff ff 	movl   $0xffffffff,0x54(%ebx)
		proc->p_iteration = 0;
  100355:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  10035c:	83 c3 5c             	add    $0x5c,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  10035f:	83 fe 04             	cmp    $0x4,%esi
  100362:	75 ba                	jne    10031e <start+0x9e>

	// Initialize the scheduling algorithm.
	scheduling_algorithm = 3;

	// Switch to the first process.
	run(&proc_array[1]);
  100364:	83 ec 0c             	sub    $0xc,%esp
  100367:	68 fc 85 10 00       	push   $0x1085fc
		proc->p_iteration = 0;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  10036c:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  100373:	80 0b 00 

	// Initialize the scheduling algorithm.
	scheduling_algorithm = 3;
  100376:	c7 05 d8 8f 10 00 03 	movl   $0x3,0x108fd8
  10037d:	00 00 00 

	// Switch to the first process.
	run(&proc_array[1]);
  100380:	e8 24 02 00 00       	call   1005a9 <run>
  100385:	90                   	nop
  100386:	90                   	nop
  100387:	90                   	nop

00100388 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100388:	b8 6c 87 10 00       	mov    $0x10876c,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10038d:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100392:	89 c2                	mov    %eax,%edx
  100394:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  100397:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100398:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  10039d:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003a0:	66 a3 f6 1b 10 00    	mov    %ax,0x101bf6
  1003a6:	c1 e8 18             	shr    $0x18,%eax
  1003a9:	88 15 f8 1b 10 00    	mov    %dl,0x101bf8
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003af:	ba d4 87 10 00       	mov    $0x1087d4,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003b4:	a2 fb 1b 10 00       	mov    %al,0x101bfb
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003b9:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003bb:	66 c7 05 f4 1b 10 00 	movw   $0x68,0x101bf4
  1003c2:	68 00 
  1003c4:	c6 05 fa 1b 10 00 40 	movb   $0x40,0x101bfa
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  1003cb:	c6 05 f9 1b 10 00 89 	movb   $0x89,0x101bf9

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  1003d2:	c7 05 70 87 10 00 00 	movl   $0x180000,0x108770
  1003d9:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  1003dc:	66 c7 05 74 87 10 00 	movw   $0x10,0x108774
  1003e3:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003e5:	66 89 0c c5 d4 87 10 	mov    %cx,0x1087d4(,%eax,8)
  1003ec:	00 
  1003ed:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1003f4:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1003f9:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  1003fe:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  100403:	40                   	inc    %eax
  100404:	3d 00 01 00 00       	cmp    $0x100,%eax
  100409:	75 da                	jne    1003e5 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  10040b:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100410:	ba d4 87 10 00       	mov    $0x1087d4,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100415:	66 a3 d4 88 10 00    	mov    %ax,0x1088d4
  10041b:	c1 e8 10             	shr    $0x10,%eax
  10041e:	66 a3 da 88 10 00    	mov    %ax,0x1088da
  100424:	b8 30 00 00 00       	mov    $0x30,%eax
  100429:	66 c7 05 d6 88 10 00 	movw   $0x8,0x1088d6
  100430:	08 00 
  100432:	c6 05 d8 88 10 00 00 	movb   $0x0,0x1088d8
  100439:	c6 05 d9 88 10 00 8e 	movb   $0x8e,0x1088d9

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100440:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  100447:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  10044e:	66 89 0c c5 d4 87 10 	mov    %cx,0x1087d4(,%eax,8)
  100455:	00 
  100456:	c1 e9 10             	shr    $0x10,%ecx
  100459:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  10045e:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  100463:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  100468:	40                   	inc    %eax
  100469:	83 f8 3a             	cmp    $0x3a,%eax
  10046c:	75 d2                	jne    100440 <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  10046e:	b0 28                	mov    $0x28,%al
  100470:	0f 01 15 bc 1b 10 00 	lgdtl  0x101bbc
  100477:	0f 00 d8             	ltr    %ax
  10047a:	0f 01 1d c4 1b 10 00 	lidtl  0x101bc4
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  100481:	5b                   	pop    %ebx
  100482:	c3                   	ret    

00100483 <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  100483:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  100484:	b0 ff                	mov    $0xff,%al
  100486:	57                   	push   %edi
  100487:	56                   	push   %esi
  100488:	53                   	push   %ebx
  100489:	bb 21 00 00 00       	mov    $0x21,%ebx
  10048e:	89 da                	mov    %ebx,%edx
  100490:	ee                   	out    %al,(%dx)
  100491:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  100496:	89 ca                	mov    %ecx,%edx
  100498:	ee                   	out    %al,(%dx)
  100499:	be 11 00 00 00       	mov    $0x11,%esi
  10049e:	bf 20 00 00 00       	mov    $0x20,%edi
  1004a3:	89 f0                	mov    %esi,%eax
  1004a5:	89 fa                	mov    %edi,%edx
  1004a7:	ee                   	out    %al,(%dx)
  1004a8:	b0 20                	mov    $0x20,%al
  1004aa:	89 da                	mov    %ebx,%edx
  1004ac:	ee                   	out    %al,(%dx)
  1004ad:	b0 04                	mov    $0x4,%al
  1004af:	ee                   	out    %al,(%dx)
  1004b0:	b0 03                	mov    $0x3,%al
  1004b2:	ee                   	out    %al,(%dx)
  1004b3:	bd a0 00 00 00       	mov    $0xa0,%ebp
  1004b8:	89 f0                	mov    %esi,%eax
  1004ba:	89 ea                	mov    %ebp,%edx
  1004bc:	ee                   	out    %al,(%dx)
  1004bd:	b0 28                	mov    $0x28,%al
  1004bf:	89 ca                	mov    %ecx,%edx
  1004c1:	ee                   	out    %al,(%dx)
  1004c2:	b0 02                	mov    $0x2,%al
  1004c4:	ee                   	out    %al,(%dx)
  1004c5:	b0 01                	mov    $0x1,%al
  1004c7:	ee                   	out    %al,(%dx)
  1004c8:	b0 68                	mov    $0x68,%al
  1004ca:	89 fa                	mov    %edi,%edx
  1004cc:	ee                   	out    %al,(%dx)
  1004cd:	be 0a 00 00 00       	mov    $0xa,%esi
  1004d2:	89 f0                	mov    %esi,%eax
  1004d4:	ee                   	out    %al,(%dx)
  1004d5:	b0 68                	mov    $0x68,%al
  1004d7:	89 ea                	mov    %ebp,%edx
  1004d9:	ee                   	out    %al,(%dx)
  1004da:	89 f0                	mov    %esi,%eax
  1004dc:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  1004dd:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  1004e2:	89 da                	mov    %ebx,%edx
  1004e4:	19 c0                	sbb    %eax,%eax
  1004e6:	f7 d0                	not    %eax
  1004e8:	05 ff 00 00 00       	add    $0xff,%eax
  1004ed:	ee                   	out    %al,(%dx)
  1004ee:	b0 ff                	mov    $0xff,%al
  1004f0:	89 ca                	mov    %ecx,%edx
  1004f2:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  1004f3:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  1004f8:	74 0d                	je     100507 <interrupt_controller_init+0x84>
  1004fa:	b2 43                	mov    $0x43,%dl
  1004fc:	b0 34                	mov    $0x34,%al
  1004fe:	ee                   	out    %al,(%dx)
  1004ff:	b0 a9                	mov    $0xa9,%al
  100501:	b2 40                	mov    $0x40,%dl
  100503:	ee                   	out    %al,(%dx)
  100504:	b0 04                	mov    $0x4,%al
  100506:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  100507:	5b                   	pop    %ebx
  100508:	5e                   	pop    %esi
  100509:	5f                   	pop    %edi
  10050a:	5d                   	pop    %ebp
  10050b:	c3                   	ret    

0010050c <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  10050c:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  10050d:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  10050f:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100510:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  100517:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  10051a:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100520:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  100526:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  100529:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  10052e:	75 ea                	jne    10051a <console_clear+0xe>
  100530:	be d4 03 00 00       	mov    $0x3d4,%esi
  100535:	b0 0e                	mov    $0xe,%al
  100537:	89 f2                	mov    %esi,%edx
  100539:	ee                   	out    %al,(%dx)
  10053a:	31 c9                	xor    %ecx,%ecx
  10053c:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  100541:	88 c8                	mov    %cl,%al
  100543:	89 da                	mov    %ebx,%edx
  100545:	ee                   	out    %al,(%dx)
  100546:	b0 0f                	mov    $0xf,%al
  100548:	89 f2                	mov    %esi,%edx
  10054a:	ee                   	out    %al,(%dx)
  10054b:	88 c8                	mov    %cl,%al
  10054d:	89 da                	mov    %ebx,%edx
  10054f:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  100550:	5b                   	pop    %ebx
  100551:	5e                   	pop    %esi
  100552:	c3                   	ret    

00100553 <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  100553:	ba 64 00 00 00       	mov    $0x64,%edx
  100558:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  100559:	a8 01                	test   $0x1,%al
  10055b:	74 45                	je     1005a2 <console_read_digit+0x4f>
  10055d:	b2 60                	mov    $0x60,%dl
  10055f:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  100560:	8d 50 fe             	lea    -0x2(%eax),%edx
  100563:	80 fa 08             	cmp    $0x8,%dl
  100566:	77 05                	ja     10056d <console_read_digit+0x1a>
		return data - 0x02 + 1;
  100568:	0f b6 c0             	movzbl %al,%eax
  10056b:	48                   	dec    %eax
  10056c:	c3                   	ret    
	else if (data == 0x0B)
  10056d:	3c 0b                	cmp    $0xb,%al
  10056f:	74 35                	je     1005a6 <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  100571:	8d 50 b9             	lea    -0x47(%eax),%edx
  100574:	80 fa 02             	cmp    $0x2,%dl
  100577:	77 07                	ja     100580 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  100579:	0f b6 c0             	movzbl %al,%eax
  10057c:	83 e8 40             	sub    $0x40,%eax
  10057f:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  100580:	8d 50 b5             	lea    -0x4b(%eax),%edx
  100583:	80 fa 02             	cmp    $0x2,%dl
  100586:	77 07                	ja     10058f <console_read_digit+0x3c>
		return data - 0x4B + 4;
  100588:	0f b6 c0             	movzbl %al,%eax
  10058b:	83 e8 47             	sub    $0x47,%eax
  10058e:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  10058f:	8d 50 b1             	lea    -0x4f(%eax),%edx
  100592:	80 fa 02             	cmp    $0x2,%dl
  100595:	77 07                	ja     10059e <console_read_digit+0x4b>
		return data - 0x4F + 1;
  100597:	0f b6 c0             	movzbl %al,%eax
  10059a:	83 e8 4e             	sub    $0x4e,%eax
  10059d:	c3                   	ret    
	else if (data == 0x53)
  10059e:	3c 53                	cmp    $0x53,%al
  1005a0:	74 04                	je     1005a6 <console_read_digit+0x53>
  1005a2:	83 c8 ff             	or     $0xffffffff,%eax
  1005a5:	c3                   	ret    
  1005a6:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  1005a8:	c3                   	ret    

001005a9 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  1005a9:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  1005ad:	a3 d4 8f 10 00       	mov    %eax,0x108fd4

	asm volatile("movl %0,%%esp\n\t"
  1005b2:	83 c0 04             	add    $0x4,%eax
  1005b5:	89 c4                	mov    %eax,%esp
  1005b7:	61                   	popa   
  1005b8:	07                   	pop    %es
  1005b9:	1f                   	pop    %ds
  1005ba:	83 c4 08             	add    $0x8,%esp
  1005bd:	cf                   	iret   
  1005be:	eb fe                	jmp    1005be <run+0x15>

001005c0 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  1005c0:	53                   	push   %ebx
  1005c1:	83 ec 0c             	sub    $0xc,%esp
  1005c4:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  1005c8:	6a 44                	push   $0x44
  1005ca:	6a 00                	push   $0x0
  1005cc:	8d 43 04             	lea    0x4(%ebx),%eax
  1005cf:	50                   	push   %eax
  1005d0:	e8 17 01 00 00       	call   1006ec <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  1005d5:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  1005db:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  1005e1:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  1005e7:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  1005ed:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  1005f4:	83 c4 18             	add    $0x18,%esp
  1005f7:	5b                   	pop    %ebx
  1005f8:	c3                   	ret    
  1005f9:	90                   	nop
  1005fa:	90                   	nop
  1005fb:	90                   	nop

001005fc <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  1005fc:	55                   	push   %ebp
  1005fd:	57                   	push   %edi
  1005fe:	56                   	push   %esi
  1005ff:	53                   	push   %ebx
  100600:	83 ec 1c             	sub    $0x1c,%esp
  100603:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  100607:	83 f8 03             	cmp    $0x3,%eax
  10060a:	7f 04                	jg     100610 <program_loader+0x14>
  10060c:	85 c0                	test   %eax,%eax
  10060e:	79 02                	jns    100612 <program_loader+0x16>
  100610:	eb fe                	jmp    100610 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  100612:	8b 34 c5 fc 1b 10 00 	mov    0x101bfc(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  100619:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  10061f:	74 02                	je     100623 <program_loader+0x27>
  100621:	eb fe                	jmp    100621 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100623:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  100626:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10062a:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  10062c:	c1 e5 05             	shl    $0x5,%ebp
  10062f:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  100632:	eb 3f                	jmp    100673 <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  100634:	83 3b 01             	cmpl   $0x1,(%ebx)
  100637:	75 37                	jne    100670 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  100639:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  10063c:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  10063f:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100642:	01 c7                	add    %eax,%edi
	memsz += va;
  100644:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  100646:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  10064b:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  10064f:	52                   	push   %edx
  100650:	89 fa                	mov    %edi,%edx
  100652:	29 c2                	sub    %eax,%edx
  100654:	52                   	push   %edx
  100655:	8b 53 04             	mov    0x4(%ebx),%edx
  100658:	01 f2                	add    %esi,%edx
  10065a:	52                   	push   %edx
  10065b:	50                   	push   %eax
  10065c:	e8 27 00 00 00       	call   100688 <memcpy>
  100661:	83 c4 10             	add    $0x10,%esp
  100664:	eb 04                	jmp    10066a <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  100666:	c6 07 00             	movb   $0x0,(%edi)
  100669:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  10066a:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  10066e:	72 f6                	jb     100666 <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  100670:	83 c3 20             	add    $0x20,%ebx
  100673:	39 eb                	cmp    %ebp,%ebx
  100675:	72 bd                	jb     100634 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  100677:	8b 56 18             	mov    0x18(%esi),%edx
  10067a:	8b 44 24 34          	mov    0x34(%esp),%eax
  10067e:	89 10                	mov    %edx,(%eax)
}
  100680:	83 c4 1c             	add    $0x1c,%esp
  100683:	5b                   	pop    %ebx
  100684:	5e                   	pop    %esi
  100685:	5f                   	pop    %edi
  100686:	5d                   	pop    %ebp
  100687:	c3                   	ret    

00100688 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  100688:	56                   	push   %esi
  100689:	31 d2                	xor    %edx,%edx
  10068b:	53                   	push   %ebx
  10068c:	8b 44 24 0c          	mov    0xc(%esp),%eax
  100690:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  100694:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100698:	eb 08                	jmp    1006a2 <memcpy+0x1a>
		*d++ = *s++;
  10069a:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  10069d:	4e                   	dec    %esi
  10069e:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  1006a1:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1006a2:	85 f6                	test   %esi,%esi
  1006a4:	75 f4                	jne    10069a <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  1006a6:	5b                   	pop    %ebx
  1006a7:	5e                   	pop    %esi
  1006a8:	c3                   	ret    

001006a9 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  1006a9:	57                   	push   %edi
  1006aa:	56                   	push   %esi
  1006ab:	53                   	push   %ebx
  1006ac:	8b 44 24 10          	mov    0x10(%esp),%eax
  1006b0:	8b 7c 24 14          	mov    0x14(%esp),%edi
  1006b4:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  1006b8:	39 c7                	cmp    %eax,%edi
  1006ba:	73 26                	jae    1006e2 <memmove+0x39>
  1006bc:	8d 34 17             	lea    (%edi,%edx,1),%esi
  1006bf:	39 c6                	cmp    %eax,%esi
  1006c1:	76 1f                	jbe    1006e2 <memmove+0x39>
		s += n, d += n;
  1006c3:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  1006c6:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  1006c8:	eb 07                	jmp    1006d1 <memmove+0x28>
			*--d = *--s;
  1006ca:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  1006cd:	4a                   	dec    %edx
  1006ce:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  1006d1:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  1006d2:	85 d2                	test   %edx,%edx
  1006d4:	75 f4                	jne    1006ca <memmove+0x21>
  1006d6:	eb 10                	jmp    1006e8 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  1006d8:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  1006db:	4a                   	dec    %edx
  1006dc:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  1006df:	41                   	inc    %ecx
  1006e0:	eb 02                	jmp    1006e4 <memmove+0x3b>
  1006e2:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  1006e4:	85 d2                	test   %edx,%edx
  1006e6:	75 f0                	jne    1006d8 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  1006e8:	5b                   	pop    %ebx
  1006e9:	5e                   	pop    %esi
  1006ea:	5f                   	pop    %edi
  1006eb:	c3                   	ret    

001006ec <memset>:

void *
memset(void *v, int c, size_t n)
{
  1006ec:	53                   	push   %ebx
  1006ed:	8b 44 24 08          	mov    0x8(%esp),%eax
  1006f1:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  1006f5:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  1006f9:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  1006fb:	eb 04                	jmp    100701 <memset+0x15>
		*p++ = c;
  1006fd:	88 1a                	mov    %bl,(%edx)
  1006ff:	49                   	dec    %ecx
  100700:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  100701:	85 c9                	test   %ecx,%ecx
  100703:	75 f8                	jne    1006fd <memset+0x11>
		*p++ = c;
	return v;
}
  100705:	5b                   	pop    %ebx
  100706:	c3                   	ret    

00100707 <strlen>:

size_t
strlen(const char *s)
{
  100707:	8b 54 24 04          	mov    0x4(%esp),%edx
  10070b:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  10070d:	eb 01                	jmp    100710 <strlen+0x9>
		++n;
  10070f:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100710:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  100714:	75 f9                	jne    10070f <strlen+0x8>
		++n;
	return n;
}
  100716:	c3                   	ret    

00100717 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  100717:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  10071b:	31 c0                	xor    %eax,%eax
  10071d:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100721:	eb 01                	jmp    100724 <strnlen+0xd>
		++n;
  100723:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100724:	39 d0                	cmp    %edx,%eax
  100726:	74 06                	je     10072e <strnlen+0x17>
  100728:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  10072c:	75 f5                	jne    100723 <strnlen+0xc>
		++n;
	return n;
}
  10072e:	c3                   	ret    

0010072f <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  10072f:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  100730:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100735:	53                   	push   %ebx
  100736:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  100738:	76 05                	jbe    10073f <console_putc+0x10>
  10073a:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  10073f:	80 fa 0a             	cmp    $0xa,%dl
  100742:	75 2c                	jne    100770 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100744:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  10074a:	be 50 00 00 00       	mov    $0x50,%esi
  10074f:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  100751:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100754:	99                   	cltd   
  100755:	f7 fe                	idiv   %esi
  100757:	89 de                	mov    %ebx,%esi
  100759:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  10075b:	eb 07                	jmp    100764 <console_putc+0x35>
			*cursor++ = ' ' | color;
  10075d:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100760:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  100761:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100764:	83 f8 50             	cmp    $0x50,%eax
  100767:	75 f4                	jne    10075d <console_putc+0x2e>
  100769:	29 d0                	sub    %edx,%eax
  10076b:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  10076e:	eb 0b                	jmp    10077b <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  100770:	0f b6 d2             	movzbl %dl,%edx
  100773:	09 ca                	or     %ecx,%edx
  100775:	66 89 13             	mov    %dx,(%ebx)
  100778:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  10077b:	5b                   	pop    %ebx
  10077c:	5e                   	pop    %esi
  10077d:	c3                   	ret    

0010077e <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  10077e:	56                   	push   %esi
  10077f:	53                   	push   %ebx
  100780:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  100784:	8d 58 ff             	lea    -0x1(%eax),%ebx
  100787:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  10078b:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  100790:	75 04                	jne    100796 <fill_numbuf+0x18>
  100792:	85 d2                	test   %edx,%edx
  100794:	74 10                	je     1007a6 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  100796:	89 d0                	mov    %edx,%eax
  100798:	31 d2                	xor    %edx,%edx
  10079a:	f7 f1                	div    %ecx
  10079c:	4b                   	dec    %ebx
  10079d:	8a 14 16             	mov    (%esi,%edx,1),%dl
  1007a0:	88 13                	mov    %dl,(%ebx)
			val /= base;
  1007a2:	89 c2                	mov    %eax,%edx
  1007a4:	eb ec                	jmp    100792 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  1007a6:	89 d8                	mov    %ebx,%eax
  1007a8:	5b                   	pop    %ebx
  1007a9:	5e                   	pop    %esi
  1007aa:	c3                   	ret    

001007ab <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  1007ab:	55                   	push   %ebp
  1007ac:	57                   	push   %edi
  1007ad:	56                   	push   %esi
  1007ae:	53                   	push   %ebx
  1007af:	83 ec 38             	sub    $0x38,%esp
  1007b2:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  1007b6:	8b 7c 24 54          	mov    0x54(%esp),%edi
  1007ba:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  1007be:	e9 60 03 00 00       	jmp    100b23 <console_vprintf+0x378>
		if (*format != '%') {
  1007c3:	80 fa 25             	cmp    $0x25,%dl
  1007c6:	74 13                	je     1007db <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  1007c8:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1007cc:	0f b6 d2             	movzbl %dl,%edx
  1007cf:	89 f0                	mov    %esi,%eax
  1007d1:	e8 59 ff ff ff       	call   10072f <console_putc>
  1007d6:	e9 45 03 00 00       	jmp    100b20 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1007db:	47                   	inc    %edi
  1007dc:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  1007e3:	00 
  1007e4:	eb 12                	jmp    1007f8 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  1007e6:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  1007e7:	8a 11                	mov    (%ecx),%dl
  1007e9:	84 d2                	test   %dl,%dl
  1007eb:	74 1a                	je     100807 <console_vprintf+0x5c>
  1007ed:	89 e8                	mov    %ebp,%eax
  1007ef:	38 c2                	cmp    %al,%dl
  1007f1:	75 f3                	jne    1007e6 <console_vprintf+0x3b>
  1007f3:	e9 3f 03 00 00       	jmp    100b37 <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1007f8:	8a 17                	mov    (%edi),%dl
  1007fa:	84 d2                	test   %dl,%dl
  1007fc:	74 0b                	je     100809 <console_vprintf+0x5e>
  1007fe:	b9 8c 0b 10 00       	mov    $0x100b8c,%ecx
  100803:	89 d5                	mov    %edx,%ebp
  100805:	eb e0                	jmp    1007e7 <console_vprintf+0x3c>
  100807:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  100809:	8d 42 cf             	lea    -0x31(%edx),%eax
  10080c:	3c 08                	cmp    $0x8,%al
  10080e:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100815:	00 
  100816:	76 13                	jbe    10082b <console_vprintf+0x80>
  100818:	eb 1d                	jmp    100837 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  10081a:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  10081f:	0f be c0             	movsbl %al,%eax
  100822:	47                   	inc    %edi
  100823:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  100827:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  10082b:	8a 07                	mov    (%edi),%al
  10082d:	8d 50 d0             	lea    -0x30(%eax),%edx
  100830:	80 fa 09             	cmp    $0x9,%dl
  100833:	76 e5                	jbe    10081a <console_vprintf+0x6f>
  100835:	eb 18                	jmp    10084f <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  100837:	80 fa 2a             	cmp    $0x2a,%dl
  10083a:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  100841:	ff 
  100842:	75 0b                	jne    10084f <console_vprintf+0xa4>
			width = va_arg(val, int);
  100844:	83 c3 04             	add    $0x4,%ebx
			++format;
  100847:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  100848:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10084b:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  10084f:	83 cd ff             	or     $0xffffffff,%ebp
  100852:	80 3f 2e             	cmpb   $0x2e,(%edi)
  100855:	75 37                	jne    10088e <console_vprintf+0xe3>
			++format;
  100857:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  100858:	31 ed                	xor    %ebp,%ebp
  10085a:	8a 07                	mov    (%edi),%al
  10085c:	8d 50 d0             	lea    -0x30(%eax),%edx
  10085f:	80 fa 09             	cmp    $0x9,%dl
  100862:	76 0d                	jbe    100871 <console_vprintf+0xc6>
  100864:	eb 17                	jmp    10087d <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  100866:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  100869:	0f be c0             	movsbl %al,%eax
  10086c:	47                   	inc    %edi
  10086d:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  100871:	8a 07                	mov    (%edi),%al
  100873:	8d 50 d0             	lea    -0x30(%eax),%edx
  100876:	80 fa 09             	cmp    $0x9,%dl
  100879:	76 eb                	jbe    100866 <console_vprintf+0xbb>
  10087b:	eb 11                	jmp    10088e <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  10087d:	3c 2a                	cmp    $0x2a,%al
  10087f:	75 0b                	jne    10088c <console_vprintf+0xe1>
				precision = va_arg(val, int);
  100881:	83 c3 04             	add    $0x4,%ebx
				++format;
  100884:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  100885:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  100888:	85 ed                	test   %ebp,%ebp
  10088a:	79 02                	jns    10088e <console_vprintf+0xe3>
  10088c:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  10088e:	8a 07                	mov    (%edi),%al
  100890:	3c 64                	cmp    $0x64,%al
  100892:	74 34                	je     1008c8 <console_vprintf+0x11d>
  100894:	7f 1d                	jg     1008b3 <console_vprintf+0x108>
  100896:	3c 58                	cmp    $0x58,%al
  100898:	0f 84 a2 00 00 00    	je     100940 <console_vprintf+0x195>
  10089e:	3c 63                	cmp    $0x63,%al
  1008a0:	0f 84 bf 00 00 00    	je     100965 <console_vprintf+0x1ba>
  1008a6:	3c 43                	cmp    $0x43,%al
  1008a8:	0f 85 d0 00 00 00    	jne    10097e <console_vprintf+0x1d3>
  1008ae:	e9 a3 00 00 00       	jmp    100956 <console_vprintf+0x1ab>
  1008b3:	3c 75                	cmp    $0x75,%al
  1008b5:	74 4d                	je     100904 <console_vprintf+0x159>
  1008b7:	3c 78                	cmp    $0x78,%al
  1008b9:	74 5c                	je     100917 <console_vprintf+0x16c>
  1008bb:	3c 73                	cmp    $0x73,%al
  1008bd:	0f 85 bb 00 00 00    	jne    10097e <console_vprintf+0x1d3>
  1008c3:	e9 86 00 00 00       	jmp    10094e <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  1008c8:	83 c3 04             	add    $0x4,%ebx
  1008cb:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  1008ce:	89 d1                	mov    %edx,%ecx
  1008d0:	c1 f9 1f             	sar    $0x1f,%ecx
  1008d3:	89 0c 24             	mov    %ecx,(%esp)
  1008d6:	31 ca                	xor    %ecx,%edx
  1008d8:	55                   	push   %ebp
  1008d9:	29 ca                	sub    %ecx,%edx
  1008db:	68 94 0b 10 00       	push   $0x100b94
  1008e0:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1008e5:	8d 44 24 40          	lea    0x40(%esp),%eax
  1008e9:	e8 90 fe ff ff       	call   10077e <fill_numbuf>
  1008ee:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  1008f2:	58                   	pop    %eax
  1008f3:	5a                   	pop    %edx
  1008f4:	ba 01 00 00 00       	mov    $0x1,%edx
  1008f9:	8b 04 24             	mov    (%esp),%eax
  1008fc:	83 e0 01             	and    $0x1,%eax
  1008ff:	e9 a5 00 00 00       	jmp    1009a9 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  100904:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  100907:	b9 0a 00 00 00       	mov    $0xa,%ecx
  10090c:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10090f:	55                   	push   %ebp
  100910:	68 94 0b 10 00       	push   $0x100b94
  100915:	eb 11                	jmp    100928 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  100917:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  10091a:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10091d:	55                   	push   %ebp
  10091e:	68 a8 0b 10 00       	push   $0x100ba8
  100923:	b9 10 00 00 00       	mov    $0x10,%ecx
  100928:	8d 44 24 40          	lea    0x40(%esp),%eax
  10092c:	e8 4d fe ff ff       	call   10077e <fill_numbuf>
  100931:	ba 01 00 00 00       	mov    $0x1,%edx
  100936:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10093a:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  10093c:	59                   	pop    %ecx
  10093d:	59                   	pop    %ecx
  10093e:	eb 69                	jmp    1009a9 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  100940:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  100943:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100946:	55                   	push   %ebp
  100947:	68 94 0b 10 00       	push   $0x100b94
  10094c:	eb d5                	jmp    100923 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  10094e:	83 c3 04             	add    $0x4,%ebx
  100951:	8b 43 fc             	mov    -0x4(%ebx),%eax
  100954:	eb 40                	jmp    100996 <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  100956:	83 c3 04             	add    $0x4,%ebx
  100959:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10095c:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  100960:	e9 bd 01 00 00       	jmp    100b22 <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100965:	83 c3 04             	add    $0x4,%ebx
  100968:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  10096b:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  10096f:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100974:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100978:	88 44 24 24          	mov    %al,0x24(%esp)
  10097c:	eb 27                	jmp    1009a5 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  10097e:	84 c0                	test   %al,%al
  100980:	75 02                	jne    100984 <console_vprintf+0x1d9>
  100982:	b0 25                	mov    $0x25,%al
  100984:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100988:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  10098d:	80 3f 00             	cmpb   $0x0,(%edi)
  100990:	74 0a                	je     10099c <console_vprintf+0x1f1>
  100992:	8d 44 24 24          	lea    0x24(%esp),%eax
  100996:	89 44 24 04          	mov    %eax,0x4(%esp)
  10099a:	eb 09                	jmp    1009a5 <console_vprintf+0x1fa>
				format--;
  10099c:	8d 54 24 24          	lea    0x24(%esp),%edx
  1009a0:	4f                   	dec    %edi
  1009a1:	89 54 24 04          	mov    %edx,0x4(%esp)
  1009a5:	31 d2                	xor    %edx,%edx
  1009a7:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1009a9:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  1009ab:	83 fd ff             	cmp    $0xffffffff,%ebp
  1009ae:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1009b5:	74 1f                	je     1009d6 <console_vprintf+0x22b>
  1009b7:	89 04 24             	mov    %eax,(%esp)
  1009ba:	eb 01                	jmp    1009bd <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  1009bc:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1009bd:	39 e9                	cmp    %ebp,%ecx
  1009bf:	74 0a                	je     1009cb <console_vprintf+0x220>
  1009c1:	8b 44 24 04          	mov    0x4(%esp),%eax
  1009c5:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  1009c9:	75 f1                	jne    1009bc <console_vprintf+0x211>
  1009cb:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1009ce:	89 0c 24             	mov    %ecx,(%esp)
  1009d1:	eb 1f                	jmp    1009f2 <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  1009d3:	42                   	inc    %edx
  1009d4:	eb 09                	jmp    1009df <console_vprintf+0x234>
  1009d6:	89 d1                	mov    %edx,%ecx
  1009d8:	8b 14 24             	mov    (%esp),%edx
  1009db:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1009df:	8b 44 24 04          	mov    0x4(%esp),%eax
  1009e3:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  1009e7:	75 ea                	jne    1009d3 <console_vprintf+0x228>
  1009e9:	8b 44 24 08          	mov    0x8(%esp),%eax
  1009ed:	89 14 24             	mov    %edx,(%esp)
  1009f0:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  1009f2:	85 c0                	test   %eax,%eax
  1009f4:	74 0c                	je     100a02 <console_vprintf+0x257>
  1009f6:	84 d2                	test   %dl,%dl
  1009f8:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  1009ff:	00 
  100a00:	75 24                	jne    100a26 <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  100a02:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  100a07:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  100a0e:	00 
  100a0f:	75 15                	jne    100a26 <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100a11:	8b 44 24 14          	mov    0x14(%esp),%eax
  100a15:	83 e0 08             	and    $0x8,%eax
  100a18:	83 f8 01             	cmp    $0x1,%eax
  100a1b:	19 c9                	sbb    %ecx,%ecx
  100a1d:	f7 d1                	not    %ecx
  100a1f:	83 e1 20             	and    $0x20,%ecx
  100a22:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100a26:	3b 2c 24             	cmp    (%esp),%ebp
  100a29:	7e 0d                	jle    100a38 <console_vprintf+0x28d>
  100a2b:	84 d2                	test   %dl,%dl
  100a2d:	74 40                	je     100a6f <console_vprintf+0x2c4>
			zeros = precision - len;
  100a2f:	2b 2c 24             	sub    (%esp),%ebp
  100a32:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100a36:	eb 3f                	jmp    100a77 <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a38:	84 d2                	test   %dl,%dl
  100a3a:	74 33                	je     100a6f <console_vprintf+0x2c4>
  100a3c:	8b 44 24 14          	mov    0x14(%esp),%eax
  100a40:	83 e0 06             	and    $0x6,%eax
  100a43:	83 f8 02             	cmp    $0x2,%eax
  100a46:	75 27                	jne    100a6f <console_vprintf+0x2c4>
  100a48:	45                   	inc    %ebp
  100a49:	75 24                	jne    100a6f <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  100a4b:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a4d:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100a50:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a55:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a58:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100a5b:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100a5f:	7d 0e                	jge    100a6f <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100a61:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100a65:	29 ca                	sub    %ecx,%edx
  100a67:	29 c2                	sub    %eax,%edx
  100a69:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a6d:	eb 08                	jmp    100a77 <console_vprintf+0x2cc>
  100a6f:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100a76:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a77:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100a7b:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a7d:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a81:	2b 2c 24             	sub    (%esp),%ebp
  100a84:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a89:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a8c:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a8f:	29 c5                	sub    %eax,%ebp
  100a91:	89 f0                	mov    %esi,%eax
  100a93:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a97:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100a9b:	eb 0f                	jmp    100aac <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100a9d:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100aa1:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100aa6:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100aa7:	e8 83 fc ff ff       	call   10072f <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100aac:	85 ed                	test   %ebp,%ebp
  100aae:	7e 07                	jle    100ab7 <console_vprintf+0x30c>
  100ab0:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100ab5:	74 e6                	je     100a9d <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100ab7:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100abc:	89 c6                	mov    %eax,%esi
  100abe:	74 23                	je     100ae3 <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100ac0:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100ac5:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100ac9:	e8 61 fc ff ff       	call   10072f <console_putc>
  100ace:	89 c6                	mov    %eax,%esi
  100ad0:	eb 11                	jmp    100ae3 <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100ad2:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100ad6:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100adb:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100adc:	e8 4e fc ff ff       	call   10072f <console_putc>
  100ae1:	eb 06                	jmp    100ae9 <console_vprintf+0x33e>
  100ae3:	89 f0                	mov    %esi,%eax
  100ae5:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100ae9:	85 f6                	test   %esi,%esi
  100aeb:	7f e5                	jg     100ad2 <console_vprintf+0x327>
  100aed:	8b 34 24             	mov    (%esp),%esi
  100af0:	eb 15                	jmp    100b07 <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100af2:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100af6:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100af7:	0f b6 11             	movzbl (%ecx),%edx
  100afa:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100afe:	e8 2c fc ff ff       	call   10072f <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100b03:	ff 44 24 04          	incl   0x4(%esp)
  100b07:	85 f6                	test   %esi,%esi
  100b09:	7f e7                	jg     100af2 <console_vprintf+0x347>
  100b0b:	eb 0f                	jmp    100b1c <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100b0d:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b11:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100b16:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100b17:	e8 13 fc ff ff       	call   10072f <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100b1c:	85 ed                	test   %ebp,%ebp
  100b1e:	7f ed                	jg     100b0d <console_vprintf+0x362>
  100b20:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100b22:	47                   	inc    %edi
  100b23:	8a 17                	mov    (%edi),%dl
  100b25:	84 d2                	test   %dl,%dl
  100b27:	0f 85 96 fc ff ff    	jne    1007c3 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100b2d:	83 c4 38             	add    $0x38,%esp
  100b30:	89 f0                	mov    %esi,%eax
  100b32:	5b                   	pop    %ebx
  100b33:	5e                   	pop    %esi
  100b34:	5f                   	pop    %edi
  100b35:	5d                   	pop    %ebp
  100b36:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100b37:	81 e9 8c 0b 10 00    	sub    $0x100b8c,%ecx
  100b3d:	b8 01 00 00 00       	mov    $0x1,%eax
  100b42:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100b44:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100b45:	09 44 24 14          	or     %eax,0x14(%esp)
  100b49:	e9 aa fc ff ff       	jmp    1007f8 <console_vprintf+0x4d>

00100b4e <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100b4e:	8d 44 24 10          	lea    0x10(%esp),%eax
  100b52:	50                   	push   %eax
  100b53:	ff 74 24 10          	pushl  0x10(%esp)
  100b57:	ff 74 24 10          	pushl  0x10(%esp)
  100b5b:	ff 74 24 10          	pushl  0x10(%esp)
  100b5f:	e8 47 fc ff ff       	call   1007ab <console_vprintf>
  100b64:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100b67:	c3                   	ret    
