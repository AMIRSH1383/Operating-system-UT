
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return 0;
}

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
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
       f:	eb 10                	jmp    21 <main+0x21>
      11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(fd >= 3){
      18:	83 f8 02             	cmp    $0x2,%eax
      1b:	0f 8f 82 01 00 00    	jg     1a3 <main+0x1a3>
  while((fd = open("console", O_RDWR)) >= 0){
      21:	83 ec 08             	sub    $0x8,%esp
      24:	6a 02                	push   $0x2
      26:	68 71 14 00 00       	push   $0x1471
      2b:	e8 13 0f 00 00       	call   f43 <open>
      30:	83 c4 10             	add    $0x10,%esp
      33:	85 c0                	test   %eax,%eax
      35:	79 e1                	jns    18 <main+0x18>
      37:	eb 6e                	jmp    a7 <main+0xa7>
      39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(2, "cannot cd %s\n", buf+3);
      continue;
    }
    if(strcmp(buf,HISTORY_WITH_SPACE) != 0)
    {
      if(num_of_commands == MAX_NUM_OF_HISTORY)
      40:	83 3d 20 1b 00 00 0a 	cmpl   $0xa,0x1b20
      47:	0f 84 21 01 00 00    	je     16e <main+0x16e>
{
      4d:	31 db                	xor    %ebx,%ebx
      4f:	eb 20                	jmp    71 <main+0x71>
      51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        }  
        num_of_commands--;
      }
      for(int i = 0; i<strlen(buf);i++)
      {
        history_of_commands[num_of_commands][i]=buf[i];
      58:	a1 20 1b 00 00       	mov    0x1b20,%eax
      5d:	0f b6 93 40 20 00 00 	movzbl 0x2040(%ebx),%edx
      64:	c1 e0 07             	shl    $0x7,%eax
      67:	88 94 03 40 1b 00 00 	mov    %dl,0x1b40(%ebx,%eax,1)
      for(int i = 0; i<strlen(buf);i++)
      6e:	83 c3 01             	add    $0x1,%ebx
      71:	83 ec 0c             	sub    $0xc,%esp
      74:	68 40 20 00 00       	push   $0x2040
      79:	e8 c2 0c 00 00       	call   d40 <strlen>
      7e:	83 c4 10             	add    $0x10,%esp
      81:	39 d8                	cmp    %ebx,%eax
      83:	77 d3                	ja     58 <main+0x58>
      }
      num_of_commands++;
      85:	83 05 20 1b 00 00 01 	addl   $0x1,0x1b20
int
fork1(void)
{
  int pid;

  pid = fork();
      8c:	e8 6a 0e 00 00       	call   efb <fork>
  if(pid == -1)
      91:	83 f8 ff             	cmp    $0xffffffff,%eax
      94:	0f 84 34 01 00 00    	je     1ce <main+0x1ce>
    if(fork1() == 0)
      9a:	85 c0                	test   %eax,%eax
      9c:	0f 84 12 01 00 00    	je     1b4 <main+0x1b4>
    wait();
      a2:	e8 64 0e 00 00       	call   f0b <wait>
  printf(2, "$ ");
      a7:	83 ec 08             	sub    $0x8,%esp
      aa:	68 c8 13 00 00       	push   $0x13c8
      af:	6a 02                	push   $0x2
      b1:	e8 ea 0f 00 00       	call   10a0 <printf>
  memset(buf, 0, nbuf);
      b6:	83 c4 0c             	add    $0xc,%esp
      b9:	6a 64                	push   $0x64
      bb:	6a 00                	push   $0x0
      bd:	68 40 20 00 00       	push   $0x2040
      c2:	e8 a9 0c 00 00       	call   d70 <memset>
  gets(buf, nbuf);
      c7:	58                   	pop    %eax
      c8:	5a                   	pop    %edx
      c9:	6a 64                	push   $0x64
      cb:	68 40 20 00 00       	push   $0x2040
      d0:	e8 fb 0c 00 00       	call   dd0 <gets>
  if(buf[0] == 0) // EOF
      d5:	0f b6 05 40 20 00 00 	movzbl 0x2040,%eax
      dc:	83 c4 10             	add    $0x10,%esp
      df:	84 c0                	test   %al,%al
      e1:	0f 84 e2 00 00 00    	je     1c9 <main+0x1c9>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      e7:	3c 63                	cmp    $0x63,%al
      e9:	75 09                	jne    f4 <main+0xf4>
      eb:	80 3d 41 20 00 00 64 	cmpb   $0x64,0x2041
      f2:	74 2c                	je     120 <main+0x120>
    if(strcmp(buf,HISTORY_WITH_SPACE) != 0)
      f4:	83 ec 08             	sub    $0x8,%esp
      f7:	68 87 14 00 00       	push   $0x1487
      fc:	68 40 20 00 00       	push   $0x2040
     101:	e8 da 0b 00 00       	call   ce0 <strcmp>
     106:	83 c4 10             	add    $0x10,%esp
     109:	85 c0                	test   %eax,%eax
     10b:	0f 84 7b ff ff ff    	je     8c <main+0x8c>
     111:	e9 2a ff ff ff       	jmp    40 <main+0x40>
     116:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     11d:	8d 76 00             	lea    0x0(%esi),%esi
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     120:	80 3d 42 20 00 00 20 	cmpb   $0x20,0x2042
     127:	75 cb                	jne    f4 <main+0xf4>
      buf[strlen(buf)-1] = 0;  // chop \n
     129:	83 ec 0c             	sub    $0xc,%esp
     12c:	68 40 20 00 00       	push   $0x2040
     131:	e8 0a 0c 00 00       	call   d40 <strlen>
      if(chdir(buf+3) < 0)
     136:	c7 04 24 43 20 00 00 	movl   $0x2043,(%esp)
      buf[strlen(buf)-1] = 0;  // chop \n
     13d:	c6 80 3f 20 00 00 00 	movb   $0x0,0x203f(%eax)
      if(chdir(buf+3) < 0)
     144:	e8 2a 0e 00 00       	call   f73 <chdir>
     149:	83 c4 10             	add    $0x10,%esp
     14c:	85 c0                	test   %eax,%eax
     14e:	0f 89 53 ff ff ff    	jns    a7 <main+0xa7>
        printf(2, "cannot cd %s\n", buf+3);
     154:	51                   	push   %ecx
     155:	68 43 20 00 00       	push   $0x2043
     15a:	68 79 14 00 00       	push   $0x1479
     15f:	6a 02                	push   $0x2
     161:	e8 3a 0f 00 00       	call   10a0 <printf>
     166:	83 c4 10             	add    $0x10,%esp
     169:	e9 39 ff ff ff       	jmp    a7 <main+0xa7>
     16e:	bb 40 1b 00 00       	mov    $0x1b40,%ebx
     173:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     177:	90                   	nop
          memmove(history_of_commands[i], history_of_commands[i+1], sizeof(char)* MAX_LEN_OF_COMMAND);
     178:	83 ec 04             	sub    $0x4,%esp
     17b:	89 d8                	mov    %ebx,%eax
     17d:	83 eb 80             	sub    $0xffffff80,%ebx
     180:	68 80 00 00 00       	push   $0x80
     185:	53                   	push   %ebx
     186:	50                   	push   %eax
     187:	e8 44 0d 00 00       	call   ed0 <memmove>
        for(int i = 0; i < MAX_NUM_OF_HISTORY - 1; i++)
     18c:	83 c4 10             	add    $0x10,%esp
     18f:	81 fb c0 1f 00 00    	cmp    $0x1fc0,%ebx
     195:	75 e1                	jne    178 <main+0x178>
        num_of_commands--;
     197:	83 2d 20 1b 00 00 01 	subl   $0x1,0x1b20
     19e:	e9 aa fe ff ff       	jmp    4d <main+0x4d>
      close(fd);
     1a3:	83 ec 0c             	sub    $0xc,%esp
     1a6:	50                   	push   %eax
     1a7:	e8 7f 0d 00 00       	call   f2b <close>
      break;
     1ac:	83 c4 10             	add    $0x10,%esp
     1af:	e9 f3 fe ff ff       	jmp    a7 <main+0xa7>
      runcmd(parsecmd(buf));
     1b4:	83 ec 0c             	sub    $0xc,%esp
     1b7:	68 40 20 00 00       	push   $0x2040
     1bc:	e8 7f 0a 00 00       	call   c40 <parsecmd>
     1c1:	89 04 24             	mov    %eax,(%esp)
     1c4:	e8 97 00 00 00       	call   260 <runcmd>
  exit();
     1c9:	e8 35 0d 00 00       	call   f03 <exit>
    panic("fork");
     1ce:	83 ec 0c             	sub    $0xc,%esp
     1d1:	68 cb 13 00 00       	push   $0x13cb
     1d6:	e8 45 00 00 00       	call   220 <panic>
     1db:	66 90                	xchg   %ax,%ax
     1dd:	66 90                	xchg   %ax,%ax
     1df:	90                   	nop

000001e0 <getcmd>:
{
     1e0:	55                   	push   %ebp
     1e1:	89 e5                	mov    %esp,%ebp
     1e3:	56                   	push   %esi
     1e4:	53                   	push   %ebx
     1e5:	8b 75 0c             	mov    0xc(%ebp),%esi
     1e8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  printf(2, "$ ");
     1eb:	83 ec 08             	sub    $0x8,%esp
     1ee:	68 c8 13 00 00       	push   $0x13c8
     1f3:	6a 02                	push   $0x2
     1f5:	e8 a6 0e 00 00       	call   10a0 <printf>
  memset(buf, 0, nbuf);
     1fa:	83 c4 0c             	add    $0xc,%esp
     1fd:	56                   	push   %esi
     1fe:	6a 00                	push   $0x0
     200:	53                   	push   %ebx
     201:	e8 6a 0b 00 00       	call   d70 <memset>
  gets(buf, nbuf);
     206:	58                   	pop    %eax
     207:	5a                   	pop    %edx
     208:	56                   	push   %esi
     209:	53                   	push   %ebx
     20a:	e8 c1 0b 00 00       	call   dd0 <gets>
  if(buf[0] == 0) // EOF
     20f:	83 c4 10             	add    $0x10,%esp
     212:	80 3b 01             	cmpb   $0x1,(%ebx)
     215:	19 c0                	sbb    %eax,%eax
}
     217:	8d 65 f8             	lea    -0x8(%ebp),%esp
     21a:	5b                   	pop    %ebx
     21b:	5e                   	pop    %esi
     21c:	5d                   	pop    %ebp
     21d:	c3                   	ret    
     21e:	66 90                	xchg   %ax,%ax

00000220 <panic>:
{
     220:	55                   	push   %ebp
     221:	89 e5                	mov    %esp,%ebp
     223:	83 ec 0c             	sub    $0xc,%esp
  printf(2, "%s\n", s);
     226:	ff 75 08             	push   0x8(%ebp)
     229:	68 6d 14 00 00       	push   $0x146d
     22e:	6a 02                	push   $0x2
     230:	e8 6b 0e 00 00       	call   10a0 <printf>
  exit();
     235:	e8 c9 0c 00 00       	call   f03 <exit>
     23a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000240 <fork1>:
{
     240:	55                   	push   %ebp
     241:	89 e5                	mov    %esp,%ebp
     243:	83 ec 08             	sub    $0x8,%esp
  pid = fork();
     246:	e8 b0 0c 00 00       	call   efb <fork>
  if(pid == -1)
     24b:	83 f8 ff             	cmp    $0xffffffff,%eax
     24e:	74 02                	je     252 <fork1+0x12>
  return pid;
}
     250:	c9                   	leave  
     251:	c3                   	ret    
    panic("fork");
     252:	83 ec 0c             	sub    $0xc,%esp
     255:	68 cb 13 00 00       	push   $0x13cb
     25a:	e8 c1 ff ff ff       	call   220 <panic>
     25f:	90                   	nop

00000260 <runcmd>:
{
     260:	55                   	push   %ebp
     261:	89 e5                	mov    %esp,%ebp
     263:	53                   	push   %ebx
     264:	83 ec 14             	sub    $0x14,%esp
     267:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(cmd == 0)
     26a:	85 db                	test   %ebx,%ebx
     26c:	74 5a                	je     2c8 <runcmd+0x68>
  switch(cmd->type){
     26e:	83 3b 05             	cmpl   $0x5,(%ebx)
     271:	0f 87 f8 00 00 00    	ja     36f <runcmd+0x10f>
     277:	8b 03                	mov    (%ebx),%eax
     279:	ff 24 85 90 14 00 00 	jmp    *0x1490(,%eax,4)
    if(ecmd->argv[0] == 0)
     280:	8b 43 04             	mov    0x4(%ebx),%eax
     283:	85 c0                	test   %eax,%eax
     285:	74 41                	je     2c8 <runcmd+0x68>
    if(strcmp(ecmd->argv[0],HISTORY)==0)
     287:	52                   	push   %edx
     288:	52                   	push   %edx
     289:	68 d7 13 00 00       	push   $0x13d7
     28e:	50                   	push   %eax
     28f:	e8 4c 0a 00 00       	call   ce0 <strcmp>
     294:	83 c4 10             	add    $0x10,%esp
     297:	85 c0                	test   %eax,%eax
     299:	0f 84 ff 00 00 00    	je     39e <runcmd+0x13e>
    exec(ecmd->argv[0], ecmd->argv);
     29f:	8d 43 04             	lea    0x4(%ebx),%eax
     2a2:	51                   	push   %ecx
     2a3:	51                   	push   %ecx
     2a4:	50                   	push   %eax
     2a5:	ff 73 04             	push   0x4(%ebx)
     2a8:	e8 8e 0c 00 00       	call   f3b <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     2ad:	83 c4 0c             	add    $0xc,%esp
     2b0:	ff 73 04             	push   0x4(%ebx)
     2b3:	68 df 13 00 00       	push   $0x13df
     2b8:	6a 02                	push   $0x2
     2ba:	e8 e1 0d 00 00       	call   10a0 <printf>
    break;
     2bf:	83 c4 10             	add    $0x10,%esp
     2c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
     2c8:	e8 36 0c 00 00       	call   f03 <exit>
    if(fork1() == 0)
     2cd:	e8 6e ff ff ff       	call   240 <fork1>
     2d2:	85 c0                	test   %eax,%eax
     2d4:	75 f2                	jne    2c8 <runcmd+0x68>
     2d6:	eb 73                	jmp    34b <runcmd+0xeb>
    if(pipe(p) < 0)
     2d8:	83 ec 0c             	sub    $0xc,%esp
     2db:	8d 45 f0             	lea    -0x10(%ebp),%eax
     2de:	50                   	push   %eax
     2df:	e8 2f 0c 00 00       	call   f13 <pipe>
     2e4:	83 c4 10             	add    $0x10,%esp
     2e7:	85 c0                	test   %eax,%eax
     2e9:	0f 88 a2 00 00 00    	js     391 <runcmd+0x131>
    if(fork1() == 0){
     2ef:	e8 4c ff ff ff       	call   240 <fork1>
     2f4:	85 c0                	test   %eax,%eax
     2f6:	0f 84 f5 00 00 00    	je     3f1 <runcmd+0x191>
    if(fork1() == 0){
     2fc:	e8 3f ff ff ff       	call   240 <fork1>
     301:	85 c0                	test   %eax,%eax
     303:	0f 84 ba 00 00 00    	je     3c3 <runcmd+0x163>
    close(p[0]);
     309:	83 ec 0c             	sub    $0xc,%esp
     30c:	ff 75 f0             	push   -0x10(%ebp)
     30f:	e8 17 0c 00 00       	call   f2b <close>
    close(p[1]);
     314:	58                   	pop    %eax
     315:	ff 75 f4             	push   -0xc(%ebp)
     318:	e8 0e 0c 00 00       	call   f2b <close>
    wait();
     31d:	e8 e9 0b 00 00       	call   f0b <wait>
    wait();
     322:	e8 e4 0b 00 00       	call   f0b <wait>
    break;
     327:	83 c4 10             	add    $0x10,%esp
     32a:	eb 9c                	jmp    2c8 <runcmd+0x68>
    close(rcmd->fd);
     32c:	83 ec 0c             	sub    $0xc,%esp
     32f:	ff 73 14             	push   0x14(%ebx)
     332:	e8 f4 0b 00 00       	call   f2b <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     337:	58                   	pop    %eax
     338:	5a                   	pop    %edx
     339:	ff 73 10             	push   0x10(%ebx)
     33c:	ff 73 08             	push   0x8(%ebx)
     33f:	e8 ff 0b 00 00       	call   f43 <open>
     344:	83 c4 10             	add    $0x10,%esp
     347:	85 c0                	test   %eax,%eax
     349:	78 31                	js     37c <runcmd+0x11c>
      runcmd(bcmd->cmd);
     34b:	83 ec 0c             	sub    $0xc,%esp
     34e:	ff 73 04             	push   0x4(%ebx)
     351:	e8 0a ff ff ff       	call   260 <runcmd>
    if(fork1() == 0)
     356:	e8 e5 fe ff ff       	call   240 <fork1>
     35b:	85 c0                	test   %eax,%eax
     35d:	74 ec                	je     34b <runcmd+0xeb>
    wait();
     35f:	e8 a7 0b 00 00       	call   f0b <wait>
    runcmd(lcmd->right);
     364:	83 ec 0c             	sub    $0xc,%esp
     367:	ff 73 08             	push   0x8(%ebx)
     36a:	e8 f1 fe ff ff       	call   260 <runcmd>
    panic("runcmd");
     36f:	83 ec 0c             	sub    $0xc,%esp
     372:	68 d0 13 00 00       	push   $0x13d0
     377:	e8 a4 fe ff ff       	call   220 <panic>
      printf(2, "open %s failed\n", rcmd->file);
     37c:	51                   	push   %ecx
     37d:	ff 73 08             	push   0x8(%ebx)
     380:	68 ef 13 00 00       	push   $0x13ef
     385:	6a 02                	push   $0x2
     387:	e8 14 0d 00 00       	call   10a0 <printf>
      exit();
     38c:	e8 72 0b 00 00       	call   f03 <exit>
      panic("pipe");
     391:	83 ec 0c             	sub    $0xc,%esp
     394:	68 ff 13 00 00       	push   $0x13ff
     399:	e8 82 fe ff ff       	call   220 <panic>
      for(int i = 0;i<num_of_commands;i++)
     39e:	8b 0d 20 1b 00 00    	mov    0x1b20,%ecx
     3a4:	31 c0                	xor    %eax,%eax
     3a6:	eb 12                	jmp    3ba <runcmd+0x15a>
        ecmd->argv[i+1] = history_of_commands[i];
     3a8:	89 c2                	mov    %eax,%edx
     3aa:	c1 e2 07             	shl    $0x7,%edx
     3ad:	81 c2 40 1b 00 00    	add    $0x1b40,%edx
     3b3:	89 54 83 08          	mov    %edx,0x8(%ebx,%eax,4)
      for(int i = 0;i<num_of_commands;i++)
     3b7:	83 c0 01             	add    $0x1,%eax
     3ba:	39 c1                	cmp    %eax,%ecx
     3bc:	7f ea                	jg     3a8 <runcmd+0x148>
     3be:	e9 dc fe ff ff       	jmp    29f <runcmd+0x3f>
      close(0);
     3c3:	83 ec 0c             	sub    $0xc,%esp
     3c6:	6a 00                	push   $0x0
     3c8:	e8 5e 0b 00 00       	call   f2b <close>
      dup(p[0]);
     3cd:	5a                   	pop    %edx
     3ce:	ff 75 f0             	push   -0x10(%ebp)
     3d1:	e8 a5 0b 00 00       	call   f7b <dup>
      close(p[0]);
     3d6:	59                   	pop    %ecx
     3d7:	ff 75 f0             	push   -0x10(%ebp)
     3da:	e8 4c 0b 00 00       	call   f2b <close>
      close(p[1]);
     3df:	58                   	pop    %eax
     3e0:	ff 75 f4             	push   -0xc(%ebp)
     3e3:	e8 43 0b 00 00       	call   f2b <close>
      runcmd(pcmd->right);
     3e8:	58                   	pop    %eax
     3e9:	ff 73 08             	push   0x8(%ebx)
     3ec:	e8 6f fe ff ff       	call   260 <runcmd>
      close(1);
     3f1:	83 ec 0c             	sub    $0xc,%esp
     3f4:	6a 01                	push   $0x1
     3f6:	e8 30 0b 00 00       	call   f2b <close>
      dup(p[1]);
     3fb:	58                   	pop    %eax
     3fc:	ff 75 f4             	push   -0xc(%ebp)
     3ff:	e8 77 0b 00 00       	call   f7b <dup>
      close(p[0]);
     404:	58                   	pop    %eax
     405:	ff 75 f0             	push   -0x10(%ebp)
     408:	e8 1e 0b 00 00       	call   f2b <close>
      close(p[1]);
     40d:	58                   	pop    %eax
     40e:	ff 75 f4             	push   -0xc(%ebp)
     411:	e8 15 0b 00 00       	call   f2b <close>
      runcmd(pcmd->left);
     416:	5a                   	pop    %edx
     417:	ff 73 04             	push   0x4(%ebx)
     41a:	e8 41 fe ff ff       	call   260 <runcmd>
     41f:	90                   	nop

00000420 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     420:	55                   	push   %ebp
     421:	89 e5                	mov    %esp,%ebp
     423:	53                   	push   %ebx
     424:	83 ec 10             	sub    $0x10,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     427:	68 a4 00 00 00       	push   $0xa4
     42c:	e8 9f 0e 00 00       	call   12d0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     431:	83 c4 0c             	add    $0xc,%esp
     434:	68 a4 00 00 00       	push   $0xa4
  cmd = malloc(sizeof(*cmd));
     439:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     43b:	6a 00                	push   $0x0
     43d:	50                   	push   %eax
     43e:	e8 2d 09 00 00       	call   d70 <memset>
  cmd->type = EXEC;
     443:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
     449:	89 d8                	mov    %ebx,%eax
     44b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     44e:	c9                   	leave  
     44f:	c3                   	ret    

00000450 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     450:	55                   	push   %ebp
     451:	89 e5                	mov    %esp,%ebp
     453:	53                   	push   %ebx
     454:	83 ec 10             	sub    $0x10,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     457:	6a 18                	push   $0x18
     459:	e8 72 0e 00 00       	call   12d0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     45e:	83 c4 0c             	add    $0xc,%esp
     461:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     463:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     465:	6a 00                	push   $0x0
     467:	50                   	push   %eax
     468:	e8 03 09 00 00       	call   d70 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     46d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = REDIR;
     470:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     476:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     479:	8b 45 0c             	mov    0xc(%ebp),%eax
     47c:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     47f:	8b 45 10             	mov    0x10(%ebp),%eax
     482:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     485:	8b 45 14             	mov    0x14(%ebp),%eax
     488:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     48b:	8b 45 18             	mov    0x18(%ebp),%eax
     48e:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     491:	89 d8                	mov    %ebx,%eax
     493:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     496:	c9                   	leave  
     497:	c3                   	ret    
     498:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     49f:	90                   	nop

000004a0 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     4a0:	55                   	push   %ebp
     4a1:	89 e5                	mov    %esp,%ebp
     4a3:	53                   	push   %ebx
     4a4:	83 ec 10             	sub    $0x10,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4a7:	6a 0c                	push   $0xc
     4a9:	e8 22 0e 00 00       	call   12d0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     4ae:	83 c4 0c             	add    $0xc,%esp
     4b1:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     4b3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     4b5:	6a 00                	push   $0x0
     4b7:	50                   	push   %eax
     4b8:	e8 b3 08 00 00       	call   d70 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     4bd:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = PIPE;
     4c0:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     4c6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     4c9:	8b 45 0c             	mov    0xc(%ebp),%eax
     4cc:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     4cf:	89 d8                	mov    %ebx,%eax
     4d1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     4d4:	c9                   	leave  
     4d5:	c3                   	ret    
     4d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     4dd:	8d 76 00             	lea    0x0(%esi),%esi

000004e0 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     4e0:	55                   	push   %ebp
     4e1:	89 e5                	mov    %esp,%ebp
     4e3:	53                   	push   %ebx
     4e4:	83 ec 10             	sub    $0x10,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4e7:	6a 0c                	push   $0xc
     4e9:	e8 e2 0d 00 00       	call   12d0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     4ee:	83 c4 0c             	add    $0xc,%esp
     4f1:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     4f3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     4f5:	6a 00                	push   $0x0
     4f7:	50                   	push   %eax
     4f8:	e8 73 08 00 00       	call   d70 <memset>
  cmd->type = LIST;
  cmd->left = left;
     4fd:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = LIST;
     500:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     506:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     509:	8b 45 0c             	mov    0xc(%ebp),%eax
     50c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     50f:	89 d8                	mov    %ebx,%eax
     511:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     514:	c9                   	leave  
     515:	c3                   	ret    
     516:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     51d:	8d 76 00             	lea    0x0(%esi),%esi

00000520 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     520:	55                   	push   %ebp
     521:	89 e5                	mov    %esp,%ebp
     523:	53                   	push   %ebx
     524:	83 ec 10             	sub    $0x10,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     527:	6a 08                	push   $0x8
     529:	e8 a2 0d 00 00       	call   12d0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     52e:	83 c4 0c             	add    $0xc,%esp
     531:	6a 08                	push   $0x8
  cmd = malloc(sizeof(*cmd));
     533:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     535:	6a 00                	push   $0x0
     537:	50                   	push   %eax
     538:	e8 33 08 00 00       	call   d70 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     53d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = BACK;
     540:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     546:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     549:	89 d8                	mov    %ebx,%eax
     54b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     54e:	c9                   	leave  
     54f:	c3                   	ret    

00000550 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     550:	55                   	push   %ebp
     551:	89 e5                	mov    %esp,%ebp
     553:	57                   	push   %edi
     554:	56                   	push   %esi
     555:	53                   	push   %ebx
     556:	83 ec 0c             	sub    $0xc,%esp
  char *s;
  int ret;

  s = *ps;
     559:	8b 45 08             	mov    0x8(%ebp),%eax
{
     55c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     55f:	8b 75 10             	mov    0x10(%ebp),%esi
  s = *ps;
     562:	8b 38                	mov    (%eax),%edi
  while(s < es && strchr(whitespace, *s))
     564:	39 df                	cmp    %ebx,%edi
     566:	72 0f                	jb     577 <gettoken+0x27>
     568:	eb 25                	jmp    58f <gettoken+0x3f>
     56a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s++;
     570:	83 c7 01             	add    $0x1,%edi
  while(s < es && strchr(whitespace, *s))
     573:	39 fb                	cmp    %edi,%ebx
     575:	74 18                	je     58f <gettoken+0x3f>
     577:	0f be 07             	movsbl (%edi),%eax
     57a:	83 ec 08             	sub    $0x8,%esp
     57d:	50                   	push   %eax
     57e:	68 00 1b 00 00       	push   $0x1b00
     583:	e8 08 08 00 00       	call   d90 <strchr>
     588:	83 c4 10             	add    $0x10,%esp
     58b:	85 c0                	test   %eax,%eax
     58d:	75 e1                	jne    570 <gettoken+0x20>
  if(q)
     58f:	85 f6                	test   %esi,%esi
     591:	74 02                	je     595 <gettoken+0x45>
    *q = s;
     593:	89 3e                	mov    %edi,(%esi)
  ret = *s;
     595:	0f b6 07             	movzbl (%edi),%eax
  switch(*s){
     598:	3c 3c                	cmp    $0x3c,%al
     59a:	0f 8f d0 00 00 00    	jg     670 <gettoken+0x120>
     5a0:	3c 3a                	cmp    $0x3a,%al
     5a2:	0f 8f b4 00 00 00    	jg     65c <gettoken+0x10c>
     5a8:	84 c0                	test   %al,%al
     5aa:	75 44                	jne    5f0 <gettoken+0xa0>
     5ac:	31 f6                	xor    %esi,%esi
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     5ae:	8b 55 14             	mov    0x14(%ebp),%edx
     5b1:	85 d2                	test   %edx,%edx
     5b3:	74 05                	je     5ba <gettoken+0x6a>
    *eq = s;
     5b5:	8b 45 14             	mov    0x14(%ebp),%eax
     5b8:	89 38                	mov    %edi,(%eax)

  while(s < es && strchr(whitespace, *s))
     5ba:	39 df                	cmp    %ebx,%edi
     5bc:	72 09                	jb     5c7 <gettoken+0x77>
     5be:	eb 1f                	jmp    5df <gettoken+0x8f>
    s++;
     5c0:	83 c7 01             	add    $0x1,%edi
  while(s < es && strchr(whitespace, *s))
     5c3:	39 fb                	cmp    %edi,%ebx
     5c5:	74 18                	je     5df <gettoken+0x8f>
     5c7:	0f be 07             	movsbl (%edi),%eax
     5ca:	83 ec 08             	sub    $0x8,%esp
     5cd:	50                   	push   %eax
     5ce:	68 00 1b 00 00       	push   $0x1b00
     5d3:	e8 b8 07 00 00       	call   d90 <strchr>
     5d8:	83 c4 10             	add    $0x10,%esp
     5db:	85 c0                	test   %eax,%eax
     5dd:	75 e1                	jne    5c0 <gettoken+0x70>
  *ps = s;
     5df:	8b 45 08             	mov    0x8(%ebp),%eax
     5e2:	89 38                	mov    %edi,(%eax)
  return ret;
}
     5e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     5e7:	89 f0                	mov    %esi,%eax
     5e9:	5b                   	pop    %ebx
     5ea:	5e                   	pop    %esi
     5eb:	5f                   	pop    %edi
     5ec:	5d                   	pop    %ebp
     5ed:	c3                   	ret    
     5ee:	66 90                	xchg   %ax,%ax
  switch(*s){
     5f0:	79 5e                	jns    650 <gettoken+0x100>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     5f2:	39 fb                	cmp    %edi,%ebx
     5f4:	77 34                	ja     62a <gettoken+0xda>
  if(eq)
     5f6:	8b 45 14             	mov    0x14(%ebp),%eax
     5f9:	be 61 00 00 00       	mov    $0x61,%esi
     5fe:	85 c0                	test   %eax,%eax
     600:	75 b3                	jne    5b5 <gettoken+0x65>
     602:	eb db                	jmp    5df <gettoken+0x8f>
     604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     608:	0f be 07             	movsbl (%edi),%eax
     60b:	83 ec 08             	sub    $0x8,%esp
     60e:	50                   	push   %eax
     60f:	68 f8 1a 00 00       	push   $0x1af8
     614:	e8 77 07 00 00       	call   d90 <strchr>
     619:	83 c4 10             	add    $0x10,%esp
     61c:	85 c0                	test   %eax,%eax
     61e:	75 22                	jne    642 <gettoken+0xf2>
      s++;
     620:	83 c7 01             	add    $0x1,%edi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     623:	39 fb                	cmp    %edi,%ebx
     625:	74 cf                	je     5f6 <gettoken+0xa6>
     627:	0f b6 07             	movzbl (%edi),%eax
     62a:	83 ec 08             	sub    $0x8,%esp
     62d:	0f be f0             	movsbl %al,%esi
     630:	56                   	push   %esi
     631:	68 00 1b 00 00       	push   $0x1b00
     636:	e8 55 07 00 00       	call   d90 <strchr>
     63b:	83 c4 10             	add    $0x10,%esp
     63e:	85 c0                	test   %eax,%eax
     640:	74 c6                	je     608 <gettoken+0xb8>
    ret = 'a';
     642:	be 61 00 00 00       	mov    $0x61,%esi
     647:	e9 62 ff ff ff       	jmp    5ae <gettoken+0x5e>
     64c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     650:	3c 26                	cmp    $0x26,%al
     652:	74 08                	je     65c <gettoken+0x10c>
     654:	8d 48 d8             	lea    -0x28(%eax),%ecx
     657:	80 f9 01             	cmp    $0x1,%cl
     65a:	77 96                	ja     5f2 <gettoken+0xa2>
  ret = *s;
     65c:	0f be f0             	movsbl %al,%esi
    s++;
     65f:	83 c7 01             	add    $0x1,%edi
    break;
     662:	e9 47 ff ff ff       	jmp    5ae <gettoken+0x5e>
     667:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     66e:	66 90                	xchg   %ax,%ax
  switch(*s){
     670:	3c 3e                	cmp    $0x3e,%al
     672:	75 1c                	jne    690 <gettoken+0x140>
    if(*s == '>'){
     674:	80 7f 01 3e          	cmpb   $0x3e,0x1(%edi)
    s++;
     678:	8d 47 01             	lea    0x1(%edi),%eax
    if(*s == '>'){
     67b:	74 1c                	je     699 <gettoken+0x149>
    s++;
     67d:	89 c7                	mov    %eax,%edi
     67f:	be 3e 00 00 00       	mov    $0x3e,%esi
     684:	e9 25 ff ff ff       	jmp    5ae <gettoken+0x5e>
     689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     690:	3c 7c                	cmp    $0x7c,%al
     692:	74 c8                	je     65c <gettoken+0x10c>
     694:	e9 59 ff ff ff       	jmp    5f2 <gettoken+0xa2>
      s++;
     699:	83 c7 02             	add    $0x2,%edi
      ret = '+';
     69c:	be 2b 00 00 00       	mov    $0x2b,%esi
     6a1:	e9 08 ff ff ff       	jmp    5ae <gettoken+0x5e>
     6a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     6ad:	8d 76 00             	lea    0x0(%esi),%esi

000006b0 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     6b0:	55                   	push   %ebp
     6b1:	89 e5                	mov    %esp,%ebp
     6b3:	57                   	push   %edi
     6b4:	56                   	push   %esi
     6b5:	53                   	push   %ebx
     6b6:	83 ec 0c             	sub    $0xc,%esp
     6b9:	8b 7d 08             	mov    0x8(%ebp),%edi
     6bc:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     6bf:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     6c1:	39 f3                	cmp    %esi,%ebx
     6c3:	72 12                	jb     6d7 <peek+0x27>
     6c5:	eb 28                	jmp    6ef <peek+0x3f>
     6c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     6ce:	66 90                	xchg   %ax,%ax
    s++;
     6d0:	83 c3 01             	add    $0x1,%ebx
  while(s < es && strchr(whitespace, *s))
     6d3:	39 de                	cmp    %ebx,%esi
     6d5:	74 18                	je     6ef <peek+0x3f>
     6d7:	0f be 03             	movsbl (%ebx),%eax
     6da:	83 ec 08             	sub    $0x8,%esp
     6dd:	50                   	push   %eax
     6de:	68 00 1b 00 00       	push   $0x1b00
     6e3:	e8 a8 06 00 00       	call   d90 <strchr>
     6e8:	83 c4 10             	add    $0x10,%esp
     6eb:	85 c0                	test   %eax,%eax
     6ed:	75 e1                	jne    6d0 <peek+0x20>
  *ps = s;
     6ef:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     6f1:	0f be 03             	movsbl (%ebx),%eax
     6f4:	31 d2                	xor    %edx,%edx
     6f6:	84 c0                	test   %al,%al
     6f8:	75 0e                	jne    708 <peek+0x58>
}
     6fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
     6fd:	89 d0                	mov    %edx,%eax
     6ff:	5b                   	pop    %ebx
     700:	5e                   	pop    %esi
     701:	5f                   	pop    %edi
     702:	5d                   	pop    %ebp
     703:	c3                   	ret    
     704:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return *s && strchr(toks, *s);
     708:	83 ec 08             	sub    $0x8,%esp
     70b:	50                   	push   %eax
     70c:	ff 75 10             	push   0x10(%ebp)
     70f:	e8 7c 06 00 00       	call   d90 <strchr>
     714:	83 c4 10             	add    $0x10,%esp
     717:	31 d2                	xor    %edx,%edx
     719:	85 c0                	test   %eax,%eax
     71b:	0f 95 c2             	setne  %dl
}
     71e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     721:	5b                   	pop    %ebx
     722:	89 d0                	mov    %edx,%eax
     724:	5e                   	pop    %esi
     725:	5f                   	pop    %edi
     726:	5d                   	pop    %ebp
     727:	c3                   	ret    
     728:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     72f:	90                   	nop

00000730 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     730:	55                   	push   %ebp
     731:	89 e5                	mov    %esp,%ebp
     733:	57                   	push   %edi
     734:	56                   	push   %esi
     735:	53                   	push   %ebx
     736:	83 ec 2c             	sub    $0x2c,%esp
     739:	8b 75 0c             	mov    0xc(%ebp),%esi
     73c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     73f:	90                   	nop
     740:	83 ec 04             	sub    $0x4,%esp
     743:	68 21 14 00 00       	push   $0x1421
     748:	53                   	push   %ebx
     749:	56                   	push   %esi
     74a:	e8 61 ff ff ff       	call   6b0 <peek>
     74f:	83 c4 10             	add    $0x10,%esp
     752:	85 c0                	test   %eax,%eax
     754:	0f 84 f6 00 00 00    	je     850 <parseredirs+0x120>
    tok = gettoken(ps, es, 0, 0);
     75a:	6a 00                	push   $0x0
     75c:	6a 00                	push   $0x0
     75e:	53                   	push   %ebx
     75f:	56                   	push   %esi
     760:	e8 eb fd ff ff       	call   550 <gettoken>
     765:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
     767:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     76a:	50                   	push   %eax
     76b:	8d 45 e0             	lea    -0x20(%ebp),%eax
     76e:	50                   	push   %eax
     76f:	53                   	push   %ebx
     770:	56                   	push   %esi
     771:	e8 da fd ff ff       	call   550 <gettoken>
     776:	83 c4 20             	add    $0x20,%esp
     779:	83 f8 61             	cmp    $0x61,%eax
     77c:	0f 85 d9 00 00 00    	jne    85b <parseredirs+0x12b>
      panic("missing file for redirection");
    switch(tok){
     782:	83 ff 3c             	cmp    $0x3c,%edi
     785:	74 69                	je     7f0 <parseredirs+0xc0>
     787:	83 ff 3e             	cmp    $0x3e,%edi
     78a:	74 05                	je     791 <parseredirs+0x61>
     78c:	83 ff 2b             	cmp    $0x2b,%edi
     78f:	75 af                	jne    740 <parseredirs+0x10>
  cmd = malloc(sizeof(*cmd));
     791:	83 ec 0c             	sub    $0xc,%esp
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     794:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     797:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  cmd = malloc(sizeof(*cmd));
     79a:	6a 18                	push   $0x18
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     79c:	89 55 d0             	mov    %edx,-0x30(%ebp)
     79f:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
     7a2:	e8 29 0b 00 00       	call   12d0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     7a7:	83 c4 0c             	add    $0xc,%esp
     7aa:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     7ac:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
     7ae:	6a 00                	push   $0x0
     7b0:	50                   	push   %eax
     7b1:	e8 ba 05 00 00       	call   d70 <memset>
  cmd->type = REDIR;
     7b6:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  cmd->cmd = subcmd;
     7bc:	8b 45 08             	mov    0x8(%ebp),%eax
      break;
     7bf:	83 c4 10             	add    $0x10,%esp
  cmd->cmd = subcmd;
     7c2:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
     7c5:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     7c8:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
     7cb:	8b 55 d0             	mov    -0x30(%ebp),%edx
  cmd->mode = mode;
     7ce:	c7 47 10 01 02 00 00 	movl   $0x201,0x10(%edi)
  cmd->efile = efile;
     7d5:	89 57 0c             	mov    %edx,0xc(%edi)
  cmd->fd = fd;
     7d8:	c7 47 14 01 00 00 00 	movl   $0x1,0x14(%edi)
      break;
     7df:	89 7d 08             	mov    %edi,0x8(%ebp)
     7e2:	e9 59 ff ff ff       	jmp    740 <parseredirs+0x10>
     7e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     7ee:	66 90                	xchg   %ax,%ax
  cmd = malloc(sizeof(*cmd));
     7f0:	83 ec 0c             	sub    $0xc,%esp
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     7f3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     7f6:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  cmd = malloc(sizeof(*cmd));
     7f9:	6a 18                	push   $0x18
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     7fb:	89 55 d0             	mov    %edx,-0x30(%ebp)
     7fe:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
     801:	e8 ca 0a 00 00       	call   12d0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     806:	83 c4 0c             	add    $0xc,%esp
     809:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     80b:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
     80d:	6a 00                	push   $0x0
     80f:	50                   	push   %eax
     810:	e8 5b 05 00 00       	call   d70 <memset>
  cmd->cmd = subcmd;
     815:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->file = file;
     818:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      break;
     81b:	89 7d 08             	mov    %edi,0x8(%ebp)
  cmd->efile = efile;
     81e:	8b 55 d0             	mov    -0x30(%ebp),%edx
  cmd->type = REDIR;
     821:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
      break;
     827:	83 c4 10             	add    $0x10,%esp
  cmd->cmd = subcmd;
     82a:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
     82d:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
     830:	89 57 0c             	mov    %edx,0xc(%edi)
  cmd->mode = mode;
     833:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%edi)
  cmd->fd = fd;
     83a:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
      break;
     841:	e9 fa fe ff ff       	jmp    740 <parseredirs+0x10>
     846:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     84d:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
  return cmd;
}
     850:	8b 45 08             	mov    0x8(%ebp),%eax
     853:	8d 65 f4             	lea    -0xc(%ebp),%esp
     856:	5b                   	pop    %ebx
     857:	5e                   	pop    %esi
     858:	5f                   	pop    %edi
     859:	5d                   	pop    %ebp
     85a:	c3                   	ret    
      panic("missing file for redirection");
     85b:	83 ec 0c             	sub    $0xc,%esp
     85e:	68 04 14 00 00       	push   $0x1404
     863:	e8 b8 f9 ff ff       	call   220 <panic>
     868:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     86f:	90                   	nop

00000870 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     870:	55                   	push   %ebp
     871:	89 e5                	mov    %esp,%ebp
     873:	57                   	push   %edi
     874:	56                   	push   %esi
     875:	53                   	push   %ebx
     876:	83 ec 30             	sub    $0x30,%esp
     879:	8b 75 08             	mov    0x8(%ebp),%esi
     87c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     87f:	68 24 14 00 00       	push   $0x1424
     884:	57                   	push   %edi
     885:	56                   	push   %esi
     886:	e8 25 fe ff ff       	call   6b0 <peek>
     88b:	83 c4 10             	add    $0x10,%esp
     88e:	85 c0                	test   %eax,%eax
     890:	0f 85 da 00 00 00    	jne    970 <parseexec+0x100>
  cmd = malloc(sizeof(*cmd));
     896:	83 ec 0c             	sub    $0xc,%esp
     899:	89 c3                	mov    %eax,%ebx
     89b:	68 a4 00 00 00       	push   $0xa4
     8a0:	e8 2b 0a 00 00       	call   12d0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     8a5:	83 c4 0c             	add    $0xc,%esp
     8a8:	68 a4 00 00 00       	push   $0xa4
     8ad:	6a 00                	push   $0x0
     8af:	50                   	push   %eax
     8b0:	89 45 d0             	mov    %eax,-0x30(%ebp)
     8b3:	e8 b8 04 00 00       	call   d70 <memset>
  cmd->type = EXEC;
     8b8:	8b 45 d0             	mov    -0x30(%ebp),%eax

  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     8bb:	83 c4 0c             	add    $0xc,%esp
  cmd->type = EXEC;
     8be:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  ret = parseredirs(ret, ps, es);
     8c4:	57                   	push   %edi
     8c5:	56                   	push   %esi
     8c6:	50                   	push   %eax
     8c7:	e8 64 fe ff ff       	call   730 <parseredirs>
  while(!peek(ps, es, "|)&;")){
     8cc:	83 c4 10             	add    $0x10,%esp
  ret = parseredirs(ret, ps, es);
     8cf:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     8d2:	eb 17                	jmp    8eb <parseexec+0x7b>
     8d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     8d8:	83 ec 04             	sub    $0x4,%esp
     8db:	57                   	push   %edi
     8dc:	56                   	push   %esi
     8dd:	ff 75 d4             	push   -0x2c(%ebp)
     8e0:	e8 4b fe ff ff       	call   730 <parseredirs>
     8e5:	83 c4 10             	add    $0x10,%esp
     8e8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     8eb:	83 ec 04             	sub    $0x4,%esp
     8ee:	68 3b 14 00 00       	push   $0x143b
     8f3:	57                   	push   %edi
     8f4:	56                   	push   %esi
     8f5:	e8 b6 fd ff ff       	call   6b0 <peek>
     8fa:	83 c4 10             	add    $0x10,%esp
     8fd:	85 c0                	test   %eax,%eax
     8ff:	75 47                	jne    948 <parseexec+0xd8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     901:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     904:	50                   	push   %eax
     905:	8d 45 e0             	lea    -0x20(%ebp),%eax
     908:	50                   	push   %eax
     909:	57                   	push   %edi
     90a:	56                   	push   %esi
     90b:	e8 40 fc ff ff       	call   550 <gettoken>
     910:	83 c4 10             	add    $0x10,%esp
     913:	85 c0                	test   %eax,%eax
     915:	74 31                	je     948 <parseexec+0xd8>
    if(tok != 'a')
     917:	83 f8 61             	cmp    $0x61,%eax
     91a:	75 66                	jne    982 <parseexec+0x112>
    cmd->argv[argc] = q;
     91c:	8b 45 e0             	mov    -0x20(%ebp),%eax
     91f:	8b 55 d0             	mov    -0x30(%ebp),%edx
     922:	89 44 9a 04          	mov    %eax,0x4(%edx,%ebx,4)
    cmd->eargv[argc] = eq;
     926:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     929:	89 44 9a 54          	mov    %eax,0x54(%edx,%ebx,4)
    argc++;
     92d:	83 c3 01             	add    $0x1,%ebx
    if(argc >= MAXARGS)
     930:	83 fb 14             	cmp    $0x14,%ebx
     933:	75 a3                	jne    8d8 <parseexec+0x68>
      panic("too many args");
     935:	83 ec 0c             	sub    $0xc,%esp
     938:	68 2d 14 00 00       	push   $0x142d
     93d:	e8 de f8 ff ff       	call   220 <panic>
     942:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  cmd->argv[argc] = 0;
     948:	8b 45 d0             	mov    -0x30(%ebp),%eax
     94b:	c7 44 98 04 00 00 00 	movl   $0x0,0x4(%eax,%ebx,4)
     952:	00 
  cmd->eargv[argc] = 0;
     953:	c7 44 98 54 00 00 00 	movl   $0x0,0x54(%eax,%ebx,4)
     95a:	00 
  return ret;
}
     95b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     95e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     961:	5b                   	pop    %ebx
     962:	5e                   	pop    %esi
     963:	5f                   	pop    %edi
     964:	5d                   	pop    %ebp
     965:	c3                   	ret    
     966:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     96d:	8d 76 00             	lea    0x0(%esi),%esi
    return parseblock(ps, es);
     970:	89 7d 0c             	mov    %edi,0xc(%ebp)
     973:	89 75 08             	mov    %esi,0x8(%ebp)
}
     976:	8d 65 f4             	lea    -0xc(%ebp),%esp
     979:	5b                   	pop    %ebx
     97a:	5e                   	pop    %esi
     97b:	5f                   	pop    %edi
     97c:	5d                   	pop    %ebp
    return parseblock(ps, es);
     97d:	e9 7e 01 00 00       	jmp    b00 <parseblock>
      panic("syntax");
     982:	83 ec 0c             	sub    $0xc,%esp
     985:	68 26 14 00 00       	push   $0x1426
     98a:	e8 91 f8 ff ff       	call   220 <panic>
     98f:	90                   	nop

00000990 <parsepipe>:
{
     990:	55                   	push   %ebp
     991:	89 e5                	mov    %esp,%ebp
     993:	57                   	push   %edi
     994:	56                   	push   %esi
     995:	53                   	push   %ebx
     996:	83 ec 14             	sub    $0x14,%esp
     999:	8b 75 08             	mov    0x8(%ebp),%esi
     99c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parseexec(ps, es);
     99f:	57                   	push   %edi
     9a0:	56                   	push   %esi
     9a1:	e8 ca fe ff ff       	call   870 <parseexec>
  if(peek(ps, es, "|")){
     9a6:	83 c4 0c             	add    $0xc,%esp
     9a9:	68 40 14 00 00       	push   $0x1440
  cmd = parseexec(ps, es);
     9ae:	89 c3                	mov    %eax,%ebx
  if(peek(ps, es, "|")){
     9b0:	57                   	push   %edi
     9b1:	56                   	push   %esi
     9b2:	e8 f9 fc ff ff       	call   6b0 <peek>
     9b7:	83 c4 10             	add    $0x10,%esp
     9ba:	85 c0                	test   %eax,%eax
     9bc:	75 12                	jne    9d0 <parsepipe+0x40>
}
     9be:	8d 65 f4             	lea    -0xc(%ebp),%esp
     9c1:	89 d8                	mov    %ebx,%eax
     9c3:	5b                   	pop    %ebx
     9c4:	5e                   	pop    %esi
     9c5:	5f                   	pop    %edi
     9c6:	5d                   	pop    %ebp
     9c7:	c3                   	ret    
     9c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     9cf:	90                   	nop
    gettoken(ps, es, 0, 0);
     9d0:	6a 00                	push   $0x0
     9d2:	6a 00                	push   $0x0
     9d4:	57                   	push   %edi
     9d5:	56                   	push   %esi
     9d6:	e8 75 fb ff ff       	call   550 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     9db:	58                   	pop    %eax
     9dc:	5a                   	pop    %edx
     9dd:	57                   	push   %edi
     9de:	56                   	push   %esi
     9df:	e8 ac ff ff ff       	call   990 <parsepipe>
  cmd = malloc(sizeof(*cmd));
     9e4:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    cmd = pipecmd(cmd, parsepipe(ps, es));
     9eb:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
     9ed:	e8 de 08 00 00       	call   12d0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     9f2:	83 c4 0c             	add    $0xc,%esp
     9f5:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     9f7:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
     9f9:	6a 00                	push   $0x0
     9fb:	50                   	push   %eax
     9fc:	e8 6f 03 00 00       	call   d70 <memset>
  cmd->left = left;
     a01:	89 5e 04             	mov    %ebx,0x4(%esi)
  cmd->right = right;
     a04:	83 c4 10             	add    $0x10,%esp
     a07:	89 f3                	mov    %esi,%ebx
  cmd->type = PIPE;
     a09:	c7 06 03 00 00 00    	movl   $0x3,(%esi)
}
     a0f:	89 d8                	mov    %ebx,%eax
  cmd->right = right;
     a11:	89 7e 08             	mov    %edi,0x8(%esi)
}
     a14:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a17:	5b                   	pop    %ebx
     a18:	5e                   	pop    %esi
     a19:	5f                   	pop    %edi
     a1a:	5d                   	pop    %ebp
     a1b:	c3                   	ret    
     a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a20 <parseline>:
{
     a20:	55                   	push   %ebp
     a21:	89 e5                	mov    %esp,%ebp
     a23:	57                   	push   %edi
     a24:	56                   	push   %esi
     a25:	53                   	push   %ebx
     a26:	83 ec 24             	sub    $0x24,%esp
     a29:	8b 75 08             	mov    0x8(%ebp),%esi
     a2c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parsepipe(ps, es);
     a2f:	57                   	push   %edi
     a30:	56                   	push   %esi
     a31:	e8 5a ff ff ff       	call   990 <parsepipe>
  while(peek(ps, es, "&")){
     a36:	83 c4 10             	add    $0x10,%esp
  cmd = parsepipe(ps, es);
     a39:	89 c3                	mov    %eax,%ebx
  while(peek(ps, es, "&")){
     a3b:	eb 3b                	jmp    a78 <parseline+0x58>
     a3d:	8d 76 00             	lea    0x0(%esi),%esi
    gettoken(ps, es, 0, 0);
     a40:	6a 00                	push   $0x0
     a42:	6a 00                	push   $0x0
     a44:	57                   	push   %edi
     a45:	56                   	push   %esi
     a46:	e8 05 fb ff ff       	call   550 <gettoken>
  cmd = malloc(sizeof(*cmd));
     a4b:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     a52:	e8 79 08 00 00       	call   12d0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     a57:	83 c4 0c             	add    $0xc,%esp
     a5a:	6a 08                	push   $0x8
     a5c:	6a 00                	push   $0x0
     a5e:	50                   	push   %eax
     a5f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     a62:	e8 09 03 00 00       	call   d70 <memset>
  cmd->type = BACK;
     a67:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  cmd->cmd = subcmd;
     a6a:	83 c4 10             	add    $0x10,%esp
  cmd->type = BACK;
     a6d:	c7 02 05 00 00 00    	movl   $0x5,(%edx)
  cmd->cmd = subcmd;
     a73:	89 5a 04             	mov    %ebx,0x4(%edx)
     a76:	89 d3                	mov    %edx,%ebx
  while(peek(ps, es, "&")){
     a78:	83 ec 04             	sub    $0x4,%esp
     a7b:	68 42 14 00 00       	push   $0x1442
     a80:	57                   	push   %edi
     a81:	56                   	push   %esi
     a82:	e8 29 fc ff ff       	call   6b0 <peek>
     a87:	83 c4 10             	add    $0x10,%esp
     a8a:	85 c0                	test   %eax,%eax
     a8c:	75 b2                	jne    a40 <parseline+0x20>
  if(peek(ps, es, ";")){
     a8e:	83 ec 04             	sub    $0x4,%esp
     a91:	68 3e 14 00 00       	push   $0x143e
     a96:	57                   	push   %edi
     a97:	56                   	push   %esi
     a98:	e8 13 fc ff ff       	call   6b0 <peek>
     a9d:	83 c4 10             	add    $0x10,%esp
     aa0:	85 c0                	test   %eax,%eax
     aa2:	75 0c                	jne    ab0 <parseline+0x90>
}
     aa4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     aa7:	89 d8                	mov    %ebx,%eax
     aa9:	5b                   	pop    %ebx
     aaa:	5e                   	pop    %esi
     aab:	5f                   	pop    %edi
     aac:	5d                   	pop    %ebp
     aad:	c3                   	ret    
     aae:	66 90                	xchg   %ax,%ax
    gettoken(ps, es, 0, 0);
     ab0:	6a 00                	push   $0x0
     ab2:	6a 00                	push   $0x0
     ab4:	57                   	push   %edi
     ab5:	56                   	push   %esi
     ab6:	e8 95 fa ff ff       	call   550 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     abb:	58                   	pop    %eax
     abc:	5a                   	pop    %edx
     abd:	57                   	push   %edi
     abe:	56                   	push   %esi
     abf:	e8 5c ff ff ff       	call   a20 <parseline>
  cmd = malloc(sizeof(*cmd));
     ac4:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    cmd = listcmd(cmd, parseline(ps, es));
     acb:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
     acd:	e8 fe 07 00 00       	call   12d0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     ad2:	83 c4 0c             	add    $0xc,%esp
     ad5:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     ad7:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
     ad9:	6a 00                	push   $0x0
     adb:	50                   	push   %eax
     adc:	e8 8f 02 00 00       	call   d70 <memset>
  cmd->left = left;
     ae1:	89 5e 04             	mov    %ebx,0x4(%esi)
  cmd->right = right;
     ae4:	83 c4 10             	add    $0x10,%esp
     ae7:	89 f3                	mov    %esi,%ebx
  cmd->type = LIST;
     ae9:	c7 06 04 00 00 00    	movl   $0x4,(%esi)
}
     aef:	89 d8                	mov    %ebx,%eax
  cmd->right = right;
     af1:	89 7e 08             	mov    %edi,0x8(%esi)
}
     af4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     af7:	5b                   	pop    %ebx
     af8:	5e                   	pop    %esi
     af9:	5f                   	pop    %edi
     afa:	5d                   	pop    %ebp
     afb:	c3                   	ret    
     afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000b00 <parseblock>:
{
     b00:	55                   	push   %ebp
     b01:	89 e5                	mov    %esp,%ebp
     b03:	57                   	push   %edi
     b04:	56                   	push   %esi
     b05:	53                   	push   %ebx
     b06:	83 ec 10             	sub    $0x10,%esp
     b09:	8b 5d 08             	mov    0x8(%ebp),%ebx
     b0c:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(!peek(ps, es, "("))
     b0f:	68 24 14 00 00       	push   $0x1424
     b14:	56                   	push   %esi
     b15:	53                   	push   %ebx
     b16:	e8 95 fb ff ff       	call   6b0 <peek>
     b1b:	83 c4 10             	add    $0x10,%esp
     b1e:	85 c0                	test   %eax,%eax
     b20:	74 4a                	je     b6c <parseblock+0x6c>
  gettoken(ps, es, 0, 0);
     b22:	6a 00                	push   $0x0
     b24:	6a 00                	push   $0x0
     b26:	56                   	push   %esi
     b27:	53                   	push   %ebx
     b28:	e8 23 fa ff ff       	call   550 <gettoken>
  cmd = parseline(ps, es);
     b2d:	58                   	pop    %eax
     b2e:	5a                   	pop    %edx
     b2f:	56                   	push   %esi
     b30:	53                   	push   %ebx
     b31:	e8 ea fe ff ff       	call   a20 <parseline>
  if(!peek(ps, es, ")"))
     b36:	83 c4 0c             	add    $0xc,%esp
     b39:	68 60 14 00 00       	push   $0x1460
  cmd = parseline(ps, es);
     b3e:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     b40:	56                   	push   %esi
     b41:	53                   	push   %ebx
     b42:	e8 69 fb ff ff       	call   6b0 <peek>
     b47:	83 c4 10             	add    $0x10,%esp
     b4a:	85 c0                	test   %eax,%eax
     b4c:	74 2b                	je     b79 <parseblock+0x79>
  gettoken(ps, es, 0, 0);
     b4e:	6a 00                	push   $0x0
     b50:	6a 00                	push   $0x0
     b52:	56                   	push   %esi
     b53:	53                   	push   %ebx
     b54:	e8 f7 f9 ff ff       	call   550 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     b59:	83 c4 0c             	add    $0xc,%esp
     b5c:	56                   	push   %esi
     b5d:	53                   	push   %ebx
     b5e:	57                   	push   %edi
     b5f:	e8 cc fb ff ff       	call   730 <parseredirs>
}
     b64:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b67:	5b                   	pop    %ebx
     b68:	5e                   	pop    %esi
     b69:	5f                   	pop    %edi
     b6a:	5d                   	pop    %ebp
     b6b:	c3                   	ret    
    panic("parseblock");
     b6c:	83 ec 0c             	sub    $0xc,%esp
     b6f:	68 44 14 00 00       	push   $0x1444
     b74:	e8 a7 f6 ff ff       	call   220 <panic>
    panic("syntax - missing )");
     b79:	83 ec 0c             	sub    $0xc,%esp
     b7c:	68 4f 14 00 00       	push   $0x144f
     b81:	e8 9a f6 ff ff       	call   220 <panic>
     b86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     b8d:	8d 76 00             	lea    0x0(%esi),%esi

00000b90 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     b90:	55                   	push   %ebp
     b91:	89 e5                	mov    %esp,%ebp
     b93:	53                   	push   %ebx
     b94:	83 ec 04             	sub    $0x4,%esp
     b97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     b9a:	85 db                	test   %ebx,%ebx
     b9c:	0f 84 8e 00 00 00    	je     c30 <nulterminate+0xa0>
    return 0;

  switch(cmd->type){
     ba2:	83 3b 05             	cmpl   $0x5,(%ebx)
     ba5:	77 61                	ja     c08 <nulterminate+0x78>
     ba7:	8b 03                	mov    (%ebx),%eax
     ba9:	ff 24 85 a8 14 00 00 	jmp    *0x14a8(,%eax,4)
    nulterminate(pcmd->right);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
     bb0:	83 ec 0c             	sub    $0xc,%esp
     bb3:	ff 73 04             	push   0x4(%ebx)
     bb6:	e8 d5 ff ff ff       	call   b90 <nulterminate>
    nulterminate(lcmd->right);
     bbb:	58                   	pop    %eax
     bbc:	ff 73 08             	push   0x8(%ebx)
     bbf:	e8 cc ff ff ff       	call   b90 <nulterminate>
    break;
     bc4:	83 c4 10             	add    $0x10,%esp
     bc7:	89 d8                	mov    %ebx,%eax
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     bc9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     bcc:	c9                   	leave  
     bcd:	c3                   	ret    
     bce:	66 90                	xchg   %ax,%ax
    nulterminate(bcmd->cmd);
     bd0:	83 ec 0c             	sub    $0xc,%esp
     bd3:	ff 73 04             	push   0x4(%ebx)
     bd6:	e8 b5 ff ff ff       	call   b90 <nulterminate>
    break;
     bdb:	89 d8                	mov    %ebx,%eax
     bdd:	83 c4 10             	add    $0x10,%esp
}
     be0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     be3:	c9                   	leave  
     be4:	c3                   	ret    
     be5:	8d 76 00             	lea    0x0(%esi),%esi
    for(i=0; ecmd->argv[i]; i++)
     be8:	8b 4b 04             	mov    0x4(%ebx),%ecx
     beb:	8d 43 08             	lea    0x8(%ebx),%eax
     bee:	85 c9                	test   %ecx,%ecx
     bf0:	74 16                	je     c08 <nulterminate+0x78>
     bf2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
     bf8:	8b 50 4c             	mov    0x4c(%eax),%edx
    for(i=0; ecmd->argv[i]; i++)
     bfb:	83 c0 04             	add    $0x4,%eax
      *ecmd->eargv[i] = 0;
     bfe:	c6 02 00             	movb   $0x0,(%edx)
    for(i=0; ecmd->argv[i]; i++)
     c01:	8b 50 fc             	mov    -0x4(%eax),%edx
     c04:	85 d2                	test   %edx,%edx
     c06:	75 f0                	jne    bf8 <nulterminate+0x68>
  switch(cmd->type){
     c08:	89 d8                	mov    %ebx,%eax
}
     c0a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c0d:	c9                   	leave  
     c0e:	c3                   	ret    
     c0f:	90                   	nop
    nulterminate(rcmd->cmd);
     c10:	83 ec 0c             	sub    $0xc,%esp
     c13:	ff 73 04             	push   0x4(%ebx)
     c16:	e8 75 ff ff ff       	call   b90 <nulterminate>
    *rcmd->efile = 0;
     c1b:	8b 43 0c             	mov    0xc(%ebx),%eax
    break;
     c1e:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
     c21:	c6 00 00             	movb   $0x0,(%eax)
    break;
     c24:	89 d8                	mov    %ebx,%eax
}
     c26:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c29:	c9                   	leave  
     c2a:	c3                   	ret    
     c2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     c2f:	90                   	nop
    return 0;
     c30:	31 c0                	xor    %eax,%eax
     c32:	eb 95                	jmp    bc9 <nulterminate+0x39>
     c34:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     c3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     c3f:	90                   	nop

00000c40 <parsecmd>:
{
     c40:	55                   	push   %ebp
     c41:	89 e5                	mov    %esp,%ebp
     c43:	57                   	push   %edi
     c44:	56                   	push   %esi
  cmd = parseline(&s, es);
     c45:	8d 7d 08             	lea    0x8(%ebp),%edi
{
     c48:	53                   	push   %ebx
     c49:	83 ec 18             	sub    $0x18,%esp
  es = s + strlen(s);
     c4c:	8b 5d 08             	mov    0x8(%ebp),%ebx
     c4f:	53                   	push   %ebx
     c50:	e8 eb 00 00 00       	call   d40 <strlen>
  cmd = parseline(&s, es);
     c55:	59                   	pop    %ecx
     c56:	5e                   	pop    %esi
  es = s + strlen(s);
     c57:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     c59:	53                   	push   %ebx
     c5a:	57                   	push   %edi
     c5b:	e8 c0 fd ff ff       	call   a20 <parseline>
  peek(&s, es, "");
     c60:	83 c4 0c             	add    $0xc,%esp
     c63:	68 ee 13 00 00       	push   $0x13ee
  cmd = parseline(&s, es);
     c68:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     c6a:	53                   	push   %ebx
     c6b:	57                   	push   %edi
     c6c:	e8 3f fa ff ff       	call   6b0 <peek>
  if(s != es){
     c71:	8b 45 08             	mov    0x8(%ebp),%eax
     c74:	83 c4 10             	add    $0x10,%esp
     c77:	39 d8                	cmp    %ebx,%eax
     c79:	75 13                	jne    c8e <parsecmd+0x4e>
  nulterminate(cmd);
     c7b:	83 ec 0c             	sub    $0xc,%esp
     c7e:	56                   	push   %esi
     c7f:	e8 0c ff ff ff       	call   b90 <nulterminate>
}
     c84:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c87:	89 f0                	mov    %esi,%eax
     c89:	5b                   	pop    %ebx
     c8a:	5e                   	pop    %esi
     c8b:	5f                   	pop    %edi
     c8c:	5d                   	pop    %ebp
     c8d:	c3                   	ret    
    printf(2, "leftovers: %s\n", s);
     c8e:	52                   	push   %edx
     c8f:	50                   	push   %eax
     c90:	68 62 14 00 00       	push   $0x1462
     c95:	6a 02                	push   $0x2
     c97:	e8 04 04 00 00       	call   10a0 <printf>
    panic("syntax");
     c9c:	c7 04 24 26 14 00 00 	movl   $0x1426,(%esp)
     ca3:	e8 78 f5 ff ff       	call   220 <panic>
     ca8:	66 90                	xchg   %ax,%ax
     caa:	66 90                	xchg   %ax,%ax
     cac:	66 90                	xchg   %ax,%ax
     cae:	66 90                	xchg   %ax,%ax

00000cb0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     cb0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     cb1:	31 c0                	xor    %eax,%eax
{
     cb3:	89 e5                	mov    %esp,%ebp
     cb5:	53                   	push   %ebx
     cb6:	8b 4d 08             	mov    0x8(%ebp),%ecx
     cb9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
     cc0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
     cc4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
     cc7:	83 c0 01             	add    $0x1,%eax
     cca:	84 d2                	test   %dl,%dl
     ccc:	75 f2                	jne    cc0 <strcpy+0x10>
    ;
  return os;
}
     cce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     cd1:	89 c8                	mov    %ecx,%eax
     cd3:	c9                   	leave  
     cd4:	c3                   	ret    
     cd5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000ce0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     ce0:	55                   	push   %ebp
     ce1:	89 e5                	mov    %esp,%ebp
     ce3:	53                   	push   %ebx
     ce4:	8b 55 08             	mov    0x8(%ebp),%edx
     ce7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     cea:	0f b6 02             	movzbl (%edx),%eax
     ced:	84 c0                	test   %al,%al
     cef:	75 17                	jne    d08 <strcmp+0x28>
     cf1:	eb 3a                	jmp    d2d <strcmp+0x4d>
     cf3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     cf7:	90                   	nop
     cf8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
     cfc:	83 c2 01             	add    $0x1,%edx
     cff:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
     d02:	84 c0                	test   %al,%al
     d04:	74 1a                	je     d20 <strcmp+0x40>
    p++, q++;
     d06:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
     d08:	0f b6 19             	movzbl (%ecx),%ebx
     d0b:	38 c3                	cmp    %al,%bl
     d0d:	74 e9                	je     cf8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
     d0f:	29 d8                	sub    %ebx,%eax
}
     d11:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     d14:	c9                   	leave  
     d15:	c3                   	ret    
     d16:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d1d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
     d20:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
     d24:	31 c0                	xor    %eax,%eax
     d26:	29 d8                	sub    %ebx,%eax
}
     d28:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     d2b:	c9                   	leave  
     d2c:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
     d2d:	0f b6 19             	movzbl (%ecx),%ebx
     d30:	31 c0                	xor    %eax,%eax
     d32:	eb db                	jmp    d0f <strcmp+0x2f>
     d34:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     d3f:	90                   	nop

00000d40 <strlen>:

uint
strlen(const char *s)
{
     d40:	55                   	push   %ebp
     d41:	89 e5                	mov    %esp,%ebp
     d43:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
     d46:	80 3a 00             	cmpb   $0x0,(%edx)
     d49:	74 15                	je     d60 <strlen+0x20>
     d4b:	31 c0                	xor    %eax,%eax
     d4d:	8d 76 00             	lea    0x0(%esi),%esi
     d50:	83 c0 01             	add    $0x1,%eax
     d53:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
     d57:	89 c1                	mov    %eax,%ecx
     d59:	75 f5                	jne    d50 <strlen+0x10>
    ;
  return n;
}
     d5b:	89 c8                	mov    %ecx,%eax
     d5d:	5d                   	pop    %ebp
     d5e:	c3                   	ret    
     d5f:	90                   	nop
  for(n = 0; s[n]; n++)
     d60:	31 c9                	xor    %ecx,%ecx
}
     d62:	5d                   	pop    %ebp
     d63:	89 c8                	mov    %ecx,%eax
     d65:	c3                   	ret    
     d66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d6d:	8d 76 00             	lea    0x0(%esi),%esi

00000d70 <memset>:

void*
memset(void *dst, int c, uint n)
{
     d70:	55                   	push   %ebp
     d71:	89 e5                	mov    %esp,%ebp
     d73:	57                   	push   %edi
     d74:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     d77:	8b 4d 10             	mov    0x10(%ebp),%ecx
     d7a:	8b 45 0c             	mov    0xc(%ebp),%eax
     d7d:	89 d7                	mov    %edx,%edi
     d7f:	fc                   	cld    
     d80:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     d82:	8b 7d fc             	mov    -0x4(%ebp),%edi
     d85:	89 d0                	mov    %edx,%eax
     d87:	c9                   	leave  
     d88:	c3                   	ret    
     d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000d90 <strchr>:

char*
strchr(const char *s, char c)
{
     d90:	55                   	push   %ebp
     d91:	89 e5                	mov    %esp,%ebp
     d93:	8b 45 08             	mov    0x8(%ebp),%eax
     d96:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
     d9a:	0f b6 10             	movzbl (%eax),%edx
     d9d:	84 d2                	test   %dl,%dl
     d9f:	75 12                	jne    db3 <strchr+0x23>
     da1:	eb 1d                	jmp    dc0 <strchr+0x30>
     da3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     da7:	90                   	nop
     da8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
     dac:	83 c0 01             	add    $0x1,%eax
     daf:	84 d2                	test   %dl,%dl
     db1:	74 0d                	je     dc0 <strchr+0x30>
    if(*s == c)
     db3:	38 d1                	cmp    %dl,%cl
     db5:	75 f1                	jne    da8 <strchr+0x18>
      return (char*)s;
  return 0;
}
     db7:	5d                   	pop    %ebp
     db8:	c3                   	ret    
     db9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
     dc0:	31 c0                	xor    %eax,%eax
}
     dc2:	5d                   	pop    %ebp
     dc3:	c3                   	ret    
     dc4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     dcb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     dcf:	90                   	nop

00000dd0 <gets>:

char*
gets(char *buf, int max)
{
     dd0:	55                   	push   %ebp
     dd1:	89 e5                	mov    %esp,%ebp
     dd3:	57                   	push   %edi
     dd4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
     dd5:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
     dd8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
     dd9:	31 db                	xor    %ebx,%ebx
{
     ddb:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
     dde:	eb 27                	jmp    e07 <gets+0x37>
    cc = read(0, &c, 1);
     de0:	83 ec 04             	sub    $0x4,%esp
     de3:	6a 01                	push   $0x1
     de5:	57                   	push   %edi
     de6:	6a 00                	push   $0x0
     de8:	e8 2e 01 00 00       	call   f1b <read>
    if(cc < 1)
     ded:	83 c4 10             	add    $0x10,%esp
     df0:	85 c0                	test   %eax,%eax
     df2:	7e 1d                	jle    e11 <gets+0x41>
      break;
    buf[i++] = c;
     df4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     df8:	8b 55 08             	mov    0x8(%ebp),%edx
     dfb:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
     dff:	3c 0a                	cmp    $0xa,%al
     e01:	74 1d                	je     e20 <gets+0x50>
     e03:	3c 0d                	cmp    $0xd,%al
     e05:	74 19                	je     e20 <gets+0x50>
  for(i=0; i+1 < max; ){
     e07:	89 de                	mov    %ebx,%esi
     e09:	83 c3 01             	add    $0x1,%ebx
     e0c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     e0f:	7c cf                	jl     de0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
     e11:	8b 45 08             	mov    0x8(%ebp),%eax
     e14:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
     e18:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e1b:	5b                   	pop    %ebx
     e1c:	5e                   	pop    %esi
     e1d:	5f                   	pop    %edi
     e1e:	5d                   	pop    %ebp
     e1f:	c3                   	ret    
  buf[i] = '\0';
     e20:	8b 45 08             	mov    0x8(%ebp),%eax
     e23:	89 de                	mov    %ebx,%esi
     e25:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
     e29:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e2c:	5b                   	pop    %ebx
     e2d:	5e                   	pop    %esi
     e2e:	5f                   	pop    %edi
     e2f:	5d                   	pop    %ebp
     e30:	c3                   	ret    
     e31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     e38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     e3f:	90                   	nop

00000e40 <stat>:

int
stat(const char *n, struct stat *st)
{
     e40:	55                   	push   %ebp
     e41:	89 e5                	mov    %esp,%ebp
     e43:	56                   	push   %esi
     e44:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     e45:	83 ec 08             	sub    $0x8,%esp
     e48:	6a 00                	push   $0x0
     e4a:	ff 75 08             	push   0x8(%ebp)
     e4d:	e8 f1 00 00 00       	call   f43 <open>
  if(fd < 0)
     e52:	83 c4 10             	add    $0x10,%esp
     e55:	85 c0                	test   %eax,%eax
     e57:	78 27                	js     e80 <stat+0x40>
    return -1;
  r = fstat(fd, st);
     e59:	83 ec 08             	sub    $0x8,%esp
     e5c:	ff 75 0c             	push   0xc(%ebp)
     e5f:	89 c3                	mov    %eax,%ebx
     e61:	50                   	push   %eax
     e62:	e8 f4 00 00 00       	call   f5b <fstat>
  close(fd);
     e67:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     e6a:	89 c6                	mov    %eax,%esi
  close(fd);
     e6c:	e8 ba 00 00 00       	call   f2b <close>
  return r;
     e71:	83 c4 10             	add    $0x10,%esp
}
     e74:	8d 65 f8             	lea    -0x8(%ebp),%esp
     e77:	89 f0                	mov    %esi,%eax
     e79:	5b                   	pop    %ebx
     e7a:	5e                   	pop    %esi
     e7b:	5d                   	pop    %ebp
     e7c:	c3                   	ret    
     e7d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
     e80:	be ff ff ff ff       	mov    $0xffffffff,%esi
     e85:	eb ed                	jmp    e74 <stat+0x34>
     e87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     e8e:	66 90                	xchg   %ax,%ax

00000e90 <atoi>:

int
atoi(const char *s)
{
     e90:	55                   	push   %ebp
     e91:	89 e5                	mov    %esp,%ebp
     e93:	53                   	push   %ebx
     e94:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     e97:	0f be 02             	movsbl (%edx),%eax
     e9a:	8d 48 d0             	lea    -0x30(%eax),%ecx
     e9d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
     ea0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
     ea5:	77 1e                	ja     ec5 <atoi+0x35>
     ea7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     eae:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
     eb0:	83 c2 01             	add    $0x1,%edx
     eb3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
     eb6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
     eba:	0f be 02             	movsbl (%edx),%eax
     ebd:	8d 58 d0             	lea    -0x30(%eax),%ebx
     ec0:	80 fb 09             	cmp    $0x9,%bl
     ec3:	76 eb                	jbe    eb0 <atoi+0x20>
  return n;
}
     ec5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ec8:	89 c8                	mov    %ecx,%eax
     eca:	c9                   	leave  
     ecb:	c3                   	ret    
     ecc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000ed0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     ed0:	55                   	push   %ebp
     ed1:	89 e5                	mov    %esp,%ebp
     ed3:	57                   	push   %edi
     ed4:	8b 45 10             	mov    0x10(%ebp),%eax
     ed7:	8b 55 08             	mov    0x8(%ebp),%edx
     eda:	56                   	push   %esi
     edb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     ede:	85 c0                	test   %eax,%eax
     ee0:	7e 13                	jle    ef5 <memmove+0x25>
     ee2:	01 d0                	add    %edx,%eax
  dst = vdst;
     ee4:	89 d7                	mov    %edx,%edi
     ee6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     eed:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
     ef0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
     ef1:	39 f8                	cmp    %edi,%eax
     ef3:	75 fb                	jne    ef0 <memmove+0x20>
  return vdst;
}
     ef5:	5e                   	pop    %esi
     ef6:	89 d0                	mov    %edx,%eax
     ef8:	5f                   	pop    %edi
     ef9:	5d                   	pop    %ebp
     efa:	c3                   	ret    

00000efb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     efb:	b8 01 00 00 00       	mov    $0x1,%eax
     f00:	cd 40                	int    $0x40
     f02:	c3                   	ret    

00000f03 <exit>:
SYSCALL(exit)
     f03:	b8 02 00 00 00       	mov    $0x2,%eax
     f08:	cd 40                	int    $0x40
     f0a:	c3                   	ret    

00000f0b <wait>:
SYSCALL(wait)
     f0b:	b8 03 00 00 00       	mov    $0x3,%eax
     f10:	cd 40                	int    $0x40
     f12:	c3                   	ret    

00000f13 <pipe>:
SYSCALL(pipe)
     f13:	b8 04 00 00 00       	mov    $0x4,%eax
     f18:	cd 40                	int    $0x40
     f1a:	c3                   	ret    

00000f1b <read>:
SYSCALL(read)
     f1b:	b8 05 00 00 00       	mov    $0x5,%eax
     f20:	cd 40                	int    $0x40
     f22:	c3                   	ret    

00000f23 <write>:
SYSCALL(write)
     f23:	b8 10 00 00 00       	mov    $0x10,%eax
     f28:	cd 40                	int    $0x40
     f2a:	c3                   	ret    

00000f2b <close>:
SYSCALL(close)
     f2b:	b8 15 00 00 00       	mov    $0x15,%eax
     f30:	cd 40                	int    $0x40
     f32:	c3                   	ret    

00000f33 <kill>:
SYSCALL(kill)
     f33:	b8 06 00 00 00       	mov    $0x6,%eax
     f38:	cd 40                	int    $0x40
     f3a:	c3                   	ret    

00000f3b <exec>:
SYSCALL(exec)
     f3b:	b8 07 00 00 00       	mov    $0x7,%eax
     f40:	cd 40                	int    $0x40
     f42:	c3                   	ret    

00000f43 <open>:
SYSCALL(open)
     f43:	b8 0f 00 00 00       	mov    $0xf,%eax
     f48:	cd 40                	int    $0x40
     f4a:	c3                   	ret    

00000f4b <mknod>:
SYSCALL(mknod)
     f4b:	b8 11 00 00 00       	mov    $0x11,%eax
     f50:	cd 40                	int    $0x40
     f52:	c3                   	ret    

00000f53 <unlink>:
SYSCALL(unlink)
     f53:	b8 12 00 00 00       	mov    $0x12,%eax
     f58:	cd 40                	int    $0x40
     f5a:	c3                   	ret    

00000f5b <fstat>:
SYSCALL(fstat)
     f5b:	b8 08 00 00 00       	mov    $0x8,%eax
     f60:	cd 40                	int    $0x40
     f62:	c3                   	ret    

00000f63 <link>:
SYSCALL(link)
     f63:	b8 13 00 00 00       	mov    $0x13,%eax
     f68:	cd 40                	int    $0x40
     f6a:	c3                   	ret    

00000f6b <mkdir>:
SYSCALL(mkdir)
     f6b:	b8 14 00 00 00       	mov    $0x14,%eax
     f70:	cd 40                	int    $0x40
     f72:	c3                   	ret    

00000f73 <chdir>:
SYSCALL(chdir)
     f73:	b8 09 00 00 00       	mov    $0x9,%eax
     f78:	cd 40                	int    $0x40
     f7a:	c3                   	ret    

00000f7b <dup>:
SYSCALL(dup)
     f7b:	b8 0a 00 00 00       	mov    $0xa,%eax
     f80:	cd 40                	int    $0x40
     f82:	c3                   	ret    

00000f83 <getpid>:
SYSCALL(getpid)
     f83:	b8 0b 00 00 00       	mov    $0xb,%eax
     f88:	cd 40                	int    $0x40
     f8a:	c3                   	ret    

00000f8b <sbrk>:
SYSCALL(sbrk)
     f8b:	b8 0c 00 00 00       	mov    $0xc,%eax
     f90:	cd 40                	int    $0x40
     f92:	c3                   	ret    

00000f93 <sleep>:
SYSCALL(sleep)
     f93:	b8 0d 00 00 00       	mov    $0xd,%eax
     f98:	cd 40                	int    $0x40
     f9a:	c3                   	ret    

00000f9b <uptime>:
SYSCALL(uptime)
     f9b:	b8 0e 00 00 00       	mov    $0xe,%eax
     fa0:	cd 40                	int    $0x40
     fa2:	c3                   	ret    

00000fa3 <create_palindrome>:
SYSCALL(create_palindrome)
     fa3:	b8 16 00 00 00       	mov    $0x16,%eax
     fa8:	cd 40                	int    $0x40
     faa:	c3                   	ret    

00000fab <list_all_processes>:
SYSCALL(list_all_processes)
     fab:	b8 19 00 00 00       	mov    $0x19,%eax
     fb0:	cd 40                	int    $0x40
     fb2:	c3                   	ret    

00000fb3 <setqueue>:
SYSCALL(setqueue)
     fb3:	b8 1a 00 00 00       	mov    $0x1a,%eax
     fb8:	cd 40                	int    $0x40
     fba:	c3                   	ret    

00000fbb <printinfo>:
SYSCALL(printinfo)
     fbb:	b8 1b 00 00 00       	mov    $0x1b,%eax
     fc0:	cd 40                	int    $0x40
     fc2:	c3                   	ret    

00000fc3 <setburstconf>:
SYSCALL(setburstconf)
     fc3:	b8 1c 00 00 00       	mov    $0x1c,%eax
     fc8:	cd 40                	int    $0x40
     fca:	c3                   	ret    

00000fcb <count_syscalls>:
SYSCALL(count_syscalls)
     fcb:	b8 1d 00 00 00       	mov    $0x1d,%eax
     fd0:	cd 40                	int    $0x40
     fd2:	c3                   	ret    

00000fd3 <init_reentrantlock>:
SYSCALL(init_reentrantlock)
     fd3:	b8 1e 00 00 00       	mov    $0x1e,%eax
     fd8:	cd 40                	int    $0x40
     fda:	c3                   	ret    

00000fdb <acquire_reentrantlock>:
SYSCALL(acquire_reentrantlock)
     fdb:	b8 1f 00 00 00       	mov    $0x1f,%eax
     fe0:	cd 40                	int    $0x40
     fe2:	c3                   	ret    

00000fe3 <release_reentrantlock>:
     fe3:	b8 20 00 00 00       	mov    $0x20,%eax
     fe8:	cd 40                	int    $0x40
     fea:	c3                   	ret    
     feb:	66 90                	xchg   %ax,%ax
     fed:	66 90                	xchg   %ax,%ax
     fef:	90                   	nop

00000ff0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     ff0:	55                   	push   %ebp
     ff1:	89 e5                	mov    %esp,%ebp
     ff3:	57                   	push   %edi
     ff4:	56                   	push   %esi
     ff5:	53                   	push   %ebx
     ff6:	83 ec 3c             	sub    $0x3c,%esp
     ff9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
     ffc:	89 d1                	mov    %edx,%ecx
{
     ffe:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    1001:	85 d2                	test   %edx,%edx
    1003:	0f 89 7f 00 00 00    	jns    1088 <printint+0x98>
    1009:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    100d:	74 79                	je     1088 <printint+0x98>
    neg = 1;
    100f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    1016:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    1018:	31 db                	xor    %ebx,%ebx
    101a:	8d 75 d7             	lea    -0x29(%ebp),%esi
    101d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    1020:	89 c8                	mov    %ecx,%eax
    1022:	31 d2                	xor    %edx,%edx
    1024:	89 cf                	mov    %ecx,%edi
    1026:	f7 75 c4             	divl   -0x3c(%ebp)
    1029:	0f b6 92 20 15 00 00 	movzbl 0x1520(%edx),%edx
    1030:	89 45 c0             	mov    %eax,-0x40(%ebp)
    1033:	89 d8                	mov    %ebx,%eax
    1035:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    1038:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    103b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    103e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    1041:	76 dd                	jbe    1020 <printint+0x30>
  if(neg)
    1043:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    1046:	85 c9                	test   %ecx,%ecx
    1048:	74 0c                	je     1056 <printint+0x66>
    buf[i++] = '-';
    104a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    104f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    1051:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    1056:	8b 7d b8             	mov    -0x48(%ebp),%edi
    1059:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    105d:	eb 07                	jmp    1066 <printint+0x76>
    105f:	90                   	nop
    putc(fd, buf[i]);
    1060:	0f b6 13             	movzbl (%ebx),%edx
    1063:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    1066:	83 ec 04             	sub    $0x4,%esp
    1069:	88 55 d7             	mov    %dl,-0x29(%ebp)
    106c:	6a 01                	push   $0x1
    106e:	56                   	push   %esi
    106f:	57                   	push   %edi
    1070:	e8 ae fe ff ff       	call   f23 <write>
  while(--i >= 0)
    1075:	83 c4 10             	add    $0x10,%esp
    1078:	39 de                	cmp    %ebx,%esi
    107a:	75 e4                	jne    1060 <printint+0x70>
}
    107c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    107f:	5b                   	pop    %ebx
    1080:	5e                   	pop    %esi
    1081:	5f                   	pop    %edi
    1082:	5d                   	pop    %ebp
    1083:	c3                   	ret    
    1084:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    1088:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    108f:	eb 87                	jmp    1018 <printint+0x28>
    1091:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1098:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    109f:	90                   	nop

000010a0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    10a0:	55                   	push   %ebp
    10a1:	89 e5                	mov    %esp,%ebp
    10a3:	57                   	push   %edi
    10a4:	56                   	push   %esi
    10a5:	53                   	push   %ebx
    10a6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    10a9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
    10ac:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
    10af:	0f b6 13             	movzbl (%ebx),%edx
    10b2:	84 d2                	test   %dl,%dl
    10b4:	74 6a                	je     1120 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
    10b6:	8d 45 10             	lea    0x10(%ebp),%eax
    10b9:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
    10bc:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    10bf:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
    10c1:	89 45 d0             	mov    %eax,-0x30(%ebp)
    10c4:	eb 36                	jmp    10fc <printf+0x5c>
    10c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10cd:	8d 76 00             	lea    0x0(%esi),%esi
    10d0:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    10d3:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
    10d8:	83 f8 25             	cmp    $0x25,%eax
    10db:	74 15                	je     10f2 <printf+0x52>
  write(fd, &c, 1);
    10dd:	83 ec 04             	sub    $0x4,%esp
    10e0:	88 55 e7             	mov    %dl,-0x19(%ebp)
    10e3:	6a 01                	push   $0x1
    10e5:	57                   	push   %edi
    10e6:	56                   	push   %esi
    10e7:	e8 37 fe ff ff       	call   f23 <write>
    10ec:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
    10ef:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    10f2:	0f b6 13             	movzbl (%ebx),%edx
    10f5:	83 c3 01             	add    $0x1,%ebx
    10f8:	84 d2                	test   %dl,%dl
    10fa:	74 24                	je     1120 <printf+0x80>
    c = fmt[i] & 0xff;
    10fc:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
    10ff:	85 c9                	test   %ecx,%ecx
    1101:	74 cd                	je     10d0 <printf+0x30>
      }
    } else if(state == '%'){
    1103:	83 f9 25             	cmp    $0x25,%ecx
    1106:	75 ea                	jne    10f2 <printf+0x52>
      if(c == 'd'){
    1108:	83 f8 25             	cmp    $0x25,%eax
    110b:	0f 84 07 01 00 00    	je     1218 <printf+0x178>
    1111:	83 e8 63             	sub    $0x63,%eax
    1114:	83 f8 15             	cmp    $0x15,%eax
    1117:	77 17                	ja     1130 <printf+0x90>
    1119:	ff 24 85 c8 14 00 00 	jmp    *0x14c8(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1120:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1123:	5b                   	pop    %ebx
    1124:	5e                   	pop    %esi
    1125:	5f                   	pop    %edi
    1126:	5d                   	pop    %ebp
    1127:	c3                   	ret    
    1128:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    112f:	90                   	nop
  write(fd, &c, 1);
    1130:	83 ec 04             	sub    $0x4,%esp
    1133:	88 55 d4             	mov    %dl,-0x2c(%ebp)
    1136:	6a 01                	push   $0x1
    1138:	57                   	push   %edi
    1139:	56                   	push   %esi
    113a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    113e:	e8 e0 fd ff ff       	call   f23 <write>
        putc(fd, c);
    1143:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
    1147:	83 c4 0c             	add    $0xc,%esp
    114a:	88 55 e7             	mov    %dl,-0x19(%ebp)
    114d:	6a 01                	push   $0x1
    114f:	57                   	push   %edi
    1150:	56                   	push   %esi
    1151:	e8 cd fd ff ff       	call   f23 <write>
        putc(fd, c);
    1156:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1159:	31 c9                	xor    %ecx,%ecx
    115b:	eb 95                	jmp    10f2 <printf+0x52>
    115d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    1160:	83 ec 0c             	sub    $0xc,%esp
    1163:	b9 10 00 00 00       	mov    $0x10,%ecx
    1168:	6a 00                	push   $0x0
    116a:	8b 45 d0             	mov    -0x30(%ebp),%eax
    116d:	8b 10                	mov    (%eax),%edx
    116f:	89 f0                	mov    %esi,%eax
    1171:	e8 7a fe ff ff       	call   ff0 <printint>
        ap++;
    1176:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    117a:	83 c4 10             	add    $0x10,%esp
      state = 0;
    117d:	31 c9                	xor    %ecx,%ecx
    117f:	e9 6e ff ff ff       	jmp    10f2 <printf+0x52>
    1184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    1188:	8b 45 d0             	mov    -0x30(%ebp),%eax
    118b:	8b 10                	mov    (%eax),%edx
        ap++;
    118d:	83 c0 04             	add    $0x4,%eax
    1190:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    1193:	85 d2                	test   %edx,%edx
    1195:	0f 84 8d 00 00 00    	je     1228 <printf+0x188>
        while(*s != 0){
    119b:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
    119e:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
    11a0:	84 c0                	test   %al,%al
    11a2:	0f 84 4a ff ff ff    	je     10f2 <printf+0x52>
    11a8:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    11ab:	89 d3                	mov    %edx,%ebx
    11ad:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    11b0:	83 ec 04             	sub    $0x4,%esp
          s++;
    11b3:	83 c3 01             	add    $0x1,%ebx
    11b6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    11b9:	6a 01                	push   $0x1
    11bb:	57                   	push   %edi
    11bc:	56                   	push   %esi
    11bd:	e8 61 fd ff ff       	call   f23 <write>
        while(*s != 0){
    11c2:	0f b6 03             	movzbl (%ebx),%eax
    11c5:	83 c4 10             	add    $0x10,%esp
    11c8:	84 c0                	test   %al,%al
    11ca:	75 e4                	jne    11b0 <printf+0x110>
      state = 0;
    11cc:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
    11cf:	31 c9                	xor    %ecx,%ecx
    11d1:	e9 1c ff ff ff       	jmp    10f2 <printf+0x52>
    11d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    11dd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    11e0:	83 ec 0c             	sub    $0xc,%esp
    11e3:	b9 0a 00 00 00       	mov    $0xa,%ecx
    11e8:	6a 01                	push   $0x1
    11ea:	e9 7b ff ff ff       	jmp    116a <printf+0xca>
    11ef:	90                   	nop
        putc(fd, *ap);
    11f0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
    11f3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    11f6:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
    11f8:	6a 01                	push   $0x1
    11fa:	57                   	push   %edi
    11fb:	56                   	push   %esi
        putc(fd, *ap);
    11fc:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    11ff:	e8 1f fd ff ff       	call   f23 <write>
        ap++;
    1204:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    1208:	83 c4 10             	add    $0x10,%esp
      state = 0;
    120b:	31 c9                	xor    %ecx,%ecx
    120d:	e9 e0 fe ff ff       	jmp    10f2 <printf+0x52>
    1212:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
    1218:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
    121b:	83 ec 04             	sub    $0x4,%esp
    121e:	e9 2a ff ff ff       	jmp    114d <printf+0xad>
    1223:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1227:	90                   	nop
          s = "(null)";
    1228:	ba c0 14 00 00       	mov    $0x14c0,%edx
        while(*s != 0){
    122d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    1230:	b8 28 00 00 00       	mov    $0x28,%eax
    1235:	89 d3                	mov    %edx,%ebx
    1237:	e9 74 ff ff ff       	jmp    11b0 <printf+0x110>
    123c:	66 90                	xchg   %ax,%ax
    123e:	66 90                	xchg   %ax,%ax

00001240 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1240:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1241:	a1 a4 20 00 00       	mov    0x20a4,%eax
{
    1246:	89 e5                	mov    %esp,%ebp
    1248:	57                   	push   %edi
    1249:	56                   	push   %esi
    124a:	53                   	push   %ebx
    124b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    124e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1251:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1258:	89 c2                	mov    %eax,%edx
    125a:	8b 00                	mov    (%eax),%eax
    125c:	39 ca                	cmp    %ecx,%edx
    125e:	73 30                	jae    1290 <free+0x50>
    1260:	39 c1                	cmp    %eax,%ecx
    1262:	72 04                	jb     1268 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1264:	39 c2                	cmp    %eax,%edx
    1266:	72 f0                	jb     1258 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1268:	8b 73 fc             	mov    -0x4(%ebx),%esi
    126b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    126e:	39 f8                	cmp    %edi,%eax
    1270:	74 30                	je     12a2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    1272:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    1275:	8b 42 04             	mov    0x4(%edx),%eax
    1278:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    127b:	39 f1                	cmp    %esi,%ecx
    127d:	74 3a                	je     12b9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    127f:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
    1281:	5b                   	pop    %ebx
  freep = p;
    1282:	89 15 a4 20 00 00    	mov    %edx,0x20a4
}
    1288:	5e                   	pop    %esi
    1289:	5f                   	pop    %edi
    128a:	5d                   	pop    %ebp
    128b:	c3                   	ret    
    128c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1290:	39 c2                	cmp    %eax,%edx
    1292:	72 c4                	jb     1258 <free+0x18>
    1294:	39 c1                	cmp    %eax,%ecx
    1296:	73 c0                	jae    1258 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    1298:	8b 73 fc             	mov    -0x4(%ebx),%esi
    129b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    129e:	39 f8                	cmp    %edi,%eax
    12a0:	75 d0                	jne    1272 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    12a2:	03 70 04             	add    0x4(%eax),%esi
    12a5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    12a8:	8b 02                	mov    (%edx),%eax
    12aa:	8b 00                	mov    (%eax),%eax
    12ac:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    12af:	8b 42 04             	mov    0x4(%edx),%eax
    12b2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    12b5:	39 f1                	cmp    %esi,%ecx
    12b7:	75 c6                	jne    127f <free+0x3f>
    p->s.size += bp->s.size;
    12b9:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    12bc:	89 15 a4 20 00 00    	mov    %edx,0x20a4
    p->s.size += bp->s.size;
    12c2:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    12c5:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    12c8:	89 0a                	mov    %ecx,(%edx)
}
    12ca:	5b                   	pop    %ebx
    12cb:	5e                   	pop    %esi
    12cc:	5f                   	pop    %edi
    12cd:	5d                   	pop    %ebp
    12ce:	c3                   	ret    
    12cf:	90                   	nop

000012d0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    12d0:	55                   	push   %ebp
    12d1:	89 e5                	mov    %esp,%ebp
    12d3:	57                   	push   %edi
    12d4:	56                   	push   %esi
    12d5:	53                   	push   %ebx
    12d6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    12d9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    12dc:	8b 3d a4 20 00 00    	mov    0x20a4,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    12e2:	8d 70 07             	lea    0x7(%eax),%esi
    12e5:	c1 ee 03             	shr    $0x3,%esi
    12e8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    12eb:	85 ff                	test   %edi,%edi
    12ed:	0f 84 9d 00 00 00    	je     1390 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    12f3:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
    12f5:	8b 4a 04             	mov    0x4(%edx),%ecx
    12f8:	39 f1                	cmp    %esi,%ecx
    12fa:	73 6a                	jae    1366 <malloc+0x96>
    12fc:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1301:	39 de                	cmp    %ebx,%esi
    1303:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    1306:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    130d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1310:	eb 17                	jmp    1329 <malloc+0x59>
    1312:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1318:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    131a:	8b 48 04             	mov    0x4(%eax),%ecx
    131d:	39 f1                	cmp    %esi,%ecx
    131f:	73 4f                	jae    1370 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1321:	8b 3d a4 20 00 00    	mov    0x20a4,%edi
    1327:	89 c2                	mov    %eax,%edx
    1329:	39 d7                	cmp    %edx,%edi
    132b:	75 eb                	jne    1318 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    132d:	83 ec 0c             	sub    $0xc,%esp
    1330:	ff 75 e4             	push   -0x1c(%ebp)
    1333:	e8 53 fc ff ff       	call   f8b <sbrk>
  if(p == (char*)-1)
    1338:	83 c4 10             	add    $0x10,%esp
    133b:	83 f8 ff             	cmp    $0xffffffff,%eax
    133e:	74 1c                	je     135c <malloc+0x8c>
  hp->s.size = nu;
    1340:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    1343:	83 ec 0c             	sub    $0xc,%esp
    1346:	83 c0 08             	add    $0x8,%eax
    1349:	50                   	push   %eax
    134a:	e8 f1 fe ff ff       	call   1240 <free>
  return freep;
    134f:	8b 15 a4 20 00 00    	mov    0x20a4,%edx
      if((p = morecore(nunits)) == 0)
    1355:	83 c4 10             	add    $0x10,%esp
    1358:	85 d2                	test   %edx,%edx
    135a:	75 bc                	jne    1318 <malloc+0x48>
        return 0;
  }
}
    135c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    135f:	31 c0                	xor    %eax,%eax
}
    1361:	5b                   	pop    %ebx
    1362:	5e                   	pop    %esi
    1363:	5f                   	pop    %edi
    1364:	5d                   	pop    %ebp
    1365:	c3                   	ret    
    if(p->s.size >= nunits){
    1366:	89 d0                	mov    %edx,%eax
    1368:	89 fa                	mov    %edi,%edx
    136a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1370:	39 ce                	cmp    %ecx,%esi
    1372:	74 4c                	je     13c0 <malloc+0xf0>
        p->s.size -= nunits;
    1374:	29 f1                	sub    %esi,%ecx
    1376:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1379:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    137c:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
    137f:	89 15 a4 20 00 00    	mov    %edx,0x20a4
}
    1385:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1388:	83 c0 08             	add    $0x8,%eax
}
    138b:	5b                   	pop    %ebx
    138c:	5e                   	pop    %esi
    138d:	5f                   	pop    %edi
    138e:	5d                   	pop    %ebp
    138f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
    1390:	c7 05 a4 20 00 00 a8 	movl   $0x20a8,0x20a4
    1397:	20 00 00 
    base.s.size = 0;
    139a:	bf a8 20 00 00       	mov    $0x20a8,%edi
    base.s.ptr = freep = prevp = &base;
    139f:	c7 05 a8 20 00 00 a8 	movl   $0x20a8,0x20a8
    13a6:	20 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    13a9:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
    13ab:	c7 05 ac 20 00 00 00 	movl   $0x0,0x20ac
    13b2:	00 00 00 
    if(p->s.size >= nunits){
    13b5:	e9 42 ff ff ff       	jmp    12fc <malloc+0x2c>
    13ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    13c0:	8b 08                	mov    (%eax),%ecx
    13c2:	89 0a                	mov    %ecx,(%edx)
    13c4:	eb b9                	jmp    137f <malloc+0xaf>
