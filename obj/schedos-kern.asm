
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
  100014:	e8 78 02 00 00       	call   100291 <start>
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
  10006d:	e8 8a 01 00 00       	call   1001fc <interrupt>

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
  1000a1:	a1 e8 8f 10 00       	mov    0x108fe8,%eax
  1000a6:	8b 10                	mov    (%eax),%edx
	unsigned int priority = 0xffffffff;
	int index = 1;

	if (scheduling_algorithm == 0) //round robin scheduling
  1000a8:	a1 ec 8f 10 00       	mov    0x108fec,%eax
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
  1000bf:	83 b8 fc 85 10 00 01 	cmpl   $0x1,0x1085fc(%eax)
  1000c6:	75 ee                	jne    1000b6 <schedule+0x1a>
  1000c8:	e9 c4 00 00 00       	jmp    100191 <schedule+0xf5>
				run(&proc_array[pid]);
		}
	}

	if (scheduling_algorithm == 1) //priority based on lowest pid
  1000cd:	83 f8 01             	cmp    $0x1,%eax
  1000d0:	75 37                	jne    100109 <schedule+0x6d>
  1000d2:	ba 01 00 00 00       	mov    $0x1,%edx
	{
		while (1) {
			for (pid = 1; pid < NPROCS; pid++)
			{
				if (proc_array[pid].p_state == P_RUNNABLE)
  1000d7:	6b c8 5c             	imul   $0x5c,%eax,%ecx
  1000da:	83 b9 fc 85 10 00 01 	cmpl   $0x1,0x1085fc(%ecx)
  1000e1:	75 12                	jne    1000f5 <schedule+0x59>
					run(&proc_array[pid]);
  1000e3:	6b d2 5c             	imul   $0x5c,%edx,%edx
  1000e6:	83 ec 0c             	sub    $0xc,%esp
  1000e9:	81 c2 b4 85 10 00    	add    $0x1085b4,%edx
  1000ef:	52                   	push   %edx
  1000f0:	e8 c4 04 00 00       	call   1005b9 <run>
	}

	if (scheduling_algorithm == 1) //priority based on lowest pid
	{
		while (1) {
			for (pid = 1; pid < NPROCS; pid++)
  1000f5:	40                   	inc    %eax
  1000f6:	83 f8 04             	cmp    $0x4,%eax
			if (proc_array[pid].p_state == P_RUNNABLE)
				run(&proc_array[pid]);
		}
	}

	if (scheduling_algorithm == 1) //priority based on lowest pid
  1000f9:	89 c2                	mov    %eax,%edx
	{
		while (1) {
			for (pid = 1; pid < NPROCS; pid++)
  1000fb:	7e da                	jle    1000d7 <schedule+0x3b>
  1000fd:	ba 01 00 00 00       	mov    $0x1,%edx
  100102:	b8 01 00 00 00       	mov    $0x1,%eax
  100107:	eb ce                	jmp    1000d7 <schedule+0x3b>
					run(&proc_array[pid]);
			}
		}
	}

	if (scheduling_algorithm == 2) //priority based on lowerst p_priority
  100109:	83 f8 02             	cmp    $0x2,%eax
  10010c:	75 57                	jne    100165 <schedule+0xc9>
  10010e:	bb 01 00 00 00       	mov    $0x1,%ebx
  100113:	83 ce ff             	or     $0xffffffff,%esi
					priority = proc_array[index].p_priority;
				}
			}
			// search for proc with that priority
			// increment pid by 1 to "alternate"
			for (pid = (pid + 1) % NPROCS; pid < NPROCS; pid = (pid + 1) % NPROCS)
  100116:	b9 05 00 00 00       	mov    $0x5,%ecx
  10011b:	eb 19                	jmp    100136 <schedule+0x9a>
	{
		while (1) {
			//find lowest p_priority
			for (; index < NPROCS; index++)
			{
				if (proc_array[index].p_state == P_RUNNABLE &&
  10011d:	6b c3 5c             	imul   $0x5c,%ebx,%eax
  100120:	83 b8 fc 85 10 00 01 	cmpl   $0x1,0x1085fc(%eax)
  100127:	75 0c                	jne    100135 <schedule+0x99>
  100129:	8b 80 04 86 10 00    	mov    0x108604(%eax),%eax
  10012f:	39 c6                	cmp    %eax,%esi
  100131:	76 02                	jbe    100135 <schedule+0x99>
  100133:	89 c6                	mov    %eax,%esi

	if (scheduling_algorithm == 2) //priority based on lowerst p_priority
	{
		while (1) {
			//find lowest p_priority
			for (; index < NPROCS; index++)
  100135:	43                   	inc    %ebx
  100136:	83 fb 04             	cmp    $0x4,%ebx
  100139:	7e e2                	jle    10011d <schedule+0x81>
  10013b:	eb 1b                	jmp    100158 <schedule+0xbc>
			}
			// search for proc with that priority
			// increment pid by 1 to "alternate"
			for (pid = (pid + 1) % NPROCS; pid < NPROCS; pid = (pid + 1) % NPROCS)
			{
				if (proc_array[pid].p_state == P_RUNNABLE &&
  10013d:	6b c2 5c             	imul   $0x5c,%edx,%eax
  100140:	83 b8 fc 85 10 00 01 	cmpl   $0x1,0x1085fc(%eax)
  100147:	75 0f                	jne    100158 <schedule+0xbc>
  100149:	05 b4 85 10 00       	add    $0x1085b4,%eax
  10014e:	39 70 50             	cmp    %esi,0x50(%eax)
  100151:	77 05                	ja     100158 <schedule+0xbc>
					proc_array[pid].p_priority <= priority)
				{
					run(&proc_array[pid]);
  100153:	83 ec 0c             	sub    $0xc,%esp
  100156:	eb 41                	jmp    100199 <schedule+0xfd>
					priority = proc_array[index].p_priority;
				}
			}
			// search for proc with that priority
			// increment pid by 1 to "alternate"
			for (pid = (pid + 1) % NPROCS; pid < NPROCS; pid = (pid + 1) % NPROCS)
  100158:	8d 42 01             	lea    0x1(%edx),%eax
  10015b:	99                   	cltd   
  10015c:	f7 f9                	idiv   %ecx
  10015e:	83 fa 04             	cmp    $0x4,%edx
  100161:	7e da                	jle    10013d <schedule+0xa1>
  100163:	eb d1                	jmp    100136 <schedule+0x9a>
				}
			}
		}
	}

	if (scheduling_algorithm == 3) //priority based on highest share
  100165:	83 f8 03             	cmp    $0x3,%eax
  100168:	ba 01 00 00 00       	mov    $0x1,%edx
  10016d:	75 65                	jne    1001d4 <schedule+0x138>
  10016f:	eb 2f                	jmp    1001a0 <schedule+0x104>
	{
		while (1) {
			//for each proc, run until iterations == share
			for (pid = 1; pid < NPROCS; pid++)
			{
				if (proc_array[pid].p_state == P_RUNNABLE &&
  100171:	6b c2 5c             	imul   $0x5c,%edx,%eax
  100174:	8d 88 bc 85 10 00    	lea    0x1085bc(%eax),%ecx
  10017a:	83 79 40 01          	cmpl   $0x1,0x40(%ecx)
  10017e:	75 1f                	jne    10019f <schedule+0x103>
					proc_array[pid].p_iteration < proc_array[pid].p_share)
  100180:	8d 59 50             	lea    0x50(%ecx),%ebx
  100183:	8b 49 50             	mov    0x50(%ecx),%ecx
	{
		while (1) {
			//for each proc, run until iterations == share
			for (pid = 1; pid < NPROCS; pid++)
			{
				if (proc_array[pid].p_state == P_RUNNABLE &&
  100186:	3b 88 08 86 10 00    	cmp    0x108608(%eax),%ecx
  10018c:	73 11                	jae    10019f <schedule+0x103>
					proc_array[pid].p_iteration < proc_array[pid].p_share)
				{
					proc_array[pid].p_iteration++;
  10018e:	41                   	inc    %ecx
  10018f:	89 0b                	mov    %ecx,(%ebx)
					run(&proc_array[pid]);
  100191:	83 ec 0c             	sub    $0xc,%esp
  100194:	05 b4 85 10 00       	add    $0x1085b4,%eax
  100199:	50                   	push   %eax
  10019a:	e9 51 ff ff ff       	jmp    1000f0 <schedule+0x54>

	if (scheduling_algorithm == 3) //priority based on highest share
	{
		while (1) {
			//for each proc, run until iterations == share
			for (pid = 1; pid < NPROCS; pid++)
  10019f:	42                   	inc    %edx
  1001a0:	83 fa 04             	cmp    $0x4,%edx
  1001a3:	7e cc                	jle    100171 <schedule+0xd5>
				}
			}
			//reset iterations
			for (pid = 1; pid < NPROCS; pid++)
			{
				proc_array[pid].p_iteration = 0;
  1001a5:	c7 05 68 86 10 00 00 	movl   $0x0,0x108668
  1001ac:	00 00 00 
  1001af:	ba 01 00 00 00       	mov    $0x1,%edx
  1001b4:	c7 05 c4 86 10 00 00 	movl   $0x0,0x1086c4
  1001bb:	00 00 00 
  1001be:	c7 05 20 87 10 00 00 	movl   $0x0,0x108720
  1001c5:	00 00 00 
  1001c8:	c7 05 7c 87 10 00 00 	movl   $0x0,0x10877c
  1001cf:	00 00 00 
  1001d2:	eb 9d                	jmp    100171 <schedule+0xd5>
			}
		}
	}

	if (scheduling_algorithm == 4) //lottery scheduling
  1001d4:	83 f8 04             	cmp    $0x4,%eax
  1001d7:	75 02                	jne    1001db <schedule+0x13f>
  1001d9:	eb fe                	jmp    1001d9 <schedule+0x13d>
		}
	}


	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  1001db:	8b 15 00 80 19 00    	mov    0x198000,%edx
  1001e1:	50                   	push   %eax
  1001e2:	68 78 0b 10 00       	push   $0x100b78
  1001e7:	68 00 01 00 00       	push   $0x100
  1001ec:	52                   	push   %edx
  1001ed:	e8 6c 09 00 00       	call   100b5e <console_printf>
  1001f2:	83 c4 10             	add    $0x10,%esp
  1001f5:	a3 00 80 19 00       	mov    %eax,0x198000
  1001fa:	eb fe                	jmp    1001fa <schedule+0x15e>

001001fc <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  1001fc:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  1001fd:	a1 e8 8f 10 00       	mov    0x108fe8,%eax
  100202:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  100207:	56                   	push   %esi
  100208:	53                   	push   %ebx
  100209:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  10020d:	8d 78 04             	lea    0x4(%eax),%edi
  100210:	89 de                	mov    %ebx,%esi
  100212:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  100214:	8b 53 28             	mov    0x28(%ebx),%edx
  100217:	83 fa 32             	cmp    $0x32,%edx
  10021a:	74 3d                	je     100259 <interrupt+0x5d>
  10021c:	77 0e                	ja     10022c <interrupt+0x30>
  10021e:	83 fa 30             	cmp    $0x30,%edx
  100221:	74 15                	je     100238 <interrupt+0x3c>
  100223:	77 18                	ja     10023d <interrupt+0x41>
  100225:	83 fa 20             	cmp    $0x20,%edx
  100228:	74 2a                	je     100254 <interrupt+0x58>
  10022a:	eb 63                	jmp    10028f <interrupt+0x93>
  10022c:	83 fa 33             	cmp    $0x33,%edx
  10022f:	74 35                	je     100266 <interrupt+0x6a>
  100231:	83 fa 34             	cmp    $0x34,%edx
  100234:	74 42                	je     100278 <interrupt+0x7c>
  100236:	eb 57                	jmp    10028f <interrupt+0x93>

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  100238:	e8 5f fe ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  10023d:	a1 e8 8f 10 00       	mov    0x108fe8,%eax
		current->p_exit_status = reg->reg_eax;
  100242:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100245:	c7 40 48 03 00 00 00 	movl   $0x3,0x48(%eax)
		current->p_exit_status = reg->reg_eax;
  10024c:	89 50 4c             	mov    %edx,0x4c(%eax)
		schedule();
  10024f:	e8 48 fe ff ff       	call   10009c <schedule>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  100254:	e8 43 fe ff ff       	call   10009c <schedule>

	case INT_SYS_PRIORITY:
		//Set current process' priority.
		current->p_priority = reg->reg_eax;
  100259:	a1 e8 8f 10 00       	mov    0x108fe8,%eax
  10025e:	8b 53 1c             	mov    0x1c(%ebx),%edx
  100261:	89 50 50             	mov    %edx,0x50(%eax)
  100264:	eb 09                	jmp    10026f <interrupt+0x73>
		run(current);

	case INT_SYS_SHARE:
		//Set current process' share.
		current->p_share = reg->reg_eax;
  100266:	8b 53 1c             	mov    0x1c(%ebx),%edx
		current->p_iteration--;
  100269:	ff 48 58             	decl   0x58(%eax)
		current->p_priority = reg->reg_eax;
		run(current);

	case INT_SYS_SHARE:
		//Set current process' share.
		current->p_share = reg->reg_eax;
  10026c:	89 50 54             	mov    %edx,0x54(%eax)
		current->p_iteration--;
		run(current);
  10026f:	83 ec 0c             	sub    $0xc,%esp
  100272:	50                   	push   %eax
  100273:	e8 41 03 00 00       	call   1005b9 <run>

	case INT_SYS_PRINT:
		//print next char
		*cursorpos++ = reg->reg_eax;
  100278:	8b 15 00 80 19 00    	mov    0x198000,%edx
  10027e:	8b 4b 1c             	mov    0x1c(%ebx),%ecx
  100281:	66 89 0a             	mov    %cx,(%edx)
  100284:	83 c2 02             	add    $0x2,%edx
  100287:	89 15 00 80 19 00    	mov    %edx,0x198000
  10028d:	eb e0                	jmp    10026f <interrupt+0x73>
  10028f:	eb fe                	jmp    10028f <interrupt+0x93>

00100291 <start>:
 *
 *****************************************************************************/

void
start(void)
{
  100291:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100292:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  100297:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100298:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  10029a:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  10029b:	bb 10 86 10 00       	mov    $0x108610,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  1002a0:	e8 f3 00 00 00       	call   100398 <segments_init>
	interrupt_controller_init(0);
  1002a5:	83 ec 0c             	sub    $0xc,%esp
  1002a8:	6a 00                	push   $0x0
  1002aa:	e8 e4 01 00 00       	call   100493 <interrupt_controller_init>
	console_clear();
  1002af:	e8 68 02 00 00       	call   10051c <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  1002b4:	83 c4 0c             	add    $0xc,%esp
  1002b7:	68 cc 01 00 00       	push   $0x1cc
  1002bc:	6a 00                	push   $0x0
  1002be:	68 b4 85 10 00       	push   $0x1085b4
  1002c3:	e8 34 04 00 00       	call   1006fc <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1002c8:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002cb:	c7 05 b4 85 10 00 00 	movl   $0x0,0x1085b4
  1002d2:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002d5:	c7 05 fc 85 10 00 00 	movl   $0x0,0x1085fc
  1002dc:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002df:	c7 05 10 86 10 00 01 	movl   $0x1,0x108610
  1002e6:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002e9:	c7 05 58 86 10 00 00 	movl   $0x0,0x108658
  1002f0:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002f3:	c7 05 6c 86 10 00 02 	movl   $0x2,0x10866c
  1002fa:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002fd:	c7 05 b4 86 10 00 00 	movl   $0x0,0x1086b4
  100304:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100307:	c7 05 c8 86 10 00 03 	movl   $0x3,0x1086c8
  10030e:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100311:	c7 05 10 87 10 00 00 	movl   $0x0,0x108710
  100318:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10031b:	c7 05 24 87 10 00 04 	movl   $0x4,0x108724
  100322:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100325:	c7 05 6c 87 10 00 00 	movl   $0x0,0x10876c
  10032c:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  10032f:	83 ec 0c             	sub    $0xc,%esp
  100332:	53                   	push   %ebx
  100333:	e8 98 02 00 00       	call   1005d0 <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100338:	58                   	pop    %eax
  100339:	5a                   	pop    %edx
  10033a:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  10033d:	89 7b 40             	mov    %edi,0x40(%ebx)
		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;

		proc->p_priority = 0;
		proc->p_share = 1;
		proc->p_iteration = 0;
  100340:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100346:	50                   	push   %eax
  100347:	56                   	push   %esi
		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;

		proc->p_priority = 0;
		proc->p_share = 1;
		proc->p_iteration = 0;
  100348:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100349:	e8 be 02 00 00       	call   10060c <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  10034e:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100351:	c7 43 48 01 00 00 00 	movl   $0x1,0x48(%ebx)

		proc->p_priority = 0;
  100358:	c7 43 50 00 00 00 00 	movl   $0x0,0x50(%ebx)
		proc->p_share = 1;
  10035f:	c7 43 54 01 00 00 00 	movl   $0x1,0x54(%ebx)
		proc->p_iteration = 0;
  100366:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  10036d:	83 c3 5c             	add    $0x5c,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100370:	83 fe 04             	cmp    $0x4,%esi
  100373:	75 ba                	jne    10032f <start+0x9e>

	// Initialize the scheduling algorithm.
	scheduling_algorithm = 3;

	// Switch to the first process.
	run(&proc_array[1]);
  100375:	83 ec 0c             	sub    $0xc,%esp
  100378:	68 10 86 10 00       	push   $0x108610
		proc->p_iteration = 0;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  10037d:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  100384:	80 0b 00 

	// Initialize the scheduling algorithm.
	scheduling_algorithm = 3;
  100387:	c7 05 ec 8f 10 00 03 	movl   $0x3,0x108fec
  10038e:	00 00 00 

	// Switch to the first process.
	run(&proc_array[1]);
  100391:	e8 23 02 00 00       	call   1005b9 <run>
  100396:	90                   	nop
  100397:	90                   	nop

00100398 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100398:	b8 80 87 10 00       	mov    $0x108780,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10039d:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003a2:	89 c2                	mov    %eax,%edx
  1003a4:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  1003a7:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003a8:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  1003ad:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003b0:	66 a3 06 1c 10 00    	mov    %ax,0x101c06
  1003b6:	c1 e8 18             	shr    $0x18,%eax
  1003b9:	88 15 08 1c 10 00    	mov    %dl,0x101c08
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003bf:	ba e8 87 10 00       	mov    $0x1087e8,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003c4:	a2 0b 1c 10 00       	mov    %al,0x101c0b
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003c9:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003cb:	66 c7 05 04 1c 10 00 	movw   $0x68,0x101c04
  1003d2:	68 00 
  1003d4:	c6 05 0a 1c 10 00 40 	movb   $0x40,0x101c0a
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  1003db:	c6 05 09 1c 10 00 89 	movb   $0x89,0x101c09

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  1003e2:	c7 05 84 87 10 00 00 	movl   $0x180000,0x108784
  1003e9:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  1003ec:	66 c7 05 88 87 10 00 	movw   $0x10,0x108788
  1003f3:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003f5:	66 89 0c c5 e8 87 10 	mov    %cx,0x1087e8(,%eax,8)
  1003fc:	00 
  1003fd:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100404:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100409:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  10040e:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  100413:	40                   	inc    %eax
  100414:	3d 00 01 00 00       	cmp    $0x100,%eax
  100419:	75 da                	jne    1003f5 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  10041b:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100420:	ba e8 87 10 00       	mov    $0x1087e8,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100425:	66 a3 e8 88 10 00    	mov    %ax,0x1088e8
  10042b:	c1 e8 10             	shr    $0x10,%eax
  10042e:	66 a3 ee 88 10 00    	mov    %ax,0x1088ee
  100434:	b8 30 00 00 00       	mov    $0x30,%eax
  100439:	66 c7 05 ea 88 10 00 	movw   $0x8,0x1088ea
  100440:	08 00 
  100442:	c6 05 ec 88 10 00 00 	movb   $0x0,0x1088ec
  100449:	c6 05 ed 88 10 00 8e 	movb   $0x8e,0x1088ed

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100450:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  100457:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  10045e:	66 89 0c c5 e8 87 10 	mov    %cx,0x1087e8(,%eax,8)
  100465:	00 
  100466:	c1 e9 10             	shr    $0x10,%ecx
  100469:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  10046e:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  100473:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  100478:	40                   	inc    %eax
  100479:	83 f8 3a             	cmp    $0x3a,%eax
  10047c:	75 d2                	jne    100450 <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  10047e:	b0 28                	mov    $0x28,%al
  100480:	0f 01 15 cc 1b 10 00 	lgdtl  0x101bcc
  100487:	0f 00 d8             	ltr    %ax
  10048a:	0f 01 1d d4 1b 10 00 	lidtl  0x101bd4
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  100491:	5b                   	pop    %ebx
  100492:	c3                   	ret    

00100493 <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  100493:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  100494:	b0 ff                	mov    $0xff,%al
  100496:	57                   	push   %edi
  100497:	56                   	push   %esi
  100498:	53                   	push   %ebx
  100499:	bb 21 00 00 00       	mov    $0x21,%ebx
  10049e:	89 da                	mov    %ebx,%edx
  1004a0:	ee                   	out    %al,(%dx)
  1004a1:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  1004a6:	89 ca                	mov    %ecx,%edx
  1004a8:	ee                   	out    %al,(%dx)
  1004a9:	be 11 00 00 00       	mov    $0x11,%esi
  1004ae:	bf 20 00 00 00       	mov    $0x20,%edi
  1004b3:	89 f0                	mov    %esi,%eax
  1004b5:	89 fa                	mov    %edi,%edx
  1004b7:	ee                   	out    %al,(%dx)
  1004b8:	b0 20                	mov    $0x20,%al
  1004ba:	89 da                	mov    %ebx,%edx
  1004bc:	ee                   	out    %al,(%dx)
  1004bd:	b0 04                	mov    $0x4,%al
  1004bf:	ee                   	out    %al,(%dx)
  1004c0:	b0 03                	mov    $0x3,%al
  1004c2:	ee                   	out    %al,(%dx)
  1004c3:	bd a0 00 00 00       	mov    $0xa0,%ebp
  1004c8:	89 f0                	mov    %esi,%eax
  1004ca:	89 ea                	mov    %ebp,%edx
  1004cc:	ee                   	out    %al,(%dx)
  1004cd:	b0 28                	mov    $0x28,%al
  1004cf:	89 ca                	mov    %ecx,%edx
  1004d1:	ee                   	out    %al,(%dx)
  1004d2:	b0 02                	mov    $0x2,%al
  1004d4:	ee                   	out    %al,(%dx)
  1004d5:	b0 01                	mov    $0x1,%al
  1004d7:	ee                   	out    %al,(%dx)
  1004d8:	b0 68                	mov    $0x68,%al
  1004da:	89 fa                	mov    %edi,%edx
  1004dc:	ee                   	out    %al,(%dx)
  1004dd:	be 0a 00 00 00       	mov    $0xa,%esi
  1004e2:	89 f0                	mov    %esi,%eax
  1004e4:	ee                   	out    %al,(%dx)
  1004e5:	b0 68                	mov    $0x68,%al
  1004e7:	89 ea                	mov    %ebp,%edx
  1004e9:	ee                   	out    %al,(%dx)
  1004ea:	89 f0                	mov    %esi,%eax
  1004ec:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  1004ed:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  1004f2:	89 da                	mov    %ebx,%edx
  1004f4:	19 c0                	sbb    %eax,%eax
  1004f6:	f7 d0                	not    %eax
  1004f8:	05 ff 00 00 00       	add    $0xff,%eax
  1004fd:	ee                   	out    %al,(%dx)
  1004fe:	b0 ff                	mov    $0xff,%al
  100500:	89 ca                	mov    %ecx,%edx
  100502:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  100503:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  100508:	74 0d                	je     100517 <interrupt_controller_init+0x84>
  10050a:	b2 43                	mov    $0x43,%dl
  10050c:	b0 34                	mov    $0x34,%al
  10050e:	ee                   	out    %al,(%dx)
  10050f:	b0 a9                	mov    $0xa9,%al
  100511:	b2 40                	mov    $0x40,%dl
  100513:	ee                   	out    %al,(%dx)
  100514:	b0 04                	mov    $0x4,%al
  100516:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  100517:	5b                   	pop    %ebx
  100518:	5e                   	pop    %esi
  100519:	5f                   	pop    %edi
  10051a:	5d                   	pop    %ebp
  10051b:	c3                   	ret    

0010051c <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  10051c:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  10051d:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  10051f:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100520:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  100527:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  10052a:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100530:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  100536:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  100539:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  10053e:	75 ea                	jne    10052a <console_clear+0xe>
  100540:	be d4 03 00 00       	mov    $0x3d4,%esi
  100545:	b0 0e                	mov    $0xe,%al
  100547:	89 f2                	mov    %esi,%edx
  100549:	ee                   	out    %al,(%dx)
  10054a:	31 c9                	xor    %ecx,%ecx
  10054c:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  100551:	88 c8                	mov    %cl,%al
  100553:	89 da                	mov    %ebx,%edx
  100555:	ee                   	out    %al,(%dx)
  100556:	b0 0f                	mov    $0xf,%al
  100558:	89 f2                	mov    %esi,%edx
  10055a:	ee                   	out    %al,(%dx)
  10055b:	88 c8                	mov    %cl,%al
  10055d:	89 da                	mov    %ebx,%edx
  10055f:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  100560:	5b                   	pop    %ebx
  100561:	5e                   	pop    %esi
  100562:	c3                   	ret    

00100563 <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  100563:	ba 64 00 00 00       	mov    $0x64,%edx
  100568:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  100569:	a8 01                	test   $0x1,%al
  10056b:	74 45                	je     1005b2 <console_read_digit+0x4f>
  10056d:	b2 60                	mov    $0x60,%dl
  10056f:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  100570:	8d 50 fe             	lea    -0x2(%eax),%edx
  100573:	80 fa 08             	cmp    $0x8,%dl
  100576:	77 05                	ja     10057d <console_read_digit+0x1a>
		return data - 0x02 + 1;
  100578:	0f b6 c0             	movzbl %al,%eax
  10057b:	48                   	dec    %eax
  10057c:	c3                   	ret    
	else if (data == 0x0B)
  10057d:	3c 0b                	cmp    $0xb,%al
  10057f:	74 35                	je     1005b6 <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  100581:	8d 50 b9             	lea    -0x47(%eax),%edx
  100584:	80 fa 02             	cmp    $0x2,%dl
  100587:	77 07                	ja     100590 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  100589:	0f b6 c0             	movzbl %al,%eax
  10058c:	83 e8 40             	sub    $0x40,%eax
  10058f:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  100590:	8d 50 b5             	lea    -0x4b(%eax),%edx
  100593:	80 fa 02             	cmp    $0x2,%dl
  100596:	77 07                	ja     10059f <console_read_digit+0x3c>
		return data - 0x4B + 4;
  100598:	0f b6 c0             	movzbl %al,%eax
  10059b:	83 e8 47             	sub    $0x47,%eax
  10059e:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  10059f:	8d 50 b1             	lea    -0x4f(%eax),%edx
  1005a2:	80 fa 02             	cmp    $0x2,%dl
  1005a5:	77 07                	ja     1005ae <console_read_digit+0x4b>
		return data - 0x4F + 1;
  1005a7:	0f b6 c0             	movzbl %al,%eax
  1005aa:	83 e8 4e             	sub    $0x4e,%eax
  1005ad:	c3                   	ret    
	else if (data == 0x53)
  1005ae:	3c 53                	cmp    $0x53,%al
  1005b0:	74 04                	je     1005b6 <console_read_digit+0x53>
  1005b2:	83 c8 ff             	or     $0xffffffff,%eax
  1005b5:	c3                   	ret    
  1005b6:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  1005b8:	c3                   	ret    

001005b9 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  1005b9:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  1005bd:	a3 e8 8f 10 00       	mov    %eax,0x108fe8

	asm volatile("movl %0,%%esp\n\t"
  1005c2:	83 c0 04             	add    $0x4,%eax
  1005c5:	89 c4                	mov    %eax,%esp
  1005c7:	61                   	popa   
  1005c8:	07                   	pop    %es
  1005c9:	1f                   	pop    %ds
  1005ca:	83 c4 08             	add    $0x8,%esp
  1005cd:	cf                   	iret   
  1005ce:	eb fe                	jmp    1005ce <run+0x15>

001005d0 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  1005d0:	53                   	push   %ebx
  1005d1:	83 ec 0c             	sub    $0xc,%esp
  1005d4:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  1005d8:	6a 44                	push   $0x44
  1005da:	6a 00                	push   $0x0
  1005dc:	8d 43 04             	lea    0x4(%ebx),%eax
  1005df:	50                   	push   %eax
  1005e0:	e8 17 01 00 00       	call   1006fc <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  1005e5:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  1005eb:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  1005f1:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  1005f7:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  1005fd:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  100604:	83 c4 18             	add    $0x18,%esp
  100607:	5b                   	pop    %ebx
  100608:	c3                   	ret    
  100609:	90                   	nop
  10060a:	90                   	nop
  10060b:	90                   	nop

0010060c <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  10060c:	55                   	push   %ebp
  10060d:	57                   	push   %edi
  10060e:	56                   	push   %esi
  10060f:	53                   	push   %ebx
  100610:	83 ec 1c             	sub    $0x1c,%esp
  100613:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  100617:	83 f8 03             	cmp    $0x3,%eax
  10061a:	7f 04                	jg     100620 <program_loader+0x14>
  10061c:	85 c0                	test   %eax,%eax
  10061e:	79 02                	jns    100622 <program_loader+0x16>
  100620:	eb fe                	jmp    100620 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  100622:	8b 34 c5 0c 1c 10 00 	mov    0x101c0c(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  100629:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  10062f:	74 02                	je     100633 <program_loader+0x27>
  100631:	eb fe                	jmp    100631 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100633:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  100636:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10063a:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  10063c:	c1 e5 05             	shl    $0x5,%ebp
  10063f:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  100642:	eb 3f                	jmp    100683 <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  100644:	83 3b 01             	cmpl   $0x1,(%ebx)
  100647:	75 37                	jne    100680 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  100649:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  10064c:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  10064f:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100652:	01 c7                	add    %eax,%edi
	memsz += va;
  100654:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  100656:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  10065b:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  10065f:	52                   	push   %edx
  100660:	89 fa                	mov    %edi,%edx
  100662:	29 c2                	sub    %eax,%edx
  100664:	52                   	push   %edx
  100665:	8b 53 04             	mov    0x4(%ebx),%edx
  100668:	01 f2                	add    %esi,%edx
  10066a:	52                   	push   %edx
  10066b:	50                   	push   %eax
  10066c:	e8 27 00 00 00       	call   100698 <memcpy>
  100671:	83 c4 10             	add    $0x10,%esp
  100674:	eb 04                	jmp    10067a <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  100676:	c6 07 00             	movb   $0x0,(%edi)
  100679:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  10067a:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  10067e:	72 f6                	jb     100676 <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  100680:	83 c3 20             	add    $0x20,%ebx
  100683:	39 eb                	cmp    %ebp,%ebx
  100685:	72 bd                	jb     100644 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  100687:	8b 56 18             	mov    0x18(%esi),%edx
  10068a:	8b 44 24 34          	mov    0x34(%esp),%eax
  10068e:	89 10                	mov    %edx,(%eax)
}
  100690:	83 c4 1c             	add    $0x1c,%esp
  100693:	5b                   	pop    %ebx
  100694:	5e                   	pop    %esi
  100695:	5f                   	pop    %edi
  100696:	5d                   	pop    %ebp
  100697:	c3                   	ret    

00100698 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  100698:	56                   	push   %esi
  100699:	31 d2                	xor    %edx,%edx
  10069b:	53                   	push   %ebx
  10069c:	8b 44 24 0c          	mov    0xc(%esp),%eax
  1006a0:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  1006a4:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1006a8:	eb 08                	jmp    1006b2 <memcpy+0x1a>
		*d++ = *s++;
  1006aa:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  1006ad:	4e                   	dec    %esi
  1006ae:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  1006b1:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1006b2:	85 f6                	test   %esi,%esi
  1006b4:	75 f4                	jne    1006aa <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  1006b6:	5b                   	pop    %ebx
  1006b7:	5e                   	pop    %esi
  1006b8:	c3                   	ret    

001006b9 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  1006b9:	57                   	push   %edi
  1006ba:	56                   	push   %esi
  1006bb:	53                   	push   %ebx
  1006bc:	8b 44 24 10          	mov    0x10(%esp),%eax
  1006c0:	8b 7c 24 14          	mov    0x14(%esp),%edi
  1006c4:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  1006c8:	39 c7                	cmp    %eax,%edi
  1006ca:	73 26                	jae    1006f2 <memmove+0x39>
  1006cc:	8d 34 17             	lea    (%edi,%edx,1),%esi
  1006cf:	39 c6                	cmp    %eax,%esi
  1006d1:	76 1f                	jbe    1006f2 <memmove+0x39>
		s += n, d += n;
  1006d3:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  1006d6:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  1006d8:	eb 07                	jmp    1006e1 <memmove+0x28>
			*--d = *--s;
  1006da:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  1006dd:	4a                   	dec    %edx
  1006de:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  1006e1:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  1006e2:	85 d2                	test   %edx,%edx
  1006e4:	75 f4                	jne    1006da <memmove+0x21>
  1006e6:	eb 10                	jmp    1006f8 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  1006e8:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  1006eb:	4a                   	dec    %edx
  1006ec:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  1006ef:	41                   	inc    %ecx
  1006f0:	eb 02                	jmp    1006f4 <memmove+0x3b>
  1006f2:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  1006f4:	85 d2                	test   %edx,%edx
  1006f6:	75 f0                	jne    1006e8 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  1006f8:	5b                   	pop    %ebx
  1006f9:	5e                   	pop    %esi
  1006fa:	5f                   	pop    %edi
  1006fb:	c3                   	ret    

001006fc <memset>:

void *
memset(void *v, int c, size_t n)
{
  1006fc:	53                   	push   %ebx
  1006fd:	8b 44 24 08          	mov    0x8(%esp),%eax
  100701:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  100705:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  100709:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  10070b:	eb 04                	jmp    100711 <memset+0x15>
		*p++ = c;
  10070d:	88 1a                	mov    %bl,(%edx)
  10070f:	49                   	dec    %ecx
  100710:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  100711:	85 c9                	test   %ecx,%ecx
  100713:	75 f8                	jne    10070d <memset+0x11>
		*p++ = c;
	return v;
}
  100715:	5b                   	pop    %ebx
  100716:	c3                   	ret    

00100717 <strlen>:

size_t
strlen(const char *s)
{
  100717:	8b 54 24 04          	mov    0x4(%esp),%edx
  10071b:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  10071d:	eb 01                	jmp    100720 <strlen+0x9>
		++n;
  10071f:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100720:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  100724:	75 f9                	jne    10071f <strlen+0x8>
		++n;
	return n;
}
  100726:	c3                   	ret    

00100727 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  100727:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  10072b:	31 c0                	xor    %eax,%eax
  10072d:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100731:	eb 01                	jmp    100734 <strnlen+0xd>
		++n;
  100733:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100734:	39 d0                	cmp    %edx,%eax
  100736:	74 06                	je     10073e <strnlen+0x17>
  100738:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  10073c:	75 f5                	jne    100733 <strnlen+0xc>
		++n;
	return n;
}
  10073e:	c3                   	ret    

0010073f <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  10073f:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  100740:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100745:	53                   	push   %ebx
  100746:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  100748:	76 05                	jbe    10074f <console_putc+0x10>
  10074a:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  10074f:	80 fa 0a             	cmp    $0xa,%dl
  100752:	75 2c                	jne    100780 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100754:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  10075a:	be 50 00 00 00       	mov    $0x50,%esi
  10075f:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  100761:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100764:	99                   	cltd   
  100765:	f7 fe                	idiv   %esi
  100767:	89 de                	mov    %ebx,%esi
  100769:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  10076b:	eb 07                	jmp    100774 <console_putc+0x35>
			*cursor++ = ' ' | color;
  10076d:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100770:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  100771:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100774:	83 f8 50             	cmp    $0x50,%eax
  100777:	75 f4                	jne    10076d <console_putc+0x2e>
  100779:	29 d0                	sub    %edx,%eax
  10077b:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  10077e:	eb 0b                	jmp    10078b <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  100780:	0f b6 d2             	movzbl %dl,%edx
  100783:	09 ca                	or     %ecx,%edx
  100785:	66 89 13             	mov    %dx,(%ebx)
  100788:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  10078b:	5b                   	pop    %ebx
  10078c:	5e                   	pop    %esi
  10078d:	c3                   	ret    

0010078e <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  10078e:	56                   	push   %esi
  10078f:	53                   	push   %ebx
  100790:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  100794:	8d 58 ff             	lea    -0x1(%eax),%ebx
  100797:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  10079b:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  1007a0:	75 04                	jne    1007a6 <fill_numbuf+0x18>
  1007a2:	85 d2                	test   %edx,%edx
  1007a4:	74 10                	je     1007b6 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  1007a6:	89 d0                	mov    %edx,%eax
  1007a8:	31 d2                	xor    %edx,%edx
  1007aa:	f7 f1                	div    %ecx
  1007ac:	4b                   	dec    %ebx
  1007ad:	8a 14 16             	mov    (%esi,%edx,1),%dl
  1007b0:	88 13                	mov    %dl,(%ebx)
			val /= base;
  1007b2:	89 c2                	mov    %eax,%edx
  1007b4:	eb ec                	jmp    1007a2 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  1007b6:	89 d8                	mov    %ebx,%eax
  1007b8:	5b                   	pop    %ebx
  1007b9:	5e                   	pop    %esi
  1007ba:	c3                   	ret    

001007bb <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  1007bb:	55                   	push   %ebp
  1007bc:	57                   	push   %edi
  1007bd:	56                   	push   %esi
  1007be:	53                   	push   %ebx
  1007bf:	83 ec 38             	sub    $0x38,%esp
  1007c2:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  1007c6:	8b 7c 24 54          	mov    0x54(%esp),%edi
  1007ca:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  1007ce:	e9 60 03 00 00       	jmp    100b33 <console_vprintf+0x378>
		if (*format != '%') {
  1007d3:	80 fa 25             	cmp    $0x25,%dl
  1007d6:	74 13                	je     1007eb <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  1007d8:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1007dc:	0f b6 d2             	movzbl %dl,%edx
  1007df:	89 f0                	mov    %esi,%eax
  1007e1:	e8 59 ff ff ff       	call   10073f <console_putc>
  1007e6:	e9 45 03 00 00       	jmp    100b30 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1007eb:	47                   	inc    %edi
  1007ec:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  1007f3:	00 
  1007f4:	eb 12                	jmp    100808 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  1007f6:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  1007f7:	8a 11                	mov    (%ecx),%dl
  1007f9:	84 d2                	test   %dl,%dl
  1007fb:	74 1a                	je     100817 <console_vprintf+0x5c>
  1007fd:	89 e8                	mov    %ebp,%eax
  1007ff:	38 c2                	cmp    %al,%dl
  100801:	75 f3                	jne    1007f6 <console_vprintf+0x3b>
  100803:	e9 3f 03 00 00       	jmp    100b47 <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100808:	8a 17                	mov    (%edi),%dl
  10080a:	84 d2                	test   %dl,%dl
  10080c:	74 0b                	je     100819 <console_vprintf+0x5e>
  10080e:	b9 9c 0b 10 00       	mov    $0x100b9c,%ecx
  100813:	89 d5                	mov    %edx,%ebp
  100815:	eb e0                	jmp    1007f7 <console_vprintf+0x3c>
  100817:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  100819:	8d 42 cf             	lea    -0x31(%edx),%eax
  10081c:	3c 08                	cmp    $0x8,%al
  10081e:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100825:	00 
  100826:	76 13                	jbe    10083b <console_vprintf+0x80>
  100828:	eb 1d                	jmp    100847 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  10082a:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  10082f:	0f be c0             	movsbl %al,%eax
  100832:	47                   	inc    %edi
  100833:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  100837:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  10083b:	8a 07                	mov    (%edi),%al
  10083d:	8d 50 d0             	lea    -0x30(%eax),%edx
  100840:	80 fa 09             	cmp    $0x9,%dl
  100843:	76 e5                	jbe    10082a <console_vprintf+0x6f>
  100845:	eb 18                	jmp    10085f <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  100847:	80 fa 2a             	cmp    $0x2a,%dl
  10084a:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  100851:	ff 
  100852:	75 0b                	jne    10085f <console_vprintf+0xa4>
			width = va_arg(val, int);
  100854:	83 c3 04             	add    $0x4,%ebx
			++format;
  100857:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  100858:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10085b:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  10085f:	83 cd ff             	or     $0xffffffff,%ebp
  100862:	80 3f 2e             	cmpb   $0x2e,(%edi)
  100865:	75 37                	jne    10089e <console_vprintf+0xe3>
			++format;
  100867:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  100868:	31 ed                	xor    %ebp,%ebp
  10086a:	8a 07                	mov    (%edi),%al
  10086c:	8d 50 d0             	lea    -0x30(%eax),%edx
  10086f:	80 fa 09             	cmp    $0x9,%dl
  100872:	76 0d                	jbe    100881 <console_vprintf+0xc6>
  100874:	eb 17                	jmp    10088d <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  100876:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  100879:	0f be c0             	movsbl %al,%eax
  10087c:	47                   	inc    %edi
  10087d:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  100881:	8a 07                	mov    (%edi),%al
  100883:	8d 50 d0             	lea    -0x30(%eax),%edx
  100886:	80 fa 09             	cmp    $0x9,%dl
  100889:	76 eb                	jbe    100876 <console_vprintf+0xbb>
  10088b:	eb 11                	jmp    10089e <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  10088d:	3c 2a                	cmp    $0x2a,%al
  10088f:	75 0b                	jne    10089c <console_vprintf+0xe1>
				precision = va_arg(val, int);
  100891:	83 c3 04             	add    $0x4,%ebx
				++format;
  100894:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  100895:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  100898:	85 ed                	test   %ebp,%ebp
  10089a:	79 02                	jns    10089e <console_vprintf+0xe3>
  10089c:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  10089e:	8a 07                	mov    (%edi),%al
  1008a0:	3c 64                	cmp    $0x64,%al
  1008a2:	74 34                	je     1008d8 <console_vprintf+0x11d>
  1008a4:	7f 1d                	jg     1008c3 <console_vprintf+0x108>
  1008a6:	3c 58                	cmp    $0x58,%al
  1008a8:	0f 84 a2 00 00 00    	je     100950 <console_vprintf+0x195>
  1008ae:	3c 63                	cmp    $0x63,%al
  1008b0:	0f 84 bf 00 00 00    	je     100975 <console_vprintf+0x1ba>
  1008b6:	3c 43                	cmp    $0x43,%al
  1008b8:	0f 85 d0 00 00 00    	jne    10098e <console_vprintf+0x1d3>
  1008be:	e9 a3 00 00 00       	jmp    100966 <console_vprintf+0x1ab>
  1008c3:	3c 75                	cmp    $0x75,%al
  1008c5:	74 4d                	je     100914 <console_vprintf+0x159>
  1008c7:	3c 78                	cmp    $0x78,%al
  1008c9:	74 5c                	je     100927 <console_vprintf+0x16c>
  1008cb:	3c 73                	cmp    $0x73,%al
  1008cd:	0f 85 bb 00 00 00    	jne    10098e <console_vprintf+0x1d3>
  1008d3:	e9 86 00 00 00       	jmp    10095e <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  1008d8:	83 c3 04             	add    $0x4,%ebx
  1008db:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  1008de:	89 d1                	mov    %edx,%ecx
  1008e0:	c1 f9 1f             	sar    $0x1f,%ecx
  1008e3:	89 0c 24             	mov    %ecx,(%esp)
  1008e6:	31 ca                	xor    %ecx,%edx
  1008e8:	55                   	push   %ebp
  1008e9:	29 ca                	sub    %ecx,%edx
  1008eb:	68 a4 0b 10 00       	push   $0x100ba4
  1008f0:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1008f5:	8d 44 24 40          	lea    0x40(%esp),%eax
  1008f9:	e8 90 fe ff ff       	call   10078e <fill_numbuf>
  1008fe:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  100902:	58                   	pop    %eax
  100903:	5a                   	pop    %edx
  100904:	ba 01 00 00 00       	mov    $0x1,%edx
  100909:	8b 04 24             	mov    (%esp),%eax
  10090c:	83 e0 01             	and    $0x1,%eax
  10090f:	e9 a5 00 00 00       	jmp    1009b9 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  100914:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  100917:	b9 0a 00 00 00       	mov    $0xa,%ecx
  10091c:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10091f:	55                   	push   %ebp
  100920:	68 a4 0b 10 00       	push   $0x100ba4
  100925:	eb 11                	jmp    100938 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  100927:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  10092a:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10092d:	55                   	push   %ebp
  10092e:	68 b8 0b 10 00       	push   $0x100bb8
  100933:	b9 10 00 00 00       	mov    $0x10,%ecx
  100938:	8d 44 24 40          	lea    0x40(%esp),%eax
  10093c:	e8 4d fe ff ff       	call   10078e <fill_numbuf>
  100941:	ba 01 00 00 00       	mov    $0x1,%edx
  100946:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10094a:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  10094c:	59                   	pop    %ecx
  10094d:	59                   	pop    %ecx
  10094e:	eb 69                	jmp    1009b9 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  100950:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  100953:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100956:	55                   	push   %ebp
  100957:	68 a4 0b 10 00       	push   $0x100ba4
  10095c:	eb d5                	jmp    100933 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  10095e:	83 c3 04             	add    $0x4,%ebx
  100961:	8b 43 fc             	mov    -0x4(%ebx),%eax
  100964:	eb 40                	jmp    1009a6 <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  100966:	83 c3 04             	add    $0x4,%ebx
  100969:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10096c:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  100970:	e9 bd 01 00 00       	jmp    100b32 <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100975:	83 c3 04             	add    $0x4,%ebx
  100978:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  10097b:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  10097f:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100984:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100988:	88 44 24 24          	mov    %al,0x24(%esp)
  10098c:	eb 27                	jmp    1009b5 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  10098e:	84 c0                	test   %al,%al
  100990:	75 02                	jne    100994 <console_vprintf+0x1d9>
  100992:	b0 25                	mov    $0x25,%al
  100994:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100998:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  10099d:	80 3f 00             	cmpb   $0x0,(%edi)
  1009a0:	74 0a                	je     1009ac <console_vprintf+0x1f1>
  1009a2:	8d 44 24 24          	lea    0x24(%esp),%eax
  1009a6:	89 44 24 04          	mov    %eax,0x4(%esp)
  1009aa:	eb 09                	jmp    1009b5 <console_vprintf+0x1fa>
				format--;
  1009ac:	8d 54 24 24          	lea    0x24(%esp),%edx
  1009b0:	4f                   	dec    %edi
  1009b1:	89 54 24 04          	mov    %edx,0x4(%esp)
  1009b5:	31 d2                	xor    %edx,%edx
  1009b7:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1009b9:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  1009bb:	83 fd ff             	cmp    $0xffffffff,%ebp
  1009be:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1009c5:	74 1f                	je     1009e6 <console_vprintf+0x22b>
  1009c7:	89 04 24             	mov    %eax,(%esp)
  1009ca:	eb 01                	jmp    1009cd <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  1009cc:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1009cd:	39 e9                	cmp    %ebp,%ecx
  1009cf:	74 0a                	je     1009db <console_vprintf+0x220>
  1009d1:	8b 44 24 04          	mov    0x4(%esp),%eax
  1009d5:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  1009d9:	75 f1                	jne    1009cc <console_vprintf+0x211>
  1009db:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1009de:	89 0c 24             	mov    %ecx,(%esp)
  1009e1:	eb 1f                	jmp    100a02 <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  1009e3:	42                   	inc    %edx
  1009e4:	eb 09                	jmp    1009ef <console_vprintf+0x234>
  1009e6:	89 d1                	mov    %edx,%ecx
  1009e8:	8b 14 24             	mov    (%esp),%edx
  1009eb:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1009ef:	8b 44 24 04          	mov    0x4(%esp),%eax
  1009f3:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  1009f7:	75 ea                	jne    1009e3 <console_vprintf+0x228>
  1009f9:	8b 44 24 08          	mov    0x8(%esp),%eax
  1009fd:	89 14 24             	mov    %edx,(%esp)
  100a00:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  100a02:	85 c0                	test   %eax,%eax
  100a04:	74 0c                	je     100a12 <console_vprintf+0x257>
  100a06:	84 d2                	test   %dl,%dl
  100a08:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  100a0f:	00 
  100a10:	75 24                	jne    100a36 <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  100a12:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  100a17:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  100a1e:	00 
  100a1f:	75 15                	jne    100a36 <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100a21:	8b 44 24 14          	mov    0x14(%esp),%eax
  100a25:	83 e0 08             	and    $0x8,%eax
  100a28:	83 f8 01             	cmp    $0x1,%eax
  100a2b:	19 c9                	sbb    %ecx,%ecx
  100a2d:	f7 d1                	not    %ecx
  100a2f:	83 e1 20             	and    $0x20,%ecx
  100a32:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100a36:	3b 2c 24             	cmp    (%esp),%ebp
  100a39:	7e 0d                	jle    100a48 <console_vprintf+0x28d>
  100a3b:	84 d2                	test   %dl,%dl
  100a3d:	74 40                	je     100a7f <console_vprintf+0x2c4>
			zeros = precision - len;
  100a3f:	2b 2c 24             	sub    (%esp),%ebp
  100a42:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100a46:	eb 3f                	jmp    100a87 <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a48:	84 d2                	test   %dl,%dl
  100a4a:	74 33                	je     100a7f <console_vprintf+0x2c4>
  100a4c:	8b 44 24 14          	mov    0x14(%esp),%eax
  100a50:	83 e0 06             	and    $0x6,%eax
  100a53:	83 f8 02             	cmp    $0x2,%eax
  100a56:	75 27                	jne    100a7f <console_vprintf+0x2c4>
  100a58:	45                   	inc    %ebp
  100a59:	75 24                	jne    100a7f <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  100a5b:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a5d:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100a60:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a65:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a68:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100a6b:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100a6f:	7d 0e                	jge    100a7f <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100a71:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100a75:	29 ca                	sub    %ecx,%edx
  100a77:	29 c2                	sub    %eax,%edx
  100a79:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a7d:	eb 08                	jmp    100a87 <console_vprintf+0x2cc>
  100a7f:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100a86:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a87:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100a8b:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a8d:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a91:	2b 2c 24             	sub    (%esp),%ebp
  100a94:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a99:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a9c:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a9f:	29 c5                	sub    %eax,%ebp
  100aa1:	89 f0                	mov    %esi,%eax
  100aa3:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100aa7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100aab:	eb 0f                	jmp    100abc <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100aad:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100ab1:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100ab6:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100ab7:	e8 83 fc ff ff       	call   10073f <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100abc:	85 ed                	test   %ebp,%ebp
  100abe:	7e 07                	jle    100ac7 <console_vprintf+0x30c>
  100ac0:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100ac5:	74 e6                	je     100aad <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100ac7:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100acc:	89 c6                	mov    %eax,%esi
  100ace:	74 23                	je     100af3 <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100ad0:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100ad5:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100ad9:	e8 61 fc ff ff       	call   10073f <console_putc>
  100ade:	89 c6                	mov    %eax,%esi
  100ae0:	eb 11                	jmp    100af3 <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100ae2:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100ae6:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100aeb:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100aec:	e8 4e fc ff ff       	call   10073f <console_putc>
  100af1:	eb 06                	jmp    100af9 <console_vprintf+0x33e>
  100af3:	89 f0                	mov    %esi,%eax
  100af5:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100af9:	85 f6                	test   %esi,%esi
  100afb:	7f e5                	jg     100ae2 <console_vprintf+0x327>
  100afd:	8b 34 24             	mov    (%esp),%esi
  100b00:	eb 15                	jmp    100b17 <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100b02:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100b06:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100b07:	0f b6 11             	movzbl (%ecx),%edx
  100b0a:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b0e:	e8 2c fc ff ff       	call   10073f <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100b13:	ff 44 24 04          	incl   0x4(%esp)
  100b17:	85 f6                	test   %esi,%esi
  100b19:	7f e7                	jg     100b02 <console_vprintf+0x347>
  100b1b:	eb 0f                	jmp    100b2c <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100b1d:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b21:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100b26:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100b27:	e8 13 fc ff ff       	call   10073f <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100b2c:	85 ed                	test   %ebp,%ebp
  100b2e:	7f ed                	jg     100b1d <console_vprintf+0x362>
  100b30:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100b32:	47                   	inc    %edi
  100b33:	8a 17                	mov    (%edi),%dl
  100b35:	84 d2                	test   %dl,%dl
  100b37:	0f 85 96 fc ff ff    	jne    1007d3 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100b3d:	83 c4 38             	add    $0x38,%esp
  100b40:	89 f0                	mov    %esi,%eax
  100b42:	5b                   	pop    %ebx
  100b43:	5e                   	pop    %esi
  100b44:	5f                   	pop    %edi
  100b45:	5d                   	pop    %ebp
  100b46:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100b47:	81 e9 9c 0b 10 00    	sub    $0x100b9c,%ecx
  100b4d:	b8 01 00 00 00       	mov    $0x1,%eax
  100b52:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100b54:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100b55:	09 44 24 14          	or     %eax,0x14(%esp)
  100b59:	e9 aa fc ff ff       	jmp    100808 <console_vprintf+0x4d>

00100b5e <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100b5e:	8d 44 24 10          	lea    0x10(%esp),%eax
  100b62:	50                   	push   %eax
  100b63:	ff 74 24 10          	pushl  0x10(%esp)
  100b67:	ff 74 24 10          	pushl  0x10(%esp)
  100b6b:	ff 74 24 10          	pushl  0x10(%esp)
  100b6f:	e8 47 fc ff ff       	call   1007bb <console_vprintf>
  100b74:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100b77:	c3                   	ret    
