
_create_palindrome:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char *argv[]){
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	56                   	push   %esi
   e:	53                   	push   %ebx
   f:	51                   	push   %ecx
  10:	83 ec 0c             	sub    $0xc,%esp
	if(argc < 2){
  13:	83 39 01             	cmpl   $0x1,(%ecx)
int main(int argc, char *argv[]){
  16:	8b 41 04             	mov    0x4(%ecx),%eax
	if(argc < 2){
  19:	7e 3e                	jle    59 <main+0x59>
		exit();
	}
    else
    {
		// We will use ebx register for storing input number
		int saved_ebx, number = atoi(argv[1]);
  1b:	83 ec 0c             	sub    $0xc,%esp
  1e:	ff 70 04             	push   0x4(%eax)
  21:	e8 2a 02 00 00       	call   250 <atoi>
  26:	89 c3                	mov    %eax,%ebx
		// 
		asm volatile(
  28:	89 de                	mov    %ebx,%esi
  2a:	89 c3                	mov    %eax,%ebx
			"movl %%ebx, %0;" // saved_ebx = ebx
			"movl %1, %%ebx;" // ebx = number
			: "=r" (saved_ebx)
			: "r"(number)
		);
		printf(1, "User: create_palindrome called for number: %d\n" , number);
  2c:	83 c4 0c             	add    $0xc,%esp
  2f:	50                   	push   %eax
  30:	68 ac 07 00 00       	push   $0x7ac
  35:	6a 01                	push   $0x1
  37:	e8 24 04 00 00       	call   460 <printf>
		printf(1, "Palindrome of %d is: %d\n" , number , create_palindrome());
  3c:	e8 22 03 00 00       	call   363 <create_palindrome>
  41:	50                   	push   %eax
  42:	53                   	push   %ebx
  43:	68 db 07 00 00       	push   $0x7db
  48:	6a 01                	push   $0x1
  4a:	e8 11 04 00 00       	call   460 <printf>
		asm("movl %0, %%ebx" : : "r"(saved_ebx)); // ebx = saved_ebx -> restore
  4f:	89 f3                	mov    %esi,%ebx
		exit();  	
  51:	83 c4 20             	add    $0x20,%esp
  54:	e8 6a 02 00 00       	call   2c3 <exit>
		printf(2, "You must enter exactly 1 number!\n");
  59:	50                   	push   %eax
  5a:	50                   	push   %eax
  5b:	68 88 07 00 00       	push   $0x788
  60:	6a 02                	push   $0x2
  62:	e8 f9 03 00 00       	call   460 <printf>
		exit();
  67:	e8 57 02 00 00       	call   2c3 <exit>
  6c:	66 90                	xchg   %ax,%ax
  6e:	66 90                	xchg   %ax,%ax

00000070 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  70:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  71:	31 c0                	xor    %eax,%eax
{
  73:	89 e5                	mov    %esp,%ebp
  75:	53                   	push   %ebx
  76:	8b 4d 08             	mov    0x8(%ebp),%ecx
  79:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  80:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  84:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  87:	83 c0 01             	add    $0x1,%eax
  8a:	84 d2                	test   %dl,%dl
  8c:	75 f2                	jne    80 <strcpy+0x10>
    ;
  return os;
}
  8e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  91:	89 c8                	mov    %ecx,%eax
  93:	c9                   	leave  
  94:	c3                   	ret    
  95:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000000a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	53                   	push   %ebx
  a4:	8b 55 08             	mov    0x8(%ebp),%edx
  a7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  aa:	0f b6 02             	movzbl (%edx),%eax
  ad:	84 c0                	test   %al,%al
  af:	75 17                	jne    c8 <strcmp+0x28>
  b1:	eb 3a                	jmp    ed <strcmp+0x4d>
  b3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  b7:	90                   	nop
  b8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
  bc:	83 c2 01             	add    $0x1,%edx
  bf:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
  c2:	84 c0                	test   %al,%al
  c4:	74 1a                	je     e0 <strcmp+0x40>
    p++, q++;
  c6:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
  c8:	0f b6 19             	movzbl (%ecx),%ebx
  cb:	38 c3                	cmp    %al,%bl
  cd:	74 e9                	je     b8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
  cf:	29 d8                	sub    %ebx,%eax
}
  d1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  d4:	c9                   	leave  
  d5:	c3                   	ret    
  d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  dd:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
  e0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  e4:	31 c0                	xor    %eax,%eax
  e6:	29 d8                	sub    %ebx,%eax
}
  e8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  eb:	c9                   	leave  
  ec:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
  ed:	0f b6 19             	movzbl (%ecx),%ebx
  f0:	31 c0                	xor    %eax,%eax
  f2:	eb db                	jmp    cf <strcmp+0x2f>
  f4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ff:	90                   	nop

00000100 <strlen>:

uint
strlen(const char *s)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 106:	80 3a 00             	cmpb   $0x0,(%edx)
 109:	74 15                	je     120 <strlen+0x20>
 10b:	31 c0                	xor    %eax,%eax
 10d:	8d 76 00             	lea    0x0(%esi),%esi
 110:	83 c0 01             	add    $0x1,%eax
 113:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 117:	89 c1                	mov    %eax,%ecx
 119:	75 f5                	jne    110 <strlen+0x10>
    ;
  return n;
}
 11b:	89 c8                	mov    %ecx,%eax
 11d:	5d                   	pop    %ebp
 11e:	c3                   	ret    
 11f:	90                   	nop
  for(n = 0; s[n]; n++)
 120:	31 c9                	xor    %ecx,%ecx
}
 122:	5d                   	pop    %ebp
 123:	89 c8                	mov    %ecx,%eax
 125:	c3                   	ret    
 126:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 12d:	8d 76 00             	lea    0x0(%esi),%esi

00000130 <memset>:

void*
memset(void *dst, int c, uint n)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	57                   	push   %edi
 134:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 137:	8b 4d 10             	mov    0x10(%ebp),%ecx
 13a:	8b 45 0c             	mov    0xc(%ebp),%eax
 13d:	89 d7                	mov    %edx,%edi
 13f:	fc                   	cld    
 140:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 142:	8b 7d fc             	mov    -0x4(%ebp),%edi
 145:	89 d0                	mov    %edx,%eax
 147:	c9                   	leave  
 148:	c3                   	ret    
 149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000150 <strchr>:

char*
strchr(const char *s, char c)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	8b 45 08             	mov    0x8(%ebp),%eax
 156:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 15a:	0f b6 10             	movzbl (%eax),%edx
 15d:	84 d2                	test   %dl,%dl
 15f:	75 12                	jne    173 <strchr+0x23>
 161:	eb 1d                	jmp    180 <strchr+0x30>
 163:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 167:	90                   	nop
 168:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 16c:	83 c0 01             	add    $0x1,%eax
 16f:	84 d2                	test   %dl,%dl
 171:	74 0d                	je     180 <strchr+0x30>
    if(*s == c)
 173:	38 d1                	cmp    %dl,%cl
 175:	75 f1                	jne    168 <strchr+0x18>
      return (char*)s;
  return 0;
}
 177:	5d                   	pop    %ebp
 178:	c3                   	ret    
 179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 180:	31 c0                	xor    %eax,%eax
}
 182:	5d                   	pop    %ebp
 183:	c3                   	ret    
 184:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 18b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 18f:	90                   	nop

00000190 <gets>:

char*
gets(char *buf, int max)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	57                   	push   %edi
 194:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 195:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 198:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 199:	31 db                	xor    %ebx,%ebx
{
 19b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 19e:	eb 27                	jmp    1c7 <gets+0x37>
    cc = read(0, &c, 1);
 1a0:	83 ec 04             	sub    $0x4,%esp
 1a3:	6a 01                	push   $0x1
 1a5:	57                   	push   %edi
 1a6:	6a 00                	push   $0x0
 1a8:	e8 2e 01 00 00       	call   2db <read>
    if(cc < 1)
 1ad:	83 c4 10             	add    $0x10,%esp
 1b0:	85 c0                	test   %eax,%eax
 1b2:	7e 1d                	jle    1d1 <gets+0x41>
      break;
    buf[i++] = c;
 1b4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1b8:	8b 55 08             	mov    0x8(%ebp),%edx
 1bb:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 1bf:	3c 0a                	cmp    $0xa,%al
 1c1:	74 1d                	je     1e0 <gets+0x50>
 1c3:	3c 0d                	cmp    $0xd,%al
 1c5:	74 19                	je     1e0 <gets+0x50>
  for(i=0; i+1 < max; ){
 1c7:	89 de                	mov    %ebx,%esi
 1c9:	83 c3 01             	add    $0x1,%ebx
 1cc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1cf:	7c cf                	jl     1a0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 1d1:	8b 45 08             	mov    0x8(%ebp),%eax
 1d4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 1d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1db:	5b                   	pop    %ebx
 1dc:	5e                   	pop    %esi
 1dd:	5f                   	pop    %edi
 1de:	5d                   	pop    %ebp
 1df:	c3                   	ret    
  buf[i] = '\0';
 1e0:	8b 45 08             	mov    0x8(%ebp),%eax
 1e3:	89 de                	mov    %ebx,%esi
 1e5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 1e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1ec:	5b                   	pop    %ebx
 1ed:	5e                   	pop    %esi
 1ee:	5f                   	pop    %edi
 1ef:	5d                   	pop    %ebp
 1f0:	c3                   	ret    
 1f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ff:	90                   	nop

00000200 <stat>:

int
stat(const char *n, struct stat *st)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	56                   	push   %esi
 204:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 205:	83 ec 08             	sub    $0x8,%esp
 208:	6a 00                	push   $0x0
 20a:	ff 75 08             	push   0x8(%ebp)
 20d:	e8 f1 00 00 00       	call   303 <open>
  if(fd < 0)
 212:	83 c4 10             	add    $0x10,%esp
 215:	85 c0                	test   %eax,%eax
 217:	78 27                	js     240 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 219:	83 ec 08             	sub    $0x8,%esp
 21c:	ff 75 0c             	push   0xc(%ebp)
 21f:	89 c3                	mov    %eax,%ebx
 221:	50                   	push   %eax
 222:	e8 f4 00 00 00       	call   31b <fstat>
  close(fd);
 227:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 22a:	89 c6                	mov    %eax,%esi
  close(fd);
 22c:	e8 ba 00 00 00       	call   2eb <close>
  return r;
 231:	83 c4 10             	add    $0x10,%esp
}
 234:	8d 65 f8             	lea    -0x8(%ebp),%esp
 237:	89 f0                	mov    %esi,%eax
 239:	5b                   	pop    %ebx
 23a:	5e                   	pop    %esi
 23b:	5d                   	pop    %ebp
 23c:	c3                   	ret    
 23d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 240:	be ff ff ff ff       	mov    $0xffffffff,%esi
 245:	eb ed                	jmp    234 <stat+0x34>
 247:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 24e:	66 90                	xchg   %ax,%ax

00000250 <atoi>:

int
atoi(const char *s)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	53                   	push   %ebx
 254:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 257:	0f be 02             	movsbl (%edx),%eax
 25a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 25d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 260:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 265:	77 1e                	ja     285 <atoi+0x35>
 267:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 26e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 270:	83 c2 01             	add    $0x1,%edx
 273:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 276:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 27a:	0f be 02             	movsbl (%edx),%eax
 27d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 280:	80 fb 09             	cmp    $0x9,%bl
 283:	76 eb                	jbe    270 <atoi+0x20>
  return n;
}
 285:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 288:	89 c8                	mov    %ecx,%eax
 28a:	c9                   	leave  
 28b:	c3                   	ret    
 28c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000290 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	57                   	push   %edi
 294:	8b 45 10             	mov    0x10(%ebp),%eax
 297:	8b 55 08             	mov    0x8(%ebp),%edx
 29a:	56                   	push   %esi
 29b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 29e:	85 c0                	test   %eax,%eax
 2a0:	7e 13                	jle    2b5 <memmove+0x25>
 2a2:	01 d0                	add    %edx,%eax
  dst = vdst;
 2a4:	89 d7                	mov    %edx,%edi
 2a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2ad:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 2b0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 2b1:	39 f8                	cmp    %edi,%eax
 2b3:	75 fb                	jne    2b0 <memmove+0x20>
  return vdst;
}
 2b5:	5e                   	pop    %esi
 2b6:	89 d0                	mov    %edx,%eax
 2b8:	5f                   	pop    %edi
 2b9:	5d                   	pop    %ebp
 2ba:	c3                   	ret    

000002bb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2bb:	b8 01 00 00 00       	mov    $0x1,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret    

000002c3 <exit>:
SYSCALL(exit)
 2c3:	b8 02 00 00 00       	mov    $0x2,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret    

000002cb <wait>:
SYSCALL(wait)
 2cb:	b8 03 00 00 00       	mov    $0x3,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret    

000002d3 <pipe>:
SYSCALL(pipe)
 2d3:	b8 04 00 00 00       	mov    $0x4,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret    

000002db <read>:
SYSCALL(read)
 2db:	b8 05 00 00 00       	mov    $0x5,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret    

000002e3 <write>:
SYSCALL(write)
 2e3:	b8 10 00 00 00       	mov    $0x10,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret    

000002eb <close>:
SYSCALL(close)
 2eb:	b8 15 00 00 00       	mov    $0x15,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret    

000002f3 <kill>:
SYSCALL(kill)
 2f3:	b8 06 00 00 00       	mov    $0x6,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret    

000002fb <exec>:
SYSCALL(exec)
 2fb:	b8 07 00 00 00       	mov    $0x7,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret    

00000303 <open>:
SYSCALL(open)
 303:	b8 0f 00 00 00       	mov    $0xf,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret    

0000030b <mknod>:
SYSCALL(mknod)
 30b:	b8 11 00 00 00       	mov    $0x11,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret    

00000313 <unlink>:
SYSCALL(unlink)
 313:	b8 12 00 00 00       	mov    $0x12,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret    

0000031b <fstat>:
SYSCALL(fstat)
 31b:	b8 08 00 00 00       	mov    $0x8,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <link>:
SYSCALL(link)
 323:	b8 13 00 00 00       	mov    $0x13,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <mkdir>:
SYSCALL(mkdir)
 32b:	b8 14 00 00 00       	mov    $0x14,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <chdir>:
SYSCALL(chdir)
 333:	b8 09 00 00 00       	mov    $0x9,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <dup>:
SYSCALL(dup)
 33b:	b8 0a 00 00 00       	mov    $0xa,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    

00000343 <getpid>:
SYSCALL(getpid)
 343:	b8 0b 00 00 00       	mov    $0xb,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    

0000034b <sbrk>:
SYSCALL(sbrk)
 34b:	b8 0c 00 00 00       	mov    $0xc,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <sleep>:
SYSCALL(sleep)
 353:	b8 0d 00 00 00       	mov    $0xd,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    

0000035b <uptime>:
SYSCALL(uptime)
 35b:	b8 0e 00 00 00       	mov    $0xe,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret    

00000363 <create_palindrome>:
SYSCALL(create_palindrome)
 363:	b8 16 00 00 00       	mov    $0x16,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret    

0000036b <list_all_processes>:
SYSCALL(list_all_processes)
 36b:	b8 19 00 00 00       	mov    $0x19,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <setqueue>:
SYSCALL(setqueue)
 373:	b8 1a 00 00 00       	mov    $0x1a,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    

0000037b <printinfo>:
SYSCALL(printinfo)
 37b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <setburstconf>:
SYSCALL(setburstconf)
 383:	b8 1c 00 00 00       	mov    $0x1c,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <count_syscalls>:
SYSCALL(count_syscalls)
 38b:	b8 1d 00 00 00       	mov    $0x1d,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <init_reentrantlock>:
SYSCALL(init_reentrantlock)
 393:	b8 1e 00 00 00       	mov    $0x1e,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    

0000039b <acquire_reentrantlock>:
SYSCALL(acquire_reentrantlock)
 39b:	b8 1f 00 00 00       	mov    $0x1f,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret    

000003a3 <release_reentrantlock>:
 3a3:	b8 20 00 00 00       	mov    $0x20,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret    
 3ab:	66 90                	xchg   %ax,%ax
 3ad:	66 90                	xchg   %ax,%ax
 3af:	90                   	nop

000003b0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	57                   	push   %edi
 3b4:	56                   	push   %esi
 3b5:	53                   	push   %ebx
 3b6:	83 ec 3c             	sub    $0x3c,%esp
 3b9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3bc:	89 d1                	mov    %edx,%ecx
{
 3be:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 3c1:	85 d2                	test   %edx,%edx
 3c3:	0f 89 7f 00 00 00    	jns    448 <printint+0x98>
 3c9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 3cd:	74 79                	je     448 <printint+0x98>
    neg = 1;
 3cf:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 3d6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 3d8:	31 db                	xor    %ebx,%ebx
 3da:	8d 75 d7             	lea    -0x29(%ebp),%esi
 3dd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 3e0:	89 c8                	mov    %ecx,%eax
 3e2:	31 d2                	xor    %edx,%edx
 3e4:	89 cf                	mov    %ecx,%edi
 3e6:	f7 75 c4             	divl   -0x3c(%ebp)
 3e9:	0f b6 92 54 08 00 00 	movzbl 0x854(%edx),%edx
 3f0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 3f3:	89 d8                	mov    %ebx,%eax
 3f5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 3f8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 3fb:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 3fe:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 401:	76 dd                	jbe    3e0 <printint+0x30>
  if(neg)
 403:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 406:	85 c9                	test   %ecx,%ecx
 408:	74 0c                	je     416 <printint+0x66>
    buf[i++] = '-';
 40a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 40f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 411:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 416:	8b 7d b8             	mov    -0x48(%ebp),%edi
 419:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 41d:	eb 07                	jmp    426 <printint+0x76>
 41f:	90                   	nop
    putc(fd, buf[i]);
 420:	0f b6 13             	movzbl (%ebx),%edx
 423:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 426:	83 ec 04             	sub    $0x4,%esp
 429:	88 55 d7             	mov    %dl,-0x29(%ebp)
 42c:	6a 01                	push   $0x1
 42e:	56                   	push   %esi
 42f:	57                   	push   %edi
 430:	e8 ae fe ff ff       	call   2e3 <write>
  while(--i >= 0)
 435:	83 c4 10             	add    $0x10,%esp
 438:	39 de                	cmp    %ebx,%esi
 43a:	75 e4                	jne    420 <printint+0x70>
}
 43c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 43f:	5b                   	pop    %ebx
 440:	5e                   	pop    %esi
 441:	5f                   	pop    %edi
 442:	5d                   	pop    %ebp
 443:	c3                   	ret    
 444:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 448:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 44f:	eb 87                	jmp    3d8 <printint+0x28>
 451:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 458:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 45f:	90                   	nop

00000460 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	57                   	push   %edi
 464:	56                   	push   %esi
 465:	53                   	push   %ebx
 466:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 469:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 46c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 46f:	0f b6 13             	movzbl (%ebx),%edx
 472:	84 d2                	test   %dl,%dl
 474:	74 6a                	je     4e0 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
 476:	8d 45 10             	lea    0x10(%ebp),%eax
 479:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 47c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 47f:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
 481:	89 45 d0             	mov    %eax,-0x30(%ebp)
 484:	eb 36                	jmp    4bc <printf+0x5c>
 486:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 48d:	8d 76 00             	lea    0x0(%esi),%esi
 490:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 493:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
 498:	83 f8 25             	cmp    $0x25,%eax
 49b:	74 15                	je     4b2 <printf+0x52>
  write(fd, &c, 1);
 49d:	83 ec 04             	sub    $0x4,%esp
 4a0:	88 55 e7             	mov    %dl,-0x19(%ebp)
 4a3:	6a 01                	push   $0x1
 4a5:	57                   	push   %edi
 4a6:	56                   	push   %esi
 4a7:	e8 37 fe ff ff       	call   2e3 <write>
 4ac:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
 4af:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 4b2:	0f b6 13             	movzbl (%ebx),%edx
 4b5:	83 c3 01             	add    $0x1,%ebx
 4b8:	84 d2                	test   %dl,%dl
 4ba:	74 24                	je     4e0 <printf+0x80>
    c = fmt[i] & 0xff;
 4bc:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 4bf:	85 c9                	test   %ecx,%ecx
 4c1:	74 cd                	je     490 <printf+0x30>
      }
    } else if(state == '%'){
 4c3:	83 f9 25             	cmp    $0x25,%ecx
 4c6:	75 ea                	jne    4b2 <printf+0x52>
      if(c == 'd'){
 4c8:	83 f8 25             	cmp    $0x25,%eax
 4cb:	0f 84 07 01 00 00    	je     5d8 <printf+0x178>
 4d1:	83 e8 63             	sub    $0x63,%eax
 4d4:	83 f8 15             	cmp    $0x15,%eax
 4d7:	77 17                	ja     4f0 <printf+0x90>
 4d9:	ff 24 85 fc 07 00 00 	jmp    *0x7fc(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 4e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4e3:	5b                   	pop    %ebx
 4e4:	5e                   	pop    %esi
 4e5:	5f                   	pop    %edi
 4e6:	5d                   	pop    %ebp
 4e7:	c3                   	ret    
 4e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4ef:	90                   	nop
  write(fd, &c, 1);
 4f0:	83 ec 04             	sub    $0x4,%esp
 4f3:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 4f6:	6a 01                	push   $0x1
 4f8:	57                   	push   %edi
 4f9:	56                   	push   %esi
 4fa:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4fe:	e8 e0 fd ff ff       	call   2e3 <write>
        putc(fd, c);
 503:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 507:	83 c4 0c             	add    $0xc,%esp
 50a:	88 55 e7             	mov    %dl,-0x19(%ebp)
 50d:	6a 01                	push   $0x1
 50f:	57                   	push   %edi
 510:	56                   	push   %esi
 511:	e8 cd fd ff ff       	call   2e3 <write>
        putc(fd, c);
 516:	83 c4 10             	add    $0x10,%esp
      state = 0;
 519:	31 c9                	xor    %ecx,%ecx
 51b:	eb 95                	jmp    4b2 <printf+0x52>
 51d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 520:	83 ec 0c             	sub    $0xc,%esp
 523:	b9 10 00 00 00       	mov    $0x10,%ecx
 528:	6a 00                	push   $0x0
 52a:	8b 45 d0             	mov    -0x30(%ebp),%eax
 52d:	8b 10                	mov    (%eax),%edx
 52f:	89 f0                	mov    %esi,%eax
 531:	e8 7a fe ff ff       	call   3b0 <printint>
        ap++;
 536:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 53a:	83 c4 10             	add    $0x10,%esp
      state = 0;
 53d:	31 c9                	xor    %ecx,%ecx
 53f:	e9 6e ff ff ff       	jmp    4b2 <printf+0x52>
 544:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 548:	8b 45 d0             	mov    -0x30(%ebp),%eax
 54b:	8b 10                	mov    (%eax),%edx
        ap++;
 54d:	83 c0 04             	add    $0x4,%eax
 550:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 553:	85 d2                	test   %edx,%edx
 555:	0f 84 8d 00 00 00    	je     5e8 <printf+0x188>
        while(*s != 0){
 55b:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
 55e:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
 560:	84 c0                	test   %al,%al
 562:	0f 84 4a ff ff ff    	je     4b2 <printf+0x52>
 568:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 56b:	89 d3                	mov    %edx,%ebx
 56d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 570:	83 ec 04             	sub    $0x4,%esp
          s++;
 573:	83 c3 01             	add    $0x1,%ebx
 576:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 579:	6a 01                	push   $0x1
 57b:	57                   	push   %edi
 57c:	56                   	push   %esi
 57d:	e8 61 fd ff ff       	call   2e3 <write>
        while(*s != 0){
 582:	0f b6 03             	movzbl (%ebx),%eax
 585:	83 c4 10             	add    $0x10,%esp
 588:	84 c0                	test   %al,%al
 58a:	75 e4                	jne    570 <printf+0x110>
      state = 0;
 58c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 58f:	31 c9                	xor    %ecx,%ecx
 591:	e9 1c ff ff ff       	jmp    4b2 <printf+0x52>
 596:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 59d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 5a0:	83 ec 0c             	sub    $0xc,%esp
 5a3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5a8:	6a 01                	push   $0x1
 5aa:	e9 7b ff ff ff       	jmp    52a <printf+0xca>
 5af:	90                   	nop
        putc(fd, *ap);
 5b0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
 5b3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 5b6:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 5b8:	6a 01                	push   $0x1
 5ba:	57                   	push   %edi
 5bb:	56                   	push   %esi
        putc(fd, *ap);
 5bc:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5bf:	e8 1f fd ff ff       	call   2e3 <write>
        ap++;
 5c4:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 5c8:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5cb:	31 c9                	xor    %ecx,%ecx
 5cd:	e9 e0 fe ff ff       	jmp    4b2 <printf+0x52>
 5d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 5d8:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 5db:	83 ec 04             	sub    $0x4,%esp
 5de:	e9 2a ff ff ff       	jmp    50d <printf+0xad>
 5e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5e7:	90                   	nop
          s = "(null)";
 5e8:	ba f4 07 00 00       	mov    $0x7f4,%edx
        while(*s != 0){
 5ed:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 5f0:	b8 28 00 00 00       	mov    $0x28,%eax
 5f5:	89 d3                	mov    %edx,%ebx
 5f7:	e9 74 ff ff ff       	jmp    570 <printf+0x110>
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
 601:	a1 04 0b 00 00       	mov    0xb04,%eax
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
 632:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 635:	8b 42 04             	mov    0x4(%edx),%eax
 638:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 63b:	39 f1                	cmp    %esi,%ecx
 63d:	74 3a                	je     679 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 63f:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 641:	5b                   	pop    %ebx
  freep = p;
 642:	89 15 04 0b 00 00    	mov    %edx,0xb04
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
 67c:	89 15 04 0b 00 00    	mov    %edx,0xb04
    p->s.size += bp->s.size;
 682:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 685:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 688:	89 0a                	mov    %ecx,(%edx)
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
 69c:	8b 3d 04 0b 00 00    	mov    0xb04,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6a2:	8d 70 07             	lea    0x7(%eax),%esi
 6a5:	c1 ee 03             	shr    $0x3,%esi
 6a8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 6ab:	85 ff                	test   %edi,%edi
 6ad:	0f 84 9d 00 00 00    	je     750 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6b3:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 6b5:	8b 4a 04             	mov    0x4(%edx),%ecx
 6b8:	39 f1                	cmp    %esi,%ecx
 6ba:	73 6a                	jae    726 <malloc+0x96>
 6bc:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6c1:	39 de                	cmp    %ebx,%esi
 6c3:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 6c6:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 6cd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 6d0:	eb 17                	jmp    6e9 <malloc+0x59>
 6d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6d8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6da:	8b 48 04             	mov    0x4(%eax),%ecx
 6dd:	39 f1                	cmp    %esi,%ecx
 6df:	73 4f                	jae    730 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6e1:	8b 3d 04 0b 00 00    	mov    0xb04,%edi
 6e7:	89 c2                	mov    %eax,%edx
 6e9:	39 d7                	cmp    %edx,%edi
 6eb:	75 eb                	jne    6d8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 6ed:	83 ec 0c             	sub    $0xc,%esp
 6f0:	ff 75 e4             	push   -0x1c(%ebp)
 6f3:	e8 53 fc ff ff       	call   34b <sbrk>
  if(p == (char*)-1)
 6f8:	83 c4 10             	add    $0x10,%esp
 6fb:	83 f8 ff             	cmp    $0xffffffff,%eax
 6fe:	74 1c                	je     71c <malloc+0x8c>
  hp->s.size = nu;
 700:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 703:	83 ec 0c             	sub    $0xc,%esp
 706:	83 c0 08             	add    $0x8,%eax
 709:	50                   	push   %eax
 70a:	e8 f1 fe ff ff       	call   600 <free>
  return freep;
 70f:	8b 15 04 0b 00 00    	mov    0xb04,%edx
      if((p = morecore(nunits)) == 0)
 715:	83 c4 10             	add    $0x10,%esp
 718:	85 d2                	test   %edx,%edx
 71a:	75 bc                	jne    6d8 <malloc+0x48>
        return 0;
  }
}
 71c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 71f:	31 c0                	xor    %eax,%eax
}
 721:	5b                   	pop    %ebx
 722:	5e                   	pop    %esi
 723:	5f                   	pop    %edi
 724:	5d                   	pop    %ebp
 725:	c3                   	ret    
    if(p->s.size >= nunits){
 726:	89 d0                	mov    %edx,%eax
 728:	89 fa                	mov    %edi,%edx
 72a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 730:	39 ce                	cmp    %ecx,%esi
 732:	74 4c                	je     780 <malloc+0xf0>
        p->s.size -= nunits;
 734:	29 f1                	sub    %esi,%ecx
 736:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 739:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 73c:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 73f:	89 15 04 0b 00 00    	mov    %edx,0xb04
}
 745:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 748:	83 c0 08             	add    $0x8,%eax
}
 74b:	5b                   	pop    %ebx
 74c:	5e                   	pop    %esi
 74d:	5f                   	pop    %edi
 74e:	5d                   	pop    %ebp
 74f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 750:	c7 05 04 0b 00 00 08 	movl   $0xb08,0xb04
 757:	0b 00 00 
    base.s.size = 0;
 75a:	bf 08 0b 00 00       	mov    $0xb08,%edi
    base.s.ptr = freep = prevp = &base;
 75f:	c7 05 08 0b 00 00 08 	movl   $0xb08,0xb08
 766:	0b 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 769:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 76b:	c7 05 0c 0b 00 00 00 	movl   $0x0,0xb0c
 772:	00 00 00 
    if(p->s.size >= nunits){
 775:	e9 42 ff ff ff       	jmp    6bc <malloc+0x2c>
 77a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 780:	8b 08                	mov    (%eax),%ecx
 782:	89 0a                	mov    %ecx,(%edx)
 784:	eb b9                	jmp    73f <malloc+0xaf>
