
obj/schedos-1:     file format elf32-i386


Disassembly of section .text:

00200000 <start>:
#define SHARE 4
#endif

void
start(void)
{
  200000:	53                   	push   %ebx
 *****************************************************************************/

static inline void
sys_priority(int priority)
{
	asm volatile("int %0\n"
  200001:	b8 04 00 00 00       	mov    $0x4,%eax
  200006:	cd 32                	int    $0x32
 *****************************************************************************/

static inline void
sys_share(int share)
{
	asm volatile("int %0\n"
  200008:	cd 33                	int    $0x33
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  20000a:	cd 30                	int    $0x30
  20000c:	31 d2                	xor    %edx,%edx
static inline uint32_t compare_and_swap(uint32_t *addr, uint32_t expected, uint32_t desired) __attribute__((always_inline));

static inline uint32_t
compare_and_swap(uint32_t *addr, uint32_t expected, uint32_t desired)
{
	asm volatile("lock cmpxchg %2,%1"
  20000e:	b9 01 00 00 00       	mov    $0x1,%ecx
  200013:	31 db                	xor    %ebx,%ebx
  200015:	89 d8                	mov    %ebx,%eax
  200017:	f0 0f b1 0d 04 80 19 	lock cmpxchg %ecx,0x198004
  20001e:	00 
	sys_share(SHARE);
	sys_yield();
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
		while (compare_and_swap(&lock, 0, 1) != 1)
  20001f:	48                   	dec    %eax
  200020:	75 f3                	jne    200015 <start+0x15>
			continue;
		// Write characters to the console, yielding after each one.
		*cursorpos++ = PRINTCHAR;
  200022:	a1 00 80 19 00       	mov    0x198000,%eax
  200027:	66 c7 00 31 0c       	movw   $0xc31,(%eax)
  20002c:	83 c0 02             	add    $0x2,%eax
  20002f:	a3 00 80 19 00       	mov    %eax,0x198000
static inline uint32_t atomic_swap(uint32_t *addr, uint32_t val) __attribute__((always_inline));

static inline uint32_t
atomic_swap(uint32_t *addr, uint32_t val)
{
	asm volatile("xchgl %0, %1"
  200034:	31 c0                	xor    %eax,%eax
  200036:	87 05 04 80 19 00    	xchg   %eax,0x198004
  20003c:	cd 30                	int    $0x30
	sys_priority(PRIORITY);
	sys_share(SHARE);
	sys_yield();
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
  20003e:	42                   	inc    %edx
  20003f:	81 fa 40 01 00 00    	cmp    $0x140,%edx
  200045:	75 ce                	jne    200015 <start+0x15>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  200047:	31 c0                	xor    %eax,%eax
  200049:	cd 31                	int    $0x31
  20004b:	eb fe                	jmp    20004b <start+0x4b>
