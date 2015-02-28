
obj/schedos-3:     file format elf32-i386


Disassembly of section .text:

00400000 <start>:
#define SHARE 4
#endif

void
start(void)
{
  400000:	53                   	push   %ebx
 *****************************************************************************/

static inline void
sys_priority(int priority)
{
	asm volatile("int %0\n"
  400001:	b8 04 00 00 00       	mov    $0x4,%eax
  400006:	cd 32                	int    $0x32
 *****************************************************************************/

static inline void
sys_share(int share)
{
	asm volatile("int %0\n"
  400008:	b0 02                	mov    $0x2,%al
  40000a:	cd 33                	int    $0x33
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  40000c:	cd 30                	int    $0x30
  40000e:	31 d2                	xor    %edx,%edx
static inline uint32_t compare_and_swap(uint32_t *addr, uint32_t expected, uint32_t desired) __attribute__((always_inline));

static inline uint32_t
compare_and_swap(uint32_t *addr, uint32_t expected, uint32_t desired)
{
	asm volatile("lock cmpxchg %2,%1"
  400010:	b9 01 00 00 00       	mov    $0x1,%ecx
  400015:	31 db                	xor    %ebx,%ebx
  400017:	89 d8                	mov    %ebx,%eax
  400019:	f0 0f b1 0d 04 80 19 	lock cmpxchg %ecx,0x198004
  400020:	00 
	sys_share(SHARE);
	sys_yield();
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
		while (compare_and_swap(&lock, 0, 1) != 1)
  400021:	48                   	dec    %eax
  400022:	75 f3                	jne    400017 <start+0x17>
			continue;
		// Write characters to the console, yielding after each one.
		*cursorpos++ = PRINTCHAR;
  400024:	a1 00 80 19 00       	mov    0x198000,%eax
  400029:	66 c7 00 33 09       	movw   $0x933,(%eax)
  40002e:	83 c0 02             	add    $0x2,%eax
  400031:	a3 00 80 19 00       	mov    %eax,0x198000
static inline uint32_t atomic_swap(uint32_t *addr, uint32_t val) __attribute__((always_inline));

static inline uint32_t
atomic_swap(uint32_t *addr, uint32_t val)
{
	asm volatile("xchgl %0, %1"
  400036:	31 c0                	xor    %eax,%eax
  400038:	87 05 04 80 19 00    	xchg   %eax,0x198004
  40003e:	cd 30                	int    $0x30
	sys_priority(PRIORITY);
	sys_share(SHARE);
	sys_yield();
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
  400040:	42                   	inc    %edx
  400041:	81 fa 40 01 00 00    	cmp    $0x140,%edx
  400047:	75 ce                	jne    400017 <start+0x17>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  400049:	31 c0                	xor    %eax,%eax
  40004b:	cd 31                	int    $0x31
  40004d:	eb fe                	jmp    40004d <start+0x4d>
