
obj/schedos-4:     file format elf32-i386


Disassembly of section .text:

00500000 <start>:
}

static inline void
sys_priority(int priority)
{
	asm volatile("int %0\n"
  500000:	b8 04 00 00 00       	mov    $0x4,%eax
  500005:	cd 32                	int    $0x32
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  500007:	cd 30                	int    $0x30
  500009:	30 c0                	xor    %al,%al
	sys_yield();
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
		*cursorpos++ = PRINTCHAR;
  50000b:	8b 15 00 80 19 00    	mov    0x198000,%edx
  500011:	66 c7 02 34 0e       	movw   $0xe34,(%edx)
  500016:	83 c2 02             	add    $0x2,%edx
  500019:	89 15 00 80 19 00    	mov    %edx,0x198000
  50001f:	cd 30                	int    $0x30
{
	sys_priority(PRIORITY);
	sys_yield();
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
  500021:	40                   	inc    %eax
  500022:	3d 40 01 00 00       	cmp    $0x140,%eax
  500027:	75 e2                	jne    50000b <start+0xb>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  500029:	66 31 c0             	xor    %ax,%ax
  50002c:	cd 31                	int    $0x31
  50002e:	eb fe                	jmp    50002e <start+0x2e>
