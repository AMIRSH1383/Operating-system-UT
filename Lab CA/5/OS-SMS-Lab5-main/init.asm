
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   f:	83 ec 08             	sub    $0x8,%esp
  12:	6a 02                	push   $0x2
  14:	68 58 08 00 00       	push   $0x858
  19:	e8 85 03 00 00       	call   3a3 <open>
  1e:	83 c4 10             	add    $0x10,%esp
  21:	85 c0                	test   %eax,%eax
  23:	0f 88 cf 00 00 00    	js     f8 <main+0xf8>
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  29:	83 ec 0c             	sub    $0xc,%esp
  2c:	6a 00                	push   $0x0
  2e:	e8 a8 03 00 00       	call   3db <dup>
  dup(0);  // stderr
  33:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  3a:	e8 9c 03 00 00       	call   3db <dup>
  3f:	83 c4 10             	add    $0x10,%esp
  42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  for(;;){
    // ----------------------------------------
    printf(1, "\nMembers of Team SMS:\n");
  48:	83 ec 08             	sub    $0x8,%esp
  4b:	68 60 08 00 00       	push   $0x860
  50:	6a 01                	push   $0x1
  52:	e8 99 04 00 00       	call   4f0 <printf>
    printf(1, "  Mohamad Mahdi Samadi\n");
  57:	58                   	pop    %eax
  58:	5a                   	pop    %edx
  59:	68 77 08 00 00       	push   $0x877
  5e:	6a 01                	push   $0x1
  60:	e8 8b 04 00 00       	call   4f0 <printf>
    printf(1, "   Amir Arsalan Shahbazi\n");
  65:	59                   	pop    %ecx
  66:	5b                   	pop    %ebx
  67:	68 8f 08 00 00       	push   $0x88f
  6c:	6a 01                	push   $0x1
  6e:	e8 7d 04 00 00       	call   4f0 <printf>
    printf(1, "    Mohammad Hosein Mazhari\n");
  73:	58                   	pop    %eax
  74:	5a                   	pop    %edx
  75:	68 a9 08 00 00       	push   $0x8a9
  7a:	6a 01                	push   $0x1
  7c:	e8 6f 04 00 00       	call   4f0 <printf>
    // ----------------------------------------
    printf(1, "init: starting sh\n");
  81:	59                   	pop    %ecx
  82:	5b                   	pop    %ebx
  83:	68 c6 08 00 00       	push   $0x8c6
  88:	6a 01                	push   $0x1
  8a:	e8 61 04 00 00       	call   4f0 <printf>
    pid = fork();
  8f:	e8 c7 02 00 00       	call   35b <fork>
    if(pid < 0){
  94:	83 c4 10             	add    $0x10,%esp
    pid = fork();
  97:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
  99:	85 c0                	test   %eax,%eax
  9b:	78 24                	js     c1 <main+0xc1>
      printf(1, "init: fork failed\n");
      exit();
    }
    if(pid == 0){
  9d:	74 35                	je     d4 <main+0xd4>
  9f:	90                   	nop
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  a0:	e8 c6 02 00 00       	call   36b <wait>
  a5:	85 c0                	test   %eax,%eax
  a7:	78 9f                	js     48 <main+0x48>
  a9:	39 c3                	cmp    %eax,%ebx
  ab:	74 9b                	je     48 <main+0x48>
      printf(1, "zombie!\n");
  ad:	83 ec 08             	sub    $0x8,%esp
  b0:	68 05 09 00 00       	push   $0x905
  b5:	6a 01                	push   $0x1
  b7:	e8 34 04 00 00       	call   4f0 <printf>
  bc:	83 c4 10             	add    $0x10,%esp
  bf:	eb df                	jmp    a0 <main+0xa0>
      printf(1, "init: fork failed\n");
  c1:	53                   	push   %ebx
  c2:	53                   	push   %ebx
  c3:	68 d9 08 00 00       	push   $0x8d9
  c8:	6a 01                	push   $0x1
  ca:	e8 21 04 00 00       	call   4f0 <printf>
      exit();
  cf:	e8 8f 02 00 00       	call   363 <exit>
      exec("sh", argv);
  d4:	50                   	push   %eax
  d5:	50                   	push   %eax
  d6:	68 c0 0b 00 00       	push   $0xbc0
  db:	68 ec 08 00 00       	push   $0x8ec
  e0:	e8 b6 02 00 00       	call   39b <exec>
      printf(1, "init: exec sh failed\n");
  e5:	5a                   	pop    %edx
  e6:	59                   	pop    %ecx
  e7:	68 ef 08 00 00       	push   $0x8ef
  ec:	6a 01                	push   $0x1
  ee:	e8 fd 03 00 00       	call   4f0 <printf>
      exit();
  f3:	e8 6b 02 00 00       	call   363 <exit>
    mknod("console", 1, 1);
  f8:	50                   	push   %eax
  f9:	6a 01                	push   $0x1
  fb:	6a 01                	push   $0x1
  fd:	68 58 08 00 00       	push   $0x858
 102:	e8 a4 02 00 00       	call   3ab <mknod>
    open("console", O_RDWR);
 107:	58                   	pop    %eax
 108:	5a                   	pop    %edx
 109:	6a 02                	push   $0x2
 10b:	68 58 08 00 00       	push   $0x858
 110:	e8 8e 02 00 00       	call   3a3 <open>
 115:	83 c4 10             	add    $0x10,%esp
 118:	e9 0c ff ff ff       	jmp    29 <main+0x29>
 11d:	66 90                	xchg   %ax,%ax
 11f:	90                   	nop

00000120 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 120:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 121:	31 c0                	xor    %eax,%eax
{
 123:	89 e5                	mov    %esp,%ebp
 125:	53                   	push   %ebx
 126:	8b 4d 08             	mov    0x8(%ebp),%ecx
 129:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 12c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 130:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 134:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 137:	83 c0 01             	add    $0x1,%eax
 13a:	84 d2                	test   %dl,%dl
 13c:	75 f2                	jne    130 <strcpy+0x10>
    ;
  return os;
}
 13e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 141:	89 c8                	mov    %ecx,%eax
 143:	c9                   	leave
 144:	c3                   	ret
 145:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 14c:	00 
 14d:	8d 76 00             	lea    0x0(%esi),%esi

00000150 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	53                   	push   %ebx
 154:	8b 4d 08             	mov    0x8(%ebp),%ecx
 157:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 15a:	0f b6 01             	movzbl (%ecx),%eax
 15d:	0f b6 1a             	movzbl (%edx),%ebx
 160:	84 c0                	test   %al,%al
 162:	75 1c                	jne    180 <strcmp+0x30>
 164:	eb 2e                	jmp    194 <strcmp+0x44>
 166:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 16d:	00 
 16e:	66 90                	xchg   %ax,%ax
 170:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 174:	83 c1 01             	add    $0x1,%ecx
 177:	8d 5a 01             	lea    0x1(%edx),%ebx
  while(*p && *p == *q)
 17a:	84 c0                	test   %al,%al
 17c:	74 12                	je     190 <strcmp+0x40>
    p++, q++;
 17e:	89 da                	mov    %ebx,%edx
  while(*p && *p == *q)
 180:	0f b6 1a             	movzbl (%edx),%ebx
 183:	38 c3                	cmp    %al,%bl
 185:	74 e9                	je     170 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 187:	29 d8                	sub    %ebx,%eax
}
 189:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 18c:	c9                   	leave
 18d:	c3                   	ret
 18e:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 190:	0f b6 5a 01          	movzbl 0x1(%edx),%ebx
 194:	31 c0                	xor    %eax,%eax
 196:	29 d8                	sub    %ebx,%eax
}
 198:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 19b:	c9                   	leave
 19c:	c3                   	ret
 19d:	8d 76 00             	lea    0x0(%esi),%esi

000001a0 <strlen>:

uint
strlen(const char *s)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 1a6:	80 3a 00             	cmpb   $0x0,(%edx)
 1a9:	74 15                	je     1c0 <strlen+0x20>
 1ab:	31 c0                	xor    %eax,%eax
 1ad:	8d 76 00             	lea    0x0(%esi),%esi
 1b0:	83 c0 01             	add    $0x1,%eax
 1b3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 1b7:	89 c1                	mov    %eax,%ecx
 1b9:	75 f5                	jne    1b0 <strlen+0x10>
    ;
  return n;
}
 1bb:	89 c8                	mov    %ecx,%eax
 1bd:	5d                   	pop    %ebp
 1be:	c3                   	ret
 1bf:	90                   	nop
  for(n = 0; s[n]; n++)
 1c0:	31 c9                	xor    %ecx,%ecx
}
 1c2:	5d                   	pop    %ebp
 1c3:	89 c8                	mov    %ecx,%eax
 1c5:	c3                   	ret
 1c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1cd:	00 
 1ce:	66 90                	xchg   %ax,%ax

000001d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	57                   	push   %edi
 1d4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1da:	8b 45 0c             	mov    0xc(%ebp),%eax
 1dd:	89 d7                	mov    %edx,%edi
 1df:	fc                   	cld
 1e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1e2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 1e5:	89 d0                	mov    %edx,%eax
 1e7:	c9                   	leave
 1e8:	c3                   	ret
 1e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001f0 <strchr>:

char*
strchr(const char *s, char c)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 45 08             	mov    0x8(%ebp),%eax
 1f6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1fa:	0f b6 10             	movzbl (%eax),%edx
 1fd:	84 d2                	test   %dl,%dl
 1ff:	75 12                	jne    213 <strchr+0x23>
 201:	eb 1d                	jmp    220 <strchr+0x30>
 203:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 208:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 20c:	83 c0 01             	add    $0x1,%eax
 20f:	84 d2                	test   %dl,%dl
 211:	74 0d                	je     220 <strchr+0x30>
    if(*s == c)
 213:	38 d1                	cmp    %dl,%cl
 215:	75 f1                	jne    208 <strchr+0x18>
      return (char*)s;
  return 0;
}
 217:	5d                   	pop    %ebp
 218:	c3                   	ret
 219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 220:	31 c0                	xor    %eax,%eax
}
 222:	5d                   	pop    %ebp
 223:	c3                   	ret
 224:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 22b:	00 
 22c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000230 <gets>:

char*
gets(char *buf, int max)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	57                   	push   %edi
 234:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 235:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 238:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 239:	31 db                	xor    %ebx,%ebx
{
 23b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 23e:	eb 27                	jmp    267 <gets+0x37>
    cc = read(0, &c, 1);
 240:	83 ec 04             	sub    $0x4,%esp
 243:	6a 01                	push   $0x1
 245:	57                   	push   %edi
 246:	6a 00                	push   $0x0
 248:	e8 2e 01 00 00       	call   37b <read>
    if(cc < 1)
 24d:	83 c4 10             	add    $0x10,%esp
 250:	85 c0                	test   %eax,%eax
 252:	7e 1d                	jle    271 <gets+0x41>
      break;
    buf[i++] = c;
 254:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 258:	8b 55 08             	mov    0x8(%ebp),%edx
 25b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 25f:	3c 0a                	cmp    $0xa,%al
 261:	74 1d                	je     280 <gets+0x50>
 263:	3c 0d                	cmp    $0xd,%al
 265:	74 19                	je     280 <gets+0x50>
  for(i=0; i+1 < max; ){
 267:	89 de                	mov    %ebx,%esi
 269:	83 c3 01             	add    $0x1,%ebx
 26c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 26f:	7c cf                	jl     240 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 271:	8b 45 08             	mov    0x8(%ebp),%eax
 274:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 278:	8d 65 f4             	lea    -0xc(%ebp),%esp
 27b:	5b                   	pop    %ebx
 27c:	5e                   	pop    %esi
 27d:	5f                   	pop    %edi
 27e:	5d                   	pop    %ebp
 27f:	c3                   	ret
  buf[i] = '\0';
 280:	8b 45 08             	mov    0x8(%ebp),%eax
 283:	89 de                	mov    %ebx,%esi
 285:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 289:	8d 65 f4             	lea    -0xc(%ebp),%esp
 28c:	5b                   	pop    %ebx
 28d:	5e                   	pop    %esi
 28e:	5f                   	pop    %edi
 28f:	5d                   	pop    %ebp
 290:	c3                   	ret
 291:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 298:	00 
 299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002a0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	56                   	push   %esi
 2a4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2a5:	83 ec 08             	sub    $0x8,%esp
 2a8:	6a 00                	push   $0x0
 2aa:	ff 75 08             	push   0x8(%ebp)
 2ad:	e8 f1 00 00 00       	call   3a3 <open>
  if(fd < 0)
 2b2:	83 c4 10             	add    $0x10,%esp
 2b5:	85 c0                	test   %eax,%eax
 2b7:	78 27                	js     2e0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 2b9:	83 ec 08             	sub    $0x8,%esp
 2bc:	ff 75 0c             	push   0xc(%ebp)
 2bf:	89 c3                	mov    %eax,%ebx
 2c1:	50                   	push   %eax
 2c2:	e8 f4 00 00 00       	call   3bb <fstat>
  close(fd);
 2c7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2ca:	89 c6                	mov    %eax,%esi
  close(fd);
 2cc:	e8 ba 00 00 00       	call   38b <close>
  return r;
 2d1:	83 c4 10             	add    $0x10,%esp
}
 2d4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2d7:	89 f0                	mov    %esi,%eax
 2d9:	5b                   	pop    %ebx
 2da:	5e                   	pop    %esi
 2db:	5d                   	pop    %ebp
 2dc:	c3                   	ret
 2dd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 2e0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2e5:	eb ed                	jmp    2d4 <stat+0x34>
 2e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2ee:	00 
 2ef:	90                   	nop

000002f0 <atoi>:

int
atoi(const char *s)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	53                   	push   %ebx
 2f4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2f7:	0f be 02             	movsbl (%edx),%eax
 2fa:	8d 48 d0             	lea    -0x30(%eax),%ecx
 2fd:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 300:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 305:	77 1e                	ja     325 <atoi+0x35>
 307:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 30e:	00 
 30f:	90                   	nop
    n = n*10 + *s++ - '0';
 310:	83 c2 01             	add    $0x1,%edx
 313:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 316:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 31a:	0f be 02             	movsbl (%edx),%eax
 31d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 320:	80 fb 09             	cmp    $0x9,%bl
 323:	76 eb                	jbe    310 <atoi+0x20>
  return n;
}
 325:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 328:	89 c8                	mov    %ecx,%eax
 32a:	c9                   	leave
 32b:	c3                   	ret
 32c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000330 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	57                   	push   %edi
 334:	8b 45 10             	mov    0x10(%ebp),%eax
 337:	8b 55 08             	mov    0x8(%ebp),%edx
 33a:	56                   	push   %esi
 33b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 33e:	85 c0                	test   %eax,%eax
 340:	7e 13                	jle    355 <memmove+0x25>
 342:	01 d0                	add    %edx,%eax
  dst = vdst;
 344:	89 d7                	mov    %edx,%edi
 346:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 34d:	00 
 34e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 350:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 351:	39 f8                	cmp    %edi,%eax
 353:	75 fb                	jne    350 <memmove+0x20>
  return vdst;
}
 355:	5e                   	pop    %esi
 356:	89 d0                	mov    %edx,%eax
 358:	5f                   	pop    %edi
 359:	5d                   	pop    %ebp
 35a:	c3                   	ret

0000035b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 35b:	b8 01 00 00 00       	mov    $0x1,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret

00000363 <exit>:
SYSCALL(exit)
 363:	b8 02 00 00 00       	mov    $0x2,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret

0000036b <wait>:
SYSCALL(wait)
 36b:	b8 03 00 00 00       	mov    $0x3,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret

00000373 <pipe>:
SYSCALL(pipe)
 373:	b8 04 00 00 00       	mov    $0x4,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret

0000037b <read>:
SYSCALL(read)
 37b:	b8 05 00 00 00       	mov    $0x5,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret

00000383 <write>:
SYSCALL(write)
 383:	b8 10 00 00 00       	mov    $0x10,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret

0000038b <close>:
SYSCALL(close)
 38b:	b8 15 00 00 00       	mov    $0x15,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret

00000393 <kill>:
SYSCALL(kill)
 393:	b8 06 00 00 00       	mov    $0x6,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret

0000039b <exec>:
SYSCALL(exec)
 39b:	b8 07 00 00 00       	mov    $0x7,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret

000003a3 <open>:
SYSCALL(open)
 3a3:	b8 0f 00 00 00       	mov    $0xf,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret

000003ab <mknod>:
SYSCALL(mknod)
 3ab:	b8 11 00 00 00       	mov    $0x11,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret

000003b3 <unlink>:
SYSCALL(unlink)
 3b3:	b8 12 00 00 00       	mov    $0x12,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret

000003bb <fstat>:
SYSCALL(fstat)
 3bb:	b8 08 00 00 00       	mov    $0x8,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret

000003c3 <link>:
SYSCALL(link)
 3c3:	b8 13 00 00 00       	mov    $0x13,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret

000003cb <mkdir>:
SYSCALL(mkdir)
 3cb:	b8 14 00 00 00       	mov    $0x14,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret

000003d3 <chdir>:
SYSCALL(chdir)
 3d3:	b8 09 00 00 00       	mov    $0x9,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret

000003db <dup>:
SYSCALL(dup)
 3db:	b8 0a 00 00 00       	mov    $0xa,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret

000003e3 <getpid>:
SYSCALL(getpid)
 3e3:	b8 0b 00 00 00       	mov    $0xb,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret

000003eb <sbrk>:
SYSCALL(sbrk)
 3eb:	b8 0c 00 00 00       	mov    $0xc,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret

000003f3 <sleep>:
SYSCALL(sleep)
 3f3:	b8 0d 00 00 00       	mov    $0xd,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret

000003fb <uptime>:
SYSCALL(uptime)
 3fb:	b8 0e 00 00 00       	mov    $0xe,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret

00000403 <create_palindrome>:
SYSCALL(create_palindrome)
 403:	b8 16 00 00 00       	mov    $0x16,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret

0000040b <sort_syscalls>:
SYSCALL(sort_syscalls)
 40b:	b8 17 00 00 00       	mov    $0x17,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret

00000413 <get_most_invoked_syscall>:
SYSCALL(get_most_invoked_syscall)
 413:	b8 18 00 00 00       	mov    $0x18,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret

0000041b <list_all_processes>:
SYSCALL(list_all_processes)
 41b:	b8 19 00 00 00       	mov    $0x19,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret

00000423 <move_file>:
SYSCALL(move_file)
 423:	b8 1a 00 00 00       	mov    $0x1a,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret

0000042b <open_sharedmem>:
SYSCALL(open_sharedmem)
 42b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret

00000433 <close_sharedmem>:
 433:	b8 1c 00 00 00       	mov    $0x1c,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret
 43b:	66 90                	xchg   %ax,%ax
 43d:	66 90                	xchg   %ax,%ax
 43f:	90                   	nop

00000440 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	57                   	push   %edi
 444:	56                   	push   %esi
 445:	53                   	push   %ebx
 446:	83 ec 3c             	sub    $0x3c,%esp
 449:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 44c:	89 d1                	mov    %edx,%ecx
{
 44e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 451:	85 d2                	test   %edx,%edx
 453:	0f 89 7f 00 00 00    	jns    4d8 <printint+0x98>
 459:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 45d:	74 79                	je     4d8 <printint+0x98>
    neg = 1;
 45f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 466:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 468:	31 db                	xor    %ebx,%ebx
 46a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 46d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 470:	89 c8                	mov    %ecx,%eax
 472:	31 d2                	xor    %edx,%edx
 474:	89 cf                	mov    %ecx,%edi
 476:	f7 75 c4             	divl   -0x3c(%ebp)
 479:	0f b6 92 18 09 00 00 	movzbl 0x918(%edx),%edx
 480:	89 45 c0             	mov    %eax,-0x40(%ebp)
 483:	89 d8                	mov    %ebx,%eax
 485:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 488:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 48b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 48e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 491:	76 dd                	jbe    470 <printint+0x30>
  if(neg)
 493:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 496:	85 c9                	test   %ecx,%ecx
 498:	74 0c                	je     4a6 <printint+0x66>
    buf[i++] = '-';
 49a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 49f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 4a1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 4a6:	8b 7d b8             	mov    -0x48(%ebp),%edi
 4a9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 4ad:	eb 07                	jmp    4b6 <printint+0x76>
 4af:	90                   	nop
    putc(fd, buf[i]);
 4b0:	0f b6 13             	movzbl (%ebx),%edx
 4b3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 4b6:	83 ec 04             	sub    $0x4,%esp
 4b9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 4bc:	6a 01                	push   $0x1
 4be:	56                   	push   %esi
 4bf:	57                   	push   %edi
 4c0:	e8 be fe ff ff       	call   383 <write>
  while(--i >= 0)
 4c5:	83 c4 10             	add    $0x10,%esp
 4c8:	39 de                	cmp    %ebx,%esi
 4ca:	75 e4                	jne    4b0 <printint+0x70>
}
 4cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4cf:	5b                   	pop    %ebx
 4d0:	5e                   	pop    %esi
 4d1:	5f                   	pop    %edi
 4d2:	5d                   	pop    %ebp
 4d3:	c3                   	ret
 4d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 4d8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 4df:	eb 87                	jmp    468 <printint+0x28>
 4e1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4e8:	00 
 4e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000004f0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4f0:	55                   	push   %ebp
 4f1:	89 e5                	mov    %esp,%ebp
 4f3:	57                   	push   %edi
 4f4:	56                   	push   %esi
 4f5:	53                   	push   %ebx
 4f6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4f9:	8b 75 0c             	mov    0xc(%ebp),%esi
 4fc:	0f b6 1e             	movzbl (%esi),%ebx
 4ff:	84 db                	test   %bl,%bl
 501:	0f 84 b8 00 00 00    	je     5bf <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 507:	8d 45 10             	lea    0x10(%ebp),%eax
 50a:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 50d:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 510:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 512:	89 45 d0             	mov    %eax,-0x30(%ebp)
 515:	eb 37                	jmp    54e <printf+0x5e>
 517:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 51e:	00 
 51f:	90                   	nop
 520:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 523:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 528:	83 f8 25             	cmp    $0x25,%eax
 52b:	74 17                	je     544 <printf+0x54>
  write(fd, &c, 1);
 52d:	83 ec 04             	sub    $0x4,%esp
 530:	88 5d e7             	mov    %bl,-0x19(%ebp)
 533:	6a 01                	push   $0x1
 535:	57                   	push   %edi
 536:	ff 75 08             	push   0x8(%ebp)
 539:	e8 45 fe ff ff       	call   383 <write>
 53e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 541:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 544:	0f b6 1e             	movzbl (%esi),%ebx
 547:	83 c6 01             	add    $0x1,%esi
 54a:	84 db                	test   %bl,%bl
 54c:	74 71                	je     5bf <printf+0xcf>
    c = fmt[i] & 0xff;
 54e:	0f be cb             	movsbl %bl,%ecx
 551:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 554:	85 d2                	test   %edx,%edx
 556:	74 c8                	je     520 <printf+0x30>
      }
    } else if(state == '%'){
 558:	83 fa 25             	cmp    $0x25,%edx
 55b:	75 e7                	jne    544 <printf+0x54>
      if(c == 'd'){
 55d:	83 f8 64             	cmp    $0x64,%eax
 560:	0f 84 9a 00 00 00    	je     600 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 566:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 56c:	83 f9 70             	cmp    $0x70,%ecx
 56f:	74 5f                	je     5d0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 571:	83 f8 73             	cmp    $0x73,%eax
 574:	0f 84 d6 00 00 00    	je     650 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 57a:	83 f8 63             	cmp    $0x63,%eax
 57d:	0f 84 8d 00 00 00    	je     610 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 583:	83 f8 25             	cmp    $0x25,%eax
 586:	0f 84 b4 00 00 00    	je     640 <printf+0x150>
  write(fd, &c, 1);
 58c:	83 ec 04             	sub    $0x4,%esp
 58f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 593:	6a 01                	push   $0x1
 595:	57                   	push   %edi
 596:	ff 75 08             	push   0x8(%ebp)
 599:	e8 e5 fd ff ff       	call   383 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 59e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 5a1:	83 c4 0c             	add    $0xc,%esp
 5a4:	6a 01                	push   $0x1
  for(i = 0; fmt[i]; i++){
 5a6:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 5a9:	57                   	push   %edi
 5aa:	ff 75 08             	push   0x8(%ebp)
 5ad:	e8 d1 fd ff ff       	call   383 <write>
  for(i = 0; fmt[i]; i++){
 5b2:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 5b6:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5b9:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 5bb:	84 db                	test   %bl,%bl
 5bd:	75 8f                	jne    54e <printf+0x5e>
    }
  }
}
 5bf:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5c2:	5b                   	pop    %ebx
 5c3:	5e                   	pop    %esi
 5c4:	5f                   	pop    %edi
 5c5:	5d                   	pop    %ebp
 5c6:	c3                   	ret
 5c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5ce:	00 
 5cf:	90                   	nop
        printint(fd, *ap, 16, 0);
 5d0:	83 ec 0c             	sub    $0xc,%esp
 5d3:	b9 10 00 00 00       	mov    $0x10,%ecx
 5d8:	6a 00                	push   $0x0
 5da:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5dd:	8b 45 08             	mov    0x8(%ebp),%eax
 5e0:	8b 13                	mov    (%ebx),%edx
 5e2:	e8 59 fe ff ff       	call   440 <printint>
        ap++;
 5e7:	89 d8                	mov    %ebx,%eax
 5e9:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5ec:	31 d2                	xor    %edx,%edx
        ap++;
 5ee:	83 c0 04             	add    $0x4,%eax
 5f1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5f4:	e9 4b ff ff ff       	jmp    544 <printf+0x54>
 5f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 600:	83 ec 0c             	sub    $0xc,%esp
 603:	b9 0a 00 00 00       	mov    $0xa,%ecx
 608:	6a 01                	push   $0x1
 60a:	eb ce                	jmp    5da <printf+0xea>
 60c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 610:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 613:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 616:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 618:	6a 01                	push   $0x1
        ap++;
 61a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 61d:	57                   	push   %edi
 61e:	ff 75 08             	push   0x8(%ebp)
        putc(fd, *ap);
 621:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 624:	e8 5a fd ff ff       	call   383 <write>
        ap++;
 629:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 62c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 62f:	31 d2                	xor    %edx,%edx
 631:	e9 0e ff ff ff       	jmp    544 <printf+0x54>
 636:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 63d:	00 
 63e:	66 90                	xchg   %ax,%ax
        putc(fd, c);
 640:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 643:	83 ec 04             	sub    $0x4,%esp
 646:	e9 59 ff ff ff       	jmp    5a4 <printf+0xb4>
 64b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 650:	8b 45 d0             	mov    -0x30(%ebp),%eax
 653:	8b 18                	mov    (%eax),%ebx
        ap++;
 655:	83 c0 04             	add    $0x4,%eax
 658:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 65b:	85 db                	test   %ebx,%ebx
 65d:	74 17                	je     676 <printf+0x186>
        while(*s != 0){
 65f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 662:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 664:	84 c0                	test   %al,%al
 666:	0f 84 d8 fe ff ff    	je     544 <printf+0x54>
 66c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 66f:	89 de                	mov    %ebx,%esi
 671:	8b 5d 08             	mov    0x8(%ebp),%ebx
 674:	eb 1a                	jmp    690 <printf+0x1a0>
          s = "(null)";
 676:	bb 0e 09 00 00       	mov    $0x90e,%ebx
        while(*s != 0){
 67b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 67e:	b8 28 00 00 00       	mov    $0x28,%eax
 683:	89 de                	mov    %ebx,%esi
 685:	8b 5d 08             	mov    0x8(%ebp),%ebx
 688:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 68f:	00 
  write(fd, &c, 1);
 690:	83 ec 04             	sub    $0x4,%esp
          s++;
 693:	83 c6 01             	add    $0x1,%esi
 696:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 699:	6a 01                	push   $0x1
 69b:	57                   	push   %edi
 69c:	53                   	push   %ebx
 69d:	e8 e1 fc ff ff       	call   383 <write>
        while(*s != 0){
 6a2:	0f b6 06             	movzbl (%esi),%eax
 6a5:	83 c4 10             	add    $0x10,%esp
 6a8:	84 c0                	test   %al,%al
 6aa:	75 e4                	jne    690 <printf+0x1a0>
      state = 0;
 6ac:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 6af:	31 d2                	xor    %edx,%edx
 6b1:	e9 8e fe ff ff       	jmp    544 <printf+0x54>
 6b6:	66 90                	xchg   %ax,%ax
 6b8:	66 90                	xchg   %ax,%ax
 6ba:	66 90                	xchg   %ax,%ax
 6bc:	66 90                	xchg   %ax,%ax
 6be:	66 90                	xchg   %ax,%ax

000006c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c1:	a1 c8 0b 00 00       	mov    0xbc8,%eax
{
 6c6:	89 e5                	mov    %esp,%ebp
 6c8:	57                   	push   %edi
 6c9:	56                   	push   %esi
 6ca:	53                   	push   %ebx
 6cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 6ce:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6d8:	89 c2                	mov    %eax,%edx
 6da:	8b 00                	mov    (%eax),%eax
 6dc:	39 ca                	cmp    %ecx,%edx
 6de:	73 30                	jae    710 <free+0x50>
 6e0:	39 c1                	cmp    %eax,%ecx
 6e2:	72 04                	jb     6e8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6e4:	39 c2                	cmp    %eax,%edx
 6e6:	72 f0                	jb     6d8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6e8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6eb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6ee:	39 f8                	cmp    %edi,%eax
 6f0:	74 30                	je     722 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6f2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 6f5:	8b 42 04             	mov    0x4(%edx),%eax
 6f8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 6fb:	39 f1                	cmp    %esi,%ecx
 6fd:	74 3a                	je     739 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6ff:	89 0a                	mov    %ecx,(%edx)
  freep = p;
}
 701:	5b                   	pop    %ebx
  freep = p;
 702:	89 15 c8 0b 00 00    	mov    %edx,0xbc8
}
 708:	5e                   	pop    %esi
 709:	5f                   	pop    %edi
 70a:	5d                   	pop    %ebp
 70b:	c3                   	ret
 70c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 710:	39 c2                	cmp    %eax,%edx
 712:	72 c4                	jb     6d8 <free+0x18>
 714:	39 c1                	cmp    %eax,%ecx
 716:	73 c0                	jae    6d8 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 718:	8b 73 fc             	mov    -0x4(%ebx),%esi
 71b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 71e:	39 f8                	cmp    %edi,%eax
 720:	75 d0                	jne    6f2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 722:	03 70 04             	add    0x4(%eax),%esi
 725:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 728:	8b 02                	mov    (%edx),%eax
 72a:	8b 00                	mov    (%eax),%eax
 72c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 72f:	8b 42 04             	mov    0x4(%edx),%eax
 732:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 735:	39 f1                	cmp    %esi,%ecx
 737:	75 c6                	jne    6ff <free+0x3f>
    p->s.size += bp->s.size;
 739:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 73c:	89 15 c8 0b 00 00    	mov    %edx,0xbc8
    p->s.size += bp->s.size;
 742:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 745:	8b 43 f8             	mov    -0x8(%ebx),%eax
 748:	89 02                	mov    %eax,(%edx)
}
 74a:	5b                   	pop    %ebx
 74b:	5e                   	pop    %esi
 74c:	5f                   	pop    %edi
 74d:	5d                   	pop    %ebp
 74e:	c3                   	ret
 74f:	90                   	nop

00000750 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 750:	55                   	push   %ebp
 751:	89 e5                	mov    %esp,%ebp
 753:	57                   	push   %edi
 754:	56                   	push   %esi
 755:	53                   	push   %ebx
 756:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 759:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 75c:	8b 3d c8 0b 00 00    	mov    0xbc8,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 762:	8d 70 07             	lea    0x7(%eax),%esi
 765:	c1 ee 03             	shr    $0x3,%esi
 768:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 76b:	85 ff                	test   %edi,%edi
 76d:	0f 84 ad 00 00 00    	je     820 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 773:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 775:	8b 48 04             	mov    0x4(%eax),%ecx
 778:	39 f1                	cmp    %esi,%ecx
 77a:	73 71                	jae    7ed <malloc+0x9d>
 77c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 782:	bb 00 10 00 00       	mov    $0x1000,%ebx
 787:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 78a:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 791:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 794:	eb 1b                	jmp    7b1 <malloc+0x61>
 796:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 79d:	00 
 79e:	66 90                	xchg   %ax,%ax
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a0:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 7a2:	8b 4a 04             	mov    0x4(%edx),%ecx
 7a5:	39 f1                	cmp    %esi,%ecx
 7a7:	73 4f                	jae    7f8 <malloc+0xa8>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7a9:	8b 3d c8 0b 00 00    	mov    0xbc8,%edi
 7af:	89 d0                	mov    %edx,%eax
 7b1:	39 c7                	cmp    %eax,%edi
 7b3:	75 eb                	jne    7a0 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 7b5:	83 ec 0c             	sub    $0xc,%esp
 7b8:	ff 75 e4             	push   -0x1c(%ebp)
 7bb:	e8 2b fc ff ff       	call   3eb <sbrk>
  if(p == (char*)-1)
 7c0:	83 c4 10             	add    $0x10,%esp
 7c3:	83 f8 ff             	cmp    $0xffffffff,%eax
 7c6:	74 1b                	je     7e3 <malloc+0x93>
  hp->s.size = nu;
 7c8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7cb:	83 ec 0c             	sub    $0xc,%esp
 7ce:	83 c0 08             	add    $0x8,%eax
 7d1:	50                   	push   %eax
 7d2:	e8 e9 fe ff ff       	call   6c0 <free>
  return freep;
 7d7:	a1 c8 0b 00 00       	mov    0xbc8,%eax
      if((p = morecore(nunits)) == 0)
 7dc:	83 c4 10             	add    $0x10,%esp
 7df:	85 c0                	test   %eax,%eax
 7e1:	75 bd                	jne    7a0 <malloc+0x50>
        return 0;
  }
}
 7e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 7e6:	31 c0                	xor    %eax,%eax
}
 7e8:	5b                   	pop    %ebx
 7e9:	5e                   	pop    %esi
 7ea:	5f                   	pop    %edi
 7eb:	5d                   	pop    %ebp
 7ec:	c3                   	ret
    if(p->s.size >= nunits){
 7ed:	89 c2                	mov    %eax,%edx
 7ef:	89 f8                	mov    %edi,%eax
 7f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 7f8:	39 ce                	cmp    %ecx,%esi
 7fa:	74 54                	je     850 <malloc+0x100>
        p->s.size -= nunits;
 7fc:	29 f1                	sub    %esi,%ecx
 7fe:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 801:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 804:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 807:	a3 c8 0b 00 00       	mov    %eax,0xbc8
}
 80c:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 80f:	8d 42 08             	lea    0x8(%edx),%eax
}
 812:	5b                   	pop    %ebx
 813:	5e                   	pop    %esi
 814:	5f                   	pop    %edi
 815:	5d                   	pop    %ebp
 816:	c3                   	ret
 817:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 81e:	00 
 81f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 820:	c7 05 c8 0b 00 00 cc 	movl   $0xbcc,0xbc8
 827:	0b 00 00 
    base.s.size = 0;
 82a:	bf cc 0b 00 00       	mov    $0xbcc,%edi
    base.s.ptr = freep = prevp = &base;
 82f:	c7 05 cc 0b 00 00 cc 	movl   $0xbcc,0xbcc
 836:	0b 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 839:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 83b:	c7 05 d0 0b 00 00 00 	movl   $0x0,0xbd0
 842:	00 00 00 
    if(p->s.size >= nunits){
 845:	e9 32 ff ff ff       	jmp    77c <malloc+0x2c>
 84a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 850:	8b 0a                	mov    (%edx),%ecx
 852:	89 08                	mov    %ecx,(%eax)
 854:	eb b1                	jmp    807 <malloc+0xb7>
