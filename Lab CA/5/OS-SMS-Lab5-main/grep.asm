
_grep:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
}

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 18             	sub    $0x18,%esp
  14:	8b 01                	mov    (%ecx),%eax
  16:	8b 59 04             	mov    0x4(%ecx),%ebx
  19:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int fd, i;
  char *pattern;

  if(argc <= 1){
  1c:	83 f8 01             	cmp    $0x1,%eax
  1f:	7e 6f                	jle    90 <main+0x90>
    printf(2, "usage: grep pattern [file ...]\n");
    exit();
  }
  pattern = argv[1];
  21:	8b 43 04             	mov    0x4(%ebx),%eax
  24:	83 c3 08             	add    $0x8,%ebx

  if(argc <= 2){
  27:	83 7d e4 02          	cmpl   $0x2,-0x1c(%ebp)
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
  2b:	be 02 00 00 00       	mov    $0x2,%esi
  pattern = argv[1];
  30:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(argc <= 2){
  33:	75 2d                	jne    62 <main+0x62>
  35:	eb 6c                	jmp    a3 <main+0xa3>
  37:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  3e:	00 
  3f:	90                   	nop
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "grep: cannot open %s\n", argv[i]);
      exit();
    }
    grep(pattern, fd);
  40:	83 ec 08             	sub    $0x8,%esp
  for(i = 2; i < argc; i++){
  43:	83 c6 01             	add    $0x1,%esi
  46:	83 c3 04             	add    $0x4,%ebx
    grep(pattern, fd);
  49:	50                   	push   %eax
  4a:	ff 75 e0             	push   -0x20(%ebp)
  4d:	e8 7e 01 00 00       	call   1d0 <grep>
    close(fd);
  52:	89 3c 24             	mov    %edi,(%esp)
  55:	e8 81 05 00 00       	call   5db <close>
  for(i = 2; i < argc; i++){
  5a:	83 c4 10             	add    $0x10,%esp
  5d:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  60:	7e 29                	jle    8b <main+0x8b>
    if((fd = open(argv[i], 0)) < 0){
  62:	83 ec 08             	sub    $0x8,%esp
  65:	6a 00                	push   $0x0
  67:	ff 33                	push   (%ebx)
  69:	e8 85 05 00 00       	call   5f3 <open>
  6e:	83 c4 10             	add    $0x10,%esp
  71:	89 c7                	mov    %eax,%edi
  73:	85 c0                	test   %eax,%eax
  75:	79 c9                	jns    40 <main+0x40>
      printf(1, "grep: cannot open %s\n", argv[i]);
  77:	50                   	push   %eax
  78:	ff 33                	push   (%ebx)
  7a:	68 c8 0a 00 00       	push   $0xac8
  7f:	6a 01                	push   $0x1
  81:	e8 ba 06 00 00       	call   740 <printf>
      exit();
  86:	e8 28 05 00 00       	call   5b3 <exit>
  }
  exit();
  8b:	e8 23 05 00 00       	call   5b3 <exit>
    printf(2, "usage: grep pattern [file ...]\n");
  90:	51                   	push   %ecx
  91:	51                   	push   %ecx
  92:	68 a8 0a 00 00       	push   $0xaa8
  97:	6a 02                	push   $0x2
  99:	e8 a2 06 00 00       	call   740 <printf>
    exit();
  9e:	e8 10 05 00 00       	call   5b3 <exit>
    grep(pattern, 0);
  a3:	52                   	push   %edx
  a4:	52                   	push   %edx
  a5:	6a 00                	push   $0x0
  a7:	50                   	push   %eax
  a8:	e8 23 01 00 00       	call   1d0 <grep>
    exit();
  ad:	e8 01 05 00 00       	call   5b3 <exit>
  b2:	66 90                	xchg   %ax,%ax
  b4:	66 90                	xchg   %ax,%ax
  b6:	66 90                	xchg   %ax,%ax
  b8:	66 90                	xchg   %ax,%ax
  ba:	66 90                	xchg   %ax,%ax
  bc:	66 90                	xchg   %ax,%ax
  be:	66 90                	xchg   %ax,%ax

000000c0 <matchhere>:
  return 0;
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	57                   	push   %edi
  c4:	56                   	push   %esi
  c5:	53                   	push   %ebx
  c6:	83 ec 0c             	sub    $0xc,%esp
  c9:	8b 75 08             	mov    0x8(%ebp),%esi
  cc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(re[0] == '\0')
  cf:	0f b6 06             	movzbl (%esi),%eax
  d2:	84 c0                	test   %al,%al
  d4:	75 2d                	jne    103 <matchhere+0x43>
  d6:	e9 7d 00 00 00       	jmp    158 <matchhere+0x98>
  db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return 1;
  if(re[1] == '*')
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  e0:	0f b6 0b             	movzbl (%ebx),%ecx
  if(re[0] == '$' && re[1] == '\0')
  e3:	80 fa 24             	cmp    $0x24,%dl
  e6:	75 04                	jne    ec <matchhere+0x2c>
  e8:	84 c0                	test   %al,%al
  ea:	74 79                	je     165 <matchhere+0xa5>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  ec:	84 c9                	test   %cl,%cl
  ee:	74 58                	je     148 <matchhere+0x88>
  f0:	38 d1                	cmp    %dl,%cl
  f2:	74 05                	je     f9 <matchhere+0x39>
  f4:	80 fa 2e             	cmp    $0x2e,%dl
  f7:	75 4f                	jne    148 <matchhere+0x88>
    return matchhere(re+1, text+1);
  f9:	83 c3 01             	add    $0x1,%ebx
  fc:	83 c6 01             	add    $0x1,%esi
  if(re[0] == '\0')
  ff:	84 c0                	test   %al,%al
 101:	74 55                	je     158 <matchhere+0x98>
  if(re[1] == '*')
 103:	89 c2                	mov    %eax,%edx
 105:	0f b6 46 01          	movzbl 0x1(%esi),%eax
 109:	3c 2a                	cmp    $0x2a,%al
 10b:	75 d3                	jne    e0 <matchhere+0x20>
    return matchstar(re[0], re+2, text);
 10d:	83 c6 02             	add    $0x2,%esi
 110:	0f be fa             	movsbl %dl,%edi
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
 113:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
{
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
 118:	83 ec 08             	sub    $0x8,%esp
 11b:	53                   	push   %ebx
 11c:	56                   	push   %esi
 11d:	e8 9e ff ff ff       	call   c0 <matchhere>
 122:	83 c4 10             	add    $0x10,%esp
 125:	85 c0                	test   %eax,%eax
 127:	75 2f                	jne    158 <matchhere+0x98>
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
 129:	0f be 13             	movsbl (%ebx),%edx
 12c:	84 d2                	test   %dl,%dl
 12e:	74 0c                	je     13c <matchhere+0x7c>
 130:	83 c3 01             	add    $0x1,%ebx
 133:	83 ff 2e             	cmp    $0x2e,%edi
 136:	74 e0                	je     118 <matchhere+0x58>
 138:	39 fa                	cmp    %edi,%edx
 13a:	74 dc                	je     118 <matchhere+0x58>
}
 13c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 13f:	5b                   	pop    %ebx
 140:	5e                   	pop    %esi
 141:	5f                   	pop    %edi
 142:	5d                   	pop    %ebp
 143:	c3                   	ret
 144:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 148:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
 14b:	31 c0                	xor    %eax,%eax
}
 14d:	5b                   	pop    %ebx
 14e:	5e                   	pop    %esi
 14f:	5f                   	pop    %edi
 150:	5d                   	pop    %ebp
 151:	c3                   	ret
 152:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 158:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 1;
 15b:	b8 01 00 00 00       	mov    $0x1,%eax
}
 160:	5b                   	pop    %ebx
 161:	5e                   	pop    %esi
 162:	5f                   	pop    %edi
 163:	5d                   	pop    %ebp
 164:	c3                   	ret
    return *text == '\0';
 165:	31 c0                	xor    %eax,%eax
 167:	84 c9                	test   %cl,%cl
 169:	0f 94 c0             	sete   %al
 16c:	eb ce                	jmp    13c <matchhere+0x7c>
 16e:	66 90                	xchg   %ax,%ax

00000170 <match>:
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	56                   	push   %esi
 174:	53                   	push   %ebx
 175:	8b 5d 08             	mov    0x8(%ebp),%ebx
 178:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(re[0] == '^')
 17b:	80 3b 5e             	cmpb   $0x5e,(%ebx)
 17e:	75 11                	jne    191 <match+0x21>
 180:	eb 2e                	jmp    1b0 <match+0x40>
 182:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }while(*text++ != '\0');
 188:	83 c6 01             	add    $0x1,%esi
 18b:	80 7e ff 00          	cmpb   $0x0,-0x1(%esi)
 18f:	74 16                	je     1a7 <match+0x37>
    if(matchhere(re, text))
 191:	83 ec 08             	sub    $0x8,%esp
 194:	56                   	push   %esi
 195:	53                   	push   %ebx
 196:	e8 25 ff ff ff       	call   c0 <matchhere>
 19b:	83 c4 10             	add    $0x10,%esp
 19e:	85 c0                	test   %eax,%eax
 1a0:	74 e6                	je     188 <match+0x18>
      return 1;
 1a2:	b8 01 00 00 00       	mov    $0x1,%eax
}
 1a7:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1aa:	5b                   	pop    %ebx
 1ab:	5e                   	pop    %esi
 1ac:	5d                   	pop    %ebp
 1ad:	c3                   	ret
 1ae:	66 90                	xchg   %ax,%ax
    return matchhere(re+1, text);
 1b0:	83 c3 01             	add    $0x1,%ebx
 1b3:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
 1b6:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1b9:	5b                   	pop    %ebx
 1ba:	5e                   	pop    %esi
 1bb:	5d                   	pop    %ebp
    return matchhere(re+1, text);
 1bc:	e9 ff fe ff ff       	jmp    c0 <matchhere>
 1c1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1c8:	00 
 1c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001d0 <grep>:
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	57                   	push   %edi
 1d4:	56                   	push   %esi
 1d5:	53                   	push   %ebx
 1d6:	83 ec 1c             	sub    $0x1c,%esp
 1d9:	8b 7d 08             	mov    0x8(%ebp),%edi
  m = 0;
 1dc:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    return matchhere(re+1, text);
 1e3:	8d 47 01             	lea    0x1(%edi),%eax
 1e6:	89 45 d8             	mov    %eax,-0x28(%ebp)
 1e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 1f0:	8b 4d dc             	mov    -0x24(%ebp),%ecx
 1f3:	b8 ff 03 00 00       	mov    $0x3ff,%eax
 1f8:	83 ec 04             	sub    $0x4,%esp
 1fb:	29 c8                	sub    %ecx,%eax
 1fd:	50                   	push   %eax
 1fe:	8d 81 a0 0e 00 00    	lea    0xea0(%ecx),%eax
 204:	50                   	push   %eax
 205:	ff 75 0c             	push   0xc(%ebp)
 208:	e8 be 03 00 00       	call   5cb <read>
 20d:	83 c4 10             	add    $0x10,%esp
 210:	85 c0                	test   %eax,%eax
 212:	0f 8e e5 00 00 00    	jle    2fd <grep+0x12d>
    m += n;
 218:	01 45 dc             	add    %eax,-0x24(%ebp)
 21b:	8b 4d dc             	mov    -0x24(%ebp),%ecx
    p = buf;
 21e:	c7 45 e4 a0 0e 00 00 	movl   $0xea0,-0x1c(%ebp)
    buf[m] = '\0';
 225:	c6 81 a0 0e 00 00 00 	movb   $0x0,0xea0(%ecx)
    while((q = strchr(p, '\n')) != 0){
 22c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 230:	83 ec 08             	sub    $0x8,%esp
 233:	6a 0a                	push   $0xa
 235:	ff 75 e4             	push   -0x1c(%ebp)
 238:	e8 03 02 00 00       	call   440 <strchr>
 23d:	83 c4 10             	add    $0x10,%esp
 240:	89 c3                	mov    %eax,%ebx
 242:	85 c0                	test   %eax,%eax
 244:	74 72                	je     2b8 <grep+0xe8>
      *q = 0;
 246:	c6 03 00             	movb   $0x0,(%ebx)
        write(1, p, q+1 - p);
 249:	8d 43 01             	lea    0x1(%ebx),%eax
  if(re[0] == '^')
 24c:	80 3f 5e             	cmpb   $0x5e,(%edi)
        write(1, p, q+1 - p);
 24f:	89 45 e0             	mov    %eax,-0x20(%ebp)
 252:	8b 75 e4             	mov    -0x1c(%ebp),%esi
  if(re[0] == '^')
 255:	75 12                	jne    269 <grep+0x99>
 257:	eb 47                	jmp    2a0 <grep+0xd0>
 259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }while(*text++ != '\0');
 260:	83 c6 01             	add    $0x1,%esi
 263:	80 7e ff 00          	cmpb   $0x0,-0x1(%esi)
 267:	74 2b                	je     294 <grep+0xc4>
    if(matchhere(re, text))
 269:	83 ec 08             	sub    $0x8,%esp
 26c:	56                   	push   %esi
 26d:	57                   	push   %edi
 26e:	e8 4d fe ff ff       	call   c0 <matchhere>
 273:	83 c4 10             	add    $0x10,%esp
 276:	85 c0                	test   %eax,%eax
 278:	74 e6                	je     260 <grep+0x90>
        write(1, p, q+1 - p);
 27a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 27d:	8b 45 e0             	mov    -0x20(%ebp),%eax
 280:	83 ec 04             	sub    $0x4,%esp
        *q = '\n';
 283:	c6 03 0a             	movb   $0xa,(%ebx)
        write(1, p, q+1 - p);
 286:	29 d0                	sub    %edx,%eax
 288:	50                   	push   %eax
 289:	52                   	push   %edx
 28a:	6a 01                	push   $0x1
 28c:	e8 42 03 00 00       	call   5d3 <write>
 291:	83 c4 10             	add    $0x10,%esp
      p = q+1;
 294:	8b 45 e0             	mov    -0x20(%ebp),%eax
 297:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 29a:	eb 94                	jmp    230 <grep+0x60>
 29c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return matchhere(re+1, text);
 2a0:	83 ec 08             	sub    $0x8,%esp
 2a3:	56                   	push   %esi
 2a4:	ff 75 d8             	push   -0x28(%ebp)
 2a7:	e8 14 fe ff ff       	call   c0 <matchhere>
 2ac:	83 c4 10             	add    $0x10,%esp
      if(match(pattern, p)){
 2af:	85 c0                	test   %eax,%eax
 2b1:	74 e1                	je     294 <grep+0xc4>
 2b3:	eb c5                	jmp    27a <grep+0xaa>
 2b5:	8d 76 00             	lea    0x0(%esi),%esi
    if(p == buf)
 2b8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 2bb:	81 fa a0 0e 00 00    	cmp    $0xea0,%edx
 2c1:	74 2e                	je     2f1 <grep+0x121>
    if(m > 0){
 2c3:	8b 4d dc             	mov    -0x24(%ebp),%ecx
 2c6:	85 c9                	test   %ecx,%ecx
 2c8:	0f 8e 22 ff ff ff    	jle    1f0 <grep+0x20>
      m -= p - buf;
 2ce:	89 d0                	mov    %edx,%eax
      memmove(buf, p, m);
 2d0:	83 ec 04             	sub    $0x4,%esp
      m -= p - buf;
 2d3:	2d a0 0e 00 00       	sub    $0xea0,%eax
 2d8:	29 c1                	sub    %eax,%ecx
      memmove(buf, p, m);
 2da:	51                   	push   %ecx
 2db:	52                   	push   %edx
 2dc:	68 a0 0e 00 00       	push   $0xea0
      m -= p - buf;
 2e1:	89 4d dc             	mov    %ecx,-0x24(%ebp)
      memmove(buf, p, m);
 2e4:	e8 97 02 00 00       	call   580 <memmove>
 2e9:	83 c4 10             	add    $0x10,%esp
 2ec:	e9 ff fe ff ff       	jmp    1f0 <grep+0x20>
      m = 0;
 2f1:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
 2f8:	e9 f3 fe ff ff       	jmp    1f0 <grep+0x20>
}
 2fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 300:	5b                   	pop    %ebx
 301:	5e                   	pop    %esi
 302:	5f                   	pop    %edi
 303:	5d                   	pop    %ebp
 304:	c3                   	ret
 305:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 30c:	00 
 30d:	8d 76 00             	lea    0x0(%esi),%esi

00000310 <matchstar>:
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	57                   	push   %edi
 314:	56                   	push   %esi
 315:	53                   	push   %ebx
 316:	83 ec 0c             	sub    $0xc,%esp
 319:	8b 5d 08             	mov    0x8(%ebp),%ebx
 31c:	8b 75 0c             	mov    0xc(%ebp),%esi
 31f:	8b 7d 10             	mov    0x10(%ebp),%edi
 322:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(matchhere(re, text))
 328:	83 ec 08             	sub    $0x8,%esp
 32b:	57                   	push   %edi
 32c:	56                   	push   %esi
 32d:	e8 8e fd ff ff       	call   c0 <matchhere>
 332:	83 c4 10             	add    $0x10,%esp
 335:	89 c2                	mov    %eax,%edx
 337:	85 c0                	test   %eax,%eax
 339:	75 25                	jne    360 <matchstar+0x50>
  }while(*text!='\0' && (*text++==c || c=='.'));
 33b:	0f be 07             	movsbl (%edi),%eax
 33e:	84 c0                	test   %al,%al
 340:	74 0c                	je     34e <matchstar+0x3e>
 342:	83 c7 01             	add    $0x1,%edi
 345:	39 d8                	cmp    %ebx,%eax
 347:	74 df                	je     328 <matchstar+0x18>
 349:	83 fb 2e             	cmp    $0x2e,%ebx
 34c:	74 da                	je     328 <matchstar+0x18>
}
 34e:	8d 65 f4             	lea    -0xc(%ebp),%esp
 351:	89 d0                	mov    %edx,%eax
 353:	5b                   	pop    %ebx
 354:	5e                   	pop    %esi
 355:	5f                   	pop    %edi
 356:	5d                   	pop    %ebp
 357:	c3                   	ret
 358:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 35f:	00 
 360:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 1;
 363:	ba 01 00 00 00       	mov    $0x1,%edx
}
 368:	5b                   	pop    %ebx
 369:	89 d0                	mov    %edx,%eax
 36b:	5e                   	pop    %esi
 36c:	5f                   	pop    %edi
 36d:	5d                   	pop    %ebp
 36e:	c3                   	ret
 36f:	90                   	nop

00000370 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 370:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 371:	31 c0                	xor    %eax,%eax
{
 373:	89 e5                	mov    %esp,%ebp
 375:	53                   	push   %ebx
 376:	8b 4d 08             	mov    0x8(%ebp),%ecx
 379:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 37c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 380:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 384:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 387:	83 c0 01             	add    $0x1,%eax
 38a:	84 d2                	test   %dl,%dl
 38c:	75 f2                	jne    380 <strcpy+0x10>
    ;
  return os;
}
 38e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 391:	89 c8                	mov    %ecx,%eax
 393:	c9                   	leave
 394:	c3                   	ret
 395:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 39c:	00 
 39d:	8d 76 00             	lea    0x0(%esi),%esi

000003a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	53                   	push   %ebx
 3a4:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 3aa:	0f b6 01             	movzbl (%ecx),%eax
 3ad:	0f b6 1a             	movzbl (%edx),%ebx
 3b0:	84 c0                	test   %al,%al
 3b2:	75 1c                	jne    3d0 <strcmp+0x30>
 3b4:	eb 2e                	jmp    3e4 <strcmp+0x44>
 3b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3bd:	00 
 3be:	66 90                	xchg   %ax,%ax
 3c0:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 3c4:	83 c1 01             	add    $0x1,%ecx
 3c7:	8d 5a 01             	lea    0x1(%edx),%ebx
  while(*p && *p == *q)
 3ca:	84 c0                	test   %al,%al
 3cc:	74 12                	je     3e0 <strcmp+0x40>
    p++, q++;
 3ce:	89 da                	mov    %ebx,%edx
  while(*p && *p == *q)
 3d0:	0f b6 1a             	movzbl (%edx),%ebx
 3d3:	38 c3                	cmp    %al,%bl
 3d5:	74 e9                	je     3c0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 3d7:	29 d8                	sub    %ebx,%eax
}
 3d9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3dc:	c9                   	leave
 3dd:	c3                   	ret
 3de:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 3e0:	0f b6 5a 01          	movzbl 0x1(%edx),%ebx
 3e4:	31 c0                	xor    %eax,%eax
 3e6:	29 d8                	sub    %ebx,%eax
}
 3e8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3eb:	c9                   	leave
 3ec:	c3                   	ret
 3ed:	8d 76 00             	lea    0x0(%esi),%esi

000003f0 <strlen>:

uint
strlen(const char *s)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 3f6:	80 3a 00             	cmpb   $0x0,(%edx)
 3f9:	74 15                	je     410 <strlen+0x20>
 3fb:	31 c0                	xor    %eax,%eax
 3fd:	8d 76 00             	lea    0x0(%esi),%esi
 400:	83 c0 01             	add    $0x1,%eax
 403:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 407:	89 c1                	mov    %eax,%ecx
 409:	75 f5                	jne    400 <strlen+0x10>
    ;
  return n;
}
 40b:	89 c8                	mov    %ecx,%eax
 40d:	5d                   	pop    %ebp
 40e:	c3                   	ret
 40f:	90                   	nop
  for(n = 0; s[n]; n++)
 410:	31 c9                	xor    %ecx,%ecx
}
 412:	5d                   	pop    %ebp
 413:	89 c8                	mov    %ecx,%eax
 415:	c3                   	ret
 416:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 41d:	00 
 41e:	66 90                	xchg   %ax,%ax

00000420 <memset>:

void*
memset(void *dst, int c, uint n)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	57                   	push   %edi
 424:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 427:	8b 4d 10             	mov    0x10(%ebp),%ecx
 42a:	8b 45 0c             	mov    0xc(%ebp),%eax
 42d:	89 d7                	mov    %edx,%edi
 42f:	fc                   	cld
 430:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 432:	8b 7d fc             	mov    -0x4(%ebp),%edi
 435:	89 d0                	mov    %edx,%eax
 437:	c9                   	leave
 438:	c3                   	ret
 439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000440 <strchr>:

char*
strchr(const char *s, char c)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	8b 45 08             	mov    0x8(%ebp),%eax
 446:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 44a:	0f b6 10             	movzbl (%eax),%edx
 44d:	84 d2                	test   %dl,%dl
 44f:	75 12                	jne    463 <strchr+0x23>
 451:	eb 1d                	jmp    470 <strchr+0x30>
 453:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 458:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 45c:	83 c0 01             	add    $0x1,%eax
 45f:	84 d2                	test   %dl,%dl
 461:	74 0d                	je     470 <strchr+0x30>
    if(*s == c)
 463:	38 d1                	cmp    %dl,%cl
 465:	75 f1                	jne    458 <strchr+0x18>
      return (char*)s;
  return 0;
}
 467:	5d                   	pop    %ebp
 468:	c3                   	ret
 469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 470:	31 c0                	xor    %eax,%eax
}
 472:	5d                   	pop    %ebp
 473:	c3                   	ret
 474:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 47b:	00 
 47c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000480 <gets>:

char*
gets(char *buf, int max)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	57                   	push   %edi
 484:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 485:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 488:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 489:	31 db                	xor    %ebx,%ebx
{
 48b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 48e:	eb 27                	jmp    4b7 <gets+0x37>
    cc = read(0, &c, 1);
 490:	83 ec 04             	sub    $0x4,%esp
 493:	6a 01                	push   $0x1
 495:	57                   	push   %edi
 496:	6a 00                	push   $0x0
 498:	e8 2e 01 00 00       	call   5cb <read>
    if(cc < 1)
 49d:	83 c4 10             	add    $0x10,%esp
 4a0:	85 c0                	test   %eax,%eax
 4a2:	7e 1d                	jle    4c1 <gets+0x41>
      break;
    buf[i++] = c;
 4a4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 4a8:	8b 55 08             	mov    0x8(%ebp),%edx
 4ab:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 4af:	3c 0a                	cmp    $0xa,%al
 4b1:	74 1d                	je     4d0 <gets+0x50>
 4b3:	3c 0d                	cmp    $0xd,%al
 4b5:	74 19                	je     4d0 <gets+0x50>
  for(i=0; i+1 < max; ){
 4b7:	89 de                	mov    %ebx,%esi
 4b9:	83 c3 01             	add    $0x1,%ebx
 4bc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 4bf:	7c cf                	jl     490 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 4c1:	8b 45 08             	mov    0x8(%ebp),%eax
 4c4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 4c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4cb:	5b                   	pop    %ebx
 4cc:	5e                   	pop    %esi
 4cd:	5f                   	pop    %edi
 4ce:	5d                   	pop    %ebp
 4cf:	c3                   	ret
  buf[i] = '\0';
 4d0:	8b 45 08             	mov    0x8(%ebp),%eax
 4d3:	89 de                	mov    %ebx,%esi
 4d5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 4d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4dc:	5b                   	pop    %ebx
 4dd:	5e                   	pop    %esi
 4de:	5f                   	pop    %edi
 4df:	5d                   	pop    %ebp
 4e0:	c3                   	ret
 4e1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4e8:	00 
 4e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000004f0 <stat>:

int
stat(const char *n, struct stat *st)
{
 4f0:	55                   	push   %ebp
 4f1:	89 e5                	mov    %esp,%ebp
 4f3:	56                   	push   %esi
 4f4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4f5:	83 ec 08             	sub    $0x8,%esp
 4f8:	6a 00                	push   $0x0
 4fa:	ff 75 08             	push   0x8(%ebp)
 4fd:	e8 f1 00 00 00       	call   5f3 <open>
  if(fd < 0)
 502:	83 c4 10             	add    $0x10,%esp
 505:	85 c0                	test   %eax,%eax
 507:	78 27                	js     530 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 509:	83 ec 08             	sub    $0x8,%esp
 50c:	ff 75 0c             	push   0xc(%ebp)
 50f:	89 c3                	mov    %eax,%ebx
 511:	50                   	push   %eax
 512:	e8 f4 00 00 00       	call   60b <fstat>
  close(fd);
 517:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 51a:	89 c6                	mov    %eax,%esi
  close(fd);
 51c:	e8 ba 00 00 00       	call   5db <close>
  return r;
 521:	83 c4 10             	add    $0x10,%esp
}
 524:	8d 65 f8             	lea    -0x8(%ebp),%esp
 527:	89 f0                	mov    %esi,%eax
 529:	5b                   	pop    %ebx
 52a:	5e                   	pop    %esi
 52b:	5d                   	pop    %ebp
 52c:	c3                   	ret
 52d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 530:	be ff ff ff ff       	mov    $0xffffffff,%esi
 535:	eb ed                	jmp    524 <stat+0x34>
 537:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 53e:	00 
 53f:	90                   	nop

00000540 <atoi>:

int
atoi(const char *s)
{
 540:	55                   	push   %ebp
 541:	89 e5                	mov    %esp,%ebp
 543:	53                   	push   %ebx
 544:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 547:	0f be 02             	movsbl (%edx),%eax
 54a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 54d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 550:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 555:	77 1e                	ja     575 <atoi+0x35>
 557:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 55e:	00 
 55f:	90                   	nop
    n = n*10 + *s++ - '0';
 560:	83 c2 01             	add    $0x1,%edx
 563:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 566:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 56a:	0f be 02             	movsbl (%edx),%eax
 56d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 570:	80 fb 09             	cmp    $0x9,%bl
 573:	76 eb                	jbe    560 <atoi+0x20>
  return n;
}
 575:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 578:	89 c8                	mov    %ecx,%eax
 57a:	c9                   	leave
 57b:	c3                   	ret
 57c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000580 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	57                   	push   %edi
 584:	8b 45 10             	mov    0x10(%ebp),%eax
 587:	8b 55 08             	mov    0x8(%ebp),%edx
 58a:	56                   	push   %esi
 58b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 58e:	85 c0                	test   %eax,%eax
 590:	7e 13                	jle    5a5 <memmove+0x25>
 592:	01 d0                	add    %edx,%eax
  dst = vdst;
 594:	89 d7                	mov    %edx,%edi
 596:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 59d:	00 
 59e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 5a0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 5a1:	39 f8                	cmp    %edi,%eax
 5a3:	75 fb                	jne    5a0 <memmove+0x20>
  return vdst;
}
 5a5:	5e                   	pop    %esi
 5a6:	89 d0                	mov    %edx,%eax
 5a8:	5f                   	pop    %edi
 5a9:	5d                   	pop    %ebp
 5aa:	c3                   	ret

000005ab <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5ab:	b8 01 00 00 00       	mov    $0x1,%eax
 5b0:	cd 40                	int    $0x40
 5b2:	c3                   	ret

000005b3 <exit>:
SYSCALL(exit)
 5b3:	b8 02 00 00 00       	mov    $0x2,%eax
 5b8:	cd 40                	int    $0x40
 5ba:	c3                   	ret

000005bb <wait>:
SYSCALL(wait)
 5bb:	b8 03 00 00 00       	mov    $0x3,%eax
 5c0:	cd 40                	int    $0x40
 5c2:	c3                   	ret

000005c3 <pipe>:
SYSCALL(pipe)
 5c3:	b8 04 00 00 00       	mov    $0x4,%eax
 5c8:	cd 40                	int    $0x40
 5ca:	c3                   	ret

000005cb <read>:
SYSCALL(read)
 5cb:	b8 05 00 00 00       	mov    $0x5,%eax
 5d0:	cd 40                	int    $0x40
 5d2:	c3                   	ret

000005d3 <write>:
SYSCALL(write)
 5d3:	b8 10 00 00 00       	mov    $0x10,%eax
 5d8:	cd 40                	int    $0x40
 5da:	c3                   	ret

000005db <close>:
SYSCALL(close)
 5db:	b8 15 00 00 00       	mov    $0x15,%eax
 5e0:	cd 40                	int    $0x40
 5e2:	c3                   	ret

000005e3 <kill>:
SYSCALL(kill)
 5e3:	b8 06 00 00 00       	mov    $0x6,%eax
 5e8:	cd 40                	int    $0x40
 5ea:	c3                   	ret

000005eb <exec>:
SYSCALL(exec)
 5eb:	b8 07 00 00 00       	mov    $0x7,%eax
 5f0:	cd 40                	int    $0x40
 5f2:	c3                   	ret

000005f3 <open>:
SYSCALL(open)
 5f3:	b8 0f 00 00 00       	mov    $0xf,%eax
 5f8:	cd 40                	int    $0x40
 5fa:	c3                   	ret

000005fb <mknod>:
SYSCALL(mknod)
 5fb:	b8 11 00 00 00       	mov    $0x11,%eax
 600:	cd 40                	int    $0x40
 602:	c3                   	ret

00000603 <unlink>:
SYSCALL(unlink)
 603:	b8 12 00 00 00       	mov    $0x12,%eax
 608:	cd 40                	int    $0x40
 60a:	c3                   	ret

0000060b <fstat>:
SYSCALL(fstat)
 60b:	b8 08 00 00 00       	mov    $0x8,%eax
 610:	cd 40                	int    $0x40
 612:	c3                   	ret

00000613 <link>:
SYSCALL(link)
 613:	b8 13 00 00 00       	mov    $0x13,%eax
 618:	cd 40                	int    $0x40
 61a:	c3                   	ret

0000061b <mkdir>:
SYSCALL(mkdir)
 61b:	b8 14 00 00 00       	mov    $0x14,%eax
 620:	cd 40                	int    $0x40
 622:	c3                   	ret

00000623 <chdir>:
SYSCALL(chdir)
 623:	b8 09 00 00 00       	mov    $0x9,%eax
 628:	cd 40                	int    $0x40
 62a:	c3                   	ret

0000062b <dup>:
SYSCALL(dup)
 62b:	b8 0a 00 00 00       	mov    $0xa,%eax
 630:	cd 40                	int    $0x40
 632:	c3                   	ret

00000633 <getpid>:
SYSCALL(getpid)
 633:	b8 0b 00 00 00       	mov    $0xb,%eax
 638:	cd 40                	int    $0x40
 63a:	c3                   	ret

0000063b <sbrk>:
SYSCALL(sbrk)
 63b:	b8 0c 00 00 00       	mov    $0xc,%eax
 640:	cd 40                	int    $0x40
 642:	c3                   	ret

00000643 <sleep>:
SYSCALL(sleep)
 643:	b8 0d 00 00 00       	mov    $0xd,%eax
 648:	cd 40                	int    $0x40
 64a:	c3                   	ret

0000064b <uptime>:
SYSCALL(uptime)
 64b:	b8 0e 00 00 00       	mov    $0xe,%eax
 650:	cd 40                	int    $0x40
 652:	c3                   	ret

00000653 <create_palindrome>:
SYSCALL(create_palindrome)
 653:	b8 16 00 00 00       	mov    $0x16,%eax
 658:	cd 40                	int    $0x40
 65a:	c3                   	ret

0000065b <sort_syscalls>:
SYSCALL(sort_syscalls)
 65b:	b8 17 00 00 00       	mov    $0x17,%eax
 660:	cd 40                	int    $0x40
 662:	c3                   	ret

00000663 <get_most_invoked_syscall>:
SYSCALL(get_most_invoked_syscall)
 663:	b8 18 00 00 00       	mov    $0x18,%eax
 668:	cd 40                	int    $0x40
 66a:	c3                   	ret

0000066b <list_all_processes>:
SYSCALL(list_all_processes)
 66b:	b8 19 00 00 00       	mov    $0x19,%eax
 670:	cd 40                	int    $0x40
 672:	c3                   	ret

00000673 <move_file>:
SYSCALL(move_file)
 673:	b8 1a 00 00 00       	mov    $0x1a,%eax
 678:	cd 40                	int    $0x40
 67a:	c3                   	ret

0000067b <open_sharedmem>:
SYSCALL(open_sharedmem)
 67b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 680:	cd 40                	int    $0x40
 682:	c3                   	ret

00000683 <close_sharedmem>:
 683:	b8 1c 00 00 00       	mov    $0x1c,%eax
 688:	cd 40                	int    $0x40
 68a:	c3                   	ret
 68b:	66 90                	xchg   %ax,%ax
 68d:	66 90                	xchg   %ax,%ax
 68f:	90                   	nop

00000690 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 690:	55                   	push   %ebp
 691:	89 e5                	mov    %esp,%ebp
 693:	57                   	push   %edi
 694:	56                   	push   %esi
 695:	53                   	push   %ebx
 696:	83 ec 3c             	sub    $0x3c,%esp
 699:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 69c:	89 d1                	mov    %edx,%ecx
{
 69e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 6a1:	85 d2                	test   %edx,%edx
 6a3:	0f 89 7f 00 00 00    	jns    728 <printint+0x98>
 6a9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 6ad:	74 79                	je     728 <printint+0x98>
    neg = 1;
 6af:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 6b6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 6b8:	31 db                	xor    %ebx,%ebx
 6ba:	8d 75 d7             	lea    -0x29(%ebp),%esi
 6bd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 6c0:	89 c8                	mov    %ecx,%eax
 6c2:	31 d2                	xor    %edx,%edx
 6c4:	89 cf                	mov    %ecx,%edi
 6c6:	f7 75 c4             	divl   -0x3c(%ebp)
 6c9:	0f b6 92 e8 0a 00 00 	movzbl 0xae8(%edx),%edx
 6d0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 6d3:	89 d8                	mov    %ebx,%eax
 6d5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 6d8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 6db:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 6de:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 6e1:	76 dd                	jbe    6c0 <printint+0x30>
  if(neg)
 6e3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 6e6:	85 c9                	test   %ecx,%ecx
 6e8:	74 0c                	je     6f6 <printint+0x66>
    buf[i++] = '-';
 6ea:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 6ef:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 6f1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 6f6:	8b 7d b8             	mov    -0x48(%ebp),%edi
 6f9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 6fd:	eb 07                	jmp    706 <printint+0x76>
 6ff:	90                   	nop
    putc(fd, buf[i]);
 700:	0f b6 13             	movzbl (%ebx),%edx
 703:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 706:	83 ec 04             	sub    $0x4,%esp
 709:	88 55 d7             	mov    %dl,-0x29(%ebp)
 70c:	6a 01                	push   $0x1
 70e:	56                   	push   %esi
 70f:	57                   	push   %edi
 710:	e8 be fe ff ff       	call   5d3 <write>
  while(--i >= 0)
 715:	83 c4 10             	add    $0x10,%esp
 718:	39 de                	cmp    %ebx,%esi
 71a:	75 e4                	jne    700 <printint+0x70>
}
 71c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 71f:	5b                   	pop    %ebx
 720:	5e                   	pop    %esi
 721:	5f                   	pop    %edi
 722:	5d                   	pop    %ebp
 723:	c3                   	ret
 724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 728:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 72f:	eb 87                	jmp    6b8 <printint+0x28>
 731:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 738:	00 
 739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000740 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 740:	55                   	push   %ebp
 741:	89 e5                	mov    %esp,%ebp
 743:	57                   	push   %edi
 744:	56                   	push   %esi
 745:	53                   	push   %ebx
 746:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 749:	8b 75 0c             	mov    0xc(%ebp),%esi
 74c:	0f b6 1e             	movzbl (%esi),%ebx
 74f:	84 db                	test   %bl,%bl
 751:	0f 84 b8 00 00 00    	je     80f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 757:	8d 45 10             	lea    0x10(%ebp),%eax
 75a:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 75d:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 760:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 762:	89 45 d0             	mov    %eax,-0x30(%ebp)
 765:	eb 37                	jmp    79e <printf+0x5e>
 767:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 76e:	00 
 76f:	90                   	nop
 770:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 773:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 778:	83 f8 25             	cmp    $0x25,%eax
 77b:	74 17                	je     794 <printf+0x54>
  write(fd, &c, 1);
 77d:	83 ec 04             	sub    $0x4,%esp
 780:	88 5d e7             	mov    %bl,-0x19(%ebp)
 783:	6a 01                	push   $0x1
 785:	57                   	push   %edi
 786:	ff 75 08             	push   0x8(%ebp)
 789:	e8 45 fe ff ff       	call   5d3 <write>
 78e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 791:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 794:	0f b6 1e             	movzbl (%esi),%ebx
 797:	83 c6 01             	add    $0x1,%esi
 79a:	84 db                	test   %bl,%bl
 79c:	74 71                	je     80f <printf+0xcf>
    c = fmt[i] & 0xff;
 79e:	0f be cb             	movsbl %bl,%ecx
 7a1:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 7a4:	85 d2                	test   %edx,%edx
 7a6:	74 c8                	je     770 <printf+0x30>
      }
    } else if(state == '%'){
 7a8:	83 fa 25             	cmp    $0x25,%edx
 7ab:	75 e7                	jne    794 <printf+0x54>
      if(c == 'd'){
 7ad:	83 f8 64             	cmp    $0x64,%eax
 7b0:	0f 84 9a 00 00 00    	je     850 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 7b6:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 7bc:	83 f9 70             	cmp    $0x70,%ecx
 7bf:	74 5f                	je     820 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 7c1:	83 f8 73             	cmp    $0x73,%eax
 7c4:	0f 84 d6 00 00 00    	je     8a0 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7ca:	83 f8 63             	cmp    $0x63,%eax
 7cd:	0f 84 8d 00 00 00    	je     860 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 7d3:	83 f8 25             	cmp    $0x25,%eax
 7d6:	0f 84 b4 00 00 00    	je     890 <printf+0x150>
  write(fd, &c, 1);
 7dc:	83 ec 04             	sub    $0x4,%esp
 7df:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 7e3:	6a 01                	push   $0x1
 7e5:	57                   	push   %edi
 7e6:	ff 75 08             	push   0x8(%ebp)
 7e9:	e8 e5 fd ff ff       	call   5d3 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 7ee:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 7f1:	83 c4 0c             	add    $0xc,%esp
 7f4:	6a 01                	push   $0x1
  for(i = 0; fmt[i]; i++){
 7f6:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 7f9:	57                   	push   %edi
 7fa:	ff 75 08             	push   0x8(%ebp)
 7fd:	e8 d1 fd ff ff       	call   5d3 <write>
  for(i = 0; fmt[i]; i++){
 802:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 806:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 809:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 80b:	84 db                	test   %bl,%bl
 80d:	75 8f                	jne    79e <printf+0x5e>
    }
  }
}
 80f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 812:	5b                   	pop    %ebx
 813:	5e                   	pop    %esi
 814:	5f                   	pop    %edi
 815:	5d                   	pop    %ebp
 816:	c3                   	ret
 817:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 81e:	00 
 81f:	90                   	nop
        printint(fd, *ap, 16, 0);
 820:	83 ec 0c             	sub    $0xc,%esp
 823:	b9 10 00 00 00       	mov    $0x10,%ecx
 828:	6a 00                	push   $0x0
 82a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 82d:	8b 45 08             	mov    0x8(%ebp),%eax
 830:	8b 13                	mov    (%ebx),%edx
 832:	e8 59 fe ff ff       	call   690 <printint>
        ap++;
 837:	89 d8                	mov    %ebx,%eax
 839:	83 c4 10             	add    $0x10,%esp
      state = 0;
 83c:	31 d2                	xor    %edx,%edx
        ap++;
 83e:	83 c0 04             	add    $0x4,%eax
 841:	89 45 d0             	mov    %eax,-0x30(%ebp)
 844:	e9 4b ff ff ff       	jmp    794 <printf+0x54>
 849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 850:	83 ec 0c             	sub    $0xc,%esp
 853:	b9 0a 00 00 00       	mov    $0xa,%ecx
 858:	6a 01                	push   $0x1
 85a:	eb ce                	jmp    82a <printf+0xea>
 85c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 860:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 863:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 866:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 868:	6a 01                	push   $0x1
        ap++;
 86a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 86d:	57                   	push   %edi
 86e:	ff 75 08             	push   0x8(%ebp)
        putc(fd, *ap);
 871:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 874:	e8 5a fd ff ff       	call   5d3 <write>
        ap++;
 879:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 87c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 87f:	31 d2                	xor    %edx,%edx
 881:	e9 0e ff ff ff       	jmp    794 <printf+0x54>
 886:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 88d:	00 
 88e:	66 90                	xchg   %ax,%ax
        putc(fd, c);
 890:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 893:	83 ec 04             	sub    $0x4,%esp
 896:	e9 59 ff ff ff       	jmp    7f4 <printf+0xb4>
 89b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 8a0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 8a3:	8b 18                	mov    (%eax),%ebx
        ap++;
 8a5:	83 c0 04             	add    $0x4,%eax
 8a8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 8ab:	85 db                	test   %ebx,%ebx
 8ad:	74 17                	je     8c6 <printf+0x186>
        while(*s != 0){
 8af:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 8b2:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 8b4:	84 c0                	test   %al,%al
 8b6:	0f 84 d8 fe ff ff    	je     794 <printf+0x54>
 8bc:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 8bf:	89 de                	mov    %ebx,%esi
 8c1:	8b 5d 08             	mov    0x8(%ebp),%ebx
 8c4:	eb 1a                	jmp    8e0 <printf+0x1a0>
          s = "(null)";
 8c6:	bb de 0a 00 00       	mov    $0xade,%ebx
        while(*s != 0){
 8cb:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 8ce:	b8 28 00 00 00       	mov    $0x28,%eax
 8d3:	89 de                	mov    %ebx,%esi
 8d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 8d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 8df:	00 
  write(fd, &c, 1);
 8e0:	83 ec 04             	sub    $0x4,%esp
          s++;
 8e3:	83 c6 01             	add    $0x1,%esi
 8e6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 8e9:	6a 01                	push   $0x1
 8eb:	57                   	push   %edi
 8ec:	53                   	push   %ebx
 8ed:	e8 e1 fc ff ff       	call   5d3 <write>
        while(*s != 0){
 8f2:	0f b6 06             	movzbl (%esi),%eax
 8f5:	83 c4 10             	add    $0x10,%esp
 8f8:	84 c0                	test   %al,%al
 8fa:	75 e4                	jne    8e0 <printf+0x1a0>
      state = 0;
 8fc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 8ff:	31 d2                	xor    %edx,%edx
 901:	e9 8e fe ff ff       	jmp    794 <printf+0x54>
 906:	66 90                	xchg   %ax,%ax
 908:	66 90                	xchg   %ax,%ax
 90a:	66 90                	xchg   %ax,%ax
 90c:	66 90                	xchg   %ax,%ax
 90e:	66 90                	xchg   %ax,%ax

00000910 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 910:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 911:	a1 a0 12 00 00       	mov    0x12a0,%eax
{
 916:	89 e5                	mov    %esp,%ebp
 918:	57                   	push   %edi
 919:	56                   	push   %esi
 91a:	53                   	push   %ebx
 91b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 91e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 921:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 928:	89 c2                	mov    %eax,%edx
 92a:	8b 00                	mov    (%eax),%eax
 92c:	39 ca                	cmp    %ecx,%edx
 92e:	73 30                	jae    960 <free+0x50>
 930:	39 c1                	cmp    %eax,%ecx
 932:	72 04                	jb     938 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 934:	39 c2                	cmp    %eax,%edx
 936:	72 f0                	jb     928 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 938:	8b 73 fc             	mov    -0x4(%ebx),%esi
 93b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 93e:	39 f8                	cmp    %edi,%eax
 940:	74 30                	je     972 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 942:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 945:	8b 42 04             	mov    0x4(%edx),%eax
 948:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 94b:	39 f1                	cmp    %esi,%ecx
 94d:	74 3a                	je     989 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 94f:	89 0a                	mov    %ecx,(%edx)
  freep = p;
}
 951:	5b                   	pop    %ebx
  freep = p;
 952:	89 15 a0 12 00 00    	mov    %edx,0x12a0
}
 958:	5e                   	pop    %esi
 959:	5f                   	pop    %edi
 95a:	5d                   	pop    %ebp
 95b:	c3                   	ret
 95c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 960:	39 c2                	cmp    %eax,%edx
 962:	72 c4                	jb     928 <free+0x18>
 964:	39 c1                	cmp    %eax,%ecx
 966:	73 c0                	jae    928 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 968:	8b 73 fc             	mov    -0x4(%ebx),%esi
 96b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 96e:	39 f8                	cmp    %edi,%eax
 970:	75 d0                	jne    942 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 972:	03 70 04             	add    0x4(%eax),%esi
 975:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 978:	8b 02                	mov    (%edx),%eax
 97a:	8b 00                	mov    (%eax),%eax
 97c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 97f:	8b 42 04             	mov    0x4(%edx),%eax
 982:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 985:	39 f1                	cmp    %esi,%ecx
 987:	75 c6                	jne    94f <free+0x3f>
    p->s.size += bp->s.size;
 989:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 98c:	89 15 a0 12 00 00    	mov    %edx,0x12a0
    p->s.size += bp->s.size;
 992:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 995:	8b 43 f8             	mov    -0x8(%ebx),%eax
 998:	89 02                	mov    %eax,(%edx)
}
 99a:	5b                   	pop    %ebx
 99b:	5e                   	pop    %esi
 99c:	5f                   	pop    %edi
 99d:	5d                   	pop    %ebp
 99e:	c3                   	ret
 99f:	90                   	nop

000009a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9a0:	55                   	push   %ebp
 9a1:	89 e5                	mov    %esp,%ebp
 9a3:	57                   	push   %edi
 9a4:	56                   	push   %esi
 9a5:	53                   	push   %ebx
 9a6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9a9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 9ac:	8b 3d a0 12 00 00    	mov    0x12a0,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9b2:	8d 70 07             	lea    0x7(%eax),%esi
 9b5:	c1 ee 03             	shr    $0x3,%esi
 9b8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 9bb:	85 ff                	test   %edi,%edi
 9bd:	0f 84 ad 00 00 00    	je     a70 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9c3:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 9c5:	8b 48 04             	mov    0x4(%eax),%ecx
 9c8:	39 f1                	cmp    %esi,%ecx
 9ca:	73 71                	jae    a3d <malloc+0x9d>
 9cc:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 9d2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 9d7:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 9da:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 9e1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 9e4:	eb 1b                	jmp    a01 <malloc+0x61>
 9e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 9ed:	00 
 9ee:	66 90                	xchg   %ax,%ax
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9f0:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 9f2:	8b 4a 04             	mov    0x4(%edx),%ecx
 9f5:	39 f1                	cmp    %esi,%ecx
 9f7:	73 4f                	jae    a48 <malloc+0xa8>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9f9:	8b 3d a0 12 00 00    	mov    0x12a0,%edi
 9ff:	89 d0                	mov    %edx,%eax
 a01:	39 c7                	cmp    %eax,%edi
 a03:	75 eb                	jne    9f0 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 a05:	83 ec 0c             	sub    $0xc,%esp
 a08:	ff 75 e4             	push   -0x1c(%ebp)
 a0b:	e8 2b fc ff ff       	call   63b <sbrk>
  if(p == (char*)-1)
 a10:	83 c4 10             	add    $0x10,%esp
 a13:	83 f8 ff             	cmp    $0xffffffff,%eax
 a16:	74 1b                	je     a33 <malloc+0x93>
  hp->s.size = nu;
 a18:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 a1b:	83 ec 0c             	sub    $0xc,%esp
 a1e:	83 c0 08             	add    $0x8,%eax
 a21:	50                   	push   %eax
 a22:	e8 e9 fe ff ff       	call   910 <free>
  return freep;
 a27:	a1 a0 12 00 00       	mov    0x12a0,%eax
      if((p = morecore(nunits)) == 0)
 a2c:	83 c4 10             	add    $0x10,%esp
 a2f:	85 c0                	test   %eax,%eax
 a31:	75 bd                	jne    9f0 <malloc+0x50>
        return 0;
  }
}
 a33:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 a36:	31 c0                	xor    %eax,%eax
}
 a38:	5b                   	pop    %ebx
 a39:	5e                   	pop    %esi
 a3a:	5f                   	pop    %edi
 a3b:	5d                   	pop    %ebp
 a3c:	c3                   	ret
    if(p->s.size >= nunits){
 a3d:	89 c2                	mov    %eax,%edx
 a3f:	89 f8                	mov    %edi,%eax
 a41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 a48:	39 ce                	cmp    %ecx,%esi
 a4a:	74 54                	je     aa0 <malloc+0x100>
        p->s.size -= nunits;
 a4c:	29 f1                	sub    %esi,%ecx
 a4e:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 a51:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 a54:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 a57:	a3 a0 12 00 00       	mov    %eax,0x12a0
}
 a5c:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 a5f:	8d 42 08             	lea    0x8(%edx),%eax
}
 a62:	5b                   	pop    %ebx
 a63:	5e                   	pop    %esi
 a64:	5f                   	pop    %edi
 a65:	5d                   	pop    %ebp
 a66:	c3                   	ret
 a67:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 a6e:	00 
 a6f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 a70:	c7 05 a0 12 00 00 a4 	movl   $0x12a4,0x12a0
 a77:	12 00 00 
    base.s.size = 0;
 a7a:	bf a4 12 00 00       	mov    $0x12a4,%edi
    base.s.ptr = freep = prevp = &base;
 a7f:	c7 05 a4 12 00 00 a4 	movl   $0x12a4,0x12a4
 a86:	12 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a89:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 a8b:	c7 05 a8 12 00 00 00 	movl   $0x0,0x12a8
 a92:	00 00 00 
    if(p->s.size >= nunits){
 a95:	e9 32 ff ff ff       	jmp    9cc <malloc+0x2c>
 a9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 aa0:	8b 0a                	mov    (%edx),%ecx
 aa2:	89 08                	mov    %ecx,(%eax)
 aa4:	eb b1                	jmp    a57 <malloc+0xb7>
