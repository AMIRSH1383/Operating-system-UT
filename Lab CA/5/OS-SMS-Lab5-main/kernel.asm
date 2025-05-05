
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 b0 10 00       	mov    $0x10b000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc e0 ac 34 80       	mov    $0x8034ace0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 40 41 10 80       	mov    $0x80104140,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb f4 c8 10 80       	mov    $0x8010c8f4,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 00 90 10 80       	push   $0x80109000
80100051:	68 c0 c8 10 80       	push   $0x8010c8c0
80100056:	e8 95 5a 00 00       	call   80105af0 <initlock>
  bcache.head.next = &bcache.head;
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 bc 0f 11 80       	mov    $0x80110fbc,%eax
  bcache.head.prev = &bcache.head;
80100063:	c7 05 0c 10 11 80 bc 	movl   $0x80110fbc,0x8011100c
8010006a:	0f 11 80 
  bcache.head.next = &bcache.head;
8010006d:	c7 05 10 10 11 80 bc 	movl   $0x80110fbc,0x80111010
80100074:	0f 11 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 d3                	mov    %edx,%ebx
    b->next = bcache.head.next;
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->prev = &bcache.head;
8010008b:	c7 43 50 bc 0f 11 80 	movl   $0x80110fbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 07 90 10 80       	push   $0x80109007
80100097:	50                   	push   %eax
80100098:	e8 23 59 00 00       	call   801059c0 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 10 10 11 80       	mov    0x80111010,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 10 10 11 80    	mov    %ebx,0x80111010
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb 60 0d 11 80    	cmp    $0x80110d60,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
  }
}
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave
801000c2:	c3                   	ret
801000c3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801000ca:	00 
801000cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 c0 c8 10 80       	push   $0x8010c8c0
801000e4:	e8 d7 5b 00 00       	call   80105cc0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 10 10 11 80    	mov    0x80111010,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb bc 0f 11 80    	cmp    $0x80110fbc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc 0f 11 80    	cmp    $0x80110fbc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 0c 10 11 80    	mov    0x8011100c,%ebx
80100126:	81 fb bc 0f 11 80    	cmp    $0x80110fbc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 6e                	jmp    8010019e <bread+0xce>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc 0f 11 80    	cmp    $0x80110fbc,%ebx
80100139:	74 63                	je     8010019e <bread+0xce>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 c0 c8 10 80       	push   $0x8010c8c0
80100162:	e8 f9 5a 00 00       	call   80105c60 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 8e 58 00 00       	call   80105a00 <acquiresleep>
      return b;
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	74 0e                	je     80100188 <bread+0xb8>
    iderw(b);
  }
  return b;
}
8010017a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010017d:	89 d8                	mov    %ebx,%eax
8010017f:	5b                   	pop    %ebx
80100180:	5e                   	pop    %esi
80100181:	5f                   	pop    %edi
80100182:	5d                   	pop    %ebp
80100183:	c3                   	ret
80100184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iderw(b);
80100188:	83 ec 0c             	sub    $0xc,%esp
8010018b:	53                   	push   %ebx
8010018c:	e8 2f 32 00 00       	call   801033c0 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
}
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret
  panic("bget: no buffers");
8010019e:	83 ec 0c             	sub    $0xc,%esp
801001a1:	68 0e 90 10 80       	push   $0x8010900e
801001a6:	e8 25 03 00 00       	call   801004d0 <panic>
801001ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801001b0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001b0:	55                   	push   %ebp
801001b1:	89 e5                	mov    %esp,%ebp
801001b3:	53                   	push   %ebx
801001b4:	83 ec 10             	sub    $0x10,%esp
801001b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801001bd:	50                   	push   %eax
801001be:	e8 dd 58 00 00       	call   80105aa0 <holdingsleep>
801001c3:	83 c4 10             	add    $0x10,%esp
801001c6:	85 c0                	test   %eax,%eax
801001c8:	74 0f                	je     801001d9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ca:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001cd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d3:	c9                   	leave
  iderw(b);
801001d4:	e9 e7 31 00 00       	jmp    801033c0 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 1f 90 10 80       	push   $0x8010901f
801001e1:	e8 ea 02 00 00       	call   801004d0 <panic>
801001e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801001ed:	00 
801001ee:	66 90                	xchg   %ax,%ax

801001f0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001f0:	55                   	push   %ebp
801001f1:	89 e5                	mov    %esp,%ebp
801001f3:	56                   	push   %esi
801001f4:	53                   	push   %ebx
801001f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001f8:	8d 73 0c             	lea    0xc(%ebx),%esi
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 9c 58 00 00       	call   80105aa0 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 66                	je     80100271 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 4c 58 00 00       	call   80105a60 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 c0 c8 10 80 	movl   $0x8010c8c0,(%esp)
8010021b:	e8 a0 5a 00 00       	call   80105cc0 <acquire>
  b->refcnt--;
80100220:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100223:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100226:	83 e8 01             	sub    $0x1,%eax
80100229:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010022c:	85 c0                	test   %eax,%eax
8010022e:	75 2f                	jne    8010025f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100230:	8b 43 54             	mov    0x54(%ebx),%eax
80100233:	8b 53 50             	mov    0x50(%ebx),%edx
80100236:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100239:	8b 43 50             	mov    0x50(%ebx),%eax
8010023c:	8b 53 54             	mov    0x54(%ebx),%edx
8010023f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100242:	a1 10 10 11 80       	mov    0x80111010,%eax
    b->prev = &bcache.head;
80100247:	c7 43 50 bc 0f 11 80 	movl   $0x80110fbc,0x50(%ebx)
    b->next = bcache.head.next;
8010024e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100251:	a1 10 10 11 80       	mov    0x80111010,%eax
80100256:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100259:	89 1d 10 10 11 80    	mov    %ebx,0x80111010
  }
  
  release(&bcache.lock);
8010025f:	c7 45 08 c0 c8 10 80 	movl   $0x8010c8c0,0x8(%ebp)
}
80100266:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100269:	5b                   	pop    %ebx
8010026a:	5e                   	pop    %esi
8010026b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010026c:	e9 ef 59 00 00       	jmp    80105c60 <release>
    panic("brelse");
80100271:	83 ec 0c             	sub    $0xc,%esp
80100274:	68 26 90 10 80       	push   $0x80109026
80100279:	e8 52 02 00 00       	call   801004d0 <panic>
8010027e:	66 90                	xchg   %ax,%ax

80100280 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100280:	55                   	push   %ebp
80100281:	89 e5                	mov    %esp,%ebp
80100283:	57                   	push   %edi
80100284:	56                   	push   %esi
80100285:	53                   	push   %ebx
80100286:	83 ec 18             	sub    $0x18,%esp
80100289:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010028c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010028f:	ff 75 08             	push   0x8(%ebp)
  target = n;
80100292:	89 df                	mov    %ebx,%edi
  iunlock(ip);
80100294:	e8 a7 26 00 00       	call   80102940 <iunlock>
  acquire(&cons.lock);
80100299:	c7 04 24 c0 17 11 80 	movl   $0x801117c0,(%esp)
801002a0:	e8 1b 5a 00 00       	call   80105cc0 <acquire>
  while(n > 0){
801002a5:	83 c4 10             	add    $0x10,%esp
801002a8:	85 db                	test   %ebx,%ebx
801002aa:	0f 8e 94 00 00 00    	jle    80100344 <consoleread+0xc4>
    while(input.r == input.w){
801002b0:	a1 a4 12 11 80       	mov    0x801112a4,%eax
801002b5:	3b 05 a8 12 11 80    	cmp    0x801112a8,%eax
801002bb:	74 25                	je     801002e2 <consoleread+0x62>
801002bd:	eb 59                	jmp    80100318 <consoleread+0x98>
801002bf:	90                   	nop
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002c0:	83 ec 08             	sub    $0x8,%esp
801002c3:	68 c0 17 11 80       	push   $0x801117c0
801002c8:	68 a4 12 11 80       	push   $0x801112a4
801002cd:	e8 6e 4e 00 00       	call   80105140 <sleep>
    while(input.r == input.w){
801002d2:	a1 a4 12 11 80       	mov    0x801112a4,%eax
801002d7:	83 c4 10             	add    $0x10,%esp
801002da:	3b 05 a8 12 11 80    	cmp    0x801112a8,%eax
801002e0:	75 36                	jne    80100318 <consoleread+0x98>
      if(myproc()->killed){
801002e2:	e8 89 47 00 00       	call   80104a70 <myproc>
801002e7:	8b 48 24             	mov    0x24(%eax),%ecx
801002ea:	85 c9                	test   %ecx,%ecx
801002ec:	74 d2                	je     801002c0 <consoleread+0x40>
        release(&cons.lock);
801002ee:	83 ec 0c             	sub    $0xc,%esp
801002f1:	68 c0 17 11 80       	push   $0x801117c0
801002f6:	e8 65 59 00 00       	call   80105c60 <release>
        ilock(ip);
801002fb:	5a                   	pop    %edx
801002fc:	ff 75 08             	push   0x8(%ebp)
801002ff:	e8 5c 25 00 00       	call   80102860 <ilock>
        return -1;
80100304:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100307:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
8010030a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010030f:	5b                   	pop    %ebx
80100310:	5e                   	pop    %esi
80100311:	5f                   	pop    %edi
80100312:	5d                   	pop    %ebp
80100313:	c3                   	ret
80100314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100318:	8d 50 01             	lea    0x1(%eax),%edx
8010031b:	89 15 a4 12 11 80    	mov    %edx,0x801112a4
80100321:	89 c2                	mov    %eax,%edx
80100323:	83 e2 7f             	and    $0x7f,%edx
80100326:	0f be 8a 24 12 11 80 	movsbl -0x7feeeddc(%edx),%ecx
    if(c == C('D')){  // EOF
8010032d:	80 f9 04             	cmp    $0x4,%cl
80100330:	74 37                	je     80100369 <consoleread+0xe9>
    *dst++ = c;
80100332:	83 c6 01             	add    $0x1,%esi
    --n;
80100335:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
80100338:	88 4e ff             	mov    %cl,-0x1(%esi)
    if(c == '\n')
8010033b:	83 f9 0a             	cmp    $0xa,%ecx
8010033e:	0f 85 64 ff ff ff    	jne    801002a8 <consoleread+0x28>
  release(&cons.lock);
80100344:	83 ec 0c             	sub    $0xc,%esp
80100347:	68 c0 17 11 80       	push   $0x801117c0
8010034c:	e8 0f 59 00 00       	call   80105c60 <release>
  ilock(ip);
80100351:	58                   	pop    %eax
80100352:	ff 75 08             	push   0x8(%ebp)
80100355:	e8 06 25 00 00       	call   80102860 <ilock>
  return target - n;
8010035a:	89 f8                	mov    %edi,%eax
8010035c:	83 c4 10             	add    $0x10,%esp
}
8010035f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
80100362:	29 d8                	sub    %ebx,%eax
}
80100364:	5b                   	pop    %ebx
80100365:	5e                   	pop    %esi
80100366:	5f                   	pop    %edi
80100367:	5d                   	pop    %ebp
80100368:	c3                   	ret
      if(n < target){
80100369:	39 fb                	cmp    %edi,%ebx
8010036b:	73 d7                	jae    80100344 <consoleread+0xc4>
        input.r--;
8010036d:	a3 a4 12 11 80       	mov    %eax,0x801112a4
80100372:	eb d0                	jmp    80100344 <consoleread+0xc4>
80100374:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010037b:	00 
8010037c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100380 <add_history.part.0>:
void add_history(char *command)
80100380:	55                   	push   %ebp
80100381:	89 e5                	mov    %esp,%ebp
80100383:	57                   	push   %edi
80100384:	56                   	push   %esi
80100385:	53                   	push   %ebx
80100386:	89 c3                	mov    %eax,%ebx
80100388:	83 ec 28             	sub    $0x28,%esp
    int length = strlen(command) <= MAX_LEN_OF_COMMAND ? strlen(command) : MAX_LEN_OF_COMMAND - 1;
8010038b:	50                   	push   %eax
8010038c:	e8 ef 5b 00 00       	call   80105f80 <strlen>
80100391:	c7 45 e0 7f 00 00 00 	movl   $0x7f,-0x20(%ebp)
80100398:	83 c4 10             	add    $0x10,%esp
8010039b:	c7 45 e4 7f 00 00 00 	movl   $0x7f,-0x1c(%ebp)
801003a2:	3d 80 00 00 00       	cmp    $0x80,%eax
801003a7:	0f 8e 8b 00 00 00    	jle    80100438 <add_history.part.0+0xb8>
    if(num_of_stored_commands < MAX_NUM_OF_HISTORY)
801003ad:	a1 b4 12 11 80       	mov    0x801112b4,%eax
801003b2:	83 f8 09             	cmp    $0x9,%eax
801003b5:	7f 49                	jg     80100400 <add_history.part.0+0x80>
      num_of_stored_commands++;
801003b7:	8d 50 01             	lea    0x1(%eax),%edx
801003ba:	89 15 b4 12 11 80    	mov    %edx,0x801112b4
    memmove(command_history[num_of_stored_commands-1], command, sizeof(char)* length);
801003c0:	c1 e0 07             	shl    $0x7,%eax
801003c3:	83 ec 04             	sub    $0x4,%esp
801003c6:	ff 75 e0             	push   -0x20(%ebp)
801003c9:	05 c0 12 11 80       	add    $0x801112c0,%eax
801003ce:	53                   	push   %ebx
801003cf:	50                   	push   %eax
801003d0:	e8 4b 5a 00 00       	call   80105e20 <memmove>
    command_history[num_of_stored_commands-1][length] = '\0';
801003d5:	a1 b4 12 11 80       	mov    0x801112b4,%eax
801003da:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
}
801003dd:	83 c4 10             	add    $0x10,%esp
    command_history[num_of_stored_commands-1][length] = '\0';
801003e0:	83 e8 01             	sub    $0x1,%eax
801003e3:	89 c2                	mov    %eax,%edx
    command_id = num_of_stored_commands - 1;
801003e5:	a3 b8 12 11 80       	mov    %eax,0x801112b8
    command_history[num_of_stored_commands-1][length] = '\0';
801003ea:	c1 e2 07             	shl    $0x7,%edx
801003ed:	c6 84 11 c0 12 11 80 	movb   $0x0,-0x7feeed40(%ecx,%edx,1)
801003f4:	00 
}
801003f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801003f8:	5b                   	pop    %ebx
801003f9:	5e                   	pop    %esi
801003fa:	5f                   	pop    %edi
801003fb:	5d                   	pop    %ebp
801003fc:	c3                   	ret
801003fd:	8d 76 00             	lea    0x0(%esi),%esi
80100400:	bf c0 12 11 80       	mov    $0x801112c0,%edi
80100405:	be 40 17 11 80       	mov    $0x80111740,%esi
8010040a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        memmove(command_history[i], command_history[i+1], sizeof(char)* MAX_LEN_OF_COMMAND);
80100410:	83 ec 04             	sub    $0x4,%esp
80100413:	89 f8                	mov    %edi,%eax
80100415:	83 ef 80             	sub    $0xffffff80,%edi
80100418:	68 80 00 00 00       	push   $0x80
8010041d:	57                   	push   %edi
8010041e:	50                   	push   %eax
8010041f:	e8 fc 59 00 00       	call   80105e20 <memmove>
      for(int i = 0; i < MAX_NUM_OF_HISTORY - 1; i++)
80100424:	83 c4 10             	add    $0x10,%esp
80100427:	39 fe                	cmp    %edi,%esi
80100429:	75 e5                	jne    80100410 <add_history.part.0+0x90>
    memmove(command_history[num_of_stored_commands-1], command, sizeof(char)* length);
8010042b:	a1 b4 12 11 80       	mov    0x801112b4,%eax
80100430:	83 e8 01             	sub    $0x1,%eax
80100433:	eb 8b                	jmp    801003c0 <add_history.part.0+0x40>
80100435:	8d 76 00             	lea    0x0(%esi),%esi
    int length = strlen(command) <= MAX_LEN_OF_COMMAND ? strlen(command) : MAX_LEN_OF_COMMAND - 1;
80100438:	83 ec 0c             	sub    $0xc,%esp
8010043b:	53                   	push   %ebx
8010043c:	e8 3f 5b 00 00       	call   80105f80 <strlen>
80100441:	83 c4 10             	add    $0x10,%esp
80100444:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    memmove(command_history[num_of_stored_commands-1], command, sizeof(char)* length);
80100447:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010044a:	e9 5e ff ff ff       	jmp    801003ad <add_history.part.0+0x2d>
8010044f:	90                   	nop

80100450 <detect_math_expression.part.0>:
  if (c == '?' && input.buf[(input.position-1) % INPUT_BUF] == '=') {
80100450:	8b 15 20 12 11 80    	mov    0x80111220,%edx
  return 0;
80100456:	31 c9                	xor    %ecx,%ecx
  if (c == '?' && input.buf[(input.position-1) % INPUT_BUF] == '=') {
80100458:	8d 42 ff             	lea    -0x1(%edx),%eax
8010045b:	83 e0 7f             	and    $0x7f,%eax
8010045e:	80 b8 24 12 11 80 3d 	cmpb   $0x3d,-0x7feeeddc(%eax)
80100465:	74 09                	je     80100470 <detect_math_expression.part.0+0x20>
}
80100467:	89 c8                	mov    %ecx,%eax
80100469:	c3                   	ret
8010046a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if (isdigit(input.buf[(input.position-2) % INPUT_BUF])) {
80100470:	8d 42 fe             	lea    -0x2(%edx),%eax
80100473:	83 e0 7f             	and    $0x7f,%eax
80100476:	0f b6 80 24 12 11 80 	movzbl -0x7feeeddc(%eax),%eax
8010047d:	83 e8 30             	sub    $0x30,%eax
80100480:	3c 09                	cmp    $0x9,%al
80100482:	77 e3                	ja     80100467 <detect_math_expression.part.0+0x17>
      char operator = input.buf[(input.position-3) % INPUT_BUF];
80100484:	8d 42 fd             	lea    -0x3(%edx),%eax
int detect_math_expression(char c) {
80100487:	55                   	push   %ebp
      char operator = input.buf[(input.position-3) % INPUT_BUF];
80100488:	83 e0 7f             	and    $0x7f,%eax
8010048b:	0f b6 80 24 12 11 80 	movzbl -0x7feeeddc(%eax),%eax
int detect_math_expression(char c) {
80100492:	89 e5                	mov    %esp,%ebp
80100494:	53                   	push   %ebx
      if ((operator == '+') || (operator == '-') || (operator == '*') || (operator == '/')) {
80100495:	89 c3                	mov    %eax,%ebx
80100497:	83 e3 fd             	and    $0xfffffffd,%ebx
8010049a:	80 fb 2d             	cmp    $0x2d,%bl
8010049d:	74 07                	je     801004a6 <detect_math_expression.part.0+0x56>
8010049f:	83 e8 2a             	sub    $0x2a,%eax
801004a2:	3c 01                	cmp    $0x1,%al
801004a4:	77 17                	ja     801004bd <detect_math_expression.part.0+0x6d>
        if (isdigit(input.buf[(input.position-4) % INPUT_BUF])) {
801004a6:	83 ea 04             	sub    $0x4,%edx
801004a9:	31 c9                	xor    %ecx,%ecx
801004ab:	83 e2 7f             	and    $0x7f,%edx
801004ae:	0f b6 82 24 12 11 80 	movzbl -0x7feeeddc(%edx),%eax
801004b5:	83 e8 30             	sub    $0x30,%eax
801004b8:	3c 09                	cmp    $0x9,%al
801004ba:	0f 96 c1             	setbe  %cl
}
801004bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801004c0:	89 c8                	mov    %ecx,%eax
801004c2:	c9                   	leave
801004c3:	c3                   	ret
801004c4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801004cb:	00 
801004cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801004d0 <panic>:
{
801004d0:	55                   	push   %ebp
801004d1:	89 e5                	mov    %esp,%ebp
801004d3:	56                   	push   %esi
801004d4:	53                   	push   %ebx
801004d5:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
801004d8:	fa                   	cli
  cons.locking = 0;
801004d9:	c7 05 f4 17 11 80 00 	movl   $0x0,0x801117f4
801004e0:	00 00 00 
  getcallerpcs(&s, pcs);
801004e3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801004e6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801004e9:	e8 e2 34 00 00       	call   801039d0 <lapicid>
801004ee:	83 ec 08             	sub    $0x8,%esp
801004f1:	50                   	push   %eax
801004f2:	68 2d 90 10 80       	push   $0x8010902d
801004f7:	e8 d4 02 00 00       	call   801007d0 <cprintf>
  cprintf(s);
801004fc:	58                   	pop    %eax
801004fd:	ff 75 08             	push   0x8(%ebp)
80100500:	e8 cb 02 00 00       	call   801007d0 <cprintf>
  cprintf("\n");
80100505:	c7 04 24 0c 95 10 80 	movl   $0x8010950c,(%esp)
8010050c:	e8 bf 02 00 00       	call   801007d0 <cprintf>
  getcallerpcs(&s, pcs);
80100511:	8d 45 08             	lea    0x8(%ebp),%eax
80100514:	5a                   	pop    %edx
80100515:	59                   	pop    %ecx
80100516:	53                   	push   %ebx
80100517:	50                   	push   %eax
80100518:	e8 f3 55 00 00       	call   80105b10 <getcallerpcs>
  for(i=0; i<10; i++)
8010051d:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
80100520:	83 ec 08             	sub    $0x8,%esp
80100523:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
80100525:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
80100528:	68 41 90 10 80       	push   $0x80109041
8010052d:	e8 9e 02 00 00       	call   801007d0 <cprintf>
  for(i=0; i<10; i++)
80100532:	83 c4 10             	add    $0x10,%esp
80100535:	39 f3                	cmp    %esi,%ebx
80100537:	75 e7                	jne    80100520 <panic+0x50>
  panicked = 1; // freeze other CPU
80100539:	c7 05 f8 17 11 80 01 	movl   $0x1,0x801117f8
80100540:	00 00 00 
  for(;;)
80100543:	eb fe                	jmp    80100543 <panic+0x73>
80100545:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010054c:	00 
8010054d:	8d 76 00             	lea    0x0(%esi),%esi

80100550 <cgaputc>:
{
80100550:	55                   	push   %ebp
80100551:	89 c1                	mov    %eax,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100553:	b8 0e 00 00 00       	mov    $0xe,%eax
80100558:	89 e5                	mov    %esp,%ebp
8010055a:	57                   	push   %edi
8010055b:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100560:	56                   	push   %esi
80100561:	89 fa                	mov    %edi,%edx
80100563:	53                   	push   %ebx
80100564:	83 ec 1c             	sub    $0x1c,%esp
80100567:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100568:	be d5 03 00 00       	mov    $0x3d5,%esi
8010056d:	89 f2                	mov    %esi,%edx
8010056f:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100570:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100573:	89 fa                	mov    %edi,%edx
80100575:	c1 e0 08             	shl    $0x8,%eax
80100578:	89 c3                	mov    %eax,%ebx
8010057a:	b8 0f 00 00 00       	mov    $0xf,%eax
8010057f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100580:	89 f2                	mov    %esi,%edx
80100582:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100583:	0f b6 c0             	movzbl %al,%eax
80100586:	09 d8                	or     %ebx,%eax
  if(c == '\n')
80100588:	83 f9 0a             	cmp    $0xa,%ecx
8010058b:	0f 84 97 00 00 00    	je     80100628 <cgaputc+0xd8>
  else if(c == BACKSPACE){
80100591:	81 f9 00 01 00 00    	cmp    $0x100,%ecx
80100597:	74 77                	je     80100610 <cgaputc+0xc0>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100599:	0f b6 c9             	movzbl %cl,%ecx
8010059c:	8d 58 01             	lea    0x1(%eax),%ebx
8010059f:	80 cd 07             	or     $0x7,%ch
801005a2:	66 89 8c 00 00 80 0b 	mov    %cx,-0x7ff48000(%eax,%eax,1)
801005a9:	80 
  if(pos < 0 || pos > 25*80)
801005aa:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
801005b0:	0f 8f cc 00 00 00    	jg     80100682 <cgaputc+0x132>
  if((pos/80) >= 24){  // Scroll up.
801005b6:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
801005bc:	0f 8f 7e 00 00 00    	jg     80100640 <cgaputc+0xf0>
  outb(CRTPORT+1, pos>>8);
801005c2:	0f b6 c7             	movzbl %bh,%eax
  outb(CRTPORT+1, pos);
801005c5:	89 df                	mov    %ebx,%edi
  crt[pos] = ' ' | 0x0700;
801005c7:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi
  outb(CRTPORT+1, pos>>8);
801005ce:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801005d1:	bb d4 03 00 00       	mov    $0x3d4,%ebx
801005d6:	b8 0e 00 00 00       	mov    $0xe,%eax
801005db:	89 da                	mov    %ebx,%edx
801005dd:	ee                   	out    %al,(%dx)
801005de:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
801005e3:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
801005e7:	89 ca                	mov    %ecx,%edx
801005e9:	ee                   	out    %al,(%dx)
801005ea:	b8 0f 00 00 00       	mov    $0xf,%eax
801005ef:	89 da                	mov    %ebx,%edx
801005f1:	ee                   	out    %al,(%dx)
801005f2:	89 f8                	mov    %edi,%eax
801005f4:	89 ca                	mov    %ecx,%edx
801005f6:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801005f7:	b8 20 07 00 00       	mov    $0x720,%eax
801005fc:	66 89 06             	mov    %ax,(%esi)
}
801005ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100602:	5b                   	pop    %ebx
80100603:	5e                   	pop    %esi
80100604:	5f                   	pop    %edi
80100605:	5d                   	pop    %ebp
80100606:	c3                   	ret
80100607:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010060e:	00 
8010060f:	90                   	nop
    if(pos > 0) --pos;
80100610:	8d 58 ff             	lea    -0x1(%eax),%ebx
80100613:	85 c0                	test   %eax,%eax
80100615:	75 93                	jne    801005aa <cgaputc+0x5a>
80100617:	c6 45 e4 00          	movb   $0x0,-0x1c(%ebp)
8010061b:	be 00 80 0b 80       	mov    $0x800b8000,%esi
80100620:	31 ff                	xor    %edi,%edi
80100622:	eb ad                	jmp    801005d1 <cgaputc+0x81>
80100624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pos += 80 - pos%80;
80100628:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
8010062d:	f7 e2                	mul    %edx
8010062f:	c1 ea 06             	shr    $0x6,%edx
80100632:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100635:	c1 e0 04             	shl    $0x4,%eax
80100638:	8d 58 50             	lea    0x50(%eax),%ebx
8010063b:	e9 6a ff ff ff       	jmp    801005aa <cgaputc+0x5a>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100640:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
80100643:	8d 7b b0             	lea    -0x50(%ebx),%edi
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100646:	8d b4 1b 60 7f 0b 80 	lea    -0x7ff480a0(%ebx,%ebx,1),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010064d:	68 60 0e 00 00       	push   $0xe60
80100652:	68 a0 80 0b 80       	push   $0x800b80a0
80100657:	68 00 80 0b 80       	push   $0x800b8000
8010065c:	e8 bf 57 00 00       	call   80105e20 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100661:	b8 80 07 00 00       	mov    $0x780,%eax
80100666:	83 c4 0c             	add    $0xc,%esp
80100669:	29 f8                	sub    %edi,%eax
8010066b:	01 c0                	add    %eax,%eax
8010066d:	50                   	push   %eax
8010066e:	6a 00                	push   $0x0
80100670:	56                   	push   %esi
80100671:	e8 0a 57 00 00       	call   80105d80 <memset>
  outb(CRTPORT+1, pos);
80100676:	c6 45 e4 07          	movb   $0x7,-0x1c(%ebp)
8010067a:	83 c4 10             	add    $0x10,%esp
8010067d:	e9 4f ff ff ff       	jmp    801005d1 <cgaputc+0x81>
    panic("pos under/overflow");
80100682:	83 ec 0c             	sub    $0xc,%esp
80100685:	68 45 90 10 80       	push   $0x80109045
8010068a:	e8 41 fe ff ff       	call   801004d0 <panic>
8010068f:	90                   	nop

80100690 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100690:	55                   	push   %ebp
80100691:	89 e5                	mov    %esp,%ebp
80100693:	57                   	push   %edi
80100694:	56                   	push   %esi
80100695:	53                   	push   %ebx
80100696:	83 ec 28             	sub    $0x28,%esp
  int i;

  iunlock(ip);
80100699:	ff 75 08             	push   0x8(%ebp)
{
8010069c:	8b 75 10             	mov    0x10(%ebp),%esi
  iunlock(ip);
8010069f:	e8 9c 22 00 00       	call   80102940 <iunlock>
  acquire(&cons.lock);
801006a4:	c7 04 24 c0 17 11 80 	movl   $0x801117c0,(%esp)
801006ab:	e8 10 56 00 00       	call   80105cc0 <acquire>
  for(i = 0; i < n; i++)
801006b0:	83 c4 10             	add    $0x10,%esp
801006b3:	85 f6                	test   %esi,%esi
801006b5:	7e 3a                	jle    801006f1 <consolewrite+0x61>
801006b7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801006ba:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
  if(panicked){
801006bd:	8b 15 f8 17 11 80    	mov    0x801117f8,%edx
801006c3:	85 d2                	test   %edx,%edx
801006c5:	74 09                	je     801006d0 <consolewrite+0x40>
  asm volatile("cli");
801006c7:	fa                   	cli
    for(;;)
801006c8:	eb fe                	jmp    801006c8 <consolewrite+0x38>
801006ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
801006d0:	0f b6 03             	movzbl (%ebx),%eax
    uartputc(c);
801006d3:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < n; i++)
801006d6:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
801006d9:	50                   	push   %eax
801006da:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006dd:	e8 ce 71 00 00       	call   801078b0 <uartputc>
  cgaputc(c);
801006e2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801006e5:	e8 66 fe ff ff       	call   80100550 <cgaputc>
  for(i = 0; i < n; i++)
801006ea:	83 c4 10             	add    $0x10,%esp
801006ed:	39 df                	cmp    %ebx,%edi
801006ef:	75 cc                	jne    801006bd <consolewrite+0x2d>
  release(&cons.lock);
801006f1:	83 ec 0c             	sub    $0xc,%esp
801006f4:	68 c0 17 11 80       	push   $0x801117c0
801006f9:	e8 62 55 00 00       	call   80105c60 <release>
  ilock(ip);
801006fe:	58                   	pop    %eax
801006ff:	ff 75 08             	push   0x8(%ebp)
80100702:	e8 59 21 00 00       	call   80102860 <ilock>

  return n;
}
80100707:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010070a:	89 f0                	mov    %esi,%eax
8010070c:	5b                   	pop    %ebx
8010070d:	5e                   	pop    %esi
8010070e:	5f                   	pop    %edi
8010070f:	5d                   	pop    %ebp
80100710:	c3                   	ret
80100711:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100718:	00 
80100719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100720 <printint>:
{
80100720:	55                   	push   %ebp
80100721:	89 e5                	mov    %esp,%ebp
80100723:	57                   	push   %edi
80100724:	56                   	push   %esi
80100725:	53                   	push   %ebx
80100726:	83 ec 2c             	sub    $0x2c,%esp
80100729:	89 55 d4             	mov    %edx,-0x2c(%ebp)
8010072c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
  if(sign && (sign = xx < 0))
8010072f:	85 c9                	test   %ecx,%ecx
80100731:	74 04                	je     80100737 <printint+0x17>
80100733:	85 c0                	test   %eax,%eax
80100735:	78 7e                	js     801007b5 <printint+0x95>
    x = xx;
80100737:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
8010073e:	89 c1                	mov    %eax,%ecx
  i = 0;
80100740:	31 db                	xor    %ebx,%ebx
80100742:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    buf[i++] = digits[x % base];
80100748:	89 c8                	mov    %ecx,%eax
8010074a:	31 d2                	xor    %edx,%edx
8010074c:	89 de                	mov    %ebx,%esi
8010074e:	89 cf                	mov    %ecx,%edi
80100750:	f7 75 d4             	divl   -0x2c(%ebp)
80100753:	8d 5b 01             	lea    0x1(%ebx),%ebx
80100756:	0f b6 92 bc 95 10 80 	movzbl -0x7fef6a44(%edx),%edx
  }while((x /= base) != 0);
8010075d:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
8010075f:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
80100763:	3b 7d d4             	cmp    -0x2c(%ebp),%edi
80100766:	73 e0                	jae    80100748 <printint+0x28>
  if(sign)
80100768:	8b 4d d0             	mov    -0x30(%ebp),%ecx
8010076b:	85 c9                	test   %ecx,%ecx
8010076d:	74 0c                	je     8010077b <printint+0x5b>
    buf[i++] = '-';
8010076f:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
80100774:	89 de                	mov    %ebx,%esi
    buf[i++] = '-';
80100776:	ba 2d 00 00 00       	mov    $0x2d,%edx
  while(--i >= 0)
8010077b:	8d 5c 35 d7          	lea    -0x29(%ebp,%esi,1),%ebx
  if(panicked){
8010077f:	a1 f8 17 11 80       	mov    0x801117f8,%eax
80100784:	85 c0                	test   %eax,%eax
80100786:	74 08                	je     80100790 <printint+0x70>
80100788:	fa                   	cli
    for(;;)
80100789:	eb fe                	jmp    80100789 <printint+0x69>
8010078b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    consputc(buf[i]);
80100790:	0f be f2             	movsbl %dl,%esi
    uartputc(c);
80100793:	83 ec 0c             	sub    $0xc,%esp
80100796:	56                   	push   %esi
80100797:	e8 14 71 00 00       	call   801078b0 <uartputc>
  cgaputc(c);
8010079c:	89 f0                	mov    %esi,%eax
8010079e:	e8 ad fd ff ff       	call   80100550 <cgaputc>
  while(--i >= 0)
801007a3:	8d 45 d7             	lea    -0x29(%ebp),%eax
801007a6:	83 c4 10             	add    $0x10,%esp
801007a9:	39 c3                	cmp    %eax,%ebx
801007ab:	74 0e                	je     801007bb <printint+0x9b>
    consputc(buf[i]);
801007ad:	0f b6 13             	movzbl (%ebx),%edx
801007b0:	83 eb 01             	sub    $0x1,%ebx
801007b3:	eb ca                	jmp    8010077f <printint+0x5f>
    x = -xx;
801007b5:	f7 d8                	neg    %eax
801007b7:	89 c1                	mov    %eax,%ecx
801007b9:	eb 85                	jmp    80100740 <printint+0x20>
}
801007bb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801007be:	5b                   	pop    %ebx
801007bf:	5e                   	pop    %esi
801007c0:	5f                   	pop    %edi
801007c1:	5d                   	pop    %ebp
801007c2:	c3                   	ret
801007c3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801007ca:	00 
801007cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801007d0 <cprintf>:
{
801007d0:	55                   	push   %ebp
801007d1:	89 e5                	mov    %esp,%ebp
801007d3:	57                   	push   %edi
801007d4:	56                   	push   %esi
801007d5:	53                   	push   %ebx
801007d6:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
801007d9:	a1 f4 17 11 80       	mov    0x801117f4,%eax
801007de:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(locking)
801007e1:	85 c0                	test   %eax,%eax
801007e3:	0f 85 37 01 00 00    	jne    80100920 <cprintf+0x150>
  if (fmt == 0)
801007e9:	8b 75 08             	mov    0x8(%ebp),%esi
801007ec:	85 f6                	test   %esi,%esi
801007ee:	0f 84 3f 02 00 00    	je     80100a33 <cprintf+0x263>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007f4:	0f b6 06             	movzbl (%esi),%eax
  argp = (uint*)(void*)(&fmt + 1);
801007f7:	8d 7d 0c             	lea    0xc(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007fa:	31 db                	xor    %ebx,%ebx
801007fc:	85 c0                	test   %eax,%eax
801007fe:	74 56                	je     80100856 <cprintf+0x86>
    if(c != '%'){
80100800:	83 f8 25             	cmp    $0x25,%eax
80100803:	0f 85 d7 00 00 00    	jne    801008e0 <cprintf+0x110>
    c = fmt[++i] & 0xff;
80100809:	83 c3 01             	add    $0x1,%ebx
8010080c:	0f b6 14 1e          	movzbl (%esi,%ebx,1),%edx
    if(c == 0)
80100810:	85 d2                	test   %edx,%edx
80100812:	74 42                	je     80100856 <cprintf+0x86>
    switch(c){
80100814:	83 fa 70             	cmp    $0x70,%edx
80100817:	0f 84 94 00 00 00    	je     801008b1 <cprintf+0xe1>
8010081d:	7f 51                	jg     80100870 <cprintf+0xa0>
8010081f:	83 fa 25             	cmp    $0x25,%edx
80100822:	0f 84 48 01 00 00    	je     80100970 <cprintf+0x1a0>
80100828:	83 fa 64             	cmp    $0x64,%edx
8010082b:	0f 85 04 01 00 00    	jne    80100935 <cprintf+0x165>
      printint(*argp++, 10, 1);
80100831:	8d 47 04             	lea    0x4(%edi),%eax
80100834:	b9 01 00 00 00       	mov    $0x1,%ecx
80100839:	ba 0a 00 00 00       	mov    $0xa,%edx
8010083e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100841:	8b 07                	mov    (%edi),%eax
80100843:	e8 d8 fe ff ff       	call   80100720 <printint>
80100848:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010084b:	83 c3 01             	add    $0x1,%ebx
8010084e:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100852:	85 c0                	test   %eax,%eax
80100854:	75 aa                	jne    80100800 <cprintf+0x30>
  if(locking)
80100856:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100859:	85 c0                	test   %eax,%eax
8010085b:	0f 85 b5 01 00 00    	jne    80100a16 <cprintf+0x246>
}
80100861:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100864:	5b                   	pop    %ebx
80100865:	5e                   	pop    %esi
80100866:	5f                   	pop    %edi
80100867:	5d                   	pop    %ebp
80100868:	c3                   	ret
80100869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100870:	83 fa 73             	cmp    $0x73,%edx
80100873:	75 33                	jne    801008a8 <cprintf+0xd8>
      if((s = (char*)*argp++) == 0)
80100875:	8d 47 04             	lea    0x4(%edi),%eax
80100878:	8b 3f                	mov    (%edi),%edi
8010087a:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010087d:	85 ff                	test   %edi,%edi
8010087f:	0f 85 33 01 00 00    	jne    801009b8 <cprintf+0x1e8>
        s = "(null)";
80100885:	bf 58 90 10 80       	mov    $0x80109058,%edi
      for(; *s; s++)
8010088a:	89 5d dc             	mov    %ebx,-0x24(%ebp)
8010088d:	b8 28 00 00 00       	mov    $0x28,%eax
80100892:	89 fb                	mov    %edi,%ebx
  if(panicked){
80100894:	8b 15 f8 17 11 80    	mov    0x801117f8,%edx
8010089a:	85 d2                	test   %edx,%edx
8010089c:	0f 84 27 01 00 00    	je     801009c9 <cprintf+0x1f9>
801008a2:	fa                   	cli
    for(;;)
801008a3:	eb fe                	jmp    801008a3 <cprintf+0xd3>
801008a5:	8d 76 00             	lea    0x0(%esi),%esi
    switch(c){
801008a8:	83 fa 78             	cmp    $0x78,%edx
801008ab:	0f 85 84 00 00 00    	jne    80100935 <cprintf+0x165>
      printint(*argp++, 16, 0);
801008b1:	8d 47 04             	lea    0x4(%edi),%eax
801008b4:	31 c9                	xor    %ecx,%ecx
801008b6:	ba 10 00 00 00       	mov    $0x10,%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801008bb:	83 c3 01             	add    $0x1,%ebx
      printint(*argp++, 16, 0);
801008be:	89 45 e0             	mov    %eax,-0x20(%ebp)
801008c1:	8b 07                	mov    (%edi),%eax
801008c3:	e8 58 fe ff ff       	call   80100720 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801008c8:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
      printint(*argp++, 16, 0);
801008cc:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801008cf:	85 c0                	test   %eax,%eax
801008d1:	0f 85 29 ff ff ff    	jne    80100800 <cprintf+0x30>
801008d7:	e9 7a ff ff ff       	jmp    80100856 <cprintf+0x86>
801008dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(panicked){
801008e0:	8b 0d f8 17 11 80    	mov    0x801117f8,%ecx
801008e6:	85 c9                	test   %ecx,%ecx
801008e8:	74 06                	je     801008f0 <cprintf+0x120>
801008ea:	fa                   	cli
    for(;;)
801008eb:	eb fe                	jmp    801008eb <cprintf+0x11b>
801008ed:	8d 76 00             	lea    0x0(%esi),%esi
    uartputc(c);
801008f0:	83 ec 0c             	sub    $0xc,%esp
801008f3:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801008f6:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
801008f9:	50                   	push   %eax
801008fa:	e8 b1 6f 00 00       	call   801078b0 <uartputc>
  cgaputc(c);
801008ff:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100902:	e8 49 fc ff ff       	call   80100550 <cgaputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100907:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
      continue;
8010090b:	83 c4 10             	add    $0x10,%esp
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010090e:	85 c0                	test   %eax,%eax
80100910:	0f 85 ea fe ff ff    	jne    80100800 <cprintf+0x30>
80100916:	e9 3b ff ff ff       	jmp    80100856 <cprintf+0x86>
8010091b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
80100920:	83 ec 0c             	sub    $0xc,%esp
80100923:	68 c0 17 11 80       	push   $0x801117c0
80100928:	e8 93 53 00 00       	call   80105cc0 <acquire>
8010092d:	83 c4 10             	add    $0x10,%esp
80100930:	e9 b4 fe ff ff       	jmp    801007e9 <cprintf+0x19>
  if(panicked){
80100935:	8b 0d f8 17 11 80    	mov    0x801117f8,%ecx
8010093b:	85 c9                	test   %ecx,%ecx
8010093d:	75 71                	jne    801009b0 <cprintf+0x1e0>
    uartputc(c);
8010093f:	83 ec 0c             	sub    $0xc,%esp
80100942:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100945:	6a 25                	push   $0x25
80100947:	e8 64 6f 00 00       	call   801078b0 <uartputc>
  cgaputc(c);
8010094c:	b8 25 00 00 00       	mov    $0x25,%eax
80100951:	e8 fa fb ff ff       	call   80100550 <cgaputc>
  if(panicked){
80100956:	8b 15 f8 17 11 80    	mov    0x801117f8,%edx
8010095c:	83 c4 10             	add    $0x10,%esp
8010095f:	85 d2                	test   %edx,%edx
80100961:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100964:	0f 84 8e 00 00 00    	je     801009f8 <cprintf+0x228>
8010096a:	fa                   	cli
    for(;;)
8010096b:	eb fe                	jmp    8010096b <cprintf+0x19b>
8010096d:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
80100970:	a1 f8 17 11 80       	mov    0x801117f8,%eax
80100975:	85 c0                	test   %eax,%eax
80100977:	74 07                	je     80100980 <cprintf+0x1b0>
80100979:	fa                   	cli
    for(;;)
8010097a:	eb fe                	jmp    8010097a <cprintf+0x1aa>
8010097c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartputc(c);
80100980:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100983:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100986:	6a 25                	push   $0x25
80100988:	e8 23 6f 00 00       	call   801078b0 <uartputc>
  cgaputc(c);
8010098d:	b8 25 00 00 00       	mov    $0x25,%eax
80100992:	e8 b9 fb ff ff       	call   80100550 <cgaputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100997:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
}
8010099b:	83 c4 10             	add    $0x10,%esp
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010099e:	85 c0                	test   %eax,%eax
801009a0:	0f 85 5a fe ff ff    	jne    80100800 <cprintf+0x30>
801009a6:	e9 ab fe ff ff       	jmp    80100856 <cprintf+0x86>
801009ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801009b0:	fa                   	cli
    for(;;)
801009b1:	eb fe                	jmp    801009b1 <cprintf+0x1e1>
801009b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      for(; *s; s++)
801009b8:	0f b6 07             	movzbl (%edi),%eax
801009bb:	84 c0                	test   %al,%al
801009bd:	74 6c                	je     80100a2b <cprintf+0x25b>
801009bf:	89 5d dc             	mov    %ebx,-0x24(%ebp)
801009c2:	89 fb                	mov    %edi,%ebx
801009c4:	e9 cb fe ff ff       	jmp    80100894 <cprintf+0xc4>
    uartputc(c);
801009c9:	83 ec 0c             	sub    $0xc,%esp
        consputc(*s);
801009cc:	0f be f8             	movsbl %al,%edi
      for(; *s; s++)
801009cf:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
801009d2:	57                   	push   %edi
801009d3:	e8 d8 6e 00 00       	call   801078b0 <uartputc>
  cgaputc(c);
801009d8:	89 f8                	mov    %edi,%eax
801009da:	e8 71 fb ff ff       	call   80100550 <cgaputc>
      for(; *s; s++)
801009df:	0f b6 03             	movzbl (%ebx),%eax
801009e2:	83 c4 10             	add    $0x10,%esp
801009e5:	84 c0                	test   %al,%al
801009e7:	0f 85 a7 fe ff ff    	jne    80100894 <cprintf+0xc4>
      if((s = (char*)*argp++) == 0)
801009ed:	8b 5d dc             	mov    -0x24(%ebp),%ebx
801009f0:	8b 7d e0             	mov    -0x20(%ebp),%edi
801009f3:	e9 53 fe ff ff       	jmp    8010084b <cprintf+0x7b>
    uartputc(c);
801009f8:	83 ec 0c             	sub    $0xc,%esp
801009fb:	89 55 e0             	mov    %edx,-0x20(%ebp)
801009fe:	52                   	push   %edx
801009ff:	e8 ac 6e 00 00       	call   801078b0 <uartputc>
  cgaputc(c);
80100a04:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100a07:	89 d0                	mov    %edx,%eax
80100a09:	e8 42 fb ff ff       	call   80100550 <cgaputc>
}
80100a0e:	83 c4 10             	add    $0x10,%esp
80100a11:	e9 35 fe ff ff       	jmp    8010084b <cprintf+0x7b>
    release(&cons.lock);
80100a16:	83 ec 0c             	sub    $0xc,%esp
80100a19:	68 c0 17 11 80       	push   $0x801117c0
80100a1e:	e8 3d 52 00 00       	call   80105c60 <release>
80100a23:	83 c4 10             	add    $0x10,%esp
}
80100a26:	e9 36 fe ff ff       	jmp    80100861 <cprintf+0x91>
      if((s = (char*)*argp++) == 0)
80100a2b:	8b 7d e0             	mov    -0x20(%ebp),%edi
80100a2e:	e9 18 fe ff ff       	jmp    8010084b <cprintf+0x7b>
    panic("null fmt");
80100a33:	83 ec 0c             	sub    $0xc,%esp
80100a36:	68 5f 90 10 80       	push   $0x8010905f
80100a3b:	e8 90 fa ff ff       	call   801004d0 <panic>

80100a40 <move_cursor_left>:
{
80100a40:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100a41:	b8 0e 00 00 00       	mov    $0xe,%eax
80100a46:	89 e5                	mov    %esp,%ebp
80100a48:	57                   	push   %edi
80100a49:	56                   	push   %esi
80100a4a:	be d4 03 00 00       	mov    $0x3d4,%esi
80100a4f:	53                   	push   %ebx
80100a50:	89 f2                	mov    %esi,%edx
80100a52:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100a53:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100a58:	89 da                	mov    %ebx,%edx
80100a5a:	ec                   	in     (%dx),%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100a5b:	bf 0f 00 00 00       	mov    $0xf,%edi
  cursor_position = inb(CRTPORT+1) << 8;
80100a60:	0f b6 c8             	movzbl %al,%ecx
80100a63:	89 f2                	mov    %esi,%edx
80100a65:	c1 e1 08             	shl    $0x8,%ecx
80100a68:	89 f8                	mov    %edi,%eax
80100a6a:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100a6b:	89 da                	mov    %ebx,%edx
80100a6d:	ec                   	in     (%dx),%al
  cursor_position = cursor_position | inb(CRTPORT+1);/*Finding current position of cursor*/
80100a6e:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100a71:	89 f2                	mov    %esi,%edx
80100a73:	09 c1                	or     %eax,%ecx
80100a75:	89 f8                	mov    %edi,%eax
  cursor_position = cursor_position - 1; /*Moving cursor one step back*/
80100a77:	83 e9 01             	sub    $0x1,%ecx
80100a7a:	ee                   	out    %al,(%dx)
80100a7b:	89 c8                	mov    %ecx,%eax
80100a7d:	89 da                	mov    %ebx,%edx
80100a7f:	ee                   	out    %al,(%dx)
80100a80:	b8 0e 00 00 00       	mov    $0xe,%eax
80100a85:	89 f2                	mov    %esi,%edx
80100a87:	ee                   	out    %al,(%dx)
  outb(CRTPORT+1, (unsigned char)((cursor_position>>8) & 0xFF)); /*Reset cursor*/
80100a88:	89 c8                	mov    %ecx,%eax
80100a8a:	89 da                	mov    %ebx,%edx
80100a8c:	c1 f8 08             	sar    $0x8,%eax
80100a8f:	ee                   	out    %al,(%dx)
}
80100a90:	5b                   	pop    %ebx
80100a91:	5e                   	pop    %esi
80100a92:	5f                   	pop    %edi
80100a93:	5d                   	pop    %ebp
80100a94:	c3                   	ret
80100a95:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100a9c:	00 
80100a9d:	8d 76 00             	lea    0x0(%esi),%esi

80100aa0 <move_cursor_right>:
{
80100aa0:	55                   	push   %ebp
80100aa1:	b8 0e 00 00 00       	mov    $0xe,%eax
80100aa6:	89 e5                	mov    %esp,%ebp
80100aa8:	57                   	push   %edi
80100aa9:	56                   	push   %esi
80100aaa:	be d4 03 00 00       	mov    $0x3d4,%esi
80100aaf:	53                   	push   %ebx
80100ab0:	89 f2                	mov    %esi,%edx
80100ab2:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100ab3:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100ab8:	89 da                	mov    %ebx,%edx
80100aba:	ec                   	in     (%dx),%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100abb:	bf 0f 00 00 00       	mov    $0xf,%edi
  cursor_position = inb(CRTPORT+1) << 8;
80100ac0:	0f b6 c8             	movzbl %al,%ecx
80100ac3:	89 f2                	mov    %esi,%edx
80100ac5:	c1 e1 08             	shl    $0x8,%ecx
80100ac8:	89 f8                	mov    %edi,%eax
80100aca:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100acb:	89 da                	mov    %ebx,%edx
80100acd:	ec                   	in     (%dx),%al
  cursor_position = cursor_position | inb(CRTPORT+1);/*Finding current position of cursor*/
80100ace:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100ad1:	89 f2                	mov    %esi,%edx
80100ad3:	09 c1                	or     %eax,%ecx
80100ad5:	89 f8                	mov    %edi,%eax
  cursor_position = cursor_position + 1; /*Moving cursor one step forward*/
80100ad7:	83 c1 01             	add    $0x1,%ecx
80100ada:	ee                   	out    %al,(%dx)
80100adb:	89 c8                	mov    %ecx,%eax
80100add:	89 da                	mov    %ebx,%edx
80100adf:	ee                   	out    %al,(%dx)
80100ae0:	b8 0e 00 00 00       	mov    $0xe,%eax
80100ae5:	89 f2                	mov    %esi,%edx
80100ae7:	ee                   	out    %al,(%dx)
  outb(CRTPORT+1, (unsigned char)((cursor_position>>8) & 0xFF)); /*Reset cursor*/
80100ae8:	89 c8                	mov    %ecx,%eax
80100aea:	89 da                	mov    %ebx,%edx
80100aec:	c1 f8 08             	sar    $0x8,%eax
80100aef:	ee                   	out    %al,(%dx)
}
80100af0:	5b                   	pop    %ebx
80100af1:	5e                   	pop    %esi
80100af2:	5f                   	pop    %edi
80100af3:	5d                   	pop    %ebp
80100af4:	c3                   	ret
80100af5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100afc:	00 
80100afd:	8d 76 00             	lea    0x0(%esi),%esi

80100b00 <remove_chars>:
{
80100b00:	55                   	push   %ebp
80100b01:	b8 0e 00 00 00       	mov    $0xe,%eax
80100b06:	89 e5                	mov    %esp,%ebp
80100b08:	57                   	push   %edi
80100b09:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100b0e:	56                   	push   %esi
80100b0f:	89 fa                	mov    %edi,%edx
80100b11:	53                   	push   %ebx
80100b12:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100b15:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100b16:	be d5 03 00 00       	mov    $0x3d5,%esi
80100b1b:	89 f2                	mov    %esi,%edx
80100b1d:	ec                   	in     (%dx),%al
  cursor_position = inb(CRTPORT+1) << 8;
80100b1e:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100b21:	89 fa                	mov    %edi,%edx
80100b23:	c1 e0 08             	shl    $0x8,%eax
80100b26:	89 c1                	mov    %eax,%ecx
80100b28:	b8 0f 00 00 00       	mov    $0xf,%eax
80100b2d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100b2e:	89 f2                	mov    %esi,%edx
80100b30:	ec                   	in     (%dx),%al
  cursor_position = cursor_position | inb(CRTPORT+1);/*Finding current position of cursor*/
80100b31:	0f b6 c0             	movzbl %al,%eax
80100b34:	09 c8                	or     %ecx,%eax
  for(int i = cursor_position -1 ; i <= cursor_position + back_counter; i++)
80100b36:	8d 48 ff             	lea    -0x1(%eax),%ecx
80100b39:	8d 34 18             	lea    (%eax,%ebx,1),%esi
80100b3c:	83 fb ff             	cmp    $0xffffffff,%ebx
80100b3f:	7c 20                	jl     80100b61 <remove_chars+0x61>
80100b41:	8d 84 00 00 80 0b 80 	lea    -0x7ff48000(%eax,%eax,1),%eax
80100b48:	89 ca                	mov    %ecx,%edx
80100b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    crt[i] = crt[i+1];
80100b50:	0f b7 38             	movzwl (%eax),%edi
  for(int i = cursor_position -1 ; i <= cursor_position + back_counter; i++)
80100b53:	83 c2 01             	add    $0x1,%edx
80100b56:	83 c0 02             	add    $0x2,%eax
    crt[i] = crt[i+1];
80100b59:	66 89 78 fc          	mov    %di,-0x4(%eax)
  for(int i = cursor_position -1 ; i <= cursor_position + back_counter; i++)
80100b5d:	39 f2                	cmp    %esi,%edx
80100b5f:	7e ef                	jle    80100b50 <remove_chars+0x50>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100b61:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100b66:	b8 0f 00 00 00       	mov    $0xf,%eax
80100b6b:	89 fa                	mov    %edi,%edx
80100b6d:	ee                   	out    %al,(%dx)
80100b6e:	be d5 03 00 00       	mov    $0x3d5,%esi
80100b73:	89 c8                	mov    %ecx,%eax
80100b75:	89 f2                	mov    %esi,%edx
80100b77:	ee                   	out    %al,(%dx)
80100b78:	b8 0e 00 00 00       	mov    $0xe,%eax
80100b7d:	89 fa                	mov    %edi,%edx
80100b7f:	ee                   	out    %al,(%dx)
  outb(CRTPORT+1, (unsigned char)((cursor_position>>8) & 0xFF)); /*Reset cursor*/
80100b80:	89 c8                	mov    %ecx,%eax
80100b82:	89 f2                	mov    %esi,%edx
80100b84:	c1 f8 08             	sar    $0x8,%eax
80100b87:	ee                   	out    %al,(%dx)
  crt[cursor_position+back_counter] = ' ' | 0x0700;
80100b88:	b8 20 07 00 00       	mov    $0x720,%eax
80100b8d:	01 d9                	add    %ebx,%ecx
80100b8f:	66 89 84 09 00 80 0b 	mov    %ax,-0x7ff48000(%ecx,%ecx,1)
80100b96:	80 
}
80100b97:	5b                   	pop    %ebx
80100b98:	5e                   	pop    %esi
80100b99:	5f                   	pop    %edi
80100b9a:	5d                   	pop    %ebp
80100b9b:	c3                   	ret
80100b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100ba0 <insert_chars>:
{
80100ba0:	55                   	push   %ebp
80100ba1:	b8 0e 00 00 00       	mov    $0xe,%eax
80100ba6:	89 e5                	mov    %esp,%ebp
80100ba8:	56                   	push   %esi
80100ba9:	be d4 03 00 00       	mov    $0x3d4,%esi
80100bae:	53                   	push   %ebx
80100baf:	89 f2                	mov    %esi,%edx
80100bb1:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100bb2:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100bb7:	89 da                	mov    %ebx,%edx
80100bb9:	ec                   	in     (%dx),%al
  current_position = inb(CRTPORT+1) << 8;
80100bba:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100bbd:	89 f2                	mov    %esi,%edx
80100bbf:	c1 e0 08             	shl    $0x8,%eax
80100bc2:	89 c1                	mov    %eax,%ecx
80100bc4:	b8 0f 00 00 00       	mov    $0xf,%eax
80100bc9:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100bca:	89 da                	mov    %ebx,%edx
80100bcc:	ec                   	in     (%dx),%al
  for(int i = current_position + back_counter; i >= current_position; i--)
80100bcd:	8b 55 08             	mov    0x8(%ebp),%edx
  current_position |= inb(CRTPORT+1);
80100bd0:	0f b6 c0             	movzbl %al,%eax
80100bd3:	09 c8                	or     %ecx,%eax
  for(int i = current_position + back_counter; i >= current_position; i--)
80100bd5:	01 c2                	add    %eax,%edx
80100bd7:	39 d0                	cmp    %edx,%eax
80100bd9:	7f 23                	jg     80100bfe <insert_chars+0x5e>
80100bdb:	8d 94 12 00 80 0b 80 	lea    -0x7ff48000(%edx,%edx,1),%edx
80100be2:	8d 9c 00 fe 7f 0b 80 	lea    -0x7ff48002(%eax,%eax,1),%ebx
80100be9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    crt[i+1] = crt[i];
80100bf0:	0f b7 0a             	movzwl (%edx),%ecx
  for(int i = current_position + back_counter; i >= current_position; i--)
80100bf3:	83 ea 02             	sub    $0x2,%edx
    crt[i+1] = crt[i];
80100bf6:	66 89 4a 04          	mov    %cx,0x4(%edx)
  for(int i = current_position + back_counter; i >= current_position; i--)
80100bfa:	39 d3                	cmp    %edx,%ebx
80100bfc:	75 f2                	jne    80100bf0 <insert_chars+0x50>
  crt[current_position] = (c&0xff) | 0x0700;/*move back crt buffer*/  
80100bfe:	0f b6 55 0c          	movzbl 0xc(%ebp),%edx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100c02:	be d4 03 00 00       	mov    $0x3d4,%esi
  current_position += 1;/*Updating cursor position*/
80100c07:	8d 48 01             	lea    0x1(%eax),%ecx
  crt[current_position] = (c&0xff) | 0x0700;/*move back crt buffer*/  
80100c0a:	80 ce 07             	or     $0x7,%dh
80100c0d:	66 89 94 00 00 80 0b 	mov    %dx,-0x7ff48000(%eax,%eax,1)
80100c14:	80 
80100c15:	b8 0e 00 00 00       	mov    $0xe,%eax
80100c1a:	89 f2                	mov    %esi,%edx
80100c1c:	ee                   	out    %al,(%dx)
80100c1d:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  outb(CRTPORT+1, current_position>>8);
80100c22:	89 c8                	mov    %ecx,%eax
80100c24:	c1 f8 08             	sar    $0x8,%eax
80100c27:	89 da                	mov    %ebx,%edx
80100c29:	ee                   	out    %al,(%dx)
80100c2a:	b8 0f 00 00 00       	mov    $0xf,%eax
80100c2f:	89 f2                	mov    %esi,%edx
80100c31:	ee                   	out    %al,(%dx)
80100c32:	89 c8                	mov    %ecx,%eax
80100c34:	89 da                	mov    %ebx,%edx
80100c36:	ee                   	out    %al,(%dx)
  crt[current_position+back_counter] = ' ' | 0x0700;/*Reset cursor*/
80100c37:	8b 45 08             	mov    0x8(%ebp),%eax
80100c3a:	ba 20 07 00 00       	mov    $0x720,%edx
80100c3f:	01 c8                	add    %ecx,%eax
80100c41:	66 89 94 00 00 80 0b 	mov    %dx,-0x7ff48000(%eax,%eax,1)
80100c48:	80 
}
80100c49:	5b                   	pop    %ebx
80100c4a:	5e                   	pop    %esi
80100c4b:	5d                   	pop    %ebp
80100c4c:	c3                   	ret
80100c4d:	8d 76 00             	lea    0x0(%esi),%esi

80100c50 <add_history>:
{
80100c50:	55                   	push   %ebp
80100c51:	89 e5                	mov    %esp,%ebp
80100c53:	8b 45 08             	mov    0x8(%ebp),%eax
  if((command[0]!='\0'))
80100c56:	80 38 00             	cmpb   $0x0,(%eax)
80100c59:	75 05                	jne    80100c60 <add_history+0x10>
}
80100c5b:	5d                   	pop    %ebp
80100c5c:	c3                   	ret
80100c5d:	8d 76 00             	lea    0x0(%esi),%esi
80100c60:	5d                   	pop    %ebp
80100c61:	e9 1a f7 ff ff       	jmp    80100380 <add_history.part.0>
80100c66:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100c6d:	00 
80100c6e:	66 90                	xchg   %ax,%ax

80100c70 <detect_math_expression>:
int detect_math_expression(char c) {
80100c70:	55                   	push   %ebp
80100c71:	89 e5                	mov    %esp,%ebp
  if (c == '?' && input.buf[(input.position-1) % INPUT_BUF] == '=') {
80100c73:	80 7d 08 3f          	cmpb   $0x3f,0x8(%ebp)
80100c77:	74 07                	je     80100c80 <detect_math_expression+0x10>
}
80100c79:	31 c0                	xor    %eax,%eax
80100c7b:	5d                   	pop    %ebp
80100c7c:	c3                   	ret
80100c7d:	8d 76 00             	lea    0x0(%esi),%esi
80100c80:	5d                   	pop    %ebp
80100c81:	e9 ca f7 ff ff       	jmp    80100450 <detect_math_expression.part.0>
80100c86:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100c8d:	00 
80100c8e:	66 90                	xchg   %ax,%ax

80100c90 <calculate_result_math_expression>:
float calculate_result_math_expression(int* is_divide) {
80100c90:	55                   	push   %ebp
80100c91:	89 e5                	mov    %esp,%ebp
80100c93:	83 ec 04             	sub    $0x4,%esp
  char operator = input.buf[(input.position-3) % INPUT_BUF];
80100c96:	a1 20 12 11 80       	mov    0x80111220,%eax
80100c9b:	8d 50 fd             	lea    -0x3(%eax),%edx
  float first_operand = input.buf[(input.position-4) % INPUT_BUF] - '0';
80100c9e:	8d 48 fc             	lea    -0x4(%eax),%ecx
  float second_operand = input.buf[(input.position-2) % INPUT_BUF] - '0';
80100ca1:	83 e8 02             	sub    $0x2,%eax
  float first_operand = input.buf[(input.position-4) % INPUT_BUF] - '0';
80100ca4:	83 e1 7f             	and    $0x7f,%ecx
  float second_operand = input.buf[(input.position-2) % INPUT_BUF] - '0';
80100ca7:	83 e0 7f             	and    $0x7f,%eax
  char operator = input.buf[(input.position-3) % INPUT_BUF];
80100caa:	83 e2 7f             	and    $0x7f,%edx
  float first_operand = input.buf[(input.position-4) % INPUT_BUF] - '0';
80100cad:	0f be 89 24 12 11 80 	movsbl -0x7feeeddc(%ecx),%ecx
  float second_operand = input.buf[(input.position-2) % INPUT_BUF] - '0';
80100cb4:	0f be 80 24 12 11 80 	movsbl -0x7feeeddc(%eax),%eax
  char operator = input.buf[(input.position-3) % INPUT_BUF];
80100cbb:	0f b6 92 24 12 11 80 	movzbl -0x7feeeddc(%edx),%edx
  float first_operand = input.buf[(input.position-4) % INPUT_BUF] - '0';
80100cc2:	83 e9 30             	sub    $0x30,%ecx
  float second_operand = input.buf[(input.position-2) % INPUT_BUF] - '0';
80100cc5:	83 e8 30             	sub    $0x30,%eax
  float first_operand = input.buf[(input.position-4) % INPUT_BUF] - '0';
80100cc8:	89 4d fc             	mov    %ecx,-0x4(%ebp)
80100ccb:	db 45 fc             	fildl  -0x4(%ebp)
  float second_operand = input.buf[(input.position-2) % INPUT_BUF] - '0';
80100cce:	89 45 fc             	mov    %eax,-0x4(%ebp)
80100cd1:	db 45 fc             	fildl  -0x4(%ebp)
  switch (operator) {
80100cd4:	80 fa 2d             	cmp    $0x2d,%dl
80100cd7:	74 4f                	je     80100d28 <calculate_result_math_expression+0x98>
80100cd9:	7f 15                	jg     80100cf0 <calculate_result_math_expression+0x60>
80100cdb:	80 fa 2a             	cmp    $0x2a,%dl
80100cde:	74 40                	je     80100d20 <calculate_result_math_expression+0x90>
80100ce0:	80 fa 2b             	cmp    $0x2b,%dl
80100ce3:	75 1d                	jne    80100d02 <calculate_result_math_expression+0x72>
}
80100ce5:	c9                   	leave
      result = first_operand + second_operand;
80100ce6:	de c1                	faddp  %st,%st(1)
}
80100ce8:	c3                   	ret
80100ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  switch (operator) {
80100cf0:	80 fa 2f             	cmp    $0x2f,%dl
80100cf3:	75 1b                	jne    80100d10 <calculate_result_math_expression+0x80>
      *is_divide = 1;
80100cf5:	8b 45 08             	mov    0x8(%ebp),%eax
      result = first_operand / second_operand;
80100cf8:	de f9                	fdivrp %st,%st(1)
      *is_divide = 1;
80100cfa:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
}
80100d00:	c9                   	leave
80100d01:	c3                   	ret
80100d02:	dd d8                	fstp   %st(0)
80100d04:	dd d8                	fstp   %st(0)
80100d06:	eb 0c                	jmp    80100d14 <calculate_result_math_expression+0x84>
80100d08:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100d0f:	00 
80100d10:	dd d8                	fstp   %st(0)
80100d12:	dd d8                	fstp   %st(0)
80100d14:	c9                   	leave
  switch (operator) {
80100d15:	d9 ee                	fldz
}
80100d17:	c3                   	ret
80100d18:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100d1f:	00 
80100d20:	c9                   	leave
      result = first_operand * second_operand;    
80100d21:	de c9                	fmulp  %st,%st(1)
}
80100d23:	c3                   	ret
80100d24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100d28:	c9                   	leave
      result = first_operand - second_operand;
80100d29:	de e9                	fsubrp %st,%st(1)
}
80100d2b:	c3                   	ret
80100d2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100d30 <float_to_str>:
int float_to_str(float result, char* res_str, int precision) {
80100d30:	55                   	push   %ebp
80100d31:	89 e5                	mov    %esp,%ebp
80100d33:	57                   	push   %edi
80100d34:	56                   	push   %esi
80100d35:	53                   	push   %ebx
80100d36:	83 ec 10             	sub    $0x10,%esp
  if (result == 0) {
80100d39:	d9 ee                	fldz
int float_to_str(float result, char* res_str, int precision) {
80100d3b:	d9 45 08             	flds   0x8(%ebp)
80100d3e:	8b 75 0c             	mov    0xc(%ebp),%esi
  if (result == 0) {
80100d41:	db e9                	fucomi %st(1),%st
80100d43:	dd d9                	fstp   %st(1)
80100d45:	7a 19                	jp     80100d60 <float_to_str+0x30>
80100d47:	75 17                	jne    80100d60 <float_to_str+0x30>
80100d49:	dd d8                	fstp   %st(0)
    res_str[res_len] = '0';
80100d4b:	c6 06 30             	movb   $0x30,(%esi)
    res_len += 1;
80100d4e:	bb 01 00 00 00       	mov    $0x1,%ebx
}
80100d53:	83 c4 10             	add    $0x10,%esp
80100d56:	89 d8                	mov    %ebx,%eax
80100d58:	5b                   	pop    %ebx
80100d59:	5e                   	pop    %esi
80100d5a:	5f                   	pop    %edi
80100d5b:	5d                   	pop    %ebp
80100d5c:	c3                   	ret
80100d5d:	8d 76 00             	lea    0x0(%esi),%esi
      if (result < 0) {
80100d60:	d9 ee                	fldz
80100d62:	df f1                	fcomip %st(1),%st
80100d64:	0f 87 fe 00 00 00    	ja     80100e68 <float_to_str+0x138>
      if ((result > 0) && (result < 1)) {
80100d6a:	d9 ee                	fldz
80100d6c:	d9 c9                	fxch   %st(1)
  int is_neg = 0;
80100d6e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
      if ((result > 0) && (result < 1)) {
80100d75:	db f1                	fcomi  %st(1),%st
80100d77:	dd d9                	fstp   %st(1)
80100d79:	0f 86 00 01 00 00    	jbe    80100e7f <float_to_str+0x14f>
80100d7f:	d9 e8                	fld1
80100d81:	31 c0                	xor    %eax,%eax
80100d83:	df f1                	fcomip %st(1),%st
80100d85:	0f 97 c0             	seta   %al
80100d88:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      for (int i=0; i<precision; i++) {
80100d8b:	8b 4d 10             	mov    0x10(%ebp),%ecx
80100d8e:	85 c9                	test   %ecx,%ecx
80100d90:	7e 1b                	jle    80100dad <float_to_str+0x7d>
80100d92:	8b 55 10             	mov    0x10(%ebp),%edx
80100d95:	31 c0                	xor    %eax,%eax
80100d97:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100d9e:	00 
80100d9f:	90                   	nop
80100da0:	83 c0 01             	add    $0x1,%eax
        result *= 10;
80100da3:	d8 0d d4 95 10 80    	fmuls  0x801095d4
      for (int i=0; i<precision; i++) {
80100da9:	39 c2                	cmp    %eax,%edx
80100dab:	75 f3                	jne    80100da0 <float_to_str+0x70>
      int temp_result = result;
80100dad:	d9 7d f2             	fnstcw -0xe(%ebp)
  int res_len = 0;
80100db0:	31 db                	xor    %ebx,%ebx
      int temp_result = result;
80100db2:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
80100db6:	80 cc 0c             	or     $0xc,%ah
80100db9:	66 89 45 f0          	mov    %ax,-0x10(%ebp)
80100dbd:	d9 6d f0             	fldcw  -0x10(%ebp)
80100dc0:	db 5d e8             	fistpl -0x18(%ebp)
80100dc3:	d9 6d f2             	fldcw  -0xe(%ebp)
80100dc6:	8b 4d e8             	mov    -0x18(%ebp),%ecx
      int point = 0;
80100dc9:	eb 2a                	jmp    80100df5 <float_to_str+0xc5>
80100dcb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
          res_str[res_len] = (temp_result % 10) + '0';
80100dd0:	b8 67 66 66 66       	mov    $0x66666667,%eax
80100dd5:	f7 e9                	imul   %ecx
80100dd7:	89 c8                	mov    %ecx,%eax
80100dd9:	c1 f8 1f             	sar    $0x1f,%eax
80100ddc:	c1 fa 02             	sar    $0x2,%edx
80100ddf:	29 c2                	sub    %eax,%edx
80100de1:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100de4:	01 c0                	add    %eax,%eax
80100de6:	29 c1                	sub    %eax,%ecx
80100de8:	83 c1 30             	add    $0x30,%ecx
80100deb:	88 4c 1e ff          	mov    %cl,-0x1(%esi,%ebx,1)
          temp_result /= 10;
80100def:	89 d1                	mov    %edx,%ecx
      } while (temp_result > 0);
80100df1:	85 c9                	test   %ecx,%ecx
80100df3:	7e 13                	jle    80100e08 <float_to_str+0xd8>
        if (point == precision) {
80100df5:	89 df                	mov    %ebx,%edi
          res_len += 1;
80100df7:	83 c3 01             	add    $0x1,%ebx
        if (point == precision) {
80100dfa:	3b 7d 10             	cmp    0x10(%ebp),%edi
80100dfd:	75 d1                	jne    80100dd0 <float_to_str+0xa0>
          res_str[res_len] = '.';
80100dff:	c6 44 1e ff 2e       	movb   $0x2e,-0x1(%esi,%ebx,1)
      } while (temp_result > 0);
80100e04:	85 c9                	test   %ecx,%ecx
80100e06:	7f ed                	jg     80100df5 <float_to_str+0xc5>
  if (is_less_than_one) {
80100e08:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100e0b:	85 d2                	test   %edx,%edx
80100e0d:	74 7c                	je     80100e8b <float_to_str+0x15b>
  if (is_neg) {
80100e0f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    res_str[res_len] = '.';
80100e12:	c6 04 1e 2e          	movb   $0x2e,(%esi,%ebx,1)
    res_len += 1;
80100e16:	8d 5f 03             	lea    0x3(%edi),%ebx
    res_str[res_len] = '0';
80100e19:	c6 44 3e 02 30       	movb   $0x30,0x2(%esi,%edi,1)
  if (is_neg) {
80100e1e:	85 c0                	test   %eax,%eax
80100e20:	74 7f                	je     80100ea1 <float_to_str+0x171>
    res_str[res_len] = '-';
80100e22:	c6 04 1e 2d          	movb   $0x2d,(%esi,%ebx,1)
    res_len += 1;
80100e26:	83 c3 01             	add    $0x1,%ebx
  for (int i = 0; i < res_len / 2; ++i) {
80100e29:	89 df                	mov    %ebx,%edi
80100e2b:	d1 ff                	sar    $1,%edi
  int res_len = 0;
80100e2d:	89 5d ec             	mov    %ebx,-0x14(%ebp)
80100e30:	8d 54 1e ff          	lea    -0x1(%esi,%ebx,1),%edx
80100e34:	31 c0                	xor    %eax,%eax
80100e36:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100e3d:	00 
80100e3e:	66 90                	xchg   %ax,%ax
    res_str[i] = res_str[res_len - i - 1];
80100e40:	0f b6 1a             	movzbl (%edx),%ebx
    char temp = res_str[i];
80100e43:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
  for (int i = 0; i < res_len / 2; ++i) {
80100e47:	83 ea 01             	sub    $0x1,%edx
    res_str[i] = res_str[res_len - i - 1];
80100e4a:	88 1c 06             	mov    %bl,(%esi,%eax,1)
  for (int i = 0; i < res_len / 2; ++i) {
80100e4d:	83 c0 01             	add    $0x1,%eax
    res_str[res_len - i - 1] = temp;
80100e50:	88 4a 01             	mov    %cl,0x1(%edx)
  for (int i = 0; i < res_len / 2; ++i) {
80100e53:	39 f8                	cmp    %edi,%eax
80100e55:	7c e9                	jl     80100e40 <float_to_str+0x110>
80100e57:	8b 5d ec             	mov    -0x14(%ebp),%ebx
}
80100e5a:	83 c4 10             	add    $0x10,%esp
80100e5d:	89 d8                	mov    %ebx,%eax
80100e5f:	5b                   	pop    %ebx
80100e60:	5e                   	pop    %esi
80100e61:	5f                   	pop    %edi
80100e62:	5d                   	pop    %ebp
80100e63:	c3                   	ret
80100e64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        result = -result;
80100e68:	d9 e0                	fchs
        is_neg = 1;
80100e6a:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
      if ((result > 0) && (result < 1)) {
80100e71:	d9 ee                	fldz
80100e73:	d9 c9                	fxch   %st(1)
80100e75:	db f1                	fcomi  %st(1),%st
80100e77:	dd d9                	fstp   %st(1)
80100e79:	0f 87 00 ff ff ff    	ja     80100d7f <float_to_str+0x4f>
  int is_less_than_one = 0;
80100e7f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80100e86:	e9 00 ff ff ff       	jmp    80100d8b <float_to_str+0x5b>
  if (is_neg) {
80100e8b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80100e8f:	75 91                	jne    80100e22 <float_to_str+0xf2>
  for (int i = 0; i < res_len / 2; ++i) {
80100e91:	89 df                	mov    %ebx,%edi
80100e93:	d1 ff                	sar    $1,%edi
80100e95:	75 96                	jne    80100e2d <float_to_str+0xfd>
80100e97:	bb 01 00 00 00       	mov    $0x1,%ebx
  return res_len;
80100e9c:	e9 b2 fe ff ff       	jmp    80100d53 <float_to_str+0x23>
  for (int i = 0; i < res_len / 2; ++i) {
80100ea1:	89 df                	mov    %ebx,%edi
80100ea3:	d1 ff                	sar    $1,%edi
80100ea5:	eb 86                	jmp    80100e2d <float_to_str+0xfd>
80100ea7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100eae:	00 
80100eaf:	90                   	nop

80100eb0 <int_to_str>:
int int_to_str(int result, char* res_str) {
80100eb0:	55                   	push   %ebp
80100eb1:	89 e5                	mov    %esp,%ebp
80100eb3:	57                   	push   %edi
80100eb4:	56                   	push   %esi
80100eb5:	53                   	push   %ebx
80100eb6:	83 ec 04             	sub    $0x4,%esp
80100eb9:	8b 75 08             	mov    0x8(%ebp),%esi
80100ebc:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  if (result == 0) {
80100ebf:	85 f6                	test   %esi,%esi
80100ec1:	75 15                	jne    80100ed8 <int_to_str+0x28>
    res_str[res_len] = '0';
80100ec3:	c6 01 30             	movb   $0x30,(%ecx)
    res_len += 1;
80100ec6:	bb 01 00 00 00       	mov    $0x1,%ebx
}
80100ecb:	83 c4 04             	add    $0x4,%esp
80100ece:	89 d8                	mov    %ebx,%eax
80100ed0:	5b                   	pop    %ebx
80100ed1:	5e                   	pop    %esi
80100ed2:	5f                   	pop    %edi
80100ed3:	5d                   	pop    %ebp
80100ed4:	c3                   	ret
80100ed5:	8d 76 00             	lea    0x0(%esi),%esi
  int is_neg = 0;
80100ed8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
      if (result < 0) {
80100edf:	0f 88 8b 00 00 00    	js     80100f70 <int_to_str+0xc0>
  int res_len = 0;
80100ee5:	31 db                	xor    %ebx,%ebx
80100ee7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100eee:	00 
80100eef:	90                   	nop
        res_str[res_len] = (temp_result % 10) + '0';
80100ef0:	b8 cd cc cc cc       	mov    $0xcccccccd,%eax
80100ef5:	f7 e6                	mul    %esi
80100ef7:	89 f0                	mov    %esi,%eax
80100ef9:	c1 ea 03             	shr    $0x3,%edx
80100efc:	8d 3c 92             	lea    (%edx,%edx,4),%edi
80100eff:	01 ff                	add    %edi,%edi
80100f01:	29 f8                	sub    %edi,%eax
80100f03:	89 df                	mov    %ebx,%edi
80100f05:	83 c0 30             	add    $0x30,%eax
80100f08:	88 04 19             	mov    %al,(%ecx,%ebx,1)
        res_len += 1;
80100f0b:	89 f0                	mov    %esi,%eax
80100f0d:	83 c3 01             	add    $0x1,%ebx
        temp_result /= 10;
80100f10:	89 d6                	mov    %edx,%esi
      while (temp_result > 0);
80100f12:	83 f8 09             	cmp    $0x9,%eax
80100f15:	7f d9                	jg     80100ef0 <int_to_str+0x40>
  if (is_neg) {
80100f17:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100f1a:	85 c0                	test   %eax,%eax
80100f1c:	75 42                	jne    80100f60 <int_to_str+0xb0>
  for (int i = 0; i < res_len / 2; ++i) {
80100f1e:	89 df                	mov    %ebx,%edi
80100f20:	d1 ff                	sar    $1,%edi
80100f22:	74 5a                	je     80100f7e <int_to_str+0xce>
80100f24:	8d 54 19 ff          	lea    -0x1(%ecx,%ebx,1),%edx
  int res_len = 0;
80100f28:	31 c0                	xor    %eax,%eax
80100f2a:	89 de                	mov    %ebx,%esi
80100f2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    char temp = res_str[i];
80100f30:	0f b6 1c 01          	movzbl (%ecx,%eax,1),%ebx
  for (int i = 0; i < res_len / 2; ++i) {
80100f34:	83 ea 01             	sub    $0x1,%edx
    char temp = res_str[i];
80100f37:	88 5d f0             	mov    %bl,-0x10(%ebp)
    res_str[i] = res_str[res_len - i - 1];
80100f3a:	0f b6 5a 01          	movzbl 0x1(%edx),%ebx
80100f3e:	88 1c 01             	mov    %bl,(%ecx,%eax,1)
    res_str[res_len - i - 1] = temp;
80100f41:	0f b6 5d f0          	movzbl -0x10(%ebp),%ebx
  for (int i = 0; i < res_len / 2; ++i) {
80100f45:	83 c0 01             	add    $0x1,%eax
    res_str[res_len - i - 1] = temp;
80100f48:	88 5a 01             	mov    %bl,0x1(%edx)
  for (int i = 0; i < res_len / 2; ++i) {
80100f4b:	39 f8                	cmp    %edi,%eax
80100f4d:	7c e1                	jl     80100f30 <int_to_str+0x80>
}
80100f4f:	83 c4 04             	add    $0x4,%esp
80100f52:	89 f3                	mov    %esi,%ebx
80100f54:	89 d8                	mov    %ebx,%eax
80100f56:	5b                   	pop    %ebx
80100f57:	5e                   	pop    %esi
80100f58:	5f                   	pop    %edi
80100f59:	5d                   	pop    %ebp
80100f5a:	c3                   	ret
80100f5b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    res_str[res_len] = '-';
80100f60:	c6 04 19 2d          	movb   $0x2d,(%ecx,%ebx,1)
    res_len += 1;
80100f64:	8d 5f 02             	lea    0x2(%edi),%ebx
  for (int i = 0; i < res_len / 2; ++i) {
80100f67:	89 df                	mov    %ebx,%edi
80100f69:	d1 ff                	sar    $1,%edi
80100f6b:	eb b7                	jmp    80100f24 <int_to_str+0x74>
80100f6d:	8d 76 00             	lea    0x0(%esi),%esi
        is_neg = 1;
80100f70:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
        result = -result;
80100f77:	f7 de                	neg    %esi
80100f79:	e9 67 ff ff ff       	jmp    80100ee5 <int_to_str+0x35>
  for (int i = 0; i < res_len / 2; ++i) {
80100f7e:	bb 01 00 00 00       	mov    $0x1,%ebx
  return res_len;
80100f83:	e9 43 ff ff ff       	jmp    80100ecb <int_to_str+0x1b>
80100f88:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100f8f:	00 

80100f90 <store_command>:
  if (num_copied_commands < INPUT_BUF) {  
80100f90:	a1 fc 17 11 80       	mov    0x801117fc,%eax
80100f95:	83 f8 7f             	cmp    $0x7f,%eax
80100f98:	7f 1e                	jg     80100fb8 <store_command+0x28>
void store_command(int c) {
80100f9a:	55                   	push   %ebp
80100f9b:	89 e5                	mov    %esp,%ebp
    copybuf[num_copied_commands] = c; // save the current command
80100f9d:	8b 55 08             	mov    0x8(%ebp),%edx
}
80100fa0:	5d                   	pop    %ebp
    copybuf[num_copied_commands] = c; // save the current command
80100fa1:	89 14 85 20 18 11 80 	mov    %edx,-0x7feee7e0(,%eax,4)
    num_copied_commands++; // increase the number of copied commands by 1
80100fa8:	83 c0 01             	add    $0x1,%eax
80100fab:	a3 fc 17 11 80       	mov    %eax,0x801117fc
}
80100fb0:	c3                   	ret
80100fb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100fb8:	c3                   	ret
80100fb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100fc0 <consoleintr>:
{
80100fc0:	55                   	push   %ebp
80100fc1:	89 e5                	mov    %esp,%ebp
80100fc3:	57                   	push   %edi
80100fc4:	56                   	push   %esi
80100fc5:	53                   	push   %ebx
80100fc6:	81 ec c8 00 00 00    	sub    $0xc8,%esp
80100fcc:	8b 7d 08             	mov    0x8(%ebp),%edi
  acquire(&cons.lock);
80100fcf:	68 c0 17 11 80       	push   $0x801117c0
80100fd4:	e8 e7 4c 00 00       	call   80105cc0 <acquire>
  while(((temp_c = getc()) >= 0) || (insert_copied_commands)){
80100fd9:	83 c4 10             	add    $0x10,%esp
  int temp_c, doprocdump = 0;
80100fdc:	c7 85 50 ff ff ff 00 	movl   $0x0,-0xb0(%ebp)
80100fe3:	00 00 00 
80100fe6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100fed:	00 
80100fee:	66 90                	xchg   %ax,%ax
  while(((temp_c = getc()) >= 0) || (insert_copied_commands)){
80100ff0:	ff d7                	call   *%edi
80100ff2:	89 c3                	mov    %eax,%ebx
80100ff4:	85 c0                	test   %eax,%eax
80100ff6:	0f 88 cc 00 00 00    	js     801010c8 <consoleintr+0x108>
    if (insert_copied_commands) {
80100ffc:	8b 0d 04 18 11 80    	mov    0x80111804,%ecx
80101002:	85 c9                	test   %ecx,%ecx
80101004:	0f 85 cc 00 00 00    	jne    801010d6 <consoleintr+0x116>
      c = copybuf[current_copied_command_to_run_idx];
8010100a:	a1 00 18 11 80       	mov    0x80111800,%eax
    if (current_copied_command_to_run_idx == (num_copied_commands - 1)) {
8010100f:	8b 15 fc 17 11 80    	mov    0x801117fc,%edx
80101015:	8d 4a ff             	lea    -0x1(%edx),%ecx
80101018:	39 c1                	cmp    %eax,%ecx
8010101a:	75 0a                	jne    80101026 <consoleintr+0x66>
        insert_copied_commands = 0; // turn off this signal
8010101c:	c7 05 04 18 11 80 00 	movl   $0x0,0x80111804
80101023:	00 00 00 
    switch(c){
80101026:	83 fb 7f             	cmp    $0x7f,%ebx
80101029:	0f 84 e9 00 00 00    	je     80101118 <consoleintr+0x158>
8010102f:	0f 8f 4b 01 00 00    	jg     80101180 <consoleintr+0x1c0>
80101035:	8d 43 fa             	lea    -0x6(%ebx),%eax
80101038:	83 f8 0f             	cmp    $0xf,%eax
8010103b:	0f 87 45 05 00 00    	ja     80101586 <consoleintr+0x5c6>
80101041:	ff 24 85 7c 95 10 80 	jmp    *-0x7fef6a84(,%eax,4)
80101048:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010104f:	00 
      if (!copying) {
80101050:	8b 15 08 18 11 80    	mov    0x80111808,%edx
80101056:	85 d2                	test   %edx,%edx
80101058:	75 96                	jne    80100ff0 <consoleintr+0x30>
        while(input.e != input.w &&
8010105a:	a1 ac 12 11 80       	mov    0x801112ac,%eax
8010105f:	39 05 a8 12 11 80    	cmp    %eax,0x801112a8
80101065:	74 89                	je     80100ff0 <consoleintr+0x30>
              input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80101067:	83 e8 01             	sub    $0x1,%eax
8010106a:	89 c2                	mov    %eax,%edx
8010106c:	83 e2 7f             	and    $0x7f,%edx
        while(input.e != input.w &&
8010106f:	80 ba 24 12 11 80 0a 	cmpb   $0xa,-0x7feeeddc(%edx)
80101076:	0f 84 74 ff ff ff    	je     80100ff0 <consoleintr+0x30>
          input.e--;
8010107c:	a3 ac 12 11 80       	mov    %eax,0x801112ac
  if(panicked){
80101081:	a1 f8 17 11 80       	mov    0x801117f8,%eax
80101086:	85 c0                	test   %eax,%eax
80101088:	0f 84 d2 05 00 00    	je     80101660 <consoleintr+0x6a0>
  asm volatile("cli");
8010108e:	fa                   	cli
    for(;;)
8010108f:	eb fe                	jmp    8010108f <consoleintr+0xcf>
80101091:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      copying = 1; // enable copying flag
80101098:	c7 05 08 18 11 80 01 	movl   $0x1,0x80111808
8010109f:	00 00 00 
      num_copied_commands = 0;
801010a2:	c7 05 fc 17 11 80 00 	movl   $0x0,0x801117fc
801010a9:	00 00 00 
      insert_copied_commands = 0;
801010ac:	c7 05 04 18 11 80 00 	movl   $0x0,0x80111804
801010b3:	00 00 00 
  while(((temp_c = getc()) >= 0) || (insert_copied_commands)){
801010b6:	ff d7                	call   *%edi
801010b8:	89 c3                	mov    %eax,%ebx
801010ba:	85 c0                	test   %eax,%eax
801010bc:	0f 89 3a ff ff ff    	jns    80100ffc <consoleintr+0x3c>
801010c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801010c8:	8b 0d 04 18 11 80    	mov    0x80111804,%ecx
801010ce:	85 c9                	test   %ecx,%ecx
801010d0:	0f 84 8a 04 00 00    	je     80101560 <consoleintr+0x5a0>
      c = copybuf[current_copied_command_to_run_idx];
801010d6:	a1 00 18 11 80       	mov    0x80111800,%eax
801010db:	8b 1c 85 20 18 11 80 	mov    -0x7feee7e0(,%eax,4),%ebx
      current_copied_command_to_run_idx++;
801010e2:	83 c0 01             	add    $0x1,%eax
801010e5:	a3 00 18 11 80       	mov    %eax,0x80111800
801010ea:	e9 20 ff ff ff       	jmp    8010100f <consoleintr+0x4f>
801010ef:	90                   	nop
      copying = 0; // disable copying flag
801010f0:	c7 05 08 18 11 80 00 	movl   $0x0,0x80111808
801010f7:	00 00 00 
      insert_copied_commands = 1; // send the signal to start running the copied commands
801010fa:	c7 05 04 18 11 80 01 	movl   $0x1,0x80111804
80101101:	00 00 00 
      current_copied_command_to_run_idx = 0; // set the idx to zero
80101104:	c7 05 00 18 11 80 00 	movl   $0x0,0x80111800
8010110b:	00 00 00 
      break;
8010110e:	e9 dd fe ff ff       	jmp    80100ff0 <consoleintr+0x30>
80101113:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if (copying) {
80101118:	a1 08 18 11 80       	mov    0x80111808,%eax
8010111d:	85 c0                	test   %eax,%eax
8010111f:	0f 85 50 03 00 00    	jne    80101475 <consoleintr+0x4b5>
        if(input.e != input.w && input.position > input.r){
80101125:	a1 ac 12 11 80       	mov    0x801112ac,%eax
8010112a:	3b 05 a8 12 11 80    	cmp    0x801112a8,%eax
80101130:	0f 84 ba fe ff ff    	je     80100ff0 <consoleintr+0x30>
80101136:	8b 15 20 12 11 80    	mov    0x80111220,%edx
8010113c:	3b 15 a4 12 11 80    	cmp    0x801112a4,%edx
80101142:	0f 86 a8 fe ff ff    	jbe    80100ff0 <consoleintr+0x30>
          remove_chars(num_of_backs);
80101148:	83 ec 0c             	sub    $0xc,%esp
8010114b:	ff 35 b0 12 11 80    	push   0x801112b0
          input.e--;
80101151:	83 e8 01             	sub    $0x1,%eax
          input.position--;
80101154:	83 ea 01             	sub    $0x1,%edx
          input.e--;
80101157:	a3 ac 12 11 80       	mov    %eax,0x801112ac
          input.position--;
8010115c:	89 15 20 12 11 80    	mov    %edx,0x80111220
          remove_chars(num_of_backs);
80101162:	e8 99 f9 ff ff       	call   80100b00 <remove_chars>
80101167:	83 c4 10             	add    $0x10,%esp
8010116a:	e9 81 fe ff ff       	jmp    80100ff0 <consoleintr+0x30>
8010116f:	90                   	nop
    switch(c){
80101170:	c7 85 50 ff ff ff 01 	movl   $0x1,-0xb0(%ebp)
80101177:	00 00 00 
8010117a:	e9 71 fe ff ff       	jmp    80100ff0 <consoleintr+0x30>
8010117f:	90                   	nop
80101180:	81 fb e4 00 00 00    	cmp    $0xe4,%ebx
80101186:	0f 84 ac 02 00 00    	je     80101438 <consoleintr+0x478>
8010118c:	7e 42                	jle    801011d0 <consoleintr+0x210>
8010118e:	81 fb e5 00 00 00    	cmp    $0xe5,%ebx
80101194:	0f 85 ce 02 00 00    	jne    80101468 <consoleintr+0x4a8>
      if (copying) {
8010119a:	a1 08 18 11 80       	mov    0x80111808,%eax
8010119f:	85 c0                	test   %eax,%eax
801011a1:	0f 84 69 03 00 00    	je     80101510 <consoleintr+0x550>
  if (num_copied_commands < INPUT_BUF) {  
801011a7:	83 fa 7f             	cmp    $0x7f,%edx
801011aa:	0f 8f 40 fe ff ff    	jg     80100ff0 <consoleintr+0x30>
    copybuf[num_copied_commands] = c; // save the current command
801011b0:	c7 04 95 20 18 11 80 	movl   $0xe5,-0x7feee7e0(,%edx,4)
801011b7:	e5 00 00 00 
    num_copied_commands++; // increase the number of copied commands by 1
801011bb:	83 c2 01             	add    $0x1,%edx
801011be:	89 15 fc 17 11 80    	mov    %edx,0x801117fc
801011c4:	e9 27 fe ff ff       	jmp    80100ff0 <consoleintr+0x30>
801011c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
801011d0:	81 fb e2 00 00 00    	cmp    $0xe2,%ebx
801011d6:	0f 84 44 01 00 00    	je     80101320 <consoleintr+0x360>
801011dc:	81 fb e3 00 00 00    	cmp    $0xe3,%ebx
801011e2:	0f 85 80 02 00 00    	jne    80101468 <consoleintr+0x4a8>
      if (!copying) {
801011e8:	a1 08 18 11 80       	mov    0x80111808,%eax
801011ed:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)
801011f3:	85 c0                	test   %eax,%eax
801011f5:	0f 85 f5 fd ff ff    	jne    80100ff0 <consoleintr+0x30>
        if(command_id < num_of_stored_commands - 1)/*Locating the last command in order to have a boundary*/
801011fb:	a1 b4 12 11 80       	mov    0x801112b4,%eax
80101200:	8b 35 b8 12 11 80    	mov    0x801112b8,%esi
80101206:	83 e8 01             	sub    $0x1,%eax
80101209:	89 b5 44 ff ff ff    	mov    %esi,-0xbc(%ebp)
8010120f:	39 f0                	cmp    %esi,%eax
80101211:	0f 8e d9 fd ff ff    	jle    80100ff0 <consoleintr+0x30>
          for(int i=input.position; i < input.e; i++)
80101217:	a1 20 12 11 80       	mov    0x80111220,%eax
8010121c:	8b 35 ac 12 11 80    	mov    0x801112ac,%esi
80101222:	39 f0                	cmp    %esi,%eax
80101224:	73 77                	jae    8010129d <consoleintr+0x2dd>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101226:	89 7d 08             	mov    %edi,0x8(%ebp)
80101229:	89 b5 4c ff ff ff    	mov    %esi,-0xb4(%ebp)
8010122f:	89 c6                	mov    %eax,%esi
80101231:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101238:	b8 0e 00 00 00       	mov    $0xe,%eax
8010123d:	ba d4 03 00 00       	mov    $0x3d4,%edx
80101242:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101243:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80101248:	89 da                	mov    %ebx,%edx
8010124a:	ec                   	in     (%dx),%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010124b:	bf 0f 00 00 00       	mov    $0xf,%edi
  cursor_position = inb(CRTPORT+1) << 8;
80101250:	0f b6 c8             	movzbl %al,%ecx
80101253:	ba d4 03 00 00       	mov    $0x3d4,%edx
80101258:	c1 e1 08             	shl    $0x8,%ecx
8010125b:	89 f8                	mov    %edi,%eax
8010125d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010125e:	89 da                	mov    %ebx,%edx
80101260:	ec                   	in     (%dx),%al
  cursor_position = cursor_position | inb(CRTPORT+1);/*Finding current position of cursor*/
80101261:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101264:	ba d4 03 00 00       	mov    $0x3d4,%edx
80101269:	09 c1                	or     %eax,%ecx
8010126b:	89 f8                	mov    %edi,%eax
  cursor_position = cursor_position + 1; /*Moving cursor one step forward*/
8010126d:	83 c1 01             	add    $0x1,%ecx
80101270:	ee                   	out    %al,(%dx)
80101271:	89 c8                	mov    %ecx,%eax
80101273:	89 da                	mov    %ebx,%edx
80101275:	ee                   	out    %al,(%dx)
80101276:	b8 0e 00 00 00       	mov    $0xe,%eax
8010127b:	ba d4 03 00 00       	mov    $0x3d4,%edx
80101280:	ee                   	out    %al,(%dx)
  outb(CRTPORT+1, (unsigned char)((cursor_position>>8) & 0xFF)); /*Reset cursor*/
80101281:	89 c8                	mov    %ecx,%eax
80101283:	89 da                	mov    %ebx,%edx
80101285:	c1 f8 08             	sar    $0x8,%eax
80101288:	ee                   	out    %al,(%dx)
          for(int i=input.position; i < input.e; i++)
80101289:	83 c6 01             	add    $0x1,%esi
8010128c:	39 b5 4c ff ff ff    	cmp    %esi,-0xb4(%ebp)
80101292:	77 a4                	ja     80101238 <consoleintr+0x278>
80101294:	8b b5 4c ff ff ff    	mov    -0xb4(%ebp),%esi
8010129a:	8b 7d 08             	mov    0x8(%ebp),%edi
          while(input.e > input.w)
8010129d:	3b 35 a8 12 11 80    	cmp    0x801112a8,%esi
801012a3:	76 32                	jbe    801012d7 <consoleintr+0x317>
801012a5:	8d 76 00             	lea    0x0(%esi),%esi
            remove_chars(0);
801012a8:	83 ec 0c             	sub    $0xc,%esp
            input.e--;
801012ab:	83 ee 01             	sub    $0x1,%esi
            remove_chars(0);
801012ae:	6a 00                	push   $0x0
            input.e--;
801012b0:	89 35 ac 12 11 80    	mov    %esi,0x801112ac
            remove_chars(0);
801012b6:	e8 45 f8 ff ff       	call   80100b00 <remove_chars>
          while(input.e > input.w)
801012bb:	8b 35 ac 12 11 80    	mov    0x801112ac,%esi
801012c1:	83 c4 10             	add    $0x10,%esp
801012c4:	3b 35 a8 12 11 80    	cmp    0x801112a8,%esi
801012ca:	77 dc                	ja     801012a8 <consoleintr+0x2e8>
          command_id ++;
801012cc:	a1 b8 12 11 80       	mov    0x801112b8,%eax
801012d1:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
801012d7:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
801012dd:	8b 9d 48 ff ff ff    	mov    -0xb8(%ebp),%ebx
801012e3:	83 c0 01             	add    $0x1,%eax
801012e6:	a3 b8 12 11 80       	mov    %eax,0x801112b8
          for(int i=0; i < strlen(command_history[command_id]); i++)
801012eb:	c1 e0 07             	shl    $0x7,%eax
801012ee:	83 ec 0c             	sub    $0xc,%esp
801012f1:	05 c0 12 11 80       	add    $0x801112c0,%eax
801012f6:	50                   	push   %eax
801012f7:	e8 84 4c 00 00       	call   80105f80 <strlen>
801012fc:	83 c4 10             	add    $0x10,%esp
801012ff:	39 d8                	cmp    %ebx,%eax
80101301:	0f 8e cf 05 00 00    	jle    801018d6 <consoleintr+0x916>
  if(panicked){
80101307:	8b 35 f8 17 11 80    	mov    0x801117f8,%esi
8010130d:	85 f6                	test   %esi,%esi
8010130f:	0f 84 f5 03 00 00    	je     8010170a <consoleintr+0x74a>
  asm volatile("cli");
80101315:	fa                   	cli
    for(;;)
80101316:	eb fe                	jmp    80101316 <consoleintr+0x356>
80101318:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010131f:	00 
      if (!copying) {
80101320:	a1 08 18 11 80       	mov    0x80111808,%eax
80101325:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)
8010132b:	85 c0                	test   %eax,%eax
8010132d:	0f 85 bd fc ff ff    	jne    80100ff0 <consoleintr+0x30>
        if(command_id >= 0) /*We need to have a command in order to press up and see history*/
80101333:	a1 b8 12 11 80       	mov    0x801112b8,%eax
80101338:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
8010133e:	85 c0                	test   %eax,%eax
80101340:	0f 88 aa fc ff ff    	js     80100ff0 <consoleintr+0x30>
          for(int i=input.position; i < input.e; i++)
80101346:	a1 20 12 11 80       	mov    0x80111220,%eax
8010134b:	8b 35 ac 12 11 80    	mov    0x801112ac,%esi
80101351:	39 f0                	cmp    %esi,%eax
80101353:	73 70                	jae    801013c5 <consoleintr+0x405>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101355:	89 7d 08             	mov    %edi,0x8(%ebp)
80101358:	89 b5 4c ff ff ff    	mov    %esi,-0xb4(%ebp)
8010135e:	89 c6                	mov    %eax,%esi
80101360:	b8 0e 00 00 00       	mov    $0xe,%eax
80101365:	ba d4 03 00 00       	mov    $0x3d4,%edx
8010136a:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010136b:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80101370:	89 da                	mov    %ebx,%edx
80101372:	ec                   	in     (%dx),%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101373:	bf 0f 00 00 00       	mov    $0xf,%edi
  cursor_position = inb(CRTPORT+1) << 8;
80101378:	0f b6 c8             	movzbl %al,%ecx
8010137b:	ba d4 03 00 00       	mov    $0x3d4,%edx
80101380:	c1 e1 08             	shl    $0x8,%ecx
80101383:	89 f8                	mov    %edi,%eax
80101385:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101386:	89 da                	mov    %ebx,%edx
80101388:	ec                   	in     (%dx),%al
  cursor_position = cursor_position | inb(CRTPORT+1);/*Finding current position of cursor*/
80101389:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010138c:	ba d4 03 00 00       	mov    $0x3d4,%edx
80101391:	09 c1                	or     %eax,%ecx
80101393:	89 f8                	mov    %edi,%eax
  cursor_position = cursor_position + 1; /*Moving cursor one step forward*/
80101395:	83 c1 01             	add    $0x1,%ecx
80101398:	ee                   	out    %al,(%dx)
80101399:	89 c8                	mov    %ecx,%eax
8010139b:	89 da                	mov    %ebx,%edx
8010139d:	ee                   	out    %al,(%dx)
8010139e:	b8 0e 00 00 00       	mov    $0xe,%eax
801013a3:	ba d4 03 00 00       	mov    $0x3d4,%edx
801013a8:	ee                   	out    %al,(%dx)
  outb(CRTPORT+1, (unsigned char)((cursor_position>>8) & 0xFF)); /*Reset cursor*/
801013a9:	89 c8                	mov    %ecx,%eax
801013ab:	89 da                	mov    %ebx,%edx
801013ad:	c1 f8 08             	sar    $0x8,%eax
801013b0:	ee                   	out    %al,(%dx)
          for(int i=input.position; i < input.e; i++)
801013b1:	83 c6 01             	add    $0x1,%esi
801013b4:	39 b5 4c ff ff ff    	cmp    %esi,-0xb4(%ebp)
801013ba:	77 a4                	ja     80101360 <consoleintr+0x3a0>
801013bc:	8b b5 4c ff ff ff    	mov    -0xb4(%ebp),%esi
801013c2:	8b 7d 08             	mov    0x8(%ebp),%edi
          while(input.e > input.w)
801013c5:	39 35 a8 12 11 80    	cmp    %esi,0x801112a8
801013cb:	0f 83 38 05 00 00    	jae    80101909 <consoleintr+0x949>
801013d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            remove_chars(0);
801013d8:	83 ec 0c             	sub    $0xc,%esp
            input.e--;
801013db:	83 ee 01             	sub    $0x1,%esi
            remove_chars(0);
801013de:	6a 00                	push   $0x0
            input.e--;
801013e0:	89 35 ac 12 11 80    	mov    %esi,0x801112ac
            remove_chars(0);
801013e6:	e8 15 f7 ff ff       	call   80100b00 <remove_chars>
          while(input.e > input.w)
801013eb:	8b 35 ac 12 11 80    	mov    0x801112ac,%esi
801013f1:	83 c4 10             	add    $0x10,%esp
801013f4:	3b 35 a8 12 11 80    	cmp    0x801112a8,%esi
801013fa:	77 dc                	ja     801013d8 <consoleintr+0x418>
          for(int i=0; i < strlen(command_history[command_id]); i++)
801013fc:	a1 b8 12 11 80       	mov    0x801112b8,%eax
80101401:	8b 9d 48 ff ff ff    	mov    -0xb8(%ebp),%ebx
80101407:	c1 e0 07             	shl    $0x7,%eax
8010140a:	83 ec 0c             	sub    $0xc,%esp
8010140d:	05 c0 12 11 80       	add    $0x801112c0,%eax
80101412:	50                   	push   %eax
80101413:	e8 68 4b 00 00       	call   80105f80 <strlen>
80101418:	83 c4 10             	add    $0x10,%esp
8010141b:	39 d8                	cmp    %ebx,%eax
8010141d:	0f 8e 9d 04 00 00    	jle    801018c0 <consoleintr+0x900>
  if(panicked){
80101423:	a1 f8 17 11 80       	mov    0x801117f8,%eax
80101428:	85 c0                	test   %eax,%eax
8010142a:	0f 84 85 02 00 00    	je     801016b5 <consoleintr+0x6f5>
  asm volatile("cli");
80101430:	fa                   	cli
    for(;;)
80101431:	eb fe                	jmp    80101431 <consoleintr+0x471>
80101433:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if (copying) {
80101438:	a1 08 18 11 80       	mov    0x80111808,%eax
8010143d:	85 c0                	test   %eax,%eax
8010143f:	74 57                	je     80101498 <consoleintr+0x4d8>
  if (num_copied_commands < INPUT_BUF) {  
80101441:	83 fa 7f             	cmp    $0x7f,%edx
80101444:	0f 8f a6 fb ff ff    	jg     80100ff0 <consoleintr+0x30>
    copybuf[num_copied_commands] = c; // save the current command
8010144a:	c7 04 95 20 18 11 80 	movl   $0xe4,-0x7feee7e0(,%edx,4)
80101451:	e4 00 00 00 
    num_copied_commands++; // increase the number of copied commands by 1
80101455:	83 c2 01             	add    $0x1,%edx
80101458:	89 15 fc 17 11 80    	mov    %edx,0x801117fc
8010145e:	e9 8d fb ff ff       	jmp    80100ff0 <consoleintr+0x30>
80101463:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if (copying) {
80101468:	a1 08 18 11 80       	mov    0x80111808,%eax
8010146d:	85 c0                	test   %eax,%eax
8010146f:	0f 84 2b 01 00 00    	je     801015a0 <consoleintr+0x5e0>
  if (num_copied_commands < INPUT_BUF) {  
80101475:	83 fa 7f             	cmp    $0x7f,%edx
80101478:	0f 8f 72 fb ff ff    	jg     80100ff0 <consoleintr+0x30>
    copybuf[num_copied_commands] = c; // save the current command
8010147e:	89 1c 95 20 18 11 80 	mov    %ebx,-0x7feee7e0(,%edx,4)
    num_copied_commands++; // increase the number of copied commands by 1
80101485:	83 c2 01             	add    $0x1,%edx
80101488:	89 15 fc 17 11 80    	mov    %edx,0x801117fc
8010148e:	e9 5d fb ff ff       	jmp    80100ff0 <consoleintr+0x30>
80101493:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        if(input.position > input.r) /*Checking that we are not at first of the line*/
80101498:	a1 20 12 11 80       	mov    0x80111220,%eax
8010149d:	3b 05 a4 12 11 80    	cmp    0x801112a4,%eax
801014a3:	0f 86 47 fb ff ff    	jbe    80100ff0 <consoleintr+0x30>
          input.position = input.position - 1;/*Fixing position of current state*/
801014a9:	83 e8 01             	sub    $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801014ac:	be d4 03 00 00       	mov    $0x3d4,%esi
          num_of_backs += 1; /*With each left movement we calculate how much do we go back*/
801014b1:	83 05 b0 12 11 80 01 	addl   $0x1,0x801112b0
          input.position = input.position - 1;/*Fixing position of current state*/
801014b8:	a3 20 12 11 80       	mov    %eax,0x80111220
801014bd:	89 f2                	mov    %esi,%edx
801014bf:	b8 0e 00 00 00       	mov    $0xe,%eax
801014c4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801014c5:	bb d5 03 00 00       	mov    $0x3d5,%ebx
801014ca:	89 da                	mov    %ebx,%edx
801014cc:	ec                   	in     (%dx),%al
  cursor_position = inb(CRTPORT+1) << 8;
801014cd:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801014d0:	89 f2                	mov    %esi,%edx
801014d2:	b8 0f 00 00 00       	mov    $0xf,%eax
801014d7:	c1 e1 08             	shl    $0x8,%ecx
801014da:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801014db:	89 da                	mov    %ebx,%edx
801014dd:	ec                   	in     (%dx),%al
  cursor_position = cursor_position | inb(CRTPORT+1);/*Finding current position of cursor*/
801014de:	0f b6 c0             	movzbl %al,%eax
801014e1:	09 c1                	or     %eax,%ecx
  cursor_position = cursor_position - 1; /*Moving cursor one step back*/
801014e3:	83 e9 01             	sub    $0x1,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801014e6:	b8 0f 00 00 00       	mov    $0xf,%eax
801014eb:	89 f2                	mov    %esi,%edx
801014ed:	ee                   	out    %al,(%dx)
801014ee:	89 c8                	mov    %ecx,%eax
801014f0:	89 da                	mov    %ebx,%edx
801014f2:	ee                   	out    %al,(%dx)
801014f3:	b8 0e 00 00 00       	mov    $0xe,%eax
801014f8:	89 f2                	mov    %esi,%edx
801014fa:	ee                   	out    %al,(%dx)
  outb(CRTPORT+1, (unsigned char)((cursor_position>>8) & 0xFF)); /*Reset cursor*/
801014fb:	89 c8                	mov    %ecx,%eax
801014fd:	89 da                	mov    %ebx,%edx
801014ff:	c1 f8 08             	sar    $0x8,%eax
80101502:	ee                   	out    %al,(%dx)
}
80101503:	e9 e8 fa ff ff       	jmp    80100ff0 <consoleintr+0x30>
80101508:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010150f:	00 
        if(input.position < input.e) /*Checking that we are not at end of the line*/
80101510:	a1 20 12 11 80       	mov    0x80111220,%eax
80101515:	3b 05 ac 12 11 80    	cmp    0x801112ac,%eax
8010151b:	0f 83 cf fa ff ff    	jae    80100ff0 <consoleintr+0x30>
          input.position = input.position + 1;/*Fixing position of current state*/
80101521:	83 c0 01             	add    $0x1,%eax
80101524:	be d4 03 00 00       	mov    $0x3d4,%esi
          num_of_backs -= 1; /*With each left movement we calculate how much do we go back*/
80101529:	83 2d b0 12 11 80 01 	subl   $0x1,0x801112b0
          input.position = input.position + 1;/*Fixing position of current state*/
80101530:	a3 20 12 11 80       	mov    %eax,0x80111220
80101535:	89 f2                	mov    %esi,%edx
80101537:	b8 0e 00 00 00       	mov    $0xe,%eax
8010153c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010153d:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80101542:	89 da                	mov    %ebx,%edx
80101544:	ec                   	in     (%dx),%al
  cursor_position = inb(CRTPORT+1) << 8;
80101545:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101548:	89 f2                	mov    %esi,%edx
8010154a:	b8 0f 00 00 00       	mov    $0xf,%eax
8010154f:	c1 e1 08             	shl    $0x8,%ecx
80101552:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101553:	89 da                	mov    %ebx,%edx
80101555:	ec                   	in     (%dx),%al
  cursor_position = cursor_position | inb(CRTPORT+1);/*Finding current position of cursor*/
80101556:	0f b6 c0             	movzbl %al,%eax
80101559:	09 c1                	or     %eax,%ecx
  cursor_position = cursor_position + 1; /*Moving cursor one step forward*/
8010155b:	83 c1 01             	add    $0x1,%ecx
8010155e:	eb 86                	jmp    801014e6 <consoleintr+0x526>
  release(&cons.lock);
80101560:	83 ec 0c             	sub    $0xc,%esp
80101563:	68 c0 17 11 80       	push   $0x801117c0
80101568:	e8 f3 46 00 00       	call   80105c60 <release>
  if(doprocdump) {
8010156d:	8b 95 50 ff ff ff    	mov    -0xb0(%ebp),%edx
80101573:	83 c4 10             	add    $0x10,%esp
80101576:	85 d2                	test   %edx,%edx
80101578:	0f 85 2a 01 00 00    	jne    801016a8 <consoleintr+0x6e8>
}
8010157e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101581:	5b                   	pop    %ebx
80101582:	5e                   	pop    %esi
80101583:	5f                   	pop    %edi
80101584:	5d                   	pop    %ebp
80101585:	c3                   	ret
      if (copying) {
80101586:	83 3d 08 18 11 80 00 	cmpl   $0x0,0x80111808
8010158d:	0f 85 e2 fe ff ff    	jne    80101475 <consoleintr+0x4b5>
        if(c != 0 && input.e-input.r < INPUT_BUF) {
80101593:	85 db                	test   %ebx,%ebx
80101595:	0f 84 55 fa ff ff    	je     80100ff0 <consoleintr+0x30>
8010159b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801015a0:	8b 35 ac 12 11 80    	mov    0x801112ac,%esi
801015a6:	8b 15 a4 12 11 80    	mov    0x801112a4,%edx
801015ac:	89 f0                	mov    %esi,%eax
801015ae:	29 d0                	sub    %edx,%eax
801015b0:	83 f8 7f             	cmp    $0x7f,%eax
801015b3:	0f 87 37 fa ff ff    	ja     80100ff0 <consoleintr+0x30>
          int is_divide = 0;
801015b9:	c7 85 58 ff ff ff 00 	movl   $0x0,-0xa8(%ebp)
801015c0:	00 00 00 
          int is_math_expression = detect_math_expression(c);
801015c3:	88 9d 48 ff ff ff    	mov    %bl,-0xb8(%ebp)
  if (c == '?' && input.buf[(input.position-1) % INPUT_BUF] == '=') {
801015c9:	80 fb 3f             	cmp    $0x3f,%bl
801015cc:	0f 84 25 02 00 00    	je     801017f7 <consoleintr+0x837>
              input.buf[input.e++ % INPUT_BUF] = c;
801015d2:	8d 46 01             	lea    0x1(%esi),%eax
801015d5:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%ebp)
            c = (c == '\r') ? '\n' : c;     
801015db:	83 fb 0d             	cmp    $0xd,%ebx
801015de:	0f 84 bc 02 00 00    	je     801018a0 <consoleintr+0x8e0>
            if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF)
801015e4:	83 fb 0a             	cmp    $0xa,%ebx
801015e7:	0f 84 ec 04 00 00    	je     80101ad9 <consoleintr+0xb19>
801015ed:	83 fb 04             	cmp    $0x4,%ebx
801015f0:	0f 84 e3 04 00 00    	je     80101ad9 <consoleintr+0xb19>
801015f6:	8d 82 80 00 00 00    	lea    0x80(%edx),%eax
801015fc:	39 c6                	cmp    %eax,%esi
801015fe:	0f 84 d5 04 00 00    	je     80101ad9 <consoleintr+0xb19>
        if(input.e != input.w && input.position > input.r){
80101604:	8b 0d 20 12 11 80    	mov    0x80111220,%ecx
              if(num_of_backs == 0) {
8010160a:	a1 b0 12 11 80       	mov    0x801112b0,%eax
          input.position = input.position + 1;/*Fixing position of current state*/
8010160f:	8d 51 01             	lea    0x1(%ecx),%edx
              if(num_of_backs == 0) {
80101612:	89 85 40 ff ff ff    	mov    %eax,-0xc0(%ebp)
        if(input.e != input.w && input.position > input.r){
80101618:	89 8d 44 ff ff ff    	mov    %ecx,-0xbc(%ebp)
          input.position = input.position + 1;/*Fixing position of current state*/
8010161e:	89 95 3c ff ff ff    	mov    %edx,-0xc4(%ebp)
              if(num_of_backs == 0) {
80101624:	85 c0                	test   %eax,%eax
80101626:	0f 85 33 01 00 00    	jne    8010175f <consoleintr+0x79f>
                  input.buf[input.e++ % INPUT_BUF] = c;
8010162c:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
                  input.position ++;
80101632:	89 15 20 12 11 80    	mov    %edx,0x80111220
                  input.buf[input.e++ % INPUT_BUF] = c;
80101638:	a3 ac 12 11 80       	mov    %eax,0x801112ac
8010163d:	89 f0                	mov    %esi,%eax
  if(panicked){
8010163f:	8b 35 f8 17 11 80    	mov    0x801117f8,%esi
                  input.buf[input.e++ % INPUT_BUF] = c;
80101645:	83 e0 7f             	and    $0x7f,%eax
80101648:	88 98 24 12 11 80    	mov    %bl,-0x7feeeddc(%eax)
  if(panicked){
8010164e:	85 f6                	test   %esi,%esi
80101650:	0f 84 8f 02 00 00    	je     801018e5 <consoleintr+0x925>
  asm volatile("cli");
80101656:	fa                   	cli
    for(;;)
80101657:	eb fe                	jmp    80101657 <consoleintr+0x697>
80101659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartputc('\b'); uartputc(' '); uartputc('\b');
80101660:	83 ec 0c             	sub    $0xc,%esp
80101663:	6a 08                	push   $0x8
80101665:	e8 46 62 00 00       	call   801078b0 <uartputc>
8010166a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80101671:	e8 3a 62 00 00       	call   801078b0 <uartputc>
80101676:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010167d:	e8 2e 62 00 00       	call   801078b0 <uartputc>
  cgaputc(c);
80101682:	b8 00 01 00 00       	mov    $0x100,%eax
80101687:	e8 c4 ee ff ff       	call   80100550 <cgaputc>
        while(input.e != input.w &&
8010168c:	a1 ac 12 11 80       	mov    0x801112ac,%eax
80101691:	83 c4 10             	add    $0x10,%esp
80101694:	3b 05 a8 12 11 80    	cmp    0x801112a8,%eax
8010169a:	0f 85 c7 f9 ff ff    	jne    80101067 <consoleintr+0xa7>
801016a0:	e9 4b f9 ff ff       	jmp    80100ff0 <consoleintr+0x30>
801016a5:	8d 76 00             	lea    0x0(%esi),%esi
    procdump();  // now call procdump() wo. cons.lock held
801016a8:	e8 33 3c 00 00       	call   801052e0 <procdump>
}
801016ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
801016b0:	5b                   	pop    %ebx
801016b1:	5e                   	pop    %esi
801016b2:	5f                   	pop    %edi
801016b3:	5d                   	pop    %ebp
801016b4:	c3                   	ret
            letter = command_history[command_id][i];
801016b5:	a1 b8 12 11 80       	mov    0x801112b8,%eax
    uartputc(c);
801016ba:	83 ec 0c             	sub    $0xc,%esp
            letter = command_history[command_id][i];
801016bd:	c1 e0 07             	shl    $0x7,%eax
801016c0:	0f b6 b4 03 c0 12 11 	movzbl -0x7feeed40(%ebx,%eax,1),%esi
801016c7:	80 
          for(int i=0; i < strlen(command_history[command_id]); i++)
801016c8:	83 c3 01             	add    $0x1,%ebx
            letter = command_history[command_id][i];
801016cb:	89 f0                	mov    %esi,%eax
801016cd:	0f be c0             	movsbl %al,%eax
    uartputc(c);
801016d0:	50                   	push   %eax
801016d1:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%ebp)
801016d7:	e8 d4 61 00 00       	call   801078b0 <uartputc>
  cgaputc(c);
801016dc:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
801016e2:	e8 69 ee ff ff       	call   80100550 <cgaputc>
            input.buf[input.e++] = letter;
801016e7:	a1 ac 12 11 80       	mov    0x801112ac,%eax
801016ec:	89 f1                	mov    %esi,%ecx
          for(int i=0; i < strlen(command_history[command_id]); i++)
801016ee:	83 c4 10             	add    $0x10,%esp
            input.buf[input.e++] = letter;
801016f1:	8d 50 01             	lea    0x1(%eax),%edx
801016f4:	88 88 24 12 11 80    	mov    %cl,-0x7feeeddc(%eax)
          for(int i=0; i < strlen(command_history[command_id]); i++)
801016fa:	a1 b8 12 11 80       	mov    0x801112b8,%eax
            input.buf[input.e++] = letter;
801016ff:	89 15 ac 12 11 80    	mov    %edx,0x801112ac
80101705:	e9 fd fc ff ff       	jmp    80101407 <consoleintr+0x447>
            letter = command_history[command_id][i];
8010170a:	a1 b8 12 11 80       	mov    0x801112b8,%eax
    uartputc(c);
8010170f:	83 ec 0c             	sub    $0xc,%esp
            letter = command_history[command_id][i];
80101712:	c1 e0 07             	shl    $0x7,%eax
80101715:	0f b6 b4 03 c0 12 11 	movzbl -0x7feeed40(%ebx,%eax,1),%esi
8010171c:	80 
          for(int i=0; i < strlen(command_history[command_id]); i++)
8010171d:	83 c3 01             	add    $0x1,%ebx
            letter = command_history[command_id][i];
80101720:	89 f0                	mov    %esi,%eax
80101722:	0f be c0             	movsbl %al,%eax
    uartputc(c);
80101725:	50                   	push   %eax
80101726:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%ebp)
8010172c:	e8 7f 61 00 00       	call   801078b0 <uartputc>
  cgaputc(c);
80101731:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
80101737:	e8 14 ee ff ff       	call   80100550 <cgaputc>
            input.buf[input.e++] = letter;
8010173c:	a1 ac 12 11 80       	mov    0x801112ac,%eax
80101741:	89 f1                	mov    %esi,%ecx
          for(int i=0; i < strlen(command_history[command_id]); i++)
80101743:	83 c4 10             	add    $0x10,%esp
            input.buf[input.e++] = letter;
80101746:	8d 50 01             	lea    0x1(%eax),%edx
80101749:	88 88 24 12 11 80    	mov    %cl,-0x7feeeddc(%eax)
          for(int i=0; i < strlen(command_history[command_id]); i++)
8010174f:	a1 b8 12 11 80       	mov    0x801112b8,%eax
            input.buf[input.e++] = letter;
80101754:	89 15 ac 12 11 80    	mov    %edx,0x801112ac
8010175a:	e9 8c fb ff ff       	jmp    801012eb <consoleintr+0x32b>
                for(int i=input.e; i > input.position; i--)
8010175f:	89 f0                	mov    %esi,%eax
80101761:	3b b5 44 ff ff ff    	cmp    -0xbc(%ebp),%esi
80101767:	76 4b                	jbe    801017b4 <consoleintr+0x7f4>
80101769:	89 9d 38 ff ff ff    	mov    %ebx,-0xc8(%ebp)
8010176f:	8b b5 44 ff ff ff    	mov    -0xbc(%ebp),%esi
80101775:	8d 76 00             	lea    0x0(%esi),%esi
                  input.buf[(i + 1) % INPUT_BUF] = input.buf[(i) % INPUT_BUF];
80101778:	89 c1                	mov    %eax,%ecx
8010177a:	c1 f9 1f             	sar    $0x1f,%ecx
8010177d:	c1 e9 19             	shr    $0x19,%ecx
80101780:	8d 14 08             	lea    (%eax,%ecx,1),%edx
80101783:	83 e2 7f             	and    $0x7f,%edx
80101786:	29 ca                	sub    %ecx,%edx
80101788:	0f b6 9a 24 12 11 80 	movzbl -0x7feeeddc(%edx),%ebx
8010178f:	8d 50 01             	lea    0x1(%eax),%edx
                for(int i=input.e; i > input.position; i--)
80101792:	83 e8 01             	sub    $0x1,%eax
                  input.buf[(i + 1) % INPUT_BUF] = input.buf[(i) % INPUT_BUF];
80101795:	89 d1                	mov    %edx,%ecx
80101797:	c1 f9 1f             	sar    $0x1f,%ecx
8010179a:	c1 e9 19             	shr    $0x19,%ecx
8010179d:	01 ca                	add    %ecx,%edx
8010179f:	83 e2 7f             	and    $0x7f,%edx
801017a2:	29 ca                	sub    %ecx,%edx
801017a4:	88 9a 24 12 11 80    	mov    %bl,-0x7feeeddc(%edx)
                for(int i=input.e; i > input.position; i--)
801017aa:	39 f0                	cmp    %esi,%eax
801017ac:	77 ca                	ja     80101778 <consoleintr+0x7b8>
801017ae:	8b 9d 38 ff ff ff    	mov    -0xc8(%ebp),%ebx
                input.buf[input.position % INPUT_BUF] = c;
801017b4:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
801017ba:	0f b6 8d 48 ff ff ff 	movzbl -0xb8(%ebp),%ecx
                insert_chars(num_of_backs,c);
801017c1:	83 ec 08             	sub    $0x8,%esp
801017c4:	53                   	push   %ebx
                input.buf[input.position % INPUT_BUF] = c;
801017c5:	83 e0 7f             	and    $0x7f,%eax
                insert_chars(num_of_backs,c);
801017c8:	ff b5 40 ff ff ff    	push   -0xc0(%ebp)
                input.buf[input.position % INPUT_BUF] = c;
801017ce:	88 88 24 12 11 80    	mov    %cl,-0x7feeeddc(%eax)
                input.e++;
801017d4:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
801017da:	a3 ac 12 11 80       	mov    %eax,0x801112ac
                input.position++;
801017df:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
801017e5:	a3 20 12 11 80       	mov    %eax,0x80111220
                insert_chars(num_of_backs,c);
801017ea:	e8 b1 f3 ff ff       	call   80100ba0 <insert_chars>
801017ef:	83 c4 10             	add    $0x10,%esp
801017f2:	e9 f9 f7 ff ff       	jmp    80100ff0 <consoleintr+0x30>
801017f7:	89 95 4c ff ff ff    	mov    %edx,-0xb4(%ebp)
801017fd:	e8 4e ec ff ff       	call   80100450 <detect_math_expression.part.0>
          if (is_math_expression) {
80101802:	8b 95 4c ff ff ff    	mov    -0xb4(%ebp),%edx
80101808:	85 c0                	test   %eax,%eax
8010180a:	0f 84 c2 fd ff ff    	je     801015d2 <consoleintr+0x612>
            float result = calculate_result_math_expression(&is_divide);
80101810:	83 ec 0c             	sub    $0xc,%esp
80101813:	8d 85 58 ff ff ff    	lea    -0xa8(%ebp),%eax
80101819:	50                   	push   %eax
8010181a:	e8 71 f4 ff ff       	call   80100c90 <calculate_result_math_expression>
            if (!is_divide) {
8010181f:	8b 9d 58 ff ff ff    	mov    -0xa8(%ebp),%ebx
80101825:	83 c4 10             	add    $0x10,%esp
80101828:	85 db                	test   %ebx,%ebx
8010182a:	0f 85 88 02 00 00    	jne    80101ab8 <consoleintr+0xaf8>
              res_len = int_to_str((int)result, res_str);
80101830:	d9 bd 56 ff ff ff    	fnstcw -0xaa(%ebp)
80101836:	83 ec 08             	sub    $0x8,%esp
80101839:	8d 9d 5c ff ff ff    	lea    -0xa4(%ebp),%ebx
8010183f:	53                   	push   %ebx
80101840:	0f b7 85 56 ff ff ff 	movzwl -0xaa(%ebp),%eax
80101847:	80 cc 0c             	or     $0xc,%ah
8010184a:	66 89 85 54 ff ff ff 	mov    %ax,-0xac(%ebp)
80101851:	d9 ad 54 ff ff ff    	fldcw  -0xac(%ebp)
80101857:	db 9d 4c ff ff ff    	fistpl -0xb4(%ebp)
8010185d:	d9 ad 56 ff ff ff    	fldcw  -0xaa(%ebp)
80101863:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
80101869:	50                   	push   %eax
8010186a:	e8 41 f6 ff ff       	call   80100eb0 <int_to_str>
8010186f:	83 c4 10             	add    $0x10,%esp
80101872:	89 c2                	mov    %eax,%edx
{
80101874:	89 9d 4c ff ff ff    	mov    %ebx,-0xb4(%ebp)
8010187a:	be 04 00 00 00       	mov    $0x4,%esi
8010187f:	89 d3                	mov    %edx,%ebx
  if(panicked){
80101881:	8b 0d f8 17 11 80    	mov    0x801117f8,%ecx
              input.e--;
80101887:	83 2d ac 12 11 80 01 	subl   $0x1,0x801112ac
              input.position--;
8010188e:	83 2d 20 12 11 80 01 	subl   $0x1,0x80111220
  if(panicked){
80101895:	85 c9                	test   %ecx,%ecx
80101897:	0f 84 6c 01 00 00    	je     80101a09 <consoleintr+0xa49>
8010189d:	fa                   	cli
    for(;;)
8010189e:	eb fe                	jmp    8010189e <consoleintr+0x8de>
              input.buf[input.e++ % INPUT_BUF] = c;
801018a0:	a3 ac 12 11 80       	mov    %eax,0x801112ac
801018a5:	89 f0                	mov    %esi,%eax
801018a7:	83 e0 7f             	and    $0x7f,%eax
801018aa:	c6 80 24 12 11 80 0a 	movb   $0xa,-0x7feeeddc(%eax)
  if(panicked){
801018b1:	a1 f8 17 11 80       	mov    0x801117f8,%eax
801018b6:	85 c0                	test   %eax,%eax
801018b8:	74 60                	je     8010191a <consoleintr+0x95a>
801018ba:	fa                   	cli
    for(;;)
801018bb:	eb fe                	jmp    801018bb <consoleintr+0x8fb>
801018bd:	8d 76 00             	lea    0x0(%esi),%esi
          input.position = input.e;
801018c0:	a1 ac 12 11 80       	mov    0x801112ac,%eax
          command_id --;
801018c5:	83 2d b8 12 11 80 01 	subl   $0x1,0x801112b8
          input.position = input.e;
801018cc:	a3 20 12 11 80       	mov    %eax,0x80111220
801018d1:	e9 1a f7 ff ff       	jmp    80100ff0 <consoleintr+0x30>
          input.position = input.e;
801018d6:	a1 ac 12 11 80       	mov    0x801112ac,%eax
801018db:	a3 20 12 11 80       	mov    %eax,0x80111220
801018e0:	e9 0b f7 ff ff       	jmp    80100ff0 <consoleintr+0x30>
  if(c == BACKSPACE){
801018e5:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
801018eb:	0f 84 d6 00 00 00    	je     801019c7 <consoleintr+0xa07>
    uartputc(c);
801018f1:	83 ec 0c             	sub    $0xc,%esp
801018f4:	53                   	push   %ebx
801018f5:	e8 b6 5f 00 00       	call   801078b0 <uartputc>
801018fa:	83 c4 10             	add    $0x10,%esp
  cgaputc(c);
801018fd:	89 d8                	mov    %ebx,%eax
801018ff:	e8 4c ec ff ff       	call   80100550 <cgaputc>
}
80101904:	e9 e7 f6 ff ff       	jmp    80100ff0 <consoleintr+0x30>
80101909:	8b 9d 48 ff ff ff    	mov    -0xb8(%ebp),%ebx
8010190f:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
80101915:	e9 ed fa ff ff       	jmp    80101407 <consoleintr+0x447>
            c = (c == '\r') ? '\n' : c;     
8010191a:	bb 0a 00 00 00       	mov    $0xa,%ebx
    uartputc(c);
8010191f:	83 ec 0c             	sub    $0xc,%esp
80101922:	53                   	push   %ebx
80101923:	e8 88 5f 00 00       	call   801078b0 <uartputc>
80101928:	83 c4 10             	add    $0x10,%esp
  cgaputc(c);
8010192b:	89 d8                	mov    %ebx,%eax
8010192d:	e8 1e ec ff ff       	call   80100550 <cgaputc>
              for(int i=input.w, j=0; i < input.e-1; i++, j++)
80101932:	8b 35 ac 12 11 80    	mov    0x801112ac,%esi
80101938:	8b 0d a8 12 11 80    	mov    0x801112a8,%ecx
              num_of_backs = 0; /*Set num of back to 0*/
8010193e:	c7 05 b0 12 11 80 00 	movl   $0x0,0x801112b0
80101945:	00 00 00 
              for(int i=input.w, j=0; i < input.e-1; i++, j++)
80101948:	89 b5 4c ff ff ff    	mov    %esi,-0xb4(%ebp)
8010194e:	8d 5e ff             	lea    -0x1(%esi),%ebx
                current_command[j] = input.buf[i % INPUT_BUF];
80101951:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
              for(int i=input.w, j=0; i < input.e-1; i++, j++)
80101957:	89 c8                	mov    %ecx,%eax
80101959:	89 8d 48 ff ff ff    	mov    %ecx,-0xb8(%ebp)
                current_command[j] = input.buf[i % INPUT_BUF];
8010195f:	29 ce                	sub    %ecx,%esi
              for(int i=input.w, j=0; i < input.e-1; i++, j++)
80101961:	39 d9                	cmp    %ebx,%ecx
80101963:	73 21                	jae    80101986 <consoleintr+0x9c6>
                current_command[j] = input.buf[i % INPUT_BUF];
80101965:	89 c1                	mov    %eax,%ecx
80101967:	c1 f9 1f             	sar    $0x1f,%ecx
8010196a:	c1 e9 19             	shr    $0x19,%ecx
8010196d:	8d 14 08             	lea    (%eax,%ecx,1),%edx
80101970:	83 e2 7f             	and    $0x7f,%edx
80101973:	29 ca                	sub    %ecx,%edx
80101975:	0f b6 92 24 12 11 80 	movzbl -0x7feeeddc(%edx),%edx
8010197c:	88 14 06             	mov    %dl,(%esi,%eax,1)
              for(int i=input.w, j=0; i < input.e-1; i++, j++)
8010197f:	83 c0 01             	add    $0x1,%eax
80101982:	39 c3                	cmp    %eax,%ebx
80101984:	77 df                	ja     80101965 <consoleintr+0x9a5>
              current_command[(input.e-1-input.w) % INPUT_BUF] = '\0';
80101986:	89 d8                	mov    %ebx,%eax
80101988:	2b 85 48 ff ff ff    	sub    -0xb8(%ebp),%eax
8010198e:	83 e0 7f             	and    $0x7f,%eax
80101991:	c6 84 05 68 ff ff ff 	movb   $0x0,-0x98(%ebp,%eax,1)
80101998:	00 
  if((command[0]!='\0'))
80101999:	80 bd 68 ff ff ff 00 	cmpb   $0x0,-0x98(%ebp)
801019a0:	75 4f                	jne    801019f1 <consoleintr+0xa31>
              wakeup(&input.r);
801019a2:	83 ec 0c             	sub    $0xc,%esp
              input.w = input.e;
801019a5:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
              wakeup(&input.r);
801019ab:	68 a4 12 11 80       	push   $0x801112a4
              input.w = input.e;
801019b0:	a3 a8 12 11 80       	mov    %eax,0x801112a8
              input.position = input.e;
801019b5:	a3 20 12 11 80       	mov    %eax,0x80111220
              wakeup(&input.r);
801019ba:	e8 41 38 00 00       	call   80105200 <wakeup>
801019bf:	83 c4 10             	add    $0x10,%esp
801019c2:	e9 29 f6 ff ff       	jmp    80100ff0 <consoleintr+0x30>
    uartputc('\b'); uartputc(' '); uartputc('\b');
801019c7:	83 ec 0c             	sub    $0xc,%esp
801019ca:	6a 08                	push   $0x8
801019cc:	e8 df 5e 00 00       	call   801078b0 <uartputc>
801019d1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801019d8:	e8 d3 5e 00 00       	call   801078b0 <uartputc>
801019dd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801019e4:	e8 c7 5e 00 00       	call   801078b0 <uartputc>
801019e9:	83 c4 10             	add    $0x10,%esp
801019ec:	e9 0c ff ff ff       	jmp    801018fd <consoleintr+0x93d>
801019f1:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801019f7:	e8 84 e9 ff ff       	call   80100380 <add_history.part.0>
              input.w = input.e;
801019fc:	a1 ac 12 11 80       	mov    0x801112ac,%eax
80101a01:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%ebp)
80101a07:	eb 99                	jmp    801019a2 <consoleintr+0x9e2>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80101a09:	83 ec 0c             	sub    $0xc,%esp
80101a0c:	6a 08                	push   $0x8
80101a0e:	e8 9d 5e 00 00       	call   801078b0 <uartputc>
80101a13:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80101a1a:	e8 91 5e 00 00       	call   801078b0 <uartputc>
80101a1f:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80101a26:	e8 85 5e 00 00       	call   801078b0 <uartputc>
  cgaputc(c);
80101a2b:	b8 00 01 00 00       	mov    $0x100,%eax
80101a30:	e8 1b eb ff ff       	call   80100550 <cgaputc>
            for(int i = 0; i < math_exp_len-1; i++) {
80101a35:	83 c4 10             	add    $0x10,%esp
80101a38:	83 ee 01             	sub    $0x1,%esi
80101a3b:	0f 85 40 fe ff ff    	jne    80101881 <consoleintr+0x8c1>
80101a41:	89 da                	mov    %ebx,%edx
80101a43:	8b 9d 4c ff ff ff    	mov    -0xb4(%ebp),%ebx
            for (int i = 0; i < res_len; i++) {
80101a49:	8d 34 1a             	lea    (%edx,%ebx,1),%esi
80101a4c:	85 d2                	test   %edx,%edx
80101a4e:	0f 8e 9c f5 ff ff    	jle    80100ff0 <consoleintr+0x30>
80101a54:	89 7d 08             	mov    %edi,0x8(%ebp)
80101a57:	89 f7                	mov    %esi,%edi
80101a59:	89 de                	mov    %ebx,%esi
              input.buf[input.position % INPUT_BUF] = res_str[i];
80101a5b:	8b 0d 20 12 11 80    	mov    0x80111220,%ecx
80101a61:	0f b6 06             	movzbl (%esi),%eax
  if(panicked){
80101a64:	8b 15 f8 17 11 80    	mov    0x801117f8,%edx
              input.e++;
80101a6a:	83 05 ac 12 11 80 01 	addl   $0x1,0x801112ac
              input.buf[input.position % INPUT_BUF] = res_str[i];
80101a71:	89 cb                	mov    %ecx,%ebx
              input.position++;
80101a73:	83 c1 01             	add    $0x1,%ecx
              input.buf[input.position % INPUT_BUF] = res_str[i];
80101a76:	83 e3 7f             	and    $0x7f,%ebx
              input.position++;
80101a79:	89 0d 20 12 11 80    	mov    %ecx,0x80111220
              input.buf[input.position % INPUT_BUF] = res_str[i];
80101a7f:	88 83 24 12 11 80    	mov    %al,-0x7feeeddc(%ebx)
  if(panicked){
80101a85:	85 d2                	test   %edx,%edx
80101a87:	74 07                	je     80101a90 <consoleintr+0xad0>
80101a89:	fa                   	cli
    for(;;)
80101a8a:	eb fe                	jmp    80101a8a <consoleintr+0xaca>
80101a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartputc(c);
80101a90:	83 ec 0c             	sub    $0xc,%esp
              consputc(res_str[i]);
80101a93:	0f be d8             	movsbl %al,%ebx
            for (int i = 0; i < res_len; i++) {
80101a96:	83 c6 01             	add    $0x1,%esi
    uartputc(c);
80101a99:	53                   	push   %ebx
80101a9a:	e8 11 5e 00 00       	call   801078b0 <uartputc>
  cgaputc(c);
80101a9f:	89 d8                	mov    %ebx,%eax
80101aa1:	e8 aa ea ff ff       	call   80100550 <cgaputc>
            for (int i = 0; i < res_len; i++) {
80101aa6:	83 c4 10             	add    $0x10,%esp
80101aa9:	39 f7                	cmp    %esi,%edi
80101aab:	75 ae                	jne    80101a5b <consoleintr+0xa9b>
80101aad:	8b 7d 08             	mov    0x8(%ebp),%edi
80101ab0:	e9 3b f5 ff ff       	jmp    80100ff0 <consoleintr+0x30>
80101ab5:	8d 76 00             	lea    0x0(%esi),%esi
              res_len = float_to_str(result, res_str, PRECISION);
80101ab8:	83 ec 04             	sub    $0x4,%esp
80101abb:	8d 9d 5c ff ff ff    	lea    -0xa4(%ebp),%ebx
80101ac1:	6a 02                	push   $0x2
80101ac3:	53                   	push   %ebx
80101ac4:	83 ec 04             	sub    $0x4,%esp
80101ac7:	d9 1c 24             	fstps  (%esp)
80101aca:	e8 61 f2 ff ff       	call   80100d30 <float_to_str>
80101acf:	83 c4 10             	add    $0x10,%esp
80101ad2:	89 c2                	mov    %eax,%edx
80101ad4:	e9 9b fd ff ff       	jmp    80101874 <consoleintr+0x8b4>
              input.buf[input.e++ % INPUT_BUF] = c;
80101ad9:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
80101adf:	a3 ac 12 11 80       	mov    %eax,0x801112ac
80101ae4:	89 f0                	mov    %esi,%eax
80101ae6:	83 e0 7f             	and    $0x7f,%eax
  if(panicked){
80101ae9:	83 3d f8 17 11 80 00 	cmpl   $0x0,0x801117f8
              input.buf[input.e++ % INPUT_BUF] = c;
80101af0:	88 98 24 12 11 80    	mov    %bl,-0x7feeeddc(%eax)
  if(panicked){
80101af6:	0f 85 be fd ff ff    	jne    801018ba <consoleintr+0x8fa>
  if(c == BACKSPACE){
80101afc:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
80101b02:	0f 85 17 fe ff ff    	jne    8010191f <consoleintr+0x95f>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80101b08:	83 ec 0c             	sub    $0xc,%esp
80101b0b:	6a 08                	push   $0x8
80101b0d:	e8 9e 5d 00 00       	call   801078b0 <uartputc>
80101b12:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80101b19:	e8 92 5d 00 00       	call   801078b0 <uartputc>
80101b1e:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80101b25:	e8 86 5d 00 00       	call   801078b0 <uartputc>
80101b2a:	83 c4 10             	add    $0x10,%esp
80101b2d:	e9 f9 fd ff ff       	jmp    8010192b <consoleintr+0x96b>
80101b32:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101b39:	00 
80101b3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101b40 <consoleinit>:

void
consoleinit(void)
{
80101b40:	55                   	push   %ebp
80101b41:	89 e5                	mov    %esp,%ebp
80101b43:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80101b46:	68 68 90 10 80       	push   $0x80109068
80101b4b:	68 c0 17 11 80       	push   $0x801117c0
80101b50:	e8 9b 3f 00 00       	call   80105af0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80101b55:	58                   	pop    %eax
80101b56:	5a                   	pop    %edx
80101b57:	6a 00                	push   $0x0
80101b59:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80101b5b:	c7 05 cc 23 11 80 90 	movl   $0x80100690,0x801123cc
80101b62:	06 10 80 
  devsw[CONSOLE].read = consoleread;
80101b65:	c7 05 c8 23 11 80 80 	movl   $0x80100280,0x801123c8
80101b6c:	02 10 80 
  cons.locking = 1;
80101b6f:	c7 05 f4 17 11 80 01 	movl   $0x1,0x801117f4
80101b76:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80101b79:	e8 e2 19 00 00       	call   80103560 <ioapicenable>
}
80101b7e:	83 c4 10             	add    $0x10,%esp
80101b81:	c9                   	leave
80101b82:	c3                   	ret
80101b83:	66 90                	xchg   %ax,%ax
80101b85:	66 90                	xchg   %ax,%ax
80101b87:	66 90                	xchg   %ax,%ax
80101b89:	66 90                	xchg   %ax,%ax
80101b8b:	66 90                	xchg   %ax,%ax
80101b8d:	66 90                	xchg   %ax,%ax
80101b8f:	90                   	nop

80101b90 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80101b90:	55                   	push   %ebp
80101b91:	89 e5                	mov    %esp,%ebp
80101b93:	57                   	push   %edi
80101b94:	56                   	push   %esi
80101b95:	53                   	push   %ebx
80101b96:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80101b9c:	e8 cf 2e 00 00       	call   80104a70 <myproc>
80101ba1:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80101ba7:	e8 94 22 00 00       	call   80103e40 <begin_op>

  if((ip = namei(path)) == 0){
80101bac:	83 ec 0c             	sub    $0xc,%esp
80101baf:	ff 75 08             	push   0x8(%ebp)
80101bb2:	e8 c9 15 00 00       	call   80103180 <namei>
80101bb7:	83 c4 10             	add    $0x10,%esp
80101bba:	85 c0                	test   %eax,%eax
80101bbc:	0f 84 02 03 00 00    	je     80101ec4 <exec+0x334>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80101bc2:	83 ec 0c             	sub    $0xc,%esp
80101bc5:	89 c3                	mov    %eax,%ebx
80101bc7:	50                   	push   %eax
80101bc8:	e8 93 0c 00 00       	call   80102860 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80101bcd:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80101bd3:	6a 34                	push   $0x34
80101bd5:	6a 00                	push   $0x0
80101bd7:	50                   	push   %eax
80101bd8:	53                   	push   %ebx
80101bd9:	e8 92 0f 00 00       	call   80102b70 <readi>
80101bde:	83 c4 20             	add    $0x20,%esp
80101be1:	83 f8 34             	cmp    $0x34,%eax
80101be4:	74 22                	je     80101c08 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80101be6:	83 ec 0c             	sub    $0xc,%esp
80101be9:	53                   	push   %ebx
80101bea:	e8 01 0f 00 00       	call   80102af0 <iunlockput>
    end_op();
80101bef:	e8 bc 22 00 00       	call   80103eb0 <end_op>
80101bf4:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80101bf7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101bfc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101bff:	5b                   	pop    %ebx
80101c00:	5e                   	pop    %esi
80101c01:	5f                   	pop    %edi
80101c02:	5d                   	pop    %ebp
80101c03:	c3                   	ret
80101c04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80101c08:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80101c0f:	45 4c 46 
80101c12:	75 d2                	jne    80101be6 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80101c14:	e8 27 6e 00 00       	call   80108a40 <setupkvm>
80101c19:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80101c1f:	85 c0                	test   %eax,%eax
80101c21:	74 c3                	je     80101be6 <exec+0x56>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101c23:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80101c2a:	00 
80101c2b:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80101c31:	0f 84 ac 02 00 00    	je     80101ee3 <exec+0x353>
  sz = 0;
80101c37:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80101c3e:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101c41:	31 ff                	xor    %edi,%edi
80101c43:	e9 8e 00 00 00       	jmp    80101cd6 <exec+0x146>
80101c48:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101c4f:	00 
    if(ph.type != ELF_PROG_LOAD)
80101c50:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80101c57:	75 6c                	jne    80101cc5 <exec+0x135>
    if(ph.memsz < ph.filesz)
80101c59:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80101c5f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80101c65:	0f 82 87 00 00 00    	jb     80101cf2 <exec+0x162>
    if(ph.vaddr + ph.memsz < ph.vaddr)
80101c6b:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80101c71:	72 7f                	jb     80101cf2 <exec+0x162>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80101c73:	83 ec 04             	sub    $0x4,%esp
80101c76:	50                   	push   %eax
80101c77:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80101c7d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101c83:	e8 d8 6b 00 00       	call   80108860 <allocuvm>
80101c88:	83 c4 10             	add    $0x10,%esp
80101c8b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80101c91:	85 c0                	test   %eax,%eax
80101c93:	74 5d                	je     80101cf2 <exec+0x162>
    if(ph.vaddr % PGSIZE != 0)
80101c95:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80101c9b:	a9 ff 0f 00 00       	test   $0xfff,%eax
80101ca0:	75 50                	jne    80101cf2 <exec+0x162>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80101ca2:	83 ec 0c             	sub    $0xc,%esp
80101ca5:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
80101cab:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
80101cb1:	53                   	push   %ebx
80101cb2:	50                   	push   %eax
80101cb3:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101cb9:	e8 b2 6a 00 00       	call   80108770 <loaduvm>
80101cbe:	83 c4 20             	add    $0x20,%esp
80101cc1:	85 c0                	test   %eax,%eax
80101cc3:	78 2d                	js     80101cf2 <exec+0x162>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101cc5:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80101ccc:	83 c7 01             	add    $0x1,%edi
80101ccf:	83 c6 20             	add    $0x20,%esi
80101cd2:	39 f8                	cmp    %edi,%eax
80101cd4:	7e 3a                	jle    80101d10 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80101cd6:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80101cdc:	6a 20                	push   $0x20
80101cde:	56                   	push   %esi
80101cdf:	50                   	push   %eax
80101ce0:	53                   	push   %ebx
80101ce1:	e8 8a 0e 00 00       	call   80102b70 <readi>
80101ce6:	83 c4 10             	add    $0x10,%esp
80101ce9:	83 f8 20             	cmp    $0x20,%eax
80101cec:	0f 84 5e ff ff ff    	je     80101c50 <exec+0xc0>
    freevm(pgdir);
80101cf2:	83 ec 0c             	sub    $0xc,%esp
80101cf5:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101cfb:	e8 c0 6c 00 00       	call   801089c0 <freevm>
  if(ip){
80101d00:	83 c4 10             	add    $0x10,%esp
80101d03:	e9 de fe ff ff       	jmp    80101be6 <exec+0x56>
80101d08:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101d0f:	00 
  sz = PGROUNDUP(sz);
80101d10:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80101d16:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80101d1c:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80101d22:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80101d28:	83 ec 0c             	sub    $0xc,%esp
80101d2b:	53                   	push   %ebx
80101d2c:	e8 bf 0d 00 00       	call   80102af0 <iunlockput>
  end_op();
80101d31:	e8 7a 21 00 00       	call   80103eb0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80101d36:	83 c4 0c             	add    $0xc,%esp
80101d39:	56                   	push   %esi
80101d3a:	57                   	push   %edi
80101d3b:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80101d41:	57                   	push   %edi
80101d42:	e8 19 6b 00 00       	call   80108860 <allocuvm>
80101d47:	83 c4 10             	add    $0x10,%esp
80101d4a:	89 c6                	mov    %eax,%esi
80101d4c:	85 c0                	test   %eax,%eax
80101d4e:	0f 84 94 00 00 00    	je     80101de8 <exec+0x258>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101d54:	83 ec 08             	sub    $0x8,%esp
80101d57:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
80101d5d:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101d5f:	50                   	push   %eax
80101d60:	57                   	push   %edi
  for(argc = 0; argv[argc]; argc++) {
80101d61:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101d63:	e8 78 6d 00 00       	call   80108ae0 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80101d68:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d6b:	83 c4 10             	add    $0x10,%esp
80101d6e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80101d74:	8b 00                	mov    (%eax),%eax
80101d76:	85 c0                	test   %eax,%eax
80101d78:	0f 84 8b 00 00 00    	je     80101e09 <exec+0x279>
80101d7e:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
80101d84:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80101d8a:	eb 23                	jmp    80101daf <exec+0x21f>
80101d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101d90:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80101d93:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80101d9a:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80101d9d:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80101da3:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80101da6:	85 c0                	test   %eax,%eax
80101da8:	74 59                	je     80101e03 <exec+0x273>
    if(argc >= MAXARG)
80101daa:	83 ff 20             	cmp    $0x20,%edi
80101dad:	74 39                	je     80101de8 <exec+0x258>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80101daf:	83 ec 0c             	sub    $0xc,%esp
80101db2:	50                   	push   %eax
80101db3:	e8 c8 41 00 00       	call   80105f80 <strlen>
80101db8:	f7 d0                	not    %eax
80101dba:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80101dbc:	58                   	pop    %eax
80101dbd:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80101dc0:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80101dc3:	ff 34 b8             	push   (%eax,%edi,4)
80101dc6:	e8 b5 41 00 00       	call   80105f80 <strlen>
80101dcb:	83 c0 01             	add    $0x1,%eax
80101dce:	50                   	push   %eax
80101dcf:	8b 45 0c             	mov    0xc(%ebp),%eax
80101dd2:	ff 34 b8             	push   (%eax,%edi,4)
80101dd5:	53                   	push   %ebx
80101dd6:	56                   	push   %esi
80101dd7:	e8 d4 6e 00 00       	call   80108cb0 <copyout>
80101ddc:	83 c4 20             	add    $0x20,%esp
80101ddf:	85 c0                	test   %eax,%eax
80101de1:	79 ad                	jns    80101d90 <exec+0x200>
80101de3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    freevm(pgdir);
80101de8:	83 ec 0c             	sub    $0xc,%esp
80101deb:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101df1:	e8 ca 6b 00 00       	call   801089c0 <freevm>
80101df6:	83 c4 10             	add    $0x10,%esp
  return -1;
80101df9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101dfe:	e9 f9 fd ff ff       	jmp    80101bfc <exec+0x6c>
80101e03:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80101e09:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80101e10:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80101e12:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80101e19:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80101e1d:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80101e1f:	83 c0 0c             	add    $0xc,%eax
  ustack[1] = argc;
80101e22:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  sp -= (3+argc+1) * 4;
80101e28:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80101e2a:	50                   	push   %eax
80101e2b:	52                   	push   %edx
80101e2c:	53                   	push   %ebx
80101e2d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
  ustack[0] = 0xffffffff;  // fake return PC
80101e33:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80101e3a:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80101e3d:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80101e43:	e8 68 6e 00 00       	call   80108cb0 <copyout>
80101e48:	83 c4 10             	add    $0x10,%esp
80101e4b:	85 c0                	test   %eax,%eax
80101e4d:	78 99                	js     80101de8 <exec+0x258>
  for(last=s=path; *s; s++)
80101e4f:	8b 45 08             	mov    0x8(%ebp),%eax
80101e52:	8b 55 08             	mov    0x8(%ebp),%edx
80101e55:	0f b6 00             	movzbl (%eax),%eax
80101e58:	84 c0                	test   %al,%al
80101e5a:	74 13                	je     80101e6f <exec+0x2df>
80101e5c:	89 d1                	mov    %edx,%ecx
80101e5e:	66 90                	xchg   %ax,%ax
      last = s+1;
80101e60:	83 c1 01             	add    $0x1,%ecx
80101e63:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80101e65:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
80101e68:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
80101e6b:	84 c0                	test   %al,%al
80101e6d:	75 f1                	jne    80101e60 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80101e6f:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80101e75:	83 ec 04             	sub    $0x4,%esp
80101e78:	6a 10                	push   $0x10
80101e7a:	89 f8                	mov    %edi,%eax
80101e7c:	52                   	push   %edx
80101e7d:	83 c0 6c             	add    $0x6c,%eax
80101e80:	50                   	push   %eax
80101e81:	e8 ba 40 00 00       	call   80105f40 <safestrcpy>
  curproc->pgdir = pgdir;
80101e86:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80101e8c:	89 f8                	mov    %edi,%eax
80101e8e:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->sz = sz;
80101e91:	89 30                	mov    %esi,(%eax)
  curproc->pgdir = pgdir;
80101e93:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80101e96:	89 c1                	mov    %eax,%ecx
80101e98:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80101e9e:	8b 40 18             	mov    0x18(%eax),%eax
80101ea1:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80101ea4:	8b 41 18             	mov    0x18(%ecx),%eax
80101ea7:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80101eaa:	89 0c 24             	mov    %ecx,(%esp)
80101ead:	e8 2e 67 00 00       	call   801085e0 <switchuvm>
  freevm(oldpgdir);
80101eb2:	89 3c 24             	mov    %edi,(%esp)
80101eb5:	e8 06 6b 00 00       	call   801089c0 <freevm>
  return 0;
80101eba:	83 c4 10             	add    $0x10,%esp
80101ebd:	31 c0                	xor    %eax,%eax
80101ebf:	e9 38 fd ff ff       	jmp    80101bfc <exec+0x6c>
    end_op();
80101ec4:	e8 e7 1f 00 00       	call   80103eb0 <end_op>
    cprintf("exec: fail\n");
80101ec9:	83 ec 0c             	sub    $0xc,%esp
80101ecc:	68 70 90 10 80       	push   $0x80109070
80101ed1:	e8 fa e8 ff ff       	call   801007d0 <cprintf>
    return -1;
80101ed6:	83 c4 10             	add    $0x10,%esp
80101ed9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ede:	e9 19 fd ff ff       	jmp    80101bfc <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101ee3:	31 ff                	xor    %edi,%edi
80101ee5:	be 00 20 00 00       	mov    $0x2000,%esi
80101eea:	e9 39 fe ff ff       	jmp    80101d28 <exec+0x198>
80101eef:	90                   	nop

80101ef0 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80101ef0:	55                   	push   %ebp
80101ef1:	89 e5                	mov    %esp,%ebp
80101ef3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80101ef6:	68 7c 90 10 80       	push   $0x8010907c
80101efb:	68 20 1a 11 80       	push   $0x80111a20
80101f00:	e8 eb 3b 00 00       	call   80105af0 <initlock>
}
80101f05:	83 c4 10             	add    $0x10,%esp
80101f08:	c9                   	leave
80101f09:	c3                   	ret
80101f0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101f10 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80101f10:	55                   	push   %ebp
80101f11:	89 e5                	mov    %esp,%ebp
80101f13:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101f14:	bb 54 1a 11 80       	mov    $0x80111a54,%ebx
{
80101f19:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80101f1c:	68 20 1a 11 80       	push   $0x80111a20
80101f21:	e8 9a 3d 00 00       	call   80105cc0 <acquire>
80101f26:	83 c4 10             	add    $0x10,%esp
80101f29:	eb 10                	jmp    80101f3b <filealloc+0x2b>
80101f2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101f30:	83 c3 18             	add    $0x18,%ebx
80101f33:	81 fb b4 23 11 80    	cmp    $0x801123b4,%ebx
80101f39:	74 25                	je     80101f60 <filealloc+0x50>
    if(f->ref == 0){
80101f3b:	8b 43 04             	mov    0x4(%ebx),%eax
80101f3e:	85 c0                	test   %eax,%eax
80101f40:	75 ee                	jne    80101f30 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80101f42:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80101f45:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80101f4c:	68 20 1a 11 80       	push   $0x80111a20
80101f51:	e8 0a 3d 00 00       	call   80105c60 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80101f56:	89 d8                	mov    %ebx,%eax
      return f;
80101f58:	83 c4 10             	add    $0x10,%esp
}
80101f5b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101f5e:	c9                   	leave
80101f5f:	c3                   	ret
  release(&ftable.lock);
80101f60:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80101f63:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80101f65:	68 20 1a 11 80       	push   $0x80111a20
80101f6a:	e8 f1 3c 00 00       	call   80105c60 <release>
}
80101f6f:	89 d8                	mov    %ebx,%eax
  return 0;
80101f71:	83 c4 10             	add    $0x10,%esp
}
80101f74:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101f77:	c9                   	leave
80101f78:	c3                   	ret
80101f79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101f80 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80101f80:	55                   	push   %ebp
80101f81:	89 e5                	mov    %esp,%ebp
80101f83:	53                   	push   %ebx
80101f84:	83 ec 10             	sub    $0x10,%esp
80101f87:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80101f8a:	68 20 1a 11 80       	push   $0x80111a20
80101f8f:	e8 2c 3d 00 00       	call   80105cc0 <acquire>
  if(f->ref < 1)
80101f94:	8b 43 04             	mov    0x4(%ebx),%eax
80101f97:	83 c4 10             	add    $0x10,%esp
80101f9a:	85 c0                	test   %eax,%eax
80101f9c:	7e 1a                	jle    80101fb8 <filedup+0x38>
    panic("filedup");
  f->ref++;
80101f9e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80101fa1:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80101fa4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80101fa7:	68 20 1a 11 80       	push   $0x80111a20
80101fac:	e8 af 3c 00 00       	call   80105c60 <release>
  return f;
}
80101fb1:	89 d8                	mov    %ebx,%eax
80101fb3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101fb6:	c9                   	leave
80101fb7:	c3                   	ret
    panic("filedup");
80101fb8:	83 ec 0c             	sub    $0xc,%esp
80101fbb:	68 83 90 10 80       	push   $0x80109083
80101fc0:	e8 0b e5 ff ff       	call   801004d0 <panic>
80101fc5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101fcc:	00 
80101fcd:	8d 76 00             	lea    0x0(%esi),%esi

80101fd0 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101fd0:	55                   	push   %ebp
80101fd1:	89 e5                	mov    %esp,%ebp
80101fd3:	57                   	push   %edi
80101fd4:	56                   	push   %esi
80101fd5:	53                   	push   %ebx
80101fd6:	83 ec 28             	sub    $0x28,%esp
80101fd9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80101fdc:	68 20 1a 11 80       	push   $0x80111a20
80101fe1:	e8 da 3c 00 00       	call   80105cc0 <acquire>
  if(f->ref < 1)
80101fe6:	8b 53 04             	mov    0x4(%ebx),%edx
80101fe9:	83 c4 10             	add    $0x10,%esp
80101fec:	85 d2                	test   %edx,%edx
80101fee:	0f 8e a5 00 00 00    	jle    80102099 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80101ff4:	83 ea 01             	sub    $0x1,%edx
80101ff7:	89 53 04             	mov    %edx,0x4(%ebx)
80101ffa:	75 44                	jne    80102040 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80101ffc:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80102000:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80102003:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80102005:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
8010200b:	8b 73 0c             	mov    0xc(%ebx),%esi
8010200e:	88 45 e7             	mov    %al,-0x19(%ebp)
80102011:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80102014:	68 20 1a 11 80       	push   $0x80111a20
  ff = *f;
80102019:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
8010201c:	e8 3f 3c 00 00       	call   80105c60 <release>

  if(ff.type == FD_PIPE)
80102021:	83 c4 10             	add    $0x10,%esp
80102024:	83 ff 01             	cmp    $0x1,%edi
80102027:	74 57                	je     80102080 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80102029:	83 ff 02             	cmp    $0x2,%edi
8010202c:	74 2a                	je     80102058 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
8010202e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102031:	5b                   	pop    %ebx
80102032:	5e                   	pop    %esi
80102033:	5f                   	pop    %edi
80102034:	5d                   	pop    %ebp
80102035:	c3                   	ret
80102036:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010203d:	00 
8010203e:	66 90                	xchg   %ax,%ax
    release(&ftable.lock);
80102040:	c7 45 08 20 1a 11 80 	movl   $0x80111a20,0x8(%ebp)
}
80102047:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010204a:	5b                   	pop    %ebx
8010204b:	5e                   	pop    %esi
8010204c:	5f                   	pop    %edi
8010204d:	5d                   	pop    %ebp
    release(&ftable.lock);
8010204e:	e9 0d 3c 00 00       	jmp    80105c60 <release>
80102053:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    begin_op();
80102058:	e8 e3 1d 00 00       	call   80103e40 <begin_op>
    iput(ff.ip);
8010205d:	83 ec 0c             	sub    $0xc,%esp
80102060:	ff 75 e0             	push   -0x20(%ebp)
80102063:	e8 28 09 00 00       	call   80102990 <iput>
    end_op();
80102068:	83 c4 10             	add    $0x10,%esp
}
8010206b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010206e:	5b                   	pop    %ebx
8010206f:	5e                   	pop    %esi
80102070:	5f                   	pop    %edi
80102071:	5d                   	pop    %ebp
    end_op();
80102072:	e9 39 1e 00 00       	jmp    80103eb0 <end_op>
80102077:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010207e:	00 
8010207f:	90                   	nop
    pipeclose(ff.pipe, ff.writable);
80102080:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80102084:	83 ec 08             	sub    $0x8,%esp
80102087:	53                   	push   %ebx
80102088:	56                   	push   %esi
80102089:	e8 82 25 00 00       	call   80104610 <pipeclose>
8010208e:	83 c4 10             	add    $0x10,%esp
}
80102091:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102094:	5b                   	pop    %ebx
80102095:	5e                   	pop    %esi
80102096:	5f                   	pop    %edi
80102097:	5d                   	pop    %ebp
80102098:	c3                   	ret
    panic("fileclose");
80102099:	83 ec 0c             	sub    $0xc,%esp
8010209c:	68 8b 90 10 80       	push   $0x8010908b
801020a1:	e8 2a e4 ff ff       	call   801004d0 <panic>
801020a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801020ad:	00 
801020ae:	66 90                	xchg   %ax,%ax

801020b0 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
801020b0:	55                   	push   %ebp
801020b1:	89 e5                	mov    %esp,%ebp
801020b3:	53                   	push   %ebx
801020b4:	83 ec 04             	sub    $0x4,%esp
801020b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
801020ba:	83 3b 02             	cmpl   $0x2,(%ebx)
801020bd:	75 31                	jne    801020f0 <filestat+0x40>
    ilock(f->ip);
801020bf:	83 ec 0c             	sub    $0xc,%esp
801020c2:	ff 73 10             	push   0x10(%ebx)
801020c5:	e8 96 07 00 00       	call   80102860 <ilock>
    stati(f->ip, st);
801020ca:	58                   	pop    %eax
801020cb:	5a                   	pop    %edx
801020cc:	ff 75 0c             	push   0xc(%ebp)
801020cf:	ff 73 10             	push   0x10(%ebx)
801020d2:	e8 69 0a 00 00       	call   80102b40 <stati>
    iunlock(f->ip);
801020d7:	59                   	pop    %ecx
801020d8:	ff 73 10             	push   0x10(%ebx)
801020db:	e8 60 08 00 00       	call   80102940 <iunlock>
    return 0;
  }
  return -1;
}
801020e0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
801020e3:	83 c4 10             	add    $0x10,%esp
801020e6:	31 c0                	xor    %eax,%eax
}
801020e8:	c9                   	leave
801020e9:	c3                   	ret
801020ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801020f0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
801020f3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801020f8:	c9                   	leave
801020f9:	c3                   	ret
801020fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102100 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80102100:	55                   	push   %ebp
80102101:	89 e5                	mov    %esp,%ebp
80102103:	57                   	push   %edi
80102104:	56                   	push   %esi
80102105:	53                   	push   %ebx
80102106:	83 ec 0c             	sub    $0xc,%esp
80102109:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010210c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010210f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80102112:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80102116:	74 60                	je     80102178 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80102118:	8b 03                	mov    (%ebx),%eax
8010211a:	83 f8 01             	cmp    $0x1,%eax
8010211d:	74 41                	je     80102160 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010211f:	83 f8 02             	cmp    $0x2,%eax
80102122:	75 5b                	jne    8010217f <fileread+0x7f>
    ilock(f->ip);
80102124:	83 ec 0c             	sub    $0xc,%esp
80102127:	ff 73 10             	push   0x10(%ebx)
8010212a:	e8 31 07 00 00       	call   80102860 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010212f:	57                   	push   %edi
80102130:	ff 73 14             	push   0x14(%ebx)
80102133:	56                   	push   %esi
80102134:	ff 73 10             	push   0x10(%ebx)
80102137:	e8 34 0a 00 00       	call   80102b70 <readi>
8010213c:	83 c4 20             	add    $0x20,%esp
8010213f:	89 c6                	mov    %eax,%esi
80102141:	85 c0                	test   %eax,%eax
80102143:	7e 03                	jle    80102148 <fileread+0x48>
      f->off += r;
80102145:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80102148:	83 ec 0c             	sub    $0xc,%esp
8010214b:	ff 73 10             	push   0x10(%ebx)
8010214e:	e8 ed 07 00 00       	call   80102940 <iunlock>
    return r;
80102153:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80102156:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102159:	89 f0                	mov    %esi,%eax
8010215b:	5b                   	pop    %ebx
8010215c:	5e                   	pop    %esi
8010215d:	5f                   	pop    %edi
8010215e:	5d                   	pop    %ebp
8010215f:	c3                   	ret
    return piperead(f->pipe, addr, n);
80102160:	8b 43 0c             	mov    0xc(%ebx),%eax
80102163:	89 45 08             	mov    %eax,0x8(%ebp)
}
80102166:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102169:	5b                   	pop    %ebx
8010216a:	5e                   	pop    %esi
8010216b:	5f                   	pop    %edi
8010216c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010216d:	e9 3e 26 00 00       	jmp    801047b0 <piperead>
80102172:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80102178:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010217d:	eb d7                	jmp    80102156 <fileread+0x56>
  panic("fileread");
8010217f:	83 ec 0c             	sub    $0xc,%esp
80102182:	68 95 90 10 80       	push   $0x80109095
80102187:	e8 44 e3 ff ff       	call   801004d0 <panic>
8010218c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102190 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80102190:	55                   	push   %ebp
80102191:	89 e5                	mov    %esp,%ebp
80102193:	57                   	push   %edi
80102194:	56                   	push   %esi
80102195:	53                   	push   %ebx
80102196:	83 ec 1c             	sub    $0x1c,%esp
80102199:	8b 45 0c             	mov    0xc(%ebp),%eax
8010219c:	8b 75 08             	mov    0x8(%ebp),%esi
8010219f:	89 45 dc             	mov    %eax,-0x24(%ebp)
801021a2:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
801021a5:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
801021a9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
801021ac:	0f 84 bd 00 00 00    	je     8010226f <filewrite+0xdf>
    return -1;
  if(f->type == FD_PIPE)
801021b2:	8b 06                	mov    (%esi),%eax
801021b4:	83 f8 01             	cmp    $0x1,%eax
801021b7:	0f 84 bf 00 00 00    	je     8010227c <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
801021bd:	83 f8 02             	cmp    $0x2,%eax
801021c0:	0f 85 c8 00 00 00    	jne    8010228e <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801021c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
801021c9:	31 ff                	xor    %edi,%edi
    while(i < n){
801021cb:	85 c0                	test   %eax,%eax
801021cd:	7f 30                	jg     801021ff <filewrite+0x6f>
801021cf:	e9 94 00 00 00       	jmp    80102268 <filewrite+0xd8>
801021d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
801021d8:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
801021db:	83 ec 0c             	sub    $0xc,%esp
801021de:	ff 76 10             	push   0x10(%esi)
        f->off += r;
801021e1:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
801021e4:	e8 57 07 00 00       	call   80102940 <iunlock>
      end_op();
801021e9:	e8 c2 1c 00 00       	call   80103eb0 <end_op>

      if(r < 0)
        break;
      if(r != n1)
801021ee:	8b 45 e0             	mov    -0x20(%ebp),%eax
801021f1:	83 c4 10             	add    $0x10,%esp
801021f4:	39 c3                	cmp    %eax,%ebx
801021f6:	75 60                	jne    80102258 <filewrite+0xc8>
        panic("short filewrite");
      i += r;
801021f8:	01 df                	add    %ebx,%edi
    while(i < n){
801021fa:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801021fd:	7e 69                	jle    80102268 <filewrite+0xd8>
      int n1 = n - i;
801021ff:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80102202:	b8 00 06 00 00       	mov    $0x600,%eax
80102207:	29 fb                	sub    %edi,%ebx
      if(n1 > max)
80102209:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
8010220f:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
80102212:	e8 29 1c 00 00       	call   80103e40 <begin_op>
      ilock(f->ip);
80102217:	83 ec 0c             	sub    $0xc,%esp
8010221a:	ff 76 10             	push   0x10(%esi)
8010221d:	e8 3e 06 00 00       	call   80102860 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80102222:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102225:	53                   	push   %ebx
80102226:	ff 76 14             	push   0x14(%esi)
80102229:	01 f8                	add    %edi,%eax
8010222b:	50                   	push   %eax
8010222c:	ff 76 10             	push   0x10(%esi)
8010222f:	e8 3c 0a 00 00       	call   80102c70 <writei>
80102234:	83 c4 20             	add    $0x20,%esp
80102237:	85 c0                	test   %eax,%eax
80102239:	7f 9d                	jg     801021d8 <filewrite+0x48>
      iunlock(f->ip);
8010223b:	83 ec 0c             	sub    $0xc,%esp
8010223e:	ff 76 10             	push   0x10(%esi)
80102241:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80102244:	e8 f7 06 00 00       	call   80102940 <iunlock>
      end_op();
80102249:	e8 62 1c 00 00       	call   80103eb0 <end_op>
      if(r < 0)
8010224e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102251:	83 c4 10             	add    $0x10,%esp
80102254:	85 c0                	test   %eax,%eax
80102256:	75 17                	jne    8010226f <filewrite+0xdf>
        panic("short filewrite");
80102258:	83 ec 0c             	sub    $0xc,%esp
8010225b:	68 9e 90 10 80       	push   $0x8010909e
80102260:	e8 6b e2 ff ff       	call   801004d0 <panic>
80102265:	8d 76 00             	lea    0x0(%esi),%esi
    }
    return i == n ? n : -1;
80102268:	89 f8                	mov    %edi,%eax
8010226a:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
8010226d:	74 05                	je     80102274 <filewrite+0xe4>
8010226f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
80102274:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102277:	5b                   	pop    %ebx
80102278:	5e                   	pop    %esi
80102279:	5f                   	pop    %edi
8010227a:	5d                   	pop    %ebp
8010227b:	c3                   	ret
    return pipewrite(f->pipe, addr, n);
8010227c:	8b 46 0c             	mov    0xc(%esi),%eax
8010227f:	89 45 08             	mov    %eax,0x8(%ebp)
}
80102282:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102285:	5b                   	pop    %ebx
80102286:	5e                   	pop    %esi
80102287:	5f                   	pop    %edi
80102288:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80102289:	e9 22 24 00 00       	jmp    801046b0 <pipewrite>
  panic("filewrite");
8010228e:	83 ec 0c             	sub    $0xc,%esp
80102291:	68 a4 90 10 80       	push   $0x801090a4
80102296:	e8 35 e2 ff ff       	call   801004d0 <panic>
8010229b:	66 90                	xchg   %ax,%ax
8010229d:	66 90                	xchg   %ax,%ax
8010229f:	90                   	nop

801022a0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
801022a0:	55                   	push   %ebp
801022a1:	89 c1                	mov    %eax,%ecx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
801022a3:	89 d0                	mov    %edx,%eax
801022a5:	c1 e8 0c             	shr    $0xc,%eax
801022a8:	03 05 8c 40 11 80    	add    0x8011408c,%eax
{
801022ae:	89 e5                	mov    %esp,%ebp
801022b0:	56                   	push   %esi
801022b1:	53                   	push   %ebx
801022b2:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
801022b4:	83 ec 08             	sub    $0x8,%esp
801022b7:	50                   	push   %eax
801022b8:	51                   	push   %ecx
801022b9:	e8 12 de ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
801022be:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
801022c0:	c1 fb 03             	sar    $0x3,%ebx
801022c3:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
801022c6:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
801022c8:	83 e1 07             	and    $0x7,%ecx
801022cb:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
801022d0:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  m = 1 << (bi % 8);
801022d6:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
801022d8:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
801022dd:	85 c1                	test   %eax,%ecx
801022df:	74 23                	je     80102304 <bfree+0x64>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
801022e1:	f7 d0                	not    %eax
  log_write(bp);
801022e3:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
801022e6:	21 c8                	and    %ecx,%eax
801022e8:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
801022ec:	56                   	push   %esi
801022ed:	e8 2e 1d 00 00       	call   80104020 <log_write>
  brelse(bp);
801022f2:	89 34 24             	mov    %esi,(%esp)
801022f5:	e8 f6 de ff ff       	call   801001f0 <brelse>
}
801022fa:	83 c4 10             	add    $0x10,%esp
801022fd:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102300:	5b                   	pop    %ebx
80102301:	5e                   	pop    %esi
80102302:	5d                   	pop    %ebp
80102303:	c3                   	ret
    panic("freeing free block");
80102304:	83 ec 0c             	sub    $0xc,%esp
80102307:	68 ae 90 10 80       	push   $0x801090ae
8010230c:	e8 bf e1 ff ff       	call   801004d0 <panic>
80102311:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102318:	00 
80102319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102320 <balloc>:
{
80102320:	55                   	push   %ebp
80102321:	89 e5                	mov    %esp,%ebp
80102323:	57                   	push   %edi
80102324:	56                   	push   %esi
80102325:	53                   	push   %ebx
80102326:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
80102329:	8b 0d 74 40 11 80    	mov    0x80114074,%ecx
{
8010232f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80102332:	85 c9                	test   %ecx,%ecx
80102334:	0f 84 87 00 00 00    	je     801023c1 <balloc+0xa1>
8010233a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80102341:	8b 75 dc             	mov    -0x24(%ebp),%esi
80102344:	83 ec 08             	sub    $0x8,%esp
80102347:	89 f0                	mov    %esi,%eax
80102349:	c1 f8 0c             	sar    $0xc,%eax
8010234c:	03 05 8c 40 11 80    	add    0x8011408c,%eax
80102352:	50                   	push   %eax
80102353:	ff 75 d8             	push   -0x28(%ebp)
80102356:	e8 75 dd ff ff       	call   801000d0 <bread>
8010235b:	83 c4 10             	add    $0x10,%esp
8010235e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80102361:	a1 74 40 11 80       	mov    0x80114074,%eax
80102366:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102369:	31 c0                	xor    %eax,%eax
8010236b:	eb 2f                	jmp    8010239c <balloc+0x7c>
8010236d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80102370:	89 c1                	mov    %eax,%ecx
80102372:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80102377:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
8010237a:	83 e1 07             	and    $0x7,%ecx
8010237d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010237f:	89 c1                	mov    %eax,%ecx
80102381:	c1 f9 03             	sar    $0x3,%ecx
80102384:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80102389:	89 fa                	mov    %edi,%edx
8010238b:	85 df                	test   %ebx,%edi
8010238d:	74 41                	je     801023d0 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010238f:	83 c0 01             	add    $0x1,%eax
80102392:	83 c6 01             	add    $0x1,%esi
80102395:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010239a:	74 05                	je     801023a1 <balloc+0x81>
8010239c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010239f:	77 cf                	ja     80102370 <balloc+0x50>
    brelse(bp);
801023a1:	83 ec 0c             	sub    $0xc,%esp
801023a4:	ff 75 e4             	push   -0x1c(%ebp)
801023a7:	e8 44 de ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
801023ac:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801023b3:	83 c4 10             	add    $0x10,%esp
801023b6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801023b9:	39 05 74 40 11 80    	cmp    %eax,0x80114074
801023bf:	77 80                	ja     80102341 <balloc+0x21>
  panic("balloc: out of blocks");
801023c1:	83 ec 0c             	sub    $0xc,%esp
801023c4:	68 c1 90 10 80       	push   $0x801090c1
801023c9:	e8 02 e1 ff ff       	call   801004d0 <panic>
801023ce:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
801023d0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801023d3:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
801023d6:	09 da                	or     %ebx,%edx
801023d8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801023dc:	57                   	push   %edi
801023dd:	e8 3e 1c 00 00       	call   80104020 <log_write>
        brelse(bp);
801023e2:	89 3c 24             	mov    %edi,(%esp)
801023e5:	e8 06 de ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
801023ea:	58                   	pop    %eax
801023eb:	5a                   	pop    %edx
801023ec:	56                   	push   %esi
801023ed:	ff 75 d8             	push   -0x28(%ebp)
801023f0:	e8 db dc ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
801023f5:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
801023f8:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801023fa:	8d 40 5c             	lea    0x5c(%eax),%eax
801023fd:	68 00 02 00 00       	push   $0x200
80102402:	6a 00                	push   $0x0
80102404:	50                   	push   %eax
80102405:	e8 76 39 00 00       	call   80105d80 <memset>
  log_write(bp);
8010240a:	89 1c 24             	mov    %ebx,(%esp)
8010240d:	e8 0e 1c 00 00       	call   80104020 <log_write>
  brelse(bp);
80102412:	89 1c 24             	mov    %ebx,(%esp)
80102415:	e8 d6 dd ff ff       	call   801001f0 <brelse>
}
8010241a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010241d:	89 f0                	mov    %esi,%eax
8010241f:	5b                   	pop    %ebx
80102420:	5e                   	pop    %esi
80102421:	5f                   	pop    %edi
80102422:	5d                   	pop    %ebp
80102423:	c3                   	ret
80102424:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010242b:	00 
8010242c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102430 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80102430:	55                   	push   %ebp
80102431:	89 e5                	mov    %esp,%ebp
80102433:	57                   	push   %edi
80102434:	89 c7                	mov    %eax,%edi
80102436:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80102437:	31 f6                	xor    %esi,%esi
{
80102439:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010243a:	bb 54 24 11 80       	mov    $0x80112454,%ebx
{
8010243f:	83 ec 28             	sub    $0x28,%esp
80102442:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80102445:	68 20 24 11 80       	push   $0x80112420
8010244a:	e8 71 38 00 00       	call   80105cc0 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010244f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
80102452:	83 c4 10             	add    $0x10,%esp
80102455:	eb 1b                	jmp    80102472 <iget+0x42>
80102457:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010245e:	00 
8010245f:	90                   	nop
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80102460:	39 3b                	cmp    %edi,(%ebx)
80102462:	74 6c                	je     801024d0 <iget+0xa0>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80102464:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010246a:	81 fb 74 40 11 80    	cmp    $0x80114074,%ebx
80102470:	73 26                	jae    80102498 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80102472:	8b 43 08             	mov    0x8(%ebx),%eax
80102475:	85 c0                	test   %eax,%eax
80102477:	7f e7                	jg     80102460 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80102479:	85 f6                	test   %esi,%esi
8010247b:	75 e7                	jne    80102464 <iget+0x34>
8010247d:	85 c0                	test   %eax,%eax
8010247f:	75 76                	jne    801024f7 <iget+0xc7>
80102481:	89 de                	mov    %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80102483:	81 c3 90 00 00 00    	add    $0x90,%ebx
80102489:	81 fb 74 40 11 80    	cmp    $0x80114074,%ebx
8010248f:	72 e1                	jb     80102472 <iget+0x42>
80102491:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80102498:	85 f6                	test   %esi,%esi
8010249a:	74 79                	je     80102515 <iget+0xe5>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
8010249c:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
8010249f:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
801024a1:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
801024a4:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
801024ab:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801024b2:	68 20 24 11 80       	push   $0x80112420
801024b7:	e8 a4 37 00 00       	call   80105c60 <release>

  return ip;
801024bc:	83 c4 10             	add    $0x10,%esp
}
801024bf:	8d 65 f4             	lea    -0xc(%ebp),%esp
801024c2:	89 f0                	mov    %esi,%eax
801024c4:	5b                   	pop    %ebx
801024c5:	5e                   	pop    %esi
801024c6:	5f                   	pop    %edi
801024c7:	5d                   	pop    %ebp
801024c8:	c3                   	ret
801024c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801024d0:	39 53 04             	cmp    %edx,0x4(%ebx)
801024d3:	75 8f                	jne    80102464 <iget+0x34>
      release(&icache.lock);
801024d5:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
801024d8:	83 c0 01             	add    $0x1,%eax
      return ip;
801024db:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
801024dd:	68 20 24 11 80       	push   $0x80112420
      ip->ref++;
801024e2:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
801024e5:	e8 76 37 00 00       	call   80105c60 <release>
      return ip;
801024ea:	83 c4 10             	add    $0x10,%esp
}
801024ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
801024f0:	89 f0                	mov    %esi,%eax
801024f2:	5b                   	pop    %ebx
801024f3:	5e                   	pop    %esi
801024f4:	5f                   	pop    %edi
801024f5:	5d                   	pop    %ebp
801024f6:	c3                   	ret
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801024f7:	81 c3 90 00 00 00    	add    $0x90,%ebx
801024fd:	81 fb 74 40 11 80    	cmp    $0x80114074,%ebx
80102503:	73 10                	jae    80102515 <iget+0xe5>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80102505:	8b 43 08             	mov    0x8(%ebx),%eax
80102508:	85 c0                	test   %eax,%eax
8010250a:	0f 8f 50 ff ff ff    	jg     80102460 <iget+0x30>
80102510:	e9 68 ff ff ff       	jmp    8010247d <iget+0x4d>
    panic("iget: no inodes");
80102515:	83 ec 0c             	sub    $0xc,%esp
80102518:	68 d7 90 10 80       	push   $0x801090d7
8010251d:	e8 ae df ff ff       	call   801004d0 <panic>
80102522:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102529:	00 
8010252a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102530 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80102530:	55                   	push   %ebp
80102531:	89 e5                	mov    %esp,%ebp
80102533:	57                   	push   %edi
80102534:	56                   	push   %esi
80102535:	89 c6                	mov    %eax,%esi
80102537:	53                   	push   %ebx
80102538:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010253b:	83 fa 0b             	cmp    $0xb,%edx
8010253e:	0f 86 8c 00 00 00    	jbe    801025d0 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80102544:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80102547:	83 fb 7f             	cmp    $0x7f,%ebx
8010254a:	0f 87 a2 00 00 00    	ja     801025f2 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80102550:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80102556:	85 c0                	test   %eax,%eax
80102558:	74 5e                	je     801025b8 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010255a:	83 ec 08             	sub    $0x8,%esp
8010255d:	50                   	push   %eax
8010255e:	ff 36                	push   (%esi)
80102560:	e8 6b db ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80102565:	83 c4 10             	add    $0x10,%esp
80102568:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
8010256c:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
8010256e:	8b 3b                	mov    (%ebx),%edi
80102570:	85 ff                	test   %edi,%edi
80102572:	74 1c                	je     80102590 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80102574:	83 ec 0c             	sub    $0xc,%esp
80102577:	52                   	push   %edx
80102578:	e8 73 dc ff ff       	call   801001f0 <brelse>
8010257d:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
80102580:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102583:	89 f8                	mov    %edi,%eax
80102585:	5b                   	pop    %ebx
80102586:	5e                   	pop    %esi
80102587:	5f                   	pop    %edi
80102588:	5d                   	pop    %ebp
80102589:	c3                   	ret
8010258a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102590:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
80102593:	8b 06                	mov    (%esi),%eax
80102595:	e8 86 fd ff ff       	call   80102320 <balloc>
      log_write(bp);
8010259a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010259d:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
801025a0:	89 03                	mov    %eax,(%ebx)
801025a2:	89 c7                	mov    %eax,%edi
      log_write(bp);
801025a4:	52                   	push   %edx
801025a5:	e8 76 1a 00 00       	call   80104020 <log_write>
801025aa:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801025ad:	83 c4 10             	add    $0x10,%esp
801025b0:	eb c2                	jmp    80102574 <bmap+0x44>
801025b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801025b8:	8b 06                	mov    (%esi),%eax
801025ba:	e8 61 fd ff ff       	call   80102320 <balloc>
801025bf:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801025c5:	eb 93                	jmp    8010255a <bmap+0x2a>
801025c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801025ce:	00 
801025cf:	90                   	nop
    if((addr = ip->addrs[bn]) == 0)
801025d0:	8d 5a 14             	lea    0x14(%edx),%ebx
801025d3:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
801025d7:	85 ff                	test   %edi,%edi
801025d9:	75 a5                	jne    80102580 <bmap+0x50>
      ip->addrs[bn] = addr = balloc(ip->dev);
801025db:	8b 00                	mov    (%eax),%eax
801025dd:	e8 3e fd ff ff       	call   80102320 <balloc>
801025e2:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
801025e6:	89 c7                	mov    %eax,%edi
}
801025e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801025eb:	5b                   	pop    %ebx
801025ec:	89 f8                	mov    %edi,%eax
801025ee:	5e                   	pop    %esi
801025ef:	5f                   	pop    %edi
801025f0:	5d                   	pop    %ebp
801025f1:	c3                   	ret
  panic("bmap: out of range");
801025f2:	83 ec 0c             	sub    $0xc,%esp
801025f5:	68 e7 90 10 80       	push   $0x801090e7
801025fa:	e8 d1 de ff ff       	call   801004d0 <panic>
801025ff:	90                   	nop

80102600 <readsb>:
{
80102600:	55                   	push   %ebp
80102601:	89 e5                	mov    %esp,%ebp
80102603:	56                   	push   %esi
80102604:	53                   	push   %ebx
80102605:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80102608:	83 ec 08             	sub    $0x8,%esp
8010260b:	6a 01                	push   $0x1
8010260d:	ff 75 08             	push   0x8(%ebp)
80102610:	e8 bb da ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80102615:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80102618:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010261a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010261d:	6a 1c                	push   $0x1c
8010261f:	50                   	push   %eax
80102620:	56                   	push   %esi
80102621:	e8 fa 37 00 00       	call   80105e20 <memmove>
  brelse(bp);
80102626:	89 5d 08             	mov    %ebx,0x8(%ebp)
80102629:	83 c4 10             	add    $0x10,%esp
}
8010262c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010262f:	5b                   	pop    %ebx
80102630:	5e                   	pop    %esi
80102631:	5d                   	pop    %ebp
  brelse(bp);
80102632:	e9 b9 db ff ff       	jmp    801001f0 <brelse>
80102637:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010263e:	00 
8010263f:	90                   	nop

80102640 <iinit>:
{
80102640:	55                   	push   %ebp
80102641:	89 e5                	mov    %esp,%ebp
80102643:	53                   	push   %ebx
80102644:	bb 60 24 11 80       	mov    $0x80112460,%ebx
80102649:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010264c:	68 fa 90 10 80       	push   $0x801090fa
80102651:	68 20 24 11 80       	push   $0x80112420
80102656:	e8 95 34 00 00       	call   80105af0 <initlock>
  for(i = 0; i < NINODE; i++) {
8010265b:	83 c4 10             	add    $0x10,%esp
8010265e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80102660:	83 ec 08             	sub    $0x8,%esp
80102663:	68 01 91 10 80       	push   $0x80109101
80102668:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
80102669:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
8010266f:	e8 4c 33 00 00       	call   801059c0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80102674:	83 c4 10             	add    $0x10,%esp
80102677:	81 fb 80 40 11 80    	cmp    $0x80114080,%ebx
8010267d:	75 e1                	jne    80102660 <iinit+0x20>
  bp = bread(dev, 1);
8010267f:	83 ec 08             	sub    $0x8,%esp
80102682:	6a 01                	push   $0x1
80102684:	ff 75 08             	push   0x8(%ebp)
80102687:	e8 44 da ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
8010268c:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
8010268f:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80102691:	8d 40 5c             	lea    0x5c(%eax),%eax
80102694:	6a 1c                	push   $0x1c
80102696:	50                   	push   %eax
80102697:	68 74 40 11 80       	push   $0x80114074
8010269c:	e8 7f 37 00 00       	call   80105e20 <memmove>
  brelse(bp);
801026a1:	89 1c 24             	mov    %ebx,(%esp)
801026a4:	e8 47 db ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801026a9:	ff 35 8c 40 11 80    	push   0x8011408c
801026af:	ff 35 88 40 11 80    	push   0x80114088
801026b5:	ff 35 84 40 11 80    	push   0x80114084
801026bb:	ff 35 80 40 11 80    	push   0x80114080
801026c1:	ff 35 7c 40 11 80    	push   0x8011407c
801026c7:	ff 35 78 40 11 80    	push   0x80114078
801026cd:	ff 35 74 40 11 80    	push   0x80114074
801026d3:	68 d8 95 10 80       	push   $0x801095d8
801026d8:	e8 f3 e0 ff ff       	call   801007d0 <cprintf>
}
801026dd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801026e0:	83 c4 30             	add    $0x30,%esp
801026e3:	c9                   	leave
801026e4:	c3                   	ret
801026e5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801026ec:	00 
801026ed:	8d 76 00             	lea    0x0(%esi),%esi

801026f0 <ialloc>:
{
801026f0:	55                   	push   %ebp
801026f1:	89 e5                	mov    %esp,%ebp
801026f3:	57                   	push   %edi
801026f4:	56                   	push   %esi
801026f5:	53                   	push   %ebx
801026f6:	83 ec 1c             	sub    $0x1c,%esp
801026f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
801026fc:	83 3d 7c 40 11 80 01 	cmpl   $0x1,0x8011407c
{
80102703:	8b 75 08             	mov    0x8(%ebp),%esi
80102706:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80102709:	0f 86 91 00 00 00    	jbe    801027a0 <ialloc+0xb0>
8010270f:	bf 01 00 00 00       	mov    $0x1,%edi
80102714:	eb 21                	jmp    80102737 <ialloc+0x47>
80102716:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010271d:	00 
8010271e:	66 90                	xchg   %ax,%ax
    brelse(bp);
80102720:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80102723:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80102726:	53                   	push   %ebx
80102727:	e8 c4 da ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010272c:	83 c4 10             	add    $0x10,%esp
8010272f:	3b 3d 7c 40 11 80    	cmp    0x8011407c,%edi
80102735:	73 69                	jae    801027a0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80102737:	89 f8                	mov    %edi,%eax
80102739:	83 ec 08             	sub    $0x8,%esp
8010273c:	c1 e8 03             	shr    $0x3,%eax
8010273f:	03 05 88 40 11 80    	add    0x80114088,%eax
80102745:	50                   	push   %eax
80102746:	56                   	push   %esi
80102747:	e8 84 d9 ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
8010274c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
8010274f:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
80102751:	89 f8                	mov    %edi,%eax
80102753:	83 e0 07             	and    $0x7,%eax
80102756:	c1 e0 06             	shl    $0x6,%eax
80102759:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010275d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80102761:	75 bd                	jne    80102720 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80102763:	83 ec 04             	sub    $0x4,%esp
80102766:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80102769:	6a 40                	push   $0x40
8010276b:	6a 00                	push   $0x0
8010276d:	51                   	push   %ecx
8010276e:	e8 0d 36 00 00       	call   80105d80 <memset>
      dip->type = type;
80102773:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80102777:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010277a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010277d:	89 1c 24             	mov    %ebx,(%esp)
80102780:	e8 9b 18 00 00       	call   80104020 <log_write>
      brelse(bp);
80102785:	89 1c 24             	mov    %ebx,(%esp)
80102788:	e8 63 da ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
8010278d:	83 c4 10             	add    $0x10,%esp
}
80102790:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80102793:	89 fa                	mov    %edi,%edx
}
80102795:	5b                   	pop    %ebx
      return iget(dev, inum);
80102796:	89 f0                	mov    %esi,%eax
}
80102798:	5e                   	pop    %esi
80102799:	5f                   	pop    %edi
8010279a:	5d                   	pop    %ebp
      return iget(dev, inum);
8010279b:	e9 90 fc ff ff       	jmp    80102430 <iget>
  panic("ialloc: no inodes");
801027a0:	83 ec 0c             	sub    $0xc,%esp
801027a3:	68 07 91 10 80       	push   $0x80109107
801027a8:	e8 23 dd ff ff       	call   801004d0 <panic>
801027ad:	8d 76 00             	lea    0x0(%esi),%esi

801027b0 <iupdate>:
{
801027b0:	55                   	push   %ebp
801027b1:	89 e5                	mov    %esp,%ebp
801027b3:	56                   	push   %esi
801027b4:	53                   	push   %ebx
801027b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801027b8:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801027bb:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801027be:	83 ec 08             	sub    $0x8,%esp
801027c1:	c1 e8 03             	shr    $0x3,%eax
801027c4:	03 05 88 40 11 80    	add    0x80114088,%eax
801027ca:	50                   	push   %eax
801027cb:	ff 73 a4             	push   -0x5c(%ebx)
801027ce:	e8 fd d8 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
801027d3:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801027d7:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801027da:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801027dc:	8b 43 a8             	mov    -0x58(%ebx),%eax
801027df:	83 e0 07             	and    $0x7,%eax
801027e2:	c1 e0 06             	shl    $0x6,%eax
801027e5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
801027e9:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801027ec:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801027f0:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
801027f3:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
801027f7:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
801027fb:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
801027ff:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80102803:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80102807:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010280a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010280d:	6a 34                	push   $0x34
8010280f:	53                   	push   %ebx
80102810:	50                   	push   %eax
80102811:	e8 0a 36 00 00       	call   80105e20 <memmove>
  log_write(bp);
80102816:	89 34 24             	mov    %esi,(%esp)
80102819:	e8 02 18 00 00       	call   80104020 <log_write>
  brelse(bp);
8010281e:	89 75 08             	mov    %esi,0x8(%ebp)
80102821:	83 c4 10             	add    $0x10,%esp
}
80102824:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102827:	5b                   	pop    %ebx
80102828:	5e                   	pop    %esi
80102829:	5d                   	pop    %ebp
  brelse(bp);
8010282a:	e9 c1 d9 ff ff       	jmp    801001f0 <brelse>
8010282f:	90                   	nop

80102830 <idup>:
{
80102830:	55                   	push   %ebp
80102831:	89 e5                	mov    %esp,%ebp
80102833:	53                   	push   %ebx
80102834:	83 ec 10             	sub    $0x10,%esp
80102837:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010283a:	68 20 24 11 80       	push   $0x80112420
8010283f:	e8 7c 34 00 00       	call   80105cc0 <acquire>
  ip->ref++;
80102844:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80102848:	c7 04 24 20 24 11 80 	movl   $0x80112420,(%esp)
8010284f:	e8 0c 34 00 00       	call   80105c60 <release>
}
80102854:	89 d8                	mov    %ebx,%eax
80102856:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102859:	c9                   	leave
8010285a:	c3                   	ret
8010285b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102860 <ilock>:
{
80102860:	55                   	push   %ebp
80102861:	89 e5                	mov    %esp,%ebp
80102863:	56                   	push   %esi
80102864:	53                   	push   %ebx
80102865:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80102868:	85 db                	test   %ebx,%ebx
8010286a:	0f 84 b7 00 00 00    	je     80102927 <ilock+0xc7>
80102870:	8b 53 08             	mov    0x8(%ebx),%edx
80102873:	85 d2                	test   %edx,%edx
80102875:	0f 8e ac 00 00 00    	jle    80102927 <ilock+0xc7>
  acquiresleep(&ip->lock);
8010287b:	83 ec 0c             	sub    $0xc,%esp
8010287e:	8d 43 0c             	lea    0xc(%ebx),%eax
80102881:	50                   	push   %eax
80102882:	e8 79 31 00 00       	call   80105a00 <acquiresleep>
  if(ip->valid == 0){
80102887:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010288a:	83 c4 10             	add    $0x10,%esp
8010288d:	85 c0                	test   %eax,%eax
8010288f:	74 0f                	je     801028a0 <ilock+0x40>
}
80102891:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102894:	5b                   	pop    %ebx
80102895:	5e                   	pop    %esi
80102896:	5d                   	pop    %ebp
80102897:	c3                   	ret
80102898:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010289f:	00 
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801028a0:	8b 43 04             	mov    0x4(%ebx),%eax
801028a3:	83 ec 08             	sub    $0x8,%esp
801028a6:	c1 e8 03             	shr    $0x3,%eax
801028a9:	03 05 88 40 11 80    	add    0x80114088,%eax
801028af:	50                   	push   %eax
801028b0:	ff 33                	push   (%ebx)
801028b2:	e8 19 d8 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801028b7:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801028ba:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801028bc:	8b 43 04             	mov    0x4(%ebx),%eax
801028bf:	83 e0 07             	and    $0x7,%eax
801028c2:	c1 e0 06             	shl    $0x6,%eax
801028c5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801028c9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801028cc:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801028cf:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801028d3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801028d7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801028db:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801028df:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
801028e3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
801028e7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
801028eb:	8b 50 fc             	mov    -0x4(%eax),%edx
801028ee:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801028f1:	6a 34                	push   $0x34
801028f3:	50                   	push   %eax
801028f4:	8d 43 5c             	lea    0x5c(%ebx),%eax
801028f7:	50                   	push   %eax
801028f8:	e8 23 35 00 00       	call   80105e20 <memmove>
    brelse(bp);
801028fd:	89 34 24             	mov    %esi,(%esp)
80102900:	e8 eb d8 ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80102905:	83 c4 10             	add    $0x10,%esp
80102908:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010290d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80102914:	0f 85 77 ff ff ff    	jne    80102891 <ilock+0x31>
      panic("ilock: no type");
8010291a:	83 ec 0c             	sub    $0xc,%esp
8010291d:	68 1f 91 10 80       	push   $0x8010911f
80102922:	e8 a9 db ff ff       	call   801004d0 <panic>
    panic("ilock");
80102927:	83 ec 0c             	sub    $0xc,%esp
8010292a:	68 19 91 10 80       	push   $0x80109119
8010292f:	e8 9c db ff ff       	call   801004d0 <panic>
80102934:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010293b:	00 
8010293c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102940 <iunlock>:
{
80102940:	55                   	push   %ebp
80102941:	89 e5                	mov    %esp,%ebp
80102943:	56                   	push   %esi
80102944:	53                   	push   %ebx
80102945:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102948:	85 db                	test   %ebx,%ebx
8010294a:	74 28                	je     80102974 <iunlock+0x34>
8010294c:	83 ec 0c             	sub    $0xc,%esp
8010294f:	8d 73 0c             	lea    0xc(%ebx),%esi
80102952:	56                   	push   %esi
80102953:	e8 48 31 00 00       	call   80105aa0 <holdingsleep>
80102958:	83 c4 10             	add    $0x10,%esp
8010295b:	85 c0                	test   %eax,%eax
8010295d:	74 15                	je     80102974 <iunlock+0x34>
8010295f:	8b 43 08             	mov    0x8(%ebx),%eax
80102962:	85 c0                	test   %eax,%eax
80102964:	7e 0e                	jle    80102974 <iunlock+0x34>
  releasesleep(&ip->lock);
80102966:	89 75 08             	mov    %esi,0x8(%ebp)
}
80102969:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010296c:	5b                   	pop    %ebx
8010296d:	5e                   	pop    %esi
8010296e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010296f:	e9 ec 30 00 00       	jmp    80105a60 <releasesleep>
    panic("iunlock");
80102974:	83 ec 0c             	sub    $0xc,%esp
80102977:	68 2e 91 10 80       	push   $0x8010912e
8010297c:	e8 4f db ff ff       	call   801004d0 <panic>
80102981:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102988:	00 
80102989:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102990 <iput>:
{
80102990:	55                   	push   %ebp
80102991:	89 e5                	mov    %esp,%ebp
80102993:	57                   	push   %edi
80102994:	56                   	push   %esi
80102995:	53                   	push   %ebx
80102996:	83 ec 28             	sub    $0x28,%esp
80102999:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
8010299c:	8d 7b 0c             	lea    0xc(%ebx),%edi
8010299f:	57                   	push   %edi
801029a0:	e8 5b 30 00 00       	call   80105a00 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801029a5:	8b 53 4c             	mov    0x4c(%ebx),%edx
801029a8:	83 c4 10             	add    $0x10,%esp
801029ab:	85 d2                	test   %edx,%edx
801029ad:	74 07                	je     801029b6 <iput+0x26>
801029af:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801029b4:	74 32                	je     801029e8 <iput+0x58>
  releasesleep(&ip->lock);
801029b6:	83 ec 0c             	sub    $0xc,%esp
801029b9:	57                   	push   %edi
801029ba:	e8 a1 30 00 00       	call   80105a60 <releasesleep>
  acquire(&icache.lock);
801029bf:	c7 04 24 20 24 11 80 	movl   $0x80112420,(%esp)
801029c6:	e8 f5 32 00 00       	call   80105cc0 <acquire>
  ip->ref--;
801029cb:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
801029cf:	83 c4 10             	add    $0x10,%esp
801029d2:	c7 45 08 20 24 11 80 	movl   $0x80112420,0x8(%ebp)
}
801029d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801029dc:	5b                   	pop    %ebx
801029dd:	5e                   	pop    %esi
801029de:	5f                   	pop    %edi
801029df:	5d                   	pop    %ebp
  release(&icache.lock);
801029e0:	e9 7b 32 00 00       	jmp    80105c60 <release>
801029e5:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
801029e8:	83 ec 0c             	sub    $0xc,%esp
801029eb:	68 20 24 11 80       	push   $0x80112420
801029f0:	e8 cb 32 00 00       	call   80105cc0 <acquire>
    int r = ip->ref;
801029f5:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
801029f8:	c7 04 24 20 24 11 80 	movl   $0x80112420,(%esp)
801029ff:	e8 5c 32 00 00       	call   80105c60 <release>
    if(r == 1){
80102a04:	83 c4 10             	add    $0x10,%esp
80102a07:	83 fe 01             	cmp    $0x1,%esi
80102a0a:	75 aa                	jne    801029b6 <iput+0x26>
80102a0c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80102a12:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80102a15:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102a18:	89 cf                	mov    %ecx,%edi
80102a1a:	eb 0b                	jmp    80102a27 <iput+0x97>
80102a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80102a20:	83 c6 04             	add    $0x4,%esi
80102a23:	39 fe                	cmp    %edi,%esi
80102a25:	74 19                	je     80102a40 <iput+0xb0>
    if(ip->addrs[i]){
80102a27:	8b 16                	mov    (%esi),%edx
80102a29:	85 d2                	test   %edx,%edx
80102a2b:	74 f3                	je     80102a20 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
80102a2d:	8b 03                	mov    (%ebx),%eax
80102a2f:	e8 6c f8 ff ff       	call   801022a0 <bfree>
      ip->addrs[i] = 0;
80102a34:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80102a3a:	eb e4                	jmp    80102a20 <iput+0x90>
80102a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80102a40:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80102a46:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80102a49:	85 c0                	test   %eax,%eax
80102a4b:	75 2d                	jne    80102a7a <iput+0xea>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80102a4d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80102a50:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80102a57:	53                   	push   %ebx
80102a58:	e8 53 fd ff ff       	call   801027b0 <iupdate>
      ip->type = 0;
80102a5d:	31 c0                	xor    %eax,%eax
80102a5f:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80102a63:	89 1c 24             	mov    %ebx,(%esp)
80102a66:	e8 45 fd ff ff       	call   801027b0 <iupdate>
      ip->valid = 0;
80102a6b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80102a72:	83 c4 10             	add    $0x10,%esp
80102a75:	e9 3c ff ff ff       	jmp    801029b6 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80102a7a:	83 ec 08             	sub    $0x8,%esp
80102a7d:	50                   	push   %eax
80102a7e:	ff 33                	push   (%ebx)
80102a80:	e8 4b d6 ff ff       	call   801000d0 <bread>
80102a85:	89 7d e0             	mov    %edi,-0x20(%ebp)
80102a88:	83 c4 10             	add    $0x10,%esp
80102a8b:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80102a91:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80102a94:	8d 70 5c             	lea    0x5c(%eax),%esi
80102a97:	89 cf                	mov    %ecx,%edi
80102a99:	eb 0c                	jmp    80102aa7 <iput+0x117>
80102a9b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80102aa0:	83 c6 04             	add    $0x4,%esi
80102aa3:	39 f7                	cmp    %esi,%edi
80102aa5:	74 0f                	je     80102ab6 <iput+0x126>
      if(a[j])
80102aa7:	8b 16                	mov    (%esi),%edx
80102aa9:	85 d2                	test   %edx,%edx
80102aab:	74 f3                	je     80102aa0 <iput+0x110>
        bfree(ip->dev, a[j]);
80102aad:	8b 03                	mov    (%ebx),%eax
80102aaf:	e8 ec f7 ff ff       	call   801022a0 <bfree>
80102ab4:	eb ea                	jmp    80102aa0 <iput+0x110>
    brelse(bp);
80102ab6:	83 ec 0c             	sub    $0xc,%esp
80102ab9:	ff 75 e4             	push   -0x1c(%ebp)
80102abc:	8b 7d e0             	mov    -0x20(%ebp),%edi
80102abf:	e8 2c d7 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80102ac4:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80102aca:	8b 03                	mov    (%ebx),%eax
80102acc:	e8 cf f7 ff ff       	call   801022a0 <bfree>
    ip->addrs[NDIRECT] = 0;
80102ad1:	83 c4 10             	add    $0x10,%esp
80102ad4:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80102adb:	00 00 00 
80102ade:	e9 6a ff ff ff       	jmp    80102a4d <iput+0xbd>
80102ae3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102aea:	00 
80102aeb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102af0 <iunlockput>:
{
80102af0:	55                   	push   %ebp
80102af1:	89 e5                	mov    %esp,%ebp
80102af3:	56                   	push   %esi
80102af4:	53                   	push   %ebx
80102af5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102af8:	85 db                	test   %ebx,%ebx
80102afa:	74 34                	je     80102b30 <iunlockput+0x40>
80102afc:	83 ec 0c             	sub    $0xc,%esp
80102aff:	8d 73 0c             	lea    0xc(%ebx),%esi
80102b02:	56                   	push   %esi
80102b03:	e8 98 2f 00 00       	call   80105aa0 <holdingsleep>
80102b08:	83 c4 10             	add    $0x10,%esp
80102b0b:	85 c0                	test   %eax,%eax
80102b0d:	74 21                	je     80102b30 <iunlockput+0x40>
80102b0f:	8b 43 08             	mov    0x8(%ebx),%eax
80102b12:	85 c0                	test   %eax,%eax
80102b14:	7e 1a                	jle    80102b30 <iunlockput+0x40>
  releasesleep(&ip->lock);
80102b16:	83 ec 0c             	sub    $0xc,%esp
80102b19:	56                   	push   %esi
80102b1a:	e8 41 2f 00 00       	call   80105a60 <releasesleep>
  iput(ip);
80102b1f:	89 5d 08             	mov    %ebx,0x8(%ebp)
80102b22:	83 c4 10             	add    $0x10,%esp
}
80102b25:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102b28:	5b                   	pop    %ebx
80102b29:	5e                   	pop    %esi
80102b2a:	5d                   	pop    %ebp
  iput(ip);
80102b2b:	e9 60 fe ff ff       	jmp    80102990 <iput>
    panic("iunlock");
80102b30:	83 ec 0c             	sub    $0xc,%esp
80102b33:	68 2e 91 10 80       	push   $0x8010912e
80102b38:	e8 93 d9 ff ff       	call   801004d0 <panic>
80102b3d:	8d 76 00             	lea    0x0(%esi),%esi

80102b40 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80102b40:	55                   	push   %ebp
80102b41:	89 e5                	mov    %esp,%ebp
80102b43:	8b 55 08             	mov    0x8(%ebp),%edx
80102b46:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80102b49:	8b 0a                	mov    (%edx),%ecx
80102b4b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80102b4e:	8b 4a 04             	mov    0x4(%edx),%ecx
80102b51:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80102b54:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80102b58:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80102b5b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80102b5f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80102b63:	8b 52 58             	mov    0x58(%edx),%edx
80102b66:	89 50 10             	mov    %edx,0x10(%eax)
}
80102b69:	5d                   	pop    %ebp
80102b6a:	c3                   	ret
80102b6b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102b70 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80102b70:	55                   	push   %ebp
80102b71:	89 e5                	mov    %esp,%ebp
80102b73:	57                   	push   %edi
80102b74:	56                   	push   %esi
80102b75:	53                   	push   %ebx
80102b76:	83 ec 1c             	sub    $0x1c,%esp
80102b79:	8b 7d 0c             	mov    0xc(%ebp),%edi
80102b7c:	8b 45 08             	mov    0x8(%ebp),%eax
80102b7f:	8b 75 10             	mov    0x10(%ebp),%esi
80102b82:	89 7d e0             	mov    %edi,-0x20(%ebp)
80102b85:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80102b88:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80102b8d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102b90:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80102b93:	0f 84 a7 00 00 00    	je     80102c40 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80102b99:	8b 45 d8             	mov    -0x28(%ebp),%eax
80102b9c:	8b 40 58             	mov    0x58(%eax),%eax
80102b9f:	39 c6                	cmp    %eax,%esi
80102ba1:	0f 87 ba 00 00 00    	ja     80102c61 <readi+0xf1>
80102ba7:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80102baa:	31 c9                	xor    %ecx,%ecx
80102bac:	89 da                	mov    %ebx,%edx
80102bae:	01 f2                	add    %esi,%edx
80102bb0:	0f 92 c1             	setb   %cl
80102bb3:	89 cf                	mov    %ecx,%edi
80102bb5:	0f 82 a6 00 00 00    	jb     80102c61 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80102bbb:	89 c1                	mov    %eax,%ecx
80102bbd:	29 f1                	sub    %esi,%ecx
80102bbf:	39 d0                	cmp    %edx,%eax
80102bc1:	0f 43 cb             	cmovae %ebx,%ecx
80102bc4:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102bc7:	85 c9                	test   %ecx,%ecx
80102bc9:	74 67                	je     80102c32 <readi+0xc2>
80102bcb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102bd0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80102bd3:	89 f2                	mov    %esi,%edx
80102bd5:	c1 ea 09             	shr    $0x9,%edx
80102bd8:	89 d8                	mov    %ebx,%eax
80102bda:	e8 51 f9 ff ff       	call   80102530 <bmap>
80102bdf:	83 ec 08             	sub    $0x8,%esp
80102be2:	50                   	push   %eax
80102be3:	ff 33                	push   (%ebx)
80102be5:	e8 e6 d4 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80102bea:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80102bed:	b9 00 02 00 00       	mov    $0x200,%ecx
80102bf2:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102bf5:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80102bf7:	89 f0                	mov    %esi,%eax
80102bf9:	25 ff 01 00 00       	and    $0x1ff,%eax
80102bfe:	29 fb                	sub    %edi,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80102c00:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80102c03:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80102c05:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80102c09:	39 d9                	cmp    %ebx,%ecx
80102c0b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80102c0e:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102c0f:	01 df                	add    %ebx,%edi
80102c11:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80102c13:	50                   	push   %eax
80102c14:	ff 75 e0             	push   -0x20(%ebp)
80102c17:	e8 04 32 00 00       	call   80105e20 <memmove>
    brelse(bp);
80102c1c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80102c1f:	89 14 24             	mov    %edx,(%esp)
80102c22:	e8 c9 d5 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102c27:	01 5d e0             	add    %ebx,-0x20(%ebp)
80102c2a:	83 c4 10             	add    $0x10,%esp
80102c2d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80102c30:	77 9e                	ja     80102bd0 <readi+0x60>
  }
  return n;
80102c32:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80102c35:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c38:	5b                   	pop    %ebx
80102c39:	5e                   	pop    %esi
80102c3a:	5f                   	pop    %edi
80102c3b:	5d                   	pop    %ebp
80102c3c:	c3                   	ret
80102c3d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80102c40:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102c44:	66 83 f8 09          	cmp    $0x9,%ax
80102c48:	77 17                	ja     80102c61 <readi+0xf1>
80102c4a:	8b 04 c5 c0 23 11 80 	mov    -0x7feedc40(,%eax,8),%eax
80102c51:	85 c0                	test   %eax,%eax
80102c53:	74 0c                	je     80102c61 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80102c55:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80102c58:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c5b:	5b                   	pop    %ebx
80102c5c:	5e                   	pop    %esi
80102c5d:	5f                   	pop    %edi
80102c5e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80102c5f:	ff e0                	jmp    *%eax
      return -1;
80102c61:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102c66:	eb cd                	jmp    80102c35 <readi+0xc5>
80102c68:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102c6f:	00 

80102c70 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80102c70:	55                   	push   %ebp
80102c71:	89 e5                	mov    %esp,%ebp
80102c73:	57                   	push   %edi
80102c74:	56                   	push   %esi
80102c75:	53                   	push   %ebx
80102c76:	83 ec 1c             	sub    $0x1c,%esp
80102c79:	8b 45 08             	mov    0x8(%ebp),%eax
80102c7c:	8b 75 0c             	mov    0xc(%ebp),%esi
80102c7f:	8b 55 14             	mov    0x14(%ebp),%edx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80102c82:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80102c87:	89 75 dc             	mov    %esi,-0x24(%ebp)
80102c8a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102c8d:	8b 75 10             	mov    0x10(%ebp),%esi
80102c90:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(ip->type == T_DEV){
80102c93:	0f 84 b7 00 00 00    	je     80102d50 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80102c99:	8b 45 d8             	mov    -0x28(%ebp),%eax
80102c9c:	3b 70 58             	cmp    0x58(%eax),%esi
80102c9f:	0f 87 e7 00 00 00    	ja     80102d8c <writei+0x11c>
80102ca5:	8b 7d e0             	mov    -0x20(%ebp),%edi
80102ca8:	31 d2                	xor    %edx,%edx
80102caa:	89 f8                	mov    %edi,%eax
80102cac:	01 f0                	add    %esi,%eax
80102cae:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80102cb1:	3d 00 18 01 00       	cmp    $0x11800,%eax
80102cb6:	0f 87 d0 00 00 00    	ja     80102d8c <writei+0x11c>
80102cbc:	85 d2                	test   %edx,%edx
80102cbe:	0f 85 c8 00 00 00    	jne    80102d8c <writei+0x11c>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102cc4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80102ccb:	85 ff                	test   %edi,%edi
80102ccd:	74 72                	je     80102d41 <writei+0xd1>
80102ccf:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102cd0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80102cd3:	89 f2                	mov    %esi,%edx
80102cd5:	c1 ea 09             	shr    $0x9,%edx
80102cd8:	89 f8                	mov    %edi,%eax
80102cda:	e8 51 f8 ff ff       	call   80102530 <bmap>
80102cdf:	83 ec 08             	sub    $0x8,%esp
80102ce2:	50                   	push   %eax
80102ce3:	ff 37                	push   (%edi)
80102ce5:	e8 e6 d3 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80102cea:	b9 00 02 00 00       	mov    $0x200,%ecx
80102cef:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80102cf2:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102cf5:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80102cf7:	89 f0                	mov    %esi,%eax
80102cf9:	83 c4 0c             	add    $0xc,%esp
80102cfc:	25 ff 01 00 00       	and    $0x1ff,%eax
80102d01:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80102d03:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80102d07:	39 d9                	cmp    %ebx,%ecx
80102d09:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80102d0c:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102d0d:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80102d0f:	ff 75 dc             	push   -0x24(%ebp)
80102d12:	50                   	push   %eax
80102d13:	e8 08 31 00 00       	call   80105e20 <memmove>
    log_write(bp);
80102d18:	89 3c 24             	mov    %edi,(%esp)
80102d1b:	e8 00 13 00 00       	call   80104020 <log_write>
    brelse(bp);
80102d20:	89 3c 24             	mov    %edi,(%esp)
80102d23:	e8 c8 d4 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102d28:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80102d2b:	83 c4 10             	add    $0x10,%esp
80102d2e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102d31:	01 5d dc             	add    %ebx,-0x24(%ebp)
80102d34:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80102d37:	77 97                	ja     80102cd0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80102d39:	8b 45 d8             	mov    -0x28(%ebp),%eax
80102d3c:	3b 70 58             	cmp    0x58(%eax),%esi
80102d3f:	77 37                	ja     80102d78 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80102d41:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80102d44:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d47:	5b                   	pop    %ebx
80102d48:	5e                   	pop    %esi
80102d49:	5f                   	pop    %edi
80102d4a:	5d                   	pop    %ebp
80102d4b:	c3                   	ret
80102d4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80102d50:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102d54:	66 83 f8 09          	cmp    $0x9,%ax
80102d58:	77 32                	ja     80102d8c <writei+0x11c>
80102d5a:	8b 04 c5 c4 23 11 80 	mov    -0x7feedc3c(,%eax,8),%eax
80102d61:	85 c0                	test   %eax,%eax
80102d63:	74 27                	je     80102d8c <writei+0x11c>
    return devsw[ip->major].write(ip, src, n);
80102d65:	89 55 10             	mov    %edx,0x10(%ebp)
}
80102d68:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d6b:	5b                   	pop    %ebx
80102d6c:	5e                   	pop    %esi
80102d6d:	5f                   	pop    %edi
80102d6e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80102d6f:	ff e0                	jmp    *%eax
80102d71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80102d78:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80102d7b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80102d7e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80102d81:	50                   	push   %eax
80102d82:	e8 29 fa ff ff       	call   801027b0 <iupdate>
80102d87:	83 c4 10             	add    $0x10,%esp
80102d8a:	eb b5                	jmp    80102d41 <writei+0xd1>
      return -1;
80102d8c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102d91:	eb b1                	jmp    80102d44 <writei+0xd4>
80102d93:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102d9a:	00 
80102d9b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102da0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80102da0:	55                   	push   %ebp
80102da1:	89 e5                	mov    %esp,%ebp
80102da3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80102da6:	6a 0e                	push   $0xe
80102da8:	ff 75 0c             	push   0xc(%ebp)
80102dab:	ff 75 08             	push   0x8(%ebp)
80102dae:	e8 dd 30 00 00       	call   80105e90 <strncmp>
}
80102db3:	c9                   	leave
80102db4:	c3                   	ret
80102db5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102dbc:	00 
80102dbd:	8d 76 00             	lea    0x0(%esi),%esi

80102dc0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102dc0:	55                   	push   %ebp
80102dc1:	89 e5                	mov    %esp,%ebp
80102dc3:	57                   	push   %edi
80102dc4:	56                   	push   %esi
80102dc5:	53                   	push   %ebx
80102dc6:	83 ec 1c             	sub    $0x1c,%esp
80102dc9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80102dcc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80102dd1:	0f 85 85 00 00 00    	jne    80102e5c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80102dd7:	8b 53 58             	mov    0x58(%ebx),%edx
80102dda:	31 ff                	xor    %edi,%edi
80102ddc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102ddf:	85 d2                	test   %edx,%edx
80102de1:	74 3e                	je     80102e21 <dirlookup+0x61>
80102de3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102de8:	6a 10                	push   $0x10
80102dea:	57                   	push   %edi
80102deb:	56                   	push   %esi
80102dec:	53                   	push   %ebx
80102ded:	e8 7e fd ff ff       	call   80102b70 <readi>
80102df2:	83 c4 10             	add    $0x10,%esp
80102df5:	83 f8 10             	cmp    $0x10,%eax
80102df8:	75 55                	jne    80102e4f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80102dfa:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80102dff:	74 18                	je     80102e19 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80102e01:	83 ec 04             	sub    $0x4,%esp
80102e04:	8d 45 da             	lea    -0x26(%ebp),%eax
80102e07:	6a 0e                	push   $0xe
80102e09:	50                   	push   %eax
80102e0a:	ff 75 0c             	push   0xc(%ebp)
80102e0d:	e8 7e 30 00 00       	call   80105e90 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80102e12:	83 c4 10             	add    $0x10,%esp
80102e15:	85 c0                	test   %eax,%eax
80102e17:	74 17                	je     80102e30 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80102e19:	83 c7 10             	add    $0x10,%edi
80102e1c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102e1f:	72 c7                	jb     80102de8 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80102e21:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80102e24:	31 c0                	xor    %eax,%eax
}
80102e26:	5b                   	pop    %ebx
80102e27:	5e                   	pop    %esi
80102e28:	5f                   	pop    %edi
80102e29:	5d                   	pop    %ebp
80102e2a:	c3                   	ret
80102e2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(poff)
80102e30:	8b 45 10             	mov    0x10(%ebp),%eax
80102e33:	85 c0                	test   %eax,%eax
80102e35:	74 05                	je     80102e3c <dirlookup+0x7c>
        *poff = off;
80102e37:	8b 45 10             	mov    0x10(%ebp),%eax
80102e3a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80102e3c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80102e40:	8b 03                	mov    (%ebx),%eax
80102e42:	e8 e9 f5 ff ff       	call   80102430 <iget>
}
80102e47:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e4a:	5b                   	pop    %ebx
80102e4b:	5e                   	pop    %esi
80102e4c:	5f                   	pop    %edi
80102e4d:	5d                   	pop    %ebp
80102e4e:	c3                   	ret
      panic("dirlookup read");
80102e4f:	83 ec 0c             	sub    $0xc,%esp
80102e52:	68 48 91 10 80       	push   $0x80109148
80102e57:	e8 74 d6 ff ff       	call   801004d0 <panic>
    panic("dirlookup not DIR");
80102e5c:	83 ec 0c             	sub    $0xc,%esp
80102e5f:	68 36 91 10 80       	push   $0x80109136
80102e64:	e8 67 d6 ff ff       	call   801004d0 <panic>
80102e69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102e70 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80102e70:	55                   	push   %ebp
80102e71:	89 e5                	mov    %esp,%ebp
80102e73:	57                   	push   %edi
80102e74:	56                   	push   %esi
80102e75:	53                   	push   %ebx
80102e76:	89 c3                	mov    %eax,%ebx
80102e78:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80102e7b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80102e7e:	89 55 dc             	mov    %edx,-0x24(%ebp)
80102e81:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80102e84:	0f 84 64 01 00 00    	je     80102fee <namex+0x17e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80102e8a:	e8 e1 1b 00 00       	call   80104a70 <myproc>
  acquire(&icache.lock);
80102e8f:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80102e92:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80102e95:	68 20 24 11 80       	push   $0x80112420
80102e9a:	e8 21 2e 00 00       	call   80105cc0 <acquire>
  ip->ref++;
80102e9f:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80102ea3:	c7 04 24 20 24 11 80 	movl   $0x80112420,(%esp)
80102eaa:	e8 b1 2d 00 00       	call   80105c60 <release>
80102eaf:	83 c4 10             	add    $0x10,%esp
80102eb2:	eb 07                	jmp    80102ebb <namex+0x4b>
80102eb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80102eb8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80102ebb:	0f b6 03             	movzbl (%ebx),%eax
80102ebe:	3c 2f                	cmp    $0x2f,%al
80102ec0:	74 f6                	je     80102eb8 <namex+0x48>
  if(*path == 0)
80102ec2:	84 c0                	test   %al,%al
80102ec4:	0f 84 06 01 00 00    	je     80102fd0 <namex+0x160>
  while(*path != '/' && *path != 0)
80102eca:	0f b6 03             	movzbl (%ebx),%eax
80102ecd:	84 c0                	test   %al,%al
80102ecf:	0f 84 10 01 00 00    	je     80102fe5 <namex+0x175>
80102ed5:	89 df                	mov    %ebx,%edi
80102ed7:	3c 2f                	cmp    $0x2f,%al
80102ed9:	0f 84 06 01 00 00    	je     80102fe5 <namex+0x175>
80102edf:	90                   	nop
80102ee0:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
80102ee4:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
80102ee7:	3c 2f                	cmp    $0x2f,%al
80102ee9:	74 04                	je     80102eef <namex+0x7f>
80102eeb:	84 c0                	test   %al,%al
80102eed:	75 f1                	jne    80102ee0 <namex+0x70>
  len = path - s;
80102eef:	89 f8                	mov    %edi,%eax
80102ef1:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
80102ef3:	83 f8 0d             	cmp    $0xd,%eax
80102ef6:	0f 8e ac 00 00 00    	jle    80102fa8 <namex+0x138>
    memmove(name, s, DIRSIZ);
80102efc:	83 ec 04             	sub    $0x4,%esp
80102eff:	6a 0e                	push   $0xe
80102f01:	53                   	push   %ebx
    path++;
80102f02:	89 fb                	mov    %edi,%ebx
    memmove(name, s, DIRSIZ);
80102f04:	ff 75 e4             	push   -0x1c(%ebp)
80102f07:	e8 14 2f 00 00       	call   80105e20 <memmove>
80102f0c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80102f0f:	80 3f 2f             	cmpb   $0x2f,(%edi)
80102f12:	75 0c                	jne    80102f20 <namex+0xb0>
80102f14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80102f18:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80102f1b:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80102f1e:	74 f8                	je     80102f18 <namex+0xa8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80102f20:	83 ec 0c             	sub    $0xc,%esp
80102f23:	56                   	push   %esi
80102f24:	e8 37 f9 ff ff       	call   80102860 <ilock>
    if(ip->type != T_DIR){
80102f29:	83 c4 10             	add    $0x10,%esp
80102f2c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80102f31:	0f 85 cd 00 00 00    	jne    80103004 <namex+0x194>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80102f37:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102f3a:	85 c0                	test   %eax,%eax
80102f3c:	74 09                	je     80102f47 <namex+0xd7>
80102f3e:	80 3b 00             	cmpb   $0x0,(%ebx)
80102f41:	0f 84 22 01 00 00    	je     80103069 <namex+0x1f9>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80102f47:	83 ec 04             	sub    $0x4,%esp
80102f4a:	6a 00                	push   $0x0
80102f4c:	ff 75 e4             	push   -0x1c(%ebp)
80102f4f:	56                   	push   %esi
80102f50:	e8 6b fe ff ff       	call   80102dc0 <dirlookup>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102f55:	8d 56 0c             	lea    0xc(%esi),%edx
    if((next = dirlookup(ip, name, 0)) == 0){
80102f58:	83 c4 10             	add    $0x10,%esp
80102f5b:	89 c7                	mov    %eax,%edi
80102f5d:	85 c0                	test   %eax,%eax
80102f5f:	0f 84 e1 00 00 00    	je     80103046 <namex+0x1d6>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102f65:	83 ec 0c             	sub    $0xc,%esp
80102f68:	89 55 e0             	mov    %edx,-0x20(%ebp)
80102f6b:	52                   	push   %edx
80102f6c:	e8 2f 2b 00 00       	call   80105aa0 <holdingsleep>
80102f71:	83 c4 10             	add    $0x10,%esp
80102f74:	85 c0                	test   %eax,%eax
80102f76:	0f 84 30 01 00 00    	je     801030ac <namex+0x23c>
80102f7c:	8b 56 08             	mov    0x8(%esi),%edx
80102f7f:	85 d2                	test   %edx,%edx
80102f81:	0f 8e 25 01 00 00    	jle    801030ac <namex+0x23c>
  releasesleep(&ip->lock);
80102f87:	8b 55 e0             	mov    -0x20(%ebp),%edx
80102f8a:	83 ec 0c             	sub    $0xc,%esp
80102f8d:	52                   	push   %edx
80102f8e:	e8 cd 2a 00 00       	call   80105a60 <releasesleep>
  iput(ip);
80102f93:	89 34 24             	mov    %esi,(%esp)
80102f96:	89 fe                	mov    %edi,%esi
80102f98:	e8 f3 f9 ff ff       	call   80102990 <iput>
80102f9d:	83 c4 10             	add    $0x10,%esp
80102fa0:	e9 16 ff ff ff       	jmp    80102ebb <namex+0x4b>
80102fa5:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80102fa8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80102fab:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    memmove(name, s, len);
80102fae:	83 ec 04             	sub    $0x4,%esp
80102fb1:	89 55 e0             	mov    %edx,-0x20(%ebp)
80102fb4:	50                   	push   %eax
80102fb5:	53                   	push   %ebx
    name[len] = 0;
80102fb6:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
80102fb8:	ff 75 e4             	push   -0x1c(%ebp)
80102fbb:	e8 60 2e 00 00       	call   80105e20 <memmove>
    name[len] = 0;
80102fc0:	8b 55 e0             	mov    -0x20(%ebp),%edx
80102fc3:	83 c4 10             	add    $0x10,%esp
80102fc6:	c6 02 00             	movb   $0x0,(%edx)
80102fc9:	e9 41 ff ff ff       	jmp    80102f0f <namex+0x9f>
80102fce:	66 90                	xchg   %ax,%ax
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80102fd0:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102fd3:	85 c0                	test   %eax,%eax
80102fd5:	0f 85 be 00 00 00    	jne    80103099 <namex+0x229>
    iput(ip);
    return 0;
  }
  return ip;
}
80102fdb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102fde:	89 f0                	mov    %esi,%eax
80102fe0:	5b                   	pop    %ebx
80102fe1:	5e                   	pop    %esi
80102fe2:	5f                   	pop    %edi
80102fe3:	5d                   	pop    %ebp
80102fe4:	c3                   	ret
  while(*path != '/' && *path != 0)
80102fe5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102fe8:	89 df                	mov    %ebx,%edi
80102fea:	31 c0                	xor    %eax,%eax
80102fec:	eb c0                	jmp    80102fae <namex+0x13e>
    ip = iget(ROOTDEV, ROOTINO);
80102fee:	ba 01 00 00 00       	mov    $0x1,%edx
80102ff3:	b8 01 00 00 00       	mov    $0x1,%eax
80102ff8:	e8 33 f4 ff ff       	call   80102430 <iget>
80102ffd:	89 c6                	mov    %eax,%esi
80102fff:	e9 b7 fe ff ff       	jmp    80102ebb <namex+0x4b>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80103004:	83 ec 0c             	sub    $0xc,%esp
80103007:	8d 5e 0c             	lea    0xc(%esi),%ebx
8010300a:	53                   	push   %ebx
8010300b:	e8 90 2a 00 00       	call   80105aa0 <holdingsleep>
80103010:	83 c4 10             	add    $0x10,%esp
80103013:	85 c0                	test   %eax,%eax
80103015:	0f 84 91 00 00 00    	je     801030ac <namex+0x23c>
8010301b:	8b 46 08             	mov    0x8(%esi),%eax
8010301e:	85 c0                	test   %eax,%eax
80103020:	0f 8e 86 00 00 00    	jle    801030ac <namex+0x23c>
  releasesleep(&ip->lock);
80103026:	83 ec 0c             	sub    $0xc,%esp
80103029:	53                   	push   %ebx
8010302a:	e8 31 2a 00 00       	call   80105a60 <releasesleep>
  iput(ip);
8010302f:	89 34 24             	mov    %esi,(%esp)
      return 0;
80103032:	31 f6                	xor    %esi,%esi
  iput(ip);
80103034:	e8 57 f9 ff ff       	call   80102990 <iput>
      return 0;
80103039:	83 c4 10             	add    $0x10,%esp
}
8010303c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010303f:	89 f0                	mov    %esi,%eax
80103041:	5b                   	pop    %ebx
80103042:	5e                   	pop    %esi
80103043:	5f                   	pop    %edi
80103044:	5d                   	pop    %ebp
80103045:	c3                   	ret
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80103046:	83 ec 0c             	sub    $0xc,%esp
80103049:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010304c:	52                   	push   %edx
8010304d:	e8 4e 2a 00 00       	call   80105aa0 <holdingsleep>
80103052:	83 c4 10             	add    $0x10,%esp
80103055:	85 c0                	test   %eax,%eax
80103057:	74 53                	je     801030ac <namex+0x23c>
80103059:	8b 4e 08             	mov    0x8(%esi),%ecx
8010305c:	85 c9                	test   %ecx,%ecx
8010305e:	7e 4c                	jle    801030ac <namex+0x23c>
  releasesleep(&ip->lock);
80103060:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103063:	83 ec 0c             	sub    $0xc,%esp
80103066:	52                   	push   %edx
80103067:	eb c1                	jmp    8010302a <namex+0x1ba>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80103069:	83 ec 0c             	sub    $0xc,%esp
8010306c:	8d 5e 0c             	lea    0xc(%esi),%ebx
8010306f:	53                   	push   %ebx
80103070:	e8 2b 2a 00 00       	call   80105aa0 <holdingsleep>
80103075:	83 c4 10             	add    $0x10,%esp
80103078:	85 c0                	test   %eax,%eax
8010307a:	74 30                	je     801030ac <namex+0x23c>
8010307c:	8b 7e 08             	mov    0x8(%esi),%edi
8010307f:	85 ff                	test   %edi,%edi
80103081:	7e 29                	jle    801030ac <namex+0x23c>
  releasesleep(&ip->lock);
80103083:	83 ec 0c             	sub    $0xc,%esp
80103086:	53                   	push   %ebx
80103087:	e8 d4 29 00 00       	call   80105a60 <releasesleep>
}
8010308c:	83 c4 10             	add    $0x10,%esp
}
8010308f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103092:	89 f0                	mov    %esi,%eax
80103094:	5b                   	pop    %ebx
80103095:	5e                   	pop    %esi
80103096:	5f                   	pop    %edi
80103097:	5d                   	pop    %ebp
80103098:	c3                   	ret
    iput(ip);
80103099:	83 ec 0c             	sub    $0xc,%esp
8010309c:	56                   	push   %esi
    return 0;
8010309d:	31 f6                	xor    %esi,%esi
    iput(ip);
8010309f:	e8 ec f8 ff ff       	call   80102990 <iput>
    return 0;
801030a4:	83 c4 10             	add    $0x10,%esp
801030a7:	e9 2f ff ff ff       	jmp    80102fdb <namex+0x16b>
    panic("iunlock");
801030ac:	83 ec 0c             	sub    $0xc,%esp
801030af:	68 2e 91 10 80       	push   $0x8010912e
801030b4:	e8 17 d4 ff ff       	call   801004d0 <panic>
801030b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801030c0 <dirlink>:
{
801030c0:	55                   	push   %ebp
801030c1:	89 e5                	mov    %esp,%ebp
801030c3:	57                   	push   %edi
801030c4:	56                   	push   %esi
801030c5:	53                   	push   %ebx
801030c6:	83 ec 20             	sub    $0x20,%esp
801030c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
801030cc:	6a 00                	push   $0x0
801030ce:	ff 75 0c             	push   0xc(%ebp)
801030d1:	53                   	push   %ebx
801030d2:	e8 e9 fc ff ff       	call   80102dc0 <dirlookup>
801030d7:	83 c4 10             	add    $0x10,%esp
801030da:	85 c0                	test   %eax,%eax
801030dc:	75 67                	jne    80103145 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
801030de:	8b 7b 58             	mov    0x58(%ebx),%edi
801030e1:	8d 75 d8             	lea    -0x28(%ebp),%esi
801030e4:	85 ff                	test   %edi,%edi
801030e6:	74 29                	je     80103111 <dirlink+0x51>
801030e8:	31 ff                	xor    %edi,%edi
801030ea:	8d 75 d8             	lea    -0x28(%ebp),%esi
801030ed:	eb 09                	jmp    801030f8 <dirlink+0x38>
801030ef:	90                   	nop
801030f0:	83 c7 10             	add    $0x10,%edi
801030f3:	3b 7b 58             	cmp    0x58(%ebx),%edi
801030f6:	73 19                	jae    80103111 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801030f8:	6a 10                	push   $0x10
801030fa:	57                   	push   %edi
801030fb:	56                   	push   %esi
801030fc:	53                   	push   %ebx
801030fd:	e8 6e fa ff ff       	call   80102b70 <readi>
80103102:	83 c4 10             	add    $0x10,%esp
80103105:	83 f8 10             	cmp    $0x10,%eax
80103108:	75 4e                	jne    80103158 <dirlink+0x98>
    if(de.inum == 0)
8010310a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010310f:	75 df                	jne    801030f0 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80103111:	83 ec 04             	sub    $0x4,%esp
80103114:	8d 45 da             	lea    -0x26(%ebp),%eax
80103117:	6a 0e                	push   $0xe
80103119:	ff 75 0c             	push   0xc(%ebp)
8010311c:	50                   	push   %eax
8010311d:	e8 be 2d 00 00       	call   80105ee0 <strncpy>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80103122:	6a 10                	push   $0x10
  de.inum = inum;
80103124:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80103127:	57                   	push   %edi
80103128:	56                   	push   %esi
80103129:	53                   	push   %ebx
  de.inum = inum;
8010312a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010312e:	e8 3d fb ff ff       	call   80102c70 <writei>
80103133:	83 c4 20             	add    $0x20,%esp
80103136:	83 f8 10             	cmp    $0x10,%eax
80103139:	75 2a                	jne    80103165 <dirlink+0xa5>
  return 0;
8010313b:	31 c0                	xor    %eax,%eax
}
8010313d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103140:	5b                   	pop    %ebx
80103141:	5e                   	pop    %esi
80103142:	5f                   	pop    %edi
80103143:	5d                   	pop    %ebp
80103144:	c3                   	ret
    iput(ip);
80103145:	83 ec 0c             	sub    $0xc,%esp
80103148:	50                   	push   %eax
80103149:	e8 42 f8 ff ff       	call   80102990 <iput>
    return -1;
8010314e:	83 c4 10             	add    $0x10,%esp
80103151:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103156:	eb e5                	jmp    8010313d <dirlink+0x7d>
      panic("dirlink read");
80103158:	83 ec 0c             	sub    $0xc,%esp
8010315b:	68 57 91 10 80       	push   $0x80109157
80103160:	e8 6b d3 ff ff       	call   801004d0 <panic>
    panic("dirlink");
80103165:	83 ec 0c             	sub    $0xc,%esp
80103168:	68 10 94 10 80       	push   $0x80109410
8010316d:	e8 5e d3 ff ff       	call   801004d0 <panic>
80103172:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103179:	00 
8010317a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103180 <namei>:

struct inode*
namei(char *path)
{
80103180:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80103181:	31 d2                	xor    %edx,%edx
{
80103183:	89 e5                	mov    %esp,%ebp
80103185:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80103188:	8b 45 08             	mov    0x8(%ebp),%eax
8010318b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
8010318e:	e8 dd fc ff ff       	call   80102e70 <namex>
}
80103193:	c9                   	leave
80103194:	c3                   	ret
80103195:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010319c:	00 
8010319d:	8d 76 00             	lea    0x0(%esi),%esi

801031a0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
801031a0:	55                   	push   %ebp
  return namex(path, 1, name);
801031a1:	ba 01 00 00 00       	mov    $0x1,%edx
{
801031a6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
801031a8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801031ab:	8b 45 08             	mov    0x8(%ebp),%eax
}
801031ae:	5d                   	pop    %ebp
  return namex(path, 1, name);
801031af:	e9 bc fc ff ff       	jmp    80102e70 <namex>
801031b4:	66 90                	xchg   %ax,%ax
801031b6:	66 90                	xchg   %ax,%ax
801031b8:	66 90                	xchg   %ax,%ax
801031ba:	66 90                	xchg   %ax,%ax
801031bc:	66 90                	xchg   %ax,%ax
801031be:	66 90                	xchg   %ax,%ax

801031c0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801031c0:	55                   	push   %ebp
801031c1:	89 e5                	mov    %esp,%ebp
801031c3:	57                   	push   %edi
801031c4:	56                   	push   %esi
801031c5:	53                   	push   %ebx
801031c6:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
801031c9:	85 c0                	test   %eax,%eax
801031cb:	0f 84 b4 00 00 00    	je     80103285 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
801031d1:	8b 70 08             	mov    0x8(%eax),%esi
801031d4:	89 c3                	mov    %eax,%ebx
801031d6:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
801031dc:	0f 87 96 00 00 00    	ja     80103278 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801031e2:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
801031e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801031ee:	00 
801031ef:	90                   	nop
801031f0:	89 ca                	mov    %ecx,%edx
801031f2:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801031f3:	83 e0 c0             	and    $0xffffffc0,%eax
801031f6:	3c 40                	cmp    $0x40,%al
801031f8:	75 f6                	jne    801031f0 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801031fa:	31 ff                	xor    %edi,%edi
801031fc:	ba f6 03 00 00       	mov    $0x3f6,%edx
80103201:	89 f8                	mov    %edi,%eax
80103203:	ee                   	out    %al,(%dx)
80103204:	b8 01 00 00 00       	mov    $0x1,%eax
80103209:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010320e:	ee                   	out    %al,(%dx)
8010320f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80103214:	89 f0                	mov    %esi,%eax
80103216:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80103217:	89 f0                	mov    %esi,%eax
80103219:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010321e:	c1 f8 08             	sar    $0x8,%eax
80103221:	ee                   	out    %al,(%dx)
80103222:	ba f5 01 00 00       	mov    $0x1f5,%edx
80103227:	89 f8                	mov    %edi,%eax
80103229:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010322a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
8010322e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80103233:	c1 e0 04             	shl    $0x4,%eax
80103236:	83 e0 10             	and    $0x10,%eax
80103239:	83 c8 e0             	or     $0xffffffe0,%eax
8010323c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010323d:	f6 03 04             	testb  $0x4,(%ebx)
80103240:	75 16                	jne    80103258 <idestart+0x98>
80103242:	b8 20 00 00 00       	mov    $0x20,%eax
80103247:	89 ca                	mov    %ecx,%edx
80103249:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010324a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010324d:	5b                   	pop    %ebx
8010324e:	5e                   	pop    %esi
8010324f:	5f                   	pop    %edi
80103250:	5d                   	pop    %ebp
80103251:	c3                   	ret
80103252:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103258:	b8 30 00 00 00       	mov    $0x30,%eax
8010325d:	89 ca                	mov    %ecx,%edx
8010325f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80103260:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80103265:	8d 73 5c             	lea    0x5c(%ebx),%esi
80103268:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010326d:	fc                   	cld
8010326e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80103270:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103273:	5b                   	pop    %ebx
80103274:	5e                   	pop    %esi
80103275:	5f                   	pop    %edi
80103276:	5d                   	pop    %ebp
80103277:	c3                   	ret
    panic("incorrect blockno");
80103278:	83 ec 0c             	sub    $0xc,%esp
8010327b:	68 6d 91 10 80       	push   $0x8010916d
80103280:	e8 4b d2 ff ff       	call   801004d0 <panic>
    panic("idestart");
80103285:	83 ec 0c             	sub    $0xc,%esp
80103288:	68 64 91 10 80       	push   $0x80109164
8010328d:	e8 3e d2 ff ff       	call   801004d0 <panic>
80103292:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103299:	00 
8010329a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801032a0 <ideinit>:
{
801032a0:	55                   	push   %ebp
801032a1:	89 e5                	mov    %esp,%ebp
801032a3:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
801032a6:	68 7f 91 10 80       	push   $0x8010917f
801032ab:	68 c0 40 11 80       	push   $0x801140c0
801032b0:	e8 3b 28 00 00       	call   80105af0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801032b5:	58                   	pop    %eax
801032b6:	a1 44 42 11 80       	mov    0x80114244,%eax
801032bb:	5a                   	pop    %edx
801032bc:	83 e8 01             	sub    $0x1,%eax
801032bf:	50                   	push   %eax
801032c0:	6a 0e                	push   $0xe
801032c2:	e8 99 02 00 00       	call   80103560 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801032c7:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801032ca:	ba f7 01 00 00       	mov    $0x1f7,%edx
801032cf:	90                   	nop
801032d0:	ec                   	in     (%dx),%al
801032d1:	83 e0 c0             	and    $0xffffffc0,%eax
801032d4:	3c 40                	cmp    $0x40,%al
801032d6:	75 f8                	jne    801032d0 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801032d8:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
801032dd:	ba f6 01 00 00       	mov    $0x1f6,%edx
801032e2:	ee                   	out    %al,(%dx)
801032e3:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801032e8:	ba f7 01 00 00       	mov    $0x1f7,%edx
801032ed:	eb 06                	jmp    801032f5 <ideinit+0x55>
801032ef:	90                   	nop
  for(i=0; i<1000; i++){
801032f0:	83 e9 01             	sub    $0x1,%ecx
801032f3:	74 0f                	je     80103304 <ideinit+0x64>
801032f5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801032f6:	84 c0                	test   %al,%al
801032f8:	74 f6                	je     801032f0 <ideinit+0x50>
      havedisk1 = 1;
801032fa:	c7 05 a0 40 11 80 01 	movl   $0x1,0x801140a0
80103301:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103304:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80103309:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010330e:	ee                   	out    %al,(%dx)
}
8010330f:	c9                   	leave
80103310:	c3                   	ret
80103311:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103318:	00 
80103319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103320 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80103320:	55                   	push   %ebp
80103321:	89 e5                	mov    %esp,%ebp
80103323:	57                   	push   %edi
80103324:	56                   	push   %esi
80103325:	53                   	push   %ebx
80103326:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80103329:	68 c0 40 11 80       	push   $0x801140c0
8010332e:	e8 8d 29 00 00       	call   80105cc0 <acquire>

  if((b = idequeue) == 0){
80103333:	8b 1d a4 40 11 80    	mov    0x801140a4,%ebx
80103339:	83 c4 10             	add    $0x10,%esp
8010333c:	85 db                	test   %ebx,%ebx
8010333e:	74 63                	je     801033a3 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80103340:	8b 43 58             	mov    0x58(%ebx),%eax
80103343:	a3 a4 40 11 80       	mov    %eax,0x801140a4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80103348:	8b 33                	mov    (%ebx),%esi
8010334a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80103350:	75 2f                	jne    80103381 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103352:	ba f7 01 00 00       	mov    $0x1f7,%edx
80103357:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010335e:	00 
8010335f:	90                   	nop
80103360:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80103361:	89 c1                	mov    %eax,%ecx
80103363:	83 e1 c0             	and    $0xffffffc0,%ecx
80103366:	80 f9 40             	cmp    $0x40,%cl
80103369:	75 f5                	jne    80103360 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010336b:	a8 21                	test   $0x21,%al
8010336d:	75 12                	jne    80103381 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
8010336f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80103372:	b9 80 00 00 00       	mov    $0x80,%ecx
80103377:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010337c:	fc                   	cld
8010337d:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
8010337f:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
80103381:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80103384:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80103387:	83 ce 02             	or     $0x2,%esi
8010338a:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010338c:	53                   	push   %ebx
8010338d:	e8 6e 1e 00 00       	call   80105200 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80103392:	a1 a4 40 11 80       	mov    0x801140a4,%eax
80103397:	83 c4 10             	add    $0x10,%esp
8010339a:	85 c0                	test   %eax,%eax
8010339c:	74 05                	je     801033a3 <ideintr+0x83>
    idestart(idequeue);
8010339e:	e8 1d fe ff ff       	call   801031c0 <idestart>
    release(&idelock);
801033a3:	83 ec 0c             	sub    $0xc,%esp
801033a6:	68 c0 40 11 80       	push   $0x801140c0
801033ab:	e8 b0 28 00 00       	call   80105c60 <release>

  release(&idelock);
}
801033b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801033b3:	5b                   	pop    %ebx
801033b4:	5e                   	pop    %esi
801033b5:	5f                   	pop    %edi
801033b6:	5d                   	pop    %ebp
801033b7:	c3                   	ret
801033b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801033bf:	00 

801033c0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801033c0:	55                   	push   %ebp
801033c1:	89 e5                	mov    %esp,%ebp
801033c3:	53                   	push   %ebx
801033c4:	83 ec 10             	sub    $0x10,%esp
801033c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801033ca:	8d 43 0c             	lea    0xc(%ebx),%eax
801033cd:	50                   	push   %eax
801033ce:	e8 cd 26 00 00       	call   80105aa0 <holdingsleep>
801033d3:	83 c4 10             	add    $0x10,%esp
801033d6:	85 c0                	test   %eax,%eax
801033d8:	0f 84 c3 00 00 00    	je     801034a1 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801033de:	8b 03                	mov    (%ebx),%eax
801033e0:	83 e0 06             	and    $0x6,%eax
801033e3:	83 f8 02             	cmp    $0x2,%eax
801033e6:	0f 84 a8 00 00 00    	je     80103494 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
801033ec:	8b 53 04             	mov    0x4(%ebx),%edx
801033ef:	85 d2                	test   %edx,%edx
801033f1:	74 0d                	je     80103400 <iderw+0x40>
801033f3:	a1 a0 40 11 80       	mov    0x801140a0,%eax
801033f8:	85 c0                	test   %eax,%eax
801033fa:	0f 84 87 00 00 00    	je     80103487 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80103400:	83 ec 0c             	sub    $0xc,%esp
80103403:	68 c0 40 11 80       	push   $0x801140c0
80103408:	e8 b3 28 00 00       	call   80105cc0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010340d:	a1 a4 40 11 80       	mov    0x801140a4,%eax
  b->qnext = 0;
80103412:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80103419:	83 c4 10             	add    $0x10,%esp
8010341c:	85 c0                	test   %eax,%eax
8010341e:	74 60                	je     80103480 <iderw+0xc0>
80103420:	89 c2                	mov    %eax,%edx
80103422:	8b 40 58             	mov    0x58(%eax),%eax
80103425:	85 c0                	test   %eax,%eax
80103427:	75 f7                	jne    80103420 <iderw+0x60>
80103429:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
8010342c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
8010342e:	39 1d a4 40 11 80    	cmp    %ebx,0x801140a4
80103434:	74 3a                	je     80103470 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80103436:	8b 03                	mov    (%ebx),%eax
80103438:	83 e0 06             	and    $0x6,%eax
8010343b:	83 f8 02             	cmp    $0x2,%eax
8010343e:	74 1b                	je     8010345b <iderw+0x9b>
    sleep(b, &idelock);
80103440:	83 ec 08             	sub    $0x8,%esp
80103443:	68 c0 40 11 80       	push   $0x801140c0
80103448:	53                   	push   %ebx
80103449:	e8 f2 1c 00 00       	call   80105140 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010344e:	8b 03                	mov    (%ebx),%eax
80103450:	83 c4 10             	add    $0x10,%esp
80103453:	83 e0 06             	and    $0x6,%eax
80103456:	83 f8 02             	cmp    $0x2,%eax
80103459:	75 e5                	jne    80103440 <iderw+0x80>
  }


  release(&idelock);
8010345b:	c7 45 08 c0 40 11 80 	movl   $0x801140c0,0x8(%ebp)
}
80103462:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103465:	c9                   	leave
  release(&idelock);
80103466:	e9 f5 27 00 00       	jmp    80105c60 <release>
8010346b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    idestart(b);
80103470:	89 d8                	mov    %ebx,%eax
80103472:	e8 49 fd ff ff       	call   801031c0 <idestart>
80103477:	eb bd                	jmp    80103436 <iderw+0x76>
80103479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80103480:	ba a4 40 11 80       	mov    $0x801140a4,%edx
80103485:	eb a5                	jmp    8010342c <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
80103487:	83 ec 0c             	sub    $0xc,%esp
8010348a:	68 ae 91 10 80       	push   $0x801091ae
8010348f:	e8 3c d0 ff ff       	call   801004d0 <panic>
    panic("iderw: nothing to do");
80103494:	83 ec 0c             	sub    $0xc,%esp
80103497:	68 99 91 10 80       	push   $0x80109199
8010349c:	e8 2f d0 ff ff       	call   801004d0 <panic>
    panic("iderw: buf not locked");
801034a1:	83 ec 0c             	sub    $0xc,%esp
801034a4:	68 83 91 10 80       	push   $0x80109183
801034a9:	e8 22 d0 ff ff       	call   801004d0 <panic>
801034ae:	66 90                	xchg   %ax,%ax

801034b0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801034b0:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801034b1:	c7 05 f4 40 11 80 00 	movl   $0xfec00000,0x801140f4
801034b8:	00 c0 fe 
{
801034bb:	89 e5                	mov    %esp,%ebp
801034bd:	56                   	push   %esi
801034be:	53                   	push   %ebx
  ioapic->reg = reg;
801034bf:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801034c6:	00 00 00 
  return ioapic->data;
801034c9:	8b 15 f4 40 11 80    	mov    0x801140f4,%edx
801034cf:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
801034d2:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
801034d8:	8b 0d f4 40 11 80    	mov    0x801140f4,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801034de:	0f b6 15 40 42 11 80 	movzbl 0x80114240,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801034e5:	c1 ee 10             	shr    $0x10,%esi
801034e8:	89 f0                	mov    %esi,%eax
801034ea:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
801034ed:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
801034f0:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
801034f3:	39 c2                	cmp    %eax,%edx
801034f5:	74 16                	je     8010350d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801034f7:	83 ec 0c             	sub    $0xc,%esp
801034fa:	68 2c 96 10 80       	push   $0x8010962c
801034ff:	e8 cc d2 ff ff       	call   801007d0 <cprintf>
  ioapic->reg = reg;
80103504:	8b 0d f4 40 11 80    	mov    0x801140f4,%ecx
8010350a:	83 c4 10             	add    $0x10,%esp
8010350d:	83 c6 21             	add    $0x21,%esi
{
80103510:	ba 10 00 00 00       	mov    $0x10,%edx
80103515:	b8 20 00 00 00       	mov    $0x20,%eax
8010351a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ioapic->reg = reg;
80103520:	89 11                	mov    %edx,(%ecx)

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80103522:	89 c3                	mov    %eax,%ebx
  ioapic->data = data;
80103524:	8b 0d f4 40 11 80    	mov    0x801140f4,%ecx
  for(i = 0; i <= maxintr; i++){
8010352a:	83 c0 01             	add    $0x1,%eax
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
8010352d:	81 cb 00 00 01 00    	or     $0x10000,%ebx
  ioapic->data = data;
80103533:	89 59 10             	mov    %ebx,0x10(%ecx)
  ioapic->reg = reg;
80103536:	8d 5a 01             	lea    0x1(%edx),%ebx
  for(i = 0; i <= maxintr; i++){
80103539:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
8010353c:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
8010353e:	8b 0d f4 40 11 80    	mov    0x801140f4,%ecx
80103544:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010354b:	39 f0                	cmp    %esi,%eax
8010354d:	75 d1                	jne    80103520 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010354f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103552:	5b                   	pop    %ebx
80103553:	5e                   	pop    %esi
80103554:	5d                   	pop    %ebp
80103555:	c3                   	ret
80103556:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010355d:	00 
8010355e:	66 90                	xchg   %ax,%ax

80103560 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80103560:	55                   	push   %ebp
  ioapic->reg = reg;
80103561:	8b 0d f4 40 11 80    	mov    0x801140f4,%ecx
{
80103567:	89 e5                	mov    %esp,%ebp
80103569:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010356c:	8d 50 20             	lea    0x20(%eax),%edx
8010356f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80103573:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80103575:	8b 0d f4 40 11 80    	mov    0x801140f4,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010357b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010357e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80103581:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80103584:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80103586:	a1 f4 40 11 80       	mov    0x801140f4,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010358b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010358e:	89 50 10             	mov    %edx,0x10(%eax)
}
80103591:	5d                   	pop    %ebp
80103592:	c3                   	ret
80103593:	66 90                	xchg   %ax,%ax
80103595:	66 90                	xchg   %ax,%ax
80103597:	66 90                	xchg   %ax,%ax
80103599:	66 90                	xchg   %ax,%ax
8010359b:	66 90                	xchg   %ax,%ax
8010359d:	66 90                	xchg   %ax,%ax
8010359f:	90                   	nop

801035a0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801035a0:	55                   	push   %ebp
801035a1:	89 e5                	mov    %esp,%ebp
801035a3:	53                   	push   %ebx
801035a4:	83 ec 04             	sub    $0x4,%esp
801035a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801035aa:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801035b0:	75 76                	jne    80103628 <kfree+0x88>
801035b2:	81 fb e0 ac 34 80    	cmp    $0x8034ace0,%ebx
801035b8:	72 6e                	jb     80103628 <kfree+0x88>
801035ba:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801035c0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801035c5:	77 61                	ja     80103628 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801035c7:	83 ec 04             	sub    $0x4,%esp
801035ca:	68 00 10 00 00       	push   $0x1000
801035cf:	6a 01                	push   $0x1
801035d1:	53                   	push   %ebx
801035d2:	e8 a9 27 00 00       	call   80105d80 <memset>

  if(kmem.use_lock)
801035d7:	8b 15 34 41 11 80    	mov    0x80114134,%edx
801035dd:	83 c4 10             	add    $0x10,%esp
801035e0:	85 d2                	test   %edx,%edx
801035e2:	75 1c                	jne    80103600 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801035e4:	a1 38 41 11 80       	mov    0x80114138,%eax
801035e9:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
801035eb:	a1 34 41 11 80       	mov    0x80114134,%eax
  kmem.freelist = r;
801035f0:	89 1d 38 41 11 80    	mov    %ebx,0x80114138
  if(kmem.use_lock)
801035f6:	85 c0                	test   %eax,%eax
801035f8:	75 1e                	jne    80103618 <kfree+0x78>
    release(&kmem.lock);
}
801035fa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801035fd:	c9                   	leave
801035fe:	c3                   	ret
801035ff:	90                   	nop
    acquire(&kmem.lock);
80103600:	83 ec 0c             	sub    $0xc,%esp
80103603:	68 00 41 11 80       	push   $0x80114100
80103608:	e8 b3 26 00 00       	call   80105cc0 <acquire>
8010360d:	83 c4 10             	add    $0x10,%esp
80103610:	eb d2                	jmp    801035e4 <kfree+0x44>
80103612:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80103618:	c7 45 08 00 41 11 80 	movl   $0x80114100,0x8(%ebp)
}
8010361f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103622:	c9                   	leave
    release(&kmem.lock);
80103623:	e9 38 26 00 00       	jmp    80105c60 <release>
    panic("kfree");
80103628:	83 ec 0c             	sub    $0xc,%esp
8010362b:	68 cc 91 10 80       	push   $0x801091cc
80103630:	e8 9b ce ff ff       	call   801004d0 <panic>
80103635:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010363c:	00 
8010363d:	8d 76 00             	lea    0x0(%esi),%esi

80103640 <freerange>:
{
80103640:	55                   	push   %ebp
80103641:	89 e5                	mov    %esp,%ebp
80103643:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80103644:	8b 45 08             	mov    0x8(%ebp),%eax
{
80103647:	8b 75 0c             	mov    0xc(%ebp),%esi
8010364a:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
8010364b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80103651:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103657:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010365d:	39 de                	cmp    %ebx,%esi
8010365f:	72 23                	jb     80103684 <freerange+0x44>
80103661:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80103668:	83 ec 0c             	sub    $0xc,%esp
8010366b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103671:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80103677:	50                   	push   %eax
80103678:	e8 23 ff ff ff       	call   801035a0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010367d:	83 c4 10             	add    $0x10,%esp
80103680:	39 f3                	cmp    %esi,%ebx
80103682:	76 e4                	jbe    80103668 <freerange+0x28>
}
80103684:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103687:	5b                   	pop    %ebx
80103688:	5e                   	pop    %esi
80103689:	5d                   	pop    %ebp
8010368a:	c3                   	ret
8010368b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103690 <kinit2>:
{
80103690:	55                   	push   %ebp
80103691:	89 e5                	mov    %esp,%ebp
80103693:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80103694:	8b 45 08             	mov    0x8(%ebp),%eax
{
80103697:	8b 75 0c             	mov    0xc(%ebp),%esi
8010369a:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
8010369b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801036a1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801036a7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801036ad:	39 de                	cmp    %ebx,%esi
801036af:	72 23                	jb     801036d4 <kinit2+0x44>
801036b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801036b8:	83 ec 0c             	sub    $0xc,%esp
801036bb:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801036c1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801036c7:	50                   	push   %eax
801036c8:	e8 d3 fe ff ff       	call   801035a0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801036cd:	83 c4 10             	add    $0x10,%esp
801036d0:	39 de                	cmp    %ebx,%esi
801036d2:	73 e4                	jae    801036b8 <kinit2+0x28>
  kmem.use_lock = 1;
801036d4:	c7 05 34 41 11 80 01 	movl   $0x1,0x80114134
801036db:	00 00 00 
}
801036de:	8d 65 f8             	lea    -0x8(%ebp),%esp
801036e1:	5b                   	pop    %ebx
801036e2:	5e                   	pop    %esi
801036e3:	5d                   	pop    %ebp
801036e4:	c3                   	ret
801036e5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801036ec:	00 
801036ed:	8d 76 00             	lea    0x0(%esi),%esi

801036f0 <kinit1>:
{
801036f0:	55                   	push   %ebp
801036f1:	89 e5                	mov    %esp,%ebp
801036f3:	56                   	push   %esi
801036f4:	53                   	push   %ebx
801036f5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801036f8:	83 ec 08             	sub    $0x8,%esp
801036fb:	68 d2 91 10 80       	push   $0x801091d2
80103700:	68 00 41 11 80       	push   $0x80114100
80103705:	e8 e6 23 00 00       	call   80105af0 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010370a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010370d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80103710:	c7 05 34 41 11 80 00 	movl   $0x0,0x80114134
80103717:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010371a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80103720:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103726:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010372c:	39 de                	cmp    %ebx,%esi
8010372e:	72 1c                	jb     8010374c <kinit1+0x5c>
    kfree(p);
80103730:	83 ec 0c             	sub    $0xc,%esp
80103733:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103739:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010373f:	50                   	push   %eax
80103740:	e8 5b fe ff ff       	call   801035a0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103745:	83 c4 10             	add    $0x10,%esp
80103748:	39 de                	cmp    %ebx,%esi
8010374a:	73 e4                	jae    80103730 <kinit1+0x40>
}
8010374c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010374f:	5b                   	pop    %ebx
80103750:	5e                   	pop    %esi
80103751:	5d                   	pop    %ebp
80103752:	c3                   	ret
80103753:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010375a:	00 
8010375b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103760 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
80103760:	a1 34 41 11 80       	mov    0x80114134,%eax
80103765:	85 c0                	test   %eax,%eax
80103767:	75 1f                	jne    80103788 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
80103769:	a1 38 41 11 80       	mov    0x80114138,%eax
  if(r)
8010376e:	85 c0                	test   %eax,%eax
80103770:	74 0e                	je     80103780 <kalloc+0x20>
    kmem.freelist = r->next;
80103772:	8b 10                	mov    (%eax),%edx
80103774:	89 15 38 41 11 80    	mov    %edx,0x80114138
  if(kmem.use_lock)
8010377a:	c3                   	ret
8010377b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    release(&kmem.lock);
  return (char*)r;
}
80103780:	c3                   	ret
80103781:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
80103788:	55                   	push   %ebp
80103789:	89 e5                	mov    %esp,%ebp
8010378b:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
8010378e:	68 00 41 11 80       	push   $0x80114100
80103793:	e8 28 25 00 00       	call   80105cc0 <acquire>
  r = kmem.freelist;
80103798:	a1 38 41 11 80       	mov    0x80114138,%eax
  if(kmem.use_lock)
8010379d:	8b 15 34 41 11 80    	mov    0x80114134,%edx
  if(r)
801037a3:	83 c4 10             	add    $0x10,%esp
801037a6:	85 c0                	test   %eax,%eax
801037a8:	74 08                	je     801037b2 <kalloc+0x52>
    kmem.freelist = r->next;
801037aa:	8b 08                	mov    (%eax),%ecx
801037ac:	89 0d 38 41 11 80    	mov    %ecx,0x80114138
  if(kmem.use_lock)
801037b2:	85 d2                	test   %edx,%edx
801037b4:	74 16                	je     801037cc <kalloc+0x6c>
    release(&kmem.lock);
801037b6:	83 ec 0c             	sub    $0xc,%esp
801037b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
801037bc:	68 00 41 11 80       	push   $0x80114100
801037c1:	e8 9a 24 00 00       	call   80105c60 <release>
  return (char*)r;
801037c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
801037c9:	83 c4 10             	add    $0x10,%esp
}
801037cc:	c9                   	leave
801037cd:	c3                   	ret
801037ce:	66 90                	xchg   %ax,%ax

801037d0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801037d0:	ba 64 00 00 00       	mov    $0x64,%edx
801037d5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801037d6:	a8 01                	test   $0x1,%al
801037d8:	0f 84 ca 00 00 00    	je     801038a8 <kbdgetc+0xd8>
{
801037de:	55                   	push   %ebp
801037df:	ba 60 00 00 00       	mov    $0x60,%edx
801037e4:	89 e5                	mov    %esp,%ebp
801037e6:	53                   	push   %ebx
801037e7:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
801037e8:	8b 1d 3c 41 11 80    	mov    0x8011413c,%ebx
  data = inb(KBDATAP);
801037ee:	0f b6 c8             	movzbl %al,%ecx
  if(data == 0xE0){
801037f1:	3c e0                	cmp    $0xe0,%al
801037f3:	74 5b                	je     80103850 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
801037f5:	89 da                	mov    %ebx,%edx
801037f7:	83 e2 40             	and    $0x40,%edx
  } else if(data & 0x80){
801037fa:	84 c0                	test   %al,%al
801037fc:	78 62                	js     80103860 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
801037fe:	85 d2                	test   %edx,%edx
80103800:	74 09                	je     8010380b <kbdgetc+0x3b>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80103802:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80103805:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80103808:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
8010380b:	0f b6 91 80 9c 10 80 	movzbl -0x7fef6380(%ecx),%edx
  shift ^= togglecode[data];
80103812:	0f b6 81 80 9b 10 80 	movzbl -0x7fef6480(%ecx),%eax
  shift |= shiftcode[data];
80103819:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
8010381b:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010381d:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
8010381f:	89 15 3c 41 11 80    	mov    %edx,0x8011413c
  c = charcode[shift & (CTL | SHIFT)][data];
80103825:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80103828:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010382b:	8b 04 85 60 9b 10 80 	mov    -0x7fef64a0(,%eax,4),%eax
80103832:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80103836:	74 0b                	je     80103843 <kbdgetc+0x73>
    if('a' <= c && c <= 'z')
80103838:	8d 50 9f             	lea    -0x61(%eax),%edx
8010383b:	83 fa 19             	cmp    $0x19,%edx
8010383e:	77 50                	ja     80103890 <kbdgetc+0xc0>
      c += 'A' - 'a';
80103840:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80103843:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103846:	c9                   	leave
80103847:	c3                   	ret
80103848:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010384f:	00 
    shift |= E0ESC;
80103850:	83 cb 40             	or     $0x40,%ebx
    return 0;
80103853:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80103855:	89 1d 3c 41 11 80    	mov    %ebx,0x8011413c
}
8010385b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010385e:	c9                   	leave
8010385f:	c3                   	ret
    data = (shift & E0ESC ? data : data & 0x7F);
80103860:	83 e0 7f             	and    $0x7f,%eax
80103863:	85 d2                	test   %edx,%edx
80103865:	0f 44 c8             	cmove  %eax,%ecx
    return 0;
80103868:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
8010386a:	0f b6 91 80 9c 10 80 	movzbl -0x7fef6380(%ecx),%edx
80103871:	83 ca 40             	or     $0x40,%edx
80103874:	0f b6 d2             	movzbl %dl,%edx
80103877:	f7 d2                	not    %edx
80103879:	21 da                	and    %ebx,%edx
}
8010387b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    shift &= ~(shiftcode[data] | E0ESC);
8010387e:	89 15 3c 41 11 80    	mov    %edx,0x8011413c
}
80103884:	c9                   	leave
80103885:	c3                   	ret
80103886:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010388d:	00 
8010388e:	66 90                	xchg   %ax,%ax
    else if('A' <= c && c <= 'Z')
80103890:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80103893:	8d 50 20             	lea    0x20(%eax),%edx
}
80103896:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103899:	c9                   	leave
      c += 'a' - 'A';
8010389a:	83 f9 1a             	cmp    $0x1a,%ecx
8010389d:	0f 42 c2             	cmovb  %edx,%eax
}
801038a0:	c3                   	ret
801038a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801038a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801038ad:	c3                   	ret
801038ae:	66 90                	xchg   %ax,%ax

801038b0 <kbdintr>:

void
kbdintr(void)
{
801038b0:	55                   	push   %ebp
801038b1:	89 e5                	mov    %esp,%ebp
801038b3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801038b6:	68 d0 37 10 80       	push   $0x801037d0
801038bb:	e8 00 d7 ff ff       	call   80100fc0 <consoleintr>
}
801038c0:	83 c4 10             	add    $0x10,%esp
801038c3:	c9                   	leave
801038c4:	c3                   	ret
801038c5:	66 90                	xchg   %ax,%ax
801038c7:	66 90                	xchg   %ax,%ax
801038c9:	66 90                	xchg   %ax,%ax
801038cb:	66 90                	xchg   %ax,%ax
801038cd:	66 90                	xchg   %ax,%ax
801038cf:	90                   	nop

801038d0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801038d0:	a1 40 41 11 80       	mov    0x80114140,%eax
801038d5:	85 c0                	test   %eax,%eax
801038d7:	0f 84 cb 00 00 00    	je     801039a8 <lapicinit+0xd8>
  lapic[index] = value;
801038dd:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801038e4:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801038e7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801038ea:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
801038f1:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801038f4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801038f7:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801038fe:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80103901:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103904:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010390b:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
8010390e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103911:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80103918:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010391b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010391e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80103925:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80103928:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010392b:	8b 50 30             	mov    0x30(%eax),%edx
8010392e:	c1 ea 10             	shr    $0x10,%edx
80103931:	81 e2 fc 00 00 00    	and    $0xfc,%edx
80103937:	75 77                	jne    801039b0 <lapicinit+0xe0>
  lapic[index] = value;
80103939:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80103940:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103943:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103946:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010394d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103950:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103953:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010395a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010395d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103960:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80103967:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010396a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010396d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80103974:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103977:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010397a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80103981:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80103984:	8b 50 20             	mov    0x20(%eax),%edx
80103987:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010398e:	00 
8010398f:	90                   	nop
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80103990:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80103996:	80 e6 10             	and    $0x10,%dh
80103999:	75 f5                	jne    80103990 <lapicinit+0xc0>
  lapic[index] = value;
8010399b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801039a2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801039a5:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801039a8:	c3                   	ret
801039a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
801039b0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801039b7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801039ba:	8b 50 20             	mov    0x20(%eax),%edx
}
801039bd:	e9 77 ff ff ff       	jmp    80103939 <lapicinit+0x69>
801039c2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801039c9:	00 
801039ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801039d0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
801039d0:	a1 40 41 11 80       	mov    0x80114140,%eax
801039d5:	85 c0                	test   %eax,%eax
801039d7:	74 07                	je     801039e0 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
801039d9:	8b 40 20             	mov    0x20(%eax),%eax
801039dc:	c1 e8 18             	shr    $0x18,%eax
801039df:	c3                   	ret
    return 0;
801039e0:	31 c0                	xor    %eax,%eax
}
801039e2:	c3                   	ret
801039e3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801039ea:	00 
801039eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801039f0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
801039f0:	a1 40 41 11 80       	mov    0x80114140,%eax
801039f5:	85 c0                	test   %eax,%eax
801039f7:	74 0d                	je     80103a06 <lapiceoi+0x16>
  lapic[index] = value;
801039f9:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80103a00:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103a03:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80103a06:	c3                   	ret
80103a07:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103a0e:	00 
80103a0f:	90                   	nop

80103a10 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80103a10:	c3                   	ret
80103a11:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103a18:	00 
80103a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103a20 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80103a20:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103a21:	b8 0f 00 00 00       	mov    $0xf,%eax
80103a26:	ba 70 00 00 00       	mov    $0x70,%edx
80103a2b:	89 e5                	mov    %esp,%ebp
80103a2d:	53                   	push   %ebx
80103a2e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103a31:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103a34:	ee                   	out    %al,(%dx)
80103a35:	b8 0a 00 00 00       	mov    $0xa,%eax
80103a3a:	ba 71 00 00 00       	mov    $0x71,%edx
80103a3f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80103a40:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80103a42:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80103a45:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80103a4b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80103a4d:	c1 e9 0c             	shr    $0xc,%ecx
  lapicw(ICRHI, apicid<<24);
80103a50:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80103a52:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80103a55:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80103a58:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80103a5e:	a1 40 41 11 80       	mov    0x80114140,%eax
80103a63:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103a69:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80103a6c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80103a73:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103a76:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80103a79:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80103a80:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103a83:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80103a86:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103a8c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80103a8f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103a95:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80103a98:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103a9e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103aa1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103aa7:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
80103aaa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103aad:	c9                   	leave
80103aae:	c3                   	ret
80103aaf:	90                   	nop

80103ab0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80103ab0:	55                   	push   %ebp
80103ab1:	b8 0b 00 00 00       	mov    $0xb,%eax
80103ab6:	ba 70 00 00 00       	mov    $0x70,%edx
80103abb:	89 e5                	mov    %esp,%ebp
80103abd:	57                   	push   %edi
80103abe:	56                   	push   %esi
80103abf:	53                   	push   %ebx
80103ac0:	83 ec 4c             	sub    $0x4c,%esp
80103ac3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103ac4:	ba 71 00 00 00       	mov    $0x71,%edx
80103ac9:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
80103aca:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103acd:	bb 70 00 00 00       	mov    $0x70,%ebx
80103ad2:	88 45 b3             	mov    %al,-0x4d(%ebp)
80103ad5:	8d 76 00             	lea    0x0(%esi),%esi
80103ad8:	31 c0                	xor    %eax,%eax
80103ada:	89 da                	mov    %ebx,%edx
80103adc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103add:	b9 71 00 00 00       	mov    $0x71,%ecx
80103ae2:	89 ca                	mov    %ecx,%edx
80103ae4:	ec                   	in     (%dx),%al
80103ae5:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103ae8:	89 da                	mov    %ebx,%edx
80103aea:	b8 02 00 00 00       	mov    $0x2,%eax
80103aef:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103af0:	89 ca                	mov    %ecx,%edx
80103af2:	ec                   	in     (%dx),%al
80103af3:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103af6:	89 da                	mov    %ebx,%edx
80103af8:	b8 04 00 00 00       	mov    $0x4,%eax
80103afd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103afe:	89 ca                	mov    %ecx,%edx
80103b00:	ec                   	in     (%dx),%al
80103b01:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103b04:	89 da                	mov    %ebx,%edx
80103b06:	b8 07 00 00 00       	mov    $0x7,%eax
80103b0b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103b0c:	89 ca                	mov    %ecx,%edx
80103b0e:	ec                   	in     (%dx),%al
80103b0f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103b12:	89 da                	mov    %ebx,%edx
80103b14:	b8 08 00 00 00       	mov    $0x8,%eax
80103b19:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103b1a:	89 ca                	mov    %ecx,%edx
80103b1c:	ec                   	in     (%dx),%al
80103b1d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103b1f:	89 da                	mov    %ebx,%edx
80103b21:	b8 09 00 00 00       	mov    $0x9,%eax
80103b26:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103b27:	89 ca                	mov    %ecx,%edx
80103b29:	ec                   	in     (%dx),%al
80103b2a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103b2c:	89 da                	mov    %ebx,%edx
80103b2e:	b8 0a 00 00 00       	mov    $0xa,%eax
80103b33:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103b34:	89 ca                	mov    %ecx,%edx
80103b36:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80103b37:	84 c0                	test   %al,%al
80103b39:	78 9d                	js     80103ad8 <cmostime+0x28>
  return inb(CMOS_RETURN);
80103b3b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80103b3f:	89 fa                	mov    %edi,%edx
80103b41:	0f b6 fa             	movzbl %dl,%edi
80103b44:	89 f2                	mov    %esi,%edx
80103b46:	89 45 b8             	mov    %eax,-0x48(%ebp)
80103b49:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80103b4d:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103b50:	89 da                	mov    %ebx,%edx
80103b52:	89 7d c8             	mov    %edi,-0x38(%ebp)
80103b55:	89 45 bc             	mov    %eax,-0x44(%ebp)
80103b58:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80103b5c:	89 75 cc             	mov    %esi,-0x34(%ebp)
80103b5f:	89 45 c0             	mov    %eax,-0x40(%ebp)
80103b62:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80103b66:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80103b69:	31 c0                	xor    %eax,%eax
80103b6b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103b6c:	89 ca                	mov    %ecx,%edx
80103b6e:	ec                   	in     (%dx),%al
80103b6f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103b72:	89 da                	mov    %ebx,%edx
80103b74:	89 45 d0             	mov    %eax,-0x30(%ebp)
80103b77:	b8 02 00 00 00       	mov    $0x2,%eax
80103b7c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103b7d:	89 ca                	mov    %ecx,%edx
80103b7f:	ec                   	in     (%dx),%al
80103b80:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103b83:	89 da                	mov    %ebx,%edx
80103b85:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80103b88:	b8 04 00 00 00       	mov    $0x4,%eax
80103b8d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103b8e:	89 ca                	mov    %ecx,%edx
80103b90:	ec                   	in     (%dx),%al
80103b91:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103b94:	89 da                	mov    %ebx,%edx
80103b96:	89 45 d8             	mov    %eax,-0x28(%ebp)
80103b99:	b8 07 00 00 00       	mov    $0x7,%eax
80103b9e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103b9f:	89 ca                	mov    %ecx,%edx
80103ba1:	ec                   	in     (%dx),%al
80103ba2:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103ba5:	89 da                	mov    %ebx,%edx
80103ba7:	89 45 dc             	mov    %eax,-0x24(%ebp)
80103baa:	b8 08 00 00 00       	mov    $0x8,%eax
80103baf:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103bb0:	89 ca                	mov    %ecx,%edx
80103bb2:	ec                   	in     (%dx),%al
80103bb3:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103bb6:	89 da                	mov    %ebx,%edx
80103bb8:	89 45 e0             	mov    %eax,-0x20(%ebp)
80103bbb:	b8 09 00 00 00       	mov    $0x9,%eax
80103bc0:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103bc1:	89 ca                	mov    %ecx,%edx
80103bc3:	ec                   	in     (%dx),%al
80103bc4:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80103bc7:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80103bca:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80103bcd:	8d 45 d0             	lea    -0x30(%ebp),%eax
80103bd0:	6a 18                	push   $0x18
80103bd2:	50                   	push   %eax
80103bd3:	8d 45 b8             	lea    -0x48(%ebp),%eax
80103bd6:	50                   	push   %eax
80103bd7:	e8 f4 21 00 00       	call   80105dd0 <memcmp>
80103bdc:	83 c4 10             	add    $0x10,%esp
80103bdf:	85 c0                	test   %eax,%eax
80103be1:	0f 85 f1 fe ff ff    	jne    80103ad8 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80103be7:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80103beb:	75 78                	jne    80103c65 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80103bed:	8b 45 b8             	mov    -0x48(%ebp),%eax
80103bf0:	89 c2                	mov    %eax,%edx
80103bf2:	83 e0 0f             	and    $0xf,%eax
80103bf5:	c1 ea 04             	shr    $0x4,%edx
80103bf8:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103bfb:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103bfe:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80103c01:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103c04:	89 c2                	mov    %eax,%edx
80103c06:	83 e0 0f             	and    $0xf,%eax
80103c09:	c1 ea 04             	shr    $0x4,%edx
80103c0c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103c0f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103c12:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80103c15:	8b 45 c0             	mov    -0x40(%ebp),%eax
80103c18:	89 c2                	mov    %eax,%edx
80103c1a:	83 e0 0f             	and    $0xf,%eax
80103c1d:	c1 ea 04             	shr    $0x4,%edx
80103c20:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103c23:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103c26:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80103c29:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80103c2c:	89 c2                	mov    %eax,%edx
80103c2e:	83 e0 0f             	and    $0xf,%eax
80103c31:	c1 ea 04             	shr    $0x4,%edx
80103c34:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103c37:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103c3a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80103c3d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103c40:	89 c2                	mov    %eax,%edx
80103c42:	83 e0 0f             	and    $0xf,%eax
80103c45:	c1 ea 04             	shr    $0x4,%edx
80103c48:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103c4b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103c4e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80103c51:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103c54:	89 c2                	mov    %eax,%edx
80103c56:	83 e0 0f             	and    $0xf,%eax
80103c59:	c1 ea 04             	shr    $0x4,%edx
80103c5c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103c5f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103c62:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80103c65:	8b 75 08             	mov    0x8(%ebp),%esi
80103c68:	8b 45 b8             	mov    -0x48(%ebp),%eax
80103c6b:	89 06                	mov    %eax,(%esi)
80103c6d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103c70:	89 46 04             	mov    %eax,0x4(%esi)
80103c73:	8b 45 c0             	mov    -0x40(%ebp),%eax
80103c76:	89 46 08             	mov    %eax,0x8(%esi)
80103c79:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80103c7c:	89 46 0c             	mov    %eax,0xc(%esi)
80103c7f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103c82:	89 46 10             	mov    %eax,0x10(%esi)
80103c85:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103c88:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80103c8b:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80103c92:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103c95:	5b                   	pop    %ebx
80103c96:	5e                   	pop    %esi
80103c97:	5f                   	pop    %edi
80103c98:	5d                   	pop    %ebp
80103c99:	c3                   	ret
80103c9a:	66 90                	xchg   %ax,%ax
80103c9c:	66 90                	xchg   %ax,%ax
80103c9e:	66 90                	xchg   %ax,%ax

80103ca0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103ca0:	8b 0d a8 41 11 80    	mov    0x801141a8,%ecx
80103ca6:	85 c9                	test   %ecx,%ecx
80103ca8:	0f 8e 8a 00 00 00    	jle    80103d38 <install_trans+0x98>
{
80103cae:	55                   	push   %ebp
80103caf:	89 e5                	mov    %esp,%ebp
80103cb1:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80103cb2:	31 ff                	xor    %edi,%edi
{
80103cb4:	56                   	push   %esi
80103cb5:	53                   	push   %ebx
80103cb6:	83 ec 0c             	sub    $0xc,%esp
80103cb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80103cc0:	a1 94 41 11 80       	mov    0x80114194,%eax
80103cc5:	83 ec 08             	sub    $0x8,%esp
80103cc8:	01 f8                	add    %edi,%eax
80103cca:	83 c0 01             	add    $0x1,%eax
80103ccd:	50                   	push   %eax
80103cce:	ff 35 a4 41 11 80    	push   0x801141a4
80103cd4:	e8 f7 c3 ff ff       	call   801000d0 <bread>
80103cd9:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80103cdb:	58                   	pop    %eax
80103cdc:	5a                   	pop    %edx
80103cdd:	ff 34 bd ac 41 11 80 	push   -0x7feebe54(,%edi,4)
80103ce4:	ff 35 a4 41 11 80    	push   0x801141a4
  for (tail = 0; tail < log.lh.n; tail++) {
80103cea:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80103ced:	e8 de c3 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103cf2:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80103cf5:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103cf7:	8d 46 5c             	lea    0x5c(%esi),%eax
80103cfa:	68 00 02 00 00       	push   $0x200
80103cff:	50                   	push   %eax
80103d00:	8d 43 5c             	lea    0x5c(%ebx),%eax
80103d03:	50                   	push   %eax
80103d04:	e8 17 21 00 00       	call   80105e20 <memmove>
    bwrite(dbuf);  // write dst to disk
80103d09:	89 1c 24             	mov    %ebx,(%esp)
80103d0c:	e8 9f c4 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80103d11:	89 34 24             	mov    %esi,(%esp)
80103d14:	e8 d7 c4 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80103d19:	89 1c 24             	mov    %ebx,(%esp)
80103d1c:	e8 cf c4 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103d21:	83 c4 10             	add    $0x10,%esp
80103d24:	39 3d a8 41 11 80    	cmp    %edi,0x801141a8
80103d2a:	7f 94                	jg     80103cc0 <install_trans+0x20>
  }
}
80103d2c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103d2f:	5b                   	pop    %ebx
80103d30:	5e                   	pop    %esi
80103d31:	5f                   	pop    %edi
80103d32:	5d                   	pop    %ebp
80103d33:	c3                   	ret
80103d34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103d38:	c3                   	ret
80103d39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103d40 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80103d40:	55                   	push   %ebp
80103d41:	89 e5                	mov    %esp,%ebp
80103d43:	53                   	push   %ebx
80103d44:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80103d47:	ff 35 94 41 11 80    	push   0x80114194
80103d4d:	ff 35 a4 41 11 80    	push   0x801141a4
80103d53:	e8 78 c3 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80103d58:	8b 0d a8 41 11 80    	mov    0x801141a8,%ecx
  for (i = 0; i < log.lh.n; i++) {
80103d5e:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80103d61:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80103d63:	89 48 5c             	mov    %ecx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80103d66:	85 c9                	test   %ecx,%ecx
80103d68:	7e 18                	jle    80103d82 <write_head+0x42>
80103d6a:	31 c0                	xor    %eax,%eax
80103d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80103d70:	8b 14 85 ac 41 11 80 	mov    -0x7feebe54(,%eax,4),%edx
80103d77:	89 54 83 60          	mov    %edx,0x60(%ebx,%eax,4)
  for (i = 0; i < log.lh.n; i++) {
80103d7b:	83 c0 01             	add    $0x1,%eax
80103d7e:	39 c1                	cmp    %eax,%ecx
80103d80:	75 ee                	jne    80103d70 <write_head+0x30>
  }
  bwrite(buf);
80103d82:	83 ec 0c             	sub    $0xc,%esp
80103d85:	53                   	push   %ebx
80103d86:	e8 25 c4 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
80103d8b:	89 1c 24             	mov    %ebx,(%esp)
80103d8e:	e8 5d c4 ff ff       	call   801001f0 <brelse>
}
80103d93:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d96:	83 c4 10             	add    $0x10,%esp
80103d99:	c9                   	leave
80103d9a:	c3                   	ret
80103d9b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103da0 <initlog>:
{
80103da0:	55                   	push   %ebp
80103da1:	89 e5                	mov    %esp,%ebp
80103da3:	53                   	push   %ebx
80103da4:	83 ec 2c             	sub    $0x2c,%esp
80103da7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80103daa:	68 d7 91 10 80       	push   $0x801091d7
80103daf:	68 60 41 11 80       	push   $0x80114160
80103db4:	e8 37 1d 00 00       	call   80105af0 <initlock>
  readsb(dev, &sb);
80103db9:	58                   	pop    %eax
80103dba:	8d 45 dc             	lea    -0x24(%ebp),%eax
80103dbd:	5a                   	pop    %edx
80103dbe:	50                   	push   %eax
80103dbf:	53                   	push   %ebx
80103dc0:	e8 3b e8 ff ff       	call   80102600 <readsb>
  log.start = sb.logstart;
80103dc5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80103dc8:	59                   	pop    %ecx
  log.dev = dev;
80103dc9:	89 1d a4 41 11 80    	mov    %ebx,0x801141a4
  log.size = sb.nlog;
80103dcf:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80103dd2:	a3 94 41 11 80       	mov    %eax,0x80114194
  log.size = sb.nlog;
80103dd7:	89 15 98 41 11 80    	mov    %edx,0x80114198
  struct buf *buf = bread(log.dev, log.start);
80103ddd:	5a                   	pop    %edx
80103dde:	50                   	push   %eax
80103ddf:	53                   	push   %ebx
80103de0:	e8 eb c2 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80103de5:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80103de8:	8b 58 5c             	mov    0x5c(%eax),%ebx
  struct buf *buf = bread(log.dev, log.start);
80103deb:	89 c1                	mov    %eax,%ecx
  log.lh.n = lh->n;
80103ded:	89 1d a8 41 11 80    	mov    %ebx,0x801141a8
  for (i = 0; i < log.lh.n; i++) {
80103df3:	85 db                	test   %ebx,%ebx
80103df5:	7e 1b                	jle    80103e12 <initlog+0x72>
80103df7:	31 c0                	xor    %eax,%eax
80103df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    log.lh.block[i] = lh->block[i];
80103e00:	8b 54 81 60          	mov    0x60(%ecx,%eax,4),%edx
80103e04:	89 14 85 ac 41 11 80 	mov    %edx,-0x7feebe54(,%eax,4)
  for (i = 0; i < log.lh.n; i++) {
80103e0b:	83 c0 01             	add    $0x1,%eax
80103e0e:	39 c3                	cmp    %eax,%ebx
80103e10:	75 ee                	jne    80103e00 <initlog+0x60>
  brelse(buf);
80103e12:	83 ec 0c             	sub    $0xc,%esp
80103e15:	51                   	push   %ecx
80103e16:	e8 d5 c3 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80103e1b:	e8 80 fe ff ff       	call   80103ca0 <install_trans>
  log.lh.n = 0;
80103e20:	c7 05 a8 41 11 80 00 	movl   $0x0,0x801141a8
80103e27:	00 00 00 
  write_head(); // clear the log
80103e2a:	e8 11 ff ff ff       	call   80103d40 <write_head>
}
80103e2f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103e32:	83 c4 10             	add    $0x10,%esp
80103e35:	c9                   	leave
80103e36:	c3                   	ret
80103e37:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103e3e:	00 
80103e3f:	90                   	nop

80103e40 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80103e40:	55                   	push   %ebp
80103e41:	89 e5                	mov    %esp,%ebp
80103e43:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80103e46:	68 60 41 11 80       	push   $0x80114160
80103e4b:	e8 70 1e 00 00       	call   80105cc0 <acquire>
80103e50:	83 c4 10             	add    $0x10,%esp
80103e53:	eb 18                	jmp    80103e6d <begin_op+0x2d>
80103e55:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80103e58:	83 ec 08             	sub    $0x8,%esp
80103e5b:	68 60 41 11 80       	push   $0x80114160
80103e60:	68 60 41 11 80       	push   $0x80114160
80103e65:	e8 d6 12 00 00       	call   80105140 <sleep>
80103e6a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80103e6d:	a1 a0 41 11 80       	mov    0x801141a0,%eax
80103e72:	85 c0                	test   %eax,%eax
80103e74:	75 e2                	jne    80103e58 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80103e76:	a1 9c 41 11 80       	mov    0x8011419c,%eax
80103e7b:	8b 15 a8 41 11 80    	mov    0x801141a8,%edx
80103e81:	83 c0 01             	add    $0x1,%eax
80103e84:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80103e87:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80103e8a:	83 fa 1e             	cmp    $0x1e,%edx
80103e8d:	7f c9                	jg     80103e58 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80103e8f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80103e92:	a3 9c 41 11 80       	mov    %eax,0x8011419c
      release(&log.lock);
80103e97:	68 60 41 11 80       	push   $0x80114160
80103e9c:	e8 bf 1d 00 00       	call   80105c60 <release>
      break;
    }
  }
}
80103ea1:	83 c4 10             	add    $0x10,%esp
80103ea4:	c9                   	leave
80103ea5:	c3                   	ret
80103ea6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103ead:	00 
80103eae:	66 90                	xchg   %ax,%ax

80103eb0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80103eb0:	55                   	push   %ebp
80103eb1:	89 e5                	mov    %esp,%ebp
80103eb3:	57                   	push   %edi
80103eb4:	56                   	push   %esi
80103eb5:	53                   	push   %ebx
80103eb6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80103eb9:	68 60 41 11 80       	push   $0x80114160
80103ebe:	e8 fd 1d 00 00       	call   80105cc0 <acquire>
  log.outstanding -= 1;
80103ec3:	a1 9c 41 11 80       	mov    0x8011419c,%eax
  if(log.committing)
80103ec8:	8b 35 a0 41 11 80    	mov    0x801141a0,%esi
80103ece:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80103ed1:	8d 58 ff             	lea    -0x1(%eax),%ebx
80103ed4:	89 1d 9c 41 11 80    	mov    %ebx,0x8011419c
  if(log.committing)
80103eda:	85 f6                	test   %esi,%esi
80103edc:	0f 85 22 01 00 00    	jne    80104004 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80103ee2:	85 db                	test   %ebx,%ebx
80103ee4:	0f 85 f6 00 00 00    	jne    80103fe0 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
80103eea:	c7 05 a0 41 11 80 01 	movl   $0x1,0x801141a0
80103ef1:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80103ef4:	83 ec 0c             	sub    $0xc,%esp
80103ef7:	68 60 41 11 80       	push   $0x80114160
80103efc:	e8 5f 1d 00 00       	call   80105c60 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80103f01:	8b 0d a8 41 11 80    	mov    0x801141a8,%ecx
80103f07:	83 c4 10             	add    $0x10,%esp
80103f0a:	85 c9                	test   %ecx,%ecx
80103f0c:	7f 42                	jg     80103f50 <end_op+0xa0>
    acquire(&log.lock);
80103f0e:	83 ec 0c             	sub    $0xc,%esp
80103f11:	68 60 41 11 80       	push   $0x80114160
80103f16:	e8 a5 1d 00 00       	call   80105cc0 <acquire>
    wakeup(&log);
80103f1b:	c7 04 24 60 41 11 80 	movl   $0x80114160,(%esp)
    log.committing = 0;
80103f22:	c7 05 a0 41 11 80 00 	movl   $0x0,0x801141a0
80103f29:	00 00 00 
    wakeup(&log);
80103f2c:	e8 cf 12 00 00       	call   80105200 <wakeup>
    release(&log.lock);
80103f31:	c7 04 24 60 41 11 80 	movl   $0x80114160,(%esp)
80103f38:	e8 23 1d 00 00       	call   80105c60 <release>
80103f3d:	83 c4 10             	add    $0x10,%esp
}
80103f40:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f43:	5b                   	pop    %ebx
80103f44:	5e                   	pop    %esi
80103f45:	5f                   	pop    %edi
80103f46:	5d                   	pop    %ebp
80103f47:	c3                   	ret
80103f48:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103f4f:	00 
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103f50:	a1 94 41 11 80       	mov    0x80114194,%eax
80103f55:	83 ec 08             	sub    $0x8,%esp
80103f58:	01 d8                	add    %ebx,%eax
80103f5a:	83 c0 01             	add    $0x1,%eax
80103f5d:	50                   	push   %eax
80103f5e:	ff 35 a4 41 11 80    	push   0x801141a4
80103f64:	e8 67 c1 ff ff       	call   801000d0 <bread>
80103f69:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103f6b:	58                   	pop    %eax
80103f6c:	5a                   	pop    %edx
80103f6d:	ff 34 9d ac 41 11 80 	push   -0x7feebe54(,%ebx,4)
80103f74:	ff 35 a4 41 11 80    	push   0x801141a4
  for (tail = 0; tail < log.lh.n; tail++) {
80103f7a:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103f7d:	e8 4e c1 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80103f82:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103f85:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103f87:	8d 40 5c             	lea    0x5c(%eax),%eax
80103f8a:	68 00 02 00 00       	push   $0x200
80103f8f:	50                   	push   %eax
80103f90:	8d 46 5c             	lea    0x5c(%esi),%eax
80103f93:	50                   	push   %eax
80103f94:	e8 87 1e 00 00       	call   80105e20 <memmove>
    bwrite(to);  // write the log
80103f99:	89 34 24             	mov    %esi,(%esp)
80103f9c:	e8 0f c2 ff ff       	call   801001b0 <bwrite>
    brelse(from);
80103fa1:	89 3c 24             	mov    %edi,(%esp)
80103fa4:	e8 47 c2 ff ff       	call   801001f0 <brelse>
    brelse(to);
80103fa9:	89 34 24             	mov    %esi,(%esp)
80103fac:	e8 3f c2 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103fb1:	83 c4 10             	add    $0x10,%esp
80103fb4:	3b 1d a8 41 11 80    	cmp    0x801141a8,%ebx
80103fba:	7c 94                	jl     80103f50 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80103fbc:	e8 7f fd ff ff       	call   80103d40 <write_head>
    install_trans(); // Now install writes to home locations
80103fc1:	e8 da fc ff ff       	call   80103ca0 <install_trans>
    log.lh.n = 0;
80103fc6:	c7 05 a8 41 11 80 00 	movl   $0x0,0x801141a8
80103fcd:	00 00 00 
    write_head();    // Erase the transaction from the log
80103fd0:	e8 6b fd ff ff       	call   80103d40 <write_head>
80103fd5:	e9 34 ff ff ff       	jmp    80103f0e <end_op+0x5e>
80103fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80103fe0:	83 ec 0c             	sub    $0xc,%esp
80103fe3:	68 60 41 11 80       	push   $0x80114160
80103fe8:	e8 13 12 00 00       	call   80105200 <wakeup>
  release(&log.lock);
80103fed:	c7 04 24 60 41 11 80 	movl   $0x80114160,(%esp)
80103ff4:	e8 67 1c 00 00       	call   80105c60 <release>
80103ff9:	83 c4 10             	add    $0x10,%esp
}
80103ffc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103fff:	5b                   	pop    %ebx
80104000:	5e                   	pop    %esi
80104001:	5f                   	pop    %edi
80104002:	5d                   	pop    %ebp
80104003:	c3                   	ret
    panic("log.committing");
80104004:	83 ec 0c             	sub    $0xc,%esp
80104007:	68 db 91 10 80       	push   $0x801091db
8010400c:	e8 bf c4 ff ff       	call   801004d0 <panic>
80104011:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104018:	00 
80104019:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104020 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80104020:	55                   	push   %ebp
80104021:	89 e5                	mov    %esp,%ebp
80104023:	53                   	push   %ebx
80104024:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80104027:	8b 15 a8 41 11 80    	mov    0x801141a8,%edx
{
8010402d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80104030:	83 fa 1d             	cmp    $0x1d,%edx
80104033:	0f 8f 85 00 00 00    	jg     801040be <log_write+0x9e>
80104039:	a1 98 41 11 80       	mov    0x80114198,%eax
8010403e:	83 e8 01             	sub    $0x1,%eax
80104041:	39 c2                	cmp    %eax,%edx
80104043:	7d 79                	jge    801040be <log_write+0x9e>
    panic("too big a transaction");
  if (log.outstanding < 1)
80104045:	a1 9c 41 11 80       	mov    0x8011419c,%eax
8010404a:	85 c0                	test   %eax,%eax
8010404c:	7e 7d                	jle    801040cb <log_write+0xab>
    panic("log_write outside of trans");

  acquire(&log.lock);
8010404e:	83 ec 0c             	sub    $0xc,%esp
80104051:	68 60 41 11 80       	push   $0x80114160
80104056:	e8 65 1c 00 00       	call   80105cc0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
8010405b:	8b 15 a8 41 11 80    	mov    0x801141a8,%edx
80104061:	83 c4 10             	add    $0x10,%esp
80104064:	85 d2                	test   %edx,%edx
80104066:	7e 4a                	jle    801040b2 <log_write+0x92>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80104068:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
8010406b:	31 c0                	xor    %eax,%eax
8010406d:	eb 08                	jmp    80104077 <log_write+0x57>
8010406f:	90                   	nop
80104070:	83 c0 01             	add    $0x1,%eax
80104073:	39 c2                	cmp    %eax,%edx
80104075:	74 29                	je     801040a0 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80104077:	39 0c 85 ac 41 11 80 	cmp    %ecx,-0x7feebe54(,%eax,4)
8010407e:	75 f0                	jne    80104070 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
80104080:	89 0c 85 ac 41 11 80 	mov    %ecx,-0x7feebe54(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80104087:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
8010408a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
8010408d:	c7 45 08 60 41 11 80 	movl   $0x80114160,0x8(%ebp)
}
80104094:	c9                   	leave
  release(&log.lock);
80104095:	e9 c6 1b 00 00       	jmp    80105c60 <release>
8010409a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
801040a0:	89 0c 95 ac 41 11 80 	mov    %ecx,-0x7feebe54(,%edx,4)
    log.lh.n++;
801040a7:	83 c2 01             	add    $0x1,%edx
801040aa:	89 15 a8 41 11 80    	mov    %edx,0x801141a8
801040b0:	eb d5                	jmp    80104087 <log_write+0x67>
  log.lh.block[i] = b->blockno;
801040b2:	8b 43 08             	mov    0x8(%ebx),%eax
801040b5:	a3 ac 41 11 80       	mov    %eax,0x801141ac
  if (i == log.lh.n)
801040ba:	75 cb                	jne    80104087 <log_write+0x67>
801040bc:	eb e9                	jmp    801040a7 <log_write+0x87>
    panic("too big a transaction");
801040be:	83 ec 0c             	sub    $0xc,%esp
801040c1:	68 ea 91 10 80       	push   $0x801091ea
801040c6:	e8 05 c4 ff ff       	call   801004d0 <panic>
    panic("log_write outside of trans");
801040cb:	83 ec 0c             	sub    $0xc,%esp
801040ce:	68 00 92 10 80       	push   $0x80109200
801040d3:	e8 f8 c3 ff ff       	call   801004d0 <panic>
801040d8:	66 90                	xchg   %ax,%ax
801040da:	66 90                	xchg   %ax,%ax
801040dc:	66 90                	xchg   %ax,%ax
801040de:	66 90                	xchg   %ax,%ax

801040e0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801040e0:	55                   	push   %ebp
801040e1:	89 e5                	mov    %esp,%ebp
801040e3:	53                   	push   %ebx
801040e4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
801040e7:	e8 64 09 00 00       	call   80104a50 <cpuid>
801040ec:	89 c3                	mov    %eax,%ebx
801040ee:	e8 5d 09 00 00       	call   80104a50 <cpuid>
801040f3:	83 ec 04             	sub    $0x4,%esp
801040f6:	53                   	push   %ebx
801040f7:	50                   	push   %eax
801040f8:	68 1b 92 10 80       	push   $0x8010921b
801040fd:	e8 ce c6 ff ff       	call   801007d0 <cprintf>
  idtinit();       // load idt register
80104102:	e8 d9 33 00 00       	call   801074e0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80104107:	e8 d4 08 00 00       	call   801049e0 <mycpu>
8010410c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010410e:	b8 01 00 00 00       	mov    $0x1,%eax
80104113:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010411a:	e8 11 0c 00 00       	call   80104d30 <scheduler>
8010411f:	90                   	nop

80104120 <mpenter>:
{
80104120:	55                   	push   %ebp
80104121:	89 e5                	mov    %esp,%ebp
80104123:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80104126:	e8 a5 44 00 00       	call   801085d0 <switchkvm>
  seginit();
8010412b:	e8 10 44 00 00       	call   80108540 <seginit>
  lapicinit();
80104130:	e8 9b f7 ff ff       	call   801038d0 <lapicinit>
  mpmain();
80104135:	e8 a6 ff ff ff       	call   801040e0 <mpmain>
8010413a:	66 90                	xchg   %ax,%ax
8010413c:	66 90                	xchg   %ax,%ax
8010413e:	66 90                	xchg   %ax,%ax

80104140 <main>:
{
80104140:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80104144:	83 e4 f0             	and    $0xfffffff0,%esp
80104147:	ff 71 fc             	push   -0x4(%ecx)
8010414a:	55                   	push   %ebp
8010414b:	89 e5                	mov    %esp,%ebp
8010414d:	53                   	push   %ebx
8010414e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010414f:	83 ec 08             	sub    $0x8,%esp
80104152:	68 00 00 40 80       	push   $0x80400000
80104157:	68 e0 ac 34 80       	push   $0x8034ace0
8010415c:	e8 8f f5 ff ff       	call   801036f0 <kinit1>
  kvmalloc();      // kernel page table
80104161:	e8 5a 49 00 00       	call   80108ac0 <kvmalloc>
  mpinit();        // detect other processors
80104166:	e8 85 01 00 00       	call   801042f0 <mpinit>
  lapicinit();     // interrupt controller
8010416b:	e8 60 f7 ff ff       	call   801038d0 <lapicinit>
  seginit();       // segment descriptors
80104170:	e8 cb 43 00 00       	call   80108540 <seginit>
  picinit();       // disable pic
80104175:	e8 76 03 00 00       	call   801044f0 <picinit>
  ioapicinit();    // another interrupt controller
8010417a:	e8 31 f3 ff ff       	call   801034b0 <ioapicinit>
  consoleinit();   // console hardware
8010417f:	e8 bc d9 ff ff       	call   80101b40 <consoleinit>
  uartinit();      // serial port
80104184:	e8 47 36 00 00       	call   801077d0 <uartinit>
  pinit();         // process table
80104189:	e8 32 08 00 00       	call   801049c0 <pinit>
  tvinit();        // trap vectors
8010418e:	e8 cd 32 00 00       	call   80107460 <tvinit>
  binit();         // buffer cache
80104193:	e8 a8 be ff ff       	call   80100040 <binit>
  fileinit();      // file table
80104198:	e8 53 dd ff ff       	call   80101ef0 <fileinit>
  ideinit();       // disk 
8010419d:	e8 fe f0 ff ff       	call   801032a0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
801041a2:	83 c4 0c             	add    $0xc,%esp
801041a5:	68 8a 00 00 00       	push   $0x8a
801041aa:	68 2c c8 10 80       	push   $0x8010c82c
801041af:	68 00 70 00 80       	push   $0x80007000
801041b4:	e8 67 1c 00 00       	call   80105e20 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
801041b9:	83 c4 10             	add    $0x10,%esp
801041bc:	69 05 44 42 11 80 b0 	imul   $0xb0,0x80114244,%eax
801041c3:	00 00 00 
801041c6:	05 60 42 11 80       	add    $0x80114260,%eax
801041cb:	3d 60 42 11 80       	cmp    $0x80114260,%eax
801041d0:	76 7e                	jbe    80104250 <main+0x110>
801041d2:	bb 60 42 11 80       	mov    $0x80114260,%ebx
801041d7:	eb 20                	jmp    801041f9 <main+0xb9>
801041d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801041e0:	69 05 44 42 11 80 b0 	imul   $0xb0,0x80114244,%eax
801041e7:	00 00 00 
801041ea:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
801041f0:	05 60 42 11 80       	add    $0x80114260,%eax
801041f5:	39 c3                	cmp    %eax,%ebx
801041f7:	73 57                	jae    80104250 <main+0x110>
    if(c == mycpu())  // We've started already.
801041f9:	e8 e2 07 00 00       	call   801049e0 <mycpu>
801041fe:	39 c3                	cmp    %eax,%ebx
80104200:	74 de                	je     801041e0 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80104202:	e8 59 f5 ff ff       	call   80103760 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80104207:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
8010420a:	c7 05 f8 6f 00 80 20 	movl   $0x80104120,0x80006ff8
80104211:	41 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80104214:	c7 05 f4 6f 00 80 00 	movl   $0x10b000,0x80006ff4
8010421b:	b0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
8010421e:	05 00 10 00 00       	add    $0x1000,%eax
80104223:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80104228:	0f b6 03             	movzbl (%ebx),%eax
8010422b:	68 00 70 00 00       	push   $0x7000
80104230:	50                   	push   %eax
80104231:	e8 ea f7 ff ff       	call   80103a20 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80104236:	83 c4 10             	add    $0x10,%esp
80104239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104240:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80104246:	85 c0                	test   %eax,%eax
80104248:	74 f6                	je     80104240 <main+0x100>
8010424a:	eb 94                	jmp    801041e0 <main+0xa0>
8010424c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80104250:	83 ec 08             	sub    $0x8,%esp
80104253:	68 00 00 00 8e       	push   $0x8e000000
80104258:	68 00 00 40 80       	push   $0x80400000
8010425d:	e8 2e f4 ff ff       	call   80103690 <kinit2>
  userinit();      // first user process
80104262:	e8 39 08 00 00       	call   80104aa0 <userinit>
  mpmain();        // finish this processor's setup
80104267:	e8 74 fe ff ff       	call   801040e0 <mpmain>
8010426c:	66 90                	xchg   %ax,%ax
8010426e:	66 90                	xchg   %ax,%ax

80104270 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80104270:	55                   	push   %ebp
80104271:	89 e5                	mov    %esp,%ebp
80104273:	57                   	push   %edi
80104274:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80104275:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010427b:	53                   	push   %ebx
  e = addr+len;
8010427c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010427f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80104282:	39 de                	cmp    %ebx,%esi
80104284:	72 10                	jb     80104296 <mpsearch1+0x26>
80104286:	eb 50                	jmp    801042d8 <mpsearch1+0x68>
80104288:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010428f:	00 
80104290:	89 fe                	mov    %edi,%esi
80104292:	39 fb                	cmp    %edi,%ebx
80104294:	76 42                	jbe    801042d8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80104296:	83 ec 04             	sub    $0x4,%esp
80104299:	8d 7e 10             	lea    0x10(%esi),%edi
8010429c:	6a 04                	push   $0x4
8010429e:	68 2f 92 10 80       	push   $0x8010922f
801042a3:	56                   	push   %esi
801042a4:	e8 27 1b 00 00       	call   80105dd0 <memcmp>
801042a9:	83 c4 10             	add    $0x10,%esp
801042ac:	89 c2                	mov    %eax,%edx
801042ae:	85 c0                	test   %eax,%eax
801042b0:	75 de                	jne    80104290 <mpsearch1+0x20>
801042b2:	89 f0                	mov    %esi,%eax
801042b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
801042b8:	0f b6 08             	movzbl (%eax),%ecx
  for(i=0; i<len; i++)
801042bb:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
801042be:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801042c0:	39 f8                	cmp    %edi,%eax
801042c2:	75 f4                	jne    801042b8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801042c4:	84 d2                	test   %dl,%dl
801042c6:	75 c8                	jne    80104290 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801042c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801042cb:	89 f0                	mov    %esi,%eax
801042cd:	5b                   	pop    %ebx
801042ce:	5e                   	pop    %esi
801042cf:	5f                   	pop    %edi
801042d0:	5d                   	pop    %ebp
801042d1:	c3                   	ret
801042d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801042d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801042db:	31 f6                	xor    %esi,%esi
}
801042dd:	5b                   	pop    %ebx
801042de:	89 f0                	mov    %esi,%eax
801042e0:	5e                   	pop    %esi
801042e1:	5f                   	pop    %edi
801042e2:	5d                   	pop    %ebp
801042e3:	c3                   	ret
801042e4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801042eb:	00 
801042ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801042f0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801042f0:	55                   	push   %ebp
801042f1:	89 e5                	mov    %esp,%ebp
801042f3:	57                   	push   %edi
801042f4:	56                   	push   %esi
801042f5:	53                   	push   %ebx
801042f6:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801042f9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80104300:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80104307:	c1 e0 08             	shl    $0x8,%eax
8010430a:	09 d0                	or     %edx,%eax
8010430c:	c1 e0 04             	shl    $0x4,%eax
8010430f:	75 1b                	jne    8010432c <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80104311:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80104318:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
8010431f:	c1 e0 08             	shl    $0x8,%eax
80104322:	09 d0                	or     %edx,%eax
80104324:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80104327:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010432c:	ba 00 04 00 00       	mov    $0x400,%edx
80104331:	e8 3a ff ff ff       	call   80104270 <mpsearch1>
80104336:	89 c3                	mov    %eax,%ebx
80104338:	85 c0                	test   %eax,%eax
8010433a:	0f 84 40 01 00 00    	je     80104480 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80104340:	8b 73 04             	mov    0x4(%ebx),%esi
80104343:	85 f6                	test   %esi,%esi
80104345:	0f 84 25 01 00 00    	je     80104470 <mpinit+0x180>
  if(memcmp(conf, "PCMP", 4) != 0)
8010434b:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010434e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80104354:	6a 04                	push   $0x4
80104356:	68 34 92 10 80       	push   $0x80109234
8010435b:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010435c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
8010435f:	e8 6c 1a 00 00       	call   80105dd0 <memcmp>
80104364:	83 c4 10             	add    $0x10,%esp
80104367:	85 c0                	test   %eax,%eax
80104369:	0f 85 01 01 00 00    	jne    80104470 <mpinit+0x180>
  if(conf->version != 1 && conf->version != 4)
8010436f:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80104376:	3c 01                	cmp    $0x1,%al
80104378:	74 08                	je     80104382 <mpinit+0x92>
8010437a:	3c 04                	cmp    $0x4,%al
8010437c:	0f 85 ee 00 00 00    	jne    80104470 <mpinit+0x180>
  if(sum((uchar*)conf, conf->length) != 0)
80104382:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
  for(i=0; i<len; i++)
80104389:	66 85 d2             	test   %dx,%dx
8010438c:	74 22                	je     801043b0 <mpinit+0xc0>
8010438e:	8d 3c 32             	lea    (%edx,%esi,1),%edi
80104391:	89 f0                	mov    %esi,%eax
  sum = 0;
80104393:	31 d2                	xor    %edx,%edx
80104395:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80104398:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
8010439f:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
801043a2:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801043a4:	39 f8                	cmp    %edi,%eax
801043a6:	75 f0                	jne    80104398 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
801043a8:	84 d2                	test   %dl,%dl
801043aa:	0f 85 c0 00 00 00    	jne    80104470 <mpinit+0x180>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801043b0:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
801043b6:	a3 40 41 11 80       	mov    %eax,0x80114140
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801043bb:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
801043c2:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
  ismp = 1;
801043c8:	be 01 00 00 00       	mov    $0x1,%esi
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801043cd:	03 55 e4             	add    -0x1c(%ebp),%edx
801043d0:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801043d3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801043d8:	39 d0                	cmp    %edx,%eax
801043da:	73 15                	jae    801043f1 <mpinit+0x101>
    switch(*p){
801043dc:	0f b6 08             	movzbl (%eax),%ecx
801043df:	80 f9 02             	cmp    $0x2,%cl
801043e2:	74 4c                	je     80104430 <mpinit+0x140>
801043e4:	77 3a                	ja     80104420 <mpinit+0x130>
801043e6:	84 c9                	test   %cl,%cl
801043e8:	74 56                	je     80104440 <mpinit+0x150>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801043ea:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801043ed:	39 d0                	cmp    %edx,%eax
801043ef:	72 eb                	jb     801043dc <mpinit+0xec>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
801043f1:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801043f4:	85 f6                	test   %esi,%esi
801043f6:	0f 84 d9 00 00 00    	je     801044d5 <mpinit+0x1e5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801043fc:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
80104400:	74 15                	je     80104417 <mpinit+0x127>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80104402:	b8 70 00 00 00       	mov    $0x70,%eax
80104407:	ba 22 00 00 00       	mov    $0x22,%edx
8010440c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010440d:	ba 23 00 00 00       	mov    $0x23,%edx
80104412:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80104413:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80104416:	ee                   	out    %al,(%dx)
  }
}
80104417:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010441a:	5b                   	pop    %ebx
8010441b:	5e                   	pop    %esi
8010441c:	5f                   	pop    %edi
8010441d:	5d                   	pop    %ebp
8010441e:	c3                   	ret
8010441f:	90                   	nop
    switch(*p){
80104420:	83 e9 03             	sub    $0x3,%ecx
80104423:	80 f9 01             	cmp    $0x1,%cl
80104426:	76 c2                	jbe    801043ea <mpinit+0xfa>
80104428:	31 f6                	xor    %esi,%esi
8010442a:	eb ac                	jmp    801043d8 <mpinit+0xe8>
8010442c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80104430:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
80104434:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
80104437:	88 0d 40 42 11 80    	mov    %cl,0x80114240
      continue;
8010443d:	eb 99                	jmp    801043d8 <mpinit+0xe8>
8010443f:	90                   	nop
      if(ncpu < NCPU) {
80104440:	8b 0d 44 42 11 80    	mov    0x80114244,%ecx
80104446:	83 f9 07             	cmp    $0x7,%ecx
80104449:	7f 19                	jg     80104464 <mpinit+0x174>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010444b:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
80104451:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80104455:	83 c1 01             	add    $0x1,%ecx
80104458:	89 0d 44 42 11 80    	mov    %ecx,0x80114244
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010445e:	88 9f 60 42 11 80    	mov    %bl,-0x7feebda0(%edi)
      p += sizeof(struct mpproc);
80104464:	83 c0 14             	add    $0x14,%eax
      continue;
80104467:	e9 6c ff ff ff       	jmp    801043d8 <mpinit+0xe8>
8010446c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
80104470:	83 ec 0c             	sub    $0xc,%esp
80104473:	68 39 92 10 80       	push   $0x80109239
80104478:	e8 53 c0 ff ff       	call   801004d0 <panic>
8010447d:	8d 76 00             	lea    0x0(%esi),%esi
{
80104480:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
80104485:	eb 13                	jmp    8010449a <mpinit+0x1aa>
80104487:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010448e:	00 
8010448f:	90                   	nop
  for(p = addr; p < e; p += sizeof(struct mp))
80104490:	89 f3                	mov    %esi,%ebx
80104492:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
80104498:	74 d6                	je     80104470 <mpinit+0x180>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010449a:	83 ec 04             	sub    $0x4,%esp
8010449d:	8d 73 10             	lea    0x10(%ebx),%esi
801044a0:	6a 04                	push   $0x4
801044a2:	68 2f 92 10 80       	push   $0x8010922f
801044a7:	53                   	push   %ebx
801044a8:	e8 23 19 00 00       	call   80105dd0 <memcmp>
801044ad:	83 c4 10             	add    $0x10,%esp
801044b0:	89 c2                	mov    %eax,%edx
801044b2:	85 c0                	test   %eax,%eax
801044b4:	75 da                	jne    80104490 <mpinit+0x1a0>
801044b6:	89 d8                	mov    %ebx,%eax
801044b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801044bf:	00 
    sum += addr[i];
801044c0:	0f b6 08             	movzbl (%eax),%ecx
  for(i=0; i<len; i++)
801044c3:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
801044c6:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801044c8:	39 f0                	cmp    %esi,%eax
801044ca:	75 f4                	jne    801044c0 <mpinit+0x1d0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801044cc:	84 d2                	test   %dl,%dl
801044ce:	75 c0                	jne    80104490 <mpinit+0x1a0>
801044d0:	e9 6b fe ff ff       	jmp    80104340 <mpinit+0x50>
    panic("Didn't find a suitable machine");
801044d5:	83 ec 0c             	sub    $0xc,%esp
801044d8:	68 60 96 10 80       	push   $0x80109660
801044dd:	e8 ee bf ff ff       	call   801004d0 <panic>
801044e2:	66 90                	xchg   %ax,%ax
801044e4:	66 90                	xchg   %ax,%ax
801044e6:	66 90                	xchg   %ax,%ax
801044e8:	66 90                	xchg   %ax,%ax
801044ea:	66 90                	xchg   %ax,%ax
801044ec:	66 90                	xchg   %ax,%ax
801044ee:	66 90                	xchg   %ax,%ax

801044f0 <picinit>:
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801044f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801044f5:	ba 21 00 00 00       	mov    $0x21,%edx
801044fa:	ee                   	out    %al,(%dx)
801044fb:	ba a1 00 00 00       	mov    $0xa1,%edx
80104500:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80104501:	c3                   	ret
80104502:	66 90                	xchg   %ax,%ax
80104504:	66 90                	xchg   %ax,%ax
80104506:	66 90                	xchg   %ax,%ax
80104508:	66 90                	xchg   %ax,%ax
8010450a:	66 90                	xchg   %ax,%ax
8010450c:	66 90                	xchg   %ax,%ax
8010450e:	66 90                	xchg   %ax,%ax

80104510 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80104510:	55                   	push   %ebp
80104511:	89 e5                	mov    %esp,%ebp
80104513:	57                   	push   %edi
80104514:	56                   	push   %esi
80104515:	53                   	push   %ebx
80104516:	83 ec 0c             	sub    $0xc,%esp
80104519:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010451c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010451f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80104525:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010452b:	e8 e0 d9 ff ff       	call   80101f10 <filealloc>
80104530:	89 03                	mov    %eax,(%ebx)
80104532:	85 c0                	test   %eax,%eax
80104534:	0f 84 a8 00 00 00    	je     801045e2 <pipealloc+0xd2>
8010453a:	e8 d1 d9 ff ff       	call   80101f10 <filealloc>
8010453f:	89 06                	mov    %eax,(%esi)
80104541:	85 c0                	test   %eax,%eax
80104543:	0f 84 87 00 00 00    	je     801045d0 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80104549:	e8 12 f2 ff ff       	call   80103760 <kalloc>
8010454e:	89 c7                	mov    %eax,%edi
80104550:	85 c0                	test   %eax,%eax
80104552:	0f 84 b0 00 00 00    	je     80104608 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
80104558:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010455f:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80104562:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80104565:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010456c:	00 00 00 
  p->nwrite = 0;
8010456f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80104576:	00 00 00 
  p->nread = 0;
80104579:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80104580:	00 00 00 
  initlock(&p->lock, "pipe");
80104583:	68 51 92 10 80       	push   $0x80109251
80104588:	50                   	push   %eax
80104589:	e8 62 15 00 00       	call   80105af0 <initlock>
  (*f0)->type = FD_PIPE;
8010458e:	8b 03                	mov    (%ebx),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80104590:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80104593:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80104599:	8b 03                	mov    (%ebx),%eax
8010459b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010459f:	8b 03                	mov    (%ebx),%eax
801045a1:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801045a5:	8b 03                	mov    (%ebx),%eax
801045a7:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801045aa:	8b 06                	mov    (%esi),%eax
801045ac:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801045b2:	8b 06                	mov    (%esi),%eax
801045b4:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801045b8:	8b 06                	mov    (%esi),%eax
801045ba:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801045be:	8b 06                	mov    (%esi),%eax
801045c0:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801045c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801045c6:	31 c0                	xor    %eax,%eax
}
801045c8:	5b                   	pop    %ebx
801045c9:	5e                   	pop    %esi
801045ca:	5f                   	pop    %edi
801045cb:	5d                   	pop    %ebp
801045cc:	c3                   	ret
801045cd:	8d 76 00             	lea    0x0(%esi),%esi
  if(*f0)
801045d0:	8b 03                	mov    (%ebx),%eax
801045d2:	85 c0                	test   %eax,%eax
801045d4:	74 1e                	je     801045f4 <pipealloc+0xe4>
    fileclose(*f0);
801045d6:	83 ec 0c             	sub    $0xc,%esp
801045d9:	50                   	push   %eax
801045da:	e8 f1 d9 ff ff       	call   80101fd0 <fileclose>
801045df:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801045e2:	8b 06                	mov    (%esi),%eax
801045e4:	85 c0                	test   %eax,%eax
801045e6:	74 0c                	je     801045f4 <pipealloc+0xe4>
    fileclose(*f1);
801045e8:	83 ec 0c             	sub    $0xc,%esp
801045eb:	50                   	push   %eax
801045ec:	e8 df d9 ff ff       	call   80101fd0 <fileclose>
801045f1:	83 c4 10             	add    $0x10,%esp
}
801045f4:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801045f7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801045fc:	5b                   	pop    %ebx
801045fd:	5e                   	pop    %esi
801045fe:	5f                   	pop    %edi
801045ff:	5d                   	pop    %ebp
80104600:	c3                   	ret
80104601:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
80104608:	8b 03                	mov    (%ebx),%eax
8010460a:	85 c0                	test   %eax,%eax
8010460c:	75 c8                	jne    801045d6 <pipealloc+0xc6>
8010460e:	eb d2                	jmp    801045e2 <pipealloc+0xd2>

80104610 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80104610:	55                   	push   %ebp
80104611:	89 e5                	mov    %esp,%ebp
80104613:	56                   	push   %esi
80104614:	53                   	push   %ebx
80104615:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104618:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010461b:	83 ec 0c             	sub    $0xc,%esp
8010461e:	53                   	push   %ebx
8010461f:	e8 9c 16 00 00       	call   80105cc0 <acquire>
  if(writable){
80104624:	83 c4 10             	add    $0x10,%esp
80104627:	85 f6                	test   %esi,%esi
80104629:	74 65                	je     80104690 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
8010462b:	83 ec 0c             	sub    $0xc,%esp
8010462e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80104634:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010463b:	00 00 00 
    wakeup(&p->nread);
8010463e:	50                   	push   %eax
8010463f:	e8 bc 0b 00 00       	call   80105200 <wakeup>
80104644:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80104647:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010464d:	85 d2                	test   %edx,%edx
8010464f:	75 0a                	jne    8010465b <pipeclose+0x4b>
80104651:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80104657:	85 c0                	test   %eax,%eax
80104659:	74 15                	je     80104670 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010465b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010465e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104661:	5b                   	pop    %ebx
80104662:	5e                   	pop    %esi
80104663:	5d                   	pop    %ebp
    release(&p->lock);
80104664:	e9 f7 15 00 00       	jmp    80105c60 <release>
80104669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80104670:	83 ec 0c             	sub    $0xc,%esp
80104673:	53                   	push   %ebx
80104674:	e8 e7 15 00 00       	call   80105c60 <release>
    kfree((char*)p);
80104679:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010467c:	83 c4 10             	add    $0x10,%esp
}
8010467f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104682:	5b                   	pop    %ebx
80104683:	5e                   	pop    %esi
80104684:	5d                   	pop    %ebp
    kfree((char*)p);
80104685:	e9 16 ef ff ff       	jmp    801035a0 <kfree>
8010468a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
80104690:	83 ec 0c             	sub    $0xc,%esp
80104693:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80104699:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801046a0:	00 00 00 
    wakeup(&p->nwrite);
801046a3:	50                   	push   %eax
801046a4:	e8 57 0b 00 00       	call   80105200 <wakeup>
801046a9:	83 c4 10             	add    $0x10,%esp
801046ac:	eb 99                	jmp    80104647 <pipeclose+0x37>
801046ae:	66 90                	xchg   %ax,%ax

801046b0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801046b0:	55                   	push   %ebp
801046b1:	89 e5                	mov    %esp,%ebp
801046b3:	57                   	push   %edi
801046b4:	56                   	push   %esi
801046b5:	53                   	push   %ebx
801046b6:	83 ec 28             	sub    $0x28,%esp
801046b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801046bc:	53                   	push   %ebx
801046bd:	e8 fe 15 00 00       	call   80105cc0 <acquire>
  for(i = 0; i < n; i++){
801046c2:	8b 45 10             	mov    0x10(%ebp),%eax
801046c5:	83 c4 10             	add    $0x10,%esp
801046c8:	85 c0                	test   %eax,%eax
801046ca:	0f 8e c0 00 00 00    	jle    80104790 <pipewrite+0xe0>
801046d0:	8b 45 0c             	mov    0xc(%ebp),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801046d3:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801046d9:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
801046df:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801046e2:	03 45 10             	add    0x10(%ebp),%eax
801046e5:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801046e8:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801046ee:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801046f4:	89 ca                	mov    %ecx,%edx
801046f6:	05 00 02 00 00       	add    $0x200,%eax
801046fb:	39 c1                	cmp    %eax,%ecx
801046fd:	74 3f                	je     8010473e <pipewrite+0x8e>
801046ff:	eb 67                	jmp    80104768 <pipewrite+0xb8>
80104701:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
80104708:	e8 63 03 00 00       	call   80104a70 <myproc>
8010470d:	8b 48 24             	mov    0x24(%eax),%ecx
80104710:	85 c9                	test   %ecx,%ecx
80104712:	75 34                	jne    80104748 <pipewrite+0x98>
      wakeup(&p->nread);
80104714:	83 ec 0c             	sub    $0xc,%esp
80104717:	57                   	push   %edi
80104718:	e8 e3 0a 00 00       	call   80105200 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010471d:	58                   	pop    %eax
8010471e:	5a                   	pop    %edx
8010471f:	53                   	push   %ebx
80104720:	56                   	push   %esi
80104721:	e8 1a 0a 00 00       	call   80105140 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104726:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010472c:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80104732:	83 c4 10             	add    $0x10,%esp
80104735:	05 00 02 00 00       	add    $0x200,%eax
8010473a:	39 c2                	cmp    %eax,%edx
8010473c:	75 2a                	jne    80104768 <pipewrite+0xb8>
      if(p->readopen == 0 || myproc()->killed){
8010473e:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80104744:	85 c0                	test   %eax,%eax
80104746:	75 c0                	jne    80104708 <pipewrite+0x58>
        release(&p->lock);
80104748:	83 ec 0c             	sub    $0xc,%esp
8010474b:	53                   	push   %ebx
8010474c:	e8 0f 15 00 00       	call   80105c60 <release>
        return -1;
80104751:	83 c4 10             	add    $0x10,%esp
80104754:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80104759:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010475c:	5b                   	pop    %ebx
8010475d:	5e                   	pop    %esi
8010475e:	5f                   	pop    %edi
8010475f:	5d                   	pop    %ebp
80104760:	c3                   	ret
80104761:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80104768:	8b 75 e4             	mov    -0x1c(%ebp),%esi
8010476b:	8d 4a 01             	lea    0x1(%edx),%ecx
8010476e:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80104774:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
8010477a:	0f b6 06             	movzbl (%esi),%eax
  for(i = 0; i < n; i++){
8010477d:	83 c6 01             	add    $0x1,%esi
80104780:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80104783:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80104787:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010478a:	0f 85 58 ff ff ff    	jne    801046e8 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80104790:	83 ec 0c             	sub    $0xc,%esp
80104793:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80104799:	50                   	push   %eax
8010479a:	e8 61 0a 00 00       	call   80105200 <wakeup>
  release(&p->lock);
8010479f:	89 1c 24             	mov    %ebx,(%esp)
801047a2:	e8 b9 14 00 00       	call   80105c60 <release>
  return n;
801047a7:	8b 45 10             	mov    0x10(%ebp),%eax
801047aa:	83 c4 10             	add    $0x10,%esp
801047ad:	eb aa                	jmp    80104759 <pipewrite+0xa9>
801047af:	90                   	nop

801047b0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801047b0:	55                   	push   %ebp
801047b1:	89 e5                	mov    %esp,%ebp
801047b3:	57                   	push   %edi
801047b4:	56                   	push   %esi
801047b5:	53                   	push   %ebx
801047b6:	83 ec 18             	sub    $0x18,%esp
801047b9:	8b 75 08             	mov    0x8(%ebp),%esi
801047bc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801047bf:	56                   	push   %esi
801047c0:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801047c6:	e8 f5 14 00 00       	call   80105cc0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801047cb:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801047d1:	83 c4 10             	add    $0x10,%esp
801047d4:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
801047da:	74 2f                	je     8010480b <piperead+0x5b>
801047dc:	eb 37                	jmp    80104815 <piperead+0x65>
801047de:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
801047e0:	e8 8b 02 00 00       	call   80104a70 <myproc>
801047e5:	8b 48 24             	mov    0x24(%eax),%ecx
801047e8:	85 c9                	test   %ecx,%ecx
801047ea:	0f 85 80 00 00 00    	jne    80104870 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801047f0:	83 ec 08             	sub    $0x8,%esp
801047f3:	56                   	push   %esi
801047f4:	53                   	push   %ebx
801047f5:	e8 46 09 00 00       	call   80105140 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801047fa:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
80104800:	83 c4 10             	add    $0x10,%esp
80104803:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
80104809:	75 0a                	jne    80104815 <piperead+0x65>
8010480b:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
80104811:	85 c0                	test   %eax,%eax
80104813:	75 cb                	jne    801047e0 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104815:	8b 55 10             	mov    0x10(%ebp),%edx
80104818:	31 db                	xor    %ebx,%ebx
8010481a:	85 d2                	test   %edx,%edx
8010481c:	7f 20                	jg     8010483e <piperead+0x8e>
8010481e:	eb 2c                	jmp    8010484c <piperead+0x9c>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80104820:	8d 48 01             	lea    0x1(%eax),%ecx
80104823:	25 ff 01 00 00       	and    $0x1ff,%eax
80104828:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
8010482e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80104833:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104836:	83 c3 01             	add    $0x1,%ebx
80104839:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010483c:	74 0e                	je     8010484c <piperead+0x9c>
    if(p->nread == p->nwrite)
8010483e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80104844:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010484a:	75 d4                	jne    80104820 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010484c:	83 ec 0c             	sub    $0xc,%esp
8010484f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80104855:	50                   	push   %eax
80104856:	e8 a5 09 00 00       	call   80105200 <wakeup>
  release(&p->lock);
8010485b:	89 34 24             	mov    %esi,(%esp)
8010485e:	e8 fd 13 00 00       	call   80105c60 <release>
  return i;
80104863:	83 c4 10             	add    $0x10,%esp
}
80104866:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104869:	89 d8                	mov    %ebx,%eax
8010486b:	5b                   	pop    %ebx
8010486c:	5e                   	pop    %esi
8010486d:	5f                   	pop    %edi
8010486e:	5d                   	pop    %ebp
8010486f:	c3                   	ret
      release(&p->lock);
80104870:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104873:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80104878:	56                   	push   %esi
80104879:	e8 e2 13 00 00       	call   80105c60 <release>
      return -1;
8010487e:	83 c4 10             	add    $0x10,%esp
}
80104881:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104884:	89 d8                	mov    %ebx,%eax
80104886:	5b                   	pop    %ebx
80104887:	5e                   	pop    %esi
80104888:	5f                   	pop    %edi
80104889:	5d                   	pop    %ebp
8010488a:	c3                   	ret
8010488b:	66 90                	xchg   %ax,%ax
8010488d:	66 90                	xchg   %ax,%ax
8010488f:	90                   	nop

80104890 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80104890:	55                   	push   %ebp
80104891:	89 e5                	mov    %esp,%ebp
80104893:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104894:	bb 14 48 11 80       	mov    $0x80114814,%ebx
{
80104899:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010489c:	68 e0 47 11 80       	push   $0x801147e0
801048a1:	e8 1a 14 00 00       	call   80105cc0 <acquire>
801048a6:	83 c4 10             	add    $0x10,%esp
801048a9:	eb 17                	jmp    801048c2 <allocproc+0x32>
801048ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801048b0:	81 c3 24 8d 00 00    	add    $0x8d24,%ebx
801048b6:	81 fb 14 91 34 80    	cmp    $0x80349114,%ebx
801048bc:	0f 84 7e 00 00 00    	je     80104940 <allocproc+0xb0>
    if(p->state == UNUSED)
801048c2:	8b 43 0c             	mov    0xc(%ebx),%eax
801048c5:	85 c0                	test   %eax,%eax
801048c7:	75 e7                	jne    801048b0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801048c9:	a1 04 c0 10 80       	mov    0x8010c004,%eax
  p->syscall_count = 0;

  release(&ptable.lock);
801048ce:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
801048d1:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->syscall_count = 0;
801048d8:	c7 83 1c 8d 00 00 00 	movl   $0x0,0x8d1c(%ebx)
801048df:	00 00 00 
  p->pid = nextpid++;
801048e2:	89 43 10             	mov    %eax,0x10(%ebx)
801048e5:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
801048e8:	68 e0 47 11 80       	push   $0x801147e0
  p->pid = nextpid++;
801048ed:	89 15 04 c0 10 80    	mov    %edx,0x8010c004
  release(&ptable.lock);
801048f3:	e8 68 13 00 00       	call   80105c60 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801048f8:	e8 63 ee ff ff       	call   80103760 <kalloc>
801048fd:	83 c4 10             	add    $0x10,%esp
80104900:	89 43 08             	mov    %eax,0x8(%ebx)
80104903:	85 c0                	test   %eax,%eax
80104905:	74 52                	je     80104959 <allocproc+0xc9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80104907:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010490d:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80104910:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80104915:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80104918:	c7 40 14 4f 74 10 80 	movl   $0x8010744f,0x14(%eax)
  p->context = (struct context*)sp;
8010491f:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80104922:	6a 14                	push   $0x14
80104924:	6a 00                	push   $0x0
80104926:	50                   	push   %eax
80104927:	e8 54 14 00 00       	call   80105d80 <memset>
  p->context->eip = (uint)forkret;
8010492c:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
8010492f:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80104932:	c7 40 10 70 49 10 80 	movl   $0x80104970,0x10(%eax)
}
80104939:	89 d8                	mov    %ebx,%eax
8010493b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010493e:	c9                   	leave
8010493f:	c3                   	ret
  release(&ptable.lock);
80104940:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80104943:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80104945:	68 e0 47 11 80       	push   $0x801147e0
8010494a:	e8 11 13 00 00       	call   80105c60 <release>
}
8010494f:	89 d8                	mov    %ebx,%eax
  return 0;
80104951:	83 c4 10             	add    $0x10,%esp
}
80104954:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104957:	c9                   	leave
80104958:	c3                   	ret
    p->state = UNUSED;
80104959:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80104960:	31 db                	xor    %ebx,%ebx
}
80104962:	89 d8                	mov    %ebx,%eax
80104964:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104967:	c9                   	leave
80104968:	c3                   	ret
80104969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104970 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80104970:	55                   	push   %ebp
80104971:	89 e5                	mov    %esp,%ebp
80104973:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80104976:	68 e0 47 11 80       	push   $0x801147e0
8010497b:	e8 e0 12 00 00       	call   80105c60 <release>

  if (first) {
80104980:	a1 00 c0 10 80       	mov    0x8010c000,%eax
80104985:	83 c4 10             	add    $0x10,%esp
80104988:	85 c0                	test   %eax,%eax
8010498a:	75 04                	jne    80104990 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010498c:	c9                   	leave
8010498d:	c3                   	ret
8010498e:	66 90                	xchg   %ax,%ax
    first = 0;
80104990:	c7 05 00 c0 10 80 00 	movl   $0x0,0x8010c000
80104997:	00 00 00 
    iinit(ROOTDEV);
8010499a:	83 ec 0c             	sub    $0xc,%esp
8010499d:	6a 01                	push   $0x1
8010499f:	e8 9c dc ff ff       	call   80102640 <iinit>
    initlog(ROOTDEV);
801049a4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801049ab:	e8 f0 f3 ff ff       	call   80103da0 <initlog>
}
801049b0:	83 c4 10             	add    $0x10,%esp
801049b3:	c9                   	leave
801049b4:	c3                   	ret
801049b5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801049bc:	00 
801049bd:	8d 76 00             	lea    0x0(%esi),%esi

801049c0 <pinit>:
{
801049c0:	55                   	push   %ebp
801049c1:	89 e5                	mov    %esp,%ebp
801049c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
801049c6:	68 56 92 10 80       	push   $0x80109256
801049cb:	68 e0 47 11 80       	push   $0x801147e0
801049d0:	e8 1b 11 00 00       	call   80105af0 <initlock>
}
801049d5:	83 c4 10             	add    $0x10,%esp
801049d8:	c9                   	leave
801049d9:	c3                   	ret
801049da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801049e0 <mycpu>:
{
801049e0:	55                   	push   %ebp
801049e1:	89 e5                	mov    %esp,%ebp
801049e3:	56                   	push   %esi
801049e4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801049e5:	9c                   	pushf
801049e6:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801049e7:	f6 c4 02             	test   $0x2,%ah
801049ea:	75 4e                	jne    80104a3a <mycpu+0x5a>
  apicid = lapicid();
801049ec:	e8 df ef ff ff       	call   801039d0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
801049f1:	8b 35 44 42 11 80    	mov    0x80114244,%esi
  apicid = lapicid();
801049f7:	89 c3                	mov    %eax,%ebx
  for (i = 0; i < ncpu; ++i) {
801049f9:	85 f6                	test   %esi,%esi
801049fb:	7e 30                	jle    80104a2d <mycpu+0x4d>
801049fd:	31 c0                	xor    %eax,%eax
801049ff:	eb 0e                	jmp    80104a0f <mycpu+0x2f>
80104a01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a08:	83 c0 01             	add    $0x1,%eax
80104a0b:	39 f0                	cmp    %esi,%eax
80104a0d:	74 1e                	je     80104a2d <mycpu+0x4d>
    if (cpus[i].apicid == apicid)
80104a0f:	69 d0 b0 00 00 00    	imul   $0xb0,%eax,%edx
80104a15:	0f b6 8a 60 42 11 80 	movzbl -0x7feebda0(%edx),%ecx
80104a1c:	39 d9                	cmp    %ebx,%ecx
80104a1e:	75 e8                	jne    80104a08 <mycpu+0x28>
}
80104a20:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
80104a23:	8d 82 60 42 11 80    	lea    -0x7feebda0(%edx),%eax
}
80104a29:	5b                   	pop    %ebx
80104a2a:	5e                   	pop    %esi
80104a2b:	5d                   	pop    %ebp
80104a2c:	c3                   	ret
  panic("unknown apicid\n");
80104a2d:	83 ec 0c             	sub    $0xc,%esp
80104a30:	68 5d 92 10 80       	push   $0x8010925d
80104a35:	e8 96 ba ff ff       	call   801004d0 <panic>
    panic("mycpu called with interrupts enabled\n");
80104a3a:	83 ec 0c             	sub    $0xc,%esp
80104a3d:	68 80 96 10 80       	push   $0x80109680
80104a42:	e8 89 ba ff ff       	call   801004d0 <panic>
80104a47:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a4e:	00 
80104a4f:	90                   	nop

80104a50 <cpuid>:
cpuid() {
80104a50:	55                   	push   %ebp
80104a51:	89 e5                	mov    %esp,%ebp
80104a53:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80104a56:	e8 85 ff ff ff       	call   801049e0 <mycpu>
}
80104a5b:	c9                   	leave
  return mycpu()-cpus;
80104a5c:	2d 60 42 11 80       	sub    $0x80114260,%eax
80104a61:	c1 f8 04             	sar    $0x4,%eax
80104a64:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80104a6a:	c3                   	ret
80104a6b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104a70 <myproc>:
myproc(void) {
80104a70:	55                   	push   %ebp
80104a71:	89 e5                	mov    %esp,%ebp
80104a73:	53                   	push   %ebx
80104a74:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104a77:	e8 f4 10 00 00       	call   80105b70 <pushcli>
  c = mycpu();
80104a7c:	e8 5f ff ff ff       	call   801049e0 <mycpu>
  p = c->proc;
80104a81:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104a87:	e8 34 11 00 00       	call   80105bc0 <popcli>
}
80104a8c:	89 d8                	mov    %ebx,%eax
80104a8e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a91:	c9                   	leave
80104a92:	c3                   	ret
80104a93:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a9a:	00 
80104a9b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104aa0 <userinit>:
{
80104aa0:	55                   	push   %ebp
80104aa1:	89 e5                	mov    %esp,%ebp
80104aa3:	53                   	push   %ebx
80104aa4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80104aa7:	e8 e4 fd ff ff       	call   80104890 <allocproc>
80104aac:	89 c3                	mov    %eax,%ebx
  initproc = p;
80104aae:	a3 14 91 34 80       	mov    %eax,0x80349114
  if((p->pgdir = setupkvm()) == 0)
80104ab3:	e8 88 3f 00 00       	call   80108a40 <setupkvm>
80104ab8:	89 43 04             	mov    %eax,0x4(%ebx)
80104abb:	85 c0                	test   %eax,%eax
80104abd:	0f 84 bd 00 00 00    	je     80104b80 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80104ac3:	83 ec 04             	sub    $0x4,%esp
80104ac6:	68 2c 00 00 00       	push   $0x2c
80104acb:	68 00 c8 10 80       	push   $0x8010c800
80104ad0:	50                   	push   %eax
80104ad1:	e8 1a 3c 00 00       	call   801086f0 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80104ad6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80104ad9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80104adf:	6a 4c                	push   $0x4c
80104ae1:	6a 00                	push   $0x0
80104ae3:	ff 73 18             	push   0x18(%ebx)
80104ae6:	e8 95 12 00 00       	call   80105d80 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80104aeb:	8b 43 18             	mov    0x18(%ebx),%eax
80104aee:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80104af3:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80104af6:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80104afb:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80104aff:	8b 43 18             	mov    0x18(%ebx),%eax
80104b02:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80104b06:	8b 43 18             	mov    0x18(%ebx),%eax
80104b09:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80104b0d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80104b11:	8b 43 18             	mov    0x18(%ebx),%eax
80104b14:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80104b18:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80104b1c:	8b 43 18             	mov    0x18(%ebx),%eax
80104b1f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80104b26:	8b 43 18             	mov    0x18(%ebx),%eax
80104b29:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80104b30:	8b 43 18             	mov    0x18(%ebx),%eax
80104b33:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80104b3a:	8d 43 6c             	lea    0x6c(%ebx),%eax
80104b3d:	6a 10                	push   $0x10
80104b3f:	68 86 92 10 80       	push   $0x80109286
80104b44:	50                   	push   %eax
80104b45:	e8 f6 13 00 00       	call   80105f40 <safestrcpy>
  p->cwd = namei("/");
80104b4a:	c7 04 24 8f 92 10 80 	movl   $0x8010928f,(%esp)
80104b51:	e8 2a e6 ff ff       	call   80103180 <namei>
80104b56:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80104b59:	c7 04 24 e0 47 11 80 	movl   $0x801147e0,(%esp)
80104b60:	e8 5b 11 00 00       	call   80105cc0 <acquire>
  p->state = RUNNABLE;
80104b65:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80104b6c:	c7 04 24 e0 47 11 80 	movl   $0x801147e0,(%esp)
80104b73:	e8 e8 10 00 00       	call   80105c60 <release>
}
80104b78:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b7b:	83 c4 10             	add    $0x10,%esp
80104b7e:	c9                   	leave
80104b7f:	c3                   	ret
    panic("userinit: out of memory?");
80104b80:	83 ec 0c             	sub    $0xc,%esp
80104b83:	68 6d 92 10 80       	push   $0x8010926d
80104b88:	e8 43 b9 ff ff       	call   801004d0 <panic>
80104b8d:	8d 76 00             	lea    0x0(%esi),%esi

80104b90 <growproc>:
{
80104b90:	55                   	push   %ebp
80104b91:	89 e5                	mov    %esp,%ebp
80104b93:	56                   	push   %esi
80104b94:	53                   	push   %ebx
80104b95:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80104b98:	e8 d3 0f 00 00       	call   80105b70 <pushcli>
  c = mycpu();
80104b9d:	e8 3e fe ff ff       	call   801049e0 <mycpu>
  p = c->proc;
80104ba2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104ba8:	e8 13 10 00 00       	call   80105bc0 <popcli>
  sz = curproc->sz;
80104bad:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80104baf:	85 f6                	test   %esi,%esi
80104bb1:	7f 1d                	jg     80104bd0 <growproc+0x40>
  } else if(n < 0){
80104bb3:	75 3b                	jne    80104bf0 <growproc+0x60>
  switchuvm(curproc);
80104bb5:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80104bb8:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80104bba:	53                   	push   %ebx
80104bbb:	e8 20 3a 00 00       	call   801085e0 <switchuvm>
  return 0;
80104bc0:	83 c4 10             	add    $0x10,%esp
80104bc3:	31 c0                	xor    %eax,%eax
}
80104bc5:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104bc8:	5b                   	pop    %ebx
80104bc9:	5e                   	pop    %esi
80104bca:	5d                   	pop    %ebp
80104bcb:	c3                   	ret
80104bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104bd0:	83 ec 04             	sub    $0x4,%esp
80104bd3:	01 c6                	add    %eax,%esi
80104bd5:	56                   	push   %esi
80104bd6:	50                   	push   %eax
80104bd7:	ff 73 04             	push   0x4(%ebx)
80104bda:	e8 81 3c 00 00       	call   80108860 <allocuvm>
80104bdf:	83 c4 10             	add    $0x10,%esp
80104be2:	85 c0                	test   %eax,%eax
80104be4:	75 cf                	jne    80104bb5 <growproc+0x25>
      return -1;
80104be6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104beb:	eb d8                	jmp    80104bc5 <growproc+0x35>
80104bed:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104bf0:	83 ec 04             	sub    $0x4,%esp
80104bf3:	01 c6                	add    %eax,%esi
80104bf5:	56                   	push   %esi
80104bf6:	50                   	push   %eax
80104bf7:	ff 73 04             	push   0x4(%ebx)
80104bfa:	e8 91 3d 00 00       	call   80108990 <deallocuvm>
80104bff:	83 c4 10             	add    $0x10,%esp
80104c02:	85 c0                	test   %eax,%eax
80104c04:	75 af                	jne    80104bb5 <growproc+0x25>
80104c06:	eb de                	jmp    80104be6 <growproc+0x56>
80104c08:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c0f:	00 

80104c10 <fork>:
{
80104c10:	55                   	push   %ebp
80104c11:	89 e5                	mov    %esp,%ebp
80104c13:	57                   	push   %edi
80104c14:	56                   	push   %esi
80104c15:	53                   	push   %ebx
80104c16:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80104c19:	e8 52 0f 00 00       	call   80105b70 <pushcli>
  c = mycpu();
80104c1e:	e8 bd fd ff ff       	call   801049e0 <mycpu>
  p = c->proc;
80104c23:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104c29:	e8 92 0f 00 00       	call   80105bc0 <popcli>
  if((np = allocproc()) == 0){
80104c2e:	e8 5d fc ff ff       	call   80104890 <allocproc>
80104c33:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104c36:	85 c0                	test   %eax,%eax
80104c38:	0f 84 b7 00 00 00    	je     80104cf5 <fork+0xe5>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80104c3e:	83 ec 08             	sub    $0x8,%esp
80104c41:	ff 33                	push   (%ebx)
80104c43:	89 c7                	mov    %eax,%edi
80104c45:	ff 73 04             	push   0x4(%ebx)
80104c48:	e8 e3 3e 00 00       	call   80108b30 <copyuvm>
80104c4d:	83 c4 10             	add    $0x10,%esp
80104c50:	89 47 04             	mov    %eax,0x4(%edi)
80104c53:	85 c0                	test   %eax,%eax
80104c55:	0f 84 a1 00 00 00    	je     80104cfc <fork+0xec>
  np->sz = curproc->sz;
80104c5b:	8b 03                	mov    (%ebx),%eax
80104c5d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104c60:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80104c62:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80104c65:	89 c8                	mov    %ecx,%eax
80104c67:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80104c6a:	b9 13 00 00 00       	mov    $0x13,%ecx
80104c6f:	8b 73 18             	mov    0x18(%ebx),%esi
80104c72:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80104c74:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80104c76:	8b 40 18             	mov    0x18(%eax),%eax
80104c79:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80104c80:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80104c84:	85 c0                	test   %eax,%eax
80104c86:	74 13                	je     80104c9b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80104c88:	83 ec 0c             	sub    $0xc,%esp
80104c8b:	50                   	push   %eax
80104c8c:	e8 ef d2 ff ff       	call   80101f80 <filedup>
80104c91:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104c94:	83 c4 10             	add    $0x10,%esp
80104c97:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80104c9b:	83 c6 01             	add    $0x1,%esi
80104c9e:	83 fe 10             	cmp    $0x10,%esi
80104ca1:	75 dd                	jne    80104c80 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80104ca3:	83 ec 0c             	sub    $0xc,%esp
80104ca6:	ff 73 68             	push   0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104ca9:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80104cac:	e8 7f db ff ff       	call   80102830 <idup>
80104cb1:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104cb4:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80104cb7:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104cba:	8d 47 6c             	lea    0x6c(%edi),%eax
80104cbd:	6a 10                	push   $0x10
80104cbf:	53                   	push   %ebx
80104cc0:	50                   	push   %eax
80104cc1:	e8 7a 12 00 00       	call   80105f40 <safestrcpy>
  pid = np->pid;
80104cc6:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80104cc9:	c7 04 24 e0 47 11 80 	movl   $0x801147e0,(%esp)
80104cd0:	e8 eb 0f 00 00       	call   80105cc0 <acquire>
  np->state = RUNNABLE;
80104cd5:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80104cdc:	c7 04 24 e0 47 11 80 	movl   $0x801147e0,(%esp)
80104ce3:	e8 78 0f 00 00       	call   80105c60 <release>
  return pid;
80104ce8:	83 c4 10             	add    $0x10,%esp
}
80104ceb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104cee:	89 d8                	mov    %ebx,%eax
80104cf0:	5b                   	pop    %ebx
80104cf1:	5e                   	pop    %esi
80104cf2:	5f                   	pop    %edi
80104cf3:	5d                   	pop    %ebp
80104cf4:	c3                   	ret
    return -1;
80104cf5:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104cfa:	eb ef                	jmp    80104ceb <fork+0xdb>
    kfree(np->kstack);
80104cfc:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80104cff:	83 ec 0c             	sub    $0xc,%esp
80104d02:	ff 73 08             	push   0x8(%ebx)
80104d05:	e8 96 e8 ff ff       	call   801035a0 <kfree>
    np->kstack = 0;
80104d0a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80104d11:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80104d14:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80104d1b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104d20:	eb c9                	jmp    80104ceb <fork+0xdb>
80104d22:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104d29:	00 
80104d2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104d30 <scheduler>:
{
80104d30:	55                   	push   %ebp
80104d31:	89 e5                	mov    %esp,%ebp
80104d33:	57                   	push   %edi
80104d34:	56                   	push   %esi
80104d35:	53                   	push   %ebx
80104d36:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80104d39:	e8 a2 fc ff ff       	call   801049e0 <mycpu>
  c->proc = 0;
80104d3e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80104d45:	00 00 00 
  struct cpu *c = mycpu();
80104d48:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80104d4a:	8d 78 04             	lea    0x4(%eax),%edi
80104d4d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80104d50:	fb                   	sti
    acquire(&ptable.lock);
80104d51:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104d54:	bb 14 48 11 80       	mov    $0x80114814,%ebx
    acquire(&ptable.lock);
80104d59:	68 e0 47 11 80       	push   $0x801147e0
80104d5e:	e8 5d 0f 00 00       	call   80105cc0 <acquire>
80104d63:	83 c4 10             	add    $0x10,%esp
80104d66:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104d6d:	00 
80104d6e:	66 90                	xchg   %ax,%ax
      if(p->state != RUNNABLE)
80104d70:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80104d74:	75 33                	jne    80104da9 <scheduler+0x79>
      switchuvm(p);
80104d76:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80104d79:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80104d7f:	53                   	push   %ebx
80104d80:	e8 5b 38 00 00       	call   801085e0 <switchuvm>
      swtch(&(c->scheduler), p->context);
80104d85:	58                   	pop    %eax
80104d86:	5a                   	pop    %edx
80104d87:	ff 73 1c             	push   0x1c(%ebx)
80104d8a:	57                   	push   %edi
      p->state = RUNNING;
80104d8b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80104d92:	e8 04 12 00 00       	call   80105f9b <swtch>
      switchkvm();
80104d97:	e8 34 38 00 00       	call   801085d0 <switchkvm>
      c->proc = 0;
80104d9c:	83 c4 10             	add    $0x10,%esp
80104d9f:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80104da6:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104da9:	81 c3 24 8d 00 00    	add    $0x8d24,%ebx
80104daf:	81 fb 14 91 34 80    	cmp    $0x80349114,%ebx
80104db5:	75 b9                	jne    80104d70 <scheduler+0x40>
    release(&ptable.lock);
80104db7:	83 ec 0c             	sub    $0xc,%esp
80104dba:	68 e0 47 11 80       	push   $0x801147e0
80104dbf:	e8 9c 0e 00 00       	call   80105c60 <release>
    sti();
80104dc4:	83 c4 10             	add    $0x10,%esp
80104dc7:	eb 87                	jmp    80104d50 <scheduler+0x20>
80104dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104dd0 <sched>:
{
80104dd0:	55                   	push   %ebp
80104dd1:	89 e5                	mov    %esp,%ebp
80104dd3:	56                   	push   %esi
80104dd4:	53                   	push   %ebx
  pushcli();
80104dd5:	e8 96 0d 00 00       	call   80105b70 <pushcli>
  c = mycpu();
80104dda:	e8 01 fc ff ff       	call   801049e0 <mycpu>
  p = c->proc;
80104ddf:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104de5:	e8 d6 0d 00 00       	call   80105bc0 <popcli>
  if(!holding(&ptable.lock))
80104dea:	83 ec 0c             	sub    $0xc,%esp
80104ded:	68 e0 47 11 80       	push   $0x801147e0
80104df2:	e8 29 0e 00 00       	call   80105c20 <holding>
80104df7:	83 c4 10             	add    $0x10,%esp
80104dfa:	85 c0                	test   %eax,%eax
80104dfc:	74 4f                	je     80104e4d <sched+0x7d>
  if(mycpu()->ncli != 1)
80104dfe:	e8 dd fb ff ff       	call   801049e0 <mycpu>
80104e03:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80104e0a:	75 68                	jne    80104e74 <sched+0xa4>
  if(p->state == RUNNING)
80104e0c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80104e10:	74 55                	je     80104e67 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104e12:	9c                   	pushf
80104e13:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104e14:	f6 c4 02             	test   $0x2,%ah
80104e17:	75 41                	jne    80104e5a <sched+0x8a>
  intena = mycpu()->intena;
80104e19:	e8 c2 fb ff ff       	call   801049e0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80104e1e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80104e21:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80104e27:	e8 b4 fb ff ff       	call   801049e0 <mycpu>
80104e2c:	83 ec 08             	sub    $0x8,%esp
80104e2f:	ff 70 04             	push   0x4(%eax)
80104e32:	53                   	push   %ebx
80104e33:	e8 63 11 00 00       	call   80105f9b <swtch>
  mycpu()->intena = intena;
80104e38:	e8 a3 fb ff ff       	call   801049e0 <mycpu>
}
80104e3d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80104e40:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80104e46:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104e49:	5b                   	pop    %ebx
80104e4a:	5e                   	pop    %esi
80104e4b:	5d                   	pop    %ebp
80104e4c:	c3                   	ret
    panic("sched ptable.lock");
80104e4d:	83 ec 0c             	sub    $0xc,%esp
80104e50:	68 91 92 10 80       	push   $0x80109291
80104e55:	e8 76 b6 ff ff       	call   801004d0 <panic>
    panic("sched interruptible");
80104e5a:	83 ec 0c             	sub    $0xc,%esp
80104e5d:	68 bd 92 10 80       	push   $0x801092bd
80104e62:	e8 69 b6 ff ff       	call   801004d0 <panic>
    panic("sched running");
80104e67:	83 ec 0c             	sub    $0xc,%esp
80104e6a:	68 af 92 10 80       	push   $0x801092af
80104e6f:	e8 5c b6 ff ff       	call   801004d0 <panic>
    panic("sched locks");
80104e74:	83 ec 0c             	sub    $0xc,%esp
80104e77:	68 a3 92 10 80       	push   $0x801092a3
80104e7c:	e8 4f b6 ff ff       	call   801004d0 <panic>
80104e81:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104e88:	00 
80104e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104e90 <exit>:
{
80104e90:	55                   	push   %ebp
80104e91:	89 e5                	mov    %esp,%ebp
80104e93:	57                   	push   %edi
80104e94:	56                   	push   %esi
80104e95:	53                   	push   %ebx
80104e96:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80104e99:	e8 d2 fb ff ff       	call   80104a70 <myproc>
  if(curproc == initproc)
80104e9e:	39 05 14 91 34 80    	cmp    %eax,0x80349114
80104ea4:	0f 84 07 01 00 00    	je     80104fb1 <exit+0x121>
80104eaa:	89 c3                	mov    %eax,%ebx
80104eac:	8d 70 28             	lea    0x28(%eax),%esi
80104eaf:	8d 78 68             	lea    0x68(%eax),%edi
80104eb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
80104eb8:	8b 06                	mov    (%esi),%eax
80104eba:	85 c0                	test   %eax,%eax
80104ebc:	74 12                	je     80104ed0 <exit+0x40>
      fileclose(curproc->ofile[fd]);
80104ebe:	83 ec 0c             	sub    $0xc,%esp
80104ec1:	50                   	push   %eax
80104ec2:	e8 09 d1 ff ff       	call   80101fd0 <fileclose>
      curproc->ofile[fd] = 0;
80104ec7:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80104ecd:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80104ed0:	83 c6 04             	add    $0x4,%esi
80104ed3:	39 f7                	cmp    %esi,%edi
80104ed5:	75 e1                	jne    80104eb8 <exit+0x28>
  begin_op();
80104ed7:	e8 64 ef ff ff       	call   80103e40 <begin_op>
  iput(curproc->cwd);
80104edc:	83 ec 0c             	sub    $0xc,%esp
80104edf:	ff 73 68             	push   0x68(%ebx)
80104ee2:	e8 a9 da ff ff       	call   80102990 <iput>
  end_op();
80104ee7:	e8 c4 ef ff ff       	call   80103eb0 <end_op>
  curproc->cwd = 0;
80104eec:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
80104ef3:	c7 04 24 e0 47 11 80 	movl   $0x801147e0,(%esp)
80104efa:	e8 c1 0d 00 00       	call   80105cc0 <acquire>
  wakeup1(curproc->parent);
80104eff:	8b 53 14             	mov    0x14(%ebx),%edx
80104f02:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104f05:	b8 14 48 11 80       	mov    $0x80114814,%eax
80104f0a:	eb 10                	jmp    80104f1c <exit+0x8c>
80104f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104f10:	05 24 8d 00 00       	add    $0x8d24,%eax
80104f15:	3d 14 91 34 80       	cmp    $0x80349114,%eax
80104f1a:	74 1e                	je     80104f3a <exit+0xaa>
    if(p->state == SLEEPING && p->chan == chan)
80104f1c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104f20:	75 ee                	jne    80104f10 <exit+0x80>
80104f22:	3b 50 20             	cmp    0x20(%eax),%edx
80104f25:	75 e9                	jne    80104f10 <exit+0x80>
      p->state = RUNNABLE;
80104f27:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104f2e:	05 24 8d 00 00       	add    $0x8d24,%eax
80104f33:	3d 14 91 34 80       	cmp    $0x80349114,%eax
80104f38:	75 e2                	jne    80104f1c <exit+0x8c>
      p->parent = initproc;
80104f3a:	8b 0d 14 91 34 80    	mov    0x80349114,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104f40:	ba 14 48 11 80       	mov    $0x80114814,%edx
80104f45:	eb 17                	jmp    80104f5e <exit+0xce>
80104f47:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104f4e:	00 
80104f4f:	90                   	nop
80104f50:	81 c2 24 8d 00 00    	add    $0x8d24,%edx
80104f56:	81 fa 14 91 34 80    	cmp    $0x80349114,%edx
80104f5c:	74 3a                	je     80104f98 <exit+0x108>
    if(p->parent == curproc){
80104f5e:	39 5a 14             	cmp    %ebx,0x14(%edx)
80104f61:	75 ed                	jne    80104f50 <exit+0xc0>
      if(p->state == ZOMBIE)
80104f63:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80104f67:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80104f6a:	75 e4                	jne    80104f50 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104f6c:	b8 14 48 11 80       	mov    $0x80114814,%eax
80104f71:	eb 11                	jmp    80104f84 <exit+0xf4>
80104f73:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104f78:	05 24 8d 00 00       	add    $0x8d24,%eax
80104f7d:	3d 14 91 34 80       	cmp    $0x80349114,%eax
80104f82:	74 cc                	je     80104f50 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80104f84:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104f88:	75 ee                	jne    80104f78 <exit+0xe8>
80104f8a:	3b 48 20             	cmp    0x20(%eax),%ecx
80104f8d:	75 e9                	jne    80104f78 <exit+0xe8>
      p->state = RUNNABLE;
80104f8f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104f96:	eb e0                	jmp    80104f78 <exit+0xe8>
  curproc->state = ZOMBIE;
80104f98:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80104f9f:	e8 2c fe ff ff       	call   80104dd0 <sched>
  panic("zombie exit");
80104fa4:	83 ec 0c             	sub    $0xc,%esp
80104fa7:	68 de 92 10 80       	push   $0x801092de
80104fac:	e8 1f b5 ff ff       	call   801004d0 <panic>
    panic("init exiting");
80104fb1:	83 ec 0c             	sub    $0xc,%esp
80104fb4:	68 d1 92 10 80       	push   $0x801092d1
80104fb9:	e8 12 b5 ff ff       	call   801004d0 <panic>
80104fbe:	66 90                	xchg   %ax,%ax

80104fc0 <wait>:
{
80104fc0:	55                   	push   %ebp
80104fc1:	89 e5                	mov    %esp,%ebp
80104fc3:	56                   	push   %esi
80104fc4:	53                   	push   %ebx
  pushcli();
80104fc5:	e8 a6 0b 00 00       	call   80105b70 <pushcli>
  c = mycpu();
80104fca:	e8 11 fa ff ff       	call   801049e0 <mycpu>
  p = c->proc;
80104fcf:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104fd5:	e8 e6 0b 00 00       	call   80105bc0 <popcli>
  acquire(&ptable.lock);
80104fda:	83 ec 0c             	sub    $0xc,%esp
80104fdd:	68 e0 47 11 80       	push   $0x801147e0
80104fe2:	e8 d9 0c 00 00       	call   80105cc0 <acquire>
80104fe7:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80104fea:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104fec:	bb 14 48 11 80       	mov    $0x80114814,%ebx
80104ff1:	eb 13                	jmp    80105006 <wait+0x46>
80104ff3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104ff8:	81 c3 24 8d 00 00    	add    $0x8d24,%ebx
80104ffe:	81 fb 14 91 34 80    	cmp    $0x80349114,%ebx
80105004:	74 1e                	je     80105024 <wait+0x64>
      if(p->parent != curproc)
80105006:	39 73 14             	cmp    %esi,0x14(%ebx)
80105009:	75 ed                	jne    80104ff8 <wait+0x38>
      if(p->state == ZOMBIE){
8010500b:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010500f:	74 5f                	je     80105070 <wait+0xb0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105011:	81 c3 24 8d 00 00    	add    $0x8d24,%ebx
      havekids = 1;
80105017:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010501c:	81 fb 14 91 34 80    	cmp    $0x80349114,%ebx
80105022:	75 e2                	jne    80105006 <wait+0x46>
    if(!havekids || curproc->killed){
80105024:	85 c0                	test   %eax,%eax
80105026:	0f 84 9a 00 00 00    	je     801050c6 <wait+0x106>
8010502c:	8b 46 24             	mov    0x24(%esi),%eax
8010502f:	85 c0                	test   %eax,%eax
80105031:	0f 85 8f 00 00 00    	jne    801050c6 <wait+0x106>
  pushcli();
80105037:	e8 34 0b 00 00       	call   80105b70 <pushcli>
  c = mycpu();
8010503c:	e8 9f f9 ff ff       	call   801049e0 <mycpu>
  p = c->proc;
80105041:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80105047:	e8 74 0b 00 00       	call   80105bc0 <popcli>
  if(p == 0)
8010504c:	85 db                	test   %ebx,%ebx
8010504e:	0f 84 89 00 00 00    	je     801050dd <wait+0x11d>
  p->chan = chan;
80105054:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80105057:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
8010505e:	e8 6d fd ff ff       	call   80104dd0 <sched>
  p->chan = 0;
80105063:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
8010506a:	e9 7b ff ff ff       	jmp    80104fea <wait+0x2a>
8010506f:	90                   	nop
        kfree(p->kstack);
80105070:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
80105073:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80105076:	ff 73 08             	push   0x8(%ebx)
80105079:	e8 22 e5 ff ff       	call   801035a0 <kfree>
        p->kstack = 0;
8010507e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80105085:	5a                   	pop    %edx
80105086:	ff 73 04             	push   0x4(%ebx)
80105089:	e8 32 39 00 00       	call   801089c0 <freevm>
        p->pid = 0;
8010508e:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80105095:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010509c:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
801050a0:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
801050a7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
801050ae:	c7 04 24 e0 47 11 80 	movl   $0x801147e0,(%esp)
801050b5:	e8 a6 0b 00 00       	call   80105c60 <release>
        return pid;
801050ba:	83 c4 10             	add    $0x10,%esp
}
801050bd:	8d 65 f8             	lea    -0x8(%ebp),%esp
801050c0:	89 f0                	mov    %esi,%eax
801050c2:	5b                   	pop    %ebx
801050c3:	5e                   	pop    %esi
801050c4:	5d                   	pop    %ebp
801050c5:	c3                   	ret
      release(&ptable.lock);
801050c6:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801050c9:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
801050ce:	68 e0 47 11 80       	push   $0x801147e0
801050d3:	e8 88 0b 00 00       	call   80105c60 <release>
      return -1;
801050d8:	83 c4 10             	add    $0x10,%esp
801050db:	eb e0                	jmp    801050bd <wait+0xfd>
    panic("sleep");
801050dd:	83 ec 0c             	sub    $0xc,%esp
801050e0:	68 ea 92 10 80       	push   $0x801092ea
801050e5:	e8 e6 b3 ff ff       	call   801004d0 <panic>
801050ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801050f0 <yield>:
{
801050f0:	55                   	push   %ebp
801050f1:	89 e5                	mov    %esp,%ebp
801050f3:	53                   	push   %ebx
801050f4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
801050f7:	68 e0 47 11 80       	push   $0x801147e0
801050fc:	e8 bf 0b 00 00       	call   80105cc0 <acquire>
  pushcli();
80105101:	e8 6a 0a 00 00       	call   80105b70 <pushcli>
  c = mycpu();
80105106:	e8 d5 f8 ff ff       	call   801049e0 <mycpu>
  p = c->proc;
8010510b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80105111:	e8 aa 0a 00 00       	call   80105bc0 <popcli>
  myproc()->state = RUNNABLE;
80105116:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
8010511d:	e8 ae fc ff ff       	call   80104dd0 <sched>
  release(&ptable.lock);
80105122:	c7 04 24 e0 47 11 80 	movl   $0x801147e0,(%esp)
80105129:	e8 32 0b 00 00       	call   80105c60 <release>
}
8010512e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105131:	83 c4 10             	add    $0x10,%esp
80105134:	c9                   	leave
80105135:	c3                   	ret
80105136:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010513d:	00 
8010513e:	66 90                	xchg   %ax,%ax

80105140 <sleep>:
{
80105140:	55                   	push   %ebp
80105141:	89 e5                	mov    %esp,%ebp
80105143:	57                   	push   %edi
80105144:	56                   	push   %esi
80105145:	53                   	push   %ebx
80105146:	83 ec 0c             	sub    $0xc,%esp
80105149:	8b 7d 08             	mov    0x8(%ebp),%edi
8010514c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
8010514f:	e8 1c 0a 00 00       	call   80105b70 <pushcli>
  c = mycpu();
80105154:	e8 87 f8 ff ff       	call   801049e0 <mycpu>
  p = c->proc;
80105159:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010515f:	e8 5c 0a 00 00       	call   80105bc0 <popcli>
  if(p == 0)
80105164:	85 db                	test   %ebx,%ebx
80105166:	0f 84 87 00 00 00    	je     801051f3 <sleep+0xb3>
  if(lk == 0)
8010516c:	85 f6                	test   %esi,%esi
8010516e:	74 76                	je     801051e6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80105170:	81 fe e0 47 11 80    	cmp    $0x801147e0,%esi
80105176:	74 50                	je     801051c8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80105178:	83 ec 0c             	sub    $0xc,%esp
8010517b:	68 e0 47 11 80       	push   $0x801147e0
80105180:	e8 3b 0b 00 00       	call   80105cc0 <acquire>
    release(lk);
80105185:	89 34 24             	mov    %esi,(%esp)
80105188:	e8 d3 0a 00 00       	call   80105c60 <release>
  p->chan = chan;
8010518d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80105190:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80105197:	e8 34 fc ff ff       	call   80104dd0 <sched>
  p->chan = 0;
8010519c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
801051a3:	c7 04 24 e0 47 11 80 	movl   $0x801147e0,(%esp)
801051aa:	e8 b1 0a 00 00       	call   80105c60 <release>
    acquire(lk);
801051af:	89 75 08             	mov    %esi,0x8(%ebp)
801051b2:	83 c4 10             	add    $0x10,%esp
}
801051b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801051b8:	5b                   	pop    %ebx
801051b9:	5e                   	pop    %esi
801051ba:	5f                   	pop    %edi
801051bb:	5d                   	pop    %ebp
    acquire(lk);
801051bc:	e9 ff 0a 00 00       	jmp    80105cc0 <acquire>
801051c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
801051c8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801051cb:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801051d2:	e8 f9 fb ff ff       	call   80104dd0 <sched>
  p->chan = 0;
801051d7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
801051de:	8d 65 f4             	lea    -0xc(%ebp),%esp
801051e1:	5b                   	pop    %ebx
801051e2:	5e                   	pop    %esi
801051e3:	5f                   	pop    %edi
801051e4:	5d                   	pop    %ebp
801051e5:	c3                   	ret
    panic("sleep without lk");
801051e6:	83 ec 0c             	sub    $0xc,%esp
801051e9:	68 f0 92 10 80       	push   $0x801092f0
801051ee:	e8 dd b2 ff ff       	call   801004d0 <panic>
    panic("sleep");
801051f3:	83 ec 0c             	sub    $0xc,%esp
801051f6:	68 ea 92 10 80       	push   $0x801092ea
801051fb:	e8 d0 b2 ff ff       	call   801004d0 <panic>

80105200 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80105200:	55                   	push   %ebp
80105201:	89 e5                	mov    %esp,%ebp
80105203:	53                   	push   %ebx
80105204:	83 ec 10             	sub    $0x10,%esp
80105207:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010520a:	68 e0 47 11 80       	push   $0x801147e0
8010520f:	e8 ac 0a 00 00       	call   80105cc0 <acquire>
80105214:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105217:	b8 14 48 11 80       	mov    $0x80114814,%eax
8010521c:	eb 0e                	jmp    8010522c <wakeup+0x2c>
8010521e:	66 90                	xchg   %ax,%ax
80105220:	05 24 8d 00 00       	add    $0x8d24,%eax
80105225:	3d 14 91 34 80       	cmp    $0x80349114,%eax
8010522a:	74 1e                	je     8010524a <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
8010522c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80105230:	75 ee                	jne    80105220 <wakeup+0x20>
80105232:	3b 58 20             	cmp    0x20(%eax),%ebx
80105235:	75 e9                	jne    80105220 <wakeup+0x20>
      p->state = RUNNABLE;
80105237:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010523e:	05 24 8d 00 00       	add    $0x8d24,%eax
80105243:	3d 14 91 34 80       	cmp    $0x80349114,%eax
80105248:	75 e2                	jne    8010522c <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
8010524a:	c7 45 08 e0 47 11 80 	movl   $0x801147e0,0x8(%ebp)
}
80105251:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105254:	c9                   	leave
  release(&ptable.lock);
80105255:	e9 06 0a 00 00       	jmp    80105c60 <release>
8010525a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105260 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80105260:	55                   	push   %ebp
80105261:	89 e5                	mov    %esp,%ebp
80105263:	53                   	push   %ebx
80105264:	83 ec 10             	sub    $0x10,%esp
80105267:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010526a:	68 e0 47 11 80       	push   $0x801147e0
8010526f:	e8 4c 0a 00 00       	call   80105cc0 <acquire>
80105274:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105277:	b8 14 48 11 80       	mov    $0x80114814,%eax
8010527c:	eb 0e                	jmp    8010528c <kill+0x2c>
8010527e:	66 90                	xchg   %ax,%ax
80105280:	05 24 8d 00 00       	add    $0x8d24,%eax
80105285:	3d 14 91 34 80       	cmp    $0x80349114,%eax
8010528a:	74 34                	je     801052c0 <kill+0x60>
    if(p->pid == pid){
8010528c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010528f:	75 ef                	jne    80105280 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80105291:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80105295:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010529c:	75 07                	jne    801052a5 <kill+0x45>
        p->state = RUNNABLE;
8010529e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
801052a5:	83 ec 0c             	sub    $0xc,%esp
801052a8:	68 e0 47 11 80       	push   $0x801147e0
801052ad:	e8 ae 09 00 00       	call   80105c60 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
801052b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
801052b5:	83 c4 10             	add    $0x10,%esp
801052b8:	31 c0                	xor    %eax,%eax
}
801052ba:	c9                   	leave
801052bb:	c3                   	ret
801052bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
801052c0:	83 ec 0c             	sub    $0xc,%esp
801052c3:	68 e0 47 11 80       	push   $0x801147e0
801052c8:	e8 93 09 00 00       	call   80105c60 <release>
}
801052cd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
801052d0:	83 c4 10             	add    $0x10,%esp
801052d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801052d8:	c9                   	leave
801052d9:	c3                   	ret
801052da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801052e0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801052e0:	55                   	push   %ebp
801052e1:	89 e5                	mov    %esp,%ebp
801052e3:	57                   	push   %edi
801052e4:	56                   	push   %esi
801052e5:	8d 75 e8             	lea    -0x18(%ebp),%esi
801052e8:	53                   	push   %ebx
801052e9:	bb 80 48 11 80       	mov    $0x80114880,%ebx
801052ee:	83 ec 3c             	sub    $0x3c,%esp
801052f1:	eb 27                	jmp    8010531a <procdump+0x3a>
801052f3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801052f8:	83 ec 0c             	sub    $0xc,%esp
801052fb:	68 0c 95 10 80       	push   $0x8010950c
80105300:	e8 cb b4 ff ff       	call   801007d0 <cprintf>
80105305:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105308:	81 c3 24 8d 00 00    	add    $0x8d24,%ebx
8010530e:	81 fb 80 91 34 80    	cmp    $0x80349180,%ebx
80105314:	0f 84 7e 00 00 00    	je     80105398 <procdump+0xb8>
    if(p->state == UNUSED)
8010531a:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010531d:	85 c0                	test   %eax,%eax
8010531f:	74 e7                	je     80105308 <procdump+0x28>
      state = "???";
80105321:	ba 01 93 10 80       	mov    $0x80109301,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80105326:	83 f8 05             	cmp    $0x5,%eax
80105329:	77 11                	ja     8010533c <procdump+0x5c>
8010532b:	8b 14 85 80 9d 10 80 	mov    -0x7fef6280(,%eax,4),%edx
      state = "???";
80105332:	b8 01 93 10 80       	mov    $0x80109301,%eax
80105337:	85 d2                	test   %edx,%edx
80105339:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
8010533c:	53                   	push   %ebx
8010533d:	52                   	push   %edx
8010533e:	ff 73 a4             	push   -0x5c(%ebx)
80105341:	68 05 93 10 80       	push   $0x80109305
80105346:	e8 85 b4 ff ff       	call   801007d0 <cprintf>
    if(p->state == SLEEPING){
8010534b:	83 c4 10             	add    $0x10,%esp
8010534e:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80105352:	75 a4                	jne    801052f8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80105354:	83 ec 08             	sub    $0x8,%esp
80105357:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010535a:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010535d:	50                   	push   %eax
8010535e:	8b 43 b0             	mov    -0x50(%ebx),%eax
80105361:	8b 40 0c             	mov    0xc(%eax),%eax
80105364:	83 c0 08             	add    $0x8,%eax
80105367:	50                   	push   %eax
80105368:	e8 a3 07 00 00       	call   80105b10 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
8010536d:	83 c4 10             	add    $0x10,%esp
80105370:	8b 17                	mov    (%edi),%edx
80105372:	85 d2                	test   %edx,%edx
80105374:	74 82                	je     801052f8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80105376:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80105379:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
8010537c:	52                   	push   %edx
8010537d:	68 41 90 10 80       	push   $0x80109041
80105382:	e8 49 b4 ff ff       	call   801007d0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80105387:	83 c4 10             	add    $0x10,%esp
8010538a:	39 fe                	cmp    %edi,%esi
8010538c:	75 e2                	jne    80105370 <procdump+0x90>
8010538e:	e9 65 ff ff ff       	jmp    801052f8 <procdump+0x18>
80105393:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  }
}
80105398:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010539b:	5b                   	pop    %ebx
8010539c:	5e                   	pop    %esi
8010539d:	5f                   	pop    %edi
8010539e:	5d                   	pop    %ebp
8010539f:	c3                   	ret

801053a0 <create_palindrome>:

int 
create_palindrome(int num)
{
801053a0:	55                   	push   %ebp
801053a1:	89 e5                	mov    %esp,%ebp
801053a3:	57                   	push   %edi
801053a4:	8b 4d 08             	mov    0x8(%ebp),%ecx
801053a7:	56                   	push   %esi
801053a8:	53                   	push   %ebx
    //printf("The number is :%d\n",num);
 
    temp = num;
    
    //loop to find reverse number
    while(temp != 0)
801053a9:	85 c9                	test   %ecx,%ecx
801053ab:	74 43                	je     801053f0 <create_palindrome+0x50>
801053ad:	89 cb                	mov    %ecx,%ebx
    int reverse = 0, rem, temp;
801053af:	31 f6                	xor    %esi,%esi
    {
        rem = temp % 10;
801053b1:	bf 67 66 66 66       	mov    $0x66666667,%edi
801053b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801053bd:	00 
801053be:	66 90                	xchg   %ax,%ax
801053c0:	89 c8                	mov    %ecx,%eax
        reverse = reverse * 10 + rem;
801053c2:	8d 34 b6             	lea    (%esi,%esi,4),%esi
        temp /= 10;
        num *= 10;
801053c5:	8d 1c 9b             	lea    (%ebx,%ebx,4),%ebx
        rem = temp % 10;
801053c8:	f7 ef                	imul   %edi
801053ca:	89 c8                	mov    %ecx,%eax
        num *= 10;
801053cc:	01 db                	add    %ebx,%ebx
        rem = temp % 10;
801053ce:	c1 f8 1f             	sar    $0x1f,%eax
801053d1:	c1 fa 02             	sar    $0x2,%edx
801053d4:	29 c2                	sub    %eax,%edx
801053d6:	8d 04 92             	lea    (%edx,%edx,4),%eax
801053d9:	01 c0                	add    %eax,%eax
801053db:	29 c1                	sub    %eax,%ecx
        reverse = reverse * 10 + rem;
801053dd:	8d 34 71             	lea    (%ecx,%esi,2),%esi
        temp /= 10;
801053e0:	89 d1                	mov    %edx,%ecx
    while(temp != 0)
801053e2:	85 d2                	test   %edx,%edx
801053e4:	75 da                	jne    801053c0 <create_palindrome+0x20>
    };

    return num + reverse;
801053e6:	8d 04 1e             	lea    (%esi,%ebx,1),%eax
}
801053e9:	5b                   	pop    %ebx
801053ea:	5e                   	pop    %esi
801053eb:	5f                   	pop    %edi
801053ec:	5d                   	pop    %ebp
801053ed:	c3                   	ret
801053ee:	66 90                	xchg   %ax,%ax
801053f0:	5b                   	pop    %ebx
    while(temp != 0)
801053f1:	31 c0                	xor    %eax,%eax
}
801053f3:	5e                   	pop    %esi
801053f4:	5f                   	pop    %edi
801053f5:	5d                   	pop    %ebp
801053f6:	c3                   	ret
801053f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801053fe:	00 
801053ff:	90                   	nop

80105400 <find_process_by_id>:

// ----------------------------------------------------------------------
// Added function in Ex2
struct proc*
find_process_by_id(int pid)
{
80105400:	55                   	push   %ebp
80105401:	89 e5                	mov    %esp,%ebp
80105403:	56                   	push   %esi
80105404:	53                   	push   %ebx
80105405:	8b 75 08             	mov    0x8(%ebp),%esi
    struct proc *p;
    // Acquire the process table lock to ensure thread safety
    acquire(&ptable.lock);
    
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80105408:	bb 14 48 11 80       	mov    $0x80114814,%ebx
    acquire(&ptable.lock);
8010540d:	83 ec 0c             	sub    $0xc,%esp
80105410:	68 e0 47 11 80       	push   $0x801147e0
80105415:	e8 a6 08 00 00       	call   80105cc0 <acquire>
8010541a:	83 c4 10             	add    $0x10,%esp
8010541d:	eb 0f                	jmp    8010542e <find_process_by_id+0x2e>
8010541f:	90                   	nop
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80105420:	81 c3 24 8d 00 00    	add    $0x8d24,%ebx
80105426:	81 fb 14 91 34 80    	cmp    $0x80349114,%ebx
8010542c:	74 22                	je     80105450 <find_process_by_id+0x50>
        if (p->pid == pid) {
8010542e:	39 73 10             	cmp    %esi,0x10(%ebx)
80105431:	75 ed                	jne    80105420 <find_process_by_id+0x20>
            // If the process was found, release the lock and return the process pointer
            release(&ptable.lock);
80105433:	83 ec 0c             	sub    $0xc,%esp
80105436:	68 e0 47 11 80       	push   $0x801147e0
8010543b:	e8 20 08 00 00       	call   80105c60 <release>
            return p;
80105440:	83 c4 10             	add    $0x10,%esp
    }
    
    // if the process wasn'y found, release the lock and return 0
    release(&ptable.lock);
    return 0;
}
80105443:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105446:	89 d8                	mov    %ebx,%eax
80105448:	5b                   	pop    %ebx
80105449:	5e                   	pop    %esi
8010544a:	5d                   	pop    %ebp
8010544b:	c3                   	ret
8010544c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    release(&ptable.lock);
80105450:	83 ec 0c             	sub    $0xc,%esp
    return 0;
80105453:	31 db                	xor    %ebx,%ebx
    release(&ptable.lock);
80105455:	68 e0 47 11 80       	push   $0x801147e0
8010545a:	e8 01 08 00 00       	call   80105c60 <release>
    return 0;
8010545f:	83 c4 10             	add    $0x10,%esp
}
80105462:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105465:	89 d8                	mov    %ebx,%eax
80105467:	5b                   	pop    %ebx
80105468:	5e                   	pop    %esi
80105469:	5d                   	pop    %ebp
8010546a:	c3                   	ret
8010546b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105470 <sort_syscalls>:
// ----------------------------------------------------------------------

// ----------------------------------------------------------------------
// Added function in Ex2
int sort_syscalls(int pid)
{
80105470:	55                   	push   %ebp
80105471:	89 e5                	mov    %esp,%ebp
80105473:	57                   	push   %edi
80105474:	56                   	push   %esi
80105475:	53                   	push   %ebx
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80105476:	bb 14 48 11 80       	mov    $0x80114814,%ebx
{
8010547b:	83 ec 78             	sub    $0x78,%esp
8010547e:	8b 75 08             	mov    0x8(%ebp),%esi
    acquire(&ptable.lock);
80105481:	68 e0 47 11 80       	push   $0x801147e0
80105486:	e8 35 08 00 00       	call   80105cc0 <acquire>
8010548b:	83 c4 10             	add    $0x10,%esp
8010548e:	eb 12                	jmp    801054a2 <sort_syscalls+0x32>
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80105490:	81 c3 24 8d 00 00    	add    $0x8d24,%ebx
80105496:	81 fb 14 91 34 80    	cmp    $0x80349114,%ebx
8010549c:	0f 84 2c 02 00 00    	je     801056ce <sort_syscalls+0x25e>
        if (p->pid == pid) {
801054a2:	3b 73 10             	cmp    0x10(%ebx),%esi
801054a5:	75 e9                	jne    80105490 <sort_syscalls+0x20>
            release(&ptable.lock);
801054a7:	83 ec 0c             	sub    $0xc,%esp
801054aa:	68 e0 47 11 80       	push   $0x801147e0
801054af:	e8 ac 07 00 00       	call   80105c60 <release>
        cprintf("Kernel: Process with ID %d not found\n", pid);
        return -1;
    }


    int count = p->syscall_count;
801054b4:	8b 83 1c 8d 00 00    	mov    0x8d1c(%ebx),%eax
    if (count == 0) {
801054ba:	83 c4 10             	add    $0x10,%esp
    int count = p->syscall_count;
801054bd:	89 45 90             	mov    %eax,-0x70(%ebp)
    if (count == 0) {
801054c0:	85 c0                	test   %eax,%eax
801054c2:	0f 84 35 02 00 00    	je     801056fd <sort_syscalls+0x28d>
      cprintf("No system calls yet.\n");
      return 0;
    }

    // don't change the original system calls order
    struct syscall_info copied_syscalls[count];
801054c8:	8b 45 90             	mov    -0x70(%ebp),%eax
801054cb:	89 e1                	mov    %esp,%ecx
801054cd:	8d 70 ff             	lea    -0x1(%eax),%esi
801054d0:	89 75 98             	mov    %esi,-0x68(%ebp)
801054d3:	8d 34 c0             	lea    (%eax,%eax,8),%esi
801054d6:	c1 e6 02             	shl    $0x2,%esi
801054d9:	8d 46 0f             	lea    0xf(%esi),%eax
801054dc:	89 c2                	mov    %eax,%edx
801054de:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801054e3:	29 c1                	sub    %eax,%ecx
801054e5:	83 e2 f0             	and    $0xfffffff0,%edx
801054e8:	39 cc                	cmp    %ecx,%esp
801054ea:	74 12                	je     801054fe <sort_syscalls+0x8e>
801054ec:	81 ec 00 10 00 00    	sub    $0x1000,%esp
801054f2:	83 8c 24 fc 0f 00 00 	orl    $0x0,0xffc(%esp)
801054f9:	00 
801054fa:	39 cc                	cmp    %ecx,%esp
801054fc:	75 ee                	jne    801054ec <sort_syscalls+0x7c>
801054fe:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
80105504:	29 d4                	sub    %edx,%esp
80105506:	85 d2                	test   %edx,%edx
80105508:	0f 85 0a 02 00 00    	jne    80105718 <sort_syscalls+0x2a8>
    int cnt = 0;
    while (cnt < count) {
8010550e:	8b 7d 90             	mov    -0x70(%ebp),%edi
    struct syscall_info copied_syscalls[count];
80105511:	89 e0                	mov    %esp,%eax
            }
        }
    }

    // print the sorted system calls
    cprintf("Sorting system calls of process %s:\n", p->name);
80105513:	8d 4b 6c             	lea    0x6c(%ebx),%ecx
    struct syscall_info copied_syscalls[count];
80105516:	89 45 94             	mov    %eax,-0x6c(%ebp)
    cprintf("Sorting system calls of process %s:\n", p->name);
80105519:	89 4d 8c             	mov    %ecx,-0x74(%ebp)
    while (cnt < count) {
8010551c:	85 ff                	test   %edi,%edi
8010551e:	0f 8e fe 01 00 00    	jle    80105722 <sort_syscalls+0x2b2>
80105524:	83 c3 7c             	add    $0x7c,%ebx
80105527:	8d 14 33             	lea    (%ebx,%esi,1),%edx
8010552a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      copied_syscalls[cnt] = p->syscalls[cnt];
80105530:	8b 0b                	mov    (%ebx),%ecx
    while (cnt < count) {
80105532:	83 c3 24             	add    $0x24,%ebx
80105535:	83 c0 24             	add    $0x24,%eax
      copied_syscalls[cnt] = p->syscalls[cnt];
80105538:	89 48 dc             	mov    %ecx,-0x24(%eax)
8010553b:	8b 4b e0             	mov    -0x20(%ebx),%ecx
8010553e:	89 48 e0             	mov    %ecx,-0x20(%eax)
80105541:	8b 4b e4             	mov    -0x1c(%ebx),%ecx
80105544:	89 48 e4             	mov    %ecx,-0x1c(%eax)
80105547:	8b 4b e8             	mov    -0x18(%ebx),%ecx
8010554a:	89 48 e8             	mov    %ecx,-0x18(%eax)
8010554d:	8b 4b ec             	mov    -0x14(%ebx),%ecx
80105550:	89 48 ec             	mov    %ecx,-0x14(%eax)
80105553:	8b 4b f0             	mov    -0x10(%ebx),%ecx
80105556:	89 48 f0             	mov    %ecx,-0x10(%eax)
80105559:	8b 4b f4             	mov    -0xc(%ebx),%ecx
8010555c:	89 48 f4             	mov    %ecx,-0xc(%eax)
8010555f:	8b 4b f8             	mov    -0x8(%ebx),%ecx
80105562:	89 48 f8             	mov    %ecx,-0x8(%eax)
80105565:	8b 4b fc             	mov    -0x4(%ebx),%ecx
80105568:	89 48 fc             	mov    %ecx,-0x4(%eax)
    while (cnt < count) {
8010556b:	39 d3                	cmp    %edx,%ebx
8010556d:	75 c1                	jne    80105530 <sort_syscalls+0xc0>
    for (int i = 0; i < count-1; i++) {
8010556f:	8b 55 98             	mov    -0x68(%ebp),%edx
80105572:	85 d2                	test   %edx,%edx
80105574:	0f 8e cb 01 00 00    	jle    80105745 <sort_syscalls+0x2d5>
8010557a:	8b 45 94             	mov    -0x6c(%ebp),%eax
8010557d:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%ebp)
80105584:	8d 44 30 dc          	lea    -0x24(%eax,%esi,1),%eax
80105588:	89 45 b4             	mov    %eax,-0x4c(%ebp)
8010558b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        for (int j = 0; j < count-i-1; j++) {
80105590:	8b 45 98             	mov    -0x68(%ebp),%eax
80105593:	2b 45 9c             	sub    -0x64(%ebp),%eax
80105596:	8b 55 94             	mov    -0x6c(%ebp),%edx
80105599:	85 c0                	test   %eax,%eax
8010559b:	0f 8e bf 00 00 00    	jle    80105660 <sort_syscalls+0x1f0>
801055a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            if (copied_syscalls[j].number > copied_syscalls[j+1].number) {
801055a8:	8b 42 20             	mov    0x20(%edx),%eax
801055ab:	3b 42 44             	cmp    0x44(%edx),%eax
801055ae:	0f 8e a0 00 00 00    	jle    80105654 <sort_syscalls+0x1e4>
                struct syscall_info temp = copied_syscalls[j];
801055b4:	8b 3a                	mov    (%edx),%edi
801055b6:	8b 72 04             	mov    0x4(%edx),%esi
801055b9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801055bc:	8b 4a 08             	mov    0x8(%edx),%ecx
801055bf:	8b 5a 0c             	mov    0xc(%edx),%ebx
801055c2:	89 7d b0             	mov    %edi,-0x50(%ebp)
801055c5:	89 7d c4             	mov    %edi,-0x3c(%ebp)
801055c8:	8b 7a 10             	mov    0x10(%edx),%edi
801055cb:	89 75 ac             	mov    %esi,-0x54(%ebp)
801055ce:	89 7d a0             	mov    %edi,-0x60(%ebp)
801055d1:	89 7d d4             	mov    %edi,-0x2c(%ebp)
                copied_syscalls[j] = copied_syscalls[j+1];
801055d4:	8b 7a 24             	mov    0x24(%edx),%edi
                struct syscall_info temp = copied_syscalls[j];
801055d7:	89 75 c8             	mov    %esi,-0x38(%ebp)
801055da:	8b 72 14             	mov    0x14(%edx),%esi
                copied_syscalls[j] = copied_syscalls[j+1];
801055dd:	89 3a                	mov    %edi,(%edx)
801055df:	8b 7a 28             	mov    0x28(%edx),%edi
                struct syscall_info temp = copied_syscalls[j];
801055e2:	89 4d a8             	mov    %ecx,-0x58(%ebp)
                copied_syscalls[j] = copied_syscalls[j+1];
801055e5:	89 7a 04             	mov    %edi,0x4(%edx)
801055e8:	8b 7a 2c             	mov    0x2c(%edx),%edi
                struct syscall_info temp = copied_syscalls[j];
801055eb:	89 4d cc             	mov    %ecx,-0x34(%ebp)
801055ee:	8b 4a 1c             	mov    0x1c(%edx),%ecx
                copied_syscalls[j] = copied_syscalls[j+1];
801055f1:	89 7a 08             	mov    %edi,0x8(%edx)
801055f4:	8b 7a 30             	mov    0x30(%edx),%edi
                struct syscall_info temp = copied_syscalls[j];
801055f7:	89 5d a4             	mov    %ebx,-0x5c(%ebp)
801055fa:	89 5d d0             	mov    %ebx,-0x30(%ebp)
801055fd:	8b 5a 18             	mov    0x18(%edx),%ebx
                copied_syscalls[j] = copied_syscalls[j+1];
80105600:	89 7a 0c             	mov    %edi,0xc(%edx)
80105603:	8b 7a 34             	mov    0x34(%edx),%edi
                struct syscall_info temp = copied_syscalls[j];
80105606:	89 75 d8             	mov    %esi,-0x28(%ebp)
80105609:	89 5d dc             	mov    %ebx,-0x24(%ebp)
8010560c:	89 4d e0             	mov    %ecx,-0x20(%ebp)
                copied_syscalls[j] = copied_syscalls[j+1];
8010560f:	89 7a 10             	mov    %edi,0x10(%edx)
80105612:	8b 7a 38             	mov    0x38(%edx),%edi
                copied_syscalls[j+1] = temp;
80105615:	89 72 38             	mov    %esi,0x38(%edx)
                copied_syscalls[j] = copied_syscalls[j+1];
80105618:	89 7a 14             	mov    %edi,0x14(%edx)
8010561b:	8b 7a 3c             	mov    0x3c(%edx),%edi
                copied_syscalls[j+1] = temp;
8010561e:	89 5a 3c             	mov    %ebx,0x3c(%edx)
                copied_syscalls[j] = copied_syscalls[j+1];
80105621:	89 7a 18             	mov    %edi,0x18(%edx)
80105624:	8b 7a 40             	mov    0x40(%edx),%edi
                copied_syscalls[j+1] = temp;
80105627:	89 4a 40             	mov    %ecx,0x40(%edx)
                copied_syscalls[j] = copied_syscalls[j+1];
8010562a:	89 7a 1c             	mov    %edi,0x1c(%edx)
8010562d:	8b 7a 44             	mov    0x44(%edx),%edi
                copied_syscalls[j+1] = temp;
80105630:	89 42 44             	mov    %eax,0x44(%edx)
                copied_syscalls[j] = copied_syscalls[j+1];
80105633:	89 7a 20             	mov    %edi,0x20(%edx)
                copied_syscalls[j+1] = temp;
80105636:	8b 7d b0             	mov    -0x50(%ebp),%edi
80105639:	89 7a 24             	mov    %edi,0x24(%edx)
8010563c:	8b 7d ac             	mov    -0x54(%ebp),%edi
8010563f:	89 7a 28             	mov    %edi,0x28(%edx)
80105642:	8b 7d a8             	mov    -0x58(%ebp),%edi
80105645:	89 7a 2c             	mov    %edi,0x2c(%edx)
80105648:	8b 7d a4             	mov    -0x5c(%ebp),%edi
8010564b:	89 7a 30             	mov    %edi,0x30(%edx)
8010564e:	8b 7d a0             	mov    -0x60(%ebp),%edi
80105651:	89 7a 34             	mov    %edi,0x34(%edx)
        for (int j = 0; j < count-i-1; j++) {
80105654:	83 c2 24             	add    $0x24,%edx
80105657:	3b 55 b4             	cmp    -0x4c(%ebp),%edx
8010565a:	0f 85 48 ff ff ff    	jne    801055a8 <sort_syscalls+0x138>
    for (int i = 0; i < count-1; i++) {
80105660:	83 45 9c 01          	addl   $0x1,-0x64(%ebp)
80105664:	8b 45 9c             	mov    -0x64(%ebp),%eax
80105667:	83 6d b4 24          	subl   $0x24,-0x4c(%ebp)
8010566b:	39 45 98             	cmp    %eax,-0x68(%ebp)
8010566e:	0f 8f 1c ff ff ff    	jg     80105590 <sort_syscalls+0x120>
    cprintf("Sorting system calls of process %s:\n", p->name);
80105674:	83 ec 08             	sub    $0x8,%esp
80105677:	ff 75 8c             	push   -0x74(%ebp)
8010567a:	68 d0 96 10 80       	push   $0x801096d0
8010567f:	e8 4c b1 ff ff       	call   801007d0 <cprintf>
    for (int i=0; i<count; i++) {
80105684:	8b 4d 90             	mov    -0x70(%ebp),%ecx
80105687:	83 c4 10             	add    $0x10,%esp
8010568a:	85 c9                	test   %ecx,%ecx
8010568c:	7e 2e                	jle    801056bc <sort_syscalls+0x24c>
8010568e:	8b 75 94             	mov    -0x6c(%ebp),%esi
    for (int i = 0; i < count-1; i++) {
80105691:	8b 7d 90             	mov    -0x70(%ebp),%edi
80105694:	31 db                	xor    %ebx,%ebx
80105696:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010569d:	00 
8010569e:	66 90                	xchg   %ax,%ax
        cprintf("\t%d. %s (%d)\n", i+1, copied_syscalls[i].name, copied_syscalls[i].number);
801056a0:	83 c3 01             	add    $0x1,%ebx
801056a3:	ff 76 20             	push   0x20(%esi)
801056a6:	56                   	push   %esi
    for (int i=0; i<count; i++) {
801056a7:	83 c6 24             	add    $0x24,%esi
        cprintf("\t%d. %s (%d)\n", i+1, copied_syscalls[i].name, copied_syscalls[i].number);
801056aa:	53                   	push   %ebx
801056ab:	68 24 93 10 80       	push   $0x80109324
801056b0:	e8 1b b1 ff ff       	call   801007d0 <cprintf>
    for (int i=0; i<count; i++) {
801056b5:	83 c4 10             	add    $0x10,%esp
801056b8:	39 fb                	cmp    %edi,%ebx
801056ba:	7c e4                	jl     801056a0 <sort_syscalls+0x230>
    }

    return 0;
801056bc:	c7 45 90 00 00 00 00 	movl   $0x0,-0x70(%ebp)
}
801056c3:	8b 45 90             	mov    -0x70(%ebp),%eax
801056c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801056c9:	5b                   	pop    %ebx
801056ca:	5e                   	pop    %esi
801056cb:	5f                   	pop    %edi
801056cc:	5d                   	pop    %ebp
801056cd:	c3                   	ret
    release(&ptable.lock);
801056ce:	83 ec 0c             	sub    $0xc,%esp
801056d1:	68 e0 47 11 80       	push   $0x801147e0
801056d6:	e8 85 05 00 00       	call   80105c60 <release>
        cprintf("Kernel: Process with ID %d not found\n", pid);
801056db:	58                   	pop    %eax
801056dc:	5a                   	pop    %edx
801056dd:	56                   	push   %esi
801056de:	68 a8 96 10 80       	push   $0x801096a8
801056e3:	e8 e8 b0 ff ff       	call   801007d0 <cprintf>
        return -1;
801056e8:	c7 45 90 ff ff ff ff 	movl   $0xffffffff,-0x70(%ebp)
801056ef:	83 c4 10             	add    $0x10,%esp
}
801056f2:	8b 45 90             	mov    -0x70(%ebp),%eax
801056f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801056f8:	5b                   	pop    %ebx
801056f9:	5e                   	pop    %esi
801056fa:	5f                   	pop    %edi
801056fb:	5d                   	pop    %ebp
801056fc:	c3                   	ret
      cprintf("No system calls yet.\n");
801056fd:	83 ec 0c             	sub    $0xc,%esp
80105700:	68 0e 93 10 80       	push   $0x8010930e
80105705:	e8 c6 b0 ff ff       	call   801007d0 <cprintf>
}
8010570a:	8b 45 90             	mov    -0x70(%ebp),%eax
      return 0;
8010570d:	83 c4 10             	add    $0x10,%esp
}
80105710:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105713:	5b                   	pop    %ebx
80105714:	5e                   	pop    %esi
80105715:	5f                   	pop    %edi
80105716:	5d                   	pop    %ebp
80105717:	c3                   	ret
    struct syscall_info copied_syscalls[count];
80105718:	83 4c 14 fc 00       	orl    $0x0,-0x4(%esp,%edx,1)
8010571d:	e9 ec fd ff ff       	jmp    8010550e <sort_syscalls+0x9e>
    for (int i = 0; i < count-1; i++) {
80105722:	8b 45 98             	mov    -0x68(%ebp),%eax
80105725:	85 c0                	test   %eax,%eax
80105727:	0f 8f 4d fe ff ff    	jg     8010557a <sort_syscalls+0x10a>
    cprintf("Sorting system calls of process %s:\n", p->name);
8010572d:	83 ec 08             	sub    $0x8,%esp
80105730:	ff 75 8c             	push   -0x74(%ebp)
80105733:	68 d0 96 10 80       	push   $0x801096d0
80105738:	e8 93 b0 ff ff       	call   801007d0 <cprintf>
8010573d:	83 c4 10             	add    $0x10,%esp
80105740:	e9 77 ff ff ff       	jmp    801056bc <sort_syscalls+0x24c>
80105745:	83 ec 08             	sub    $0x8,%esp
80105748:	ff 75 8c             	push   -0x74(%ebp)
8010574b:	68 d0 96 10 80       	push   $0x801096d0
80105750:	e8 7b b0 ff ff       	call   801007d0 <cprintf>
80105755:	83 c4 10             	add    $0x10,%esp
80105758:	e9 31 ff ff ff       	jmp    8010568e <sort_syscalls+0x21e>
8010575d:	8d 76 00             	lea    0x0(%esi),%esi

80105760 <get_most_invoked_syscall>:
// ----------------------------------------------------------------------

// ----------------------------------------------------------------------
int
get_most_invoked_syscall(int pid)
{
80105760:	55                   	push   %ebp
80105761:	89 e5                	mov    %esp,%ebp
80105763:	57                   	push   %edi
80105764:	56                   	push   %esi
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80105765:	be 14 48 11 80       	mov    $0x80114814,%esi
{
8010576a:	53                   	push   %ebx
8010576b:	81 ec 98 00 00 00    	sub    $0x98,%esp
80105771:	8b 5d 08             	mov    0x8(%ebp),%ebx
    acquire(&ptable.lock);
80105774:	68 e0 47 11 80       	push   $0x801147e0
80105779:	e8 42 05 00 00       	call   80105cc0 <acquire>
8010577e:	83 c4 10             	add    $0x10,%esp
80105781:	eb 17                	jmp    8010579a <get_most_invoked_syscall+0x3a>
80105783:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80105788:	81 c6 24 8d 00 00    	add    $0x8d24,%esi
8010578e:	81 fe 14 91 34 80    	cmp    $0x80349114,%esi
80105794:	0f 84 4c 01 00 00    	je     801058e6 <get_most_invoked_syscall+0x186>
        if (p->pid == pid) {
8010579a:	3b 5e 10             	cmp    0x10(%esi),%ebx
8010579d:	75 e9                	jne    80105788 <get_most_invoked_syscall+0x28>
            release(&ptable.lock);
8010579f:	83 ec 0c             	sub    $0xc,%esp
801057a2:	68 e0 47 11 80       	push   $0x801147e0
801057a7:	e8 b4 04 00 00       	call   80105c60 <release>
    {
        cprintf("Process with ID %d not found\n", pid);
        return -1;
    }

    int count = p->syscall_count;
801057ac:	8b 9e 1c 8d 00 00    	mov    0x8d1c(%esi),%ebx
    if (count == 0)
801057b2:	83 c4 10             	add    $0x10,%esp
801057b5:	85 db                	test   %ebx,%ebx
801057b7:	0f 84 74 01 00 00    	je     80105931 <get_most_invoked_syscall+0x1d1>
    {
      cprintf("No system calls in the %s process yet.\n", p->name);
      return -1;
    }

    int counts[30] = {0};
801057bd:	b9 1e 00 00 00       	mov    $0x1e,%ecx
801057c2:	b8 00 00 00 00       	mov    $0x0,%eax
801057c7:	8d bd 70 ff ff ff    	lea    -0x90(%ebp),%edi
801057cd:	f3 ab                	rep stos %eax,%es:(%edi)

    int max_freq = -1;
    int cnt = 0;
    while (cnt < count)
801057cf:	0f 8e 4f 01 00 00    	jle    80105924 <get_most_invoked_syscall+0x1c4>
801057d5:	8d 96 9c 00 00 00    	lea    0x9c(%esi),%edx
801057db:	8d 04 db             	lea    (%ebx,%ebx,8),%eax
    int max_freq = -1;
801057de:	bf ff ff ff ff       	mov    $0xffffffff,%edi
801057e3:	8d 1c 82             	lea    (%edx,%eax,4),%ebx
801057e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801057ed:	00 
801057ee:	66 90                	xchg   %ax,%ax
    {
      counts[p->syscalls[cnt].number]++;
801057f0:	8b 0a                	mov    (%edx),%ecx
801057f2:	8b 84 8d 70 ff ff ff 	mov    -0x90(%ebp,%ecx,4),%eax
801057f9:	83 c0 01             	add    $0x1,%eax
801057fc:	39 c7                	cmp    %eax,%edi
801057fe:	89 84 8d 70 ff ff ff 	mov    %eax,-0x90(%ebp,%ecx,4)
      if (counts[p->syscalls[cnt].number] > max_freq)
80105805:	0f 4c f8             	cmovl  %eax,%edi
    while (cnt < count)
80105808:	83 c2 24             	add    $0x24,%edx
8010580b:	39 da                	cmp    %ebx,%edx
8010580d:	75 e1                	jne    801057f0 <get_most_invoked_syscall+0x90>
          max_freq = counts[p->syscalls[cnt].number]; 
      }
      cnt++;
    }

    if (max_freq == -1)
8010580f:	83 ff ff             	cmp    $0xffffffff,%edi
80105812:	0f 84 0c 01 00 00    	je     80105924 <get_most_invoked_syscall+0x1c4>
80105818:	8d 9d 70 ff ff ff    	lea    -0x90(%ebp),%ebx
    {
        return -1;
    }

    int max_count = 0;
8010581e:	31 d2                	xor    %edx,%edx
    if (max_freq == -1)
80105820:	89 d8                	mov    %ebx,%eax
80105822:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cnt = 0;
    for (int i=0; i<30; i++) 
    {
        if (counts[i] == max_freq)
        {
            max_count++;
80105828:	31 c9                	xor    %ecx,%ecx
8010582a:	39 38                	cmp    %edi,(%eax)
8010582c:	0f 94 c1             	sete   %cl
    for (int i=0; i<30; i++) 
8010582f:	83 c0 04             	add    $0x4,%eax
            max_count++;
80105832:	01 ca                	add    %ecx,%edx
    for (int i=0; i<30; i++) 
80105834:	8d 4d e8             	lea    -0x18(%ebp),%ecx
80105837:	39 c8                	cmp    %ecx,%eax
80105839:	75 ed                	jne    80105828 <get_most_invoked_syscall+0xc8>
        }
    }

    if (max_count == 0) 
8010583b:	85 d2                	test   %edx,%edx
8010583d:	0f 84 cd 00 00 00    	je     80105910 <get_most_invoked_syscall+0x1b0>
    {
        cprintf("No most invoked system call found for process with ID %s\n", p->name);
        return -1;
    }
    else if (max_count == 1)
80105843:	83 fa 01             	cmp    $0x1,%edx
80105846:	75 58                	jne    801058a0 <get_most_invoked_syscall+0x140>
80105848:	be 20 c0 10 80       	mov    $0x8010c020,%esi
8010584d:	b8 a4 c3 10 80       	mov    $0x8010c3a4,%eax
80105852:	eb 0e                	jmp    80105862 <get_most_invoked_syscall+0x102>
80105854:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    {
        for (int i=0; i<30; i++) 
80105858:	83 c6 1e             	add    $0x1e,%esi
8010585b:	83 c3 04             	add    $0x4,%ebx
8010585e:	39 f0                	cmp    %esi,%eax
80105860:	74 2e                	je     80105890 <get_most_invoked_syscall+0x130>
        {
            if (counts[i] == max_freq)
80105862:	39 3b                	cmp    %edi,(%ebx)
80105864:	75 f2                	jne    80105858 <get_most_invoked_syscall+0xf8>
            {
                cprintf("The most invoked process is %s with %d times\n", system_call_titles[i], counts[i]);
80105866:	83 ec 04             	sub    $0x4,%esp
        for (int i=0; i<30; i++) 
80105869:	83 c3 04             	add    $0x4,%ebx
                cprintf("The most invoked process is %s with %d times\n", system_call_titles[i], counts[i]);
8010586c:	57                   	push   %edi
8010586d:	56                   	push   %esi
        for (int i=0; i<30; i++) 
8010586e:	83 c6 1e             	add    $0x1e,%esi
                cprintf("The most invoked process is %s with %d times\n", system_call_titles[i], counts[i]);
80105871:	68 5c 97 10 80       	push   $0x8010975c
80105876:	e8 55 af ff ff       	call   801007d0 <cprintf>
8010587b:	b8 a4 c3 10 80       	mov    $0x8010c3a4,%eax
80105880:	83 c4 10             	add    $0x10,%esp
        for (int i=0; i<30; i++) 
80105883:	39 f0                	cmp    %esi,%eax
80105885:	75 db                	jne    80105862 <get_most_invoked_syscall+0x102>
80105887:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010588e:	00 
8010588f:	90                   	nop
            }
        }
        return 0;
80105890:	31 c0                	xor    %eax,%eax
            }
        }

        return 0;
    }
}
80105892:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105895:	5b                   	pop    %ebx
80105896:	5e                   	pop    %esi
80105897:	5f                   	pop    %edi
80105898:	5d                   	pop    %ebp
80105899:	c3                   	ret
8010589a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        cprintf("There are several system calls with the most count:\n");
801058a0:	83 ec 0c             	sub    $0xc,%esp
801058a3:	be 20 c0 10 80       	mov    $0x8010c020,%esi
801058a8:	68 8c 97 10 80       	push   $0x8010978c
801058ad:	e8 1e af ff ff       	call   801007d0 <cprintf>
        for (int i=0; i<30; i++) 
801058b2:	83 c4 10             	add    $0x10,%esp
801058b5:	eb 17                	jmp    801058ce <get_most_invoked_syscall+0x16e>
801058b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801058be:	00 
801058bf:	90                   	nop
801058c0:	83 c6 1e             	add    $0x1e,%esi
801058c3:	83 c3 04             	add    $0x4,%ebx
801058c6:	81 fe a4 c3 10 80    	cmp    $0x8010c3a4,%esi
801058cc:	74 c2                	je     80105890 <get_most_invoked_syscall+0x130>
            if (counts[i] == max_freq)
801058ce:	39 3b                	cmp    %edi,(%ebx)
801058d0:	75 ee                	jne    801058c0 <get_most_invoked_syscall+0x160>
                cprintf("    %d. %s with %d times.\n", system_call_titles[i], counts[i]);
801058d2:	83 ec 04             	sub    $0x4,%esp
801058d5:	57                   	push   %edi
801058d6:	56                   	push   %esi
801058d7:	68 50 93 10 80       	push   $0x80109350
801058dc:	e8 ef ae ff ff       	call   801007d0 <cprintf>
801058e1:	83 c4 10             	add    $0x10,%esp
801058e4:	eb da                	jmp    801058c0 <get_most_invoked_syscall+0x160>
    release(&ptable.lock);
801058e6:	83 ec 0c             	sub    $0xc,%esp
801058e9:	68 e0 47 11 80       	push   $0x801147e0
801058ee:	e8 6d 03 00 00       	call   80105c60 <release>
        cprintf("Process with ID %d not found\n", pid);
801058f3:	58                   	pop    %eax
801058f4:	5a                   	pop    %edx
801058f5:	53                   	push   %ebx
801058f6:	68 32 93 10 80       	push   $0x80109332
801058fb:	e8 d0 ae ff ff       	call   801007d0 <cprintf>
        return -1;
80105900:	83 c4 10             	add    $0x10,%esp
}
80105903:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80105906:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010590b:	5b                   	pop    %ebx
8010590c:	5e                   	pop    %esi
8010590d:	5f                   	pop    %edi
8010590e:	5d                   	pop    %ebp
8010590f:	c3                   	ret
        cprintf("No most invoked system call found for process with ID %s\n", p->name);
80105910:	83 ec 08             	sub    $0x8,%esp
80105913:	83 c6 6c             	add    $0x6c,%esi
80105916:	56                   	push   %esi
80105917:	68 20 97 10 80       	push   $0x80109720
8010591c:	e8 af ae ff ff       	call   801007d0 <cprintf>
        return -1;
80105921:	83 c4 10             	add    $0x10,%esp
}
80105924:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80105927:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010592c:	5b                   	pop    %ebx
8010592d:	5e                   	pop    %esi
8010592e:	5f                   	pop    %edi
8010592f:	5d                   	pop    %ebp
80105930:	c3                   	ret
      cprintf("No system calls in the %s process yet.\n", p->name);
80105931:	83 ec 08             	sub    $0x8,%esp
80105934:	83 c6 6c             	add    $0x6c,%esi
80105937:	56                   	push   %esi
80105938:	68 f8 96 10 80       	push   $0x801096f8
8010593d:	e8 8e ae ff ff       	call   801007d0 <cprintf>
      return -1;
80105942:	83 c4 10             	add    $0x10,%esp
80105945:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010594a:	e9 43 ff ff ff       	jmp    80105892 <get_most_invoked_syscall+0x132>
8010594f:	90                   	nop

80105950 <list_all_processes>:
// ----------------------------------------------------------------------

void
list_all_processes(int a)
{
80105950:	55                   	push   %ebp
80105951:	89 e5                	mov    %esp,%ebp
80105953:	53                   	push   %ebx
80105954:	bb 80 48 11 80       	mov    $0x80114880,%ebx
80105959:	83 ec 10             	sub    $0x10,%esp
    struct proc *p;

    acquire(&ptable.lock);
8010595c:	68 e0 47 11 80       	push   $0x801147e0
80105961:	e8 5a 03 00 00       	call   80105cc0 <acquire>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105966:	83 c4 10             	add    $0x10,%esp
80105969:	eb 13                	jmp    8010597e <list_all_processes+0x2e>
8010596b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80105970:	81 c3 24 8d 00 00    	add    $0x8d24,%ebx
80105976:	81 fb 80 91 34 80    	cmp    $0x80349180,%ebx
8010597c:	74 2a                	je     801059a8 <list_all_processes+0x58>
    { 
        if(p->pid != 0)
8010597e:	8b 43 a4             	mov    -0x5c(%ebx),%eax
80105981:	85 c0                	test   %eax,%eax
80105983:	74 eb                	je     80105970 <list_all_processes+0x20>
            cprintf("My name is: %s.\t My id is:%d.\t Number of system calls i invoked is: %d.\n",p->name, p->pid,p->syscall_count);
80105985:	ff b3 b0 8c 00 00    	push   0x8cb0(%ebx)
8010598b:	50                   	push   %eax
8010598c:	53                   	push   %ebx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010598d:	81 c3 24 8d 00 00    	add    $0x8d24,%ebx
            cprintf("My name is: %s.\t My id is:%d.\t Number of system calls i invoked is: %d.\n",p->name, p->pid,p->syscall_count);
80105993:	68 c4 97 10 80       	push   $0x801097c4
80105998:	e8 33 ae ff ff       	call   801007d0 <cprintf>
8010599d:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801059a0:	81 fb 80 91 34 80    	cmp    $0x80349180,%ebx
801059a6:	75 d6                	jne    8010597e <list_all_processes+0x2e>
    }   
    release(&ptable.lock);
801059a8:	c7 45 08 e0 47 11 80 	movl   $0x801147e0,0x8(%ebp)
801059af:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801059b2:	c9                   	leave
    release(&ptable.lock);
801059b3:	e9 a8 02 00 00       	jmp    80105c60 <release>
801059b8:	66 90                	xchg   %ax,%ax
801059ba:	66 90                	xchg   %ax,%ax
801059bc:	66 90                	xchg   %ax,%ax
801059be:	66 90                	xchg   %ax,%ax

801059c0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801059c0:	55                   	push   %ebp
801059c1:	89 e5                	mov    %esp,%ebp
801059c3:	53                   	push   %ebx
801059c4:	83 ec 0c             	sub    $0xc,%esp
801059c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801059ca:	68 95 93 10 80       	push   $0x80109395
801059cf:	8d 43 04             	lea    0x4(%ebx),%eax
801059d2:	50                   	push   %eax
801059d3:	e8 18 01 00 00       	call   80105af0 <initlock>
  lk->name = name;
801059d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801059db:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801059e1:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
801059e4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
801059eb:	89 43 38             	mov    %eax,0x38(%ebx)
}
801059ee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801059f1:	c9                   	leave
801059f2:	c3                   	ret
801059f3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801059fa:	00 
801059fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105a00 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80105a00:	55                   	push   %ebp
80105a01:	89 e5                	mov    %esp,%ebp
80105a03:	56                   	push   %esi
80105a04:	53                   	push   %ebx
80105a05:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80105a08:	8d 73 04             	lea    0x4(%ebx),%esi
80105a0b:	83 ec 0c             	sub    $0xc,%esp
80105a0e:	56                   	push   %esi
80105a0f:	e8 ac 02 00 00       	call   80105cc0 <acquire>
  while (lk->locked) {
80105a14:	8b 13                	mov    (%ebx),%edx
80105a16:	83 c4 10             	add    $0x10,%esp
80105a19:	85 d2                	test   %edx,%edx
80105a1b:	74 16                	je     80105a33 <acquiresleep+0x33>
80105a1d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80105a20:	83 ec 08             	sub    $0x8,%esp
80105a23:	56                   	push   %esi
80105a24:	53                   	push   %ebx
80105a25:	e8 16 f7 ff ff       	call   80105140 <sleep>
  while (lk->locked) {
80105a2a:	8b 03                	mov    (%ebx),%eax
80105a2c:	83 c4 10             	add    $0x10,%esp
80105a2f:	85 c0                	test   %eax,%eax
80105a31:	75 ed                	jne    80105a20 <acquiresleep+0x20>
  }
  lk->locked = 1;
80105a33:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80105a39:	e8 32 f0 ff ff       	call   80104a70 <myproc>
80105a3e:	8b 40 10             	mov    0x10(%eax),%eax
80105a41:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80105a44:	89 75 08             	mov    %esi,0x8(%ebp)
}
80105a47:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105a4a:	5b                   	pop    %ebx
80105a4b:	5e                   	pop    %esi
80105a4c:	5d                   	pop    %ebp
  release(&lk->lk);
80105a4d:	e9 0e 02 00 00       	jmp    80105c60 <release>
80105a52:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105a59:	00 
80105a5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105a60 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80105a60:	55                   	push   %ebp
80105a61:	89 e5                	mov    %esp,%ebp
80105a63:	56                   	push   %esi
80105a64:	53                   	push   %ebx
80105a65:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80105a68:	8d 73 04             	lea    0x4(%ebx),%esi
80105a6b:	83 ec 0c             	sub    $0xc,%esp
80105a6e:	56                   	push   %esi
80105a6f:	e8 4c 02 00 00       	call   80105cc0 <acquire>
  lk->locked = 0;
80105a74:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80105a7a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80105a81:	89 1c 24             	mov    %ebx,(%esp)
80105a84:	e8 77 f7 ff ff       	call   80105200 <wakeup>
  release(&lk->lk);
80105a89:	89 75 08             	mov    %esi,0x8(%ebp)
80105a8c:	83 c4 10             	add    $0x10,%esp
}
80105a8f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105a92:	5b                   	pop    %ebx
80105a93:	5e                   	pop    %esi
80105a94:	5d                   	pop    %ebp
  release(&lk->lk);
80105a95:	e9 c6 01 00 00       	jmp    80105c60 <release>
80105a9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105aa0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80105aa0:	55                   	push   %ebp
80105aa1:	89 e5                	mov    %esp,%ebp
80105aa3:	57                   	push   %edi
80105aa4:	31 ff                	xor    %edi,%edi
80105aa6:	56                   	push   %esi
80105aa7:	53                   	push   %ebx
80105aa8:	83 ec 18             	sub    $0x18,%esp
80105aab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80105aae:	8d 73 04             	lea    0x4(%ebx),%esi
80105ab1:	56                   	push   %esi
80105ab2:	e8 09 02 00 00       	call   80105cc0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80105ab7:	8b 03                	mov    (%ebx),%eax
80105ab9:	83 c4 10             	add    $0x10,%esp
80105abc:	85 c0                	test   %eax,%eax
80105abe:	75 18                	jne    80105ad8 <holdingsleep+0x38>
  release(&lk->lk);
80105ac0:	83 ec 0c             	sub    $0xc,%esp
80105ac3:	56                   	push   %esi
80105ac4:	e8 97 01 00 00       	call   80105c60 <release>
  return r;
}
80105ac9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105acc:	89 f8                	mov    %edi,%eax
80105ace:	5b                   	pop    %ebx
80105acf:	5e                   	pop    %esi
80105ad0:	5f                   	pop    %edi
80105ad1:	5d                   	pop    %ebp
80105ad2:	c3                   	ret
80105ad3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  r = lk->locked && (lk->pid == myproc()->pid);
80105ad8:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80105adb:	e8 90 ef ff ff       	call   80104a70 <myproc>
80105ae0:	39 58 10             	cmp    %ebx,0x10(%eax)
80105ae3:	0f 94 c0             	sete   %al
80105ae6:	0f b6 c0             	movzbl %al,%eax
80105ae9:	89 c7                	mov    %eax,%edi
80105aeb:	eb d3                	jmp    80105ac0 <holdingsleep+0x20>
80105aed:	66 90                	xchg   %ax,%ax
80105aef:	90                   	nop

80105af0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80105af0:	55                   	push   %ebp
80105af1:	89 e5                	mov    %esp,%ebp
80105af3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80105af6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80105af9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80105aff:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80105b02:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80105b09:	5d                   	pop    %ebp
80105b0a:	c3                   	ret
80105b0b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105b10 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105b10:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80105b11:	31 d2                	xor    %edx,%edx
{
80105b13:	89 e5                	mov    %esp,%ebp
80105b15:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80105b16:	8b 45 08             	mov    0x8(%ebp),%eax
{
80105b19:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80105b1c:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
80105b1f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105b20:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80105b26:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80105b2c:	77 1a                	ja     80105b48 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
80105b2e:	8b 58 04             	mov    0x4(%eax),%ebx
80105b31:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80105b34:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80105b37:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80105b39:	83 fa 0a             	cmp    $0xa,%edx
80105b3c:	75 e2                	jne    80105b20 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80105b3e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105b41:	c9                   	leave
80105b42:	c3                   	ret
80105b43:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80105b48:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80105b4b:	8d 51 28             	lea    0x28(%ecx),%edx
80105b4e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80105b50:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80105b56:	83 c0 04             	add    $0x4,%eax
80105b59:	39 d0                	cmp    %edx,%eax
80105b5b:	75 f3                	jne    80105b50 <getcallerpcs+0x40>
}
80105b5d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105b60:	c9                   	leave
80105b61:	c3                   	ret
80105b62:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105b69:	00 
80105b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105b70 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105b70:	55                   	push   %ebp
80105b71:	89 e5                	mov    %esp,%ebp
80105b73:	53                   	push   %ebx
80105b74:	83 ec 04             	sub    $0x4,%esp
80105b77:	9c                   	pushf
80105b78:	5b                   	pop    %ebx
  asm volatile("cli");
80105b79:	fa                   	cli
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80105b7a:	e8 61 ee ff ff       	call   801049e0 <mycpu>
80105b7f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80105b85:	85 c0                	test   %eax,%eax
80105b87:	74 17                	je     80105ba0 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80105b89:	e8 52 ee ff ff       	call   801049e0 <mycpu>
80105b8e:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80105b95:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105b98:	c9                   	leave
80105b99:	c3                   	ret
80105b9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
80105ba0:	e8 3b ee ff ff       	call   801049e0 <mycpu>
80105ba5:	81 e3 00 02 00 00    	and    $0x200,%ebx
80105bab:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80105bb1:	eb d6                	jmp    80105b89 <pushcli+0x19>
80105bb3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105bba:	00 
80105bbb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105bc0 <popcli>:

void
popcli(void)
{
80105bc0:	55                   	push   %ebp
80105bc1:	89 e5                	mov    %esp,%ebp
80105bc3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105bc6:	9c                   	pushf
80105bc7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80105bc8:	f6 c4 02             	test   $0x2,%ah
80105bcb:	75 35                	jne    80105c02 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80105bcd:	e8 0e ee ff ff       	call   801049e0 <mycpu>
80105bd2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80105bd9:	78 34                	js     80105c0f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105bdb:	e8 00 ee ff ff       	call   801049e0 <mycpu>
80105be0:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80105be6:	85 d2                	test   %edx,%edx
80105be8:	74 06                	je     80105bf0 <popcli+0x30>
    sti();
}
80105bea:	c9                   	leave
80105beb:	c3                   	ret
80105bec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105bf0:	e8 eb ed ff ff       	call   801049e0 <mycpu>
80105bf5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80105bfb:	85 c0                	test   %eax,%eax
80105bfd:	74 eb                	je     80105bea <popcli+0x2a>
  asm volatile("sti");
80105bff:	fb                   	sti
}
80105c00:	c9                   	leave
80105c01:	c3                   	ret
    panic("popcli - interruptible");
80105c02:	83 ec 0c             	sub    $0xc,%esp
80105c05:	68 a0 93 10 80       	push   $0x801093a0
80105c0a:	e8 c1 a8 ff ff       	call   801004d0 <panic>
    panic("popcli");
80105c0f:	83 ec 0c             	sub    $0xc,%esp
80105c12:	68 b7 93 10 80       	push   $0x801093b7
80105c17:	e8 b4 a8 ff ff       	call   801004d0 <panic>
80105c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105c20 <holding>:
{
80105c20:	55                   	push   %ebp
80105c21:	89 e5                	mov    %esp,%ebp
80105c23:	56                   	push   %esi
80105c24:	53                   	push   %ebx
80105c25:	8b 75 08             	mov    0x8(%ebp),%esi
80105c28:	31 db                	xor    %ebx,%ebx
  pushcli();
80105c2a:	e8 41 ff ff ff       	call   80105b70 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80105c2f:	8b 06                	mov    (%esi),%eax
80105c31:	85 c0                	test   %eax,%eax
80105c33:	75 0b                	jne    80105c40 <holding+0x20>
  popcli();
80105c35:	e8 86 ff ff ff       	call   80105bc0 <popcli>
}
80105c3a:	89 d8                	mov    %ebx,%eax
80105c3c:	5b                   	pop    %ebx
80105c3d:	5e                   	pop    %esi
80105c3e:	5d                   	pop    %ebp
80105c3f:	c3                   	ret
  r = lock->locked && lock->cpu == mycpu();
80105c40:	8b 5e 08             	mov    0x8(%esi),%ebx
80105c43:	e8 98 ed ff ff       	call   801049e0 <mycpu>
80105c48:	39 c3                	cmp    %eax,%ebx
80105c4a:	0f 94 c3             	sete   %bl
  popcli();
80105c4d:	e8 6e ff ff ff       	call   80105bc0 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80105c52:	0f b6 db             	movzbl %bl,%ebx
}
80105c55:	89 d8                	mov    %ebx,%eax
80105c57:	5b                   	pop    %ebx
80105c58:	5e                   	pop    %esi
80105c59:	5d                   	pop    %ebp
80105c5a:	c3                   	ret
80105c5b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105c60 <release>:
{
80105c60:	55                   	push   %ebp
80105c61:	89 e5                	mov    %esp,%ebp
80105c63:	56                   	push   %esi
80105c64:	53                   	push   %ebx
80105c65:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80105c68:	e8 03 ff ff ff       	call   80105b70 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80105c6d:	8b 03                	mov    (%ebx),%eax
80105c6f:	85 c0                	test   %eax,%eax
80105c71:	75 15                	jne    80105c88 <release+0x28>
  popcli();
80105c73:	e8 48 ff ff ff       	call   80105bc0 <popcli>
    panic("release");
80105c78:	83 ec 0c             	sub    $0xc,%esp
80105c7b:	68 be 93 10 80       	push   $0x801093be
80105c80:	e8 4b a8 ff ff       	call   801004d0 <panic>
80105c85:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80105c88:	8b 73 08             	mov    0x8(%ebx),%esi
80105c8b:	e8 50 ed ff ff       	call   801049e0 <mycpu>
80105c90:	39 c6                	cmp    %eax,%esi
80105c92:	75 df                	jne    80105c73 <release+0x13>
  popcli();
80105c94:	e8 27 ff ff ff       	call   80105bc0 <popcli>
  lk->pcs[0] = 0;
80105c99:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80105ca0:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80105ca7:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80105cac:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80105cb2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105cb5:	5b                   	pop    %ebx
80105cb6:	5e                   	pop    %esi
80105cb7:	5d                   	pop    %ebp
  popcli();
80105cb8:	e9 03 ff ff ff       	jmp    80105bc0 <popcli>
80105cbd:	8d 76 00             	lea    0x0(%esi),%esi

80105cc0 <acquire>:
{
80105cc0:	55                   	push   %ebp
80105cc1:	89 e5                	mov    %esp,%ebp
80105cc3:	53                   	push   %ebx
80105cc4:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80105cc7:	e8 a4 fe ff ff       	call   80105b70 <pushcli>
  if(holding(lk))
80105ccc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80105ccf:	e8 9c fe ff ff       	call   80105b70 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80105cd4:	8b 03                	mov    (%ebx),%eax
80105cd6:	85 c0                	test   %eax,%eax
80105cd8:	75 7e                	jne    80105d58 <acquire+0x98>
  popcli();
80105cda:	e8 e1 fe ff ff       	call   80105bc0 <popcli>
  asm volatile("lock; xchgl %0, %1" :
80105cdf:	b9 01 00 00 00       	mov    $0x1,%ecx
80105ce4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(xchg(&lk->locked, 1) != 0)
80105ce8:	8b 55 08             	mov    0x8(%ebp),%edx
80105ceb:	89 c8                	mov    %ecx,%eax
80105ced:	f0 87 02             	lock xchg %eax,(%edx)
80105cf0:	85 c0                	test   %eax,%eax
80105cf2:	75 f4                	jne    80105ce8 <acquire+0x28>
  __sync_synchronize();
80105cf4:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80105cf9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105cfc:	e8 df ec ff ff       	call   801049e0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80105d01:	8b 4d 08             	mov    0x8(%ebp),%ecx
  ebp = (uint*)v - 2;
80105d04:	89 ea                	mov    %ebp,%edx
  lk->cpu = mycpu();
80105d06:	89 43 08             	mov    %eax,0x8(%ebx)
  for(i = 0; i < 10; i++){
80105d09:	31 c0                	xor    %eax,%eax
80105d0b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105d10:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80105d16:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80105d1c:	77 1a                	ja     80105d38 <acquire+0x78>
    pcs[i] = ebp[1];     // saved %eip
80105d1e:	8b 5a 04             	mov    0x4(%edx),%ebx
80105d21:	89 5c 81 0c          	mov    %ebx,0xc(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80105d25:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80105d28:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
80105d2a:	83 f8 0a             	cmp    $0xa,%eax
80105d2d:	75 e1                	jne    80105d10 <acquire+0x50>
}
80105d2f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105d32:	c9                   	leave
80105d33:	c3                   	ret
80105d34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80105d38:	8d 44 81 0c          	lea    0xc(%ecx,%eax,4),%eax
80105d3c:	8d 51 34             	lea    0x34(%ecx),%edx
80105d3f:	90                   	nop
    pcs[i] = 0;
80105d40:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80105d46:	83 c0 04             	add    $0x4,%eax
80105d49:	39 c2                	cmp    %eax,%edx
80105d4b:	75 f3                	jne    80105d40 <acquire+0x80>
}
80105d4d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105d50:	c9                   	leave
80105d51:	c3                   	ret
80105d52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80105d58:	8b 5b 08             	mov    0x8(%ebx),%ebx
80105d5b:	e8 80 ec ff ff       	call   801049e0 <mycpu>
80105d60:	39 c3                	cmp    %eax,%ebx
80105d62:	0f 85 72 ff ff ff    	jne    80105cda <acquire+0x1a>
  popcli();
80105d68:	e8 53 fe ff ff       	call   80105bc0 <popcli>
    panic("acquire");
80105d6d:	83 ec 0c             	sub    $0xc,%esp
80105d70:	68 c6 93 10 80       	push   $0x801093c6
80105d75:	e8 56 a7 ff ff       	call   801004d0 <panic>
80105d7a:	66 90                	xchg   %ax,%ax
80105d7c:	66 90                	xchg   %ax,%ax
80105d7e:	66 90                	xchg   %ax,%ax

80105d80 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105d80:	55                   	push   %ebp
80105d81:	89 e5                	mov    %esp,%ebp
80105d83:	57                   	push   %edi
80105d84:	8b 55 08             	mov    0x8(%ebp),%edx
80105d87:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105d8a:	53                   	push   %ebx
80105d8b:	8b 45 0c             	mov    0xc(%ebp),%eax
  if ((int)dst%4 == 0 && n%4 == 0){
80105d8e:	89 d7                	mov    %edx,%edi
80105d90:	09 cf                	or     %ecx,%edi
80105d92:	83 e7 03             	and    $0x3,%edi
80105d95:	75 29                	jne    80105dc0 <memset+0x40>
    c &= 0xFF;
80105d97:	0f b6 f8             	movzbl %al,%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80105d9a:	c1 e0 18             	shl    $0x18,%eax
80105d9d:	89 fb                	mov    %edi,%ebx
80105d9f:	c1 e9 02             	shr    $0x2,%ecx
80105da2:	c1 e3 10             	shl    $0x10,%ebx
80105da5:	09 d8                	or     %ebx,%eax
80105da7:	09 f8                	or     %edi,%eax
80105da9:	c1 e7 08             	shl    $0x8,%edi
80105dac:	09 f8                	or     %edi,%eax
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
80105dae:	89 d7                	mov    %edx,%edi
80105db0:	fc                   	cld
80105db1:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80105db3:	5b                   	pop    %ebx
80105db4:	89 d0                	mov    %edx,%eax
80105db6:	5f                   	pop    %edi
80105db7:	5d                   	pop    %ebp
80105db8:	c3                   	ret
80105db9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
80105dc0:	89 d7                	mov    %edx,%edi
80105dc2:	fc                   	cld
80105dc3:	f3 aa                	rep stos %al,%es:(%edi)
80105dc5:	5b                   	pop    %ebx
80105dc6:	89 d0                	mov    %edx,%eax
80105dc8:	5f                   	pop    %edi
80105dc9:	5d                   	pop    %ebp
80105dca:	c3                   	ret
80105dcb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105dd0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80105dd0:	55                   	push   %ebp
80105dd1:	89 e5                	mov    %esp,%ebp
80105dd3:	56                   	push   %esi
80105dd4:	8b 75 10             	mov    0x10(%ebp),%esi
80105dd7:	8b 55 08             	mov    0x8(%ebp),%edx
80105dda:	53                   	push   %ebx
80105ddb:	8b 45 0c             	mov    0xc(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80105dde:	85 f6                	test   %esi,%esi
80105de0:	74 2e                	je     80105e10 <memcmp+0x40>
80105de2:	01 c6                	add    %eax,%esi
80105de4:	eb 14                	jmp    80105dfa <memcmp+0x2a>
80105de6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105ded:	00 
80105dee:	66 90                	xchg   %ax,%ax
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80105df0:	83 c0 01             	add    $0x1,%eax
80105df3:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80105df6:	39 f0                	cmp    %esi,%eax
80105df8:	74 16                	je     80105e10 <memcmp+0x40>
    if(*s1 != *s2)
80105dfa:	0f b6 0a             	movzbl (%edx),%ecx
80105dfd:	0f b6 18             	movzbl (%eax),%ebx
80105e00:	38 d9                	cmp    %bl,%cl
80105e02:	74 ec                	je     80105df0 <memcmp+0x20>
      return *s1 - *s2;
80105e04:	0f b6 c1             	movzbl %cl,%eax
80105e07:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80105e09:	5b                   	pop    %ebx
80105e0a:	5e                   	pop    %esi
80105e0b:	5d                   	pop    %ebp
80105e0c:	c3                   	ret
80105e0d:	8d 76 00             	lea    0x0(%esi),%esi
80105e10:	5b                   	pop    %ebx
  return 0;
80105e11:	31 c0                	xor    %eax,%eax
}
80105e13:	5e                   	pop    %esi
80105e14:	5d                   	pop    %ebp
80105e15:	c3                   	ret
80105e16:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105e1d:	00 
80105e1e:	66 90                	xchg   %ax,%ax

80105e20 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105e20:	55                   	push   %ebp
80105e21:	89 e5                	mov    %esp,%ebp
80105e23:	57                   	push   %edi
80105e24:	8b 55 08             	mov    0x8(%ebp),%edx
80105e27:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105e2a:	56                   	push   %esi
80105e2b:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80105e2e:	39 d6                	cmp    %edx,%esi
80105e30:	73 26                	jae    80105e58 <memmove+0x38>
80105e32:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80105e35:	39 fa                	cmp    %edi,%edx
80105e37:	73 1f                	jae    80105e58 <memmove+0x38>
80105e39:	8d 41 ff             	lea    -0x1(%ecx),%eax
    s += n;
    d += n;
    while(n-- > 0)
80105e3c:	85 c9                	test   %ecx,%ecx
80105e3e:	74 0c                	je     80105e4c <memmove+0x2c>
      *--d = *--s;
80105e40:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80105e44:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80105e47:	83 e8 01             	sub    $0x1,%eax
80105e4a:	73 f4                	jae    80105e40 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80105e4c:	5e                   	pop    %esi
80105e4d:	89 d0                	mov    %edx,%eax
80105e4f:	5f                   	pop    %edi
80105e50:	5d                   	pop    %ebp
80105e51:	c3                   	ret
80105e52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
80105e58:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
80105e5b:	89 d7                	mov    %edx,%edi
80105e5d:	85 c9                	test   %ecx,%ecx
80105e5f:	74 eb                	je     80105e4c <memmove+0x2c>
80105e61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80105e68:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80105e69:	39 c6                	cmp    %eax,%esi
80105e6b:	75 fb                	jne    80105e68 <memmove+0x48>
}
80105e6d:	5e                   	pop    %esi
80105e6e:	89 d0                	mov    %edx,%eax
80105e70:	5f                   	pop    %edi
80105e71:	5d                   	pop    %ebp
80105e72:	c3                   	ret
80105e73:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105e7a:	00 
80105e7b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105e80 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80105e80:	eb 9e                	jmp    80105e20 <memmove>
80105e82:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105e89:	00 
80105e8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105e90 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80105e90:	55                   	push   %ebp
80105e91:	89 e5                	mov    %esp,%ebp
80105e93:	56                   	push   %esi
80105e94:	8b 75 10             	mov    0x10(%ebp),%esi
80105e97:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105e9a:	53                   	push   %ebx
80105e9b:	8b 45 0c             	mov    0xc(%ebp),%eax
  while(n > 0 && *p && *p == *q)
80105e9e:	85 f6                	test   %esi,%esi
80105ea0:	74 36                	je     80105ed8 <strncmp+0x48>
80105ea2:	01 c6                	add    %eax,%esi
80105ea4:	eb 18                	jmp    80105ebe <strncmp+0x2e>
80105ea6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105ead:	00 
80105eae:	66 90                	xchg   %ax,%ax
80105eb0:	38 da                	cmp    %bl,%dl
80105eb2:	75 14                	jne    80105ec8 <strncmp+0x38>
    n--, p++, q++;
80105eb4:	83 c0 01             	add    $0x1,%eax
80105eb7:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80105eba:	39 f0                	cmp    %esi,%eax
80105ebc:	74 1a                	je     80105ed8 <strncmp+0x48>
80105ebe:	0f b6 11             	movzbl (%ecx),%edx
80105ec1:	0f b6 18             	movzbl (%eax),%ebx
80105ec4:	84 d2                	test   %dl,%dl
80105ec6:	75 e8                	jne    80105eb0 <strncmp+0x20>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80105ec8:	0f b6 c2             	movzbl %dl,%eax
80105ecb:	29 d8                	sub    %ebx,%eax
}
80105ecd:	5b                   	pop    %ebx
80105ece:	5e                   	pop    %esi
80105ecf:	5d                   	pop    %ebp
80105ed0:	c3                   	ret
80105ed1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ed8:	5b                   	pop    %ebx
    return 0;
80105ed9:	31 c0                	xor    %eax,%eax
}
80105edb:	5e                   	pop    %esi
80105edc:	5d                   	pop    %ebp
80105edd:	c3                   	ret
80105ede:	66 90                	xchg   %ax,%ax

80105ee0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105ee0:	55                   	push   %ebp
80105ee1:	89 e5                	mov    %esp,%ebp
80105ee3:	57                   	push   %edi
80105ee4:	56                   	push   %esi
80105ee5:	8b 75 08             	mov    0x8(%ebp),%esi
80105ee8:	53                   	push   %ebx
80105ee9:	8b 45 10             	mov    0x10(%ebp),%eax
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80105eec:	89 f2                	mov    %esi,%edx
80105eee:	eb 17                	jmp    80105f07 <strncpy+0x27>
80105ef0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80105ef4:	8b 7d 0c             	mov    0xc(%ebp),%edi
80105ef7:	83 c2 01             	add    $0x1,%edx
80105efa:	0f b6 7f ff          	movzbl -0x1(%edi),%edi
80105efe:	89 f9                	mov    %edi,%ecx
80105f00:	88 4a ff             	mov    %cl,-0x1(%edx)
80105f03:	84 c9                	test   %cl,%cl
80105f05:	74 09                	je     80105f10 <strncpy+0x30>
80105f07:	89 c3                	mov    %eax,%ebx
80105f09:	83 e8 01             	sub    $0x1,%eax
80105f0c:	85 db                	test   %ebx,%ebx
80105f0e:	7f e0                	jg     80105ef0 <strncpy+0x10>
    ;
  while(n-- > 0)
80105f10:	89 d1                	mov    %edx,%ecx
80105f12:	85 c0                	test   %eax,%eax
80105f14:	7e 1d                	jle    80105f33 <strncpy+0x53>
80105f16:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105f1d:	00 
80105f1e:	66 90                	xchg   %ax,%ax
    *s++ = 0;
80105f20:	83 c1 01             	add    $0x1,%ecx
80105f23:	c6 41 ff 00          	movb   $0x0,-0x1(%ecx)
  while(n-- > 0)
80105f27:	89 c8                	mov    %ecx,%eax
80105f29:	f7 d0                	not    %eax
80105f2b:	01 d0                	add    %edx,%eax
80105f2d:	01 d8                	add    %ebx,%eax
80105f2f:	85 c0                	test   %eax,%eax
80105f31:	7f ed                	jg     80105f20 <strncpy+0x40>
  return os;
}
80105f33:	5b                   	pop    %ebx
80105f34:	89 f0                	mov    %esi,%eax
80105f36:	5e                   	pop    %esi
80105f37:	5f                   	pop    %edi
80105f38:	5d                   	pop    %ebp
80105f39:	c3                   	ret
80105f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105f40 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105f40:	55                   	push   %ebp
80105f41:	89 e5                	mov    %esp,%ebp
80105f43:	56                   	push   %esi
80105f44:	8b 55 10             	mov    0x10(%ebp),%edx
80105f47:	8b 75 08             	mov    0x8(%ebp),%esi
80105f4a:	53                   	push   %ebx
80105f4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
80105f4e:	85 d2                	test   %edx,%edx
80105f50:	7e 25                	jle    80105f77 <safestrcpy+0x37>
80105f52:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80105f56:	89 f2                	mov    %esi,%edx
80105f58:	eb 16                	jmp    80105f70 <safestrcpy+0x30>
80105f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80105f60:	0f b6 08             	movzbl (%eax),%ecx
80105f63:	83 c0 01             	add    $0x1,%eax
80105f66:	83 c2 01             	add    $0x1,%edx
80105f69:	88 4a ff             	mov    %cl,-0x1(%edx)
80105f6c:	84 c9                	test   %cl,%cl
80105f6e:	74 04                	je     80105f74 <safestrcpy+0x34>
80105f70:	39 d8                	cmp    %ebx,%eax
80105f72:	75 ec                	jne    80105f60 <safestrcpy+0x20>
    ;
  *s = 0;
80105f74:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80105f77:	89 f0                	mov    %esi,%eax
80105f79:	5b                   	pop    %ebx
80105f7a:	5e                   	pop    %esi
80105f7b:	5d                   	pop    %ebp
80105f7c:	c3                   	ret
80105f7d:	8d 76 00             	lea    0x0(%esi),%esi

80105f80 <strlen>:

int
strlen(const char *s)
{
80105f80:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80105f81:	31 c0                	xor    %eax,%eax
{
80105f83:	89 e5                	mov    %esp,%ebp
80105f85:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80105f88:	80 3a 00             	cmpb   $0x0,(%edx)
80105f8b:	74 0c                	je     80105f99 <strlen+0x19>
80105f8d:	8d 76 00             	lea    0x0(%esi),%esi
80105f90:	83 c0 01             	add    $0x1,%eax
80105f93:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80105f97:	75 f7                	jne    80105f90 <strlen+0x10>
    ;
  return n;
}
80105f99:	5d                   	pop    %ebp
80105f9a:	c3                   	ret

80105f9b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80105f9b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80105f9f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80105fa3:	55                   	push   %ebp
  pushl %ebx
80105fa4:	53                   	push   %ebx
  pushl %esi
80105fa5:	56                   	push   %esi
  pushl %edi
80105fa6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80105fa7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80105fa9:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80105fab:	5f                   	pop    %edi
  popl %esi
80105fac:	5e                   	pop    %esi
  popl %ebx
80105fad:	5b                   	pop    %ebx
  popl %ebp
80105fae:	5d                   	pop    %ebp
  ret
80105faf:	c3                   	ret

80105fb0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105fb0:	55                   	push   %ebp
80105fb1:	89 e5                	mov    %esp,%ebp
80105fb3:	53                   	push   %ebx
80105fb4:	83 ec 04             	sub    $0x4,%esp
80105fb7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80105fba:	e8 b1 ea ff ff       	call   80104a70 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105fbf:	8b 00                	mov    (%eax),%eax
80105fc1:	39 d8                	cmp    %ebx,%eax
80105fc3:	76 1b                	jbe    80105fe0 <fetchint+0x30>
80105fc5:	8d 53 04             	lea    0x4(%ebx),%edx
80105fc8:	39 d0                	cmp    %edx,%eax
80105fca:	72 14                	jb     80105fe0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80105fcc:	8b 45 0c             	mov    0xc(%ebp),%eax
80105fcf:	8b 13                	mov    (%ebx),%edx
80105fd1:	89 10                	mov    %edx,(%eax)
  return 0;
80105fd3:	31 c0                	xor    %eax,%eax
}
80105fd5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105fd8:	c9                   	leave
80105fd9:	c3                   	ret
80105fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105fe0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105fe5:	eb ee                	jmp    80105fd5 <fetchint+0x25>
80105fe7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105fee:	00 
80105fef:	90                   	nop

80105ff0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105ff0:	55                   	push   %ebp
80105ff1:	89 e5                	mov    %esp,%ebp
80105ff3:	53                   	push   %ebx
80105ff4:	83 ec 04             	sub    $0x4,%esp
80105ff7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80105ffa:	e8 71 ea ff ff       	call   80104a70 <myproc>

  if(addr >= curproc->sz)
80105fff:	39 18                	cmp    %ebx,(%eax)
80106001:	76 2d                	jbe    80106030 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
80106003:	8b 55 0c             	mov    0xc(%ebp),%edx
80106006:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80106008:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
8010600a:	39 d3                	cmp    %edx,%ebx
8010600c:	73 22                	jae    80106030 <fetchstr+0x40>
8010600e:	89 d8                	mov    %ebx,%eax
80106010:	eb 0d                	jmp    8010601f <fetchstr+0x2f>
80106012:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106018:	83 c0 01             	add    $0x1,%eax
8010601b:	39 c2                	cmp    %eax,%edx
8010601d:	76 11                	jbe    80106030 <fetchstr+0x40>
    if(*s == 0)
8010601f:	80 38 00             	cmpb   $0x0,(%eax)
80106022:	75 f4                	jne    80106018 <fetchstr+0x28>
      return s - *pp;
80106024:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80106026:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106029:	c9                   	leave
8010602a:	c3                   	ret
8010602b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80106030:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80106033:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106038:	c9                   	leave
80106039:	c3                   	ret
8010603a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106040 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80106040:	55                   	push   %ebp
80106041:	89 e5                	mov    %esp,%ebp
80106043:	56                   	push   %esi
80106044:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80106045:	e8 26 ea ff ff       	call   80104a70 <myproc>
8010604a:	8b 55 08             	mov    0x8(%ebp),%edx
8010604d:	8b 40 18             	mov    0x18(%eax),%eax
80106050:	8b 40 44             	mov    0x44(%eax),%eax
80106053:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80106056:	e8 15 ea ff ff       	call   80104a70 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010605b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010605e:	8b 00                	mov    (%eax),%eax
80106060:	39 c6                	cmp    %eax,%esi
80106062:	73 1c                	jae    80106080 <argint+0x40>
80106064:	8d 53 08             	lea    0x8(%ebx),%edx
80106067:	39 d0                	cmp    %edx,%eax
80106069:	72 15                	jb     80106080 <argint+0x40>
  *ip = *(int*)(addr);
8010606b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010606e:	8b 53 04             	mov    0x4(%ebx),%edx
80106071:	89 10                	mov    %edx,(%eax)
  return 0;
80106073:	31 c0                	xor    %eax,%eax
}
80106075:	5b                   	pop    %ebx
80106076:	5e                   	pop    %esi
80106077:	5d                   	pop    %ebp
80106078:	c3                   	ret
80106079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106080:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80106085:	eb ee                	jmp    80106075 <argint+0x35>
80106087:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010608e:	00 
8010608f:	90                   	nop

80106090 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80106090:	55                   	push   %ebp
80106091:	89 e5                	mov    %esp,%ebp
80106093:	57                   	push   %edi
80106094:	56                   	push   %esi
80106095:	53                   	push   %ebx
80106096:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
80106099:	e8 d2 e9 ff ff       	call   80104a70 <myproc>
8010609e:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801060a0:	e8 cb e9 ff ff       	call   80104a70 <myproc>
801060a5:	8b 55 08             	mov    0x8(%ebp),%edx
801060a8:	8b 40 18             	mov    0x18(%eax),%eax
801060ab:	8b 40 44             	mov    0x44(%eax),%eax
801060ae:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801060b1:	e8 ba e9 ff ff       	call   80104a70 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801060b6:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801060b9:	8b 00                	mov    (%eax),%eax
801060bb:	39 c7                	cmp    %eax,%edi
801060bd:	73 31                	jae    801060f0 <argptr+0x60>
801060bf:	8d 4b 08             	lea    0x8(%ebx),%ecx
801060c2:	39 c8                	cmp    %ecx,%eax
801060c4:	72 2a                	jb     801060f0 <argptr+0x60>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801060c6:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
801060c9:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801060cc:	85 d2                	test   %edx,%edx
801060ce:	78 20                	js     801060f0 <argptr+0x60>
801060d0:	8b 16                	mov    (%esi),%edx
801060d2:	39 c2                	cmp    %eax,%edx
801060d4:	76 1a                	jbe    801060f0 <argptr+0x60>
801060d6:	8b 5d 10             	mov    0x10(%ebp),%ebx
801060d9:	01 c3                	add    %eax,%ebx
801060db:	39 da                	cmp    %ebx,%edx
801060dd:	72 11                	jb     801060f0 <argptr+0x60>
    return -1;
  *pp = (char*)i;
801060df:	8b 55 0c             	mov    0xc(%ebp),%edx
801060e2:	89 02                	mov    %eax,(%edx)
  return 0;
801060e4:	31 c0                	xor    %eax,%eax
}
801060e6:	83 c4 0c             	add    $0xc,%esp
801060e9:	5b                   	pop    %ebx
801060ea:	5e                   	pop    %esi
801060eb:	5f                   	pop    %edi
801060ec:	5d                   	pop    %ebp
801060ed:	c3                   	ret
801060ee:	66 90                	xchg   %ax,%ax
    return -1;
801060f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060f5:	eb ef                	jmp    801060e6 <argptr+0x56>
801060f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801060fe:	00 
801060ff:	90                   	nop

80106100 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80106100:	55                   	push   %ebp
80106101:	89 e5                	mov    %esp,%ebp
80106103:	56                   	push   %esi
80106104:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80106105:	e8 66 e9 ff ff       	call   80104a70 <myproc>
8010610a:	8b 55 08             	mov    0x8(%ebp),%edx
8010610d:	8b 40 18             	mov    0x18(%eax),%eax
80106110:	8b 40 44             	mov    0x44(%eax),%eax
80106113:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80106116:	e8 55 e9 ff ff       	call   80104a70 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010611b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010611e:	8b 00                	mov    (%eax),%eax
80106120:	39 c6                	cmp    %eax,%esi
80106122:	73 44                	jae    80106168 <argstr+0x68>
80106124:	8d 53 08             	lea    0x8(%ebx),%edx
80106127:	39 d0                	cmp    %edx,%eax
80106129:	72 3d                	jb     80106168 <argstr+0x68>
  *ip = *(int*)(addr);
8010612b:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
8010612e:	e8 3d e9 ff ff       	call   80104a70 <myproc>
  if(addr >= curproc->sz)
80106133:	3b 18                	cmp    (%eax),%ebx
80106135:	73 31                	jae    80106168 <argstr+0x68>
  *pp = (char*)addr;
80106137:	8b 55 0c             	mov    0xc(%ebp),%edx
8010613a:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
8010613c:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
8010613e:	39 d3                	cmp    %edx,%ebx
80106140:	73 26                	jae    80106168 <argstr+0x68>
80106142:	89 d8                	mov    %ebx,%eax
80106144:	eb 11                	jmp    80106157 <argstr+0x57>
80106146:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010614d:	00 
8010614e:	66 90                	xchg   %ax,%ax
80106150:	83 c0 01             	add    $0x1,%eax
80106153:	39 c2                	cmp    %eax,%edx
80106155:	76 11                	jbe    80106168 <argstr+0x68>
    if(*s == 0)
80106157:	80 38 00             	cmpb   $0x0,(%eax)
8010615a:	75 f4                	jne    80106150 <argstr+0x50>
      return s - *pp;
8010615c:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
8010615e:	5b                   	pop    %ebx
8010615f:	5e                   	pop    %esi
80106160:	5d                   	pop    %ebp
80106161:	c3                   	ret
80106162:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106168:	5b                   	pop    %ebx
    return -1;
80106169:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010616e:	5e                   	pop    %esi
8010616f:	5d                   	pop    %ebp
80106170:	c3                   	ret
80106171:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106178:	00 
80106179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106180 <my_strcpy>:
[SYS_move_file] sys_move_file ,
[SYS_open_sharedmem]  sys_open_sharedmem,
[SYS_close_sharedmem] sys_close_sharedmem,
};

void my_strcpy(char *dest, const char *src) {
80106180:	55                   	push   %ebp
80106181:	89 e5                	mov    %esp,%ebp
80106183:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106186:	8b 45 08             	mov    0x8(%ebp),%eax
    while (*src) {
80106189:	0f b6 11             	movzbl (%ecx),%edx
8010618c:	84 d2                	test   %dl,%dl
8010618e:	74 0f                	je     8010619f <my_strcpy+0x1f>
        *dest++ = *src++;
80106190:	83 c1 01             	add    $0x1,%ecx
80106193:	88 10                	mov    %dl,(%eax)
80106195:	83 c0 01             	add    $0x1,%eax
    while (*src) {
80106198:	0f b6 11             	movzbl (%ecx),%edx
8010619b:	84 d2                	test   %dl,%dl
8010619d:	75 f1                	jne    80106190 <my_strcpy+0x10>
    }
    *dest = '\0';
8010619f:	c6 00 00             	movb   $0x0,(%eax)
}
801061a2:	5d                   	pop    %ebp
801061a3:	c3                   	ret
801061a4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801061ab:	00 
801061ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801061b0 <syscall>:

void
syscall(void)
{
801061b0:	55                   	push   %ebp
801061b1:	89 e5                	mov    %esp,%ebp
801061b3:	57                   	push   %edi
801061b4:	56                   	push   %esi
801061b5:	53                   	push   %ebx
801061b6:	83 ec 3c             	sub    $0x3c,%esp
  int num;
  struct proc *curproc = myproc();
801061b9:	e8 b2 e8 ff ff       	call   80104a70 <myproc>
801061be:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
801061c0:	8b 40 18             	mov    0x18(%eax),%eax
801061c3:	8b 70 1c             	mov    0x1c(%eax),%esi
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801061c6:	8d 46 ff             	lea    -0x1(%esi),%eax
801061c9:	83 f8 1b             	cmp    $0x1b,%eax
801061cc:	0f 87 de 00 00 00    	ja     801062b0 <syscall+0x100>
801061d2:	8b 04 b5 a0 9d 10 80 	mov    -0x7fef6260(,%esi,4),%eax
801061d9:	85 c0                	test   %eax,%eax
801061db:	0f 84 cf 00 00 00    	je     801062b0 <syscall+0x100>
    curproc->tf->eax = syscalls[num]();
801061e1:	ff d0                	call   *%eax
801061e3:	8b 53 18             	mov    0x18(%ebx),%edx
801061e6:	89 42 1c             	mov    %eax,0x1c(%edx)
    if (curproc->syscall_count < 1000) {
801061e9:	8b bb 1c 8d 00 00    	mov    0x8d1c(%ebx),%edi
801061ef:	81 ff e7 03 00 00    	cmp    $0x3e7,%edi
801061f5:	0f 8f e5 00 00 00    	jg     801062e0 <syscall+0x130>
        struct syscall_info new_syscall = {"", num};
801061fb:	89 75 e4             	mov    %esi,-0x1c(%ebp)
        new_syscall.number = num;
        my_strcpy(new_syscall.name, system_call_titles[num]);
801061fe:	6b f6 1e             	imul   $0x1e,%esi,%esi
    while (*src) {
80106201:	8d 55 c4             	lea    -0x3c(%ebp),%edx
        struct syscall_info new_syscall = {"", num};
80106204:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
8010620b:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    while (*src) {
80106212:	0f b6 86 20 c0 10 80 	movzbl -0x7fef3fe0(%esi),%eax
        struct syscall_info new_syscall = {"", num};
80106219:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
        my_strcpy(new_syscall.name, system_call_titles[num]);
80106220:	8d 8e 20 c0 10 80    	lea    -0x7fef3fe0(%esi),%ecx
        struct syscall_info new_syscall = {"", num};
80106226:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
8010622d:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
80106234:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
8010623b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
80106242:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    while (*src) {
80106249:	84 c0                	test   %al,%al
8010624b:	74 12                	je     8010625f <syscall+0xaf>
8010624d:	8d 76 00             	lea    0x0(%esi),%esi
        *dest++ = *src++;
80106250:	83 c1 01             	add    $0x1,%ecx
80106253:	88 02                	mov    %al,(%edx)
80106255:	83 c2 01             	add    $0x1,%edx
    while (*src) {
80106258:	0f b6 01             	movzbl (%ecx),%eax
8010625b:	84 c0                	test   %al,%al
8010625d:	75 f1                	jne    80106250 <syscall+0xa0>
        curproc->syscalls[curproc->syscall_count++] = new_syscall;
8010625f:	8d 47 01             	lea    0x1(%edi),%eax
    *dest = '\0';
80106262:	c6 02 00             	movb   $0x0,(%edx)
        curproc->syscalls[curproc->syscall_count++] = new_syscall;
80106265:	8b 55 c4             	mov    -0x3c(%ebp),%edx
80106268:	89 83 1c 8d 00 00    	mov    %eax,0x8d1c(%ebx)
8010626e:	8d 04 ff             	lea    (%edi,%edi,8),%eax
80106271:	8d 44 83 70          	lea    0x70(%ebx,%eax,4),%eax
80106275:	89 50 0c             	mov    %edx,0xc(%eax)
80106278:	8b 55 c8             	mov    -0x38(%ebp),%edx
8010627b:	89 50 10             	mov    %edx,0x10(%eax)
8010627e:	8b 55 cc             	mov    -0x34(%ebp),%edx
80106281:	89 50 14             	mov    %edx,0x14(%eax)
80106284:	8b 55 d0             	mov    -0x30(%ebp),%edx
80106287:	89 50 18             	mov    %edx,0x18(%eax)
8010628a:	8b 55 d4             	mov    -0x2c(%ebp),%edx
8010628d:	89 50 1c             	mov    %edx,0x1c(%eax)
80106290:	8b 55 d8             	mov    -0x28(%ebp),%edx
80106293:	89 50 20             	mov    %edx,0x20(%eax)
80106296:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106299:	89 50 24             	mov    %edx,0x24(%eax)
8010629c:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010629f:	89 50 28             	mov    %edx,0x28(%eax)
801062a2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801062a5:	89 50 2c             	mov    %edx,0x2c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
801062a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801062ab:	5b                   	pop    %ebx
801062ac:	5e                   	pop    %esi
801062ad:	5f                   	pop    %edi
801062ae:	5d                   	pop    %ebp
801062af:	c3                   	ret
            curproc->pid, curproc->name, num);
801062b0:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
801062b3:	56                   	push   %esi
801062b4:	50                   	push   %eax
801062b5:	ff 73 10             	push   0x10(%ebx)
801062b8:	68 ce 93 10 80       	push   $0x801093ce
801062bd:	e8 0e a5 ff ff       	call   801007d0 <cprintf>
    curproc->tf->eax = -1;
801062c2:	8b 43 18             	mov    0x18(%ebx),%eax
801062c5:	83 c4 10             	add    $0x10,%esp
801062c8:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
801062cf:	8d 65 f4             	lea    -0xc(%ebp),%esp
801062d2:	5b                   	pop    %ebx
801062d3:	5e                   	pop    %esi
801062d4:	5f                   	pop    %edi
801062d5:	5d                   	pop    %ebp
801062d6:	c3                   	ret
801062d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801062de:	00 
801062df:	90                   	nop
      cprintf("max system calls limit for a process has exceeded\n");
801062e0:	83 ec 0c             	sub    $0xc,%esp
801062e3:	68 10 98 10 80       	push   $0x80109810
801062e8:	e8 e3 a4 ff ff       	call   801007d0 <cprintf>
801062ed:	83 c4 10             	add    $0x10,%esp
801062f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801062f3:	5b                   	pop    %ebx
801062f4:	5e                   	pop    %esi
801062f5:	5f                   	pop    %edi
801062f6:	5d                   	pop    %ebp
801062f7:	c3                   	ret
801062f8:	66 90                	xchg   %ax,%ax
801062fa:	66 90                	xchg   %ax,%ax
801062fc:	66 90                	xchg   %ax,%ax
801062fe:	66 90                	xchg   %ax,%ax

80106300 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80106300:	55                   	push   %ebp
80106301:	89 e5                	mov    %esp,%ebp
80106303:	57                   	push   %edi
80106304:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80106305:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80106308:	53                   	push   %ebx
80106309:	83 ec 34             	sub    $0x34,%esp
8010630c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
8010630f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80106312:	57                   	push   %edi
80106313:	50                   	push   %eax
{
80106314:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80106317:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
8010631a:	e8 81 ce ff ff       	call   801031a0 <nameiparent>
8010631f:	83 c4 10             	add    $0x10,%esp
80106322:	85 c0                	test   %eax,%eax
80106324:	0f 84 46 01 00 00    	je     80106470 <create+0x170>
    return 0;
  ilock(dp);
8010632a:	83 ec 0c             	sub    $0xc,%esp
8010632d:	89 c3                	mov    %eax,%ebx
8010632f:	50                   	push   %eax
80106330:	e8 2b c5 ff ff       	call   80102860 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80106335:	83 c4 0c             	add    $0xc,%esp
80106338:	6a 00                	push   $0x0
8010633a:	57                   	push   %edi
8010633b:	53                   	push   %ebx
8010633c:	e8 7f ca ff ff       	call   80102dc0 <dirlookup>
80106341:	83 c4 10             	add    $0x10,%esp
80106344:	89 c6                	mov    %eax,%esi
80106346:	85 c0                	test   %eax,%eax
80106348:	74 56                	je     801063a0 <create+0xa0>
    iunlockput(dp);
8010634a:	83 ec 0c             	sub    $0xc,%esp
8010634d:	53                   	push   %ebx
8010634e:	e8 9d c7 ff ff       	call   80102af0 <iunlockput>
    ilock(ip);
80106353:	89 34 24             	mov    %esi,(%esp)
80106356:	e8 05 c5 ff ff       	call   80102860 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
8010635b:	83 c4 10             	add    $0x10,%esp
8010635e:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80106363:	75 1b                	jne    80106380 <create+0x80>
80106365:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
8010636a:	75 14                	jne    80106380 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010636c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010636f:	89 f0                	mov    %esi,%eax
80106371:	5b                   	pop    %ebx
80106372:	5e                   	pop    %esi
80106373:	5f                   	pop    %edi
80106374:	5d                   	pop    %ebp
80106375:	c3                   	ret
80106376:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010637d:	00 
8010637e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80106380:	83 ec 0c             	sub    $0xc,%esp
80106383:	56                   	push   %esi
    return 0;
80106384:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80106386:	e8 65 c7 ff ff       	call   80102af0 <iunlockput>
    return 0;
8010638b:	83 c4 10             	add    $0x10,%esp
}
8010638e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106391:	89 f0                	mov    %esi,%eax
80106393:	5b                   	pop    %ebx
80106394:	5e                   	pop    %esi
80106395:	5f                   	pop    %edi
80106396:	5d                   	pop    %ebp
80106397:	c3                   	ret
80106398:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010639f:	00 
  if((ip = ialloc(dp->dev, type)) == 0)
801063a0:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
801063a4:	83 ec 08             	sub    $0x8,%esp
801063a7:	50                   	push   %eax
801063a8:	ff 33                	push   (%ebx)
801063aa:	e8 41 c3 ff ff       	call   801026f0 <ialloc>
801063af:	83 c4 10             	add    $0x10,%esp
801063b2:	89 c6                	mov    %eax,%esi
801063b4:	85 c0                	test   %eax,%eax
801063b6:	0f 84 cd 00 00 00    	je     80106489 <create+0x189>
  ilock(ip);
801063bc:	83 ec 0c             	sub    $0xc,%esp
801063bf:	50                   	push   %eax
801063c0:	e8 9b c4 ff ff       	call   80102860 <ilock>
  ip->major = major;
801063c5:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
801063c9:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
801063cd:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
801063d1:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
801063d5:	b8 01 00 00 00       	mov    $0x1,%eax
801063da:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
801063de:	89 34 24             	mov    %esi,(%esp)
801063e1:	e8 ca c3 ff ff       	call   801027b0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
801063e6:	83 c4 10             	add    $0x10,%esp
801063e9:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
801063ee:	74 30                	je     80106420 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
801063f0:	83 ec 04             	sub    $0x4,%esp
801063f3:	ff 76 04             	push   0x4(%esi)
801063f6:	57                   	push   %edi
801063f7:	53                   	push   %ebx
801063f8:	e8 c3 cc ff ff       	call   801030c0 <dirlink>
801063fd:	83 c4 10             	add    $0x10,%esp
80106400:	85 c0                	test   %eax,%eax
80106402:	78 78                	js     8010647c <create+0x17c>
  iunlockput(dp);
80106404:	83 ec 0c             	sub    $0xc,%esp
80106407:	53                   	push   %ebx
80106408:	e8 e3 c6 ff ff       	call   80102af0 <iunlockput>
  return ip;
8010640d:	83 c4 10             	add    $0x10,%esp
}
80106410:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106413:	89 f0                	mov    %esi,%eax
80106415:	5b                   	pop    %ebx
80106416:	5e                   	pop    %esi
80106417:	5f                   	pop    %edi
80106418:	5d                   	pop    %ebp
80106419:	c3                   	ret
8010641a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80106420:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80106423:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80106428:	53                   	push   %ebx
80106429:	e8 82 c3 ff ff       	call   801027b0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010642e:	83 c4 0c             	add    $0xc,%esp
80106431:	ff 76 04             	push   0x4(%esi)
80106434:	68 06 94 10 80       	push   $0x80109406
80106439:	56                   	push   %esi
8010643a:	e8 81 cc ff ff       	call   801030c0 <dirlink>
8010643f:	83 c4 10             	add    $0x10,%esp
80106442:	85 c0                	test   %eax,%eax
80106444:	78 18                	js     8010645e <create+0x15e>
80106446:	83 ec 04             	sub    $0x4,%esp
80106449:	ff 73 04             	push   0x4(%ebx)
8010644c:	68 05 94 10 80       	push   $0x80109405
80106451:	56                   	push   %esi
80106452:	e8 69 cc ff ff       	call   801030c0 <dirlink>
80106457:	83 c4 10             	add    $0x10,%esp
8010645a:	85 c0                	test   %eax,%eax
8010645c:	79 92                	jns    801063f0 <create+0xf0>
      panic("create dots");
8010645e:	83 ec 0c             	sub    $0xc,%esp
80106461:	68 f9 93 10 80       	push   $0x801093f9
80106466:	e8 65 a0 ff ff       	call   801004d0 <panic>
8010646b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
}
80106470:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80106473:	31 f6                	xor    %esi,%esi
}
80106475:	5b                   	pop    %ebx
80106476:	89 f0                	mov    %esi,%eax
80106478:	5e                   	pop    %esi
80106479:	5f                   	pop    %edi
8010647a:	5d                   	pop    %ebp
8010647b:	c3                   	ret
    panic("create: dirlink");
8010647c:	83 ec 0c             	sub    $0xc,%esp
8010647f:	68 08 94 10 80       	push   $0x80109408
80106484:	e8 47 a0 ff ff       	call   801004d0 <panic>
    panic("create: ialloc");
80106489:	83 ec 0c             	sub    $0xc,%esp
8010648c:	68 ea 93 10 80       	push   $0x801093ea
80106491:	e8 3a a0 ff ff       	call   801004d0 <panic>
80106496:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010649d:	00 
8010649e:	66 90                	xchg   %ax,%ax

801064a0 <sys_dup>:
{
801064a0:	55                   	push   %ebp
801064a1:	89 e5                	mov    %esp,%ebp
801064a3:	56                   	push   %esi
801064a4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801064a5:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801064a8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801064ab:	50                   	push   %eax
801064ac:	6a 00                	push   $0x0
801064ae:	e8 8d fb ff ff       	call   80106040 <argint>
801064b3:	83 c4 10             	add    $0x10,%esp
801064b6:	85 c0                	test   %eax,%eax
801064b8:	78 36                	js     801064f0 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801064ba:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801064be:	77 30                	ja     801064f0 <sys_dup+0x50>
801064c0:	e8 ab e5 ff ff       	call   80104a70 <myproc>
801064c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801064c8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801064cc:	85 f6                	test   %esi,%esi
801064ce:	74 20                	je     801064f0 <sys_dup+0x50>
  struct proc *curproc = myproc();
801064d0:	e8 9b e5 ff ff       	call   80104a70 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801064d5:	31 db                	xor    %ebx,%ebx
801064d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801064de:	00 
801064df:	90                   	nop
    if(curproc->ofile[fd] == 0){
801064e0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801064e4:	85 d2                	test   %edx,%edx
801064e6:	74 18                	je     80106500 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
801064e8:	83 c3 01             	add    $0x1,%ebx
801064eb:	83 fb 10             	cmp    $0x10,%ebx
801064ee:	75 f0                	jne    801064e0 <sys_dup+0x40>
}
801064f0:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
801064f3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
801064f8:	89 d8                	mov    %ebx,%eax
801064fa:	5b                   	pop    %ebx
801064fb:	5e                   	pop    %esi
801064fc:	5d                   	pop    %ebp
801064fd:	c3                   	ret
801064fe:	66 90                	xchg   %ax,%ax
  filedup(f);
80106500:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80106503:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80106507:	56                   	push   %esi
80106508:	e8 73 ba ff ff       	call   80101f80 <filedup>
  return fd;
8010650d:	83 c4 10             	add    $0x10,%esp
}
80106510:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106513:	89 d8                	mov    %ebx,%eax
80106515:	5b                   	pop    %ebx
80106516:	5e                   	pop    %esi
80106517:	5d                   	pop    %ebp
80106518:	c3                   	ret
80106519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106520 <sys_read>:
{
80106520:	55                   	push   %ebp
80106521:	89 e5                	mov    %esp,%ebp
80106523:	56                   	push   %esi
80106524:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80106525:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80106528:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010652b:	53                   	push   %ebx
8010652c:	6a 00                	push   $0x0
8010652e:	e8 0d fb ff ff       	call   80106040 <argint>
80106533:	83 c4 10             	add    $0x10,%esp
80106536:	85 c0                	test   %eax,%eax
80106538:	78 5e                	js     80106598 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010653a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010653e:	77 58                	ja     80106598 <sys_read+0x78>
80106540:	e8 2b e5 ff ff       	call   80104a70 <myproc>
80106545:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106548:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010654c:	85 f6                	test   %esi,%esi
8010654e:	74 48                	je     80106598 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106550:	83 ec 08             	sub    $0x8,%esp
80106553:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106556:	50                   	push   %eax
80106557:	6a 02                	push   $0x2
80106559:	e8 e2 fa ff ff       	call   80106040 <argint>
8010655e:	83 c4 10             	add    $0x10,%esp
80106561:	85 c0                	test   %eax,%eax
80106563:	78 33                	js     80106598 <sys_read+0x78>
80106565:	83 ec 04             	sub    $0x4,%esp
80106568:	ff 75 f0             	push   -0x10(%ebp)
8010656b:	53                   	push   %ebx
8010656c:	6a 01                	push   $0x1
8010656e:	e8 1d fb ff ff       	call   80106090 <argptr>
80106573:	83 c4 10             	add    $0x10,%esp
80106576:	85 c0                	test   %eax,%eax
80106578:	78 1e                	js     80106598 <sys_read+0x78>
  return fileread(f, p, n);
8010657a:	83 ec 04             	sub    $0x4,%esp
8010657d:	ff 75 f0             	push   -0x10(%ebp)
80106580:	ff 75 f4             	push   -0xc(%ebp)
80106583:	56                   	push   %esi
80106584:	e8 77 bb ff ff       	call   80102100 <fileread>
80106589:	83 c4 10             	add    $0x10,%esp
}
8010658c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010658f:	5b                   	pop    %ebx
80106590:	5e                   	pop    %esi
80106591:	5d                   	pop    %ebp
80106592:	c3                   	ret
80106593:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
80106598:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010659d:	eb ed                	jmp    8010658c <sys_read+0x6c>
8010659f:	90                   	nop

801065a0 <sys_write>:
{
801065a0:	55                   	push   %ebp
801065a1:	89 e5                	mov    %esp,%ebp
801065a3:	56                   	push   %esi
801065a4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801065a5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
801065a8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801065ab:	53                   	push   %ebx
801065ac:	6a 00                	push   $0x0
801065ae:	e8 8d fa ff ff       	call   80106040 <argint>
801065b3:	83 c4 10             	add    $0x10,%esp
801065b6:	85 c0                	test   %eax,%eax
801065b8:	78 5e                	js     80106618 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801065ba:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801065be:	77 58                	ja     80106618 <sys_write+0x78>
801065c0:	e8 ab e4 ff ff       	call   80104a70 <myproc>
801065c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801065c8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801065cc:	85 f6                	test   %esi,%esi
801065ce:	74 48                	je     80106618 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801065d0:	83 ec 08             	sub    $0x8,%esp
801065d3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801065d6:	50                   	push   %eax
801065d7:	6a 02                	push   $0x2
801065d9:	e8 62 fa ff ff       	call   80106040 <argint>
801065de:	83 c4 10             	add    $0x10,%esp
801065e1:	85 c0                	test   %eax,%eax
801065e3:	78 33                	js     80106618 <sys_write+0x78>
801065e5:	83 ec 04             	sub    $0x4,%esp
801065e8:	ff 75 f0             	push   -0x10(%ebp)
801065eb:	53                   	push   %ebx
801065ec:	6a 01                	push   $0x1
801065ee:	e8 9d fa ff ff       	call   80106090 <argptr>
801065f3:	83 c4 10             	add    $0x10,%esp
801065f6:	85 c0                	test   %eax,%eax
801065f8:	78 1e                	js     80106618 <sys_write+0x78>
  return filewrite(f, p, n);
801065fa:	83 ec 04             	sub    $0x4,%esp
801065fd:	ff 75 f0             	push   -0x10(%ebp)
80106600:	ff 75 f4             	push   -0xc(%ebp)
80106603:	56                   	push   %esi
80106604:	e8 87 bb ff ff       	call   80102190 <filewrite>
80106609:	83 c4 10             	add    $0x10,%esp
}
8010660c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010660f:	5b                   	pop    %ebx
80106610:	5e                   	pop    %esi
80106611:	5d                   	pop    %ebp
80106612:	c3                   	ret
80106613:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
80106618:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010661d:	eb ed                	jmp    8010660c <sys_write+0x6c>
8010661f:	90                   	nop

80106620 <sys_close>:
{
80106620:	55                   	push   %ebp
80106621:	89 e5                	mov    %esp,%ebp
80106623:	56                   	push   %esi
80106624:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80106625:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106628:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010662b:	50                   	push   %eax
8010662c:	6a 00                	push   $0x0
8010662e:	e8 0d fa ff ff       	call   80106040 <argint>
80106633:	83 c4 10             	add    $0x10,%esp
80106636:	85 c0                	test   %eax,%eax
80106638:	78 3e                	js     80106678 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010663a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010663e:	77 38                	ja     80106678 <sys_close+0x58>
80106640:	e8 2b e4 ff ff       	call   80104a70 <myproc>
80106645:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106648:	8d 5a 08             	lea    0x8(%edx),%ebx
8010664b:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
8010664f:	85 f6                	test   %esi,%esi
80106651:	74 25                	je     80106678 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
80106653:	e8 18 e4 ff ff       	call   80104a70 <myproc>
  fileclose(f);
80106658:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
8010665b:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
80106662:	00 
  fileclose(f);
80106663:	56                   	push   %esi
80106664:	e8 67 b9 ff ff       	call   80101fd0 <fileclose>
  return 0;
80106669:	83 c4 10             	add    $0x10,%esp
8010666c:	31 c0                	xor    %eax,%eax
}
8010666e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106671:	5b                   	pop    %ebx
80106672:	5e                   	pop    %esi
80106673:	5d                   	pop    %ebp
80106674:	c3                   	ret
80106675:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106678:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010667d:	eb ef                	jmp    8010666e <sys_close+0x4e>
8010667f:	90                   	nop

80106680 <sys_fstat>:
{
80106680:	55                   	push   %ebp
80106681:	89 e5                	mov    %esp,%ebp
80106683:	56                   	push   %esi
80106684:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80106685:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80106688:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010668b:	53                   	push   %ebx
8010668c:	6a 00                	push   $0x0
8010668e:	e8 ad f9 ff ff       	call   80106040 <argint>
80106693:	83 c4 10             	add    $0x10,%esp
80106696:	85 c0                	test   %eax,%eax
80106698:	78 46                	js     801066e0 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010669a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010669e:	77 40                	ja     801066e0 <sys_fstat+0x60>
801066a0:	e8 cb e3 ff ff       	call   80104a70 <myproc>
801066a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801066a8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801066ac:	85 f6                	test   %esi,%esi
801066ae:	74 30                	je     801066e0 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801066b0:	83 ec 04             	sub    $0x4,%esp
801066b3:	6a 14                	push   $0x14
801066b5:	53                   	push   %ebx
801066b6:	6a 01                	push   $0x1
801066b8:	e8 d3 f9 ff ff       	call   80106090 <argptr>
801066bd:	83 c4 10             	add    $0x10,%esp
801066c0:	85 c0                	test   %eax,%eax
801066c2:	78 1c                	js     801066e0 <sys_fstat+0x60>
  return filestat(f, st);
801066c4:	83 ec 08             	sub    $0x8,%esp
801066c7:	ff 75 f4             	push   -0xc(%ebp)
801066ca:	56                   	push   %esi
801066cb:	e8 e0 b9 ff ff       	call   801020b0 <filestat>
801066d0:	83 c4 10             	add    $0x10,%esp
}
801066d3:	8d 65 f8             	lea    -0x8(%ebp),%esp
801066d6:	5b                   	pop    %ebx
801066d7:	5e                   	pop    %esi
801066d8:	5d                   	pop    %ebp
801066d9:	c3                   	ret
801066da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801066e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801066e5:	eb ec                	jmp    801066d3 <sys_fstat+0x53>
801066e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801066ee:	00 
801066ef:	90                   	nop

801066f0 <sys_link>:
{
801066f0:	55                   	push   %ebp
801066f1:	89 e5                	mov    %esp,%ebp
801066f3:	57                   	push   %edi
801066f4:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801066f5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
801066f8:	53                   	push   %ebx
801066f9:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801066fc:	50                   	push   %eax
801066fd:	6a 00                	push   $0x0
801066ff:	e8 fc f9 ff ff       	call   80106100 <argstr>
80106704:	83 c4 10             	add    $0x10,%esp
80106707:	85 c0                	test   %eax,%eax
80106709:	0f 88 fb 00 00 00    	js     8010680a <sys_link+0x11a>
8010670f:	83 ec 08             	sub    $0x8,%esp
80106712:	8d 45 d0             	lea    -0x30(%ebp),%eax
80106715:	50                   	push   %eax
80106716:	6a 01                	push   $0x1
80106718:	e8 e3 f9 ff ff       	call   80106100 <argstr>
8010671d:	83 c4 10             	add    $0x10,%esp
80106720:	85 c0                	test   %eax,%eax
80106722:	0f 88 e2 00 00 00    	js     8010680a <sys_link+0x11a>
  begin_op();
80106728:	e8 13 d7 ff ff       	call   80103e40 <begin_op>
  if((ip = namei(old)) == 0){
8010672d:	83 ec 0c             	sub    $0xc,%esp
80106730:	ff 75 d4             	push   -0x2c(%ebp)
80106733:	e8 48 ca ff ff       	call   80103180 <namei>
80106738:	83 c4 10             	add    $0x10,%esp
8010673b:	89 c3                	mov    %eax,%ebx
8010673d:	85 c0                	test   %eax,%eax
8010673f:	0f 84 e4 00 00 00    	je     80106829 <sys_link+0x139>
  ilock(ip);
80106745:	83 ec 0c             	sub    $0xc,%esp
80106748:	50                   	push   %eax
80106749:	e8 12 c1 ff ff       	call   80102860 <ilock>
  if(ip->type == T_DIR){
8010674e:	83 c4 10             	add    $0x10,%esp
80106751:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106756:	0f 84 b5 00 00 00    	je     80106811 <sys_link+0x121>
  iupdate(ip);
8010675c:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
8010675f:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80106764:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80106767:	53                   	push   %ebx
80106768:	e8 43 c0 ff ff       	call   801027b0 <iupdate>
  iunlock(ip);
8010676d:	89 1c 24             	mov    %ebx,(%esp)
80106770:	e8 cb c1 ff ff       	call   80102940 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80106775:	58                   	pop    %eax
80106776:	5a                   	pop    %edx
80106777:	57                   	push   %edi
80106778:	ff 75 d0             	push   -0x30(%ebp)
8010677b:	e8 20 ca ff ff       	call   801031a0 <nameiparent>
80106780:	83 c4 10             	add    $0x10,%esp
80106783:	89 c6                	mov    %eax,%esi
80106785:	85 c0                	test   %eax,%eax
80106787:	74 5b                	je     801067e4 <sys_link+0xf4>
  ilock(dp);
80106789:	83 ec 0c             	sub    $0xc,%esp
8010678c:	50                   	push   %eax
8010678d:	e8 ce c0 ff ff       	call   80102860 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80106792:	8b 03                	mov    (%ebx),%eax
80106794:	83 c4 10             	add    $0x10,%esp
80106797:	39 06                	cmp    %eax,(%esi)
80106799:	75 3d                	jne    801067d8 <sys_link+0xe8>
8010679b:	83 ec 04             	sub    $0x4,%esp
8010679e:	ff 73 04             	push   0x4(%ebx)
801067a1:	57                   	push   %edi
801067a2:	56                   	push   %esi
801067a3:	e8 18 c9 ff ff       	call   801030c0 <dirlink>
801067a8:	83 c4 10             	add    $0x10,%esp
801067ab:	85 c0                	test   %eax,%eax
801067ad:	78 29                	js     801067d8 <sys_link+0xe8>
  iunlockput(dp);
801067af:	83 ec 0c             	sub    $0xc,%esp
801067b2:	56                   	push   %esi
801067b3:	e8 38 c3 ff ff       	call   80102af0 <iunlockput>
  iput(ip);
801067b8:	89 1c 24             	mov    %ebx,(%esp)
801067bb:	e8 d0 c1 ff ff       	call   80102990 <iput>
  end_op();
801067c0:	e8 eb d6 ff ff       	call   80103eb0 <end_op>
  return 0;
801067c5:	83 c4 10             	add    $0x10,%esp
801067c8:	31 c0                	xor    %eax,%eax
}
801067ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
801067cd:	5b                   	pop    %ebx
801067ce:	5e                   	pop    %esi
801067cf:	5f                   	pop    %edi
801067d0:	5d                   	pop    %ebp
801067d1:	c3                   	ret
801067d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
801067d8:	83 ec 0c             	sub    $0xc,%esp
801067db:	56                   	push   %esi
801067dc:	e8 0f c3 ff ff       	call   80102af0 <iunlockput>
    goto bad;
801067e1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
801067e4:	83 ec 0c             	sub    $0xc,%esp
801067e7:	53                   	push   %ebx
801067e8:	e8 73 c0 ff ff       	call   80102860 <ilock>
  ip->nlink--;
801067ed:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801067f2:	89 1c 24             	mov    %ebx,(%esp)
801067f5:	e8 b6 bf ff ff       	call   801027b0 <iupdate>
  iunlockput(ip);
801067fa:	89 1c 24             	mov    %ebx,(%esp)
801067fd:	e8 ee c2 ff ff       	call   80102af0 <iunlockput>
  end_op();
80106802:	e8 a9 d6 ff ff       	call   80103eb0 <end_op>
  return -1;
80106807:	83 c4 10             	add    $0x10,%esp
8010680a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010680f:	eb b9                	jmp    801067ca <sys_link+0xda>
    iunlockput(ip);
80106811:	83 ec 0c             	sub    $0xc,%esp
80106814:	53                   	push   %ebx
80106815:	e8 d6 c2 ff ff       	call   80102af0 <iunlockput>
    end_op();
8010681a:	e8 91 d6 ff ff       	call   80103eb0 <end_op>
    return -1;
8010681f:	83 c4 10             	add    $0x10,%esp
80106822:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106827:	eb a1                	jmp    801067ca <sys_link+0xda>
    end_op();
80106829:	e8 82 d6 ff ff       	call   80103eb0 <end_op>
    return -1;
8010682e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106833:	eb 95                	jmp    801067ca <sys_link+0xda>
80106835:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010683c:	00 
8010683d:	8d 76 00             	lea    0x0(%esi),%esi

80106840 <sys_unlink>:
{
80106840:	55                   	push   %ebp
80106841:	89 e5                	mov    %esp,%ebp
80106843:	57                   	push   %edi
80106844:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80106845:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80106848:	53                   	push   %ebx
80106849:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
8010684c:	50                   	push   %eax
8010684d:	6a 00                	push   $0x0
8010684f:	e8 ac f8 ff ff       	call   80106100 <argstr>
80106854:	83 c4 10             	add    $0x10,%esp
80106857:	85 c0                	test   %eax,%eax
80106859:	0f 88 7a 01 00 00    	js     801069d9 <sys_unlink+0x199>
  begin_op();
8010685f:	e8 dc d5 ff ff       	call   80103e40 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80106864:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80106867:	83 ec 08             	sub    $0x8,%esp
8010686a:	53                   	push   %ebx
8010686b:	ff 75 c0             	push   -0x40(%ebp)
8010686e:	e8 2d c9 ff ff       	call   801031a0 <nameiparent>
80106873:	83 c4 10             	add    $0x10,%esp
80106876:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80106879:	85 c0                	test   %eax,%eax
8010687b:	0f 84 62 01 00 00    	je     801069e3 <sys_unlink+0x1a3>
  ilock(dp);
80106881:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80106884:	83 ec 0c             	sub    $0xc,%esp
80106887:	57                   	push   %edi
80106888:	e8 d3 bf ff ff       	call   80102860 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010688d:	58                   	pop    %eax
8010688e:	5a                   	pop    %edx
8010688f:	68 06 94 10 80       	push   $0x80109406
80106894:	53                   	push   %ebx
80106895:	e8 06 c5 ff ff       	call   80102da0 <namecmp>
8010689a:	83 c4 10             	add    $0x10,%esp
8010689d:	85 c0                	test   %eax,%eax
8010689f:	0f 84 fb 00 00 00    	je     801069a0 <sys_unlink+0x160>
801068a5:	83 ec 08             	sub    $0x8,%esp
801068a8:	68 05 94 10 80       	push   $0x80109405
801068ad:	53                   	push   %ebx
801068ae:	e8 ed c4 ff ff       	call   80102da0 <namecmp>
801068b3:	83 c4 10             	add    $0x10,%esp
801068b6:	85 c0                	test   %eax,%eax
801068b8:	0f 84 e2 00 00 00    	je     801069a0 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
801068be:	83 ec 04             	sub    $0x4,%esp
801068c1:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801068c4:	50                   	push   %eax
801068c5:	53                   	push   %ebx
801068c6:	57                   	push   %edi
801068c7:	e8 f4 c4 ff ff       	call   80102dc0 <dirlookup>
801068cc:	83 c4 10             	add    $0x10,%esp
801068cf:	89 c3                	mov    %eax,%ebx
801068d1:	85 c0                	test   %eax,%eax
801068d3:	0f 84 c7 00 00 00    	je     801069a0 <sys_unlink+0x160>
  ilock(ip);
801068d9:	83 ec 0c             	sub    $0xc,%esp
801068dc:	50                   	push   %eax
801068dd:	e8 7e bf ff ff       	call   80102860 <ilock>
  if(ip->nlink < 1)
801068e2:	83 c4 10             	add    $0x10,%esp
801068e5:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801068ea:	0f 8e 1c 01 00 00    	jle    80106a0c <sys_unlink+0x1cc>
  if(ip->type == T_DIR && !isdirempty(ip)){
801068f0:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801068f5:	8d 7d d8             	lea    -0x28(%ebp),%edi
801068f8:	74 66                	je     80106960 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
801068fa:	83 ec 04             	sub    $0x4,%esp
801068fd:	6a 10                	push   $0x10
801068ff:	6a 00                	push   $0x0
80106901:	57                   	push   %edi
80106902:	e8 79 f4 ff ff       	call   80105d80 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80106907:	6a 10                	push   $0x10
80106909:	ff 75 c4             	push   -0x3c(%ebp)
8010690c:	57                   	push   %edi
8010690d:	ff 75 b4             	push   -0x4c(%ebp)
80106910:	e8 5b c3 ff ff       	call   80102c70 <writei>
80106915:	83 c4 20             	add    $0x20,%esp
80106918:	83 f8 10             	cmp    $0x10,%eax
8010691b:	0f 85 de 00 00 00    	jne    801069ff <sys_unlink+0x1bf>
  if(ip->type == T_DIR){
80106921:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106926:	0f 84 94 00 00 00    	je     801069c0 <sys_unlink+0x180>
  iunlockput(dp);
8010692c:	83 ec 0c             	sub    $0xc,%esp
8010692f:	ff 75 b4             	push   -0x4c(%ebp)
80106932:	e8 b9 c1 ff ff       	call   80102af0 <iunlockput>
  ip->nlink--;
80106937:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010693c:	89 1c 24             	mov    %ebx,(%esp)
8010693f:	e8 6c be ff ff       	call   801027b0 <iupdate>
  iunlockput(ip);
80106944:	89 1c 24             	mov    %ebx,(%esp)
80106947:	e8 a4 c1 ff ff       	call   80102af0 <iunlockput>
  end_op();
8010694c:	e8 5f d5 ff ff       	call   80103eb0 <end_op>
  return 0;
80106951:	83 c4 10             	add    $0x10,%esp
80106954:	31 c0                	xor    %eax,%eax
}
80106956:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106959:	5b                   	pop    %ebx
8010695a:	5e                   	pop    %esi
8010695b:	5f                   	pop    %edi
8010695c:	5d                   	pop    %ebp
8010695d:	c3                   	ret
8010695e:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80106960:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80106964:	76 94                	jbe    801068fa <sys_unlink+0xba>
80106966:	be 20 00 00 00       	mov    $0x20,%esi
8010696b:	eb 0b                	jmp    80106978 <sys_unlink+0x138>
8010696d:	8d 76 00             	lea    0x0(%esi),%esi
80106970:	83 c6 10             	add    $0x10,%esi
80106973:	3b 73 58             	cmp    0x58(%ebx),%esi
80106976:	73 82                	jae    801068fa <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80106978:	6a 10                	push   $0x10
8010697a:	56                   	push   %esi
8010697b:	57                   	push   %edi
8010697c:	53                   	push   %ebx
8010697d:	e8 ee c1 ff ff       	call   80102b70 <readi>
80106982:	83 c4 10             	add    $0x10,%esp
80106985:	83 f8 10             	cmp    $0x10,%eax
80106988:	75 68                	jne    801069f2 <sys_unlink+0x1b2>
    if(de.inum != 0)
8010698a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010698f:	74 df                	je     80106970 <sys_unlink+0x130>
    iunlockput(ip);
80106991:	83 ec 0c             	sub    $0xc,%esp
80106994:	53                   	push   %ebx
80106995:	e8 56 c1 ff ff       	call   80102af0 <iunlockput>
    goto bad;
8010699a:	83 c4 10             	add    $0x10,%esp
8010699d:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
801069a0:	83 ec 0c             	sub    $0xc,%esp
801069a3:	ff 75 b4             	push   -0x4c(%ebp)
801069a6:	e8 45 c1 ff ff       	call   80102af0 <iunlockput>
  end_op();
801069ab:	e8 00 d5 ff ff       	call   80103eb0 <end_op>
  return -1;
801069b0:	83 c4 10             	add    $0x10,%esp
801069b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801069b8:	eb 9c                	jmp    80106956 <sys_unlink+0x116>
801069ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
801069c0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
801069c3:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
801069c6:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
801069cb:	50                   	push   %eax
801069cc:	e8 df bd ff ff       	call   801027b0 <iupdate>
801069d1:	83 c4 10             	add    $0x10,%esp
801069d4:	e9 53 ff ff ff       	jmp    8010692c <sys_unlink+0xec>
    return -1;
801069d9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801069de:	e9 73 ff ff ff       	jmp    80106956 <sys_unlink+0x116>
    end_op();
801069e3:	e8 c8 d4 ff ff       	call   80103eb0 <end_op>
    return -1;
801069e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801069ed:	e9 64 ff ff ff       	jmp    80106956 <sys_unlink+0x116>
      panic("isdirempty: readi");
801069f2:	83 ec 0c             	sub    $0xc,%esp
801069f5:	68 2a 94 10 80       	push   $0x8010942a
801069fa:	e8 d1 9a ff ff       	call   801004d0 <panic>
    panic("unlink: writei");
801069ff:	83 ec 0c             	sub    $0xc,%esp
80106a02:	68 3c 94 10 80       	push   $0x8010943c
80106a07:	e8 c4 9a ff ff       	call   801004d0 <panic>
    panic("unlink: nlink < 1");
80106a0c:	83 ec 0c             	sub    $0xc,%esp
80106a0f:	68 18 94 10 80       	push   $0x80109418
80106a14:	e8 b7 9a ff ff       	call   801004d0 <panic>
80106a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106a20 <sys_open>:

int
sys_open(void)
{
80106a20:	55                   	push   %ebp
80106a21:	89 e5                	mov    %esp,%ebp
80106a23:	57                   	push   %edi
80106a24:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80106a25:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80106a28:	53                   	push   %ebx
80106a29:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80106a2c:	50                   	push   %eax
80106a2d:	6a 00                	push   $0x0
80106a2f:	e8 cc f6 ff ff       	call   80106100 <argstr>
80106a34:	83 c4 10             	add    $0x10,%esp
80106a37:	85 c0                	test   %eax,%eax
80106a39:	0f 88 8e 00 00 00    	js     80106acd <sys_open+0xad>
80106a3f:	83 ec 08             	sub    $0x8,%esp
80106a42:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106a45:	50                   	push   %eax
80106a46:	6a 01                	push   $0x1
80106a48:	e8 f3 f5 ff ff       	call   80106040 <argint>
80106a4d:	83 c4 10             	add    $0x10,%esp
80106a50:	85 c0                	test   %eax,%eax
80106a52:	78 79                	js     80106acd <sys_open+0xad>
    return -1;

  begin_op();
80106a54:	e8 e7 d3 ff ff       	call   80103e40 <begin_op>

  if(omode & O_CREATE){
80106a59:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80106a5d:	75 79                	jne    80106ad8 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80106a5f:	83 ec 0c             	sub    $0xc,%esp
80106a62:	ff 75 e0             	push   -0x20(%ebp)
80106a65:	e8 16 c7 ff ff       	call   80103180 <namei>
80106a6a:	83 c4 10             	add    $0x10,%esp
80106a6d:	89 c6                	mov    %eax,%esi
80106a6f:	85 c0                	test   %eax,%eax
80106a71:	0f 84 7e 00 00 00    	je     80106af5 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80106a77:	83 ec 0c             	sub    $0xc,%esp
80106a7a:	50                   	push   %eax
80106a7b:	e8 e0 bd ff ff       	call   80102860 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80106a80:	83 c4 10             	add    $0x10,%esp
80106a83:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80106a88:	0f 84 c2 00 00 00    	je     80106b50 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80106a8e:	e8 7d b4 ff ff       	call   80101f10 <filealloc>
80106a93:	89 c7                	mov    %eax,%edi
80106a95:	85 c0                	test   %eax,%eax
80106a97:	74 23                	je     80106abc <sys_open+0x9c>
  struct proc *curproc = myproc();
80106a99:	e8 d2 df ff ff       	call   80104a70 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80106a9e:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80106aa0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80106aa4:	85 d2                	test   %edx,%edx
80106aa6:	74 60                	je     80106b08 <sys_open+0xe8>
  for(fd = 0; fd < NOFILE; fd++){
80106aa8:	83 c3 01             	add    $0x1,%ebx
80106aab:	83 fb 10             	cmp    $0x10,%ebx
80106aae:	75 f0                	jne    80106aa0 <sys_open+0x80>
    if(f)
      fileclose(f);
80106ab0:	83 ec 0c             	sub    $0xc,%esp
80106ab3:	57                   	push   %edi
80106ab4:	e8 17 b5 ff ff       	call   80101fd0 <fileclose>
80106ab9:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80106abc:	83 ec 0c             	sub    $0xc,%esp
80106abf:	56                   	push   %esi
80106ac0:	e8 2b c0 ff ff       	call   80102af0 <iunlockput>
    end_op();
80106ac5:	e8 e6 d3 ff ff       	call   80103eb0 <end_op>
    return -1;
80106aca:	83 c4 10             	add    $0x10,%esp
80106acd:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106ad2:	eb 6d                	jmp    80106b41 <sys_open+0x121>
80106ad4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80106ad8:	83 ec 0c             	sub    $0xc,%esp
80106adb:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106ade:	31 c9                	xor    %ecx,%ecx
80106ae0:	ba 02 00 00 00       	mov    $0x2,%edx
80106ae5:	6a 00                	push   $0x0
80106ae7:	e8 14 f8 ff ff       	call   80106300 <create>
    if(ip == 0){
80106aec:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
80106aef:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80106af1:	85 c0                	test   %eax,%eax
80106af3:	75 99                	jne    80106a8e <sys_open+0x6e>
      end_op();
80106af5:	e8 b6 d3 ff ff       	call   80103eb0 <end_op>
      return -1;
80106afa:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106aff:	eb 40                	jmp    80106b41 <sys_open+0x121>
80106b01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80106b08:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80106b0b:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80106b0f:	56                   	push   %esi
80106b10:	e8 2b be ff ff       	call   80102940 <iunlock>
  end_op();
80106b15:	e8 96 d3 ff ff       	call   80103eb0 <end_op>

  f->type = FD_INODE;
80106b1a:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80106b20:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106b23:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80106b26:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80106b29:	89 d0                	mov    %edx,%eax
  f->off = 0;
80106b2b:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80106b32:	f7 d0                	not    %eax
80106b34:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106b37:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80106b3a:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106b3d:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80106b41:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106b44:	89 d8                	mov    %ebx,%eax
80106b46:	5b                   	pop    %ebx
80106b47:	5e                   	pop    %esi
80106b48:	5f                   	pop    %edi
80106b49:	5d                   	pop    %ebp
80106b4a:	c3                   	ret
80106b4b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80106b50:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106b53:	85 c9                	test   %ecx,%ecx
80106b55:	0f 84 33 ff ff ff    	je     80106a8e <sys_open+0x6e>
80106b5b:	e9 5c ff ff ff       	jmp    80106abc <sys_open+0x9c>

80106b60 <sys_mkdir>:

int
sys_mkdir(void)
{
80106b60:	55                   	push   %ebp
80106b61:	89 e5                	mov    %esp,%ebp
80106b63:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80106b66:	e8 d5 d2 ff ff       	call   80103e40 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80106b6b:	83 ec 08             	sub    $0x8,%esp
80106b6e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106b71:	50                   	push   %eax
80106b72:	6a 00                	push   $0x0
80106b74:	e8 87 f5 ff ff       	call   80106100 <argstr>
80106b79:	83 c4 10             	add    $0x10,%esp
80106b7c:	85 c0                	test   %eax,%eax
80106b7e:	78 30                	js     80106bb0 <sys_mkdir+0x50>
80106b80:	83 ec 0c             	sub    $0xc,%esp
80106b83:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b86:	31 c9                	xor    %ecx,%ecx
80106b88:	ba 01 00 00 00       	mov    $0x1,%edx
80106b8d:	6a 00                	push   $0x0
80106b8f:	e8 6c f7 ff ff       	call   80106300 <create>
80106b94:	83 c4 10             	add    $0x10,%esp
80106b97:	85 c0                	test   %eax,%eax
80106b99:	74 15                	je     80106bb0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80106b9b:	83 ec 0c             	sub    $0xc,%esp
80106b9e:	50                   	push   %eax
80106b9f:	e8 4c bf ff ff       	call   80102af0 <iunlockput>
  end_op();
80106ba4:	e8 07 d3 ff ff       	call   80103eb0 <end_op>
  return 0;
80106ba9:	83 c4 10             	add    $0x10,%esp
80106bac:	31 c0                	xor    %eax,%eax
}
80106bae:	c9                   	leave
80106baf:	c3                   	ret
    end_op();
80106bb0:	e8 fb d2 ff ff       	call   80103eb0 <end_op>
    return -1;
80106bb5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106bba:	c9                   	leave
80106bbb:	c3                   	ret
80106bbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106bc0 <sys_mknod>:

int
sys_mknod(void)
{
80106bc0:	55                   	push   %ebp
80106bc1:	89 e5                	mov    %esp,%ebp
80106bc3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80106bc6:	e8 75 d2 ff ff       	call   80103e40 <begin_op>
  if((argstr(0, &path)) < 0 ||
80106bcb:	83 ec 08             	sub    $0x8,%esp
80106bce:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106bd1:	50                   	push   %eax
80106bd2:	6a 00                	push   $0x0
80106bd4:	e8 27 f5 ff ff       	call   80106100 <argstr>
80106bd9:	83 c4 10             	add    $0x10,%esp
80106bdc:	85 c0                	test   %eax,%eax
80106bde:	78 60                	js     80106c40 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80106be0:	83 ec 08             	sub    $0x8,%esp
80106be3:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106be6:	50                   	push   %eax
80106be7:	6a 01                	push   $0x1
80106be9:	e8 52 f4 ff ff       	call   80106040 <argint>
  if((argstr(0, &path)) < 0 ||
80106bee:	83 c4 10             	add    $0x10,%esp
80106bf1:	85 c0                	test   %eax,%eax
80106bf3:	78 4b                	js     80106c40 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80106bf5:	83 ec 08             	sub    $0x8,%esp
80106bf8:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106bfb:	50                   	push   %eax
80106bfc:	6a 02                	push   $0x2
80106bfe:	e8 3d f4 ff ff       	call   80106040 <argint>
     argint(1, &major) < 0 ||
80106c03:	83 c4 10             	add    $0x10,%esp
80106c06:	85 c0                	test   %eax,%eax
80106c08:	78 36                	js     80106c40 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80106c0a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80106c0e:	83 ec 0c             	sub    $0xc,%esp
80106c11:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80106c15:	ba 03 00 00 00       	mov    $0x3,%edx
80106c1a:	50                   	push   %eax
80106c1b:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106c1e:	e8 dd f6 ff ff       	call   80106300 <create>
     argint(2, &minor) < 0 ||
80106c23:	83 c4 10             	add    $0x10,%esp
80106c26:	85 c0                	test   %eax,%eax
80106c28:	74 16                	je     80106c40 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
80106c2a:	83 ec 0c             	sub    $0xc,%esp
80106c2d:	50                   	push   %eax
80106c2e:	e8 bd be ff ff       	call   80102af0 <iunlockput>
  end_op();
80106c33:	e8 78 d2 ff ff       	call   80103eb0 <end_op>
  return 0;
80106c38:	83 c4 10             	add    $0x10,%esp
80106c3b:	31 c0                	xor    %eax,%eax
}
80106c3d:	c9                   	leave
80106c3e:	c3                   	ret
80106c3f:	90                   	nop
    end_op();
80106c40:	e8 6b d2 ff ff       	call   80103eb0 <end_op>
    return -1;
80106c45:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106c4a:	c9                   	leave
80106c4b:	c3                   	ret
80106c4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106c50 <sys_chdir>:

int
sys_chdir(void)
{
80106c50:	55                   	push   %ebp
80106c51:	89 e5                	mov    %esp,%ebp
80106c53:	56                   	push   %esi
80106c54:	53                   	push   %ebx
80106c55:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80106c58:	e8 13 de ff ff       	call   80104a70 <myproc>
80106c5d:	89 c6                	mov    %eax,%esi
  
  begin_op();
80106c5f:	e8 dc d1 ff ff       	call   80103e40 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80106c64:	83 ec 08             	sub    $0x8,%esp
80106c67:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106c6a:	50                   	push   %eax
80106c6b:	6a 00                	push   $0x0
80106c6d:	e8 8e f4 ff ff       	call   80106100 <argstr>
80106c72:	83 c4 10             	add    $0x10,%esp
80106c75:	85 c0                	test   %eax,%eax
80106c77:	78 77                	js     80106cf0 <sys_chdir+0xa0>
80106c79:	83 ec 0c             	sub    $0xc,%esp
80106c7c:	ff 75 f4             	push   -0xc(%ebp)
80106c7f:	e8 fc c4 ff ff       	call   80103180 <namei>
80106c84:	83 c4 10             	add    $0x10,%esp
80106c87:	89 c3                	mov    %eax,%ebx
80106c89:	85 c0                	test   %eax,%eax
80106c8b:	74 63                	je     80106cf0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80106c8d:	83 ec 0c             	sub    $0xc,%esp
80106c90:	50                   	push   %eax
80106c91:	e8 ca bb ff ff       	call   80102860 <ilock>
  if(ip->type != T_DIR){
80106c96:	83 c4 10             	add    $0x10,%esp
80106c99:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106c9e:	75 30                	jne    80106cd0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80106ca0:	83 ec 0c             	sub    $0xc,%esp
80106ca3:	53                   	push   %ebx
80106ca4:	e8 97 bc ff ff       	call   80102940 <iunlock>
  iput(curproc->cwd);
80106ca9:	58                   	pop    %eax
80106caa:	ff 76 68             	push   0x68(%esi)
80106cad:	e8 de bc ff ff       	call   80102990 <iput>
  end_op();
80106cb2:	e8 f9 d1 ff ff       	call   80103eb0 <end_op>
  curproc->cwd = ip;
80106cb7:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
80106cba:	83 c4 10             	add    $0x10,%esp
80106cbd:	31 c0                	xor    %eax,%eax
}
80106cbf:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106cc2:	5b                   	pop    %ebx
80106cc3:	5e                   	pop    %esi
80106cc4:	5d                   	pop    %ebp
80106cc5:	c3                   	ret
80106cc6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106ccd:	00 
80106cce:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80106cd0:	83 ec 0c             	sub    $0xc,%esp
80106cd3:	53                   	push   %ebx
80106cd4:	e8 17 be ff ff       	call   80102af0 <iunlockput>
    end_op();
80106cd9:	e8 d2 d1 ff ff       	call   80103eb0 <end_op>
    return -1;
80106cde:	83 c4 10             	add    $0x10,%esp
80106ce1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106ce6:	eb d7                	jmp    80106cbf <sys_chdir+0x6f>
80106ce8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106cef:	00 
    end_op();
80106cf0:	e8 bb d1 ff ff       	call   80103eb0 <end_op>
    return -1;
80106cf5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106cfa:	eb c3                	jmp    80106cbf <sys_chdir+0x6f>
80106cfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106d00 <sys_exec>:

int
sys_exec(void)
{
80106d00:	55                   	push   %ebp
80106d01:	89 e5                	mov    %esp,%ebp
80106d03:	57                   	push   %edi
80106d04:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106d05:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
80106d0b:	53                   	push   %ebx
80106d0c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106d12:	50                   	push   %eax
80106d13:	6a 00                	push   $0x0
80106d15:	e8 e6 f3 ff ff       	call   80106100 <argstr>
80106d1a:	83 c4 10             	add    $0x10,%esp
80106d1d:	85 c0                	test   %eax,%eax
80106d1f:	0f 88 87 00 00 00    	js     80106dac <sys_exec+0xac>
80106d25:	83 ec 08             	sub    $0x8,%esp
80106d28:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80106d2e:	50                   	push   %eax
80106d2f:	6a 01                	push   $0x1
80106d31:	e8 0a f3 ff ff       	call   80106040 <argint>
80106d36:	83 c4 10             	add    $0x10,%esp
80106d39:	85 c0                	test   %eax,%eax
80106d3b:	78 6f                	js     80106dac <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80106d3d:	83 ec 04             	sub    $0x4,%esp
80106d40:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
80106d46:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80106d48:	68 80 00 00 00       	push   $0x80
80106d4d:	6a 00                	push   $0x0
80106d4f:	56                   	push   %esi
80106d50:	e8 2b f0 ff ff       	call   80105d80 <memset>
80106d55:	83 c4 10             	add    $0x10,%esp
80106d58:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106d5f:	00 
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80106d60:	83 ec 08             	sub    $0x8,%esp
80106d63:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80106d69:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80106d70:	50                   	push   %eax
80106d71:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80106d77:	01 f8                	add    %edi,%eax
80106d79:	50                   	push   %eax
80106d7a:	e8 31 f2 ff ff       	call   80105fb0 <fetchint>
80106d7f:	83 c4 10             	add    $0x10,%esp
80106d82:	85 c0                	test   %eax,%eax
80106d84:	78 26                	js     80106dac <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80106d86:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80106d8c:	85 c0                	test   %eax,%eax
80106d8e:	74 30                	je     80106dc0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80106d90:	83 ec 08             	sub    $0x8,%esp
80106d93:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80106d96:	52                   	push   %edx
80106d97:	50                   	push   %eax
80106d98:	e8 53 f2 ff ff       	call   80105ff0 <fetchstr>
80106d9d:	83 c4 10             	add    $0x10,%esp
80106da0:	85 c0                	test   %eax,%eax
80106da2:	78 08                	js     80106dac <sys_exec+0xac>
  for(i=0;; i++){
80106da4:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80106da7:	83 fb 20             	cmp    $0x20,%ebx
80106daa:	75 b4                	jne    80106d60 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
80106dac:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80106daf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106db4:	5b                   	pop    %ebx
80106db5:	5e                   	pop    %esi
80106db6:	5f                   	pop    %edi
80106db7:	5d                   	pop    %ebp
80106db8:	c3                   	ret
80106db9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80106dc0:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80106dc7:	00 00 00 00 
  return exec(path, argv);
80106dcb:	83 ec 08             	sub    $0x8,%esp
80106dce:	56                   	push   %esi
80106dcf:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
80106dd5:	e8 b6 ad ff ff       	call   80101b90 <exec>
80106dda:	83 c4 10             	add    $0x10,%esp
}
80106ddd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106de0:	5b                   	pop    %ebx
80106de1:	5e                   	pop    %esi
80106de2:	5f                   	pop    %edi
80106de3:	5d                   	pop    %ebp
80106de4:	c3                   	ret
80106de5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106dec:	00 
80106ded:	8d 76 00             	lea    0x0(%esi),%esi

80106df0 <sys_pipe>:

int
sys_pipe(void)
{
80106df0:	55                   	push   %ebp
80106df1:	89 e5                	mov    %esp,%ebp
80106df3:	57                   	push   %edi
80106df4:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106df5:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80106df8:	53                   	push   %ebx
80106df9:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106dfc:	6a 08                	push   $0x8
80106dfe:	50                   	push   %eax
80106dff:	6a 00                	push   $0x0
80106e01:	e8 8a f2 ff ff       	call   80106090 <argptr>
80106e06:	83 c4 10             	add    $0x10,%esp
80106e09:	85 c0                	test   %eax,%eax
80106e0b:	78 4a                	js     80106e57 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80106e0d:	83 ec 08             	sub    $0x8,%esp
80106e10:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106e13:	50                   	push   %eax
80106e14:	8d 45 e0             	lea    -0x20(%ebp),%eax
80106e17:	50                   	push   %eax
80106e18:	e8 f3 d6 ff ff       	call   80104510 <pipealloc>
80106e1d:	83 c4 10             	add    $0x10,%esp
80106e20:	85 c0                	test   %eax,%eax
80106e22:	78 33                	js     80106e57 <sys_pipe+0x67>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106e24:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80106e27:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80106e29:	e8 42 dc ff ff       	call   80104a70 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80106e2e:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
80106e30:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80106e34:	85 f6                	test   %esi,%esi
80106e36:	74 28                	je     80106e60 <sys_pipe+0x70>
  for(fd = 0; fd < NOFILE; fd++){
80106e38:	83 c3 01             	add    $0x1,%ebx
80106e3b:	83 fb 10             	cmp    $0x10,%ebx
80106e3e:	75 f0                	jne    80106e30 <sys_pipe+0x40>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80106e40:	83 ec 0c             	sub    $0xc,%esp
80106e43:	ff 75 e0             	push   -0x20(%ebp)
80106e46:	e8 85 b1 ff ff       	call   80101fd0 <fileclose>
    fileclose(wf);
80106e4b:	58                   	pop    %eax
80106e4c:	ff 75 e4             	push   -0x1c(%ebp)
80106e4f:	e8 7c b1 ff ff       	call   80101fd0 <fileclose>
    return -1;
80106e54:	83 c4 10             	add    $0x10,%esp
80106e57:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106e5c:	eb 53                	jmp    80106eb1 <sys_pipe+0xc1>
80106e5e:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80106e60:	8d 73 08             	lea    0x8(%ebx),%esi
80106e63:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106e67:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80106e6a:	e8 01 dc ff ff       	call   80104a70 <myproc>
80106e6f:	89 c2                	mov    %eax,%edx
  for(fd = 0; fd < NOFILE; fd++){
80106e71:	31 c0                	xor    %eax,%eax
80106e73:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80106e78:	8b 4c 82 28          	mov    0x28(%edx,%eax,4),%ecx
80106e7c:	85 c9                	test   %ecx,%ecx
80106e7e:	74 20                	je     80106ea0 <sys_pipe+0xb0>
  for(fd = 0; fd < NOFILE; fd++){
80106e80:	83 c0 01             	add    $0x1,%eax
80106e83:	83 f8 10             	cmp    $0x10,%eax
80106e86:	75 f0                	jne    80106e78 <sys_pipe+0x88>
      myproc()->ofile[fd0] = 0;
80106e88:	e8 e3 db ff ff       	call   80104a70 <myproc>
80106e8d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80106e94:	00 
80106e95:	eb a9                	jmp    80106e40 <sys_pipe+0x50>
80106e97:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106e9e:	00 
80106e9f:	90                   	nop
      curproc->ofile[fd] = f;
80106ea0:	89 7c 82 28          	mov    %edi,0x28(%edx,%eax,4)
  }
  fd[0] = fd0;
80106ea4:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106ea7:	89 1a                	mov    %ebx,(%edx)
  fd[1] = fd1;
80106ea9:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106eac:	89 42 04             	mov    %eax,0x4(%edx)
  return 0;
80106eaf:	31 c0                	xor    %eax,%eax
}
80106eb1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106eb4:	5b                   	pop    %ebx
80106eb5:	5e                   	pop    %esi
80106eb6:	5f                   	pop    %edi
80106eb7:	5d                   	pop    %ebp
80106eb8:	c3                   	ret
80106eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106ec0 <sys_move_file>:

int sys_move_file(void) {
80106ec0:	55                   	push   %ebp
80106ec1:	89 e5                	mov    %esp,%ebp
80106ec3:	57                   	push   %edi
80106ec4:	56                   	push   %esi
    char filename[DIRSIZ];
    struct inode *src_inode = 0, *src_parent_inode = 0, *dest_inode = 0;
    uint offset;
    // int result = -1;

    if (argstr(0, &src_path) < 0 || argstr(1, &dest_path) < 0) {
80106ec5:	8d 45 bc             	lea    -0x44(%ebp),%eax
int sys_move_file(void) {
80106ec8:	53                   	push   %ebx
80106ec9:	83 ec 44             	sub    $0x44,%esp
    if (argstr(0, &src_path) < 0 || argstr(1, &dest_path) < 0) {
80106ecc:	50                   	push   %eax
80106ecd:	6a 00                	push   $0x0
80106ecf:	e8 2c f2 ff ff       	call   80106100 <argstr>
80106ed4:	83 c4 10             	add    $0x10,%esp
80106ed7:	85 c0                	test   %eax,%eax
80106ed9:	0f 88 bf 01 00 00    	js     8010709e <sys_move_file+0x1de>
80106edf:	83 ec 08             	sub    $0x8,%esp
80106ee2:	8d 45 c0             	lea    -0x40(%ebp),%eax
80106ee5:	50                   	push   %eax
80106ee6:	6a 01                	push   $0x1
80106ee8:	e8 13 f2 ff ff       	call   80106100 <argstr>
80106eed:	83 c4 10             	add    $0x10,%esp
80106ef0:	85 c0                	test   %eax,%eax
80106ef2:	0f 88 a6 01 00 00    	js     8010709e <sys_move_file+0x1de>
        return -1;
    }

    begin_op();
80106ef8:	e8 43 cf ff ff       	call   80103e40 <begin_op>

    // Find the inode of the source file
    src_inode = namei(src_path);
80106efd:	83 ec 0c             	sub    $0xc,%esp
80106f00:	ff 75 bc             	push   -0x44(%ebp)
80106f03:	e8 78 c2 ff ff       	call   80103180 <namei>
    if (src_inode == 0) {
80106f08:	83 c4 10             	add    $0x10,%esp
    src_inode = namei(src_path);
80106f0b:	89 c3                	mov    %eax,%ebx
    if (src_inode == 0) {
80106f0d:	85 c0                	test   %eax,%eax
80106f0f:	0f 84 b1 01 00 00    	je     801070c6 <sys_move_file+0x206>
        end_op();
        return -1;
    }

    ilock(src_inode);
80106f15:	83 ec 0c             	sub    $0xc,%esp
80106f18:	50                   	push   %eax
80106f19:	e8 42 b9 ff ff       	call   80102860 <ilock>

    if (src_inode->type != T_FILE) {
80106f1e:	83 c4 10             	add    $0x10,%esp
80106f21:	66 83 7b 50 02       	cmpw   $0x2,0x50(%ebx)
80106f26:	0f 85 7c 01 00 00    	jne    801070a8 <sys_move_file+0x1e8>
        end_op();
        return -1;
    }

    src_inode->nlink++;
    iupdate(src_inode);
80106f2c:	83 ec 0c             	sub    $0xc,%esp
    src_inode->nlink++;
80106f2f:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iunlock(src_inode);

    // Find the parent inode of the source path
    src_parent_inode = nameiparent(src_path, filename);
80106f34:	8d 75 ca             	lea    -0x36(%ebp),%esi
    iupdate(src_inode);
80106f37:	53                   	push   %ebx
80106f38:	e8 73 b8 ff ff       	call   801027b0 <iupdate>
    iunlock(src_inode);
80106f3d:	89 1c 24             	mov    %ebx,(%esp)
80106f40:	e8 fb b9 ff ff       	call   80102940 <iunlock>
    src_parent_inode = nameiparent(src_path, filename);
80106f45:	5a                   	pop    %edx
80106f46:	59                   	pop    %ecx
80106f47:	56                   	push   %esi
80106f48:	ff 75 bc             	push   -0x44(%ebp)
80106f4b:	e8 50 c2 ff ff       	call   801031a0 <nameiparent>
    if (src_parent_inode == 0) {
80106f50:	83 c4 10             	add    $0x10,%esp
    src_parent_inode = nameiparent(src_path, filename);
80106f53:	89 c7                	mov    %eax,%edi
    if (src_parent_inode == 0) {
80106f55:	85 c0                	test   %eax,%eax
80106f57:	0f 84 63 01 00 00    	je     801070c0 <sys_move_file+0x200>
        iunlockput(src_inode);
        end_op();
        return -1;
    }

    ilock(src_parent_inode);
80106f5d:	83 ec 0c             	sub    $0xc,%esp
80106f60:	50                   	push   %eax
80106f61:	e8 fa b8 ff ff       	call   80102860 <ilock>

    if (dirlookup(src_parent_inode, filename, &offset) == 0) {
80106f66:	83 c4 0c             	add    $0xc,%esp
80106f69:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80106f6c:	50                   	push   %eax
80106f6d:	56                   	push   %esi
80106f6e:	57                   	push   %edi
80106f6f:	e8 4c be ff ff       	call   80102dc0 <dirlookup>
80106f74:	83 c4 10             	add    $0x10,%esp
80106f77:	85 c0                	test   %eax,%eax
80106f79:	0f 84 f1 00 00 00    	je     80107070 <sys_move_file+0x1b0>
        end_op();
        return -1;
    }

    struct dirent empty_entry;
    memset(&empty_entry, 0, sizeof(empty_entry));
80106f7f:	83 ec 04             	sub    $0x4,%esp
80106f82:	8d 4d d8             	lea    -0x28(%ebp),%ecx
80106f85:	6a 10                	push   $0x10
80106f87:	6a 00                	push   $0x0
80106f89:	51                   	push   %ecx
80106f8a:	e8 f1 ed ff ff       	call   80105d80 <memset>

    if (writei(src_parent_inode, (char*)&empty_entry, offset, sizeof(empty_entry)) != sizeof(empty_entry)) {
80106f8f:	8d 4d d8             	lea    -0x28(%ebp),%ecx
80106f92:	6a 10                	push   $0x10
80106f94:	ff 75 c4             	push   -0x3c(%ebp)
80106f97:	51                   	push   %ecx
80106f98:	57                   	push   %edi
80106f99:	e8 d2 bc ff ff       	call   80102c70 <writei>
80106f9e:	83 c4 20             	add    $0x20,%esp
80106fa1:	83 f8 10             	cmp    $0x10,%eax
80106fa4:	0f 85 c6 00 00 00    	jne    80107070 <sys_move_file+0x1b0>
        iunlockput(src_inode);
        end_op();
        return -1;
    }

    if (src_inode->type == T_DIR) {
80106faa:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106faf:	0f 84 a3 00 00 00    	je     80107058 <sys_move_file+0x198>
        src_parent_inode->nlink--;
        iupdate(src_parent_inode);
    }
    src_parent_inode->nlink--;
    iunlock(src_parent_inode);
80106fb5:	83 ec 0c             	sub    $0xc,%esp
    src_parent_inode->nlink--;
80106fb8:	66 83 6f 56 01       	subw   $0x1,0x56(%edi)
    iunlock(src_parent_inode);
80106fbd:	57                   	push   %edi
80106fbe:	e8 7d b9 ff ff       	call   80102940 <iunlock>

    // Find the destination directory inode
    dest_inode = namei(dest_path);
80106fc3:	58                   	pop    %eax
80106fc4:	ff 75 c0             	push   -0x40(%ebp)
80106fc7:	e8 b4 c1 ff ff       	call   80103180 <namei>
    if (dest_inode == 0) {
80106fcc:	83 c4 10             	add    $0x10,%esp
    dest_inode = namei(dest_path);
80106fcf:	89 c7                	mov    %eax,%edi
    if (dest_inode == 0) {
80106fd1:	85 c0                	test   %eax,%eax
80106fd3:	0f 84 e7 00 00 00    	je     801070c0 <sys_move_file+0x200>
        iunlockput(src_inode);
        end_op();
        return -1;
    }

    ilock(dest_inode);
80106fd9:	83 ec 0c             	sub    $0xc,%esp
80106fdc:	50                   	push   %eax
80106fdd:	e8 7e b8 ff ff       	call   80102860 <ilock>
    if (dest_inode->type != T_DIR) {
80106fe2:	83 c4 10             	add    $0x10,%esp
80106fe5:	66 83 7f 50 01       	cmpw   $0x1,0x50(%edi)
80106fea:	0f 85 80 00 00 00    	jne    80107070 <sys_move_file+0x1b0>
        iunlockput(src_inode);
        end_op();
        return -1;
    }

    if (dirlookup(dest_inode, filename, &offset) != 0) {
80106ff0:	83 ec 04             	sub    $0x4,%esp
80106ff3:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80106ff6:	50                   	push   %eax
80106ff7:	56                   	push   %esi
80106ff8:	57                   	push   %edi
80106ff9:	e8 c2 bd ff ff       	call   80102dc0 <dirlookup>
80106ffe:	83 c4 10             	add    $0x10,%esp
80107001:	85 c0                	test   %eax,%eax
80107003:	75 6b                	jne    80107070 <sys_move_file+0x1b0>
        iunlockput(src_inode);
        end_op();
        return -1;
    }

    if (dirlink(dest_inode, filename, src_inode->inum) < 0) {
80107005:	83 ec 04             	sub    $0x4,%esp
80107008:	ff 73 04             	push   0x4(%ebx)
8010700b:	56                   	push   %esi
8010700c:	57                   	push   %edi
8010700d:	e8 ae c0 ff ff       	call   801030c0 <dirlink>
80107012:	83 c4 10             	add    $0x10,%esp
80107015:	85 c0                	test   %eax,%eax
80107017:	78 57                	js     80107070 <sys_move_file+0x1b0>
        iunlockput(src_inode);
        end_op();
        return -1;
    }

    iunlockput(dest_inode);
80107019:	83 ec 0c             	sub    $0xc,%esp
8010701c:	57                   	push   %edi
8010701d:	e8 ce ba ff ff       	call   80102af0 <iunlockput>

    ilock(src_inode);
80107022:	89 1c 24             	mov    %ebx,(%esp)
80107025:	e8 36 b8 ff ff       	call   80102860 <ilock>
    src_inode->nlink--;
8010702a:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
    iupdate(src_inode);
8010702f:	89 1c 24             	mov    %ebx,(%esp)
80107032:	e8 79 b7 ff ff       	call   801027b0 <iupdate>
    iunlockput(src_inode);
80107037:	89 1c 24             	mov    %ebx,(%esp)
8010703a:	e8 b1 ba ff ff       	call   80102af0 <iunlockput>

    end_op();
8010703f:	e8 6c ce ff ff       	call   80103eb0 <end_op>
    return 0;
80107044:	83 c4 10             	add    $0x10,%esp
80107047:	31 c0                	xor    %eax,%eax
80107049:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010704c:	5b                   	pop    %ebx
8010704d:	5e                   	pop    %esi
8010704e:	5f                   	pop    %edi
8010704f:	5d                   	pop    %ebp
80107050:	c3                   	ret
80107051:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        iupdate(src_parent_inode);
80107058:	83 ec 0c             	sub    $0xc,%esp
        src_parent_inode->nlink--;
8010705b:	66 83 6f 56 01       	subw   $0x1,0x56(%edi)
        iupdate(src_parent_inode);
80107060:	57                   	push   %edi
80107061:	e8 4a b7 ff ff       	call   801027b0 <iupdate>
80107066:	83 c4 10             	add    $0x10,%esp
80107069:	e9 47 ff ff ff       	jmp    80106fb5 <sys_move_file+0xf5>
8010706e:	66 90                	xchg   %ax,%ax
        iunlockput(dest_inode);
80107070:	83 ec 0c             	sub    $0xc,%esp
80107073:	57                   	push   %edi
80107074:	e8 77 ba ff ff       	call   80102af0 <iunlockput>
        ilock(src_inode);
80107079:	89 1c 24             	mov    %ebx,(%esp)
8010707c:	e8 df b7 ff ff       	call   80102860 <ilock>
        src_inode->nlink--;
80107081:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
        iupdate(src_inode);
80107086:	89 1c 24             	mov    %ebx,(%esp)
80107089:	e8 22 b7 ff ff       	call   801027b0 <iupdate>
        iunlockput(src_inode);
8010708e:	89 1c 24             	mov    %ebx,(%esp)
80107091:	e8 5a ba ff ff       	call   80102af0 <iunlockput>
        end_op();
80107096:	e8 15 ce ff ff       	call   80103eb0 <end_op>
        return -1;
8010709b:	83 c4 10             	add    $0x10,%esp
8010709e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801070a3:	eb a4                	jmp    80107049 <sys_move_file+0x189>
801070a5:	8d 76 00             	lea    0x0(%esi),%esi
        iunlockput(src_inode);
801070a8:	83 ec 0c             	sub    $0xc,%esp
801070ab:	53                   	push   %ebx
801070ac:	e8 3f ba ff ff       	call   80102af0 <iunlockput>
        end_op();
801070b1:	e8 fa cd ff ff       	call   80103eb0 <end_op>
        return -1;
801070b6:	83 c4 10             	add    $0x10,%esp
801070b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801070be:	eb 89                	jmp    80107049 <sys_move_file+0x189>
        ilock(src_inode);
801070c0:	83 ec 0c             	sub    $0xc,%esp
801070c3:	53                   	push   %ebx
801070c4:	eb b6                	jmp    8010707c <sys_move_file+0x1bc>
        end_op();
801070c6:	e8 e5 cd ff ff       	call   80103eb0 <end_op>
        return -1;
801070cb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801070d0:	e9 74 ff ff ff       	jmp    80107049 <sys_move_file+0x189>
801070d5:	66 90                	xchg   %ax,%ax
801070d7:	66 90                	xchg   %ax,%ax
801070d9:	66 90                	xchg   %ax,%ax
801070db:	66 90                	xchg   %ax,%ax
801070dd:	66 90                	xchg   %ax,%ax
801070df:	90                   	nop

801070e0 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
801070e0:	e9 2b db ff ff       	jmp    80104c10 <fork>
801070e5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801070ec:	00 
801070ed:	8d 76 00             	lea    0x0(%esi),%esi

801070f0 <sys_exit>:
}

int
sys_exit(void)
{
801070f0:	55                   	push   %ebp
801070f1:	89 e5                	mov    %esp,%ebp
801070f3:	83 ec 08             	sub    $0x8,%esp
  exit();
801070f6:	e8 95 dd ff ff       	call   80104e90 <exit>
  return 0;  // not reached
}
801070fb:	31 c0                	xor    %eax,%eax
801070fd:	c9                   	leave
801070fe:	c3                   	ret
801070ff:	90                   	nop

80107100 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80107100:	e9 bb de ff ff       	jmp    80104fc0 <wait>
80107105:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010710c:	00 
8010710d:	8d 76 00             	lea    0x0(%esi),%esi

80107110 <sys_kill>:
}

int
sys_kill(void)
{
80107110:	55                   	push   %ebp
80107111:	89 e5                	mov    %esp,%ebp
80107113:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80107116:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107119:	50                   	push   %eax
8010711a:	6a 00                	push   $0x0
8010711c:	e8 1f ef ff ff       	call   80106040 <argint>
80107121:	83 c4 10             	add    $0x10,%esp
80107124:	85 c0                	test   %eax,%eax
80107126:	78 18                	js     80107140 <sys_kill+0x30>
    return -1;
  return kill(pid);
80107128:	83 ec 0c             	sub    $0xc,%esp
8010712b:	ff 75 f4             	push   -0xc(%ebp)
8010712e:	e8 2d e1 ff ff       	call   80105260 <kill>
80107133:	83 c4 10             	add    $0x10,%esp
}
80107136:	c9                   	leave
80107137:	c3                   	ret
80107138:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010713f:	00 
80107140:	c9                   	leave
    return -1;
80107141:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107146:	c3                   	ret
80107147:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010714e:	00 
8010714f:	90                   	nop

80107150 <sys_getpid>:

int
sys_getpid(void)
{
80107150:	55                   	push   %ebp
80107151:	89 e5                	mov    %esp,%ebp
80107153:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80107156:	e8 15 d9 ff ff       	call   80104a70 <myproc>
8010715b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010715e:	c9                   	leave
8010715f:	c3                   	ret

80107160 <sys_sbrk>:

int
sys_sbrk(void)
{
80107160:	55                   	push   %ebp
80107161:	89 e5                	mov    %esp,%ebp
80107163:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80107164:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80107167:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010716a:	50                   	push   %eax
8010716b:	6a 00                	push   $0x0
8010716d:	e8 ce ee ff ff       	call   80106040 <argint>
80107172:	83 c4 10             	add    $0x10,%esp
80107175:	85 c0                	test   %eax,%eax
80107177:	78 27                	js     801071a0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80107179:	e8 f2 d8 ff ff       	call   80104a70 <myproc>
  if(growproc(n) < 0)
8010717e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80107181:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80107183:	ff 75 f4             	push   -0xc(%ebp)
80107186:	e8 05 da ff ff       	call   80104b90 <growproc>
8010718b:	83 c4 10             	add    $0x10,%esp
8010718e:	85 c0                	test   %eax,%eax
80107190:	78 0e                	js     801071a0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80107192:	89 d8                	mov    %ebx,%eax
80107194:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107197:	c9                   	leave
80107198:	c3                   	ret
80107199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801071a0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801071a5:	eb eb                	jmp    80107192 <sys_sbrk+0x32>
801071a7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801071ae:	00 
801071af:	90                   	nop

801071b0 <sys_sleep>:

int
sys_sleep(void)
{
801071b0:	55                   	push   %ebp
801071b1:	89 e5                	mov    %esp,%ebp
801071b3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801071b4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801071b7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801071ba:	50                   	push   %eax
801071bb:	6a 00                	push   $0x0
801071bd:	e8 7e ee ff ff       	call   80106040 <argint>
801071c2:	83 c4 10             	add    $0x10,%esp
801071c5:	85 c0                	test   %eax,%eax
801071c7:	0f 88 8a 00 00 00    	js     80107257 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
801071cd:	83 ec 0c             	sub    $0xc,%esp
801071d0:	68 40 91 34 80       	push   $0x80349140
801071d5:	e8 e6 ea ff ff       	call   80105cc0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801071da:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
801071dd:	8b 1d 20 91 34 80    	mov    0x80349120,%ebx
  while(ticks - ticks0 < n){
801071e3:	83 c4 10             	add    $0x10,%esp
801071e6:	85 d2                	test   %edx,%edx
801071e8:	75 27                	jne    80107211 <sys_sleep+0x61>
801071ea:	eb 54                	jmp    80107240 <sys_sleep+0x90>
801071ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801071f0:	83 ec 08             	sub    $0x8,%esp
801071f3:	68 40 91 34 80       	push   $0x80349140
801071f8:	68 20 91 34 80       	push   $0x80349120
801071fd:	e8 3e df ff ff       	call   80105140 <sleep>
  while(ticks - ticks0 < n){
80107202:	a1 20 91 34 80       	mov    0x80349120,%eax
80107207:	83 c4 10             	add    $0x10,%esp
8010720a:	29 d8                	sub    %ebx,%eax
8010720c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010720f:	73 2f                	jae    80107240 <sys_sleep+0x90>
    if(myproc()->killed){
80107211:	e8 5a d8 ff ff       	call   80104a70 <myproc>
80107216:	8b 40 24             	mov    0x24(%eax),%eax
80107219:	85 c0                	test   %eax,%eax
8010721b:	74 d3                	je     801071f0 <sys_sleep+0x40>
      release(&tickslock);
8010721d:	83 ec 0c             	sub    $0xc,%esp
80107220:	68 40 91 34 80       	push   $0x80349140
80107225:	e8 36 ea ff ff       	call   80105c60 <release>
  }
  release(&tickslock);
  return 0;
}
8010722a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return -1;
8010722d:	83 c4 10             	add    $0x10,%esp
80107230:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107235:	c9                   	leave
80107236:	c3                   	ret
80107237:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010723e:	00 
8010723f:	90                   	nop
  release(&tickslock);
80107240:	83 ec 0c             	sub    $0xc,%esp
80107243:	68 40 91 34 80       	push   $0x80349140
80107248:	e8 13 ea ff ff       	call   80105c60 <release>
  return 0;
8010724d:	83 c4 10             	add    $0x10,%esp
80107250:	31 c0                	xor    %eax,%eax
}
80107252:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107255:	c9                   	leave
80107256:	c3                   	ret
    return -1;
80107257:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010725c:	eb f4                	jmp    80107252 <sys_sleep+0xa2>
8010725e:	66 90                	xchg   %ax,%ax

80107260 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80107260:	55                   	push   %ebp
80107261:	89 e5                	mov    %esp,%ebp
80107263:	53                   	push   %ebx
80107264:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80107267:	68 40 91 34 80       	push   $0x80349140
8010726c:	e8 4f ea ff ff       	call   80105cc0 <acquire>
  xticks = ticks;
80107271:	8b 1d 20 91 34 80    	mov    0x80349120,%ebx
  release(&tickslock);
80107277:	c7 04 24 40 91 34 80 	movl   $0x80349140,(%esp)
8010727e:	e8 dd e9 ff ff       	call   80105c60 <release>
  return xticks;
}
80107283:	89 d8                	mov    %ebx,%eax
80107285:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107288:	c9                   	leave
80107289:	c3                   	ret
8010728a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107290 <sys_create_palindrome>:

int 
sys_create_palindrome(void)
{
80107290:	55                   	push   %ebp
80107291:	89 e5                	mov    %esp,%ebp
80107293:	53                   	push   %ebx
80107294:	83 ec 04             	sub    $0x4,%esp
    int number = myproc()->tf->ebx; //register after eax
80107297:	e8 d4 d7 ff ff       	call   80104a70 <myproc>
    cprintf("Kernel: sys_create_palindrome called for number %d\n", number);
8010729c:	83 ec 08             	sub    $0x8,%esp
    int number = myproc()->tf->ebx; //register after eax
8010729f:	8b 40 18             	mov    0x18(%eax),%eax
801072a2:	8b 58 10             	mov    0x10(%eax),%ebx
    cprintf("Kernel: sys_create_palindrome called for number %d\n", number);
801072a5:	53                   	push   %ebx
801072a6:	68 44 98 10 80       	push   $0x80109844
801072ab:	e8 20 95 ff ff       	call   801007d0 <cprintf>
    return create_palindrome(number);
801072b0:	89 1c 24             	mov    %ebx,(%esp)
801072b3:	e8 e8 e0 ff ff       	call   801053a0 <create_palindrome>
}
801072b8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801072bb:	c9                   	leave
801072bc:	c3                   	ret
801072bd:	8d 76 00             	lea    0x0(%esi),%esi

801072c0 <sys_sort_syscalls>:

int
sys_sort_syscalls(void)
{
801072c0:	55                   	push   %ebp
801072c1:	89 e5                	mov    %esp,%ebp
801072c3:	83 ec 20             	sub    $0x20,%esp
    int pid;
    // try to extract the first argument of the system call
    int could_fetch = argint(0, &pid);
801072c6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801072c9:	50                   	push   %eax
801072ca:	6a 00                	push   $0x0
801072cc:	e8 6f ed ff ff       	call   80106040 <argint>
    if (could_fetch < 0) {
801072d1:	83 c4 10             	add    $0x10,%esp
801072d4:	85 c0                	test   %eax,%eax
801072d6:	78 1e                	js     801072f6 <sys_sort_syscalls+0x36>
        cprintf("Kernel: Could not extract the 'pid' argument for sort_syscalls\n");
        return -1;
    }
    
    // If the function reachs here, it means the 'pid' argument is available
    cprintf("Kernel: sort_syscalls called for process with ID %d\n", pid);
801072d8:	83 ec 08             	sub    $0x8,%esp
801072db:	ff 75 f4             	push   -0xc(%ebp)
801072de:	68 b8 98 10 80       	push   $0x801098b8
801072e3:	e8 e8 94 ff ff       	call   801007d0 <cprintf>

    // Get the process structure
    // struct proc* p = find_process_by_id(pid);

    return sort_syscalls(pid);
801072e8:	58                   	pop    %eax
801072e9:	ff 75 f4             	push   -0xc(%ebp)
801072ec:	e8 7f e1 ff ff       	call   80105470 <sort_syscalls>
801072f1:	83 c4 10             	add    $0x10,%esp
}
801072f4:	c9                   	leave
801072f5:	c3                   	ret
        cprintf("Kernel: Could not extract the 'pid' argument for sort_syscalls\n");
801072f6:	83 ec 0c             	sub    $0xc,%esp
801072f9:	68 78 98 10 80       	push   $0x80109878
801072fe:	e8 cd 94 ff ff       	call   801007d0 <cprintf>
        return -1;
80107303:	83 c4 10             	add    $0x10,%esp
80107306:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010730b:	c9                   	leave
8010730c:	c3                   	ret
8010730d:	8d 76 00             	lea    0x0(%esi),%esi

80107310 <sys_get_most_invoked_syscall>:

int
sys_get_most_invoked_syscall(void)
{
80107310:	55                   	push   %ebp
80107311:	89 e5                	mov    %esp,%ebp
80107313:	83 ec 20             	sub    $0x20,%esp
    int pid;
    // try to extract the first argument of the system call
    int could_fetch = argint(0, &pid);
80107316:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107319:	50                   	push   %eax
8010731a:	6a 00                	push   $0x0
8010731c:	e8 1f ed ff ff       	call   80106040 <argint>
    if (could_fetch < 0)
80107321:	83 c4 10             	add    $0x10,%esp
80107324:	85 c0                	test   %eax,%eax
80107326:	78 52                	js     8010737a <sys_get_most_invoked_syscall+0x6a>
        cprintf("Kernel: Could not extract the 'pid' argument for get_most_invoked_systemcall\n");
        return -1;
    }

    // If the function reachs here, it means the 'pid' argument is available
    cprintf("Kernel: most_invoked_systemcall called for process with ID %d\n", pid);
80107328:	83 ec 08             	sub    $0x8,%esp
8010732b:	ff 75 f4             	push   -0xc(%ebp)
8010732e:	68 40 99 10 80       	push   $0x80109940
80107333:	e8 98 94 ff ff       	call   801007d0 <cprintf>

    int res = get_most_invoked_syscall(pid);
80107338:	58                   	pop    %eax
80107339:	ff 75 f4             	push   -0xc(%ebp)
8010733c:	e8 1f e4 ff ff       	call   80105760 <get_most_invoked_syscall>
    if (res < 0)
80107341:	83 c4 10             	add    $0x10,%esp
80107344:	85 c0                	test   %eax,%eax
80107346:	78 18                	js     80107360 <sys_get_most_invoked_syscall+0x50>
        cprintf("Kernel: Could not find the most invoked system call for process with ID %d\n", pid);
        return -1;
    }
    else
    {
        cprintf("Kernel: Successfully found the most invoked system call for process with ID %d\n", pid);
80107348:	83 ec 08             	sub    $0x8,%esp
8010734b:	ff 75 f4             	push   -0xc(%ebp)
8010734e:	68 cc 99 10 80       	push   $0x801099cc
80107353:	e8 78 94 ff ff       	call   801007d0 <cprintf>
        return 0;
80107358:	83 c4 10             	add    $0x10,%esp
8010735b:	31 c0                	xor    %eax,%eax
    }
}
8010735d:	c9                   	leave
8010735e:	c3                   	ret
8010735f:	90                   	nop
        cprintf("Kernel: Could not find the most invoked system call for process with ID %d\n", pid);
80107360:	83 ec 08             	sub    $0x8,%esp
80107363:	ff 75 f4             	push   -0xc(%ebp)
80107366:	68 80 99 10 80       	push   $0x80109980
8010736b:	e8 60 94 ff ff       	call   801007d0 <cprintf>
        return -1;
80107370:	83 c4 10             	add    $0x10,%esp
80107373:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107378:	c9                   	leave
80107379:	c3                   	ret
        cprintf("Kernel: Could not extract the 'pid' argument for get_most_invoked_systemcall\n");
8010737a:	83 ec 0c             	sub    $0xc,%esp
8010737d:	68 f0 98 10 80       	push   $0x801098f0
80107382:	e8 49 94 ff ff       	call   801007d0 <cprintf>
        return -1;
80107387:	83 c4 10             	add    $0x10,%esp
8010738a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010738f:	c9                   	leave
80107390:	c3                   	ret
80107391:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107398:	00 
80107399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801073a0 <sys_list_all_processes>:

void
sys_list_all_processes(void)
{
801073a0:	55                   	push   %ebp
801073a1:	89 e5                	mov    %esp,%ebp
801073a3:	83 ec 14             	sub    $0x14,%esp
  cprintf("Kernel: sys_list_all_processes called.\n");
801073a6:	68 1c 9a 10 80       	push   $0x80109a1c
801073ab:	e8 20 94 ff ff       	call   801007d0 <cprintf>
  list_all_processes(1);
801073b0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801073b7:	e8 94 e5 ff ff       	call   80105950 <list_all_processes>
}
801073bc:	83 c4 10             	add    $0x10,%esp
801073bf:	c9                   	leave
801073c0:	c3                   	ret
801073c1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801073c8:	00 
801073c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801073d0 <sys_open_sharedmem>:

char* sys_open_sharedmem(void) {
801073d0:	55                   	push   %ebp
801073d1:	89 e5                	mov    %esp,%ebp
801073d3:	83 ec 20             	sub    $0x20,%esp
    int id;
    if (argint(0, &id) < 0)
801073d6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801073d9:	50                   	push   %eax
801073da:	6a 00                	push   $0x0
801073dc:	e8 5f ec ff ff       	call   80106040 <argint>
801073e1:	83 c4 10             	add    $0x10,%esp
801073e4:	89 c2                	mov    %eax,%edx
801073e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801073eb:	85 d2                	test   %edx,%edx
801073ed:	78 0e                	js     801073fd <sys_open_sharedmem+0x2d>
        return (char*)(-1); // error but we don't have equivalent in char*

    return open_sharedmem(id);
801073ef:	83 ec 0c             	sub    $0xc,%esp
801073f2:	ff 75 f4             	push   -0xc(%ebp)
801073f5:	e8 86 19 00 00       	call   80108d80 <open_sharedmem>
801073fa:	83 c4 10             	add    $0x10,%esp
}
801073fd:	c9                   	leave
801073fe:	c3                   	ret
801073ff:	90                   	nop

80107400 <sys_close_sharedmem>:

int sys_close_sharedmem(void) {
80107400:	55                   	push   %ebp
80107401:	89 e5                	mov    %esp,%ebp
80107403:	83 ec 20             	sub    $0x20,%esp
    int id;
    if (argint(0, &id) < 0)
80107406:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107409:	50                   	push   %eax
8010740a:	6a 00                	push   $0x0
8010740c:	e8 2f ec ff ff       	call   80106040 <argint>
80107411:	83 c4 10             	add    $0x10,%esp
80107414:	85 c0                	test   %eax,%eax
80107416:	78 18                	js     80107430 <sys_close_sharedmem+0x30>
        return -1;

    return close_sharedmem(id);
80107418:	83 ec 0c             	sub    $0xc,%esp
8010741b:	ff 75 f4             	push   -0xc(%ebp)
8010741e:	e8 cd 1a 00 00       	call   80108ef0 <close_sharedmem>
80107423:	83 c4 10             	add    $0x10,%esp
80107426:	c9                   	leave
80107427:	c3                   	ret
80107428:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010742f:	00 
80107430:	c9                   	leave
        return -1;
80107431:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107436:	c3                   	ret

80107437 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80107437:	1e                   	push   %ds
  pushl %es
80107438:	06                   	push   %es
  pushl %fs
80107439:	0f a0                	push   %fs
  pushl %gs
8010743b:	0f a8                	push   %gs
  pushal
8010743d:	60                   	pusha
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
8010743e:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80107442:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80107444:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80107446:	54                   	push   %esp
  call trap
80107447:	e8 c4 00 00 00       	call   80107510 <trap>
  addl $4, %esp
8010744c:	83 c4 04             	add    $0x4,%esp

8010744f <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
8010744f:	61                   	popa
  popl %gs
80107450:	0f a9                	pop    %gs
  popl %fs
80107452:	0f a1                	pop    %fs
  popl %es
80107454:	07                   	pop    %es
  popl %ds
80107455:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80107456:	83 c4 08             	add    $0x8,%esp
  iret
80107459:	cf                   	iret
8010745a:	66 90                	xchg   %ax,%ax
8010745c:	66 90                	xchg   %ax,%ax
8010745e:	66 90                	xchg   %ax,%ax

80107460 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80107460:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80107461:	31 c0                	xor    %eax,%eax
{
80107463:	89 e5                	mov    %esp,%ebp
80107465:	83 ec 08             	sub    $0x8,%esp
80107468:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010746f:	00 
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80107470:	8b 14 85 a4 c3 10 80 	mov    -0x7fef3c5c(,%eax,4),%edx
80107477:	c7 04 c5 82 91 34 80 	movl   $0x8e000008,-0x7fcb6e7e(,%eax,8)
8010747e:	08 00 00 8e 
80107482:	66 89 14 c5 80 91 34 	mov    %dx,-0x7fcb6e80(,%eax,8)
80107489:	80 
8010748a:	c1 ea 10             	shr    $0x10,%edx
8010748d:	66 89 14 c5 86 91 34 	mov    %dx,-0x7fcb6e7a(,%eax,8)
80107494:	80 
  for(i = 0; i < 256; i++)
80107495:	83 c0 01             	add    $0x1,%eax
80107498:	3d 00 01 00 00       	cmp    $0x100,%eax
8010749d:	75 d1                	jne    80107470 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
8010749f:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801074a2:	a1 a4 c4 10 80       	mov    0x8010c4a4,%eax
801074a7:	c7 05 82 93 34 80 08 	movl   $0xef000008,0x80349382
801074ae:	00 00 ef 
  initlock(&tickslock, "time");
801074b1:	68 4b 94 10 80       	push   $0x8010944b
801074b6:	68 40 91 34 80       	push   $0x80349140
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801074bb:	66 a3 80 93 34 80    	mov    %ax,0x80349380
801074c1:	c1 e8 10             	shr    $0x10,%eax
801074c4:	66 a3 86 93 34 80    	mov    %ax,0x80349386
  initlock(&tickslock, "time");
801074ca:	e8 21 e6 ff ff       	call   80105af0 <initlock>
}
801074cf:	83 c4 10             	add    $0x10,%esp
801074d2:	c9                   	leave
801074d3:	c3                   	ret
801074d4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801074db:	00 
801074dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801074e0 <idtinit>:

void
idtinit(void)
{
801074e0:	55                   	push   %ebp
  pd[0] = size-1;
801074e1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801074e6:	89 e5                	mov    %esp,%ebp
801074e8:	83 ec 10             	sub    $0x10,%esp
801074eb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801074ef:	b8 80 91 34 80       	mov    $0x80349180,%eax
801074f4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801074f8:	c1 e8 10             	shr    $0x10,%eax
801074fb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
801074ff:	8d 45 fa             	lea    -0x6(%ebp),%eax
80107502:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80107505:	c9                   	leave
80107506:	c3                   	ret
80107507:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010750e:	00 
8010750f:	90                   	nop

80107510 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80107510:	55                   	push   %ebp
80107511:	89 e5                	mov    %esp,%ebp
80107513:	57                   	push   %edi
80107514:	56                   	push   %esi
80107515:	53                   	push   %ebx
80107516:	83 ec 1c             	sub    $0x1c,%esp
80107519:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
8010751c:	8b 43 30             	mov    0x30(%ebx),%eax
8010751f:	83 f8 40             	cmp    $0x40,%eax
80107522:	0f 84 68 01 00 00    	je     80107690 <trap+0x180>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80107528:	83 e8 20             	sub    $0x20,%eax
8010752b:	83 f8 1f             	cmp    $0x1f,%eax
8010752e:	0f 87 8c 00 00 00    	ja     801075c0 <trap+0xb0>
80107534:	ff 24 85 14 9e 10 80 	jmp    *-0x7fef61ec(,%eax,4)
8010753b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80107540:	e8 db bd ff ff       	call   80103320 <ideintr>
    lapiceoi();
80107545:	e8 a6 c4 ff ff       	call   801039f0 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010754a:	e8 21 d5 ff ff       	call   80104a70 <myproc>
8010754f:	85 c0                	test   %eax,%eax
80107551:	74 1d                	je     80107570 <trap+0x60>
80107553:	e8 18 d5 ff ff       	call   80104a70 <myproc>
80107558:	8b 50 24             	mov    0x24(%eax),%edx
8010755b:	85 d2                	test   %edx,%edx
8010755d:	74 11                	je     80107570 <trap+0x60>
8010755f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80107563:	83 e0 03             	and    $0x3,%eax
80107566:	66 83 f8 03          	cmp    $0x3,%ax
8010756a:	0f 84 e8 01 00 00    	je     80107758 <trap+0x248>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80107570:	e8 fb d4 ff ff       	call   80104a70 <myproc>
80107575:	85 c0                	test   %eax,%eax
80107577:	74 0f                	je     80107588 <trap+0x78>
80107579:	e8 f2 d4 ff ff       	call   80104a70 <myproc>
8010757e:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80107582:	0f 84 b8 00 00 00    	je     80107640 <trap+0x130>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107588:	e8 e3 d4 ff ff       	call   80104a70 <myproc>
8010758d:	85 c0                	test   %eax,%eax
8010758f:	74 1d                	je     801075ae <trap+0x9e>
80107591:	e8 da d4 ff ff       	call   80104a70 <myproc>
80107596:	8b 40 24             	mov    0x24(%eax),%eax
80107599:	85 c0                	test   %eax,%eax
8010759b:	74 11                	je     801075ae <trap+0x9e>
8010759d:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801075a1:	83 e0 03             	and    $0x3,%eax
801075a4:	66 83 f8 03          	cmp    $0x3,%ax
801075a8:	0f 84 0f 01 00 00    	je     801076bd <trap+0x1ad>
    exit();
}
801075ae:	8d 65 f4             	lea    -0xc(%ebp),%esp
801075b1:	5b                   	pop    %ebx
801075b2:	5e                   	pop    %esi
801075b3:	5f                   	pop    %edi
801075b4:	5d                   	pop    %ebp
801075b5:	c3                   	ret
801075b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801075bd:	00 
801075be:	66 90                	xchg   %ax,%ax
    if(myproc() == 0 || (tf->cs&3) == 0){
801075c0:	e8 ab d4 ff ff       	call   80104a70 <myproc>
801075c5:	8b 7b 38             	mov    0x38(%ebx),%edi
801075c8:	85 c0                	test   %eax,%eax
801075ca:	0f 84 a2 01 00 00    	je     80107772 <trap+0x262>
801075d0:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
801075d4:	0f 84 98 01 00 00    	je     80107772 <trap+0x262>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801075da:	0f 20 d1             	mov    %cr2,%ecx
801075dd:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801075e0:	e8 6b d4 ff ff       	call   80104a50 <cpuid>
801075e5:	8b 73 30             	mov    0x30(%ebx),%esi
801075e8:	89 45 dc             	mov    %eax,-0x24(%ebp)
801075eb:	8b 43 34             	mov    0x34(%ebx),%eax
801075ee:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
801075f1:	e8 7a d4 ff ff       	call   80104a70 <myproc>
801075f6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801075f9:	e8 72 d4 ff ff       	call   80104a70 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801075fe:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80107601:	8b 55 dc             	mov    -0x24(%ebp),%edx
80107604:	51                   	push   %ecx
80107605:	57                   	push   %edi
80107606:	52                   	push   %edx
80107607:	ff 75 e4             	push   -0x1c(%ebp)
8010760a:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
8010760b:	8b 75 e0             	mov    -0x20(%ebp),%esi
8010760e:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80107611:	56                   	push   %esi
80107612:	ff 70 10             	push   0x10(%eax)
80107615:	68 9c 9a 10 80       	push   $0x80109a9c
8010761a:	e8 b1 91 ff ff       	call   801007d0 <cprintf>
    myproc()->killed = 1;
8010761f:	83 c4 20             	add    $0x20,%esp
80107622:	e8 49 d4 ff ff       	call   80104a70 <myproc>
80107627:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010762e:	e8 3d d4 ff ff       	call   80104a70 <myproc>
80107633:	85 c0                	test   %eax,%eax
80107635:	0f 85 18 ff ff ff    	jne    80107553 <trap+0x43>
8010763b:	e9 30 ff ff ff       	jmp    80107570 <trap+0x60>
  if(myproc() && myproc()->state == RUNNING &&
80107640:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80107644:	0f 85 3e ff ff ff    	jne    80107588 <trap+0x78>
    yield();
8010764a:	e8 a1 da ff ff       	call   801050f0 <yield>
8010764f:	e9 34 ff ff ff       	jmp    80107588 <trap+0x78>
80107654:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80107658:	8b 7b 38             	mov    0x38(%ebx),%edi
8010765b:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
8010765f:	e8 ec d3 ff ff       	call   80104a50 <cpuid>
80107664:	57                   	push   %edi
80107665:	56                   	push   %esi
80107666:	50                   	push   %eax
80107667:	68 44 9a 10 80       	push   $0x80109a44
8010766c:	e8 5f 91 ff ff       	call   801007d0 <cprintf>
    lapiceoi();
80107671:	e8 7a c3 ff ff       	call   801039f0 <lapiceoi>
    break;
80107676:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107679:	e8 f2 d3 ff ff       	call   80104a70 <myproc>
8010767e:	85 c0                	test   %eax,%eax
80107680:	0f 85 cd fe ff ff    	jne    80107553 <trap+0x43>
80107686:	e9 e5 fe ff ff       	jmp    80107570 <trap+0x60>
8010768b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80107690:	e8 db d3 ff ff       	call   80104a70 <myproc>
80107695:	8b 70 24             	mov    0x24(%eax),%esi
80107698:	85 f6                	test   %esi,%esi
8010769a:	0f 85 c8 00 00 00    	jne    80107768 <trap+0x258>
    myproc()->tf = tf;
801076a0:	e8 cb d3 ff ff       	call   80104a70 <myproc>
801076a5:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
801076a8:	e8 03 eb ff ff       	call   801061b0 <syscall>
    if(myproc()->killed)
801076ad:	e8 be d3 ff ff       	call   80104a70 <myproc>
801076b2:	8b 48 24             	mov    0x24(%eax),%ecx
801076b5:	85 c9                	test   %ecx,%ecx
801076b7:	0f 84 f1 fe ff ff    	je     801075ae <trap+0x9e>
}
801076bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801076c0:	5b                   	pop    %ebx
801076c1:	5e                   	pop    %esi
801076c2:	5f                   	pop    %edi
801076c3:	5d                   	pop    %ebp
      exit();
801076c4:	e9 c7 d7 ff ff       	jmp    80104e90 <exit>
801076c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
801076d0:	e8 3b 02 00 00       	call   80107910 <uartintr>
    lapiceoi();
801076d5:	e8 16 c3 ff ff       	call   801039f0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801076da:	e8 91 d3 ff ff       	call   80104a70 <myproc>
801076df:	85 c0                	test   %eax,%eax
801076e1:	0f 85 6c fe ff ff    	jne    80107553 <trap+0x43>
801076e7:	e9 84 fe ff ff       	jmp    80107570 <trap+0x60>
801076ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
801076f0:	e8 bb c1 ff ff       	call   801038b0 <kbdintr>
    lapiceoi();
801076f5:	e8 f6 c2 ff ff       	call   801039f0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801076fa:	e8 71 d3 ff ff       	call   80104a70 <myproc>
801076ff:	85 c0                	test   %eax,%eax
80107701:	0f 85 4c fe ff ff    	jne    80107553 <trap+0x43>
80107707:	e9 64 fe ff ff       	jmp    80107570 <trap+0x60>
8010770c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80107710:	e8 3b d3 ff ff       	call   80104a50 <cpuid>
80107715:	85 c0                	test   %eax,%eax
80107717:	0f 85 28 fe ff ff    	jne    80107545 <trap+0x35>
      acquire(&tickslock);
8010771d:	83 ec 0c             	sub    $0xc,%esp
80107720:	68 40 91 34 80       	push   $0x80349140
80107725:	e8 96 e5 ff ff       	call   80105cc0 <acquire>
      wakeup(&ticks);
8010772a:	c7 04 24 20 91 34 80 	movl   $0x80349120,(%esp)
      ticks++;
80107731:	83 05 20 91 34 80 01 	addl   $0x1,0x80349120
      wakeup(&ticks);
80107738:	e8 c3 da ff ff       	call   80105200 <wakeup>
      release(&tickslock);
8010773d:	c7 04 24 40 91 34 80 	movl   $0x80349140,(%esp)
80107744:	e8 17 e5 ff ff       	call   80105c60 <release>
80107749:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
8010774c:	e9 f4 fd ff ff       	jmp    80107545 <trap+0x35>
80107751:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
80107758:	e8 33 d7 ff ff       	call   80104e90 <exit>
8010775d:	e9 0e fe ff ff       	jmp    80107570 <trap+0x60>
80107762:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80107768:	e8 23 d7 ff ff       	call   80104e90 <exit>
8010776d:	e9 2e ff ff ff       	jmp    801076a0 <trap+0x190>
80107772:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80107775:	e8 d6 d2 ff ff       	call   80104a50 <cpuid>
8010777a:	83 ec 0c             	sub    $0xc,%esp
8010777d:	56                   	push   %esi
8010777e:	57                   	push   %edi
8010777f:	50                   	push   %eax
80107780:	ff 73 30             	push   0x30(%ebx)
80107783:	68 68 9a 10 80       	push   $0x80109a68
80107788:	e8 43 90 ff ff       	call   801007d0 <cprintf>
      panic("trap");
8010778d:	83 c4 14             	add    $0x14,%esp
80107790:	68 50 94 10 80       	push   $0x80109450
80107795:	e8 36 8d ff ff       	call   801004d0 <panic>
8010779a:	66 90                	xchg   %ax,%ax
8010779c:	66 90                	xchg   %ax,%ax
8010779e:	66 90                	xchg   %ax,%ax

801077a0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
801077a0:	a1 80 99 34 80       	mov    0x80349980,%eax
801077a5:	85 c0                	test   %eax,%eax
801077a7:	74 17                	je     801077c0 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801077a9:	ba fd 03 00 00       	mov    $0x3fd,%edx
801077ae:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801077af:	a8 01                	test   $0x1,%al
801077b1:	74 0d                	je     801077c0 <uartgetc+0x20>
801077b3:	ba f8 03 00 00       	mov    $0x3f8,%edx
801077b8:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801077b9:	0f b6 c0             	movzbl %al,%eax
801077bc:	c3                   	ret
801077bd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801077c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801077c5:	c3                   	ret
801077c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801077cd:	00 
801077ce:	66 90                	xchg   %ax,%ax

801077d0 <uartinit>:
{
801077d0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801077d1:	31 c9                	xor    %ecx,%ecx
801077d3:	89 c8                	mov    %ecx,%eax
801077d5:	89 e5                	mov    %esp,%ebp
801077d7:	57                   	push   %edi
801077d8:	bf fa 03 00 00       	mov    $0x3fa,%edi
801077dd:	56                   	push   %esi
801077de:	89 fa                	mov    %edi,%edx
801077e0:	53                   	push   %ebx
801077e1:	83 ec 1c             	sub    $0x1c,%esp
801077e4:	ee                   	out    %al,(%dx)
801077e5:	be fb 03 00 00       	mov    $0x3fb,%esi
801077ea:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
801077ef:	89 f2                	mov    %esi,%edx
801077f1:	ee                   	out    %al,(%dx)
801077f2:	b8 0c 00 00 00       	mov    $0xc,%eax
801077f7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801077fc:	ee                   	out    %al,(%dx)
801077fd:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80107802:	89 c8                	mov    %ecx,%eax
80107804:	89 da                	mov    %ebx,%edx
80107806:	ee                   	out    %al,(%dx)
80107807:	b8 03 00 00 00       	mov    $0x3,%eax
8010780c:	89 f2                	mov    %esi,%edx
8010780e:	ee                   	out    %al,(%dx)
8010780f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80107814:	89 c8                	mov    %ecx,%eax
80107816:	ee                   	out    %al,(%dx)
80107817:	b8 01 00 00 00       	mov    $0x1,%eax
8010781c:	89 da                	mov    %ebx,%edx
8010781e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010781f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80107824:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80107825:	3c ff                	cmp    $0xff,%al
80107827:	74 78                	je     801078a1 <uartinit+0xd1>
  uart = 1;
80107829:	c7 05 80 99 34 80 01 	movl   $0x1,0x80349980
80107830:	00 00 00 
80107833:	89 fa                	mov    %edi,%edx
80107835:	ec                   	in     (%dx),%al
80107836:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010783b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
8010783c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
8010783f:	bf 55 94 10 80       	mov    $0x80109455,%edi
80107844:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
80107849:	6a 00                	push   $0x0
8010784b:	6a 04                	push   $0x4
8010784d:	e8 0e bd ff ff       	call   80103560 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
80107852:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
  ioapicenable(IRQ_COM1, 0);
80107856:	83 c4 10             	add    $0x10,%esp
80107859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(!uart)
80107860:	a1 80 99 34 80       	mov    0x80349980,%eax
80107865:	bb 80 00 00 00       	mov    $0x80,%ebx
8010786a:	85 c0                	test   %eax,%eax
8010786c:	75 14                	jne    80107882 <uartinit+0xb2>
8010786e:	eb 23                	jmp    80107893 <uartinit+0xc3>
    microdelay(10);
80107870:	83 ec 0c             	sub    $0xc,%esp
80107873:	6a 0a                	push   $0xa
80107875:	e8 96 c1 ff ff       	call   80103a10 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010787a:	83 c4 10             	add    $0x10,%esp
8010787d:	83 eb 01             	sub    $0x1,%ebx
80107880:	74 07                	je     80107889 <uartinit+0xb9>
80107882:	89 f2                	mov    %esi,%edx
80107884:	ec                   	in     (%dx),%al
80107885:	a8 20                	test   $0x20,%al
80107887:	74 e7                	je     80107870 <uartinit+0xa0>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80107889:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
8010788d:	ba f8 03 00 00       	mov    $0x3f8,%edx
80107892:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
80107893:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80107897:	83 c7 01             	add    $0x1,%edi
8010789a:	88 45 e7             	mov    %al,-0x19(%ebp)
8010789d:	84 c0                	test   %al,%al
8010789f:	75 bf                	jne    80107860 <uartinit+0x90>
}
801078a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801078a4:	5b                   	pop    %ebx
801078a5:	5e                   	pop    %esi
801078a6:	5f                   	pop    %edi
801078a7:	5d                   	pop    %ebp
801078a8:	c3                   	ret
801078a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801078b0 <uartputc>:
  if(!uart)
801078b0:	a1 80 99 34 80       	mov    0x80349980,%eax
801078b5:	85 c0                	test   %eax,%eax
801078b7:	74 47                	je     80107900 <uartputc+0x50>
{
801078b9:	55                   	push   %ebp
801078ba:	89 e5                	mov    %esp,%ebp
801078bc:	56                   	push   %esi
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801078bd:	be fd 03 00 00       	mov    $0x3fd,%esi
801078c2:	53                   	push   %ebx
801078c3:	bb 80 00 00 00       	mov    $0x80,%ebx
801078c8:	eb 18                	jmp    801078e2 <uartputc+0x32>
801078ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
801078d0:	83 ec 0c             	sub    $0xc,%esp
801078d3:	6a 0a                	push   $0xa
801078d5:	e8 36 c1 ff ff       	call   80103a10 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801078da:	83 c4 10             	add    $0x10,%esp
801078dd:	83 eb 01             	sub    $0x1,%ebx
801078e0:	74 07                	je     801078e9 <uartputc+0x39>
801078e2:	89 f2                	mov    %esi,%edx
801078e4:	ec                   	in     (%dx),%al
801078e5:	a8 20                	test   $0x20,%al
801078e7:	74 e7                	je     801078d0 <uartputc+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801078e9:	8b 45 08             	mov    0x8(%ebp),%eax
801078ec:	ba f8 03 00 00       	mov    $0x3f8,%edx
801078f1:	ee                   	out    %al,(%dx)
}
801078f2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801078f5:	5b                   	pop    %ebx
801078f6:	5e                   	pop    %esi
801078f7:	5d                   	pop    %ebp
801078f8:	c3                   	ret
801078f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107900:	c3                   	ret
80107901:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107908:	00 
80107909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107910 <uartintr>:

void
uartintr(void)
{
80107910:	55                   	push   %ebp
80107911:	89 e5                	mov    %esp,%ebp
80107913:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80107916:	68 a0 77 10 80       	push   $0x801077a0
8010791b:	e8 a0 96 ff ff       	call   80100fc0 <consoleintr>
}
80107920:	83 c4 10             	add    $0x10,%esp
80107923:	c9                   	leave
80107924:	c3                   	ret

80107925 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80107925:	6a 00                	push   $0x0
  pushl $0
80107927:	6a 00                	push   $0x0
  jmp alltraps
80107929:	e9 09 fb ff ff       	jmp    80107437 <alltraps>

8010792e <vector1>:
.globl vector1
vector1:
  pushl $0
8010792e:	6a 00                	push   $0x0
  pushl $1
80107930:	6a 01                	push   $0x1
  jmp alltraps
80107932:	e9 00 fb ff ff       	jmp    80107437 <alltraps>

80107937 <vector2>:
.globl vector2
vector2:
  pushl $0
80107937:	6a 00                	push   $0x0
  pushl $2
80107939:	6a 02                	push   $0x2
  jmp alltraps
8010793b:	e9 f7 fa ff ff       	jmp    80107437 <alltraps>

80107940 <vector3>:
.globl vector3
vector3:
  pushl $0
80107940:	6a 00                	push   $0x0
  pushl $3
80107942:	6a 03                	push   $0x3
  jmp alltraps
80107944:	e9 ee fa ff ff       	jmp    80107437 <alltraps>

80107949 <vector4>:
.globl vector4
vector4:
  pushl $0
80107949:	6a 00                	push   $0x0
  pushl $4
8010794b:	6a 04                	push   $0x4
  jmp alltraps
8010794d:	e9 e5 fa ff ff       	jmp    80107437 <alltraps>

80107952 <vector5>:
.globl vector5
vector5:
  pushl $0
80107952:	6a 00                	push   $0x0
  pushl $5
80107954:	6a 05                	push   $0x5
  jmp alltraps
80107956:	e9 dc fa ff ff       	jmp    80107437 <alltraps>

8010795b <vector6>:
.globl vector6
vector6:
  pushl $0
8010795b:	6a 00                	push   $0x0
  pushl $6
8010795d:	6a 06                	push   $0x6
  jmp alltraps
8010795f:	e9 d3 fa ff ff       	jmp    80107437 <alltraps>

80107964 <vector7>:
.globl vector7
vector7:
  pushl $0
80107964:	6a 00                	push   $0x0
  pushl $7
80107966:	6a 07                	push   $0x7
  jmp alltraps
80107968:	e9 ca fa ff ff       	jmp    80107437 <alltraps>

8010796d <vector8>:
.globl vector8
vector8:
  pushl $8
8010796d:	6a 08                	push   $0x8
  jmp alltraps
8010796f:	e9 c3 fa ff ff       	jmp    80107437 <alltraps>

80107974 <vector9>:
.globl vector9
vector9:
  pushl $0
80107974:	6a 00                	push   $0x0
  pushl $9
80107976:	6a 09                	push   $0x9
  jmp alltraps
80107978:	e9 ba fa ff ff       	jmp    80107437 <alltraps>

8010797d <vector10>:
.globl vector10
vector10:
  pushl $10
8010797d:	6a 0a                	push   $0xa
  jmp alltraps
8010797f:	e9 b3 fa ff ff       	jmp    80107437 <alltraps>

80107984 <vector11>:
.globl vector11
vector11:
  pushl $11
80107984:	6a 0b                	push   $0xb
  jmp alltraps
80107986:	e9 ac fa ff ff       	jmp    80107437 <alltraps>

8010798b <vector12>:
.globl vector12
vector12:
  pushl $12
8010798b:	6a 0c                	push   $0xc
  jmp alltraps
8010798d:	e9 a5 fa ff ff       	jmp    80107437 <alltraps>

80107992 <vector13>:
.globl vector13
vector13:
  pushl $13
80107992:	6a 0d                	push   $0xd
  jmp alltraps
80107994:	e9 9e fa ff ff       	jmp    80107437 <alltraps>

80107999 <vector14>:
.globl vector14
vector14:
  pushl $14
80107999:	6a 0e                	push   $0xe
  jmp alltraps
8010799b:	e9 97 fa ff ff       	jmp    80107437 <alltraps>

801079a0 <vector15>:
.globl vector15
vector15:
  pushl $0
801079a0:	6a 00                	push   $0x0
  pushl $15
801079a2:	6a 0f                	push   $0xf
  jmp alltraps
801079a4:	e9 8e fa ff ff       	jmp    80107437 <alltraps>

801079a9 <vector16>:
.globl vector16
vector16:
  pushl $0
801079a9:	6a 00                	push   $0x0
  pushl $16
801079ab:	6a 10                	push   $0x10
  jmp alltraps
801079ad:	e9 85 fa ff ff       	jmp    80107437 <alltraps>

801079b2 <vector17>:
.globl vector17
vector17:
  pushl $17
801079b2:	6a 11                	push   $0x11
  jmp alltraps
801079b4:	e9 7e fa ff ff       	jmp    80107437 <alltraps>

801079b9 <vector18>:
.globl vector18
vector18:
  pushl $0
801079b9:	6a 00                	push   $0x0
  pushl $18
801079bb:	6a 12                	push   $0x12
  jmp alltraps
801079bd:	e9 75 fa ff ff       	jmp    80107437 <alltraps>

801079c2 <vector19>:
.globl vector19
vector19:
  pushl $0
801079c2:	6a 00                	push   $0x0
  pushl $19
801079c4:	6a 13                	push   $0x13
  jmp alltraps
801079c6:	e9 6c fa ff ff       	jmp    80107437 <alltraps>

801079cb <vector20>:
.globl vector20
vector20:
  pushl $0
801079cb:	6a 00                	push   $0x0
  pushl $20
801079cd:	6a 14                	push   $0x14
  jmp alltraps
801079cf:	e9 63 fa ff ff       	jmp    80107437 <alltraps>

801079d4 <vector21>:
.globl vector21
vector21:
  pushl $0
801079d4:	6a 00                	push   $0x0
  pushl $21
801079d6:	6a 15                	push   $0x15
  jmp alltraps
801079d8:	e9 5a fa ff ff       	jmp    80107437 <alltraps>

801079dd <vector22>:
.globl vector22
vector22:
  pushl $0
801079dd:	6a 00                	push   $0x0
  pushl $22
801079df:	6a 16                	push   $0x16
  jmp alltraps
801079e1:	e9 51 fa ff ff       	jmp    80107437 <alltraps>

801079e6 <vector23>:
.globl vector23
vector23:
  pushl $0
801079e6:	6a 00                	push   $0x0
  pushl $23
801079e8:	6a 17                	push   $0x17
  jmp alltraps
801079ea:	e9 48 fa ff ff       	jmp    80107437 <alltraps>

801079ef <vector24>:
.globl vector24
vector24:
  pushl $0
801079ef:	6a 00                	push   $0x0
  pushl $24
801079f1:	6a 18                	push   $0x18
  jmp alltraps
801079f3:	e9 3f fa ff ff       	jmp    80107437 <alltraps>

801079f8 <vector25>:
.globl vector25
vector25:
  pushl $0
801079f8:	6a 00                	push   $0x0
  pushl $25
801079fa:	6a 19                	push   $0x19
  jmp alltraps
801079fc:	e9 36 fa ff ff       	jmp    80107437 <alltraps>

80107a01 <vector26>:
.globl vector26
vector26:
  pushl $0
80107a01:	6a 00                	push   $0x0
  pushl $26
80107a03:	6a 1a                	push   $0x1a
  jmp alltraps
80107a05:	e9 2d fa ff ff       	jmp    80107437 <alltraps>

80107a0a <vector27>:
.globl vector27
vector27:
  pushl $0
80107a0a:	6a 00                	push   $0x0
  pushl $27
80107a0c:	6a 1b                	push   $0x1b
  jmp alltraps
80107a0e:	e9 24 fa ff ff       	jmp    80107437 <alltraps>

80107a13 <vector28>:
.globl vector28
vector28:
  pushl $0
80107a13:	6a 00                	push   $0x0
  pushl $28
80107a15:	6a 1c                	push   $0x1c
  jmp alltraps
80107a17:	e9 1b fa ff ff       	jmp    80107437 <alltraps>

80107a1c <vector29>:
.globl vector29
vector29:
  pushl $0
80107a1c:	6a 00                	push   $0x0
  pushl $29
80107a1e:	6a 1d                	push   $0x1d
  jmp alltraps
80107a20:	e9 12 fa ff ff       	jmp    80107437 <alltraps>

80107a25 <vector30>:
.globl vector30
vector30:
  pushl $0
80107a25:	6a 00                	push   $0x0
  pushl $30
80107a27:	6a 1e                	push   $0x1e
  jmp alltraps
80107a29:	e9 09 fa ff ff       	jmp    80107437 <alltraps>

80107a2e <vector31>:
.globl vector31
vector31:
  pushl $0
80107a2e:	6a 00                	push   $0x0
  pushl $31
80107a30:	6a 1f                	push   $0x1f
  jmp alltraps
80107a32:	e9 00 fa ff ff       	jmp    80107437 <alltraps>

80107a37 <vector32>:
.globl vector32
vector32:
  pushl $0
80107a37:	6a 00                	push   $0x0
  pushl $32
80107a39:	6a 20                	push   $0x20
  jmp alltraps
80107a3b:	e9 f7 f9 ff ff       	jmp    80107437 <alltraps>

80107a40 <vector33>:
.globl vector33
vector33:
  pushl $0
80107a40:	6a 00                	push   $0x0
  pushl $33
80107a42:	6a 21                	push   $0x21
  jmp alltraps
80107a44:	e9 ee f9 ff ff       	jmp    80107437 <alltraps>

80107a49 <vector34>:
.globl vector34
vector34:
  pushl $0
80107a49:	6a 00                	push   $0x0
  pushl $34
80107a4b:	6a 22                	push   $0x22
  jmp alltraps
80107a4d:	e9 e5 f9 ff ff       	jmp    80107437 <alltraps>

80107a52 <vector35>:
.globl vector35
vector35:
  pushl $0
80107a52:	6a 00                	push   $0x0
  pushl $35
80107a54:	6a 23                	push   $0x23
  jmp alltraps
80107a56:	e9 dc f9 ff ff       	jmp    80107437 <alltraps>

80107a5b <vector36>:
.globl vector36
vector36:
  pushl $0
80107a5b:	6a 00                	push   $0x0
  pushl $36
80107a5d:	6a 24                	push   $0x24
  jmp alltraps
80107a5f:	e9 d3 f9 ff ff       	jmp    80107437 <alltraps>

80107a64 <vector37>:
.globl vector37
vector37:
  pushl $0
80107a64:	6a 00                	push   $0x0
  pushl $37
80107a66:	6a 25                	push   $0x25
  jmp alltraps
80107a68:	e9 ca f9 ff ff       	jmp    80107437 <alltraps>

80107a6d <vector38>:
.globl vector38
vector38:
  pushl $0
80107a6d:	6a 00                	push   $0x0
  pushl $38
80107a6f:	6a 26                	push   $0x26
  jmp alltraps
80107a71:	e9 c1 f9 ff ff       	jmp    80107437 <alltraps>

80107a76 <vector39>:
.globl vector39
vector39:
  pushl $0
80107a76:	6a 00                	push   $0x0
  pushl $39
80107a78:	6a 27                	push   $0x27
  jmp alltraps
80107a7a:	e9 b8 f9 ff ff       	jmp    80107437 <alltraps>

80107a7f <vector40>:
.globl vector40
vector40:
  pushl $0
80107a7f:	6a 00                	push   $0x0
  pushl $40
80107a81:	6a 28                	push   $0x28
  jmp alltraps
80107a83:	e9 af f9 ff ff       	jmp    80107437 <alltraps>

80107a88 <vector41>:
.globl vector41
vector41:
  pushl $0
80107a88:	6a 00                	push   $0x0
  pushl $41
80107a8a:	6a 29                	push   $0x29
  jmp alltraps
80107a8c:	e9 a6 f9 ff ff       	jmp    80107437 <alltraps>

80107a91 <vector42>:
.globl vector42
vector42:
  pushl $0
80107a91:	6a 00                	push   $0x0
  pushl $42
80107a93:	6a 2a                	push   $0x2a
  jmp alltraps
80107a95:	e9 9d f9 ff ff       	jmp    80107437 <alltraps>

80107a9a <vector43>:
.globl vector43
vector43:
  pushl $0
80107a9a:	6a 00                	push   $0x0
  pushl $43
80107a9c:	6a 2b                	push   $0x2b
  jmp alltraps
80107a9e:	e9 94 f9 ff ff       	jmp    80107437 <alltraps>

80107aa3 <vector44>:
.globl vector44
vector44:
  pushl $0
80107aa3:	6a 00                	push   $0x0
  pushl $44
80107aa5:	6a 2c                	push   $0x2c
  jmp alltraps
80107aa7:	e9 8b f9 ff ff       	jmp    80107437 <alltraps>

80107aac <vector45>:
.globl vector45
vector45:
  pushl $0
80107aac:	6a 00                	push   $0x0
  pushl $45
80107aae:	6a 2d                	push   $0x2d
  jmp alltraps
80107ab0:	e9 82 f9 ff ff       	jmp    80107437 <alltraps>

80107ab5 <vector46>:
.globl vector46
vector46:
  pushl $0
80107ab5:	6a 00                	push   $0x0
  pushl $46
80107ab7:	6a 2e                	push   $0x2e
  jmp alltraps
80107ab9:	e9 79 f9 ff ff       	jmp    80107437 <alltraps>

80107abe <vector47>:
.globl vector47
vector47:
  pushl $0
80107abe:	6a 00                	push   $0x0
  pushl $47
80107ac0:	6a 2f                	push   $0x2f
  jmp alltraps
80107ac2:	e9 70 f9 ff ff       	jmp    80107437 <alltraps>

80107ac7 <vector48>:
.globl vector48
vector48:
  pushl $0
80107ac7:	6a 00                	push   $0x0
  pushl $48
80107ac9:	6a 30                	push   $0x30
  jmp alltraps
80107acb:	e9 67 f9 ff ff       	jmp    80107437 <alltraps>

80107ad0 <vector49>:
.globl vector49
vector49:
  pushl $0
80107ad0:	6a 00                	push   $0x0
  pushl $49
80107ad2:	6a 31                	push   $0x31
  jmp alltraps
80107ad4:	e9 5e f9 ff ff       	jmp    80107437 <alltraps>

80107ad9 <vector50>:
.globl vector50
vector50:
  pushl $0
80107ad9:	6a 00                	push   $0x0
  pushl $50
80107adb:	6a 32                	push   $0x32
  jmp alltraps
80107add:	e9 55 f9 ff ff       	jmp    80107437 <alltraps>

80107ae2 <vector51>:
.globl vector51
vector51:
  pushl $0
80107ae2:	6a 00                	push   $0x0
  pushl $51
80107ae4:	6a 33                	push   $0x33
  jmp alltraps
80107ae6:	e9 4c f9 ff ff       	jmp    80107437 <alltraps>

80107aeb <vector52>:
.globl vector52
vector52:
  pushl $0
80107aeb:	6a 00                	push   $0x0
  pushl $52
80107aed:	6a 34                	push   $0x34
  jmp alltraps
80107aef:	e9 43 f9 ff ff       	jmp    80107437 <alltraps>

80107af4 <vector53>:
.globl vector53
vector53:
  pushl $0
80107af4:	6a 00                	push   $0x0
  pushl $53
80107af6:	6a 35                	push   $0x35
  jmp alltraps
80107af8:	e9 3a f9 ff ff       	jmp    80107437 <alltraps>

80107afd <vector54>:
.globl vector54
vector54:
  pushl $0
80107afd:	6a 00                	push   $0x0
  pushl $54
80107aff:	6a 36                	push   $0x36
  jmp alltraps
80107b01:	e9 31 f9 ff ff       	jmp    80107437 <alltraps>

80107b06 <vector55>:
.globl vector55
vector55:
  pushl $0
80107b06:	6a 00                	push   $0x0
  pushl $55
80107b08:	6a 37                	push   $0x37
  jmp alltraps
80107b0a:	e9 28 f9 ff ff       	jmp    80107437 <alltraps>

80107b0f <vector56>:
.globl vector56
vector56:
  pushl $0
80107b0f:	6a 00                	push   $0x0
  pushl $56
80107b11:	6a 38                	push   $0x38
  jmp alltraps
80107b13:	e9 1f f9 ff ff       	jmp    80107437 <alltraps>

80107b18 <vector57>:
.globl vector57
vector57:
  pushl $0
80107b18:	6a 00                	push   $0x0
  pushl $57
80107b1a:	6a 39                	push   $0x39
  jmp alltraps
80107b1c:	e9 16 f9 ff ff       	jmp    80107437 <alltraps>

80107b21 <vector58>:
.globl vector58
vector58:
  pushl $0
80107b21:	6a 00                	push   $0x0
  pushl $58
80107b23:	6a 3a                	push   $0x3a
  jmp alltraps
80107b25:	e9 0d f9 ff ff       	jmp    80107437 <alltraps>

80107b2a <vector59>:
.globl vector59
vector59:
  pushl $0
80107b2a:	6a 00                	push   $0x0
  pushl $59
80107b2c:	6a 3b                	push   $0x3b
  jmp alltraps
80107b2e:	e9 04 f9 ff ff       	jmp    80107437 <alltraps>

80107b33 <vector60>:
.globl vector60
vector60:
  pushl $0
80107b33:	6a 00                	push   $0x0
  pushl $60
80107b35:	6a 3c                	push   $0x3c
  jmp alltraps
80107b37:	e9 fb f8 ff ff       	jmp    80107437 <alltraps>

80107b3c <vector61>:
.globl vector61
vector61:
  pushl $0
80107b3c:	6a 00                	push   $0x0
  pushl $61
80107b3e:	6a 3d                	push   $0x3d
  jmp alltraps
80107b40:	e9 f2 f8 ff ff       	jmp    80107437 <alltraps>

80107b45 <vector62>:
.globl vector62
vector62:
  pushl $0
80107b45:	6a 00                	push   $0x0
  pushl $62
80107b47:	6a 3e                	push   $0x3e
  jmp alltraps
80107b49:	e9 e9 f8 ff ff       	jmp    80107437 <alltraps>

80107b4e <vector63>:
.globl vector63
vector63:
  pushl $0
80107b4e:	6a 00                	push   $0x0
  pushl $63
80107b50:	6a 3f                	push   $0x3f
  jmp alltraps
80107b52:	e9 e0 f8 ff ff       	jmp    80107437 <alltraps>

80107b57 <vector64>:
.globl vector64
vector64:
  pushl $0
80107b57:	6a 00                	push   $0x0
  pushl $64
80107b59:	6a 40                	push   $0x40
  jmp alltraps
80107b5b:	e9 d7 f8 ff ff       	jmp    80107437 <alltraps>

80107b60 <vector65>:
.globl vector65
vector65:
  pushl $0
80107b60:	6a 00                	push   $0x0
  pushl $65
80107b62:	6a 41                	push   $0x41
  jmp alltraps
80107b64:	e9 ce f8 ff ff       	jmp    80107437 <alltraps>

80107b69 <vector66>:
.globl vector66
vector66:
  pushl $0
80107b69:	6a 00                	push   $0x0
  pushl $66
80107b6b:	6a 42                	push   $0x42
  jmp alltraps
80107b6d:	e9 c5 f8 ff ff       	jmp    80107437 <alltraps>

80107b72 <vector67>:
.globl vector67
vector67:
  pushl $0
80107b72:	6a 00                	push   $0x0
  pushl $67
80107b74:	6a 43                	push   $0x43
  jmp alltraps
80107b76:	e9 bc f8 ff ff       	jmp    80107437 <alltraps>

80107b7b <vector68>:
.globl vector68
vector68:
  pushl $0
80107b7b:	6a 00                	push   $0x0
  pushl $68
80107b7d:	6a 44                	push   $0x44
  jmp alltraps
80107b7f:	e9 b3 f8 ff ff       	jmp    80107437 <alltraps>

80107b84 <vector69>:
.globl vector69
vector69:
  pushl $0
80107b84:	6a 00                	push   $0x0
  pushl $69
80107b86:	6a 45                	push   $0x45
  jmp alltraps
80107b88:	e9 aa f8 ff ff       	jmp    80107437 <alltraps>

80107b8d <vector70>:
.globl vector70
vector70:
  pushl $0
80107b8d:	6a 00                	push   $0x0
  pushl $70
80107b8f:	6a 46                	push   $0x46
  jmp alltraps
80107b91:	e9 a1 f8 ff ff       	jmp    80107437 <alltraps>

80107b96 <vector71>:
.globl vector71
vector71:
  pushl $0
80107b96:	6a 00                	push   $0x0
  pushl $71
80107b98:	6a 47                	push   $0x47
  jmp alltraps
80107b9a:	e9 98 f8 ff ff       	jmp    80107437 <alltraps>

80107b9f <vector72>:
.globl vector72
vector72:
  pushl $0
80107b9f:	6a 00                	push   $0x0
  pushl $72
80107ba1:	6a 48                	push   $0x48
  jmp alltraps
80107ba3:	e9 8f f8 ff ff       	jmp    80107437 <alltraps>

80107ba8 <vector73>:
.globl vector73
vector73:
  pushl $0
80107ba8:	6a 00                	push   $0x0
  pushl $73
80107baa:	6a 49                	push   $0x49
  jmp alltraps
80107bac:	e9 86 f8 ff ff       	jmp    80107437 <alltraps>

80107bb1 <vector74>:
.globl vector74
vector74:
  pushl $0
80107bb1:	6a 00                	push   $0x0
  pushl $74
80107bb3:	6a 4a                	push   $0x4a
  jmp alltraps
80107bb5:	e9 7d f8 ff ff       	jmp    80107437 <alltraps>

80107bba <vector75>:
.globl vector75
vector75:
  pushl $0
80107bba:	6a 00                	push   $0x0
  pushl $75
80107bbc:	6a 4b                	push   $0x4b
  jmp alltraps
80107bbe:	e9 74 f8 ff ff       	jmp    80107437 <alltraps>

80107bc3 <vector76>:
.globl vector76
vector76:
  pushl $0
80107bc3:	6a 00                	push   $0x0
  pushl $76
80107bc5:	6a 4c                	push   $0x4c
  jmp alltraps
80107bc7:	e9 6b f8 ff ff       	jmp    80107437 <alltraps>

80107bcc <vector77>:
.globl vector77
vector77:
  pushl $0
80107bcc:	6a 00                	push   $0x0
  pushl $77
80107bce:	6a 4d                	push   $0x4d
  jmp alltraps
80107bd0:	e9 62 f8 ff ff       	jmp    80107437 <alltraps>

80107bd5 <vector78>:
.globl vector78
vector78:
  pushl $0
80107bd5:	6a 00                	push   $0x0
  pushl $78
80107bd7:	6a 4e                	push   $0x4e
  jmp alltraps
80107bd9:	e9 59 f8 ff ff       	jmp    80107437 <alltraps>

80107bde <vector79>:
.globl vector79
vector79:
  pushl $0
80107bde:	6a 00                	push   $0x0
  pushl $79
80107be0:	6a 4f                	push   $0x4f
  jmp alltraps
80107be2:	e9 50 f8 ff ff       	jmp    80107437 <alltraps>

80107be7 <vector80>:
.globl vector80
vector80:
  pushl $0
80107be7:	6a 00                	push   $0x0
  pushl $80
80107be9:	6a 50                	push   $0x50
  jmp alltraps
80107beb:	e9 47 f8 ff ff       	jmp    80107437 <alltraps>

80107bf0 <vector81>:
.globl vector81
vector81:
  pushl $0
80107bf0:	6a 00                	push   $0x0
  pushl $81
80107bf2:	6a 51                	push   $0x51
  jmp alltraps
80107bf4:	e9 3e f8 ff ff       	jmp    80107437 <alltraps>

80107bf9 <vector82>:
.globl vector82
vector82:
  pushl $0
80107bf9:	6a 00                	push   $0x0
  pushl $82
80107bfb:	6a 52                	push   $0x52
  jmp alltraps
80107bfd:	e9 35 f8 ff ff       	jmp    80107437 <alltraps>

80107c02 <vector83>:
.globl vector83
vector83:
  pushl $0
80107c02:	6a 00                	push   $0x0
  pushl $83
80107c04:	6a 53                	push   $0x53
  jmp alltraps
80107c06:	e9 2c f8 ff ff       	jmp    80107437 <alltraps>

80107c0b <vector84>:
.globl vector84
vector84:
  pushl $0
80107c0b:	6a 00                	push   $0x0
  pushl $84
80107c0d:	6a 54                	push   $0x54
  jmp alltraps
80107c0f:	e9 23 f8 ff ff       	jmp    80107437 <alltraps>

80107c14 <vector85>:
.globl vector85
vector85:
  pushl $0
80107c14:	6a 00                	push   $0x0
  pushl $85
80107c16:	6a 55                	push   $0x55
  jmp alltraps
80107c18:	e9 1a f8 ff ff       	jmp    80107437 <alltraps>

80107c1d <vector86>:
.globl vector86
vector86:
  pushl $0
80107c1d:	6a 00                	push   $0x0
  pushl $86
80107c1f:	6a 56                	push   $0x56
  jmp alltraps
80107c21:	e9 11 f8 ff ff       	jmp    80107437 <alltraps>

80107c26 <vector87>:
.globl vector87
vector87:
  pushl $0
80107c26:	6a 00                	push   $0x0
  pushl $87
80107c28:	6a 57                	push   $0x57
  jmp alltraps
80107c2a:	e9 08 f8 ff ff       	jmp    80107437 <alltraps>

80107c2f <vector88>:
.globl vector88
vector88:
  pushl $0
80107c2f:	6a 00                	push   $0x0
  pushl $88
80107c31:	6a 58                	push   $0x58
  jmp alltraps
80107c33:	e9 ff f7 ff ff       	jmp    80107437 <alltraps>

80107c38 <vector89>:
.globl vector89
vector89:
  pushl $0
80107c38:	6a 00                	push   $0x0
  pushl $89
80107c3a:	6a 59                	push   $0x59
  jmp alltraps
80107c3c:	e9 f6 f7 ff ff       	jmp    80107437 <alltraps>

80107c41 <vector90>:
.globl vector90
vector90:
  pushl $0
80107c41:	6a 00                	push   $0x0
  pushl $90
80107c43:	6a 5a                	push   $0x5a
  jmp alltraps
80107c45:	e9 ed f7 ff ff       	jmp    80107437 <alltraps>

80107c4a <vector91>:
.globl vector91
vector91:
  pushl $0
80107c4a:	6a 00                	push   $0x0
  pushl $91
80107c4c:	6a 5b                	push   $0x5b
  jmp alltraps
80107c4e:	e9 e4 f7 ff ff       	jmp    80107437 <alltraps>

80107c53 <vector92>:
.globl vector92
vector92:
  pushl $0
80107c53:	6a 00                	push   $0x0
  pushl $92
80107c55:	6a 5c                	push   $0x5c
  jmp alltraps
80107c57:	e9 db f7 ff ff       	jmp    80107437 <alltraps>

80107c5c <vector93>:
.globl vector93
vector93:
  pushl $0
80107c5c:	6a 00                	push   $0x0
  pushl $93
80107c5e:	6a 5d                	push   $0x5d
  jmp alltraps
80107c60:	e9 d2 f7 ff ff       	jmp    80107437 <alltraps>

80107c65 <vector94>:
.globl vector94
vector94:
  pushl $0
80107c65:	6a 00                	push   $0x0
  pushl $94
80107c67:	6a 5e                	push   $0x5e
  jmp alltraps
80107c69:	e9 c9 f7 ff ff       	jmp    80107437 <alltraps>

80107c6e <vector95>:
.globl vector95
vector95:
  pushl $0
80107c6e:	6a 00                	push   $0x0
  pushl $95
80107c70:	6a 5f                	push   $0x5f
  jmp alltraps
80107c72:	e9 c0 f7 ff ff       	jmp    80107437 <alltraps>

80107c77 <vector96>:
.globl vector96
vector96:
  pushl $0
80107c77:	6a 00                	push   $0x0
  pushl $96
80107c79:	6a 60                	push   $0x60
  jmp alltraps
80107c7b:	e9 b7 f7 ff ff       	jmp    80107437 <alltraps>

80107c80 <vector97>:
.globl vector97
vector97:
  pushl $0
80107c80:	6a 00                	push   $0x0
  pushl $97
80107c82:	6a 61                	push   $0x61
  jmp alltraps
80107c84:	e9 ae f7 ff ff       	jmp    80107437 <alltraps>

80107c89 <vector98>:
.globl vector98
vector98:
  pushl $0
80107c89:	6a 00                	push   $0x0
  pushl $98
80107c8b:	6a 62                	push   $0x62
  jmp alltraps
80107c8d:	e9 a5 f7 ff ff       	jmp    80107437 <alltraps>

80107c92 <vector99>:
.globl vector99
vector99:
  pushl $0
80107c92:	6a 00                	push   $0x0
  pushl $99
80107c94:	6a 63                	push   $0x63
  jmp alltraps
80107c96:	e9 9c f7 ff ff       	jmp    80107437 <alltraps>

80107c9b <vector100>:
.globl vector100
vector100:
  pushl $0
80107c9b:	6a 00                	push   $0x0
  pushl $100
80107c9d:	6a 64                	push   $0x64
  jmp alltraps
80107c9f:	e9 93 f7 ff ff       	jmp    80107437 <alltraps>

80107ca4 <vector101>:
.globl vector101
vector101:
  pushl $0
80107ca4:	6a 00                	push   $0x0
  pushl $101
80107ca6:	6a 65                	push   $0x65
  jmp alltraps
80107ca8:	e9 8a f7 ff ff       	jmp    80107437 <alltraps>

80107cad <vector102>:
.globl vector102
vector102:
  pushl $0
80107cad:	6a 00                	push   $0x0
  pushl $102
80107caf:	6a 66                	push   $0x66
  jmp alltraps
80107cb1:	e9 81 f7 ff ff       	jmp    80107437 <alltraps>

80107cb6 <vector103>:
.globl vector103
vector103:
  pushl $0
80107cb6:	6a 00                	push   $0x0
  pushl $103
80107cb8:	6a 67                	push   $0x67
  jmp alltraps
80107cba:	e9 78 f7 ff ff       	jmp    80107437 <alltraps>

80107cbf <vector104>:
.globl vector104
vector104:
  pushl $0
80107cbf:	6a 00                	push   $0x0
  pushl $104
80107cc1:	6a 68                	push   $0x68
  jmp alltraps
80107cc3:	e9 6f f7 ff ff       	jmp    80107437 <alltraps>

80107cc8 <vector105>:
.globl vector105
vector105:
  pushl $0
80107cc8:	6a 00                	push   $0x0
  pushl $105
80107cca:	6a 69                	push   $0x69
  jmp alltraps
80107ccc:	e9 66 f7 ff ff       	jmp    80107437 <alltraps>

80107cd1 <vector106>:
.globl vector106
vector106:
  pushl $0
80107cd1:	6a 00                	push   $0x0
  pushl $106
80107cd3:	6a 6a                	push   $0x6a
  jmp alltraps
80107cd5:	e9 5d f7 ff ff       	jmp    80107437 <alltraps>

80107cda <vector107>:
.globl vector107
vector107:
  pushl $0
80107cda:	6a 00                	push   $0x0
  pushl $107
80107cdc:	6a 6b                	push   $0x6b
  jmp alltraps
80107cde:	e9 54 f7 ff ff       	jmp    80107437 <alltraps>

80107ce3 <vector108>:
.globl vector108
vector108:
  pushl $0
80107ce3:	6a 00                	push   $0x0
  pushl $108
80107ce5:	6a 6c                	push   $0x6c
  jmp alltraps
80107ce7:	e9 4b f7 ff ff       	jmp    80107437 <alltraps>

80107cec <vector109>:
.globl vector109
vector109:
  pushl $0
80107cec:	6a 00                	push   $0x0
  pushl $109
80107cee:	6a 6d                	push   $0x6d
  jmp alltraps
80107cf0:	e9 42 f7 ff ff       	jmp    80107437 <alltraps>

80107cf5 <vector110>:
.globl vector110
vector110:
  pushl $0
80107cf5:	6a 00                	push   $0x0
  pushl $110
80107cf7:	6a 6e                	push   $0x6e
  jmp alltraps
80107cf9:	e9 39 f7 ff ff       	jmp    80107437 <alltraps>

80107cfe <vector111>:
.globl vector111
vector111:
  pushl $0
80107cfe:	6a 00                	push   $0x0
  pushl $111
80107d00:	6a 6f                	push   $0x6f
  jmp alltraps
80107d02:	e9 30 f7 ff ff       	jmp    80107437 <alltraps>

80107d07 <vector112>:
.globl vector112
vector112:
  pushl $0
80107d07:	6a 00                	push   $0x0
  pushl $112
80107d09:	6a 70                	push   $0x70
  jmp alltraps
80107d0b:	e9 27 f7 ff ff       	jmp    80107437 <alltraps>

80107d10 <vector113>:
.globl vector113
vector113:
  pushl $0
80107d10:	6a 00                	push   $0x0
  pushl $113
80107d12:	6a 71                	push   $0x71
  jmp alltraps
80107d14:	e9 1e f7 ff ff       	jmp    80107437 <alltraps>

80107d19 <vector114>:
.globl vector114
vector114:
  pushl $0
80107d19:	6a 00                	push   $0x0
  pushl $114
80107d1b:	6a 72                	push   $0x72
  jmp alltraps
80107d1d:	e9 15 f7 ff ff       	jmp    80107437 <alltraps>

80107d22 <vector115>:
.globl vector115
vector115:
  pushl $0
80107d22:	6a 00                	push   $0x0
  pushl $115
80107d24:	6a 73                	push   $0x73
  jmp alltraps
80107d26:	e9 0c f7 ff ff       	jmp    80107437 <alltraps>

80107d2b <vector116>:
.globl vector116
vector116:
  pushl $0
80107d2b:	6a 00                	push   $0x0
  pushl $116
80107d2d:	6a 74                	push   $0x74
  jmp alltraps
80107d2f:	e9 03 f7 ff ff       	jmp    80107437 <alltraps>

80107d34 <vector117>:
.globl vector117
vector117:
  pushl $0
80107d34:	6a 00                	push   $0x0
  pushl $117
80107d36:	6a 75                	push   $0x75
  jmp alltraps
80107d38:	e9 fa f6 ff ff       	jmp    80107437 <alltraps>

80107d3d <vector118>:
.globl vector118
vector118:
  pushl $0
80107d3d:	6a 00                	push   $0x0
  pushl $118
80107d3f:	6a 76                	push   $0x76
  jmp alltraps
80107d41:	e9 f1 f6 ff ff       	jmp    80107437 <alltraps>

80107d46 <vector119>:
.globl vector119
vector119:
  pushl $0
80107d46:	6a 00                	push   $0x0
  pushl $119
80107d48:	6a 77                	push   $0x77
  jmp alltraps
80107d4a:	e9 e8 f6 ff ff       	jmp    80107437 <alltraps>

80107d4f <vector120>:
.globl vector120
vector120:
  pushl $0
80107d4f:	6a 00                	push   $0x0
  pushl $120
80107d51:	6a 78                	push   $0x78
  jmp alltraps
80107d53:	e9 df f6 ff ff       	jmp    80107437 <alltraps>

80107d58 <vector121>:
.globl vector121
vector121:
  pushl $0
80107d58:	6a 00                	push   $0x0
  pushl $121
80107d5a:	6a 79                	push   $0x79
  jmp alltraps
80107d5c:	e9 d6 f6 ff ff       	jmp    80107437 <alltraps>

80107d61 <vector122>:
.globl vector122
vector122:
  pushl $0
80107d61:	6a 00                	push   $0x0
  pushl $122
80107d63:	6a 7a                	push   $0x7a
  jmp alltraps
80107d65:	e9 cd f6 ff ff       	jmp    80107437 <alltraps>

80107d6a <vector123>:
.globl vector123
vector123:
  pushl $0
80107d6a:	6a 00                	push   $0x0
  pushl $123
80107d6c:	6a 7b                	push   $0x7b
  jmp alltraps
80107d6e:	e9 c4 f6 ff ff       	jmp    80107437 <alltraps>

80107d73 <vector124>:
.globl vector124
vector124:
  pushl $0
80107d73:	6a 00                	push   $0x0
  pushl $124
80107d75:	6a 7c                	push   $0x7c
  jmp alltraps
80107d77:	e9 bb f6 ff ff       	jmp    80107437 <alltraps>

80107d7c <vector125>:
.globl vector125
vector125:
  pushl $0
80107d7c:	6a 00                	push   $0x0
  pushl $125
80107d7e:	6a 7d                	push   $0x7d
  jmp alltraps
80107d80:	e9 b2 f6 ff ff       	jmp    80107437 <alltraps>

80107d85 <vector126>:
.globl vector126
vector126:
  pushl $0
80107d85:	6a 00                	push   $0x0
  pushl $126
80107d87:	6a 7e                	push   $0x7e
  jmp alltraps
80107d89:	e9 a9 f6 ff ff       	jmp    80107437 <alltraps>

80107d8e <vector127>:
.globl vector127
vector127:
  pushl $0
80107d8e:	6a 00                	push   $0x0
  pushl $127
80107d90:	6a 7f                	push   $0x7f
  jmp alltraps
80107d92:	e9 a0 f6 ff ff       	jmp    80107437 <alltraps>

80107d97 <vector128>:
.globl vector128
vector128:
  pushl $0
80107d97:	6a 00                	push   $0x0
  pushl $128
80107d99:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80107d9e:	e9 94 f6 ff ff       	jmp    80107437 <alltraps>

80107da3 <vector129>:
.globl vector129
vector129:
  pushl $0
80107da3:	6a 00                	push   $0x0
  pushl $129
80107da5:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80107daa:	e9 88 f6 ff ff       	jmp    80107437 <alltraps>

80107daf <vector130>:
.globl vector130
vector130:
  pushl $0
80107daf:	6a 00                	push   $0x0
  pushl $130
80107db1:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80107db6:	e9 7c f6 ff ff       	jmp    80107437 <alltraps>

80107dbb <vector131>:
.globl vector131
vector131:
  pushl $0
80107dbb:	6a 00                	push   $0x0
  pushl $131
80107dbd:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80107dc2:	e9 70 f6 ff ff       	jmp    80107437 <alltraps>

80107dc7 <vector132>:
.globl vector132
vector132:
  pushl $0
80107dc7:	6a 00                	push   $0x0
  pushl $132
80107dc9:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80107dce:	e9 64 f6 ff ff       	jmp    80107437 <alltraps>

80107dd3 <vector133>:
.globl vector133
vector133:
  pushl $0
80107dd3:	6a 00                	push   $0x0
  pushl $133
80107dd5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80107dda:	e9 58 f6 ff ff       	jmp    80107437 <alltraps>

80107ddf <vector134>:
.globl vector134
vector134:
  pushl $0
80107ddf:	6a 00                	push   $0x0
  pushl $134
80107de1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80107de6:	e9 4c f6 ff ff       	jmp    80107437 <alltraps>

80107deb <vector135>:
.globl vector135
vector135:
  pushl $0
80107deb:	6a 00                	push   $0x0
  pushl $135
80107ded:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80107df2:	e9 40 f6 ff ff       	jmp    80107437 <alltraps>

80107df7 <vector136>:
.globl vector136
vector136:
  pushl $0
80107df7:	6a 00                	push   $0x0
  pushl $136
80107df9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80107dfe:	e9 34 f6 ff ff       	jmp    80107437 <alltraps>

80107e03 <vector137>:
.globl vector137
vector137:
  pushl $0
80107e03:	6a 00                	push   $0x0
  pushl $137
80107e05:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80107e0a:	e9 28 f6 ff ff       	jmp    80107437 <alltraps>

80107e0f <vector138>:
.globl vector138
vector138:
  pushl $0
80107e0f:	6a 00                	push   $0x0
  pushl $138
80107e11:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80107e16:	e9 1c f6 ff ff       	jmp    80107437 <alltraps>

80107e1b <vector139>:
.globl vector139
vector139:
  pushl $0
80107e1b:	6a 00                	push   $0x0
  pushl $139
80107e1d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80107e22:	e9 10 f6 ff ff       	jmp    80107437 <alltraps>

80107e27 <vector140>:
.globl vector140
vector140:
  pushl $0
80107e27:	6a 00                	push   $0x0
  pushl $140
80107e29:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80107e2e:	e9 04 f6 ff ff       	jmp    80107437 <alltraps>

80107e33 <vector141>:
.globl vector141
vector141:
  pushl $0
80107e33:	6a 00                	push   $0x0
  pushl $141
80107e35:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80107e3a:	e9 f8 f5 ff ff       	jmp    80107437 <alltraps>

80107e3f <vector142>:
.globl vector142
vector142:
  pushl $0
80107e3f:	6a 00                	push   $0x0
  pushl $142
80107e41:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80107e46:	e9 ec f5 ff ff       	jmp    80107437 <alltraps>

80107e4b <vector143>:
.globl vector143
vector143:
  pushl $0
80107e4b:	6a 00                	push   $0x0
  pushl $143
80107e4d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80107e52:	e9 e0 f5 ff ff       	jmp    80107437 <alltraps>

80107e57 <vector144>:
.globl vector144
vector144:
  pushl $0
80107e57:	6a 00                	push   $0x0
  pushl $144
80107e59:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80107e5e:	e9 d4 f5 ff ff       	jmp    80107437 <alltraps>

80107e63 <vector145>:
.globl vector145
vector145:
  pushl $0
80107e63:	6a 00                	push   $0x0
  pushl $145
80107e65:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80107e6a:	e9 c8 f5 ff ff       	jmp    80107437 <alltraps>

80107e6f <vector146>:
.globl vector146
vector146:
  pushl $0
80107e6f:	6a 00                	push   $0x0
  pushl $146
80107e71:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80107e76:	e9 bc f5 ff ff       	jmp    80107437 <alltraps>

80107e7b <vector147>:
.globl vector147
vector147:
  pushl $0
80107e7b:	6a 00                	push   $0x0
  pushl $147
80107e7d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80107e82:	e9 b0 f5 ff ff       	jmp    80107437 <alltraps>

80107e87 <vector148>:
.globl vector148
vector148:
  pushl $0
80107e87:	6a 00                	push   $0x0
  pushl $148
80107e89:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80107e8e:	e9 a4 f5 ff ff       	jmp    80107437 <alltraps>

80107e93 <vector149>:
.globl vector149
vector149:
  pushl $0
80107e93:	6a 00                	push   $0x0
  pushl $149
80107e95:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80107e9a:	e9 98 f5 ff ff       	jmp    80107437 <alltraps>

80107e9f <vector150>:
.globl vector150
vector150:
  pushl $0
80107e9f:	6a 00                	push   $0x0
  pushl $150
80107ea1:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80107ea6:	e9 8c f5 ff ff       	jmp    80107437 <alltraps>

80107eab <vector151>:
.globl vector151
vector151:
  pushl $0
80107eab:	6a 00                	push   $0x0
  pushl $151
80107ead:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80107eb2:	e9 80 f5 ff ff       	jmp    80107437 <alltraps>

80107eb7 <vector152>:
.globl vector152
vector152:
  pushl $0
80107eb7:	6a 00                	push   $0x0
  pushl $152
80107eb9:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80107ebe:	e9 74 f5 ff ff       	jmp    80107437 <alltraps>

80107ec3 <vector153>:
.globl vector153
vector153:
  pushl $0
80107ec3:	6a 00                	push   $0x0
  pushl $153
80107ec5:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80107eca:	e9 68 f5 ff ff       	jmp    80107437 <alltraps>

80107ecf <vector154>:
.globl vector154
vector154:
  pushl $0
80107ecf:	6a 00                	push   $0x0
  pushl $154
80107ed1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80107ed6:	e9 5c f5 ff ff       	jmp    80107437 <alltraps>

80107edb <vector155>:
.globl vector155
vector155:
  pushl $0
80107edb:	6a 00                	push   $0x0
  pushl $155
80107edd:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80107ee2:	e9 50 f5 ff ff       	jmp    80107437 <alltraps>

80107ee7 <vector156>:
.globl vector156
vector156:
  pushl $0
80107ee7:	6a 00                	push   $0x0
  pushl $156
80107ee9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80107eee:	e9 44 f5 ff ff       	jmp    80107437 <alltraps>

80107ef3 <vector157>:
.globl vector157
vector157:
  pushl $0
80107ef3:	6a 00                	push   $0x0
  pushl $157
80107ef5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80107efa:	e9 38 f5 ff ff       	jmp    80107437 <alltraps>

80107eff <vector158>:
.globl vector158
vector158:
  pushl $0
80107eff:	6a 00                	push   $0x0
  pushl $158
80107f01:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80107f06:	e9 2c f5 ff ff       	jmp    80107437 <alltraps>

80107f0b <vector159>:
.globl vector159
vector159:
  pushl $0
80107f0b:	6a 00                	push   $0x0
  pushl $159
80107f0d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80107f12:	e9 20 f5 ff ff       	jmp    80107437 <alltraps>

80107f17 <vector160>:
.globl vector160
vector160:
  pushl $0
80107f17:	6a 00                	push   $0x0
  pushl $160
80107f19:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80107f1e:	e9 14 f5 ff ff       	jmp    80107437 <alltraps>

80107f23 <vector161>:
.globl vector161
vector161:
  pushl $0
80107f23:	6a 00                	push   $0x0
  pushl $161
80107f25:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80107f2a:	e9 08 f5 ff ff       	jmp    80107437 <alltraps>

80107f2f <vector162>:
.globl vector162
vector162:
  pushl $0
80107f2f:	6a 00                	push   $0x0
  pushl $162
80107f31:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80107f36:	e9 fc f4 ff ff       	jmp    80107437 <alltraps>

80107f3b <vector163>:
.globl vector163
vector163:
  pushl $0
80107f3b:	6a 00                	push   $0x0
  pushl $163
80107f3d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80107f42:	e9 f0 f4 ff ff       	jmp    80107437 <alltraps>

80107f47 <vector164>:
.globl vector164
vector164:
  pushl $0
80107f47:	6a 00                	push   $0x0
  pushl $164
80107f49:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80107f4e:	e9 e4 f4 ff ff       	jmp    80107437 <alltraps>

80107f53 <vector165>:
.globl vector165
vector165:
  pushl $0
80107f53:	6a 00                	push   $0x0
  pushl $165
80107f55:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80107f5a:	e9 d8 f4 ff ff       	jmp    80107437 <alltraps>

80107f5f <vector166>:
.globl vector166
vector166:
  pushl $0
80107f5f:	6a 00                	push   $0x0
  pushl $166
80107f61:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80107f66:	e9 cc f4 ff ff       	jmp    80107437 <alltraps>

80107f6b <vector167>:
.globl vector167
vector167:
  pushl $0
80107f6b:	6a 00                	push   $0x0
  pushl $167
80107f6d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80107f72:	e9 c0 f4 ff ff       	jmp    80107437 <alltraps>

80107f77 <vector168>:
.globl vector168
vector168:
  pushl $0
80107f77:	6a 00                	push   $0x0
  pushl $168
80107f79:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80107f7e:	e9 b4 f4 ff ff       	jmp    80107437 <alltraps>

80107f83 <vector169>:
.globl vector169
vector169:
  pushl $0
80107f83:	6a 00                	push   $0x0
  pushl $169
80107f85:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80107f8a:	e9 a8 f4 ff ff       	jmp    80107437 <alltraps>

80107f8f <vector170>:
.globl vector170
vector170:
  pushl $0
80107f8f:	6a 00                	push   $0x0
  pushl $170
80107f91:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80107f96:	e9 9c f4 ff ff       	jmp    80107437 <alltraps>

80107f9b <vector171>:
.globl vector171
vector171:
  pushl $0
80107f9b:	6a 00                	push   $0x0
  pushl $171
80107f9d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80107fa2:	e9 90 f4 ff ff       	jmp    80107437 <alltraps>

80107fa7 <vector172>:
.globl vector172
vector172:
  pushl $0
80107fa7:	6a 00                	push   $0x0
  pushl $172
80107fa9:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80107fae:	e9 84 f4 ff ff       	jmp    80107437 <alltraps>

80107fb3 <vector173>:
.globl vector173
vector173:
  pushl $0
80107fb3:	6a 00                	push   $0x0
  pushl $173
80107fb5:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80107fba:	e9 78 f4 ff ff       	jmp    80107437 <alltraps>

80107fbf <vector174>:
.globl vector174
vector174:
  pushl $0
80107fbf:	6a 00                	push   $0x0
  pushl $174
80107fc1:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80107fc6:	e9 6c f4 ff ff       	jmp    80107437 <alltraps>

80107fcb <vector175>:
.globl vector175
vector175:
  pushl $0
80107fcb:	6a 00                	push   $0x0
  pushl $175
80107fcd:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80107fd2:	e9 60 f4 ff ff       	jmp    80107437 <alltraps>

80107fd7 <vector176>:
.globl vector176
vector176:
  pushl $0
80107fd7:	6a 00                	push   $0x0
  pushl $176
80107fd9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80107fde:	e9 54 f4 ff ff       	jmp    80107437 <alltraps>

80107fe3 <vector177>:
.globl vector177
vector177:
  pushl $0
80107fe3:	6a 00                	push   $0x0
  pushl $177
80107fe5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80107fea:	e9 48 f4 ff ff       	jmp    80107437 <alltraps>

80107fef <vector178>:
.globl vector178
vector178:
  pushl $0
80107fef:	6a 00                	push   $0x0
  pushl $178
80107ff1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80107ff6:	e9 3c f4 ff ff       	jmp    80107437 <alltraps>

80107ffb <vector179>:
.globl vector179
vector179:
  pushl $0
80107ffb:	6a 00                	push   $0x0
  pushl $179
80107ffd:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80108002:	e9 30 f4 ff ff       	jmp    80107437 <alltraps>

80108007 <vector180>:
.globl vector180
vector180:
  pushl $0
80108007:	6a 00                	push   $0x0
  pushl $180
80108009:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010800e:	e9 24 f4 ff ff       	jmp    80107437 <alltraps>

80108013 <vector181>:
.globl vector181
vector181:
  pushl $0
80108013:	6a 00                	push   $0x0
  pushl $181
80108015:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010801a:	e9 18 f4 ff ff       	jmp    80107437 <alltraps>

8010801f <vector182>:
.globl vector182
vector182:
  pushl $0
8010801f:	6a 00                	push   $0x0
  pushl $182
80108021:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80108026:	e9 0c f4 ff ff       	jmp    80107437 <alltraps>

8010802b <vector183>:
.globl vector183
vector183:
  pushl $0
8010802b:	6a 00                	push   $0x0
  pushl $183
8010802d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80108032:	e9 00 f4 ff ff       	jmp    80107437 <alltraps>

80108037 <vector184>:
.globl vector184
vector184:
  pushl $0
80108037:	6a 00                	push   $0x0
  pushl $184
80108039:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010803e:	e9 f4 f3 ff ff       	jmp    80107437 <alltraps>

80108043 <vector185>:
.globl vector185
vector185:
  pushl $0
80108043:	6a 00                	push   $0x0
  pushl $185
80108045:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010804a:	e9 e8 f3 ff ff       	jmp    80107437 <alltraps>

8010804f <vector186>:
.globl vector186
vector186:
  pushl $0
8010804f:	6a 00                	push   $0x0
  pushl $186
80108051:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80108056:	e9 dc f3 ff ff       	jmp    80107437 <alltraps>

8010805b <vector187>:
.globl vector187
vector187:
  pushl $0
8010805b:	6a 00                	push   $0x0
  pushl $187
8010805d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80108062:	e9 d0 f3 ff ff       	jmp    80107437 <alltraps>

80108067 <vector188>:
.globl vector188
vector188:
  pushl $0
80108067:	6a 00                	push   $0x0
  pushl $188
80108069:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010806e:	e9 c4 f3 ff ff       	jmp    80107437 <alltraps>

80108073 <vector189>:
.globl vector189
vector189:
  pushl $0
80108073:	6a 00                	push   $0x0
  pushl $189
80108075:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010807a:	e9 b8 f3 ff ff       	jmp    80107437 <alltraps>

8010807f <vector190>:
.globl vector190
vector190:
  pushl $0
8010807f:	6a 00                	push   $0x0
  pushl $190
80108081:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80108086:	e9 ac f3 ff ff       	jmp    80107437 <alltraps>

8010808b <vector191>:
.globl vector191
vector191:
  pushl $0
8010808b:	6a 00                	push   $0x0
  pushl $191
8010808d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80108092:	e9 a0 f3 ff ff       	jmp    80107437 <alltraps>

80108097 <vector192>:
.globl vector192
vector192:
  pushl $0
80108097:	6a 00                	push   $0x0
  pushl $192
80108099:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010809e:	e9 94 f3 ff ff       	jmp    80107437 <alltraps>

801080a3 <vector193>:
.globl vector193
vector193:
  pushl $0
801080a3:	6a 00                	push   $0x0
  pushl $193
801080a5:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
801080aa:	e9 88 f3 ff ff       	jmp    80107437 <alltraps>

801080af <vector194>:
.globl vector194
vector194:
  pushl $0
801080af:	6a 00                	push   $0x0
  pushl $194
801080b1:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801080b6:	e9 7c f3 ff ff       	jmp    80107437 <alltraps>

801080bb <vector195>:
.globl vector195
vector195:
  pushl $0
801080bb:	6a 00                	push   $0x0
  pushl $195
801080bd:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801080c2:	e9 70 f3 ff ff       	jmp    80107437 <alltraps>

801080c7 <vector196>:
.globl vector196
vector196:
  pushl $0
801080c7:	6a 00                	push   $0x0
  pushl $196
801080c9:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801080ce:	e9 64 f3 ff ff       	jmp    80107437 <alltraps>

801080d3 <vector197>:
.globl vector197
vector197:
  pushl $0
801080d3:	6a 00                	push   $0x0
  pushl $197
801080d5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801080da:	e9 58 f3 ff ff       	jmp    80107437 <alltraps>

801080df <vector198>:
.globl vector198
vector198:
  pushl $0
801080df:	6a 00                	push   $0x0
  pushl $198
801080e1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801080e6:	e9 4c f3 ff ff       	jmp    80107437 <alltraps>

801080eb <vector199>:
.globl vector199
vector199:
  pushl $0
801080eb:	6a 00                	push   $0x0
  pushl $199
801080ed:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801080f2:	e9 40 f3 ff ff       	jmp    80107437 <alltraps>

801080f7 <vector200>:
.globl vector200
vector200:
  pushl $0
801080f7:	6a 00                	push   $0x0
  pushl $200
801080f9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801080fe:	e9 34 f3 ff ff       	jmp    80107437 <alltraps>

80108103 <vector201>:
.globl vector201
vector201:
  pushl $0
80108103:	6a 00                	push   $0x0
  pushl $201
80108105:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010810a:	e9 28 f3 ff ff       	jmp    80107437 <alltraps>

8010810f <vector202>:
.globl vector202
vector202:
  pushl $0
8010810f:	6a 00                	push   $0x0
  pushl $202
80108111:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80108116:	e9 1c f3 ff ff       	jmp    80107437 <alltraps>

8010811b <vector203>:
.globl vector203
vector203:
  pushl $0
8010811b:	6a 00                	push   $0x0
  pushl $203
8010811d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80108122:	e9 10 f3 ff ff       	jmp    80107437 <alltraps>

80108127 <vector204>:
.globl vector204
vector204:
  pushl $0
80108127:	6a 00                	push   $0x0
  pushl $204
80108129:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010812e:	e9 04 f3 ff ff       	jmp    80107437 <alltraps>

80108133 <vector205>:
.globl vector205
vector205:
  pushl $0
80108133:	6a 00                	push   $0x0
  pushl $205
80108135:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010813a:	e9 f8 f2 ff ff       	jmp    80107437 <alltraps>

8010813f <vector206>:
.globl vector206
vector206:
  pushl $0
8010813f:	6a 00                	push   $0x0
  pushl $206
80108141:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80108146:	e9 ec f2 ff ff       	jmp    80107437 <alltraps>

8010814b <vector207>:
.globl vector207
vector207:
  pushl $0
8010814b:	6a 00                	push   $0x0
  pushl $207
8010814d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80108152:	e9 e0 f2 ff ff       	jmp    80107437 <alltraps>

80108157 <vector208>:
.globl vector208
vector208:
  pushl $0
80108157:	6a 00                	push   $0x0
  pushl $208
80108159:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010815e:	e9 d4 f2 ff ff       	jmp    80107437 <alltraps>

80108163 <vector209>:
.globl vector209
vector209:
  pushl $0
80108163:	6a 00                	push   $0x0
  pushl $209
80108165:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010816a:	e9 c8 f2 ff ff       	jmp    80107437 <alltraps>

8010816f <vector210>:
.globl vector210
vector210:
  pushl $0
8010816f:	6a 00                	push   $0x0
  pushl $210
80108171:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80108176:	e9 bc f2 ff ff       	jmp    80107437 <alltraps>

8010817b <vector211>:
.globl vector211
vector211:
  pushl $0
8010817b:	6a 00                	push   $0x0
  pushl $211
8010817d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80108182:	e9 b0 f2 ff ff       	jmp    80107437 <alltraps>

80108187 <vector212>:
.globl vector212
vector212:
  pushl $0
80108187:	6a 00                	push   $0x0
  pushl $212
80108189:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010818e:	e9 a4 f2 ff ff       	jmp    80107437 <alltraps>

80108193 <vector213>:
.globl vector213
vector213:
  pushl $0
80108193:	6a 00                	push   $0x0
  pushl $213
80108195:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010819a:	e9 98 f2 ff ff       	jmp    80107437 <alltraps>

8010819f <vector214>:
.globl vector214
vector214:
  pushl $0
8010819f:	6a 00                	push   $0x0
  pushl $214
801081a1:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
801081a6:	e9 8c f2 ff ff       	jmp    80107437 <alltraps>

801081ab <vector215>:
.globl vector215
vector215:
  pushl $0
801081ab:	6a 00                	push   $0x0
  pushl $215
801081ad:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
801081b2:	e9 80 f2 ff ff       	jmp    80107437 <alltraps>

801081b7 <vector216>:
.globl vector216
vector216:
  pushl $0
801081b7:	6a 00                	push   $0x0
  pushl $216
801081b9:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801081be:	e9 74 f2 ff ff       	jmp    80107437 <alltraps>

801081c3 <vector217>:
.globl vector217
vector217:
  pushl $0
801081c3:	6a 00                	push   $0x0
  pushl $217
801081c5:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801081ca:	e9 68 f2 ff ff       	jmp    80107437 <alltraps>

801081cf <vector218>:
.globl vector218
vector218:
  pushl $0
801081cf:	6a 00                	push   $0x0
  pushl $218
801081d1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801081d6:	e9 5c f2 ff ff       	jmp    80107437 <alltraps>

801081db <vector219>:
.globl vector219
vector219:
  pushl $0
801081db:	6a 00                	push   $0x0
  pushl $219
801081dd:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801081e2:	e9 50 f2 ff ff       	jmp    80107437 <alltraps>

801081e7 <vector220>:
.globl vector220
vector220:
  pushl $0
801081e7:	6a 00                	push   $0x0
  pushl $220
801081e9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801081ee:	e9 44 f2 ff ff       	jmp    80107437 <alltraps>

801081f3 <vector221>:
.globl vector221
vector221:
  pushl $0
801081f3:	6a 00                	push   $0x0
  pushl $221
801081f5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801081fa:	e9 38 f2 ff ff       	jmp    80107437 <alltraps>

801081ff <vector222>:
.globl vector222
vector222:
  pushl $0
801081ff:	6a 00                	push   $0x0
  pushl $222
80108201:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80108206:	e9 2c f2 ff ff       	jmp    80107437 <alltraps>

8010820b <vector223>:
.globl vector223
vector223:
  pushl $0
8010820b:	6a 00                	push   $0x0
  pushl $223
8010820d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80108212:	e9 20 f2 ff ff       	jmp    80107437 <alltraps>

80108217 <vector224>:
.globl vector224
vector224:
  pushl $0
80108217:	6a 00                	push   $0x0
  pushl $224
80108219:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010821e:	e9 14 f2 ff ff       	jmp    80107437 <alltraps>

80108223 <vector225>:
.globl vector225
vector225:
  pushl $0
80108223:	6a 00                	push   $0x0
  pushl $225
80108225:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010822a:	e9 08 f2 ff ff       	jmp    80107437 <alltraps>

8010822f <vector226>:
.globl vector226
vector226:
  pushl $0
8010822f:	6a 00                	push   $0x0
  pushl $226
80108231:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80108236:	e9 fc f1 ff ff       	jmp    80107437 <alltraps>

8010823b <vector227>:
.globl vector227
vector227:
  pushl $0
8010823b:	6a 00                	push   $0x0
  pushl $227
8010823d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80108242:	e9 f0 f1 ff ff       	jmp    80107437 <alltraps>

80108247 <vector228>:
.globl vector228
vector228:
  pushl $0
80108247:	6a 00                	push   $0x0
  pushl $228
80108249:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010824e:	e9 e4 f1 ff ff       	jmp    80107437 <alltraps>

80108253 <vector229>:
.globl vector229
vector229:
  pushl $0
80108253:	6a 00                	push   $0x0
  pushl $229
80108255:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010825a:	e9 d8 f1 ff ff       	jmp    80107437 <alltraps>

8010825f <vector230>:
.globl vector230
vector230:
  pushl $0
8010825f:	6a 00                	push   $0x0
  pushl $230
80108261:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80108266:	e9 cc f1 ff ff       	jmp    80107437 <alltraps>

8010826b <vector231>:
.globl vector231
vector231:
  pushl $0
8010826b:	6a 00                	push   $0x0
  pushl $231
8010826d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80108272:	e9 c0 f1 ff ff       	jmp    80107437 <alltraps>

80108277 <vector232>:
.globl vector232
vector232:
  pushl $0
80108277:	6a 00                	push   $0x0
  pushl $232
80108279:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010827e:	e9 b4 f1 ff ff       	jmp    80107437 <alltraps>

80108283 <vector233>:
.globl vector233
vector233:
  pushl $0
80108283:	6a 00                	push   $0x0
  pushl $233
80108285:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010828a:	e9 a8 f1 ff ff       	jmp    80107437 <alltraps>

8010828f <vector234>:
.globl vector234
vector234:
  pushl $0
8010828f:	6a 00                	push   $0x0
  pushl $234
80108291:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80108296:	e9 9c f1 ff ff       	jmp    80107437 <alltraps>

8010829b <vector235>:
.globl vector235
vector235:
  pushl $0
8010829b:	6a 00                	push   $0x0
  pushl $235
8010829d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
801082a2:	e9 90 f1 ff ff       	jmp    80107437 <alltraps>

801082a7 <vector236>:
.globl vector236
vector236:
  pushl $0
801082a7:	6a 00                	push   $0x0
  pushl $236
801082a9:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
801082ae:	e9 84 f1 ff ff       	jmp    80107437 <alltraps>

801082b3 <vector237>:
.globl vector237
vector237:
  pushl $0
801082b3:	6a 00                	push   $0x0
  pushl $237
801082b5:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
801082ba:	e9 78 f1 ff ff       	jmp    80107437 <alltraps>

801082bf <vector238>:
.globl vector238
vector238:
  pushl $0
801082bf:	6a 00                	push   $0x0
  pushl $238
801082c1:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801082c6:	e9 6c f1 ff ff       	jmp    80107437 <alltraps>

801082cb <vector239>:
.globl vector239
vector239:
  pushl $0
801082cb:	6a 00                	push   $0x0
  pushl $239
801082cd:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801082d2:	e9 60 f1 ff ff       	jmp    80107437 <alltraps>

801082d7 <vector240>:
.globl vector240
vector240:
  pushl $0
801082d7:	6a 00                	push   $0x0
  pushl $240
801082d9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801082de:	e9 54 f1 ff ff       	jmp    80107437 <alltraps>

801082e3 <vector241>:
.globl vector241
vector241:
  pushl $0
801082e3:	6a 00                	push   $0x0
  pushl $241
801082e5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801082ea:	e9 48 f1 ff ff       	jmp    80107437 <alltraps>

801082ef <vector242>:
.globl vector242
vector242:
  pushl $0
801082ef:	6a 00                	push   $0x0
  pushl $242
801082f1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801082f6:	e9 3c f1 ff ff       	jmp    80107437 <alltraps>

801082fb <vector243>:
.globl vector243
vector243:
  pushl $0
801082fb:	6a 00                	push   $0x0
  pushl $243
801082fd:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80108302:	e9 30 f1 ff ff       	jmp    80107437 <alltraps>

80108307 <vector244>:
.globl vector244
vector244:
  pushl $0
80108307:	6a 00                	push   $0x0
  pushl $244
80108309:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010830e:	e9 24 f1 ff ff       	jmp    80107437 <alltraps>

80108313 <vector245>:
.globl vector245
vector245:
  pushl $0
80108313:	6a 00                	push   $0x0
  pushl $245
80108315:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
8010831a:	e9 18 f1 ff ff       	jmp    80107437 <alltraps>

8010831f <vector246>:
.globl vector246
vector246:
  pushl $0
8010831f:	6a 00                	push   $0x0
  pushl $246
80108321:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80108326:	e9 0c f1 ff ff       	jmp    80107437 <alltraps>

8010832b <vector247>:
.globl vector247
vector247:
  pushl $0
8010832b:	6a 00                	push   $0x0
  pushl $247
8010832d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80108332:	e9 00 f1 ff ff       	jmp    80107437 <alltraps>

80108337 <vector248>:
.globl vector248
vector248:
  pushl $0
80108337:	6a 00                	push   $0x0
  pushl $248
80108339:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010833e:	e9 f4 f0 ff ff       	jmp    80107437 <alltraps>

80108343 <vector249>:
.globl vector249
vector249:
  pushl $0
80108343:	6a 00                	push   $0x0
  pushl $249
80108345:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010834a:	e9 e8 f0 ff ff       	jmp    80107437 <alltraps>

8010834f <vector250>:
.globl vector250
vector250:
  pushl $0
8010834f:	6a 00                	push   $0x0
  pushl $250
80108351:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80108356:	e9 dc f0 ff ff       	jmp    80107437 <alltraps>

8010835b <vector251>:
.globl vector251
vector251:
  pushl $0
8010835b:	6a 00                	push   $0x0
  pushl $251
8010835d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80108362:	e9 d0 f0 ff ff       	jmp    80107437 <alltraps>

80108367 <vector252>:
.globl vector252
vector252:
  pushl $0
80108367:	6a 00                	push   $0x0
  pushl $252
80108369:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010836e:	e9 c4 f0 ff ff       	jmp    80107437 <alltraps>

80108373 <vector253>:
.globl vector253
vector253:
  pushl $0
80108373:	6a 00                	push   $0x0
  pushl $253
80108375:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010837a:	e9 b8 f0 ff ff       	jmp    80107437 <alltraps>

8010837f <vector254>:
.globl vector254
vector254:
  pushl $0
8010837f:	6a 00                	push   $0x0
  pushl $254
80108381:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80108386:	e9 ac f0 ff ff       	jmp    80107437 <alltraps>

8010838b <vector255>:
.globl vector255
vector255:
  pushl $0
8010838b:	6a 00                	push   $0x0
  pushl $255
8010838d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80108392:	e9 a0 f0 ff ff       	jmp    80107437 <alltraps>
80108397:	66 90                	xchg   %ax,%ax
80108399:	66 90                	xchg   %ax,%ax
8010839b:	66 90                	xchg   %ax,%ax
8010839d:	66 90                	xchg   %ax,%ax
8010839f:	90                   	nop

801083a0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801083a0:	55                   	push   %ebp
801083a1:	89 e5                	mov    %esp,%ebp
801083a3:	57                   	push   %edi
801083a4:	56                   	push   %esi
801083a5:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801083a6:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
801083ac:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801083b2:	83 ec 1c             	sub    $0x1c,%esp
801083b5:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
801083b8:	39 d3                	cmp    %edx,%ebx
801083ba:	73 45                	jae    80108401 <deallocuvm.part.0+0x61>
801083bc:	89 c7                	mov    %eax,%edi
801083be:	eb 0a                	jmp    801083ca <deallocuvm.part.0+0x2a>
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801083c0:	8d 59 01             	lea    0x1(%ecx),%ebx
801083c3:	c1 e3 16             	shl    $0x16,%ebx
  for(; a  < oldsz; a += PGSIZE){
801083c6:	39 da                	cmp    %ebx,%edx
801083c8:	76 37                	jbe    80108401 <deallocuvm.part.0+0x61>
  pde = &pgdir[PDX(va)];
801083ca:	89 d9                	mov    %ebx,%ecx
801083cc:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
801083cf:	8b 04 8f             	mov    (%edi,%ecx,4),%eax
801083d2:	a8 01                	test   $0x1,%al
801083d4:	74 ea                	je     801083c0 <deallocuvm.part.0+0x20>
  return &pgtab[PTX(va)];
801083d6:	89 de                	mov    %ebx,%esi
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801083d8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
801083dd:	c1 ee 0a             	shr    $0xa,%esi
801083e0:	81 e6 fc 0f 00 00    	and    $0xffc,%esi
801083e6:	8d b4 30 00 00 00 80 	lea    -0x80000000(%eax,%esi,1),%esi
    if(!pte)
801083ed:	85 f6                	test   %esi,%esi
801083ef:	74 cf                	je     801083c0 <deallocuvm.part.0+0x20>
    else if((*pte & PTE_P) != 0){
801083f1:	8b 06                	mov    (%esi),%eax
801083f3:	a8 01                	test   $0x1,%al
801083f5:	75 19                	jne    80108410 <deallocuvm.part.0+0x70>
  for(; a  < oldsz; a += PGSIZE){
801083f7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801083fd:	39 da                	cmp    %ebx,%edx
801083ff:	77 c9                	ja     801083ca <deallocuvm.part.0+0x2a>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80108401:	8b 45 e0             	mov    -0x20(%ebp),%eax
80108404:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108407:	5b                   	pop    %ebx
80108408:	5e                   	pop    %esi
80108409:	5f                   	pop    %edi
8010840a:	5d                   	pop    %ebp
8010840b:	c3                   	ret
8010840c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(pa == 0)
80108410:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108415:	74 25                	je     8010843c <deallocuvm.part.0+0x9c>
      kfree(v);
80108417:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
8010841a:	05 00 00 00 80       	add    $0x80000000,%eax
8010841f:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80108422:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
80108428:	50                   	push   %eax
80108429:	e8 72 b1 ff ff       	call   801035a0 <kfree>
      *pte = 0;
8010842e:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  for(; a  < oldsz; a += PGSIZE){
80108434:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80108437:	83 c4 10             	add    $0x10,%esp
8010843a:	eb 8a                	jmp    801083c6 <deallocuvm.part.0+0x26>
        panic("kfree");
8010843c:	83 ec 0c             	sub    $0xc,%esp
8010843f:	68 cc 91 10 80       	push   $0x801091cc
80108444:	e8 87 80 ff ff       	call   801004d0 <panic>
80108449:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80108450 <mappages>:
{
80108450:	55                   	push   %ebp
80108451:	89 e5                	mov    %esp,%ebp
80108453:	57                   	push   %edi
80108454:	56                   	push   %esi
80108455:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80108456:	89 d3                	mov    %edx,%ebx
80108458:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
8010845e:	83 ec 1c             	sub    $0x1c,%esp
80108461:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80108464:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80108468:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010846d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80108470:	8b 45 08             	mov    0x8(%ebp),%eax
80108473:	29 d8                	sub    %ebx,%eax
80108475:	89 45 e0             	mov    %eax,-0x20(%ebp)
80108478:	eb 3d                	jmp    801084b7 <mappages+0x67>
8010847a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80108480:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80108482:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80108487:	c1 ea 0a             	shr    $0xa,%edx
8010848a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80108490:	8d 94 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%edx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80108497:	85 d2                	test   %edx,%edx
80108499:	74 75                	je     80108510 <mappages+0xc0>
    if(*pte & PTE_P)
8010849b:	f6 02 01             	testb  $0x1,(%edx)
8010849e:	0f 85 86 00 00 00    	jne    8010852a <mappages+0xda>
    *pte = pa | perm | PTE_P;
801084a4:	0b 75 0c             	or     0xc(%ebp),%esi
801084a7:	83 ce 01             	or     $0x1,%esi
801084aa:	89 32                	mov    %esi,(%edx)
    if(a == last)
801084ac:	3b 5d dc             	cmp    -0x24(%ebp),%ebx
801084af:	74 6f                	je     80108520 <mappages+0xd0>
    a += PGSIZE;
801084b1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
801084b7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  pde = &pgdir[PDX(va)];
801084ba:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801084bd:	8d 34 18             	lea    (%eax,%ebx,1),%esi
801084c0:	89 d8                	mov    %ebx,%eax
801084c2:	c1 e8 16             	shr    $0x16,%eax
801084c5:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
801084c8:	8b 07                	mov    (%edi),%eax
801084ca:	a8 01                	test   $0x1,%al
801084cc:	75 b2                	jne    80108480 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801084ce:	e8 8d b2 ff ff       	call   80103760 <kalloc>
801084d3:	85 c0                	test   %eax,%eax
801084d5:	74 39                	je     80108510 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
801084d7:	83 ec 04             	sub    $0x4,%esp
801084da:	89 45 d8             	mov    %eax,-0x28(%ebp)
801084dd:	68 00 10 00 00       	push   $0x1000
801084e2:	6a 00                	push   $0x0
801084e4:	50                   	push   %eax
801084e5:	e8 96 d8 ff ff       	call   80105d80 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801084ea:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
801084ed:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801084f0:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
801084f6:	83 c8 07             	or     $0x7,%eax
801084f9:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
801084fb:	89 d8                	mov    %ebx,%eax
801084fd:	c1 e8 0a             	shr    $0xa,%eax
80108500:	25 fc 0f 00 00       	and    $0xffc,%eax
80108505:	01 c2                	add    %eax,%edx
80108507:	eb 92                	jmp    8010849b <mappages+0x4b>
80108509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
80108510:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80108513:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80108518:	5b                   	pop    %ebx
80108519:	5e                   	pop    %esi
8010851a:	5f                   	pop    %edi
8010851b:	5d                   	pop    %ebp
8010851c:	c3                   	ret
8010851d:	8d 76 00             	lea    0x0(%esi),%esi
80108520:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80108523:	31 c0                	xor    %eax,%eax
}
80108525:	5b                   	pop    %ebx
80108526:	5e                   	pop    %esi
80108527:	5f                   	pop    %edi
80108528:	5d                   	pop    %ebp
80108529:	c3                   	ret
      panic("remap");
8010852a:	83 ec 0c             	sub    $0xc,%esp
8010852d:	68 5d 94 10 80       	push   $0x8010945d
80108532:	e8 99 7f ff ff       	call   801004d0 <panic>
80108537:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010853e:	00 
8010853f:	90                   	nop

80108540 <seginit>:
{
80108540:	55                   	push   %ebp
80108541:	89 e5                	mov    %esp,%ebp
80108543:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80108546:	e8 05 c5 ff ff       	call   80104a50 <cpuid>
  pd[0] = size-1;
8010854b:	ba 2f 00 00 00       	mov    $0x2f,%edx
80108550:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80108556:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010855a:	c7 80 d8 42 11 80 ff 	movl   $0xffff,-0x7feebd28(%eax)
80108561:	ff 00 00 
80108564:	c7 80 dc 42 11 80 00 	movl   $0xcf9a00,-0x7feebd24(%eax)
8010856b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010856e:	c7 80 e0 42 11 80 ff 	movl   $0xffff,-0x7feebd20(%eax)
80108575:	ff 00 00 
80108578:	c7 80 e4 42 11 80 00 	movl   $0xcf9200,-0x7feebd1c(%eax)
8010857f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80108582:	c7 80 e8 42 11 80 ff 	movl   $0xffff,-0x7feebd18(%eax)
80108589:	ff 00 00 
8010858c:	c7 80 ec 42 11 80 00 	movl   $0xcffa00,-0x7feebd14(%eax)
80108593:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80108596:	c7 80 f0 42 11 80 ff 	movl   $0xffff,-0x7feebd10(%eax)
8010859d:	ff 00 00 
801085a0:	c7 80 f4 42 11 80 00 	movl   $0xcff200,-0x7feebd0c(%eax)
801085a7:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
801085aa:	05 d0 42 11 80       	add    $0x801142d0,%eax
  pd[1] = (uint)p;
801085af:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
801085b3:	c1 e8 10             	shr    $0x10,%eax
801085b6:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
801085ba:	8d 45 f2             	lea    -0xe(%ebp),%eax
801085bd:	0f 01 10             	lgdtl  (%eax)
}
801085c0:	c9                   	leave
801085c1:	c3                   	ret
801085c2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801085c9:	00 
801085ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801085d0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801085d0:	a1 d4 9c 34 80       	mov    0x80349cd4,%eax
801085d5:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801085da:	0f 22 d8             	mov    %eax,%cr3
}
801085dd:	c3                   	ret
801085de:	66 90                	xchg   %ax,%ax

801085e0 <switchuvm>:
{
801085e0:	55                   	push   %ebp
801085e1:	89 e5                	mov    %esp,%ebp
801085e3:	57                   	push   %edi
801085e4:	56                   	push   %esi
801085e5:	53                   	push   %ebx
801085e6:	83 ec 1c             	sub    $0x1c,%esp
801085e9:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
801085ec:	85 f6                	test   %esi,%esi
801085ee:	0f 84 cb 00 00 00    	je     801086bf <switchuvm+0xdf>
  if(p->kstack == 0)
801085f4:	8b 46 08             	mov    0x8(%esi),%eax
801085f7:	85 c0                	test   %eax,%eax
801085f9:	0f 84 da 00 00 00    	je     801086d9 <switchuvm+0xf9>
  if(p->pgdir == 0)
801085ff:	8b 46 04             	mov    0x4(%esi),%eax
80108602:	85 c0                	test   %eax,%eax
80108604:	0f 84 c2 00 00 00    	je     801086cc <switchuvm+0xec>
  pushcli();
8010860a:	e8 61 d5 ff ff       	call   80105b70 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010860f:	e8 cc c3 ff ff       	call   801049e0 <mycpu>
80108614:	89 c3                	mov    %eax,%ebx
80108616:	e8 c5 c3 ff ff       	call   801049e0 <mycpu>
8010861b:	89 c7                	mov    %eax,%edi
8010861d:	e8 be c3 ff ff       	call   801049e0 <mycpu>
80108622:	83 c7 08             	add    $0x8,%edi
80108625:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80108628:	e8 b3 c3 ff ff       	call   801049e0 <mycpu>
8010862d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80108630:	ba 67 00 00 00       	mov    $0x67,%edx
80108635:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
8010863c:	83 c0 08             	add    $0x8,%eax
8010863f:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80108646:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010864b:	83 c1 08             	add    $0x8,%ecx
8010864e:	c1 e8 18             	shr    $0x18,%eax
80108651:	c1 e9 10             	shr    $0x10,%ecx
80108654:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
8010865a:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80108660:	b9 99 40 00 00       	mov    $0x4099,%ecx
80108665:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010866c:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80108671:	e8 6a c3 ff ff       	call   801049e0 <mycpu>
80108676:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010867d:	e8 5e c3 ff ff       	call   801049e0 <mycpu>
80108682:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80108686:	8b 5e 08             	mov    0x8(%esi),%ebx
80108689:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010868f:	e8 4c c3 ff ff       	call   801049e0 <mycpu>
80108694:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80108697:	e8 44 c3 ff ff       	call   801049e0 <mycpu>
8010869c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
801086a0:	b8 28 00 00 00       	mov    $0x28,%eax
801086a5:	0f 00 d8             	ltr    %eax
  lcr3(V2P(p->pgdir));  // switch to process's address space
801086a8:	8b 46 04             	mov    0x4(%esi),%eax
801086ab:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
801086b0:	0f 22 d8             	mov    %eax,%cr3
}
801086b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801086b6:	5b                   	pop    %ebx
801086b7:	5e                   	pop    %esi
801086b8:	5f                   	pop    %edi
801086b9:	5d                   	pop    %ebp
  popcli();
801086ba:	e9 01 d5 ff ff       	jmp    80105bc0 <popcli>
    panic("switchuvm: no process");
801086bf:	83 ec 0c             	sub    $0xc,%esp
801086c2:	68 63 94 10 80       	push   $0x80109463
801086c7:	e8 04 7e ff ff       	call   801004d0 <panic>
    panic("switchuvm: no pgdir");
801086cc:	83 ec 0c             	sub    $0xc,%esp
801086cf:	68 8e 94 10 80       	push   $0x8010948e
801086d4:	e8 f7 7d ff ff       	call   801004d0 <panic>
    panic("switchuvm: no kstack");
801086d9:	83 ec 0c             	sub    $0xc,%esp
801086dc:	68 79 94 10 80       	push   $0x80109479
801086e1:	e8 ea 7d ff ff       	call   801004d0 <panic>
801086e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801086ed:	00 
801086ee:	66 90                	xchg   %ax,%ax

801086f0 <inituvm>:
{
801086f0:	55                   	push   %ebp
801086f1:	89 e5                	mov    %esp,%ebp
801086f3:	57                   	push   %edi
801086f4:	56                   	push   %esi
801086f5:	53                   	push   %ebx
801086f6:	83 ec 1c             	sub    $0x1c,%esp
801086f9:	8b 45 0c             	mov    0xc(%ebp),%eax
801086fc:	8b 75 10             	mov    0x10(%ebp),%esi
801086ff:	8b 7d 08             	mov    0x8(%ebp),%edi
80108702:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80108705:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010870b:	77 4b                	ja     80108758 <inituvm+0x68>
  mem = kalloc();
8010870d:	e8 4e b0 ff ff       	call   80103760 <kalloc>
  memset(mem, 0, PGSIZE);
80108712:	83 ec 04             	sub    $0x4,%esp
80108715:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
8010871a:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
8010871c:	6a 00                	push   $0x0
8010871e:	50                   	push   %eax
8010871f:	e8 5c d6 ff ff       	call   80105d80 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80108724:	58                   	pop    %eax
80108725:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010872b:	5a                   	pop    %edx
8010872c:	6a 06                	push   $0x6
8010872e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80108733:	31 d2                	xor    %edx,%edx
80108735:	50                   	push   %eax
80108736:	89 f8                	mov    %edi,%eax
80108738:	e8 13 fd ff ff       	call   80108450 <mappages>
  memmove(mem, init, sz);
8010873d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108740:	89 75 10             	mov    %esi,0x10(%ebp)
80108743:	83 c4 10             	add    $0x10,%esp
80108746:	89 5d 08             	mov    %ebx,0x8(%ebp)
80108749:	89 45 0c             	mov    %eax,0xc(%ebp)
}
8010874c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010874f:	5b                   	pop    %ebx
80108750:	5e                   	pop    %esi
80108751:	5f                   	pop    %edi
80108752:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80108753:	e9 c8 d6 ff ff       	jmp    80105e20 <memmove>
    panic("inituvm: more than a page");
80108758:	83 ec 0c             	sub    $0xc,%esp
8010875b:	68 a2 94 10 80       	push   $0x801094a2
80108760:	e8 6b 7d ff ff       	call   801004d0 <panic>
80108765:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010876c:	00 
8010876d:	8d 76 00             	lea    0x0(%esi),%esi

80108770 <loaduvm>:
{
80108770:	55                   	push   %ebp
80108771:	89 e5                	mov    %esp,%ebp
80108773:	57                   	push   %edi
80108774:	56                   	push   %esi
80108775:	53                   	push   %ebx
80108776:	83 ec 1c             	sub    $0x1c,%esp
80108779:	8b 45 0c             	mov    0xc(%ebp),%eax
8010877c:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
8010877f:	a9 ff 0f 00 00       	test   $0xfff,%eax
80108784:	0f 85 bb 00 00 00    	jne    80108845 <loaduvm+0xd5>
  for(i = 0; i < sz; i += PGSIZE){
8010878a:	01 f0                	add    %esi,%eax
8010878c:	89 f3                	mov    %esi,%ebx
8010878e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
80108791:	8b 45 14             	mov    0x14(%ebp),%eax
80108794:	01 f0                	add    %esi,%eax
80108796:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
80108799:	85 f6                	test   %esi,%esi
8010879b:	0f 84 87 00 00 00    	je     80108828 <loaduvm+0xb8>
801087a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  pde = &pgdir[PDX(va)];
801087a8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  if(*pde & PTE_P){
801087ab:	8b 4d 08             	mov    0x8(%ebp),%ecx
801087ae:	29 d8                	sub    %ebx,%eax
  pde = &pgdir[PDX(va)];
801087b0:	89 c2                	mov    %eax,%edx
801087b2:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
801087b5:	8b 14 91             	mov    (%ecx,%edx,4),%edx
801087b8:	f6 c2 01             	test   $0x1,%dl
801087bb:	75 13                	jne    801087d0 <loaduvm+0x60>
      panic("loaduvm: address should exist");
801087bd:	83 ec 0c             	sub    $0xc,%esp
801087c0:	68 bc 94 10 80       	push   $0x801094bc
801087c5:	e8 06 7d ff ff       	call   801004d0 <panic>
801087ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
801087d0:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801087d3:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
801087d9:	25 fc 0f 00 00       	and    $0xffc,%eax
801087de:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801087e5:	85 c0                	test   %eax,%eax
801087e7:	74 d4                	je     801087bd <loaduvm+0x4d>
    pa = PTE_ADDR(*pte);
801087e9:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
801087eb:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
801087ee:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
801087f3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
801087f8:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
801087fe:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80108801:	29 d9                	sub    %ebx,%ecx
80108803:	05 00 00 00 80       	add    $0x80000000,%eax
80108808:	57                   	push   %edi
80108809:	51                   	push   %ecx
8010880a:	50                   	push   %eax
8010880b:	ff 75 10             	push   0x10(%ebp)
8010880e:	e8 5d a3 ff ff       	call   80102b70 <readi>
80108813:	83 c4 10             	add    $0x10,%esp
80108816:	39 f8                	cmp    %edi,%eax
80108818:	75 1e                	jne    80108838 <loaduvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
8010881a:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
80108820:	89 f0                	mov    %esi,%eax
80108822:	29 d8                	sub    %ebx,%eax
80108824:	39 c6                	cmp    %eax,%esi
80108826:	77 80                	ja     801087a8 <loaduvm+0x38>
}
80108828:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010882b:	31 c0                	xor    %eax,%eax
}
8010882d:	5b                   	pop    %ebx
8010882e:	5e                   	pop    %esi
8010882f:	5f                   	pop    %edi
80108830:	5d                   	pop    %ebp
80108831:	c3                   	ret
80108832:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80108838:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010883b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80108840:	5b                   	pop    %ebx
80108841:	5e                   	pop    %esi
80108842:	5f                   	pop    %edi
80108843:	5d                   	pop    %ebp
80108844:	c3                   	ret
    panic("loaduvm: addr must be page aligned");
80108845:	83 ec 0c             	sub    $0xc,%esp
80108848:	68 e0 9a 10 80       	push   $0x80109ae0
8010884d:	e8 7e 7c ff ff       	call   801004d0 <panic>
80108852:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80108859:	00 
8010885a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108860 <allocuvm>:
{
80108860:	55                   	push   %ebp
80108861:	89 e5                	mov    %esp,%ebp
80108863:	57                   	push   %edi
80108864:	56                   	push   %esi
80108865:	53                   	push   %ebx
80108866:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80108869:	8b 45 10             	mov    0x10(%ebp),%eax
{
8010886c:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(newsz >= KERNBASE)
8010886f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80108872:	85 c0                	test   %eax,%eax
80108874:	0f 88 b6 00 00 00    	js     80108930 <allocuvm+0xd0>
  if(newsz < oldsz)
8010887a:	3b 45 0c             	cmp    0xc(%ebp),%eax
    return oldsz;
8010887d:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
80108880:	0f 82 9a 00 00 00    	jb     80108920 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
80108886:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
8010888c:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
80108892:	39 75 10             	cmp    %esi,0x10(%ebp)
80108895:	77 44                	ja     801088db <allocuvm+0x7b>
80108897:	e9 87 00 00 00       	jmp    80108923 <allocuvm+0xc3>
8010889c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
801088a0:	83 ec 04             	sub    $0x4,%esp
801088a3:	68 00 10 00 00       	push   $0x1000
801088a8:	6a 00                	push   $0x0
801088aa:	50                   	push   %eax
801088ab:	e8 d0 d4 ff ff       	call   80105d80 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801088b0:	58                   	pop    %eax
801088b1:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801088b7:	5a                   	pop    %edx
801088b8:	6a 06                	push   $0x6
801088ba:	b9 00 10 00 00       	mov    $0x1000,%ecx
801088bf:	89 f2                	mov    %esi,%edx
801088c1:	50                   	push   %eax
801088c2:	89 f8                	mov    %edi,%eax
801088c4:	e8 87 fb ff ff       	call   80108450 <mappages>
801088c9:	83 c4 10             	add    $0x10,%esp
801088cc:	85 c0                	test   %eax,%eax
801088ce:	78 78                	js     80108948 <allocuvm+0xe8>
  for(; a < newsz; a += PGSIZE){
801088d0:	81 c6 00 10 00 00    	add    $0x1000,%esi
801088d6:	39 75 10             	cmp    %esi,0x10(%ebp)
801088d9:	76 48                	jbe    80108923 <allocuvm+0xc3>
    mem = kalloc();
801088db:	e8 80 ae ff ff       	call   80103760 <kalloc>
801088e0:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
801088e2:	85 c0                	test   %eax,%eax
801088e4:	75 ba                	jne    801088a0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
801088e6:	83 ec 0c             	sub    $0xc,%esp
801088e9:	68 da 94 10 80       	push   $0x801094da
801088ee:	e8 dd 7e ff ff       	call   801007d0 <cprintf>
  if(newsz >= oldsz)
801088f3:	8b 45 0c             	mov    0xc(%ebp),%eax
801088f6:	83 c4 10             	add    $0x10,%esp
801088f9:	39 45 10             	cmp    %eax,0x10(%ebp)
801088fc:	74 32                	je     80108930 <allocuvm+0xd0>
801088fe:	8b 55 10             	mov    0x10(%ebp),%edx
80108901:	89 c1                	mov    %eax,%ecx
80108903:	89 f8                	mov    %edi,%eax
80108905:	e8 96 fa ff ff       	call   801083a0 <deallocuvm.part.0>
      return 0;
8010890a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80108911:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108914:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108917:	5b                   	pop    %ebx
80108918:	5e                   	pop    %esi
80108919:	5f                   	pop    %edi
8010891a:	5d                   	pop    %ebp
8010891b:	c3                   	ret
8010891c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80108920:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}
80108923:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108926:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108929:	5b                   	pop    %ebx
8010892a:	5e                   	pop    %esi
8010892b:	5f                   	pop    %edi
8010892c:	5d                   	pop    %ebp
8010892d:	c3                   	ret
8010892e:	66 90                	xchg   %ax,%ax
    return 0;
80108930:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80108937:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010893a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010893d:	5b                   	pop    %ebx
8010893e:	5e                   	pop    %esi
8010893f:	5f                   	pop    %edi
80108940:	5d                   	pop    %ebp
80108941:	c3                   	ret
80108942:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80108948:	83 ec 0c             	sub    $0xc,%esp
8010894b:	68 f2 94 10 80       	push   $0x801094f2
80108950:	e8 7b 7e ff ff       	call   801007d0 <cprintf>
  if(newsz >= oldsz)
80108955:	8b 45 0c             	mov    0xc(%ebp),%eax
80108958:	83 c4 10             	add    $0x10,%esp
8010895b:	39 45 10             	cmp    %eax,0x10(%ebp)
8010895e:	74 0c                	je     8010896c <allocuvm+0x10c>
80108960:	8b 55 10             	mov    0x10(%ebp),%edx
80108963:	89 c1                	mov    %eax,%ecx
80108965:	89 f8                	mov    %edi,%eax
80108967:	e8 34 fa ff ff       	call   801083a0 <deallocuvm.part.0>
      kfree(mem);
8010896c:	83 ec 0c             	sub    $0xc,%esp
8010896f:	53                   	push   %ebx
80108970:	e8 2b ac ff ff       	call   801035a0 <kfree>
      return 0;
80108975:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010897c:	83 c4 10             	add    $0x10,%esp
}
8010897f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108982:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108985:	5b                   	pop    %ebx
80108986:	5e                   	pop    %esi
80108987:	5f                   	pop    %edi
80108988:	5d                   	pop    %ebp
80108989:	c3                   	ret
8010898a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108990 <deallocuvm>:
{
80108990:	55                   	push   %ebp
80108991:	89 e5                	mov    %esp,%ebp
80108993:	8b 55 0c             	mov    0xc(%ebp),%edx
80108996:	8b 4d 10             	mov    0x10(%ebp),%ecx
80108999:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010899c:	39 d1                	cmp    %edx,%ecx
8010899e:	73 10                	jae    801089b0 <deallocuvm+0x20>
}
801089a0:	5d                   	pop    %ebp
801089a1:	e9 fa f9 ff ff       	jmp    801083a0 <deallocuvm.part.0>
801089a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801089ad:	00 
801089ae:	66 90                	xchg   %ax,%ax
801089b0:	89 d0                	mov    %edx,%eax
801089b2:	5d                   	pop    %ebp
801089b3:	c3                   	ret
801089b4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801089bb:	00 
801089bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801089c0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801089c0:	55                   	push   %ebp
801089c1:	89 e5                	mov    %esp,%ebp
801089c3:	57                   	push   %edi
801089c4:	56                   	push   %esi
801089c5:	53                   	push   %ebx
801089c6:	83 ec 0c             	sub    $0xc,%esp
801089c9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
801089cc:	85 f6                	test   %esi,%esi
801089ce:	74 59                	je     80108a29 <freevm+0x69>
  if(newsz >= oldsz)
801089d0:	31 c9                	xor    %ecx,%ecx
801089d2:	ba 00 00 00 80       	mov    $0x80000000,%edx
801089d7:	89 f0                	mov    %esi,%eax
801089d9:	89 f3                	mov    %esi,%ebx
801089db:	e8 c0 f9 ff ff       	call   801083a0 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801089e0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
801089e6:	eb 0f                	jmp    801089f7 <freevm+0x37>
801089e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801089ef:	00 
801089f0:	83 c3 04             	add    $0x4,%ebx
801089f3:	39 df                	cmp    %ebx,%edi
801089f5:	74 23                	je     80108a1a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
801089f7:	8b 03                	mov    (%ebx),%eax
801089f9:	a8 01                	test   $0x1,%al
801089fb:	74 f3                	je     801089f0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
801089fd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80108a02:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
80108a05:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80108a08:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80108a0d:	50                   	push   %eax
80108a0e:	e8 8d ab ff ff       	call   801035a0 <kfree>
80108a13:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80108a16:	39 df                	cmp    %ebx,%edi
80108a18:	75 dd                	jne    801089f7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80108a1a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80108a1d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108a20:	5b                   	pop    %ebx
80108a21:	5e                   	pop    %esi
80108a22:	5f                   	pop    %edi
80108a23:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80108a24:	e9 77 ab ff ff       	jmp    801035a0 <kfree>
    panic("freevm: no pgdir");
80108a29:	83 ec 0c             	sub    $0xc,%esp
80108a2c:	68 0e 95 10 80       	push   $0x8010950e
80108a31:	e8 9a 7a ff ff       	call   801004d0 <panic>
80108a36:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80108a3d:	00 
80108a3e:	66 90                	xchg   %ax,%ax

80108a40 <setupkvm>:
{
80108a40:	55                   	push   %ebp
80108a41:	89 e5                	mov    %esp,%ebp
80108a43:	56                   	push   %esi
80108a44:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80108a45:	e8 16 ad ff ff       	call   80103760 <kalloc>
80108a4a:	89 c6                	mov    %eax,%esi
80108a4c:	85 c0                	test   %eax,%eax
80108a4e:	74 42                	je     80108a92 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80108a50:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80108a53:	bb c0 c7 10 80       	mov    $0x8010c7c0,%ebx
  memset(pgdir, 0, PGSIZE);
80108a58:	68 00 10 00 00       	push   $0x1000
80108a5d:	6a 00                	push   $0x0
80108a5f:	50                   	push   %eax
80108a60:	e8 1b d3 ff ff       	call   80105d80 <memset>
80108a65:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80108a68:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80108a6b:	83 ec 08             	sub    $0x8,%esp
80108a6e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80108a71:	ff 73 0c             	push   0xc(%ebx)
80108a74:	8b 13                	mov    (%ebx),%edx
80108a76:	50                   	push   %eax
80108a77:	29 c1                	sub    %eax,%ecx
80108a79:	89 f0                	mov    %esi,%eax
80108a7b:	e8 d0 f9 ff ff       	call   80108450 <mappages>
80108a80:	83 c4 10             	add    $0x10,%esp
80108a83:	85 c0                	test   %eax,%eax
80108a85:	78 19                	js     80108aa0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80108a87:	83 c3 10             	add    $0x10,%ebx
80108a8a:	81 fb 00 c8 10 80    	cmp    $0x8010c800,%ebx
80108a90:	75 d6                	jne    80108a68 <setupkvm+0x28>
}
80108a92:	8d 65 f8             	lea    -0x8(%ebp),%esp
80108a95:	89 f0                	mov    %esi,%eax
80108a97:	5b                   	pop    %ebx
80108a98:	5e                   	pop    %esi
80108a99:	5d                   	pop    %ebp
80108a9a:	c3                   	ret
80108a9b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80108aa0:	83 ec 0c             	sub    $0xc,%esp
80108aa3:	56                   	push   %esi
      return 0;
80108aa4:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80108aa6:	e8 15 ff ff ff       	call   801089c0 <freevm>
      return 0;
80108aab:	83 c4 10             	add    $0x10,%esp
}
80108aae:	8d 65 f8             	lea    -0x8(%ebp),%esp
80108ab1:	89 f0                	mov    %esi,%eax
80108ab3:	5b                   	pop    %ebx
80108ab4:	5e                   	pop    %esi
80108ab5:	5d                   	pop    %ebp
80108ab6:	c3                   	ret
80108ab7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80108abe:	00 
80108abf:	90                   	nop

80108ac0 <kvmalloc>:
{
80108ac0:	55                   	push   %ebp
80108ac1:	89 e5                	mov    %esp,%ebp
80108ac3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80108ac6:	e8 75 ff ff ff       	call   80108a40 <setupkvm>
80108acb:	a3 d4 9c 34 80       	mov    %eax,0x80349cd4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80108ad0:	05 00 00 00 80       	add    $0x80000000,%eax
80108ad5:	0f 22 d8             	mov    %eax,%cr3
}
80108ad8:	c9                   	leave
80108ad9:	c3                   	ret
80108ada:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108ae0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80108ae0:	55                   	push   %ebp
80108ae1:	89 e5                	mov    %esp,%ebp
80108ae3:	83 ec 08             	sub    $0x8,%esp
80108ae6:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80108ae9:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80108aec:	89 c1                	mov    %eax,%ecx
80108aee:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80108af1:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80108af4:	f6 c2 01             	test   $0x1,%dl
80108af7:	75 17                	jne    80108b10 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80108af9:	83 ec 0c             	sub    $0xc,%esp
80108afc:	68 1f 95 10 80       	push   $0x8010951f
80108b01:	e8 ca 79 ff ff       	call   801004d0 <panic>
80108b06:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80108b0d:	00 
80108b0e:	66 90                	xchg   %ax,%ax
  return &pgtab[PTX(va)];
80108b10:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80108b13:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80108b19:	25 fc 0f 00 00       	and    $0xffc,%eax
80108b1e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
80108b25:	85 c0                	test   %eax,%eax
80108b27:	74 d0                	je     80108af9 <clearpteu+0x19>
  *pte &= ~PTE_U;
80108b29:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80108b2c:	c9                   	leave
80108b2d:	c3                   	ret
80108b2e:	66 90                	xchg   %ax,%ax

80108b30 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80108b30:	55                   	push   %ebp
80108b31:	89 e5                	mov    %esp,%ebp
80108b33:	57                   	push   %edi
80108b34:	56                   	push   %esi
80108b35:	53                   	push   %ebx
80108b36:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80108b39:	e8 02 ff ff ff       	call   80108a40 <setupkvm>
80108b3e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80108b41:	85 c0                	test   %eax,%eax
80108b43:	0f 84 bd 00 00 00    	je     80108c06 <copyuvm+0xd6>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80108b49:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80108b4c:	85 c9                	test   %ecx,%ecx
80108b4e:	0f 84 b2 00 00 00    	je     80108c06 <copyuvm+0xd6>
80108b54:	31 f6                	xor    %esi,%esi
80108b56:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80108b5d:	00 
80108b5e:	66 90                	xchg   %ax,%ax
  if(*pde & PTE_P){
80108b60:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
80108b63:	89 f0                	mov    %esi,%eax
80108b65:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80108b68:	8b 04 81             	mov    (%ecx,%eax,4),%eax
80108b6b:	a8 01                	test   $0x1,%al
80108b6d:	75 11                	jne    80108b80 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
80108b6f:	83 ec 0c             	sub    $0xc,%esp
80108b72:	68 29 95 10 80       	push   $0x80109529
80108b77:	e8 54 79 ff ff       	call   801004d0 <panic>
80108b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
80108b80:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80108b82:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80108b87:	c1 ea 0a             	shr    $0xa,%edx
80108b8a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80108b90:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80108b97:	85 c0                	test   %eax,%eax
80108b99:	74 d4                	je     80108b6f <copyuvm+0x3f>
    if(!(*pte & PTE_P))
80108b9b:	8b 00                	mov    (%eax),%eax
80108b9d:	a8 01                	test   $0x1,%al
80108b9f:	0f 84 9f 00 00 00    	je     80108c44 <copyuvm+0x114>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80108ba5:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
80108ba7:	25 ff 0f 00 00       	and    $0xfff,%eax
80108bac:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
80108baf:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80108bb5:	e8 a6 ab ff ff       	call   80103760 <kalloc>
80108bba:	89 c3                	mov    %eax,%ebx
80108bbc:	85 c0                	test   %eax,%eax
80108bbe:	74 64                	je     80108c24 <copyuvm+0xf4>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80108bc0:	83 ec 04             	sub    $0x4,%esp
80108bc3:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80108bc9:	68 00 10 00 00       	push   $0x1000
80108bce:	57                   	push   %edi
80108bcf:	50                   	push   %eax
80108bd0:	e8 4b d2 ff ff       	call   80105e20 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80108bd5:	58                   	pop    %eax
80108bd6:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80108bdc:	5a                   	pop    %edx
80108bdd:	ff 75 e4             	push   -0x1c(%ebp)
80108be0:	b9 00 10 00 00       	mov    $0x1000,%ecx
80108be5:	89 f2                	mov    %esi,%edx
80108be7:	50                   	push   %eax
80108be8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80108beb:	e8 60 f8 ff ff       	call   80108450 <mappages>
80108bf0:	83 c4 10             	add    $0x10,%esp
80108bf3:	85 c0                	test   %eax,%eax
80108bf5:	78 21                	js     80108c18 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
80108bf7:	81 c6 00 10 00 00    	add    $0x1000,%esi
80108bfd:	39 75 0c             	cmp    %esi,0xc(%ebp)
80108c00:	0f 87 5a ff ff ff    	ja     80108b60 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
80108c06:	8b 45 e0             	mov    -0x20(%ebp),%eax
80108c09:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108c0c:	5b                   	pop    %ebx
80108c0d:	5e                   	pop    %esi
80108c0e:	5f                   	pop    %edi
80108c0f:	5d                   	pop    %ebp
80108c10:	c3                   	ret
80108c11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80108c18:	83 ec 0c             	sub    $0xc,%esp
80108c1b:	53                   	push   %ebx
80108c1c:	e8 7f a9 ff ff       	call   801035a0 <kfree>
      goto bad;
80108c21:	83 c4 10             	add    $0x10,%esp
  freevm(d);
80108c24:	83 ec 0c             	sub    $0xc,%esp
80108c27:	ff 75 e0             	push   -0x20(%ebp)
80108c2a:	e8 91 fd ff ff       	call   801089c0 <freevm>
  return 0;
80108c2f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80108c36:	83 c4 10             	add    $0x10,%esp
}
80108c39:	8b 45 e0             	mov    -0x20(%ebp),%eax
80108c3c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108c3f:	5b                   	pop    %ebx
80108c40:	5e                   	pop    %esi
80108c41:	5f                   	pop    %edi
80108c42:	5d                   	pop    %ebp
80108c43:	c3                   	ret
      panic("copyuvm: page not present");
80108c44:	83 ec 0c             	sub    $0xc,%esp
80108c47:	68 43 95 10 80       	push   $0x80109543
80108c4c:	e8 7f 78 ff ff       	call   801004d0 <panic>
80108c51:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80108c58:	00 
80108c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80108c60 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80108c60:	55                   	push   %ebp
80108c61:	89 e5                	mov    %esp,%ebp
80108c63:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80108c66:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80108c69:	89 c1                	mov    %eax,%ecx
80108c6b:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80108c6e:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80108c71:	f6 c2 01             	test   $0x1,%dl
80108c74:	0f 84 5e 03 00 00    	je     80108fd8 <uva2ka.cold>
  return &pgtab[PTX(va)];
80108c7a:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80108c7d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80108c83:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
80108c84:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
80108c89:	8b 84 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%eax
  if((*pte & PTE_U) == 0)
80108c90:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80108c92:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80108c97:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80108c9a:	05 00 00 00 80       	add    $0x80000000,%eax
80108c9f:	83 fa 05             	cmp    $0x5,%edx
80108ca2:	ba 00 00 00 00       	mov    $0x0,%edx
80108ca7:	0f 45 c2             	cmovne %edx,%eax
}
80108caa:	c3                   	ret
80108cab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80108cb0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80108cb0:	55                   	push   %ebp
80108cb1:	89 e5                	mov    %esp,%ebp
80108cb3:	57                   	push   %edi
80108cb4:	56                   	push   %esi
80108cb5:	53                   	push   %ebx
80108cb6:	83 ec 0c             	sub    $0xc,%esp
80108cb9:	8b 75 14             	mov    0x14(%ebp),%esi
80108cbc:	8b 45 0c             	mov    0xc(%ebp),%eax
80108cbf:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80108cc2:	85 f6                	test   %esi,%esi
80108cc4:	75 51                	jne    80108d17 <copyout+0x67>
80108cc6:	e9 a5 00 00 00       	jmp    80108d70 <copyout+0xc0>
80108ccb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  return (char*)P2V(PTE_ADDR(*pte));
80108cd0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80108cd6:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
80108cdc:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
80108ce2:	74 75                	je     80108d59 <copyout+0xa9>
      return -1;
    n = PGSIZE - (va - va0);
80108ce4:	89 fb                	mov    %edi,%ebx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80108ce6:	89 55 10             	mov    %edx,0x10(%ebp)
    n = PGSIZE - (va - va0);
80108ce9:	29 c3                	sub    %eax,%ebx
80108ceb:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
80108cf1:	39 f3                	cmp    %esi,%ebx
80108cf3:	0f 47 de             	cmova  %esi,%ebx
    memmove(pa0 + (va - va0), buf, n);
80108cf6:	29 f8                	sub    %edi,%eax
80108cf8:	83 ec 04             	sub    $0x4,%esp
80108cfb:	01 c8                	add    %ecx,%eax
80108cfd:	53                   	push   %ebx
80108cfe:	52                   	push   %edx
80108cff:	50                   	push   %eax
80108d00:	e8 1b d1 ff ff       	call   80105e20 <memmove>
    len -= n;
    buf += n;
80108d05:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
80108d08:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
80108d0e:	83 c4 10             	add    $0x10,%esp
    buf += n;
80108d11:	01 da                	add    %ebx,%edx
  while(len > 0){
80108d13:	29 de                	sub    %ebx,%esi
80108d15:	74 59                	je     80108d70 <copyout+0xc0>
  if(*pde & PTE_P){
80108d17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
80108d1a:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80108d1c:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
80108d1e:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80108d21:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
80108d27:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
80108d2a:	f6 c1 01             	test   $0x1,%cl
80108d2d:	0f 84 ac 02 00 00    	je     80108fdf <copyout.cold>
  return &pgtab[PTX(va)];
80108d33:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80108d35:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80108d3b:	c1 eb 0c             	shr    $0xc,%ebx
80108d3e:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
80108d44:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
80108d4b:	89 d9                	mov    %ebx,%ecx
80108d4d:	83 e1 05             	and    $0x5,%ecx
80108d50:	83 f9 05             	cmp    $0x5,%ecx
80108d53:	0f 84 77 ff ff ff    	je     80108cd0 <copyout+0x20>
  }
  return 0;
}
80108d59:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80108d5c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80108d61:	5b                   	pop    %ebx
80108d62:	5e                   	pop    %esi
80108d63:	5f                   	pop    %edi
80108d64:	5d                   	pop    %ebp
80108d65:	c3                   	ret
80108d66:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80108d6d:	00 
80108d6e:	66 90                	xchg   %ax,%ax
80108d70:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80108d73:	31 c0                	xor    %eax,%eax
}
80108d75:	5b                   	pop    %ebx
80108d76:	5e                   	pop    %esi
80108d77:	5f                   	pop    %edi
80108d78:	5d                   	pop    %ebp
80108d79:	c3                   	ret
80108d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108d80 <open_sharedmem>:
struct shmemtable {
    struct shpage pages[NSHPAGE];
    struct spinlock lock;
} shmemtable;

char* open_sharedmem(int id) {
80108d80:	55                   	push   %ebp
80108d81:	89 e5                	mov    %esp,%ebp
80108d83:	57                   	push   %edi
80108d84:	56                   	push   %esi
80108d85:	53                   	push   %ebx
80108d86:	83 ec 1c             	sub    $0x1c,%esp
80108d89:	8b 75 08             	mov    0x8(%ebp),%esi
    struct proc* proc = myproc();
80108d8c:	e8 df bc ff ff       	call   80104a70 <myproc>
    acquire(&shmemtable.lock);
80108d91:	83 ec 0c             	sub    $0xc,%esp
80108d94:	68 a0 9c 34 80       	push   $0x80349ca0
    struct proc* proc = myproc();
80108d99:	89 c3                	mov    %eax,%ebx
    acquire(&shmemtable.lock);
80108d9b:	e8 20 cf ff ff       	call   80105cc0 <acquire>
    int size = PGSIZE;

    for (int i = 0; i < NSHPAGE; i++) {
80108da0:	b9 a0 99 34 80       	mov    $0x803499a0,%ecx
80108da5:	83 c4 10             	add    $0x10,%esp
80108da8:	31 c0                	xor    %eax,%eax
    acquire(&shmemtable.lock);
80108daa:	89 ca                	mov    %ecx,%edx
80108dac:	eb 0d                	jmp    80108dbb <open_sharedmem+0x3b>
80108dae:	66 90                	xchg   %ax,%ax
    for (int i = 0; i < NSHPAGE; i++) {
80108db0:	83 c0 01             	add    $0x1,%eax
80108db3:	83 c2 0c             	add    $0xc,%edx
80108db6:	83 f8 40             	cmp    $0x40,%eax
80108db9:	74 55                	je     80108e10 <open_sharedmem+0x90>
        if (shmemtable.pages[i].id == id) {
80108dbb:	39 32                	cmp    %esi,(%edx)
80108dbd:	75 f1                	jne    80108db0 <open_sharedmem+0x30>
            shmemtable.pages[i].n_access++;
80108dbf:	8d 04 40             	lea    (%eax,%eax,2),%eax
            char* vaddr = (char*)PGROUNDUP(proc->sz);
            if (mappages(proc->pgdir, vaddr, PGSIZE, shmemtable.pages[i].physicalAddr, PTE_W | PTE_U) < 0)
80108dc2:	83 ec 08             	sub    $0x8,%esp
80108dc5:	b9 00 10 00 00       	mov    $0x1000,%ecx
            shmemtable.pages[i].n_access++;
80108dca:	8d 04 85 a0 99 34 80 	lea    -0x7fcb6660(,%eax,4),%eax
80108dd1:	83 40 04 01          	addl   $0x1,0x4(%eax)
            char* vaddr = (char*)PGROUNDUP(proc->sz);
80108dd5:	8b 3b                	mov    (%ebx),%edi
80108dd7:	8d b7 ff 0f 00 00    	lea    0xfff(%edi),%esi
            if (mappages(proc->pgdir, vaddr, PGSIZE, shmemtable.pages[i].physicalAddr, PTE_W | PTE_U) < 0)
80108ddd:	8b 7b 04             	mov    0x4(%ebx),%edi
80108de0:	6a 06                	push   $0x6
80108de2:	ff 70 08             	push   0x8(%eax)
            char* vaddr = (char*)PGROUNDUP(proc->sz);
80108de5:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
            if (mappages(proc->pgdir, vaddr, PGSIZE, shmemtable.pages[i].physicalAddr, PTE_W | PTE_U) < 0)
80108deb:	89 f2                	mov    %esi,%edx
80108ded:	89 f8                	mov    %edi,%eax
80108def:	e8 5c f6 ff ff       	call   80108450 <mappages>
80108df4:	83 c4 10             	add    $0x10,%esp
80108df7:	85 c0                	test   %eax,%eax
80108df9:	0f 89 9e 00 00 00    	jns    80108e9d <open_sharedmem+0x11d>
    proc->shmemaddr = (uint)vaddr;
    proc->sz += size;

    release(&shmemtable.lock);
    return vaddr;
}
80108dff:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return (char*)(-1);
80108e02:	be ff ff ff ff       	mov    $0xffffffff,%esi
}
80108e07:	5b                   	pop    %ebx
80108e08:	89 f0                	mov    %esi,%eax
80108e0a:	5e                   	pop    %esi
80108e0b:	5f                   	pop    %edi
80108e0c:	5d                   	pop    %ebp
80108e0d:	c3                   	ret
80108e0e:	66 90                	xchg   %ax,%ax
    for (int i = 0; i < NSHPAGE; i++) {
80108e10:	31 c0                	xor    %eax,%eax
80108e12:	eb 13                	jmp    80108e27 <open_sharedmem+0xa7>
80108e14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80108e18:	83 c0 01             	add    $0x1,%eax
80108e1b:	83 c1 0c             	add    $0xc,%ecx
80108e1e:	83 f8 40             	cmp    $0x40,%eax
80108e21:	0f 84 9c 00 00 00    	je     80108ec3 <open_sharedmem+0x143>
        if (shmemtable.pages[i].id == 0) {
80108e27:	8b 11                	mov    (%ecx),%edx
80108e29:	85 d2                	test   %edx,%edx
80108e2b:	75 eb                	jne    80108e18 <open_sharedmem+0x98>
            shmemtable.pages[i].id = id;
80108e2d:	8d 04 40             	lea    (%eax,%eax,2),%eax
80108e30:	c1 e0 02             	shl    $0x2,%eax
80108e33:	89 b0 a0 99 34 80    	mov    %esi,-0x7fcb6660(%eax)
80108e39:	8d b8 a0 99 34 80    	lea    -0x7fcb6660(%eax),%edi
    char* paddr = kalloc();
80108e3f:	e8 1c a9 ff ff       	call   80103760 <kalloc>
    if (paddr == 0) {
80108e44:	85 c0                	test   %eax,%eax
80108e46:	0f 84 98 00 00 00    	je     80108ee4 <open_sharedmem+0x164>
    memset(paddr, 0, PGSIZE);
80108e4c:	83 ec 04             	sub    $0x4,%esp
80108e4f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80108e52:	68 00 10 00 00       	push   $0x1000
80108e57:	6a 00                	push   $0x0
80108e59:	50                   	push   %eax
80108e5a:	e8 21 cf ff ff       	call   80105d80 <memset>
    shmemtable.pages[pgidx].physicalAddr = (uint)V2P(paddr);
80108e5f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    char* vaddr = (char*)PGROUNDUP(proc->sz);
80108e62:	8b 03                	mov    (%ebx),%eax
    if (mappages(proc->pgdir, vaddr, PGSIZE, shmemtable.pages[pgidx].physicalAddr, PTE_W | PTE_U) < 0)
80108e64:	83 c4 08             	add    $0x8,%esp
80108e67:	b9 00 10 00 00       	mov    $0x1000,%ecx
    shmemtable.pages[pgidx].physicalAddr = (uint)V2P(paddr);
80108e6c:	81 c2 00 00 00 80    	add    $0x80000000,%edx
    char* vaddr = (char*)PGROUNDUP(proc->sz);
80108e72:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
    shmemtable.pages[pgidx].physicalAddr = (uint)V2P(paddr);
80108e78:	89 57 08             	mov    %edx,0x8(%edi)
    if (mappages(proc->pgdir, vaddr, PGSIZE, shmemtable.pages[pgidx].physicalAddr, PTE_W | PTE_U) < 0)
80108e7b:	8b 43 04             	mov    0x4(%ebx),%eax
    char* vaddr = (char*)PGROUNDUP(proc->sz);
80108e7e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    if (mappages(proc->pgdir, vaddr, PGSIZE, shmemtable.pages[pgidx].physicalAddr, PTE_W | PTE_U) < 0)
80108e84:	6a 06                	push   $0x6
80108e86:	52                   	push   %edx
80108e87:	89 f2                	mov    %esi,%edx
80108e89:	e8 c2 f5 ff ff       	call   80108450 <mappages>
80108e8e:	83 c4 10             	add    $0x10,%esp
80108e91:	85 c0                	test   %eax,%eax
80108e93:	0f 88 66 ff ff ff    	js     80108dff <open_sharedmem+0x7f>
    shmemtable.pages[pgidx].n_access++;
80108e99:	83 47 04 01          	addl   $0x1,0x4(%edi)
    proc->sz += size;
80108e9d:	81 03 00 10 00 00    	addl   $0x1000,(%ebx)
    release(&shmemtable.lock);
80108ea3:	83 ec 0c             	sub    $0xc,%esp
    proc->shmemaddr = (uint)vaddr;
80108ea6:	89 b3 20 8d 00 00    	mov    %esi,0x8d20(%ebx)
    release(&shmemtable.lock);
80108eac:	68 a0 9c 34 80       	push   $0x80349ca0
80108eb1:	e8 aa cd ff ff       	call   80105c60 <release>
    return vaddr;
80108eb6:	83 c4 10             	add    $0x10,%esp
}
80108eb9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108ebc:	89 f0                	mov    %esi,%eax
80108ebe:	5b                   	pop    %ebx
80108ebf:	5e                   	pop    %esi
80108ec0:	5f                   	pop    %edi
80108ec1:	5d                   	pop    %ebp
80108ec2:	c3                   	ret
        cprintf("shared memory: pages are full\n");
80108ec3:	83 ec 0c             	sub    $0xc,%esp
80108ec6:	68 04 9b 10 80       	push   $0x80109b04
80108ecb:	e8 00 79 ff ff       	call   801007d0 <cprintf>
        release(&shmemtable.lock);
80108ed0:	c7 04 24 a0 9c 34 80 	movl   $0x80349ca0,(%esp)
80108ed7:	e8 84 cd ff ff       	call   80105c60 <release>
        return (char*)(-1);
80108edc:	83 c4 10             	add    $0x10,%esp
80108edf:	e9 1b ff ff ff       	jmp    80108dff <open_sharedmem+0x7f>
        cprintf("shared memory: out of memory\n");
80108ee4:	83 ec 0c             	sub    $0xc,%esp
80108ee7:	68 5d 95 10 80       	push   $0x8010955d
80108eec:	eb dd                	jmp    80108ecb <open_sharedmem+0x14b>
80108eee:	66 90                	xchg   %ax,%ax

80108ef0 <close_sharedmem>:

int close_sharedmem(int id) {
80108ef0:	55                   	push   %ebp
80108ef1:	89 e5                	mov    %esp,%ebp
80108ef3:	56                   	push   %esi
80108ef4:	53                   	push   %ebx
80108ef5:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct proc* proc = myproc();
80108ef8:	e8 73 bb ff ff       	call   80104a70 <myproc>
    acquire(&shmemtable.lock);
80108efd:	83 ec 0c             	sub    $0xc,%esp
80108f00:	68 a0 9c 34 80       	push   $0x80349ca0
    struct proc* proc = myproc();
80108f05:	89 c6                	mov    %eax,%esi
    acquire(&shmemtable.lock);
80108f07:	e8 b4 cd ff ff       	call   80105cc0 <acquire>

    for (int i = 0; i < NSHPAGE; i++) {
80108f0c:	ba a0 99 34 80       	mov    $0x803499a0,%edx
80108f11:	83 c4 10             	add    $0x10,%esp
80108f14:	31 c0                	xor    %eax,%eax
80108f16:	eb 17                	jmp    80108f2f <close_sharedmem+0x3f>
80108f18:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80108f1f:	00 
80108f20:	83 c0 01             	add    $0x1,%eax
80108f23:	83 c2 0c             	add    $0xc,%edx
80108f26:	83 f8 40             	cmp    $0x40,%eax
80108f29:	0f 84 81 00 00 00    	je     80108fb0 <close_sharedmem+0xc0>
        if (shmemtable.pages[i].id == id) {
80108f2f:	39 1a                	cmp    %ebx,(%edx)
80108f31:	75 ed                	jne    80108f20 <close_sharedmem+0x30>
            shmemtable.pages[i].n_access--;
80108f33:	8d 14 40             	lea    (%eax,%eax,2),%edx

            uint a = (uint)PGROUNDUP(proc->shmemaddr);
80108f36:	8b 86 20 8d 00 00    	mov    0x8d20(%esi),%eax
            shmemtable.pages[i].n_access--;
80108f3c:	c1 e2 02             	shl    $0x2,%edx
80108f3f:	83 aa a4 99 34 80 01 	subl   $0x1,-0x7fcb665c(%edx)
            uint a = (uint)PGROUNDUP(proc->shmemaddr);
80108f46:	05 ff 0f 00 00       	add    $0xfff,%eax
  if(*pde & PTE_P){
80108f4b:	8b 76 04             	mov    0x4(%esi),%esi
            uint a = (uint)PGROUNDUP(proc->shmemaddr);
80108f4e:	89 c1                	mov    %eax,%ecx
  pde = &pgdir[PDX(va)];
80108f50:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80108f53:	8b 04 86             	mov    (%esi,%eax,4),%eax
            uint a = (uint)PGROUNDUP(proc->shmemaddr);
80108f56:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  if(*pde & PTE_P){
80108f5c:	a8 01                	test   $0x1,%al
80108f5e:	0f 84 82 00 00 00    	je     80108fe6 <close_sharedmem.cold>
  return &pgtab[PTX(va)];
80108f64:	c1 e9 0c             	shr    $0xc,%ecx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80108f67:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80108f6c:	81 e1 ff 03 00 00    	and    $0x3ff,%ecx
            pte_t* pte = walkpgdir(proc->pgdir, (char*)a, 0);
            *pte = 0;
80108f72:	c7 84 88 00 00 00 80 	movl   $0x0,-0x80000000(%eax,%ecx,4)
80108f79:	00 00 00 00 

            if (shmemtable.pages[i].n_access == 0)
80108f7d:	8b 82 a4 99 34 80    	mov    -0x7fcb665c(%edx),%eax
80108f83:	85 c0                	test   %eax,%eax
80108f85:	74 19                	je     80108fa0 <close_sharedmem+0xb0>
                shmemtable.pages[i].id = 0;

            release(&shmemtable.lock);
80108f87:	83 ec 0c             	sub    $0xc,%esp
80108f8a:	68 a0 9c 34 80       	push   $0x80349ca0
80108f8f:	e8 cc cc ff ff       	call   80105c60 <release>
            return 0;
80108f94:	83 c4 10             	add    $0x10,%esp
    }

    release(&shmemtable.lock);
    cprintf("No shared memory with this ID.\n");
    return -1;
}
80108f97:	8d 65 f8             	lea    -0x8(%ebp),%esp
            return 0;
80108f9a:	31 c0                	xor    %eax,%eax
}
80108f9c:	5b                   	pop    %ebx
80108f9d:	5e                   	pop    %esi
80108f9e:	5d                   	pop    %ebp
80108f9f:	c3                   	ret
                shmemtable.pages[i].id = 0;
80108fa0:	c7 82 a0 99 34 80 00 	movl   $0x0,-0x7fcb6660(%edx)
80108fa7:	00 00 00 
80108faa:	eb db                	jmp    80108f87 <close_sharedmem+0x97>
80108fac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    release(&shmemtable.lock);
80108fb0:	83 ec 0c             	sub    $0xc,%esp
80108fb3:	68 a0 9c 34 80       	push   $0x80349ca0
80108fb8:	e8 a3 cc ff ff       	call   80105c60 <release>
    cprintf("No shared memory with this ID.\n");
80108fbd:	c7 04 24 24 9b 10 80 	movl   $0x80109b24,(%esp)
80108fc4:	e8 07 78 ff ff       	call   801007d0 <cprintf>
    return -1;
80108fc9:	83 c4 10             	add    $0x10,%esp
}
80108fcc:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80108fcf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80108fd4:	5b                   	pop    %ebx
80108fd5:	5e                   	pop    %esi
80108fd6:	5d                   	pop    %ebp
80108fd7:	c3                   	ret

80108fd8 <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
80108fd8:	a1 00 00 00 00       	mov    0x0,%eax
80108fdd:	0f 0b                	ud2

80108fdf <copyout.cold>:
80108fdf:	a1 00 00 00 00       	mov    0x0,%eax
80108fe4:	0f 0b                	ud2

80108fe6 <close_sharedmem.cold>:
            *pte = 0;
80108fe6:	c7 05 00 00 00 00 00 	movl   $0x0,0x0
80108fed:	00 00 00 
80108ff0:	0f 0b                	ud2
