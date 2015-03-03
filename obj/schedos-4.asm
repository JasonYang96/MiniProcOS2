
obj/schedos-4:     file format elf32-i386


Disassembly of section .text:

00500000 <start>:

#define LOCK

void
start(void)
{
  500000:	53                   	push   %ebx
 *****************************************************************************/

static inline void
sys_share(unsigned int share)
{
	asm volatile("int %0\n"
  500001:	b8 04 00 00 00       	mov    $0x4,%eax
  500006:	cd 33                	int    $0x33
 *****************************************************************************/

static inline void
sys_priority(unsigned int priority)
{
	asm volatile("int %0\n"
  500008:	b0 03                	mov    $0x3,%al
  50000a:	cd 32                	int    $0x32
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  50000c:	cd 30                	int    $0x30
  50000e:	31 d2                	xor    %edx,%edx
static inline uint32_t compare_and_swap(uint32_t *addr, uint32_t expected, uint32_t desired) __attribute__((always_inline));

static inline uint32_t
compare_and_swap(uint32_t *addr, uint32_t expected, uint32_t desired)
{
	asm volatile("lock cmpxchg %2,%1"
  500010:	b9 01 00 00 00       	mov    $0x1,%ecx
  500015:	31 db                	xor    %ebx,%ebx
  500017:	89 d8                	mov    %ebx,%eax
  500019:	f0 0f b1 0d 04 80 19 	lock cmpxchg %ecx,0x198004
  500020:	00 
	for (i = 0; i < RUNCOUNT; i++) {
		#ifndef LOCK
			sys_print(PRINTCHAR);
		#endif
		#ifdef LOCK
			while (compare_and_swap(&lock, 0, 1) != 0)
  500021:	85 c0                	test   %eax,%eax
  500023:	75 f2                	jne    500017 <start+0x17>
				continue;
			// Write characters to the console, yielding after each one.
			*cursorpos++ = PRINTCHAR;
  500025:	a1 00 80 19 00       	mov    0x198000,%eax
  50002a:	66 c7 00 34 0e       	movw   $0xe34,(%eax)
  50002f:	83 c0 02             	add    $0x2,%eax
  500032:	a3 00 80 19 00       	mov    %eax,0x198000
static inline uint32_t atomic_swap(uint32_t *addr, uint32_t val) __attribute__((always_inline));

static inline uint32_t
atomic_swap(uint32_t *addr, uint32_t val)
{
	asm volatile("xchgl %0, %1"
  500037:	31 c0                	xor    %eax,%eax
  500039:	87 05 04 80 19 00    	xchg   %eax,0x198004
  50003f:	cd 30                	int    $0x30
	sys_share(SHARE);
	sys_priority(PRIORITY);
	sys_yield();
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
  500041:	42                   	inc    %edx
  500042:	81 fa 40 01 00 00    	cmp    $0x140,%edx
  500048:	75 cd                	jne    500017 <start+0x17>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  50004a:	31 c0                	xor    %eax,%eax
  50004c:	cd 31                	int    $0x31
  50004e:	eb fe                	jmp    50004e <start+0x4e>
