
obj/schedos-4:     file format elf32-i386


Disassembly of section .text:

00500000 <start>:
#define SHARE 4
#endif

void
start(void)
{
  500000:	53                   	push   %ebx
 *****************************************************************************/

static inline void
sys_priority(int priority)
{
	asm volatile("int %0\n"
  500001:	b8 04 00 00 00       	mov    $0x4,%eax
  500006:	cd 32                	int    $0x32
 *****************************************************************************/

static inline void
sys_share(int share)
{
	asm volatile("int %0\n"
  500008:	b0 01                	mov    $0x1,%al
  50000a:	cd 33                	int    $0x33
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
	sys_share(SHARE);
	sys_yield();
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
		while (compare_and_swap(&lock, 0, 1) != 1)
  500021:	48                   	dec    %eax
  500022:	75 f3                	jne    500017 <start+0x17>
			continue;
		// Write characters to the console, yielding after each one.
		*cursorpos++ = PRINTCHAR;
  500024:	a1 00 80 19 00       	mov    0x198000,%eax
  500029:	66 c7 00 34 0e       	movw   $0xe34,(%eax)
  50002e:	83 c0 02             	add    $0x2,%eax
  500031:	a3 00 80 19 00       	mov    %eax,0x198000
static inline uint32_t atomic_swap(uint32_t *addr, uint32_t val) __attribute__((always_inline));

static inline uint32_t
atomic_swap(uint32_t *addr, uint32_t val)
{
	asm volatile("xchgl %0, %1"
  500036:	31 c0                	xor    %eax,%eax
  500038:	87 05 04 80 19 00    	xchg   %eax,0x198004
  50003e:	cd 30                	int    $0x30
	sys_priority(PRIORITY);
	sys_share(SHARE);
	sys_yield();
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
  500040:	42                   	inc    %edx
  500041:	81 fa 40 01 00 00    	cmp    $0x140,%edx
  500047:	75 ce                	jne    500017 <start+0x17>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  500049:	31 c0                	xor    %eax,%eax
  50004b:	cd 31                	int    $0x31
  50004d:	eb fe                	jmp    50004d <start+0x4d>
