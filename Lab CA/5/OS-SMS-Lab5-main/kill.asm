
_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	bb 01 00 00 00       	mov    $0x1,%ebx
  15:	51                   	push   %ecx
  16:	83 ec 08             	sub    $0x8,%esp
  19:	8b 31                	mov    (%ecx),%esi
  1b:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;

  if(argc < 2){
  1e:	83 fe 01             	cmp    $0x1,%esi
  21:	7e 27                	jle    4a <main+0x4a>
  23:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  28:	83 ec 0c             	sub    $0xc,%esp
  2b:	ff 34 9f             	push   (%edi,%ebx,4)
  for(i=1; i<argc; i++)
  2e:	83 c3 01             	add    $0x1,%ebx
    kill(atoi(argv[i]));
  31:	e8 fa 01 00 00       	call   230 <atoi>
  36:	89 04 24             	mov    %eax,(%esp)
  39:	e8 95 02 00 00       	call   2d3 <kill>
  for(i=1; i<argc; i++)
  3e:	83 c4 10             	add    $0x10,%esp
  41:	39 de                	cmp    %ebx,%esi
  43:	75 e3                	jne    28 <main+0x28>
  exit();
  45:	e8 59 02 00 00       	call   2a3 <exit>
    printf(2, "usage: kill pid...\n");
  4a:	50                   	push   %eax
  4b:	50                   	push   %eax
  4c:	68 98 07 00 00       	push   $0x798
  51:	6a 02                	push   $0x2
  53:	e8 d8 03 00 00       	call   430 <printf>
    exit();
  58:	e8 46 02 00 00       	call   2a3 <exit>
  5d:	66 90                	xchg   %ax,%ax
  5f:	90                   	nop

00000060 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  60:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  61:	31 c0                	xor    %eax,%eax
{
  63:	89 e5                	mov    %esp,%ebp
  65:	53                   	push   %ebx
  66:	8b 4d 08             	mov    0x8(%ebp),%ecx
  69:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  70:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  74:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  77:	83 c0 01             	add    $0x1,%eax
  7a:	84 d2                	test   %dl,%dl
  7c:	75 f2                	jne    70 <strcpy+0x10>
    ;
  return os;
}
  7e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  81:	89 c8                	mov    %ecx,%eax
  83:	c9                   	leave
  84:	c3                   	ret
  85:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  8c:	00 
  8d:	8d 76 00             	lea    0x0(%esi),%esi

00000090 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	53                   	push   %ebx
  94:	8b 4d 08             	mov    0x8(%ebp),%ecx
  97:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  9a:	0f b6 01             	movzbl (%ecx),%eax
  9d:	0f b6 1a             	movzbl (%edx),%ebx
  a0:	84 c0                	test   %al,%al
  a2:	75 1c                	jne    c0 <strcmp+0x30>
  a4:	eb 2e                	jmp    d4 <strcmp+0x44>
  a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  ad:	00 
  ae:	66 90                	xchg   %ax,%ax
  b0:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
  b4:	83 c1 01             	add    $0x1,%ecx
  b7:	8d 5a 01             	lea    0x1(%edx),%ebx
  while(*p && *p == *q)
  ba:	84 c0                	test   %al,%al
  bc:	74 12                	je     d0 <strcmp+0x40>
    p++, q++;
  be:	89 da                	mov    %ebx,%edx
  while(*p && *p == *q)
  c0:	0f b6 1a             	movzbl (%edx),%ebx
  c3:	38 c3                	cmp    %al,%bl
  c5:	74 e9                	je     b0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
  c7:	29 d8                	sub    %ebx,%eax
}
  c9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  cc:	c9                   	leave
  cd:	c3                   	ret
  ce:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
  d0:	0f b6 5a 01          	movzbl 0x1(%edx),%ebx
  d4:	31 c0                	xor    %eax,%eax
  d6:	29 d8                	sub    %ebx,%eax
}
  d8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  db:	c9                   	leave
  dc:	c3                   	ret
  dd:	8d 76 00             	lea    0x0(%esi),%esi

000000e0 <strlen>:

uint
strlen(const char *s)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  e6:	80 3a 00             	cmpb   $0x0,(%edx)
  e9:	74 15                	je     100 <strlen+0x20>
  eb:	31 c0                	xor    %eax,%eax
  ed:	8d 76 00             	lea    0x0(%esi),%esi
  f0:	83 c0 01             	add    $0x1,%eax
  f3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  f7:	89 c1                	mov    %eax,%ecx
  f9:	75 f5                	jne    f0 <strlen+0x10>
    ;
  return n;
}
  fb:	89 c8                	mov    %ecx,%eax
  fd:	5d                   	pop    %ebp
  fe:	c3                   	ret
  ff:	90                   	nop
  for(n = 0; s[n]; n++)
 100:	31 c9                	xor    %ecx,%ecx
}
 102:	5d                   	pop    %ebp
 103:	89 c8                	mov    %ecx,%eax
 105:	c3                   	ret
 106:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 10d:	00 
 10e:	66 90                	xchg   %ax,%ax

00000110 <memset>:

void*
memset(void *dst, int c, uint n)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	57                   	push   %edi
 114:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 117:	8b 4d 10             	mov    0x10(%ebp),%ecx
 11a:	8b 45 0c             	mov    0xc(%ebp),%eax
 11d:	89 d7                	mov    %edx,%edi
 11f:	fc                   	cld
 120:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 122:	8b 7d fc             	mov    -0x4(%ebp),%edi
 125:	89 d0                	mov    %edx,%eax
 127:	c9                   	leave
 128:	c3                   	ret
 129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000130 <strchr>:

char*
strchr(const char *s, char c)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	8b 45 08             	mov    0x8(%ebp),%eax
 136:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 13a:	0f b6 10             	movzbl (%eax),%edx
 13d:	84 d2                	test   %dl,%dl
 13f:	75 12                	jne    153 <strchr+0x23>
 141:	eb 1d                	jmp    160 <strchr+0x30>
 143:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 148:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 14c:	83 c0 01             	add    $0x1,%eax
 14f:	84 d2                	test   %dl,%dl
 151:	74 0d                	je     160 <strchr+0x30>
    if(*s == c)
 153:	38 d1                	cmp    %dl,%cl
 155:	75 f1                	jne    148 <strchr+0x18>
      return (char*)s;
  return 0;
}
 157:	5d                   	pop    %ebp
 158:	c3                   	ret
 159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 160:	31 c0                	xor    %eax,%eax
}
 162:	5d                   	pop    %ebp
 163:	c3                   	ret
 164:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 16b:	00 
 16c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000170 <gets>:

char*
gets(char *buf, int max)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	57                   	push   %edi
 174:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 175:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 178:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 179:	31 db                	xor    %ebx,%ebx
{
 17b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 17e:	eb 27                	jmp    1a7 <gets+0x37>
    cc = read(0, &c, 1);
 180:	83 ec 04             	sub    $0x4,%esp
 183:	6a 01                	push   $0x1
 185:	57                   	push   %edi
 186:	6a 00                	push   $0x0
 188:	e8 2e 01 00 00       	call   2bb <read>
    if(cc < 1)
 18d:	83 c4 10             	add    $0x10,%esp
 190:	85 c0                	test   %eax,%eax
 192:	7e 1d                	jle    1b1 <gets+0x41>
      break;
    buf[i++] = c;
 194:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 198:	8b 55 08             	mov    0x8(%ebp),%edx
 19b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 19f:	3c 0a                	cmp    $0xa,%al
 1a1:	74 1d                	je     1c0 <gets+0x50>
 1a3:	3c 0d                	cmp    $0xd,%al
 1a5:	74 19                	je     1c0 <gets+0x50>
  for(i=0; i+1 < max; ){
 1a7:	89 de                	mov    %ebx,%esi
 1a9:	83 c3 01             	add    $0x1,%ebx
 1ac:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1af:	7c cf                	jl     180 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 1b1:	8b 45 08             	mov    0x8(%ebp),%eax
 1b4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 1b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1bb:	5b                   	pop    %ebx
 1bc:	5e                   	pop    %esi
 1bd:	5f                   	pop    %edi
 1be:	5d                   	pop    %ebp
 1bf:	c3                   	ret
  buf[i] = '\0';
 1c0:	8b 45 08             	mov    0x8(%ebp),%eax
 1c3:	89 de                	mov    %ebx,%esi
 1c5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 1c9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1cc:	5b                   	pop    %ebx
 1cd:	5e                   	pop    %esi
 1ce:	5f                   	pop    %edi
 1cf:	5d                   	pop    %ebp
 1d0:	c3                   	ret
 1d1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1d8:	00 
 1d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001e0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	56                   	push   %esi
 1e4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1e5:	83 ec 08             	sub    $0x8,%esp
 1e8:	6a 00                	push   $0x0
 1ea:	ff 75 08             	push   0x8(%ebp)
 1ed:	e8 f1 00 00 00       	call   2e3 <open>
  if(fd < 0)
 1f2:	83 c4 10             	add    $0x10,%esp
 1f5:	85 c0                	test   %eax,%eax
 1f7:	78 27                	js     220 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 1f9:	83 ec 08             	sub    $0x8,%esp
 1fc:	ff 75 0c             	push   0xc(%ebp)
 1ff:	89 c3                	mov    %eax,%ebx
 201:	50                   	push   %eax
 202:	e8 f4 00 00 00       	call   2fb <fstat>
  close(fd);
 207:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 20a:	89 c6                	mov    %eax,%esi
  close(fd);
 20c:	e8 ba 00 00 00       	call   2cb <close>
  return r;
 211:	83 c4 10             	add    $0x10,%esp
}
 214:	8d 65 f8             	lea    -0x8(%ebp),%esp
 217:	89 f0                	mov    %esi,%eax
 219:	5b                   	pop    %ebx
 21a:	5e                   	pop    %esi
 21b:	5d                   	pop    %ebp
 21c:	c3                   	ret
 21d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 220:	be ff ff ff ff       	mov    $0xffffffff,%esi
 225:	eb ed                	jmp    214 <stat+0x34>
 227:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 22e:	00 
 22f:	90                   	nop

00000230 <atoi>:

int
atoi(const char *s)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	53                   	push   %ebx
 234:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 237:	0f be 02             	movsbl (%edx),%eax
 23a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 23d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 240:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 245:	77 1e                	ja     265 <atoi+0x35>
 247:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 24e:	00 
 24f:	90                   	nop
    n = n*10 + *s++ - '0';
 250:	83 c2 01             	add    $0x1,%edx
 253:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 256:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 25a:	0f be 02             	movsbl (%edx),%eax
 25d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 260:	80 fb 09             	cmp    $0x9,%bl
 263:	76 eb                	jbe    250 <atoi+0x20>
  return n;
}
 265:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 268:	89 c8                	mov    %ecx,%eax
 26a:	c9                   	leave
 26b:	c3                   	ret
 26c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000270 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	57                   	push   %edi
 274:	8b 45 10             	mov    0x10(%ebp),%eax
 277:	8b 55 08             	mov    0x8(%ebp),%edx
 27a:	56                   	push   %esi
 27b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 27e:	85 c0                	test   %eax,%eax
 280:	7e 13                	jle    295 <memmove+0x25>
 282:	01 d0                	add    %edx,%eax
  dst = vdst;
 284:	89 d7                	mov    %edx,%edi
 286:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 28d:	00 
 28e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 290:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 291:	39 f8                	cmp    %edi,%eax
 293:	75 fb                	jne    290 <memmove+0x20>
  return vdst;
}
 295:	5e                   	pop    %esi
 296:	89 d0                	mov    %edx,%eax
 298:	5f                   	pop    %edi
 299:	5d                   	pop    %ebp
 29a:	c3                   	ret

0000029b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 29b:	b8 01 00 00 00       	mov    $0x1,%eax
 2a0:	cd 40                	int    $0x40
 2a2:	c3                   	ret

000002a3 <exit>:
SYSCALL(exit)
 2a3:	b8 02 00 00 00       	mov    $0x2,%eax
 2a8:	cd 40                	int    $0x40
 2aa:	c3                   	ret

000002ab <wait>:
SYSCALL(wait)
 2ab:	b8 03 00 00 00       	mov    $0x3,%eax
 2b0:	cd 40                	int    $0x40
 2b2:	c3                   	ret

000002b3 <pipe>:
SYSCALL(pipe)
 2b3:	b8 04 00 00 00       	mov    $0x4,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret

000002bb <read>:
SYSCALL(read)
 2bb:	b8 05 00 00 00       	mov    $0x5,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret

000002c3 <write>:
SYSCALL(write)
 2c3:	b8 10 00 00 00       	mov    $0x10,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret

000002cb <close>:
SYSCALL(close)
 2cb:	b8 15 00 00 00       	mov    $0x15,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret

000002d3 <kill>:
SYSCALL(kill)
 2d3:	b8 06 00 00 00       	mov    $0x6,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret

000002db <exec>:
SYSCALL(exec)
 2db:	b8 07 00 00 00       	mov    $0x7,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret

000002e3 <open>:
SYSCALL(open)
 2e3:	b8 0f 00 00 00       	mov    $0xf,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret

000002eb <mknod>:
SYSCALL(mknod)
 2eb:	b8 11 00 00 00       	mov    $0x11,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret

000002f3 <unlink>:
SYSCALL(unlink)
 2f3:	b8 12 00 00 00       	mov    $0x12,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret

000002fb <fstat>:
SYSCALL(fstat)
 2fb:	b8 08 00 00 00       	mov    $0x8,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret

00000303 <link>:
SYSCALL(link)
 303:	b8 13 00 00 00       	mov    $0x13,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret

0000030b <mkdir>:
SYSCALL(mkdir)
 30b:	b8 14 00 00 00       	mov    $0x14,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret

00000313 <chdir>:
SYSCALL(chdir)
 313:	b8 09 00 00 00       	mov    $0x9,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret

0000031b <dup>:
SYSCALL(dup)
 31b:	b8 0a 00 00 00       	mov    $0xa,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret

00000323 <getpid>:
SYSCALL(getpid)
 323:	b8 0b 00 00 00       	mov    $0xb,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret

0000032b <sbrk>:
SYSCALL(sbrk)
 32b:	b8 0c 00 00 00       	mov    $0xc,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret

00000333 <sleep>:
SYSCALL(sleep)
 333:	b8 0d 00 00 00       	mov    $0xd,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret

0000033b <uptime>:
SYSCALL(uptime)
 33b:	b8 0e 00 00 00       	mov    $0xe,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret

00000343 <create_palindrome>:
SYSCALL(create_palindrome)
 343:	b8 16 00 00 00       	mov    $0x16,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret

0000034b <sort_syscalls>:
SYSCALL(sort_syscalls)
 34b:	b8 17 00 00 00       	mov    $0x17,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret

00000353 <get_most_invoked_syscall>:
SYSCALL(get_most_invoked_syscall)
 353:	b8 18 00 00 00       	mov    $0x18,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret

0000035b <list_all_processes>:
SYSCALL(list_all_processes)
 35b:	b8 19 00 00 00       	mov    $0x19,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret

00000363 <move_file>:
SYSCALL(move_file)
 363:	b8 1a 00 00 00       	mov    $0x1a,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret

0000036b <open_sharedmem>:
SYSCALL(open_sharedmem)
 36b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret

00000373 <close_sharedmem>:
 373:	b8 1c 00 00 00       	mov    $0x1c,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret
 37b:	66 90                	xchg   %ax,%ax
 37d:	66 90                	xchg   %ax,%ax
 37f:	90                   	nop

00000380 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	57                   	push   %edi
 384:	56                   	push   %esi
 385:	53                   	push   %ebx
 386:	83 ec 3c             	sub    $0x3c,%esp
 389:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 38c:	89 d1                	mov    %edx,%ecx
{
 38e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 391:	85 d2                	test   %edx,%edx
 393:	0f 89 7f 00 00 00    	jns    418 <printint+0x98>
 399:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 39d:	74 79                	je     418 <printint+0x98>
    neg = 1;
 39f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 3a6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 3a8:	31 db                	xor    %ebx,%ebx
 3aa:	8d 75 d7             	lea    -0x29(%ebp),%esi
 3ad:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 3b0:	89 c8                	mov    %ecx,%eax
 3b2:	31 d2                	xor    %edx,%edx
 3b4:	89 cf                	mov    %ecx,%edi
 3b6:	f7 75 c4             	divl   -0x3c(%ebp)
 3b9:	0f b6 92 b4 07 00 00 	movzbl 0x7b4(%edx),%edx
 3c0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 3c3:	89 d8                	mov    %ebx,%eax
 3c5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 3c8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 3cb:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 3ce:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 3d1:	76 dd                	jbe    3b0 <printint+0x30>
  if(neg)
 3d3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 3d6:	85 c9                	test   %ecx,%ecx
 3d8:	74 0c                	je     3e6 <printint+0x66>
    buf[i++] = '-';
 3da:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 3df:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 3e1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 3e6:	8b 7d b8             	mov    -0x48(%ebp),%edi
 3e9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 3ed:	eb 07                	jmp    3f6 <printint+0x76>
 3ef:	90                   	nop
    putc(fd, buf[i]);
 3f0:	0f b6 13             	movzbl (%ebx),%edx
 3f3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 3f6:	83 ec 04             	sub    $0x4,%esp
 3f9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 3fc:	6a 01                	push   $0x1
 3fe:	56                   	push   %esi
 3ff:	57                   	push   %edi
 400:	e8 be fe ff ff       	call   2c3 <write>
  while(--i >= 0)
 405:	83 c4 10             	add    $0x10,%esp
 408:	39 de                	cmp    %ebx,%esi
 40a:	75 e4                	jne    3f0 <printint+0x70>
}
 40c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 40f:	5b                   	pop    %ebx
 410:	5e                   	pop    %esi
 411:	5f                   	pop    %edi
 412:	5d                   	pop    %ebp
 413:	c3                   	ret
 414:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 418:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 41f:	eb 87                	jmp    3a8 <printint+0x28>
 421:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 428:	00 
 429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000430 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	57                   	push   %edi
 434:	56                   	push   %esi
 435:	53                   	push   %ebx
 436:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 439:	8b 75 0c             	mov    0xc(%ebp),%esi
 43c:	0f b6 1e             	movzbl (%esi),%ebx
 43f:	84 db                	test   %bl,%bl
 441:	0f 84 b8 00 00 00    	je     4ff <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 447:	8d 45 10             	lea    0x10(%ebp),%eax
 44a:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 44d:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 450:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 452:	89 45 d0             	mov    %eax,-0x30(%ebp)
 455:	eb 37                	jmp    48e <printf+0x5e>
 457:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 45e:	00 
 45f:	90                   	nop
 460:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 463:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 468:	83 f8 25             	cmp    $0x25,%eax
 46b:	74 17                	je     484 <printf+0x54>
  write(fd, &c, 1);
 46d:	83 ec 04             	sub    $0x4,%esp
 470:	88 5d e7             	mov    %bl,-0x19(%ebp)
 473:	6a 01                	push   $0x1
 475:	57                   	push   %edi
 476:	ff 75 08             	push   0x8(%ebp)
 479:	e8 45 fe ff ff       	call   2c3 <write>
 47e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 481:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 484:	0f b6 1e             	movzbl (%esi),%ebx
 487:	83 c6 01             	add    $0x1,%esi
 48a:	84 db                	test   %bl,%bl
 48c:	74 71                	je     4ff <printf+0xcf>
    c = fmt[i] & 0xff;
 48e:	0f be cb             	movsbl %bl,%ecx
 491:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 494:	85 d2                	test   %edx,%edx
 496:	74 c8                	je     460 <printf+0x30>
      }
    } else if(state == '%'){
 498:	83 fa 25             	cmp    $0x25,%edx
 49b:	75 e7                	jne    484 <printf+0x54>
      if(c == 'd'){
 49d:	83 f8 64             	cmp    $0x64,%eax
 4a0:	0f 84 9a 00 00 00    	je     540 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 4a6:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 4ac:	83 f9 70             	cmp    $0x70,%ecx
 4af:	74 5f                	je     510 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4b1:	83 f8 73             	cmp    $0x73,%eax
 4b4:	0f 84 d6 00 00 00    	je     590 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4ba:	83 f8 63             	cmp    $0x63,%eax
 4bd:	0f 84 8d 00 00 00    	je     550 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4c3:	83 f8 25             	cmp    $0x25,%eax
 4c6:	0f 84 b4 00 00 00    	je     580 <printf+0x150>
  write(fd, &c, 1);
 4cc:	83 ec 04             	sub    $0x4,%esp
 4cf:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4d3:	6a 01                	push   $0x1
 4d5:	57                   	push   %edi
 4d6:	ff 75 08             	push   0x8(%ebp)
 4d9:	e8 e5 fd ff ff       	call   2c3 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 4de:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 4e1:	83 c4 0c             	add    $0xc,%esp
 4e4:	6a 01                	push   $0x1
  for(i = 0; fmt[i]; i++){
 4e6:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 4e9:	57                   	push   %edi
 4ea:	ff 75 08             	push   0x8(%ebp)
 4ed:	e8 d1 fd ff ff       	call   2c3 <write>
  for(i = 0; fmt[i]; i++){
 4f2:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 4f6:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 4f9:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 4fb:	84 db                	test   %bl,%bl
 4fd:	75 8f                	jne    48e <printf+0x5e>
    }
  }
}
 4ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
 502:	5b                   	pop    %ebx
 503:	5e                   	pop    %esi
 504:	5f                   	pop    %edi
 505:	5d                   	pop    %ebp
 506:	c3                   	ret
 507:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 50e:	00 
 50f:	90                   	nop
        printint(fd, *ap, 16, 0);
 510:	83 ec 0c             	sub    $0xc,%esp
 513:	b9 10 00 00 00       	mov    $0x10,%ecx
 518:	6a 00                	push   $0x0
 51a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 51d:	8b 45 08             	mov    0x8(%ebp),%eax
 520:	8b 13                	mov    (%ebx),%edx
 522:	e8 59 fe ff ff       	call   380 <printint>
        ap++;
 527:	89 d8                	mov    %ebx,%eax
 529:	83 c4 10             	add    $0x10,%esp
      state = 0;
 52c:	31 d2                	xor    %edx,%edx
        ap++;
 52e:	83 c0 04             	add    $0x4,%eax
 531:	89 45 d0             	mov    %eax,-0x30(%ebp)
 534:	e9 4b ff ff ff       	jmp    484 <printf+0x54>
 539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 540:	83 ec 0c             	sub    $0xc,%esp
 543:	b9 0a 00 00 00       	mov    $0xa,%ecx
 548:	6a 01                	push   $0x1
 54a:	eb ce                	jmp    51a <printf+0xea>
 54c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 550:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 553:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 556:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 558:	6a 01                	push   $0x1
        ap++;
 55a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 55d:	57                   	push   %edi
 55e:	ff 75 08             	push   0x8(%ebp)
        putc(fd, *ap);
 561:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 564:	e8 5a fd ff ff       	call   2c3 <write>
        ap++;
 569:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 56c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 56f:	31 d2                	xor    %edx,%edx
 571:	e9 0e ff ff ff       	jmp    484 <printf+0x54>
 576:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 57d:	00 
 57e:	66 90                	xchg   %ax,%ax
        putc(fd, c);
 580:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 583:	83 ec 04             	sub    $0x4,%esp
 586:	e9 59 ff ff ff       	jmp    4e4 <printf+0xb4>
 58b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 590:	8b 45 d0             	mov    -0x30(%ebp),%eax
 593:	8b 18                	mov    (%eax),%ebx
        ap++;
 595:	83 c0 04             	add    $0x4,%eax
 598:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 59b:	85 db                	test   %ebx,%ebx
 59d:	74 17                	je     5b6 <printf+0x186>
        while(*s != 0){
 59f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 5a2:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 5a4:	84 c0                	test   %al,%al
 5a6:	0f 84 d8 fe ff ff    	je     484 <printf+0x54>
 5ac:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 5af:	89 de                	mov    %ebx,%esi
 5b1:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5b4:	eb 1a                	jmp    5d0 <printf+0x1a0>
          s = "(null)";
 5b6:	bb ac 07 00 00       	mov    $0x7ac,%ebx
        while(*s != 0){
 5bb:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 5be:	b8 28 00 00 00       	mov    $0x28,%eax
 5c3:	89 de                	mov    %ebx,%esi
 5c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5cf:	00 
  write(fd, &c, 1);
 5d0:	83 ec 04             	sub    $0x4,%esp
          s++;
 5d3:	83 c6 01             	add    $0x1,%esi
 5d6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5d9:	6a 01                	push   $0x1
 5db:	57                   	push   %edi
 5dc:	53                   	push   %ebx
 5dd:	e8 e1 fc ff ff       	call   2c3 <write>
        while(*s != 0){
 5e2:	0f b6 06             	movzbl (%esi),%eax
 5e5:	83 c4 10             	add    $0x10,%esp
 5e8:	84 c0                	test   %al,%al
 5ea:	75 e4                	jne    5d0 <printf+0x1a0>
      state = 0;
 5ec:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 5ef:	31 d2                	xor    %edx,%edx
 5f1:	e9 8e fe ff ff       	jmp    484 <printf+0x54>
 5f6:	66 90                	xchg   %ax,%ax
 5f8:	66 90                	xchg   %ax,%ax
 5fa:	66 90                	xchg   %ax,%ax
 5fc:	66 90                	xchg   %ax,%ax
 5fe:	66 90                	xchg   %ax,%ax

00000600 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 600:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 601:	a1 68 0a 00 00       	mov    0xa68,%eax
{
 606:	89 e5                	mov    %esp,%ebp
 608:	57                   	push   %edi
 609:	56                   	push   %esi
 60a:	53                   	push   %ebx
 60b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 60e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 611:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 618:	89 c2                	mov    %eax,%edx
 61a:	8b 00                	mov    (%eax),%eax
 61c:	39 ca                	cmp    %ecx,%edx
 61e:	73 30                	jae    650 <free+0x50>
 620:	39 c1                	cmp    %eax,%ecx
 622:	72 04                	jb     628 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 624:	39 c2                	cmp    %eax,%edx
 626:	72 f0                	jb     618 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 628:	8b 73 fc             	mov    -0x4(%ebx),%esi
 62b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 62e:	39 f8                	cmp    %edi,%eax
 630:	74 30                	je     662 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 632:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 635:	8b 42 04             	mov    0x4(%edx),%eax
 638:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 63b:	39 f1                	cmp    %esi,%ecx
 63d:	74 3a                	je     679 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 63f:	89 0a                	mov    %ecx,(%edx)
  freep = p;
}
 641:	5b                   	pop    %ebx
  freep = p;
 642:	89 15 68 0a 00 00    	mov    %edx,0xa68
}
 648:	5e                   	pop    %esi
 649:	5f                   	pop    %edi
 64a:	5d                   	pop    %ebp
 64b:	c3                   	ret
 64c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 650:	39 c2                	cmp    %eax,%edx
 652:	72 c4                	jb     618 <free+0x18>
 654:	39 c1                	cmp    %eax,%ecx
 656:	73 c0                	jae    618 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 658:	8b 73 fc             	mov    -0x4(%ebx),%esi
 65b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 65e:	39 f8                	cmp    %edi,%eax
 660:	75 d0                	jne    632 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 662:	03 70 04             	add    0x4(%eax),%esi
 665:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 668:	8b 02                	mov    (%edx),%eax
 66a:	8b 00                	mov    (%eax),%eax
 66c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 66f:	8b 42 04             	mov    0x4(%edx),%eax
 672:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 675:	39 f1                	cmp    %esi,%ecx
 677:	75 c6                	jne    63f <free+0x3f>
    p->s.size += bp->s.size;
 679:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 67c:	89 15 68 0a 00 00    	mov    %edx,0xa68
    p->s.size += bp->s.size;
 682:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 685:	8b 43 f8             	mov    -0x8(%ebx),%eax
 688:	89 02                	mov    %eax,(%edx)
}
 68a:	5b                   	pop    %ebx
 68b:	5e                   	pop    %esi
 68c:	5f                   	pop    %edi
 68d:	5d                   	pop    %ebp
 68e:	c3                   	ret
 68f:	90                   	nop

00000690 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 690:	55                   	push   %ebp
 691:	89 e5                	mov    %esp,%ebp
 693:	57                   	push   %edi
 694:	56                   	push   %esi
 695:	53                   	push   %ebx
 696:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 699:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 69c:	8b 3d 68 0a 00 00    	mov    0xa68,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6a2:	8d 70 07             	lea    0x7(%eax),%esi
 6a5:	c1 ee 03             	shr    $0x3,%esi
 6a8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 6ab:	85 ff                	test   %edi,%edi
 6ad:	0f 84 ad 00 00 00    	je     760 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6b3:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 6b5:	8b 48 04             	mov    0x4(%eax),%ecx
 6b8:	39 f1                	cmp    %esi,%ecx
 6ba:	73 71                	jae    72d <malloc+0x9d>
 6bc:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 6c2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6c7:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 6ca:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 6d1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 6d4:	eb 1b                	jmp    6f1 <malloc+0x61>
 6d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6dd:	00 
 6de:	66 90                	xchg   %ax,%ax
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6e0:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 6e2:	8b 4a 04             	mov    0x4(%edx),%ecx
 6e5:	39 f1                	cmp    %esi,%ecx
 6e7:	73 4f                	jae    738 <malloc+0xa8>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6e9:	8b 3d 68 0a 00 00    	mov    0xa68,%edi
 6ef:	89 d0                	mov    %edx,%eax
 6f1:	39 c7                	cmp    %eax,%edi
 6f3:	75 eb                	jne    6e0 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 6f5:	83 ec 0c             	sub    $0xc,%esp
 6f8:	ff 75 e4             	push   -0x1c(%ebp)
 6fb:	e8 2b fc ff ff       	call   32b <sbrk>
  if(p == (char*)-1)
 700:	83 c4 10             	add    $0x10,%esp
 703:	83 f8 ff             	cmp    $0xffffffff,%eax
 706:	74 1b                	je     723 <malloc+0x93>
  hp->s.size = nu;
 708:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 70b:	83 ec 0c             	sub    $0xc,%esp
 70e:	83 c0 08             	add    $0x8,%eax
 711:	50                   	push   %eax
 712:	e8 e9 fe ff ff       	call   600 <free>
  return freep;
 717:	a1 68 0a 00 00       	mov    0xa68,%eax
      if((p = morecore(nunits)) == 0)
 71c:	83 c4 10             	add    $0x10,%esp
 71f:	85 c0                	test   %eax,%eax
 721:	75 bd                	jne    6e0 <malloc+0x50>
        return 0;
  }
}
 723:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 726:	31 c0                	xor    %eax,%eax
}
 728:	5b                   	pop    %ebx
 729:	5e                   	pop    %esi
 72a:	5f                   	pop    %edi
 72b:	5d                   	pop    %ebp
 72c:	c3                   	ret
    if(p->s.size >= nunits){
 72d:	89 c2                	mov    %eax,%edx
 72f:	89 f8                	mov    %edi,%eax
 731:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 738:	39 ce                	cmp    %ecx,%esi
 73a:	74 54                	je     790 <malloc+0x100>
        p->s.size -= nunits;
 73c:	29 f1                	sub    %esi,%ecx
 73e:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 741:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 744:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 747:	a3 68 0a 00 00       	mov    %eax,0xa68
}
 74c:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 74f:	8d 42 08             	lea    0x8(%edx),%eax
}
 752:	5b                   	pop    %ebx
 753:	5e                   	pop    %esi
 754:	5f                   	pop    %edi
 755:	5d                   	pop    %ebp
 756:	c3                   	ret
 757:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 75e:	00 
 75f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 760:	c7 05 68 0a 00 00 6c 	movl   $0xa6c,0xa68
 767:	0a 00 00 
    base.s.size = 0;
 76a:	bf 6c 0a 00 00       	mov    $0xa6c,%edi
    base.s.ptr = freep = prevp = &base;
 76f:	c7 05 6c 0a 00 00 6c 	movl   $0xa6c,0xa6c
 776:	0a 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 779:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 77b:	c7 05 70 0a 00 00 00 	movl   $0x0,0xa70
 782:	00 00 00 
    if(p->s.size >= nunits){
 785:	e9 32 ff ff ff       	jmp    6bc <malloc+0x2c>
 78a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 790:	8b 0a                	mov    (%edx),%ecx
 792:	89 08                	mov    %ecx,(%eax)
 794:	eb b1                	jmp    747 <malloc+0xb7>
