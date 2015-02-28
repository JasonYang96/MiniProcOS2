
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
  20001f:	83 f8 01             	cmp    $0x1,%eax
  200022:	75 f1                	jne    200015 <start+0x15>
 *****************************************************************************/

static inline void
sys_print(unsigned int printchar)
{
	asm volatile("int %0\n"
  200024:	66 b8 31 0c          	mov    $0xc31,%ax
  200028:	cd 34                	int    $0x34
static inline uint32_t atomic_swap(uint32_t *addr, uint32_t val) __attribute__((always_inline));

static inline uint32_t
atomic_swap(uint32_t *addr, uint32_t val)
{
	asm volatile("xchgl %0, %1"
  20002a:	66 31 c0             	xor    %ax,%ax
  20002d:	87 05 04 80 19 00    	xchg   %eax,0x198004
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  200033:	cd 30                	int    $0x30
	sys_priority(PRIORITY);
	sys_share(SHARE);
	sys_yield();
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
  200035:	42                   	inc    %edx
  200036:	81 fa 40 01 00 00    	cmp    $0x140,%edx
  20003c:	75 d7                	jne    200015 <start+0x15>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  20003e:	31 c0                	xor    %eax,%eax
  200040:	cd 31                	int    $0x31
  200042:	eb fe                	jmp    200042 <start+0x42>
