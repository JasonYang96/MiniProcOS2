
obj/schedos-2:     file format elf32-i386


Disassembly of section .text:

00300000 <start>:
}

static inline void
sys_priority(int priority)
{
	asm volatile("int %0\n"
  300000:	b8 04 00 00 00       	mov    $0x4,%eax
  300005:	cd 32                	int    $0x32
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  300007:	cd 30                	int    $0x30
  300009:	30 c0                	xor    %al,%al
	sys_yield();
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
		*cursorpos++ = PRINTCHAR;
  30000b:	8b 15 00 80 19 00    	mov    0x198000,%edx
  300011:	66 c7 02 32 0a       	movw   $0xa32,(%edx)
  300016:	83 c2 02             	add    $0x2,%edx
  300019:	89 15 00 80 19 00    	mov    %edx,0x198000
  30001f:	cd 30                	int    $0x30
{
	sys_priority(PRIORITY);
	sys_yield();
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
  300021:	40                   	inc    %eax
  300022:	3d 40 01 00 00       	cmp    $0x140,%eax
  300027:	75 e2                	jne    30000b <start+0xb>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  300029:	66 31 c0             	xor    %ax,%ax
  30002c:	cd 31                	int    $0x31
  30002e:	eb fe                	jmp    30002e <start+0x2e>
