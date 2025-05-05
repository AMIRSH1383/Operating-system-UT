
_decode:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
        sentence[i] = temp;
        }
        printf(fd, "%s ", sentence);
    }

int main(int argc, char* argv[]) {
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 24             	sub    $0x24,%esp
  14:	8b 31                	mov    (%ecx),%esi
  16:	8b 79 04             	mov    0x4(%ecx),%edi

    int key = (51+ 20 + 65) % 26 ; 
    unlink("result.txt");
  19:	68 9c 08 00 00       	push   $0x89c
  1e:	e8 d0 03 00 00       	call   3f3 <unlink>
    int fd = open("result.txt", O_CREATE | O_WRONLY);
  23:	5a                   	pop    %edx
  24:	59                   	pop    %ecx
  25:	68 01 02 00 00       	push   $0x201
  2a:	68 9c 08 00 00       	push   $0x89c
  2f:	e8 af 03 00 00       	call   3e3 <open>
    if (fd < 0) {
  34:	83 c4 10             	add    $0x10,%esp
  37:	85 c0                	test   %eax,%eax
  39:	78 4c                	js     87 <main+0x87>
  3b:	89 c3                	mov    %eax,%ebx
        printf(1, "result: cannot create result.txt\n");
        exit();
    }
    for (int i = 0 ; i <argc - 1 ; i++){
  3d:	8d 46 ff             	lea    -0x1(%esi),%eax
  40:	31 f6                	xor    %esi,%esi
  42:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  45:	85 c0                	test   %eax,%eax
  47:	7e 21                	jle    6a <main+0x6a>
  49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        writeDecode(fd, key, argv[i+1]);
  50:	83 ec 04             	sub    $0x4,%esp
  53:	ff 74 b7 04          	push   0x4(%edi,%esi,4)
    for (int i = 0 ; i <argc - 1 ; i++){
  57:	83 c6 01             	add    $0x1,%esi
        writeDecode(fd, key, argv[i+1]);
  5a:	6a 06                	push   $0x6
  5c:	53                   	push   %ebx
  5d:	e8 3e 00 00 00       	call   a0 <writeDecode>
    for (int i = 0 ; i <argc - 1 ; i++){
  62:	83 c4 10             	add    $0x10,%esp
  65:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
  68:	75 e6                	jne    50 <main+0x50>
    }
    write(fd, "\n", 1);
  6a:	83 ec 04             	sub    $0x4,%esp
  6d:	6a 01                	push   $0x1
  6f:	68 a7 08 00 00       	push   $0x8a7
  74:	53                   	push   %ebx
  75:	e8 49 03 00 00       	call   3c3 <write>
    close(fd);
  7a:	89 1c 24             	mov    %ebx,(%esp)
  7d:	e8 49 03 00 00       	call   3cb <close>

    exit();
  82:	e8 1c 03 00 00       	call   3a3 <exit>
        printf(1, "result: cannot create result.txt\n");
  87:	50                   	push   %eax
  88:	50                   	push   %eax
  89:	68 b0 08 00 00       	push   $0x8b0
  8e:	6a 01                	push   $0x1
  90:	e8 9b 04 00 00       	call   530 <printf>
        exit();
  95:	e8 09 03 00 00       	call   3a3 <exit>
  9a:	66 90                	xchg   %ax,%ax
  9c:	66 90                	xchg   %ax,%ax
  9e:	66 90                	xchg   %ax,%ax

000000a0 <writeDecode>:
void writeDecode(int fd, int key, char* sentence) {
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	57                   	push   %edi
  a4:	56                   	push   %esi
  a5:	53                   	push   %ebx
  a6:	83 ec 1c             	sub    $0x1c,%esp
  a9:	8b 5d 10             	mov    0x10(%ebp),%ebx
  ac:	8b 45 08             	mov    0x8(%ebp),%eax
  af:	8b 75 0c             	mov    0xc(%ebp),%esi
    for (int i = 0;sentence[i] != '\0' ; i++) {
  b2:	0f b6 0b             	movzbl (%ebx),%ecx
void writeDecode(int fd, int key, char* sentence) {
  b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  b8:	89 5d e0             	mov    %ebx,-0x20(%ebp)
    for (int i = 0;sentence[i] != '\0' ; i++) {
  bb:	84 c9                	test   %cl,%cl
  bd:	74 79                	je     138 <writeDecode+0x98>
                    temp = (temp - 'A' - key ) % 26 + 'A';
  bf:	bf 4f ec c4 4e       	mov    $0x4ec4ec4f,%edi
  c4:	eb 37                	jmp    fd <writeDecode+0x5d>
  c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  cd:	00 
  ce:	66 90                	xchg   %ax,%ax
            if ((temp - 'a' - key ) < 0  )
  d0:	0f be c8             	movsbl %al,%ecx
  d3:	29 f1                	sub    %esi,%ecx
  d5:	79 03                	jns    da <writeDecode+0x3a>
                temp = (temp - 'a' - key + 26 )%26 +'a';
  d7:	83 c1 1a             	add    $0x1a,%ecx
                temp = (temp - 'a' - key ) % 26 + 'a';
  da:	89 c8                	mov    %ecx,%eax
  dc:	f7 ef                	imul   %edi
  de:	89 c8                	mov    %ecx,%eax
  e0:	c1 f8 1f             	sar    $0x1f,%eax
  e3:	c1 fa 03             	sar    $0x3,%edx
  e6:	29 c2                	sub    %eax,%edx
  e8:	6b d2 1a             	imul   $0x1a,%edx,%edx
  eb:	29 d1                	sub    %edx,%ecx
  ed:	83 c1 61             	add    $0x61,%ecx
        sentence[i] = temp;
  f0:	88 0b                	mov    %cl,(%ebx)
    for (int i = 0;sentence[i] != '\0' ; i++) {
  f2:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
  f6:	83 c3 01             	add    $0x1,%ebx
  f9:	84 c9                	test   %cl,%cl
  fb:	74 3b                	je     138 <writeDecode+0x98>
        if (temp >= 'a' && temp <= 'z'){
  fd:	8d 41 9f             	lea    -0x61(%ecx),%eax
 100:	3c 19                	cmp    $0x19,%al
 102:	76 cc                	jbe    d0 <writeDecode+0x30>
        else if (temp >= 'A' && temp <= 'Z'){
 104:	8d 41 bf             	lea    -0x41(%ecx),%eax
 107:	3c 19                	cmp    $0x19,%al
 109:	77 e5                	ja     f0 <writeDecode+0x50>
                if((temp - 'A' - key ) < 0)
 10b:	0f be c8             	movsbl %al,%ecx
 10e:	29 f1                	sub    %esi,%ecx
 110:	79 03                	jns    115 <writeDecode+0x75>
                    temp = (temp - 'A' - key + 26) % 26 + 'A';
 112:	83 c1 1a             	add    $0x1a,%ecx
                    temp = (temp - 'A' - key ) % 26 + 'A';
 115:	89 c8                	mov    %ecx,%eax
 117:	83 c3 01             	add    $0x1,%ebx
 11a:	f7 ef                	imul   %edi
 11c:	89 c8                	mov    %ecx,%eax
 11e:	c1 f8 1f             	sar    $0x1f,%eax
 121:	c1 fa 03             	sar    $0x3,%edx
 124:	29 c2                	sub    %eax,%edx
 126:	6b d2 1a             	imul   $0x1a,%edx,%edx
 129:	29 d1                	sub    %edx,%ecx
 12b:	83 c1 41             	add    $0x41,%ecx
        sentence[i] = temp;
 12e:	88 4b ff             	mov    %cl,-0x1(%ebx)
    for (int i = 0;sentence[i] != '\0' ; i++) {
 131:	0f b6 0b             	movzbl (%ebx),%ecx
 134:	84 c9                	test   %cl,%cl
 136:	75 c5                	jne    fd <writeDecode+0x5d>
        printf(fd, "%s ", sentence);
 138:	8b 45 e0             	mov    -0x20(%ebp),%eax
 13b:	c7 45 0c 98 08 00 00 	movl   $0x898,0xc(%ebp)
 142:	89 45 10             	mov    %eax,0x10(%ebp)
 145:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 148:	89 45 08             	mov    %eax,0x8(%ebp)
    }
 14b:	83 c4 1c             	add    $0x1c,%esp
 14e:	5b                   	pop    %ebx
 14f:	5e                   	pop    %esi
 150:	5f                   	pop    %edi
 151:	5d                   	pop    %ebp
        printf(fd, "%s ", sentence);
 152:	e9 d9 03 00 00       	jmp    530 <printf>
 157:	66 90                	xchg   %ax,%ax
 159:	66 90                	xchg   %ax,%ax
 15b:	66 90                	xchg   %ax,%ax
 15d:	66 90                	xchg   %ax,%ax
 15f:	90                   	nop

00000160 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 160:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 161:	31 c0                	xor    %eax,%eax
{
 163:	89 e5                	mov    %esp,%ebp
 165:	53                   	push   %ebx
 166:	8b 4d 08             	mov    0x8(%ebp),%ecx
 169:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 16c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 170:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 174:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 177:	83 c0 01             	add    $0x1,%eax
 17a:	84 d2                	test   %dl,%dl
 17c:	75 f2                	jne    170 <strcpy+0x10>
    ;
  return os;
}
 17e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 181:	89 c8                	mov    %ecx,%eax
 183:	c9                   	leave
 184:	c3                   	ret
 185:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 18c:	00 
 18d:	8d 76 00             	lea    0x0(%esi),%esi

00000190 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	53                   	push   %ebx
 194:	8b 4d 08             	mov    0x8(%ebp),%ecx
 197:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 19a:	0f b6 01             	movzbl (%ecx),%eax
 19d:	0f b6 1a             	movzbl (%edx),%ebx
 1a0:	84 c0                	test   %al,%al
 1a2:	75 1c                	jne    1c0 <strcmp+0x30>
 1a4:	eb 2e                	jmp    1d4 <strcmp+0x44>
 1a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1ad:	00 
 1ae:	66 90                	xchg   %ax,%ax
 1b0:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 1b4:	83 c1 01             	add    $0x1,%ecx
 1b7:	8d 5a 01             	lea    0x1(%edx),%ebx
  while(*p && *p == *q)
 1ba:	84 c0                	test   %al,%al
 1bc:	74 12                	je     1d0 <strcmp+0x40>
    p++, q++;
 1be:	89 da                	mov    %ebx,%edx
  while(*p && *p == *q)
 1c0:	0f b6 1a             	movzbl (%edx),%ebx
 1c3:	38 c3                	cmp    %al,%bl
 1c5:	74 e9                	je     1b0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 1c7:	29 d8                	sub    %ebx,%eax
}
 1c9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1cc:	c9                   	leave
 1cd:	c3                   	ret
 1ce:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 1d0:	0f b6 5a 01          	movzbl 0x1(%edx),%ebx
 1d4:	31 c0                	xor    %eax,%eax
 1d6:	29 d8                	sub    %ebx,%eax
}
 1d8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1db:	c9                   	leave
 1dc:	c3                   	ret
 1dd:	8d 76 00             	lea    0x0(%esi),%esi

000001e0 <strlen>:

uint
strlen(const char *s)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 1e6:	80 3a 00             	cmpb   $0x0,(%edx)
 1e9:	74 15                	je     200 <strlen+0x20>
 1eb:	31 c0                	xor    %eax,%eax
 1ed:	8d 76 00             	lea    0x0(%esi),%esi
 1f0:	83 c0 01             	add    $0x1,%eax
 1f3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 1f7:	89 c1                	mov    %eax,%ecx
 1f9:	75 f5                	jne    1f0 <strlen+0x10>
    ;
  return n;
}
 1fb:	89 c8                	mov    %ecx,%eax
 1fd:	5d                   	pop    %ebp
 1fe:	c3                   	ret
 1ff:	90                   	nop
  for(n = 0; s[n]; n++)
 200:	31 c9                	xor    %ecx,%ecx
}
 202:	5d                   	pop    %ebp
 203:	89 c8                	mov    %ecx,%eax
 205:	c3                   	ret
 206:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 20d:	00 
 20e:	66 90                	xchg   %ax,%ax

00000210 <memset>:

void*
memset(void *dst, int c, uint n)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	57                   	push   %edi
 214:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 217:	8b 4d 10             	mov    0x10(%ebp),%ecx
 21a:	8b 45 0c             	mov    0xc(%ebp),%eax
 21d:	89 d7                	mov    %edx,%edi
 21f:	fc                   	cld
 220:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 222:	8b 7d fc             	mov    -0x4(%ebp),%edi
 225:	89 d0                	mov    %edx,%eax
 227:	c9                   	leave
 228:	c3                   	ret
 229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000230 <strchr>:

char*
strchr(const char *s, char c)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	8b 45 08             	mov    0x8(%ebp),%eax
 236:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 23a:	0f b6 10             	movzbl (%eax),%edx
 23d:	84 d2                	test   %dl,%dl
 23f:	75 12                	jne    253 <strchr+0x23>
 241:	eb 1d                	jmp    260 <strchr+0x30>
 243:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 248:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 24c:	83 c0 01             	add    $0x1,%eax
 24f:	84 d2                	test   %dl,%dl
 251:	74 0d                	je     260 <strchr+0x30>
    if(*s == c)
 253:	38 d1                	cmp    %dl,%cl
 255:	75 f1                	jne    248 <strchr+0x18>
      return (char*)s;
  return 0;
}
 257:	5d                   	pop    %ebp
 258:	c3                   	ret
 259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 260:	31 c0                	xor    %eax,%eax
}
 262:	5d                   	pop    %ebp
 263:	c3                   	ret
 264:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 26b:	00 
 26c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000270 <gets>:

char*
gets(char *buf, int max)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	57                   	push   %edi
 274:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 275:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 278:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 279:	31 db                	xor    %ebx,%ebx
{
 27b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 27e:	eb 27                	jmp    2a7 <gets+0x37>
    cc = read(0, &c, 1);
 280:	83 ec 04             	sub    $0x4,%esp
 283:	6a 01                	push   $0x1
 285:	57                   	push   %edi
 286:	6a 00                	push   $0x0
 288:	e8 2e 01 00 00       	call   3bb <read>
    if(cc < 1)
 28d:	83 c4 10             	add    $0x10,%esp
 290:	85 c0                	test   %eax,%eax
 292:	7e 1d                	jle    2b1 <gets+0x41>
      break;
    buf[i++] = c;
 294:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 298:	8b 55 08             	mov    0x8(%ebp),%edx
 29b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 29f:	3c 0a                	cmp    $0xa,%al
 2a1:	74 1d                	je     2c0 <gets+0x50>
 2a3:	3c 0d                	cmp    $0xd,%al
 2a5:	74 19                	je     2c0 <gets+0x50>
  for(i=0; i+1 < max; ){
 2a7:	89 de                	mov    %ebx,%esi
 2a9:	83 c3 01             	add    $0x1,%ebx
 2ac:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2af:	7c cf                	jl     280 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 2b1:	8b 45 08             	mov    0x8(%ebp),%eax
 2b4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 2b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2bb:	5b                   	pop    %ebx
 2bc:	5e                   	pop    %esi
 2bd:	5f                   	pop    %edi
 2be:	5d                   	pop    %ebp
 2bf:	c3                   	ret
  buf[i] = '\0';
 2c0:	8b 45 08             	mov    0x8(%ebp),%eax
 2c3:	89 de                	mov    %ebx,%esi
 2c5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 2c9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2cc:	5b                   	pop    %ebx
 2cd:	5e                   	pop    %esi
 2ce:	5f                   	pop    %edi
 2cf:	5d                   	pop    %ebp
 2d0:	c3                   	ret
 2d1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2d8:	00 
 2d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002e0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	56                   	push   %esi
 2e4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2e5:	83 ec 08             	sub    $0x8,%esp
 2e8:	6a 00                	push   $0x0
 2ea:	ff 75 08             	push   0x8(%ebp)
 2ed:	e8 f1 00 00 00       	call   3e3 <open>
  if(fd < 0)
 2f2:	83 c4 10             	add    $0x10,%esp
 2f5:	85 c0                	test   %eax,%eax
 2f7:	78 27                	js     320 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 2f9:	83 ec 08             	sub    $0x8,%esp
 2fc:	ff 75 0c             	push   0xc(%ebp)
 2ff:	89 c3                	mov    %eax,%ebx
 301:	50                   	push   %eax
 302:	e8 f4 00 00 00       	call   3fb <fstat>
  close(fd);
 307:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 30a:	89 c6                	mov    %eax,%esi
  close(fd);
 30c:	e8 ba 00 00 00       	call   3cb <close>
  return r;
 311:	83 c4 10             	add    $0x10,%esp
}
 314:	8d 65 f8             	lea    -0x8(%ebp),%esp
 317:	89 f0                	mov    %esi,%eax
 319:	5b                   	pop    %ebx
 31a:	5e                   	pop    %esi
 31b:	5d                   	pop    %ebp
 31c:	c3                   	ret
 31d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 320:	be ff ff ff ff       	mov    $0xffffffff,%esi
 325:	eb ed                	jmp    314 <stat+0x34>
 327:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 32e:	00 
 32f:	90                   	nop

00000330 <atoi>:

int
atoi(const char *s)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	53                   	push   %ebx
 334:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 337:	0f be 02             	movsbl (%edx),%eax
 33a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 33d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 340:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 345:	77 1e                	ja     365 <atoi+0x35>
 347:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 34e:	00 
 34f:	90                   	nop
    n = n*10 + *s++ - '0';
 350:	83 c2 01             	add    $0x1,%edx
 353:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 356:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 35a:	0f be 02             	movsbl (%edx),%eax
 35d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 360:	80 fb 09             	cmp    $0x9,%bl
 363:	76 eb                	jbe    350 <atoi+0x20>
  return n;
}
 365:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 368:	89 c8                	mov    %ecx,%eax
 36a:	c9                   	leave
 36b:	c3                   	ret
 36c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000370 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	57                   	push   %edi
 374:	8b 45 10             	mov    0x10(%ebp),%eax
 377:	8b 55 08             	mov    0x8(%ebp),%edx
 37a:	56                   	push   %esi
 37b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 37e:	85 c0                	test   %eax,%eax
 380:	7e 13                	jle    395 <memmove+0x25>
 382:	01 d0                	add    %edx,%eax
  dst = vdst;
 384:	89 d7                	mov    %edx,%edi
 386:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 38d:	00 
 38e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 390:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 391:	39 f8                	cmp    %edi,%eax
 393:	75 fb                	jne    390 <memmove+0x20>
  return vdst;
}
 395:	5e                   	pop    %esi
 396:	89 d0                	mov    %edx,%eax
 398:	5f                   	pop    %edi
 399:	5d                   	pop    %ebp
 39a:	c3                   	ret

0000039b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 39b:	b8 01 00 00 00       	mov    $0x1,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret

000003a3 <exit>:
SYSCALL(exit)
 3a3:	b8 02 00 00 00       	mov    $0x2,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret

000003ab <wait>:
SYSCALL(wait)
 3ab:	b8 03 00 00 00       	mov    $0x3,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret

000003b3 <pipe>:
SYSCALL(pipe)
 3b3:	b8 04 00 00 00       	mov    $0x4,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret

000003bb <read>:
SYSCALL(read)
 3bb:	b8 05 00 00 00       	mov    $0x5,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret

000003c3 <write>:
SYSCALL(write)
 3c3:	b8 10 00 00 00       	mov    $0x10,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret

000003cb <close>:
SYSCALL(close)
 3cb:	b8 15 00 00 00       	mov    $0x15,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret

000003d3 <kill>:
SYSCALL(kill)
 3d3:	b8 06 00 00 00       	mov    $0x6,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret

000003db <exec>:
SYSCALL(exec)
 3db:	b8 07 00 00 00       	mov    $0x7,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret

000003e3 <open>:
SYSCALL(open)
 3e3:	b8 0f 00 00 00       	mov    $0xf,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret

000003eb <mknod>:
SYSCALL(mknod)
 3eb:	b8 11 00 00 00       	mov    $0x11,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret

000003f3 <unlink>:
SYSCALL(unlink)
 3f3:	b8 12 00 00 00       	mov    $0x12,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret

000003fb <fstat>:
SYSCALL(fstat)
 3fb:	b8 08 00 00 00       	mov    $0x8,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret

00000403 <link>:
SYSCALL(link)
 403:	b8 13 00 00 00       	mov    $0x13,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret

0000040b <mkdir>:
SYSCALL(mkdir)
 40b:	b8 14 00 00 00       	mov    $0x14,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret

00000413 <chdir>:
SYSCALL(chdir)
 413:	b8 09 00 00 00       	mov    $0x9,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret

0000041b <dup>:
SYSCALL(dup)
 41b:	b8 0a 00 00 00       	mov    $0xa,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret

00000423 <getpid>:
SYSCALL(getpid)
 423:	b8 0b 00 00 00       	mov    $0xb,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret

0000042b <sbrk>:
SYSCALL(sbrk)
 42b:	b8 0c 00 00 00       	mov    $0xc,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret

00000433 <sleep>:
SYSCALL(sleep)
 433:	b8 0d 00 00 00       	mov    $0xd,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret

0000043b <uptime>:
SYSCALL(uptime)
 43b:	b8 0e 00 00 00       	mov    $0xe,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret

00000443 <create_palindrome>:
SYSCALL(create_palindrome)
 443:	b8 16 00 00 00       	mov    $0x16,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret

0000044b <sort_syscalls>:
SYSCALL(sort_syscalls)
 44b:	b8 17 00 00 00       	mov    $0x17,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret

00000453 <get_most_invoked_syscall>:
SYSCALL(get_most_invoked_syscall)
 453:	b8 18 00 00 00       	mov    $0x18,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret

0000045b <list_all_processes>:
SYSCALL(list_all_processes)
 45b:	b8 19 00 00 00       	mov    $0x19,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret

00000463 <move_file>:
SYSCALL(move_file)
 463:	b8 1a 00 00 00       	mov    $0x1a,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret

0000046b <open_sharedmem>:
SYSCALL(open_sharedmem)
 46b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret

00000473 <close_sharedmem>:
 473:	b8 1c 00 00 00       	mov    $0x1c,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret
 47b:	66 90                	xchg   %ax,%ax
 47d:	66 90                	xchg   %ax,%ax
 47f:	90                   	nop

00000480 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	57                   	push   %edi
 484:	56                   	push   %esi
 485:	53                   	push   %ebx
 486:	83 ec 3c             	sub    $0x3c,%esp
 489:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 48c:	89 d1                	mov    %edx,%ecx
{
 48e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 491:	85 d2                	test   %edx,%edx
 493:	0f 89 7f 00 00 00    	jns    518 <printint+0x98>
 499:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 49d:	74 79                	je     518 <printint+0x98>
    neg = 1;
 49f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 4a6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 4a8:	31 db                	xor    %ebx,%ebx
 4aa:	8d 75 d7             	lea    -0x29(%ebp),%esi
 4ad:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 4b0:	89 c8                	mov    %ecx,%eax
 4b2:	31 d2                	xor    %edx,%edx
 4b4:	89 cf                	mov    %ecx,%edi
 4b6:	f7 75 c4             	divl   -0x3c(%ebp)
 4b9:	0f b6 92 d4 08 00 00 	movzbl 0x8d4(%edx),%edx
 4c0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 4c3:	89 d8                	mov    %ebx,%eax
 4c5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 4c8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 4cb:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 4ce:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 4d1:	76 dd                	jbe    4b0 <printint+0x30>
  if(neg)
 4d3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 4d6:	85 c9                	test   %ecx,%ecx
 4d8:	74 0c                	je     4e6 <printint+0x66>
    buf[i++] = '-';
 4da:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 4df:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 4e1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 4e6:	8b 7d b8             	mov    -0x48(%ebp),%edi
 4e9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 4ed:	eb 07                	jmp    4f6 <printint+0x76>
 4ef:	90                   	nop
    putc(fd, buf[i]);
 4f0:	0f b6 13             	movzbl (%ebx),%edx
 4f3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 4f6:	83 ec 04             	sub    $0x4,%esp
 4f9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 4fc:	6a 01                	push   $0x1
 4fe:	56                   	push   %esi
 4ff:	57                   	push   %edi
 500:	e8 be fe ff ff       	call   3c3 <write>
  while(--i >= 0)
 505:	83 c4 10             	add    $0x10,%esp
 508:	39 de                	cmp    %ebx,%esi
 50a:	75 e4                	jne    4f0 <printint+0x70>
}
 50c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 50f:	5b                   	pop    %ebx
 510:	5e                   	pop    %esi
 511:	5f                   	pop    %edi
 512:	5d                   	pop    %ebp
 513:	c3                   	ret
 514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 518:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 51f:	eb 87                	jmp    4a8 <printint+0x28>
 521:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 528:	00 
 529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000530 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	57                   	push   %edi
 534:	56                   	push   %esi
 535:	53                   	push   %ebx
 536:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 539:	8b 75 0c             	mov    0xc(%ebp),%esi
 53c:	0f b6 1e             	movzbl (%esi),%ebx
 53f:	84 db                	test   %bl,%bl
 541:	0f 84 b8 00 00 00    	je     5ff <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 547:	8d 45 10             	lea    0x10(%ebp),%eax
 54a:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 54d:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 550:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 552:	89 45 d0             	mov    %eax,-0x30(%ebp)
 555:	eb 37                	jmp    58e <printf+0x5e>
 557:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 55e:	00 
 55f:	90                   	nop
 560:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 563:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 568:	83 f8 25             	cmp    $0x25,%eax
 56b:	74 17                	je     584 <printf+0x54>
  write(fd, &c, 1);
 56d:	83 ec 04             	sub    $0x4,%esp
 570:	88 5d e7             	mov    %bl,-0x19(%ebp)
 573:	6a 01                	push   $0x1
 575:	57                   	push   %edi
 576:	ff 75 08             	push   0x8(%ebp)
 579:	e8 45 fe ff ff       	call   3c3 <write>
 57e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 581:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 584:	0f b6 1e             	movzbl (%esi),%ebx
 587:	83 c6 01             	add    $0x1,%esi
 58a:	84 db                	test   %bl,%bl
 58c:	74 71                	je     5ff <printf+0xcf>
    c = fmt[i] & 0xff;
 58e:	0f be cb             	movsbl %bl,%ecx
 591:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 594:	85 d2                	test   %edx,%edx
 596:	74 c8                	je     560 <printf+0x30>
      }
    } else if(state == '%'){
 598:	83 fa 25             	cmp    $0x25,%edx
 59b:	75 e7                	jne    584 <printf+0x54>
      if(c == 'd'){
 59d:	83 f8 64             	cmp    $0x64,%eax
 5a0:	0f 84 9a 00 00 00    	je     640 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5a6:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 5ac:	83 f9 70             	cmp    $0x70,%ecx
 5af:	74 5f                	je     610 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5b1:	83 f8 73             	cmp    $0x73,%eax
 5b4:	0f 84 d6 00 00 00    	je     690 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5ba:	83 f8 63             	cmp    $0x63,%eax
 5bd:	0f 84 8d 00 00 00    	je     650 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5c3:	83 f8 25             	cmp    $0x25,%eax
 5c6:	0f 84 b4 00 00 00    	je     680 <printf+0x150>
  write(fd, &c, 1);
 5cc:	83 ec 04             	sub    $0x4,%esp
 5cf:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5d3:	6a 01                	push   $0x1
 5d5:	57                   	push   %edi
 5d6:	ff 75 08             	push   0x8(%ebp)
 5d9:	e8 e5 fd ff ff       	call   3c3 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 5de:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 5e1:	83 c4 0c             	add    $0xc,%esp
 5e4:	6a 01                	push   $0x1
  for(i = 0; fmt[i]; i++){
 5e6:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 5e9:	57                   	push   %edi
 5ea:	ff 75 08             	push   0x8(%ebp)
 5ed:	e8 d1 fd ff ff       	call   3c3 <write>
  for(i = 0; fmt[i]; i++){
 5f2:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 5f6:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5f9:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 5fb:	84 db                	test   %bl,%bl
 5fd:	75 8f                	jne    58e <printf+0x5e>
    }
  }
}
 5ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
 602:	5b                   	pop    %ebx
 603:	5e                   	pop    %esi
 604:	5f                   	pop    %edi
 605:	5d                   	pop    %ebp
 606:	c3                   	ret
 607:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 60e:	00 
 60f:	90                   	nop
        printint(fd, *ap, 16, 0);
 610:	83 ec 0c             	sub    $0xc,%esp
 613:	b9 10 00 00 00       	mov    $0x10,%ecx
 618:	6a 00                	push   $0x0
 61a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 61d:	8b 45 08             	mov    0x8(%ebp),%eax
 620:	8b 13                	mov    (%ebx),%edx
 622:	e8 59 fe ff ff       	call   480 <printint>
        ap++;
 627:	89 d8                	mov    %ebx,%eax
 629:	83 c4 10             	add    $0x10,%esp
      state = 0;
 62c:	31 d2                	xor    %edx,%edx
        ap++;
 62e:	83 c0 04             	add    $0x4,%eax
 631:	89 45 d0             	mov    %eax,-0x30(%ebp)
 634:	e9 4b ff ff ff       	jmp    584 <printf+0x54>
 639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 640:	83 ec 0c             	sub    $0xc,%esp
 643:	b9 0a 00 00 00       	mov    $0xa,%ecx
 648:	6a 01                	push   $0x1
 64a:	eb ce                	jmp    61a <printf+0xea>
 64c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 650:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 653:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 656:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 658:	6a 01                	push   $0x1
        ap++;
 65a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 65d:	57                   	push   %edi
 65e:	ff 75 08             	push   0x8(%ebp)
        putc(fd, *ap);
 661:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 664:	e8 5a fd ff ff       	call   3c3 <write>
        ap++;
 669:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 66c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 66f:	31 d2                	xor    %edx,%edx
 671:	e9 0e ff ff ff       	jmp    584 <printf+0x54>
 676:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 67d:	00 
 67e:	66 90                	xchg   %ax,%ax
        putc(fd, c);
 680:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 683:	83 ec 04             	sub    $0x4,%esp
 686:	e9 59 ff ff ff       	jmp    5e4 <printf+0xb4>
 68b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 690:	8b 45 d0             	mov    -0x30(%ebp),%eax
 693:	8b 18                	mov    (%eax),%ebx
        ap++;
 695:	83 c0 04             	add    $0x4,%eax
 698:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 69b:	85 db                	test   %ebx,%ebx
 69d:	74 17                	je     6b6 <printf+0x186>
        while(*s != 0){
 69f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 6a2:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 6a4:	84 c0                	test   %al,%al
 6a6:	0f 84 d8 fe ff ff    	je     584 <printf+0x54>
 6ac:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 6af:	89 de                	mov    %ebx,%esi
 6b1:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6b4:	eb 1a                	jmp    6d0 <printf+0x1a0>
          s = "(null)";
 6b6:	bb a9 08 00 00       	mov    $0x8a9,%ebx
        while(*s != 0){
 6bb:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 6be:	b8 28 00 00 00       	mov    $0x28,%eax
 6c3:	89 de                	mov    %ebx,%esi
 6c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6cf:	00 
  write(fd, &c, 1);
 6d0:	83 ec 04             	sub    $0x4,%esp
          s++;
 6d3:	83 c6 01             	add    $0x1,%esi
 6d6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6d9:	6a 01                	push   $0x1
 6db:	57                   	push   %edi
 6dc:	53                   	push   %ebx
 6dd:	e8 e1 fc ff ff       	call   3c3 <write>
        while(*s != 0){
 6e2:	0f b6 06             	movzbl (%esi),%eax
 6e5:	83 c4 10             	add    $0x10,%esp
 6e8:	84 c0                	test   %al,%al
 6ea:	75 e4                	jne    6d0 <printf+0x1a0>
      state = 0;
 6ec:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 6ef:	31 d2                	xor    %edx,%edx
 6f1:	e9 8e fe ff ff       	jmp    584 <printf+0x54>
 6f6:	66 90                	xchg   %ax,%ax
 6f8:	66 90                	xchg   %ax,%ax
 6fa:	66 90                	xchg   %ax,%ax
 6fc:	66 90                	xchg   %ax,%ax
 6fe:	66 90                	xchg   %ax,%ax

00000700 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 700:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 701:	a1 b0 0b 00 00       	mov    0xbb0,%eax
{
 706:	89 e5                	mov    %esp,%ebp
 708:	57                   	push   %edi
 709:	56                   	push   %esi
 70a:	53                   	push   %ebx
 70b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 70e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 711:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 718:	89 c2                	mov    %eax,%edx
 71a:	8b 00                	mov    (%eax),%eax
 71c:	39 ca                	cmp    %ecx,%edx
 71e:	73 30                	jae    750 <free+0x50>
 720:	39 c1                	cmp    %eax,%ecx
 722:	72 04                	jb     728 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 724:	39 c2                	cmp    %eax,%edx
 726:	72 f0                	jb     718 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 728:	8b 73 fc             	mov    -0x4(%ebx),%esi
 72b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 72e:	39 f8                	cmp    %edi,%eax
 730:	74 30                	je     762 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 732:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 735:	8b 42 04             	mov    0x4(%edx),%eax
 738:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 73b:	39 f1                	cmp    %esi,%ecx
 73d:	74 3a                	je     779 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 73f:	89 0a                	mov    %ecx,(%edx)
  freep = p;
}
 741:	5b                   	pop    %ebx
  freep = p;
 742:	89 15 b0 0b 00 00    	mov    %edx,0xbb0
}
 748:	5e                   	pop    %esi
 749:	5f                   	pop    %edi
 74a:	5d                   	pop    %ebp
 74b:	c3                   	ret
 74c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 750:	39 c2                	cmp    %eax,%edx
 752:	72 c4                	jb     718 <free+0x18>
 754:	39 c1                	cmp    %eax,%ecx
 756:	73 c0                	jae    718 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 758:	8b 73 fc             	mov    -0x4(%ebx),%esi
 75b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 75e:	39 f8                	cmp    %edi,%eax
 760:	75 d0                	jne    732 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 762:	03 70 04             	add    0x4(%eax),%esi
 765:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 768:	8b 02                	mov    (%edx),%eax
 76a:	8b 00                	mov    (%eax),%eax
 76c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 76f:	8b 42 04             	mov    0x4(%edx),%eax
 772:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 775:	39 f1                	cmp    %esi,%ecx
 777:	75 c6                	jne    73f <free+0x3f>
    p->s.size += bp->s.size;
 779:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 77c:	89 15 b0 0b 00 00    	mov    %edx,0xbb0
    p->s.size += bp->s.size;
 782:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 785:	8b 43 f8             	mov    -0x8(%ebx),%eax
 788:	89 02                	mov    %eax,(%edx)
}
 78a:	5b                   	pop    %ebx
 78b:	5e                   	pop    %esi
 78c:	5f                   	pop    %edi
 78d:	5d                   	pop    %ebp
 78e:	c3                   	ret
 78f:	90                   	nop

00000790 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 790:	55                   	push   %ebp
 791:	89 e5                	mov    %esp,%ebp
 793:	57                   	push   %edi
 794:	56                   	push   %esi
 795:	53                   	push   %ebx
 796:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 799:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 79c:	8b 3d b0 0b 00 00    	mov    0xbb0,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7a2:	8d 70 07             	lea    0x7(%eax),%esi
 7a5:	c1 ee 03             	shr    $0x3,%esi
 7a8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 7ab:	85 ff                	test   %edi,%edi
 7ad:	0f 84 ad 00 00 00    	je     860 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7b3:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 7b5:	8b 48 04             	mov    0x4(%eax),%ecx
 7b8:	39 f1                	cmp    %esi,%ecx
 7ba:	73 71                	jae    82d <malloc+0x9d>
 7bc:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 7c2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7c7:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 7ca:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 7d1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 7d4:	eb 1b                	jmp    7f1 <malloc+0x61>
 7d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7dd:	00 
 7de:	66 90                	xchg   %ax,%ax
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e0:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 7e2:	8b 4a 04             	mov    0x4(%edx),%ecx
 7e5:	39 f1                	cmp    %esi,%ecx
 7e7:	73 4f                	jae    838 <malloc+0xa8>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7e9:	8b 3d b0 0b 00 00    	mov    0xbb0,%edi
 7ef:	89 d0                	mov    %edx,%eax
 7f1:	39 c7                	cmp    %eax,%edi
 7f3:	75 eb                	jne    7e0 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 7f5:	83 ec 0c             	sub    $0xc,%esp
 7f8:	ff 75 e4             	push   -0x1c(%ebp)
 7fb:	e8 2b fc ff ff       	call   42b <sbrk>
  if(p == (char*)-1)
 800:	83 c4 10             	add    $0x10,%esp
 803:	83 f8 ff             	cmp    $0xffffffff,%eax
 806:	74 1b                	je     823 <malloc+0x93>
  hp->s.size = nu;
 808:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 80b:	83 ec 0c             	sub    $0xc,%esp
 80e:	83 c0 08             	add    $0x8,%eax
 811:	50                   	push   %eax
 812:	e8 e9 fe ff ff       	call   700 <free>
  return freep;
 817:	a1 b0 0b 00 00       	mov    0xbb0,%eax
      if((p = morecore(nunits)) == 0)
 81c:	83 c4 10             	add    $0x10,%esp
 81f:	85 c0                	test   %eax,%eax
 821:	75 bd                	jne    7e0 <malloc+0x50>
        return 0;
  }
}
 823:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 826:	31 c0                	xor    %eax,%eax
}
 828:	5b                   	pop    %ebx
 829:	5e                   	pop    %esi
 82a:	5f                   	pop    %edi
 82b:	5d                   	pop    %ebp
 82c:	c3                   	ret
    if(p->s.size >= nunits){
 82d:	89 c2                	mov    %eax,%edx
 82f:	89 f8                	mov    %edi,%eax
 831:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 838:	39 ce                	cmp    %ecx,%esi
 83a:	74 54                	je     890 <malloc+0x100>
        p->s.size -= nunits;
 83c:	29 f1                	sub    %esi,%ecx
 83e:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 841:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 844:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 847:	a3 b0 0b 00 00       	mov    %eax,0xbb0
}
 84c:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 84f:	8d 42 08             	lea    0x8(%edx),%eax
}
 852:	5b                   	pop    %ebx
 853:	5e                   	pop    %esi
 854:	5f                   	pop    %edi
 855:	5d                   	pop    %ebp
 856:	c3                   	ret
 857:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 85e:	00 
 85f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 860:	c7 05 b0 0b 00 00 b4 	movl   $0xbb4,0xbb0
 867:	0b 00 00 
    base.s.size = 0;
 86a:	bf b4 0b 00 00       	mov    $0xbb4,%edi
    base.s.ptr = freep = prevp = &base;
 86f:	c7 05 b4 0b 00 00 b4 	movl   $0xbb4,0xbb4
 876:	0b 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 879:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 87b:	c7 05 b8 0b 00 00 00 	movl   $0x0,0xbb8
 882:	00 00 00 
    if(p->s.size >= nunits){
 885:	e9 32 ff ff ff       	jmp    7bc <malloc+0x2c>
 88a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 890:	8b 0a                	mov    (%edx),%ecx
 892:	89 08                	mov    %ecx,(%eax)
 894:	eb b1                	jmp    847 <malloc+0xb7>
