
obj/schedos-1:     file format elf32-i386


Disassembly of section .text:

00200000 <start>:
}

static inline void
sys_priority(int priority)
{
	asm volatile("int %0\n"
  200000:	b8 04 00 00 00       	mov    $0x4,%eax
  200005:	cd 32                	int    $0x32
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  200007:	cd 30                	int    $0x30
  200009:	30 c0                	xor    %al,%al
	sys_yield();
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
		*cursorpos++ = PRINTCHAR;
  20000b:	8b 15 00 80 19 00    	mov    0x198000,%edx
  200011:	66 c7 02 31 0c       	movw   $0xc31,(%edx)
  200016:	83 c2 02             	add    $0x2,%edx
  200019:	89 15 00 80 19 00    	mov    %edx,0x198000
  20001f:	cd 30                	int    $0x30
{
	sys_priority(PRIORITY);
	sys_yield();
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
  200021:	40                   	inc    %eax
  200022:	3d 40 01 00 00       	cmp    $0x140,%eax
  200027:	75 e2                	jne    20000b <start+0xb>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  200029:	66 31 c0             	xor    %ax,%ax
  20002c:	cd 31                	int    $0x31
  20002e:	eb fe                	jmp    20002e <start+0x2e>
