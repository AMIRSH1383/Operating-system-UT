
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
      26:	68 f1 14 00 00       	push   $0x14f1
      2b:	e8 63 0f 00 00       	call   f93 <open>
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
      40:	83 3d 60 1b 00 00 0a 	cmpl   $0xa,0x1b60
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
      58:	a1 60 1b 00 00       	mov    0x1b60,%eax
      5d:	0f b6 93 80 20 00 00 	movzbl 0x2080(%ebx),%edx
      64:	c1 e0 07             	shl    $0x7,%eax
      67:	88 94 03 80 1b 00 00 	mov    %dl,0x1b80(%ebx,%eax,1)
      for(int i = 0; i<strlen(buf);i++)
      6e:	83 c3 01             	add    $0x1,%ebx
      71:	83 ec 0c             	sub    $0xc,%esp
      74:	68 80 20 00 00       	push   $0x2080
      79:	e8 12 0d 00 00       	call   d90 <strlen>
      7e:	83 c4 10             	add    $0x10,%esp
      81:	39 d8                	cmp    %ebx,%eax
      83:	77 d3                	ja     58 <main+0x58>
      }
      num_of_commands++;
      85:	83 05 60 1b 00 00 01 	addl   $0x1,0x1b60
int
fork1(void)
{
  int pid;

  pid = fork();
      8c:	e8 ba 0e 00 00       	call   f4b <fork>
  if(pid == -1)
      91:	83 f8 ff             	cmp    $0xffffffff,%eax
      94:	0f 84 34 01 00 00    	je     1ce <main+0x1ce>
    if(fork1() == 0)
      9a:	85 c0                	test   %eax,%eax
      9c:	0f 84 12 01 00 00    	je     1b4 <main+0x1b4>
    wait();
      a2:	e8 b4 0e 00 00       	call   f5b <wait>
  printf(2, "$ ");
      a7:	83 ec 08             	sub    $0x8,%esp
      aa:	68 48 14 00 00       	push   $0x1448
      af:	6a 02                	push   $0x2
      b1:	e8 2a 10 00 00       	call   10e0 <printf>
  memset(buf, 0, nbuf);
      b6:	83 c4 0c             	add    $0xc,%esp
      b9:	6a 64                	push   $0x64
      bb:	6a 00                	push   $0x0
      bd:	68 80 20 00 00       	push   $0x2080
      c2:	e8 f9 0c 00 00       	call   dc0 <memset>
  gets(buf, nbuf);
      c7:	58                   	pop    %eax
      c8:	5a                   	pop    %edx
      c9:	6a 64                	push   $0x64
      cb:	68 80 20 00 00       	push   $0x2080
      d0:	e8 4b 0d 00 00       	call   e20 <gets>
  if(buf[0] == 0) // EOF
      d5:	0f b6 05 80 20 00 00 	movzbl 0x2080,%eax
      dc:	83 c4 10             	add    $0x10,%esp
      df:	84 c0                	test   %al,%al
      e1:	0f 84 e2 00 00 00    	je     1c9 <main+0x1c9>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      e7:	3c 63                	cmp    $0x63,%al
      e9:	75 09                	jne    f4 <main+0xf4>
      eb:	80 3d 81 20 00 00 64 	cmpb   $0x64,0x2081
      f2:	74 2c                	je     120 <main+0x120>
    if(strcmp(buf,HISTORY_WITH_SPACE) != 0)
      f4:	83 ec 08             	sub    $0x8,%esp
      f7:	68 07 15 00 00       	push   $0x1507
      fc:	68 80 20 00 00       	push   $0x2080
     101:	e8 3a 0c 00 00       	call   d40 <strcmp>
     106:	83 c4 10             	add    $0x10,%esp
     109:	85 c0                	test   %eax,%eax
     10b:	0f 84 7b ff ff ff    	je     8c <main+0x8c>
     111:	e9 2a ff ff ff       	jmp    40 <main+0x40>
     116:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     11d:	00 
     11e:	66 90                	xchg   %ax,%ax
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     120:	80 3d 82 20 00 00 20 	cmpb   $0x20,0x2082
     127:	75 cb                	jne    f4 <main+0xf4>
      buf[strlen(buf)-1] = 0;  // chop \n
     129:	83 ec 0c             	sub    $0xc,%esp
     12c:	68 80 20 00 00       	push   $0x2080
     131:	e8 5a 0c 00 00       	call   d90 <strlen>
      if(chdir(buf+3) < 0)
     136:	c7 04 24 83 20 00 00 	movl   $0x2083,(%esp)
      buf[strlen(buf)-1] = 0;  // chop \n
     13d:	c6 80 7f 20 00 00 00 	movb   $0x0,0x207f(%eax)
      if(chdir(buf+3) < 0)
     144:	e8 7a 0e 00 00       	call   fc3 <chdir>
     149:	83 c4 10             	add    $0x10,%esp
     14c:	85 c0                	test   %eax,%eax
     14e:	0f 89 53 ff ff ff    	jns    a7 <main+0xa7>
        printf(2, "cannot cd %s\n", buf+3);
     154:	51                   	push   %ecx
     155:	68 83 20 00 00       	push   $0x2083
     15a:	68 f9 14 00 00       	push   $0x14f9
     15f:	6a 02                	push   $0x2
     161:	e8 7a 0f 00 00       	call   10e0 <printf>
     166:	83 c4 10             	add    $0x10,%esp
     169:	e9 39 ff ff ff       	jmp    a7 <main+0xa7>
     16e:	bb 80 1b 00 00       	mov    $0x1b80,%ebx
     173:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
          memmove(history_of_commands[i], history_of_commands[i+1], sizeof(char)* MAX_LEN_OF_COMMAND);
     178:	83 ec 04             	sub    $0x4,%esp
     17b:	89 d8                	mov    %ebx,%eax
     17d:	83 eb 80             	sub    $0xffffff80,%ebx
     180:	68 80 00 00 00       	push   $0x80
     185:	53                   	push   %ebx
     186:	50                   	push   %eax
     187:	e8 94 0d 00 00       	call   f20 <memmove>
        for(int i = 0; i < MAX_NUM_OF_HISTORY - 1; i++)
     18c:	83 c4 10             	add    $0x10,%esp
     18f:	81 fb 00 20 00 00    	cmp    $0x2000,%ebx
     195:	75 e1                	jne    178 <main+0x178>
        num_of_commands--;
     197:	83 2d 60 1b 00 00 01 	subl   $0x1,0x1b60
     19e:	e9 aa fe ff ff       	jmp    4d <main+0x4d>
      close(fd);
     1a3:	83 ec 0c             	sub    $0xc,%esp
     1a6:	50                   	push   %eax
     1a7:	e8 cf 0d 00 00       	call   f7b <close>
      break;
     1ac:	83 c4 10             	add    $0x10,%esp
     1af:	e9 f3 fe ff ff       	jmp    a7 <main+0xa7>
      runcmd(parsecmd(buf));
     1b4:	83 ec 0c             	sub    $0xc,%esp
     1b7:	68 80 20 00 00       	push   $0x2080
     1bc:	e8 df 0a 00 00       	call   ca0 <parsecmd>
     1c1:	89 04 24             	mov    %eax,(%esp)
     1c4:	e8 a7 00 00 00       	call   270 <runcmd>
  exit();
     1c9:	e8 85 0d 00 00       	call   f53 <exit>
    panic("fork");
     1ce:	83 ec 0c             	sub    $0xc,%esp
     1d1:	68 4b 14 00 00       	push   $0x144b
     1d6:	e8 55 00 00 00       	call   230 <panic>
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
     1ee:	68 48 14 00 00       	push   $0x1448
     1f3:	6a 02                	push   $0x2
     1f5:	e8 e6 0e 00 00       	call   10e0 <printf>
  memset(buf, 0, nbuf);
     1fa:	83 c4 0c             	add    $0xc,%esp
     1fd:	56                   	push   %esi
     1fe:	6a 00                	push   $0x0
     200:	53                   	push   %ebx
     201:	e8 ba 0b 00 00       	call   dc0 <memset>
  gets(buf, nbuf);
     206:	58                   	pop    %eax
     207:	5a                   	pop    %edx
     208:	56                   	push   %esi
     209:	53                   	push   %ebx
     20a:	e8 11 0c 00 00       	call   e20 <gets>
  if(buf[0] == 0) // EOF
     20f:	83 c4 10             	add    $0x10,%esp
     212:	31 c0                	xor    %eax,%eax
     214:	80 3b 00             	cmpb   $0x0,(%ebx)
     217:	0f 94 c0             	sete   %al
}
     21a:	8d 65 f8             	lea    -0x8(%ebp),%esp
     21d:	5b                   	pop    %ebx
  if(buf[0] == 0) // EOF
     21e:	f7 d8                	neg    %eax
}
     220:	5e                   	pop    %esi
     221:	5d                   	pop    %ebp
     222:	c3                   	ret
     223:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     22a:	00 
     22b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00000230 <panic>:
{
     230:	55                   	push   %ebp
     231:	89 e5                	mov    %esp,%ebp
     233:	83 ec 0c             	sub    $0xc,%esp
  printf(2, "%s\n", s);
     236:	ff 75 08             	push   0x8(%ebp)
     239:	68 ed 14 00 00       	push   $0x14ed
     23e:	6a 02                	push   $0x2
     240:	e8 9b 0e 00 00       	call   10e0 <printf>
  exit();
     245:	e8 09 0d 00 00       	call   f53 <exit>
     24a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000250 <fork1>:
{
     250:	55                   	push   %ebp
     251:	89 e5                	mov    %esp,%ebp
     253:	83 ec 08             	sub    $0x8,%esp
  pid = fork();
     256:	e8 f0 0c 00 00       	call   f4b <fork>
  if(pid == -1)
     25b:	83 f8 ff             	cmp    $0xffffffff,%eax
     25e:	74 02                	je     262 <fork1+0x12>
  return pid;
}
     260:	c9                   	leave
     261:	c3                   	ret
    panic("fork");
     262:	83 ec 0c             	sub    $0xc,%esp
     265:	68 4b 14 00 00       	push   $0x144b
     26a:	e8 c1 ff ff ff       	call   230 <panic>
     26f:	90                   	nop

00000270 <runcmd>:
{
     270:	55                   	push   %ebp
     271:	89 e5                	mov    %esp,%ebp
     273:	53                   	push   %ebx
     274:	83 ec 14             	sub    $0x14,%esp
     277:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(cmd == 0)
     27a:	85 db                	test   %ebx,%ebx
     27c:	74 5a                	je     2d8 <runcmd+0x68>
  switch(cmd->type){
     27e:	83 3b 05             	cmpl   $0x5,(%ebx)
     281:	0f 87 f8 00 00 00    	ja     37f <runcmd+0x10f>
     287:	8b 03                	mov    (%ebx),%eax
     289:	ff 24 85 18 15 00 00 	jmp    *0x1518(,%eax,4)
    if(ecmd->argv[0] == 0)
     290:	8b 43 04             	mov    0x4(%ebx),%eax
     293:	85 c0                	test   %eax,%eax
     295:	74 41                	je     2d8 <runcmd+0x68>
    if(strcmp(ecmd->argv[0],HISTORY)==0)
     297:	52                   	push   %edx
     298:	52                   	push   %edx
     299:	68 57 14 00 00       	push   $0x1457
     29e:	50                   	push   %eax
     29f:	e8 9c 0a 00 00       	call   d40 <strcmp>
     2a4:	83 c4 10             	add    $0x10,%esp
     2a7:	85 c0                	test   %eax,%eax
     2a9:	0f 84 ff 00 00 00    	je     3ae <runcmd+0x13e>
    exec(ecmd->argv[0], ecmd->argv);
     2af:	8d 43 04             	lea    0x4(%ebx),%eax
     2b2:	51                   	push   %ecx
     2b3:	51                   	push   %ecx
     2b4:	50                   	push   %eax
     2b5:	ff 73 04             	push   0x4(%ebx)
     2b8:	e8 ce 0c 00 00       	call   f8b <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     2bd:	83 c4 0c             	add    $0xc,%esp
     2c0:	ff 73 04             	push   0x4(%ebx)
     2c3:	68 5f 14 00 00       	push   $0x145f
     2c8:	6a 02                	push   $0x2
     2ca:	e8 11 0e 00 00       	call   10e0 <printf>
    break;
     2cf:	83 c4 10             	add    $0x10,%esp
     2d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
     2d8:	e8 76 0c 00 00       	call   f53 <exit>
    if(fork1() == 0)
     2dd:	e8 6e ff ff ff       	call   250 <fork1>
     2e2:	85 c0                	test   %eax,%eax
     2e4:	75 f2                	jne    2d8 <runcmd+0x68>
     2e6:	eb 73                	jmp    35b <runcmd+0xeb>
    if(pipe(p) < 0)
     2e8:	83 ec 0c             	sub    $0xc,%esp
     2eb:	8d 45 f0             	lea    -0x10(%ebp),%eax
     2ee:	50                   	push   %eax
     2ef:	e8 6f 0c 00 00       	call   f63 <pipe>
     2f4:	83 c4 10             	add    $0x10,%esp
     2f7:	85 c0                	test   %eax,%eax
     2f9:	0f 88 a2 00 00 00    	js     3a1 <runcmd+0x131>
    if(fork1() == 0){
     2ff:	e8 4c ff ff ff       	call   250 <fork1>
     304:	85 c0                	test   %eax,%eax
     306:	0f 84 f5 00 00 00    	je     401 <runcmd+0x191>
    if(fork1() == 0){
     30c:	e8 3f ff ff ff       	call   250 <fork1>
     311:	85 c0                	test   %eax,%eax
     313:	0f 84 ba 00 00 00    	je     3d3 <runcmd+0x163>
    close(p[0]);
     319:	83 ec 0c             	sub    $0xc,%esp
     31c:	ff 75 f0             	push   -0x10(%ebp)
     31f:	e8 57 0c 00 00       	call   f7b <close>
    close(p[1]);
     324:	58                   	pop    %eax
     325:	ff 75 f4             	push   -0xc(%ebp)
     328:	e8 4e 0c 00 00       	call   f7b <close>
    wait();
     32d:	e8 29 0c 00 00       	call   f5b <wait>
    wait();
     332:	e8 24 0c 00 00       	call   f5b <wait>
    break;
     337:	83 c4 10             	add    $0x10,%esp
     33a:	eb 9c                	jmp    2d8 <runcmd+0x68>
    close(rcmd->fd);
     33c:	83 ec 0c             	sub    $0xc,%esp
     33f:	ff 73 14             	push   0x14(%ebx)
     342:	e8 34 0c 00 00       	call   f7b <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     347:	58                   	pop    %eax
     348:	5a                   	pop    %edx
     349:	ff 73 10             	push   0x10(%ebx)
     34c:	ff 73 08             	push   0x8(%ebx)
     34f:	e8 3f 0c 00 00       	call   f93 <open>
     354:	83 c4 10             	add    $0x10,%esp
     357:	85 c0                	test   %eax,%eax
     359:	78 31                	js     38c <runcmd+0x11c>
      runcmd(bcmd->cmd);
     35b:	83 ec 0c             	sub    $0xc,%esp
     35e:	ff 73 04             	push   0x4(%ebx)
     361:	e8 0a ff ff ff       	call   270 <runcmd>
    if(fork1() == 0)
     366:	e8 e5 fe ff ff       	call   250 <fork1>
     36b:	85 c0                	test   %eax,%eax
     36d:	74 ec                	je     35b <runcmd+0xeb>
    wait();
     36f:	e8 e7 0b 00 00       	call   f5b <wait>
    runcmd(lcmd->right);
     374:	83 ec 0c             	sub    $0xc,%esp
     377:	ff 73 08             	push   0x8(%ebx)
     37a:	e8 f1 fe ff ff       	call   270 <runcmd>
    panic("runcmd");
     37f:	83 ec 0c             	sub    $0xc,%esp
     382:	68 50 14 00 00       	push   $0x1450
     387:	e8 a4 fe ff ff       	call   230 <panic>
      printf(2, "open %s failed\n", rcmd->file);
     38c:	51                   	push   %ecx
     38d:	ff 73 08             	push   0x8(%ebx)
     390:	68 6f 14 00 00       	push   $0x146f
     395:	6a 02                	push   $0x2
     397:	e8 44 0d 00 00       	call   10e0 <printf>
      exit();
     39c:	e8 b2 0b 00 00       	call   f53 <exit>
      panic("pipe");
     3a1:	83 ec 0c             	sub    $0xc,%esp
     3a4:	68 7f 14 00 00       	push   $0x147f
     3a9:	e8 82 fe ff ff       	call   230 <panic>
      for(int i = 0;i<num_of_commands;i++)
     3ae:	8b 0d 60 1b 00 00    	mov    0x1b60,%ecx
     3b4:	31 c0                	xor    %eax,%eax
     3b6:	eb 12                	jmp    3ca <runcmd+0x15a>
        ecmd->argv[i+1] = history_of_commands[i];
     3b8:	89 c2                	mov    %eax,%edx
     3ba:	c1 e2 07             	shl    $0x7,%edx
     3bd:	81 c2 80 1b 00 00    	add    $0x1b80,%edx
     3c3:	89 54 83 08          	mov    %edx,0x8(%ebx,%eax,4)
      for(int i = 0;i<num_of_commands;i++)
     3c7:	83 c0 01             	add    $0x1,%eax
     3ca:	39 c1                	cmp    %eax,%ecx
     3cc:	7f ea                	jg     3b8 <runcmd+0x148>
     3ce:	e9 dc fe ff ff       	jmp    2af <runcmd+0x3f>
      close(0);
     3d3:	83 ec 0c             	sub    $0xc,%esp
     3d6:	6a 00                	push   $0x0
     3d8:	e8 9e 0b 00 00       	call   f7b <close>
      dup(p[0]);
     3dd:	5a                   	pop    %edx
     3de:	ff 75 f0             	push   -0x10(%ebp)
     3e1:	e8 e5 0b 00 00       	call   fcb <dup>
      close(p[0]);
     3e6:	59                   	pop    %ecx
     3e7:	ff 75 f0             	push   -0x10(%ebp)
     3ea:	e8 8c 0b 00 00       	call   f7b <close>
      close(p[1]);
     3ef:	58                   	pop    %eax
     3f0:	ff 75 f4             	push   -0xc(%ebp)
     3f3:	e8 83 0b 00 00       	call   f7b <close>
      runcmd(pcmd->right);
     3f8:	58                   	pop    %eax
     3f9:	ff 73 08             	push   0x8(%ebx)
     3fc:	e8 6f fe ff ff       	call   270 <runcmd>
      close(1);
     401:	83 ec 0c             	sub    $0xc,%esp
     404:	6a 01                	push   $0x1
     406:	e8 70 0b 00 00       	call   f7b <close>
      dup(p[1]);
     40b:	58                   	pop    %eax
     40c:	ff 75 f4             	push   -0xc(%ebp)
     40f:	e8 b7 0b 00 00       	call   fcb <dup>
      close(p[0]);
     414:	58                   	pop    %eax
     415:	ff 75 f0             	push   -0x10(%ebp)
     418:	e8 5e 0b 00 00       	call   f7b <close>
      close(p[1]);
     41d:	58                   	pop    %eax
     41e:	ff 75 f4             	push   -0xc(%ebp)
     421:	e8 55 0b 00 00       	call   f7b <close>
      runcmd(pcmd->left);
     426:	5a                   	pop    %edx
     427:	ff 73 04             	push   0x4(%ebx)
     42a:	e8 41 fe ff ff       	call   270 <runcmd>
     42f:	90                   	nop

00000430 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     430:	55                   	push   %ebp
     431:	89 e5                	mov    %esp,%ebp
     433:	53                   	push   %ebx
     434:	83 ec 10             	sub    $0x10,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     437:	68 a4 00 00 00       	push   $0xa4
     43c:	e8 ff 0e 00 00       	call   1340 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     441:	83 c4 0c             	add    $0xc,%esp
     444:	68 a4 00 00 00       	push   $0xa4
  cmd = malloc(sizeof(*cmd));
     449:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     44b:	6a 00                	push   $0x0
     44d:	50                   	push   %eax
     44e:	e8 6d 09 00 00       	call   dc0 <memset>
  cmd->type = EXEC;
     453:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
     459:	89 d8                	mov    %ebx,%eax
     45b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     45e:	c9                   	leave
     45f:	c3                   	ret

00000460 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     460:	55                   	push   %ebp
     461:	89 e5                	mov    %esp,%ebp
     463:	53                   	push   %ebx
     464:	83 ec 10             	sub    $0x10,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     467:	6a 18                	push   $0x18
     469:	e8 d2 0e 00 00       	call   1340 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     46e:	83 c4 0c             	add    $0xc,%esp
     471:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     473:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     475:	6a 00                	push   $0x0
     477:	50                   	push   %eax
     478:	e8 43 09 00 00       	call   dc0 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     47d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = REDIR;
     480:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     486:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     489:	8b 45 0c             	mov    0xc(%ebp),%eax
     48c:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     48f:	8b 45 10             	mov    0x10(%ebp),%eax
     492:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     495:	8b 45 14             	mov    0x14(%ebp),%eax
     498:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     49b:	8b 45 18             	mov    0x18(%ebp),%eax
     49e:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     4a1:	89 d8                	mov    %ebx,%eax
     4a3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     4a6:	c9                   	leave
     4a7:	c3                   	ret
     4a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     4af:	00 

000004b0 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     4b0:	55                   	push   %ebp
     4b1:	89 e5                	mov    %esp,%ebp
     4b3:	53                   	push   %ebx
     4b4:	83 ec 10             	sub    $0x10,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4b7:	6a 0c                	push   $0xc
     4b9:	e8 82 0e 00 00       	call   1340 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     4be:	83 c4 0c             	add    $0xc,%esp
     4c1:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     4c3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     4c5:	6a 00                	push   $0x0
     4c7:	50                   	push   %eax
     4c8:	e8 f3 08 00 00       	call   dc0 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     4cd:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = PIPE;
     4d0:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     4d6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     4d9:	8b 45 0c             	mov    0xc(%ebp),%eax
     4dc:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     4df:	89 d8                	mov    %ebx,%eax
     4e1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     4e4:	c9                   	leave
     4e5:	c3                   	ret
     4e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     4ed:	00 
     4ee:	66 90                	xchg   %ax,%ax

000004f0 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     4f0:	55                   	push   %ebp
     4f1:	89 e5                	mov    %esp,%ebp
     4f3:	53                   	push   %ebx
     4f4:	83 ec 10             	sub    $0x10,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4f7:	6a 0c                	push   $0xc
     4f9:	e8 42 0e 00 00       	call   1340 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     4fe:	83 c4 0c             	add    $0xc,%esp
     501:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     503:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     505:	6a 00                	push   $0x0
     507:	50                   	push   %eax
     508:	e8 b3 08 00 00       	call   dc0 <memset>
  cmd->type = LIST;
  cmd->left = left;
     50d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = LIST;
     510:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     516:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     519:	8b 45 0c             	mov    0xc(%ebp),%eax
     51c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     51f:	89 d8                	mov    %ebx,%eax
     521:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     524:	c9                   	leave
     525:	c3                   	ret
     526:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     52d:	00 
     52e:	66 90                	xchg   %ax,%ax

00000530 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     530:	55                   	push   %ebp
     531:	89 e5                	mov    %esp,%ebp
     533:	53                   	push   %ebx
     534:	83 ec 10             	sub    $0x10,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     537:	6a 08                	push   $0x8
     539:	e8 02 0e 00 00       	call   1340 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     53e:	83 c4 0c             	add    $0xc,%esp
     541:	6a 08                	push   $0x8
  cmd = malloc(sizeof(*cmd));
     543:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     545:	6a 00                	push   $0x0
     547:	50                   	push   %eax
     548:	e8 73 08 00 00       	call   dc0 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     54d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = BACK;
     550:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     556:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     559:	89 d8                	mov    %ebx,%eax
     55b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     55e:	c9                   	leave
     55f:	c3                   	ret

00000560 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     560:	55                   	push   %ebp
     561:	89 e5                	mov    %esp,%ebp
     563:	57                   	push   %edi
     564:	56                   	push   %esi
     565:	53                   	push   %ebx
     566:	83 ec 0c             	sub    $0xc,%esp
  char *s;
  int ret;

  s = *ps;
     569:	8b 45 08             	mov    0x8(%ebp),%eax
{
     56c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     56f:	8b 75 10             	mov    0x10(%ebp),%esi
  s = *ps;
     572:	8b 38                	mov    (%eax),%edi
  while(s < es && strchr(whitespace, *s))
     574:	39 df                	cmp    %ebx,%edi
     576:	72 0f                	jb     587 <gettoken+0x27>
     578:	eb 25                	jmp    59f <gettoken+0x3f>
     57a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s++;
     580:	83 c7 01             	add    $0x1,%edi
  while(s < es && strchr(whitespace, *s))
     583:	39 fb                	cmp    %edi,%ebx
     585:	74 18                	je     59f <gettoken+0x3f>
     587:	0f be 07             	movsbl (%edi),%eax
     58a:	83 ec 08             	sub    $0x8,%esp
     58d:	50                   	push   %eax
     58e:	68 4c 1b 00 00       	push   $0x1b4c
     593:	e8 48 08 00 00       	call   de0 <strchr>
     598:	83 c4 10             	add    $0x10,%esp
     59b:	85 c0                	test   %eax,%eax
     59d:	75 e1                	jne    580 <gettoken+0x20>
  if(q)
     59f:	85 f6                	test   %esi,%esi
     5a1:	74 02                	je     5a5 <gettoken+0x45>
    *q = s;
     5a3:	89 3e                	mov    %edi,(%esi)
  ret = *s;
     5a5:	0f b6 07             	movzbl (%edi),%eax
  switch(*s){
     5a8:	3c 3c                	cmp    $0x3c,%al
     5aa:	0f 8f d0 00 00 00    	jg     680 <gettoken+0x120>
     5b0:	3c 3a                	cmp    $0x3a,%al
     5b2:	0f 8f b4 00 00 00    	jg     66c <gettoken+0x10c>
     5b8:	84 c0                	test   %al,%al
     5ba:	75 44                	jne    600 <gettoken+0xa0>
     5bc:	31 f6                	xor    %esi,%esi
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     5be:	8b 55 14             	mov    0x14(%ebp),%edx
     5c1:	85 d2                	test   %edx,%edx
     5c3:	74 05                	je     5ca <gettoken+0x6a>
    *eq = s;
     5c5:	8b 45 14             	mov    0x14(%ebp),%eax
     5c8:	89 38                	mov    %edi,(%eax)

  while(s < es && strchr(whitespace, *s))
     5ca:	39 df                	cmp    %ebx,%edi
     5cc:	72 09                	jb     5d7 <gettoken+0x77>
     5ce:	eb 1f                	jmp    5ef <gettoken+0x8f>
    s++;
     5d0:	83 c7 01             	add    $0x1,%edi
  while(s < es && strchr(whitespace, *s))
     5d3:	39 fb                	cmp    %edi,%ebx
     5d5:	74 18                	je     5ef <gettoken+0x8f>
     5d7:	0f be 07             	movsbl (%edi),%eax
     5da:	83 ec 08             	sub    $0x8,%esp
     5dd:	50                   	push   %eax
     5de:	68 4c 1b 00 00       	push   $0x1b4c
     5e3:	e8 f8 07 00 00       	call   de0 <strchr>
     5e8:	83 c4 10             	add    $0x10,%esp
     5eb:	85 c0                	test   %eax,%eax
     5ed:	75 e1                	jne    5d0 <gettoken+0x70>
  *ps = s;
     5ef:	8b 45 08             	mov    0x8(%ebp),%eax
     5f2:	89 38                	mov    %edi,(%eax)
  return ret;
}
     5f4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     5f7:	89 f0                	mov    %esi,%eax
     5f9:	5b                   	pop    %ebx
     5fa:	5e                   	pop    %esi
     5fb:	5f                   	pop    %edi
     5fc:	5d                   	pop    %ebp
     5fd:	c3                   	ret
     5fe:	66 90                	xchg   %ax,%ax
  switch(*s){
     600:	79 5e                	jns    660 <gettoken+0x100>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     602:	39 fb                	cmp    %edi,%ebx
     604:	77 34                	ja     63a <gettoken+0xda>
  if(eq)
     606:	8b 45 14             	mov    0x14(%ebp),%eax
     609:	be 61 00 00 00       	mov    $0x61,%esi
     60e:	85 c0                	test   %eax,%eax
     610:	75 b3                	jne    5c5 <gettoken+0x65>
     612:	eb db                	jmp    5ef <gettoken+0x8f>
     614:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     618:	0f be 07             	movsbl (%edi),%eax
     61b:	83 ec 08             	sub    $0x8,%esp
     61e:	50                   	push   %eax
     61f:	68 44 1b 00 00       	push   $0x1b44
     624:	e8 b7 07 00 00       	call   de0 <strchr>
     629:	83 c4 10             	add    $0x10,%esp
     62c:	85 c0                	test   %eax,%eax
     62e:	75 22                	jne    652 <gettoken+0xf2>
      s++;
     630:	83 c7 01             	add    $0x1,%edi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     633:	39 fb                	cmp    %edi,%ebx
     635:	74 cf                	je     606 <gettoken+0xa6>
     637:	0f b6 07             	movzbl (%edi),%eax
     63a:	83 ec 08             	sub    $0x8,%esp
     63d:	0f be f0             	movsbl %al,%esi
     640:	56                   	push   %esi
     641:	68 4c 1b 00 00       	push   $0x1b4c
     646:	e8 95 07 00 00       	call   de0 <strchr>
     64b:	83 c4 10             	add    $0x10,%esp
     64e:	85 c0                	test   %eax,%eax
     650:	74 c6                	je     618 <gettoken+0xb8>
    ret = 'a';
     652:	be 61 00 00 00       	mov    $0x61,%esi
     657:	e9 62 ff ff ff       	jmp    5be <gettoken+0x5e>
     65c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     660:	3c 26                	cmp    $0x26,%al
     662:	74 08                	je     66c <gettoken+0x10c>
     664:	8d 48 d8             	lea    -0x28(%eax),%ecx
     667:	80 f9 01             	cmp    $0x1,%cl
     66a:	77 96                	ja     602 <gettoken+0xa2>
  ret = *s;
     66c:	0f be f0             	movsbl %al,%esi
    s++;
     66f:	83 c7 01             	add    $0x1,%edi
    break;
     672:	e9 47 ff ff ff       	jmp    5be <gettoken+0x5e>
     677:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     67e:	00 
     67f:	90                   	nop
  switch(*s){
     680:	3c 3e                	cmp    $0x3e,%al
     682:	75 1c                	jne    6a0 <gettoken+0x140>
    if(*s == '>'){
     684:	80 7f 01 3e          	cmpb   $0x3e,0x1(%edi)
    s++;
     688:	8d 47 01             	lea    0x1(%edi),%eax
    if(*s == '>'){
     68b:	74 1c                	je     6a9 <gettoken+0x149>
    s++;
     68d:	89 c7                	mov    %eax,%edi
     68f:	be 3e 00 00 00       	mov    $0x3e,%esi
     694:	e9 25 ff ff ff       	jmp    5be <gettoken+0x5e>
     699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     6a0:	3c 7c                	cmp    $0x7c,%al
     6a2:	74 c8                	je     66c <gettoken+0x10c>
     6a4:	e9 59 ff ff ff       	jmp    602 <gettoken+0xa2>
      s++;
     6a9:	83 c7 02             	add    $0x2,%edi
      ret = '+';
     6ac:	be 2b 00 00 00       	mov    $0x2b,%esi
     6b1:	e9 08 ff ff ff       	jmp    5be <gettoken+0x5e>
     6b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     6bd:	00 
     6be:	66 90                	xchg   %ax,%ax

000006c0 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     6c0:	55                   	push   %ebp
     6c1:	89 e5                	mov    %esp,%ebp
     6c3:	57                   	push   %edi
     6c4:	56                   	push   %esi
     6c5:	53                   	push   %ebx
     6c6:	83 ec 0c             	sub    $0xc,%esp
     6c9:	8b 7d 08             	mov    0x8(%ebp),%edi
     6cc:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     6cf:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     6d1:	39 f3                	cmp    %esi,%ebx
     6d3:	72 12                	jb     6e7 <peek+0x27>
     6d5:	eb 28                	jmp    6ff <peek+0x3f>
     6d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     6de:	00 
     6df:	90                   	nop
    s++;
     6e0:	83 c3 01             	add    $0x1,%ebx
  while(s < es && strchr(whitespace, *s))
     6e3:	39 de                	cmp    %ebx,%esi
     6e5:	74 18                	je     6ff <peek+0x3f>
     6e7:	0f be 03             	movsbl (%ebx),%eax
     6ea:	83 ec 08             	sub    $0x8,%esp
     6ed:	50                   	push   %eax
     6ee:	68 4c 1b 00 00       	push   $0x1b4c
     6f3:	e8 e8 06 00 00       	call   de0 <strchr>
     6f8:	83 c4 10             	add    $0x10,%esp
     6fb:	85 c0                	test   %eax,%eax
     6fd:	75 e1                	jne    6e0 <peek+0x20>
  *ps = s;
     6ff:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     701:	0f be 03             	movsbl (%ebx),%eax
     704:	31 d2                	xor    %edx,%edx
     706:	84 c0                	test   %al,%al
     708:	75 0e                	jne    718 <peek+0x58>
}
     70a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     70d:	89 d0                	mov    %edx,%eax
     70f:	5b                   	pop    %ebx
     710:	5e                   	pop    %esi
     711:	5f                   	pop    %edi
     712:	5d                   	pop    %ebp
     713:	c3                   	ret
     714:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return *s && strchr(toks, *s);
     718:	83 ec 08             	sub    $0x8,%esp
     71b:	50                   	push   %eax
     71c:	ff 75 10             	push   0x10(%ebp)
     71f:	e8 bc 06 00 00       	call   de0 <strchr>
     724:	83 c4 10             	add    $0x10,%esp
     727:	31 d2                	xor    %edx,%edx
     729:	85 c0                	test   %eax,%eax
     72b:	0f 95 c2             	setne  %dl
}
     72e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     731:	5b                   	pop    %ebx
     732:	89 d0                	mov    %edx,%eax
     734:	5e                   	pop    %esi
     735:	5f                   	pop    %edi
     736:	5d                   	pop    %ebp
     737:	c3                   	ret
     738:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     73f:	00 

00000740 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     740:	55                   	push   %ebp
     741:	89 e5                	mov    %esp,%ebp
     743:	57                   	push   %edi
     744:	56                   	push   %esi
     745:	53                   	push   %ebx
     746:	83 ec 2c             	sub    $0x2c,%esp
     749:	8b 75 0c             	mov    0xc(%ebp),%esi
     74c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     74f:	90                   	nop
     750:	83 ec 04             	sub    $0x4,%esp
     753:	68 a1 14 00 00       	push   $0x14a1
     758:	53                   	push   %ebx
     759:	56                   	push   %esi
     75a:	e8 61 ff ff ff       	call   6c0 <peek>
     75f:	83 c4 10             	add    $0x10,%esp
     762:	85 c0                	test   %eax,%eax
     764:	0f 84 f6 00 00 00    	je     860 <parseredirs+0x120>
    tok = gettoken(ps, es, 0, 0);
     76a:	6a 00                	push   $0x0
     76c:	6a 00                	push   $0x0
     76e:	53                   	push   %ebx
     76f:	56                   	push   %esi
     770:	e8 eb fd ff ff       	call   560 <gettoken>
     775:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
     777:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     77a:	50                   	push   %eax
     77b:	8d 45 e0             	lea    -0x20(%ebp),%eax
     77e:	50                   	push   %eax
     77f:	53                   	push   %ebx
     780:	56                   	push   %esi
     781:	e8 da fd ff ff       	call   560 <gettoken>
     786:	83 c4 20             	add    $0x20,%esp
     789:	83 f8 61             	cmp    $0x61,%eax
     78c:	0f 85 d9 00 00 00    	jne    86b <parseredirs+0x12b>
      panic("missing file for redirection");
    switch(tok){
     792:	83 ff 3c             	cmp    $0x3c,%edi
     795:	74 69                	je     800 <parseredirs+0xc0>
     797:	83 ff 3e             	cmp    $0x3e,%edi
     79a:	74 05                	je     7a1 <parseredirs+0x61>
     79c:	83 ff 2b             	cmp    $0x2b,%edi
     79f:	75 af                	jne    750 <parseredirs+0x10>
  cmd = malloc(sizeof(*cmd));
     7a1:	83 ec 0c             	sub    $0xc,%esp
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     7a4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     7a7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  cmd = malloc(sizeof(*cmd));
     7aa:	6a 18                	push   $0x18
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     7ac:	89 55 d0             	mov    %edx,-0x30(%ebp)
     7af:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
     7b2:	e8 89 0b 00 00       	call   1340 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     7b7:	83 c4 0c             	add    $0xc,%esp
     7ba:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     7bc:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
     7be:	6a 00                	push   $0x0
     7c0:	50                   	push   %eax
     7c1:	e8 fa 05 00 00       	call   dc0 <memset>
  cmd->type = REDIR;
     7c6:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  cmd->cmd = subcmd;
     7cc:	8b 45 08             	mov    0x8(%ebp),%eax
      break;
     7cf:	83 c4 10             	add    $0x10,%esp
  cmd->cmd = subcmd;
     7d2:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
     7d5:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     7d8:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
     7db:	8b 55 d0             	mov    -0x30(%ebp),%edx
  cmd->mode = mode;
     7de:	c7 47 10 01 02 00 00 	movl   $0x201,0x10(%edi)
  cmd->efile = efile;
     7e5:	89 57 0c             	mov    %edx,0xc(%edi)
  cmd->fd = fd;
     7e8:	c7 47 14 01 00 00 00 	movl   $0x1,0x14(%edi)
      break;
     7ef:	89 7d 08             	mov    %edi,0x8(%ebp)
     7f2:	e9 59 ff ff ff       	jmp    750 <parseredirs+0x10>
     7f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     7fe:	00 
     7ff:	90                   	nop
  cmd = malloc(sizeof(*cmd));
     800:	83 ec 0c             	sub    $0xc,%esp
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     803:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     806:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  cmd = malloc(sizeof(*cmd));
     809:	6a 18                	push   $0x18
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     80b:	89 55 d0             	mov    %edx,-0x30(%ebp)
     80e:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
     811:	e8 2a 0b 00 00       	call   1340 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     816:	83 c4 0c             	add    $0xc,%esp
     819:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     81b:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
     81d:	6a 00                	push   $0x0
     81f:	50                   	push   %eax
     820:	e8 9b 05 00 00       	call   dc0 <memset>
  cmd->cmd = subcmd;
     825:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->file = file;
     828:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      break;
     82b:	89 7d 08             	mov    %edi,0x8(%ebp)
  cmd->efile = efile;
     82e:	8b 55 d0             	mov    -0x30(%ebp),%edx
  cmd->type = REDIR;
     831:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
      break;
     837:	83 c4 10             	add    $0x10,%esp
  cmd->cmd = subcmd;
     83a:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
     83d:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
     840:	89 57 0c             	mov    %edx,0xc(%edi)
  cmd->mode = mode;
     843:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%edi)
  cmd->fd = fd;
     84a:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
      break;
     851:	e9 fa fe ff ff       	jmp    750 <parseredirs+0x10>
     856:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     85d:	00 
     85e:	66 90                	xchg   %ax,%ax
    }
  }
  return cmd;
}
     860:	8b 45 08             	mov    0x8(%ebp),%eax
     863:	8d 65 f4             	lea    -0xc(%ebp),%esp
     866:	5b                   	pop    %ebx
     867:	5e                   	pop    %esi
     868:	5f                   	pop    %edi
     869:	5d                   	pop    %ebp
     86a:	c3                   	ret
      panic("missing file for redirection");
     86b:	83 ec 0c             	sub    $0xc,%esp
     86e:	68 84 14 00 00       	push   $0x1484
     873:	e8 b8 f9 ff ff       	call   230 <panic>
     878:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     87f:	00 

00000880 <parseexec.part.0>:
  cmd = parseredirs(cmd, ps, es);
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
     880:	55                   	push   %ebp
     881:	89 e5                	mov    %esp,%ebp
     883:	57                   	push   %edi
     884:	89 d7                	mov    %edx,%edi
     886:	56                   	push   %esi
     887:	89 c6                	mov    %eax,%esi
     889:	53                   	push   %ebx
     88a:	83 ec 38             	sub    $0x38,%esp
  cmd = malloc(sizeof(*cmd));
     88d:	68 a4 00 00 00       	push   $0xa4
     892:	e8 a9 0a 00 00       	call   1340 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     897:	83 c4 0c             	add    $0xc,%esp
     89a:	68 a4 00 00 00       	push   $0xa4
  cmd = malloc(sizeof(*cmd));
     89f:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     8a1:	6a 00                	push   $0x0
     8a3:	50                   	push   %eax
  cmd = malloc(sizeof(*cmd));
     8a4:	89 45 d0             	mov    %eax,-0x30(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     8a7:	e8 14 05 00 00       	call   dc0 <memset>

  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     8ac:	83 c4 0c             	add    $0xc,%esp
  cmd->type = EXEC;
     8af:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  ret = parseredirs(ret, ps, es);
     8b5:	57                   	push   %edi
     8b6:	56                   	push   %esi
     8b7:	53                   	push   %ebx
  argc = 0;
     8b8:	31 db                	xor    %ebx,%ebx
  ret = parseredirs(ret, ps, es);
     8ba:	e8 81 fe ff ff       	call   740 <parseredirs>
  while(!peek(ps, es, "|)&;")){
     8bf:	83 c4 10             	add    $0x10,%esp
  ret = parseredirs(ret, ps, es);
     8c2:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     8c5:	eb 1c                	jmp    8e3 <parseexec.part.0+0x63>
     8c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     8ce:	00 
     8cf:	90                   	nop
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     8d0:	83 ec 04             	sub    $0x4,%esp
     8d3:	57                   	push   %edi
     8d4:	56                   	push   %esi
     8d5:	ff 75 d4             	push   -0x2c(%ebp)
     8d8:	e8 63 fe ff ff       	call   740 <parseredirs>
     8dd:	83 c4 10             	add    $0x10,%esp
     8e0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     8e3:	83 ec 04             	sub    $0x4,%esp
     8e6:	68 b9 14 00 00       	push   $0x14b9
     8eb:	57                   	push   %edi
     8ec:	56                   	push   %esi
     8ed:	e8 ce fd ff ff       	call   6c0 <peek>
     8f2:	83 c4 10             	add    $0x10,%esp
     8f5:	85 c0                	test   %eax,%eax
     8f7:	75 47                	jne    940 <parseexec.part.0+0xc0>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     8f9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     8fc:	50                   	push   %eax
     8fd:	8d 45 e0             	lea    -0x20(%ebp),%eax
     900:	50                   	push   %eax
     901:	57                   	push   %edi
     902:	56                   	push   %esi
     903:	e8 58 fc ff ff       	call   560 <gettoken>
     908:	83 c4 10             	add    $0x10,%esp
     90b:	85 c0                	test   %eax,%eax
     90d:	74 31                	je     940 <parseexec.part.0+0xc0>
    if(tok != 'a')
     90f:	83 f8 61             	cmp    $0x61,%eax
     912:	75 4a                	jne    95e <parseexec.part.0+0xde>
    cmd->argv[argc] = q;
     914:	8b 45 e0             	mov    -0x20(%ebp),%eax
     917:	8b 4d d0             	mov    -0x30(%ebp),%ecx
     91a:	89 44 99 04          	mov    %eax,0x4(%ecx,%ebx,4)
    cmd->eargv[argc] = eq;
     91e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     921:	89 44 99 54          	mov    %eax,0x54(%ecx,%ebx,4)
    argc++;
     925:	83 c3 01             	add    $0x1,%ebx
    if(argc >= MAXARGS)
     928:	83 fb 14             	cmp    $0x14,%ebx
     92b:	75 a3                	jne    8d0 <parseexec.part.0+0x50>
      panic("too many args");
     92d:	83 ec 0c             	sub    $0xc,%esp
     930:	68 ab 14 00 00       	push   $0x14ab
     935:	e8 f6 f8 ff ff       	call   230 <panic>
     93a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  cmd->argv[argc] = 0;
     940:	8b 45 d0             	mov    -0x30(%ebp),%eax
     943:	c7 44 98 04 00 00 00 	movl   $0x0,0x4(%eax,%ebx,4)
     94a:	00 
  cmd->eargv[argc] = 0;
     94b:	c7 44 98 54 00 00 00 	movl   $0x0,0x54(%eax,%ebx,4)
     952:	00 
  return ret;
}
     953:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     956:	8d 65 f4             	lea    -0xc(%ebp),%esp
     959:	5b                   	pop    %ebx
     95a:	5e                   	pop    %esi
     95b:	5f                   	pop    %edi
     95c:	5d                   	pop    %ebp
     95d:	c3                   	ret
      panic("syntax");
     95e:	83 ec 0c             	sub    $0xc,%esp
     961:	68 a4 14 00 00       	push   $0x14a4
     966:	e8 c5 f8 ff ff       	call   230 <panic>
     96b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00000970 <parseblock>:
{
     970:	55                   	push   %ebp
     971:	89 e5                	mov    %esp,%ebp
     973:	57                   	push   %edi
     974:	56                   	push   %esi
     975:	53                   	push   %ebx
     976:	83 ec 10             	sub    $0x10,%esp
     979:	8b 5d 08             	mov    0x8(%ebp),%ebx
     97c:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(!peek(ps, es, "("))
     97f:	68 be 14 00 00       	push   $0x14be
     984:	56                   	push   %esi
     985:	53                   	push   %ebx
     986:	e8 35 fd ff ff       	call   6c0 <peek>
     98b:	83 c4 10             	add    $0x10,%esp
     98e:	85 c0                	test   %eax,%eax
     990:	74 4a                	je     9dc <parseblock+0x6c>
  gettoken(ps, es, 0, 0);
     992:	6a 00                	push   $0x0
     994:	6a 00                	push   $0x0
     996:	56                   	push   %esi
     997:	53                   	push   %ebx
     998:	e8 c3 fb ff ff       	call   560 <gettoken>
  cmd = parseline(ps, es);
     99d:	58                   	pop    %eax
     99e:	5a                   	pop    %edx
     99f:	56                   	push   %esi
     9a0:	53                   	push   %ebx
     9a1:	e8 1a 01 00 00       	call   ac0 <parseline>
  if(!peek(ps, es, ")"))
     9a6:	83 c4 0c             	add    $0xc,%esp
     9a9:	68 dc 14 00 00       	push   $0x14dc
  cmd = parseline(ps, es);
     9ae:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     9b0:	56                   	push   %esi
     9b1:	53                   	push   %ebx
     9b2:	e8 09 fd ff ff       	call   6c0 <peek>
     9b7:	83 c4 10             	add    $0x10,%esp
     9ba:	85 c0                	test   %eax,%eax
     9bc:	74 2b                	je     9e9 <parseblock+0x79>
  gettoken(ps, es, 0, 0);
     9be:	6a 00                	push   $0x0
     9c0:	6a 00                	push   $0x0
     9c2:	56                   	push   %esi
     9c3:	53                   	push   %ebx
     9c4:	e8 97 fb ff ff       	call   560 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     9c9:	83 c4 0c             	add    $0xc,%esp
     9cc:	56                   	push   %esi
     9cd:	53                   	push   %ebx
     9ce:	57                   	push   %edi
     9cf:	e8 6c fd ff ff       	call   740 <parseredirs>
}
     9d4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     9d7:	5b                   	pop    %ebx
     9d8:	5e                   	pop    %esi
     9d9:	5f                   	pop    %edi
     9da:	5d                   	pop    %ebp
     9db:	c3                   	ret
    panic("parseblock");
     9dc:	83 ec 0c             	sub    $0xc,%esp
     9df:	68 c0 14 00 00       	push   $0x14c0
     9e4:	e8 47 f8 ff ff       	call   230 <panic>
    panic("syntax - missing )");
     9e9:	83 ec 0c             	sub    $0xc,%esp
     9ec:	68 cb 14 00 00       	push   $0x14cb
     9f1:	e8 3a f8 ff ff       	call   230 <panic>
     9f6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     9fd:	00 
     9fe:	66 90                	xchg   %ax,%ax

00000a00 <parsepipe>:
{
     a00:	55                   	push   %ebp
     a01:	89 e5                	mov    %esp,%ebp
     a03:	57                   	push   %edi
     a04:	56                   	push   %esi
     a05:	53                   	push   %ebx
     a06:	83 ec 10             	sub    $0x10,%esp
     a09:	8b 75 08             	mov    0x8(%ebp),%esi
     a0c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(peek(ps, es, "("))
     a0f:	68 be 14 00 00       	push   $0x14be
     a14:	57                   	push   %edi
     a15:	56                   	push   %esi
     a16:	e8 a5 fc ff ff       	call   6c0 <peek>
     a1b:	83 c4 10             	add    $0x10,%esp
     a1e:	85 c0                	test   %eax,%eax
     a20:	75 2e                	jne    a50 <parsepipe+0x50>
     a22:	89 fa                	mov    %edi,%edx
     a24:	89 f0                	mov    %esi,%eax
     a26:	e8 55 fe ff ff       	call   880 <parseexec.part.0>
     a2b:	89 c3                	mov    %eax,%ebx
  if(peek(ps, es, "|")){
     a2d:	83 ec 04             	sub    $0x4,%esp
     a30:	68 de 14 00 00       	push   $0x14de
     a35:	57                   	push   %edi
     a36:	56                   	push   %esi
     a37:	e8 84 fc ff ff       	call   6c0 <peek>
     a3c:	83 c4 10             	add    $0x10,%esp
     a3f:	85 c0                	test   %eax,%eax
     a41:	75 25                	jne    a68 <parsepipe+0x68>
}
     a43:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a46:	89 d8                	mov    %ebx,%eax
     a48:	5b                   	pop    %ebx
     a49:	5e                   	pop    %esi
     a4a:	5f                   	pop    %edi
     a4b:	5d                   	pop    %ebp
     a4c:	c3                   	ret
     a4d:	8d 76 00             	lea    0x0(%esi),%esi
    return parseblock(ps, es);
     a50:	83 ec 08             	sub    $0x8,%esp
     a53:	57                   	push   %edi
     a54:	56                   	push   %esi
     a55:	e8 16 ff ff ff       	call   970 <parseblock>
     a5a:	83 c4 10             	add    $0x10,%esp
     a5d:	89 c3                	mov    %eax,%ebx
     a5f:	eb cc                	jmp    a2d <parsepipe+0x2d>
     a61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    gettoken(ps, es, 0, 0);
     a68:	6a 00                	push   $0x0
     a6a:	6a 00                	push   $0x0
     a6c:	57                   	push   %edi
     a6d:	56                   	push   %esi
     a6e:	e8 ed fa ff ff       	call   560 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     a73:	58                   	pop    %eax
     a74:	5a                   	pop    %edx
     a75:	57                   	push   %edi
     a76:	56                   	push   %esi
     a77:	e8 84 ff ff ff       	call   a00 <parsepipe>
  cmd = malloc(sizeof(*cmd));
     a7c:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    cmd = pipecmd(cmd, parsepipe(ps, es));
     a83:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
     a85:	e8 b6 08 00 00       	call   1340 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     a8a:	83 c4 0c             	add    $0xc,%esp
     a8d:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     a8f:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
     a91:	6a 00                	push   $0x0
     a93:	50                   	push   %eax
     a94:	e8 27 03 00 00       	call   dc0 <memset>
  cmd->left = left;
     a99:	89 5e 04             	mov    %ebx,0x4(%esi)
  cmd->right = right;
     a9c:	83 c4 10             	add    $0x10,%esp
     a9f:	89 f3                	mov    %esi,%ebx
  cmd->type = PIPE;
     aa1:	c7 06 03 00 00 00    	movl   $0x3,(%esi)
}
     aa7:	89 d8                	mov    %ebx,%eax
  cmd->right = right;
     aa9:	89 7e 08             	mov    %edi,0x8(%esi)
}
     aac:	8d 65 f4             	lea    -0xc(%ebp),%esp
     aaf:	5b                   	pop    %ebx
     ab0:	5e                   	pop    %esi
     ab1:	5f                   	pop    %edi
     ab2:	5d                   	pop    %ebp
     ab3:	c3                   	ret
     ab4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     abb:	00 
     abc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000ac0 <parseline>:
{
     ac0:	55                   	push   %ebp
     ac1:	89 e5                	mov    %esp,%ebp
     ac3:	57                   	push   %edi
     ac4:	56                   	push   %esi
     ac5:	53                   	push   %ebx
     ac6:	83 ec 24             	sub    $0x24,%esp
     ac9:	8b 75 08             	mov    0x8(%ebp),%esi
     acc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parsepipe(ps, es);
     acf:	57                   	push   %edi
     ad0:	56                   	push   %esi
     ad1:	e8 2a ff ff ff       	call   a00 <parsepipe>
  while(peek(ps, es, "&")){
     ad6:	83 c4 10             	add    $0x10,%esp
  cmd = parsepipe(ps, es);
     ad9:	89 c3                	mov    %eax,%ebx
  while(peek(ps, es, "&")){
     adb:	eb 3b                	jmp    b18 <parseline+0x58>
     add:	8d 76 00             	lea    0x0(%esi),%esi
    gettoken(ps, es, 0, 0);
     ae0:	6a 00                	push   $0x0
     ae2:	6a 00                	push   $0x0
     ae4:	57                   	push   %edi
     ae5:	56                   	push   %esi
     ae6:	e8 75 fa ff ff       	call   560 <gettoken>
  cmd = malloc(sizeof(*cmd));
     aeb:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     af2:	e8 49 08 00 00       	call   1340 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     af7:	83 c4 0c             	add    $0xc,%esp
     afa:	6a 08                	push   $0x8
     afc:	6a 00                	push   $0x0
     afe:	50                   	push   %eax
     aff:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     b02:	e8 b9 02 00 00       	call   dc0 <memset>
  cmd->type = BACK;
     b07:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  cmd->cmd = subcmd;
     b0a:	83 c4 10             	add    $0x10,%esp
  cmd->type = BACK;
     b0d:	c7 02 05 00 00 00    	movl   $0x5,(%edx)
  cmd->cmd = subcmd;
     b13:	89 5a 04             	mov    %ebx,0x4(%edx)
     b16:	89 d3                	mov    %edx,%ebx
  while(peek(ps, es, "&")){
     b18:	83 ec 04             	sub    $0x4,%esp
     b1b:	68 e0 14 00 00       	push   $0x14e0
     b20:	57                   	push   %edi
     b21:	56                   	push   %esi
     b22:	e8 99 fb ff ff       	call   6c0 <peek>
     b27:	83 c4 10             	add    $0x10,%esp
     b2a:	85 c0                	test   %eax,%eax
     b2c:	75 b2                	jne    ae0 <parseline+0x20>
  if(peek(ps, es, ";")){
     b2e:	83 ec 04             	sub    $0x4,%esp
     b31:	68 bc 14 00 00       	push   $0x14bc
     b36:	57                   	push   %edi
     b37:	56                   	push   %esi
     b38:	e8 83 fb ff ff       	call   6c0 <peek>
     b3d:	83 c4 10             	add    $0x10,%esp
     b40:	85 c0                	test   %eax,%eax
     b42:	75 0c                	jne    b50 <parseline+0x90>
}
     b44:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b47:	89 d8                	mov    %ebx,%eax
     b49:	5b                   	pop    %ebx
     b4a:	5e                   	pop    %esi
     b4b:	5f                   	pop    %edi
     b4c:	5d                   	pop    %ebp
     b4d:	c3                   	ret
     b4e:	66 90                	xchg   %ax,%ax
    gettoken(ps, es, 0, 0);
     b50:	6a 00                	push   $0x0
     b52:	6a 00                	push   $0x0
     b54:	57                   	push   %edi
     b55:	56                   	push   %esi
     b56:	e8 05 fa ff ff       	call   560 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     b5b:	58                   	pop    %eax
     b5c:	5a                   	pop    %edx
     b5d:	57                   	push   %edi
     b5e:	56                   	push   %esi
     b5f:	e8 5c ff ff ff       	call   ac0 <parseline>
  cmd = malloc(sizeof(*cmd));
     b64:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    cmd = listcmd(cmd, parseline(ps, es));
     b6b:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
     b6d:	e8 ce 07 00 00       	call   1340 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     b72:	83 c4 0c             	add    $0xc,%esp
     b75:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     b77:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
     b79:	6a 00                	push   $0x0
     b7b:	50                   	push   %eax
     b7c:	e8 3f 02 00 00       	call   dc0 <memset>
  cmd->left = left;
     b81:	89 5e 04             	mov    %ebx,0x4(%esi)
  cmd->right = right;
     b84:	83 c4 10             	add    $0x10,%esp
     b87:	89 f3                	mov    %esi,%ebx
  cmd->type = LIST;
     b89:	c7 06 04 00 00 00    	movl   $0x4,(%esi)
}
     b8f:	89 d8                	mov    %ebx,%eax
  cmd->right = right;
     b91:	89 7e 08             	mov    %edi,0x8(%esi)
}
     b94:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b97:	5b                   	pop    %ebx
     b98:	5e                   	pop    %esi
     b99:	5f                   	pop    %edi
     b9a:	5d                   	pop    %ebp
     b9b:	c3                   	ret
     b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000ba0 <parseexec>:
{
     ba0:	55                   	push   %ebp
     ba1:	89 e5                	mov    %esp,%ebp
     ba3:	56                   	push   %esi
     ba4:	53                   	push   %ebx
     ba5:	8b 75 0c             	mov    0xc(%ebp),%esi
     ba8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(peek(ps, es, "("))
     bab:	83 ec 04             	sub    $0x4,%esp
     bae:	68 be 14 00 00       	push   $0x14be
     bb3:	56                   	push   %esi
     bb4:	53                   	push   %ebx
     bb5:	e8 06 fb ff ff       	call   6c0 <peek>
     bba:	83 c4 10             	add    $0x10,%esp
     bbd:	85 c0                	test   %eax,%eax
     bbf:	75 0f                	jne    bd0 <parseexec+0x30>
}
     bc1:	8d 65 f8             	lea    -0x8(%ebp),%esp
     bc4:	89 f2                	mov    %esi,%edx
     bc6:	89 d8                	mov    %ebx,%eax
     bc8:	5b                   	pop    %ebx
     bc9:	5e                   	pop    %esi
     bca:	5d                   	pop    %ebp
     bcb:	e9 b0 fc ff ff       	jmp    880 <parseexec.part.0>
    return parseblock(ps, es);
     bd0:	89 75 0c             	mov    %esi,0xc(%ebp)
     bd3:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
     bd6:	8d 65 f8             	lea    -0x8(%ebp),%esp
     bd9:	5b                   	pop    %ebx
     bda:	5e                   	pop    %esi
     bdb:	5d                   	pop    %ebp
    return parseblock(ps, es);
     bdc:	e9 8f fd ff ff       	jmp    970 <parseblock>
     be1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     be8:	00 
     be9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000bf0 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     bf0:	55                   	push   %ebp
     bf1:	89 e5                	mov    %esp,%ebp
     bf3:	53                   	push   %ebx
     bf4:	83 ec 04             	sub    $0x4,%esp
     bf7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     bfa:	85 db                	test   %ebx,%ebx
     bfc:	0f 84 8e 00 00 00    	je     c90 <nulterminate+0xa0>
    return 0;

  switch(cmd->type){
     c02:	83 3b 05             	cmpl   $0x5,(%ebx)
     c05:	77 61                	ja     c68 <nulterminate+0x78>
     c07:	8b 03                	mov    (%ebx),%eax
     c09:	ff 24 85 30 15 00 00 	jmp    *0x1530(,%eax,4)
    nulterminate(pcmd->right);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
     c10:	83 ec 0c             	sub    $0xc,%esp
     c13:	ff 73 04             	push   0x4(%ebx)
     c16:	e8 d5 ff ff ff       	call   bf0 <nulterminate>
    nulterminate(lcmd->right);
     c1b:	58                   	pop    %eax
     c1c:	ff 73 08             	push   0x8(%ebx)
     c1f:	e8 cc ff ff ff       	call   bf0 <nulterminate>
    break;
     c24:	83 c4 10             	add    $0x10,%esp
     c27:	89 d8                	mov    %ebx,%eax
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     c29:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c2c:	c9                   	leave
     c2d:	c3                   	ret
     c2e:	66 90                	xchg   %ax,%ax
    nulterminate(bcmd->cmd);
     c30:	83 ec 0c             	sub    $0xc,%esp
     c33:	ff 73 04             	push   0x4(%ebx)
     c36:	e8 b5 ff ff ff       	call   bf0 <nulterminate>
    break;
     c3b:	89 d8                	mov    %ebx,%eax
     c3d:	83 c4 10             	add    $0x10,%esp
}
     c40:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c43:	c9                   	leave
     c44:	c3                   	ret
     c45:	8d 76 00             	lea    0x0(%esi),%esi
    for(i=0; ecmd->argv[i]; i++)
     c48:	8b 4b 04             	mov    0x4(%ebx),%ecx
     c4b:	8d 43 08             	lea    0x8(%ebx),%eax
     c4e:	85 c9                	test   %ecx,%ecx
     c50:	74 16                	je     c68 <nulterminate+0x78>
     c52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
     c58:	8b 50 4c             	mov    0x4c(%eax),%edx
    for(i=0; ecmd->argv[i]; i++)
     c5b:	83 c0 04             	add    $0x4,%eax
      *ecmd->eargv[i] = 0;
     c5e:	c6 02 00             	movb   $0x0,(%edx)
    for(i=0; ecmd->argv[i]; i++)
     c61:	8b 50 fc             	mov    -0x4(%eax),%edx
     c64:	85 d2                	test   %edx,%edx
     c66:	75 f0                	jne    c58 <nulterminate+0x68>
  switch(cmd->type){
     c68:	89 d8                	mov    %ebx,%eax
}
     c6a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c6d:	c9                   	leave
     c6e:	c3                   	ret
     c6f:	90                   	nop
    nulterminate(rcmd->cmd);
     c70:	83 ec 0c             	sub    $0xc,%esp
     c73:	ff 73 04             	push   0x4(%ebx)
     c76:	e8 75 ff ff ff       	call   bf0 <nulterminate>
    *rcmd->efile = 0;
     c7b:	8b 43 0c             	mov    0xc(%ebx),%eax
    break;
     c7e:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
     c81:	c6 00 00             	movb   $0x0,(%eax)
    break;
     c84:	89 d8                	mov    %ebx,%eax
}
     c86:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c89:	c9                   	leave
     c8a:	c3                   	ret
     c8b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return 0;
     c90:	31 c0                	xor    %eax,%eax
     c92:	eb 95                	jmp    c29 <nulterminate+0x39>
     c94:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     c9b:	00 
     c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000ca0 <parsecmd>:
{
     ca0:	55                   	push   %ebp
     ca1:	89 e5                	mov    %esp,%ebp
     ca3:	57                   	push   %edi
     ca4:	56                   	push   %esi
  cmd = parseline(&s, es);
     ca5:	8d 7d 08             	lea    0x8(%ebp),%edi
{
     ca8:	53                   	push   %ebx
     ca9:	83 ec 18             	sub    $0x18,%esp
  es = s + strlen(s);
     cac:	8b 5d 08             	mov    0x8(%ebp),%ebx
     caf:	53                   	push   %ebx
     cb0:	e8 db 00 00 00       	call   d90 <strlen>
  cmd = parseline(&s, es);
     cb5:	59                   	pop    %ecx
     cb6:	5e                   	pop    %esi
  es = s + strlen(s);
     cb7:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     cb9:	53                   	push   %ebx
     cba:	57                   	push   %edi
     cbb:	e8 00 fe ff ff       	call   ac0 <parseline>
  peek(&s, es, "");
     cc0:	83 c4 0c             	add    $0xc,%esp
     cc3:	68 6e 14 00 00       	push   $0x146e
  cmd = parseline(&s, es);
     cc8:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     cca:	53                   	push   %ebx
     ccb:	57                   	push   %edi
     ccc:	e8 ef f9 ff ff       	call   6c0 <peek>
  if(s != es){
     cd1:	8b 45 08             	mov    0x8(%ebp),%eax
     cd4:	83 c4 10             	add    $0x10,%esp
     cd7:	39 d8                	cmp    %ebx,%eax
     cd9:	75 13                	jne    cee <parsecmd+0x4e>
  nulterminate(cmd);
     cdb:	83 ec 0c             	sub    $0xc,%esp
     cde:	56                   	push   %esi
     cdf:	e8 0c ff ff ff       	call   bf0 <nulterminate>
}
     ce4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ce7:	89 f0                	mov    %esi,%eax
     ce9:	5b                   	pop    %ebx
     cea:	5e                   	pop    %esi
     ceb:	5f                   	pop    %edi
     cec:	5d                   	pop    %ebp
     ced:	c3                   	ret
    printf(2, "leftovers: %s\n", s);
     cee:	52                   	push   %edx
     cef:	50                   	push   %eax
     cf0:	68 e2 14 00 00       	push   $0x14e2
     cf5:	6a 02                	push   $0x2
     cf7:	e8 e4 03 00 00       	call   10e0 <printf>
    panic("syntax");
     cfc:	c7 04 24 a4 14 00 00 	movl   $0x14a4,(%esp)
     d03:	e8 28 f5 ff ff       	call   230 <panic>
     d08:	66 90                	xchg   %ax,%ax
     d0a:	66 90                	xchg   %ax,%ax
     d0c:	66 90                	xchg   %ax,%ax
     d0e:	66 90                	xchg   %ax,%ax

00000d10 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     d10:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     d11:	31 c0                	xor    %eax,%eax
{
     d13:	89 e5                	mov    %esp,%ebp
     d15:	53                   	push   %ebx
     d16:	8b 4d 08             	mov    0x8(%ebp),%ecx
     d19:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     d1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
     d20:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
     d24:	88 14 01             	mov    %dl,(%ecx,%eax,1)
     d27:	83 c0 01             	add    $0x1,%eax
     d2a:	84 d2                	test   %dl,%dl
     d2c:	75 f2                	jne    d20 <strcpy+0x10>
    ;
  return os;
}
     d2e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     d31:	89 c8                	mov    %ecx,%eax
     d33:	c9                   	leave
     d34:	c3                   	ret
     d35:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     d3c:	00 
     d3d:	8d 76 00             	lea    0x0(%esi),%esi

00000d40 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     d40:	55                   	push   %ebp
     d41:	89 e5                	mov    %esp,%ebp
     d43:	53                   	push   %ebx
     d44:	8b 4d 08             	mov    0x8(%ebp),%ecx
     d47:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
     d4a:	0f b6 01             	movzbl (%ecx),%eax
     d4d:	0f b6 1a             	movzbl (%edx),%ebx
     d50:	84 c0                	test   %al,%al
     d52:	75 1c                	jne    d70 <strcmp+0x30>
     d54:	eb 2e                	jmp    d84 <strcmp+0x44>
     d56:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     d5d:	00 
     d5e:	66 90                	xchg   %ax,%ax
     d60:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
     d64:	83 c1 01             	add    $0x1,%ecx
     d67:	8d 5a 01             	lea    0x1(%edx),%ebx
  while(*p && *p == *q)
     d6a:	84 c0                	test   %al,%al
     d6c:	74 12                	je     d80 <strcmp+0x40>
    p++, q++;
     d6e:	89 da                	mov    %ebx,%edx
  while(*p && *p == *q)
     d70:	0f b6 1a             	movzbl (%edx),%ebx
     d73:	38 c3                	cmp    %al,%bl
     d75:	74 e9                	je     d60 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
     d77:	29 d8                	sub    %ebx,%eax
}
     d79:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     d7c:	c9                   	leave
     d7d:	c3                   	ret
     d7e:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
     d80:	0f b6 5a 01          	movzbl 0x1(%edx),%ebx
     d84:	31 c0                	xor    %eax,%eax
     d86:	29 d8                	sub    %ebx,%eax
}
     d88:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     d8b:	c9                   	leave
     d8c:	c3                   	ret
     d8d:	8d 76 00             	lea    0x0(%esi),%esi

00000d90 <strlen>:

uint
strlen(const char *s)
{
     d90:	55                   	push   %ebp
     d91:	89 e5                	mov    %esp,%ebp
     d93:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
     d96:	80 3a 00             	cmpb   $0x0,(%edx)
     d99:	74 15                	je     db0 <strlen+0x20>
     d9b:	31 c0                	xor    %eax,%eax
     d9d:	8d 76 00             	lea    0x0(%esi),%esi
     da0:	83 c0 01             	add    $0x1,%eax
     da3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
     da7:	89 c1                	mov    %eax,%ecx
     da9:	75 f5                	jne    da0 <strlen+0x10>
    ;
  return n;
}
     dab:	89 c8                	mov    %ecx,%eax
     dad:	5d                   	pop    %ebp
     dae:	c3                   	ret
     daf:	90                   	nop
  for(n = 0; s[n]; n++)
     db0:	31 c9                	xor    %ecx,%ecx
}
     db2:	5d                   	pop    %ebp
     db3:	89 c8                	mov    %ecx,%eax
     db5:	c3                   	ret
     db6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     dbd:	00 
     dbe:	66 90                	xchg   %ax,%ax

00000dc0 <memset>:

void*
memset(void *dst, int c, uint n)
{
     dc0:	55                   	push   %ebp
     dc1:	89 e5                	mov    %esp,%ebp
     dc3:	57                   	push   %edi
     dc4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     dc7:	8b 4d 10             	mov    0x10(%ebp),%ecx
     dca:	8b 45 0c             	mov    0xc(%ebp),%eax
     dcd:	89 d7                	mov    %edx,%edi
     dcf:	fc                   	cld
     dd0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     dd2:	8b 7d fc             	mov    -0x4(%ebp),%edi
     dd5:	89 d0                	mov    %edx,%eax
     dd7:	c9                   	leave
     dd8:	c3                   	ret
     dd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000de0 <strchr>:

char*
strchr(const char *s, char c)
{
     de0:	55                   	push   %ebp
     de1:	89 e5                	mov    %esp,%ebp
     de3:	8b 45 08             	mov    0x8(%ebp),%eax
     de6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
     dea:	0f b6 10             	movzbl (%eax),%edx
     ded:	84 d2                	test   %dl,%dl
     def:	75 12                	jne    e03 <strchr+0x23>
     df1:	eb 1d                	jmp    e10 <strchr+0x30>
     df3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
     df8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
     dfc:	83 c0 01             	add    $0x1,%eax
     dff:	84 d2                	test   %dl,%dl
     e01:	74 0d                	je     e10 <strchr+0x30>
    if(*s == c)
     e03:	38 d1                	cmp    %dl,%cl
     e05:	75 f1                	jne    df8 <strchr+0x18>
      return (char*)s;
  return 0;
}
     e07:	5d                   	pop    %ebp
     e08:	c3                   	ret
     e09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
     e10:	31 c0                	xor    %eax,%eax
}
     e12:	5d                   	pop    %ebp
     e13:	c3                   	ret
     e14:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     e1b:	00 
     e1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000e20 <gets>:

char*
gets(char *buf, int max)
{
     e20:	55                   	push   %ebp
     e21:	89 e5                	mov    %esp,%ebp
     e23:	57                   	push   %edi
     e24:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
     e25:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
     e28:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
     e29:	31 db                	xor    %ebx,%ebx
{
     e2b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
     e2e:	eb 27                	jmp    e57 <gets+0x37>
    cc = read(0, &c, 1);
     e30:	83 ec 04             	sub    $0x4,%esp
     e33:	6a 01                	push   $0x1
     e35:	57                   	push   %edi
     e36:	6a 00                	push   $0x0
     e38:	e8 2e 01 00 00       	call   f6b <read>
    if(cc < 1)
     e3d:	83 c4 10             	add    $0x10,%esp
     e40:	85 c0                	test   %eax,%eax
     e42:	7e 1d                	jle    e61 <gets+0x41>
      break;
    buf[i++] = c;
     e44:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     e48:	8b 55 08             	mov    0x8(%ebp),%edx
     e4b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
     e4f:	3c 0a                	cmp    $0xa,%al
     e51:	74 1d                	je     e70 <gets+0x50>
     e53:	3c 0d                	cmp    $0xd,%al
     e55:	74 19                	je     e70 <gets+0x50>
  for(i=0; i+1 < max; ){
     e57:	89 de                	mov    %ebx,%esi
     e59:	83 c3 01             	add    $0x1,%ebx
     e5c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     e5f:	7c cf                	jl     e30 <gets+0x10>
      break;
  }
  buf[i] = '\0';
     e61:	8b 45 08             	mov    0x8(%ebp),%eax
     e64:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
     e68:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e6b:	5b                   	pop    %ebx
     e6c:	5e                   	pop    %esi
     e6d:	5f                   	pop    %edi
     e6e:	5d                   	pop    %ebp
     e6f:	c3                   	ret
  buf[i] = '\0';
     e70:	8b 45 08             	mov    0x8(%ebp),%eax
     e73:	89 de                	mov    %ebx,%esi
     e75:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
     e79:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e7c:	5b                   	pop    %ebx
     e7d:	5e                   	pop    %esi
     e7e:	5f                   	pop    %edi
     e7f:	5d                   	pop    %ebp
     e80:	c3                   	ret
     e81:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     e88:	00 
     e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000e90 <stat>:

int
stat(const char *n, struct stat *st)
{
     e90:	55                   	push   %ebp
     e91:	89 e5                	mov    %esp,%ebp
     e93:	56                   	push   %esi
     e94:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     e95:	83 ec 08             	sub    $0x8,%esp
     e98:	6a 00                	push   $0x0
     e9a:	ff 75 08             	push   0x8(%ebp)
     e9d:	e8 f1 00 00 00       	call   f93 <open>
  if(fd < 0)
     ea2:	83 c4 10             	add    $0x10,%esp
     ea5:	85 c0                	test   %eax,%eax
     ea7:	78 27                	js     ed0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
     ea9:	83 ec 08             	sub    $0x8,%esp
     eac:	ff 75 0c             	push   0xc(%ebp)
     eaf:	89 c3                	mov    %eax,%ebx
     eb1:	50                   	push   %eax
     eb2:	e8 f4 00 00 00       	call   fab <fstat>
  close(fd);
     eb7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     eba:	89 c6                	mov    %eax,%esi
  close(fd);
     ebc:	e8 ba 00 00 00       	call   f7b <close>
  return r;
     ec1:	83 c4 10             	add    $0x10,%esp
}
     ec4:	8d 65 f8             	lea    -0x8(%ebp),%esp
     ec7:	89 f0                	mov    %esi,%eax
     ec9:	5b                   	pop    %ebx
     eca:	5e                   	pop    %esi
     ecb:	5d                   	pop    %ebp
     ecc:	c3                   	ret
     ecd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
     ed0:	be ff ff ff ff       	mov    $0xffffffff,%esi
     ed5:	eb ed                	jmp    ec4 <stat+0x34>
     ed7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     ede:	00 
     edf:	90                   	nop

00000ee0 <atoi>:

int
atoi(const char *s)
{
     ee0:	55                   	push   %ebp
     ee1:	89 e5                	mov    %esp,%ebp
     ee3:	53                   	push   %ebx
     ee4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     ee7:	0f be 02             	movsbl (%edx),%eax
     eea:	8d 48 d0             	lea    -0x30(%eax),%ecx
     eed:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
     ef0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
     ef5:	77 1e                	ja     f15 <atoi+0x35>
     ef7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     efe:	00 
     eff:	90                   	nop
    n = n*10 + *s++ - '0';
     f00:	83 c2 01             	add    $0x1,%edx
     f03:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
     f06:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
     f0a:	0f be 02             	movsbl (%edx),%eax
     f0d:	8d 58 d0             	lea    -0x30(%eax),%ebx
     f10:	80 fb 09             	cmp    $0x9,%bl
     f13:	76 eb                	jbe    f00 <atoi+0x20>
  return n;
}
     f15:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     f18:	89 c8                	mov    %ecx,%eax
     f1a:	c9                   	leave
     f1b:	c3                   	ret
     f1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000f20 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     f20:	55                   	push   %ebp
     f21:	89 e5                	mov    %esp,%ebp
     f23:	57                   	push   %edi
     f24:	8b 45 10             	mov    0x10(%ebp),%eax
     f27:	8b 55 08             	mov    0x8(%ebp),%edx
     f2a:	56                   	push   %esi
     f2b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     f2e:	85 c0                	test   %eax,%eax
     f30:	7e 13                	jle    f45 <memmove+0x25>
     f32:	01 d0                	add    %edx,%eax
  dst = vdst;
     f34:	89 d7                	mov    %edx,%edi
     f36:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     f3d:	00 
     f3e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
     f40:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
     f41:	39 f8                	cmp    %edi,%eax
     f43:	75 fb                	jne    f40 <memmove+0x20>
  return vdst;
}
     f45:	5e                   	pop    %esi
     f46:	89 d0                	mov    %edx,%eax
     f48:	5f                   	pop    %edi
     f49:	5d                   	pop    %ebp
     f4a:	c3                   	ret

00000f4b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     f4b:	b8 01 00 00 00       	mov    $0x1,%eax
     f50:	cd 40                	int    $0x40
     f52:	c3                   	ret

00000f53 <exit>:
SYSCALL(exit)
     f53:	b8 02 00 00 00       	mov    $0x2,%eax
     f58:	cd 40                	int    $0x40
     f5a:	c3                   	ret

00000f5b <wait>:
SYSCALL(wait)
     f5b:	b8 03 00 00 00       	mov    $0x3,%eax
     f60:	cd 40                	int    $0x40
     f62:	c3                   	ret

00000f63 <pipe>:
SYSCALL(pipe)
     f63:	b8 04 00 00 00       	mov    $0x4,%eax
     f68:	cd 40                	int    $0x40
     f6a:	c3                   	ret

00000f6b <read>:
SYSCALL(read)
     f6b:	b8 05 00 00 00       	mov    $0x5,%eax
     f70:	cd 40                	int    $0x40
     f72:	c3                   	ret

00000f73 <write>:
SYSCALL(write)
     f73:	b8 10 00 00 00       	mov    $0x10,%eax
     f78:	cd 40                	int    $0x40
     f7a:	c3                   	ret

00000f7b <close>:
SYSCALL(close)
     f7b:	b8 15 00 00 00       	mov    $0x15,%eax
     f80:	cd 40                	int    $0x40
     f82:	c3                   	ret

00000f83 <kill>:
SYSCALL(kill)
     f83:	b8 06 00 00 00       	mov    $0x6,%eax
     f88:	cd 40                	int    $0x40
     f8a:	c3                   	ret

00000f8b <exec>:
SYSCALL(exec)
     f8b:	b8 07 00 00 00       	mov    $0x7,%eax
     f90:	cd 40                	int    $0x40
     f92:	c3                   	ret

00000f93 <open>:
SYSCALL(open)
     f93:	b8 0f 00 00 00       	mov    $0xf,%eax
     f98:	cd 40                	int    $0x40
     f9a:	c3                   	ret

00000f9b <mknod>:
SYSCALL(mknod)
     f9b:	b8 11 00 00 00       	mov    $0x11,%eax
     fa0:	cd 40                	int    $0x40
     fa2:	c3                   	ret

00000fa3 <unlink>:
SYSCALL(unlink)
     fa3:	b8 12 00 00 00       	mov    $0x12,%eax
     fa8:	cd 40                	int    $0x40
     faa:	c3                   	ret

00000fab <fstat>:
SYSCALL(fstat)
     fab:	b8 08 00 00 00       	mov    $0x8,%eax
     fb0:	cd 40                	int    $0x40
     fb2:	c3                   	ret

00000fb3 <link>:
SYSCALL(link)
     fb3:	b8 13 00 00 00       	mov    $0x13,%eax
     fb8:	cd 40                	int    $0x40
     fba:	c3                   	ret

00000fbb <mkdir>:
SYSCALL(mkdir)
     fbb:	b8 14 00 00 00       	mov    $0x14,%eax
     fc0:	cd 40                	int    $0x40
     fc2:	c3                   	ret

00000fc3 <chdir>:
SYSCALL(chdir)
     fc3:	b8 09 00 00 00       	mov    $0x9,%eax
     fc8:	cd 40                	int    $0x40
     fca:	c3                   	ret

00000fcb <dup>:
SYSCALL(dup)
     fcb:	b8 0a 00 00 00       	mov    $0xa,%eax
     fd0:	cd 40                	int    $0x40
     fd2:	c3                   	ret

00000fd3 <getpid>:
SYSCALL(getpid)
     fd3:	b8 0b 00 00 00       	mov    $0xb,%eax
     fd8:	cd 40                	int    $0x40
     fda:	c3                   	ret

00000fdb <sbrk>:
SYSCALL(sbrk)
     fdb:	b8 0c 00 00 00       	mov    $0xc,%eax
     fe0:	cd 40                	int    $0x40
     fe2:	c3                   	ret

00000fe3 <sleep>:
SYSCALL(sleep)
     fe3:	b8 0d 00 00 00       	mov    $0xd,%eax
     fe8:	cd 40                	int    $0x40
     fea:	c3                   	ret

00000feb <uptime>:
SYSCALL(uptime)
     feb:	b8 0e 00 00 00       	mov    $0xe,%eax
     ff0:	cd 40                	int    $0x40
     ff2:	c3                   	ret

00000ff3 <create_palindrome>:
SYSCALL(create_palindrome)
     ff3:	b8 16 00 00 00       	mov    $0x16,%eax
     ff8:	cd 40                	int    $0x40
     ffa:	c3                   	ret

00000ffb <sort_syscalls>:
SYSCALL(sort_syscalls)
     ffb:	b8 17 00 00 00       	mov    $0x17,%eax
    1000:	cd 40                	int    $0x40
    1002:	c3                   	ret

00001003 <get_most_invoked_syscall>:
SYSCALL(get_most_invoked_syscall)
    1003:	b8 18 00 00 00       	mov    $0x18,%eax
    1008:	cd 40                	int    $0x40
    100a:	c3                   	ret

0000100b <list_all_processes>:
SYSCALL(list_all_processes)
    100b:	b8 19 00 00 00       	mov    $0x19,%eax
    1010:	cd 40                	int    $0x40
    1012:	c3                   	ret

00001013 <move_file>:
SYSCALL(move_file)
    1013:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1018:	cd 40                	int    $0x40
    101a:	c3                   	ret

0000101b <open_sharedmem>:
SYSCALL(open_sharedmem)
    101b:	b8 1b 00 00 00       	mov    $0x1b,%eax
    1020:	cd 40                	int    $0x40
    1022:	c3                   	ret

00001023 <close_sharedmem>:
    1023:	b8 1c 00 00 00       	mov    $0x1c,%eax
    1028:	cd 40                	int    $0x40
    102a:	c3                   	ret
    102b:	66 90                	xchg   %ax,%ax
    102d:	66 90                	xchg   %ax,%ax
    102f:	90                   	nop

00001030 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1030:	55                   	push   %ebp
    1031:	89 e5                	mov    %esp,%ebp
    1033:	57                   	push   %edi
    1034:	56                   	push   %esi
    1035:	53                   	push   %ebx
    1036:	83 ec 3c             	sub    $0x3c,%esp
    1039:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    103c:	89 d1                	mov    %edx,%ecx
{
    103e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    1041:	85 d2                	test   %edx,%edx
    1043:	0f 89 7f 00 00 00    	jns    10c8 <printint+0x98>
    1049:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    104d:	74 79                	je     10c8 <printint+0x98>
    neg = 1;
    104f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    1056:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    1058:	31 db                	xor    %ebx,%ebx
    105a:	8d 75 d7             	lea    -0x29(%ebp),%esi
    105d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    1060:	89 c8                	mov    %ecx,%eax
    1062:	31 d2                	xor    %edx,%edx
    1064:	89 cf                	mov    %ecx,%edi
    1066:	f7 75 c4             	divl   -0x3c(%ebp)
    1069:	0f b6 92 48 15 00 00 	movzbl 0x1548(%edx),%edx
    1070:	89 45 c0             	mov    %eax,-0x40(%ebp)
    1073:	89 d8                	mov    %ebx,%eax
    1075:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    1078:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    107b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    107e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    1081:	76 dd                	jbe    1060 <printint+0x30>
  if(neg)
    1083:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    1086:	85 c9                	test   %ecx,%ecx
    1088:	74 0c                	je     1096 <printint+0x66>
    buf[i++] = '-';
    108a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    108f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    1091:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    1096:	8b 7d b8             	mov    -0x48(%ebp),%edi
    1099:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    109d:	eb 07                	jmp    10a6 <printint+0x76>
    109f:	90                   	nop
    putc(fd, buf[i]);
    10a0:	0f b6 13             	movzbl (%ebx),%edx
    10a3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    10a6:	83 ec 04             	sub    $0x4,%esp
    10a9:	88 55 d7             	mov    %dl,-0x29(%ebp)
    10ac:	6a 01                	push   $0x1
    10ae:	56                   	push   %esi
    10af:	57                   	push   %edi
    10b0:	e8 be fe ff ff       	call   f73 <write>
  while(--i >= 0)
    10b5:	83 c4 10             	add    $0x10,%esp
    10b8:	39 de                	cmp    %ebx,%esi
    10ba:	75 e4                	jne    10a0 <printint+0x70>
}
    10bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    10bf:	5b                   	pop    %ebx
    10c0:	5e                   	pop    %esi
    10c1:	5f                   	pop    %edi
    10c2:	5d                   	pop    %ebp
    10c3:	c3                   	ret
    10c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    10c8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    10cf:	eb 87                	jmp    1058 <printint+0x28>
    10d1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    10d8:	00 
    10d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000010e0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    10e0:	55                   	push   %ebp
    10e1:	89 e5                	mov    %esp,%ebp
    10e3:	57                   	push   %edi
    10e4:	56                   	push   %esi
    10e5:	53                   	push   %ebx
    10e6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    10e9:	8b 75 0c             	mov    0xc(%ebp),%esi
    10ec:	0f b6 1e             	movzbl (%esi),%ebx
    10ef:	84 db                	test   %bl,%bl
    10f1:	0f 84 b8 00 00 00    	je     11af <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
    10f7:	8d 45 10             	lea    0x10(%ebp),%eax
    10fa:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    10fd:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    1100:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
    1102:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1105:	eb 37                	jmp    113e <printf+0x5e>
    1107:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    110e:	00 
    110f:	90                   	nop
    1110:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    1113:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    1118:	83 f8 25             	cmp    $0x25,%eax
    111b:	74 17                	je     1134 <printf+0x54>
  write(fd, &c, 1);
    111d:	83 ec 04             	sub    $0x4,%esp
    1120:	88 5d e7             	mov    %bl,-0x19(%ebp)
    1123:	6a 01                	push   $0x1
    1125:	57                   	push   %edi
    1126:	ff 75 08             	push   0x8(%ebp)
    1129:	e8 45 fe ff ff       	call   f73 <write>
    112e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
    1131:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    1134:	0f b6 1e             	movzbl (%esi),%ebx
    1137:	83 c6 01             	add    $0x1,%esi
    113a:	84 db                	test   %bl,%bl
    113c:	74 71                	je     11af <printf+0xcf>
    c = fmt[i] & 0xff;
    113e:	0f be cb             	movsbl %bl,%ecx
    1141:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    1144:	85 d2                	test   %edx,%edx
    1146:	74 c8                	je     1110 <printf+0x30>
      }
    } else if(state == '%'){
    1148:	83 fa 25             	cmp    $0x25,%edx
    114b:	75 e7                	jne    1134 <printf+0x54>
      if(c == 'd'){
    114d:	83 f8 64             	cmp    $0x64,%eax
    1150:	0f 84 9a 00 00 00    	je     11f0 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1156:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    115c:	83 f9 70             	cmp    $0x70,%ecx
    115f:	74 5f                	je     11c0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1161:	83 f8 73             	cmp    $0x73,%eax
    1164:	0f 84 d6 00 00 00    	je     1240 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    116a:	83 f8 63             	cmp    $0x63,%eax
    116d:	0f 84 8d 00 00 00    	je     1200 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1173:	83 f8 25             	cmp    $0x25,%eax
    1176:	0f 84 b4 00 00 00    	je     1230 <printf+0x150>
  write(fd, &c, 1);
    117c:	83 ec 04             	sub    $0x4,%esp
    117f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    1183:	6a 01                	push   $0x1
    1185:	57                   	push   %edi
    1186:	ff 75 08             	push   0x8(%ebp)
    1189:	e8 e5 fd ff ff       	call   f73 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    118e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    1191:	83 c4 0c             	add    $0xc,%esp
    1194:	6a 01                	push   $0x1
  for(i = 0; fmt[i]; i++){
    1196:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    1199:	57                   	push   %edi
    119a:	ff 75 08             	push   0x8(%ebp)
    119d:	e8 d1 fd ff ff       	call   f73 <write>
  for(i = 0; fmt[i]; i++){
    11a2:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
    11a6:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    11a9:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
    11ab:	84 db                	test   %bl,%bl
    11ad:	75 8f                	jne    113e <printf+0x5e>
    }
  }
}
    11af:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11b2:	5b                   	pop    %ebx
    11b3:	5e                   	pop    %esi
    11b4:	5f                   	pop    %edi
    11b5:	5d                   	pop    %ebp
    11b6:	c3                   	ret
    11b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    11be:	00 
    11bf:	90                   	nop
        printint(fd, *ap, 16, 0);
    11c0:	83 ec 0c             	sub    $0xc,%esp
    11c3:	b9 10 00 00 00       	mov    $0x10,%ecx
    11c8:	6a 00                	push   $0x0
    11ca:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    11cd:	8b 45 08             	mov    0x8(%ebp),%eax
    11d0:	8b 13                	mov    (%ebx),%edx
    11d2:	e8 59 fe ff ff       	call   1030 <printint>
        ap++;
    11d7:	89 d8                	mov    %ebx,%eax
    11d9:	83 c4 10             	add    $0x10,%esp
      state = 0;
    11dc:	31 d2                	xor    %edx,%edx
        ap++;
    11de:	83 c0 04             	add    $0x4,%eax
    11e1:	89 45 d0             	mov    %eax,-0x30(%ebp)
    11e4:	e9 4b ff ff ff       	jmp    1134 <printf+0x54>
    11e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
    11f0:	83 ec 0c             	sub    $0xc,%esp
    11f3:	b9 0a 00 00 00       	mov    $0xa,%ecx
    11f8:	6a 01                	push   $0x1
    11fa:	eb ce                	jmp    11ca <printf+0xea>
    11fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
    1200:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    1203:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    1206:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
    1208:	6a 01                	push   $0x1
        ap++;
    120a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    120d:	57                   	push   %edi
    120e:	ff 75 08             	push   0x8(%ebp)
        putc(fd, *ap);
    1211:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    1214:	e8 5a fd ff ff       	call   f73 <write>
        ap++;
    1219:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    121c:	83 c4 10             	add    $0x10,%esp
      state = 0;
    121f:	31 d2                	xor    %edx,%edx
    1221:	e9 0e ff ff ff       	jmp    1134 <printf+0x54>
    1226:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    122d:	00 
    122e:	66 90                	xchg   %ax,%ax
        putc(fd, c);
    1230:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    1233:	83 ec 04             	sub    $0x4,%esp
    1236:	e9 59 ff ff ff       	jmp    1194 <printf+0xb4>
    123b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    1240:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1243:	8b 18                	mov    (%eax),%ebx
        ap++;
    1245:	83 c0 04             	add    $0x4,%eax
    1248:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    124b:	85 db                	test   %ebx,%ebx
    124d:	74 17                	je     1266 <printf+0x186>
        while(*s != 0){
    124f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
    1252:	31 d2                	xor    %edx,%edx
        while(*s != 0){
    1254:	84 c0                	test   %al,%al
    1256:	0f 84 d8 fe ff ff    	je     1134 <printf+0x54>
    125c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    125f:	89 de                	mov    %ebx,%esi
    1261:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1264:	eb 1a                	jmp    1280 <printf+0x1a0>
          s = "(null)";
    1266:	bb 10 15 00 00       	mov    $0x1510,%ebx
        while(*s != 0){
    126b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    126e:	b8 28 00 00 00       	mov    $0x28,%eax
    1273:	89 de                	mov    %ebx,%esi
    1275:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1278:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    127f:	00 
  write(fd, &c, 1);
    1280:	83 ec 04             	sub    $0x4,%esp
          s++;
    1283:	83 c6 01             	add    $0x1,%esi
    1286:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    1289:	6a 01                	push   $0x1
    128b:	57                   	push   %edi
    128c:	53                   	push   %ebx
    128d:	e8 e1 fc ff ff       	call   f73 <write>
        while(*s != 0){
    1292:	0f b6 06             	movzbl (%esi),%eax
    1295:	83 c4 10             	add    $0x10,%esp
    1298:	84 c0                	test   %al,%al
    129a:	75 e4                	jne    1280 <printf+0x1a0>
      state = 0;
    129c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    129f:	31 d2                	xor    %edx,%edx
    12a1:	e9 8e fe ff ff       	jmp    1134 <printf+0x54>
    12a6:	66 90                	xchg   %ax,%ax
    12a8:	66 90                	xchg   %ax,%ax
    12aa:	66 90                	xchg   %ax,%ax
    12ac:	66 90                	xchg   %ax,%ax
    12ae:	66 90                	xchg   %ax,%ax

000012b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    12b0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    12b1:	a1 e4 20 00 00       	mov    0x20e4,%eax
{
    12b6:	89 e5                	mov    %esp,%ebp
    12b8:	57                   	push   %edi
    12b9:	56                   	push   %esi
    12ba:	53                   	push   %ebx
    12bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    12be:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    12c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    12c8:	89 c2                	mov    %eax,%edx
    12ca:	8b 00                	mov    (%eax),%eax
    12cc:	39 ca                	cmp    %ecx,%edx
    12ce:	73 30                	jae    1300 <free+0x50>
    12d0:	39 c1                	cmp    %eax,%ecx
    12d2:	72 04                	jb     12d8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    12d4:	39 c2                	cmp    %eax,%edx
    12d6:	72 f0                	jb     12c8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    12d8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    12db:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    12de:	39 f8                	cmp    %edi,%eax
    12e0:	74 30                	je     1312 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    12e2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    12e5:	8b 42 04             	mov    0x4(%edx),%eax
    12e8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    12eb:	39 f1                	cmp    %esi,%ecx
    12ed:	74 3a                	je     1329 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    12ef:	89 0a                	mov    %ecx,(%edx)
  freep = p;
}
    12f1:	5b                   	pop    %ebx
  freep = p;
    12f2:	89 15 e4 20 00 00    	mov    %edx,0x20e4
}
    12f8:	5e                   	pop    %esi
    12f9:	5f                   	pop    %edi
    12fa:	5d                   	pop    %ebp
    12fb:	c3                   	ret
    12fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1300:	39 c2                	cmp    %eax,%edx
    1302:	72 c4                	jb     12c8 <free+0x18>
    1304:	39 c1                	cmp    %eax,%ecx
    1306:	73 c0                	jae    12c8 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    1308:	8b 73 fc             	mov    -0x4(%ebx),%esi
    130b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    130e:	39 f8                	cmp    %edi,%eax
    1310:	75 d0                	jne    12e2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    1312:	03 70 04             	add    0x4(%eax),%esi
    1315:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1318:	8b 02                	mov    (%edx),%eax
    131a:	8b 00                	mov    (%eax),%eax
    131c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    131f:	8b 42 04             	mov    0x4(%edx),%eax
    1322:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    1325:	39 f1                	cmp    %esi,%ecx
    1327:	75 c6                	jne    12ef <free+0x3f>
    p->s.size += bp->s.size;
    1329:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    132c:	89 15 e4 20 00 00    	mov    %edx,0x20e4
    p->s.size += bp->s.size;
    1332:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    1335:	8b 43 f8             	mov    -0x8(%ebx),%eax
    1338:	89 02                	mov    %eax,(%edx)
}
    133a:	5b                   	pop    %ebx
    133b:	5e                   	pop    %esi
    133c:	5f                   	pop    %edi
    133d:	5d                   	pop    %ebp
    133e:	c3                   	ret
    133f:	90                   	nop

00001340 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1340:	55                   	push   %ebp
    1341:	89 e5                	mov    %esp,%ebp
    1343:	57                   	push   %edi
    1344:	56                   	push   %esi
    1345:	53                   	push   %ebx
    1346:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1349:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    134c:	8b 3d e4 20 00 00    	mov    0x20e4,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1352:	8d 70 07             	lea    0x7(%eax),%esi
    1355:	c1 ee 03             	shr    $0x3,%esi
    1358:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    135b:	85 ff                	test   %edi,%edi
    135d:	0f 84 ad 00 00 00    	je     1410 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1363:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
    1365:	8b 48 04             	mov    0x4(%eax),%ecx
    1368:	39 f1                	cmp    %esi,%ecx
    136a:	73 71                	jae    13dd <malloc+0x9d>
    136c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
    1372:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1377:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    137a:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
    1381:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    1384:	eb 1b                	jmp    13a1 <malloc+0x61>
    1386:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    138d:	00 
    138e:	66 90                	xchg   %ax,%ax
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1390:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
    1392:	8b 4a 04             	mov    0x4(%edx),%ecx
    1395:	39 f1                	cmp    %esi,%ecx
    1397:	73 4f                	jae    13e8 <malloc+0xa8>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1399:	8b 3d e4 20 00 00    	mov    0x20e4,%edi
    139f:	89 d0                	mov    %edx,%eax
    13a1:	39 c7                	cmp    %eax,%edi
    13a3:	75 eb                	jne    1390 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
    13a5:	83 ec 0c             	sub    $0xc,%esp
    13a8:	ff 75 e4             	push   -0x1c(%ebp)
    13ab:	e8 2b fc ff ff       	call   fdb <sbrk>
  if(p == (char*)-1)
    13b0:	83 c4 10             	add    $0x10,%esp
    13b3:	83 f8 ff             	cmp    $0xffffffff,%eax
    13b6:	74 1b                	je     13d3 <malloc+0x93>
  hp->s.size = nu;
    13b8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    13bb:	83 ec 0c             	sub    $0xc,%esp
    13be:	83 c0 08             	add    $0x8,%eax
    13c1:	50                   	push   %eax
    13c2:	e8 e9 fe ff ff       	call   12b0 <free>
  return freep;
    13c7:	a1 e4 20 00 00       	mov    0x20e4,%eax
      if((p = morecore(nunits)) == 0)
    13cc:	83 c4 10             	add    $0x10,%esp
    13cf:	85 c0                	test   %eax,%eax
    13d1:	75 bd                	jne    1390 <malloc+0x50>
        return 0;
  }
}
    13d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    13d6:	31 c0                	xor    %eax,%eax
}
    13d8:	5b                   	pop    %ebx
    13d9:	5e                   	pop    %esi
    13da:	5f                   	pop    %edi
    13db:	5d                   	pop    %ebp
    13dc:	c3                   	ret
    if(p->s.size >= nunits){
    13dd:	89 c2                	mov    %eax,%edx
    13df:	89 f8                	mov    %edi,%eax
    13e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
    13e8:	39 ce                	cmp    %ecx,%esi
    13ea:	74 54                	je     1440 <malloc+0x100>
        p->s.size -= nunits;
    13ec:	29 f1                	sub    %esi,%ecx
    13ee:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
    13f1:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
    13f4:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
    13f7:	a3 e4 20 00 00       	mov    %eax,0x20e4
}
    13fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    13ff:	8d 42 08             	lea    0x8(%edx),%eax
}
    1402:	5b                   	pop    %ebx
    1403:	5e                   	pop    %esi
    1404:	5f                   	pop    %edi
    1405:	5d                   	pop    %ebp
    1406:	c3                   	ret
    1407:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    140e:	00 
    140f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
    1410:	c7 05 e4 20 00 00 e8 	movl   $0x20e8,0x20e4
    1417:	20 00 00 
    base.s.size = 0;
    141a:	bf e8 20 00 00       	mov    $0x20e8,%edi
    base.s.ptr = freep = prevp = &base;
    141f:	c7 05 e8 20 00 00 e8 	movl   $0x20e8,0x20e8
    1426:	20 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1429:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
    142b:	c7 05 ec 20 00 00 00 	movl   $0x0,0x20ec
    1432:	00 00 00 
    if(p->s.size >= nunits){
    1435:	e9 32 ff ff ff       	jmp    136c <malloc+0x2c>
    143a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    1440:	8b 0a                	mov    (%edx),%ecx
    1442:	89 08                	mov    %ecx,(%eax)
    1444:	eb b1                	jmp    13f7 <malloc+0xb7>
