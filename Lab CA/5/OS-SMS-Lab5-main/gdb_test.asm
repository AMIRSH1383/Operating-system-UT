
_gdb_test:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "stat.h"
#include "user.h"

int main(){
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
    int pid = getpid();
  11:	e8 dd 02 00 00       	call   2f3 <getpid>
    printf(1,"Process pid = %d \n" ,pid);
  16:	83 ec 04             	sub    $0x4,%esp
  19:	50                   	push   %eax
  1a:	68 68 07 00 00       	push   $0x768
  1f:	6a 01                	push   $0x1
  21:	e8 da 03 00 00       	call   400 <printf>
    exit();
  26:	e8 48 02 00 00       	call   273 <exit>
  2b:	66 90                	xchg   %ax,%ax
  2d:	66 90                	xchg   %ax,%ax
  2f:	90                   	nop

00000030 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  30:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  31:	31 c0                	xor    %eax,%eax
{
  33:	89 e5                	mov    %esp,%ebp
  35:	53                   	push   %ebx
  36:	8b 4d 08             	mov    0x8(%ebp),%ecx
  39:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  40:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  44:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  47:	83 c0 01             	add    $0x1,%eax
  4a:	84 d2                	test   %dl,%dl
  4c:	75 f2                	jne    40 <strcpy+0x10>
    ;
  return os;
}
  4e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  51:	89 c8                	mov    %ecx,%eax
  53:	c9                   	leave
  54:	c3                   	ret
  55:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  5c:	00 
  5d:	8d 76 00             	lea    0x0(%esi),%esi

00000060 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	53                   	push   %ebx
  64:	8b 4d 08             	mov    0x8(%ebp),%ecx
  67:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  6a:	0f b6 01             	movzbl (%ecx),%eax
  6d:	0f b6 1a             	movzbl (%edx),%ebx
  70:	84 c0                	test   %al,%al
  72:	75 1c                	jne    90 <strcmp+0x30>
  74:	eb 2e                	jmp    a4 <strcmp+0x44>
  76:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  7d:	00 
  7e:	66 90                	xchg   %ax,%ax
  80:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
  84:	83 c1 01             	add    $0x1,%ecx
  87:	8d 5a 01             	lea    0x1(%edx),%ebx
  while(*p && *p == *q)
  8a:	84 c0                	test   %al,%al
  8c:	74 12                	je     a0 <strcmp+0x40>
    p++, q++;
  8e:	89 da                	mov    %ebx,%edx
  while(*p && *p == *q)
  90:	0f b6 1a             	movzbl (%edx),%ebx
  93:	38 c3                	cmp    %al,%bl
  95:	74 e9                	je     80 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
  97:	29 d8                	sub    %ebx,%eax
}
  99:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  9c:	c9                   	leave
  9d:	c3                   	ret
  9e:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
  a0:	0f b6 5a 01          	movzbl 0x1(%edx),%ebx
  a4:	31 c0                	xor    %eax,%eax
  a6:	29 d8                	sub    %ebx,%eax
}
  a8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  ab:	c9                   	leave
  ac:	c3                   	ret
  ad:	8d 76 00             	lea    0x0(%esi),%esi

000000b0 <strlen>:

uint
strlen(const char *s)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  b6:	80 3a 00             	cmpb   $0x0,(%edx)
  b9:	74 15                	je     d0 <strlen+0x20>
  bb:	31 c0                	xor    %eax,%eax
  bd:	8d 76 00             	lea    0x0(%esi),%esi
  c0:	83 c0 01             	add    $0x1,%eax
  c3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  c7:	89 c1                	mov    %eax,%ecx
  c9:	75 f5                	jne    c0 <strlen+0x10>
    ;
  return n;
}
  cb:	89 c8                	mov    %ecx,%eax
  cd:	5d                   	pop    %ebp
  ce:	c3                   	ret
  cf:	90                   	nop
  for(n = 0; s[n]; n++)
  d0:	31 c9                	xor    %ecx,%ecx
}
  d2:	5d                   	pop    %ebp
  d3:	89 c8                	mov    %ecx,%eax
  d5:	c3                   	ret
  d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  dd:	00 
  de:	66 90                	xchg   %ax,%ax

000000e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	57                   	push   %edi
  e4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  ed:	89 d7                	mov    %edx,%edi
  ef:	fc                   	cld
  f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  f2:	8b 7d fc             	mov    -0x4(%ebp),%edi
  f5:	89 d0                	mov    %edx,%eax
  f7:	c9                   	leave
  f8:	c3                   	ret
  f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000100 <strchr>:

char*
strchr(const char *s, char c)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 45 08             	mov    0x8(%ebp),%eax
 106:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 10a:	0f b6 10             	movzbl (%eax),%edx
 10d:	84 d2                	test   %dl,%dl
 10f:	75 12                	jne    123 <strchr+0x23>
 111:	eb 1d                	jmp    130 <strchr+0x30>
 113:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 118:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 11c:	83 c0 01             	add    $0x1,%eax
 11f:	84 d2                	test   %dl,%dl
 121:	74 0d                	je     130 <strchr+0x30>
    if(*s == c)
 123:	38 d1                	cmp    %dl,%cl
 125:	75 f1                	jne    118 <strchr+0x18>
      return (char*)s;
  return 0;
}
 127:	5d                   	pop    %ebp
 128:	c3                   	ret
 129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 130:	31 c0                	xor    %eax,%eax
}
 132:	5d                   	pop    %ebp
 133:	c3                   	ret
 134:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 13b:	00 
 13c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000140 <gets>:

char*
gets(char *buf, int max)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	57                   	push   %edi
 144:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 145:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 148:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 149:	31 db                	xor    %ebx,%ebx
{
 14b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 14e:	eb 27                	jmp    177 <gets+0x37>
    cc = read(0, &c, 1);
 150:	83 ec 04             	sub    $0x4,%esp
 153:	6a 01                	push   $0x1
 155:	57                   	push   %edi
 156:	6a 00                	push   $0x0
 158:	e8 2e 01 00 00       	call   28b <read>
    if(cc < 1)
 15d:	83 c4 10             	add    $0x10,%esp
 160:	85 c0                	test   %eax,%eax
 162:	7e 1d                	jle    181 <gets+0x41>
      break;
    buf[i++] = c;
 164:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 168:	8b 55 08             	mov    0x8(%ebp),%edx
 16b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 16f:	3c 0a                	cmp    $0xa,%al
 171:	74 1d                	je     190 <gets+0x50>
 173:	3c 0d                	cmp    $0xd,%al
 175:	74 19                	je     190 <gets+0x50>
  for(i=0; i+1 < max; ){
 177:	89 de                	mov    %ebx,%esi
 179:	83 c3 01             	add    $0x1,%ebx
 17c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 17f:	7c cf                	jl     150 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 181:	8b 45 08             	mov    0x8(%ebp),%eax
 184:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 188:	8d 65 f4             	lea    -0xc(%ebp),%esp
 18b:	5b                   	pop    %ebx
 18c:	5e                   	pop    %esi
 18d:	5f                   	pop    %edi
 18e:	5d                   	pop    %ebp
 18f:	c3                   	ret
  buf[i] = '\0';
 190:	8b 45 08             	mov    0x8(%ebp),%eax
 193:	89 de                	mov    %ebx,%esi
 195:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 199:	8d 65 f4             	lea    -0xc(%ebp),%esp
 19c:	5b                   	pop    %ebx
 19d:	5e                   	pop    %esi
 19e:	5f                   	pop    %edi
 19f:	5d                   	pop    %ebp
 1a0:	c3                   	ret
 1a1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1a8:	00 
 1a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001b0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	56                   	push   %esi
 1b4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1b5:	83 ec 08             	sub    $0x8,%esp
 1b8:	6a 00                	push   $0x0
 1ba:	ff 75 08             	push   0x8(%ebp)
 1bd:	e8 f1 00 00 00       	call   2b3 <open>
  if(fd < 0)
 1c2:	83 c4 10             	add    $0x10,%esp
 1c5:	85 c0                	test   %eax,%eax
 1c7:	78 27                	js     1f0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 1c9:	83 ec 08             	sub    $0x8,%esp
 1cc:	ff 75 0c             	push   0xc(%ebp)
 1cf:	89 c3                	mov    %eax,%ebx
 1d1:	50                   	push   %eax
 1d2:	e8 f4 00 00 00       	call   2cb <fstat>
  close(fd);
 1d7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 1da:	89 c6                	mov    %eax,%esi
  close(fd);
 1dc:	e8 ba 00 00 00       	call   29b <close>
  return r;
 1e1:	83 c4 10             	add    $0x10,%esp
}
 1e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1e7:	89 f0                	mov    %esi,%eax
 1e9:	5b                   	pop    %ebx
 1ea:	5e                   	pop    %esi
 1eb:	5d                   	pop    %ebp
 1ec:	c3                   	ret
 1ed:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 1f0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1f5:	eb ed                	jmp    1e4 <stat+0x34>
 1f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1fe:	00 
 1ff:	90                   	nop

00000200 <atoi>:

int
atoi(const char *s)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	53                   	push   %ebx
 204:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 207:	0f be 02             	movsbl (%edx),%eax
 20a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 20d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 210:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 215:	77 1e                	ja     235 <atoi+0x35>
 217:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 21e:	00 
 21f:	90                   	nop
    n = n*10 + *s++ - '0';
 220:	83 c2 01             	add    $0x1,%edx
 223:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 226:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 22a:	0f be 02             	movsbl (%edx),%eax
 22d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 230:	80 fb 09             	cmp    $0x9,%bl
 233:	76 eb                	jbe    220 <atoi+0x20>
  return n;
}
 235:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 238:	89 c8                	mov    %ecx,%eax
 23a:	c9                   	leave
 23b:	c3                   	ret
 23c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000240 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	57                   	push   %edi
 244:	8b 45 10             	mov    0x10(%ebp),%eax
 247:	8b 55 08             	mov    0x8(%ebp),%edx
 24a:	56                   	push   %esi
 24b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 24e:	85 c0                	test   %eax,%eax
 250:	7e 13                	jle    265 <memmove+0x25>
 252:	01 d0                	add    %edx,%eax
  dst = vdst;
 254:	89 d7                	mov    %edx,%edi
 256:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 25d:	00 
 25e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 260:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 261:	39 f8                	cmp    %edi,%eax
 263:	75 fb                	jne    260 <memmove+0x20>
  return vdst;
}
 265:	5e                   	pop    %esi
 266:	89 d0                	mov    %edx,%eax
 268:	5f                   	pop    %edi
 269:	5d                   	pop    %ebp
 26a:	c3                   	ret

0000026b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 26b:	b8 01 00 00 00       	mov    $0x1,%eax
 270:	cd 40                	int    $0x40
 272:	c3                   	ret

00000273 <exit>:
SYSCALL(exit)
 273:	b8 02 00 00 00       	mov    $0x2,%eax
 278:	cd 40                	int    $0x40
 27a:	c3                   	ret

0000027b <wait>:
SYSCALL(wait)
 27b:	b8 03 00 00 00       	mov    $0x3,%eax
 280:	cd 40                	int    $0x40
 282:	c3                   	ret

00000283 <pipe>:
SYSCALL(pipe)
 283:	b8 04 00 00 00       	mov    $0x4,%eax
 288:	cd 40                	int    $0x40
 28a:	c3                   	ret

0000028b <read>:
SYSCALL(read)
 28b:	b8 05 00 00 00       	mov    $0x5,%eax
 290:	cd 40                	int    $0x40
 292:	c3                   	ret

00000293 <write>:
SYSCALL(write)
 293:	b8 10 00 00 00       	mov    $0x10,%eax
 298:	cd 40                	int    $0x40
 29a:	c3                   	ret

0000029b <close>:
SYSCALL(close)
 29b:	b8 15 00 00 00       	mov    $0x15,%eax
 2a0:	cd 40                	int    $0x40
 2a2:	c3                   	ret

000002a3 <kill>:
SYSCALL(kill)
 2a3:	b8 06 00 00 00       	mov    $0x6,%eax
 2a8:	cd 40                	int    $0x40
 2aa:	c3                   	ret

000002ab <exec>:
SYSCALL(exec)
 2ab:	b8 07 00 00 00       	mov    $0x7,%eax
 2b0:	cd 40                	int    $0x40
 2b2:	c3                   	ret

000002b3 <open>:
SYSCALL(open)
 2b3:	b8 0f 00 00 00       	mov    $0xf,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret

000002bb <mknod>:
SYSCALL(mknod)
 2bb:	b8 11 00 00 00       	mov    $0x11,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret

000002c3 <unlink>:
SYSCALL(unlink)
 2c3:	b8 12 00 00 00       	mov    $0x12,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret

000002cb <fstat>:
SYSCALL(fstat)
 2cb:	b8 08 00 00 00       	mov    $0x8,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret

000002d3 <link>:
SYSCALL(link)
 2d3:	b8 13 00 00 00       	mov    $0x13,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret

000002db <mkdir>:
SYSCALL(mkdir)
 2db:	b8 14 00 00 00       	mov    $0x14,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret

000002e3 <chdir>:
SYSCALL(chdir)
 2e3:	b8 09 00 00 00       	mov    $0x9,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret

000002eb <dup>:
SYSCALL(dup)
 2eb:	b8 0a 00 00 00       	mov    $0xa,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret

000002f3 <getpid>:
SYSCALL(getpid)
 2f3:	b8 0b 00 00 00       	mov    $0xb,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret

000002fb <sbrk>:
SYSCALL(sbrk)
 2fb:	b8 0c 00 00 00       	mov    $0xc,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret

00000303 <sleep>:
SYSCALL(sleep)
 303:	b8 0d 00 00 00       	mov    $0xd,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret

0000030b <uptime>:
SYSCALL(uptime)
 30b:	b8 0e 00 00 00       	mov    $0xe,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret

00000313 <create_palindrome>:
SYSCALL(create_palindrome)
 313:	b8 16 00 00 00       	mov    $0x16,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret

0000031b <sort_syscalls>:
SYSCALL(sort_syscalls)
 31b:	b8 17 00 00 00       	mov    $0x17,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret

00000323 <get_most_invoked_syscall>:
SYSCALL(get_most_invoked_syscall)
 323:	b8 18 00 00 00       	mov    $0x18,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret

0000032b <list_all_processes>:
SYSCALL(list_all_processes)
 32b:	b8 19 00 00 00       	mov    $0x19,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret

00000333 <move_file>:
SYSCALL(move_file)
 333:	b8 1a 00 00 00       	mov    $0x1a,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret

0000033b <open_sharedmem>:
SYSCALL(open_sharedmem)
 33b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret

00000343 <close_sharedmem>:
 343:	b8 1c 00 00 00       	mov    $0x1c,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret
 34b:	66 90                	xchg   %ax,%ax
 34d:	66 90                	xchg   %ax,%ax
 34f:	90                   	nop

00000350 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	57                   	push   %edi
 354:	56                   	push   %esi
 355:	53                   	push   %ebx
 356:	83 ec 3c             	sub    $0x3c,%esp
 359:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 35c:	89 d1                	mov    %edx,%ecx
{
 35e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 361:	85 d2                	test   %edx,%edx
 363:	0f 89 7f 00 00 00    	jns    3e8 <printint+0x98>
 369:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 36d:	74 79                	je     3e8 <printint+0x98>
    neg = 1;
 36f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 376:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 378:	31 db                	xor    %ebx,%ebx
 37a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 37d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 380:	89 c8                	mov    %ecx,%eax
 382:	31 d2                	xor    %edx,%edx
 384:	89 cf                	mov    %ecx,%edi
 386:	f7 75 c4             	divl   -0x3c(%ebp)
 389:	0f b6 92 84 07 00 00 	movzbl 0x784(%edx),%edx
 390:	89 45 c0             	mov    %eax,-0x40(%ebp)
 393:	89 d8                	mov    %ebx,%eax
 395:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 398:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 39b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 39e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 3a1:	76 dd                	jbe    380 <printint+0x30>
  if(neg)
 3a3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 3a6:	85 c9                	test   %ecx,%ecx
 3a8:	74 0c                	je     3b6 <printint+0x66>
    buf[i++] = '-';
 3aa:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 3af:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 3b1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 3b6:	8b 7d b8             	mov    -0x48(%ebp),%edi
 3b9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 3bd:	eb 07                	jmp    3c6 <printint+0x76>
 3bf:	90                   	nop
    putc(fd, buf[i]);
 3c0:	0f b6 13             	movzbl (%ebx),%edx
 3c3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 3c6:	83 ec 04             	sub    $0x4,%esp
 3c9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 3cc:	6a 01                	push   $0x1
 3ce:	56                   	push   %esi
 3cf:	57                   	push   %edi
 3d0:	e8 be fe ff ff       	call   293 <write>
  while(--i >= 0)
 3d5:	83 c4 10             	add    $0x10,%esp
 3d8:	39 de                	cmp    %ebx,%esi
 3da:	75 e4                	jne    3c0 <printint+0x70>
}
 3dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3df:	5b                   	pop    %ebx
 3e0:	5e                   	pop    %esi
 3e1:	5f                   	pop    %edi
 3e2:	5d                   	pop    %ebp
 3e3:	c3                   	ret
 3e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 3e8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 3ef:	eb 87                	jmp    378 <printint+0x28>
 3f1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3f8:	00 
 3f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000400 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	57                   	push   %edi
 404:	56                   	push   %esi
 405:	53                   	push   %ebx
 406:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 409:	8b 75 0c             	mov    0xc(%ebp),%esi
 40c:	0f b6 1e             	movzbl (%esi),%ebx
 40f:	84 db                	test   %bl,%bl
 411:	0f 84 b8 00 00 00    	je     4cf <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 417:	8d 45 10             	lea    0x10(%ebp),%eax
 41a:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 41d:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 420:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 422:	89 45 d0             	mov    %eax,-0x30(%ebp)
 425:	eb 37                	jmp    45e <printf+0x5e>
 427:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 42e:	00 
 42f:	90                   	nop
 430:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 433:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 438:	83 f8 25             	cmp    $0x25,%eax
 43b:	74 17                	je     454 <printf+0x54>
  write(fd, &c, 1);
 43d:	83 ec 04             	sub    $0x4,%esp
 440:	88 5d e7             	mov    %bl,-0x19(%ebp)
 443:	6a 01                	push   $0x1
 445:	57                   	push   %edi
 446:	ff 75 08             	push   0x8(%ebp)
 449:	e8 45 fe ff ff       	call   293 <write>
 44e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 451:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 454:	0f b6 1e             	movzbl (%esi),%ebx
 457:	83 c6 01             	add    $0x1,%esi
 45a:	84 db                	test   %bl,%bl
 45c:	74 71                	je     4cf <printf+0xcf>
    c = fmt[i] & 0xff;
 45e:	0f be cb             	movsbl %bl,%ecx
 461:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 464:	85 d2                	test   %edx,%edx
 466:	74 c8                	je     430 <printf+0x30>
      }
    } else if(state == '%'){
 468:	83 fa 25             	cmp    $0x25,%edx
 46b:	75 e7                	jne    454 <printf+0x54>
      if(c == 'd'){
 46d:	83 f8 64             	cmp    $0x64,%eax
 470:	0f 84 9a 00 00 00    	je     510 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 476:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 47c:	83 f9 70             	cmp    $0x70,%ecx
 47f:	74 5f                	je     4e0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 481:	83 f8 73             	cmp    $0x73,%eax
 484:	0f 84 d6 00 00 00    	je     560 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 48a:	83 f8 63             	cmp    $0x63,%eax
 48d:	0f 84 8d 00 00 00    	je     520 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 493:	83 f8 25             	cmp    $0x25,%eax
 496:	0f 84 b4 00 00 00    	je     550 <printf+0x150>
  write(fd, &c, 1);
 49c:	83 ec 04             	sub    $0x4,%esp
 49f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4a3:	6a 01                	push   $0x1
 4a5:	57                   	push   %edi
 4a6:	ff 75 08             	push   0x8(%ebp)
 4a9:	e8 e5 fd ff ff       	call   293 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 4ae:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 4b1:	83 c4 0c             	add    $0xc,%esp
 4b4:	6a 01                	push   $0x1
  for(i = 0; fmt[i]; i++){
 4b6:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 4b9:	57                   	push   %edi
 4ba:	ff 75 08             	push   0x8(%ebp)
 4bd:	e8 d1 fd ff ff       	call   293 <write>
  for(i = 0; fmt[i]; i++){
 4c2:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 4c6:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 4c9:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 4cb:	84 db                	test   %bl,%bl
 4cd:	75 8f                	jne    45e <printf+0x5e>
    }
  }
}
 4cf:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4d2:	5b                   	pop    %ebx
 4d3:	5e                   	pop    %esi
 4d4:	5f                   	pop    %edi
 4d5:	5d                   	pop    %ebp
 4d6:	c3                   	ret
 4d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4de:	00 
 4df:	90                   	nop
        printint(fd, *ap, 16, 0);
 4e0:	83 ec 0c             	sub    $0xc,%esp
 4e3:	b9 10 00 00 00       	mov    $0x10,%ecx
 4e8:	6a 00                	push   $0x0
 4ea:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 4ed:	8b 45 08             	mov    0x8(%ebp),%eax
 4f0:	8b 13                	mov    (%ebx),%edx
 4f2:	e8 59 fe ff ff       	call   350 <printint>
        ap++;
 4f7:	89 d8                	mov    %ebx,%eax
 4f9:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4fc:	31 d2                	xor    %edx,%edx
        ap++;
 4fe:	83 c0 04             	add    $0x4,%eax
 501:	89 45 d0             	mov    %eax,-0x30(%ebp)
 504:	e9 4b ff ff ff       	jmp    454 <printf+0x54>
 509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 510:	83 ec 0c             	sub    $0xc,%esp
 513:	b9 0a 00 00 00       	mov    $0xa,%ecx
 518:	6a 01                	push   $0x1
 51a:	eb ce                	jmp    4ea <printf+0xea>
 51c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 520:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 523:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 526:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 528:	6a 01                	push   $0x1
        ap++;
 52a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 52d:	57                   	push   %edi
 52e:	ff 75 08             	push   0x8(%ebp)
        putc(fd, *ap);
 531:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 534:	e8 5a fd ff ff       	call   293 <write>
        ap++;
 539:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 53c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 53f:	31 d2                	xor    %edx,%edx
 541:	e9 0e ff ff ff       	jmp    454 <printf+0x54>
 546:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 54d:	00 
 54e:	66 90                	xchg   %ax,%ax
        putc(fd, c);
 550:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 553:	83 ec 04             	sub    $0x4,%esp
 556:	e9 59 ff ff ff       	jmp    4b4 <printf+0xb4>
 55b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 560:	8b 45 d0             	mov    -0x30(%ebp),%eax
 563:	8b 18                	mov    (%eax),%ebx
        ap++;
 565:	83 c0 04             	add    $0x4,%eax
 568:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 56b:	85 db                	test   %ebx,%ebx
 56d:	74 17                	je     586 <printf+0x186>
        while(*s != 0){
 56f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 572:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 574:	84 c0                	test   %al,%al
 576:	0f 84 d8 fe ff ff    	je     454 <printf+0x54>
 57c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 57f:	89 de                	mov    %ebx,%esi
 581:	8b 5d 08             	mov    0x8(%ebp),%ebx
 584:	eb 1a                	jmp    5a0 <printf+0x1a0>
          s = "(null)";
 586:	bb 7b 07 00 00       	mov    $0x77b,%ebx
        while(*s != 0){
 58b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 58e:	b8 28 00 00 00       	mov    $0x28,%eax
 593:	89 de                	mov    %ebx,%esi
 595:	8b 5d 08             	mov    0x8(%ebp),%ebx
 598:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 59f:	00 
  write(fd, &c, 1);
 5a0:	83 ec 04             	sub    $0x4,%esp
          s++;
 5a3:	83 c6 01             	add    $0x1,%esi
 5a6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5a9:	6a 01                	push   $0x1
 5ab:	57                   	push   %edi
 5ac:	53                   	push   %ebx
 5ad:	e8 e1 fc ff ff       	call   293 <write>
        while(*s != 0){
 5b2:	0f b6 06             	movzbl (%esi),%eax
 5b5:	83 c4 10             	add    $0x10,%esp
 5b8:	84 c0                	test   %al,%al
 5ba:	75 e4                	jne    5a0 <printf+0x1a0>
      state = 0;
 5bc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 5bf:	31 d2                	xor    %edx,%edx
 5c1:	e9 8e fe ff ff       	jmp    454 <printf+0x54>
 5c6:	66 90                	xchg   %ax,%ax
 5c8:	66 90                	xchg   %ax,%ax
 5ca:	66 90                	xchg   %ax,%ax
 5cc:	66 90                	xchg   %ax,%ax
 5ce:	66 90                	xchg   %ax,%ax

000005d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5d0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5d1:	a1 28 0a 00 00       	mov    0xa28,%eax
{
 5d6:	89 e5                	mov    %esp,%ebp
 5d8:	57                   	push   %edi
 5d9:	56                   	push   %esi
 5da:	53                   	push   %ebx
 5db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 5de:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5e8:	89 c2                	mov    %eax,%edx
 5ea:	8b 00                	mov    (%eax),%eax
 5ec:	39 ca                	cmp    %ecx,%edx
 5ee:	73 30                	jae    620 <free+0x50>
 5f0:	39 c1                	cmp    %eax,%ecx
 5f2:	72 04                	jb     5f8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5f4:	39 c2                	cmp    %eax,%edx
 5f6:	72 f0                	jb     5e8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 5f8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5fb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5fe:	39 f8                	cmp    %edi,%eax
 600:	74 30                	je     632 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 602:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 605:	8b 42 04             	mov    0x4(%edx),%eax
 608:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 60b:	39 f1                	cmp    %esi,%ecx
 60d:	74 3a                	je     649 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 60f:	89 0a                	mov    %ecx,(%edx)
  freep = p;
}
 611:	5b                   	pop    %ebx
  freep = p;
 612:	89 15 28 0a 00 00    	mov    %edx,0xa28
}
 618:	5e                   	pop    %esi
 619:	5f                   	pop    %edi
 61a:	5d                   	pop    %ebp
 61b:	c3                   	ret
 61c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 620:	39 c2                	cmp    %eax,%edx
 622:	72 c4                	jb     5e8 <free+0x18>
 624:	39 c1                	cmp    %eax,%ecx
 626:	73 c0                	jae    5e8 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 628:	8b 73 fc             	mov    -0x4(%ebx),%esi
 62b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 62e:	39 f8                	cmp    %edi,%eax
 630:	75 d0                	jne    602 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 632:	03 70 04             	add    0x4(%eax),%esi
 635:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 638:	8b 02                	mov    (%edx),%eax
 63a:	8b 00                	mov    (%eax),%eax
 63c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 63f:	8b 42 04             	mov    0x4(%edx),%eax
 642:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 645:	39 f1                	cmp    %esi,%ecx
 647:	75 c6                	jne    60f <free+0x3f>
    p->s.size += bp->s.size;
 649:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 64c:	89 15 28 0a 00 00    	mov    %edx,0xa28
    p->s.size += bp->s.size;
 652:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 655:	8b 43 f8             	mov    -0x8(%ebx),%eax
 658:	89 02                	mov    %eax,(%edx)
}
 65a:	5b                   	pop    %ebx
 65b:	5e                   	pop    %esi
 65c:	5f                   	pop    %edi
 65d:	5d                   	pop    %ebp
 65e:	c3                   	ret
 65f:	90                   	nop

00000660 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 660:	55                   	push   %ebp
 661:	89 e5                	mov    %esp,%ebp
 663:	57                   	push   %edi
 664:	56                   	push   %esi
 665:	53                   	push   %ebx
 666:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 669:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 66c:	8b 3d 28 0a 00 00    	mov    0xa28,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 672:	8d 70 07             	lea    0x7(%eax),%esi
 675:	c1 ee 03             	shr    $0x3,%esi
 678:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 67b:	85 ff                	test   %edi,%edi
 67d:	0f 84 ad 00 00 00    	je     730 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 683:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 685:	8b 48 04             	mov    0x4(%eax),%ecx
 688:	39 f1                	cmp    %esi,%ecx
 68a:	73 71                	jae    6fd <malloc+0x9d>
 68c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 692:	bb 00 10 00 00       	mov    $0x1000,%ebx
 697:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 69a:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 6a1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 6a4:	eb 1b                	jmp    6c1 <malloc+0x61>
 6a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6ad:	00 
 6ae:	66 90                	xchg   %ax,%ax
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6b0:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 6b2:	8b 4a 04             	mov    0x4(%edx),%ecx
 6b5:	39 f1                	cmp    %esi,%ecx
 6b7:	73 4f                	jae    708 <malloc+0xa8>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6b9:	8b 3d 28 0a 00 00    	mov    0xa28,%edi
 6bf:	89 d0                	mov    %edx,%eax
 6c1:	39 c7                	cmp    %eax,%edi
 6c3:	75 eb                	jne    6b0 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 6c5:	83 ec 0c             	sub    $0xc,%esp
 6c8:	ff 75 e4             	push   -0x1c(%ebp)
 6cb:	e8 2b fc ff ff       	call   2fb <sbrk>
  if(p == (char*)-1)
 6d0:	83 c4 10             	add    $0x10,%esp
 6d3:	83 f8 ff             	cmp    $0xffffffff,%eax
 6d6:	74 1b                	je     6f3 <malloc+0x93>
  hp->s.size = nu;
 6d8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 6db:	83 ec 0c             	sub    $0xc,%esp
 6de:	83 c0 08             	add    $0x8,%eax
 6e1:	50                   	push   %eax
 6e2:	e8 e9 fe ff ff       	call   5d0 <free>
  return freep;
 6e7:	a1 28 0a 00 00       	mov    0xa28,%eax
      if((p = morecore(nunits)) == 0)
 6ec:	83 c4 10             	add    $0x10,%esp
 6ef:	85 c0                	test   %eax,%eax
 6f1:	75 bd                	jne    6b0 <malloc+0x50>
        return 0;
  }
}
 6f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 6f6:	31 c0                	xor    %eax,%eax
}
 6f8:	5b                   	pop    %ebx
 6f9:	5e                   	pop    %esi
 6fa:	5f                   	pop    %edi
 6fb:	5d                   	pop    %ebp
 6fc:	c3                   	ret
    if(p->s.size >= nunits){
 6fd:	89 c2                	mov    %eax,%edx
 6ff:	89 f8                	mov    %edi,%eax
 701:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 708:	39 ce                	cmp    %ecx,%esi
 70a:	74 54                	je     760 <malloc+0x100>
        p->s.size -= nunits;
 70c:	29 f1                	sub    %esi,%ecx
 70e:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 711:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 714:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 717:	a3 28 0a 00 00       	mov    %eax,0xa28
}
 71c:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 71f:	8d 42 08             	lea    0x8(%edx),%eax
}
 722:	5b                   	pop    %ebx
 723:	5e                   	pop    %esi
 724:	5f                   	pop    %edi
 725:	5d                   	pop    %ebp
 726:	c3                   	ret
 727:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 72e:	00 
 72f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 730:	c7 05 28 0a 00 00 2c 	movl   $0xa2c,0xa28
 737:	0a 00 00 
    base.s.size = 0;
 73a:	bf 2c 0a 00 00       	mov    $0xa2c,%edi
    base.s.ptr = freep = prevp = &base;
 73f:	c7 05 2c 0a 00 00 2c 	movl   $0xa2c,0xa2c
 746:	0a 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 749:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 74b:	c7 05 30 0a 00 00 00 	movl   $0x0,0xa30
 752:	00 00 00 
    if(p->s.size >= nunits){
 755:	e9 32 ff ff ff       	jmp    68c <malloc+0x2c>
 75a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 760:	8b 0a                	mov    (%edx),%ecx
 762:	89 08                	mov    %ecx,(%eax)
 764:	eb b1                	jmp    717 <malloc+0xb7>
