
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
  19:	68 7c 08 00 00       	push   $0x87c
  1e:	e8 e0 03 00 00       	call   403 <unlink>
    int fd = open("result.txt", O_CREATE | O_WRONLY);
  23:	5a                   	pop    %edx
  24:	59                   	pop    %ecx
  25:	68 01 02 00 00       	push   $0x201
  2a:	68 7c 08 00 00       	push   $0x87c
  2f:	e8 bf 03 00 00       	call   3f3 <open>
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
  6f:	68 87 08 00 00       	push   $0x887
  74:	53                   	push   %ebx
  75:	e8 59 03 00 00       	call   3d3 <write>
    close(fd);
  7a:	89 1c 24             	mov    %ebx,(%esp)
  7d:	e8 59 03 00 00       	call   3db <close>

    exit();
  82:	e8 2c 03 00 00       	call   3b3 <exit>
        printf(1, "result: cannot create result.txt\n");
  87:	50                   	push   %eax
  88:	50                   	push   %eax
  89:	68 8c 08 00 00       	push   $0x88c
  8e:	6a 01                	push   $0x1
  90:	e8 bb 04 00 00       	call   550 <printf>
        exit();
  95:	e8 19 03 00 00       	call   3b3 <exit>
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
  bd:	74 7d                	je     13c <writeDecode+0x9c>
                    temp = (temp - 'A' - key ) % 26 + 'A';
  bf:	bf 4f ec c4 4e       	mov    $0x4ec4ec4f,%edi
  c4:	eb 39                	jmp    ff <writeDecode+0x5f>
  c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  cd:	8d 76 00             	lea    0x0(%esi),%esi
            if ((temp - 'a' - key ) < 0  )
  d0:	0f be c0             	movsbl %al,%eax
  d3:	29 f0                	sub    %esi,%eax
  d5:	89 c1                	mov    %eax,%ecx
  d7:	79 03                	jns    dc <writeDecode+0x3c>
                temp = (temp - 'a' - key + 26 )%26 +'a';
  d9:	83 c1 1a             	add    $0x1a,%ecx
                temp = (temp - 'a' - key ) % 26 + 'a';
  dc:	89 c8                	mov    %ecx,%eax
  de:	f7 ef                	imul   %edi
  e0:	89 c8                	mov    %ecx,%eax
  e2:	c1 f8 1f             	sar    $0x1f,%eax
  e5:	c1 fa 03             	sar    $0x3,%edx
  e8:	29 c2                	sub    %eax,%edx
  ea:	6b d2 1a             	imul   $0x1a,%edx,%edx
  ed:	29 d1                	sub    %edx,%ecx
  ef:	83 c1 61             	add    $0x61,%ecx
        sentence[i] = temp;
  f2:	88 0b                	mov    %cl,(%ebx)
    for (int i = 0;sentence[i] != '\0' ; i++) {
  f4:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
  f8:	83 c3 01             	add    $0x1,%ebx
  fb:	84 c9                	test   %cl,%cl
  fd:	74 3d                	je     13c <writeDecode+0x9c>
        if (temp >= 'a' && temp <= 'z'){
  ff:	8d 41 9f             	lea    -0x61(%ecx),%eax
 102:	3c 19                	cmp    $0x19,%al
 104:	76 ca                	jbe    d0 <writeDecode+0x30>
        else if (temp >= 'A' && temp <= 'Z'){
 106:	8d 41 bf             	lea    -0x41(%ecx),%eax
 109:	3c 19                	cmp    $0x19,%al
 10b:	77 e5                	ja     f2 <writeDecode+0x52>
                if((temp - 'A' - key ) < 0)
 10d:	0f be c0             	movsbl %al,%eax
 110:	29 f0                	sub    %esi,%eax
 112:	89 c1                	mov    %eax,%ecx
 114:	79 03                	jns    119 <writeDecode+0x79>
                    temp = (temp - 'A' - key + 26) % 26 + 'A';
 116:	83 c1 1a             	add    $0x1a,%ecx
                    temp = (temp - 'A' - key ) % 26 + 'A';
 119:	89 c8                	mov    %ecx,%eax
 11b:	83 c3 01             	add    $0x1,%ebx
 11e:	f7 ef                	imul   %edi
 120:	89 c8                	mov    %ecx,%eax
 122:	c1 f8 1f             	sar    $0x1f,%eax
 125:	c1 fa 03             	sar    $0x3,%edx
 128:	29 c2                	sub    %eax,%edx
 12a:	6b d2 1a             	imul   $0x1a,%edx,%edx
 12d:	29 d1                	sub    %edx,%ecx
 12f:	83 c1 41             	add    $0x41,%ecx
        sentence[i] = temp;
 132:	88 4b ff             	mov    %cl,-0x1(%ebx)
    for (int i = 0;sentence[i] != '\0' ; i++) {
 135:	0f b6 0b             	movzbl (%ebx),%ecx
 138:	84 c9                	test   %cl,%cl
 13a:	75 c3                	jne    ff <writeDecode+0x5f>
        printf(fd, "%s ", sentence);
 13c:	8b 45 e0             	mov    -0x20(%ebp),%eax
 13f:	c7 45 0c 78 08 00 00 	movl   $0x878,0xc(%ebp)
 146:	89 45 10             	mov    %eax,0x10(%ebp)
 149:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 14c:	89 45 08             	mov    %eax,0x8(%ebp)
    }
 14f:	83 c4 1c             	add    $0x1c,%esp
 152:	5b                   	pop    %ebx
 153:	5e                   	pop    %esi
 154:	5f                   	pop    %edi
 155:	5d                   	pop    %ebp
        printf(fd, "%s ", sentence);
 156:	e9 f5 03 00 00       	jmp    550 <printf>
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
 185:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000190 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	53                   	push   %ebx
 194:	8b 55 08             	mov    0x8(%ebp),%edx
 197:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 19a:	0f b6 02             	movzbl (%edx),%eax
 19d:	84 c0                	test   %al,%al
 19f:	75 17                	jne    1b8 <strcmp+0x28>
 1a1:	eb 3a                	jmp    1dd <strcmp+0x4d>
 1a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1a7:	90                   	nop
 1a8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 1ac:	83 c2 01             	add    $0x1,%edx
 1af:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 1b2:	84 c0                	test   %al,%al
 1b4:	74 1a                	je     1d0 <strcmp+0x40>
    p++, q++;
 1b6:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
 1b8:	0f b6 19             	movzbl (%ecx),%ebx
 1bb:	38 c3                	cmp    %al,%bl
 1bd:	74 e9                	je     1a8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 1bf:	29 d8                	sub    %ebx,%eax
}
 1c1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1c4:	c9                   	leave  
 1c5:	c3                   	ret    
 1c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1cd:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 1d0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 1d4:	31 c0                	xor    %eax,%eax
 1d6:	29 d8                	sub    %ebx,%eax
}
 1d8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1db:	c9                   	leave  
 1dc:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 1dd:	0f b6 19             	movzbl (%ecx),%ebx
 1e0:	31 c0                	xor    %eax,%eax
 1e2:	eb db                	jmp    1bf <strcmp+0x2f>
 1e4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1ef:	90                   	nop

000001f0 <strlen>:

uint
strlen(const char *s)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 1f6:	80 3a 00             	cmpb   $0x0,(%edx)
 1f9:	74 15                	je     210 <strlen+0x20>
 1fb:	31 c0                	xor    %eax,%eax
 1fd:	8d 76 00             	lea    0x0(%esi),%esi
 200:	83 c0 01             	add    $0x1,%eax
 203:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 207:	89 c1                	mov    %eax,%ecx
 209:	75 f5                	jne    200 <strlen+0x10>
    ;
  return n;
}
 20b:	89 c8                	mov    %ecx,%eax
 20d:	5d                   	pop    %ebp
 20e:	c3                   	ret    
 20f:	90                   	nop
  for(n = 0; s[n]; n++)
 210:	31 c9                	xor    %ecx,%ecx
}
 212:	5d                   	pop    %ebp
 213:	89 c8                	mov    %ecx,%eax
 215:	c3                   	ret    
 216:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 21d:	8d 76 00             	lea    0x0(%esi),%esi

00000220 <memset>:

void*
memset(void *dst, int c, uint n)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	57                   	push   %edi
 224:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 227:	8b 4d 10             	mov    0x10(%ebp),%ecx
 22a:	8b 45 0c             	mov    0xc(%ebp),%eax
 22d:	89 d7                	mov    %edx,%edi
 22f:	fc                   	cld    
 230:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 232:	8b 7d fc             	mov    -0x4(%ebp),%edi
 235:	89 d0                	mov    %edx,%eax
 237:	c9                   	leave  
 238:	c3                   	ret    
 239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000240 <strchr>:

char*
strchr(const char *s, char c)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	8b 45 08             	mov    0x8(%ebp),%eax
 246:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 24a:	0f b6 10             	movzbl (%eax),%edx
 24d:	84 d2                	test   %dl,%dl
 24f:	75 12                	jne    263 <strchr+0x23>
 251:	eb 1d                	jmp    270 <strchr+0x30>
 253:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 257:	90                   	nop
 258:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 25c:	83 c0 01             	add    $0x1,%eax
 25f:	84 d2                	test   %dl,%dl
 261:	74 0d                	je     270 <strchr+0x30>
    if(*s == c)
 263:	38 d1                	cmp    %dl,%cl
 265:	75 f1                	jne    258 <strchr+0x18>
      return (char*)s;
  return 0;
}
 267:	5d                   	pop    %ebp
 268:	c3                   	ret    
 269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 270:	31 c0                	xor    %eax,%eax
}
 272:	5d                   	pop    %ebp
 273:	c3                   	ret    
 274:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 27b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 27f:	90                   	nop

00000280 <gets>:

char*
gets(char *buf, int max)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	57                   	push   %edi
 284:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 285:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 288:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 289:	31 db                	xor    %ebx,%ebx
{
 28b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 28e:	eb 27                	jmp    2b7 <gets+0x37>
    cc = read(0, &c, 1);
 290:	83 ec 04             	sub    $0x4,%esp
 293:	6a 01                	push   $0x1
 295:	57                   	push   %edi
 296:	6a 00                	push   $0x0
 298:	e8 2e 01 00 00       	call   3cb <read>
    if(cc < 1)
 29d:	83 c4 10             	add    $0x10,%esp
 2a0:	85 c0                	test   %eax,%eax
 2a2:	7e 1d                	jle    2c1 <gets+0x41>
      break;
    buf[i++] = c;
 2a4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2a8:	8b 55 08             	mov    0x8(%ebp),%edx
 2ab:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 2af:	3c 0a                	cmp    $0xa,%al
 2b1:	74 1d                	je     2d0 <gets+0x50>
 2b3:	3c 0d                	cmp    $0xd,%al
 2b5:	74 19                	je     2d0 <gets+0x50>
  for(i=0; i+1 < max; ){
 2b7:	89 de                	mov    %ebx,%esi
 2b9:	83 c3 01             	add    $0x1,%ebx
 2bc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2bf:	7c cf                	jl     290 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 2c1:	8b 45 08             	mov    0x8(%ebp),%eax
 2c4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 2c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2cb:	5b                   	pop    %ebx
 2cc:	5e                   	pop    %esi
 2cd:	5f                   	pop    %edi
 2ce:	5d                   	pop    %ebp
 2cf:	c3                   	ret    
  buf[i] = '\0';
 2d0:	8b 45 08             	mov    0x8(%ebp),%eax
 2d3:	89 de                	mov    %ebx,%esi
 2d5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 2d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2dc:	5b                   	pop    %ebx
 2dd:	5e                   	pop    %esi
 2de:	5f                   	pop    %edi
 2df:	5d                   	pop    %ebp
 2e0:	c3                   	ret    
 2e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2ef:	90                   	nop

000002f0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	56                   	push   %esi
 2f4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2f5:	83 ec 08             	sub    $0x8,%esp
 2f8:	6a 00                	push   $0x0
 2fa:	ff 75 08             	push   0x8(%ebp)
 2fd:	e8 f1 00 00 00       	call   3f3 <open>
  if(fd < 0)
 302:	83 c4 10             	add    $0x10,%esp
 305:	85 c0                	test   %eax,%eax
 307:	78 27                	js     330 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 309:	83 ec 08             	sub    $0x8,%esp
 30c:	ff 75 0c             	push   0xc(%ebp)
 30f:	89 c3                	mov    %eax,%ebx
 311:	50                   	push   %eax
 312:	e8 f4 00 00 00       	call   40b <fstat>
  close(fd);
 317:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 31a:	89 c6                	mov    %eax,%esi
  close(fd);
 31c:	e8 ba 00 00 00       	call   3db <close>
  return r;
 321:	83 c4 10             	add    $0x10,%esp
}
 324:	8d 65 f8             	lea    -0x8(%ebp),%esp
 327:	89 f0                	mov    %esi,%eax
 329:	5b                   	pop    %ebx
 32a:	5e                   	pop    %esi
 32b:	5d                   	pop    %ebp
 32c:	c3                   	ret    
 32d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 330:	be ff ff ff ff       	mov    $0xffffffff,%esi
 335:	eb ed                	jmp    324 <stat+0x34>
 337:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 33e:	66 90                	xchg   %ax,%ax

00000340 <atoi>:

int
atoi(const char *s)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	53                   	push   %ebx
 344:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 347:	0f be 02             	movsbl (%edx),%eax
 34a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 34d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 350:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 355:	77 1e                	ja     375 <atoi+0x35>
 357:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 35e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 360:	83 c2 01             	add    $0x1,%edx
 363:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 366:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 36a:	0f be 02             	movsbl (%edx),%eax
 36d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 370:	80 fb 09             	cmp    $0x9,%bl
 373:	76 eb                	jbe    360 <atoi+0x20>
  return n;
}
 375:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 378:	89 c8                	mov    %ecx,%eax
 37a:	c9                   	leave  
 37b:	c3                   	ret    
 37c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000380 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	57                   	push   %edi
 384:	8b 45 10             	mov    0x10(%ebp),%eax
 387:	8b 55 08             	mov    0x8(%ebp),%edx
 38a:	56                   	push   %esi
 38b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 38e:	85 c0                	test   %eax,%eax
 390:	7e 13                	jle    3a5 <memmove+0x25>
 392:	01 d0                	add    %edx,%eax
  dst = vdst;
 394:	89 d7                	mov    %edx,%edi
 396:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 39d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 3a0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 3a1:	39 f8                	cmp    %edi,%eax
 3a3:	75 fb                	jne    3a0 <memmove+0x20>
  return vdst;
}
 3a5:	5e                   	pop    %esi
 3a6:	89 d0                	mov    %edx,%eax
 3a8:	5f                   	pop    %edi
 3a9:	5d                   	pop    %ebp
 3aa:	c3                   	ret    

000003ab <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3ab:	b8 01 00 00 00       	mov    $0x1,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <exit>:
SYSCALL(exit)
 3b3:	b8 02 00 00 00       	mov    $0x2,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <wait>:
SYSCALL(wait)
 3bb:	b8 03 00 00 00       	mov    $0x3,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <pipe>:
SYSCALL(pipe)
 3c3:	b8 04 00 00 00       	mov    $0x4,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <read>:
SYSCALL(read)
 3cb:	b8 05 00 00 00       	mov    $0x5,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <write>:
SYSCALL(write)
 3d3:	b8 10 00 00 00       	mov    $0x10,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <close>:
SYSCALL(close)
 3db:	b8 15 00 00 00       	mov    $0x15,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <kill>:
SYSCALL(kill)
 3e3:	b8 06 00 00 00       	mov    $0x6,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <exec>:
SYSCALL(exec)
 3eb:	b8 07 00 00 00       	mov    $0x7,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <open>:
SYSCALL(open)
 3f3:	b8 0f 00 00 00       	mov    $0xf,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <mknod>:
SYSCALL(mknod)
 3fb:	b8 11 00 00 00       	mov    $0x11,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <unlink>:
SYSCALL(unlink)
 403:	b8 12 00 00 00       	mov    $0x12,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <fstat>:
SYSCALL(fstat)
 40b:	b8 08 00 00 00       	mov    $0x8,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    

00000413 <link>:
SYSCALL(link)
 413:	b8 13 00 00 00       	mov    $0x13,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <mkdir>:
SYSCALL(mkdir)
 41b:	b8 14 00 00 00       	mov    $0x14,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret    

00000423 <chdir>:
SYSCALL(chdir)
 423:	b8 09 00 00 00       	mov    $0x9,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret    

0000042b <dup>:
SYSCALL(dup)
 42b:	b8 0a 00 00 00       	mov    $0xa,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <getpid>:
SYSCALL(getpid)
 433:	b8 0b 00 00 00       	mov    $0xb,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    

0000043b <sbrk>:
SYSCALL(sbrk)
 43b:	b8 0c 00 00 00       	mov    $0xc,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret    

00000443 <sleep>:
SYSCALL(sleep)
 443:	b8 0d 00 00 00       	mov    $0xd,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret    

0000044b <uptime>:
SYSCALL(uptime)
 44b:	b8 0e 00 00 00       	mov    $0xe,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret    

00000453 <create_palindrome>:
SYSCALL(create_palindrome)
 453:	b8 16 00 00 00       	mov    $0x16,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret    

0000045b <list_all_processes>:
SYSCALL(list_all_processes)
 45b:	b8 19 00 00 00       	mov    $0x19,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret    

00000463 <setqueue>:
SYSCALL(setqueue)
 463:	b8 1a 00 00 00       	mov    $0x1a,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret    

0000046b <printinfo>:
SYSCALL(printinfo)
 46b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret    

00000473 <setburstconf>:
SYSCALL(setburstconf)
 473:	b8 1c 00 00 00       	mov    $0x1c,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret    

0000047b <count_syscalls>:
SYSCALL(count_syscalls)
 47b:	b8 1d 00 00 00       	mov    $0x1d,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret    

00000483 <init_reentrantlock>:
SYSCALL(init_reentrantlock)
 483:	b8 1e 00 00 00       	mov    $0x1e,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret    

0000048b <acquire_reentrantlock>:
SYSCALL(acquire_reentrantlock)
 48b:	b8 1f 00 00 00       	mov    $0x1f,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret    

00000493 <release_reentrantlock>:
 493:	b8 20 00 00 00       	mov    $0x20,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret    
 49b:	66 90                	xchg   %ax,%ax
 49d:	66 90                	xchg   %ax,%ax
 49f:	90                   	nop

000004a0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	57                   	push   %edi
 4a4:	56                   	push   %esi
 4a5:	53                   	push   %ebx
 4a6:	83 ec 3c             	sub    $0x3c,%esp
 4a9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 4ac:	89 d1                	mov    %edx,%ecx
{
 4ae:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 4b1:	85 d2                	test   %edx,%edx
 4b3:	0f 89 7f 00 00 00    	jns    538 <printint+0x98>
 4b9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 4bd:	74 79                	je     538 <printint+0x98>
    neg = 1;
 4bf:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 4c6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 4c8:	31 db                	xor    %ebx,%ebx
 4ca:	8d 75 d7             	lea    -0x29(%ebp),%esi
 4cd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 4d0:	89 c8                	mov    %ecx,%eax
 4d2:	31 d2                	xor    %edx,%edx
 4d4:	89 cf                	mov    %ecx,%edi
 4d6:	f7 75 c4             	divl   -0x3c(%ebp)
 4d9:	0f b6 92 10 09 00 00 	movzbl 0x910(%edx),%edx
 4e0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 4e3:	89 d8                	mov    %ebx,%eax
 4e5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 4e8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 4eb:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 4ee:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 4f1:	76 dd                	jbe    4d0 <printint+0x30>
  if(neg)
 4f3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 4f6:	85 c9                	test   %ecx,%ecx
 4f8:	74 0c                	je     506 <printint+0x66>
    buf[i++] = '-';
 4fa:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 4ff:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 501:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 506:	8b 7d b8             	mov    -0x48(%ebp),%edi
 509:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 50d:	eb 07                	jmp    516 <printint+0x76>
 50f:	90                   	nop
    putc(fd, buf[i]);
 510:	0f b6 13             	movzbl (%ebx),%edx
 513:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 516:	83 ec 04             	sub    $0x4,%esp
 519:	88 55 d7             	mov    %dl,-0x29(%ebp)
 51c:	6a 01                	push   $0x1
 51e:	56                   	push   %esi
 51f:	57                   	push   %edi
 520:	e8 ae fe ff ff       	call   3d3 <write>
  while(--i >= 0)
 525:	83 c4 10             	add    $0x10,%esp
 528:	39 de                	cmp    %ebx,%esi
 52a:	75 e4                	jne    510 <printint+0x70>
}
 52c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 52f:	5b                   	pop    %ebx
 530:	5e                   	pop    %esi
 531:	5f                   	pop    %edi
 532:	5d                   	pop    %ebp
 533:	c3                   	ret    
 534:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 538:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 53f:	eb 87                	jmp    4c8 <printint+0x28>
 541:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 548:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 54f:	90                   	nop

00000550 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 550:	55                   	push   %ebp
 551:	89 e5                	mov    %esp,%ebp
 553:	57                   	push   %edi
 554:	56                   	push   %esi
 555:	53                   	push   %ebx
 556:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 559:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 55c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 55f:	0f b6 13             	movzbl (%ebx),%edx
 562:	84 d2                	test   %dl,%dl
 564:	74 6a                	je     5d0 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
 566:	8d 45 10             	lea    0x10(%ebp),%eax
 569:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 56c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 56f:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
 571:	89 45 d0             	mov    %eax,-0x30(%ebp)
 574:	eb 36                	jmp    5ac <printf+0x5c>
 576:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 57d:	8d 76 00             	lea    0x0(%esi),%esi
 580:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 583:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
 588:	83 f8 25             	cmp    $0x25,%eax
 58b:	74 15                	je     5a2 <printf+0x52>
  write(fd, &c, 1);
 58d:	83 ec 04             	sub    $0x4,%esp
 590:	88 55 e7             	mov    %dl,-0x19(%ebp)
 593:	6a 01                	push   $0x1
 595:	57                   	push   %edi
 596:	56                   	push   %esi
 597:	e8 37 fe ff ff       	call   3d3 <write>
 59c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
 59f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 5a2:	0f b6 13             	movzbl (%ebx),%edx
 5a5:	83 c3 01             	add    $0x1,%ebx
 5a8:	84 d2                	test   %dl,%dl
 5aa:	74 24                	je     5d0 <printf+0x80>
    c = fmt[i] & 0xff;
 5ac:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 5af:	85 c9                	test   %ecx,%ecx
 5b1:	74 cd                	je     580 <printf+0x30>
      }
    } else if(state == '%'){
 5b3:	83 f9 25             	cmp    $0x25,%ecx
 5b6:	75 ea                	jne    5a2 <printf+0x52>
      if(c == 'd'){
 5b8:	83 f8 25             	cmp    $0x25,%eax
 5bb:	0f 84 07 01 00 00    	je     6c8 <printf+0x178>
 5c1:	83 e8 63             	sub    $0x63,%eax
 5c4:	83 f8 15             	cmp    $0x15,%eax
 5c7:	77 17                	ja     5e0 <printf+0x90>
 5c9:	ff 24 85 b8 08 00 00 	jmp    *0x8b8(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5d3:	5b                   	pop    %ebx
 5d4:	5e                   	pop    %esi
 5d5:	5f                   	pop    %edi
 5d6:	5d                   	pop    %ebp
 5d7:	c3                   	ret    
 5d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5df:	90                   	nop
  write(fd, &c, 1);
 5e0:	83 ec 04             	sub    $0x4,%esp
 5e3:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 5e6:	6a 01                	push   $0x1
 5e8:	57                   	push   %edi
 5e9:	56                   	push   %esi
 5ea:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5ee:	e8 e0 fd ff ff       	call   3d3 <write>
        putc(fd, c);
 5f3:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 5f7:	83 c4 0c             	add    $0xc,%esp
 5fa:	88 55 e7             	mov    %dl,-0x19(%ebp)
 5fd:	6a 01                	push   $0x1
 5ff:	57                   	push   %edi
 600:	56                   	push   %esi
 601:	e8 cd fd ff ff       	call   3d3 <write>
        putc(fd, c);
 606:	83 c4 10             	add    $0x10,%esp
      state = 0;
 609:	31 c9                	xor    %ecx,%ecx
 60b:	eb 95                	jmp    5a2 <printf+0x52>
 60d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 610:	83 ec 0c             	sub    $0xc,%esp
 613:	b9 10 00 00 00       	mov    $0x10,%ecx
 618:	6a 00                	push   $0x0
 61a:	8b 45 d0             	mov    -0x30(%ebp),%eax
 61d:	8b 10                	mov    (%eax),%edx
 61f:	89 f0                	mov    %esi,%eax
 621:	e8 7a fe ff ff       	call   4a0 <printint>
        ap++;
 626:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 62a:	83 c4 10             	add    $0x10,%esp
      state = 0;
 62d:	31 c9                	xor    %ecx,%ecx
 62f:	e9 6e ff ff ff       	jmp    5a2 <printf+0x52>
 634:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 638:	8b 45 d0             	mov    -0x30(%ebp),%eax
 63b:	8b 10                	mov    (%eax),%edx
        ap++;
 63d:	83 c0 04             	add    $0x4,%eax
 640:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 643:	85 d2                	test   %edx,%edx
 645:	0f 84 8d 00 00 00    	je     6d8 <printf+0x188>
        while(*s != 0){
 64b:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
 64e:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
 650:	84 c0                	test   %al,%al
 652:	0f 84 4a ff ff ff    	je     5a2 <printf+0x52>
 658:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 65b:	89 d3                	mov    %edx,%ebx
 65d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 660:	83 ec 04             	sub    $0x4,%esp
          s++;
 663:	83 c3 01             	add    $0x1,%ebx
 666:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 669:	6a 01                	push   $0x1
 66b:	57                   	push   %edi
 66c:	56                   	push   %esi
 66d:	e8 61 fd ff ff       	call   3d3 <write>
        while(*s != 0){
 672:	0f b6 03             	movzbl (%ebx),%eax
 675:	83 c4 10             	add    $0x10,%esp
 678:	84 c0                	test   %al,%al
 67a:	75 e4                	jne    660 <printf+0x110>
      state = 0;
 67c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 67f:	31 c9                	xor    %ecx,%ecx
 681:	e9 1c ff ff ff       	jmp    5a2 <printf+0x52>
 686:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 68d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 690:	83 ec 0c             	sub    $0xc,%esp
 693:	b9 0a 00 00 00       	mov    $0xa,%ecx
 698:	6a 01                	push   $0x1
 69a:	e9 7b ff ff ff       	jmp    61a <printf+0xca>
 69f:	90                   	nop
        putc(fd, *ap);
 6a0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
 6a3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 6a6:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 6a8:	6a 01                	push   $0x1
 6aa:	57                   	push   %edi
 6ab:	56                   	push   %esi
        putc(fd, *ap);
 6ac:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6af:	e8 1f fd ff ff       	call   3d3 <write>
        ap++;
 6b4:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 6b8:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6bb:	31 c9                	xor    %ecx,%ecx
 6bd:	e9 e0 fe ff ff       	jmp    5a2 <printf+0x52>
 6c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 6c8:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 6cb:	83 ec 04             	sub    $0x4,%esp
 6ce:	e9 2a ff ff ff       	jmp    5fd <printf+0xad>
 6d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6d7:	90                   	nop
          s = "(null)";
 6d8:	ba ae 08 00 00       	mov    $0x8ae,%edx
        while(*s != 0){
 6dd:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 6e0:	b8 28 00 00 00       	mov    $0x28,%eax
 6e5:	89 d3                	mov    %edx,%ebx
 6e7:	e9 74 ff ff ff       	jmp    660 <printf+0x110>
 6ec:	66 90                	xchg   %ax,%ax
 6ee:	66 90                	xchg   %ax,%ax

000006f0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6f0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f1:	a1 f0 0b 00 00       	mov    0xbf0,%eax
{
 6f6:	89 e5                	mov    %esp,%ebp
 6f8:	57                   	push   %edi
 6f9:	56                   	push   %esi
 6fa:	53                   	push   %ebx
 6fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 6fe:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 701:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 708:	89 c2                	mov    %eax,%edx
 70a:	8b 00                	mov    (%eax),%eax
 70c:	39 ca                	cmp    %ecx,%edx
 70e:	73 30                	jae    740 <free+0x50>
 710:	39 c1                	cmp    %eax,%ecx
 712:	72 04                	jb     718 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 714:	39 c2                	cmp    %eax,%edx
 716:	72 f0                	jb     708 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 718:	8b 73 fc             	mov    -0x4(%ebx),%esi
 71b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 71e:	39 f8                	cmp    %edi,%eax
 720:	74 30                	je     752 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 722:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 725:	8b 42 04             	mov    0x4(%edx),%eax
 728:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 72b:	39 f1                	cmp    %esi,%ecx
 72d:	74 3a                	je     769 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 72f:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 731:	5b                   	pop    %ebx
  freep = p;
 732:	89 15 f0 0b 00 00    	mov    %edx,0xbf0
}
 738:	5e                   	pop    %esi
 739:	5f                   	pop    %edi
 73a:	5d                   	pop    %ebp
 73b:	c3                   	ret    
 73c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 740:	39 c2                	cmp    %eax,%edx
 742:	72 c4                	jb     708 <free+0x18>
 744:	39 c1                	cmp    %eax,%ecx
 746:	73 c0                	jae    708 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 748:	8b 73 fc             	mov    -0x4(%ebx),%esi
 74b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 74e:	39 f8                	cmp    %edi,%eax
 750:	75 d0                	jne    722 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 752:	03 70 04             	add    0x4(%eax),%esi
 755:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 758:	8b 02                	mov    (%edx),%eax
 75a:	8b 00                	mov    (%eax),%eax
 75c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 75f:	8b 42 04             	mov    0x4(%edx),%eax
 762:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 765:	39 f1                	cmp    %esi,%ecx
 767:	75 c6                	jne    72f <free+0x3f>
    p->s.size += bp->s.size;
 769:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 76c:	89 15 f0 0b 00 00    	mov    %edx,0xbf0
    p->s.size += bp->s.size;
 772:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 775:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 778:	89 0a                	mov    %ecx,(%edx)
}
 77a:	5b                   	pop    %ebx
 77b:	5e                   	pop    %esi
 77c:	5f                   	pop    %edi
 77d:	5d                   	pop    %ebp
 77e:	c3                   	ret    
 77f:	90                   	nop

00000780 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 780:	55                   	push   %ebp
 781:	89 e5                	mov    %esp,%ebp
 783:	57                   	push   %edi
 784:	56                   	push   %esi
 785:	53                   	push   %ebx
 786:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 789:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 78c:	8b 3d f0 0b 00 00    	mov    0xbf0,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 792:	8d 70 07             	lea    0x7(%eax),%esi
 795:	c1 ee 03             	shr    $0x3,%esi
 798:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 79b:	85 ff                	test   %edi,%edi
 79d:	0f 84 9d 00 00 00    	je     840 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a3:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 7a5:	8b 4a 04             	mov    0x4(%edx),%ecx
 7a8:	39 f1                	cmp    %esi,%ecx
 7aa:	73 6a                	jae    816 <malloc+0x96>
 7ac:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7b1:	39 de                	cmp    %ebx,%esi
 7b3:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 7b6:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 7bd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 7c0:	eb 17                	jmp    7d9 <malloc+0x59>
 7c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7ca:	8b 48 04             	mov    0x4(%eax),%ecx
 7cd:	39 f1                	cmp    %esi,%ecx
 7cf:	73 4f                	jae    820 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7d1:	8b 3d f0 0b 00 00    	mov    0xbf0,%edi
 7d7:	89 c2                	mov    %eax,%edx
 7d9:	39 d7                	cmp    %edx,%edi
 7db:	75 eb                	jne    7c8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 7dd:	83 ec 0c             	sub    $0xc,%esp
 7e0:	ff 75 e4             	push   -0x1c(%ebp)
 7e3:	e8 53 fc ff ff       	call   43b <sbrk>
  if(p == (char*)-1)
 7e8:	83 c4 10             	add    $0x10,%esp
 7eb:	83 f8 ff             	cmp    $0xffffffff,%eax
 7ee:	74 1c                	je     80c <malloc+0x8c>
  hp->s.size = nu;
 7f0:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7f3:	83 ec 0c             	sub    $0xc,%esp
 7f6:	83 c0 08             	add    $0x8,%eax
 7f9:	50                   	push   %eax
 7fa:	e8 f1 fe ff ff       	call   6f0 <free>
  return freep;
 7ff:	8b 15 f0 0b 00 00    	mov    0xbf0,%edx
      if((p = morecore(nunits)) == 0)
 805:	83 c4 10             	add    $0x10,%esp
 808:	85 d2                	test   %edx,%edx
 80a:	75 bc                	jne    7c8 <malloc+0x48>
        return 0;
  }
}
 80c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 80f:	31 c0                	xor    %eax,%eax
}
 811:	5b                   	pop    %ebx
 812:	5e                   	pop    %esi
 813:	5f                   	pop    %edi
 814:	5d                   	pop    %ebp
 815:	c3                   	ret    
    if(p->s.size >= nunits){
 816:	89 d0                	mov    %edx,%eax
 818:	89 fa                	mov    %edi,%edx
 81a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 820:	39 ce                	cmp    %ecx,%esi
 822:	74 4c                	je     870 <malloc+0xf0>
        p->s.size -= nunits;
 824:	29 f1                	sub    %esi,%ecx
 826:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 829:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 82c:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 82f:	89 15 f0 0b 00 00    	mov    %edx,0xbf0
}
 835:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 838:	83 c0 08             	add    $0x8,%eax
}
 83b:	5b                   	pop    %ebx
 83c:	5e                   	pop    %esi
 83d:	5f                   	pop    %edi
 83e:	5d                   	pop    %ebp
 83f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 840:	c7 05 f0 0b 00 00 f4 	movl   $0xbf4,0xbf0
 847:	0b 00 00 
    base.s.size = 0;
 84a:	bf f4 0b 00 00       	mov    $0xbf4,%edi
    base.s.ptr = freep = prevp = &base;
 84f:	c7 05 f4 0b 00 00 f4 	movl   $0xbf4,0xbf4
 856:	0b 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 859:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 85b:	c7 05 f8 0b 00 00 00 	movl   $0x0,0xbf8
 862:	00 00 00 
    if(p->s.size >= nunits){
 865:	e9 42 ff ff ff       	jmp    7ac <malloc+0x2c>
 86a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 870:	8b 08                	mov    (%eax),%ecx
 872:	89 0a                	mov    %ecx,(%edx)
 874:	eb b9                	jmp    82f <malloc+0xaf>
