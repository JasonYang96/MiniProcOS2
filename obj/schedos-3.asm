
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
  400021:	83 f8 01             	cmp    $0x1,%eax
  400024:	75 f1                	jne    400017 <start+0x17>
 *****************************************************************************/

static inline void
sys_print(unsigned int printchar)
{
	asm volatile("int %0\n"
  400026:	66 b8 33 09          	mov    $0x933,%ax
  40002a:	cd 34                	int    $0x34
static inline uint32_t atomic_swap(uint32_t *addr, uint32_t val) __attribute__((always_inline));

static inline uint32_t
atomic_swap(uint32_t *addr, uint32_t val)
{
	asm volatile("xchgl %0, %1"
  40002c:	66 31 c0             	xor    %ax,%ax
  40002f:	87 05 04 80 19 00    	xchg   %eax,0x198004
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  400035:	cd 30                	int    $0x30
	sys_priority(PRIORITY);
	sys_share(SHARE);
	sys_yield();
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
  400037:	42                   	inc    %edx
  400038:	81 fa 40 01 00 00    	cmp    $0x140,%edx
  40003e:	75 d7                	jne    400017 <start+0x17>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  400040:	31 c0                	xor    %eax,%eax
  400042:	cd 31                	int    $0x31
  400044:	eb fe                	jmp    400044 <start+0x44>
