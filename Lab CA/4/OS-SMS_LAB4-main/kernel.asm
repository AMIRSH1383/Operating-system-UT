
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
80100015:	b8 00 c0 10 00       	mov    $0x10c000,%eax
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
80100028:	bc 70 c1 34 80       	mov    $0x8034c170,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 b0 3f 10 80       	mov    $0x80103fb0,%eax
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
80100044:	bb f4 d8 10 80       	mov    $0x8010d8f4,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 20 97 10 80       	push   $0x80109720
80100051:	68 c0 d8 10 80       	push   $0x8010d8c0
80100056:	e8 f5 5c 00 00       	call   80105d50 <initlock>
  bcache.head.next = &bcache.head;
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 bc 1f 11 80       	mov    $0x80111fbc,%eax
  bcache.head.prev = &bcache.head;
80100063:	c7 05 0c 20 11 80 bc 	movl   $0x80111fbc,0x8011200c
8010006a:	1f 11 80 
  bcache.head.next = &bcache.head;
8010006d:	c7 05 10 20 11 80 bc 	movl   $0x80111fbc,0x80112010
80100074:	1f 11 80 
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
8010008b:	c7 43 50 bc 1f 11 80 	movl   $0x80111fbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 27 97 10 80       	push   $0x80109727
80100097:	50                   	push   %eax
80100098:	e8 83 5b 00 00       	call   80105c20 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 10 20 11 80       	mov    0x80112010,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 10 20 11 80    	mov    %ebx,0x80112010
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb 60 1d 11 80    	cmp    $0x80111d60,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
  }
}
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave  
801000c2:	c3                   	ret    
801000c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

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
801000df:	68 c0 d8 10 80       	push   $0x8010d8c0
801000e4:	e8 37 5e 00 00       	call   80105f20 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 10 20 11 80    	mov    0x80112010,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb bc 1f 11 80    	cmp    $0x80111fbc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc 1f 11 80    	cmp    $0x80111fbc,%ebx
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
8010011b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010011f:	90                   	nop
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 0c 20 11 80    	mov    0x8011200c,%ebx
80100126:	81 fb bc 1f 11 80    	cmp    $0x80111fbc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 6e                	jmp    8010019e <bread+0xce>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc 1f 11 80    	cmp    $0x80111fbc,%ebx
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
8010015d:	68 c0 d8 10 80       	push   $0x8010d8c0
80100162:	e8 59 5d 00 00       	call   80105ec0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 ee 5a 00 00       	call   80105c60 <acquiresleep>
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
8010018c:	e8 9f 30 00 00       	call   80103230 <iderw>
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
801001a1:	68 2e 97 10 80       	push   $0x8010972e
801001a6:	e8 25 03 00 00       	call   801004d0 <panic>
801001ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801001af:	90                   	nop

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
801001be:	e8 3d 5b 00 00       	call   80105d00 <holdingsleep>
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
801001d4:	e9 57 30 00 00       	jmp    80103230 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 3f 97 10 80       	push   $0x8010973f
801001e1:	e8 ea 02 00 00       	call   801004d0 <panic>
801001e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801001ed:	8d 76 00             	lea    0x0(%esi),%esi

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
801001ff:	e8 fc 5a 00 00       	call   80105d00 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 66                	je     80100271 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 ac 5a 00 00       	call   80105cc0 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 c0 d8 10 80 	movl   $0x8010d8c0,(%esp)
8010021b:	e8 00 5d 00 00       	call   80105f20 <acquire>
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
80100242:	a1 10 20 11 80       	mov    0x80112010,%eax
    b->prev = &bcache.head;
80100247:	c7 43 50 bc 1f 11 80 	movl   $0x80111fbc,0x50(%ebx)
    b->next = bcache.head.next;
8010024e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100251:	a1 10 20 11 80       	mov    0x80112010,%eax
80100256:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100259:	89 1d 10 20 11 80    	mov    %ebx,0x80112010
  }
  
  release(&bcache.lock);
8010025f:	c7 45 08 c0 d8 10 80 	movl   $0x8010d8c0,0x8(%ebp)
}
80100266:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100269:	5b                   	pop    %ebx
8010026a:	5e                   	pop    %esi
8010026b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010026c:	e9 4f 5c 00 00       	jmp    80105ec0 <release>
    panic("brelse");
80100271:	83 ec 0c             	sub    $0xc,%esp
80100274:	68 46 97 10 80       	push   $0x80109746
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
80100294:	e8 17 25 00 00       	call   801027b0 <iunlock>
  acquire(&cons.lock);
80100299:	c7 04 24 c0 27 11 80 	movl   $0x801127c0,(%esp)
801002a0:	e8 7b 5c 00 00       	call   80105f20 <acquire>
  while(n > 0){
801002a5:	83 c4 10             	add    $0x10,%esp
801002a8:	85 db                	test   %ebx,%ebx
801002aa:	0f 8e 94 00 00 00    	jle    80100344 <consoleread+0xc4>
    while(input.r == input.w){
801002b0:	a1 a4 22 11 80       	mov    0x801122a4,%eax
801002b5:	3b 05 a8 22 11 80    	cmp    0x801122a8,%eax
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
801002c3:	68 c0 27 11 80       	push   $0x801127c0
801002c8:	68 a4 22 11 80       	push   $0x801122a4
801002cd:	e8 5e 4d 00 00       	call   80105030 <sleep>
    while(input.r == input.w){
801002d2:	a1 a4 22 11 80       	mov    0x801122a4,%eax
801002d7:	83 c4 10             	add    $0x10,%esp
801002da:	3b 05 a8 22 11 80    	cmp    0x801122a8,%eax
801002e0:	75 36                	jne    80100318 <consoleread+0x98>
      if(myproc()->killed){
801002e2:	e8 69 46 00 00       	call   80104950 <myproc>
801002e7:	8b 48 24             	mov    0x24(%eax),%ecx
801002ea:	85 c9                	test   %ecx,%ecx
801002ec:	74 d2                	je     801002c0 <consoleread+0x40>
        release(&cons.lock);
801002ee:	83 ec 0c             	sub    $0xc,%esp
801002f1:	68 c0 27 11 80       	push   $0x801127c0
801002f6:	e8 c5 5b 00 00       	call   80105ec0 <release>
        ilock(ip);
801002fb:	5a                   	pop    %edx
801002fc:	ff 75 08             	push   0x8(%ebp)
801002ff:	e8 cc 23 00 00       	call   801026d0 <ilock>
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
8010031b:	89 15 a4 22 11 80    	mov    %edx,0x801122a4
80100321:	89 c2                	mov    %eax,%edx
80100323:	83 e2 7f             	and    $0x7f,%edx
80100326:	0f be 8a 24 22 11 80 	movsbl -0x7feedddc(%edx),%ecx
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
80100347:	68 c0 27 11 80       	push   $0x801127c0
8010034c:	e8 6f 5b 00 00       	call   80105ec0 <release>
  ilock(ip);
80100351:	58                   	pop    %eax
80100352:	ff 75 08             	push   0x8(%ebp)
80100355:	e8 76 23 00 00       	call   801026d0 <ilock>
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
8010036d:	a3 a4 22 11 80       	mov    %eax,0x801122a4
80100372:	eb d0                	jmp    80100344 <consoleread+0xc4>
80100374:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010037b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010037f:	90                   	nop

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
8010038c:	e8 7f 5f 00 00       	call   80106310 <strlen>
80100391:	c7 45 e0 7f 00 00 00 	movl   $0x7f,-0x20(%ebp)
80100398:	83 c4 10             	add    $0x10,%esp
8010039b:	c7 45 e4 7f 00 00 00 	movl   $0x7f,-0x1c(%ebp)
801003a2:	3d 80 00 00 00       	cmp    $0x80,%eax
801003a7:	0f 8e 8b 00 00 00    	jle    80100438 <add_history.part.0+0xb8>
    if(num_of_stored_commands < MAX_NUM_OF_HISTORY)
801003ad:	a1 b4 22 11 80       	mov    0x801122b4,%eax
801003b2:	83 f8 09             	cmp    $0x9,%eax
801003b5:	7f 49                	jg     80100400 <add_history.part.0+0x80>
      num_of_stored_commands++;
801003b7:	8d 50 01             	lea    0x1(%eax),%edx
801003ba:	89 15 b4 22 11 80    	mov    %edx,0x801122b4
    memmove(command_history[num_of_stored_commands-1], command, sizeof(char)* length);
801003c0:	c1 e0 07             	shl    $0x7,%eax
801003c3:	83 ec 04             	sub    $0x4,%esp
801003c6:	ff 75 e0             	push   -0x20(%ebp)
801003c9:	05 c0 22 11 80       	add    $0x801122c0,%eax
801003ce:	53                   	push   %ebx
801003cf:	50                   	push   %eax
801003d0:	e8 db 5d 00 00       	call   801061b0 <memmove>
    command_history[num_of_stored_commands-1][length] = '\0';
801003d5:	a1 b4 22 11 80       	mov    0x801122b4,%eax
801003da:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
}
801003dd:	83 c4 10             	add    $0x10,%esp
    command_history[num_of_stored_commands-1][length] = '\0';
801003e0:	83 e8 01             	sub    $0x1,%eax
801003e3:	89 c2                	mov    %eax,%edx
    command_id = num_of_stored_commands - 1;
801003e5:	a3 b8 22 11 80       	mov    %eax,0x801122b8
    command_history[num_of_stored_commands-1][length] = '\0';
801003ea:	c1 e2 07             	shl    $0x7,%edx
801003ed:	c6 84 11 c0 22 11 80 	movb   $0x0,-0x7feedd40(%ecx,%edx,1)
801003f4:	00 
}
801003f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801003f8:	5b                   	pop    %ebx
801003f9:	5e                   	pop    %esi
801003fa:	5f                   	pop    %edi
801003fb:	5d                   	pop    %ebp
801003fc:	c3                   	ret    
801003fd:	8d 76 00             	lea    0x0(%esi),%esi
80100400:	bf c0 22 11 80       	mov    $0x801122c0,%edi
80100405:	be 40 27 11 80       	mov    $0x80112740,%esi
8010040a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        memmove(command_history[i], command_history[i+1], sizeof(char)* MAX_LEN_OF_COMMAND);
80100410:	83 ec 04             	sub    $0x4,%esp
80100413:	89 f8                	mov    %edi,%eax
80100415:	83 ef 80             	sub    $0xffffff80,%edi
80100418:	68 80 00 00 00       	push   $0x80
8010041d:	57                   	push   %edi
8010041e:	50                   	push   %eax
8010041f:	e8 8c 5d 00 00       	call   801061b0 <memmove>
      for(int i = 0; i < MAX_NUM_OF_HISTORY - 1; i++)
80100424:	83 c4 10             	add    $0x10,%esp
80100427:	39 fe                	cmp    %edi,%esi
80100429:	75 e5                	jne    80100410 <add_history.part.0+0x90>
    memmove(command_history[num_of_stored_commands-1], command, sizeof(char)* length);
8010042b:	a1 b4 22 11 80       	mov    0x801122b4,%eax
80100430:	83 e8 01             	sub    $0x1,%eax
80100433:	eb 8b                	jmp    801003c0 <add_history.part.0+0x40>
80100435:	8d 76 00             	lea    0x0(%esi),%esi
    int length = strlen(command) <= MAX_LEN_OF_COMMAND ? strlen(command) : MAX_LEN_OF_COMMAND - 1;
80100438:	83 ec 0c             	sub    $0xc,%esp
8010043b:	53                   	push   %ebx
8010043c:	e8 cf 5e 00 00       	call   80106310 <strlen>
80100441:	83 c4 10             	add    $0x10,%esp
80100444:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    memmove(command_history[num_of_stored_commands-1], command, sizeof(char)* length);
80100447:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010044a:	e9 5e ff ff ff       	jmp    801003ad <add_history.part.0+0x2d>
8010044f:	90                   	nop

80100450 <detect_math_expression.part.0>:
  if (c == '?' && input.buf[(input.position-1) % INPUT_BUF] == '=') {
80100450:	8b 15 20 22 11 80    	mov    0x80112220,%edx
  return 0;
80100456:	31 c9                	xor    %ecx,%ecx
  if (c == '?' && input.buf[(input.position-1) % INPUT_BUF] == '=') {
80100458:	8d 42 ff             	lea    -0x1(%edx),%eax
8010045b:	83 e0 7f             	and    $0x7f,%eax
8010045e:	80 b8 24 22 11 80 3d 	cmpb   $0x3d,-0x7feedddc(%eax)
80100465:	74 09                	je     80100470 <detect_math_expression.part.0+0x20>
}
80100467:	89 c8                	mov    %ecx,%eax
80100469:	c3                   	ret    
8010046a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if (isdigit(input.buf[(input.position-2) % INPUT_BUF])) {
80100470:	8d 42 fe             	lea    -0x2(%edx),%eax
80100473:	83 e0 7f             	and    $0x7f,%eax
80100476:	0f b6 80 24 22 11 80 	movzbl -0x7feedddc(%eax),%eax
8010047d:	83 e8 30             	sub    $0x30,%eax
80100480:	3c 09                	cmp    $0x9,%al
80100482:	77 e3                	ja     80100467 <detect_math_expression.part.0+0x17>
      char operator = input.buf[(input.position-3) % INPUT_BUF];
80100484:	8d 42 fd             	lea    -0x3(%edx),%eax
int detect_math_expression(char c) {
80100487:	55                   	push   %ebp
      char operator = input.buf[(input.position-3) % INPUT_BUF];
80100488:	83 e0 7f             	and    $0x7f,%eax
8010048b:	0f b6 80 24 22 11 80 	movzbl -0x7feedddc(%eax),%eax
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
801004ae:	0f b6 82 24 22 11 80 	movzbl -0x7feedddc(%edx),%eax
801004b5:	83 e8 30             	sub    $0x30,%eax
801004b8:	3c 09                	cmp    $0x9,%al
801004ba:	0f 96 c1             	setbe  %cl
}
801004bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801004c0:	89 c8                	mov    %ecx,%eax
801004c2:	c9                   	leave  
801004c3:	c3                   	ret    
801004c4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801004cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801004cf:	90                   	nop

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
801004d9:	c7 05 f4 27 11 80 00 	movl   $0x0,0x801127f4
801004e0:	00 00 00 
  getcallerpcs(&s, pcs);
801004e3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801004e6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801004e9:	e8 52 33 00 00       	call   80103840 <lapicid>
801004ee:	83 ec 08             	sub    $0x8,%esp
801004f1:	50                   	push   %eax
801004f2:	68 4d 97 10 80       	push   $0x8010974d
801004f7:	e8 f4 02 00 00       	call   801007f0 <cprintf>
  cprintf(s);
801004fc:	58                   	pop    %eax
801004fd:	ff 75 08             	push   0x8(%ebp)
80100500:	e8 eb 02 00 00       	call   801007f0 <cprintf>
  cprintf("\n");
80100505:	c7 04 24 b0 a3 10 80 	movl   $0x8010a3b0,(%esp)
8010050c:	e8 df 02 00 00       	call   801007f0 <cprintf>
  getcallerpcs(&s, pcs);
80100511:	8d 45 08             	lea    0x8(%ebp),%eax
80100514:	5a                   	pop    %edx
80100515:	59                   	pop    %ecx
80100516:	53                   	push   %ebx
80100517:	50                   	push   %eax
80100518:	e8 53 58 00 00       	call   80105d70 <getcallerpcs>
  for(i=0; i<10; i++)
8010051d:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
80100520:	83 ec 08             	sub    $0x8,%esp
80100523:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
80100525:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
80100528:	68 61 97 10 80       	push   $0x80109761
8010052d:	e8 be 02 00 00       	call   801007f0 <cprintf>
  for(i=0; i<10; i++)
80100532:	83 c4 10             	add    $0x10,%esp
80100535:	39 f3                	cmp    %esi,%ebx
80100537:	75 e7                	jne    80100520 <panic+0x50>
  panicked = 1; // freeze other CPU
80100539:	c7 05 f8 27 11 80 01 	movl   $0x1,0x801127f8
80100540:	00 00 00 
  for(;;)
80100543:	eb fe                	jmp    80100543 <panic+0x73>
80100545:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010054c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100550 <consputc.part.0>:
consputc(int c)
80100550:	55                   	push   %ebp
80100551:	89 e5                	mov    %esp,%ebp
80100553:	57                   	push   %edi
80100554:	56                   	push   %esi
80100555:	53                   	push   %ebx
80100556:	89 c3                	mov    %eax,%ebx
80100558:	83 ec 1c             	sub    $0x1c,%esp
  if(c == BACKSPACE){
8010055b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100560:	0f 84 ea 00 00 00    	je     80100650 <consputc.part.0+0x100>
    uartputc(c);
80100566:	83 ec 0c             	sub    $0xc,%esp
80100569:	50                   	push   %eax
8010056a:	e8 d1 7c 00 00       	call   80108240 <uartputc>
8010056f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100572:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100577:	b8 0e 00 00 00       	mov    $0xe,%eax
8010057c:	89 fa                	mov    %edi,%edx
8010057e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010057f:	be d5 03 00 00       	mov    $0x3d5,%esi
80100584:	89 f2                	mov    %esi,%edx
80100586:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100587:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010058a:	89 fa                	mov    %edi,%edx
8010058c:	b8 0f 00 00 00       	mov    $0xf,%eax
80100591:	c1 e1 08             	shl    $0x8,%ecx
80100594:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100595:	89 f2                	mov    %esi,%edx
80100597:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100598:	0f b6 c0             	movzbl %al,%eax
8010059b:	09 c8                	or     %ecx,%eax
  if(c == '\n')
8010059d:	83 fb 0a             	cmp    $0xa,%ebx
801005a0:	0f 84 92 00 00 00    	je     80100638 <consputc.part.0+0xe8>
  else if(c == BACKSPACE){
801005a6:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
801005ac:	74 72                	je     80100620 <consputc.part.0+0xd0>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
801005ae:	0f b6 db             	movzbl %bl,%ebx
801005b1:	8d 70 01             	lea    0x1(%eax),%esi
801005b4:	80 cf 07             	or     $0x7,%bh
801005b7:	66 89 9c 00 00 80 0b 	mov    %bx,-0x7ff48000(%eax,%eax,1)
801005be:	80 
  if(pos < 0 || pos > 25*80)
801005bf:	81 fe d0 07 00 00    	cmp    $0x7d0,%esi
801005c5:	0f 8f fb 00 00 00    	jg     801006c6 <consputc.part.0+0x176>
  if((pos/80) >= 24){  // Scroll up.
801005cb:	81 fe 7f 07 00 00    	cmp    $0x77f,%esi
801005d1:	0f 8f a9 00 00 00    	jg     80100680 <consputc.part.0+0x130>
  outb(CRTPORT+1, pos>>8);
801005d7:	89 f0                	mov    %esi,%eax
  crt[pos] = ' ' | 0x0700;
801005d9:	8d b4 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%esi
  outb(CRTPORT+1, pos);
801005e0:	88 45 e7             	mov    %al,-0x19(%ebp)
  outb(CRTPORT+1, pos>>8);
801005e3:	0f b6 fc             	movzbl %ah,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801005e6:	bb d4 03 00 00       	mov    $0x3d4,%ebx
801005eb:	b8 0e 00 00 00       	mov    $0xe,%eax
801005f0:	89 da                	mov    %ebx,%edx
801005f2:	ee                   	out    %al,(%dx)
801005f3:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
801005f8:	89 f8                	mov    %edi,%eax
801005fa:	89 ca                	mov    %ecx,%edx
801005fc:	ee                   	out    %al,(%dx)
801005fd:	b8 0f 00 00 00       	mov    $0xf,%eax
80100602:	89 da                	mov    %ebx,%edx
80100604:	ee                   	out    %al,(%dx)
80100605:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80100609:	89 ca                	mov    %ecx,%edx
8010060b:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
8010060c:	b8 20 07 00 00       	mov    $0x720,%eax
80100611:	66 89 06             	mov    %ax,(%esi)
}
80100614:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100617:	5b                   	pop    %ebx
80100618:	5e                   	pop    %esi
80100619:	5f                   	pop    %edi
8010061a:	5d                   	pop    %ebp
8010061b:	c3                   	ret    
8010061c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(pos > 0) --pos;
80100620:	8d 70 ff             	lea    -0x1(%eax),%esi
80100623:	85 c0                	test   %eax,%eax
80100625:	75 98                	jne    801005bf <consputc.part.0+0x6f>
80100627:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
8010062b:	be 00 80 0b 80       	mov    $0x800b8000,%esi
80100630:	31 ff                	xor    %edi,%edi
80100632:	eb b2                	jmp    801005e6 <consputc.part.0+0x96>
80100634:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pos += 80 - pos%80;
80100638:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
8010063d:	f7 e2                	mul    %edx
8010063f:	c1 ea 06             	shr    $0x6,%edx
80100642:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100645:	c1 e0 04             	shl    $0x4,%eax
80100648:	8d 70 50             	lea    0x50(%eax),%esi
8010064b:	e9 6f ff ff ff       	jmp    801005bf <consputc.part.0+0x6f>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100650:	83 ec 0c             	sub    $0xc,%esp
80100653:	6a 08                	push   $0x8
80100655:	e8 e6 7b 00 00       	call   80108240 <uartputc>
8010065a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100661:	e8 da 7b 00 00       	call   80108240 <uartputc>
80100666:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010066d:	e8 ce 7b 00 00       	call   80108240 <uartputc>
80100672:	83 c4 10             	add    $0x10,%esp
80100675:	e9 f8 fe ff ff       	jmp    80100572 <consputc.part.0+0x22>
8010067a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100680:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
80100683:	8d 5e b0             	lea    -0x50(%esi),%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100686:	8d b4 36 60 7f 0b 80 	lea    -0x7ff480a0(%esi,%esi,1),%esi
  outb(CRTPORT+1, pos);
8010068d:	bf 07 00 00 00       	mov    $0x7,%edi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100692:	68 60 0e 00 00       	push   $0xe60
80100697:	68 a0 80 0b 80       	push   $0x800b80a0
8010069c:	68 00 80 0b 80       	push   $0x800b8000
801006a1:	e8 0a 5b 00 00       	call   801061b0 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801006a6:	b8 80 07 00 00       	mov    $0x780,%eax
801006ab:	83 c4 0c             	add    $0xc,%esp
801006ae:	29 d8                	sub    %ebx,%eax
801006b0:	01 c0                	add    %eax,%eax
801006b2:	50                   	push   %eax
801006b3:	6a 00                	push   $0x0
801006b5:	56                   	push   %esi
801006b6:	e8 55 5a 00 00       	call   80106110 <memset>
  outb(CRTPORT+1, pos);
801006bb:	88 5d e7             	mov    %bl,-0x19(%ebp)
801006be:	83 c4 10             	add    $0x10,%esp
801006c1:	e9 20 ff ff ff       	jmp    801005e6 <consputc.part.0+0x96>
    panic("pos under/overflow");
801006c6:	83 ec 0c             	sub    $0xc,%esp
801006c9:	68 65 97 10 80       	push   $0x80109765
801006ce:	e8 fd fd ff ff       	call   801004d0 <panic>
801006d3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801006da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801006e0 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
801006e0:	55                   	push   %ebp
801006e1:	89 e5                	mov    %esp,%ebp
801006e3:	57                   	push   %edi
801006e4:	56                   	push   %esi
801006e5:	53                   	push   %ebx
801006e6:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
801006e9:	ff 75 08             	push   0x8(%ebp)
{
801006ec:	8b 75 10             	mov    0x10(%ebp),%esi
  iunlock(ip);
801006ef:	e8 bc 20 00 00       	call   801027b0 <iunlock>
  acquire(&cons.lock);
801006f4:	c7 04 24 c0 27 11 80 	movl   $0x801127c0,(%esp)
801006fb:	e8 20 58 00 00       	call   80105f20 <acquire>
  for(i = 0; i < n; i++)
80100700:	83 c4 10             	add    $0x10,%esp
80100703:	85 f6                	test   %esi,%esi
80100705:	7e 25                	jle    8010072c <consolewrite+0x4c>
80100707:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010070a:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
  if(panicked){
8010070d:	8b 15 f8 27 11 80    	mov    0x801127f8,%edx
    consputc(buf[i] & 0xff);
80100713:	0f b6 03             	movzbl (%ebx),%eax
  if(panicked){
80100716:	85 d2                	test   %edx,%edx
80100718:	74 06                	je     80100720 <consolewrite+0x40>
  asm volatile("cli");
8010071a:	fa                   	cli    
    for(;;)
8010071b:	eb fe                	jmp    8010071b <consolewrite+0x3b>
8010071d:	8d 76 00             	lea    0x0(%esi),%esi
80100720:	e8 2b fe ff ff       	call   80100550 <consputc.part.0>
  for(i = 0; i < n; i++)
80100725:	83 c3 01             	add    $0x1,%ebx
80100728:	39 df                	cmp    %ebx,%edi
8010072a:	75 e1                	jne    8010070d <consolewrite+0x2d>
  release(&cons.lock);
8010072c:	83 ec 0c             	sub    $0xc,%esp
8010072f:	68 c0 27 11 80       	push   $0x801127c0
80100734:	e8 87 57 00 00       	call   80105ec0 <release>
  ilock(ip);
80100739:	58                   	pop    %eax
8010073a:	ff 75 08             	push   0x8(%ebp)
8010073d:	e8 8e 1f 00 00       	call   801026d0 <ilock>

  return n;
}
80100742:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100745:	89 f0                	mov    %esi,%eax
80100747:	5b                   	pop    %ebx
80100748:	5e                   	pop    %esi
80100749:	5f                   	pop    %edi
8010074a:	5d                   	pop    %ebp
8010074b:	c3                   	ret    
8010074c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100750 <printint>:
{
80100750:	55                   	push   %ebp
80100751:	89 e5                	mov    %esp,%ebp
80100753:	57                   	push   %edi
80100754:	56                   	push   %esi
80100755:	53                   	push   %ebx
80100756:	83 ec 2c             	sub    $0x2c,%esp
80100759:	89 55 d4             	mov    %edx,-0x2c(%ebp)
8010075c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
  if(sign && (sign = xx < 0))
8010075f:	85 c9                	test   %ecx,%ecx
80100761:	74 04                	je     80100767 <printint+0x17>
80100763:	85 c0                	test   %eax,%eax
80100765:	78 6d                	js     801007d4 <printint+0x84>
    x = xx;
80100767:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
8010076e:	89 c1                	mov    %eax,%ecx
  i = 0;
80100770:	31 db                	xor    %ebx,%ebx
80100772:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    buf[i++] = digits[x % base];
80100778:	89 c8                	mov    %ecx,%eax
8010077a:	31 d2                	xor    %edx,%edx
8010077c:	89 de                	mov    %ebx,%esi
8010077e:	89 cf                	mov    %ecx,%edi
80100780:	f7 75 d4             	divl   -0x2c(%ebp)
80100783:	8d 5b 01             	lea    0x1(%ebx),%ebx
80100786:	0f b6 92 d0 97 10 80 	movzbl -0x7fef6830(%edx),%edx
  }while((x /= base) != 0);
8010078d:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
8010078f:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
80100793:	3b 7d d4             	cmp    -0x2c(%ebp),%edi
80100796:	73 e0                	jae    80100778 <printint+0x28>
  if(sign)
80100798:	8b 4d d0             	mov    -0x30(%ebp),%ecx
8010079b:	85 c9                	test   %ecx,%ecx
8010079d:	74 0c                	je     801007ab <printint+0x5b>
    buf[i++] = '-';
8010079f:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
801007a4:	89 de                	mov    %ebx,%esi
    buf[i++] = '-';
801007a6:	ba 2d 00 00 00       	mov    $0x2d,%edx
  while(--i >= 0)
801007ab:	8d 5c 35 d7          	lea    -0x29(%ebp,%esi,1),%ebx
801007af:	0f be c2             	movsbl %dl,%eax
  if(panicked){
801007b2:	8b 15 f8 27 11 80    	mov    0x801127f8,%edx
801007b8:	85 d2                	test   %edx,%edx
801007ba:	74 04                	je     801007c0 <printint+0x70>
801007bc:	fa                   	cli    
    for(;;)
801007bd:	eb fe                	jmp    801007bd <printint+0x6d>
801007bf:	90                   	nop
801007c0:	e8 8b fd ff ff       	call   80100550 <consputc.part.0>
  while(--i >= 0)
801007c5:	8d 45 d7             	lea    -0x29(%ebp),%eax
801007c8:	39 c3                	cmp    %eax,%ebx
801007ca:	74 0e                	je     801007da <printint+0x8a>
    consputc(buf[i]);
801007cc:	0f be 03             	movsbl (%ebx),%eax
801007cf:	83 eb 01             	sub    $0x1,%ebx
801007d2:	eb de                	jmp    801007b2 <printint+0x62>
    x = -xx;
801007d4:	f7 d8                	neg    %eax
801007d6:	89 c1                	mov    %eax,%ecx
801007d8:	eb 96                	jmp    80100770 <printint+0x20>
}
801007da:	83 c4 2c             	add    $0x2c,%esp
801007dd:	5b                   	pop    %ebx
801007de:	5e                   	pop    %esi
801007df:	5f                   	pop    %edi
801007e0:	5d                   	pop    %ebp
801007e1:	c3                   	ret    
801007e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801007f0 <cprintf>:
{
801007f0:	55                   	push   %ebp
801007f1:	89 e5                	mov    %esp,%ebp
801007f3:	57                   	push   %edi
801007f4:	56                   	push   %esi
801007f5:	53                   	push   %ebx
801007f6:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
801007f9:	a1 f4 27 11 80       	mov    0x801127f4,%eax
801007fe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(locking)
80100801:	85 c0                	test   %eax,%eax
80100803:	0f 85 27 01 00 00    	jne    80100930 <cprintf+0x140>
  if (fmt == 0)
80100809:	8b 75 08             	mov    0x8(%ebp),%esi
8010080c:	85 f6                	test   %esi,%esi
8010080e:	0f 84 ac 01 00 00    	je     801009c0 <cprintf+0x1d0>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100814:	0f b6 06             	movzbl (%esi),%eax
  argp = (uint*)(void*)(&fmt + 1);
80100817:	8d 7d 0c             	lea    0xc(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010081a:	31 db                	xor    %ebx,%ebx
8010081c:	85 c0                	test   %eax,%eax
8010081e:	74 56                	je     80100876 <cprintf+0x86>
    if(c != '%'){
80100820:	83 f8 25             	cmp    $0x25,%eax
80100823:	0f 85 cf 00 00 00    	jne    801008f8 <cprintf+0x108>
    c = fmt[++i] & 0xff;
80100829:	83 c3 01             	add    $0x1,%ebx
8010082c:	0f b6 14 1e          	movzbl (%esi,%ebx,1),%edx
    if(c == 0)
80100830:	85 d2                	test   %edx,%edx
80100832:	74 42                	je     80100876 <cprintf+0x86>
    switch(c){
80100834:	83 fa 70             	cmp    $0x70,%edx
80100837:	0f 84 90 00 00 00    	je     801008cd <cprintf+0xdd>
8010083d:	7f 51                	jg     80100890 <cprintf+0xa0>
8010083f:	83 fa 25             	cmp    $0x25,%edx
80100842:	0f 84 c0 00 00 00    	je     80100908 <cprintf+0x118>
80100848:	83 fa 64             	cmp    $0x64,%edx
8010084b:	0f 85 f4 00 00 00    	jne    80100945 <cprintf+0x155>
      printint(*argp++, 10, 1);
80100851:	8d 47 04             	lea    0x4(%edi),%eax
80100854:	b9 01 00 00 00       	mov    $0x1,%ecx
80100859:	ba 0a 00 00 00       	mov    $0xa,%edx
8010085e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100861:	8b 07                	mov    (%edi),%eax
80100863:	e8 e8 fe ff ff       	call   80100750 <printint>
80100868:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010086b:	83 c3 01             	add    $0x1,%ebx
8010086e:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100872:	85 c0                	test   %eax,%eax
80100874:	75 aa                	jne    80100820 <cprintf+0x30>
  if(locking)
80100876:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100879:	85 c0                	test   %eax,%eax
8010087b:	0f 85 22 01 00 00    	jne    801009a3 <cprintf+0x1b3>
}
80100881:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100884:	5b                   	pop    %ebx
80100885:	5e                   	pop    %esi
80100886:	5f                   	pop    %edi
80100887:	5d                   	pop    %ebp
80100888:	c3                   	ret    
80100889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100890:	83 fa 73             	cmp    $0x73,%edx
80100893:	75 33                	jne    801008c8 <cprintf+0xd8>
      if((s = (char*)*argp++) == 0)
80100895:	8d 47 04             	lea    0x4(%edi),%eax
80100898:	8b 3f                	mov    (%edi),%edi
8010089a:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010089d:	85 ff                	test   %edi,%edi
8010089f:	0f 84 e3 00 00 00    	je     80100988 <cprintf+0x198>
      for(; *s; s++)
801008a5:	0f be 07             	movsbl (%edi),%eax
801008a8:	84 c0                	test   %al,%al
801008aa:	0f 84 08 01 00 00    	je     801009b8 <cprintf+0x1c8>
  if(panicked){
801008b0:	8b 15 f8 27 11 80    	mov    0x801127f8,%edx
801008b6:	85 d2                	test   %edx,%edx
801008b8:	0f 84 b2 00 00 00    	je     80100970 <cprintf+0x180>
801008be:	fa                   	cli    
    for(;;)
801008bf:	eb fe                	jmp    801008bf <cprintf+0xcf>
801008c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
801008c8:	83 fa 78             	cmp    $0x78,%edx
801008cb:	75 78                	jne    80100945 <cprintf+0x155>
      printint(*argp++, 16, 0);
801008cd:	8d 47 04             	lea    0x4(%edi),%eax
801008d0:	31 c9                	xor    %ecx,%ecx
801008d2:	ba 10 00 00 00       	mov    $0x10,%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801008d7:	83 c3 01             	add    $0x1,%ebx
      printint(*argp++, 16, 0);
801008da:	89 45 e0             	mov    %eax,-0x20(%ebp)
801008dd:	8b 07                	mov    (%edi),%eax
801008df:	e8 6c fe ff ff       	call   80100750 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801008e4:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
      printint(*argp++, 16, 0);
801008e8:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801008eb:	85 c0                	test   %eax,%eax
801008ed:	0f 85 2d ff ff ff    	jne    80100820 <cprintf+0x30>
801008f3:	eb 81                	jmp    80100876 <cprintf+0x86>
801008f5:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
801008f8:	8b 0d f8 27 11 80    	mov    0x801127f8,%ecx
801008fe:	85 c9                	test   %ecx,%ecx
80100900:	74 14                	je     80100916 <cprintf+0x126>
80100902:	fa                   	cli    
    for(;;)
80100903:	eb fe                	jmp    80100903 <cprintf+0x113>
80100905:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
80100908:	a1 f8 27 11 80       	mov    0x801127f8,%eax
8010090d:	85 c0                	test   %eax,%eax
8010090f:	75 6c                	jne    8010097d <cprintf+0x18d>
80100911:	b8 25 00 00 00       	mov    $0x25,%eax
80100916:	e8 35 fc ff ff       	call   80100550 <consputc.part.0>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010091b:	83 c3 01             	add    $0x1,%ebx
8010091e:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100922:	85 c0                	test   %eax,%eax
80100924:	0f 85 f6 fe ff ff    	jne    80100820 <cprintf+0x30>
8010092a:	e9 47 ff ff ff       	jmp    80100876 <cprintf+0x86>
8010092f:	90                   	nop
    acquire(&cons.lock);
80100930:	83 ec 0c             	sub    $0xc,%esp
80100933:	68 c0 27 11 80       	push   $0x801127c0
80100938:	e8 e3 55 00 00       	call   80105f20 <acquire>
8010093d:	83 c4 10             	add    $0x10,%esp
80100940:	e9 c4 fe ff ff       	jmp    80100809 <cprintf+0x19>
  if(panicked){
80100945:	8b 0d f8 27 11 80    	mov    0x801127f8,%ecx
8010094b:	85 c9                	test   %ecx,%ecx
8010094d:	75 31                	jne    80100980 <cprintf+0x190>
8010094f:	b8 25 00 00 00       	mov    $0x25,%eax
80100954:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100957:	e8 f4 fb ff ff       	call   80100550 <consputc.part.0>
8010095c:	8b 15 f8 27 11 80    	mov    0x801127f8,%edx
80100962:	85 d2                	test   %edx,%edx
80100964:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100967:	74 2e                	je     80100997 <cprintf+0x1a7>
80100969:	fa                   	cli    
    for(;;)
8010096a:	eb fe                	jmp    8010096a <cprintf+0x17a>
8010096c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100970:	e8 db fb ff ff       	call   80100550 <consputc.part.0>
      for(; *s; s++)
80100975:	83 c7 01             	add    $0x1,%edi
80100978:	e9 28 ff ff ff       	jmp    801008a5 <cprintf+0xb5>
8010097d:	fa                   	cli    
    for(;;)
8010097e:	eb fe                	jmp    8010097e <cprintf+0x18e>
80100980:	fa                   	cli    
80100981:	eb fe                	jmp    80100981 <cprintf+0x191>
80100983:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100987:	90                   	nop
        s = "(null)";
80100988:	bf 78 97 10 80       	mov    $0x80109778,%edi
      for(; *s; s++)
8010098d:	b8 28 00 00 00       	mov    $0x28,%eax
80100992:	e9 19 ff ff ff       	jmp    801008b0 <cprintf+0xc0>
80100997:	89 d0                	mov    %edx,%eax
80100999:	e8 b2 fb ff ff       	call   80100550 <consputc.part.0>
8010099e:	e9 c8 fe ff ff       	jmp    8010086b <cprintf+0x7b>
    release(&cons.lock);
801009a3:	83 ec 0c             	sub    $0xc,%esp
801009a6:	68 c0 27 11 80       	push   $0x801127c0
801009ab:	e8 10 55 00 00       	call   80105ec0 <release>
801009b0:	83 c4 10             	add    $0x10,%esp
}
801009b3:	e9 c9 fe ff ff       	jmp    80100881 <cprintf+0x91>
      if((s = (char*)*argp++) == 0)
801009b8:	8b 7d e0             	mov    -0x20(%ebp),%edi
801009bb:	e9 ab fe ff ff       	jmp    8010086b <cprintf+0x7b>
    panic("null fmt");
801009c0:	83 ec 0c             	sub    $0xc,%esp
801009c3:	68 7f 97 10 80       	push   $0x8010977f
801009c8:	e8 03 fb ff ff       	call   801004d0 <panic>
801009cd:	8d 76 00             	lea    0x0(%esi),%esi

801009d0 <move_cursor_left>:
{
801009d0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801009d1:	b8 0e 00 00 00       	mov    $0xe,%eax
801009d6:	89 e5                	mov    %esp,%ebp
801009d8:	57                   	push   %edi
801009d9:	56                   	push   %esi
801009da:	be d4 03 00 00       	mov    $0x3d4,%esi
801009df:	53                   	push   %ebx
801009e0:	89 f2                	mov    %esi,%edx
801009e2:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801009e3:	bb d5 03 00 00       	mov    $0x3d5,%ebx
801009e8:	89 da                	mov    %ebx,%edx
801009ea:	ec                   	in     (%dx),%al
  cursor_position = inb(CRTPORT+1) << 8;
801009eb:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801009ee:	bf 0f 00 00 00       	mov    $0xf,%edi
801009f3:	89 f2                	mov    %esi,%edx
801009f5:	89 c1                	mov    %eax,%ecx
801009f7:	89 f8                	mov    %edi,%eax
801009f9:	c1 e1 08             	shl    $0x8,%ecx
801009fc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801009fd:	89 da                	mov    %ebx,%edx
801009ff:	ec                   	in     (%dx),%al
  cursor_position = cursor_position | inb(CRTPORT+1);/*Finding current position of cursor*/
80100a00:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100a03:	89 f2                	mov    %esi,%edx
80100a05:	09 c1                	or     %eax,%ecx
80100a07:	89 f8                	mov    %edi,%eax
  cursor_position = cursor_position - 1; /*Moving cursor one step back*/
80100a09:	83 e9 01             	sub    $0x1,%ecx
80100a0c:	ee                   	out    %al,(%dx)
80100a0d:	89 c8                	mov    %ecx,%eax
80100a0f:	89 da                	mov    %ebx,%edx
80100a11:	ee                   	out    %al,(%dx)
80100a12:	b8 0e 00 00 00       	mov    $0xe,%eax
80100a17:	89 f2                	mov    %esi,%edx
80100a19:	ee                   	out    %al,(%dx)
  outb(CRTPORT+1, (unsigned char)((cursor_position>>8) & 0xFF)); /*Reset cursor*/
80100a1a:	89 c8                	mov    %ecx,%eax
80100a1c:	89 da                	mov    %ebx,%edx
80100a1e:	c1 f8 08             	sar    $0x8,%eax
80100a21:	ee                   	out    %al,(%dx)
}
80100a22:	5b                   	pop    %ebx
80100a23:	5e                   	pop    %esi
80100a24:	5f                   	pop    %edi
80100a25:	5d                   	pop    %ebp
80100a26:	c3                   	ret    
80100a27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a2e:	66 90                	xchg   %ax,%ax

80100a30 <move_cursor_right>:
{
80100a30:	55                   	push   %ebp
80100a31:	b8 0e 00 00 00       	mov    $0xe,%eax
80100a36:	89 e5                	mov    %esp,%ebp
80100a38:	57                   	push   %edi
80100a39:	56                   	push   %esi
80100a3a:	be d4 03 00 00       	mov    $0x3d4,%esi
80100a3f:	53                   	push   %ebx
80100a40:	89 f2                	mov    %esi,%edx
80100a42:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100a43:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100a48:	89 da                	mov    %ebx,%edx
80100a4a:	ec                   	in     (%dx),%al
  cursor_position = inb(CRTPORT+1) << 8;
80100a4b:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100a4e:	bf 0f 00 00 00       	mov    $0xf,%edi
80100a53:	89 f2                	mov    %esi,%edx
80100a55:	89 c1                	mov    %eax,%ecx
80100a57:	89 f8                	mov    %edi,%eax
80100a59:	c1 e1 08             	shl    $0x8,%ecx
80100a5c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100a5d:	89 da                	mov    %ebx,%edx
80100a5f:	ec                   	in     (%dx),%al
  cursor_position = cursor_position | inb(CRTPORT+1);/*Finding current position of cursor*/
80100a60:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100a63:	89 f2                	mov    %esi,%edx
80100a65:	09 c1                	or     %eax,%ecx
80100a67:	89 f8                	mov    %edi,%eax
  cursor_position = cursor_position + 1; /*Moving cursor one step forward*/
80100a69:	83 c1 01             	add    $0x1,%ecx
80100a6c:	ee                   	out    %al,(%dx)
80100a6d:	89 c8                	mov    %ecx,%eax
80100a6f:	89 da                	mov    %ebx,%edx
80100a71:	ee                   	out    %al,(%dx)
80100a72:	b8 0e 00 00 00       	mov    $0xe,%eax
80100a77:	89 f2                	mov    %esi,%edx
80100a79:	ee                   	out    %al,(%dx)
  outb(CRTPORT+1, (unsigned char)((cursor_position>>8) & 0xFF)); /*Reset cursor*/
80100a7a:	89 c8                	mov    %ecx,%eax
80100a7c:	89 da                	mov    %ebx,%edx
80100a7e:	c1 f8 08             	sar    $0x8,%eax
80100a81:	ee                   	out    %al,(%dx)
}
80100a82:	5b                   	pop    %ebx
80100a83:	5e                   	pop    %esi
80100a84:	5f                   	pop    %edi
80100a85:	5d                   	pop    %ebp
80100a86:	c3                   	ret    
80100a87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a8e:	66 90                	xchg   %ax,%ax

80100a90 <remove_chars>:
{
80100a90:	55                   	push   %ebp
80100a91:	b8 0e 00 00 00       	mov    $0xe,%eax
80100a96:	89 e5                	mov    %esp,%ebp
80100a98:	57                   	push   %edi
80100a99:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100a9e:	56                   	push   %esi
80100a9f:	89 fa                	mov    %edi,%edx
80100aa1:	53                   	push   %ebx
80100aa2:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100aa5:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100aa6:	be d5 03 00 00       	mov    $0x3d5,%esi
80100aab:	89 f2                	mov    %esi,%edx
80100aad:	ec                   	in     (%dx),%al
  cursor_position = inb(CRTPORT+1) << 8;
80100aae:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100ab1:	89 fa                	mov    %edi,%edx
80100ab3:	b8 0f 00 00 00       	mov    $0xf,%eax
80100ab8:	c1 e1 08             	shl    $0x8,%ecx
80100abb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100abc:	89 f2                	mov    %esi,%edx
80100abe:	ec                   	in     (%dx),%al
  cursor_position = cursor_position | inb(CRTPORT+1);/*Finding current position of cursor*/
80100abf:	0f b6 c0             	movzbl %al,%eax
80100ac2:	09 c8                	or     %ecx,%eax
  for(int i = cursor_position -1 ; i <= cursor_position + back_counter; i++)
80100ac4:	8d 48 ff             	lea    -0x1(%eax),%ecx
80100ac7:	8d 34 18             	lea    (%eax,%ebx,1),%esi
80100aca:	83 fb ff             	cmp    $0xffffffff,%ebx
80100acd:	7c 22                	jl     80100af1 <remove_chars+0x61>
80100acf:	8d 84 00 00 80 0b 80 	lea    -0x7ff48000(%eax,%eax,1),%eax
80100ad6:	89 ca                	mov    %ecx,%edx
80100ad8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100adf:	90                   	nop
    crt[i] = crt[i+1];
80100ae0:	0f b7 38             	movzwl (%eax),%edi
  for(int i = cursor_position -1 ; i <= cursor_position + back_counter; i++)
80100ae3:	83 c2 01             	add    $0x1,%edx
80100ae6:	83 c0 02             	add    $0x2,%eax
    crt[i] = crt[i+1];
80100ae9:	66 89 78 fc          	mov    %di,-0x4(%eax)
  for(int i = cursor_position -1 ; i <= cursor_position + back_counter; i++)
80100aed:	39 f2                	cmp    %esi,%edx
80100aef:	7e ef                	jle    80100ae0 <remove_chars+0x50>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100af1:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100af6:	b8 0f 00 00 00       	mov    $0xf,%eax
80100afb:	89 fa                	mov    %edi,%edx
80100afd:	ee                   	out    %al,(%dx)
80100afe:	be d5 03 00 00       	mov    $0x3d5,%esi
80100b03:	89 c8                	mov    %ecx,%eax
80100b05:	89 f2                	mov    %esi,%edx
80100b07:	ee                   	out    %al,(%dx)
80100b08:	b8 0e 00 00 00       	mov    $0xe,%eax
80100b0d:	89 fa                	mov    %edi,%edx
80100b0f:	ee                   	out    %al,(%dx)
  outb(CRTPORT+1, (unsigned char)((cursor_position>>8) & 0xFF)); /*Reset cursor*/
80100b10:	89 c8                	mov    %ecx,%eax
80100b12:	89 f2                	mov    %esi,%edx
80100b14:	c1 f8 08             	sar    $0x8,%eax
80100b17:	ee                   	out    %al,(%dx)
  crt[cursor_position+back_counter] = ' ' | 0x0700;
80100b18:	b8 20 07 00 00       	mov    $0x720,%eax
80100b1d:	01 d9                	add    %ebx,%ecx
80100b1f:	66 89 84 09 00 80 0b 	mov    %ax,-0x7ff48000(%ecx,%ecx,1)
80100b26:	80 
}
80100b27:	5b                   	pop    %ebx
80100b28:	5e                   	pop    %esi
80100b29:	5f                   	pop    %edi
80100b2a:	5d                   	pop    %ebp
80100b2b:	c3                   	ret    
80100b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100b30 <insert_chars>:
{
80100b30:	55                   	push   %ebp
80100b31:	b8 0e 00 00 00       	mov    $0xe,%eax
80100b36:	89 e5                	mov    %esp,%ebp
80100b38:	56                   	push   %esi
80100b39:	be d4 03 00 00       	mov    $0x3d4,%esi
80100b3e:	53                   	push   %ebx
80100b3f:	89 f2                	mov    %esi,%edx
80100b41:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100b42:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100b47:	89 da                	mov    %ebx,%edx
80100b49:	ec                   	in     (%dx),%al
  current_position = inb(CRTPORT+1) << 8;
80100b4a:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100b4d:	89 f2                	mov    %esi,%edx
80100b4f:	b8 0f 00 00 00       	mov    $0xf,%eax
80100b54:	c1 e1 08             	shl    $0x8,%ecx
80100b57:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100b58:	89 da                	mov    %ebx,%edx
80100b5a:	ec                   	in     (%dx),%al
  for(int i = current_position + back_counter; i >= current_position; i--)
80100b5b:	8b 55 08             	mov    0x8(%ebp),%edx
  current_position |= inb(CRTPORT+1);
80100b5e:	0f b6 c0             	movzbl %al,%eax
80100b61:	09 c8                	or     %ecx,%eax
  for(int i = current_position + back_counter; i >= current_position; i--)
80100b63:	01 c2                	add    %eax,%edx
80100b65:	39 d0                	cmp    %edx,%eax
80100b67:	7f 25                	jg     80100b8e <insert_chars+0x5e>
80100b69:	8d 94 12 00 80 0b 80 	lea    -0x7ff48000(%edx,%edx,1),%edx
80100b70:	8d 9c 00 fe 7f 0b 80 	lea    -0x7ff48002(%eax,%eax,1),%ebx
80100b77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100b7e:	66 90                	xchg   %ax,%ax
    crt[i+1] = crt[i];
80100b80:	0f b7 0a             	movzwl (%edx),%ecx
  for(int i = current_position + back_counter; i >= current_position; i--)
80100b83:	83 ea 02             	sub    $0x2,%edx
    crt[i+1] = crt[i];
80100b86:	66 89 4a 04          	mov    %cx,0x4(%edx)
  for(int i = current_position + back_counter; i >= current_position; i--)
80100b8a:	39 d3                	cmp    %edx,%ebx
80100b8c:	75 f2                	jne    80100b80 <insert_chars+0x50>
  crt[current_position] = (c&0xff) | 0x0700;/*move back crt buffer*/  
80100b8e:	0f b6 55 0c          	movzbl 0xc(%ebp),%edx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100b92:	be d4 03 00 00       	mov    $0x3d4,%esi
  current_position += 1;/*Updating cursor position*/
80100b97:	8d 48 01             	lea    0x1(%eax),%ecx
  crt[current_position] = (c&0xff) | 0x0700;/*move back crt buffer*/  
80100b9a:	80 ce 07             	or     $0x7,%dh
80100b9d:	66 89 94 00 00 80 0b 	mov    %dx,-0x7ff48000(%eax,%eax,1)
80100ba4:	80 
80100ba5:	b8 0e 00 00 00       	mov    $0xe,%eax
80100baa:	89 f2                	mov    %esi,%edx
80100bac:	ee                   	out    %al,(%dx)
80100bad:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  outb(CRTPORT+1, current_position>>8);
80100bb2:	89 c8                	mov    %ecx,%eax
80100bb4:	c1 f8 08             	sar    $0x8,%eax
80100bb7:	89 da                	mov    %ebx,%edx
80100bb9:	ee                   	out    %al,(%dx)
80100bba:	b8 0f 00 00 00       	mov    $0xf,%eax
80100bbf:	89 f2                	mov    %esi,%edx
80100bc1:	ee                   	out    %al,(%dx)
80100bc2:	89 c8                	mov    %ecx,%eax
80100bc4:	89 da                	mov    %ebx,%edx
80100bc6:	ee                   	out    %al,(%dx)
  crt[current_position+back_counter] = ' ' | 0x0700;/*Reset cursor*/
80100bc7:	8b 45 08             	mov    0x8(%ebp),%eax
80100bca:	ba 20 07 00 00       	mov    $0x720,%edx
80100bcf:	01 c8                	add    %ecx,%eax
80100bd1:	66 89 94 00 00 80 0b 	mov    %dx,-0x7ff48000(%eax,%eax,1)
80100bd8:	80 
}
80100bd9:	5b                   	pop    %ebx
80100bda:	5e                   	pop    %esi
80100bdb:	5d                   	pop    %ebp
80100bdc:	c3                   	ret    
80100bdd:	8d 76 00             	lea    0x0(%esi),%esi

80100be0 <add_history>:
{
80100be0:	55                   	push   %ebp
80100be1:	89 e5                	mov    %esp,%ebp
80100be3:	8b 45 08             	mov    0x8(%ebp),%eax
  if((command[0]!='\0'))
80100be6:	80 38 00             	cmpb   $0x0,(%eax)
80100be9:	75 05                	jne    80100bf0 <add_history+0x10>
}
80100beb:	5d                   	pop    %ebp
80100bec:	c3                   	ret    
80100bed:	8d 76 00             	lea    0x0(%esi),%esi
80100bf0:	5d                   	pop    %ebp
80100bf1:	e9 8a f7 ff ff       	jmp    80100380 <add_history.part.0>
80100bf6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100bfd:	8d 76 00             	lea    0x0(%esi),%esi

80100c00 <detect_math_expression>:
int detect_math_expression(char c) {
80100c00:	55                   	push   %ebp
80100c01:	89 e5                	mov    %esp,%ebp
  if (c == '?' && input.buf[(input.position-1) % INPUT_BUF] == '=') {
80100c03:	80 7d 08 3f          	cmpb   $0x3f,0x8(%ebp)
80100c07:	74 07                	je     80100c10 <detect_math_expression+0x10>
}
80100c09:	31 c0                	xor    %eax,%eax
80100c0b:	5d                   	pop    %ebp
80100c0c:	c3                   	ret    
80100c0d:	8d 76 00             	lea    0x0(%esi),%esi
80100c10:	5d                   	pop    %ebp
80100c11:	e9 3a f8 ff ff       	jmp    80100450 <detect_math_expression.part.0>
80100c16:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100c1d:	8d 76 00             	lea    0x0(%esi),%esi

80100c20 <calculate_result_math_expression>:
float calculate_result_math_expression(int* is_divide) {
80100c20:	55                   	push   %ebp
80100c21:	89 e5                	mov    %esp,%ebp
80100c23:	83 ec 04             	sub    $0x4,%esp
  char operator = input.buf[(input.position-3) % INPUT_BUF];
80100c26:	a1 20 22 11 80       	mov    0x80112220,%eax
80100c2b:	8d 50 fd             	lea    -0x3(%eax),%edx
  float first_operand = input.buf[(input.position-4) % INPUT_BUF] - '0';
80100c2e:	8d 48 fc             	lea    -0x4(%eax),%ecx
  float second_operand = input.buf[(input.position-2) % INPUT_BUF] - '0';
80100c31:	83 e8 02             	sub    $0x2,%eax
  float first_operand = input.buf[(input.position-4) % INPUT_BUF] - '0';
80100c34:	83 e1 7f             	and    $0x7f,%ecx
  float second_operand = input.buf[(input.position-2) % INPUT_BUF] - '0';
80100c37:	83 e0 7f             	and    $0x7f,%eax
  char operator = input.buf[(input.position-3) % INPUT_BUF];
80100c3a:	83 e2 7f             	and    $0x7f,%edx
  float first_operand = input.buf[(input.position-4) % INPUT_BUF] - '0';
80100c3d:	0f be 89 24 22 11 80 	movsbl -0x7feedddc(%ecx),%ecx
  float second_operand = input.buf[(input.position-2) % INPUT_BUF] - '0';
80100c44:	0f be 80 24 22 11 80 	movsbl -0x7feedddc(%eax),%eax
  char operator = input.buf[(input.position-3) % INPUT_BUF];
80100c4b:	0f b6 92 24 22 11 80 	movzbl -0x7feedddc(%edx),%edx
  float first_operand = input.buf[(input.position-4) % INPUT_BUF] - '0';
80100c52:	83 e9 30             	sub    $0x30,%ecx
  float second_operand = input.buf[(input.position-2) % INPUT_BUF] - '0';
80100c55:	83 e8 30             	sub    $0x30,%eax
  float first_operand = input.buf[(input.position-4) % INPUT_BUF] - '0';
80100c58:	89 4d fc             	mov    %ecx,-0x4(%ebp)
80100c5b:	db 45 fc             	fildl  -0x4(%ebp)
  float second_operand = input.buf[(input.position-2) % INPUT_BUF] - '0';
80100c5e:	89 45 fc             	mov    %eax,-0x4(%ebp)
80100c61:	db 45 fc             	fildl  -0x4(%ebp)
  switch (operator) {
80100c64:	80 fa 2d             	cmp    $0x2d,%dl
80100c67:	74 4f                	je     80100cb8 <calculate_result_math_expression+0x98>
80100c69:	7f 15                	jg     80100c80 <calculate_result_math_expression+0x60>
80100c6b:	80 fa 2a             	cmp    $0x2a,%dl
80100c6e:	74 40                	je     80100cb0 <calculate_result_math_expression+0x90>
80100c70:	80 fa 2b             	cmp    $0x2b,%dl
80100c73:	75 1d                	jne    80100c92 <calculate_result_math_expression+0x72>
}
80100c75:	c9                   	leave  
      result = first_operand + second_operand;
80100c76:	de c1                	faddp  %st,%st(1)
}
80100c78:	c3                   	ret    
80100c79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  switch (operator) {
80100c80:	80 fa 2f             	cmp    $0x2f,%dl
80100c83:	75 1b                	jne    80100ca0 <calculate_result_math_expression+0x80>
      *is_divide = 1;
80100c85:	8b 45 08             	mov    0x8(%ebp),%eax
      result = first_operand / second_operand;
80100c88:	de f9                	fdivrp %st,%st(1)
      *is_divide = 1;
80100c8a:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
}
80100c90:	c9                   	leave  
80100c91:	c3                   	ret    
80100c92:	dd d8                	fstp   %st(0)
80100c94:	dd d8                	fstp   %st(0)
80100c96:	eb 0c                	jmp    80100ca4 <calculate_result_math_expression+0x84>
80100c98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100c9f:	90                   	nop
80100ca0:	dd d8                	fstp   %st(0)
80100ca2:	dd d8                	fstp   %st(0)
80100ca4:	c9                   	leave  
  switch (operator) {
80100ca5:	d9 ee                	fldz   
}
80100ca7:	c3                   	ret    
80100ca8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100caf:	90                   	nop
80100cb0:	c9                   	leave  
      result = first_operand * second_operand;    
80100cb1:	de c9                	fmulp  %st,%st(1)
}
80100cb3:	c3                   	ret    
80100cb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100cb8:	c9                   	leave  
      result = first_operand - second_operand;
80100cb9:	de e9                	fsubrp %st,%st(1)
}
80100cbb:	c3                   	ret    
80100cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100cc0 <float_to_str>:
int float_to_str(float result, char* res_str, int precision) {
80100cc0:	55                   	push   %ebp
80100cc1:	89 e5                	mov    %esp,%ebp
80100cc3:	57                   	push   %edi
80100cc4:	56                   	push   %esi
80100cc5:	53                   	push   %ebx
80100cc6:	83 ec 10             	sub    $0x10,%esp
  if (result == 0) {
80100cc9:	d9 ee                	fldz   
int float_to_str(float result, char* res_str, int precision) {
80100ccb:	d9 45 08             	flds   0x8(%ebp)
80100cce:	8b 75 0c             	mov    0xc(%ebp),%esi
  if (result == 0) {
80100cd1:	db e9                	fucomi %st(1),%st
80100cd3:	dd d9                	fstp   %st(1)
80100cd5:	7a 19                	jp     80100cf0 <float_to_str+0x30>
80100cd7:	75 17                	jne    80100cf0 <float_to_str+0x30>
80100cd9:	dd d8                	fstp   %st(0)
    res_str[res_len] = '0';
80100cdb:	c6 06 30             	movb   $0x30,(%esi)
    res_len += 1;
80100cde:	bb 01 00 00 00       	mov    $0x1,%ebx
}
80100ce3:	83 c4 10             	add    $0x10,%esp
80100ce6:	89 d8                	mov    %ebx,%eax
80100ce8:	5b                   	pop    %ebx
80100ce9:	5e                   	pop    %esi
80100cea:	5f                   	pop    %edi
80100ceb:	5d                   	pop    %ebp
80100cec:	c3                   	ret    
80100ced:	8d 76 00             	lea    0x0(%esi),%esi
      if (result < 0) {
80100cf0:	d9 ee                	fldz   
80100cf2:	df f1                	fcomip %st(1),%st
80100cf4:	0f 87 f6 00 00 00    	ja     80100df0 <float_to_str+0x130>
      if ((result > 0) && (result < 1)) {
80100cfa:	d9 ee                	fldz   
80100cfc:	d9 c9                	fxch   %st(1)
  int is_neg = 0;
80100cfe:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
      if ((result > 0) && (result < 1)) {
80100d05:	db f1                	fcomi  %st(1),%st
80100d07:	dd d9                	fstp   %st(1)
80100d09:	0f 86 f8 00 00 00    	jbe    80100e07 <float_to_str+0x147>
80100d0f:	d9 e8                	fld1   
80100d11:	31 c0                	xor    %eax,%eax
80100d13:	df f1                	fcomip %st(1),%st
80100d15:	0f 97 c0             	seta   %al
80100d18:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      for (int i=0; i<precision; i++) {
80100d1b:	8b 4d 10             	mov    0x10(%ebp),%ecx
80100d1e:	85 c9                	test   %ecx,%ecx
80100d20:	7e 1b                	jle    80100d3d <float_to_str+0x7d>
80100d22:	8b 55 10             	mov    0x10(%ebp),%edx
80100d25:	31 c0                	xor    %eax,%eax
80100d27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100d2e:	66 90                	xchg   %ax,%ax
80100d30:	83 c0 01             	add    $0x1,%eax
        result *= 10;
80100d33:	d8 0d e8 97 10 80    	fmuls  0x801097e8
      for (int i=0; i<precision; i++) {
80100d39:	39 c2                	cmp    %eax,%edx
80100d3b:	75 f3                	jne    80100d30 <float_to_str+0x70>
      int temp_result = result;
80100d3d:	d9 7d f2             	fnstcw -0xe(%ebp)
  int res_len = 0;
80100d40:	31 db                	xor    %ebx,%ebx
      int temp_result = result;
80100d42:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
80100d46:	80 cc 0c             	or     $0xc,%ah
80100d49:	66 89 45 f0          	mov    %ax,-0x10(%ebp)
80100d4d:	d9 6d f0             	fldcw  -0x10(%ebp)
80100d50:	db 5d e8             	fistpl -0x18(%ebp)
80100d53:	d9 6d f2             	fldcw  -0xe(%ebp)
80100d56:	8b 4d e8             	mov    -0x18(%ebp),%ecx
      int point = 0;
80100d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        if (point == precision) {
80100d60:	89 df                	mov    %ebx,%edi
80100d62:	b8 2e 00 00 00       	mov    $0x2e,%eax
          res_len += 1;
80100d67:	83 c3 01             	add    $0x1,%ebx
        if (point == precision) {
80100d6a:	3b 7d 10             	cmp    0x10(%ebp),%edi
80100d6d:	74 1d                	je     80100d8c <float_to_str+0xcc>
          res_str[res_len] = (temp_result % 10) + '0';
80100d6f:	b8 67 66 66 66       	mov    $0x66666667,%eax
80100d74:	f7 e9                	imul   %ecx
80100d76:	89 c8                	mov    %ecx,%eax
80100d78:	c1 f8 1f             	sar    $0x1f,%eax
80100d7b:	c1 fa 02             	sar    $0x2,%edx
80100d7e:	29 c2                	sub    %eax,%edx
80100d80:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100d83:	01 c0                	add    %eax,%eax
80100d85:	29 c1                	sub    %eax,%ecx
80100d87:	8d 41 30             	lea    0x30(%ecx),%eax
          temp_result /= 10;
80100d8a:	89 d1                	mov    %edx,%ecx
          res_str[res_len] = '.';
80100d8c:	88 44 1e ff          	mov    %al,-0x1(%esi,%ebx,1)
      } while (temp_result > 0);
80100d90:	85 c9                	test   %ecx,%ecx
80100d92:	7f cc                	jg     80100d60 <float_to_str+0xa0>
  if (is_less_than_one) {
80100d94:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100d97:	85 d2                	test   %edx,%edx
80100d99:	74 78                	je     80100e13 <float_to_str+0x153>
  if (is_neg) {
80100d9b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    res_str[res_len] = '.';
80100d9e:	c6 04 1e 2e          	movb   $0x2e,(%esi,%ebx,1)
    res_len += 1;
80100da2:	8d 5f 03             	lea    0x3(%edi),%ebx
    res_str[res_len] = '0';
80100da5:	c6 44 3e 02 30       	movb   $0x30,0x2(%esi,%edi,1)
  if (is_neg) {
80100daa:	85 c0                	test   %eax,%eax
80100dac:	74 7b                	je     80100e29 <float_to_str+0x169>
    res_str[res_len] = '-';
80100dae:	c6 04 1e 2d          	movb   $0x2d,(%esi,%ebx,1)
    res_len += 1;
80100db2:	83 c3 01             	add    $0x1,%ebx
  for (int i = 0; i < res_len / 2; ++i) {
80100db5:	89 df                	mov    %ebx,%edi
80100db7:	d1 ff                	sar    %edi
80100db9:	89 5d ec             	mov    %ebx,-0x14(%ebp)
80100dbc:	8d 54 1e ff          	lea    -0x1(%esi,%ebx,1),%edx
80100dc0:	31 c0                	xor    %eax,%eax
80100dc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    res_str[i] = res_str[res_len - i - 1];
80100dc8:	0f b6 1a             	movzbl (%edx),%ebx
    char temp = res_str[i];
80100dcb:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
  for (int i = 0; i < res_len / 2; ++i) {
80100dcf:	83 ea 01             	sub    $0x1,%edx
    res_str[i] = res_str[res_len - i - 1];
80100dd2:	88 1c 06             	mov    %bl,(%esi,%eax,1)
  for (int i = 0; i < res_len / 2; ++i) {
80100dd5:	83 c0 01             	add    $0x1,%eax
    res_str[res_len - i - 1] = temp;
80100dd8:	88 4a 01             	mov    %cl,0x1(%edx)
  for (int i = 0; i < res_len / 2; ++i) {
80100ddb:	39 f8                	cmp    %edi,%eax
80100ddd:	7c e9                	jl     80100dc8 <float_to_str+0x108>
80100ddf:	8b 5d ec             	mov    -0x14(%ebp),%ebx
}
80100de2:	83 c4 10             	add    $0x10,%esp
80100de5:	89 d8                	mov    %ebx,%eax
80100de7:	5b                   	pop    %ebx
80100de8:	5e                   	pop    %esi
80100de9:	5f                   	pop    %edi
80100dea:	5d                   	pop    %ebp
80100deb:	c3                   	ret    
80100dec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        result = -result;
80100df0:	d9 e0                	fchs   
        is_neg = 1;
80100df2:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
      if ((result > 0) && (result < 1)) {
80100df9:	d9 ee                	fldz   
80100dfb:	d9 c9                	fxch   %st(1)
80100dfd:	db f1                	fcomi  %st(1),%st
80100dff:	dd d9                	fstp   %st(1)
80100e01:	0f 87 08 ff ff ff    	ja     80100d0f <float_to_str+0x4f>
  int is_less_than_one = 0;
80100e07:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80100e0e:	e9 08 ff ff ff       	jmp    80100d1b <float_to_str+0x5b>
  if (is_neg) {
80100e13:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80100e17:	75 95                	jne    80100dae <float_to_str+0xee>
  for (int i = 0; i < res_len / 2; ++i) {
80100e19:	89 df                	mov    %ebx,%edi
80100e1b:	d1 ff                	sar    %edi
80100e1d:	75 9a                	jne    80100db9 <float_to_str+0xf9>
80100e1f:	bb 01 00 00 00       	mov    $0x1,%ebx
  return res_len;
80100e24:	e9 ba fe ff ff       	jmp    80100ce3 <float_to_str+0x23>
  for (int i = 0; i < res_len / 2; ++i) {
80100e29:	89 df                	mov    %ebx,%edi
80100e2b:	d1 ff                	sar    %edi
80100e2d:	eb 8a                	jmp    80100db9 <float_to_str+0xf9>
80100e2f:	90                   	nop

80100e30 <int_to_str>:
int int_to_str(int result, char* res_str) {
80100e30:	55                   	push   %ebp
80100e31:	89 e5                	mov    %esp,%ebp
80100e33:	57                   	push   %edi
80100e34:	56                   	push   %esi
80100e35:	53                   	push   %ebx
80100e36:	83 ec 04             	sub    $0x4,%esp
80100e39:	8b 75 08             	mov    0x8(%ebp),%esi
80100e3c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  if (result == 0) {
80100e3f:	85 f6                	test   %esi,%esi
80100e41:	75 15                	jne    80100e58 <int_to_str+0x28>
    res_str[res_len] = '0';
80100e43:	c6 01 30             	movb   $0x30,(%ecx)
    res_len += 1;
80100e46:	bb 01 00 00 00       	mov    $0x1,%ebx
}
80100e4b:	83 c4 04             	add    $0x4,%esp
80100e4e:	89 d8                	mov    %ebx,%eax
80100e50:	5b                   	pop    %ebx
80100e51:	5e                   	pop    %esi
80100e52:	5f                   	pop    %edi
80100e53:	5d                   	pop    %ebp
80100e54:	c3                   	ret    
80100e55:	8d 76 00             	lea    0x0(%esi),%esi
  int is_neg = 0;
80100e58:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
      if (result < 0) {
80100e5f:	0f 88 8b 00 00 00    	js     80100ef0 <int_to_str+0xc0>
  int res_len = 0;
80100e65:	31 db                	xor    %ebx,%ebx
80100e67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100e6e:	66 90                	xchg   %ax,%ax
        res_str[res_len] = (temp_result % 10) + '0';
80100e70:	b8 cd cc cc cc       	mov    $0xcccccccd,%eax
80100e75:	f7 e6                	mul    %esi
80100e77:	89 f0                	mov    %esi,%eax
80100e79:	c1 ea 03             	shr    $0x3,%edx
80100e7c:	8d 3c 92             	lea    (%edx,%edx,4),%edi
80100e7f:	01 ff                	add    %edi,%edi
80100e81:	29 f8                	sub    %edi,%eax
80100e83:	89 df                	mov    %ebx,%edi
80100e85:	83 c0 30             	add    $0x30,%eax
80100e88:	88 04 19             	mov    %al,(%ecx,%ebx,1)
        res_len += 1;
80100e8b:	89 f0                	mov    %esi,%eax
80100e8d:	83 c3 01             	add    $0x1,%ebx
        temp_result /= 10;
80100e90:	89 d6                	mov    %edx,%esi
      while (temp_result > 0);
80100e92:	83 f8 09             	cmp    $0x9,%eax
80100e95:	7f d9                	jg     80100e70 <int_to_str+0x40>
  if (is_neg) {
80100e97:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100e9a:	85 c0                	test   %eax,%eax
80100e9c:	75 42                	jne    80100ee0 <int_to_str+0xb0>
  for (int i = 0; i < res_len / 2; ++i) {
80100e9e:	89 df                	mov    %ebx,%edi
80100ea0:	d1 ff                	sar    %edi
80100ea2:	74 5a                	je     80100efe <int_to_str+0xce>
80100ea4:	8d 54 19 ff          	lea    -0x1(%ecx,%ebx,1),%edx
  int res_len = 0;
80100ea8:	31 c0                	xor    %eax,%eax
80100eaa:	89 de                	mov    %ebx,%esi
80100eac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    char temp = res_str[i];
80100eb0:	0f b6 1c 01          	movzbl (%ecx,%eax,1),%ebx
  for (int i = 0; i < res_len / 2; ++i) {
80100eb4:	83 ea 01             	sub    $0x1,%edx
    char temp = res_str[i];
80100eb7:	88 5d f0             	mov    %bl,-0x10(%ebp)
    res_str[i] = res_str[res_len - i - 1];
80100eba:	0f b6 5a 01          	movzbl 0x1(%edx),%ebx
80100ebe:	88 1c 01             	mov    %bl,(%ecx,%eax,1)
    res_str[res_len - i - 1] = temp;
80100ec1:	0f b6 5d f0          	movzbl -0x10(%ebp),%ebx
  for (int i = 0; i < res_len / 2; ++i) {
80100ec5:	83 c0 01             	add    $0x1,%eax
    res_str[res_len - i - 1] = temp;
80100ec8:	88 5a 01             	mov    %bl,0x1(%edx)
  for (int i = 0; i < res_len / 2; ++i) {
80100ecb:	39 f8                	cmp    %edi,%eax
80100ecd:	7c e1                	jl     80100eb0 <int_to_str+0x80>
}
80100ecf:	83 c4 04             	add    $0x4,%esp
80100ed2:	89 f3                	mov    %esi,%ebx
80100ed4:	89 d8                	mov    %ebx,%eax
80100ed6:	5b                   	pop    %ebx
80100ed7:	5e                   	pop    %esi
80100ed8:	5f                   	pop    %edi
80100ed9:	5d                   	pop    %ebp
80100eda:	c3                   	ret    
80100edb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100edf:	90                   	nop
    res_str[res_len] = '-';
80100ee0:	c6 04 19 2d          	movb   $0x2d,(%ecx,%ebx,1)
    res_len += 1;
80100ee4:	8d 5f 02             	lea    0x2(%edi),%ebx
  for (int i = 0; i < res_len / 2; ++i) {
80100ee7:	89 df                	mov    %ebx,%edi
80100ee9:	d1 ff                	sar    %edi
80100eeb:	eb b7                	jmp    80100ea4 <int_to_str+0x74>
80100eed:	8d 76 00             	lea    0x0(%esi),%esi
        is_neg = 1;
80100ef0:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
        result = -result;
80100ef7:	f7 de                	neg    %esi
80100ef9:	e9 67 ff ff ff       	jmp    80100e65 <int_to_str+0x35>
  for (int i = 0; i < res_len / 2; ++i) {
80100efe:	bb 01 00 00 00       	mov    $0x1,%ebx
  return res_len;
80100f03:	e9 43 ff ff ff       	jmp    80100e4b <int_to_str+0x1b>
80100f08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f0f:	90                   	nop

80100f10 <store_command>:
  if (num_copied_commands < INPUT_BUF) {  
80100f10:	a1 fc 27 11 80       	mov    0x801127fc,%eax
80100f15:	83 f8 7f             	cmp    $0x7f,%eax
80100f18:	7f 1e                	jg     80100f38 <store_command+0x28>
void store_command(int c) {
80100f1a:	55                   	push   %ebp
80100f1b:	89 e5                	mov    %esp,%ebp
    copybuf[num_copied_commands] = c; // save the current command
80100f1d:	8b 55 08             	mov    0x8(%ebp),%edx
}
80100f20:	5d                   	pop    %ebp
    copybuf[num_copied_commands] = c; // save the current command
80100f21:	89 14 85 20 28 11 80 	mov    %edx,-0x7feed7e0(,%eax,4)
    num_copied_commands++; // increase the number of copied commands by 1
80100f28:	83 c0 01             	add    $0x1,%eax
80100f2b:	a3 fc 27 11 80       	mov    %eax,0x801127fc
}
80100f30:	c3                   	ret    
80100f31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f38:	c3                   	ret    
80100f39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100f40 <consoleintr>:
{
80100f40:	55                   	push   %ebp
80100f41:	89 e5                	mov    %esp,%ebp
80100f43:	57                   	push   %edi
80100f44:	56                   	push   %esi
80100f45:	53                   	push   %ebx
80100f46:	81 ec c8 00 00 00    	sub    $0xc8,%esp
80100f4c:	8b 7d 08             	mov    0x8(%ebp),%edi
  acquire(&cons.lock);
80100f4f:	68 c0 27 11 80       	push   $0x801127c0
80100f54:	e8 c7 4f 00 00       	call   80105f20 <acquire>
  while(((temp_c = getc()) >= 0) || (insert_copied_commands)){
80100f59:	83 c4 10             	add    $0x10,%esp
  int temp_c, doprocdump = 0;
80100f5c:	c7 85 50 ff ff ff 00 	movl   $0x0,-0xb0(%ebp)
80100f63:	00 00 00 
80100f66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f6d:	8d 76 00             	lea    0x0(%esi),%esi
  while(((temp_c = getc()) >= 0) || (insert_copied_commands)){
80100f70:	ff d7                	call   *%edi
80100f72:	89 c3                	mov    %eax,%ebx
80100f74:	85 c0                	test   %eax,%eax
80100f76:	0f 88 cc 00 00 00    	js     80101048 <consoleintr+0x108>
    if (insert_copied_commands) {
80100f7c:	8b 35 04 28 11 80    	mov    0x80112804,%esi
80100f82:	85 f6                	test   %esi,%esi
80100f84:	0f 85 cc 00 00 00    	jne    80101056 <consoleintr+0x116>
      c = copybuf[current_copied_command_to_run_idx];
80100f8a:	a1 00 28 11 80       	mov    0x80112800,%eax
    if (current_copied_command_to_run_idx == (num_copied_commands - 1)) {
80100f8f:	8b 15 fc 27 11 80    	mov    0x801127fc,%edx
80100f95:	8d 4a ff             	lea    -0x1(%edx),%ecx
80100f98:	39 c1                	cmp    %eax,%ecx
80100f9a:	75 0a                	jne    80100fa6 <consoleintr+0x66>
        insert_copied_commands = 0; // turn off this signal
80100f9c:	c7 05 04 28 11 80 00 	movl   $0x0,0x80112804
80100fa3:	00 00 00 
    switch(c){
80100fa6:	83 fb 7f             	cmp    $0x7f,%ebx
80100fa9:	0f 84 e9 00 00 00    	je     80101098 <consoleintr+0x158>
80100faf:	0f 8f 4b 01 00 00    	jg     80101100 <consoleintr+0x1c0>
80100fb5:	8d 43 fa             	lea    -0x6(%ebx),%eax
80100fb8:	83 f8 0f             	cmp    $0xf,%eax
80100fbb:	0f 87 6d 05 00 00    	ja     8010152e <consoleintr+0x5ee>
80100fc1:	ff 24 85 90 97 10 80 	jmp    *-0x7fef6870(,%eax,4)
80100fc8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100fcf:	90                   	nop
      if (!copying) {
80100fd0:	8b 0d 08 28 11 80    	mov    0x80112808,%ecx
80100fd6:	85 c9                	test   %ecx,%ecx
80100fd8:	75 96                	jne    80100f70 <consoleintr+0x30>
        while(input.e != input.w &&
80100fda:	a1 ac 22 11 80       	mov    0x801122ac,%eax
80100fdf:	39 05 a8 22 11 80    	cmp    %eax,0x801122a8
80100fe5:	74 89                	je     80100f70 <consoleintr+0x30>
              input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100fe7:	83 e8 01             	sub    $0x1,%eax
80100fea:	89 c2                	mov    %eax,%edx
80100fec:	83 e2 7f             	and    $0x7f,%edx
        while(input.e != input.w &&
80100fef:	80 ba 24 22 11 80 0a 	cmpb   $0xa,-0x7feedddc(%edx)
80100ff6:	0f 84 74 ff ff ff    	je     80100f70 <consoleintr+0x30>
  if(panicked){
80100ffc:	8b 15 f8 27 11 80    	mov    0x801127f8,%edx
          input.e--;
80101002:	a3 ac 22 11 80       	mov    %eax,0x801122ac
  if(panicked){
80101007:	85 d2                	test   %edx,%edx
80101009:	0f 84 f9 05 00 00    	je     80101608 <consoleintr+0x6c8>
  asm volatile("cli");
8010100f:	fa                   	cli    
    for(;;)
80101010:	eb fe                	jmp    80101010 <consoleintr+0xd0>
80101012:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      copying = 1; // enable copying flag
80101018:	c7 05 08 28 11 80 01 	movl   $0x1,0x80112808
8010101f:	00 00 00 
      num_copied_commands = 0;
80101022:	c7 05 fc 27 11 80 00 	movl   $0x0,0x801127fc
80101029:	00 00 00 
      insert_copied_commands = 0;
8010102c:	c7 05 04 28 11 80 00 	movl   $0x0,0x80112804
80101033:	00 00 00 
  while(((temp_c = getc()) >= 0) || (insert_copied_commands)){
80101036:	ff d7                	call   *%edi
80101038:	89 c3                	mov    %eax,%ebx
8010103a:	85 c0                	test   %eax,%eax
8010103c:	0f 89 3a ff ff ff    	jns    80100f7c <consoleintr+0x3c>
80101042:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101048:	8b 0d 04 28 11 80    	mov    0x80112804,%ecx
8010104e:	85 c9                	test   %ecx,%ecx
80101050:	0f 84 b2 04 00 00    	je     80101508 <consoleintr+0x5c8>
      c = copybuf[current_copied_command_to_run_idx];
80101056:	a1 00 28 11 80       	mov    0x80112800,%eax
8010105b:	8b 1c 85 20 28 11 80 	mov    -0x7feed7e0(,%eax,4),%ebx
      current_copied_command_to_run_idx++;
80101062:	83 c0 01             	add    $0x1,%eax
80101065:	a3 00 28 11 80       	mov    %eax,0x80112800
8010106a:	e9 20 ff ff ff       	jmp    80100f8f <consoleintr+0x4f>
8010106f:	90                   	nop
      copying = 0; // disable copying flag
80101070:	c7 05 08 28 11 80 00 	movl   $0x0,0x80112808
80101077:	00 00 00 
      insert_copied_commands = 1; // send the signal to start running the copied commands
8010107a:	c7 05 04 28 11 80 01 	movl   $0x1,0x80112804
80101081:	00 00 00 
      current_copied_command_to_run_idx = 0; // set the idx to zero
80101084:	c7 05 00 28 11 80 00 	movl   $0x0,0x80112800
8010108b:	00 00 00 
      break;
8010108e:	e9 dd fe ff ff       	jmp    80100f70 <consoleintr+0x30>
80101093:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101097:	90                   	nop
      if (copying) {
80101098:	a1 08 28 11 80       	mov    0x80112808,%eax
8010109d:	85 c0                	test   %eax,%eax
8010109f:	0f 85 70 03 00 00    	jne    80101415 <consoleintr+0x4d5>
        if(input.e != input.w && input.position > input.r){
801010a5:	a1 ac 22 11 80       	mov    0x801122ac,%eax
801010aa:	3b 05 a8 22 11 80    	cmp    0x801122a8,%eax
801010b0:	0f 84 ba fe ff ff    	je     80100f70 <consoleintr+0x30>
801010b6:	8b 15 20 22 11 80    	mov    0x80112220,%edx
801010bc:	3b 15 a4 22 11 80    	cmp    0x801122a4,%edx
801010c2:	0f 86 a8 fe ff ff    	jbe    80100f70 <consoleintr+0x30>
          remove_chars(num_of_backs);
801010c8:	83 ec 0c             	sub    $0xc,%esp
801010cb:	ff 35 b0 22 11 80    	push   0x801122b0
          input.e--;
801010d1:	83 e8 01             	sub    $0x1,%eax
          input.position--;
801010d4:	83 ea 01             	sub    $0x1,%edx
          input.e--;
801010d7:	a3 ac 22 11 80       	mov    %eax,0x801122ac
          input.position--;
801010dc:	89 15 20 22 11 80    	mov    %edx,0x80112220
          remove_chars(num_of_backs);
801010e2:	e8 a9 f9 ff ff       	call   80100a90 <remove_chars>
801010e7:	83 c4 10             	add    $0x10,%esp
801010ea:	e9 81 fe ff ff       	jmp    80100f70 <consoleintr+0x30>
801010ef:	90                   	nop
    switch(c){
801010f0:	c7 85 50 ff ff ff 01 	movl   $0x1,-0xb0(%ebp)
801010f7:	00 00 00 
801010fa:	e9 71 fe ff ff       	jmp    80100f70 <consoleintr+0x30>
801010ff:	90                   	nop
80101100:	81 fb e4 00 00 00    	cmp    $0xe4,%ebx
80101106:	0f 84 cc 02 00 00    	je     801013d8 <consoleintr+0x498>
8010110c:	7e 42                	jle    80101150 <consoleintr+0x210>
8010110e:	81 fb e5 00 00 00    	cmp    $0xe5,%ebx
80101114:	0f 85 ee 02 00 00    	jne    80101408 <consoleintr+0x4c8>
      if (copying) {
8010111a:	a1 08 28 11 80       	mov    0x80112808,%eax
8010111f:	85 c0                	test   %eax,%eax
80101121:	0f 84 89 03 00 00    	je     801014b0 <consoleintr+0x570>
  if (num_copied_commands < INPUT_BUF) {  
80101127:	83 fa 7f             	cmp    $0x7f,%edx
8010112a:	0f 8f 40 fe ff ff    	jg     80100f70 <consoleintr+0x30>
    copybuf[num_copied_commands] = c; // save the current command
80101130:	c7 04 95 20 28 11 80 	movl   $0xe5,-0x7feed7e0(,%edx,4)
80101137:	e5 00 00 00 
    num_copied_commands++; // increase the number of copied commands by 1
8010113b:	83 c2 01             	add    $0x1,%edx
8010113e:	89 15 fc 27 11 80    	mov    %edx,0x801127fc
80101144:	e9 27 fe ff ff       	jmp    80100f70 <consoleintr+0x30>
80101149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80101150:	81 fb e2 00 00 00    	cmp    $0xe2,%ebx
80101156:	0f 84 54 01 00 00    	je     801012b0 <consoleintr+0x370>
8010115c:	81 fb e3 00 00 00    	cmp    $0xe3,%ebx
80101162:	0f 85 a0 02 00 00    	jne    80101408 <consoleintr+0x4c8>
      if (!copying) {
80101168:	a1 08 28 11 80       	mov    0x80112808,%eax
8010116d:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)
80101173:	85 c0                	test   %eax,%eax
80101175:	0f 85 f5 fd ff ff    	jne    80100f70 <consoleintr+0x30>
        if(command_id < num_of_stored_commands - 1)/*Locating the last command in order to have a boundary*/
8010117b:	a1 b4 22 11 80       	mov    0x801122b4,%eax
80101180:	8b 35 b8 22 11 80    	mov    0x801122b8,%esi
80101186:	83 e8 01             	sub    $0x1,%eax
80101189:	89 b5 44 ff ff ff    	mov    %esi,-0xbc(%ebp)
8010118f:	39 f0                	cmp    %esi,%eax
80101191:	0f 8e d9 fd ff ff    	jle    80100f70 <consoleintr+0x30>
          for(int i=input.position; i < input.e; i++)
80101197:	a1 20 22 11 80       	mov    0x80112220,%eax
8010119c:	8b 35 ac 22 11 80    	mov    0x801122ac,%esi
801011a2:	39 f0                	cmp    %esi,%eax
801011a4:	73 77                	jae    8010121d <consoleintr+0x2dd>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801011a6:	89 7d 08             	mov    %edi,0x8(%ebp)
801011a9:	89 b5 4c ff ff ff    	mov    %esi,-0xb4(%ebp)
801011af:	89 c6                	mov    %eax,%esi
801011b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801011b8:	b8 0e 00 00 00       	mov    $0xe,%eax
801011bd:	ba d4 03 00 00       	mov    $0x3d4,%edx
801011c2:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801011c3:	bb d5 03 00 00       	mov    $0x3d5,%ebx
801011c8:	89 da                	mov    %ebx,%edx
801011ca:	ec                   	in     (%dx),%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801011cb:	bf 0f 00 00 00       	mov    $0xf,%edi
  cursor_position = inb(CRTPORT+1) << 8;
801011d0:	0f b6 c8             	movzbl %al,%ecx
801011d3:	ba d4 03 00 00       	mov    $0x3d4,%edx
801011d8:	c1 e1 08             	shl    $0x8,%ecx
801011db:	89 f8                	mov    %edi,%eax
801011dd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801011de:	89 da                	mov    %ebx,%edx
801011e0:	ec                   	in     (%dx),%al
  cursor_position = cursor_position | inb(CRTPORT+1);/*Finding current position of cursor*/
801011e1:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801011e4:	ba d4 03 00 00       	mov    $0x3d4,%edx
801011e9:	09 c1                	or     %eax,%ecx
801011eb:	89 f8                	mov    %edi,%eax
  cursor_position = cursor_position + 1; /*Moving cursor one step forward*/
801011ed:	83 c1 01             	add    $0x1,%ecx
801011f0:	ee                   	out    %al,(%dx)
801011f1:	89 c8                	mov    %ecx,%eax
801011f3:	89 da                	mov    %ebx,%edx
801011f5:	ee                   	out    %al,(%dx)
801011f6:	b8 0e 00 00 00       	mov    $0xe,%eax
801011fb:	ba d4 03 00 00       	mov    $0x3d4,%edx
80101200:	ee                   	out    %al,(%dx)
  outb(CRTPORT+1, (unsigned char)((cursor_position>>8) & 0xFF)); /*Reset cursor*/
80101201:	89 c8                	mov    %ecx,%eax
80101203:	89 da                	mov    %ebx,%edx
80101205:	c1 f8 08             	sar    $0x8,%eax
80101208:	ee                   	out    %al,(%dx)
          for(int i=input.position; i < input.e; i++)
80101209:	83 c6 01             	add    $0x1,%esi
8010120c:	39 b5 4c ff ff ff    	cmp    %esi,-0xb4(%ebp)
80101212:	77 a4                	ja     801011b8 <consoleintr+0x278>
80101214:	8b b5 4c ff ff ff    	mov    -0xb4(%ebp),%esi
8010121a:	8b 7d 08             	mov    0x8(%ebp),%edi
          while(input.e > input.w)
8010121d:	39 35 a8 22 11 80    	cmp    %esi,0x801122a8
80101223:	73 32                	jae    80101257 <consoleintr+0x317>
80101225:	8d 76 00             	lea    0x0(%esi),%esi
            remove_chars(0);
80101228:	83 ec 0c             	sub    $0xc,%esp
            input.e--;
8010122b:	83 ee 01             	sub    $0x1,%esi
            remove_chars(0);
8010122e:	6a 00                	push   $0x0
            input.e--;
80101230:	89 35 ac 22 11 80    	mov    %esi,0x801122ac
            remove_chars(0);
80101236:	e8 55 f8 ff ff       	call   80100a90 <remove_chars>
          while(input.e > input.w)
8010123b:	8b 35 ac 22 11 80    	mov    0x801122ac,%esi
80101241:	83 c4 10             	add    $0x10,%esp
80101244:	3b 35 a8 22 11 80    	cmp    0x801122a8,%esi
8010124a:	77 dc                	ja     80101228 <consoleintr+0x2e8>
          command_id ++;
8010124c:	a1 b8 22 11 80       	mov    0x801122b8,%eax
80101251:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
80101257:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
8010125d:	8b 9d 48 ff ff ff    	mov    -0xb8(%ebp),%ebx
80101263:	83 c0 01             	add    $0x1,%eax
80101266:	a3 b8 22 11 80       	mov    %eax,0x801122b8
          for(int i=0; i < strlen(command_history[command_id]); i++)
8010126b:	c1 e0 07             	shl    $0x7,%eax
8010126e:	83 ec 0c             	sub    $0xc,%esp
80101271:	05 c0 22 11 80       	add    $0x801122c0,%eax
80101276:	50                   	push   %eax
80101277:	e8 94 50 00 00       	call   80106310 <strlen>
8010127c:	83 c4 10             	add    $0x10,%esp
8010127f:	39 d8                	cmp    %ebx,%eax
80101281:	0f 8e a7 05 00 00    	jle    8010182e <consoleintr+0x8ee>
            letter = command_history[command_id][i];
80101287:	a1 b8 22 11 80       	mov    0x801122b8,%eax
8010128c:	c1 e0 07             	shl    $0x7,%eax
8010128f:	0f b6 b4 03 c0 22 11 	movzbl -0x7feedd40(%ebx,%eax,1),%esi
80101296:	80 
  if(panicked){
80101297:	a1 f8 27 11 80       	mov    0x801127f8,%eax
8010129c:	85 c0                	test   %eax,%eax
8010129e:	0f 84 c6 03 00 00    	je     8010166a <consoleintr+0x72a>
  asm volatile("cli");
801012a4:	fa                   	cli    
    for(;;)
801012a5:	eb fe                	jmp    801012a5 <consoleintr+0x365>
801012a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801012ae:	66 90                	xchg   %ax,%ax
      if (!copying) {
801012b0:	a1 08 28 11 80       	mov    0x80112808,%eax
801012b5:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)
801012bb:	85 c0                	test   %eax,%eax
801012bd:	0f 85 ad fc ff ff    	jne    80100f70 <consoleintr+0x30>
        if(command_id >= 0) /*We need to have a command in order to press up and see history*/
801012c3:	a1 b8 22 11 80       	mov    0x801122b8,%eax
801012c8:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
801012ce:	85 c0                	test   %eax,%eax
801012d0:	0f 88 9a fc ff ff    	js     80100f70 <consoleintr+0x30>
          for(int i=input.position; i < input.e; i++)
801012d6:	a1 20 22 11 80       	mov    0x80112220,%eax
801012db:	8b 35 ac 22 11 80    	mov    0x801122ac,%esi
801012e1:	39 f0                	cmp    %esi,%eax
801012e3:	73 70                	jae    80101355 <consoleintr+0x415>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801012e5:	89 7d 08             	mov    %edi,0x8(%ebp)
801012e8:	89 b5 4c ff ff ff    	mov    %esi,-0xb4(%ebp)
801012ee:	89 c6                	mov    %eax,%esi
801012f0:	b8 0e 00 00 00       	mov    $0xe,%eax
801012f5:	ba d4 03 00 00       	mov    $0x3d4,%edx
801012fa:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801012fb:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80101300:	89 da                	mov    %ebx,%edx
80101302:	ec                   	in     (%dx),%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101303:	bf 0f 00 00 00       	mov    $0xf,%edi
  cursor_position = inb(CRTPORT+1) << 8;
80101308:	0f b6 c8             	movzbl %al,%ecx
8010130b:	ba d4 03 00 00       	mov    $0x3d4,%edx
80101310:	c1 e1 08             	shl    $0x8,%ecx
80101313:	89 f8                	mov    %edi,%eax
80101315:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101316:	89 da                	mov    %ebx,%edx
80101318:	ec                   	in     (%dx),%al
  cursor_position = cursor_position | inb(CRTPORT+1);/*Finding current position of cursor*/
80101319:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010131c:	ba d4 03 00 00       	mov    $0x3d4,%edx
80101321:	09 c1                	or     %eax,%ecx
80101323:	89 f8                	mov    %edi,%eax
  cursor_position = cursor_position + 1; /*Moving cursor one step forward*/
80101325:	83 c1 01             	add    $0x1,%ecx
80101328:	ee                   	out    %al,(%dx)
80101329:	89 c8                	mov    %ecx,%eax
8010132b:	89 da                	mov    %ebx,%edx
8010132d:	ee                   	out    %al,(%dx)
8010132e:	b8 0e 00 00 00       	mov    $0xe,%eax
80101333:	ba d4 03 00 00       	mov    $0x3d4,%edx
80101338:	ee                   	out    %al,(%dx)
  outb(CRTPORT+1, (unsigned char)((cursor_position>>8) & 0xFF)); /*Reset cursor*/
80101339:	89 c8                	mov    %ecx,%eax
8010133b:	89 da                	mov    %ebx,%edx
8010133d:	c1 f8 08             	sar    $0x8,%eax
80101340:	ee                   	out    %al,(%dx)
          for(int i=input.position; i < input.e; i++)
80101341:	83 c6 01             	add    $0x1,%esi
80101344:	3b b5 4c ff ff ff    	cmp    -0xb4(%ebp),%esi
8010134a:	72 a4                	jb     801012f0 <consoleintr+0x3b0>
8010134c:	8b b5 4c ff ff ff    	mov    -0xb4(%ebp),%esi
80101352:	8b 7d 08             	mov    0x8(%ebp),%edi
          while(input.e > input.w)
80101355:	3b 35 a8 22 11 80    	cmp    0x801122a8,%esi
8010135b:	0f 86 e8 04 00 00    	jbe    80101849 <consoleintr+0x909>
80101361:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            remove_chars(0);
80101368:	83 ec 0c             	sub    $0xc,%esp
            input.e--;
8010136b:	83 ee 01             	sub    $0x1,%esi
            remove_chars(0);
8010136e:	6a 00                	push   $0x0
            input.e--;
80101370:	89 35 ac 22 11 80    	mov    %esi,0x801122ac
            remove_chars(0);
80101376:	e8 15 f7 ff ff       	call   80100a90 <remove_chars>
          while(input.e > input.w)
8010137b:	8b 35 ac 22 11 80    	mov    0x801122ac,%esi
80101381:	83 c4 10             	add    $0x10,%esp
80101384:	3b 35 a8 22 11 80    	cmp    0x801122a8,%esi
8010138a:	77 dc                	ja     80101368 <consoleintr+0x428>
          for(int i=0; i < strlen(command_history[command_id]); i++)
8010138c:	a1 b8 22 11 80       	mov    0x801122b8,%eax
80101391:	8b 9d 48 ff ff ff    	mov    -0xb8(%ebp),%ebx
80101397:	c1 e0 07             	shl    $0x7,%eax
8010139a:	83 ec 0c             	sub    $0xc,%esp
8010139d:	05 c0 22 11 80       	add    $0x801122c0,%eax
801013a2:	50                   	push   %eax
801013a3:	e8 68 4f 00 00       	call   80106310 <strlen>
801013a8:	83 c4 10             	add    $0x10,%esp
801013ab:	39 d8                	cmp    %ebx,%eax
801013ad:	0f 8e 65 04 00 00    	jle    80101818 <consoleintr+0x8d8>
            letter = command_history[command_id][i];
801013b3:	a1 b8 22 11 80       	mov    0x801122b8,%eax
801013b8:	c1 e0 07             	shl    $0x7,%eax
801013bb:	0f b6 b4 03 c0 22 11 	movzbl -0x7feedd40(%ebx,%eax,1),%esi
801013c2:	80 
  if(panicked){
801013c3:	a1 f8 27 11 80       	mov    0x801127f8,%eax
801013c8:	85 c0                	test   %eax,%eax
801013ca:	0f 84 6d 02 00 00    	je     8010163d <consoleintr+0x6fd>
  asm volatile("cli");
801013d0:	fa                   	cli    
    for(;;)
801013d1:	eb fe                	jmp    801013d1 <consoleintr+0x491>
801013d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801013d7:	90                   	nop
      if (copying) {
801013d8:	a1 08 28 11 80       	mov    0x80112808,%eax
801013dd:	85 c0                	test   %eax,%eax
801013df:	74 57                	je     80101438 <consoleintr+0x4f8>
  if (num_copied_commands < INPUT_BUF) {  
801013e1:	83 fa 7f             	cmp    $0x7f,%edx
801013e4:	0f 8f 86 fb ff ff    	jg     80100f70 <consoleintr+0x30>
    copybuf[num_copied_commands] = c; // save the current command
801013ea:	c7 04 95 20 28 11 80 	movl   $0xe4,-0x7feed7e0(,%edx,4)
801013f1:	e4 00 00 00 
    num_copied_commands++; // increase the number of copied commands by 1
801013f5:	83 c2 01             	add    $0x1,%edx
801013f8:	89 15 fc 27 11 80    	mov    %edx,0x801127fc
801013fe:	e9 6d fb ff ff       	jmp    80100f70 <consoleintr+0x30>
80101403:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101407:	90                   	nop
      if (copying) {
80101408:	a1 08 28 11 80       	mov    0x80112808,%eax
8010140d:	85 c0                	test   %eax,%eax
8010140f:	0f 84 33 01 00 00    	je     80101548 <consoleintr+0x608>
  if (num_copied_commands < INPUT_BUF) {  
80101415:	83 fa 7f             	cmp    $0x7f,%edx
80101418:	0f 8f 52 fb ff ff    	jg     80100f70 <consoleintr+0x30>
    copybuf[num_copied_commands] = c; // save the current command
8010141e:	89 1c 95 20 28 11 80 	mov    %ebx,-0x7feed7e0(,%edx,4)
    num_copied_commands++; // increase the number of copied commands by 1
80101425:	83 c2 01             	add    $0x1,%edx
80101428:	89 15 fc 27 11 80    	mov    %edx,0x801127fc
8010142e:	e9 3d fb ff ff       	jmp    80100f70 <consoleintr+0x30>
80101433:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101437:	90                   	nop
        if(input.position > input.r) /*Checking that we are not at first of the line*/
80101438:	a1 20 22 11 80       	mov    0x80112220,%eax
8010143d:	3b 05 a4 22 11 80    	cmp    0x801122a4,%eax
80101443:	0f 86 27 fb ff ff    	jbe    80100f70 <consoleintr+0x30>
          input.position = input.position - 1;/*Fixing position of current state*/
80101449:	83 e8 01             	sub    $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010144c:	be d4 03 00 00       	mov    $0x3d4,%esi
          num_of_backs += 1; /*With each left movement we calculate how much do we go back*/
80101451:	83 05 b0 22 11 80 01 	addl   $0x1,0x801122b0
          input.position = input.position - 1;/*Fixing position of current state*/
80101458:	a3 20 22 11 80       	mov    %eax,0x80112220
8010145d:	89 f2                	mov    %esi,%edx
8010145f:	b8 0e 00 00 00       	mov    $0xe,%eax
80101464:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101465:	bb d5 03 00 00       	mov    $0x3d5,%ebx
8010146a:	89 da                	mov    %ebx,%edx
8010146c:	ec                   	in     (%dx),%al
  cursor_position = inb(CRTPORT+1) << 8;
8010146d:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101470:	89 f2                	mov    %esi,%edx
80101472:	89 c1                	mov    %eax,%ecx
80101474:	b8 0f 00 00 00       	mov    $0xf,%eax
80101479:	c1 e1 08             	shl    $0x8,%ecx
8010147c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010147d:	89 da                	mov    %ebx,%edx
8010147f:	ec                   	in     (%dx),%al
  cursor_position = cursor_position | inb(CRTPORT+1);/*Finding current position of cursor*/
80101480:	0f b6 c0             	movzbl %al,%eax
80101483:	09 c1                	or     %eax,%ecx
  cursor_position = cursor_position - 1; /*Moving cursor one step back*/
80101485:	83 e9 01             	sub    $0x1,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101488:	b8 0f 00 00 00       	mov    $0xf,%eax
8010148d:	89 f2                	mov    %esi,%edx
8010148f:	ee                   	out    %al,(%dx)
80101490:	89 c8                	mov    %ecx,%eax
80101492:	89 da                	mov    %ebx,%edx
80101494:	ee                   	out    %al,(%dx)
80101495:	b8 0e 00 00 00       	mov    $0xe,%eax
8010149a:	89 f2                	mov    %esi,%edx
8010149c:	ee                   	out    %al,(%dx)
  outb(CRTPORT+1, (unsigned char)((cursor_position>>8) & 0xFF)); /*Reset cursor*/
8010149d:	89 c8                	mov    %ecx,%eax
8010149f:	89 da                	mov    %ebx,%edx
801014a1:	c1 f8 08             	sar    $0x8,%eax
801014a4:	ee                   	out    %al,(%dx)
}
801014a5:	e9 c6 fa ff ff       	jmp    80100f70 <consoleintr+0x30>
801014aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        if(input.position < input.e) /*Checking that we are not at end of the line*/
801014b0:	a1 20 22 11 80       	mov    0x80112220,%eax
801014b5:	3b 05 ac 22 11 80    	cmp    0x801122ac,%eax
801014bb:	0f 83 af fa ff ff    	jae    80100f70 <consoleintr+0x30>
          input.position = input.position + 1;/*Fixing position of current state*/
801014c1:	83 c0 01             	add    $0x1,%eax
801014c4:	be d4 03 00 00       	mov    $0x3d4,%esi
          num_of_backs -= 1; /*With each left movement we calculate how much do we go back*/
801014c9:	83 2d b0 22 11 80 01 	subl   $0x1,0x801122b0
          input.position = input.position + 1;/*Fixing position of current state*/
801014d0:	a3 20 22 11 80       	mov    %eax,0x80112220
801014d5:	89 f2                	mov    %esi,%edx
801014d7:	b8 0e 00 00 00       	mov    $0xe,%eax
801014dc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801014dd:	bb d5 03 00 00       	mov    $0x3d5,%ebx
801014e2:	89 da                	mov    %ebx,%edx
801014e4:	ec                   	in     (%dx),%al
  cursor_position = inb(CRTPORT+1) << 8;
801014e5:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801014e8:	89 f2                	mov    %esi,%edx
801014ea:	89 c1                	mov    %eax,%ecx
801014ec:	b8 0f 00 00 00       	mov    $0xf,%eax
801014f1:	c1 e1 08             	shl    $0x8,%ecx
801014f4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801014f5:	89 da                	mov    %ebx,%edx
801014f7:	ec                   	in     (%dx),%al
  cursor_position = cursor_position | inb(CRTPORT+1);/*Finding current position of cursor*/
801014f8:	0f b6 c0             	movzbl %al,%eax
801014fb:	09 c1                	or     %eax,%ecx
  cursor_position = cursor_position + 1; /*Moving cursor one step forward*/
801014fd:	83 c1 01             	add    $0x1,%ecx
80101500:	eb 86                	jmp    80101488 <consoleintr+0x548>
80101502:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&cons.lock);
80101508:	83 ec 0c             	sub    $0xc,%esp
8010150b:	68 c0 27 11 80       	push   $0x801127c0
80101510:	e8 ab 49 00 00       	call   80105ec0 <release>
  if(doprocdump) {
80101515:	8b 95 50 ff ff ff    	mov    -0xb0(%ebp),%edx
8010151b:	83 c4 10             	add    $0x10,%esp
8010151e:	85 d2                	test   %edx,%edx
80101520:	0f 85 0a 01 00 00    	jne    80101630 <consoleintr+0x6f0>
}
80101526:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101529:	5b                   	pop    %ebx
8010152a:	5e                   	pop    %esi
8010152b:	5f                   	pop    %edi
8010152c:	5d                   	pop    %ebp
8010152d:	c3                   	ret    
      if (copying) {
8010152e:	83 3d 08 28 11 80 00 	cmpl   $0x0,0x80112808
80101535:	0f 85 da fe ff ff    	jne    80101415 <consoleintr+0x4d5>
        if(c != 0 && input.e-input.r < INPUT_BUF) {
8010153b:	85 db                	test   %ebx,%ebx
8010153d:	0f 84 2d fa ff ff    	je     80100f70 <consoleintr+0x30>
80101543:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101547:	90                   	nop
80101548:	8b 35 ac 22 11 80    	mov    0x801122ac,%esi
8010154e:	8b 15 a4 22 11 80    	mov    0x801122a4,%edx
80101554:	89 f0                	mov    %esi,%eax
80101556:	29 d0                	sub    %edx,%eax
80101558:	83 f8 7f             	cmp    $0x7f,%eax
8010155b:	0f 87 0f fa ff ff    	ja     80100f70 <consoleintr+0x30>
          int is_divide = 0;
80101561:	c7 85 58 ff ff ff 00 	movl   $0x0,-0xa8(%ebp)
80101568:	00 00 00 
          int is_math_expression = detect_math_expression(c);
8010156b:	88 9d 48 ff ff ff    	mov    %bl,-0xb8(%ebp)
  if (c == '?' && input.buf[(input.position-1) % INPUT_BUF] == '=') {
80101571:	80 fb 3f             	cmp    $0x3f,%bl
80101574:	0f 84 b5 01 00 00    	je     8010172f <consoleintr+0x7ef>
                  input.buf[input.e++ % INPUT_BUF] = c;
8010157a:	8d 46 01             	lea    0x1(%esi),%eax
8010157d:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%ebp)
            c = (c == '\r') ? '\n' : c;     
80101583:	83 fb 0d             	cmp    $0xd,%ebx
80101586:	0f 84 54 02 00 00    	je     801017e0 <consoleintr+0x8a0>
            if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF)
8010158c:	83 fb 0a             	cmp    $0xa,%ebx
8010158f:	0f 84 57 02 00 00    	je     801017ec <consoleintr+0x8ac>
80101595:	83 fb 04             	cmp    $0x4,%ebx
80101598:	0f 84 4e 02 00 00    	je     801017ec <consoleintr+0x8ac>
8010159e:	8d 82 80 00 00 00    	lea    0x80(%edx),%eax
801015a4:	39 c6                	cmp    %eax,%esi
801015a6:	0f 84 40 02 00 00    	je     801017ec <consoleintr+0x8ac>
        if(input.e != input.w && input.position > input.r){
801015ac:	8b 0d 20 22 11 80    	mov    0x80112220,%ecx
              if(num_of_backs == 0) {
801015b2:	a1 b0 22 11 80       	mov    0x801122b0,%eax
          input.position = input.position + 1;/*Fixing position of current state*/
801015b7:	8d 51 01             	lea    0x1(%ecx),%edx
              if(num_of_backs == 0) {
801015ba:	89 85 40 ff ff ff    	mov    %eax,-0xc0(%ebp)
        if(input.e != input.w && input.position > input.r){
801015c0:	89 8d 44 ff ff ff    	mov    %ecx,-0xbc(%ebp)
          input.position = input.position + 1;/*Fixing position of current state*/
801015c6:	89 95 3c ff ff ff    	mov    %edx,-0xc4(%ebp)
              if(num_of_backs == 0) {
801015cc:	85 c0                	test   %eax,%eax
801015ce:	0f 85 c3 00 00 00    	jne    80101697 <consoleintr+0x757>
                  input.buf[input.e++ % INPUT_BUF] = c;
801015d4:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
                  input.position ++;
801015da:	89 15 20 22 11 80    	mov    %edx,0x80112220
                  input.buf[input.e++ % INPUT_BUF] = c;
801015e0:	a3 ac 22 11 80       	mov    %eax,0x801122ac
801015e5:	89 f0                	mov    %esi,%eax
  if(panicked){
801015e7:	8b 35 f8 27 11 80    	mov    0x801127f8,%esi
                  input.buf[input.e++ % INPUT_BUF] = c;
801015ed:	83 e0 7f             	and    $0x7f,%eax
801015f0:	88 98 24 22 11 80    	mov    %bl,-0x7feedddc(%eax)
  if(panicked){
801015f6:	85 f6                	test   %esi,%esi
801015f8:	0f 84 3f 02 00 00    	je     8010183d <consoleintr+0x8fd>
  asm volatile("cli");
801015fe:	fa                   	cli    
    for(;;)
801015ff:	eb fe                	jmp    801015ff <consoleintr+0x6bf>
80101601:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101608:	b8 00 01 00 00       	mov    $0x100,%eax
8010160d:	e8 3e ef ff ff       	call   80100550 <consputc.part.0>
        while(input.e != input.w &&
80101612:	a1 ac 22 11 80       	mov    0x801122ac,%eax
80101617:	3b 05 a8 22 11 80    	cmp    0x801122a8,%eax
8010161d:	0f 85 c4 f9 ff ff    	jne    80100fe7 <consoleintr+0xa7>
80101623:	e9 48 f9 ff ff       	jmp    80100f70 <consoleintr+0x30>
80101628:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010162f:	90                   	nop
    procdump();  // now call procdump() wo. cons.lock held
80101630:	e8 9b 3b 00 00       	call   801051d0 <procdump>
}
80101635:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101638:	5b                   	pop    %ebx
80101639:	5e                   	pop    %esi
8010163a:	5f                   	pop    %edi
8010163b:	5d                   	pop    %ebp
8010163c:	c3                   	ret    
            letter = command_history[command_id][i];
8010163d:	89 f0                	mov    %esi,%eax
          for(int i=0; i < strlen(command_history[command_id]); i++)
8010163f:	83 c3 01             	add    $0x1,%ebx
            letter = command_history[command_id][i];
80101642:	0f be c0             	movsbl %al,%eax
80101645:	e8 06 ef ff ff       	call   80100550 <consputc.part.0>
            input.buf[input.e++] = letter;
8010164a:	a1 ac 22 11 80       	mov    0x801122ac,%eax
8010164f:	89 f1                	mov    %esi,%ecx
80101651:	8d 50 01             	lea    0x1(%eax),%edx
80101654:	88 88 24 22 11 80    	mov    %cl,-0x7feedddc(%eax)
          for(int i=0; i < strlen(command_history[command_id]); i++)
8010165a:	a1 b8 22 11 80       	mov    0x801122b8,%eax
            input.buf[input.e++] = letter;
8010165f:	89 15 ac 22 11 80    	mov    %edx,0x801122ac
80101665:	e9 2d fd ff ff       	jmp    80101397 <consoleintr+0x457>
            letter = command_history[command_id][i];
8010166a:	89 f0                	mov    %esi,%eax
          for(int i=0; i < strlen(command_history[command_id]); i++)
8010166c:	83 c3 01             	add    $0x1,%ebx
            letter = command_history[command_id][i];
8010166f:	0f be c0             	movsbl %al,%eax
80101672:	e8 d9 ee ff ff       	call   80100550 <consputc.part.0>
            input.buf[input.e++] = letter;
80101677:	a1 ac 22 11 80       	mov    0x801122ac,%eax
8010167c:	89 f1                	mov    %esi,%ecx
8010167e:	8d 50 01             	lea    0x1(%eax),%edx
80101681:	88 88 24 22 11 80    	mov    %cl,-0x7feedddc(%eax)
          for(int i=0; i < strlen(command_history[command_id]); i++)
80101687:	a1 b8 22 11 80       	mov    0x801122b8,%eax
            input.buf[input.e++] = letter;
8010168c:	89 15 ac 22 11 80    	mov    %edx,0x801122ac
80101692:	e9 d4 fb ff ff       	jmp    8010126b <consoleintr+0x32b>
                for(int i=input.e; i > input.position; i--)
80101697:	89 f0                	mov    %esi,%eax
80101699:	3b b5 44 ff ff ff    	cmp    -0xbc(%ebp),%esi
8010169f:	76 4b                	jbe    801016ec <consoleintr+0x7ac>
801016a1:	89 9d 38 ff ff ff    	mov    %ebx,-0xc8(%ebp)
801016a7:	8b b5 44 ff ff ff    	mov    -0xbc(%ebp),%esi
801016ad:	8d 76 00             	lea    0x0(%esi),%esi
                  input.buf[(i + 1) % INPUT_BUF] = input.buf[(i) % INPUT_BUF];
801016b0:	89 c1                	mov    %eax,%ecx
801016b2:	c1 f9 1f             	sar    $0x1f,%ecx
801016b5:	c1 e9 19             	shr    $0x19,%ecx
801016b8:	8d 14 08             	lea    (%eax,%ecx,1),%edx
801016bb:	83 e2 7f             	and    $0x7f,%edx
801016be:	29 ca                	sub    %ecx,%edx
801016c0:	0f b6 9a 24 22 11 80 	movzbl -0x7feedddc(%edx),%ebx
801016c7:	8d 50 01             	lea    0x1(%eax),%edx
                for(int i=input.e; i > input.position; i--)
801016ca:	83 e8 01             	sub    $0x1,%eax
                  input.buf[(i + 1) % INPUT_BUF] = input.buf[(i) % INPUT_BUF];
801016cd:	89 d1                	mov    %edx,%ecx
801016cf:	c1 f9 1f             	sar    $0x1f,%ecx
801016d2:	c1 e9 19             	shr    $0x19,%ecx
801016d5:	01 ca                	add    %ecx,%edx
801016d7:	83 e2 7f             	and    $0x7f,%edx
801016da:	29 ca                	sub    %ecx,%edx
801016dc:	88 9a 24 22 11 80    	mov    %bl,-0x7feedddc(%edx)
                for(int i=input.e; i > input.position; i--)
801016e2:	39 f0                	cmp    %esi,%eax
801016e4:	77 ca                	ja     801016b0 <consoleintr+0x770>
801016e6:	8b 9d 38 ff ff ff    	mov    -0xc8(%ebp),%ebx
                input.buf[input.position % INPUT_BUF] = c;
801016ec:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
801016f2:	0f b6 8d 48 ff ff ff 	movzbl -0xb8(%ebp),%ecx
                insert_chars(num_of_backs,c);
801016f9:	83 ec 08             	sub    $0x8,%esp
801016fc:	53                   	push   %ebx
                input.buf[input.position % INPUT_BUF] = c;
801016fd:	83 e0 7f             	and    $0x7f,%eax
                insert_chars(num_of_backs,c);
80101700:	ff b5 40 ff ff ff    	push   -0xc0(%ebp)
                input.buf[input.position % INPUT_BUF] = c;
80101706:	88 88 24 22 11 80    	mov    %cl,-0x7feedddc(%eax)
                input.e++;
8010170c:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
80101712:	a3 ac 22 11 80       	mov    %eax,0x801122ac
                input.position++;
80101717:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
8010171d:	a3 20 22 11 80       	mov    %eax,0x80112220
                insert_chars(num_of_backs,c);
80101722:	e8 09 f4 ff ff       	call   80100b30 <insert_chars>
80101727:	83 c4 10             	add    $0x10,%esp
8010172a:	e9 41 f8 ff ff       	jmp    80100f70 <consoleintr+0x30>
8010172f:	89 95 4c ff ff ff    	mov    %edx,-0xb4(%ebp)
80101735:	e8 16 ed ff ff       	call   80100450 <detect_math_expression.part.0>
          if (is_math_expression) {
8010173a:	8b 95 4c ff ff ff    	mov    -0xb4(%ebp),%edx
80101740:	85 c0                	test   %eax,%eax
80101742:	0f 84 32 fe ff ff    	je     8010157a <consoleintr+0x63a>
            float result = calculate_result_math_expression(&is_divide);
80101748:	83 ec 0c             	sub    $0xc,%esp
8010174b:	8d 85 58 ff ff ff    	lea    -0xa8(%ebp),%eax
80101751:	50                   	push   %eax
80101752:	e8 c9 f4 ff ff       	call   80100c20 <calculate_result_math_expression>
            if (!is_divide) {
80101757:	8b 9d 58 ff ff ff    	mov    -0xa8(%ebp),%ebx
8010175d:	83 c4 10             	add    $0x10,%esp
80101760:	85 db                	test   %ebx,%ebx
80101762:	0f 85 18 02 00 00    	jne    80101980 <consoleintr+0xa40>
              res_len = int_to_str((int)result, res_str);
80101768:	d9 bd 56 ff ff ff    	fnstcw -0xaa(%ebp)
8010176e:	83 ec 08             	sub    $0x8,%esp
80101771:	8d 9d 5c ff ff ff    	lea    -0xa4(%ebp),%ebx
80101777:	53                   	push   %ebx
80101778:	0f b7 85 56 ff ff ff 	movzwl -0xaa(%ebp),%eax
8010177f:	80 cc 0c             	or     $0xc,%ah
80101782:	66 89 85 54 ff ff ff 	mov    %ax,-0xac(%ebp)
80101789:	d9 ad 54 ff ff ff    	fldcw  -0xac(%ebp)
8010178f:	db 9d 4c ff ff ff    	fistpl -0xb4(%ebp)
80101795:	d9 ad 56 ff ff ff    	fldcw  -0xaa(%ebp)
8010179b:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
801017a1:	50                   	push   %eax
801017a2:	e8 89 f6 ff ff       	call   80100e30 <int_to_str>
801017a7:	83 c4 10             	add    $0x10,%esp
801017aa:	89 c2                	mov    %eax,%edx
{
801017ac:	89 9d 4c ff ff ff    	mov    %ebx,-0xb4(%ebp)
801017b2:	be 04 00 00 00       	mov    $0x4,%esi
801017b7:	89 d3                	mov    %edx,%ebx
  if(panicked){
801017b9:	8b 0d f8 27 11 80    	mov    0x801127f8,%ecx
              input.e--;
801017bf:	83 2d ac 22 11 80 01 	subl   $0x1,0x801122ac
              input.position--;
801017c6:	83 2d 20 22 11 80 01 	subl   $0x1,0x80112220
  if(panicked){
801017cd:	85 c9                	test   %ecx,%ecx
801017cf:	0f 84 39 01 00 00    	je     8010190e <consoleintr+0x9ce>
801017d5:	fa                   	cli    
    for(;;)
801017d6:	eb fe                	jmp    801017d6 <consoleintr+0x896>
801017d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801017df:	90                   	nop
801017e0:	c6 85 48 ff ff ff 0a 	movb   $0xa,-0xb8(%ebp)
            c = (c == '\r') ? '\n' : c;     
801017e7:	bb 0a 00 00 00       	mov    $0xa,%ebx
              input.buf[input.e++ % INPUT_BUF] = c;
801017ec:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
801017f2:	0f b6 8d 48 ff ff ff 	movzbl -0xb8(%ebp),%ecx
801017f9:	a3 ac 22 11 80       	mov    %eax,0x801122ac
801017fe:	89 f0                	mov    %esi,%eax
80101800:	83 e0 7f             	and    $0x7f,%eax
80101803:	88 88 24 22 11 80    	mov    %cl,-0x7feedddc(%eax)
  if(panicked){
80101809:	a1 f8 27 11 80       	mov    0x801127f8,%eax
8010180e:	85 c0                	test   %eax,%eax
80101810:	74 48                	je     8010185a <consoleintr+0x91a>
80101812:	fa                   	cli    
    for(;;)
80101813:	eb fe                	jmp    80101813 <consoleintr+0x8d3>
80101815:	8d 76 00             	lea    0x0(%esi),%esi
          input.position = input.e;
80101818:	a1 ac 22 11 80       	mov    0x801122ac,%eax
          command_id --;
8010181d:	83 2d b8 22 11 80 01 	subl   $0x1,0x801122b8
          input.position = input.e;
80101824:	a3 20 22 11 80       	mov    %eax,0x80112220
80101829:	e9 42 f7 ff ff       	jmp    80100f70 <consoleintr+0x30>
          input.position = input.e;
8010182e:	a1 ac 22 11 80       	mov    0x801122ac,%eax
80101833:	a3 20 22 11 80       	mov    %eax,0x80112220
80101838:	e9 33 f7 ff ff       	jmp    80100f70 <consoleintr+0x30>
8010183d:	89 d8                	mov    %ebx,%eax
8010183f:	e8 0c ed ff ff       	call   80100550 <consputc.part.0>
80101844:	e9 27 f7 ff ff       	jmp    80100f70 <consoleintr+0x30>
80101849:	8b 9d 48 ff ff ff    	mov    -0xb8(%ebp),%ebx
8010184f:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
80101855:	e9 3d fb ff ff       	jmp    80101397 <consoleintr+0x457>
8010185a:	89 d8                	mov    %ebx,%eax
8010185c:	e8 ef ec ff ff       	call   80100550 <consputc.part.0>
              for(int i=input.w, j=0; i < input.e-1; i++, j++)
80101861:	8b 35 ac 22 11 80    	mov    0x801122ac,%esi
80101867:	8b 0d a8 22 11 80    	mov    0x801122a8,%ecx
              num_of_backs = 0; /*Set num of back to 0*/
8010186d:	c7 05 b0 22 11 80 00 	movl   $0x0,0x801122b0
80101874:	00 00 00 
              for(int i=input.w, j=0; i < input.e-1; i++, j++)
80101877:	89 b5 4c ff ff ff    	mov    %esi,-0xb4(%ebp)
8010187d:	8d 5e ff             	lea    -0x1(%esi),%ebx
                current_command[j] = input.buf[i % INPUT_BUF];
80101880:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
              for(int i=input.w, j=0; i < input.e-1; i++, j++)
80101886:	89 c8                	mov    %ecx,%eax
80101888:	89 8d 48 ff ff ff    	mov    %ecx,-0xb8(%ebp)
                current_command[j] = input.buf[i % INPUT_BUF];
8010188e:	29 ce                	sub    %ecx,%esi
              for(int i=input.w, j=0; i < input.e-1; i++, j++)
80101890:	39 d9                	cmp    %ebx,%ecx
80101892:	73 21                	jae    801018b5 <consoleintr+0x975>
                current_command[j] = input.buf[i % INPUT_BUF];
80101894:	89 c1                	mov    %eax,%ecx
80101896:	c1 f9 1f             	sar    $0x1f,%ecx
80101899:	c1 e9 19             	shr    $0x19,%ecx
8010189c:	8d 14 08             	lea    (%eax,%ecx,1),%edx
8010189f:	83 e2 7f             	and    $0x7f,%edx
801018a2:	29 ca                	sub    %ecx,%edx
801018a4:	0f b6 92 24 22 11 80 	movzbl -0x7feedddc(%edx),%edx
801018ab:	88 14 06             	mov    %dl,(%esi,%eax,1)
              for(int i=input.w, j=0; i < input.e-1; i++, j++)
801018ae:	83 c0 01             	add    $0x1,%eax
801018b1:	39 d8                	cmp    %ebx,%eax
801018b3:	72 df                	jb     80101894 <consoleintr+0x954>
              current_command[(input.e-1-input.w) % INPUT_BUF] = '\0';
801018b5:	89 d8                	mov    %ebx,%eax
801018b7:	2b 85 48 ff ff ff    	sub    -0xb8(%ebp),%eax
801018bd:	83 e0 7f             	and    $0x7f,%eax
801018c0:	c6 84 05 68 ff ff ff 	movb   $0x0,-0x98(%ebp,%eax,1)
801018c7:	00 
  if((command[0]!='\0'))
801018c8:	80 bd 68 ff ff ff 00 	cmpb   $0x0,-0x98(%ebp)
801018cf:	75 25                	jne    801018f6 <consoleintr+0x9b6>
              wakeup(&input.r);
801018d1:	83 ec 0c             	sub    $0xc,%esp
              input.w = input.e;
801018d4:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
              wakeup(&input.r);
801018da:	68 a4 22 11 80       	push   $0x801122a4
              input.w = input.e;
801018df:	a3 a8 22 11 80       	mov    %eax,0x801122a8
              input.position = input.e;
801018e4:	a3 20 22 11 80       	mov    %eax,0x80112220
              wakeup(&input.r);
801018e9:	e8 02 38 00 00       	call   801050f0 <wakeup>
801018ee:	83 c4 10             	add    $0x10,%esp
801018f1:	e9 7a f6 ff ff       	jmp    80100f70 <consoleintr+0x30>
801018f6:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801018fc:	e8 7f ea ff ff       	call   80100380 <add_history.part.0>
              input.w = input.e;
80101901:	a1 ac 22 11 80       	mov    0x801122ac,%eax
80101906:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%ebp)
8010190c:	eb c3                	jmp    801018d1 <consoleintr+0x991>
8010190e:	b8 00 01 00 00       	mov    $0x100,%eax
80101913:	e8 38 ec ff ff       	call   80100550 <consputc.part.0>
            for(int i = 0; i < math_exp_len-1; i++) {
80101918:	83 ee 01             	sub    $0x1,%esi
8010191b:	0f 85 98 fe ff ff    	jne    801017b9 <consoleintr+0x879>
80101921:	89 da                	mov    %ebx,%edx
80101923:	8b 9d 4c ff ff ff    	mov    -0xb4(%ebp),%ebx
            for (int i = 0; i < res_len; i++) {
80101929:	8d 34 1a             	lea    (%edx,%ebx,1),%esi
8010192c:	85 d2                	test   %edx,%edx
8010192e:	0f 8e 3c f6 ff ff    	jle    80100f70 <consoleintr+0x30>
              input.buf[input.position % INPUT_BUF] = res_str[i];
80101934:	8b 15 20 22 11 80    	mov    0x80112220,%edx
8010193a:	0f be 03             	movsbl (%ebx),%eax
              input.e++;
8010193d:	83 05 ac 22 11 80 01 	addl   $0x1,0x801122ac
              input.buf[input.position % INPUT_BUF] = res_str[i];
80101944:	89 d1                	mov    %edx,%ecx
              input.position++;
80101946:	83 c2 01             	add    $0x1,%edx
80101949:	89 15 20 22 11 80    	mov    %edx,0x80112220
  if(panicked){
8010194f:	8b 15 f8 27 11 80    	mov    0x801127f8,%edx
              input.buf[input.position % INPUT_BUF] = res_str[i];
80101955:	83 e1 7f             	and    $0x7f,%ecx
80101958:	88 81 24 22 11 80    	mov    %al,-0x7feedddc(%ecx)
  if(panicked){
8010195e:	85 d2                	test   %edx,%edx
80101960:	74 06                	je     80101968 <consoleintr+0xa28>
80101962:	fa                   	cli    
    for(;;)
80101963:	eb fe                	jmp    80101963 <consoleintr+0xa23>
80101965:	8d 76 00             	lea    0x0(%esi),%esi
80101968:	e8 e3 eb ff ff       	call   80100550 <consputc.part.0>
            for (int i = 0; i < res_len; i++) {
8010196d:	83 c3 01             	add    $0x1,%ebx
80101970:	39 de                	cmp    %ebx,%esi
80101972:	75 c0                	jne    80101934 <consoleintr+0x9f4>
80101974:	e9 f7 f5 ff ff       	jmp    80100f70 <consoleintr+0x30>
80101979:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
              res_len = float_to_str(result, res_str, PRECISION);
80101980:	83 ec 04             	sub    $0x4,%esp
80101983:	8d 9d 5c ff ff ff    	lea    -0xa4(%ebp),%ebx
80101989:	6a 02                	push   $0x2
8010198b:	53                   	push   %ebx
8010198c:	83 ec 04             	sub    $0x4,%esp
8010198f:	d9 1c 24             	fstps  (%esp)
80101992:	e8 29 f3 ff ff       	call   80100cc0 <float_to_str>
80101997:	83 c4 10             	add    $0x10,%esp
8010199a:	89 c2                	mov    %eax,%edx
8010199c:	e9 0b fe ff ff       	jmp    801017ac <consoleintr+0x86c>
801019a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801019a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801019af:	90                   	nop

801019b0 <consoleinit>:

void
consoleinit(void)
{
801019b0:	55                   	push   %ebp
801019b1:	89 e5                	mov    %esp,%ebp
801019b3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801019b6:	68 88 97 10 80       	push   $0x80109788
801019bb:	68 c0 27 11 80       	push   $0x801127c0
801019c0:	e8 8b 43 00 00       	call   80105d50 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801019c5:	58                   	pop    %eax
801019c6:	5a                   	pop    %edx
801019c7:	6a 00                	push   $0x0
801019c9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
801019cb:	c7 05 cc 33 11 80 e0 	movl   $0x801006e0,0x801133cc
801019d2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801019d5:	c7 05 c8 33 11 80 80 	movl   $0x80100280,0x801133c8
801019dc:	02 10 80 
  cons.locking = 1;
801019df:	c7 05 f4 27 11 80 01 	movl   $0x1,0x801127f4
801019e6:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
801019e9:	e8 e2 19 00 00       	call   801033d0 <ioapicenable>
}
801019ee:	83 c4 10             	add    $0x10,%esp
801019f1:	c9                   	leave  
801019f2:	c3                   	ret    
801019f3:	66 90                	xchg   %ax,%ax
801019f5:	66 90                	xchg   %ax,%ax
801019f7:	66 90                	xchg   %ax,%ax
801019f9:	66 90                	xchg   %ax,%ax
801019fb:	66 90                	xchg   %ax,%ax
801019fd:	66 90                	xchg   %ax,%ax
801019ff:	90                   	nop

80101a00 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80101a00:	55                   	push   %ebp
80101a01:	89 e5                	mov    %esp,%ebp
80101a03:	57                   	push   %edi
80101a04:	56                   	push   %esi
80101a05:	53                   	push   %ebx
80101a06:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80101a0c:	e8 3f 2f 00 00       	call   80104950 <myproc>
80101a11:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80101a17:	e8 94 22 00 00       	call   80103cb0 <begin_op>

  if((ip = namei(path)) == 0){
80101a1c:	83 ec 0c             	sub    $0xc,%esp
80101a1f:	ff 75 08             	push   0x8(%ebp)
80101a22:	e8 c9 15 00 00       	call   80102ff0 <namei>
80101a27:	83 c4 10             	add    $0x10,%esp
80101a2a:	85 c0                	test   %eax,%eax
80101a2c:	0f 84 02 03 00 00    	je     80101d34 <exec+0x334>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80101a32:	83 ec 0c             	sub    $0xc,%esp
80101a35:	89 c3                	mov    %eax,%ebx
80101a37:	50                   	push   %eax
80101a38:	e8 93 0c 00 00       	call   801026d0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80101a3d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80101a43:	6a 34                	push   $0x34
80101a45:	6a 00                	push   $0x0
80101a47:	50                   	push   %eax
80101a48:	53                   	push   %ebx
80101a49:	e8 92 0f 00 00       	call   801029e0 <readi>
80101a4e:	83 c4 20             	add    $0x20,%esp
80101a51:	83 f8 34             	cmp    $0x34,%eax
80101a54:	74 22                	je     80101a78 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80101a56:	83 ec 0c             	sub    $0xc,%esp
80101a59:	53                   	push   %ebx
80101a5a:	e8 01 0f 00 00       	call   80102960 <iunlockput>
    end_op();
80101a5f:	e8 bc 22 00 00       	call   80103d20 <end_op>
80101a64:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80101a67:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101a6c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a6f:	5b                   	pop    %ebx
80101a70:	5e                   	pop    %esi
80101a71:	5f                   	pop    %edi
80101a72:	5d                   	pop    %ebp
80101a73:	c3                   	ret    
80101a74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80101a78:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80101a7f:	45 4c 46 
80101a82:	75 d2                	jne    80101a56 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80101a84:	e8 47 79 00 00       	call   801093d0 <setupkvm>
80101a89:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80101a8f:	85 c0                	test   %eax,%eax
80101a91:	74 c3                	je     80101a56 <exec+0x56>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101a93:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80101a9a:	00 
80101a9b:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80101aa1:	0f 84 ac 02 00 00    	je     80101d53 <exec+0x353>
  sz = 0;
80101aa7:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80101aae:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101ab1:	31 ff                	xor    %edi,%edi
80101ab3:	e9 8e 00 00 00       	jmp    80101b46 <exec+0x146>
80101ab8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101abf:	90                   	nop
    if(ph.type != ELF_PROG_LOAD)
80101ac0:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80101ac7:	75 6c                	jne    80101b35 <exec+0x135>
    if(ph.memsz < ph.filesz)
80101ac9:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80101acf:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80101ad5:	0f 82 87 00 00 00    	jb     80101b62 <exec+0x162>
    if(ph.vaddr + ph.memsz < ph.vaddr)
80101adb:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80101ae1:	72 7f                	jb     80101b62 <exec+0x162>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80101ae3:	83 ec 04             	sub    $0x4,%esp
80101ae6:	50                   	push   %eax
80101ae7:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80101aed:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101af3:	e8 f8 76 00 00       	call   801091f0 <allocuvm>
80101af8:	83 c4 10             	add    $0x10,%esp
80101afb:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80101b01:	85 c0                	test   %eax,%eax
80101b03:	74 5d                	je     80101b62 <exec+0x162>
    if(ph.vaddr % PGSIZE != 0)
80101b05:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80101b0b:	a9 ff 0f 00 00       	test   $0xfff,%eax
80101b10:	75 50                	jne    80101b62 <exec+0x162>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80101b12:	83 ec 0c             	sub    $0xc,%esp
80101b15:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
80101b1b:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
80101b21:	53                   	push   %ebx
80101b22:	50                   	push   %eax
80101b23:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101b29:	e8 d2 75 00 00       	call   80109100 <loaduvm>
80101b2e:	83 c4 20             	add    $0x20,%esp
80101b31:	85 c0                	test   %eax,%eax
80101b33:	78 2d                	js     80101b62 <exec+0x162>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101b35:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80101b3c:	83 c7 01             	add    $0x1,%edi
80101b3f:	83 c6 20             	add    $0x20,%esi
80101b42:	39 f8                	cmp    %edi,%eax
80101b44:	7e 3a                	jle    80101b80 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80101b46:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80101b4c:	6a 20                	push   $0x20
80101b4e:	56                   	push   %esi
80101b4f:	50                   	push   %eax
80101b50:	53                   	push   %ebx
80101b51:	e8 8a 0e 00 00       	call   801029e0 <readi>
80101b56:	83 c4 10             	add    $0x10,%esp
80101b59:	83 f8 20             	cmp    $0x20,%eax
80101b5c:	0f 84 5e ff ff ff    	je     80101ac0 <exec+0xc0>
    freevm(pgdir);
80101b62:	83 ec 0c             	sub    $0xc,%esp
80101b65:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101b6b:	e8 e0 77 00 00       	call   80109350 <freevm>
  if(ip){
80101b70:	83 c4 10             	add    $0x10,%esp
80101b73:	e9 de fe ff ff       	jmp    80101a56 <exec+0x56>
80101b78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b7f:	90                   	nop
  sz = PGROUNDUP(sz);
80101b80:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80101b86:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80101b8c:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80101b92:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80101b98:	83 ec 0c             	sub    $0xc,%esp
80101b9b:	53                   	push   %ebx
80101b9c:	e8 bf 0d 00 00       	call   80102960 <iunlockput>
  end_op();
80101ba1:	e8 7a 21 00 00       	call   80103d20 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80101ba6:	83 c4 0c             	add    $0xc,%esp
80101ba9:	56                   	push   %esi
80101baa:	57                   	push   %edi
80101bab:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80101bb1:	57                   	push   %edi
80101bb2:	e8 39 76 00 00       	call   801091f0 <allocuvm>
80101bb7:	83 c4 10             	add    $0x10,%esp
80101bba:	89 c6                	mov    %eax,%esi
80101bbc:	85 c0                	test   %eax,%eax
80101bbe:	0f 84 94 00 00 00    	je     80101c58 <exec+0x258>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101bc4:	83 ec 08             	sub    $0x8,%esp
80101bc7:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
80101bcd:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101bcf:	50                   	push   %eax
80101bd0:	57                   	push   %edi
  for(argc = 0; argv[argc]; argc++) {
80101bd1:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101bd3:	e8 98 78 00 00       	call   80109470 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80101bd8:	8b 45 0c             	mov    0xc(%ebp),%eax
80101bdb:	83 c4 10             	add    $0x10,%esp
80101bde:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80101be4:	8b 00                	mov    (%eax),%eax
80101be6:	85 c0                	test   %eax,%eax
80101be8:	0f 84 8b 00 00 00    	je     80101c79 <exec+0x279>
80101bee:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
80101bf4:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80101bfa:	eb 23                	jmp    80101c1f <exec+0x21f>
80101bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101c00:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80101c03:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80101c0a:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80101c0d:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80101c13:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80101c16:	85 c0                	test   %eax,%eax
80101c18:	74 59                	je     80101c73 <exec+0x273>
    if(argc >= MAXARG)
80101c1a:	83 ff 20             	cmp    $0x20,%edi
80101c1d:	74 39                	je     80101c58 <exec+0x258>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80101c1f:	83 ec 0c             	sub    $0xc,%esp
80101c22:	50                   	push   %eax
80101c23:	e8 e8 46 00 00       	call   80106310 <strlen>
80101c28:	29 c3                	sub    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80101c2a:	58                   	pop    %eax
80101c2b:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80101c2e:	83 eb 01             	sub    $0x1,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80101c31:	ff 34 b8             	push   (%eax,%edi,4)
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80101c34:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80101c37:	e8 d4 46 00 00       	call   80106310 <strlen>
80101c3c:	83 c0 01             	add    $0x1,%eax
80101c3f:	50                   	push   %eax
80101c40:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c43:	ff 34 b8             	push   (%eax,%edi,4)
80101c46:	53                   	push   %ebx
80101c47:	56                   	push   %esi
80101c48:	e8 f3 79 00 00       	call   80109640 <copyout>
80101c4d:	83 c4 20             	add    $0x20,%esp
80101c50:	85 c0                	test   %eax,%eax
80101c52:	79 ac                	jns    80101c00 <exec+0x200>
80101c54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    freevm(pgdir);
80101c58:	83 ec 0c             	sub    $0xc,%esp
80101c5b:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101c61:	e8 ea 76 00 00       	call   80109350 <freevm>
80101c66:	83 c4 10             	add    $0x10,%esp
  return -1;
80101c69:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101c6e:	e9 f9 fd ff ff       	jmp    80101a6c <exec+0x6c>
80101c73:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80101c79:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80101c80:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80101c82:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80101c89:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80101c8d:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80101c8f:	83 c0 0c             	add    $0xc,%eax
  ustack[1] = argc;
80101c92:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  sp -= (3+argc+1) * 4;
80101c98:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80101c9a:	50                   	push   %eax
80101c9b:	52                   	push   %edx
80101c9c:	53                   	push   %ebx
80101c9d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
  ustack[0] = 0xffffffff;  // fake return PC
80101ca3:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80101caa:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80101cad:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80101cb3:	e8 88 79 00 00       	call   80109640 <copyout>
80101cb8:	83 c4 10             	add    $0x10,%esp
80101cbb:	85 c0                	test   %eax,%eax
80101cbd:	78 99                	js     80101c58 <exec+0x258>
  for(last=s=path; *s; s++)
80101cbf:	8b 45 08             	mov    0x8(%ebp),%eax
80101cc2:	8b 55 08             	mov    0x8(%ebp),%edx
80101cc5:	0f b6 00             	movzbl (%eax),%eax
80101cc8:	84 c0                	test   %al,%al
80101cca:	74 13                	je     80101cdf <exec+0x2df>
80101ccc:	89 d1                	mov    %edx,%ecx
80101cce:	66 90                	xchg   %ax,%ax
      last = s+1;
80101cd0:	83 c1 01             	add    $0x1,%ecx
80101cd3:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80101cd5:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
80101cd8:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
80101cdb:	84 c0                	test   %al,%al
80101cdd:	75 f1                	jne    80101cd0 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80101cdf:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80101ce5:	83 ec 04             	sub    $0x4,%esp
80101ce8:	6a 10                	push   $0x10
80101cea:	89 f8                	mov    %edi,%eax
80101cec:	52                   	push   %edx
80101ced:	83 c0 6c             	add    $0x6c,%eax
80101cf0:	50                   	push   %eax
80101cf1:	e8 da 45 00 00       	call   801062d0 <safestrcpy>
  curproc->pgdir = pgdir;
80101cf6:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80101cfc:	89 f8                	mov    %edi,%eax
80101cfe:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->sz = sz;
80101d01:	89 30                	mov    %esi,(%eax)
  curproc->pgdir = pgdir;
80101d03:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80101d06:	89 c1                	mov    %eax,%ecx
80101d08:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80101d0e:	8b 40 18             	mov    0x18(%eax),%eax
80101d11:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80101d14:	8b 41 18             	mov    0x18(%ecx),%eax
80101d17:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80101d1a:	89 0c 24             	mov    %ecx,(%esp)
80101d1d:	e8 4e 72 00 00       	call   80108f70 <switchuvm>
  freevm(oldpgdir);
80101d22:	89 3c 24             	mov    %edi,(%esp)
80101d25:	e8 26 76 00 00       	call   80109350 <freevm>
  return 0;
80101d2a:	83 c4 10             	add    $0x10,%esp
80101d2d:	31 c0                	xor    %eax,%eax
80101d2f:	e9 38 fd ff ff       	jmp    80101a6c <exec+0x6c>
    end_op();
80101d34:	e8 e7 1f 00 00       	call   80103d20 <end_op>
    cprintf("exec: fail\n");
80101d39:	83 ec 0c             	sub    $0xc,%esp
80101d3c:	68 ec 97 10 80       	push   $0x801097ec
80101d41:	e8 aa ea ff ff       	call   801007f0 <cprintf>
    return -1;
80101d46:	83 c4 10             	add    $0x10,%esp
80101d49:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101d4e:	e9 19 fd ff ff       	jmp    80101a6c <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101d53:	be 00 20 00 00       	mov    $0x2000,%esi
80101d58:	31 ff                	xor    %edi,%edi
80101d5a:	e9 39 fe ff ff       	jmp    80101b98 <exec+0x198>
80101d5f:	90                   	nop

80101d60 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80101d60:	55                   	push   %ebp
80101d61:	89 e5                	mov    %esp,%ebp
80101d63:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80101d66:	68 f8 97 10 80       	push   $0x801097f8
80101d6b:	68 20 2a 11 80       	push   $0x80112a20
80101d70:	e8 db 3f 00 00       	call   80105d50 <initlock>
}
80101d75:	83 c4 10             	add    $0x10,%esp
80101d78:	c9                   	leave  
80101d79:	c3                   	ret    
80101d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101d80 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80101d80:	55                   	push   %ebp
80101d81:	89 e5                	mov    %esp,%ebp
80101d83:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101d84:	bb 54 2a 11 80       	mov    $0x80112a54,%ebx
{
80101d89:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80101d8c:	68 20 2a 11 80       	push   $0x80112a20
80101d91:	e8 8a 41 00 00       	call   80105f20 <acquire>
80101d96:	83 c4 10             	add    $0x10,%esp
80101d99:	eb 10                	jmp    80101dab <filealloc+0x2b>
80101d9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101d9f:	90                   	nop
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101da0:	83 c3 18             	add    $0x18,%ebx
80101da3:	81 fb b4 33 11 80    	cmp    $0x801133b4,%ebx
80101da9:	74 25                	je     80101dd0 <filealloc+0x50>
    if(f->ref == 0){
80101dab:	8b 43 04             	mov    0x4(%ebx),%eax
80101dae:	85 c0                	test   %eax,%eax
80101db0:	75 ee                	jne    80101da0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80101db2:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80101db5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80101dbc:	68 20 2a 11 80       	push   $0x80112a20
80101dc1:	e8 fa 40 00 00       	call   80105ec0 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80101dc6:	89 d8                	mov    %ebx,%eax
      return f;
80101dc8:	83 c4 10             	add    $0x10,%esp
}
80101dcb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101dce:	c9                   	leave  
80101dcf:	c3                   	ret    
  release(&ftable.lock);
80101dd0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80101dd3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80101dd5:	68 20 2a 11 80       	push   $0x80112a20
80101dda:	e8 e1 40 00 00       	call   80105ec0 <release>
}
80101ddf:	89 d8                	mov    %ebx,%eax
  return 0;
80101de1:	83 c4 10             	add    $0x10,%esp
}
80101de4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101de7:	c9                   	leave  
80101de8:	c3                   	ret    
80101de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101df0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80101df0:	55                   	push   %ebp
80101df1:	89 e5                	mov    %esp,%ebp
80101df3:	53                   	push   %ebx
80101df4:	83 ec 10             	sub    $0x10,%esp
80101df7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80101dfa:	68 20 2a 11 80       	push   $0x80112a20
80101dff:	e8 1c 41 00 00       	call   80105f20 <acquire>
  if(f->ref < 1)
80101e04:	8b 43 04             	mov    0x4(%ebx),%eax
80101e07:	83 c4 10             	add    $0x10,%esp
80101e0a:	85 c0                	test   %eax,%eax
80101e0c:	7e 1a                	jle    80101e28 <filedup+0x38>
    panic("filedup");
  f->ref++;
80101e0e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80101e11:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80101e14:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80101e17:	68 20 2a 11 80       	push   $0x80112a20
80101e1c:	e8 9f 40 00 00       	call   80105ec0 <release>
  return f;
}
80101e21:	89 d8                	mov    %ebx,%eax
80101e23:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101e26:	c9                   	leave  
80101e27:	c3                   	ret    
    panic("filedup");
80101e28:	83 ec 0c             	sub    $0xc,%esp
80101e2b:	68 ff 97 10 80       	push   $0x801097ff
80101e30:	e8 9b e6 ff ff       	call   801004d0 <panic>
80101e35:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101e40 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101e40:	55                   	push   %ebp
80101e41:	89 e5                	mov    %esp,%ebp
80101e43:	57                   	push   %edi
80101e44:	56                   	push   %esi
80101e45:	53                   	push   %ebx
80101e46:	83 ec 28             	sub    $0x28,%esp
80101e49:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80101e4c:	68 20 2a 11 80       	push   $0x80112a20
80101e51:	e8 ca 40 00 00       	call   80105f20 <acquire>
  if(f->ref < 1)
80101e56:	8b 53 04             	mov    0x4(%ebx),%edx
80101e59:	83 c4 10             	add    $0x10,%esp
80101e5c:	85 d2                	test   %edx,%edx
80101e5e:	0f 8e a5 00 00 00    	jle    80101f09 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80101e64:	83 ea 01             	sub    $0x1,%edx
80101e67:	89 53 04             	mov    %edx,0x4(%ebx)
80101e6a:	75 44                	jne    80101eb0 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80101e6c:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80101e70:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80101e73:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80101e75:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80101e7b:	8b 73 0c             	mov    0xc(%ebx),%esi
80101e7e:	88 45 e7             	mov    %al,-0x19(%ebp)
80101e81:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80101e84:	68 20 2a 11 80       	push   $0x80112a20
  ff = *f;
80101e89:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80101e8c:	e8 2f 40 00 00       	call   80105ec0 <release>

  if(ff.type == FD_PIPE)
80101e91:	83 c4 10             	add    $0x10,%esp
80101e94:	83 ff 01             	cmp    $0x1,%edi
80101e97:	74 57                	je     80101ef0 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80101e99:	83 ff 02             	cmp    $0x2,%edi
80101e9c:	74 2a                	je     80101ec8 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80101e9e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ea1:	5b                   	pop    %ebx
80101ea2:	5e                   	pop    %esi
80101ea3:	5f                   	pop    %edi
80101ea4:	5d                   	pop    %ebp
80101ea5:	c3                   	ret    
80101ea6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ead:	8d 76 00             	lea    0x0(%esi),%esi
    release(&ftable.lock);
80101eb0:	c7 45 08 20 2a 11 80 	movl   $0x80112a20,0x8(%ebp)
}
80101eb7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101eba:	5b                   	pop    %ebx
80101ebb:	5e                   	pop    %esi
80101ebc:	5f                   	pop    %edi
80101ebd:	5d                   	pop    %ebp
    release(&ftable.lock);
80101ebe:	e9 fd 3f 00 00       	jmp    80105ec0 <release>
80101ec3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ec7:	90                   	nop
    begin_op();
80101ec8:	e8 e3 1d 00 00       	call   80103cb0 <begin_op>
    iput(ff.ip);
80101ecd:	83 ec 0c             	sub    $0xc,%esp
80101ed0:	ff 75 e0             	push   -0x20(%ebp)
80101ed3:	e8 28 09 00 00       	call   80102800 <iput>
    end_op();
80101ed8:	83 c4 10             	add    $0x10,%esp
}
80101edb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ede:	5b                   	pop    %ebx
80101edf:	5e                   	pop    %esi
80101ee0:	5f                   	pop    %edi
80101ee1:	5d                   	pop    %ebp
    end_op();
80101ee2:	e9 39 1e 00 00       	jmp    80103d20 <end_op>
80101ee7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101eee:	66 90                	xchg   %ax,%ax
    pipeclose(ff.pipe, ff.writable);
80101ef0:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80101ef4:	83 ec 08             	sub    $0x8,%esp
80101ef7:	53                   	push   %ebx
80101ef8:	56                   	push   %esi
80101ef9:	e8 a2 25 00 00       	call   801044a0 <pipeclose>
80101efe:	83 c4 10             	add    $0x10,%esp
}
80101f01:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f04:	5b                   	pop    %ebx
80101f05:	5e                   	pop    %esi
80101f06:	5f                   	pop    %edi
80101f07:	5d                   	pop    %ebp
80101f08:	c3                   	ret    
    panic("fileclose");
80101f09:	83 ec 0c             	sub    $0xc,%esp
80101f0c:	68 07 98 10 80       	push   $0x80109807
80101f11:	e8 ba e5 ff ff       	call   801004d0 <panic>
80101f16:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f1d:	8d 76 00             	lea    0x0(%esi),%esi

80101f20 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101f20:	55                   	push   %ebp
80101f21:	89 e5                	mov    %esp,%ebp
80101f23:	53                   	push   %ebx
80101f24:	83 ec 04             	sub    $0x4,%esp
80101f27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80101f2a:	83 3b 02             	cmpl   $0x2,(%ebx)
80101f2d:	75 31                	jne    80101f60 <filestat+0x40>
    ilock(f->ip);
80101f2f:	83 ec 0c             	sub    $0xc,%esp
80101f32:	ff 73 10             	push   0x10(%ebx)
80101f35:	e8 96 07 00 00       	call   801026d0 <ilock>
    stati(f->ip, st);
80101f3a:	58                   	pop    %eax
80101f3b:	5a                   	pop    %edx
80101f3c:	ff 75 0c             	push   0xc(%ebp)
80101f3f:	ff 73 10             	push   0x10(%ebx)
80101f42:	e8 69 0a 00 00       	call   801029b0 <stati>
    iunlock(f->ip);
80101f47:	59                   	pop    %ecx
80101f48:	ff 73 10             	push   0x10(%ebx)
80101f4b:	e8 60 08 00 00       	call   801027b0 <iunlock>
    return 0;
  }
  return -1;
}
80101f50:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80101f53:	83 c4 10             	add    $0x10,%esp
80101f56:	31 c0                	xor    %eax,%eax
}
80101f58:	c9                   	leave  
80101f59:	c3                   	ret    
80101f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101f60:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80101f63:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101f68:	c9                   	leave  
80101f69:	c3                   	ret    
80101f6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101f70 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101f70:	55                   	push   %ebp
80101f71:	89 e5                	mov    %esp,%ebp
80101f73:	57                   	push   %edi
80101f74:	56                   	push   %esi
80101f75:	53                   	push   %ebx
80101f76:	83 ec 0c             	sub    $0xc,%esp
80101f79:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101f7c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101f7f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101f82:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101f86:	74 60                	je     80101fe8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101f88:	8b 03                	mov    (%ebx),%eax
80101f8a:	83 f8 01             	cmp    $0x1,%eax
80101f8d:	74 41                	je     80101fd0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80101f8f:	83 f8 02             	cmp    $0x2,%eax
80101f92:	75 5b                	jne    80101fef <fileread+0x7f>
    ilock(f->ip);
80101f94:	83 ec 0c             	sub    $0xc,%esp
80101f97:	ff 73 10             	push   0x10(%ebx)
80101f9a:	e8 31 07 00 00       	call   801026d0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80101f9f:	57                   	push   %edi
80101fa0:	ff 73 14             	push   0x14(%ebx)
80101fa3:	56                   	push   %esi
80101fa4:	ff 73 10             	push   0x10(%ebx)
80101fa7:	e8 34 0a 00 00       	call   801029e0 <readi>
80101fac:	83 c4 20             	add    $0x20,%esp
80101faf:	89 c6                	mov    %eax,%esi
80101fb1:	85 c0                	test   %eax,%eax
80101fb3:	7e 03                	jle    80101fb8 <fileread+0x48>
      f->off += r;
80101fb5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101fb8:	83 ec 0c             	sub    $0xc,%esp
80101fbb:	ff 73 10             	push   0x10(%ebx)
80101fbe:	e8 ed 07 00 00       	call   801027b0 <iunlock>
    return r;
80101fc3:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101fc6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fc9:	89 f0                	mov    %esi,%eax
80101fcb:	5b                   	pop    %ebx
80101fcc:	5e                   	pop    %esi
80101fcd:	5f                   	pop    %edi
80101fce:	5d                   	pop    %ebp
80101fcf:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80101fd0:	8b 43 0c             	mov    0xc(%ebx),%eax
80101fd3:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101fd6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fd9:	5b                   	pop    %ebx
80101fda:	5e                   	pop    %esi
80101fdb:	5f                   	pop    %edi
80101fdc:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80101fdd:	e9 5e 26 00 00       	jmp    80104640 <piperead>
80101fe2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101fe8:	be ff ff ff ff       	mov    $0xffffffff,%esi
80101fed:	eb d7                	jmp    80101fc6 <fileread+0x56>
  panic("fileread");
80101fef:	83 ec 0c             	sub    $0xc,%esp
80101ff2:	68 11 98 10 80       	push   $0x80109811
80101ff7:	e8 d4 e4 ff ff       	call   801004d0 <panic>
80101ffc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102000 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80102000:	55                   	push   %ebp
80102001:	89 e5                	mov    %esp,%ebp
80102003:	57                   	push   %edi
80102004:	56                   	push   %esi
80102005:	53                   	push   %ebx
80102006:	83 ec 1c             	sub    $0x1c,%esp
80102009:	8b 45 0c             	mov    0xc(%ebp),%eax
8010200c:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010200f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102012:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80102015:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
{
80102019:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010201c:	0f 84 bd 00 00 00    	je     801020df <filewrite+0xdf>
    return -1;
  if(f->type == FD_PIPE)
80102022:	8b 03                	mov    (%ebx),%eax
80102024:	83 f8 01             	cmp    $0x1,%eax
80102027:	0f 84 bf 00 00 00    	je     801020ec <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010202d:	83 f8 02             	cmp    $0x2,%eax
80102030:	0f 85 c8 00 00 00    	jne    801020fe <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80102036:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80102039:	31 f6                	xor    %esi,%esi
    while(i < n){
8010203b:	85 c0                	test   %eax,%eax
8010203d:	7f 30                	jg     8010206f <filewrite+0x6f>
8010203f:	e9 94 00 00 00       	jmp    801020d8 <filewrite+0xd8>
80102044:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80102048:	01 43 14             	add    %eax,0x14(%ebx)
      iunlock(f->ip);
8010204b:	83 ec 0c             	sub    $0xc,%esp
8010204e:	ff 73 10             	push   0x10(%ebx)
        f->off += r;
80102051:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80102054:	e8 57 07 00 00       	call   801027b0 <iunlock>
      end_op();
80102059:	e8 c2 1c 00 00       	call   80103d20 <end_op>

      if(r < 0)
        break;
      if(r != n1)
8010205e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80102061:	83 c4 10             	add    $0x10,%esp
80102064:	39 c7                	cmp    %eax,%edi
80102066:	75 5c                	jne    801020c4 <filewrite+0xc4>
        panic("short filewrite");
      i += r;
80102068:	01 fe                	add    %edi,%esi
    while(i < n){
8010206a:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
8010206d:	7e 69                	jle    801020d8 <filewrite+0xd8>
      int n1 = n - i;
8010206f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80102072:	b8 00 06 00 00       	mov    $0x600,%eax
80102077:	29 f7                	sub    %esi,%edi
80102079:	39 c7                	cmp    %eax,%edi
8010207b:	0f 4f f8             	cmovg  %eax,%edi
      begin_op();
8010207e:	e8 2d 1c 00 00       	call   80103cb0 <begin_op>
      ilock(f->ip);
80102083:	83 ec 0c             	sub    $0xc,%esp
80102086:	ff 73 10             	push   0x10(%ebx)
80102089:	e8 42 06 00 00       	call   801026d0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
8010208e:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102091:	57                   	push   %edi
80102092:	ff 73 14             	push   0x14(%ebx)
80102095:	01 f0                	add    %esi,%eax
80102097:	50                   	push   %eax
80102098:	ff 73 10             	push   0x10(%ebx)
8010209b:	e8 40 0a 00 00       	call   80102ae0 <writei>
801020a0:	83 c4 20             	add    $0x20,%esp
801020a3:	85 c0                	test   %eax,%eax
801020a5:	7f a1                	jg     80102048 <filewrite+0x48>
      iunlock(f->ip);
801020a7:	83 ec 0c             	sub    $0xc,%esp
801020aa:	ff 73 10             	push   0x10(%ebx)
801020ad:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801020b0:	e8 fb 06 00 00       	call   801027b0 <iunlock>
      end_op();
801020b5:	e8 66 1c 00 00       	call   80103d20 <end_op>
      if(r < 0)
801020ba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801020bd:	83 c4 10             	add    $0x10,%esp
801020c0:	85 c0                	test   %eax,%eax
801020c2:	75 1b                	jne    801020df <filewrite+0xdf>
        panic("short filewrite");
801020c4:	83 ec 0c             	sub    $0xc,%esp
801020c7:	68 1a 98 10 80       	push   $0x8010981a
801020cc:	e8 ff e3 ff ff       	call   801004d0 <panic>
801020d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
    return i == n ? n : -1;
801020d8:	89 f0                	mov    %esi,%eax
801020da:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
801020dd:	74 05                	je     801020e4 <filewrite+0xe4>
801020df:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
801020e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020e7:	5b                   	pop    %ebx
801020e8:	5e                   	pop    %esi
801020e9:	5f                   	pop    %edi
801020ea:	5d                   	pop    %ebp
801020eb:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
801020ec:	8b 43 0c             	mov    0xc(%ebx),%eax
801020ef:	89 45 08             	mov    %eax,0x8(%ebp)
}
801020f2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020f5:	5b                   	pop    %ebx
801020f6:	5e                   	pop    %esi
801020f7:	5f                   	pop    %edi
801020f8:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801020f9:	e9 42 24 00 00       	jmp    80104540 <pipewrite>
  panic("filewrite");
801020fe:	83 ec 0c             	sub    $0xc,%esp
80102101:	68 20 98 10 80       	push   $0x80109820
80102106:	e8 c5 e3 ff ff       	call   801004d0 <panic>
8010210b:	66 90                	xchg   %ax,%ax
8010210d:	66 90                	xchg   %ax,%ax
8010210f:	90                   	nop

80102110 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80102110:	55                   	push   %ebp
80102111:	89 c1                	mov    %eax,%ecx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
80102113:	89 d0                	mov    %edx,%eax
80102115:	c1 e8 0c             	shr    $0xc,%eax
80102118:	03 05 8c 50 11 80    	add    0x8011508c,%eax
{
8010211e:	89 e5                	mov    %esp,%ebp
80102120:	56                   	push   %esi
80102121:	53                   	push   %ebx
80102122:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
80102124:	83 ec 08             	sub    $0x8,%esp
80102127:	50                   	push   %eax
80102128:	51                   	push   %ecx
80102129:	e8 a2 df ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
8010212e:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
80102130:	c1 fb 03             	sar    $0x3,%ebx
80102133:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
80102136:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
80102138:	83 e1 07             	and    $0x7,%ecx
8010213b:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
80102140:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  m = 1 << (bi % 8);
80102146:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
80102148:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
8010214d:	85 c1                	test   %eax,%ecx
8010214f:	74 23                	je     80102174 <bfree+0x64>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80102151:	f7 d0                	not    %eax
  log_write(bp);
80102153:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80102156:	21 c8                	and    %ecx,%eax
80102158:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
8010215c:	56                   	push   %esi
8010215d:	e8 2e 1d 00 00       	call   80103e90 <log_write>
  brelse(bp);
80102162:	89 34 24             	mov    %esi,(%esp)
80102165:	e8 86 e0 ff ff       	call   801001f0 <brelse>
}
8010216a:	83 c4 10             	add    $0x10,%esp
8010216d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102170:	5b                   	pop    %ebx
80102171:	5e                   	pop    %esi
80102172:	5d                   	pop    %ebp
80102173:	c3                   	ret    
    panic("freeing free block");
80102174:	83 ec 0c             	sub    $0xc,%esp
80102177:	68 2a 98 10 80       	push   $0x8010982a
8010217c:	e8 4f e3 ff ff       	call   801004d0 <panic>
80102181:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102188:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010218f:	90                   	nop

80102190 <balloc>:
{
80102190:	55                   	push   %ebp
80102191:	89 e5                	mov    %esp,%ebp
80102193:	57                   	push   %edi
80102194:	56                   	push   %esi
80102195:	53                   	push   %ebx
80102196:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
80102199:	8b 0d 74 50 11 80    	mov    0x80115074,%ecx
{
8010219f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801021a2:	85 c9                	test   %ecx,%ecx
801021a4:	0f 84 87 00 00 00    	je     80102231 <balloc+0xa1>
801021aa:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
801021b1:	8b 75 dc             	mov    -0x24(%ebp),%esi
801021b4:	83 ec 08             	sub    $0x8,%esp
801021b7:	89 f0                	mov    %esi,%eax
801021b9:	c1 f8 0c             	sar    $0xc,%eax
801021bc:	03 05 8c 50 11 80    	add    0x8011508c,%eax
801021c2:	50                   	push   %eax
801021c3:	ff 75 d8             	push   -0x28(%ebp)
801021c6:	e8 05 df ff ff       	call   801000d0 <bread>
801021cb:	83 c4 10             	add    $0x10,%esp
801021ce:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801021d1:	a1 74 50 11 80       	mov    0x80115074,%eax
801021d6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801021d9:	31 c0                	xor    %eax,%eax
801021db:	eb 2f                	jmp    8010220c <balloc+0x7c>
801021dd:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
801021e0:	89 c1                	mov    %eax,%ecx
801021e2:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801021e7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
801021ea:	83 e1 07             	and    $0x7,%ecx
801021ed:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801021ef:	89 c1                	mov    %eax,%ecx
801021f1:	c1 f9 03             	sar    $0x3,%ecx
801021f4:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
801021f9:	89 fa                	mov    %edi,%edx
801021fb:	85 df                	test   %ebx,%edi
801021fd:	74 41                	je     80102240 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801021ff:	83 c0 01             	add    $0x1,%eax
80102202:	83 c6 01             	add    $0x1,%esi
80102205:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010220a:	74 05                	je     80102211 <balloc+0x81>
8010220c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010220f:	77 cf                	ja     801021e0 <balloc+0x50>
    brelse(bp);
80102211:	83 ec 0c             	sub    $0xc,%esp
80102214:	ff 75 e4             	push   -0x1c(%ebp)
80102217:	e8 d4 df ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010221c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80102223:	83 c4 10             	add    $0x10,%esp
80102226:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102229:	39 05 74 50 11 80    	cmp    %eax,0x80115074
8010222f:	77 80                	ja     801021b1 <balloc+0x21>
  panic("balloc: out of blocks");
80102231:	83 ec 0c             	sub    $0xc,%esp
80102234:	68 3d 98 10 80       	push   $0x8010983d
80102239:	e8 92 e2 ff ff       	call   801004d0 <panic>
8010223e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80102240:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80102243:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80102246:	09 da                	or     %ebx,%edx
80102248:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010224c:	57                   	push   %edi
8010224d:	e8 3e 1c 00 00       	call   80103e90 <log_write>
        brelse(bp);
80102252:	89 3c 24             	mov    %edi,(%esp)
80102255:	e8 96 df ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
8010225a:	58                   	pop    %eax
8010225b:	5a                   	pop    %edx
8010225c:	56                   	push   %esi
8010225d:	ff 75 d8             	push   -0x28(%ebp)
80102260:	e8 6b de ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
80102265:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
80102268:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
8010226a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010226d:	68 00 02 00 00       	push   $0x200
80102272:	6a 00                	push   $0x0
80102274:	50                   	push   %eax
80102275:	e8 96 3e 00 00       	call   80106110 <memset>
  log_write(bp);
8010227a:	89 1c 24             	mov    %ebx,(%esp)
8010227d:	e8 0e 1c 00 00       	call   80103e90 <log_write>
  brelse(bp);
80102282:	89 1c 24             	mov    %ebx,(%esp)
80102285:	e8 66 df ff ff       	call   801001f0 <brelse>
}
8010228a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010228d:	89 f0                	mov    %esi,%eax
8010228f:	5b                   	pop    %ebx
80102290:	5e                   	pop    %esi
80102291:	5f                   	pop    %edi
80102292:	5d                   	pop    %ebp
80102293:	c3                   	ret    
80102294:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010229b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010229f:	90                   	nop

801022a0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801022a0:	55                   	push   %ebp
801022a1:	89 e5                	mov    %esp,%ebp
801022a3:	57                   	push   %edi
801022a4:	89 c7                	mov    %eax,%edi
801022a6:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801022a7:	31 f6                	xor    %esi,%esi
{
801022a9:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801022aa:	bb 54 34 11 80       	mov    $0x80113454,%ebx
{
801022af:	83 ec 28             	sub    $0x28,%esp
801022b2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
801022b5:	68 20 34 11 80       	push   $0x80113420
801022ba:	e8 61 3c 00 00       	call   80105f20 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801022bf:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
801022c2:	83 c4 10             	add    $0x10,%esp
801022c5:	eb 1b                	jmp    801022e2 <iget+0x42>
801022c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801022ce:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801022d0:	39 3b                	cmp    %edi,(%ebx)
801022d2:	74 6c                	je     80102340 <iget+0xa0>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801022d4:	81 c3 90 00 00 00    	add    $0x90,%ebx
801022da:	81 fb 74 50 11 80    	cmp    $0x80115074,%ebx
801022e0:	73 26                	jae    80102308 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801022e2:	8b 43 08             	mov    0x8(%ebx),%eax
801022e5:	85 c0                	test   %eax,%eax
801022e7:	7f e7                	jg     801022d0 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801022e9:	85 f6                	test   %esi,%esi
801022eb:	75 e7                	jne    801022d4 <iget+0x34>
801022ed:	85 c0                	test   %eax,%eax
801022ef:	75 76                	jne    80102367 <iget+0xc7>
801022f1:	89 de                	mov    %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801022f3:	81 c3 90 00 00 00    	add    $0x90,%ebx
801022f9:	81 fb 74 50 11 80    	cmp    $0x80115074,%ebx
801022ff:	72 e1                	jb     801022e2 <iget+0x42>
80102301:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80102308:	85 f6                	test   %esi,%esi
8010230a:	74 79                	je     80102385 <iget+0xe5>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
8010230c:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
8010230f:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80102311:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
80102314:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
8010231b:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
80102322:	68 20 34 11 80       	push   $0x80113420
80102327:	e8 94 3b 00 00       	call   80105ec0 <release>

  return ip;
8010232c:	83 c4 10             	add    $0x10,%esp
}
8010232f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102332:	89 f0                	mov    %esi,%eax
80102334:	5b                   	pop    %ebx
80102335:	5e                   	pop    %esi
80102336:	5f                   	pop    %edi
80102337:	5d                   	pop    %ebp
80102338:	c3                   	ret    
80102339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80102340:	39 53 04             	cmp    %edx,0x4(%ebx)
80102343:	75 8f                	jne    801022d4 <iget+0x34>
      release(&icache.lock);
80102345:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80102348:	83 c0 01             	add    $0x1,%eax
      return ip;
8010234b:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
8010234d:	68 20 34 11 80       	push   $0x80113420
      ip->ref++;
80102352:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
80102355:	e8 66 3b 00 00       	call   80105ec0 <release>
      return ip;
8010235a:	83 c4 10             	add    $0x10,%esp
}
8010235d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102360:	89 f0                	mov    %esi,%eax
80102362:	5b                   	pop    %ebx
80102363:	5e                   	pop    %esi
80102364:	5f                   	pop    %edi
80102365:	5d                   	pop    %ebp
80102366:	c3                   	ret    
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80102367:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010236d:	81 fb 74 50 11 80    	cmp    $0x80115074,%ebx
80102373:	73 10                	jae    80102385 <iget+0xe5>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80102375:	8b 43 08             	mov    0x8(%ebx),%eax
80102378:	85 c0                	test   %eax,%eax
8010237a:	0f 8f 50 ff ff ff    	jg     801022d0 <iget+0x30>
80102380:	e9 68 ff ff ff       	jmp    801022ed <iget+0x4d>
    panic("iget: no inodes");
80102385:	83 ec 0c             	sub    $0xc,%esp
80102388:	68 53 98 10 80       	push   $0x80109853
8010238d:	e8 3e e1 ff ff       	call   801004d0 <panic>
80102392:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801023a0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801023a0:	55                   	push   %ebp
801023a1:	89 e5                	mov    %esp,%ebp
801023a3:	57                   	push   %edi
801023a4:	56                   	push   %esi
801023a5:	89 c6                	mov    %eax,%esi
801023a7:	53                   	push   %ebx
801023a8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801023ab:	83 fa 0b             	cmp    $0xb,%edx
801023ae:	0f 86 8c 00 00 00    	jbe    80102440 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
801023b4:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
801023b7:	83 fb 7f             	cmp    $0x7f,%ebx
801023ba:	0f 87 a2 00 00 00    	ja     80102462 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801023c0:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
801023c6:	85 c0                	test   %eax,%eax
801023c8:	74 5e                	je     80102428 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801023ca:	83 ec 08             	sub    $0x8,%esp
801023cd:	50                   	push   %eax
801023ce:	ff 36                	push   (%esi)
801023d0:	e8 fb dc ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801023d5:	83 c4 10             	add    $0x10,%esp
801023d8:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
801023dc:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
801023de:	8b 3b                	mov    (%ebx),%edi
801023e0:	85 ff                	test   %edi,%edi
801023e2:	74 1c                	je     80102400 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
801023e4:	83 ec 0c             	sub    $0xc,%esp
801023e7:	52                   	push   %edx
801023e8:	e8 03 de ff ff       	call   801001f0 <brelse>
801023ed:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
801023f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801023f3:	89 f8                	mov    %edi,%eax
801023f5:	5b                   	pop    %ebx
801023f6:	5e                   	pop    %esi
801023f7:	5f                   	pop    %edi
801023f8:	5d                   	pop    %ebp
801023f9:	c3                   	ret    
801023fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102400:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
80102403:	8b 06                	mov    (%esi),%eax
80102405:	e8 86 fd ff ff       	call   80102190 <balloc>
      log_write(bp);
8010240a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010240d:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80102410:	89 03                	mov    %eax,(%ebx)
80102412:	89 c7                	mov    %eax,%edi
      log_write(bp);
80102414:	52                   	push   %edx
80102415:	e8 76 1a 00 00       	call   80103e90 <log_write>
8010241a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010241d:	83 c4 10             	add    $0x10,%esp
80102420:	eb c2                	jmp    801023e4 <bmap+0x44>
80102422:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80102428:	8b 06                	mov    (%esi),%eax
8010242a:	e8 61 fd ff ff       	call   80102190 <balloc>
8010242f:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80102435:	eb 93                	jmp    801023ca <bmap+0x2a>
80102437:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010243e:	66 90                	xchg   %ax,%ax
    if((addr = ip->addrs[bn]) == 0)
80102440:	8d 5a 14             	lea    0x14(%edx),%ebx
80102443:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
80102447:	85 ff                	test   %edi,%edi
80102449:	75 a5                	jne    801023f0 <bmap+0x50>
      ip->addrs[bn] = addr = balloc(ip->dev);
8010244b:	8b 00                	mov    (%eax),%eax
8010244d:	e8 3e fd ff ff       	call   80102190 <balloc>
80102452:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
80102456:	89 c7                	mov    %eax,%edi
}
80102458:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010245b:	5b                   	pop    %ebx
8010245c:	89 f8                	mov    %edi,%eax
8010245e:	5e                   	pop    %esi
8010245f:	5f                   	pop    %edi
80102460:	5d                   	pop    %ebp
80102461:	c3                   	ret    
  panic("bmap: out of range");
80102462:	83 ec 0c             	sub    $0xc,%esp
80102465:	68 63 98 10 80       	push   $0x80109863
8010246a:	e8 61 e0 ff ff       	call   801004d0 <panic>
8010246f:	90                   	nop

80102470 <readsb>:
{
80102470:	55                   	push   %ebp
80102471:	89 e5                	mov    %esp,%ebp
80102473:	56                   	push   %esi
80102474:	53                   	push   %ebx
80102475:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80102478:	83 ec 08             	sub    $0x8,%esp
8010247b:	6a 01                	push   $0x1
8010247d:	ff 75 08             	push   0x8(%ebp)
80102480:	e8 4b dc ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80102485:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80102488:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010248a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010248d:	6a 1c                	push   $0x1c
8010248f:	50                   	push   %eax
80102490:	56                   	push   %esi
80102491:	e8 1a 3d 00 00       	call   801061b0 <memmove>
  brelse(bp);
80102496:	89 5d 08             	mov    %ebx,0x8(%ebp)
80102499:	83 c4 10             	add    $0x10,%esp
}
8010249c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010249f:	5b                   	pop    %ebx
801024a0:	5e                   	pop    %esi
801024a1:	5d                   	pop    %ebp
  brelse(bp);
801024a2:	e9 49 dd ff ff       	jmp    801001f0 <brelse>
801024a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801024ae:	66 90                	xchg   %ax,%ax

801024b0 <iinit>:
{
801024b0:	55                   	push   %ebp
801024b1:	89 e5                	mov    %esp,%ebp
801024b3:	53                   	push   %ebx
801024b4:	bb 60 34 11 80       	mov    $0x80113460,%ebx
801024b9:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
801024bc:	68 76 98 10 80       	push   $0x80109876
801024c1:	68 20 34 11 80       	push   $0x80113420
801024c6:	e8 85 38 00 00       	call   80105d50 <initlock>
  for(i = 0; i < NINODE; i++) {
801024cb:	83 c4 10             	add    $0x10,%esp
801024ce:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801024d0:	83 ec 08             	sub    $0x8,%esp
801024d3:	68 7d 98 10 80       	push   $0x8010987d
801024d8:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
801024d9:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
801024df:	e8 3c 37 00 00       	call   80105c20 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801024e4:	83 c4 10             	add    $0x10,%esp
801024e7:	81 fb 80 50 11 80    	cmp    $0x80115080,%ebx
801024ed:	75 e1                	jne    801024d0 <iinit+0x20>
  bp = bread(dev, 1);
801024ef:	83 ec 08             	sub    $0x8,%esp
801024f2:	6a 01                	push   $0x1
801024f4:	ff 75 08             	push   0x8(%ebp)
801024f7:	e8 d4 db ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801024fc:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
801024ff:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80102501:	8d 40 5c             	lea    0x5c(%eax),%eax
80102504:	6a 1c                	push   $0x1c
80102506:	50                   	push   %eax
80102507:	68 74 50 11 80       	push   $0x80115074
8010250c:	e8 9f 3c 00 00       	call   801061b0 <memmove>
  brelse(bp);
80102511:	89 1c 24             	mov    %ebx,(%esp)
80102514:	e8 d7 dc ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80102519:	ff 35 8c 50 11 80    	push   0x8011508c
8010251f:	ff 35 88 50 11 80    	push   0x80115088
80102525:	ff 35 84 50 11 80    	push   0x80115084
8010252b:	ff 35 80 50 11 80    	push   0x80115080
80102531:	ff 35 7c 50 11 80    	push   0x8011507c
80102537:	ff 35 78 50 11 80    	push   0x80115078
8010253d:	ff 35 74 50 11 80    	push   0x80115074
80102543:	68 e0 98 10 80       	push   $0x801098e0
80102548:	e8 a3 e2 ff ff       	call   801007f0 <cprintf>
}
8010254d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102550:	83 c4 30             	add    $0x30,%esp
80102553:	c9                   	leave  
80102554:	c3                   	ret    
80102555:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010255c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102560 <ialloc>:
{
80102560:	55                   	push   %ebp
80102561:	89 e5                	mov    %esp,%ebp
80102563:	57                   	push   %edi
80102564:	56                   	push   %esi
80102565:	53                   	push   %ebx
80102566:	83 ec 1c             	sub    $0x1c,%esp
80102569:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
8010256c:	83 3d 7c 50 11 80 01 	cmpl   $0x1,0x8011507c
{
80102573:	8b 75 08             	mov    0x8(%ebp),%esi
80102576:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80102579:	0f 86 91 00 00 00    	jbe    80102610 <ialloc+0xb0>
8010257f:	bf 01 00 00 00       	mov    $0x1,%edi
80102584:	eb 21                	jmp    801025a7 <ialloc+0x47>
80102586:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010258d:	8d 76 00             	lea    0x0(%esi),%esi
    brelse(bp);
80102590:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80102593:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80102596:	53                   	push   %ebx
80102597:	e8 54 dc ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010259c:	83 c4 10             	add    $0x10,%esp
8010259f:	3b 3d 7c 50 11 80    	cmp    0x8011507c,%edi
801025a5:	73 69                	jae    80102610 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
801025a7:	89 f8                	mov    %edi,%eax
801025a9:	83 ec 08             	sub    $0x8,%esp
801025ac:	c1 e8 03             	shr    $0x3,%eax
801025af:	03 05 88 50 11 80    	add    0x80115088,%eax
801025b5:	50                   	push   %eax
801025b6:	56                   	push   %esi
801025b7:	e8 14 db ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
801025bc:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
801025bf:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
801025c1:	89 f8                	mov    %edi,%eax
801025c3:	83 e0 07             	and    $0x7,%eax
801025c6:	c1 e0 06             	shl    $0x6,%eax
801025c9:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801025cd:	66 83 39 00          	cmpw   $0x0,(%ecx)
801025d1:	75 bd                	jne    80102590 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801025d3:	83 ec 04             	sub    $0x4,%esp
801025d6:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801025d9:	6a 40                	push   $0x40
801025db:	6a 00                	push   $0x0
801025dd:	51                   	push   %ecx
801025de:	e8 2d 3b 00 00       	call   80106110 <memset>
      dip->type = type;
801025e3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801025e7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801025ea:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801025ed:	89 1c 24             	mov    %ebx,(%esp)
801025f0:	e8 9b 18 00 00       	call   80103e90 <log_write>
      brelse(bp);
801025f5:	89 1c 24             	mov    %ebx,(%esp)
801025f8:	e8 f3 db ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
801025fd:	83 c4 10             	add    $0x10,%esp
}
80102600:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80102603:	89 fa                	mov    %edi,%edx
}
80102605:	5b                   	pop    %ebx
      return iget(dev, inum);
80102606:	89 f0                	mov    %esi,%eax
}
80102608:	5e                   	pop    %esi
80102609:	5f                   	pop    %edi
8010260a:	5d                   	pop    %ebp
      return iget(dev, inum);
8010260b:	e9 90 fc ff ff       	jmp    801022a0 <iget>
  panic("ialloc: no inodes");
80102610:	83 ec 0c             	sub    $0xc,%esp
80102613:	68 83 98 10 80       	push   $0x80109883
80102618:	e8 b3 de ff ff       	call   801004d0 <panic>
8010261d:	8d 76 00             	lea    0x0(%esi),%esi

80102620 <iupdate>:
{
80102620:	55                   	push   %ebp
80102621:	89 e5                	mov    %esp,%ebp
80102623:	56                   	push   %esi
80102624:	53                   	push   %ebx
80102625:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80102628:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010262b:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010262e:	83 ec 08             	sub    $0x8,%esp
80102631:	c1 e8 03             	shr    $0x3,%eax
80102634:	03 05 88 50 11 80    	add    0x80115088,%eax
8010263a:	50                   	push   %eax
8010263b:	ff 73 a4             	push   -0x5c(%ebx)
8010263e:	e8 8d da ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
80102643:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80102647:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010264a:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010264c:	8b 43 a8             	mov    -0x58(%ebx),%eax
8010264f:	83 e0 07             	and    $0x7,%eax
80102652:	c1 e0 06             	shl    $0x6,%eax
80102655:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80102659:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010265c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80102660:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80102663:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80102667:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010266b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010266f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80102673:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80102677:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010267a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010267d:	6a 34                	push   $0x34
8010267f:	53                   	push   %ebx
80102680:	50                   	push   %eax
80102681:	e8 2a 3b 00 00       	call   801061b0 <memmove>
  log_write(bp);
80102686:	89 34 24             	mov    %esi,(%esp)
80102689:	e8 02 18 00 00       	call   80103e90 <log_write>
  brelse(bp);
8010268e:	89 75 08             	mov    %esi,0x8(%ebp)
80102691:	83 c4 10             	add    $0x10,%esp
}
80102694:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102697:	5b                   	pop    %ebx
80102698:	5e                   	pop    %esi
80102699:	5d                   	pop    %ebp
  brelse(bp);
8010269a:	e9 51 db ff ff       	jmp    801001f0 <brelse>
8010269f:	90                   	nop

801026a0 <idup>:
{
801026a0:	55                   	push   %ebp
801026a1:	89 e5                	mov    %esp,%ebp
801026a3:	53                   	push   %ebx
801026a4:	83 ec 10             	sub    $0x10,%esp
801026a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801026aa:	68 20 34 11 80       	push   $0x80113420
801026af:	e8 6c 38 00 00       	call   80105f20 <acquire>
  ip->ref++;
801026b4:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
801026b8:	c7 04 24 20 34 11 80 	movl   $0x80113420,(%esp)
801026bf:	e8 fc 37 00 00       	call   80105ec0 <release>
}
801026c4:	89 d8                	mov    %ebx,%eax
801026c6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801026c9:	c9                   	leave  
801026ca:	c3                   	ret    
801026cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801026cf:	90                   	nop

801026d0 <ilock>:
{
801026d0:	55                   	push   %ebp
801026d1:	89 e5                	mov    %esp,%ebp
801026d3:	56                   	push   %esi
801026d4:	53                   	push   %ebx
801026d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801026d8:	85 db                	test   %ebx,%ebx
801026da:	0f 84 b7 00 00 00    	je     80102797 <ilock+0xc7>
801026e0:	8b 53 08             	mov    0x8(%ebx),%edx
801026e3:	85 d2                	test   %edx,%edx
801026e5:	0f 8e ac 00 00 00    	jle    80102797 <ilock+0xc7>
  acquiresleep(&ip->lock);
801026eb:	83 ec 0c             	sub    $0xc,%esp
801026ee:	8d 43 0c             	lea    0xc(%ebx),%eax
801026f1:	50                   	push   %eax
801026f2:	e8 69 35 00 00       	call   80105c60 <acquiresleep>
  if(ip->valid == 0){
801026f7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801026fa:	83 c4 10             	add    $0x10,%esp
801026fd:	85 c0                	test   %eax,%eax
801026ff:	74 0f                	je     80102710 <ilock+0x40>
}
80102701:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102704:	5b                   	pop    %ebx
80102705:	5e                   	pop    %esi
80102706:	5d                   	pop    %ebp
80102707:	c3                   	ret    
80102708:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010270f:	90                   	nop
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80102710:	8b 43 04             	mov    0x4(%ebx),%eax
80102713:	83 ec 08             	sub    $0x8,%esp
80102716:	c1 e8 03             	shr    $0x3,%eax
80102719:	03 05 88 50 11 80    	add    0x80115088,%eax
8010271f:	50                   	push   %eax
80102720:	ff 33                	push   (%ebx)
80102722:	e8 a9 d9 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80102727:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010272a:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010272c:	8b 43 04             	mov    0x4(%ebx),%eax
8010272f:	83 e0 07             	and    $0x7,%eax
80102732:	c1 e0 06             	shl    $0x6,%eax
80102735:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80102739:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010273c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
8010273f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80102743:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80102747:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010274b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010274f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80102753:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80102757:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010275b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010275e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80102761:	6a 34                	push   $0x34
80102763:	50                   	push   %eax
80102764:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102767:	50                   	push   %eax
80102768:	e8 43 3a 00 00       	call   801061b0 <memmove>
    brelse(bp);
8010276d:	89 34 24             	mov    %esi,(%esp)
80102770:	e8 7b da ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80102775:	83 c4 10             	add    $0x10,%esp
80102778:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010277d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80102784:	0f 85 77 ff ff ff    	jne    80102701 <ilock+0x31>
      panic("ilock: no type");
8010278a:	83 ec 0c             	sub    $0xc,%esp
8010278d:	68 9b 98 10 80       	push   $0x8010989b
80102792:	e8 39 dd ff ff       	call   801004d0 <panic>
    panic("ilock");
80102797:	83 ec 0c             	sub    $0xc,%esp
8010279a:	68 95 98 10 80       	push   $0x80109895
8010279f:	e8 2c dd ff ff       	call   801004d0 <panic>
801027a4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801027af:	90                   	nop

801027b0 <iunlock>:
{
801027b0:	55                   	push   %ebp
801027b1:	89 e5                	mov    %esp,%ebp
801027b3:	56                   	push   %esi
801027b4:	53                   	push   %ebx
801027b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801027b8:	85 db                	test   %ebx,%ebx
801027ba:	74 28                	je     801027e4 <iunlock+0x34>
801027bc:	83 ec 0c             	sub    $0xc,%esp
801027bf:	8d 73 0c             	lea    0xc(%ebx),%esi
801027c2:	56                   	push   %esi
801027c3:	e8 38 35 00 00       	call   80105d00 <holdingsleep>
801027c8:	83 c4 10             	add    $0x10,%esp
801027cb:	85 c0                	test   %eax,%eax
801027cd:	74 15                	je     801027e4 <iunlock+0x34>
801027cf:	8b 43 08             	mov    0x8(%ebx),%eax
801027d2:	85 c0                	test   %eax,%eax
801027d4:	7e 0e                	jle    801027e4 <iunlock+0x34>
  releasesleep(&ip->lock);
801027d6:	89 75 08             	mov    %esi,0x8(%ebp)
}
801027d9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801027dc:	5b                   	pop    %ebx
801027dd:	5e                   	pop    %esi
801027de:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
801027df:	e9 dc 34 00 00       	jmp    80105cc0 <releasesleep>
    panic("iunlock");
801027e4:	83 ec 0c             	sub    $0xc,%esp
801027e7:	68 aa 98 10 80       	push   $0x801098aa
801027ec:	e8 df dc ff ff       	call   801004d0 <panic>
801027f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027ff:	90                   	nop

80102800 <iput>:
{
80102800:	55                   	push   %ebp
80102801:	89 e5                	mov    %esp,%ebp
80102803:	57                   	push   %edi
80102804:	56                   	push   %esi
80102805:	53                   	push   %ebx
80102806:	83 ec 28             	sub    $0x28,%esp
80102809:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
8010280c:	8d 7b 0c             	lea    0xc(%ebx),%edi
8010280f:	57                   	push   %edi
80102810:	e8 4b 34 00 00       	call   80105c60 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80102815:	8b 53 4c             	mov    0x4c(%ebx),%edx
80102818:	83 c4 10             	add    $0x10,%esp
8010281b:	85 d2                	test   %edx,%edx
8010281d:	74 07                	je     80102826 <iput+0x26>
8010281f:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80102824:	74 32                	je     80102858 <iput+0x58>
  releasesleep(&ip->lock);
80102826:	83 ec 0c             	sub    $0xc,%esp
80102829:	57                   	push   %edi
8010282a:	e8 91 34 00 00       	call   80105cc0 <releasesleep>
  acquire(&icache.lock);
8010282f:	c7 04 24 20 34 11 80 	movl   $0x80113420,(%esp)
80102836:	e8 e5 36 00 00       	call   80105f20 <acquire>
  ip->ref--;
8010283b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010283f:	83 c4 10             	add    $0x10,%esp
80102842:	c7 45 08 20 34 11 80 	movl   $0x80113420,0x8(%ebp)
}
80102849:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010284c:	5b                   	pop    %ebx
8010284d:	5e                   	pop    %esi
8010284e:	5f                   	pop    %edi
8010284f:	5d                   	pop    %ebp
  release(&icache.lock);
80102850:	e9 6b 36 00 00       	jmp    80105ec0 <release>
80102855:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80102858:	83 ec 0c             	sub    $0xc,%esp
8010285b:	68 20 34 11 80       	push   $0x80113420
80102860:	e8 bb 36 00 00       	call   80105f20 <acquire>
    int r = ip->ref;
80102865:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80102868:	c7 04 24 20 34 11 80 	movl   $0x80113420,(%esp)
8010286f:	e8 4c 36 00 00       	call   80105ec0 <release>
    if(r == 1){
80102874:	83 c4 10             	add    $0x10,%esp
80102877:	83 fe 01             	cmp    $0x1,%esi
8010287a:	75 aa                	jne    80102826 <iput+0x26>
8010287c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80102882:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80102885:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102888:	89 cf                	mov    %ecx,%edi
8010288a:	eb 0b                	jmp    80102897 <iput+0x97>
8010288c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80102890:	83 c6 04             	add    $0x4,%esi
80102893:	39 fe                	cmp    %edi,%esi
80102895:	74 19                	je     801028b0 <iput+0xb0>
    if(ip->addrs[i]){
80102897:	8b 16                	mov    (%esi),%edx
80102899:	85 d2                	test   %edx,%edx
8010289b:	74 f3                	je     80102890 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010289d:	8b 03                	mov    (%ebx),%eax
8010289f:	e8 6c f8 ff ff       	call   80102110 <bfree>
      ip->addrs[i] = 0;
801028a4:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801028aa:	eb e4                	jmp    80102890 <iput+0x90>
801028ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
801028b0:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
801028b6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801028b9:	85 c0                	test   %eax,%eax
801028bb:	75 2d                	jne    801028ea <iput+0xea>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
801028bd:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
801028c0:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
801028c7:	53                   	push   %ebx
801028c8:	e8 53 fd ff ff       	call   80102620 <iupdate>
      ip->type = 0;
801028cd:	31 c0                	xor    %eax,%eax
801028cf:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
801028d3:	89 1c 24             	mov    %ebx,(%esp)
801028d6:	e8 45 fd ff ff       	call   80102620 <iupdate>
      ip->valid = 0;
801028db:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
801028e2:	83 c4 10             	add    $0x10,%esp
801028e5:	e9 3c ff ff ff       	jmp    80102826 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801028ea:	83 ec 08             	sub    $0x8,%esp
801028ed:	50                   	push   %eax
801028ee:	ff 33                	push   (%ebx)
801028f0:	e8 db d7 ff ff       	call   801000d0 <bread>
801028f5:	89 7d e0             	mov    %edi,-0x20(%ebp)
801028f8:	83 c4 10             	add    $0x10,%esp
801028fb:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80102901:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80102904:	8d 70 5c             	lea    0x5c(%eax),%esi
80102907:	89 cf                	mov    %ecx,%edi
80102909:	eb 0c                	jmp    80102917 <iput+0x117>
8010290b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010290f:	90                   	nop
80102910:	83 c6 04             	add    $0x4,%esi
80102913:	39 f7                	cmp    %esi,%edi
80102915:	74 0f                	je     80102926 <iput+0x126>
      if(a[j])
80102917:	8b 16                	mov    (%esi),%edx
80102919:	85 d2                	test   %edx,%edx
8010291b:	74 f3                	je     80102910 <iput+0x110>
        bfree(ip->dev, a[j]);
8010291d:	8b 03                	mov    (%ebx),%eax
8010291f:	e8 ec f7 ff ff       	call   80102110 <bfree>
80102924:	eb ea                	jmp    80102910 <iput+0x110>
    brelse(bp);
80102926:	83 ec 0c             	sub    $0xc,%esp
80102929:	ff 75 e4             	push   -0x1c(%ebp)
8010292c:	8b 7d e0             	mov    -0x20(%ebp),%edi
8010292f:	e8 bc d8 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80102934:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
8010293a:	8b 03                	mov    (%ebx),%eax
8010293c:	e8 cf f7 ff ff       	call   80102110 <bfree>
    ip->addrs[NDIRECT] = 0;
80102941:	83 c4 10             	add    $0x10,%esp
80102944:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
8010294b:	00 00 00 
8010294e:	e9 6a ff ff ff       	jmp    801028bd <iput+0xbd>
80102953:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010295a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102960 <iunlockput>:
{
80102960:	55                   	push   %ebp
80102961:	89 e5                	mov    %esp,%ebp
80102963:	56                   	push   %esi
80102964:	53                   	push   %ebx
80102965:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102968:	85 db                	test   %ebx,%ebx
8010296a:	74 34                	je     801029a0 <iunlockput+0x40>
8010296c:	83 ec 0c             	sub    $0xc,%esp
8010296f:	8d 73 0c             	lea    0xc(%ebx),%esi
80102972:	56                   	push   %esi
80102973:	e8 88 33 00 00       	call   80105d00 <holdingsleep>
80102978:	83 c4 10             	add    $0x10,%esp
8010297b:	85 c0                	test   %eax,%eax
8010297d:	74 21                	je     801029a0 <iunlockput+0x40>
8010297f:	8b 43 08             	mov    0x8(%ebx),%eax
80102982:	85 c0                	test   %eax,%eax
80102984:	7e 1a                	jle    801029a0 <iunlockput+0x40>
  releasesleep(&ip->lock);
80102986:	83 ec 0c             	sub    $0xc,%esp
80102989:	56                   	push   %esi
8010298a:	e8 31 33 00 00       	call   80105cc0 <releasesleep>
  iput(ip);
8010298f:	89 5d 08             	mov    %ebx,0x8(%ebp)
80102992:	83 c4 10             	add    $0x10,%esp
}
80102995:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102998:	5b                   	pop    %ebx
80102999:	5e                   	pop    %esi
8010299a:	5d                   	pop    %ebp
  iput(ip);
8010299b:	e9 60 fe ff ff       	jmp    80102800 <iput>
    panic("iunlock");
801029a0:	83 ec 0c             	sub    $0xc,%esp
801029a3:	68 aa 98 10 80       	push   $0x801098aa
801029a8:	e8 23 db ff ff       	call   801004d0 <panic>
801029ad:	8d 76 00             	lea    0x0(%esi),%esi

801029b0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
801029b0:	55                   	push   %ebp
801029b1:	89 e5                	mov    %esp,%ebp
801029b3:	8b 55 08             	mov    0x8(%ebp),%edx
801029b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
801029b9:	8b 0a                	mov    (%edx),%ecx
801029bb:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
801029be:	8b 4a 04             	mov    0x4(%edx),%ecx
801029c1:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
801029c4:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
801029c8:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
801029cb:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
801029cf:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
801029d3:	8b 52 58             	mov    0x58(%edx),%edx
801029d6:	89 50 10             	mov    %edx,0x10(%eax)
}
801029d9:	5d                   	pop    %ebp
801029da:	c3                   	ret    
801029db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801029df:	90                   	nop

801029e0 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
801029e0:	55                   	push   %ebp
801029e1:	89 e5                	mov    %esp,%ebp
801029e3:	57                   	push   %edi
801029e4:	56                   	push   %esi
801029e5:	53                   	push   %ebx
801029e6:	83 ec 1c             	sub    $0x1c,%esp
801029e9:	8b 7d 0c             	mov    0xc(%ebp),%edi
801029ec:	8b 45 08             	mov    0x8(%ebp),%eax
801029ef:	8b 75 10             	mov    0x10(%ebp),%esi
801029f2:	89 7d e0             	mov    %edi,-0x20(%ebp)
801029f5:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801029f8:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
801029fd:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102a00:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80102a03:	0f 84 a7 00 00 00    	je     80102ab0 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80102a09:	8b 45 d8             	mov    -0x28(%ebp),%eax
80102a0c:	8b 40 58             	mov    0x58(%eax),%eax
80102a0f:	39 c6                	cmp    %eax,%esi
80102a11:	0f 87 ba 00 00 00    	ja     80102ad1 <readi+0xf1>
80102a17:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80102a1a:	31 c9                	xor    %ecx,%ecx
80102a1c:	89 da                	mov    %ebx,%edx
80102a1e:	01 f2                	add    %esi,%edx
80102a20:	0f 92 c1             	setb   %cl
80102a23:	89 cf                	mov    %ecx,%edi
80102a25:	0f 82 a6 00 00 00    	jb     80102ad1 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80102a2b:	89 c1                	mov    %eax,%ecx
80102a2d:	29 f1                	sub    %esi,%ecx
80102a2f:	39 d0                	cmp    %edx,%eax
80102a31:	0f 43 cb             	cmovae %ebx,%ecx
80102a34:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102a37:	85 c9                	test   %ecx,%ecx
80102a39:	74 67                	je     80102aa2 <readi+0xc2>
80102a3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a3f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102a40:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80102a43:	89 f2                	mov    %esi,%edx
80102a45:	c1 ea 09             	shr    $0x9,%edx
80102a48:	89 d8                	mov    %ebx,%eax
80102a4a:	e8 51 f9 ff ff       	call   801023a0 <bmap>
80102a4f:	83 ec 08             	sub    $0x8,%esp
80102a52:	50                   	push   %eax
80102a53:	ff 33                	push   (%ebx)
80102a55:	e8 76 d6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80102a5a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80102a5d:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102a62:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80102a64:	89 f0                	mov    %esi,%eax
80102a66:	25 ff 01 00 00       	and    $0x1ff,%eax
80102a6b:	29 fb                	sub    %edi,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80102a6d:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80102a70:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80102a72:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80102a76:	39 d9                	cmp    %ebx,%ecx
80102a78:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80102a7b:	83 c4 0c             	add    $0xc,%esp
80102a7e:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102a7f:	01 df                	add    %ebx,%edi
80102a81:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80102a83:	50                   	push   %eax
80102a84:	ff 75 e0             	push   -0x20(%ebp)
80102a87:	e8 24 37 00 00       	call   801061b0 <memmove>
    brelse(bp);
80102a8c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80102a8f:	89 14 24             	mov    %edx,(%esp)
80102a92:	e8 59 d7 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102a97:	01 5d e0             	add    %ebx,-0x20(%ebp)
80102a9a:	83 c4 10             	add    $0x10,%esp
80102a9d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80102aa0:	77 9e                	ja     80102a40 <readi+0x60>
  }
  return n;
80102aa2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80102aa5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102aa8:	5b                   	pop    %ebx
80102aa9:	5e                   	pop    %esi
80102aaa:	5f                   	pop    %edi
80102aab:	5d                   	pop    %ebp
80102aac:	c3                   	ret    
80102aad:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80102ab0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102ab4:	66 83 f8 09          	cmp    $0x9,%ax
80102ab8:	77 17                	ja     80102ad1 <readi+0xf1>
80102aba:	8b 04 c5 c0 33 11 80 	mov    -0x7feecc40(,%eax,8),%eax
80102ac1:	85 c0                	test   %eax,%eax
80102ac3:	74 0c                	je     80102ad1 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80102ac5:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80102ac8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102acb:	5b                   	pop    %ebx
80102acc:	5e                   	pop    %esi
80102acd:	5f                   	pop    %edi
80102ace:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80102acf:	ff e0                	jmp    *%eax
      return -1;
80102ad1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102ad6:	eb cd                	jmp    80102aa5 <readi+0xc5>
80102ad8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102adf:	90                   	nop

80102ae0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80102ae0:	55                   	push   %ebp
80102ae1:	89 e5                	mov    %esp,%ebp
80102ae3:	57                   	push   %edi
80102ae4:	56                   	push   %esi
80102ae5:	53                   	push   %ebx
80102ae6:	83 ec 1c             	sub    $0x1c,%esp
80102ae9:	8b 45 08             	mov    0x8(%ebp),%eax
80102aec:	8b 75 0c             	mov    0xc(%ebp),%esi
80102aef:	8b 55 14             	mov    0x14(%ebp),%edx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80102af2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80102af7:	89 75 dc             	mov    %esi,-0x24(%ebp)
80102afa:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102afd:	8b 75 10             	mov    0x10(%ebp),%esi
80102b00:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(ip->type == T_DEV){
80102b03:	0f 84 b7 00 00 00    	je     80102bc0 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80102b09:	8b 45 d8             	mov    -0x28(%ebp),%eax
80102b0c:	3b 70 58             	cmp    0x58(%eax),%esi
80102b0f:	0f 87 e7 00 00 00    	ja     80102bfc <writei+0x11c>
80102b15:	8b 7d e0             	mov    -0x20(%ebp),%edi
80102b18:	31 d2                	xor    %edx,%edx
80102b1a:	89 f8                	mov    %edi,%eax
80102b1c:	01 f0                	add    %esi,%eax
80102b1e:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80102b21:	3d 00 18 01 00       	cmp    $0x11800,%eax
80102b26:	0f 87 d0 00 00 00    	ja     80102bfc <writei+0x11c>
80102b2c:	85 d2                	test   %edx,%edx
80102b2e:	0f 85 c8 00 00 00    	jne    80102bfc <writei+0x11c>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102b34:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80102b3b:	85 ff                	test   %edi,%edi
80102b3d:	74 72                	je     80102bb1 <writei+0xd1>
80102b3f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102b40:	8b 7d d8             	mov    -0x28(%ebp),%edi
80102b43:	89 f2                	mov    %esi,%edx
80102b45:	c1 ea 09             	shr    $0x9,%edx
80102b48:	89 f8                	mov    %edi,%eax
80102b4a:	e8 51 f8 ff ff       	call   801023a0 <bmap>
80102b4f:	83 ec 08             	sub    $0x8,%esp
80102b52:	50                   	push   %eax
80102b53:	ff 37                	push   (%edi)
80102b55:	e8 76 d5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80102b5a:	b9 00 02 00 00       	mov    $0x200,%ecx
80102b5f:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80102b62:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102b65:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80102b67:	89 f0                	mov    %esi,%eax
80102b69:	25 ff 01 00 00       	and    $0x1ff,%eax
80102b6e:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80102b70:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80102b74:	39 d9                	cmp    %ebx,%ecx
80102b76:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80102b79:	83 c4 0c             	add    $0xc,%esp
80102b7c:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102b7d:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80102b7f:	ff 75 dc             	push   -0x24(%ebp)
80102b82:	50                   	push   %eax
80102b83:	e8 28 36 00 00       	call   801061b0 <memmove>
    log_write(bp);
80102b88:	89 3c 24             	mov    %edi,(%esp)
80102b8b:	e8 00 13 00 00       	call   80103e90 <log_write>
    brelse(bp);
80102b90:	89 3c 24             	mov    %edi,(%esp)
80102b93:	e8 58 d6 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102b98:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80102b9b:	83 c4 10             	add    $0x10,%esp
80102b9e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102ba1:	01 5d dc             	add    %ebx,-0x24(%ebp)
80102ba4:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80102ba7:	77 97                	ja     80102b40 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80102ba9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80102bac:	3b 70 58             	cmp    0x58(%eax),%esi
80102baf:	77 37                	ja     80102be8 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80102bb1:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80102bb4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102bb7:	5b                   	pop    %ebx
80102bb8:	5e                   	pop    %esi
80102bb9:	5f                   	pop    %edi
80102bba:	5d                   	pop    %ebp
80102bbb:	c3                   	ret    
80102bbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80102bc0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102bc4:	66 83 f8 09          	cmp    $0x9,%ax
80102bc8:	77 32                	ja     80102bfc <writei+0x11c>
80102bca:	8b 04 c5 c4 33 11 80 	mov    -0x7feecc3c(,%eax,8),%eax
80102bd1:	85 c0                	test   %eax,%eax
80102bd3:	74 27                	je     80102bfc <writei+0x11c>
    return devsw[ip->major].write(ip, src, n);
80102bd5:	89 55 10             	mov    %edx,0x10(%ebp)
}
80102bd8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102bdb:	5b                   	pop    %ebx
80102bdc:	5e                   	pop    %esi
80102bdd:	5f                   	pop    %edi
80102bde:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80102bdf:	ff e0                	jmp    *%eax
80102be1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80102be8:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80102beb:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80102bee:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80102bf1:	50                   	push   %eax
80102bf2:	e8 29 fa ff ff       	call   80102620 <iupdate>
80102bf7:	83 c4 10             	add    $0x10,%esp
80102bfa:	eb b5                	jmp    80102bb1 <writei+0xd1>
      return -1;
80102bfc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102c01:	eb b1                	jmp    80102bb4 <writei+0xd4>
80102c03:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102c10 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80102c10:	55                   	push   %ebp
80102c11:	89 e5                	mov    %esp,%ebp
80102c13:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80102c16:	6a 0e                	push   $0xe
80102c18:	ff 75 0c             	push   0xc(%ebp)
80102c1b:	ff 75 08             	push   0x8(%ebp)
80102c1e:	e8 fd 35 00 00       	call   80106220 <strncmp>
}
80102c23:	c9                   	leave  
80102c24:	c3                   	ret    
80102c25:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102c30 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102c30:	55                   	push   %ebp
80102c31:	89 e5                	mov    %esp,%ebp
80102c33:	57                   	push   %edi
80102c34:	56                   	push   %esi
80102c35:	53                   	push   %ebx
80102c36:	83 ec 1c             	sub    $0x1c,%esp
80102c39:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80102c3c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80102c41:	0f 85 85 00 00 00    	jne    80102ccc <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80102c47:	8b 53 58             	mov    0x58(%ebx),%edx
80102c4a:	31 ff                	xor    %edi,%edi
80102c4c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102c4f:	85 d2                	test   %edx,%edx
80102c51:	74 3e                	je     80102c91 <dirlookup+0x61>
80102c53:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c57:	90                   	nop
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102c58:	6a 10                	push   $0x10
80102c5a:	57                   	push   %edi
80102c5b:	56                   	push   %esi
80102c5c:	53                   	push   %ebx
80102c5d:	e8 7e fd ff ff       	call   801029e0 <readi>
80102c62:	83 c4 10             	add    $0x10,%esp
80102c65:	83 f8 10             	cmp    $0x10,%eax
80102c68:	75 55                	jne    80102cbf <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80102c6a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80102c6f:	74 18                	je     80102c89 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80102c71:	83 ec 04             	sub    $0x4,%esp
80102c74:	8d 45 da             	lea    -0x26(%ebp),%eax
80102c77:	6a 0e                	push   $0xe
80102c79:	50                   	push   %eax
80102c7a:	ff 75 0c             	push   0xc(%ebp)
80102c7d:	e8 9e 35 00 00       	call   80106220 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80102c82:	83 c4 10             	add    $0x10,%esp
80102c85:	85 c0                	test   %eax,%eax
80102c87:	74 17                	je     80102ca0 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80102c89:	83 c7 10             	add    $0x10,%edi
80102c8c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102c8f:	72 c7                	jb     80102c58 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80102c91:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80102c94:	31 c0                	xor    %eax,%eax
}
80102c96:	5b                   	pop    %ebx
80102c97:	5e                   	pop    %esi
80102c98:	5f                   	pop    %edi
80102c99:	5d                   	pop    %ebp
80102c9a:	c3                   	ret    
80102c9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c9f:	90                   	nop
      if(poff)
80102ca0:	8b 45 10             	mov    0x10(%ebp),%eax
80102ca3:	85 c0                	test   %eax,%eax
80102ca5:	74 05                	je     80102cac <dirlookup+0x7c>
        *poff = off;
80102ca7:	8b 45 10             	mov    0x10(%ebp),%eax
80102caa:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80102cac:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80102cb0:	8b 03                	mov    (%ebx),%eax
80102cb2:	e8 e9 f5 ff ff       	call   801022a0 <iget>
}
80102cb7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102cba:	5b                   	pop    %ebx
80102cbb:	5e                   	pop    %esi
80102cbc:	5f                   	pop    %edi
80102cbd:	5d                   	pop    %ebp
80102cbe:	c3                   	ret    
      panic("dirlookup read");
80102cbf:	83 ec 0c             	sub    $0xc,%esp
80102cc2:	68 c4 98 10 80       	push   $0x801098c4
80102cc7:	e8 04 d8 ff ff       	call   801004d0 <panic>
    panic("dirlookup not DIR");
80102ccc:	83 ec 0c             	sub    $0xc,%esp
80102ccf:	68 b2 98 10 80       	push   $0x801098b2
80102cd4:	e8 f7 d7 ff ff       	call   801004d0 <panic>
80102cd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102ce0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80102ce0:	55                   	push   %ebp
80102ce1:	89 e5                	mov    %esp,%ebp
80102ce3:	57                   	push   %edi
80102ce4:	56                   	push   %esi
80102ce5:	53                   	push   %ebx
80102ce6:	89 c3                	mov    %eax,%ebx
80102ce8:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80102ceb:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80102cee:	89 55 dc             	mov    %edx,-0x24(%ebp)
80102cf1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80102cf4:	0f 84 64 01 00 00    	je     80102e5e <namex+0x17e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80102cfa:	e8 51 1c 00 00       	call   80104950 <myproc>
  acquire(&icache.lock);
80102cff:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80102d02:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80102d05:	68 20 34 11 80       	push   $0x80113420
80102d0a:	e8 11 32 00 00       	call   80105f20 <acquire>
  ip->ref++;
80102d0f:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80102d13:	c7 04 24 20 34 11 80 	movl   $0x80113420,(%esp)
80102d1a:	e8 a1 31 00 00       	call   80105ec0 <release>
80102d1f:	83 c4 10             	add    $0x10,%esp
80102d22:	eb 07                	jmp    80102d2b <namex+0x4b>
80102d24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80102d28:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80102d2b:	0f b6 03             	movzbl (%ebx),%eax
80102d2e:	3c 2f                	cmp    $0x2f,%al
80102d30:	74 f6                	je     80102d28 <namex+0x48>
  if(*path == 0)
80102d32:	84 c0                	test   %al,%al
80102d34:	0f 84 06 01 00 00    	je     80102e40 <namex+0x160>
  while(*path != '/' && *path != 0)
80102d3a:	0f b6 03             	movzbl (%ebx),%eax
80102d3d:	84 c0                	test   %al,%al
80102d3f:	0f 84 10 01 00 00    	je     80102e55 <namex+0x175>
80102d45:	89 df                	mov    %ebx,%edi
80102d47:	3c 2f                	cmp    $0x2f,%al
80102d49:	0f 84 06 01 00 00    	je     80102e55 <namex+0x175>
80102d4f:	90                   	nop
80102d50:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
80102d54:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
80102d57:	3c 2f                	cmp    $0x2f,%al
80102d59:	74 04                	je     80102d5f <namex+0x7f>
80102d5b:	84 c0                	test   %al,%al
80102d5d:	75 f1                	jne    80102d50 <namex+0x70>
  len = path - s;
80102d5f:	89 f8                	mov    %edi,%eax
80102d61:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
80102d63:	83 f8 0d             	cmp    $0xd,%eax
80102d66:	0f 8e ac 00 00 00    	jle    80102e18 <namex+0x138>
    memmove(name, s, DIRSIZ);
80102d6c:	83 ec 04             	sub    $0x4,%esp
80102d6f:	6a 0e                	push   $0xe
80102d71:	53                   	push   %ebx
    path++;
80102d72:	89 fb                	mov    %edi,%ebx
    memmove(name, s, DIRSIZ);
80102d74:	ff 75 e4             	push   -0x1c(%ebp)
80102d77:	e8 34 34 00 00       	call   801061b0 <memmove>
80102d7c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80102d7f:	80 3f 2f             	cmpb   $0x2f,(%edi)
80102d82:	75 0c                	jne    80102d90 <namex+0xb0>
80102d84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80102d88:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80102d8b:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80102d8e:	74 f8                	je     80102d88 <namex+0xa8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80102d90:	83 ec 0c             	sub    $0xc,%esp
80102d93:	56                   	push   %esi
80102d94:	e8 37 f9 ff ff       	call   801026d0 <ilock>
    if(ip->type != T_DIR){
80102d99:	83 c4 10             	add    $0x10,%esp
80102d9c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80102da1:	0f 85 cd 00 00 00    	jne    80102e74 <namex+0x194>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80102da7:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102daa:	85 c0                	test   %eax,%eax
80102dac:	74 09                	je     80102db7 <namex+0xd7>
80102dae:	80 3b 00             	cmpb   $0x0,(%ebx)
80102db1:	0f 84 22 01 00 00    	je     80102ed9 <namex+0x1f9>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80102db7:	83 ec 04             	sub    $0x4,%esp
80102dba:	6a 00                	push   $0x0
80102dbc:	ff 75 e4             	push   -0x1c(%ebp)
80102dbf:	56                   	push   %esi
80102dc0:	e8 6b fe ff ff       	call   80102c30 <dirlookup>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102dc5:	8d 56 0c             	lea    0xc(%esi),%edx
    if((next = dirlookup(ip, name, 0)) == 0){
80102dc8:	83 c4 10             	add    $0x10,%esp
80102dcb:	89 c7                	mov    %eax,%edi
80102dcd:	85 c0                	test   %eax,%eax
80102dcf:	0f 84 e1 00 00 00    	je     80102eb6 <namex+0x1d6>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102dd5:	83 ec 0c             	sub    $0xc,%esp
80102dd8:	89 55 e0             	mov    %edx,-0x20(%ebp)
80102ddb:	52                   	push   %edx
80102ddc:	e8 1f 2f 00 00       	call   80105d00 <holdingsleep>
80102de1:	83 c4 10             	add    $0x10,%esp
80102de4:	85 c0                	test   %eax,%eax
80102de6:	0f 84 30 01 00 00    	je     80102f1c <namex+0x23c>
80102dec:	8b 56 08             	mov    0x8(%esi),%edx
80102def:	85 d2                	test   %edx,%edx
80102df1:	0f 8e 25 01 00 00    	jle    80102f1c <namex+0x23c>
  releasesleep(&ip->lock);
80102df7:	8b 55 e0             	mov    -0x20(%ebp),%edx
80102dfa:	83 ec 0c             	sub    $0xc,%esp
80102dfd:	52                   	push   %edx
80102dfe:	e8 bd 2e 00 00       	call   80105cc0 <releasesleep>
  iput(ip);
80102e03:	89 34 24             	mov    %esi,(%esp)
80102e06:	89 fe                	mov    %edi,%esi
80102e08:	e8 f3 f9 ff ff       	call   80102800 <iput>
80102e0d:	83 c4 10             	add    $0x10,%esp
80102e10:	e9 16 ff ff ff       	jmp    80102d2b <namex+0x4b>
80102e15:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80102e18:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80102e1b:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    memmove(name, s, len);
80102e1e:	83 ec 04             	sub    $0x4,%esp
80102e21:	89 55 e0             	mov    %edx,-0x20(%ebp)
80102e24:	50                   	push   %eax
80102e25:	53                   	push   %ebx
    name[len] = 0;
80102e26:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
80102e28:	ff 75 e4             	push   -0x1c(%ebp)
80102e2b:	e8 80 33 00 00       	call   801061b0 <memmove>
    name[len] = 0;
80102e30:	8b 55 e0             	mov    -0x20(%ebp),%edx
80102e33:	83 c4 10             	add    $0x10,%esp
80102e36:	c6 02 00             	movb   $0x0,(%edx)
80102e39:	e9 41 ff ff ff       	jmp    80102d7f <namex+0x9f>
80102e3e:	66 90                	xchg   %ax,%ax
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80102e40:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102e43:	85 c0                	test   %eax,%eax
80102e45:	0f 85 be 00 00 00    	jne    80102f09 <namex+0x229>
    iput(ip);
    return 0;
  }
  return ip;
}
80102e4b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e4e:	89 f0                	mov    %esi,%eax
80102e50:	5b                   	pop    %ebx
80102e51:	5e                   	pop    %esi
80102e52:	5f                   	pop    %edi
80102e53:	5d                   	pop    %ebp
80102e54:	c3                   	ret    
  while(*path != '/' && *path != 0)
80102e55:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102e58:	89 df                	mov    %ebx,%edi
80102e5a:	31 c0                	xor    %eax,%eax
80102e5c:	eb c0                	jmp    80102e1e <namex+0x13e>
    ip = iget(ROOTDEV, ROOTINO);
80102e5e:	ba 01 00 00 00       	mov    $0x1,%edx
80102e63:	b8 01 00 00 00       	mov    $0x1,%eax
80102e68:	e8 33 f4 ff ff       	call   801022a0 <iget>
80102e6d:	89 c6                	mov    %eax,%esi
80102e6f:	e9 b7 fe ff ff       	jmp    80102d2b <namex+0x4b>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102e74:	83 ec 0c             	sub    $0xc,%esp
80102e77:	8d 5e 0c             	lea    0xc(%esi),%ebx
80102e7a:	53                   	push   %ebx
80102e7b:	e8 80 2e 00 00       	call   80105d00 <holdingsleep>
80102e80:	83 c4 10             	add    $0x10,%esp
80102e83:	85 c0                	test   %eax,%eax
80102e85:	0f 84 91 00 00 00    	je     80102f1c <namex+0x23c>
80102e8b:	8b 46 08             	mov    0x8(%esi),%eax
80102e8e:	85 c0                	test   %eax,%eax
80102e90:	0f 8e 86 00 00 00    	jle    80102f1c <namex+0x23c>
  releasesleep(&ip->lock);
80102e96:	83 ec 0c             	sub    $0xc,%esp
80102e99:	53                   	push   %ebx
80102e9a:	e8 21 2e 00 00       	call   80105cc0 <releasesleep>
  iput(ip);
80102e9f:	89 34 24             	mov    %esi,(%esp)
      return 0;
80102ea2:	31 f6                	xor    %esi,%esi
  iput(ip);
80102ea4:	e8 57 f9 ff ff       	call   80102800 <iput>
      return 0;
80102ea9:	83 c4 10             	add    $0x10,%esp
}
80102eac:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102eaf:	89 f0                	mov    %esi,%eax
80102eb1:	5b                   	pop    %ebx
80102eb2:	5e                   	pop    %esi
80102eb3:	5f                   	pop    %edi
80102eb4:	5d                   	pop    %ebp
80102eb5:	c3                   	ret    
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102eb6:	83 ec 0c             	sub    $0xc,%esp
80102eb9:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80102ebc:	52                   	push   %edx
80102ebd:	e8 3e 2e 00 00       	call   80105d00 <holdingsleep>
80102ec2:	83 c4 10             	add    $0x10,%esp
80102ec5:	85 c0                	test   %eax,%eax
80102ec7:	74 53                	je     80102f1c <namex+0x23c>
80102ec9:	8b 4e 08             	mov    0x8(%esi),%ecx
80102ecc:	85 c9                	test   %ecx,%ecx
80102ece:	7e 4c                	jle    80102f1c <namex+0x23c>
  releasesleep(&ip->lock);
80102ed0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102ed3:	83 ec 0c             	sub    $0xc,%esp
80102ed6:	52                   	push   %edx
80102ed7:	eb c1                	jmp    80102e9a <namex+0x1ba>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102ed9:	83 ec 0c             	sub    $0xc,%esp
80102edc:	8d 5e 0c             	lea    0xc(%esi),%ebx
80102edf:	53                   	push   %ebx
80102ee0:	e8 1b 2e 00 00       	call   80105d00 <holdingsleep>
80102ee5:	83 c4 10             	add    $0x10,%esp
80102ee8:	85 c0                	test   %eax,%eax
80102eea:	74 30                	je     80102f1c <namex+0x23c>
80102eec:	8b 7e 08             	mov    0x8(%esi),%edi
80102eef:	85 ff                	test   %edi,%edi
80102ef1:	7e 29                	jle    80102f1c <namex+0x23c>
  releasesleep(&ip->lock);
80102ef3:	83 ec 0c             	sub    $0xc,%esp
80102ef6:	53                   	push   %ebx
80102ef7:	e8 c4 2d 00 00       	call   80105cc0 <releasesleep>
}
80102efc:	83 c4 10             	add    $0x10,%esp
}
80102eff:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f02:	89 f0                	mov    %esi,%eax
80102f04:	5b                   	pop    %ebx
80102f05:	5e                   	pop    %esi
80102f06:	5f                   	pop    %edi
80102f07:	5d                   	pop    %ebp
80102f08:	c3                   	ret    
    iput(ip);
80102f09:	83 ec 0c             	sub    $0xc,%esp
80102f0c:	56                   	push   %esi
    return 0;
80102f0d:	31 f6                	xor    %esi,%esi
    iput(ip);
80102f0f:	e8 ec f8 ff ff       	call   80102800 <iput>
    return 0;
80102f14:	83 c4 10             	add    $0x10,%esp
80102f17:	e9 2f ff ff ff       	jmp    80102e4b <namex+0x16b>
    panic("iunlock");
80102f1c:	83 ec 0c             	sub    $0xc,%esp
80102f1f:	68 aa 98 10 80       	push   $0x801098aa
80102f24:	e8 a7 d5 ff ff       	call   801004d0 <panic>
80102f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102f30 <dirlink>:
{
80102f30:	55                   	push   %ebp
80102f31:	89 e5                	mov    %esp,%ebp
80102f33:	57                   	push   %edi
80102f34:	56                   	push   %esi
80102f35:	53                   	push   %ebx
80102f36:	83 ec 20             	sub    $0x20,%esp
80102f39:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80102f3c:	6a 00                	push   $0x0
80102f3e:	ff 75 0c             	push   0xc(%ebp)
80102f41:	53                   	push   %ebx
80102f42:	e8 e9 fc ff ff       	call   80102c30 <dirlookup>
80102f47:	83 c4 10             	add    $0x10,%esp
80102f4a:	85 c0                	test   %eax,%eax
80102f4c:	75 67                	jne    80102fb5 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80102f4e:	8b 7b 58             	mov    0x58(%ebx),%edi
80102f51:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102f54:	85 ff                	test   %edi,%edi
80102f56:	74 29                	je     80102f81 <dirlink+0x51>
80102f58:	31 ff                	xor    %edi,%edi
80102f5a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102f5d:	eb 09                	jmp    80102f68 <dirlink+0x38>
80102f5f:	90                   	nop
80102f60:	83 c7 10             	add    $0x10,%edi
80102f63:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102f66:	73 19                	jae    80102f81 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102f68:	6a 10                	push   $0x10
80102f6a:	57                   	push   %edi
80102f6b:	56                   	push   %esi
80102f6c:	53                   	push   %ebx
80102f6d:	e8 6e fa ff ff       	call   801029e0 <readi>
80102f72:	83 c4 10             	add    $0x10,%esp
80102f75:	83 f8 10             	cmp    $0x10,%eax
80102f78:	75 4e                	jne    80102fc8 <dirlink+0x98>
    if(de.inum == 0)
80102f7a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80102f7f:	75 df                	jne    80102f60 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80102f81:	83 ec 04             	sub    $0x4,%esp
80102f84:	8d 45 da             	lea    -0x26(%ebp),%eax
80102f87:	6a 0e                	push   $0xe
80102f89:	ff 75 0c             	push   0xc(%ebp)
80102f8c:	50                   	push   %eax
80102f8d:	e8 de 32 00 00       	call   80106270 <strncpy>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102f92:	6a 10                	push   $0x10
  de.inum = inum;
80102f94:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102f97:	57                   	push   %edi
80102f98:	56                   	push   %esi
80102f99:	53                   	push   %ebx
  de.inum = inum;
80102f9a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102f9e:	e8 3d fb ff ff       	call   80102ae0 <writei>
80102fa3:	83 c4 20             	add    $0x20,%esp
80102fa6:	83 f8 10             	cmp    $0x10,%eax
80102fa9:	75 2a                	jne    80102fd5 <dirlink+0xa5>
  return 0;
80102fab:	31 c0                	xor    %eax,%eax
}
80102fad:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102fb0:	5b                   	pop    %ebx
80102fb1:	5e                   	pop    %esi
80102fb2:	5f                   	pop    %edi
80102fb3:	5d                   	pop    %ebp
80102fb4:	c3                   	ret    
    iput(ip);
80102fb5:	83 ec 0c             	sub    $0xc,%esp
80102fb8:	50                   	push   %eax
80102fb9:	e8 42 f8 ff ff       	call   80102800 <iput>
    return -1;
80102fbe:	83 c4 10             	add    $0x10,%esp
80102fc1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102fc6:	eb e5                	jmp    80102fad <dirlink+0x7d>
      panic("dirlink read");
80102fc8:	83 ec 0c             	sub    $0xc,%esp
80102fcb:	68 d3 98 10 80       	push   $0x801098d3
80102fd0:	e8 fb d4 ff ff       	call   801004d0 <panic>
    panic("dirlink");
80102fd5:	83 ec 0c             	sub    $0xc,%esp
80102fd8:	68 6a a0 10 80       	push   $0x8010a06a
80102fdd:	e8 ee d4 ff ff       	call   801004d0 <panic>
80102fe2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102fe9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102ff0 <namei>:

struct inode*
namei(char *path)
{
80102ff0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102ff1:	31 d2                	xor    %edx,%edx
{
80102ff3:	89 e5                	mov    %esp,%ebp
80102ff5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80102ff8:	8b 45 08             	mov    0x8(%ebp),%eax
80102ffb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80102ffe:	e8 dd fc ff ff       	call   80102ce0 <namex>
}
80103003:	c9                   	leave  
80103004:	c3                   	ret    
80103005:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010300c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103010 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80103010:	55                   	push   %ebp
  return namex(path, 1, name);
80103011:	ba 01 00 00 00       	mov    $0x1,%edx
{
80103016:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80103018:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010301b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010301e:	5d                   	pop    %ebp
  return namex(path, 1, name);
8010301f:	e9 bc fc ff ff       	jmp    80102ce0 <namex>
80103024:	66 90                	xchg   %ax,%ax
80103026:	66 90                	xchg   %ax,%ax
80103028:	66 90                	xchg   %ax,%ax
8010302a:	66 90                	xchg   %ax,%ax
8010302c:	66 90                	xchg   %ax,%ax
8010302e:	66 90                	xchg   %ax,%ax

80103030 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80103030:	55                   	push   %ebp
80103031:	89 e5                	mov    %esp,%ebp
80103033:	57                   	push   %edi
80103034:	56                   	push   %esi
80103035:	53                   	push   %ebx
80103036:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80103039:	85 c0                	test   %eax,%eax
8010303b:	0f 84 b4 00 00 00    	je     801030f5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80103041:	8b 70 08             	mov    0x8(%eax),%esi
80103044:	89 c3                	mov    %eax,%ebx
80103046:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
8010304c:	0f 87 96 00 00 00    	ja     801030e8 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103052:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80103057:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010305e:	66 90                	xchg   %ax,%ax
80103060:	89 ca                	mov    %ecx,%edx
80103062:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80103063:	83 e0 c0             	and    $0xffffffc0,%eax
80103066:	3c 40                	cmp    $0x40,%al
80103068:	75 f6                	jne    80103060 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010306a:	31 ff                	xor    %edi,%edi
8010306c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80103071:	89 f8                	mov    %edi,%eax
80103073:	ee                   	out    %al,(%dx)
80103074:	b8 01 00 00 00       	mov    $0x1,%eax
80103079:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010307e:	ee                   	out    %al,(%dx)
8010307f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80103084:	89 f0                	mov    %esi,%eax
80103086:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80103087:	89 f0                	mov    %esi,%eax
80103089:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010308e:	c1 f8 08             	sar    $0x8,%eax
80103091:	ee                   	out    %al,(%dx)
80103092:	ba f5 01 00 00       	mov    $0x1f5,%edx
80103097:	89 f8                	mov    %edi,%eax
80103099:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010309a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
8010309e:	ba f6 01 00 00       	mov    $0x1f6,%edx
801030a3:	c1 e0 04             	shl    $0x4,%eax
801030a6:	83 e0 10             	and    $0x10,%eax
801030a9:	83 c8 e0             	or     $0xffffffe0,%eax
801030ac:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
801030ad:	f6 03 04             	testb  $0x4,(%ebx)
801030b0:	75 16                	jne    801030c8 <idestart+0x98>
801030b2:	b8 20 00 00 00       	mov    $0x20,%eax
801030b7:	89 ca                	mov    %ecx,%edx
801030b9:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
801030ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
801030bd:	5b                   	pop    %ebx
801030be:	5e                   	pop    %esi
801030bf:	5f                   	pop    %edi
801030c0:	5d                   	pop    %ebp
801030c1:	c3                   	ret    
801030c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801030c8:	b8 30 00 00 00       	mov    $0x30,%eax
801030cd:	89 ca                	mov    %ecx,%edx
801030cf:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
801030d0:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
801030d5:	8d 73 5c             	lea    0x5c(%ebx),%esi
801030d8:	ba f0 01 00 00       	mov    $0x1f0,%edx
801030dd:	fc                   	cld    
801030de:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
801030e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801030e3:	5b                   	pop    %ebx
801030e4:	5e                   	pop    %esi
801030e5:	5f                   	pop    %edi
801030e6:	5d                   	pop    %ebp
801030e7:	c3                   	ret    
    panic("incorrect blockno");
801030e8:	83 ec 0c             	sub    $0xc,%esp
801030eb:	68 3c 99 10 80       	push   $0x8010993c
801030f0:	e8 db d3 ff ff       	call   801004d0 <panic>
    panic("idestart");
801030f5:	83 ec 0c             	sub    $0xc,%esp
801030f8:	68 33 99 10 80       	push   $0x80109933
801030fd:	e8 ce d3 ff ff       	call   801004d0 <panic>
80103102:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103110 <ideinit>:
{
80103110:	55                   	push   %ebp
80103111:	89 e5                	mov    %esp,%ebp
80103113:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80103116:	68 4e 99 10 80       	push   $0x8010994e
8010311b:	68 c0 50 11 80       	push   $0x801150c0
80103120:	e8 2b 2c 00 00       	call   80105d50 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80103125:	58                   	pop    %eax
80103126:	a1 44 52 11 80       	mov    0x80115244,%eax
8010312b:	5a                   	pop    %edx
8010312c:	83 e8 01             	sub    $0x1,%eax
8010312f:	50                   	push   %eax
80103130:	6a 0e                	push   $0xe
80103132:	e8 99 02 00 00       	call   801033d0 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80103137:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010313a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010313f:	90                   	nop
80103140:	ec                   	in     (%dx),%al
80103141:	83 e0 c0             	and    $0xffffffc0,%eax
80103144:	3c 40                	cmp    $0x40,%al
80103146:	75 f8                	jne    80103140 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103148:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010314d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80103152:	ee                   	out    %al,(%dx)
80103153:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103158:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010315d:	eb 06                	jmp    80103165 <ideinit+0x55>
8010315f:	90                   	nop
  for(i=0; i<1000; i++){
80103160:	83 e9 01             	sub    $0x1,%ecx
80103163:	74 0f                	je     80103174 <ideinit+0x64>
80103165:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80103166:	84 c0                	test   %al,%al
80103168:	74 f6                	je     80103160 <ideinit+0x50>
      havedisk1 = 1;
8010316a:	c7 05 a0 50 11 80 01 	movl   $0x1,0x801150a0
80103171:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103174:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80103179:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010317e:	ee                   	out    %al,(%dx)
}
8010317f:	c9                   	leave  
80103180:	c3                   	ret    
80103181:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103188:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010318f:	90                   	nop

80103190 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80103190:	55                   	push   %ebp
80103191:	89 e5                	mov    %esp,%ebp
80103193:	57                   	push   %edi
80103194:	56                   	push   %esi
80103195:	53                   	push   %ebx
80103196:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80103199:	68 c0 50 11 80       	push   $0x801150c0
8010319e:	e8 7d 2d 00 00       	call   80105f20 <acquire>

  if((b = idequeue) == 0){
801031a3:	8b 1d a4 50 11 80    	mov    0x801150a4,%ebx
801031a9:	83 c4 10             	add    $0x10,%esp
801031ac:	85 db                	test   %ebx,%ebx
801031ae:	74 63                	je     80103213 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801031b0:	8b 43 58             	mov    0x58(%ebx),%eax
801031b3:	a3 a4 50 11 80       	mov    %eax,0x801150a4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801031b8:	8b 33                	mov    (%ebx),%esi
801031ba:	f7 c6 04 00 00 00    	test   $0x4,%esi
801031c0:	75 2f                	jne    801031f1 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801031c2:	ba f7 01 00 00       	mov    $0x1f7,%edx
801031c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801031ce:	66 90                	xchg   %ax,%ax
801031d0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801031d1:	89 c1                	mov    %eax,%ecx
801031d3:	83 e1 c0             	and    $0xffffffc0,%ecx
801031d6:	80 f9 40             	cmp    $0x40,%cl
801031d9:	75 f5                	jne    801031d0 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801031db:	a8 21                	test   $0x21,%al
801031dd:	75 12                	jne    801031f1 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
801031df:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801031e2:	b9 80 00 00 00       	mov    $0x80,%ecx
801031e7:	ba f0 01 00 00       	mov    $0x1f0,%edx
801031ec:	fc                   	cld    
801031ed:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
801031ef:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
801031f1:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
801031f4:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801031f7:	83 ce 02             	or     $0x2,%esi
801031fa:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
801031fc:	53                   	push   %ebx
801031fd:	e8 ee 1e 00 00       	call   801050f0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80103202:	a1 a4 50 11 80       	mov    0x801150a4,%eax
80103207:	83 c4 10             	add    $0x10,%esp
8010320a:	85 c0                	test   %eax,%eax
8010320c:	74 05                	je     80103213 <ideintr+0x83>
    idestart(idequeue);
8010320e:	e8 1d fe ff ff       	call   80103030 <idestart>
    release(&idelock);
80103213:	83 ec 0c             	sub    $0xc,%esp
80103216:	68 c0 50 11 80       	push   $0x801150c0
8010321b:	e8 a0 2c 00 00       	call   80105ec0 <release>

  release(&idelock);
}
80103220:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103223:	5b                   	pop    %ebx
80103224:	5e                   	pop    %esi
80103225:	5f                   	pop    %edi
80103226:	5d                   	pop    %ebp
80103227:	c3                   	ret    
80103228:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010322f:	90                   	nop

80103230 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80103230:	55                   	push   %ebp
80103231:	89 e5                	mov    %esp,%ebp
80103233:	53                   	push   %ebx
80103234:	83 ec 10             	sub    $0x10,%esp
80103237:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010323a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010323d:	50                   	push   %eax
8010323e:	e8 bd 2a 00 00       	call   80105d00 <holdingsleep>
80103243:	83 c4 10             	add    $0x10,%esp
80103246:	85 c0                	test   %eax,%eax
80103248:	0f 84 c3 00 00 00    	je     80103311 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010324e:	8b 03                	mov    (%ebx),%eax
80103250:	83 e0 06             	and    $0x6,%eax
80103253:	83 f8 02             	cmp    $0x2,%eax
80103256:	0f 84 a8 00 00 00    	je     80103304 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010325c:	8b 53 04             	mov    0x4(%ebx),%edx
8010325f:	85 d2                	test   %edx,%edx
80103261:	74 0d                	je     80103270 <iderw+0x40>
80103263:	a1 a0 50 11 80       	mov    0x801150a0,%eax
80103268:	85 c0                	test   %eax,%eax
8010326a:	0f 84 87 00 00 00    	je     801032f7 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80103270:	83 ec 0c             	sub    $0xc,%esp
80103273:	68 c0 50 11 80       	push   $0x801150c0
80103278:	e8 a3 2c 00 00       	call   80105f20 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010327d:	a1 a4 50 11 80       	mov    0x801150a4,%eax
  b->qnext = 0;
80103282:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80103289:	83 c4 10             	add    $0x10,%esp
8010328c:	85 c0                	test   %eax,%eax
8010328e:	74 60                	je     801032f0 <iderw+0xc0>
80103290:	89 c2                	mov    %eax,%edx
80103292:	8b 40 58             	mov    0x58(%eax),%eax
80103295:	85 c0                	test   %eax,%eax
80103297:	75 f7                	jne    80103290 <iderw+0x60>
80103299:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
8010329c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
8010329e:	39 1d a4 50 11 80    	cmp    %ebx,0x801150a4
801032a4:	74 3a                	je     801032e0 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801032a6:	8b 03                	mov    (%ebx),%eax
801032a8:	83 e0 06             	and    $0x6,%eax
801032ab:	83 f8 02             	cmp    $0x2,%eax
801032ae:	74 1b                	je     801032cb <iderw+0x9b>
    sleep(b, &idelock);
801032b0:	83 ec 08             	sub    $0x8,%esp
801032b3:	68 c0 50 11 80       	push   $0x801150c0
801032b8:	53                   	push   %ebx
801032b9:	e8 72 1d 00 00       	call   80105030 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801032be:	8b 03                	mov    (%ebx),%eax
801032c0:	83 c4 10             	add    $0x10,%esp
801032c3:	83 e0 06             	and    $0x6,%eax
801032c6:	83 f8 02             	cmp    $0x2,%eax
801032c9:	75 e5                	jne    801032b0 <iderw+0x80>
  }


  release(&idelock);
801032cb:	c7 45 08 c0 50 11 80 	movl   $0x801150c0,0x8(%ebp)
}
801032d2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801032d5:	c9                   	leave  
  release(&idelock);
801032d6:	e9 e5 2b 00 00       	jmp    80105ec0 <release>
801032db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801032df:	90                   	nop
    idestart(b);
801032e0:	89 d8                	mov    %ebx,%eax
801032e2:	e8 49 fd ff ff       	call   80103030 <idestart>
801032e7:	eb bd                	jmp    801032a6 <iderw+0x76>
801032e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801032f0:	ba a4 50 11 80       	mov    $0x801150a4,%edx
801032f5:	eb a5                	jmp    8010329c <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
801032f7:	83 ec 0c             	sub    $0xc,%esp
801032fa:	68 7d 99 10 80       	push   $0x8010997d
801032ff:	e8 cc d1 ff ff       	call   801004d0 <panic>
    panic("iderw: nothing to do");
80103304:	83 ec 0c             	sub    $0xc,%esp
80103307:	68 68 99 10 80       	push   $0x80109968
8010330c:	e8 bf d1 ff ff       	call   801004d0 <panic>
    panic("iderw: buf not locked");
80103311:	83 ec 0c             	sub    $0xc,%esp
80103314:	68 52 99 10 80       	push   $0x80109952
80103319:	e8 b2 d1 ff ff       	call   801004d0 <panic>
8010331e:	66 90                	xchg   %ax,%ax

80103320 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80103320:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80103321:	c7 05 f4 50 11 80 00 	movl   $0xfec00000,0x801150f4
80103328:	00 c0 fe 
{
8010332b:	89 e5                	mov    %esp,%ebp
8010332d:	56                   	push   %esi
8010332e:	53                   	push   %ebx
  ioapic->reg = reg;
8010332f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80103336:	00 00 00 
  return ioapic->data;
80103339:	8b 15 f4 50 11 80    	mov    0x801150f4,%edx
8010333f:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
80103342:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80103348:	8b 0d f4 50 11 80    	mov    0x801150f4,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010334e:	0f b6 15 40 52 11 80 	movzbl 0x80115240,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80103355:	c1 ee 10             	shr    $0x10,%esi
80103358:	89 f0                	mov    %esi,%eax
8010335a:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
8010335d:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
80103360:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80103363:	39 c2                	cmp    %eax,%edx
80103365:	74 16                	je     8010337d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80103367:	83 ec 0c             	sub    $0xc,%esp
8010336a:	68 9c 99 10 80       	push   $0x8010999c
8010336f:	e8 7c d4 ff ff       	call   801007f0 <cprintf>
  ioapic->reg = reg;
80103374:	8b 0d f4 50 11 80    	mov    0x801150f4,%ecx
8010337a:	83 c4 10             	add    $0x10,%esp
8010337d:	83 c6 21             	add    $0x21,%esi
{
80103380:	ba 10 00 00 00       	mov    $0x10,%edx
80103385:	b8 20 00 00 00       	mov    $0x20,%eax
8010338a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ioapic->reg = reg;
80103390:	89 11                	mov    %edx,(%ecx)

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80103392:	89 c3                	mov    %eax,%ebx
  ioapic->data = data;
80103394:	8b 0d f4 50 11 80    	mov    0x801150f4,%ecx
  for(i = 0; i <= maxintr; i++){
8010339a:	83 c0 01             	add    $0x1,%eax
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
8010339d:	81 cb 00 00 01 00    	or     $0x10000,%ebx
  ioapic->data = data;
801033a3:	89 59 10             	mov    %ebx,0x10(%ecx)
  ioapic->reg = reg;
801033a6:	8d 5a 01             	lea    0x1(%edx),%ebx
  for(i = 0; i <= maxintr; i++){
801033a9:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
801033ac:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
801033ae:	8b 0d f4 50 11 80    	mov    0x801150f4,%ecx
801033b4:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
801033bb:	39 f0                	cmp    %esi,%eax
801033bd:	75 d1                	jne    80103390 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801033bf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801033c2:	5b                   	pop    %ebx
801033c3:	5e                   	pop    %esi
801033c4:	5d                   	pop    %ebp
801033c5:	c3                   	ret    
801033c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033cd:	8d 76 00             	lea    0x0(%esi),%esi

801033d0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801033d0:	55                   	push   %ebp
  ioapic->reg = reg;
801033d1:	8b 0d f4 50 11 80    	mov    0x801150f4,%ecx
{
801033d7:	89 e5                	mov    %esp,%ebp
801033d9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801033dc:	8d 50 20             	lea    0x20(%eax),%edx
801033df:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801033e3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801033e5:	8b 0d f4 50 11 80    	mov    0x801150f4,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801033eb:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801033ee:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801033f1:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801033f4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801033f6:	a1 f4 50 11 80       	mov    0x801150f4,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801033fb:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801033fe:	89 50 10             	mov    %edx,0x10(%eax)
}
80103401:	5d                   	pop    %ebp
80103402:	c3                   	ret    
80103403:	66 90                	xchg   %ax,%ax
80103405:	66 90                	xchg   %ax,%ax
80103407:	66 90                	xchg   %ax,%ax
80103409:	66 90                	xchg   %ax,%ax
8010340b:	66 90                	xchg   %ax,%ax
8010340d:	66 90                	xchg   %ax,%ax
8010340f:	90                   	nop

80103410 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80103410:	55                   	push   %ebp
80103411:	89 e5                	mov    %esp,%ebp
80103413:	53                   	push   %ebx
80103414:	83 ec 04             	sub    $0x4,%esp
80103417:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010341a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80103420:	75 76                	jne    80103498 <kfree+0x88>
80103422:	81 fb 70 c1 34 80    	cmp    $0x8034c170,%ebx
80103428:	72 6e                	jb     80103498 <kfree+0x88>
8010342a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80103430:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80103435:	77 61                	ja     80103498 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80103437:	83 ec 04             	sub    $0x4,%esp
8010343a:	68 00 10 00 00       	push   $0x1000
8010343f:	6a 01                	push   $0x1
80103441:	53                   	push   %ebx
80103442:	e8 c9 2c 00 00       	call   80106110 <memset>

  if(kmem.use_lock)
80103447:	8b 15 34 51 11 80    	mov    0x80115134,%edx
8010344d:	83 c4 10             	add    $0x10,%esp
80103450:	85 d2                	test   %edx,%edx
80103452:	75 1c                	jne    80103470 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80103454:	a1 38 51 11 80       	mov    0x80115138,%eax
80103459:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010345b:	a1 34 51 11 80       	mov    0x80115134,%eax
  kmem.freelist = r;
80103460:	89 1d 38 51 11 80    	mov    %ebx,0x80115138
  if(kmem.use_lock)
80103466:	85 c0                	test   %eax,%eax
80103468:	75 1e                	jne    80103488 <kfree+0x78>
    release(&kmem.lock);
}
8010346a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010346d:	c9                   	leave  
8010346e:	c3                   	ret    
8010346f:	90                   	nop
    acquire(&kmem.lock);
80103470:	83 ec 0c             	sub    $0xc,%esp
80103473:	68 00 51 11 80       	push   $0x80115100
80103478:	e8 a3 2a 00 00       	call   80105f20 <acquire>
8010347d:	83 c4 10             	add    $0x10,%esp
80103480:	eb d2                	jmp    80103454 <kfree+0x44>
80103482:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80103488:	c7 45 08 00 51 11 80 	movl   $0x80115100,0x8(%ebp)
}
8010348f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103492:	c9                   	leave  
    release(&kmem.lock);
80103493:	e9 28 2a 00 00       	jmp    80105ec0 <release>
    panic("kfree");
80103498:	83 ec 0c             	sub    $0xc,%esp
8010349b:	68 ce 99 10 80       	push   $0x801099ce
801034a0:	e8 2b d0 ff ff       	call   801004d0 <panic>
801034a5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801034ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801034b0 <freerange>:
{
801034b0:	55                   	push   %ebp
801034b1:	89 e5                	mov    %esp,%ebp
801034b3:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
801034b4:	8b 45 08             	mov    0x8(%ebp),%eax
{
801034b7:	8b 75 0c             	mov    0xc(%ebp),%esi
801034ba:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801034bb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801034c1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801034c7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801034cd:	39 de                	cmp    %ebx,%esi
801034cf:	72 23                	jb     801034f4 <freerange+0x44>
801034d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801034d8:	83 ec 0c             	sub    $0xc,%esp
801034db:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801034e1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801034e7:	50                   	push   %eax
801034e8:	e8 23 ff ff ff       	call   80103410 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801034ed:	83 c4 10             	add    $0x10,%esp
801034f0:	39 f3                	cmp    %esi,%ebx
801034f2:	76 e4                	jbe    801034d8 <freerange+0x28>
}
801034f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801034f7:	5b                   	pop    %ebx
801034f8:	5e                   	pop    %esi
801034f9:	5d                   	pop    %ebp
801034fa:	c3                   	ret    
801034fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801034ff:	90                   	nop

80103500 <kinit2>:
{
80103500:	55                   	push   %ebp
80103501:	89 e5                	mov    %esp,%ebp
80103503:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80103504:	8b 45 08             	mov    0x8(%ebp),%eax
{
80103507:	8b 75 0c             	mov    0xc(%ebp),%esi
8010350a:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
8010350b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80103511:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103517:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010351d:	39 de                	cmp    %ebx,%esi
8010351f:	72 23                	jb     80103544 <kinit2+0x44>
80103521:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80103528:	83 ec 0c             	sub    $0xc,%esp
8010352b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103531:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80103537:	50                   	push   %eax
80103538:	e8 d3 fe ff ff       	call   80103410 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010353d:	83 c4 10             	add    $0x10,%esp
80103540:	39 de                	cmp    %ebx,%esi
80103542:	73 e4                	jae    80103528 <kinit2+0x28>
  kmem.use_lock = 1;
80103544:	c7 05 34 51 11 80 01 	movl   $0x1,0x80115134
8010354b:	00 00 00 
}
8010354e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103551:	5b                   	pop    %ebx
80103552:	5e                   	pop    %esi
80103553:	5d                   	pop    %ebp
80103554:	c3                   	ret    
80103555:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010355c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103560 <kinit1>:
{
80103560:	55                   	push   %ebp
80103561:	89 e5                	mov    %esp,%ebp
80103563:	56                   	push   %esi
80103564:	53                   	push   %ebx
80103565:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80103568:	83 ec 08             	sub    $0x8,%esp
8010356b:	68 d4 99 10 80       	push   $0x801099d4
80103570:	68 00 51 11 80       	push   $0x80115100
80103575:	e8 d6 27 00 00       	call   80105d50 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010357a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010357d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80103580:	c7 05 34 51 11 80 00 	movl   $0x0,0x80115134
80103587:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010358a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80103590:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103596:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010359c:	39 de                	cmp    %ebx,%esi
8010359e:	72 1c                	jb     801035bc <kinit1+0x5c>
    kfree(p);
801035a0:	83 ec 0c             	sub    $0xc,%esp
801035a3:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801035a9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801035af:	50                   	push   %eax
801035b0:	e8 5b fe ff ff       	call   80103410 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801035b5:	83 c4 10             	add    $0x10,%esp
801035b8:	39 de                	cmp    %ebx,%esi
801035ba:	73 e4                	jae    801035a0 <kinit1+0x40>
}
801035bc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801035bf:	5b                   	pop    %ebx
801035c0:	5e                   	pop    %esi
801035c1:	5d                   	pop    %ebp
801035c2:	c3                   	ret    
801035c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801035ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801035d0 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
801035d0:	a1 34 51 11 80       	mov    0x80115134,%eax
801035d5:	85 c0                	test   %eax,%eax
801035d7:	75 1f                	jne    801035f8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
801035d9:	a1 38 51 11 80       	mov    0x80115138,%eax
  if(r)
801035de:	85 c0                	test   %eax,%eax
801035e0:	74 0e                	je     801035f0 <kalloc+0x20>
    kmem.freelist = r->next;
801035e2:	8b 10                	mov    (%eax),%edx
801035e4:	89 15 38 51 11 80    	mov    %edx,0x80115138
  if(kmem.use_lock)
801035ea:	c3                   	ret    
801035eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801035ef:	90                   	nop
    release(&kmem.lock);
  return (char*)r;
}
801035f0:	c3                   	ret    
801035f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
801035f8:	55                   	push   %ebp
801035f9:	89 e5                	mov    %esp,%ebp
801035fb:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
801035fe:	68 00 51 11 80       	push   $0x80115100
80103603:	e8 18 29 00 00       	call   80105f20 <acquire>
  r = kmem.freelist;
80103608:	a1 38 51 11 80       	mov    0x80115138,%eax
  if(kmem.use_lock)
8010360d:	8b 15 34 51 11 80    	mov    0x80115134,%edx
  if(r)
80103613:	83 c4 10             	add    $0x10,%esp
80103616:	85 c0                	test   %eax,%eax
80103618:	74 08                	je     80103622 <kalloc+0x52>
    kmem.freelist = r->next;
8010361a:	8b 08                	mov    (%eax),%ecx
8010361c:	89 0d 38 51 11 80    	mov    %ecx,0x80115138
  if(kmem.use_lock)
80103622:	85 d2                	test   %edx,%edx
80103624:	74 16                	je     8010363c <kalloc+0x6c>
    release(&kmem.lock);
80103626:	83 ec 0c             	sub    $0xc,%esp
80103629:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010362c:	68 00 51 11 80       	push   $0x80115100
80103631:	e8 8a 28 00 00       	call   80105ec0 <release>
  return (char*)r;
80103636:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80103639:	83 c4 10             	add    $0x10,%esp
}
8010363c:	c9                   	leave  
8010363d:	c3                   	ret    
8010363e:	66 90                	xchg   %ax,%ax

80103640 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103640:	ba 64 00 00 00       	mov    $0x64,%edx
80103645:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80103646:	a8 01                	test   $0x1,%al
80103648:	0f 84 c2 00 00 00    	je     80103710 <kbdgetc+0xd0>
{
8010364e:	55                   	push   %ebp
8010364f:	ba 60 00 00 00       	mov    $0x60,%edx
80103654:	89 e5                	mov    %esp,%ebp
80103656:	53                   	push   %ebx
80103657:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80103658:	8b 1d 3c 51 11 80    	mov    0x8011513c,%ebx
  data = inb(KBDATAP);
8010365e:	0f b6 c8             	movzbl %al,%ecx
  if(data == 0xE0){
80103661:	3c e0                	cmp    $0xe0,%al
80103663:	74 5b                	je     801036c0 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80103665:	89 da                	mov    %ebx,%edx
80103667:	83 e2 40             	and    $0x40,%edx
  } else if(data & 0x80){
8010366a:	84 c0                	test   %al,%al
8010366c:	78 62                	js     801036d0 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
8010366e:	85 d2                	test   %edx,%edx
80103670:	74 09                	je     8010367b <kbdgetc+0x3b>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80103672:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80103675:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80103678:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
8010367b:	0f b6 91 00 9b 10 80 	movzbl -0x7fef6500(%ecx),%edx
  shift ^= togglecode[data];
80103682:	0f b6 81 00 9a 10 80 	movzbl -0x7fef6600(%ecx),%eax
  shift |= shiftcode[data];
80103689:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
8010368b:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010368d:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
8010368f:	89 15 3c 51 11 80    	mov    %edx,0x8011513c
  c = charcode[shift & (CTL | SHIFT)][data];
80103695:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80103698:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010369b:	8b 04 85 e0 99 10 80 	mov    -0x7fef6620(,%eax,4),%eax
801036a2:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
801036a6:	74 0b                	je     801036b3 <kbdgetc+0x73>
    if('a' <= c && c <= 'z')
801036a8:	8d 50 9f             	lea    -0x61(%eax),%edx
801036ab:	83 fa 19             	cmp    $0x19,%edx
801036ae:	77 48                	ja     801036f8 <kbdgetc+0xb8>
      c += 'A' - 'a';
801036b0:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801036b3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801036b6:	c9                   	leave  
801036b7:	c3                   	ret    
801036b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036bf:	90                   	nop
    shift |= E0ESC;
801036c0:	83 cb 40             	or     $0x40,%ebx
    return 0;
801036c3:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
801036c5:	89 1d 3c 51 11 80    	mov    %ebx,0x8011513c
}
801036cb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801036ce:	c9                   	leave  
801036cf:	c3                   	ret    
    data = (shift & E0ESC ? data : data & 0x7F);
801036d0:	83 e0 7f             	and    $0x7f,%eax
801036d3:	85 d2                	test   %edx,%edx
801036d5:	0f 44 c8             	cmove  %eax,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
801036d8:	0f b6 81 00 9b 10 80 	movzbl -0x7fef6500(%ecx),%eax
801036df:	83 c8 40             	or     $0x40,%eax
801036e2:	0f b6 c0             	movzbl %al,%eax
801036e5:	f7 d0                	not    %eax
801036e7:	21 d8                	and    %ebx,%eax
}
801036e9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    shift &= ~(shiftcode[data] | E0ESC);
801036ec:	a3 3c 51 11 80       	mov    %eax,0x8011513c
    return 0;
801036f1:	31 c0                	xor    %eax,%eax
}
801036f3:	c9                   	leave  
801036f4:	c3                   	ret    
801036f5:	8d 76 00             	lea    0x0(%esi),%esi
    else if('A' <= c && c <= 'Z')
801036f8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801036fb:	8d 50 20             	lea    0x20(%eax),%edx
}
801036fe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103701:	c9                   	leave  
      c += 'a' - 'A';
80103702:	83 f9 1a             	cmp    $0x1a,%ecx
80103705:	0f 42 c2             	cmovb  %edx,%eax
}
80103708:	c3                   	ret    
80103709:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80103710:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103715:	c3                   	ret    
80103716:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010371d:	8d 76 00             	lea    0x0(%esi),%esi

80103720 <kbdintr>:

void
kbdintr(void)
{
80103720:	55                   	push   %ebp
80103721:	89 e5                	mov    %esp,%ebp
80103723:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80103726:	68 40 36 10 80       	push   $0x80103640
8010372b:	e8 10 d8 ff ff       	call   80100f40 <consoleintr>
}
80103730:	83 c4 10             	add    $0x10,%esp
80103733:	c9                   	leave  
80103734:	c3                   	ret    
80103735:	66 90                	xchg   %ax,%ax
80103737:	66 90                	xchg   %ax,%ax
80103739:	66 90                	xchg   %ax,%ax
8010373b:	66 90                	xchg   %ax,%ax
8010373d:	66 90                	xchg   %ax,%ax
8010373f:	90                   	nop

80103740 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80103740:	a1 40 51 11 80       	mov    0x80115140,%eax
80103745:	85 c0                	test   %eax,%eax
80103747:	0f 84 cb 00 00 00    	je     80103818 <lapicinit+0xd8>
  lapic[index] = value;
8010374d:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80103754:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103757:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010375a:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80103761:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103764:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103767:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
8010376e:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80103771:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103774:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010377b:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
8010377e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103781:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80103788:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010378b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010378e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80103795:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80103798:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010379b:	8b 50 30             	mov    0x30(%eax),%edx
8010379e:	c1 ea 10             	shr    $0x10,%edx
801037a1:	81 e2 fc 00 00 00    	and    $0xfc,%edx
801037a7:	75 77                	jne    80103820 <lapicinit+0xe0>
  lapic[index] = value;
801037a9:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801037b0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801037b3:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801037b6:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801037bd:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801037c0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801037c3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801037ca:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801037cd:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801037d0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801037d7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801037da:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801037dd:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801037e4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801037e7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801037ea:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801037f1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801037f4:	8b 50 20             	mov    0x20(%eax),%edx
801037f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801037fe:	66 90                	xchg   %ax,%ax
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80103800:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80103806:	80 e6 10             	and    $0x10,%dh
80103809:	75 f5                	jne    80103800 <lapicinit+0xc0>
  lapic[index] = value;
8010380b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80103812:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103815:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80103818:	c3                   	ret    
80103819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
80103820:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80103827:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010382a:	8b 50 20             	mov    0x20(%eax),%edx
}
8010382d:	e9 77 ff ff ff       	jmp    801037a9 <lapicinit+0x69>
80103832:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103840 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80103840:	a1 40 51 11 80       	mov    0x80115140,%eax
80103845:	85 c0                	test   %eax,%eax
80103847:	74 07                	je     80103850 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
80103849:	8b 40 20             	mov    0x20(%eax),%eax
8010384c:	c1 e8 18             	shr    $0x18,%eax
8010384f:	c3                   	ret    
    return 0;
80103850:	31 c0                	xor    %eax,%eax
}
80103852:	c3                   	ret    
80103853:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010385a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103860 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80103860:	a1 40 51 11 80       	mov    0x80115140,%eax
80103865:	85 c0                	test   %eax,%eax
80103867:	74 0d                	je     80103876 <lapiceoi+0x16>
  lapic[index] = value;
80103869:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80103870:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103873:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80103876:	c3                   	ret    
80103877:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010387e:	66 90                	xchg   %ax,%ax

80103880 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80103880:	c3                   	ret    
80103881:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103888:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010388f:	90                   	nop

80103890 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80103890:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103891:	b8 0f 00 00 00       	mov    $0xf,%eax
80103896:	ba 70 00 00 00       	mov    $0x70,%edx
8010389b:	89 e5                	mov    %esp,%ebp
8010389d:	53                   	push   %ebx
8010389e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801038a1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801038a4:	ee                   	out    %al,(%dx)
801038a5:	b8 0a 00 00 00       	mov    $0xa,%eax
801038aa:	ba 71 00 00 00       	mov    $0x71,%edx
801038af:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
801038b0:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
801038b2:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
801038b5:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
801038bb:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
801038bd:	c1 e9 0c             	shr    $0xc,%ecx
  lapicw(ICRHI, apicid<<24);
801038c0:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
801038c2:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
801038c5:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
801038c8:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
801038ce:	a1 40 51 11 80       	mov    0x80115140,%eax
801038d3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801038d9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801038dc:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801038e3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801038e6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801038e9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801038f0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801038f3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801038f6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801038fc:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801038ff:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103905:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80103908:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010390e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103911:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103917:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
8010391a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010391d:	c9                   	leave  
8010391e:	c3                   	ret    
8010391f:	90                   	nop

80103920 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80103920:	55                   	push   %ebp
80103921:	b8 0b 00 00 00       	mov    $0xb,%eax
80103926:	ba 70 00 00 00       	mov    $0x70,%edx
8010392b:	89 e5                	mov    %esp,%ebp
8010392d:	57                   	push   %edi
8010392e:	56                   	push   %esi
8010392f:	53                   	push   %ebx
80103930:	83 ec 4c             	sub    $0x4c,%esp
80103933:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103934:	ba 71 00 00 00       	mov    $0x71,%edx
80103939:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
8010393a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010393d:	bb 70 00 00 00       	mov    $0x70,%ebx
80103942:	88 45 b3             	mov    %al,-0x4d(%ebp)
80103945:	8d 76 00             	lea    0x0(%esi),%esi
80103948:	31 c0                	xor    %eax,%eax
8010394a:	89 da                	mov    %ebx,%edx
8010394c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010394d:	b9 71 00 00 00       	mov    $0x71,%ecx
80103952:	89 ca                	mov    %ecx,%edx
80103954:	ec                   	in     (%dx),%al
80103955:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103958:	89 da                	mov    %ebx,%edx
8010395a:	b8 02 00 00 00       	mov    $0x2,%eax
8010395f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103960:	89 ca                	mov    %ecx,%edx
80103962:	ec                   	in     (%dx),%al
80103963:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103966:	89 da                	mov    %ebx,%edx
80103968:	b8 04 00 00 00       	mov    $0x4,%eax
8010396d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010396e:	89 ca                	mov    %ecx,%edx
80103970:	ec                   	in     (%dx),%al
80103971:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103974:	89 da                	mov    %ebx,%edx
80103976:	b8 07 00 00 00       	mov    $0x7,%eax
8010397b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010397c:	89 ca                	mov    %ecx,%edx
8010397e:	ec                   	in     (%dx),%al
8010397f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103982:	89 da                	mov    %ebx,%edx
80103984:	b8 08 00 00 00       	mov    $0x8,%eax
80103989:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010398a:	89 ca                	mov    %ecx,%edx
8010398c:	ec                   	in     (%dx),%al
8010398d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010398f:	89 da                	mov    %ebx,%edx
80103991:	b8 09 00 00 00       	mov    $0x9,%eax
80103996:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103997:	89 ca                	mov    %ecx,%edx
80103999:	ec                   	in     (%dx),%al
8010399a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010399c:	89 da                	mov    %ebx,%edx
8010399e:	b8 0a 00 00 00       	mov    $0xa,%eax
801039a3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801039a4:	89 ca                	mov    %ecx,%edx
801039a6:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
801039a7:	84 c0                	test   %al,%al
801039a9:	78 9d                	js     80103948 <cmostime+0x28>
  return inb(CMOS_RETURN);
801039ab:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
801039af:	89 fa                	mov    %edi,%edx
801039b1:	0f b6 fa             	movzbl %dl,%edi
801039b4:	89 f2                	mov    %esi,%edx
801039b6:	89 45 b8             	mov    %eax,-0x48(%ebp)
801039b9:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
801039bd:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801039c0:	89 da                	mov    %ebx,%edx
801039c2:	89 7d c8             	mov    %edi,-0x38(%ebp)
801039c5:	89 45 bc             	mov    %eax,-0x44(%ebp)
801039c8:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
801039cc:	89 75 cc             	mov    %esi,-0x34(%ebp)
801039cf:	89 45 c0             	mov    %eax,-0x40(%ebp)
801039d2:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
801039d6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
801039d9:	31 c0                	xor    %eax,%eax
801039db:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801039dc:	89 ca                	mov    %ecx,%edx
801039de:	ec                   	in     (%dx),%al
801039df:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801039e2:	89 da                	mov    %ebx,%edx
801039e4:	89 45 d0             	mov    %eax,-0x30(%ebp)
801039e7:	b8 02 00 00 00       	mov    $0x2,%eax
801039ec:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801039ed:	89 ca                	mov    %ecx,%edx
801039ef:	ec                   	in     (%dx),%al
801039f0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801039f3:	89 da                	mov    %ebx,%edx
801039f5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801039f8:	b8 04 00 00 00       	mov    $0x4,%eax
801039fd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801039fe:	89 ca                	mov    %ecx,%edx
80103a00:	ec                   	in     (%dx),%al
80103a01:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103a04:	89 da                	mov    %ebx,%edx
80103a06:	89 45 d8             	mov    %eax,-0x28(%ebp)
80103a09:	b8 07 00 00 00       	mov    $0x7,%eax
80103a0e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103a0f:	89 ca                	mov    %ecx,%edx
80103a11:	ec                   	in     (%dx),%al
80103a12:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103a15:	89 da                	mov    %ebx,%edx
80103a17:	89 45 dc             	mov    %eax,-0x24(%ebp)
80103a1a:	b8 08 00 00 00       	mov    $0x8,%eax
80103a1f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103a20:	89 ca                	mov    %ecx,%edx
80103a22:	ec                   	in     (%dx),%al
80103a23:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103a26:	89 da                	mov    %ebx,%edx
80103a28:	89 45 e0             	mov    %eax,-0x20(%ebp)
80103a2b:	b8 09 00 00 00       	mov    $0x9,%eax
80103a30:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103a31:	89 ca                	mov    %ecx,%edx
80103a33:	ec                   	in     (%dx),%al
80103a34:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80103a37:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80103a3a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80103a3d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80103a40:	6a 18                	push   $0x18
80103a42:	50                   	push   %eax
80103a43:	8d 45 b8             	lea    -0x48(%ebp),%eax
80103a46:	50                   	push   %eax
80103a47:	e8 14 27 00 00       	call   80106160 <memcmp>
80103a4c:	83 c4 10             	add    $0x10,%esp
80103a4f:	85 c0                	test   %eax,%eax
80103a51:	0f 85 f1 fe ff ff    	jne    80103948 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80103a57:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80103a5b:	75 78                	jne    80103ad5 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80103a5d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80103a60:	89 c2                	mov    %eax,%edx
80103a62:	83 e0 0f             	and    $0xf,%eax
80103a65:	c1 ea 04             	shr    $0x4,%edx
80103a68:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103a6b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103a6e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80103a71:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103a74:	89 c2                	mov    %eax,%edx
80103a76:	83 e0 0f             	and    $0xf,%eax
80103a79:	c1 ea 04             	shr    $0x4,%edx
80103a7c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103a7f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103a82:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80103a85:	8b 45 c0             	mov    -0x40(%ebp),%eax
80103a88:	89 c2                	mov    %eax,%edx
80103a8a:	83 e0 0f             	and    $0xf,%eax
80103a8d:	c1 ea 04             	shr    $0x4,%edx
80103a90:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103a93:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103a96:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80103a99:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80103a9c:	89 c2                	mov    %eax,%edx
80103a9e:	83 e0 0f             	and    $0xf,%eax
80103aa1:	c1 ea 04             	shr    $0x4,%edx
80103aa4:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103aa7:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103aaa:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80103aad:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103ab0:	89 c2                	mov    %eax,%edx
80103ab2:	83 e0 0f             	and    $0xf,%eax
80103ab5:	c1 ea 04             	shr    $0x4,%edx
80103ab8:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103abb:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103abe:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80103ac1:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103ac4:	89 c2                	mov    %eax,%edx
80103ac6:	83 e0 0f             	and    $0xf,%eax
80103ac9:	c1 ea 04             	shr    $0x4,%edx
80103acc:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103acf:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103ad2:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80103ad5:	8b 75 08             	mov    0x8(%ebp),%esi
80103ad8:	8b 45 b8             	mov    -0x48(%ebp),%eax
80103adb:	89 06                	mov    %eax,(%esi)
80103add:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103ae0:	89 46 04             	mov    %eax,0x4(%esi)
80103ae3:	8b 45 c0             	mov    -0x40(%ebp),%eax
80103ae6:	89 46 08             	mov    %eax,0x8(%esi)
80103ae9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80103aec:	89 46 0c             	mov    %eax,0xc(%esi)
80103aef:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103af2:	89 46 10             	mov    %eax,0x10(%esi)
80103af5:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103af8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80103afb:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80103b02:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b05:	5b                   	pop    %ebx
80103b06:	5e                   	pop    %esi
80103b07:	5f                   	pop    %edi
80103b08:	5d                   	pop    %ebp
80103b09:	c3                   	ret    
80103b0a:	66 90                	xchg   %ax,%ax
80103b0c:	66 90                	xchg   %ax,%ax
80103b0e:	66 90                	xchg   %ax,%ax

80103b10 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103b10:	8b 0d a8 51 11 80    	mov    0x801151a8,%ecx
80103b16:	85 c9                	test   %ecx,%ecx
80103b18:	0f 8e 8a 00 00 00    	jle    80103ba8 <install_trans+0x98>
{
80103b1e:	55                   	push   %ebp
80103b1f:	89 e5                	mov    %esp,%ebp
80103b21:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80103b22:	31 ff                	xor    %edi,%edi
{
80103b24:	56                   	push   %esi
80103b25:	53                   	push   %ebx
80103b26:	83 ec 0c             	sub    $0xc,%esp
80103b29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80103b30:	a1 94 51 11 80       	mov    0x80115194,%eax
80103b35:	83 ec 08             	sub    $0x8,%esp
80103b38:	01 f8                	add    %edi,%eax
80103b3a:	83 c0 01             	add    $0x1,%eax
80103b3d:	50                   	push   %eax
80103b3e:	ff 35 a4 51 11 80    	push   0x801151a4
80103b44:	e8 87 c5 ff ff       	call   801000d0 <bread>
80103b49:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80103b4b:	58                   	pop    %eax
80103b4c:	5a                   	pop    %edx
80103b4d:	ff 34 bd ac 51 11 80 	push   -0x7feeae54(,%edi,4)
80103b54:	ff 35 a4 51 11 80    	push   0x801151a4
  for (tail = 0; tail < log.lh.n; tail++) {
80103b5a:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80103b5d:	e8 6e c5 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103b62:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80103b65:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103b67:	8d 46 5c             	lea    0x5c(%esi),%eax
80103b6a:	68 00 02 00 00       	push   $0x200
80103b6f:	50                   	push   %eax
80103b70:	8d 43 5c             	lea    0x5c(%ebx),%eax
80103b73:	50                   	push   %eax
80103b74:	e8 37 26 00 00       	call   801061b0 <memmove>
    bwrite(dbuf);  // write dst to disk
80103b79:	89 1c 24             	mov    %ebx,(%esp)
80103b7c:	e8 2f c6 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80103b81:	89 34 24             	mov    %esi,(%esp)
80103b84:	e8 67 c6 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80103b89:	89 1c 24             	mov    %ebx,(%esp)
80103b8c:	e8 5f c6 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103b91:	83 c4 10             	add    $0x10,%esp
80103b94:	39 3d a8 51 11 80    	cmp    %edi,0x801151a8
80103b9a:	7f 94                	jg     80103b30 <install_trans+0x20>
  }
}
80103b9c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b9f:	5b                   	pop    %ebx
80103ba0:	5e                   	pop    %esi
80103ba1:	5f                   	pop    %edi
80103ba2:	5d                   	pop    %ebp
80103ba3:	c3                   	ret    
80103ba4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103ba8:	c3                   	ret    
80103ba9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103bb0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80103bb0:	55                   	push   %ebp
80103bb1:	89 e5                	mov    %esp,%ebp
80103bb3:	53                   	push   %ebx
80103bb4:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80103bb7:	ff 35 94 51 11 80    	push   0x80115194
80103bbd:	ff 35 a4 51 11 80    	push   0x801151a4
80103bc3:	e8 08 c5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80103bc8:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80103bcb:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80103bcd:	a1 a8 51 11 80       	mov    0x801151a8,%eax
80103bd2:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80103bd5:	85 c0                	test   %eax,%eax
80103bd7:	7e 19                	jle    80103bf2 <write_head+0x42>
80103bd9:	31 d2                	xor    %edx,%edx
80103bdb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103bdf:	90                   	nop
    hb->block[i] = log.lh.block[i];
80103be0:	8b 0c 95 ac 51 11 80 	mov    -0x7feeae54(,%edx,4),%ecx
80103be7:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80103beb:	83 c2 01             	add    $0x1,%edx
80103bee:	39 d0                	cmp    %edx,%eax
80103bf0:	75 ee                	jne    80103be0 <write_head+0x30>
  }
  bwrite(buf);
80103bf2:	83 ec 0c             	sub    $0xc,%esp
80103bf5:	53                   	push   %ebx
80103bf6:	e8 b5 c5 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
80103bfb:	89 1c 24             	mov    %ebx,(%esp)
80103bfe:	e8 ed c5 ff ff       	call   801001f0 <brelse>
}
80103c03:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103c06:	83 c4 10             	add    $0x10,%esp
80103c09:	c9                   	leave  
80103c0a:	c3                   	ret    
80103c0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103c0f:	90                   	nop

80103c10 <initlog>:
{
80103c10:	55                   	push   %ebp
80103c11:	89 e5                	mov    %esp,%ebp
80103c13:	53                   	push   %ebx
80103c14:	83 ec 2c             	sub    $0x2c,%esp
80103c17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80103c1a:	68 00 9c 10 80       	push   $0x80109c00
80103c1f:	68 60 51 11 80       	push   $0x80115160
80103c24:	e8 27 21 00 00       	call   80105d50 <initlock>
  readsb(dev, &sb);
80103c29:	58                   	pop    %eax
80103c2a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80103c2d:	5a                   	pop    %edx
80103c2e:	50                   	push   %eax
80103c2f:	53                   	push   %ebx
80103c30:	e8 3b e8 ff ff       	call   80102470 <readsb>
  log.start = sb.logstart;
80103c35:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80103c38:	59                   	pop    %ecx
  log.dev = dev;
80103c39:	89 1d a4 51 11 80    	mov    %ebx,0x801151a4
  log.size = sb.nlog;
80103c3f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80103c42:	a3 94 51 11 80       	mov    %eax,0x80115194
  log.size = sb.nlog;
80103c47:	89 15 98 51 11 80    	mov    %edx,0x80115198
  struct buf *buf = bread(log.dev, log.start);
80103c4d:	5a                   	pop    %edx
80103c4e:	50                   	push   %eax
80103c4f:	53                   	push   %ebx
80103c50:	e8 7b c4 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80103c55:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80103c58:	8b 58 5c             	mov    0x5c(%eax),%ebx
80103c5b:	89 1d a8 51 11 80    	mov    %ebx,0x801151a8
  for (i = 0; i < log.lh.n; i++) {
80103c61:	85 db                	test   %ebx,%ebx
80103c63:	7e 1d                	jle    80103c82 <initlog+0x72>
80103c65:	31 d2                	xor    %edx,%edx
80103c67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c6e:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80103c70:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80103c74:	89 0c 95 ac 51 11 80 	mov    %ecx,-0x7feeae54(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80103c7b:	83 c2 01             	add    $0x1,%edx
80103c7e:	39 d3                	cmp    %edx,%ebx
80103c80:	75 ee                	jne    80103c70 <initlog+0x60>
  brelse(buf);
80103c82:	83 ec 0c             	sub    $0xc,%esp
80103c85:	50                   	push   %eax
80103c86:	e8 65 c5 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80103c8b:	e8 80 fe ff ff       	call   80103b10 <install_trans>
  log.lh.n = 0;
80103c90:	c7 05 a8 51 11 80 00 	movl   $0x0,0x801151a8
80103c97:	00 00 00 
  write_head(); // clear the log
80103c9a:	e8 11 ff ff ff       	call   80103bb0 <write_head>
}
80103c9f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ca2:	83 c4 10             	add    $0x10,%esp
80103ca5:	c9                   	leave  
80103ca6:	c3                   	ret    
80103ca7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103cae:	66 90                	xchg   %ax,%ax

80103cb0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80103cb0:	55                   	push   %ebp
80103cb1:	89 e5                	mov    %esp,%ebp
80103cb3:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80103cb6:	68 60 51 11 80       	push   $0x80115160
80103cbb:	e8 60 22 00 00       	call   80105f20 <acquire>
80103cc0:	83 c4 10             	add    $0x10,%esp
80103cc3:	eb 18                	jmp    80103cdd <begin_op+0x2d>
80103cc5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80103cc8:	83 ec 08             	sub    $0x8,%esp
80103ccb:	68 60 51 11 80       	push   $0x80115160
80103cd0:	68 60 51 11 80       	push   $0x80115160
80103cd5:	e8 56 13 00 00       	call   80105030 <sleep>
80103cda:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80103cdd:	a1 a0 51 11 80       	mov    0x801151a0,%eax
80103ce2:	85 c0                	test   %eax,%eax
80103ce4:	75 e2                	jne    80103cc8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80103ce6:	a1 9c 51 11 80       	mov    0x8011519c,%eax
80103ceb:	8b 15 a8 51 11 80    	mov    0x801151a8,%edx
80103cf1:	83 c0 01             	add    $0x1,%eax
80103cf4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80103cf7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80103cfa:	83 fa 1e             	cmp    $0x1e,%edx
80103cfd:	7f c9                	jg     80103cc8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80103cff:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80103d02:	a3 9c 51 11 80       	mov    %eax,0x8011519c
      release(&log.lock);
80103d07:	68 60 51 11 80       	push   $0x80115160
80103d0c:	e8 af 21 00 00       	call   80105ec0 <release>
      break;
    }
  }
}
80103d11:	83 c4 10             	add    $0x10,%esp
80103d14:	c9                   	leave  
80103d15:	c3                   	ret    
80103d16:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d1d:	8d 76 00             	lea    0x0(%esi),%esi

80103d20 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80103d20:	55                   	push   %ebp
80103d21:	89 e5                	mov    %esp,%ebp
80103d23:	57                   	push   %edi
80103d24:	56                   	push   %esi
80103d25:	53                   	push   %ebx
80103d26:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80103d29:	68 60 51 11 80       	push   $0x80115160
80103d2e:	e8 ed 21 00 00       	call   80105f20 <acquire>
  log.outstanding -= 1;
80103d33:	a1 9c 51 11 80       	mov    0x8011519c,%eax
  if(log.committing)
80103d38:	8b 35 a0 51 11 80    	mov    0x801151a0,%esi
80103d3e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80103d41:	8d 58 ff             	lea    -0x1(%eax),%ebx
80103d44:	89 1d 9c 51 11 80    	mov    %ebx,0x8011519c
  if(log.committing)
80103d4a:	85 f6                	test   %esi,%esi
80103d4c:	0f 85 22 01 00 00    	jne    80103e74 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80103d52:	85 db                	test   %ebx,%ebx
80103d54:	0f 85 f6 00 00 00    	jne    80103e50 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
80103d5a:	c7 05 a0 51 11 80 01 	movl   $0x1,0x801151a0
80103d61:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80103d64:	83 ec 0c             	sub    $0xc,%esp
80103d67:	68 60 51 11 80       	push   $0x80115160
80103d6c:	e8 4f 21 00 00       	call   80105ec0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80103d71:	8b 0d a8 51 11 80    	mov    0x801151a8,%ecx
80103d77:	83 c4 10             	add    $0x10,%esp
80103d7a:	85 c9                	test   %ecx,%ecx
80103d7c:	7f 42                	jg     80103dc0 <end_op+0xa0>
    acquire(&log.lock);
80103d7e:	83 ec 0c             	sub    $0xc,%esp
80103d81:	68 60 51 11 80       	push   $0x80115160
80103d86:	e8 95 21 00 00       	call   80105f20 <acquire>
    wakeup(&log);
80103d8b:	c7 04 24 60 51 11 80 	movl   $0x80115160,(%esp)
    log.committing = 0;
80103d92:	c7 05 a0 51 11 80 00 	movl   $0x0,0x801151a0
80103d99:	00 00 00 
    wakeup(&log);
80103d9c:	e8 4f 13 00 00       	call   801050f0 <wakeup>
    release(&log.lock);
80103da1:	c7 04 24 60 51 11 80 	movl   $0x80115160,(%esp)
80103da8:	e8 13 21 00 00       	call   80105ec0 <release>
80103dad:	83 c4 10             	add    $0x10,%esp
}
80103db0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103db3:	5b                   	pop    %ebx
80103db4:	5e                   	pop    %esi
80103db5:	5f                   	pop    %edi
80103db6:	5d                   	pop    %ebp
80103db7:	c3                   	ret    
80103db8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103dbf:	90                   	nop
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103dc0:	a1 94 51 11 80       	mov    0x80115194,%eax
80103dc5:	83 ec 08             	sub    $0x8,%esp
80103dc8:	01 d8                	add    %ebx,%eax
80103dca:	83 c0 01             	add    $0x1,%eax
80103dcd:	50                   	push   %eax
80103dce:	ff 35 a4 51 11 80    	push   0x801151a4
80103dd4:	e8 f7 c2 ff ff       	call   801000d0 <bread>
80103dd9:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103ddb:	58                   	pop    %eax
80103ddc:	5a                   	pop    %edx
80103ddd:	ff 34 9d ac 51 11 80 	push   -0x7feeae54(,%ebx,4)
80103de4:	ff 35 a4 51 11 80    	push   0x801151a4
  for (tail = 0; tail < log.lh.n; tail++) {
80103dea:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103ded:	e8 de c2 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80103df2:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103df5:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103df7:	8d 40 5c             	lea    0x5c(%eax),%eax
80103dfa:	68 00 02 00 00       	push   $0x200
80103dff:	50                   	push   %eax
80103e00:	8d 46 5c             	lea    0x5c(%esi),%eax
80103e03:	50                   	push   %eax
80103e04:	e8 a7 23 00 00       	call   801061b0 <memmove>
    bwrite(to);  // write the log
80103e09:	89 34 24             	mov    %esi,(%esp)
80103e0c:	e8 9f c3 ff ff       	call   801001b0 <bwrite>
    brelse(from);
80103e11:	89 3c 24             	mov    %edi,(%esp)
80103e14:	e8 d7 c3 ff ff       	call   801001f0 <brelse>
    brelse(to);
80103e19:	89 34 24             	mov    %esi,(%esp)
80103e1c:	e8 cf c3 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103e21:	83 c4 10             	add    $0x10,%esp
80103e24:	3b 1d a8 51 11 80    	cmp    0x801151a8,%ebx
80103e2a:	7c 94                	jl     80103dc0 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80103e2c:	e8 7f fd ff ff       	call   80103bb0 <write_head>
    install_trans(); // Now install writes to home locations
80103e31:	e8 da fc ff ff       	call   80103b10 <install_trans>
    log.lh.n = 0;
80103e36:	c7 05 a8 51 11 80 00 	movl   $0x0,0x801151a8
80103e3d:	00 00 00 
    write_head();    // Erase the transaction from the log
80103e40:	e8 6b fd ff ff       	call   80103bb0 <write_head>
80103e45:	e9 34 ff ff ff       	jmp    80103d7e <end_op+0x5e>
80103e4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80103e50:	83 ec 0c             	sub    $0xc,%esp
80103e53:	68 60 51 11 80       	push   $0x80115160
80103e58:	e8 93 12 00 00       	call   801050f0 <wakeup>
  release(&log.lock);
80103e5d:	c7 04 24 60 51 11 80 	movl   $0x80115160,(%esp)
80103e64:	e8 57 20 00 00       	call   80105ec0 <release>
80103e69:	83 c4 10             	add    $0x10,%esp
}
80103e6c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103e6f:	5b                   	pop    %ebx
80103e70:	5e                   	pop    %esi
80103e71:	5f                   	pop    %edi
80103e72:	5d                   	pop    %ebp
80103e73:	c3                   	ret    
    panic("log.committing");
80103e74:	83 ec 0c             	sub    $0xc,%esp
80103e77:	68 04 9c 10 80       	push   $0x80109c04
80103e7c:	e8 4f c6 ff ff       	call   801004d0 <panic>
80103e81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e8f:	90                   	nop

80103e90 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103e90:	55                   	push   %ebp
80103e91:	89 e5                	mov    %esp,%ebp
80103e93:	53                   	push   %ebx
80103e94:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103e97:	8b 15 a8 51 11 80    	mov    0x801151a8,%edx
{
80103e9d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103ea0:	83 fa 1d             	cmp    $0x1d,%edx
80103ea3:	0f 8f 85 00 00 00    	jg     80103f2e <log_write+0x9e>
80103ea9:	a1 98 51 11 80       	mov    0x80115198,%eax
80103eae:	83 e8 01             	sub    $0x1,%eax
80103eb1:	39 c2                	cmp    %eax,%edx
80103eb3:	7d 79                	jge    80103f2e <log_write+0x9e>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103eb5:	a1 9c 51 11 80       	mov    0x8011519c,%eax
80103eba:	85 c0                	test   %eax,%eax
80103ebc:	7e 7d                	jle    80103f3b <log_write+0xab>
    panic("log_write outside of trans");

  acquire(&log.lock);
80103ebe:	83 ec 0c             	sub    $0xc,%esp
80103ec1:	68 60 51 11 80       	push   $0x80115160
80103ec6:	e8 55 20 00 00       	call   80105f20 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80103ecb:	8b 15 a8 51 11 80    	mov    0x801151a8,%edx
80103ed1:	83 c4 10             	add    $0x10,%esp
80103ed4:	85 d2                	test   %edx,%edx
80103ed6:	7e 4a                	jle    80103f22 <log_write+0x92>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103ed8:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80103edb:	31 c0                	xor    %eax,%eax
80103edd:	eb 08                	jmp    80103ee7 <log_write+0x57>
80103edf:	90                   	nop
80103ee0:	83 c0 01             	add    $0x1,%eax
80103ee3:	39 c2                	cmp    %eax,%edx
80103ee5:	74 29                	je     80103f10 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103ee7:	39 0c 85 ac 51 11 80 	cmp    %ecx,-0x7feeae54(,%eax,4)
80103eee:	75 f0                	jne    80103ee0 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
80103ef0:	89 0c 85 ac 51 11 80 	mov    %ecx,-0x7feeae54(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80103ef7:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
80103efa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
80103efd:	c7 45 08 60 51 11 80 	movl   $0x80115160,0x8(%ebp)
}
80103f04:	c9                   	leave  
  release(&log.lock);
80103f05:	e9 b6 1f 00 00       	jmp    80105ec0 <release>
80103f0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80103f10:	89 0c 95 ac 51 11 80 	mov    %ecx,-0x7feeae54(,%edx,4)
    log.lh.n++;
80103f17:	83 c2 01             	add    $0x1,%edx
80103f1a:	89 15 a8 51 11 80    	mov    %edx,0x801151a8
80103f20:	eb d5                	jmp    80103ef7 <log_write+0x67>
  log.lh.block[i] = b->blockno;
80103f22:	8b 43 08             	mov    0x8(%ebx),%eax
80103f25:	a3 ac 51 11 80       	mov    %eax,0x801151ac
  if (i == log.lh.n)
80103f2a:	75 cb                	jne    80103ef7 <log_write+0x67>
80103f2c:	eb e9                	jmp    80103f17 <log_write+0x87>
    panic("too big a transaction");
80103f2e:	83 ec 0c             	sub    $0xc,%esp
80103f31:	68 13 9c 10 80       	push   $0x80109c13
80103f36:	e8 95 c5 ff ff       	call   801004d0 <panic>
    panic("log_write outside of trans");
80103f3b:	83 ec 0c             	sub    $0xc,%esp
80103f3e:	68 29 9c 10 80       	push   $0x80109c29
80103f43:	e8 88 c5 ff ff       	call   801004d0 <panic>
80103f48:	66 90                	xchg   %ax,%ax
80103f4a:	66 90                	xchg   %ax,%ax
80103f4c:	66 90                	xchg   %ax,%ax
80103f4e:	66 90                	xchg   %ax,%ax

80103f50 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103f50:	55                   	push   %ebp
80103f51:	89 e5                	mov    %esp,%ebp
80103f53:	53                   	push   %ebx
80103f54:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103f57:	e8 d4 09 00 00       	call   80104930 <cpuid>
80103f5c:	89 c3                	mov    %eax,%ebx
80103f5e:	e8 cd 09 00 00       	call   80104930 <cpuid>
80103f63:	83 ec 04             	sub    $0x4,%esp
80103f66:	53                   	push   %ebx
80103f67:	50                   	push   %eax
80103f68:	68 44 9c 10 80       	push   $0x80109c44
80103f6d:	e8 7e c8 ff ff       	call   801007f0 <cprintf>
  idtinit();       // load idt register
80103f72:	e8 39 3d 00 00       	call   80107cb0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103f77:	e8 54 09 00 00       	call   801048d0 <mycpu>
80103f7c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103f7e:	b8 01 00 00 00       	mov    $0x1,%eax
80103f83:	f0 87 82 a8 00 00 00 	lock xchg %eax,0xa8(%edx)
  scheduler();     // start running processes
80103f8a:	e8 d1 18 00 00       	call   80105860 <scheduler>
80103f8f:	90                   	nop

80103f90 <mpenter>:
{
80103f90:	55                   	push   %ebp
80103f91:	89 e5                	mov    %esp,%ebp
80103f93:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103f96:	e8 c5 4f 00 00       	call   80108f60 <switchkvm>
  seginit();
80103f9b:	e8 30 4f 00 00       	call   80108ed0 <seginit>
  lapicinit();
80103fa0:	e8 9b f7 ff ff       	call   80103740 <lapicinit>
  mpmain();
80103fa5:	e8 a6 ff ff ff       	call   80103f50 <mpmain>
80103faa:	66 90                	xchg   %ax,%ax
80103fac:	66 90                	xchg   %ax,%ax
80103fae:	66 90                	xchg   %ax,%ax

80103fb0 <main>:
{
80103fb0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103fb4:	83 e4 f0             	and    $0xfffffff0,%esp
80103fb7:	ff 71 fc             	push   -0x4(%ecx)
80103fba:	55                   	push   %ebp
80103fbb:	89 e5                	mov    %esp,%ebp
80103fbd:	53                   	push   %ebx
80103fbe:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103fbf:	83 ec 08             	sub    $0x8,%esp
80103fc2:	68 00 00 40 80       	push   $0x80400000
80103fc7:	68 70 c1 34 80       	push   $0x8034c170
80103fcc:	e8 8f f5 ff ff       	call   80103560 <kinit1>
  kvmalloc();      // kernel page table
80103fd1:	e8 7a 54 00 00       	call   80109450 <kvmalloc>
  mpinit();        // detect other processors
80103fd6:	e8 85 01 00 00       	call   80104160 <mpinit>
  lapicinit();     // interrupt controller
80103fdb:	e8 60 f7 ff ff       	call   80103740 <lapicinit>
  seginit();       // segment descriptors
80103fe0:	e8 eb 4e 00 00       	call   80108ed0 <seginit>
  picinit();       // disable pic
80103fe5:	e8 96 03 00 00       	call   80104380 <picinit>
  ioapicinit();    // another interrupt controller
80103fea:	e8 31 f3 ff ff       	call   80103320 <ioapicinit>
  consoleinit();   // console hardware
80103fef:	e8 bc d9 ff ff       	call   801019b0 <consoleinit>
  uartinit();      // serial port
80103ff4:	e8 67 41 00 00       	call   80108160 <uartinit>
  pinit();         // process table
80103ff9:	e8 b2 08 00 00       	call   801048b0 <pinit>
  tvinit();        // trap vectors
80103ffe:	e8 2d 3c 00 00       	call   80107c30 <tvinit>
  binit();         // buffer cache
80104003:	e8 38 c0 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80104008:	e8 53 dd ff ff       	call   80101d60 <fileinit>
  ideinit();       // disk 
8010400d:	e8 fe f0 ff ff       	call   80103110 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80104012:	83 c4 0c             	add    $0xc,%esp
80104015:	68 8a 00 00 00       	push   $0x8a
8010401a:	68 2c d8 10 80       	push   $0x8010d82c
8010401f:	68 00 70 00 80       	push   $0x80007000
80104024:	e8 87 21 00 00       	call   801061b0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80104029:	83 c4 10             	add    $0x10,%esp
8010402c:	69 05 44 52 11 80 bc 	imul   $0xbc,0x80115244,%eax
80104033:	00 00 00 
80104036:	05 60 52 11 80       	add    $0x80115260,%eax
8010403b:	3d 60 52 11 80       	cmp    $0x80115260,%eax
80104040:	76 7e                	jbe    801040c0 <main+0x110>
80104042:	bb 60 52 11 80       	mov    $0x80115260,%ebx
80104047:	eb 20                	jmp    80104069 <main+0xb9>
80104049:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104050:	69 05 44 52 11 80 bc 	imul   $0xbc,0x80115244,%eax
80104057:	00 00 00 
8010405a:	81 c3 bc 00 00 00    	add    $0xbc,%ebx
80104060:	05 60 52 11 80       	add    $0x80115260,%eax
80104065:	39 c3                	cmp    %eax,%ebx
80104067:	73 57                	jae    801040c0 <main+0x110>
    if(c == mycpu())  // We've started already.
80104069:	e8 62 08 00 00       	call   801048d0 <mycpu>
8010406e:	39 c3                	cmp    %eax,%ebx
80104070:	74 de                	je     80104050 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80104072:	e8 59 f5 ff ff       	call   801035d0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80104077:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
8010407a:	c7 05 f8 6f 00 80 90 	movl   $0x80103f90,0x80006ff8
80104081:	3f 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80104084:	c7 05 f4 6f 00 80 00 	movl   $0x10c000,0x80006ff4
8010408b:	c0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
8010408e:	05 00 10 00 00       	add    $0x1000,%eax
80104093:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80104098:	0f b6 43 08          	movzbl 0x8(%ebx),%eax
8010409c:	68 00 70 00 00       	push   $0x7000
801040a1:	50                   	push   %eax
801040a2:	e8 e9 f7 ff ff       	call   80103890 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
801040a7:	83 c4 10             	add    $0x10,%esp
801040aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801040b0:	8b 83 a8 00 00 00    	mov    0xa8(%ebx),%eax
801040b6:	85 c0                	test   %eax,%eax
801040b8:	74 f6                	je     801040b0 <main+0x100>
801040ba:	eb 94                	jmp    80104050 <main+0xa0>
801040bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
801040c0:	83 ec 08             	sub    $0x8,%esp
801040c3:	68 00 00 00 8e       	push   $0x8e000000
801040c8:	68 00 00 40 80       	push   $0x80400000
801040cd:	e8 2e f4 ff ff       	call   80103500 <kinit2>
  userinit();      // first user process
801040d2:	e8 a9 08 00 00       	call   80104980 <userinit>
  mpmain();        // finish this processor's setup
801040d7:	e8 74 fe ff ff       	call   80103f50 <mpmain>
801040dc:	66 90                	xchg   %ax,%ax
801040de:	66 90                	xchg   %ax,%ax

801040e0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801040e0:	55                   	push   %ebp
801040e1:	89 e5                	mov    %esp,%ebp
801040e3:	57                   	push   %edi
801040e4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
801040e5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
801040eb:	53                   	push   %ebx
  e = addr+len;
801040ec:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
801040ef:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
801040f2:	39 de                	cmp    %ebx,%esi
801040f4:	72 10                	jb     80104106 <mpsearch1+0x26>
801040f6:	eb 50                	jmp    80104148 <mpsearch1+0x68>
801040f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801040ff:	90                   	nop
80104100:	89 fe                	mov    %edi,%esi
80104102:	39 fb                	cmp    %edi,%ebx
80104104:	76 42                	jbe    80104148 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80104106:	83 ec 04             	sub    $0x4,%esp
80104109:	8d 7e 10             	lea    0x10(%esi),%edi
8010410c:	6a 04                	push   $0x4
8010410e:	68 58 9c 10 80       	push   $0x80109c58
80104113:	56                   	push   %esi
80104114:	e8 47 20 00 00       	call   80106160 <memcmp>
80104119:	83 c4 10             	add    $0x10,%esp
8010411c:	85 c0                	test   %eax,%eax
8010411e:	75 e0                	jne    80104100 <mpsearch1+0x20>
80104120:	89 f2                	mov    %esi,%edx
80104122:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80104128:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
8010412b:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
8010412e:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80104130:	39 fa                	cmp    %edi,%edx
80104132:	75 f4                	jne    80104128 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80104134:	84 c0                	test   %al,%al
80104136:	75 c8                	jne    80104100 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80104138:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010413b:	89 f0                	mov    %esi,%eax
8010413d:	5b                   	pop    %ebx
8010413e:	5e                   	pop    %esi
8010413f:	5f                   	pop    %edi
80104140:	5d                   	pop    %ebp
80104141:	c3                   	ret    
80104142:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104148:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010414b:	31 f6                	xor    %esi,%esi
}
8010414d:	5b                   	pop    %ebx
8010414e:	89 f0                	mov    %esi,%eax
80104150:	5e                   	pop    %esi
80104151:	5f                   	pop    %edi
80104152:	5d                   	pop    %ebp
80104153:	c3                   	ret    
80104154:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010415b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010415f:	90                   	nop

80104160 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80104160:	55                   	push   %ebp
80104161:	89 e5                	mov    %esp,%ebp
80104163:	57                   	push   %edi
80104164:	56                   	push   %esi
80104165:	53                   	push   %ebx
80104166:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80104169:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80104170:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80104177:	c1 e0 08             	shl    $0x8,%eax
8010417a:	09 d0                	or     %edx,%eax
8010417c:	c1 e0 04             	shl    $0x4,%eax
8010417f:	75 1b                	jne    8010419c <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80104181:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80104188:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
8010418f:	c1 e0 08             	shl    $0x8,%eax
80104192:	09 d0                	or     %edx,%eax
80104194:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80104197:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010419c:	ba 00 04 00 00       	mov    $0x400,%edx
801041a1:	e8 3a ff ff ff       	call   801040e0 <mpsearch1>
801041a6:	89 c3                	mov    %eax,%ebx
801041a8:	85 c0                	test   %eax,%eax
801041aa:	0f 84 60 01 00 00    	je     80104310 <mpinit+0x1b0>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801041b0:	8b 73 04             	mov    0x4(%ebx),%esi
801041b3:	85 f6                	test   %esi,%esi
801041b5:	0f 84 45 01 00 00    	je     80104300 <mpinit+0x1a0>
  if(memcmp(conf, "PCMP", 4) != 0)
801041bb:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801041be:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
801041c4:	6a 04                	push   $0x4
801041c6:	68 5d 9c 10 80       	push   $0x80109c5d
801041cb:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801041cc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
801041cf:	e8 8c 1f 00 00       	call   80106160 <memcmp>
801041d4:	83 c4 10             	add    $0x10,%esp
801041d7:	85 c0                	test   %eax,%eax
801041d9:	0f 85 21 01 00 00    	jne    80104300 <mpinit+0x1a0>
  if(conf->version != 1 && conf->version != 4)
801041df:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
801041e6:	3c 01                	cmp    $0x1,%al
801041e8:	74 08                	je     801041f2 <mpinit+0x92>
801041ea:	3c 04                	cmp    $0x4,%al
801041ec:	0f 85 0e 01 00 00    	jne    80104300 <mpinit+0x1a0>
  if(sum((uchar*)conf, conf->length) != 0)
801041f2:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
  for(i=0; i<len; i++)
801041f9:	66 85 d2             	test   %dx,%dx
801041fc:	74 22                	je     80104220 <mpinit+0xc0>
801041fe:	8d 3c 32             	lea    (%edx,%esi,1),%edi
80104201:	89 f0                	mov    %esi,%eax
  sum = 0;
80104203:	31 d2                	xor    %edx,%edx
80104205:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80104208:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
8010420f:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
80104212:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80104214:	39 c7                	cmp    %eax,%edi
80104216:	75 f0                	jne    80104208 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
80104218:	84 d2                	test   %dl,%dl
8010421a:	0f 85 e0 00 00 00    	jne    80104300 <mpinit+0x1a0>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80104220:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
80104226:	89 5d e0             	mov    %ebx,-0x20(%ebp)
  ismp = 1;
80104229:	bf 01 00 00 00       	mov    $0x1,%edi
  lapic = (uint*)conf->lapicaddr;
8010422e:	a3 40 51 11 80       	mov    %eax,0x80115140
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80104233:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
80104239:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
80104240:	03 55 e4             	add    -0x1c(%ebp),%edx
80104243:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104247:	90                   	nop
80104248:	39 d0                	cmp    %edx,%eax
8010424a:	73 15                	jae    80104261 <mpinit+0x101>
    switch(*p){
8010424c:	0f b6 08             	movzbl (%eax),%ecx
8010424f:	80 f9 02             	cmp    $0x2,%cl
80104252:	74 4c                	je     801042a0 <mpinit+0x140>
80104254:	77 3a                	ja     80104290 <mpinit+0x130>
80104256:	84 c9                	test   %cl,%cl
80104258:	74 56                	je     801042b0 <mpinit+0x150>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
8010425a:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010425d:	39 d0                	cmp    %edx,%eax
8010425f:	72 eb                	jb     8010424c <mpinit+0xec>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80104261:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80104264:	85 ff                	test   %edi,%edi
80104266:	0f 84 f9 00 00 00    	je     80104365 <mpinit+0x205>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010426c:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
80104270:	74 15                	je     80104287 <mpinit+0x127>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80104272:	b8 70 00 00 00       	mov    $0x70,%eax
80104277:	ba 22 00 00 00       	mov    $0x22,%edx
8010427c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010427d:	ba 23 00 00 00       	mov    $0x23,%edx
80104282:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80104283:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80104286:	ee                   	out    %al,(%dx)
  }
}
80104287:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010428a:	5b                   	pop    %ebx
8010428b:	5e                   	pop    %esi
8010428c:	5f                   	pop    %edi
8010428d:	5d                   	pop    %ebp
8010428e:	c3                   	ret    
8010428f:	90                   	nop
    switch(*p){
80104290:	83 e9 03             	sub    $0x3,%ecx
80104293:	80 f9 01             	cmp    $0x1,%cl
80104296:	76 c2                	jbe    8010425a <mpinit+0xfa>
80104298:	31 ff                	xor    %edi,%edi
8010429a:	eb ac                	jmp    80104248 <mpinit+0xe8>
8010429c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
801042a0:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
801042a4:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
801042a7:	88 0d 40 52 11 80    	mov    %cl,0x80115240
      continue;
801042ad:	eb 99                	jmp    80104248 <mpinit+0xe8>
801042af:	90                   	nop
      if(ncpu < NCPU) {
801042b0:	8b 35 44 52 11 80    	mov    0x80115244,%esi
801042b6:	83 fe 07             	cmp    $0x7,%esi
801042b9:	7f 3d                	jg     801042f8 <mpinit+0x198>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801042bb:	69 de bc 00 00 00    	imul   $0xbc,%esi,%ebx
801042c1:	8d 8b 60 52 11 80    	lea    -0x7feeada0(%ebx),%ecx
801042c7:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801042ca:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        cpus[ncpu].sys_call_counter = 0; 
801042ce:	c7 81 b8 00 00 00 00 	movl   $0x0,0xb8(%ecx)
801042d5:	00 00 00 
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801042d8:	88 59 08             	mov    %bl,0x8(%ecx)
        cpus[ncpu].slice_count = 0;
801042db:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
        cpus[ncpu].current_queue = ROUND_ROBIN;
801042de:	c7 41 04 01 00 00 00 	movl   $0x1,0x4(%ecx)
        ncpu++;
801042e5:	8d 4e 01             	lea    0x1(%esi),%ecx
        cpus[ncpu].slice_count = 0;
801042e8:	c7 83 60 52 11 80 00 	movl   $0x0,-0x7feeada0(%ebx)
801042ef:	00 00 00 
        ncpu++;
801042f2:	89 0d 44 52 11 80    	mov    %ecx,0x80115244
      p += sizeof(struct mpproc);
801042f8:	83 c0 14             	add    $0x14,%eax
      continue;
801042fb:	e9 48 ff ff ff       	jmp    80104248 <mpinit+0xe8>
    panic("Expect to run on an SMP");
80104300:	83 ec 0c             	sub    $0xc,%esp
80104303:	68 62 9c 10 80       	push   $0x80109c62
80104308:	e8 c3 c1 ff ff       	call   801004d0 <panic>
8010430d:	8d 76 00             	lea    0x0(%esi),%esi
{
80104310:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
80104315:	eb 13                	jmp    8010432a <mpinit+0x1ca>
80104317:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010431e:	66 90                	xchg   %ax,%ax
  for(p = addr; p < e; p += sizeof(struct mp))
80104320:	89 f3                	mov    %esi,%ebx
80104322:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
80104328:	74 d6                	je     80104300 <mpinit+0x1a0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010432a:	83 ec 04             	sub    $0x4,%esp
8010432d:	8d 73 10             	lea    0x10(%ebx),%esi
80104330:	6a 04                	push   $0x4
80104332:	68 58 9c 10 80       	push   $0x80109c58
80104337:	53                   	push   %ebx
80104338:	e8 23 1e 00 00       	call   80106160 <memcmp>
8010433d:	83 c4 10             	add    $0x10,%esp
80104340:	85 c0                	test   %eax,%eax
80104342:	75 dc                	jne    80104320 <mpinit+0x1c0>
80104344:	89 da                	mov    %ebx,%edx
80104346:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010434d:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80104350:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
80104353:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80104356:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80104358:	39 d6                	cmp    %edx,%esi
8010435a:	75 f4                	jne    80104350 <mpinit+0x1f0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010435c:	84 c0                	test   %al,%al
8010435e:	75 c0                	jne    80104320 <mpinit+0x1c0>
80104360:	e9 4b fe ff ff       	jmp    801041b0 <mpinit+0x50>
    panic("Didn't find a suitable machine");
80104365:	83 ec 0c             	sub    $0xc,%esp
80104368:	68 7c 9c 10 80       	push   $0x80109c7c
8010436d:	e8 5e c1 ff ff       	call   801004d0 <panic>
80104372:	66 90                	xchg   %ax,%ax
80104374:	66 90                	xchg   %ax,%ax
80104376:	66 90                	xchg   %ax,%ax
80104378:	66 90                	xchg   %ax,%ax
8010437a:	66 90                	xchg   %ax,%ax
8010437c:	66 90                	xchg   %ax,%ax
8010437e:	66 90                	xchg   %ax,%ax

80104380 <picinit>:
80104380:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104385:	ba 21 00 00 00       	mov    $0x21,%edx
8010438a:	ee                   	out    %al,(%dx)
8010438b:	ba a1 00 00 00       	mov    $0xa1,%edx
80104390:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80104391:	c3                   	ret    
80104392:	66 90                	xchg   %ax,%ax
80104394:	66 90                	xchg   %ax,%ax
80104396:	66 90                	xchg   %ax,%ax
80104398:	66 90                	xchg   %ax,%ax
8010439a:	66 90                	xchg   %ax,%ax
8010439c:	66 90                	xchg   %ax,%ax
8010439e:	66 90                	xchg   %ax,%ax

801043a0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801043a0:	55                   	push   %ebp
801043a1:	89 e5                	mov    %esp,%ebp
801043a3:	57                   	push   %edi
801043a4:	56                   	push   %esi
801043a5:	53                   	push   %ebx
801043a6:	83 ec 0c             	sub    $0xc,%esp
801043a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801043ac:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801043af:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801043b5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801043bb:	e8 c0 d9 ff ff       	call   80101d80 <filealloc>
801043c0:	89 03                	mov    %eax,(%ebx)
801043c2:	85 c0                	test   %eax,%eax
801043c4:	0f 84 a8 00 00 00    	je     80104472 <pipealloc+0xd2>
801043ca:	e8 b1 d9 ff ff       	call   80101d80 <filealloc>
801043cf:	89 06                	mov    %eax,(%esi)
801043d1:	85 c0                	test   %eax,%eax
801043d3:	0f 84 87 00 00 00    	je     80104460 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801043d9:	e8 f2 f1 ff ff       	call   801035d0 <kalloc>
801043de:	89 c7                	mov    %eax,%edi
801043e0:	85 c0                	test   %eax,%eax
801043e2:	0f 84 b0 00 00 00    	je     80104498 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
801043e8:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801043ef:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
801043f2:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
801043f5:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801043fc:	00 00 00 
  p->nwrite = 0;
801043ff:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80104406:	00 00 00 
  p->nread = 0;
80104409:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80104410:	00 00 00 
  initlock(&p->lock, "pipe");
80104413:	68 9b 9c 10 80       	push   $0x80109c9b
80104418:	50                   	push   %eax
80104419:	e8 32 19 00 00       	call   80105d50 <initlock>
  (*f0)->type = FD_PIPE;
8010441e:	8b 03                	mov    (%ebx),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80104420:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80104423:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80104429:	8b 03                	mov    (%ebx),%eax
8010442b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010442f:	8b 03                	mov    (%ebx),%eax
80104431:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80104435:	8b 03                	mov    (%ebx),%eax
80104437:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010443a:	8b 06                	mov    (%esi),%eax
8010443c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80104442:	8b 06                	mov    (%esi),%eax
80104444:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80104448:	8b 06                	mov    (%esi),%eax
8010444a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010444e:	8b 06                	mov    (%esi),%eax
80104450:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80104453:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80104456:	31 c0                	xor    %eax,%eax
}
80104458:	5b                   	pop    %ebx
80104459:	5e                   	pop    %esi
8010445a:	5f                   	pop    %edi
8010445b:	5d                   	pop    %ebp
8010445c:	c3                   	ret    
8010445d:	8d 76 00             	lea    0x0(%esi),%esi
  if(*f0)
80104460:	8b 03                	mov    (%ebx),%eax
80104462:	85 c0                	test   %eax,%eax
80104464:	74 1e                	je     80104484 <pipealloc+0xe4>
    fileclose(*f0);
80104466:	83 ec 0c             	sub    $0xc,%esp
80104469:	50                   	push   %eax
8010446a:	e8 d1 d9 ff ff       	call   80101e40 <fileclose>
8010446f:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80104472:	8b 06                	mov    (%esi),%eax
80104474:	85 c0                	test   %eax,%eax
80104476:	74 0c                	je     80104484 <pipealloc+0xe4>
    fileclose(*f1);
80104478:	83 ec 0c             	sub    $0xc,%esp
8010447b:	50                   	push   %eax
8010447c:	e8 bf d9 ff ff       	call   80101e40 <fileclose>
80104481:	83 c4 10             	add    $0x10,%esp
}
80104484:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80104487:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010448c:	5b                   	pop    %ebx
8010448d:	5e                   	pop    %esi
8010448e:	5f                   	pop    %edi
8010448f:	5d                   	pop    %ebp
80104490:	c3                   	ret    
80104491:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
80104498:	8b 03                	mov    (%ebx),%eax
8010449a:	85 c0                	test   %eax,%eax
8010449c:	75 c8                	jne    80104466 <pipealloc+0xc6>
8010449e:	eb d2                	jmp    80104472 <pipealloc+0xd2>

801044a0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801044a0:	55                   	push   %ebp
801044a1:	89 e5                	mov    %esp,%ebp
801044a3:	56                   	push   %esi
801044a4:	53                   	push   %ebx
801044a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801044a8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801044ab:	83 ec 0c             	sub    $0xc,%esp
801044ae:	53                   	push   %ebx
801044af:	e8 6c 1a 00 00       	call   80105f20 <acquire>
  if(writable){
801044b4:	83 c4 10             	add    $0x10,%esp
801044b7:	85 f6                	test   %esi,%esi
801044b9:	74 65                	je     80104520 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
801044bb:	83 ec 0c             	sub    $0xc,%esp
801044be:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
801044c4:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
801044cb:	00 00 00 
    wakeup(&p->nread);
801044ce:	50                   	push   %eax
801044cf:	e8 1c 0c 00 00       	call   801050f0 <wakeup>
801044d4:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801044d7:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801044dd:	85 d2                	test   %edx,%edx
801044df:	75 0a                	jne    801044eb <pipeclose+0x4b>
801044e1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801044e7:	85 c0                	test   %eax,%eax
801044e9:	74 15                	je     80104500 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801044eb:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801044ee:	8d 65 f8             	lea    -0x8(%ebp),%esp
801044f1:	5b                   	pop    %ebx
801044f2:	5e                   	pop    %esi
801044f3:	5d                   	pop    %ebp
    release(&p->lock);
801044f4:	e9 c7 19 00 00       	jmp    80105ec0 <release>
801044f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80104500:	83 ec 0c             	sub    $0xc,%esp
80104503:	53                   	push   %ebx
80104504:	e8 b7 19 00 00       	call   80105ec0 <release>
    kfree((char*)p);
80104509:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010450c:	83 c4 10             	add    $0x10,%esp
}
8010450f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104512:	5b                   	pop    %ebx
80104513:	5e                   	pop    %esi
80104514:	5d                   	pop    %ebp
    kfree((char*)p);
80104515:	e9 f6 ee ff ff       	jmp    80103410 <kfree>
8010451a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
80104520:	83 ec 0c             	sub    $0xc,%esp
80104523:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80104529:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80104530:	00 00 00 
    wakeup(&p->nwrite);
80104533:	50                   	push   %eax
80104534:	e8 b7 0b 00 00       	call   801050f0 <wakeup>
80104539:	83 c4 10             	add    $0x10,%esp
8010453c:	eb 99                	jmp    801044d7 <pipeclose+0x37>
8010453e:	66 90                	xchg   %ax,%ax

80104540 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80104540:	55                   	push   %ebp
80104541:	89 e5                	mov    %esp,%ebp
80104543:	57                   	push   %edi
80104544:	56                   	push   %esi
80104545:	53                   	push   %ebx
80104546:	83 ec 28             	sub    $0x28,%esp
80104549:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010454c:	53                   	push   %ebx
8010454d:	e8 ce 19 00 00       	call   80105f20 <acquire>
  for(i = 0; i < n; i++){
80104552:	8b 45 10             	mov    0x10(%ebp),%eax
80104555:	83 c4 10             	add    $0x10,%esp
80104558:	85 c0                	test   %eax,%eax
8010455a:	0f 8e c0 00 00 00    	jle    80104620 <pipewrite+0xe0>
80104560:	8b 45 0c             	mov    0xc(%ebp),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104563:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80104569:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010456f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104572:	03 45 10             	add    0x10(%ebp),%eax
80104575:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104578:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010457e:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104584:	89 ca                	mov    %ecx,%edx
80104586:	05 00 02 00 00       	add    $0x200,%eax
8010458b:	39 c1                	cmp    %eax,%ecx
8010458d:	74 3f                	je     801045ce <pipewrite+0x8e>
8010458f:	eb 67                	jmp    801045f8 <pipewrite+0xb8>
80104591:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
80104598:	e8 b3 03 00 00       	call   80104950 <myproc>
8010459d:	8b 48 24             	mov    0x24(%eax),%ecx
801045a0:	85 c9                	test   %ecx,%ecx
801045a2:	75 34                	jne    801045d8 <pipewrite+0x98>
      wakeup(&p->nread);
801045a4:	83 ec 0c             	sub    $0xc,%esp
801045a7:	57                   	push   %edi
801045a8:	e8 43 0b 00 00       	call   801050f0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801045ad:	58                   	pop    %eax
801045ae:	5a                   	pop    %edx
801045af:	53                   	push   %ebx
801045b0:	56                   	push   %esi
801045b1:	e8 7a 0a 00 00       	call   80105030 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801045b6:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801045bc:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
801045c2:	83 c4 10             	add    $0x10,%esp
801045c5:	05 00 02 00 00       	add    $0x200,%eax
801045ca:	39 c2                	cmp    %eax,%edx
801045cc:	75 2a                	jne    801045f8 <pipewrite+0xb8>
      if(p->readopen == 0 || myproc()->killed){
801045ce:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801045d4:	85 c0                	test   %eax,%eax
801045d6:	75 c0                	jne    80104598 <pipewrite+0x58>
        release(&p->lock);
801045d8:	83 ec 0c             	sub    $0xc,%esp
801045db:	53                   	push   %ebx
801045dc:	e8 df 18 00 00       	call   80105ec0 <release>
        return -1;
801045e1:	83 c4 10             	add    $0x10,%esp
801045e4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801045e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801045ec:	5b                   	pop    %ebx
801045ed:	5e                   	pop    %esi
801045ee:	5f                   	pop    %edi
801045ef:	5d                   	pop    %ebp
801045f0:	c3                   	ret    
801045f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801045f8:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801045fb:	8d 4a 01             	lea    0x1(%edx),%ecx
801045fe:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80104604:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
8010460a:	0f b6 06             	movzbl (%esi),%eax
  for(i = 0; i < n; i++){
8010460d:	83 c6 01             	add    $0x1,%esi
80104610:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80104613:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80104617:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010461a:	0f 85 58 ff ff ff    	jne    80104578 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80104620:	83 ec 0c             	sub    $0xc,%esp
80104623:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80104629:	50                   	push   %eax
8010462a:	e8 c1 0a 00 00       	call   801050f0 <wakeup>
  release(&p->lock);
8010462f:	89 1c 24             	mov    %ebx,(%esp)
80104632:	e8 89 18 00 00       	call   80105ec0 <release>
  return n;
80104637:	8b 45 10             	mov    0x10(%ebp),%eax
8010463a:	83 c4 10             	add    $0x10,%esp
8010463d:	eb aa                	jmp    801045e9 <pipewrite+0xa9>
8010463f:	90                   	nop

80104640 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80104640:	55                   	push   %ebp
80104641:	89 e5                	mov    %esp,%ebp
80104643:	57                   	push   %edi
80104644:	56                   	push   %esi
80104645:	53                   	push   %ebx
80104646:	83 ec 18             	sub    $0x18,%esp
80104649:	8b 75 08             	mov    0x8(%ebp),%esi
8010464c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010464f:	56                   	push   %esi
80104650:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80104656:	e8 c5 18 00 00       	call   80105f20 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010465b:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80104661:	83 c4 10             	add    $0x10,%esp
80104664:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
8010466a:	74 2f                	je     8010469b <piperead+0x5b>
8010466c:	eb 37                	jmp    801046a5 <piperead+0x65>
8010466e:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
80104670:	e8 db 02 00 00       	call   80104950 <myproc>
80104675:	8b 48 24             	mov    0x24(%eax),%ecx
80104678:	85 c9                	test   %ecx,%ecx
8010467a:	0f 85 80 00 00 00    	jne    80104700 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80104680:	83 ec 08             	sub    $0x8,%esp
80104683:	56                   	push   %esi
80104684:	53                   	push   %ebx
80104685:	e8 a6 09 00 00       	call   80105030 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010468a:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
80104690:	83 c4 10             	add    $0x10,%esp
80104693:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
80104699:	75 0a                	jne    801046a5 <piperead+0x65>
8010469b:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
801046a1:	85 c0                	test   %eax,%eax
801046a3:	75 cb                	jne    80104670 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801046a5:	8b 55 10             	mov    0x10(%ebp),%edx
801046a8:	31 db                	xor    %ebx,%ebx
801046aa:	85 d2                	test   %edx,%edx
801046ac:	7f 20                	jg     801046ce <piperead+0x8e>
801046ae:	eb 2c                	jmp    801046dc <piperead+0x9c>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
801046b0:	8d 48 01             	lea    0x1(%eax),%ecx
801046b3:	25 ff 01 00 00       	and    $0x1ff,%eax
801046b8:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
801046be:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
801046c3:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801046c6:	83 c3 01             	add    $0x1,%ebx
801046c9:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801046cc:	74 0e                	je     801046dc <piperead+0x9c>
    if(p->nread == p->nwrite)
801046ce:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801046d4:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
801046da:	75 d4                	jne    801046b0 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801046dc:	83 ec 0c             	sub    $0xc,%esp
801046df:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801046e5:	50                   	push   %eax
801046e6:	e8 05 0a 00 00       	call   801050f0 <wakeup>
  release(&p->lock);
801046eb:	89 34 24             	mov    %esi,(%esp)
801046ee:	e8 cd 17 00 00       	call   80105ec0 <release>
  return i;
801046f3:	83 c4 10             	add    $0x10,%esp
}
801046f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801046f9:	89 d8                	mov    %ebx,%eax
801046fb:	5b                   	pop    %ebx
801046fc:	5e                   	pop    %esi
801046fd:	5f                   	pop    %edi
801046fe:	5d                   	pop    %ebp
801046ff:	c3                   	ret    
      release(&p->lock);
80104700:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104703:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80104708:	56                   	push   %esi
80104709:	e8 b2 17 00 00       	call   80105ec0 <release>
      return -1;
8010470e:	83 c4 10             	add    $0x10,%esp
}
80104711:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104714:	89 d8                	mov    %ebx,%eax
80104716:	5b                   	pop    %ebx
80104717:	5e                   	pop    %esi
80104718:	5f                   	pop    %edi
80104719:	5d                   	pop    %ebp
8010471a:	c3                   	ret    
8010471b:	66 90                	xchg   %ax,%ax
8010471d:	66 90                	xchg   %ax,%ax
8010471f:	90                   	nop

80104720 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80104720:	55                   	push   %ebp
80104721:	89 e5                	mov    %esp,%ebp
80104723:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104724:	bb 74 58 11 80       	mov    $0x80115874,%ebx
{
80104729:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010472c:	68 40 58 11 80       	push   $0x80115840
80104731:	e8 ea 17 00 00       	call   80105f20 <acquire>
80104736:	83 c4 10             	add    $0x10,%esp
80104739:	eb 17                	jmp    80104752 <allocproc+0x32>
8010473b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010473f:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104740:	81 c3 40 8d 00 00    	add    $0x8d40,%ebx
80104746:	81 fb 74 a8 34 80    	cmp    $0x8034a874,%ebx
8010474c:	0f 84 d6 00 00 00    	je     80104828 <allocproc+0x108>
    if(p->state == UNUSED)
80104752:	8b 43 0c             	mov    0xc(%ebx),%eax
80104755:	85 c0                	test   %eax,%eax
80104757:	75 e7                	jne    80104740 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80104759:	a1 04 d0 10 80       	mov    0x8010d004,%eax
  p->state = EMBRYO;
8010475e:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->syscall_count = 0;
80104765:	c7 83 1c 8d 00 00 00 	movl   $0x0,0x8d1c(%ebx)
8010476c:	00 00 00 
  p->pid = nextpid++;
8010476f:	8d 50 01             	lea    0x1(%eax),%edx
80104772:	89 43 10             	mov    %eax,0x10(%ebx)
  if ((p->pid != 1) && (p->pid != 2))
80104775:	83 e8 01             	sub    $0x1,%eax
  {
    p->sched_info.queue_level = FCFS; // Default queue is the third queue
  }
  else
  {
    p->sched_info.queue_level = ROUND_ROBIN; // For shel and init processes, Default queue is the first queue
80104778:	83 f8 02             	cmp    $0x2,%eax
  }
  p->sched_info.burst_time = 2;
8010477b:	c7 83 24 8d 00 00 02 	movl   $0x2,0x8d24(%ebx)
80104782:	00 00 00 
    p->sched_info.queue_level = ROUND_ROBIN; // For shel and init processes, Default queue is the first queue
80104785:	19 c0                	sbb    %eax,%eax
  p->sched_info.wait_time = 0;
  p->sched_info.consecutive_run = 0;
  p->sched_info.arrival_time = ticks;
  p->sched_info.last_running_time = ticks;
  p->sched_info.last_tick = ticks;
  release(&ptable.lock);
80104787:	83 ec 0c             	sub    $0xc,%esp
  p->sched_info.confidence = 50;
8010478a:	c7 83 28 8d 00 00 32 	movl   $0x32,0x8d28(%ebx)
80104791:	00 00 00 
    p->sched_info.queue_level = ROUND_ROBIN; // For shel and init processes, Default queue is the first queue
80104794:	83 e0 fe             	and    $0xfffffffe,%eax
  p->pid = nextpid++;
80104797:	89 15 04 d0 10 80    	mov    %edx,0x8010d004
  p->sched_info.wait_time = 0;
8010479d:	c7 83 38 8d 00 00 00 	movl   $0x0,0x8d38(%ebx)
801047a4:	00 00 00 
    p->sched_info.queue_level = ROUND_ROBIN; // For shel and init processes, Default queue is the first queue
801047a7:	83 c0 03             	add    $0x3,%eax
801047aa:	89 83 20 8d 00 00    	mov    %eax,0x8d20(%ebx)
  p->sched_info.arrival_time = ticks;
801047b0:	a1 84 a8 34 80       	mov    0x8034a884,%eax
  p->sched_info.consecutive_run = 0;
801047b5:	c7 83 2c 8d 00 00 00 	movl   $0x0,0x8d2c(%ebx)
801047bc:	00 00 00 
  p->sched_info.arrival_time = ticks;
801047bf:	89 83 30 8d 00 00    	mov    %eax,0x8d30(%ebx)
  p->sched_info.last_running_time = ticks;
801047c5:	89 83 34 8d 00 00    	mov    %eax,0x8d34(%ebx)
  p->sched_info.last_tick = ticks;
801047cb:	89 83 3c 8d 00 00    	mov    %eax,0x8d3c(%ebx)
  release(&ptable.lock);
801047d1:	68 40 58 11 80       	push   $0x80115840
801047d6:	e8 e5 16 00 00       	call   80105ec0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801047db:	e8 f0 ed ff ff       	call   801035d0 <kalloc>
801047e0:	83 c4 10             	add    $0x10,%esp
801047e3:	89 43 08             	mov    %eax,0x8(%ebx)
801047e6:	85 c0                	test   %eax,%eax
801047e8:	74 57                	je     80104841 <allocproc+0x121>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801047ea:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
801047f0:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
801047f3:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
801047f8:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
801047fb:	c7 40 14 1f 7c 10 80 	movl   $0x80107c1f,0x14(%eax)
  p->context = (struct context*)sp;
80104802:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80104805:	6a 14                	push   $0x14
80104807:	6a 00                	push   $0x0
80104809:	50                   	push   %eax
8010480a:	e8 01 19 00 00       	call   80106110 <memset>
  p->context->eip = (uint)forkret;
8010480f:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
80104812:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80104815:	c7 40 10 60 48 10 80 	movl   $0x80104860,0x10(%eax)
}
8010481c:	89 d8                	mov    %ebx,%eax
8010481e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104821:	c9                   	leave  
80104822:	c3                   	ret    
80104823:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104827:	90                   	nop
  release(&ptable.lock);
80104828:	83 ec 0c             	sub    $0xc,%esp
  return 0;
8010482b:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
8010482d:	68 40 58 11 80       	push   $0x80115840
80104832:	e8 89 16 00 00       	call   80105ec0 <release>
}
80104837:	89 d8                	mov    %ebx,%eax
  return 0;
80104839:	83 c4 10             	add    $0x10,%esp
}
8010483c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010483f:	c9                   	leave  
80104840:	c3                   	ret    
    p->state = UNUSED;
80104841:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80104848:	31 db                	xor    %ebx,%ebx
}
8010484a:	89 d8                	mov    %ebx,%eax
8010484c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010484f:	c9                   	leave  
80104850:	c3                   	ret    
80104851:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104858:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010485f:	90                   	nop

80104860 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80104860:	55                   	push   %ebp
80104861:	89 e5                	mov    %esp,%ebp
80104863:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80104866:	68 40 58 11 80       	push   $0x80115840
8010486b:	e8 50 16 00 00       	call   80105ec0 <release>

  if (first) {
80104870:	a1 00 d0 10 80       	mov    0x8010d000,%eax
80104875:	83 c4 10             	add    $0x10,%esp
80104878:	85 c0                	test   %eax,%eax
8010487a:	75 04                	jne    80104880 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010487c:	c9                   	leave  
8010487d:	c3                   	ret    
8010487e:	66 90                	xchg   %ax,%ax
    first = 0;
80104880:	c7 05 00 d0 10 80 00 	movl   $0x0,0x8010d000
80104887:	00 00 00 
    iinit(ROOTDEV);
8010488a:	83 ec 0c             	sub    $0xc,%esp
8010488d:	6a 01                	push   $0x1
8010488f:	e8 1c dc ff ff       	call   801024b0 <iinit>
    initlog(ROOTDEV);
80104894:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010489b:	e8 70 f3 ff ff       	call   80103c10 <initlog>
}
801048a0:	83 c4 10             	add    $0x10,%esp
801048a3:	c9                   	leave  
801048a4:	c3                   	ret    
801048a5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801048b0 <pinit>:
{
801048b0:	55                   	push   %ebp
801048b1:	89 e5                	mov    %esp,%ebp
801048b3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
801048b6:	68 a0 9c 10 80       	push   $0x80109ca0
801048bb:	68 40 58 11 80       	push   $0x80115840
801048c0:	e8 8b 14 00 00       	call   80105d50 <initlock>
}
801048c5:	83 c4 10             	add    $0x10,%esp
801048c8:	c9                   	leave  
801048c9:	c3                   	ret    
801048ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801048d0 <mycpu>:
{
801048d0:	55                   	push   %ebp
801048d1:	89 e5                	mov    %esp,%ebp
801048d3:	56                   	push   %esi
801048d4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801048d5:	9c                   	pushf  
801048d6:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801048d7:	f6 c4 02             	test   $0x2,%ah
801048da:	75 46                	jne    80104922 <mycpu+0x52>
  apicid = lapicid();
801048dc:	e8 5f ef ff ff       	call   80103840 <lapicid>
  for (i = 0; i < ncpu; ++i) {
801048e1:	8b 35 44 52 11 80    	mov    0x80115244,%esi
801048e7:	85 f6                	test   %esi,%esi
801048e9:	7e 2a                	jle    80104915 <mycpu+0x45>
801048eb:	31 d2                	xor    %edx,%edx
801048ed:	eb 08                	jmp    801048f7 <mycpu+0x27>
801048ef:	90                   	nop
801048f0:	83 c2 01             	add    $0x1,%edx
801048f3:	39 f2                	cmp    %esi,%edx
801048f5:	74 1e                	je     80104915 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
801048f7:	69 ca bc 00 00 00    	imul   $0xbc,%edx,%ecx
801048fd:	0f b6 99 68 52 11 80 	movzbl -0x7feead98(%ecx),%ebx
80104904:	39 c3                	cmp    %eax,%ebx
80104906:	75 e8                	jne    801048f0 <mycpu+0x20>
}
80104908:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
8010490b:	8d 81 60 52 11 80    	lea    -0x7feeada0(%ecx),%eax
}
80104911:	5b                   	pop    %ebx
80104912:	5e                   	pop    %esi
80104913:	5d                   	pop    %ebp
80104914:	c3                   	ret    
  panic("unknown apicid\n");
80104915:	83 ec 0c             	sub    $0xc,%esp
80104918:	68 a7 9c 10 80       	push   $0x80109ca7
8010491d:	e8 ae bb ff ff       	call   801004d0 <panic>
    panic("mycpu called with interrupts enabled\n");
80104922:	83 ec 0c             	sub    $0xc,%esp
80104925:	68 a8 9d 10 80       	push   $0x80109da8
8010492a:	e8 a1 bb ff ff       	call   801004d0 <panic>
8010492f:	90                   	nop

80104930 <cpuid>:
cpuid() {
80104930:	55                   	push   %ebp
80104931:	89 e5                	mov    %esp,%ebp
80104933:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80104936:	e8 95 ff ff ff       	call   801048d0 <mycpu>
}
8010493b:	c9                   	leave  
  return mycpu()-cpus;
8010493c:	2d 60 52 11 80       	sub    $0x80115260,%eax
80104941:	c1 f8 02             	sar    $0x2,%eax
80104944:	69 c0 cf 46 7d 67    	imul   $0x677d46cf,%eax,%eax
}
8010494a:	c3                   	ret    
8010494b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010494f:	90                   	nop

80104950 <myproc>:
myproc(void) {
80104950:	55                   	push   %ebp
80104951:	89 e5                	mov    %esp,%ebp
80104953:	53                   	push   %ebx
80104954:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104957:	e8 74 14 00 00       	call   80105dd0 <pushcli>
  c = mycpu();
8010495c:	e8 6f ff ff ff       	call   801048d0 <mycpu>
  p = c->proc;
80104961:	8b 98 b4 00 00 00    	mov    0xb4(%eax),%ebx
  popcli();
80104967:	e8 b4 14 00 00       	call   80105e20 <popcli>
}
8010496c:	89 d8                	mov    %ebx,%eax
8010496e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104971:	c9                   	leave  
80104972:	c3                   	ret    
80104973:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010497a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104980 <userinit>:
{
80104980:	55                   	push   %ebp
80104981:	89 e5                	mov    %esp,%ebp
80104983:	53                   	push   %ebx
80104984:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80104987:	e8 94 fd ff ff       	call   80104720 <allocproc>
8010498c:	89 c3                	mov    %eax,%ebx
  initproc = p;
8010498e:	a3 74 a8 34 80       	mov    %eax,0x8034a874
  if((p->pgdir = setupkvm()) == 0)
80104993:	e8 38 4a 00 00       	call   801093d0 <setupkvm>
80104998:	89 43 04             	mov    %eax,0x4(%ebx)
8010499b:	85 c0                	test   %eax,%eax
8010499d:	0f 84 bd 00 00 00    	je     80104a60 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801049a3:	83 ec 04             	sub    $0x4,%esp
801049a6:	68 2c 00 00 00       	push   $0x2c
801049ab:	68 00 d8 10 80       	push   $0x8010d800
801049b0:	50                   	push   %eax
801049b1:	e8 ca 46 00 00       	call   80109080 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
801049b6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
801049b9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801049bf:	6a 4c                	push   $0x4c
801049c1:	6a 00                	push   $0x0
801049c3:	ff 73 18             	push   0x18(%ebx)
801049c6:	e8 45 17 00 00       	call   80106110 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801049cb:	8b 43 18             	mov    0x18(%ebx),%eax
801049ce:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
801049d3:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801049d6:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801049db:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801049df:	8b 43 18             	mov    0x18(%ebx),%eax
801049e2:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
801049e6:	8b 43 18             	mov    0x18(%ebx),%eax
801049e9:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801049ed:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801049f1:	8b 43 18             	mov    0x18(%ebx),%eax
801049f4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801049f8:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801049fc:	8b 43 18             	mov    0x18(%ebx),%eax
801049ff:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80104a06:	8b 43 18             	mov    0x18(%ebx),%eax
80104a09:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80104a10:	8b 43 18             	mov    0x18(%ebx),%eax
80104a13:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80104a1a:	8d 43 6c             	lea    0x6c(%ebx),%eax
80104a1d:	6a 10                	push   $0x10
80104a1f:	68 d0 9c 10 80       	push   $0x80109cd0
80104a24:	50                   	push   %eax
80104a25:	e8 a6 18 00 00       	call   801062d0 <safestrcpy>
  p->cwd = namei("/");
80104a2a:	c7 04 24 d9 9c 10 80 	movl   $0x80109cd9,(%esp)
80104a31:	e8 ba e5 ff ff       	call   80102ff0 <namei>
80104a36:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80104a39:	c7 04 24 40 58 11 80 	movl   $0x80115840,(%esp)
80104a40:	e8 db 14 00 00       	call   80105f20 <acquire>
  p->state = RUNNABLE;
80104a45:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80104a4c:	c7 04 24 40 58 11 80 	movl   $0x80115840,(%esp)
80104a53:	e8 68 14 00 00       	call   80105ec0 <release>
}
80104a58:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a5b:	83 c4 10             	add    $0x10,%esp
80104a5e:	c9                   	leave  
80104a5f:	c3                   	ret    
    panic("userinit: out of memory?");
80104a60:	83 ec 0c             	sub    $0xc,%esp
80104a63:	68 b7 9c 10 80       	push   $0x80109cb7
80104a68:	e8 63 ba ff ff       	call   801004d0 <panic>
80104a6d:	8d 76 00             	lea    0x0(%esi),%esi

80104a70 <growproc>:
{
80104a70:	55                   	push   %ebp
80104a71:	89 e5                	mov    %esp,%ebp
80104a73:	56                   	push   %esi
80104a74:	53                   	push   %ebx
80104a75:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80104a78:	e8 53 13 00 00       	call   80105dd0 <pushcli>
  c = mycpu();
80104a7d:	e8 4e fe ff ff       	call   801048d0 <mycpu>
  p = c->proc;
80104a82:	8b 98 b4 00 00 00    	mov    0xb4(%eax),%ebx
  popcli();
80104a88:	e8 93 13 00 00       	call   80105e20 <popcli>
  sz = curproc->sz;
80104a8d:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80104a8f:	85 f6                	test   %esi,%esi
80104a91:	7f 1d                	jg     80104ab0 <growproc+0x40>
  } else if(n < 0){
80104a93:	75 3b                	jne    80104ad0 <growproc+0x60>
  switchuvm(curproc);
80104a95:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80104a98:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80104a9a:	53                   	push   %ebx
80104a9b:	e8 d0 44 00 00       	call   80108f70 <switchuvm>
  return 0;
80104aa0:	83 c4 10             	add    $0x10,%esp
80104aa3:	31 c0                	xor    %eax,%eax
}
80104aa5:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104aa8:	5b                   	pop    %ebx
80104aa9:	5e                   	pop    %esi
80104aaa:	5d                   	pop    %ebp
80104aab:	c3                   	ret    
80104aac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104ab0:	83 ec 04             	sub    $0x4,%esp
80104ab3:	01 c6                	add    %eax,%esi
80104ab5:	56                   	push   %esi
80104ab6:	50                   	push   %eax
80104ab7:	ff 73 04             	push   0x4(%ebx)
80104aba:	e8 31 47 00 00       	call   801091f0 <allocuvm>
80104abf:	83 c4 10             	add    $0x10,%esp
80104ac2:	85 c0                	test   %eax,%eax
80104ac4:	75 cf                	jne    80104a95 <growproc+0x25>
      return -1;
80104ac6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104acb:	eb d8                	jmp    80104aa5 <growproc+0x35>
80104acd:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104ad0:	83 ec 04             	sub    $0x4,%esp
80104ad3:	01 c6                	add    %eax,%esi
80104ad5:	56                   	push   %esi
80104ad6:	50                   	push   %eax
80104ad7:	ff 73 04             	push   0x4(%ebx)
80104ada:	e8 41 48 00 00       	call   80109320 <deallocuvm>
80104adf:	83 c4 10             	add    $0x10,%esp
80104ae2:	85 c0                	test   %eax,%eax
80104ae4:	75 af                	jne    80104a95 <growproc+0x25>
80104ae6:	eb de                	jmp    80104ac6 <growproc+0x56>
80104ae8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104aef:	90                   	nop

80104af0 <fork>:
{
80104af0:	55                   	push   %ebp
80104af1:	89 e5                	mov    %esp,%ebp
80104af3:	57                   	push   %edi
80104af4:	56                   	push   %esi
80104af5:	53                   	push   %ebx
80104af6:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80104af9:	e8 d2 12 00 00       	call   80105dd0 <pushcli>
  c = mycpu();
80104afe:	e8 cd fd ff ff       	call   801048d0 <mycpu>
  p = c->proc;
80104b03:	8b 98 b4 00 00 00    	mov    0xb4(%eax),%ebx
  popcli();
80104b09:	e8 12 13 00 00       	call   80105e20 <popcli>
  if((np = allocproc()) == 0){
80104b0e:	e8 0d fc ff ff       	call   80104720 <allocproc>
80104b13:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104b16:	85 c0                	test   %eax,%eax
80104b18:	0f 84 b7 00 00 00    	je     80104bd5 <fork+0xe5>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80104b1e:	83 ec 08             	sub    $0x8,%esp
80104b21:	ff 33                	push   (%ebx)
80104b23:	89 c7                	mov    %eax,%edi
80104b25:	ff 73 04             	push   0x4(%ebx)
80104b28:	e8 93 49 00 00       	call   801094c0 <copyuvm>
80104b2d:	83 c4 10             	add    $0x10,%esp
80104b30:	89 47 04             	mov    %eax,0x4(%edi)
80104b33:	85 c0                	test   %eax,%eax
80104b35:	0f 84 a1 00 00 00    	je     80104bdc <fork+0xec>
  np->sz = curproc->sz;
80104b3b:	8b 03                	mov    (%ebx),%eax
80104b3d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104b40:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80104b42:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80104b45:	89 c8                	mov    %ecx,%eax
80104b47:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80104b4a:	b9 13 00 00 00       	mov    $0x13,%ecx
80104b4f:	8b 73 18             	mov    0x18(%ebx),%esi
80104b52:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80104b54:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80104b56:	8b 40 18             	mov    0x18(%eax),%eax
80104b59:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80104b60:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80104b64:	85 c0                	test   %eax,%eax
80104b66:	74 13                	je     80104b7b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80104b68:	83 ec 0c             	sub    $0xc,%esp
80104b6b:	50                   	push   %eax
80104b6c:	e8 7f d2 ff ff       	call   80101df0 <filedup>
80104b71:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104b74:	83 c4 10             	add    $0x10,%esp
80104b77:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80104b7b:	83 c6 01             	add    $0x1,%esi
80104b7e:	83 fe 10             	cmp    $0x10,%esi
80104b81:	75 dd                	jne    80104b60 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80104b83:	83 ec 0c             	sub    $0xc,%esp
80104b86:	ff 73 68             	push   0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104b89:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80104b8c:	e8 0f db ff ff       	call   801026a0 <idup>
80104b91:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104b94:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80104b97:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104b9a:	8d 47 6c             	lea    0x6c(%edi),%eax
80104b9d:	6a 10                	push   $0x10
80104b9f:	53                   	push   %ebx
80104ba0:	50                   	push   %eax
80104ba1:	e8 2a 17 00 00       	call   801062d0 <safestrcpy>
  pid = np->pid;
80104ba6:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80104ba9:	c7 04 24 40 58 11 80 	movl   $0x80115840,(%esp)
80104bb0:	e8 6b 13 00 00       	call   80105f20 <acquire>
  np->state = RUNNABLE;
80104bb5:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80104bbc:	c7 04 24 40 58 11 80 	movl   $0x80115840,(%esp)
80104bc3:	e8 f8 12 00 00       	call   80105ec0 <release>
  return pid;
80104bc8:	83 c4 10             	add    $0x10,%esp
}
80104bcb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104bce:	89 d8                	mov    %ebx,%eax
80104bd0:	5b                   	pop    %ebx
80104bd1:	5e                   	pop    %esi
80104bd2:	5f                   	pop    %edi
80104bd3:	5d                   	pop    %ebp
80104bd4:	c3                   	ret    
    return -1;
80104bd5:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104bda:	eb ef                	jmp    80104bcb <fork+0xdb>
    kfree(np->kstack);
80104bdc:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80104bdf:	83 ec 0c             	sub    $0xc,%esp
80104be2:	ff 73 08             	push   0x8(%ebx)
80104be5:	e8 26 e8 ff ff       	call   80103410 <kfree>
    np->kstack = 0;
80104bea:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80104bf1:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80104bf4:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80104bfb:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104c00:	eb c9                	jmp    80104bcb <fork+0xdb>
80104c02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104c10 <generate_random_integer>:
generate_random_integer(int degree, int max_num) {
80104c10:	55                   	push   %ebp
  int pw = ticks % max_num;
80104c11:	31 d2                	xor    %edx,%edx
generate_random_integer(int degree, int max_num) {
80104c13:	89 e5                	mov    %esp,%ebp
80104c15:	57                   	push   %edi
80104c16:	56                   	push   %esi
80104c17:	53                   	push   %ebx
80104c18:	83 ec 28             	sub    $0x28,%esp
  int pw = ticks % max_num;
80104c1b:	a1 84 a8 34 80       	mov    0x8034a884,%eax
generate_random_integer(int degree, int max_num) {
80104c20:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104c23:	8b 7d 08             	mov    0x8(%ebp),%edi
  int pw = ticks % max_num;
80104c26:	89 45 d0             	mov    %eax,-0x30(%ebp)
80104c29:	f7 f3                	div    %ebx
  int coeff[8] = {1, 17, 7};
80104c2b:	31 c0                	xor    %eax,%eax
  int pw = ticks % max_num;
80104c2d:	89 d1                	mov    %edx,%ecx
  int coeff[8] = {1, 17, 7};
80104c2f:	31 d2                	xor    %edx,%edx
80104c31:	89 54 05 d4          	mov    %edx,-0x2c(%ebp,%eax,1)
80104c35:	83 c0 04             	add    $0x4,%eax
80104c38:	83 f8 20             	cmp    $0x20,%eax
80104c3b:	72 f4                	jb     80104c31 <generate_random_integer+0x21>
80104c3d:	c7 45 dc 07 00 00 00 	movl   $0x7,-0x24(%ebp)
  for (int i=1; i<=degree; i++) {
80104c44:	85 ff                	test   %edi,%edi
80104c46:	7e 42                	jle    80104c8a <generate_random_integer+0x7a>
80104c48:	8d 75 d4             	lea    -0x2c(%ebp),%esi
80104c4b:	8d 04 be             	lea    (%esi,%edi,4),%eax
  int rand = 0;
80104c4e:	31 ff                	xor    %edi,%edi
80104c50:	89 45 cc             	mov    %eax,-0x34(%ebp)
  for (int i=1; i<=degree; i++) {
80104c53:	b8 11 00 00 00       	mov    $0x11,%eax
80104c58:	eb 09                	jmp    80104c63 <generate_random_integer+0x53>
80104c5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    rand += coeff[i] * pw;
80104c60:	8b 46 04             	mov    0x4(%esi),%eax
80104c63:	0f af c1             	imul   %ecx,%eax
  for (int i=1; i<=degree; i++) {
80104c66:	83 c6 04             	add    $0x4,%esi
    rand += coeff[i] * pw;
80104c69:	01 f8                	add    %edi,%eax
    rand %= max_num;
80104c6b:	99                   	cltd   
80104c6c:	f7 fb                	idiv   %ebx
    pw *= ticks;
80104c6e:	8b 45 d0             	mov    -0x30(%ebp),%eax
80104c71:	0f af c1             	imul   %ecx,%eax
    rand %= max_num;
80104c74:	89 d7                	mov    %edx,%edi
    pw %= max_num;
80104c76:	99                   	cltd   
80104c77:	f7 fb                	idiv   %ebx
80104c79:	89 d1                	mov    %edx,%ecx
  for (int i=1; i<=degree; i++) {
80104c7b:	39 75 cc             	cmp    %esi,-0x34(%ebp)
80104c7e:	75 e0                	jne    80104c60 <generate_random_integer+0x50>
}
80104c80:	83 c4 28             	add    $0x28,%esp
80104c83:	89 f8                	mov    %edi,%eax
80104c85:	5b                   	pop    %ebx
80104c86:	5e                   	pop    %esi
80104c87:	5f                   	pop    %edi
80104c88:	5d                   	pop    %ebp
80104c89:	c3                   	ret    
80104c8a:	83 c4 28             	add    $0x28,%esp
  int rand = 0;
80104c8d:	31 ff                	xor    %edi,%edi
}
80104c8f:	5b                   	pop    %ebx
80104c90:	89 f8                	mov    %edi,%eax
80104c92:	5e                   	pop    %esi
80104c93:	5f                   	pop    %edi
80104c94:	5d                   	pop    %ebp
80104c95:	c3                   	ret    
80104c96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c9d:	8d 76 00             	lea    0x0(%esi),%esi

80104ca0 <sched>:
{
80104ca0:	55                   	push   %ebp
80104ca1:	89 e5                	mov    %esp,%ebp
80104ca3:	56                   	push   %esi
80104ca4:	53                   	push   %ebx
  pushcli();
80104ca5:	e8 26 11 00 00       	call   80105dd0 <pushcli>
  c = mycpu();
80104caa:	e8 21 fc ff ff       	call   801048d0 <mycpu>
  p = c->proc;
80104caf:	8b 98 b4 00 00 00    	mov    0xb4(%eax),%ebx
  popcli();
80104cb5:	e8 66 11 00 00       	call   80105e20 <popcli>
  if(!holding(&ptable.lock))
80104cba:	83 ec 0c             	sub    $0xc,%esp
80104cbd:	68 40 58 11 80       	push   $0x80115840
80104cc2:	e8 b9 11 00 00       	call   80105e80 <holding>
80104cc7:	83 c4 10             	add    $0x10,%esp
80104cca:	85 c0                	test   %eax,%eax
80104ccc:	74 4f                	je     80104d1d <sched+0x7d>
  if(mycpu()->ncli != 1)
80104cce:	e8 fd fb ff ff       	call   801048d0 <mycpu>
80104cd3:	83 b8 ac 00 00 00 01 	cmpl   $0x1,0xac(%eax)
80104cda:	75 68                	jne    80104d44 <sched+0xa4>
  if(p->state == RUNNING)
80104cdc:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80104ce0:	74 55                	je     80104d37 <sched+0x97>
80104ce2:	9c                   	pushf  
80104ce3:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104ce4:	f6 c4 02             	test   $0x2,%ah
80104ce7:	75 41                	jne    80104d2a <sched+0x8a>
  intena = mycpu()->intena;
80104ce9:	e8 e2 fb ff ff       	call   801048d0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80104cee:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80104cf1:	8b b0 b0 00 00 00    	mov    0xb0(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80104cf7:	e8 d4 fb ff ff       	call   801048d0 <mycpu>
80104cfc:	83 ec 08             	sub    $0x8,%esp
80104cff:	ff 70 0c             	push   0xc(%eax)
80104d02:	53                   	push   %ebx
80104d03:	e8 41 17 00 00       	call   80106449 <swtch>
  mycpu()->intena = intena;
80104d08:	e8 c3 fb ff ff       	call   801048d0 <mycpu>
}
80104d0d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80104d10:	89 b0 b0 00 00 00    	mov    %esi,0xb0(%eax)
}
80104d16:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d19:	5b                   	pop    %ebx
80104d1a:	5e                   	pop    %esi
80104d1b:	5d                   	pop    %ebp
80104d1c:	c3                   	ret    
    panic("sched ptable.lock");
80104d1d:	83 ec 0c             	sub    $0xc,%esp
80104d20:	68 db 9c 10 80       	push   $0x80109cdb
80104d25:	e8 a6 b7 ff ff       	call   801004d0 <panic>
    panic("sched interruptible");
80104d2a:	83 ec 0c             	sub    $0xc,%esp
80104d2d:	68 07 9d 10 80       	push   $0x80109d07
80104d32:	e8 99 b7 ff ff       	call   801004d0 <panic>
    panic("sched running");
80104d37:	83 ec 0c             	sub    $0xc,%esp
80104d3a:	68 f9 9c 10 80       	push   $0x80109cf9
80104d3f:	e8 8c b7 ff ff       	call   801004d0 <panic>
    panic("sched locks");
80104d44:	83 ec 0c             	sub    $0xc,%esp
80104d47:	68 ed 9c 10 80       	push   $0x80109ced
80104d4c:	e8 7f b7 ff ff       	call   801004d0 <panic>
80104d51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d5f:	90                   	nop

80104d60 <exit>:
{
80104d60:	55                   	push   %ebp
80104d61:	89 e5                	mov    %esp,%ebp
80104d63:	57                   	push   %edi
80104d64:	56                   	push   %esi
80104d65:	53                   	push   %ebx
80104d66:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80104d69:	e8 e2 fb ff ff       	call   80104950 <myproc>
  if(curproc == initproc)
80104d6e:	39 05 74 a8 34 80    	cmp    %eax,0x8034a874
80104d74:	0f 84 07 01 00 00    	je     80104e81 <exit+0x121>
80104d7a:	89 c3                	mov    %eax,%ebx
80104d7c:	8d 70 28             	lea    0x28(%eax),%esi
80104d7f:	8d 78 68             	lea    0x68(%eax),%edi
80104d82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
80104d88:	8b 06                	mov    (%esi),%eax
80104d8a:	85 c0                	test   %eax,%eax
80104d8c:	74 12                	je     80104da0 <exit+0x40>
      fileclose(curproc->ofile[fd]);
80104d8e:	83 ec 0c             	sub    $0xc,%esp
80104d91:	50                   	push   %eax
80104d92:	e8 a9 d0 ff ff       	call   80101e40 <fileclose>
      curproc->ofile[fd] = 0;
80104d97:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80104d9d:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80104da0:	83 c6 04             	add    $0x4,%esi
80104da3:	39 f7                	cmp    %esi,%edi
80104da5:	75 e1                	jne    80104d88 <exit+0x28>
  begin_op();
80104da7:	e8 04 ef ff ff       	call   80103cb0 <begin_op>
  iput(curproc->cwd);
80104dac:	83 ec 0c             	sub    $0xc,%esp
80104daf:	ff 73 68             	push   0x68(%ebx)
80104db2:	e8 49 da ff ff       	call   80102800 <iput>
  end_op();
80104db7:	e8 64 ef ff ff       	call   80103d20 <end_op>
  curproc->cwd = 0;
80104dbc:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
80104dc3:	c7 04 24 40 58 11 80 	movl   $0x80115840,(%esp)
80104dca:	e8 51 11 00 00       	call   80105f20 <acquire>
  wakeup1(curproc->parent);
80104dcf:	8b 53 14             	mov    0x14(%ebx),%edx
80104dd2:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104dd5:	b8 74 58 11 80       	mov    $0x80115874,%eax
80104dda:	eb 10                	jmp    80104dec <exit+0x8c>
80104ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104de0:	05 40 8d 00 00       	add    $0x8d40,%eax
80104de5:	3d 74 a8 34 80       	cmp    $0x8034a874,%eax
80104dea:	74 1e                	je     80104e0a <exit+0xaa>
    if(p->state == SLEEPING && p->chan == chan)
80104dec:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104df0:	75 ee                	jne    80104de0 <exit+0x80>
80104df2:	3b 50 20             	cmp    0x20(%eax),%edx
80104df5:	75 e9                	jne    80104de0 <exit+0x80>
      p->state = RUNNABLE;
80104df7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104dfe:	05 40 8d 00 00       	add    $0x8d40,%eax
80104e03:	3d 74 a8 34 80       	cmp    $0x8034a874,%eax
80104e08:	75 e2                	jne    80104dec <exit+0x8c>
      p->parent = initproc;
80104e0a:	8b 0d 74 a8 34 80    	mov    0x8034a874,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104e10:	ba 74 58 11 80       	mov    $0x80115874,%edx
80104e15:	eb 17                	jmp    80104e2e <exit+0xce>
80104e17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e1e:	66 90                	xchg   %ax,%ax
80104e20:	81 c2 40 8d 00 00    	add    $0x8d40,%edx
80104e26:	81 fa 74 a8 34 80    	cmp    $0x8034a874,%edx
80104e2c:	74 3a                	je     80104e68 <exit+0x108>
    if(p->parent == curproc){
80104e2e:	39 5a 14             	cmp    %ebx,0x14(%edx)
80104e31:	75 ed                	jne    80104e20 <exit+0xc0>
      if(p->state == ZOMBIE)
80104e33:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80104e37:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80104e3a:	75 e4                	jne    80104e20 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104e3c:	b8 74 58 11 80       	mov    $0x80115874,%eax
80104e41:	eb 11                	jmp    80104e54 <exit+0xf4>
80104e43:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104e47:	90                   	nop
80104e48:	05 40 8d 00 00       	add    $0x8d40,%eax
80104e4d:	3d 74 a8 34 80       	cmp    $0x8034a874,%eax
80104e52:	74 cc                	je     80104e20 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80104e54:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104e58:	75 ee                	jne    80104e48 <exit+0xe8>
80104e5a:	3b 48 20             	cmp    0x20(%eax),%ecx
80104e5d:	75 e9                	jne    80104e48 <exit+0xe8>
      p->state = RUNNABLE;
80104e5f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104e66:	eb e0                	jmp    80104e48 <exit+0xe8>
  curproc->state = ZOMBIE;
80104e68:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80104e6f:	e8 2c fe ff ff       	call   80104ca0 <sched>
  panic("zombie exit");
80104e74:	83 ec 0c             	sub    $0xc,%esp
80104e77:	68 28 9d 10 80       	push   $0x80109d28
80104e7c:	e8 4f b6 ff ff       	call   801004d0 <panic>
    panic("init exiting");
80104e81:	83 ec 0c             	sub    $0xc,%esp
80104e84:	68 1b 9d 10 80       	push   $0x80109d1b
80104e89:	e8 42 b6 ff ff       	call   801004d0 <panic>
80104e8e:	66 90                	xchg   %ax,%ax

80104e90 <wait>:
{
80104e90:	55                   	push   %ebp
80104e91:	89 e5                	mov    %esp,%ebp
80104e93:	56                   	push   %esi
80104e94:	53                   	push   %ebx
  pushcli();
80104e95:	e8 36 0f 00 00       	call   80105dd0 <pushcli>
  c = mycpu();
80104e9a:	e8 31 fa ff ff       	call   801048d0 <mycpu>
  p = c->proc;
80104e9f:	8b b0 b4 00 00 00    	mov    0xb4(%eax),%esi
  popcli();
80104ea5:	e8 76 0f 00 00       	call   80105e20 <popcli>
  acquire(&ptable.lock);
80104eaa:	83 ec 0c             	sub    $0xc,%esp
80104ead:	68 40 58 11 80       	push   $0x80115840
80104eb2:	e8 69 10 00 00       	call   80105f20 <acquire>
80104eb7:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80104eba:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104ebc:	bb 74 58 11 80       	mov    $0x80115874,%ebx
80104ec1:	eb 13                	jmp    80104ed6 <wait+0x46>
80104ec3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ec7:	90                   	nop
80104ec8:	81 c3 40 8d 00 00    	add    $0x8d40,%ebx
80104ece:	81 fb 74 a8 34 80    	cmp    $0x8034a874,%ebx
80104ed4:	74 1e                	je     80104ef4 <wait+0x64>
      if(p->parent != curproc)
80104ed6:	39 73 14             	cmp    %esi,0x14(%ebx)
80104ed9:	75 ed                	jne    80104ec8 <wait+0x38>
      if(p->state == ZOMBIE){
80104edb:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104edf:	74 5f                	je     80104f40 <wait+0xb0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104ee1:	81 c3 40 8d 00 00    	add    $0x8d40,%ebx
      havekids = 1;
80104ee7:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104eec:	81 fb 74 a8 34 80    	cmp    $0x8034a874,%ebx
80104ef2:	75 e2                	jne    80104ed6 <wait+0x46>
    if(!havekids || curproc->killed){
80104ef4:	85 c0                	test   %eax,%eax
80104ef6:	0f 84 9a 00 00 00    	je     80104f96 <wait+0x106>
80104efc:	8b 46 24             	mov    0x24(%esi),%eax
80104eff:	85 c0                	test   %eax,%eax
80104f01:	0f 85 8f 00 00 00    	jne    80104f96 <wait+0x106>
  pushcli();
80104f07:	e8 c4 0e 00 00       	call   80105dd0 <pushcli>
  c = mycpu();
80104f0c:	e8 bf f9 ff ff       	call   801048d0 <mycpu>
  p = c->proc;
80104f11:	8b 98 b4 00 00 00    	mov    0xb4(%eax),%ebx
  popcli();
80104f17:	e8 04 0f 00 00       	call   80105e20 <popcli>
  if(p == 0)
80104f1c:	85 db                	test   %ebx,%ebx
80104f1e:	0f 84 89 00 00 00    	je     80104fad <wait+0x11d>
  p->chan = chan;
80104f24:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80104f27:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104f2e:	e8 6d fd ff ff       	call   80104ca0 <sched>
  p->chan = 0;
80104f33:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104f3a:	e9 7b ff ff ff       	jmp    80104eba <wait+0x2a>
80104f3f:	90                   	nop
        kfree(p->kstack);
80104f40:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
80104f43:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104f46:	ff 73 08             	push   0x8(%ebx)
80104f49:	e8 c2 e4 ff ff       	call   80103410 <kfree>
        p->kstack = 0;
80104f4e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104f55:	5a                   	pop    %edx
80104f56:	ff 73 04             	push   0x4(%ebx)
80104f59:	e8 f2 43 00 00       	call   80109350 <freevm>
        p->pid = 0;
80104f5e:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104f65:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104f6c:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104f70:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104f77:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80104f7e:	c7 04 24 40 58 11 80 	movl   $0x80115840,(%esp)
80104f85:	e8 36 0f 00 00       	call   80105ec0 <release>
        return pid;
80104f8a:	83 c4 10             	add    $0x10,%esp
}
80104f8d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f90:	89 f0                	mov    %esi,%eax
80104f92:	5b                   	pop    %ebx
80104f93:	5e                   	pop    %esi
80104f94:	5d                   	pop    %ebp
80104f95:	c3                   	ret    
      release(&ptable.lock);
80104f96:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104f99:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104f9e:	68 40 58 11 80       	push   $0x80115840
80104fa3:	e8 18 0f 00 00       	call   80105ec0 <release>
      return -1;
80104fa8:	83 c4 10             	add    $0x10,%esp
80104fab:	eb e0                	jmp    80104f8d <wait+0xfd>
    panic("sleep");
80104fad:	83 ec 0c             	sub    $0xc,%esp
80104fb0:	68 34 9d 10 80       	push   $0x80109d34
80104fb5:	e8 16 b5 ff ff       	call   801004d0 <panic>
80104fba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104fc0 <yield>:
{
80104fc0:	55                   	push   %ebp
80104fc1:	89 e5                	mov    %esp,%ebp
80104fc3:	56                   	push   %esi
80104fc4:	53                   	push   %ebx
  acquire(&ptable.lock);  //DOC: yieldlock
80104fc5:	83 ec 0c             	sub    $0xc,%esp
80104fc8:	68 40 58 11 80       	push   $0x80115840
80104fcd:	e8 4e 0f 00 00       	call   80105f20 <acquire>
  pushcli();
80104fd2:	e8 f9 0d 00 00       	call   80105dd0 <pushcli>
  c = mycpu();
80104fd7:	e8 f4 f8 ff ff       	call   801048d0 <mycpu>
  p = c->proc;
80104fdc:	8b 98 b4 00 00 00    	mov    0xb4(%eax),%ebx
  popcli();
80104fe2:	e8 39 0e 00 00       	call   80105e20 <popcli>
  myproc()->sched_info.last_running_time = ticks;
80104fe7:	8b 35 84 a8 34 80    	mov    0x8034a884,%esi
  myproc()->state = RUNNABLE;
80104fed:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  pushcli();
80104ff4:	e8 d7 0d 00 00       	call   80105dd0 <pushcli>
  c = mycpu();
80104ff9:	e8 d2 f8 ff ff       	call   801048d0 <mycpu>
  p = c->proc;
80104ffe:	8b 98 b4 00 00 00    	mov    0xb4(%eax),%ebx
  popcli();
80105004:	e8 17 0e 00 00       	call   80105e20 <popcli>
  myproc()->sched_info.last_running_time = ticks;
80105009:	89 b3 34 8d 00 00    	mov    %esi,0x8d34(%ebx)
  sched();
8010500f:	e8 8c fc ff ff       	call   80104ca0 <sched>
  release(&ptable.lock);
80105014:	c7 04 24 40 58 11 80 	movl   $0x80115840,(%esp)
8010501b:	e8 a0 0e 00 00       	call   80105ec0 <release>
}
80105020:	83 c4 10             	add    $0x10,%esp
80105023:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105026:	5b                   	pop    %ebx
80105027:	5e                   	pop    %esi
80105028:	5d                   	pop    %ebp
80105029:	c3                   	ret    
8010502a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105030 <sleep>:
{
80105030:	55                   	push   %ebp
80105031:	89 e5                	mov    %esp,%ebp
80105033:	57                   	push   %edi
80105034:	56                   	push   %esi
80105035:	53                   	push   %ebx
80105036:	83 ec 0c             	sub    $0xc,%esp
80105039:	8b 7d 08             	mov    0x8(%ebp),%edi
8010503c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
8010503f:	e8 8c 0d 00 00       	call   80105dd0 <pushcli>
  c = mycpu();
80105044:	e8 87 f8 ff ff       	call   801048d0 <mycpu>
  p = c->proc;
80105049:	8b 98 b4 00 00 00    	mov    0xb4(%eax),%ebx
  popcli();
8010504f:	e8 cc 0d 00 00       	call   80105e20 <popcli>
  if(p == 0)
80105054:	85 db                	test   %ebx,%ebx
80105056:	0f 84 87 00 00 00    	je     801050e3 <sleep+0xb3>
  if(lk == 0)
8010505c:	85 f6                	test   %esi,%esi
8010505e:	74 76                	je     801050d6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80105060:	81 fe 40 58 11 80    	cmp    $0x80115840,%esi
80105066:	74 50                	je     801050b8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80105068:	83 ec 0c             	sub    $0xc,%esp
8010506b:	68 40 58 11 80       	push   $0x80115840
80105070:	e8 ab 0e 00 00       	call   80105f20 <acquire>
    release(lk);
80105075:	89 34 24             	mov    %esi,(%esp)
80105078:	e8 43 0e 00 00       	call   80105ec0 <release>
  p->chan = chan;
8010507d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80105080:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80105087:	e8 14 fc ff ff       	call   80104ca0 <sched>
  p->chan = 0;
8010508c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80105093:	c7 04 24 40 58 11 80 	movl   $0x80115840,(%esp)
8010509a:	e8 21 0e 00 00       	call   80105ec0 <release>
    acquire(lk);
8010509f:	89 75 08             	mov    %esi,0x8(%ebp)
801050a2:	83 c4 10             	add    $0x10,%esp
}
801050a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801050a8:	5b                   	pop    %ebx
801050a9:	5e                   	pop    %esi
801050aa:	5f                   	pop    %edi
801050ab:	5d                   	pop    %ebp
    acquire(lk);
801050ac:	e9 6f 0e 00 00       	jmp    80105f20 <acquire>
801050b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
801050b8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801050bb:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801050c2:	e8 d9 fb ff ff       	call   80104ca0 <sched>
  p->chan = 0;
801050c7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
801050ce:	8d 65 f4             	lea    -0xc(%ebp),%esp
801050d1:	5b                   	pop    %ebx
801050d2:	5e                   	pop    %esi
801050d3:	5f                   	pop    %edi
801050d4:	5d                   	pop    %ebp
801050d5:	c3                   	ret    
    panic("sleep without lk");
801050d6:	83 ec 0c             	sub    $0xc,%esp
801050d9:	68 3a 9d 10 80       	push   $0x80109d3a
801050de:	e8 ed b3 ff ff       	call   801004d0 <panic>
    panic("sleep");
801050e3:	83 ec 0c             	sub    $0xc,%esp
801050e6:	68 34 9d 10 80       	push   $0x80109d34
801050eb:	e8 e0 b3 ff ff       	call   801004d0 <panic>

801050f0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801050f0:	55                   	push   %ebp
801050f1:	89 e5                	mov    %esp,%ebp
801050f3:	53                   	push   %ebx
801050f4:	83 ec 10             	sub    $0x10,%esp
801050f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801050fa:	68 40 58 11 80       	push   $0x80115840
801050ff:	e8 1c 0e 00 00       	call   80105f20 <acquire>
80105104:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105107:	b8 74 58 11 80       	mov    $0x80115874,%eax
8010510c:	eb 0e                	jmp    8010511c <wakeup+0x2c>
8010510e:	66 90                	xchg   %ax,%ax
80105110:	05 40 8d 00 00       	add    $0x8d40,%eax
80105115:	3d 74 a8 34 80       	cmp    $0x8034a874,%eax
8010511a:	74 1e                	je     8010513a <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
8010511c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80105120:	75 ee                	jne    80105110 <wakeup+0x20>
80105122:	3b 58 20             	cmp    0x20(%eax),%ebx
80105125:	75 e9                	jne    80105110 <wakeup+0x20>
      p->state = RUNNABLE;
80105127:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010512e:	05 40 8d 00 00       	add    $0x8d40,%eax
80105133:	3d 74 a8 34 80       	cmp    $0x8034a874,%eax
80105138:	75 e2                	jne    8010511c <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
8010513a:	c7 45 08 40 58 11 80 	movl   $0x80115840,0x8(%ebp)
}
80105141:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105144:	c9                   	leave  
  release(&ptable.lock);
80105145:	e9 76 0d 00 00       	jmp    80105ec0 <release>
8010514a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105150 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80105150:	55                   	push   %ebp
80105151:	89 e5                	mov    %esp,%ebp
80105153:	53                   	push   %ebx
80105154:	83 ec 10             	sub    $0x10,%esp
80105157:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010515a:	68 40 58 11 80       	push   $0x80115840
8010515f:	e8 bc 0d 00 00       	call   80105f20 <acquire>
80105164:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105167:	b8 74 58 11 80       	mov    $0x80115874,%eax
8010516c:	eb 0e                	jmp    8010517c <kill+0x2c>
8010516e:	66 90                	xchg   %ax,%ax
80105170:	05 40 8d 00 00       	add    $0x8d40,%eax
80105175:	3d 74 a8 34 80       	cmp    $0x8034a874,%eax
8010517a:	74 34                	je     801051b0 <kill+0x60>
    if(p->pid == pid){
8010517c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010517f:	75 ef                	jne    80105170 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80105181:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80105185:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010518c:	75 07                	jne    80105195 <kill+0x45>
        p->state = RUNNABLE;
8010518e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80105195:	83 ec 0c             	sub    $0xc,%esp
80105198:	68 40 58 11 80       	push   $0x80115840
8010519d:	e8 1e 0d 00 00       	call   80105ec0 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
801051a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
801051a5:	83 c4 10             	add    $0x10,%esp
801051a8:	31 c0                	xor    %eax,%eax
}
801051aa:	c9                   	leave  
801051ab:	c3                   	ret    
801051ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
801051b0:	83 ec 0c             	sub    $0xc,%esp
801051b3:	68 40 58 11 80       	push   $0x80115840
801051b8:	e8 03 0d 00 00       	call   80105ec0 <release>
}
801051bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
801051c0:	83 c4 10             	add    $0x10,%esp
801051c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801051c8:	c9                   	leave  
801051c9:	c3                   	ret    
801051ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801051d0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801051d0:	55                   	push   %ebp
801051d1:	89 e5                	mov    %esp,%ebp
801051d3:	57                   	push   %edi
801051d4:	56                   	push   %esi
801051d5:	8d 75 e8             	lea    -0x18(%ebp),%esi
801051d8:	53                   	push   %ebx
801051d9:	bb e0 58 11 80       	mov    $0x801158e0,%ebx
801051de:	83 ec 3c             	sub    $0x3c,%esp
801051e1:	eb 27                	jmp    8010520a <procdump+0x3a>
801051e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801051e7:	90                   	nop
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801051e8:	83 ec 0c             	sub    $0xc,%esp
801051eb:	68 b0 a3 10 80       	push   $0x8010a3b0
801051f0:	e8 fb b5 ff ff       	call   801007f0 <cprintf>
801051f5:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801051f8:	81 c3 40 8d 00 00    	add    $0x8d40,%ebx
801051fe:	81 fb e0 a8 34 80    	cmp    $0x8034a8e0,%ebx
80105204:	0f 84 7e 00 00 00    	je     80105288 <procdump+0xb8>
    if(p->state == UNUSED)
8010520a:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010520d:	85 c0                	test   %eax,%eax
8010520f:	74 e7                	je     801051f8 <procdump+0x28>
      state = "???";
80105211:	ba 4b 9d 10 80       	mov    $0x80109d4b,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80105216:	83 f8 05             	cmp    $0x5,%eax
80105219:	77 11                	ja     8010522c <procdump+0x5c>
8010521b:	8b 14 85 dc 9e 10 80 	mov    -0x7fef6124(,%eax,4),%edx
      state = "???";
80105222:	b8 4b 9d 10 80       	mov    $0x80109d4b,%eax
80105227:	85 d2                	test   %edx,%edx
80105229:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
8010522c:	53                   	push   %ebx
8010522d:	52                   	push   %edx
8010522e:	ff 73 a4             	push   -0x5c(%ebx)
80105231:	68 4f 9d 10 80       	push   $0x80109d4f
80105236:	e8 b5 b5 ff ff       	call   801007f0 <cprintf>
    if(p->state == SLEEPING){
8010523b:	83 c4 10             	add    $0x10,%esp
8010523e:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80105242:	75 a4                	jne    801051e8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80105244:	83 ec 08             	sub    $0x8,%esp
80105247:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010524a:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010524d:	50                   	push   %eax
8010524e:	8b 43 b0             	mov    -0x50(%ebx),%eax
80105251:	8b 40 0c             	mov    0xc(%eax),%eax
80105254:	83 c0 08             	add    $0x8,%eax
80105257:	50                   	push   %eax
80105258:	e8 13 0b 00 00       	call   80105d70 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
8010525d:	83 c4 10             	add    $0x10,%esp
80105260:	8b 17                	mov    (%edi),%edx
80105262:	85 d2                	test   %edx,%edx
80105264:	74 82                	je     801051e8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80105266:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80105269:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
8010526c:	52                   	push   %edx
8010526d:	68 61 97 10 80       	push   $0x80109761
80105272:	e8 79 b5 ff ff       	call   801007f0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80105277:	83 c4 10             	add    $0x10,%esp
8010527a:	39 fe                	cmp    %edi,%esi
8010527c:	75 e2                	jne    80105260 <procdump+0x90>
8010527e:	e9 65 ff ff ff       	jmp    801051e8 <procdump+0x18>
80105283:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105287:	90                   	nop
  }
}
80105288:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010528b:	5b                   	pop    %ebx
8010528c:	5e                   	pop    %esi
8010528d:	5f                   	pop    %edi
8010528e:	5d                   	pop    %ebp
8010528f:	c3                   	ret    

80105290 <create_palindrome>:

int 
create_palindrome(int num)
{
80105290:	55                   	push   %ebp
80105291:	89 e5                	mov    %esp,%ebp
80105293:	57                   	push   %edi
80105294:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105297:	56                   	push   %esi
80105298:	53                   	push   %ebx
    //printf("The number is :%d\n",num);
 
    temp = num;
    
    //loop to find reverse number
    while(temp != 0)
80105299:	85 c9                	test   %ecx,%ecx
8010529b:	74 43                	je     801052e0 <create_palindrome+0x50>
8010529d:	89 cb                	mov    %ecx,%ebx
    int reverse = 0, rem, temp;
8010529f:	31 c0                	xor    %eax,%eax
    {
        rem = temp % 10;
801052a1:	bf 67 66 66 66       	mov    $0x66666667,%edi
801052a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801052ad:	8d 76 00             	lea    0x0(%esi),%esi
        reverse = reverse * 10 + rem;
801052b0:	8d 34 80             	lea    (%eax,%eax,4),%esi
        rem = temp % 10;
801052b3:	89 c8                	mov    %ecx,%eax
        temp /= 10;
        num *= 10;
801052b5:	8d 1c 9b             	lea    (%ebx,%ebx,4),%ebx
        rem = temp % 10;
801052b8:	f7 ef                	imul   %edi
801052ba:	89 c8                	mov    %ecx,%eax
        num *= 10;
801052bc:	01 db                	add    %ebx,%ebx
        rem = temp % 10;
801052be:	c1 f8 1f             	sar    $0x1f,%eax
801052c1:	c1 fa 02             	sar    $0x2,%edx
801052c4:	29 c2                	sub    %eax,%edx
801052c6:	8d 04 92             	lea    (%edx,%edx,4),%eax
801052c9:	01 c0                	add    %eax,%eax
801052cb:	29 c1                	sub    %eax,%ecx
        reverse = reverse * 10 + rem;
801052cd:	8d 04 71             	lea    (%ecx,%esi,2),%eax
        temp /= 10;
801052d0:	89 d1                	mov    %edx,%ecx
    while(temp != 0)
801052d2:	85 d2                	test   %edx,%edx
801052d4:	75 da                	jne    801052b0 <create_palindrome+0x20>
    };

    return num + reverse;
801052d6:	01 d8                	add    %ebx,%eax
}
801052d8:	5b                   	pop    %ebx
801052d9:	5e                   	pop    %esi
801052da:	5f                   	pop    %edi
801052db:	5d                   	pop    %ebp
801052dc:	c3                   	ret    
801052dd:	8d 76 00             	lea    0x0(%esi),%esi
801052e0:	5b                   	pop    %ebx
    while(temp != 0)
801052e1:	31 c0                	xor    %eax,%eax
}
801052e3:	5e                   	pop    %esi
801052e4:	5f                   	pop    %edi
801052e5:	5d                   	pop    %ebp
801052e6:	c3                   	ret    
801052e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801052ee:	66 90                	xchg   %ax,%ax

801052f0 <find_process_by_id>:

// ----------------------------------------------------------------------
// Added function in Ex2
struct proc*
find_process_by_id(int pid)
{
801052f0:	55                   	push   %ebp
801052f1:	89 e5                	mov    %esp,%ebp
801052f3:	56                   	push   %esi
801052f4:	53                   	push   %ebx
801052f5:	8b 75 08             	mov    0x8(%ebp),%esi
    struct proc *p;
    // Acquire the process table lock to ensure thread safety
    acquire(&ptable.lock);
    
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801052f8:	bb 74 58 11 80       	mov    $0x80115874,%ebx
    acquire(&ptable.lock);
801052fd:	83 ec 0c             	sub    $0xc,%esp
80105300:	68 40 58 11 80       	push   $0x80115840
80105305:	e8 16 0c 00 00       	call   80105f20 <acquire>
8010530a:	83 c4 10             	add    $0x10,%esp
8010530d:	eb 0f                	jmp    8010531e <find_process_by_id+0x2e>
8010530f:	90                   	nop
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80105310:	81 c3 40 8d 00 00    	add    $0x8d40,%ebx
80105316:	81 fb 74 a8 34 80    	cmp    $0x8034a874,%ebx
8010531c:	74 22                	je     80105340 <find_process_by_id+0x50>
        if (p->pid == pid) {
8010531e:	39 73 10             	cmp    %esi,0x10(%ebx)
80105321:	75 ed                	jne    80105310 <find_process_by_id+0x20>
            // If the process was found, release the lock and return the process pointer
            release(&ptable.lock);
80105323:	83 ec 0c             	sub    $0xc,%esp
80105326:	68 40 58 11 80       	push   $0x80115840
8010532b:	e8 90 0b 00 00       	call   80105ec0 <release>
            return p;
80105330:	83 c4 10             	add    $0x10,%esp
    }
    
    // if the process wasn'y found, release the lock and return 0
    release(&ptable.lock);
    return 0;
}
80105333:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105336:	89 d8                	mov    %ebx,%eax
80105338:	5b                   	pop    %ebx
80105339:	5e                   	pop    %esi
8010533a:	5d                   	pop    %ebp
8010533b:	c3                   	ret    
8010533c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    release(&ptable.lock);
80105340:	83 ec 0c             	sub    $0xc,%esp
    return 0;
80105343:	31 db                	xor    %ebx,%ebx
    release(&ptable.lock);
80105345:	68 40 58 11 80       	push   $0x80115840
8010534a:	e8 71 0b 00 00       	call   80105ec0 <release>
    return 0;
8010534f:	83 c4 10             	add    $0x10,%esp
}
80105352:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105355:	89 d8                	mov    %ebx,%eax
80105357:	5b                   	pop    %ebx
80105358:	5e                   	pop    %esi
80105359:	5d                   	pop    %ebp
8010535a:	c3                   	ret    
8010535b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010535f:	90                   	nop

80105360 <sort_syscalls_for_process>:
// ----------------------------------------------------------------------

// ----------------------------------------------------------------------
// Added function in Ex2
void sort_syscalls_for_process(struct proc *p)
{
80105360:	55                   	push   %ebp
80105361:	89 e5                	mov    %esp,%ebp
80105363:	57                   	push   %edi
80105364:	56                   	push   %esi
80105365:	53                   	push   %ebx
80105366:	83 ec 6c             	sub    $0x6c,%esp
80105369:	8b 75 08             	mov    0x8(%ebp),%esi
8010536c:	89 65 8c             	mov    %esp,-0x74(%ebp)
    int count = p->syscall_count;
8010536f:	8b 86 1c 8d 00 00    	mov    0x8d1c(%esi),%eax
80105375:	89 45 90             	mov    %eax,-0x70(%ebp)
    if (count == 0) {
80105378:	85 c0                	test   %eax,%eax
8010537a:	0f 84 07 02 00 00    	je     80105587 <sort_syscalls_for_process+0x227>
      cprintf("No system calls yet.\n");
      return ;
    }

    // don't change the original system calls order
    struct syscall_info copied_syscalls[count];
80105380:	8b 45 90             	mov    -0x70(%ebp),%eax
80105383:	8d 48 ff             	lea    -0x1(%eax),%ecx
80105386:	8d 04 c0             	lea    (%eax,%eax,8),%eax
80105389:	8d 1c 85 00 00 00 00 	lea    0x0(,%eax,4),%ebx
80105390:	89 4d 98             	mov    %ecx,-0x68(%ebp)
80105393:	89 e1                	mov    %esp,%ecx
80105395:	8d 43 0f             	lea    0xf(%ebx),%eax
80105398:	89 c2                	mov    %eax,%edx
8010539a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010539f:	29 c1                	sub    %eax,%ecx
801053a1:	83 e2 f0             	and    $0xfffffff0,%edx
801053a4:	39 cc                	cmp    %ecx,%esp
801053a6:	74 12                	je     801053ba <sort_syscalls_for_process+0x5a>
801053a8:	81 ec 00 10 00 00    	sub    $0x1000,%esp
801053ae:	83 8c 24 fc 0f 00 00 	orl    $0x0,0xffc(%esp)
801053b5:	00 
801053b6:	39 cc                	cmp    %ecx,%esp
801053b8:	75 ee                	jne    801053a8 <sort_syscalls_for_process+0x48>
801053ba:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
801053c0:	29 d4                	sub    %edx,%esp
801053c2:	85 d2                	test   %edx,%edx
801053c4:	0f 85 d5 01 00 00    	jne    8010559f <sort_syscalls_for_process+0x23f>
    int cnt = 0;
    while (cnt < count) {
801053ca:	8b 7d 90             	mov    -0x70(%ebp),%edi
    struct syscall_info copied_syscalls[count];
801053cd:	89 e2                	mov    %esp,%edx
            }
        }
    }

    // print the sorted system calls
    cprintf("Sorting system calls of process %s:\n", p->name);
801053cf:	8d 46 6c             	lea    0x6c(%esi),%eax
    struct syscall_info copied_syscalls[count];
801053d2:	89 55 94             	mov    %edx,-0x6c(%ebp)
    cprintf("Sorting system calls of process %s:\n", p->name);
801053d5:	89 45 88             	mov    %eax,-0x78(%ebp)
    while (cnt < count) {
801053d8:	85 ff                	test   %edi,%edi
801053da:	0f 8e c9 01 00 00    	jle    801055a9 <sort_syscalls_for_process+0x249>
801053e0:	8d 46 7c             	lea    0x7c(%esi),%eax
801053e3:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
801053e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801053ed:	8d 76 00             	lea    0x0(%esi),%esi
      copied_syscalls[cnt] = p->syscalls[cnt];
801053f0:	8b 30                	mov    (%eax),%esi
    while (cnt < count) {
801053f2:	83 c0 24             	add    $0x24,%eax
801053f5:	83 c2 24             	add    $0x24,%edx
      copied_syscalls[cnt] = p->syscalls[cnt];
801053f8:	89 72 dc             	mov    %esi,-0x24(%edx)
801053fb:	8b 70 e0             	mov    -0x20(%eax),%esi
801053fe:	89 72 e0             	mov    %esi,-0x20(%edx)
80105401:	8b 70 e4             	mov    -0x1c(%eax),%esi
80105404:	89 72 e4             	mov    %esi,-0x1c(%edx)
80105407:	8b 70 e8             	mov    -0x18(%eax),%esi
8010540a:	89 72 e8             	mov    %esi,-0x18(%edx)
8010540d:	8b 70 ec             	mov    -0x14(%eax),%esi
80105410:	89 72 ec             	mov    %esi,-0x14(%edx)
80105413:	8b 70 f0             	mov    -0x10(%eax),%esi
80105416:	89 72 f0             	mov    %esi,-0x10(%edx)
80105419:	8b 70 f4             	mov    -0xc(%eax),%esi
8010541c:	89 72 f4             	mov    %esi,-0xc(%edx)
8010541f:	8b 70 f8             	mov    -0x8(%eax),%esi
80105422:	89 72 f8             	mov    %esi,-0x8(%edx)
80105425:	8b 70 fc             	mov    -0x4(%eax),%esi
80105428:	89 72 fc             	mov    %esi,-0x4(%edx)
    while (cnt < count) {
8010542b:	39 c8                	cmp    %ecx,%eax
8010542d:	75 c1                	jne    801053f0 <sort_syscalls_for_process+0x90>
    for (int i = 0; i < count-1; i++) {
8010542f:	8b 45 98             	mov    -0x68(%ebp),%eax
80105432:	85 c0                	test   %eax,%eax
80105434:	0f 8e 8f 01 00 00    	jle    801055c9 <sort_syscalls_for_process+0x269>
8010543a:	8b 45 94             	mov    -0x6c(%ebp),%eax
8010543d:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%ebp)
80105444:	8d 44 18 dc          	lea    -0x24(%eax,%ebx,1),%eax
80105448:	89 45 b4             	mov    %eax,-0x4c(%ebp)
8010544b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010544f:	90                   	nop
        for (int j = 0; j < count-i-1; j++) {
80105450:	8b 45 98             	mov    -0x68(%ebp),%eax
80105453:	2b 45 9c             	sub    -0x64(%ebp),%eax
80105456:	8b 55 94             	mov    -0x6c(%ebp),%edx
80105459:	85 c0                	test   %eax,%eax
8010545b:	0f 8e bf 00 00 00    	jle    80105520 <sort_syscalls_for_process+0x1c0>
80105461:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            if (copied_syscalls[j].number > copied_syscalls[j+1].number) {
80105468:	8b 42 20             	mov    0x20(%edx),%eax
8010546b:	3b 42 44             	cmp    0x44(%edx),%eax
8010546e:	0f 8e a0 00 00 00    	jle    80105514 <sort_syscalls_for_process+0x1b4>
                struct syscall_info temp = copied_syscalls[j];
80105474:	8b 3a                	mov    (%edx),%edi
80105476:	8b 4a 04             	mov    0x4(%edx),%ecx
80105479:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010547c:	8b 5a 08             	mov    0x8(%edx),%ebx
8010547f:	8b 72 0c             	mov    0xc(%edx),%esi
80105482:	89 7d b0             	mov    %edi,-0x50(%ebp)
80105485:	89 7d c4             	mov    %edi,-0x3c(%ebp)
80105488:	8b 7a 10             	mov    0x10(%edx),%edi
8010548b:	89 4d ac             	mov    %ecx,-0x54(%ebp)
8010548e:	89 7d a0             	mov    %edi,-0x60(%ebp)
80105491:	89 7d d4             	mov    %edi,-0x2c(%ebp)
                copied_syscalls[j] = copied_syscalls[j+1];
80105494:	8b 7a 24             	mov    0x24(%edx),%edi
                struct syscall_info temp = copied_syscalls[j];
80105497:	89 4d c8             	mov    %ecx,-0x38(%ebp)
8010549a:	8b 4a 1c             	mov    0x1c(%edx),%ecx
                copied_syscalls[j] = copied_syscalls[j+1];
8010549d:	89 3a                	mov    %edi,(%edx)
8010549f:	8b 7a 28             	mov    0x28(%edx),%edi
                struct syscall_info temp = copied_syscalls[j];
801054a2:	89 5d a8             	mov    %ebx,-0x58(%ebp)
                copied_syscalls[j] = copied_syscalls[j+1];
801054a5:	89 7a 04             	mov    %edi,0x4(%edx)
801054a8:	8b 7a 2c             	mov    0x2c(%edx),%edi
                struct syscall_info temp = copied_syscalls[j];
801054ab:	89 5d cc             	mov    %ebx,-0x34(%ebp)
801054ae:	8b 5a 18             	mov    0x18(%edx),%ebx
                copied_syscalls[j] = copied_syscalls[j+1];
801054b1:	89 7a 08             	mov    %edi,0x8(%edx)
801054b4:	8b 7a 30             	mov    0x30(%edx),%edi
                struct syscall_info temp = copied_syscalls[j];
801054b7:	89 75 a4             	mov    %esi,-0x5c(%ebp)
801054ba:	89 75 d0             	mov    %esi,-0x30(%ebp)
801054bd:	8b 72 14             	mov    0x14(%edx),%esi
                copied_syscalls[j] = copied_syscalls[j+1];
801054c0:	89 7a 0c             	mov    %edi,0xc(%edx)
801054c3:	8b 7a 34             	mov    0x34(%edx),%edi
                struct syscall_info temp = copied_syscalls[j];
801054c6:	89 75 d8             	mov    %esi,-0x28(%ebp)
801054c9:	89 5d dc             	mov    %ebx,-0x24(%ebp)
801054cc:	89 4d e0             	mov    %ecx,-0x20(%ebp)
                copied_syscalls[j] = copied_syscalls[j+1];
801054cf:	89 7a 10             	mov    %edi,0x10(%edx)
801054d2:	8b 7a 38             	mov    0x38(%edx),%edi
                copied_syscalls[j+1] = temp;
801054d5:	89 72 38             	mov    %esi,0x38(%edx)
                copied_syscalls[j] = copied_syscalls[j+1];
801054d8:	89 7a 14             	mov    %edi,0x14(%edx)
801054db:	8b 7a 3c             	mov    0x3c(%edx),%edi
                copied_syscalls[j+1] = temp;
801054de:	89 5a 3c             	mov    %ebx,0x3c(%edx)
                copied_syscalls[j] = copied_syscalls[j+1];
801054e1:	89 7a 18             	mov    %edi,0x18(%edx)
801054e4:	8b 7a 40             	mov    0x40(%edx),%edi
                copied_syscalls[j+1] = temp;
801054e7:	89 4a 40             	mov    %ecx,0x40(%edx)
                copied_syscalls[j] = copied_syscalls[j+1];
801054ea:	89 7a 1c             	mov    %edi,0x1c(%edx)
801054ed:	8b 7a 44             	mov    0x44(%edx),%edi
                copied_syscalls[j+1] = temp;
801054f0:	89 42 44             	mov    %eax,0x44(%edx)
                copied_syscalls[j] = copied_syscalls[j+1];
801054f3:	89 7a 20             	mov    %edi,0x20(%edx)
                copied_syscalls[j+1] = temp;
801054f6:	8b 7d b0             	mov    -0x50(%ebp),%edi
801054f9:	89 7a 24             	mov    %edi,0x24(%edx)
801054fc:	8b 7d ac             	mov    -0x54(%ebp),%edi
801054ff:	89 7a 28             	mov    %edi,0x28(%edx)
80105502:	8b 7d a8             	mov    -0x58(%ebp),%edi
80105505:	89 7a 2c             	mov    %edi,0x2c(%edx)
80105508:	8b 7d a4             	mov    -0x5c(%ebp),%edi
8010550b:	89 7a 30             	mov    %edi,0x30(%edx)
8010550e:	8b 7d a0             	mov    -0x60(%ebp),%edi
80105511:	89 7a 34             	mov    %edi,0x34(%edx)
        for (int j = 0; j < count-i-1; j++) {
80105514:	83 c2 24             	add    $0x24,%edx
80105517:	3b 55 b4             	cmp    -0x4c(%ebp),%edx
8010551a:	0f 85 48 ff ff ff    	jne    80105468 <sort_syscalls_for_process+0x108>
    for (int i = 0; i < count-1; i++) {
80105520:	83 45 9c 01          	addl   $0x1,-0x64(%ebp)
80105524:	8b 45 9c             	mov    -0x64(%ebp),%eax
80105527:	83 6d b4 24          	subl   $0x24,-0x4c(%ebp)
8010552b:	39 45 98             	cmp    %eax,-0x68(%ebp)
8010552e:	0f 8f 1c ff ff ff    	jg     80105450 <sort_syscalls_for_process+0xf0>
    cprintf("Sorting system calls of process %s:\n", p->name);
80105534:	83 ec 08             	sub    $0x8,%esp
80105537:	ff 75 88             	push   -0x78(%ebp)
8010553a:	68 d0 9d 10 80       	push   $0x80109dd0
8010553f:	e8 ac b2 ff ff       	call   801007f0 <cprintf>
    for (int i=0; i<count; i++) {
80105544:	8b 4d 90             	mov    -0x70(%ebp),%ecx
80105547:	83 c4 10             	add    $0x10,%esp
8010554a:	85 c9                	test   %ecx,%ecx
8010554c:	7e 2e                	jle    8010557c <sort_syscalls_for_process+0x21c>
8010554e:	8b 75 94             	mov    -0x6c(%ebp),%esi
    for (int i = 0; i < count-1; i++) {
80105551:	8b 7d 90             	mov    -0x70(%ebp),%edi
80105554:	31 db                	xor    %ebx,%ebx
80105556:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010555d:	8d 76 00             	lea    0x0(%esi),%esi
        cprintf("\t%d. %s (%d)\n", i+1, copied_syscalls[i].name, copied_syscalls[i].number);
80105560:	83 c3 01             	add    $0x1,%ebx
80105563:	ff 76 20             	push   0x20(%esi)
80105566:	56                   	push   %esi
    for (int i=0; i<count; i++) {
80105567:	83 c6 24             	add    $0x24,%esi
        cprintf("\t%d. %s (%d)\n", i+1, copied_syscalls[i].name, copied_syscalls[i].number);
8010556a:	53                   	push   %ebx
8010556b:	68 6e 9d 10 80       	push   $0x80109d6e
80105570:	e8 7b b2 ff ff       	call   801007f0 <cprintf>
    for (int i=0; i<count; i++) {
80105575:	83 c4 10             	add    $0x10,%esp
80105578:	39 fb                	cmp    %edi,%ebx
8010557a:	7c e4                	jl     80105560 <sort_syscalls_for_process+0x200>
8010557c:	8b 65 8c             	mov    -0x74(%ebp),%esp
    }
}
8010557f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105582:	5b                   	pop    %ebx
80105583:	5e                   	pop    %esi
80105584:	5f                   	pop    %edi
80105585:	5d                   	pop    %ebp
80105586:	c3                   	ret    
      cprintf("No system calls yet.\n");
80105587:	83 ec 0c             	sub    $0xc,%esp
8010558a:	68 58 9d 10 80       	push   $0x80109d58
8010558f:	e8 5c b2 ff ff       	call   801007f0 <cprintf>
      return ;
80105594:	8b 65 8c             	mov    -0x74(%ebp),%esp
}
80105597:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010559a:	5b                   	pop    %ebx
8010559b:	5e                   	pop    %esi
8010559c:	5f                   	pop    %edi
8010559d:	5d                   	pop    %ebp
8010559e:	c3                   	ret    
    struct syscall_info copied_syscalls[count];
8010559f:	83 4c 14 fc 00       	orl    $0x0,-0x4(%esp,%edx,1)
801055a4:	e9 21 fe ff ff       	jmp    801053ca <sort_syscalls_for_process+0x6a>
    for (int i = 0; i < count-1; i++) {
801055a9:	8b 55 98             	mov    -0x68(%ebp),%edx
801055ac:	85 d2                	test   %edx,%edx
801055ae:	0f 8f 86 fe ff ff    	jg     8010543a <sort_syscalls_for_process+0xda>
    cprintf("Sorting system calls of process %s:\n", p->name);
801055b4:	83 ec 08             	sub    $0x8,%esp
801055b7:	ff 75 88             	push   -0x78(%ebp)
801055ba:	68 d0 9d 10 80       	push   $0x80109dd0
801055bf:	e8 2c b2 ff ff       	call   801007f0 <cprintf>
801055c4:	83 c4 10             	add    $0x10,%esp
801055c7:	eb b3                	jmp    8010557c <sort_syscalls_for_process+0x21c>
801055c9:	83 ec 08             	sub    $0x8,%esp
801055cc:	ff 75 88             	push   -0x78(%ebp)
801055cf:	68 d0 9d 10 80       	push   $0x80109dd0
801055d4:	e8 17 b2 ff ff       	call   801007f0 <cprintf>
801055d9:	83 c4 10             	add    $0x10,%esp
801055dc:	e9 6d ff ff ff       	jmp    8010554e <sort_syscalls_for_process+0x1ee>
801055e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801055e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801055ef:	90                   	nop

801055f0 <get_most_invoked_syscall>:
// ----------------------------------------------------------------------

// ----------------------------------------------------------------------
// Added function in Ex2
void get_most_invoked_syscall(struct proc *p)
{
801055f0:	55                   	push   %ebp
801055f1:	89 e5                	mov    %esp,%ebp
801055f3:	57                   	push   %edi
801055f4:	56                   	push   %esi
801055f5:	53                   	push   %ebx
801055f6:	81 ec 9c 00 00 00    	sub    $0x9c,%esp
801055fc:	8b 45 08             	mov    0x8(%ebp),%eax
    int count = p->syscall_count;
801055ff:	8b 98 1c 8d 00 00    	mov    0x8d1c(%eax),%ebx
{
80105605:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
    if (count == 0) {
8010560b:	85 db                	test   %ebx,%ebx
8010560d:	0f 84 9d 00 00 00    	je     801056b0 <get_most_invoked_syscall+0xc0>
      return ;
    }

    // don't change the original system calls order

    int counts[30] = {0};
80105613:	8d bd 70 ff ff ff    	lea    -0x90(%ebp),%edi
80105619:	b9 1e 00 00 00       	mov    $0x1e,%ecx
8010561e:	b8 00 00 00 00       	mov    $0x0,%eax
80105623:	f3 ab                	rep stos %eax,%es:(%edi)

    int max_freq = -1, max_idx = -1;
    int cnt = 0;
    while (cnt < count) {
80105625:	0f 8e 9d 00 00 00    	jle    801056c8 <get_most_invoked_syscall+0xd8>
8010562b:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
    int cnt = 0;
80105631:	31 d2                	xor    %edx,%edx
    int max_freq = -1, max_idx = -1;
80105633:	bf ff ff ff ff       	mov    $0xffffffff,%edi
80105638:	c7 85 64 ff ff ff ff 	movl   $0xffffffff,-0x9c(%ebp)
8010563f:	ff ff ff 
80105642:	8d 88 9c 00 00 00    	lea    0x9c(%eax),%ecx
80105648:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010564f:	90                   	nop
      counts[p->syscalls[cnt].number]++;
80105650:	8b 31                	mov    (%ecx),%esi
80105652:	8b 84 b5 70 ff ff ff 	mov    -0x90(%ebp,%esi,4),%eax
80105659:	83 c0 01             	add    $0x1,%eax
8010565c:	89 84 b5 70 ff ff ff 	mov    %eax,-0x90(%ebp,%esi,4)
      if (counts[p->syscalls[cnt].number] > max_freq) {
80105663:	39 f8                	cmp    %edi,%eax
80105665:	7e 08                	jle    8010566f <get_most_invoked_syscall+0x7f>
80105667:	89 95 64 ff ff ff    	mov    %edx,-0x9c(%ebp)
8010566d:	89 c7                	mov    %eax,%edi
          max_freq = counts[p->syscalls[cnt].number];
          max_idx = cnt; 
      }
      cnt++;
8010566f:	83 c2 01             	add    $0x1,%edx
    while (cnt < count) {
80105672:	83 c1 24             	add    $0x24,%ecx
80105675:	39 d3                	cmp    %edx,%ebx
80105677:	75 d7                	jne    80105650 <get_most_invoked_syscall+0x60>
    }

    if (max_idx == -1) {
80105679:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010567f:	83 f8 ff             	cmp    $0xffffffff,%eax
80105682:	74 44                	je     801056c8 <get_most_invoked_syscall+0xd8>
        cprintf("No most invoked system call found for process with ID %s\n", p->name);
        return ;
    }

    cprintf("The most invoked process is %s with %d times\n", p->syscalls[max_idx].name, max_freq);
80105684:	8b 9d 60 ff ff ff    	mov    -0xa0(%ebp),%ebx
8010568a:	8d 04 c0             	lea    (%eax,%eax,8),%eax
8010568d:	83 ec 04             	sub    $0x4,%esp
80105690:	57                   	push   %edi
80105691:	8d 44 83 7c          	lea    0x7c(%ebx,%eax,4),%eax
80105695:	50                   	push   %eax
80105696:	68 34 9e 10 80       	push   $0x80109e34
8010569b:	e8 50 b1 ff ff       	call   801007f0 <cprintf>
801056a0:	83 c4 10             	add    $0x10,%esp
}
801056a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801056a6:	5b                   	pop    %ebx
801056a7:	5e                   	pop    %esi
801056a8:	5f                   	pop    %edi
801056a9:	5d                   	pop    %ebp
801056aa:	c3                   	ret    
801056ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801056af:	90                   	nop
      cprintf("No system calls yet.\n");
801056b0:	c7 45 08 58 9d 10 80 	movl   $0x80109d58,0x8(%ebp)
}
801056b7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801056ba:	5b                   	pop    %ebx
801056bb:	5e                   	pop    %esi
801056bc:	5f                   	pop    %edi
801056bd:	5d                   	pop    %ebp
      cprintf("No system calls yet.\n");
801056be:	e9 2d b1 ff ff       	jmp    801007f0 <cprintf>
801056c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801056c7:	90                   	nop
        cprintf("No most invoked system call found for process with ID %s\n", p->name);
801056c8:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801056ce:	83 ec 08             	sub    $0x8,%esp
801056d1:	83 c0 6c             	add    $0x6c,%eax
801056d4:	50                   	push   %eax
801056d5:	68 f8 9d 10 80       	push   $0x80109df8
801056da:	e8 11 b1 ff ff       	call   801007f0 <cprintf>
        return ;
801056df:	83 c4 10             	add    $0x10,%esp
}
801056e2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801056e5:	5b                   	pop    %ebx
801056e6:	5e                   	pop    %esi
801056e7:	5f                   	pop    %edi
801056e8:	5d                   	pop    %ebp
801056e9:	c3                   	ret    
801056ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801056f0 <list_all_processes>:
// ----------------------------------------------------------------------

void
list_all_processes(int a)
{
801056f0:	55                   	push   %ebp
801056f1:	89 e5                	mov    %esp,%ebp
801056f3:	53                   	push   %ebx
801056f4:	bb e0 58 11 80       	mov    $0x801158e0,%ebx
801056f9:	83 ec 10             	sub    $0x10,%esp
    struct proc *p;

    acquire(&ptable.lock);
801056fc:	68 40 58 11 80       	push   $0x80115840
80105701:	e8 1a 08 00 00       	call   80105f20 <acquire>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105706:	83 c4 10             	add    $0x10,%esp
80105709:	eb 13                	jmp    8010571e <list_all_processes+0x2e>
8010570b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010570f:	90                   	nop
80105710:	81 c3 40 8d 00 00    	add    $0x8d40,%ebx
80105716:	81 fb e0 a8 34 80    	cmp    $0x8034a8e0,%ebx
8010571c:	74 2a                	je     80105748 <list_all_processes+0x58>
    { 
        if(p->pid != 0)
8010571e:	8b 43 a4             	mov    -0x5c(%ebx),%eax
80105721:	85 c0                	test   %eax,%eax
80105723:	74 eb                	je     80105710 <list_all_processes+0x20>
            cprintf("My name is: %s.\t My id is:%d.\t Number of system calls i invoked is: %d.\n",p->name, p->pid,p->syscall_count);
80105725:	ff b3 b0 8c 00 00    	push   0x8cb0(%ebx)
8010572b:	50                   	push   %eax
8010572c:	53                   	push   %ebx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010572d:	81 c3 40 8d 00 00    	add    $0x8d40,%ebx
            cprintf("My name is: %s.\t My id is:%d.\t Number of system calls i invoked is: %d.\n",p->name, p->pid,p->syscall_count);
80105733:	68 64 9e 10 80       	push   $0x80109e64
80105738:	e8 b3 b0 ff ff       	call   801007f0 <cprintf>
8010573d:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105740:	81 fb e0 a8 34 80    	cmp    $0x8034a8e0,%ebx
80105746:	75 d6                	jne    8010571e <list_all_processes+0x2e>
    }   
    release(&ptable.lock);
80105748:	c7 45 08 40 58 11 80 	movl   $0x80115840,0x8(%ebp)
}
8010574f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105752:	c9                   	leave  
    release(&ptable.lock);
80105753:	e9 68 07 00 00       	jmp    80105ec0 <release>
80105758:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010575f:	90                   	nop

80105760 <setqueue>:

int setqueue(int pid, int level) {
80105760:	55                   	push   %ebp
80105761:	89 e5                	mov    %esp,%ebp
80105763:	57                   	push   %edi
80105764:	56                   	push   %esi
80105765:	53                   	push   %ebx
  struct proc *p;
  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80105766:	bb 74 58 11 80       	mov    $0x80115874,%ebx
int setqueue(int pid, int level) {
8010576b:	83 ec 18             	sub    $0x18,%esp
8010576e:	8b 75 08             	mov    0x8(%ebp),%esi
80105771:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&ptable.lock);
80105774:	68 40 58 11 80       	push   $0x80115840
80105779:	e8 a2 07 00 00       	call   80105f20 <acquire>
8010577e:	83 c4 10             	add    $0x10,%esp
80105781:	eb 13                	jmp    80105796 <setqueue+0x36>
80105783:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105787:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80105788:	81 c3 40 8d 00 00    	add    $0x8d40,%ebx
8010578e:	81 fb 74 a8 34 80    	cmp    $0x8034a874,%ebx
80105794:	74 3a                	je     801057d0 <setqueue+0x70>
    if(p->pid == pid) {
80105796:	39 73 10             	cmp    %esi,0x10(%ebx)
80105799:	75 ed                	jne    80105788 <setqueue+0x28>
      cprintf("proccess %d goes to level %d from level %d\n", p->pid , level, p->sched_info.queue_level);
8010579b:	ff b3 20 8d 00 00    	push   0x8d20(%ebx)
801057a1:	57                   	push   %edi
801057a2:	56                   	push   %esi
801057a3:	68 b0 9e 10 80       	push   $0x80109eb0
801057a8:	e8 43 b0 ff ff       	call   801007f0 <cprintf>
      p->sched_info.queue_level = level;
801057ad:	89 bb 20 8d 00 00    	mov    %edi,0x8d20(%ebx)
      release(&ptable.lock);
801057b3:	c7 04 24 40 58 11 80 	movl   $0x80115840,(%esp)
801057ba:	e8 01 07 00 00       	call   80105ec0 <release>
      return 0;
801057bf:	83 c4 10             	add    $0x10,%esp
    }
  }

  release(&ptable.lock);
  return -1;
}
801057c2:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
801057c5:	31 c0                	xor    %eax,%eax
}
801057c7:	5b                   	pop    %ebx
801057c8:	5e                   	pop    %esi
801057c9:	5f                   	pop    %edi
801057ca:	5d                   	pop    %ebp
801057cb:	c3                   	ret    
801057cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
801057d0:	83 ec 0c             	sub    $0xc,%esp
801057d3:	68 40 58 11 80       	push   $0x80115840
801057d8:	e8 e3 06 00 00       	call   80105ec0 <release>
  return -1;
801057dd:	83 c4 10             	add    $0x10,%esp
}
801057e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801057e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801057e8:	5b                   	pop    %ebx
801057e9:	5e                   	pop    %esi
801057ea:	5f                   	pop    %edi
801057eb:	5d                   	pop    %ebp
801057ec:	c3                   	ret    
801057ed:	8d 76 00             	lea    0x0(%esi),%esi

801057f0 <goto_lower_priority_queue>:
{
801057f0:	55                   	push   %ebp
801057f1:	89 e5                	mov    %esp,%ebp
801057f3:	53                   	push   %ebx
801057f4:	83 ec 04             	sub    $0x4,%esp
801057f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (p->sched_info.queue_level != ROUND_ROBIN)
801057fa:	83 bb 20 8d 00 00 01 	cmpl   $0x1,0x8d20(%ebx)
80105801:	74 4b                	je     8010584e <goto_lower_priority_queue+0x5e>
    release(&ptable.lock);
80105803:	83 ec 0c             	sub    $0xc,%esp
80105806:	68 40 58 11 80       	push   $0x80115840
8010580b:	e8 b0 06 00 00       	call   80105ec0 <release>
    setqueue(p->pid, p->sched_info.queue_level-1);
80105810:	58                   	pop    %eax
80105811:	8b 83 20 8d 00 00    	mov    0x8d20(%ebx),%eax
80105817:	5a                   	pop    %edx
80105818:	83 e8 01             	sub    $0x1,%eax
8010581b:	50                   	push   %eax
8010581c:	ff 73 10             	push   0x10(%ebx)
8010581f:	e8 3c ff ff ff       	call   80105760 <setqueue>
    acquire(&ptable.lock);
80105824:	c7 04 24 40 58 11 80 	movl   $0x80115840,(%esp)
8010582b:	e8 f0 06 00 00       	call   80105f20 <acquire>
    p->sched_info.arrival_time = ticks;
80105830:	a1 84 a8 34 80       	mov    0x8034a884,%eax
}
80105835:	83 c4 10             	add    $0x10,%esp
    p->sched_info.wait_time = 0;
80105838:	c7 83 38 8d 00 00 00 	movl   $0x0,0x8d38(%ebx)
8010583f:	00 00 00 
    p->sched_info.arrival_time = ticks;
80105842:	89 83 30 8d 00 00    	mov    %eax,0x8d30(%ebx)
    p->sched_info.last_running_time = ticks;
80105848:	89 83 34 8d 00 00    	mov    %eax,0x8d34(%ebx)
}
8010584e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105851:	c9                   	leave  
80105852:	c3                   	ret    
80105853:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010585a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105860 <scheduler>:
{
80105860:	55                   	push   %ebp
80105861:	89 e5                	mov    %esp,%ebp
80105863:	57                   	push   %edi
80105864:	56                   	push   %esi
80105865:	53                   	push   %ebx
80105866:	83 ec 4c             	sub    $0x4c,%esp
  struct cpu *c = mycpu();
80105869:	e8 62 f0 ff ff       	call   801048d0 <mycpu>
  int rand_value = generate_random_integer(2, 100);
8010586e:	83 ec 08             	sub    $0x8,%esp
  c->proc = 0;
80105871:	c7 80 b4 00 00 00 00 	movl   $0x0,0xb4(%eax)
80105878:	00 00 00 
  struct cpu *c = mycpu();
8010587b:	89 c7                	mov    %eax,%edi
  int rand_value = generate_random_integer(2, 100);
8010587d:	6a 64                	push   $0x64
8010587f:	6a 02                	push   $0x2
  struct cpu *c = mycpu();
80105881:	89 45 ac             	mov    %eax,-0x54(%ebp)
  int rand_value = generate_random_integer(2, 100);
80105884:	e8 87 f3 ff ff       	call   80104c10 <generate_random_integer>
80105889:	83 c4 10             	add    $0x10,%esp
8010588c:	89 45 b0             	mov    %eax,-0x50(%ebp)
8010588f:	8d 47 0c             	lea    0xc(%edi),%eax
80105892:	89 45 a8             	mov    %eax,-0x58(%ebp)
80105895:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80105898:	fb                   	sti    
    acquire(&ptable.lock);
80105899:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010589c:	bb 74 58 11 80       	mov    $0x80115874,%ebx
    acquire(&ptable.lock);
801058a1:	68 40 58 11 80       	push   $0x80115840
801058a6:	e8 75 06 00 00       	call   80105f20 <acquire>
    long long min_last_running_time_rr = 1e9;
801058ab:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
    acquire(&ptable.lock);
801058b0:	83 c4 10             	add    $0x10,%esp
    int found_third_priority_process = 0;        
801058b3:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    int found_second_priority_process = 0;
801058ba:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    int found_first_priority_process = 0;
801058c1:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
    long long min_last_running_time_rr = 1e9;
801058c8:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    long long min_last_arrival_time_fcfs = 1e9;
801058cf:	c7 45 d4 00 ca 9a 3b 	movl   $0x3b9aca00,-0x2c(%ebp)
801058d6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    long long min_burst_time_sjf = 1e9;
801058dd:	c7 45 c8 00 ca 9a 3b 	movl   $0x3b9aca00,-0x38(%ebp)
801058e4:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
    struct proc *last_proc = 0;
801058eb:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
    struct proc *shortest_proc_not_confident = 0;
801058f2:	c7 45 b4 00 00 00 00 	movl   $0x0,-0x4c(%ebp)
    struct proc *shortest_proc = 0;
801058f9:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
    struct proc *rr_process = 0;
80105900:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105907:	89 55 e0             	mov    %edx,-0x20(%ebp)
8010590a:	eb 7e                	jmp    8010598a <scheduler+0x12a>
8010590c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if (ticks > p->sched_info.last_tick) {
80105910:	8b 0d 84 a8 34 80    	mov    0x8034a884,%ecx
80105916:	39 8b 3c 8d 00 00    	cmp    %ecx,0x8d3c(%ebx)
8010591c:	73 0d                	jae    8010592b <scheduler+0xcb>
        p->sched_info.wait_time++;
8010591e:	83 83 38 8d 00 00 01 	addl   $0x1,0x8d38(%ebx)
        p->sched_info.last_tick = ticks;
80105925:	89 8b 3c 8d 00 00    	mov    %ecx,0x8d3c(%ebx)
      if (p->sched_info.queue_level == ROUND_ROBIN) {
8010592b:	83 f8 01             	cmp    $0x1,%eax
8010592e:	0f 84 a0 01 00 00    	je     80105ad4 <scheduler+0x274>
      if (p->sched_info.queue_level == SJF){
80105934:	83 f8 02             	cmp    $0x2,%eax
80105937:	0f 84 d3 00 00 00    	je     80105a10 <scheduler+0x1b0>
      if (p->sched_info.queue_level == FCFS){
8010593d:	83 f8 03             	cmp    $0x3,%eax
80105940:	75 36                	jne    80105978 <scheduler+0x118>
        if(p->sched_info.arrival_time < min_last_arrival_time_fcfs){
80105942:	8b 83 30 8d 00 00    	mov    0x8d30(%ebx),%eax
80105948:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
8010594b:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
80105952:	89 c7                	mov    %eax,%edi
80105954:	c1 ff 1f             	sar    $0x1f,%edi
80105957:	39 c8                	cmp    %ecx,%eax
80105959:	89 fa                	mov    %edi,%edx
8010595b:	1b 55 e4             	sbb    -0x1c(%ebp),%edx
8010595e:	0f 4d 7d e4          	cmovge -0x1c(%ebp),%edi
80105962:	0f 4d c1             	cmovge %ecx,%eax
80105965:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80105968:	89 45 d4             	mov    %eax,-0x2c(%ebp)
8010596b:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010596e:	0f 4c c3             	cmovl  %ebx,%eax
80105971:	89 45 d8             	mov    %eax,-0x28(%ebp)
80105974:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105978:	81 c3 40 8d 00 00    	add    $0x8d40,%ebx
8010597e:	81 fb 74 a8 34 80    	cmp    $0x8034a874,%ebx
80105984:	0f 84 e6 00 00 00    	je     80105a70 <scheduler+0x210>
      if(p->state != RUNNABLE)
8010598a:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
8010598e:	75 e8                	jne    80105978 <scheduler+0x118>
      if (p->sched_info.wait_time >= WAITLIMIT) {
80105990:	8b 8b 38 8d 00 00    	mov    0x8d38(%ebx),%ecx
  if (p->sched_info.queue_level != ROUND_ROBIN)
80105996:	8b 83 20 8d 00 00    	mov    0x8d20(%ebx),%eax
      if (p->sched_info.wait_time >= WAITLIMIT) {
8010599c:	81 f9 1f 03 00 00    	cmp    $0x31f,%ecx
801059a2:	0f 8e 68 ff ff ff    	jle    80105910 <scheduler+0xb0>
  if (p->sched_info.queue_level != ROUND_ROBIN)
801059a8:	83 f8 01             	cmp    $0x1,%eax
801059ab:	0f 84 07 01 00 00    	je     80105ab8 <scheduler+0x258>
    release(&ptable.lock);
801059b1:	83 ec 0c             	sub    $0xc,%esp
801059b4:	68 40 58 11 80       	push   $0x80115840
801059b9:	e8 02 05 00 00       	call   80105ec0 <release>
    setqueue(p->pid, p->sched_info.queue_level-1);
801059be:	5f                   	pop    %edi
801059bf:	58                   	pop    %eax
801059c0:	8b 83 20 8d 00 00    	mov    0x8d20(%ebx),%eax
801059c6:	83 e8 01             	sub    $0x1,%eax
801059c9:	50                   	push   %eax
801059ca:	ff 73 10             	push   0x10(%ebx)
801059cd:	e8 8e fd ff ff       	call   80105760 <setqueue>
    acquire(&ptable.lock);
801059d2:	c7 04 24 40 58 11 80 	movl   $0x80115840,(%esp)
801059d9:	e8 42 05 00 00       	call   80105f20 <acquire>
    p->sched_info.arrival_time = ticks;
801059de:	8b 0d 84 a8 34 80    	mov    0x8034a884,%ecx
801059e4:	8b 83 20 8d 00 00    	mov    0x8d20(%ebx),%eax
}
801059ea:	83 c4 10             	add    $0x10,%esp
    p->sched_info.wait_time = 0;
801059ed:	c7 83 38 8d 00 00 00 	movl   $0x0,0x8d38(%ebx)
801059f4:	00 00 00 
    p->sched_info.arrival_time = ticks;
801059f7:	89 8b 30 8d 00 00    	mov    %ecx,0x8d30(%ebx)
    p->sched_info.last_running_time = ticks;
801059fd:	89 8b 34 8d 00 00    	mov    %ecx,0x8d34(%ebx)
}
80105a03:	e9 0e ff ff ff       	jmp    80105916 <scheduler+0xb6>
80105a08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a0f:	90                   	nop
        if(p->sched_info.burst_time < min_burst_time_sjf){
80105a10:	8b 83 24 8d 00 00    	mov    0x8d24(%ebx),%eax
80105a16:	8b 4d c8             	mov    -0x38(%ebp),%ecx
            if(rand_value <= p->sched_info.confidence)
80105a19:	89 5d b4             	mov    %ebx,-0x4c(%ebp)
80105a1c:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
        if(p->sched_info.burst_time < min_burst_time_sjf){
80105a23:	89 c7                	mov    %eax,%edi
80105a25:	c1 ff 1f             	sar    $0x1f,%edi
80105a28:	39 c8                	cmp    %ecx,%eax
80105a2a:	89 fa                	mov    %edi,%edx
80105a2c:	1b 55 cc             	sbb    -0x34(%ebp),%edx
80105a2f:	0f 8d 43 ff ff ff    	jge    80105978 <scheduler+0x118>
            if(rand_value <= p->sched_info.confidence)
80105a35:	8b 55 b0             	mov    -0x50(%ebp),%edx
80105a38:	39 93 28 8d 00 00    	cmp    %edx,0x8d28(%ebx)
80105a3e:	0f 4c c1             	cmovl  %ecx,%eax
80105a41:	0f 4c 7d cc          	cmovl  -0x34(%ebp),%edi
80105a45:	89 45 c8             	mov    %eax,-0x38(%ebp)
80105a48:	8b 45 b8             	mov    -0x48(%ebp),%eax
80105a4b:	89 7d cc             	mov    %edi,-0x34(%ebp)
80105a4e:	0f 4d c3             	cmovge %ebx,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105a51:	81 c3 40 8d 00 00    	add    $0x8d40,%ebx
            if(rand_value <= p->sched_info.confidence)
80105a57:	89 45 b8             	mov    %eax,-0x48(%ebp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105a5a:	81 fb 74 a8 34 80    	cmp    $0x8034a874,%ebx
80105a60:	0f 85 24 ff ff ff    	jne    8010598a <scheduler+0x12a>
80105a66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a6d:	8d 76 00             	lea    0x0(%esi),%esi
        !found_second_priority_process &&
80105a70:	8b 7d c0             	mov    -0x40(%ebp),%edi
80105a73:	8b 45 bc             	mov    -0x44(%ebp),%eax
80105a76:	09 f8                	or     %edi,%eax
    if (!found_first_priority_process  &&
80105a78:	0b 45 c4             	or     -0x3c(%ebp),%eax
80105a7b:	74 23                	je     80105aa0 <scheduler+0x240>
      if (mycpu()->current_queue == ROUND_ROBIN) {
80105a7d:	e8 4e ee ff ff       	call   801048d0 <mycpu>
80105a82:	83 78 04 01          	cmpl   $0x1,0x4(%eax)
80105a86:	0f 85 81 00 00 00    	jne    80105b0d <scheduler+0x2ad>
        if (found_first_priority_process) p = rr_process;
80105a8c:	85 ff                	test   %edi,%edi
80105a8e:	74 10                	je     80105aa0 <scheduler+0x240>
      if (p != 0)
80105a90:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80105a93:	85 c9                	test   %ecx,%ecx
80105a95:	0f 85 92 00 00 00    	jne    80105b2d <scheduler+0x2cd>
80105a9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105a9f:	90                   	nop
    release(&ptable.lock);
80105aa0:	83 ec 0c             	sub    $0xc,%esp
80105aa3:	68 40 58 11 80       	push   $0x80115840
80105aa8:	e8 13 04 00 00       	call   80105ec0 <release>
  for(;;) {
80105aad:	83 c4 10             	add    $0x10,%esp
80105ab0:	e9 e3 fd ff ff       	jmp    80105898 <scheduler+0x38>
80105ab5:	8d 76 00             	lea    0x0(%esi),%esi
      if (ticks > p->sched_info.last_tick) {
80105ab8:	a1 84 a8 34 80       	mov    0x8034a884,%eax
80105abd:	39 83 3c 8d 00 00    	cmp    %eax,0x8d3c(%ebx)
80105ac3:	73 0f                	jae    80105ad4 <scheduler+0x274>
        p->sched_info.wait_time++;
80105ac5:	83 c1 01             	add    $0x1,%ecx
        p->sched_info.last_tick = ticks;
80105ac8:	89 83 3c 8d 00 00    	mov    %eax,0x8d3c(%ebx)
        p->sched_info.wait_time++;
80105ace:	89 8b 38 8d 00 00    	mov    %ecx,0x8d38(%ebx)
        if(p->sched_info.last_running_time < min_last_running_time_rr)
80105ad4:	8b 83 34 8d 00 00    	mov    0x8d34(%ebx),%eax
80105ada:	8b 4d d0             	mov    -0x30(%ebp),%ecx
80105add:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
80105ae4:	89 c7                	mov    %eax,%edi
80105ae6:	c1 ff 1f             	sar    $0x1f,%edi
80105ae9:	3b 45 e0             	cmp    -0x20(%ebp),%eax
80105aec:	89 fa                	mov    %edi,%edx
80105aee:	19 ca                	sbb    %ecx,%edx
80105af0:	0f 4d 45 e0          	cmovge -0x20(%ebp),%eax
80105af4:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105af7:	89 f8                	mov    %edi,%eax
80105af9:	0f 4d c1             	cmovge %ecx,%eax
80105afc:	89 45 d0             	mov    %eax,-0x30(%ebp)
80105aff:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105b02:	0f 4c c3             	cmovl  %ebx,%eax
80105b05:	89 45 dc             	mov    %eax,-0x24(%ebp)
      if (p->sched_info.queue_level == FCFS){
80105b08:	e9 6b fe ff ff       	jmp    80105978 <scheduler+0x118>
      else if (mycpu()->current_queue == SJF) {
80105b0d:	e8 be ed ff ff       	call   801048d0 <mycpu>
80105b12:	83 78 04 02          	cmpl   $0x2,0x4(%eax)
80105b16:	75 76                	jne    80105b8e <scheduler+0x32e>
          if (found_second_priority_process) {
80105b18:	8b 75 bc             	mov    -0x44(%ebp),%esi
80105b1b:	85 f6                	test   %esi,%esi
80105b1d:	74 81                	je     80105aa0 <scheduler+0x240>
              if (shortest_proc == 0) {
80105b1f:	8b 45 b8             	mov    -0x48(%ebp),%eax
80105b22:	85 c0                	test   %eax,%eax
80105b24:	0f 84 a6 00 00 00    	je     80105bd0 <scheduler+0x370>
80105b2a:	89 45 dc             	mov    %eax,-0x24(%ebp)
        c->proc = p;
80105b2d:	8b 7d dc             	mov    -0x24(%ebp),%edi
80105b30:	8b 45 ac             	mov    -0x54(%ebp),%eax
        switchuvm(p);
80105b33:	83 ec 0c             	sub    $0xc,%esp
        c->proc = p;
80105b36:	89 b8 b4 00 00 00    	mov    %edi,0xb4(%eax)
        switchuvm(p);
80105b3c:	57                   	push   %edi
80105b3d:	e8 2e 34 00 00       	call   80108f70 <switchuvm>
        p->state = RUNNING;
80105b42:	c7 47 0c 04 00 00 00 	movl   $0x4,0xc(%edi)
        swtch(&(c->scheduler),p->context);
80105b49:	58                   	pop    %eax
80105b4a:	5a                   	pop    %edx
80105b4b:	ff 77 1c             	push   0x1c(%edi)
80105b4e:	ff 75 a8             	push   -0x58(%ebp)
80105b51:	e8 f3 08 00 00       	call   80106449 <swtch>
        p->sched_info.last_running_time = ticks;
80105b56:	a1 84 a8 34 80       	mov    0x8034a884,%eax
        if (p->sched_info.queue_level == SJF && p->state == ZOMBIE)
80105b5b:	83 c4 10             	add    $0x10,%esp
80105b5e:	83 bf 20 8d 00 00 02 	cmpl   $0x2,0x8d20(%edi)
        p->sched_info.wait_time = 0;
80105b65:	c7 87 38 8d 00 00 00 	movl   $0x0,0x8d38(%edi)
80105b6c:	00 00 00 
        p->sched_info.last_running_time = ticks;
80105b6f:	89 87 34 8d 00 00    	mov    %eax,0x8d34(%edi)
        if (p->sched_info.queue_level == SJF && p->state == ZOMBIE)
80105b75:	74 3c                	je     80105bb3 <scheduler+0x353>
        switchkvm();
80105b77:	e8 e4 33 00 00       	call   80108f60 <switchkvm>
        c->proc = 0;
80105b7c:	8b 45 ac             	mov    -0x54(%ebp),%eax
80105b7f:	c7 80 b4 00 00 00 00 	movl   $0x0,0xb4(%eax)
80105b86:	00 00 00 
80105b89:	e9 12 ff ff ff       	jmp    80105aa0 <scheduler+0x240>
      else if (mycpu()->current_queue == FCFS) {
80105b8e:	e8 3d ed ff ff       	call   801048d0 <mycpu>
          if (found_third_priority_process) p = last_proc;
80105b93:	83 78 04 03          	cmpl   $0x3,0x4(%eax)
80105b97:	0f 85 03 ff ff ff    	jne    80105aa0 <scheduler+0x240>
80105b9d:	8b 5d c4             	mov    -0x3c(%ebp),%ebx
80105ba0:	85 db                	test   %ebx,%ebx
80105ba2:	0f 84 f8 fe ff ff    	je     80105aa0 <scheduler+0x240>
80105ba8:	8b 45 d8             	mov    -0x28(%ebp),%eax
80105bab:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105bae:	e9 dd fe ff ff       	jmp    80105a90 <scheduler+0x230>
        if (p->sched_info.queue_level == SJF && p->state == ZOMBIE)
80105bb3:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105bb6:	83 78 0c 05          	cmpl   $0x5,0xc(%eax)
80105bba:	75 bb                	jne    80105b77 <scheduler+0x317>
          rand_value = generate_random_integer(2, 100);
80105bbc:	83 ec 08             	sub    $0x8,%esp
80105bbf:	6a 64                	push   $0x64
80105bc1:	6a 02                	push   $0x2
80105bc3:	e8 48 f0 ff ff       	call   80104c10 <generate_random_integer>
80105bc8:	83 c4 10             	add    $0x10,%esp
80105bcb:	89 45 b0             	mov    %eax,-0x50(%ebp)
80105bce:	eb a7                	jmp    80105b77 <scheduler+0x317>
80105bd0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80105bd3:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105bd6:	e9 b5 fe ff ff       	jmp    80105a90 <scheduler+0x230>
80105bdb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105bdf:	90                   	nop

80105be0 <getptable>:
struct proc* getptable(void){
80105be0:	55                   	push   %ebp
80105be1:	89 e5                	mov    %esp,%ebp
80105be3:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);
80105be6:	68 40 58 11 80       	push   $0x80115840
80105beb:	e8 30 03 00 00       	call   80105f20 <acquire>
  return ptable.proc;
}
80105bf0:	b8 74 58 11 80       	mov    $0x80115874,%eax
80105bf5:	c9                   	leave  
80105bf6:	c3                   	ret    
80105bf7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105bfe:	66 90                	xchg   %ax,%ax

80105c00 <releaseptable>:
void releaseptable(void){
80105c00:	55                   	push   %ebp
80105c01:	89 e5                	mov    %esp,%ebp
80105c03:	83 ec 14             	sub    $0x14,%esp
  release(&ptable.lock);
80105c06:	68 40 58 11 80       	push   $0x80115840
80105c0b:	e8 b0 02 00 00       	call   80105ec0 <release>
}
80105c10:	83 c4 10             	add    $0x10,%esp
80105c13:	c9                   	leave  
80105c14:	c3                   	ret    
80105c15:	66 90                	xchg   %ax,%ax
80105c17:	66 90                	xchg   %ax,%ax
80105c19:	66 90                	xchg   %ax,%ax
80105c1b:	66 90                	xchg   %ax,%ax
80105c1d:	66 90                	xchg   %ax,%ax
80105c1f:	90                   	nop

80105c20 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80105c20:	55                   	push   %ebp
80105c21:	89 e5                	mov    %esp,%ebp
80105c23:	53                   	push   %ebx
80105c24:	83 ec 0c             	sub    $0xc,%esp
80105c27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80105c2a:	68 f4 9e 10 80       	push   $0x80109ef4
80105c2f:	8d 43 04             	lea    0x4(%ebx),%eax
80105c32:	50                   	push   %eax
80105c33:	e8 18 01 00 00       	call   80105d50 <initlock>
  lk->name = name;
80105c38:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80105c3b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80105c41:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80105c44:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
80105c4b:	89 43 38             	mov    %eax,0x38(%ebx)
}
80105c4e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105c51:	c9                   	leave  
80105c52:	c3                   	ret    
80105c53:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105c60 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80105c60:	55                   	push   %ebp
80105c61:	89 e5                	mov    %esp,%ebp
80105c63:	56                   	push   %esi
80105c64:	53                   	push   %ebx
80105c65:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80105c68:	8d 73 04             	lea    0x4(%ebx),%esi
80105c6b:	83 ec 0c             	sub    $0xc,%esp
80105c6e:	56                   	push   %esi
80105c6f:	e8 ac 02 00 00       	call   80105f20 <acquire>
  while (lk->locked) {
80105c74:	8b 13                	mov    (%ebx),%edx
80105c76:	83 c4 10             	add    $0x10,%esp
80105c79:	85 d2                	test   %edx,%edx
80105c7b:	74 16                	je     80105c93 <acquiresleep+0x33>
80105c7d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80105c80:	83 ec 08             	sub    $0x8,%esp
80105c83:	56                   	push   %esi
80105c84:	53                   	push   %ebx
80105c85:	e8 a6 f3 ff ff       	call   80105030 <sleep>
  while (lk->locked) {
80105c8a:	8b 03                	mov    (%ebx),%eax
80105c8c:	83 c4 10             	add    $0x10,%esp
80105c8f:	85 c0                	test   %eax,%eax
80105c91:	75 ed                	jne    80105c80 <acquiresleep+0x20>
  }
  lk->locked = 1;
80105c93:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80105c99:	e8 b2 ec ff ff       	call   80104950 <myproc>
80105c9e:	8b 40 10             	mov    0x10(%eax),%eax
80105ca1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80105ca4:	89 75 08             	mov    %esi,0x8(%ebp)
}
80105ca7:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105caa:	5b                   	pop    %ebx
80105cab:	5e                   	pop    %esi
80105cac:	5d                   	pop    %ebp
  release(&lk->lk);
80105cad:	e9 0e 02 00 00       	jmp    80105ec0 <release>
80105cb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105cb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105cc0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80105cc0:	55                   	push   %ebp
80105cc1:	89 e5                	mov    %esp,%ebp
80105cc3:	56                   	push   %esi
80105cc4:	53                   	push   %ebx
80105cc5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80105cc8:	8d 73 04             	lea    0x4(%ebx),%esi
80105ccb:	83 ec 0c             	sub    $0xc,%esp
80105cce:	56                   	push   %esi
80105ccf:	e8 4c 02 00 00       	call   80105f20 <acquire>
  lk->locked = 0;
80105cd4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80105cda:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80105ce1:	89 1c 24             	mov    %ebx,(%esp)
80105ce4:	e8 07 f4 ff ff       	call   801050f0 <wakeup>
  release(&lk->lk);
80105ce9:	89 75 08             	mov    %esi,0x8(%ebp)
80105cec:	83 c4 10             	add    $0x10,%esp
}
80105cef:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105cf2:	5b                   	pop    %ebx
80105cf3:	5e                   	pop    %esi
80105cf4:	5d                   	pop    %ebp
  release(&lk->lk);
80105cf5:	e9 c6 01 00 00       	jmp    80105ec0 <release>
80105cfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105d00 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80105d00:	55                   	push   %ebp
80105d01:	89 e5                	mov    %esp,%ebp
80105d03:	57                   	push   %edi
80105d04:	31 ff                	xor    %edi,%edi
80105d06:	56                   	push   %esi
80105d07:	53                   	push   %ebx
80105d08:	83 ec 18             	sub    $0x18,%esp
80105d0b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80105d0e:	8d 73 04             	lea    0x4(%ebx),%esi
80105d11:	56                   	push   %esi
80105d12:	e8 09 02 00 00       	call   80105f20 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80105d17:	8b 03                	mov    (%ebx),%eax
80105d19:	83 c4 10             	add    $0x10,%esp
80105d1c:	85 c0                	test   %eax,%eax
80105d1e:	75 18                	jne    80105d38 <holdingsleep+0x38>
  release(&lk->lk);
80105d20:	83 ec 0c             	sub    $0xc,%esp
80105d23:	56                   	push   %esi
80105d24:	e8 97 01 00 00       	call   80105ec0 <release>
  return r;
}
80105d29:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d2c:	89 f8                	mov    %edi,%eax
80105d2e:	5b                   	pop    %ebx
80105d2f:	5e                   	pop    %esi
80105d30:	5f                   	pop    %edi
80105d31:	5d                   	pop    %ebp
80105d32:	c3                   	ret    
80105d33:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105d37:	90                   	nop
  r = lk->locked && (lk->pid == myproc()->pid);
80105d38:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80105d3b:	e8 10 ec ff ff       	call   80104950 <myproc>
80105d40:	39 58 10             	cmp    %ebx,0x10(%eax)
80105d43:	0f 94 c0             	sete   %al
80105d46:	0f b6 c0             	movzbl %al,%eax
80105d49:	89 c7                	mov    %eax,%edi
80105d4b:	eb d3                	jmp    80105d20 <holdingsleep+0x20>
80105d4d:	66 90                	xchg   %ax,%ax
80105d4f:	90                   	nop

80105d50 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80105d50:	55                   	push   %ebp
80105d51:	89 e5                	mov    %esp,%ebp
80105d53:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80105d56:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80105d59:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80105d5f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80105d62:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80105d69:	5d                   	pop    %ebp
80105d6a:	c3                   	ret    
80105d6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105d6f:	90                   	nop

80105d70 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105d70:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80105d71:	31 d2                	xor    %edx,%edx
{
80105d73:	89 e5                	mov    %esp,%ebp
80105d75:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80105d76:	8b 45 08             	mov    0x8(%ebp),%eax
{
80105d79:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80105d7c:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
80105d7f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105d80:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80105d86:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80105d8c:	77 1a                	ja     80105da8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
80105d8e:	8b 58 04             	mov    0x4(%eax),%ebx
80105d91:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80105d94:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80105d97:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80105d99:	83 fa 0a             	cmp    $0xa,%edx
80105d9c:	75 e2                	jne    80105d80 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80105d9e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105da1:	c9                   	leave  
80105da2:	c3                   	ret    
80105da3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105da7:	90                   	nop
  for(; i < 10; i++)
80105da8:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80105dab:	8d 51 28             	lea    0x28(%ecx),%edx
80105dae:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80105db0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80105db6:	83 c0 04             	add    $0x4,%eax
80105db9:	39 d0                	cmp    %edx,%eax
80105dbb:	75 f3                	jne    80105db0 <getcallerpcs+0x40>
}
80105dbd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105dc0:	c9                   	leave  
80105dc1:	c3                   	ret    
80105dc2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105dd0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105dd0:	55                   	push   %ebp
80105dd1:	89 e5                	mov    %esp,%ebp
80105dd3:	53                   	push   %ebx
80105dd4:	83 ec 04             	sub    $0x4,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105dd7:	9c                   	pushf  
80105dd8:	5b                   	pop    %ebx
  asm volatile("cli");
80105dd9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80105dda:	e8 f1 ea ff ff       	call   801048d0 <mycpu>
80105ddf:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80105de5:	85 c0                	test   %eax,%eax
80105de7:	74 17                	je     80105e00 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80105de9:	e8 e2 ea ff ff       	call   801048d0 <mycpu>
80105dee:	83 80 ac 00 00 00 01 	addl   $0x1,0xac(%eax)
}
80105df5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105df8:	c9                   	leave  
80105df9:	c3                   	ret    
80105dfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
80105e00:	e8 cb ea ff ff       	call   801048d0 <mycpu>
80105e05:	81 e3 00 02 00 00    	and    $0x200,%ebx
80105e0b:	89 98 b0 00 00 00    	mov    %ebx,0xb0(%eax)
80105e11:	eb d6                	jmp    80105de9 <pushcli+0x19>
80105e13:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105e20 <popcli>:

void
popcli(void)
{
80105e20:	55                   	push   %ebp
80105e21:	89 e5                	mov    %esp,%ebp
80105e23:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105e26:	9c                   	pushf  
80105e27:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80105e28:	f6 c4 02             	test   $0x2,%ah
80105e2b:	75 35                	jne    80105e62 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80105e2d:	e8 9e ea ff ff       	call   801048d0 <mycpu>
80105e32:	83 a8 ac 00 00 00 01 	subl   $0x1,0xac(%eax)
80105e39:	78 34                	js     80105e6f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105e3b:	e8 90 ea ff ff       	call   801048d0 <mycpu>
80105e40:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
80105e46:	85 d2                	test   %edx,%edx
80105e48:	74 06                	je     80105e50 <popcli+0x30>
    sti();
}
80105e4a:	c9                   	leave  
80105e4b:	c3                   	ret    
80105e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105e50:	e8 7b ea ff ff       	call   801048d0 <mycpu>
80105e55:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80105e5b:	85 c0                	test   %eax,%eax
80105e5d:	74 eb                	je     80105e4a <popcli+0x2a>
  asm volatile("sti");
80105e5f:	fb                   	sti    
}
80105e60:	c9                   	leave  
80105e61:	c3                   	ret    
    panic("popcli - interruptible");
80105e62:	83 ec 0c             	sub    $0xc,%esp
80105e65:	68 ff 9e 10 80       	push   $0x80109eff
80105e6a:	e8 61 a6 ff ff       	call   801004d0 <panic>
    panic("popcli");
80105e6f:	83 ec 0c             	sub    $0xc,%esp
80105e72:	68 16 9f 10 80       	push   $0x80109f16
80105e77:	e8 54 a6 ff ff       	call   801004d0 <panic>
80105e7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105e80 <holding>:
{
80105e80:	55                   	push   %ebp
80105e81:	89 e5                	mov    %esp,%ebp
80105e83:	56                   	push   %esi
80105e84:	53                   	push   %ebx
80105e85:	8b 75 08             	mov    0x8(%ebp),%esi
80105e88:	31 db                	xor    %ebx,%ebx
  pushcli();
80105e8a:	e8 41 ff ff ff       	call   80105dd0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80105e8f:	8b 06                	mov    (%esi),%eax
80105e91:	85 c0                	test   %eax,%eax
80105e93:	75 0b                	jne    80105ea0 <holding+0x20>
  popcli();
80105e95:	e8 86 ff ff ff       	call   80105e20 <popcli>
}
80105e9a:	89 d8                	mov    %ebx,%eax
80105e9c:	5b                   	pop    %ebx
80105e9d:	5e                   	pop    %esi
80105e9e:	5d                   	pop    %ebp
80105e9f:	c3                   	ret    
  r = lock->locked && lock->cpu == mycpu();
80105ea0:	8b 5e 08             	mov    0x8(%esi),%ebx
80105ea3:	e8 28 ea ff ff       	call   801048d0 <mycpu>
80105ea8:	39 c3                	cmp    %eax,%ebx
80105eaa:	0f 94 c3             	sete   %bl
  popcli();
80105ead:	e8 6e ff ff ff       	call   80105e20 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80105eb2:	0f b6 db             	movzbl %bl,%ebx
}
80105eb5:	89 d8                	mov    %ebx,%eax
80105eb7:	5b                   	pop    %ebx
80105eb8:	5e                   	pop    %esi
80105eb9:	5d                   	pop    %ebp
80105eba:	c3                   	ret    
80105ebb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105ebf:	90                   	nop

80105ec0 <release>:
{
80105ec0:	55                   	push   %ebp
80105ec1:	89 e5                	mov    %esp,%ebp
80105ec3:	56                   	push   %esi
80105ec4:	53                   	push   %ebx
80105ec5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80105ec8:	e8 03 ff ff ff       	call   80105dd0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80105ecd:	8b 03                	mov    (%ebx),%eax
80105ecf:	85 c0                	test   %eax,%eax
80105ed1:	75 15                	jne    80105ee8 <release+0x28>
  popcli();
80105ed3:	e8 48 ff ff ff       	call   80105e20 <popcli>
    panic("release");
80105ed8:	83 ec 0c             	sub    $0xc,%esp
80105edb:	68 1d 9f 10 80       	push   $0x80109f1d
80105ee0:	e8 eb a5 ff ff       	call   801004d0 <panic>
80105ee5:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80105ee8:	8b 73 08             	mov    0x8(%ebx),%esi
80105eeb:	e8 e0 e9 ff ff       	call   801048d0 <mycpu>
80105ef0:	39 c6                	cmp    %eax,%esi
80105ef2:	75 df                	jne    80105ed3 <release+0x13>
  popcli();
80105ef4:	e8 27 ff ff ff       	call   80105e20 <popcli>
  lk->pcs[0] = 0;
80105ef9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80105f00:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80105f07:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80105f0c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80105f12:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105f15:	5b                   	pop    %ebx
80105f16:	5e                   	pop    %esi
80105f17:	5d                   	pop    %ebp
  popcli();
80105f18:	e9 03 ff ff ff       	jmp    80105e20 <popcli>
80105f1d:	8d 76 00             	lea    0x0(%esi),%esi

80105f20 <acquire>:
{
80105f20:	55                   	push   %ebp
80105f21:	89 e5                	mov    %esp,%ebp
80105f23:	53                   	push   %ebx
80105f24:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80105f27:	e8 a4 fe ff ff       	call   80105dd0 <pushcli>
  if(holding(lk))
80105f2c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80105f2f:	e8 9c fe ff ff       	call   80105dd0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80105f34:	8b 03                	mov    (%ebx),%eax
80105f36:	85 c0                	test   %eax,%eax
80105f38:	75 7e                	jne    80105fb8 <acquire+0x98>
  popcli();
80105f3a:	e8 e1 fe ff ff       	call   80105e20 <popcli>
  asm volatile("lock; xchgl %0, %1" :
80105f3f:	b9 01 00 00 00       	mov    $0x1,%ecx
80105f44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(xchg(&lk->locked, 1) != 0)
80105f48:	8b 55 08             	mov    0x8(%ebp),%edx
80105f4b:	89 c8                	mov    %ecx,%eax
80105f4d:	f0 87 02             	lock xchg %eax,(%edx)
80105f50:	85 c0                	test   %eax,%eax
80105f52:	75 f4                	jne    80105f48 <acquire+0x28>
  __sync_synchronize();
80105f54:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80105f59:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105f5c:	e8 6f e9 ff ff       	call   801048d0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80105f61:	8b 4d 08             	mov    0x8(%ebp),%ecx
  ebp = (uint*)v - 2;
80105f64:	89 ea                	mov    %ebp,%edx
  lk->cpu = mycpu();
80105f66:	89 43 08             	mov    %eax,0x8(%ebx)
  for(i = 0; i < 10; i++){
80105f69:	31 c0                	xor    %eax,%eax
80105f6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105f6f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105f70:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80105f76:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80105f7c:	77 1a                	ja     80105f98 <acquire+0x78>
    pcs[i] = ebp[1];     // saved %eip
80105f7e:	8b 5a 04             	mov    0x4(%edx),%ebx
80105f81:	89 5c 81 0c          	mov    %ebx,0xc(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80105f85:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80105f88:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
80105f8a:	83 f8 0a             	cmp    $0xa,%eax
80105f8d:	75 e1                	jne    80105f70 <acquire+0x50>
}
80105f8f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105f92:	c9                   	leave  
80105f93:	c3                   	ret    
80105f94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80105f98:	8d 44 81 0c          	lea    0xc(%ecx,%eax,4),%eax
80105f9c:	8d 51 34             	lea    0x34(%ecx),%edx
80105f9f:	90                   	nop
    pcs[i] = 0;
80105fa0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80105fa6:	83 c0 04             	add    $0x4,%eax
80105fa9:	39 c2                	cmp    %eax,%edx
80105fab:	75 f3                	jne    80105fa0 <acquire+0x80>
}
80105fad:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105fb0:	c9                   	leave  
80105fb1:	c3                   	ret    
80105fb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80105fb8:	8b 5b 08             	mov    0x8(%ebx),%ebx
80105fbb:	e8 10 e9 ff ff       	call   801048d0 <mycpu>
80105fc0:	39 c3                	cmp    %eax,%ebx
80105fc2:	0f 85 72 ff ff ff    	jne    80105f3a <acquire+0x1a>
  popcli();
80105fc8:	e8 53 fe ff ff       	call   80105e20 <popcli>
    panic("acquire");
80105fcd:	83 ec 0c             	sub    $0xc,%esp
80105fd0:	68 25 9f 10 80       	push   $0x80109f25
80105fd5:	e8 f6 a4 ff ff       	call   801004d0 <panic>
80105fda:	66 90                	xchg   %ax,%ax
80105fdc:	66 90                	xchg   %ax,%ax
80105fde:	66 90                	xchg   %ax,%ax

80105fe0 <init_reentrantlock>:
// #include "types.h"
// #include "param.h"
// #include "memlayout.h"
// #include "reentrantlock.h"

void init_reentrantlock(struct reentrantlock* rl) {
80105fe0:	55                   	push   %ebp
80105fe1:	89 e5                	mov    %esp,%ebp
80105fe3:	53                   	push   %ebx
80105fe4:	83 ec 10             	sub    $0x10,%esp
80105fe7:	8b 5d 08             	mov    0x8(%ebp),%ebx
    cprintf("entered init reentrantlock\n");
80105fea:	68 2d 9f 10 80       	push   $0x80109f2d
80105fef:	e8 fc a7 ff ff       	call   801007f0 <cprintf>
    initlock(&rl->sl, "myRL");
80105ff4:	58                   	pop    %eax
80105ff5:	8d 43 04             	lea    0x4(%ebx),%eax
80105ff8:	5a                   	pop    %edx
80105ff9:	68 49 9f 10 80       	push   $0x80109f49
80105ffe:	50                   	push   %eax
80105fff:	e8 4c fd ff ff       	call   80105d50 <initlock>
    rl->locked = 0;
80106004:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
    rl->owner_pid = -1; // meaning it has no owner yet
    rl->rec = 0;
    cprintf("exit init reentrantlock\n");
8010600a:	83 c4 10             	add    $0x10,%esp
    rl->owner_pid = -1; // meaning it has no owner yet
8010600d:	c7 43 3c ff ff ff ff 	movl   $0xffffffff,0x3c(%ebx)
    rl->rec = 0;
80106014:	c7 43 38 00 00 00 00 	movl   $0x0,0x38(%ebx)
}
8010601b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    cprintf("exit init reentrantlock\n");
8010601e:	c7 45 08 4e 9f 10 80 	movl   $0x80109f4e,0x8(%ebp)
}
80106025:	c9                   	leave  
    cprintf("exit init reentrantlock\n");
80106026:	e9 c5 a7 ff ff       	jmp    801007f0 <cprintf>
8010602b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010602f:	90                   	nop

80106030 <acquire_reentrantlock>:

void acquire_reentrantlock(struct reentrantlock *rl) {
80106030:	55                   	push   %ebp
80106031:	89 e5                	mov    %esp,%ebp
80106033:	57                   	push   %edi
80106034:	56                   	push   %esi
80106035:	53                   	push   %ebx
80106036:	83 ec 0c             	sub    $0xc,%esp
80106039:	8b 5d 08             	mov    0x8(%ebp),%ebx
    int cur = myproc()->pid;
8010603c:	e8 0f e9 ff ff       	call   80104950 <myproc>

    acquire(&rl->sl);
80106041:	83 ec 0c             	sub    $0xc,%esp
80106044:	8d 73 04             	lea    0x4(%ebx),%esi
    int cur = myproc()->pid;
80106047:	8b 78 10             	mov    0x10(%eax),%edi
    acquire(&rl->sl);
8010604a:	56                   	push   %esi
8010604b:	e8 d0 fe ff ff       	call   80105f20 <acquire>
    if (rl->locked && rl->owner_pid == cur) {
80106050:	8b 13                	mov    (%ebx),%edx
80106052:	83 c4 10             	add    $0x10,%esp
80106055:	85 d2                	test   %edx,%edx
80106057:	74 1a                	je     80106073 <acquire_reentrantlock+0x43>
80106059:	39 7b 3c             	cmp    %edi,0x3c(%ebx)
8010605c:	74 34                	je     80106092 <acquire_reentrantlock+0x62>
8010605e:	66 90                	xchg   %ax,%ax
        release(&rl->sl);
        return;
    }

    while (rl->locked) {
        sleep(rl, &rl->sl);
80106060:	83 ec 08             	sub    $0x8,%esp
80106063:	56                   	push   %esi
80106064:	53                   	push   %ebx
80106065:	e8 c6 ef ff ff       	call   80105030 <sleep>
    while (rl->locked) {
8010606a:	8b 03                	mov    (%ebx),%eax
8010606c:	83 c4 10             	add    $0x10,%esp
8010606f:	85 c0                	test   %eax,%eax
80106071:	75 ed                	jne    80106060 <acquire_reentrantlock+0x30>
    }

    rl->locked = 1;
80106073:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
    rl->owner_pid = cur;
80106079:	89 7b 3c             	mov    %edi,0x3c(%ebx)
    rl->rec = 1;
8010607c:	c7 43 38 01 00 00 00 	movl   $0x1,0x38(%ebx)
    release(&rl->sl);
80106083:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106086:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106089:	5b                   	pop    %ebx
8010608a:	5e                   	pop    %esi
8010608b:	5f                   	pop    %edi
8010608c:	5d                   	pop    %ebp
    release(&rl->sl);
8010608d:	e9 2e fe ff ff       	jmp    80105ec0 <release>
        rl->rec++;
80106092:	83 43 38 01          	addl   $0x1,0x38(%ebx)
        release(&rl->sl);
80106096:	eb eb                	jmp    80106083 <acquire_reentrantlock+0x53>
80106098:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010609f:	90                   	nop

801060a0 <release_reentrantlock>:

void release_reentrantlock(struct reentrantlock *rl) {
801060a0:	55                   	push   %ebp
801060a1:	89 e5                	mov    %esp,%ebp
801060a3:	57                   	push   %edi
801060a4:	56                   	push   %esi
801060a5:	53                   	push   %ebx
801060a6:	83 ec 18             	sub    $0x18,%esp
801060a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
    acquire(&rl->sl);
801060ac:	8d 73 04             	lea    0x4(%ebx),%esi
801060af:	56                   	push   %esi
801060b0:	e8 6b fe ff ff       	call   80105f20 <acquire>
    if (rl->owner_pid != myproc()->pid) {
801060b5:	8b 7b 3c             	mov    0x3c(%ebx),%edi
801060b8:	e8 93 e8 ff ff       	call   80104950 <myproc>
801060bd:	83 c4 10             	add    $0x10,%esp
801060c0:	3b 78 10             	cmp    0x10(%eax),%edi
801060c3:	75 06                	jne    801060cb <release_reentrantlock+0x2b>
        release(&rl->sl);
        return;
    }

    rl->rec--;
801060c5:	83 6b 38 01          	subl   $0x1,0x38(%ebx)
    if (rl->rec == 0) {
801060c9:	74 15                	je     801060e0 <release_reentrantlock+0x40>
        rl->locked = 0;
        rl->owner_pid = -1;
        wakeup(rl);
    }
    release(&rl->sl);
801060cb:	89 75 08             	mov    %esi,0x8(%ebp)
801060ce:	8d 65 f4             	lea    -0xc(%ebp),%esp
801060d1:	5b                   	pop    %ebx
801060d2:	5e                   	pop    %esi
801060d3:	5f                   	pop    %edi
801060d4:	5d                   	pop    %ebp
    release(&rl->sl);
801060d5:	e9 e6 fd ff ff       	jmp    80105ec0 <release>
801060da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        wakeup(rl);
801060e0:	83 ec 0c             	sub    $0xc,%esp
        rl->locked = 0;
801060e3:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
        rl->owner_pid = -1;
801060e9:	c7 43 3c ff ff ff ff 	movl   $0xffffffff,0x3c(%ebx)
        wakeup(rl);
801060f0:	53                   	push   %ebx
801060f1:	e8 fa ef ff ff       	call   801050f0 <wakeup>
    release(&rl->sl);
801060f6:	89 75 08             	mov    %esi,0x8(%ebp)
        wakeup(rl);
801060f9:	83 c4 10             	add    $0x10,%esp
801060fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801060ff:	5b                   	pop    %ebx
80106100:	5e                   	pop    %esi
80106101:	5f                   	pop    %edi
80106102:	5d                   	pop    %ebp
    release(&rl->sl);
80106103:	e9 b8 fd ff ff       	jmp    80105ec0 <release>
80106108:	66 90                	xchg   %ax,%ax
8010610a:	66 90                	xchg   %ax,%ax
8010610c:	66 90                	xchg   %ax,%ax
8010610e:	66 90                	xchg   %ax,%ax

80106110 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80106110:	55                   	push   %ebp
80106111:	89 e5                	mov    %esp,%ebp
80106113:	57                   	push   %edi
80106114:	8b 55 08             	mov    0x8(%ebp),%edx
80106117:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010611a:	53                   	push   %ebx
8010611b:	8b 45 0c             	mov    0xc(%ebp),%eax
  if ((int)dst%4 == 0 && n%4 == 0){
8010611e:	89 d7                	mov    %edx,%edi
80106120:	09 cf                	or     %ecx,%edi
80106122:	83 e7 03             	and    $0x3,%edi
80106125:	75 29                	jne    80106150 <memset+0x40>
    c &= 0xFF;
80106127:	0f b6 f8             	movzbl %al,%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010612a:	c1 e0 18             	shl    $0x18,%eax
8010612d:	89 fb                	mov    %edi,%ebx
8010612f:	c1 e9 02             	shr    $0x2,%ecx
80106132:	c1 e3 10             	shl    $0x10,%ebx
80106135:	09 d8                	or     %ebx,%eax
80106137:	09 f8                	or     %edi,%eax
80106139:	c1 e7 08             	shl    $0x8,%edi
8010613c:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
8010613e:	89 d7                	mov    %edx,%edi
80106140:	fc                   	cld    
80106141:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80106143:	5b                   	pop    %ebx
80106144:	89 d0                	mov    %edx,%eax
80106146:	5f                   	pop    %edi
80106147:	5d                   	pop    %ebp
80106148:	c3                   	ret    
80106149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
80106150:	89 d7                	mov    %edx,%edi
80106152:	fc                   	cld    
80106153:	f3 aa                	rep stos %al,%es:(%edi)
80106155:	5b                   	pop    %ebx
80106156:	89 d0                	mov    %edx,%eax
80106158:	5f                   	pop    %edi
80106159:	5d                   	pop    %ebp
8010615a:	c3                   	ret    
8010615b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010615f:	90                   	nop

80106160 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80106160:	55                   	push   %ebp
80106161:	89 e5                	mov    %esp,%ebp
80106163:	56                   	push   %esi
80106164:	8b 75 10             	mov    0x10(%ebp),%esi
80106167:	8b 55 08             	mov    0x8(%ebp),%edx
8010616a:	53                   	push   %ebx
8010616b:	8b 45 0c             	mov    0xc(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010616e:	85 f6                	test   %esi,%esi
80106170:	74 2e                	je     801061a0 <memcmp+0x40>
80106172:	01 c6                	add    %eax,%esi
80106174:	eb 14                	jmp    8010618a <memcmp+0x2a>
80106176:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010617d:	8d 76 00             	lea    0x0(%esi),%esi
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80106180:	83 c0 01             	add    $0x1,%eax
80106183:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80106186:	39 f0                	cmp    %esi,%eax
80106188:	74 16                	je     801061a0 <memcmp+0x40>
    if(*s1 != *s2)
8010618a:	0f b6 0a             	movzbl (%edx),%ecx
8010618d:	0f b6 18             	movzbl (%eax),%ebx
80106190:	38 d9                	cmp    %bl,%cl
80106192:	74 ec                	je     80106180 <memcmp+0x20>
      return *s1 - *s2;
80106194:	0f b6 c1             	movzbl %cl,%eax
80106197:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80106199:	5b                   	pop    %ebx
8010619a:	5e                   	pop    %esi
8010619b:	5d                   	pop    %ebp
8010619c:	c3                   	ret    
8010619d:	8d 76 00             	lea    0x0(%esi),%esi
801061a0:	5b                   	pop    %ebx
  return 0;
801061a1:	31 c0                	xor    %eax,%eax
}
801061a3:	5e                   	pop    %esi
801061a4:	5d                   	pop    %ebp
801061a5:	c3                   	ret    
801061a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801061ad:	8d 76 00             	lea    0x0(%esi),%esi

801061b0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801061b0:	55                   	push   %ebp
801061b1:	89 e5                	mov    %esp,%ebp
801061b3:	57                   	push   %edi
801061b4:	8b 55 08             	mov    0x8(%ebp),%edx
801061b7:	8b 4d 10             	mov    0x10(%ebp),%ecx
801061ba:	56                   	push   %esi
801061bb:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801061be:	39 d6                	cmp    %edx,%esi
801061c0:	73 26                	jae    801061e8 <memmove+0x38>
801061c2:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
801061c5:	39 fa                	cmp    %edi,%edx
801061c7:	73 1f                	jae    801061e8 <memmove+0x38>
801061c9:	8d 41 ff             	lea    -0x1(%ecx),%eax
    s += n;
    d += n;
    while(n-- > 0)
801061cc:	85 c9                	test   %ecx,%ecx
801061ce:	74 0c                	je     801061dc <memmove+0x2c>
      *--d = *--s;
801061d0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
801061d4:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
801061d7:	83 e8 01             	sub    $0x1,%eax
801061da:	73 f4                	jae    801061d0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
801061dc:	5e                   	pop    %esi
801061dd:	89 d0                	mov    %edx,%eax
801061df:	5f                   	pop    %edi
801061e0:	5d                   	pop    %ebp
801061e1:	c3                   	ret    
801061e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
801061e8:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
801061eb:	89 d7                	mov    %edx,%edi
801061ed:	85 c9                	test   %ecx,%ecx
801061ef:	74 eb                	je     801061dc <memmove+0x2c>
801061f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
801061f8:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
801061f9:	39 c6                	cmp    %eax,%esi
801061fb:	75 fb                	jne    801061f8 <memmove+0x48>
}
801061fd:	5e                   	pop    %esi
801061fe:	89 d0                	mov    %edx,%eax
80106200:	5f                   	pop    %edi
80106201:	5d                   	pop    %ebp
80106202:	c3                   	ret    
80106203:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010620a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106210 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80106210:	eb 9e                	jmp    801061b0 <memmove>
80106212:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106220 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80106220:	55                   	push   %ebp
80106221:	89 e5                	mov    %esp,%ebp
80106223:	56                   	push   %esi
80106224:	8b 75 10             	mov    0x10(%ebp),%esi
80106227:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010622a:	53                   	push   %ebx
8010622b:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(n > 0 && *p && *p == *q)
8010622e:	85 f6                	test   %esi,%esi
80106230:	74 2e                	je     80106260 <strncmp+0x40>
80106232:	01 d6                	add    %edx,%esi
80106234:	eb 18                	jmp    8010624e <strncmp+0x2e>
80106236:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010623d:	8d 76 00             	lea    0x0(%esi),%esi
80106240:	38 d8                	cmp    %bl,%al
80106242:	75 14                	jne    80106258 <strncmp+0x38>
    n--, p++, q++;
80106244:	83 c2 01             	add    $0x1,%edx
80106247:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
8010624a:	39 f2                	cmp    %esi,%edx
8010624c:	74 12                	je     80106260 <strncmp+0x40>
8010624e:	0f b6 01             	movzbl (%ecx),%eax
80106251:	0f b6 1a             	movzbl (%edx),%ebx
80106254:	84 c0                	test   %al,%al
80106256:	75 e8                	jne    80106240 <strncmp+0x20>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80106258:	29 d8                	sub    %ebx,%eax
}
8010625a:	5b                   	pop    %ebx
8010625b:	5e                   	pop    %esi
8010625c:	5d                   	pop    %ebp
8010625d:	c3                   	ret    
8010625e:	66 90                	xchg   %ax,%ax
80106260:	5b                   	pop    %ebx
    return 0;
80106261:	31 c0                	xor    %eax,%eax
}
80106263:	5e                   	pop    %esi
80106264:	5d                   	pop    %ebp
80106265:	c3                   	ret    
80106266:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010626d:	8d 76 00             	lea    0x0(%esi),%esi

80106270 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80106270:	55                   	push   %ebp
80106271:	89 e5                	mov    %esp,%ebp
80106273:	57                   	push   %edi
80106274:	56                   	push   %esi
80106275:	8b 75 08             	mov    0x8(%ebp),%esi
80106278:	53                   	push   %ebx
80106279:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010627c:	89 f0                	mov    %esi,%eax
8010627e:	eb 15                	jmp    80106295 <strncpy+0x25>
80106280:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80106284:	8b 7d 0c             	mov    0xc(%ebp),%edi
80106287:	83 c0 01             	add    $0x1,%eax
8010628a:	0f b6 57 ff          	movzbl -0x1(%edi),%edx
8010628e:	88 50 ff             	mov    %dl,-0x1(%eax)
80106291:	84 d2                	test   %dl,%dl
80106293:	74 09                	je     8010629e <strncpy+0x2e>
80106295:	89 cb                	mov    %ecx,%ebx
80106297:	83 e9 01             	sub    $0x1,%ecx
8010629a:	85 db                	test   %ebx,%ebx
8010629c:	7f e2                	jg     80106280 <strncpy+0x10>
    ;
  while(n-- > 0)
8010629e:	89 c2                	mov    %eax,%edx
801062a0:	85 c9                	test   %ecx,%ecx
801062a2:	7e 17                	jle    801062bb <strncpy+0x4b>
801062a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
801062a8:	83 c2 01             	add    $0x1,%edx
801062ab:	89 c1                	mov    %eax,%ecx
801062ad:	c6 42 ff 00          	movb   $0x0,-0x1(%edx)
  while(n-- > 0)
801062b1:	29 d1                	sub    %edx,%ecx
801062b3:	8d 4c 0b ff          	lea    -0x1(%ebx,%ecx,1),%ecx
801062b7:	85 c9                	test   %ecx,%ecx
801062b9:	7f ed                	jg     801062a8 <strncpy+0x38>
  return os;
}
801062bb:	5b                   	pop    %ebx
801062bc:	89 f0                	mov    %esi,%eax
801062be:	5e                   	pop    %esi
801062bf:	5f                   	pop    %edi
801062c0:	5d                   	pop    %ebp
801062c1:	c3                   	ret    
801062c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801062c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801062d0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
801062d0:	55                   	push   %ebp
801062d1:	89 e5                	mov    %esp,%ebp
801062d3:	56                   	push   %esi
801062d4:	8b 55 10             	mov    0x10(%ebp),%edx
801062d7:	8b 75 08             	mov    0x8(%ebp),%esi
801062da:	53                   	push   %ebx
801062db:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
801062de:	85 d2                	test   %edx,%edx
801062e0:	7e 25                	jle    80106307 <safestrcpy+0x37>
801062e2:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
801062e6:	89 f2                	mov    %esi,%edx
801062e8:	eb 16                	jmp    80106300 <safestrcpy+0x30>
801062ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
801062f0:	0f b6 08             	movzbl (%eax),%ecx
801062f3:	83 c0 01             	add    $0x1,%eax
801062f6:	83 c2 01             	add    $0x1,%edx
801062f9:	88 4a ff             	mov    %cl,-0x1(%edx)
801062fc:	84 c9                	test   %cl,%cl
801062fe:	74 04                	je     80106304 <safestrcpy+0x34>
80106300:	39 d8                	cmp    %ebx,%eax
80106302:	75 ec                	jne    801062f0 <safestrcpy+0x20>
    ;
  *s = 0;
80106304:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80106307:	89 f0                	mov    %esi,%eax
80106309:	5b                   	pop    %ebx
8010630a:	5e                   	pop    %esi
8010630b:	5d                   	pop    %ebp
8010630c:	c3                   	ret    
8010630d:	8d 76 00             	lea    0x0(%esi),%esi

80106310 <strlen>:

int
strlen(const char *s)
{
80106310:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80106311:	31 c0                	xor    %eax,%eax
{
80106313:	89 e5                	mov    %esp,%ebp
80106315:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80106318:	80 3a 00             	cmpb   $0x0,(%edx)
8010631b:	74 0c                	je     80106329 <strlen+0x19>
8010631d:	8d 76 00             	lea    0x0(%esi),%esi
80106320:	83 c0 01             	add    $0x1,%eax
80106323:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80106327:	75 f7                	jne    80106320 <strlen+0x10>
    ;
  return n;
}
80106329:	5d                   	pop    %ebp
8010632a:	c3                   	ret    
8010632b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010632f:	90                   	nop

80106330 <align_word>:

void align_word(char* inp, int max_size, char* out) {
80106330:	55                   	push   %ebp
  int i=0;
80106331:	31 c0                	xor    %eax,%eax
void align_word(char* inp, int max_size, char* out) {
80106333:	89 e5                	mov    %esp,%ebp
80106335:	56                   	push   %esi
80106336:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106339:	8b 75 08             	mov    0x8(%ebp),%esi
8010633c:	53                   	push   %ebx
8010633d:	8b 5d 10             	mov    0x10(%ebp),%ebx
80106340:	eb 10                	jmp    80106352 <align_word+0x22>
80106342:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if (inp[i] == '\0') {
      while (i < max_size) {
        out[i++] = ' ';
      }
    } else {
      out[i] = inp[i];
80106348:	88 14 03             	mov    %dl,(%ebx,%eax,1)
      i++;
8010634b:	83 c0 01             	add    $0x1,%eax
    }
    if (i == max_size) {
8010634e:	39 c8                	cmp    %ecx,%eax
80106350:	74 20                	je     80106372 <align_word+0x42>
    if (inp[i] == '\0') {
80106352:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
80106356:	84 d2                	test   %dl,%dl
80106358:	75 ee                	jne    80106348 <align_word+0x18>
      while (i < max_size) {
8010635a:	39 c8                	cmp    %ecx,%eax
8010635c:	7d f0                	jge    8010634e <align_word+0x1e>
8010635e:	01 d8                	add    %ebx,%eax
80106360:	8d 14 0b             	lea    (%ebx,%ecx,1),%edx
80106363:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106367:	90                   	nop
        out[i++] = ' ';
80106368:	c6 00 20             	movb   $0x20,(%eax)
      while (i < max_size) {
8010636b:	83 c0 01             	add    $0x1,%eax
8010636e:	39 d0                	cmp    %edx,%eax
80106370:	75 f6                	jne    80106368 <align_word+0x38>
      break;
    }
  }
  out[max_size] = '\0';
80106372:	c6 04 0b 00          	movb   $0x0,(%ebx,%ecx,1)
}
80106376:	5b                   	pop    %ebx
80106377:	5e                   	pop    %esi
80106378:	5d                   	pop    %ebp
80106379:	c3                   	ret    
8010637a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106380 <myitos>:

void myitos(int num, char *str, int base) {
80106380:	55                   	push   %ebp
80106381:	89 e5                	mov    %esp,%ebp
80106383:	57                   	push   %edi
80106384:	56                   	push   %esi
80106385:	53                   	push   %ebx
80106386:	83 ec 08             	sub    $0x8,%esp
80106389:	8b 45 08             	mov    0x8(%ebp),%eax
8010638c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    int i = 0;
    int isNegative = 0;

    if (num == 0) {
8010638f:	85 c0                	test   %eax,%eax
80106391:	0f 84 91 00 00 00    	je     80106428 <myitos+0xa8>
        str[i++] = '0';
        str[i] = '\0';
        return;
    }

    if (num < 0 && base == 10) {
80106397:	79 7f                	jns    80106418 <myitos+0x98>
80106399:	83 7d 10 0a          	cmpl   $0xa,0x10(%ebp)
8010639d:	75 79                	jne    80106418 <myitos+0x98>
        isNegative = 1;
8010639f:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
        num = -num;
801063a6:	f7 d8                	neg    %eax
    }

    while (num != 0) {
        int rem = num % base;
        str[i++] = (rem > 9) ? (rem - 10) + 'a' : rem + '0';
801063a8:	31 c9                	xor    %ecx,%ecx
801063aa:	eb 06                	jmp    801063b2 <myitos+0x32>
801063ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801063b0:	89 d1                	mov    %edx,%ecx
        int rem = num % base;
801063b2:	99                   	cltd   
801063b3:	f7 7d 10             	idivl  0x10(%ebp)
        str[i++] = (rem > 9) ? (rem - 10) + 'a' : rem + '0';
801063b6:	8d 7a 57             	lea    0x57(%edx),%edi
801063b9:	8d 72 30             	lea    0x30(%edx),%esi
801063bc:	83 fa 0a             	cmp    $0xa,%edx
801063bf:	89 45 f0             	mov    %eax,-0x10(%ebp)
801063c2:	0f 4d f7             	cmovge %edi,%esi
801063c5:	8d 51 01             	lea    0x1(%ecx),%edx
801063c8:	89 f0                	mov    %esi,%eax
801063ca:	88 44 13 ff          	mov    %al,-0x1(%ebx,%edx,1)
        num = num / base;
801063ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
    while (num != 0) {
801063d1:	85 c0                	test   %eax,%eax
801063d3:	75 db                	jne    801063b0 <myitos+0x30>
    }

    if (isNegative) {
801063d5:	8b 7d ec             	mov    -0x14(%ebp),%edi
801063d8:	89 d6                	mov    %edx,%esi
        str[i++] = '-';
801063da:	8d 14 13             	lea    (%ebx,%edx,1),%edx
    if (isNegative) {
801063dd:	85 ff                	test   %edi,%edi
801063df:	74 5f                	je     80106440 <myitos+0xc0>
        str[i++] = '-';
801063e1:	c6 02 2d             	movb   $0x2d,(%edx)
    }

    str[i] = '\0';
801063e4:	c6 44 0b 02 00       	movb   $0x0,0x2(%ebx,%ecx,1)
        str[i++] = (rem > 9) ? (rem - 10) + 'a' : rem + '0';
801063e9:	89 f1                	mov    %esi,%ecx
801063eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801063ef:	90                   	nop

    int start = 0;
    int end = i - 1;
    while (start < end) {
        char temp = str[start];
801063f0:	0f b6 3c 03          	movzbl (%ebx,%eax,1),%edi
        str[start] = str[end];
801063f4:	0f b6 14 0b          	movzbl (%ebx,%ecx,1),%edx
801063f8:	88 14 03             	mov    %dl,(%ebx,%eax,1)
        str[end] = temp;
801063fb:	89 fa                	mov    %edi,%edx
        start++;
801063fd:	83 c0 01             	add    $0x1,%eax
        str[end] = temp;
80106400:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
        end--;
80106403:	83 e9 01             	sub    $0x1,%ecx
    while (start < end) {
80106406:	39 c8                	cmp    %ecx,%eax
80106408:	7c e6                	jl     801063f0 <myitos+0x70>
    }
8010640a:	83 c4 08             	add    $0x8,%esp
8010640d:	5b                   	pop    %ebx
8010640e:	5e                   	pop    %esi
8010640f:	5f                   	pop    %edi
80106410:	5d                   	pop    %ebp
80106411:	c3                   	ret    
80106412:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    int isNegative = 0;
80106418:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
8010641f:	eb 87                	jmp    801063a8 <myitos+0x28>
80106421:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        str[i++] = '0';
80106428:	b8 30 00 00 00       	mov    $0x30,%eax
8010642d:	66 89 03             	mov    %ax,(%ebx)
80106430:	83 c4 08             	add    $0x8,%esp
80106433:	5b                   	pop    %ebx
80106434:	5e                   	pop    %esi
80106435:	5f                   	pop    %edi
80106436:	5d                   	pop    %ebp
80106437:	c3                   	ret    
80106438:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010643f:	90                   	nop
    str[i] = '\0';
80106440:	c6 02 00             	movb   $0x0,(%edx)
    while (start < end) {
80106443:	85 c9                	test   %ecx,%ecx
80106445:	75 a9                	jne    801063f0 <myitos+0x70>
80106447:	eb c1                	jmp    8010640a <myitos+0x8a>

80106449 <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80106449:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010644d:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80106451:	55                   	push   %ebp
  pushl %ebx
80106452:	53                   	push   %ebx
  pushl %esi
80106453:	56                   	push   %esi
  pushl %edi
80106454:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80106455:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80106457:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80106459:	5f                   	pop    %edi
  popl %esi
8010645a:	5e                   	pop    %esi
  popl %ebx
8010645b:	5b                   	pop    %ebx
  popl %ebp
8010645c:	5d                   	pop    %ebp
  ret
8010645d:	c3                   	ret    
8010645e:	66 90                	xchg   %ax,%ax

80106460 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80106460:	55                   	push   %ebp
80106461:	89 e5                	mov    %esp,%ebp
80106463:	53                   	push   %ebx
80106464:	83 ec 04             	sub    $0x4,%esp
80106467:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010646a:	e8 e1 e4 ff ff       	call   80104950 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010646f:	8b 00                	mov    (%eax),%eax
80106471:	39 d8                	cmp    %ebx,%eax
80106473:	76 1b                	jbe    80106490 <fetchint+0x30>
80106475:	8d 53 04             	lea    0x4(%ebx),%edx
80106478:	39 d0                	cmp    %edx,%eax
8010647a:	72 14                	jb     80106490 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010647c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010647f:	8b 13                	mov    (%ebx),%edx
80106481:	89 10                	mov    %edx,(%eax)
  return 0;
80106483:	31 c0                	xor    %eax,%eax
}
80106485:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106488:	c9                   	leave  
80106489:	c3                   	ret    
8010648a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80106490:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106495:	eb ee                	jmp    80106485 <fetchint+0x25>
80106497:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010649e:	66 90                	xchg   %ax,%ax

801064a0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801064a0:	55                   	push   %ebp
801064a1:	89 e5                	mov    %esp,%ebp
801064a3:	53                   	push   %ebx
801064a4:	83 ec 04             	sub    $0x4,%esp
801064a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
801064aa:	e8 a1 e4 ff ff       	call   80104950 <myproc>

  if(addr >= curproc->sz)
801064af:	39 18                	cmp    %ebx,(%eax)
801064b1:	76 2d                	jbe    801064e0 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
801064b3:	8b 55 0c             	mov    0xc(%ebp),%edx
801064b6:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
801064b8:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
801064ba:	39 d3                	cmp    %edx,%ebx
801064bc:	73 22                	jae    801064e0 <fetchstr+0x40>
801064be:	89 d8                	mov    %ebx,%eax
801064c0:	eb 0d                	jmp    801064cf <fetchstr+0x2f>
801064c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801064c8:	83 c0 01             	add    $0x1,%eax
801064cb:	39 c2                	cmp    %eax,%edx
801064cd:	76 11                	jbe    801064e0 <fetchstr+0x40>
    if(*s == 0)
801064cf:	80 38 00             	cmpb   $0x0,(%eax)
801064d2:	75 f4                	jne    801064c8 <fetchstr+0x28>
      return s - *pp;
801064d4:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
801064d6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801064d9:	c9                   	leave  
801064da:	c3                   	ret    
801064db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801064df:	90                   	nop
801064e0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
801064e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801064e8:	c9                   	leave  
801064e9:	c3                   	ret    
801064ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801064f0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801064f0:	55                   	push   %ebp
801064f1:	89 e5                	mov    %esp,%ebp
801064f3:	56                   	push   %esi
801064f4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801064f5:	e8 56 e4 ff ff       	call   80104950 <myproc>
801064fa:	8b 55 08             	mov    0x8(%ebp),%edx
801064fd:	8b 40 18             	mov    0x18(%eax),%eax
80106500:	8b 40 44             	mov    0x44(%eax),%eax
80106503:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80106506:	e8 45 e4 ff ff       	call   80104950 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010650b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010650e:	8b 00                	mov    (%eax),%eax
80106510:	39 c6                	cmp    %eax,%esi
80106512:	73 1c                	jae    80106530 <argint+0x40>
80106514:	8d 53 08             	lea    0x8(%ebx),%edx
80106517:	39 d0                	cmp    %edx,%eax
80106519:	72 15                	jb     80106530 <argint+0x40>
  *ip = *(int*)(addr);
8010651b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010651e:	8b 53 04             	mov    0x4(%ebx),%edx
80106521:	89 10                	mov    %edx,(%eax)
  return 0;
80106523:	31 c0                	xor    %eax,%eax
}
80106525:	5b                   	pop    %ebx
80106526:	5e                   	pop    %esi
80106527:	5d                   	pop    %ebp
80106528:	c3                   	ret    
80106529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106530:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80106535:	eb ee                	jmp    80106525 <argint+0x35>
80106537:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010653e:	66 90                	xchg   %ax,%ax

80106540 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80106540:	55                   	push   %ebp
80106541:	89 e5                	mov    %esp,%ebp
80106543:	57                   	push   %edi
80106544:	56                   	push   %esi
80106545:	53                   	push   %ebx
80106546:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
80106549:	e8 02 e4 ff ff       	call   80104950 <myproc>
8010654e:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80106550:	e8 fb e3 ff ff       	call   80104950 <myproc>
80106555:	8b 55 08             	mov    0x8(%ebp),%edx
80106558:	8b 40 18             	mov    0x18(%eax),%eax
8010655b:	8b 40 44             	mov    0x44(%eax),%eax
8010655e:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80106561:	e8 ea e3 ff ff       	call   80104950 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80106566:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80106569:	8b 00                	mov    (%eax),%eax
8010656b:	39 c7                	cmp    %eax,%edi
8010656d:	73 31                	jae    801065a0 <argptr+0x60>
8010656f:	8d 4b 08             	lea    0x8(%ebx),%ecx
80106572:	39 c8                	cmp    %ecx,%eax
80106574:	72 2a                	jb     801065a0 <argptr+0x60>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80106576:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
80106579:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
8010657c:	85 d2                	test   %edx,%edx
8010657e:	78 20                	js     801065a0 <argptr+0x60>
80106580:	8b 16                	mov    (%esi),%edx
80106582:	39 c2                	cmp    %eax,%edx
80106584:	76 1a                	jbe    801065a0 <argptr+0x60>
80106586:	8b 5d 10             	mov    0x10(%ebp),%ebx
80106589:	01 c3                	add    %eax,%ebx
8010658b:	39 da                	cmp    %ebx,%edx
8010658d:	72 11                	jb     801065a0 <argptr+0x60>
    return -1;
  *pp = (char*)i;
8010658f:	8b 55 0c             	mov    0xc(%ebp),%edx
80106592:	89 02                	mov    %eax,(%edx)
  return 0;
80106594:	31 c0                	xor    %eax,%eax
}
80106596:	83 c4 0c             	add    $0xc,%esp
80106599:	5b                   	pop    %ebx
8010659a:	5e                   	pop    %esi
8010659b:	5f                   	pop    %edi
8010659c:	5d                   	pop    %ebp
8010659d:	c3                   	ret    
8010659e:	66 90                	xchg   %ax,%ax
    return -1;
801065a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801065a5:	eb ef                	jmp    80106596 <argptr+0x56>
801065a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801065ae:	66 90                	xchg   %ax,%ax

801065b0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801065b0:	55                   	push   %ebp
801065b1:	89 e5                	mov    %esp,%ebp
801065b3:	56                   	push   %esi
801065b4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801065b5:	e8 96 e3 ff ff       	call   80104950 <myproc>
801065ba:	8b 55 08             	mov    0x8(%ebp),%edx
801065bd:	8b 40 18             	mov    0x18(%eax),%eax
801065c0:	8b 40 44             	mov    0x44(%eax),%eax
801065c3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801065c6:	e8 85 e3 ff ff       	call   80104950 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801065cb:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801065ce:	8b 00                	mov    (%eax),%eax
801065d0:	39 c6                	cmp    %eax,%esi
801065d2:	73 44                	jae    80106618 <argstr+0x68>
801065d4:	8d 53 08             	lea    0x8(%ebx),%edx
801065d7:	39 d0                	cmp    %edx,%eax
801065d9:	72 3d                	jb     80106618 <argstr+0x68>
  *ip = *(int*)(addr);
801065db:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
801065de:	e8 6d e3 ff ff       	call   80104950 <myproc>
  if(addr >= curproc->sz)
801065e3:	3b 18                	cmp    (%eax),%ebx
801065e5:	73 31                	jae    80106618 <argstr+0x68>
  *pp = (char*)addr;
801065e7:	8b 55 0c             	mov    0xc(%ebp),%edx
801065ea:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
801065ec:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
801065ee:	39 d3                	cmp    %edx,%ebx
801065f0:	73 26                	jae    80106618 <argstr+0x68>
801065f2:	89 d8                	mov    %ebx,%eax
801065f4:	eb 11                	jmp    80106607 <argstr+0x57>
801065f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801065fd:	8d 76 00             	lea    0x0(%esi),%esi
80106600:	83 c0 01             	add    $0x1,%eax
80106603:	39 c2                	cmp    %eax,%edx
80106605:	76 11                	jbe    80106618 <argstr+0x68>
    if(*s == 0)
80106607:	80 38 00             	cmpb   $0x0,(%eax)
8010660a:	75 f4                	jne    80106600 <argstr+0x50>
      return s - *pp;
8010660c:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
8010660e:	5b                   	pop    %ebx
8010660f:	5e                   	pop    %esi
80106610:	5d                   	pop    %ebp
80106611:	c3                   	ret    
80106612:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106618:	5b                   	pop    %ebx
    return -1;
80106619:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010661e:	5e                   	pop    %esi
8010661f:	5d                   	pop    %ebp
80106620:	c3                   	ret    
80106621:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106628:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010662f:	90                   	nop

80106630 <my_strcpy>:
[SYS_acquire_reentrantlock] sys_acquire_reentrantlock,
[SYS_release_reentrantlock] sys_release_reentrantlock,
// P4
};

void my_strcpy(char *dest, const char *src) {
80106630:	55                   	push   %ebp
80106631:	89 e5                	mov    %esp,%ebp
80106633:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106636:	8b 45 08             	mov    0x8(%ebp),%eax
    while (*src) {
80106639:	0f b6 11             	movzbl (%ecx),%edx
8010663c:	84 d2                	test   %dl,%dl
8010663e:	74 0f                	je     8010664f <my_strcpy+0x1f>
        *dest++ = *src++;
80106640:	83 c1 01             	add    $0x1,%ecx
80106643:	88 10                	mov    %dl,(%eax)
80106645:	83 c0 01             	add    $0x1,%eax
    while (*src) {
80106648:	0f b6 11             	movzbl (%ecx),%edx
8010664b:	84 d2                	test   %dl,%dl
8010664d:	75 f1                	jne    80106640 <my_strcpy+0x10>
    }
    *dest = '\0';
8010664f:	c6 00 00             	movb   $0x0,(%eax)
}
80106652:	5d                   	pop    %ebp
80106653:	c3                   	ret    
80106654:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010665b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010665f:	90                   	nop

80106660 <syscall>:

void
syscall(void)
{
80106660:	55                   	push   %ebp
80106661:	89 e5                	mov    %esp,%ebp
80106663:	57                   	push   %edi
80106664:	56                   	push   %esi
80106665:	53                   	push   %ebx
80106666:	83 ec 3c             	sub    $0x3c,%esp
  int num;
  struct proc *curproc = myproc();
80106669:	e8 e2 e2 ff ff       	call   80104950 <myproc>
8010666e:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80106670:	8b 40 18             	mov    0x18(%eax),%eax
80106673:	8b 70 1c             	mov    0x1c(%eax),%esi
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80106676:	8d 46 ff             	lea    -0x1(%esi),%eax
80106679:	83 f8 1f             	cmp    $0x1f,%eax
8010667c:	0f 87 de 00 00 00    	ja     80106760 <syscall+0x100>
80106682:	8b 04 b5 c0 9f 10 80 	mov    -0x7fef6040(,%esi,4),%eax
80106689:	85 c0                	test   %eax,%eax
8010668b:	0f 84 cf 00 00 00    	je     80106760 <syscall+0x100>
    curproc->tf->eax = syscalls[num]();
80106691:	ff d0                	call   *%eax
80106693:	8b 53 18             	mov    0x18(%ebx),%edx
80106696:	89 42 1c             	mov    %eax,0x1c(%edx)
    if (curproc->syscall_count < 1000) {
80106699:	8b bb 1c 8d 00 00    	mov    0x8d1c(%ebx),%edi
8010669f:	81 ff e7 03 00 00    	cmp    $0x3e7,%edi
801066a5:	0f 8f e5 00 00 00    	jg     80106790 <syscall+0x130>
        struct syscall_info new_syscall = {"", num};
801066ab:	89 75 e4             	mov    %esi,-0x1c(%ebp)
        new_syscall.number = num;
        my_strcpy(new_syscall.name, system_call_titles[num]);
801066ae:	6b f6 1e             	imul   $0x1e,%esi,%esi
    while (*src) {
801066b1:	8d 55 c4             	lea    -0x3c(%ebp),%edx
        struct syscall_info new_syscall = {"", num};
801066b4:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
801066bb:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    while (*src) {
801066c2:	0f b6 86 20 d0 10 80 	movzbl -0x7fef2fe0(%esi),%eax
        struct syscall_info new_syscall = {"", num};
801066c9:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
        my_strcpy(new_syscall.name, system_call_titles[num]);
801066d0:	8d 8e 20 d0 10 80    	lea    -0x7fef2fe0(%esi),%ecx
        struct syscall_info new_syscall = {"", num};
801066d6:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
801066dd:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
801066e4:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
801066eb:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
801066f2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    while (*src) {
801066f9:	84 c0                	test   %al,%al
801066fb:	74 12                	je     8010670f <syscall+0xaf>
801066fd:	8d 76 00             	lea    0x0(%esi),%esi
        *dest++ = *src++;
80106700:	83 c1 01             	add    $0x1,%ecx
80106703:	88 02                	mov    %al,(%edx)
80106705:	83 c2 01             	add    $0x1,%edx
    while (*src) {
80106708:	0f b6 01             	movzbl (%ecx),%eax
8010670b:	84 c0                	test   %al,%al
8010670d:	75 f1                	jne    80106700 <syscall+0xa0>
        curproc->syscalls[curproc->syscall_count++] = new_syscall;
8010670f:	8d 47 01             	lea    0x1(%edi),%eax
    *dest = '\0';
80106712:	c6 02 00             	movb   $0x0,(%edx)
        curproc->syscalls[curproc->syscall_count++] = new_syscall;
80106715:	8b 55 c4             	mov    -0x3c(%ebp),%edx
80106718:	89 83 1c 8d 00 00    	mov    %eax,0x8d1c(%ebx)
8010671e:	8d 04 ff             	lea    (%edi,%edi,8),%eax
80106721:	8d 44 83 70          	lea    0x70(%ebx,%eax,4),%eax
80106725:	89 50 0c             	mov    %edx,0xc(%eax)
80106728:	8b 55 c8             	mov    -0x38(%ebp),%edx
8010672b:	89 50 10             	mov    %edx,0x10(%eax)
8010672e:	8b 55 cc             	mov    -0x34(%ebp),%edx
80106731:	89 50 14             	mov    %edx,0x14(%eax)
80106734:	8b 55 d0             	mov    -0x30(%ebp),%edx
80106737:	89 50 18             	mov    %edx,0x18(%eax)
8010673a:	8b 55 d4             	mov    -0x2c(%ebp),%edx
8010673d:	89 50 1c             	mov    %edx,0x1c(%eax)
80106740:	8b 55 d8             	mov    -0x28(%ebp),%edx
80106743:	89 50 20             	mov    %edx,0x20(%eax)
80106746:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106749:	89 50 24             	mov    %edx,0x24(%eax)
8010674c:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010674f:	89 50 28             	mov    %edx,0x28(%eax)
80106752:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106755:	89 50 2c             	mov    %edx,0x2c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
80106758:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010675b:	5b                   	pop    %ebx
8010675c:	5e                   	pop    %esi
8010675d:	5f                   	pop    %edi
8010675e:	5d                   	pop    %ebp
8010675f:	c3                   	ret    
            curproc->pid, curproc->name, num);
80106760:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80106763:	56                   	push   %esi
80106764:	50                   	push   %eax
80106765:	ff 73 10             	push   0x10(%ebx)
80106768:	68 9b 9f 10 80       	push   $0x80109f9b
8010676d:	e8 7e a0 ff ff       	call   801007f0 <cprintf>
    curproc->tf->eax = -1;
80106772:	8b 43 18             	mov    0x18(%ebx),%eax
80106775:	83 c4 10             	add    $0x10,%esp
80106778:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
8010677f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106782:	5b                   	pop    %ebx
80106783:	5e                   	pop    %esi
80106784:	5f                   	pop    %edi
80106785:	5d                   	pop    %ebp
80106786:	c3                   	ret    
80106787:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010678e:	66 90                	xchg   %ax,%ax
      cprintf("max system calls limit for a process has exceeded\n");
80106790:	83 ec 0c             	sub    $0xc,%esp
80106793:	68 68 9f 10 80       	push   $0x80109f68
80106798:	e8 53 a0 ff ff       	call   801007f0 <cprintf>
8010679d:	83 c4 10             	add    $0x10,%esp
801067a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801067a3:	5b                   	pop    %ebx
801067a4:	5e                   	pop    %esi
801067a5:	5f                   	pop    %edi
801067a6:	5d                   	pop    %ebp
801067a7:	c3                   	ret    
801067a8:	66 90                	xchg   %ax,%ax
801067aa:	66 90                	xchg   %ax,%ax
801067ac:	66 90                	xchg   %ax,%ax
801067ae:	66 90                	xchg   %ax,%ax

801067b0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
801067b0:	55                   	push   %ebp
801067b1:	89 e5                	mov    %esp,%ebp
801067b3:	57                   	push   %edi
801067b4:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801067b5:	8d 7d da             	lea    -0x26(%ebp),%edi
{
801067b8:	53                   	push   %ebx
801067b9:	83 ec 34             	sub    $0x34,%esp
801067bc:	89 4d d0             	mov    %ecx,-0x30(%ebp)
801067bf:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
801067c2:	57                   	push   %edi
801067c3:	50                   	push   %eax
{
801067c4:	89 55 d4             	mov    %edx,-0x2c(%ebp)
801067c7:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
801067ca:	e8 41 c8 ff ff       	call   80103010 <nameiparent>
801067cf:	83 c4 10             	add    $0x10,%esp
801067d2:	85 c0                	test   %eax,%eax
801067d4:	0f 84 46 01 00 00    	je     80106920 <create+0x170>
    return 0;
  ilock(dp);
801067da:	83 ec 0c             	sub    $0xc,%esp
801067dd:	89 c3                	mov    %eax,%ebx
801067df:	50                   	push   %eax
801067e0:	e8 eb be ff ff       	call   801026d0 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
801067e5:	83 c4 0c             	add    $0xc,%esp
801067e8:	6a 00                	push   $0x0
801067ea:	57                   	push   %edi
801067eb:	53                   	push   %ebx
801067ec:	e8 3f c4 ff ff       	call   80102c30 <dirlookup>
801067f1:	83 c4 10             	add    $0x10,%esp
801067f4:	89 c6                	mov    %eax,%esi
801067f6:	85 c0                	test   %eax,%eax
801067f8:	74 56                	je     80106850 <create+0xa0>
    iunlockput(dp);
801067fa:	83 ec 0c             	sub    $0xc,%esp
801067fd:	53                   	push   %ebx
801067fe:	e8 5d c1 ff ff       	call   80102960 <iunlockput>
    ilock(ip);
80106803:	89 34 24             	mov    %esi,(%esp)
80106806:	e8 c5 be ff ff       	call   801026d0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
8010680b:	83 c4 10             	add    $0x10,%esp
8010680e:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80106813:	75 1b                	jne    80106830 <create+0x80>
80106815:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
8010681a:	75 14                	jne    80106830 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010681c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010681f:	89 f0                	mov    %esi,%eax
80106821:	5b                   	pop    %ebx
80106822:	5e                   	pop    %esi
80106823:	5f                   	pop    %edi
80106824:	5d                   	pop    %ebp
80106825:	c3                   	ret    
80106826:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010682d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80106830:	83 ec 0c             	sub    $0xc,%esp
80106833:	56                   	push   %esi
    return 0;
80106834:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80106836:	e8 25 c1 ff ff       	call   80102960 <iunlockput>
    return 0;
8010683b:	83 c4 10             	add    $0x10,%esp
}
8010683e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106841:	89 f0                	mov    %esi,%eax
80106843:	5b                   	pop    %ebx
80106844:	5e                   	pop    %esi
80106845:	5f                   	pop    %edi
80106846:	5d                   	pop    %ebp
80106847:	c3                   	ret    
80106848:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010684f:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
80106850:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80106854:	83 ec 08             	sub    $0x8,%esp
80106857:	50                   	push   %eax
80106858:	ff 33                	push   (%ebx)
8010685a:	e8 01 bd ff ff       	call   80102560 <ialloc>
8010685f:	83 c4 10             	add    $0x10,%esp
80106862:	89 c6                	mov    %eax,%esi
80106864:	85 c0                	test   %eax,%eax
80106866:	0f 84 cd 00 00 00    	je     80106939 <create+0x189>
  ilock(ip);
8010686c:	83 ec 0c             	sub    $0xc,%esp
8010686f:	50                   	push   %eax
80106870:	e8 5b be ff ff       	call   801026d0 <ilock>
  ip->major = major;
80106875:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80106879:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
8010687d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80106881:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80106885:	b8 01 00 00 00       	mov    $0x1,%eax
8010688a:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
8010688e:	89 34 24             	mov    %esi,(%esp)
80106891:	e8 8a bd ff ff       	call   80102620 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80106896:	83 c4 10             	add    $0x10,%esp
80106899:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
8010689e:	74 30                	je     801068d0 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
801068a0:	83 ec 04             	sub    $0x4,%esp
801068a3:	ff 76 04             	push   0x4(%esi)
801068a6:	57                   	push   %edi
801068a7:	53                   	push   %ebx
801068a8:	e8 83 c6 ff ff       	call   80102f30 <dirlink>
801068ad:	83 c4 10             	add    $0x10,%esp
801068b0:	85 c0                	test   %eax,%eax
801068b2:	78 78                	js     8010692c <create+0x17c>
  iunlockput(dp);
801068b4:	83 ec 0c             	sub    $0xc,%esp
801068b7:	53                   	push   %ebx
801068b8:	e8 a3 c0 ff ff       	call   80102960 <iunlockput>
  return ip;
801068bd:	83 c4 10             	add    $0x10,%esp
}
801068c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801068c3:	89 f0                	mov    %esi,%eax
801068c5:	5b                   	pop    %ebx
801068c6:	5e                   	pop    %esi
801068c7:	5f                   	pop    %edi
801068c8:	5d                   	pop    %ebp
801068c9:	c3                   	ret    
801068ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
801068d0:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
801068d3:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
801068d8:	53                   	push   %ebx
801068d9:	e8 42 bd ff ff       	call   80102620 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801068de:	83 c4 0c             	add    $0xc,%esp
801068e1:	ff 76 04             	push   0x4(%esi)
801068e4:	68 60 a0 10 80       	push   $0x8010a060
801068e9:	56                   	push   %esi
801068ea:	e8 41 c6 ff ff       	call   80102f30 <dirlink>
801068ef:	83 c4 10             	add    $0x10,%esp
801068f2:	85 c0                	test   %eax,%eax
801068f4:	78 18                	js     8010690e <create+0x15e>
801068f6:	83 ec 04             	sub    $0x4,%esp
801068f9:	ff 73 04             	push   0x4(%ebx)
801068fc:	68 5f a0 10 80       	push   $0x8010a05f
80106901:	56                   	push   %esi
80106902:	e8 29 c6 ff ff       	call   80102f30 <dirlink>
80106907:	83 c4 10             	add    $0x10,%esp
8010690a:	85 c0                	test   %eax,%eax
8010690c:	79 92                	jns    801068a0 <create+0xf0>
      panic("create dots");
8010690e:	83 ec 0c             	sub    $0xc,%esp
80106911:	68 53 a0 10 80       	push   $0x8010a053
80106916:	e8 b5 9b ff ff       	call   801004d0 <panic>
8010691b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010691f:	90                   	nop
}
80106920:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80106923:	31 f6                	xor    %esi,%esi
}
80106925:	5b                   	pop    %ebx
80106926:	89 f0                	mov    %esi,%eax
80106928:	5e                   	pop    %esi
80106929:	5f                   	pop    %edi
8010692a:	5d                   	pop    %ebp
8010692b:	c3                   	ret    
    panic("create: dirlink");
8010692c:	83 ec 0c             	sub    $0xc,%esp
8010692f:	68 62 a0 10 80       	push   $0x8010a062
80106934:	e8 97 9b ff ff       	call   801004d0 <panic>
    panic("create: ialloc");
80106939:	83 ec 0c             	sub    $0xc,%esp
8010693c:	68 44 a0 10 80       	push   $0x8010a044
80106941:	e8 8a 9b ff ff       	call   801004d0 <panic>
80106946:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010694d:	8d 76 00             	lea    0x0(%esi),%esi

80106950 <sys_dup>:
{
80106950:	55                   	push   %ebp
80106951:	89 e5                	mov    %esp,%ebp
80106953:	56                   	push   %esi
80106954:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80106955:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106958:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010695b:	50                   	push   %eax
8010695c:	6a 00                	push   $0x0
8010695e:	e8 8d fb ff ff       	call   801064f0 <argint>
80106963:	83 c4 10             	add    $0x10,%esp
80106966:	85 c0                	test   %eax,%eax
80106968:	78 36                	js     801069a0 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010696a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010696e:	77 30                	ja     801069a0 <sys_dup+0x50>
80106970:	e8 db df ff ff       	call   80104950 <myproc>
80106975:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106978:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010697c:	85 f6                	test   %esi,%esi
8010697e:	74 20                	je     801069a0 <sys_dup+0x50>
  struct proc *curproc = myproc();
80106980:	e8 cb df ff ff       	call   80104950 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80106985:	31 db                	xor    %ebx,%ebx
80106987:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010698e:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
80106990:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80106994:	85 d2                	test   %edx,%edx
80106996:	74 18                	je     801069b0 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
80106998:	83 c3 01             	add    $0x1,%ebx
8010699b:	83 fb 10             	cmp    $0x10,%ebx
8010699e:	75 f0                	jne    80106990 <sys_dup+0x40>
}
801069a0:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
801069a3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
801069a8:	89 d8                	mov    %ebx,%eax
801069aa:	5b                   	pop    %ebx
801069ab:	5e                   	pop    %esi
801069ac:	5d                   	pop    %ebp
801069ad:	c3                   	ret    
801069ae:	66 90                	xchg   %ax,%ax
  filedup(f);
801069b0:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
801069b3:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
801069b7:	56                   	push   %esi
801069b8:	e8 33 b4 ff ff       	call   80101df0 <filedup>
  return fd;
801069bd:	83 c4 10             	add    $0x10,%esp
}
801069c0:	8d 65 f8             	lea    -0x8(%ebp),%esp
801069c3:	89 d8                	mov    %ebx,%eax
801069c5:	5b                   	pop    %ebx
801069c6:	5e                   	pop    %esi
801069c7:	5d                   	pop    %ebp
801069c8:	c3                   	ret    
801069c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801069d0 <sys_read>:
{
801069d0:	55                   	push   %ebp
801069d1:	89 e5                	mov    %esp,%ebp
801069d3:	56                   	push   %esi
801069d4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801069d5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
801069d8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801069db:	53                   	push   %ebx
801069dc:	6a 00                	push   $0x0
801069de:	e8 0d fb ff ff       	call   801064f0 <argint>
801069e3:	83 c4 10             	add    $0x10,%esp
801069e6:	85 c0                	test   %eax,%eax
801069e8:	78 5e                	js     80106a48 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801069ea:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801069ee:	77 58                	ja     80106a48 <sys_read+0x78>
801069f0:	e8 5b df ff ff       	call   80104950 <myproc>
801069f5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801069f8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801069fc:	85 f6                	test   %esi,%esi
801069fe:	74 48                	je     80106a48 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106a00:	83 ec 08             	sub    $0x8,%esp
80106a03:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106a06:	50                   	push   %eax
80106a07:	6a 02                	push   $0x2
80106a09:	e8 e2 fa ff ff       	call   801064f0 <argint>
80106a0e:	83 c4 10             	add    $0x10,%esp
80106a11:	85 c0                	test   %eax,%eax
80106a13:	78 33                	js     80106a48 <sys_read+0x78>
80106a15:	83 ec 04             	sub    $0x4,%esp
80106a18:	ff 75 f0             	push   -0x10(%ebp)
80106a1b:	53                   	push   %ebx
80106a1c:	6a 01                	push   $0x1
80106a1e:	e8 1d fb ff ff       	call   80106540 <argptr>
80106a23:	83 c4 10             	add    $0x10,%esp
80106a26:	85 c0                	test   %eax,%eax
80106a28:	78 1e                	js     80106a48 <sys_read+0x78>
  return fileread(f, p, n);
80106a2a:	83 ec 04             	sub    $0x4,%esp
80106a2d:	ff 75 f0             	push   -0x10(%ebp)
80106a30:	ff 75 f4             	push   -0xc(%ebp)
80106a33:	56                   	push   %esi
80106a34:	e8 37 b5 ff ff       	call   80101f70 <fileread>
80106a39:	83 c4 10             	add    $0x10,%esp
}
80106a3c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106a3f:	5b                   	pop    %ebx
80106a40:	5e                   	pop    %esi
80106a41:	5d                   	pop    %ebp
80106a42:	c3                   	ret    
80106a43:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106a47:	90                   	nop
    return -1;
80106a48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106a4d:	eb ed                	jmp    80106a3c <sys_read+0x6c>
80106a4f:	90                   	nop

80106a50 <sys_write>:
{
80106a50:	55                   	push   %ebp
80106a51:	89 e5                	mov    %esp,%ebp
80106a53:	56                   	push   %esi
80106a54:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80106a55:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80106a58:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80106a5b:	53                   	push   %ebx
80106a5c:	6a 00                	push   $0x0
80106a5e:	e8 8d fa ff ff       	call   801064f0 <argint>
80106a63:	83 c4 10             	add    $0x10,%esp
80106a66:	85 c0                	test   %eax,%eax
80106a68:	78 5e                	js     80106ac8 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80106a6a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80106a6e:	77 58                	ja     80106ac8 <sys_write+0x78>
80106a70:	e8 db de ff ff       	call   80104950 <myproc>
80106a75:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106a78:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80106a7c:	85 f6                	test   %esi,%esi
80106a7e:	74 48                	je     80106ac8 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106a80:	83 ec 08             	sub    $0x8,%esp
80106a83:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106a86:	50                   	push   %eax
80106a87:	6a 02                	push   $0x2
80106a89:	e8 62 fa ff ff       	call   801064f0 <argint>
80106a8e:	83 c4 10             	add    $0x10,%esp
80106a91:	85 c0                	test   %eax,%eax
80106a93:	78 33                	js     80106ac8 <sys_write+0x78>
80106a95:	83 ec 04             	sub    $0x4,%esp
80106a98:	ff 75 f0             	push   -0x10(%ebp)
80106a9b:	53                   	push   %ebx
80106a9c:	6a 01                	push   $0x1
80106a9e:	e8 9d fa ff ff       	call   80106540 <argptr>
80106aa3:	83 c4 10             	add    $0x10,%esp
80106aa6:	85 c0                	test   %eax,%eax
80106aa8:	78 1e                	js     80106ac8 <sys_write+0x78>
  return filewrite(f, p, n);
80106aaa:	83 ec 04             	sub    $0x4,%esp
80106aad:	ff 75 f0             	push   -0x10(%ebp)
80106ab0:	ff 75 f4             	push   -0xc(%ebp)
80106ab3:	56                   	push   %esi
80106ab4:	e8 47 b5 ff ff       	call   80102000 <filewrite>
80106ab9:	83 c4 10             	add    $0x10,%esp
}
80106abc:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106abf:	5b                   	pop    %ebx
80106ac0:	5e                   	pop    %esi
80106ac1:	5d                   	pop    %ebp
80106ac2:	c3                   	ret    
80106ac3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106ac7:	90                   	nop
    return -1;
80106ac8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106acd:	eb ed                	jmp    80106abc <sys_write+0x6c>
80106acf:	90                   	nop

80106ad0 <sys_close>:
{
80106ad0:	55                   	push   %ebp
80106ad1:	89 e5                	mov    %esp,%ebp
80106ad3:	56                   	push   %esi
80106ad4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80106ad5:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106ad8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80106adb:	50                   	push   %eax
80106adc:	6a 00                	push   $0x0
80106ade:	e8 0d fa ff ff       	call   801064f0 <argint>
80106ae3:	83 c4 10             	add    $0x10,%esp
80106ae6:	85 c0                	test   %eax,%eax
80106ae8:	78 3e                	js     80106b28 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80106aea:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80106aee:	77 38                	ja     80106b28 <sys_close+0x58>
80106af0:	e8 5b de ff ff       	call   80104950 <myproc>
80106af5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106af8:	8d 5a 08             	lea    0x8(%edx),%ebx
80106afb:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
80106aff:	85 f6                	test   %esi,%esi
80106b01:	74 25                	je     80106b28 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
80106b03:	e8 48 de ff ff       	call   80104950 <myproc>
  fileclose(f);
80106b08:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80106b0b:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
80106b12:	00 
  fileclose(f);
80106b13:	56                   	push   %esi
80106b14:	e8 27 b3 ff ff       	call   80101e40 <fileclose>
  return 0;
80106b19:	83 c4 10             	add    $0x10,%esp
80106b1c:	31 c0                	xor    %eax,%eax
}
80106b1e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106b21:	5b                   	pop    %ebx
80106b22:	5e                   	pop    %esi
80106b23:	5d                   	pop    %ebp
80106b24:	c3                   	ret    
80106b25:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106b28:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106b2d:	eb ef                	jmp    80106b1e <sys_close+0x4e>
80106b2f:	90                   	nop

80106b30 <sys_fstat>:
{
80106b30:	55                   	push   %ebp
80106b31:	89 e5                	mov    %esp,%ebp
80106b33:	56                   	push   %esi
80106b34:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80106b35:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80106b38:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80106b3b:	53                   	push   %ebx
80106b3c:	6a 00                	push   $0x0
80106b3e:	e8 ad f9 ff ff       	call   801064f0 <argint>
80106b43:	83 c4 10             	add    $0x10,%esp
80106b46:	85 c0                	test   %eax,%eax
80106b48:	78 46                	js     80106b90 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80106b4a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80106b4e:	77 40                	ja     80106b90 <sys_fstat+0x60>
80106b50:	e8 fb dd ff ff       	call   80104950 <myproc>
80106b55:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106b58:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80106b5c:	85 f6                	test   %esi,%esi
80106b5e:	74 30                	je     80106b90 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80106b60:	83 ec 04             	sub    $0x4,%esp
80106b63:	6a 14                	push   $0x14
80106b65:	53                   	push   %ebx
80106b66:	6a 01                	push   $0x1
80106b68:	e8 d3 f9 ff ff       	call   80106540 <argptr>
80106b6d:	83 c4 10             	add    $0x10,%esp
80106b70:	85 c0                	test   %eax,%eax
80106b72:	78 1c                	js     80106b90 <sys_fstat+0x60>
  return filestat(f, st);
80106b74:	83 ec 08             	sub    $0x8,%esp
80106b77:	ff 75 f4             	push   -0xc(%ebp)
80106b7a:	56                   	push   %esi
80106b7b:	e8 a0 b3 ff ff       	call   80101f20 <filestat>
80106b80:	83 c4 10             	add    $0x10,%esp
}
80106b83:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106b86:	5b                   	pop    %ebx
80106b87:	5e                   	pop    %esi
80106b88:	5d                   	pop    %ebp
80106b89:	c3                   	ret    
80106b8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80106b90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106b95:	eb ec                	jmp    80106b83 <sys_fstat+0x53>
80106b97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b9e:	66 90                	xchg   %ax,%ax

80106ba0 <sys_link>:
{
80106ba0:	55                   	push   %ebp
80106ba1:	89 e5                	mov    %esp,%ebp
80106ba3:	57                   	push   %edi
80106ba4:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80106ba5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80106ba8:	53                   	push   %ebx
80106ba9:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80106bac:	50                   	push   %eax
80106bad:	6a 00                	push   $0x0
80106baf:	e8 fc f9 ff ff       	call   801065b0 <argstr>
80106bb4:	83 c4 10             	add    $0x10,%esp
80106bb7:	85 c0                	test   %eax,%eax
80106bb9:	0f 88 fb 00 00 00    	js     80106cba <sys_link+0x11a>
80106bbf:	83 ec 08             	sub    $0x8,%esp
80106bc2:	8d 45 d0             	lea    -0x30(%ebp),%eax
80106bc5:	50                   	push   %eax
80106bc6:	6a 01                	push   $0x1
80106bc8:	e8 e3 f9 ff ff       	call   801065b0 <argstr>
80106bcd:	83 c4 10             	add    $0x10,%esp
80106bd0:	85 c0                	test   %eax,%eax
80106bd2:	0f 88 e2 00 00 00    	js     80106cba <sys_link+0x11a>
  begin_op();
80106bd8:	e8 d3 d0 ff ff       	call   80103cb0 <begin_op>
  if((ip = namei(old)) == 0){
80106bdd:	83 ec 0c             	sub    $0xc,%esp
80106be0:	ff 75 d4             	push   -0x2c(%ebp)
80106be3:	e8 08 c4 ff ff       	call   80102ff0 <namei>
80106be8:	83 c4 10             	add    $0x10,%esp
80106beb:	89 c3                	mov    %eax,%ebx
80106bed:	85 c0                	test   %eax,%eax
80106bef:	0f 84 e4 00 00 00    	je     80106cd9 <sys_link+0x139>
  ilock(ip);
80106bf5:	83 ec 0c             	sub    $0xc,%esp
80106bf8:	50                   	push   %eax
80106bf9:	e8 d2 ba ff ff       	call   801026d0 <ilock>
  if(ip->type == T_DIR){
80106bfe:	83 c4 10             	add    $0x10,%esp
80106c01:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106c06:	0f 84 b5 00 00 00    	je     80106cc1 <sys_link+0x121>
  iupdate(ip);
80106c0c:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
80106c0f:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80106c14:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80106c17:	53                   	push   %ebx
80106c18:	e8 03 ba ff ff       	call   80102620 <iupdate>
  iunlock(ip);
80106c1d:	89 1c 24             	mov    %ebx,(%esp)
80106c20:	e8 8b bb ff ff       	call   801027b0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80106c25:	58                   	pop    %eax
80106c26:	5a                   	pop    %edx
80106c27:	57                   	push   %edi
80106c28:	ff 75 d0             	push   -0x30(%ebp)
80106c2b:	e8 e0 c3 ff ff       	call   80103010 <nameiparent>
80106c30:	83 c4 10             	add    $0x10,%esp
80106c33:	89 c6                	mov    %eax,%esi
80106c35:	85 c0                	test   %eax,%eax
80106c37:	74 5b                	je     80106c94 <sys_link+0xf4>
  ilock(dp);
80106c39:	83 ec 0c             	sub    $0xc,%esp
80106c3c:	50                   	push   %eax
80106c3d:	e8 8e ba ff ff       	call   801026d0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80106c42:	8b 03                	mov    (%ebx),%eax
80106c44:	83 c4 10             	add    $0x10,%esp
80106c47:	39 06                	cmp    %eax,(%esi)
80106c49:	75 3d                	jne    80106c88 <sys_link+0xe8>
80106c4b:	83 ec 04             	sub    $0x4,%esp
80106c4e:	ff 73 04             	push   0x4(%ebx)
80106c51:	57                   	push   %edi
80106c52:	56                   	push   %esi
80106c53:	e8 d8 c2 ff ff       	call   80102f30 <dirlink>
80106c58:	83 c4 10             	add    $0x10,%esp
80106c5b:	85 c0                	test   %eax,%eax
80106c5d:	78 29                	js     80106c88 <sys_link+0xe8>
  iunlockput(dp);
80106c5f:	83 ec 0c             	sub    $0xc,%esp
80106c62:	56                   	push   %esi
80106c63:	e8 f8 bc ff ff       	call   80102960 <iunlockput>
  iput(ip);
80106c68:	89 1c 24             	mov    %ebx,(%esp)
80106c6b:	e8 90 bb ff ff       	call   80102800 <iput>
  end_op();
80106c70:	e8 ab d0 ff ff       	call   80103d20 <end_op>
  return 0;
80106c75:	83 c4 10             	add    $0x10,%esp
80106c78:	31 c0                	xor    %eax,%eax
}
80106c7a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c7d:	5b                   	pop    %ebx
80106c7e:	5e                   	pop    %esi
80106c7f:	5f                   	pop    %edi
80106c80:	5d                   	pop    %ebp
80106c81:	c3                   	ret    
80106c82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80106c88:	83 ec 0c             	sub    $0xc,%esp
80106c8b:	56                   	push   %esi
80106c8c:	e8 cf bc ff ff       	call   80102960 <iunlockput>
    goto bad;
80106c91:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80106c94:	83 ec 0c             	sub    $0xc,%esp
80106c97:	53                   	push   %ebx
80106c98:	e8 33 ba ff ff       	call   801026d0 <ilock>
  ip->nlink--;
80106c9d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80106ca2:	89 1c 24             	mov    %ebx,(%esp)
80106ca5:	e8 76 b9 ff ff       	call   80102620 <iupdate>
  iunlockput(ip);
80106caa:	89 1c 24             	mov    %ebx,(%esp)
80106cad:	e8 ae bc ff ff       	call   80102960 <iunlockput>
  end_op();
80106cb2:	e8 69 d0 ff ff       	call   80103d20 <end_op>
  return -1;
80106cb7:	83 c4 10             	add    $0x10,%esp
80106cba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106cbf:	eb b9                	jmp    80106c7a <sys_link+0xda>
    iunlockput(ip);
80106cc1:	83 ec 0c             	sub    $0xc,%esp
80106cc4:	53                   	push   %ebx
80106cc5:	e8 96 bc ff ff       	call   80102960 <iunlockput>
    end_op();
80106cca:	e8 51 d0 ff ff       	call   80103d20 <end_op>
    return -1;
80106ccf:	83 c4 10             	add    $0x10,%esp
80106cd2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106cd7:	eb a1                	jmp    80106c7a <sys_link+0xda>
    end_op();
80106cd9:	e8 42 d0 ff ff       	call   80103d20 <end_op>
    return -1;
80106cde:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106ce3:	eb 95                	jmp    80106c7a <sys_link+0xda>
80106ce5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106cec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106cf0 <sys_unlink>:
{
80106cf0:	55                   	push   %ebp
80106cf1:	89 e5                	mov    %esp,%ebp
80106cf3:	57                   	push   %edi
80106cf4:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80106cf5:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80106cf8:	53                   	push   %ebx
80106cf9:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
80106cfc:	50                   	push   %eax
80106cfd:	6a 00                	push   $0x0
80106cff:	e8 ac f8 ff ff       	call   801065b0 <argstr>
80106d04:	83 c4 10             	add    $0x10,%esp
80106d07:	85 c0                	test   %eax,%eax
80106d09:	0f 88 7a 01 00 00    	js     80106e89 <sys_unlink+0x199>
  begin_op();
80106d0f:	e8 9c cf ff ff       	call   80103cb0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80106d14:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80106d17:	83 ec 08             	sub    $0x8,%esp
80106d1a:	53                   	push   %ebx
80106d1b:	ff 75 c0             	push   -0x40(%ebp)
80106d1e:	e8 ed c2 ff ff       	call   80103010 <nameiparent>
80106d23:	83 c4 10             	add    $0x10,%esp
80106d26:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80106d29:	85 c0                	test   %eax,%eax
80106d2b:	0f 84 62 01 00 00    	je     80106e93 <sys_unlink+0x1a3>
  ilock(dp);
80106d31:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80106d34:	83 ec 0c             	sub    $0xc,%esp
80106d37:	57                   	push   %edi
80106d38:	e8 93 b9 ff ff       	call   801026d0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80106d3d:	58                   	pop    %eax
80106d3e:	5a                   	pop    %edx
80106d3f:	68 60 a0 10 80       	push   $0x8010a060
80106d44:	53                   	push   %ebx
80106d45:	e8 c6 be ff ff       	call   80102c10 <namecmp>
80106d4a:	83 c4 10             	add    $0x10,%esp
80106d4d:	85 c0                	test   %eax,%eax
80106d4f:	0f 84 fb 00 00 00    	je     80106e50 <sys_unlink+0x160>
80106d55:	83 ec 08             	sub    $0x8,%esp
80106d58:	68 5f a0 10 80       	push   $0x8010a05f
80106d5d:	53                   	push   %ebx
80106d5e:	e8 ad be ff ff       	call   80102c10 <namecmp>
80106d63:	83 c4 10             	add    $0x10,%esp
80106d66:	85 c0                	test   %eax,%eax
80106d68:	0f 84 e2 00 00 00    	je     80106e50 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
80106d6e:	83 ec 04             	sub    $0x4,%esp
80106d71:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80106d74:	50                   	push   %eax
80106d75:	53                   	push   %ebx
80106d76:	57                   	push   %edi
80106d77:	e8 b4 be ff ff       	call   80102c30 <dirlookup>
80106d7c:	83 c4 10             	add    $0x10,%esp
80106d7f:	89 c3                	mov    %eax,%ebx
80106d81:	85 c0                	test   %eax,%eax
80106d83:	0f 84 c7 00 00 00    	je     80106e50 <sys_unlink+0x160>
  ilock(ip);
80106d89:	83 ec 0c             	sub    $0xc,%esp
80106d8c:	50                   	push   %eax
80106d8d:	e8 3e b9 ff ff       	call   801026d0 <ilock>
  if(ip->nlink < 1)
80106d92:	83 c4 10             	add    $0x10,%esp
80106d95:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80106d9a:	0f 8e 1c 01 00 00    	jle    80106ebc <sys_unlink+0x1cc>
  if(ip->type == T_DIR && !isdirempty(ip)){
80106da0:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106da5:	8d 7d d8             	lea    -0x28(%ebp),%edi
80106da8:	74 66                	je     80106e10 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80106daa:	83 ec 04             	sub    $0x4,%esp
80106dad:	6a 10                	push   $0x10
80106daf:	6a 00                	push   $0x0
80106db1:	57                   	push   %edi
80106db2:	e8 59 f3 ff ff       	call   80106110 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80106db7:	6a 10                	push   $0x10
80106db9:	ff 75 c4             	push   -0x3c(%ebp)
80106dbc:	57                   	push   %edi
80106dbd:	ff 75 b4             	push   -0x4c(%ebp)
80106dc0:	e8 1b bd ff ff       	call   80102ae0 <writei>
80106dc5:	83 c4 20             	add    $0x20,%esp
80106dc8:	83 f8 10             	cmp    $0x10,%eax
80106dcb:	0f 85 de 00 00 00    	jne    80106eaf <sys_unlink+0x1bf>
  if(ip->type == T_DIR){
80106dd1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106dd6:	0f 84 94 00 00 00    	je     80106e70 <sys_unlink+0x180>
  iunlockput(dp);
80106ddc:	83 ec 0c             	sub    $0xc,%esp
80106ddf:	ff 75 b4             	push   -0x4c(%ebp)
80106de2:	e8 79 bb ff ff       	call   80102960 <iunlockput>
  ip->nlink--;
80106de7:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80106dec:	89 1c 24             	mov    %ebx,(%esp)
80106def:	e8 2c b8 ff ff       	call   80102620 <iupdate>
  iunlockput(ip);
80106df4:	89 1c 24             	mov    %ebx,(%esp)
80106df7:	e8 64 bb ff ff       	call   80102960 <iunlockput>
  end_op();
80106dfc:	e8 1f cf ff ff       	call   80103d20 <end_op>
  return 0;
80106e01:	83 c4 10             	add    $0x10,%esp
80106e04:	31 c0                	xor    %eax,%eax
}
80106e06:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e09:	5b                   	pop    %ebx
80106e0a:	5e                   	pop    %esi
80106e0b:	5f                   	pop    %edi
80106e0c:	5d                   	pop    %ebp
80106e0d:	c3                   	ret    
80106e0e:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80106e10:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80106e14:	76 94                	jbe    80106daa <sys_unlink+0xba>
80106e16:	be 20 00 00 00       	mov    $0x20,%esi
80106e1b:	eb 0b                	jmp    80106e28 <sys_unlink+0x138>
80106e1d:	8d 76 00             	lea    0x0(%esi),%esi
80106e20:	83 c6 10             	add    $0x10,%esi
80106e23:	3b 73 58             	cmp    0x58(%ebx),%esi
80106e26:	73 82                	jae    80106daa <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80106e28:	6a 10                	push   $0x10
80106e2a:	56                   	push   %esi
80106e2b:	57                   	push   %edi
80106e2c:	53                   	push   %ebx
80106e2d:	e8 ae bb ff ff       	call   801029e0 <readi>
80106e32:	83 c4 10             	add    $0x10,%esp
80106e35:	83 f8 10             	cmp    $0x10,%eax
80106e38:	75 68                	jne    80106ea2 <sys_unlink+0x1b2>
    if(de.inum != 0)
80106e3a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80106e3f:	74 df                	je     80106e20 <sys_unlink+0x130>
    iunlockput(ip);
80106e41:	83 ec 0c             	sub    $0xc,%esp
80106e44:	53                   	push   %ebx
80106e45:	e8 16 bb ff ff       	call   80102960 <iunlockput>
    goto bad;
80106e4a:	83 c4 10             	add    $0x10,%esp
80106e4d:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
80106e50:	83 ec 0c             	sub    $0xc,%esp
80106e53:	ff 75 b4             	push   -0x4c(%ebp)
80106e56:	e8 05 bb ff ff       	call   80102960 <iunlockput>
  end_op();
80106e5b:	e8 c0 ce ff ff       	call   80103d20 <end_op>
  return -1;
80106e60:	83 c4 10             	add    $0x10,%esp
80106e63:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106e68:	eb 9c                	jmp    80106e06 <sys_unlink+0x116>
80106e6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
80106e70:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80106e73:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80106e76:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
80106e7b:	50                   	push   %eax
80106e7c:	e8 9f b7 ff ff       	call   80102620 <iupdate>
80106e81:	83 c4 10             	add    $0x10,%esp
80106e84:	e9 53 ff ff ff       	jmp    80106ddc <sys_unlink+0xec>
    return -1;
80106e89:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106e8e:	e9 73 ff ff ff       	jmp    80106e06 <sys_unlink+0x116>
    end_op();
80106e93:	e8 88 ce ff ff       	call   80103d20 <end_op>
    return -1;
80106e98:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106e9d:	e9 64 ff ff ff       	jmp    80106e06 <sys_unlink+0x116>
      panic("isdirempty: readi");
80106ea2:	83 ec 0c             	sub    $0xc,%esp
80106ea5:	68 84 a0 10 80       	push   $0x8010a084
80106eaa:	e8 21 96 ff ff       	call   801004d0 <panic>
    panic("unlink: writei");
80106eaf:	83 ec 0c             	sub    $0xc,%esp
80106eb2:	68 96 a0 10 80       	push   $0x8010a096
80106eb7:	e8 14 96 ff ff       	call   801004d0 <panic>
    panic("unlink: nlink < 1");
80106ebc:	83 ec 0c             	sub    $0xc,%esp
80106ebf:	68 72 a0 10 80       	push   $0x8010a072
80106ec4:	e8 07 96 ff ff       	call   801004d0 <panic>
80106ec9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106ed0 <sys_open>:

int
sys_open(void)
{
80106ed0:	55                   	push   %ebp
80106ed1:	89 e5                	mov    %esp,%ebp
80106ed3:	57                   	push   %edi
80106ed4:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80106ed5:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80106ed8:	53                   	push   %ebx
80106ed9:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80106edc:	50                   	push   %eax
80106edd:	6a 00                	push   $0x0
80106edf:	e8 cc f6 ff ff       	call   801065b0 <argstr>
80106ee4:	83 c4 10             	add    $0x10,%esp
80106ee7:	85 c0                	test   %eax,%eax
80106ee9:	0f 88 8e 00 00 00    	js     80106f7d <sys_open+0xad>
80106eef:	83 ec 08             	sub    $0x8,%esp
80106ef2:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106ef5:	50                   	push   %eax
80106ef6:	6a 01                	push   $0x1
80106ef8:	e8 f3 f5 ff ff       	call   801064f0 <argint>
80106efd:	83 c4 10             	add    $0x10,%esp
80106f00:	85 c0                	test   %eax,%eax
80106f02:	78 79                	js     80106f7d <sys_open+0xad>
    return -1;

  begin_op();
80106f04:	e8 a7 cd ff ff       	call   80103cb0 <begin_op>

  if(omode & O_CREATE){
80106f09:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80106f0d:	75 79                	jne    80106f88 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80106f0f:	83 ec 0c             	sub    $0xc,%esp
80106f12:	ff 75 e0             	push   -0x20(%ebp)
80106f15:	e8 d6 c0 ff ff       	call   80102ff0 <namei>
80106f1a:	83 c4 10             	add    $0x10,%esp
80106f1d:	89 c6                	mov    %eax,%esi
80106f1f:	85 c0                	test   %eax,%eax
80106f21:	0f 84 7e 00 00 00    	je     80106fa5 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80106f27:	83 ec 0c             	sub    $0xc,%esp
80106f2a:	50                   	push   %eax
80106f2b:	e8 a0 b7 ff ff       	call   801026d0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80106f30:	83 c4 10             	add    $0x10,%esp
80106f33:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80106f38:	0f 84 c2 00 00 00    	je     80107000 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80106f3e:	e8 3d ae ff ff       	call   80101d80 <filealloc>
80106f43:	89 c7                	mov    %eax,%edi
80106f45:	85 c0                	test   %eax,%eax
80106f47:	74 23                	je     80106f6c <sys_open+0x9c>
  struct proc *curproc = myproc();
80106f49:	e8 02 da ff ff       	call   80104950 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80106f4e:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80106f50:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80106f54:	85 d2                	test   %edx,%edx
80106f56:	74 60                	je     80106fb8 <sys_open+0xe8>
  for(fd = 0; fd < NOFILE; fd++){
80106f58:	83 c3 01             	add    $0x1,%ebx
80106f5b:	83 fb 10             	cmp    $0x10,%ebx
80106f5e:	75 f0                	jne    80106f50 <sys_open+0x80>
    if(f)
      fileclose(f);
80106f60:	83 ec 0c             	sub    $0xc,%esp
80106f63:	57                   	push   %edi
80106f64:	e8 d7 ae ff ff       	call   80101e40 <fileclose>
80106f69:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80106f6c:	83 ec 0c             	sub    $0xc,%esp
80106f6f:	56                   	push   %esi
80106f70:	e8 eb b9 ff ff       	call   80102960 <iunlockput>
    end_op();
80106f75:	e8 a6 cd ff ff       	call   80103d20 <end_op>
    return -1;
80106f7a:	83 c4 10             	add    $0x10,%esp
80106f7d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106f82:	eb 6d                	jmp    80106ff1 <sys_open+0x121>
80106f84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80106f88:	83 ec 0c             	sub    $0xc,%esp
80106f8b:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106f8e:	31 c9                	xor    %ecx,%ecx
80106f90:	ba 02 00 00 00       	mov    $0x2,%edx
80106f95:	6a 00                	push   $0x0
80106f97:	e8 14 f8 ff ff       	call   801067b0 <create>
    if(ip == 0){
80106f9c:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
80106f9f:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80106fa1:	85 c0                	test   %eax,%eax
80106fa3:	75 99                	jne    80106f3e <sys_open+0x6e>
      end_op();
80106fa5:	e8 76 cd ff ff       	call   80103d20 <end_op>
      return -1;
80106faa:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106faf:	eb 40                	jmp    80106ff1 <sys_open+0x121>
80106fb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80106fb8:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80106fbb:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80106fbf:	56                   	push   %esi
80106fc0:	e8 eb b7 ff ff       	call   801027b0 <iunlock>
  end_op();
80106fc5:	e8 56 cd ff ff       	call   80103d20 <end_op>

  f->type = FD_INODE;
80106fca:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80106fd0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106fd3:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80106fd6:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80106fd9:	89 d0                	mov    %edx,%eax
  f->off = 0;
80106fdb:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80106fe2:	f7 d0                	not    %eax
80106fe4:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106fe7:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80106fea:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106fed:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80106ff1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ff4:	89 d8                	mov    %ebx,%eax
80106ff6:	5b                   	pop    %ebx
80106ff7:	5e                   	pop    %esi
80106ff8:	5f                   	pop    %edi
80106ff9:	5d                   	pop    %ebp
80106ffa:	c3                   	ret    
80106ffb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106fff:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
80107000:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107003:	85 c9                	test   %ecx,%ecx
80107005:	0f 84 33 ff ff ff    	je     80106f3e <sys_open+0x6e>
8010700b:	e9 5c ff ff ff       	jmp    80106f6c <sys_open+0x9c>

80107010 <sys_mkdir>:

int
sys_mkdir(void)
{
80107010:	55                   	push   %ebp
80107011:	89 e5                	mov    %esp,%ebp
80107013:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80107016:	e8 95 cc ff ff       	call   80103cb0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010701b:	83 ec 08             	sub    $0x8,%esp
8010701e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107021:	50                   	push   %eax
80107022:	6a 00                	push   $0x0
80107024:	e8 87 f5 ff ff       	call   801065b0 <argstr>
80107029:	83 c4 10             	add    $0x10,%esp
8010702c:	85 c0                	test   %eax,%eax
8010702e:	78 30                	js     80107060 <sys_mkdir+0x50>
80107030:	83 ec 0c             	sub    $0xc,%esp
80107033:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107036:	31 c9                	xor    %ecx,%ecx
80107038:	ba 01 00 00 00       	mov    $0x1,%edx
8010703d:	6a 00                	push   $0x0
8010703f:	e8 6c f7 ff ff       	call   801067b0 <create>
80107044:	83 c4 10             	add    $0x10,%esp
80107047:	85 c0                	test   %eax,%eax
80107049:	74 15                	je     80107060 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010704b:	83 ec 0c             	sub    $0xc,%esp
8010704e:	50                   	push   %eax
8010704f:	e8 0c b9 ff ff       	call   80102960 <iunlockput>
  end_op();
80107054:	e8 c7 cc ff ff       	call   80103d20 <end_op>
  return 0;
80107059:	83 c4 10             	add    $0x10,%esp
8010705c:	31 c0                	xor    %eax,%eax
}
8010705e:	c9                   	leave  
8010705f:	c3                   	ret    
    end_op();
80107060:	e8 bb cc ff ff       	call   80103d20 <end_op>
    return -1;
80107065:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010706a:	c9                   	leave  
8010706b:	c3                   	ret    
8010706c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107070 <sys_mknod>:

int
sys_mknod(void)
{
80107070:	55                   	push   %ebp
80107071:	89 e5                	mov    %esp,%ebp
80107073:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80107076:	e8 35 cc ff ff       	call   80103cb0 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010707b:	83 ec 08             	sub    $0x8,%esp
8010707e:	8d 45 ec             	lea    -0x14(%ebp),%eax
80107081:	50                   	push   %eax
80107082:	6a 00                	push   $0x0
80107084:	e8 27 f5 ff ff       	call   801065b0 <argstr>
80107089:	83 c4 10             	add    $0x10,%esp
8010708c:	85 c0                	test   %eax,%eax
8010708e:	78 60                	js     801070f0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80107090:	83 ec 08             	sub    $0x8,%esp
80107093:	8d 45 f0             	lea    -0x10(%ebp),%eax
80107096:	50                   	push   %eax
80107097:	6a 01                	push   $0x1
80107099:	e8 52 f4 ff ff       	call   801064f0 <argint>
  if((argstr(0, &path)) < 0 ||
8010709e:	83 c4 10             	add    $0x10,%esp
801070a1:	85 c0                	test   %eax,%eax
801070a3:	78 4b                	js     801070f0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801070a5:	83 ec 08             	sub    $0x8,%esp
801070a8:	8d 45 f4             	lea    -0xc(%ebp),%eax
801070ab:	50                   	push   %eax
801070ac:	6a 02                	push   $0x2
801070ae:	e8 3d f4 ff ff       	call   801064f0 <argint>
     argint(1, &major) < 0 ||
801070b3:	83 c4 10             	add    $0x10,%esp
801070b6:	85 c0                	test   %eax,%eax
801070b8:	78 36                	js     801070f0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
801070ba:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
801070be:	83 ec 0c             	sub    $0xc,%esp
801070c1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
801070c5:	ba 03 00 00 00       	mov    $0x3,%edx
801070ca:	50                   	push   %eax
801070cb:	8b 45 ec             	mov    -0x14(%ebp),%eax
801070ce:	e8 dd f6 ff ff       	call   801067b0 <create>
     argint(2, &minor) < 0 ||
801070d3:	83 c4 10             	add    $0x10,%esp
801070d6:	85 c0                	test   %eax,%eax
801070d8:	74 16                	je     801070f0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
801070da:	83 ec 0c             	sub    $0xc,%esp
801070dd:	50                   	push   %eax
801070de:	e8 7d b8 ff ff       	call   80102960 <iunlockput>
  end_op();
801070e3:	e8 38 cc ff ff       	call   80103d20 <end_op>
  return 0;
801070e8:	83 c4 10             	add    $0x10,%esp
801070eb:	31 c0                	xor    %eax,%eax
}
801070ed:	c9                   	leave  
801070ee:	c3                   	ret    
801070ef:	90                   	nop
    end_op();
801070f0:	e8 2b cc ff ff       	call   80103d20 <end_op>
    return -1;
801070f5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801070fa:	c9                   	leave  
801070fb:	c3                   	ret    
801070fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107100 <sys_chdir>:

int
sys_chdir(void)
{
80107100:	55                   	push   %ebp
80107101:	89 e5                	mov    %esp,%ebp
80107103:	56                   	push   %esi
80107104:	53                   	push   %ebx
80107105:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80107108:	e8 43 d8 ff ff       	call   80104950 <myproc>
8010710d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010710f:	e8 9c cb ff ff       	call   80103cb0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80107114:	83 ec 08             	sub    $0x8,%esp
80107117:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010711a:	50                   	push   %eax
8010711b:	6a 00                	push   $0x0
8010711d:	e8 8e f4 ff ff       	call   801065b0 <argstr>
80107122:	83 c4 10             	add    $0x10,%esp
80107125:	85 c0                	test   %eax,%eax
80107127:	78 77                	js     801071a0 <sys_chdir+0xa0>
80107129:	83 ec 0c             	sub    $0xc,%esp
8010712c:	ff 75 f4             	push   -0xc(%ebp)
8010712f:	e8 bc be ff ff       	call   80102ff0 <namei>
80107134:	83 c4 10             	add    $0x10,%esp
80107137:	89 c3                	mov    %eax,%ebx
80107139:	85 c0                	test   %eax,%eax
8010713b:	74 63                	je     801071a0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010713d:	83 ec 0c             	sub    $0xc,%esp
80107140:	50                   	push   %eax
80107141:	e8 8a b5 ff ff       	call   801026d0 <ilock>
  if(ip->type != T_DIR){
80107146:	83 c4 10             	add    $0x10,%esp
80107149:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010714e:	75 30                	jne    80107180 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80107150:	83 ec 0c             	sub    $0xc,%esp
80107153:	53                   	push   %ebx
80107154:	e8 57 b6 ff ff       	call   801027b0 <iunlock>
  iput(curproc->cwd);
80107159:	58                   	pop    %eax
8010715a:	ff 76 68             	push   0x68(%esi)
8010715d:	e8 9e b6 ff ff       	call   80102800 <iput>
  end_op();
80107162:	e8 b9 cb ff ff       	call   80103d20 <end_op>
  curproc->cwd = ip;
80107167:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010716a:	83 c4 10             	add    $0x10,%esp
8010716d:	31 c0                	xor    %eax,%eax
}
8010716f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107172:	5b                   	pop    %ebx
80107173:	5e                   	pop    %esi
80107174:	5d                   	pop    %ebp
80107175:	c3                   	ret    
80107176:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010717d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80107180:	83 ec 0c             	sub    $0xc,%esp
80107183:	53                   	push   %ebx
80107184:	e8 d7 b7 ff ff       	call   80102960 <iunlockput>
    end_op();
80107189:	e8 92 cb ff ff       	call   80103d20 <end_op>
    return -1;
8010718e:	83 c4 10             	add    $0x10,%esp
80107191:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107196:	eb d7                	jmp    8010716f <sys_chdir+0x6f>
80107198:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010719f:	90                   	nop
    end_op();
801071a0:	e8 7b cb ff ff       	call   80103d20 <end_op>
    return -1;
801071a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801071aa:	eb c3                	jmp    8010716f <sys_chdir+0x6f>
801071ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801071b0 <sys_exec>:

int
sys_exec(void)
{
801071b0:	55                   	push   %ebp
801071b1:	89 e5                	mov    %esp,%ebp
801071b3:	57                   	push   %edi
801071b4:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801071b5:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
801071bb:	53                   	push   %ebx
801071bc:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801071c2:	50                   	push   %eax
801071c3:	6a 00                	push   $0x0
801071c5:	e8 e6 f3 ff ff       	call   801065b0 <argstr>
801071ca:	83 c4 10             	add    $0x10,%esp
801071cd:	85 c0                	test   %eax,%eax
801071cf:	0f 88 87 00 00 00    	js     8010725c <sys_exec+0xac>
801071d5:	83 ec 08             	sub    $0x8,%esp
801071d8:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801071de:	50                   	push   %eax
801071df:	6a 01                	push   $0x1
801071e1:	e8 0a f3 ff ff       	call   801064f0 <argint>
801071e6:	83 c4 10             	add    $0x10,%esp
801071e9:	85 c0                	test   %eax,%eax
801071eb:	78 6f                	js     8010725c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801071ed:	83 ec 04             	sub    $0x4,%esp
801071f0:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
801071f6:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
801071f8:	68 80 00 00 00       	push   $0x80
801071fd:	6a 00                	push   $0x0
801071ff:	56                   	push   %esi
80107200:	e8 0b ef ff ff       	call   80106110 <memset>
80107205:	83 c4 10             	add    $0x10,%esp
80107208:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010720f:	90                   	nop
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80107210:	83 ec 08             	sub    $0x8,%esp
80107213:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80107219:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80107220:	50                   	push   %eax
80107221:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80107227:	01 f8                	add    %edi,%eax
80107229:	50                   	push   %eax
8010722a:	e8 31 f2 ff ff       	call   80106460 <fetchint>
8010722f:	83 c4 10             	add    $0x10,%esp
80107232:	85 c0                	test   %eax,%eax
80107234:	78 26                	js     8010725c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80107236:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010723c:	85 c0                	test   %eax,%eax
8010723e:	74 30                	je     80107270 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80107240:	83 ec 08             	sub    $0x8,%esp
80107243:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80107246:	52                   	push   %edx
80107247:	50                   	push   %eax
80107248:	e8 53 f2 ff ff       	call   801064a0 <fetchstr>
8010724d:	83 c4 10             	add    $0x10,%esp
80107250:	85 c0                	test   %eax,%eax
80107252:	78 08                	js     8010725c <sys_exec+0xac>
  for(i=0;; i++){
80107254:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80107257:	83 fb 20             	cmp    $0x20,%ebx
8010725a:	75 b4                	jne    80107210 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010725c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010725f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107264:	5b                   	pop    %ebx
80107265:	5e                   	pop    %esi
80107266:	5f                   	pop    %edi
80107267:	5d                   	pop    %ebp
80107268:	c3                   	ret    
80107269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80107270:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80107277:	00 00 00 00 
  return exec(path, argv);
8010727b:	83 ec 08             	sub    $0x8,%esp
8010727e:	56                   	push   %esi
8010727f:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
80107285:	e8 76 a7 ff ff       	call   80101a00 <exec>
8010728a:	83 c4 10             	add    $0x10,%esp
}
8010728d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107290:	5b                   	pop    %ebx
80107291:	5e                   	pop    %esi
80107292:	5f                   	pop    %edi
80107293:	5d                   	pop    %ebp
80107294:	c3                   	ret    
80107295:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010729c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801072a0 <sys_pipe>:

int
sys_pipe(void)
{
801072a0:	55                   	push   %ebp
801072a1:	89 e5                	mov    %esp,%ebp
801072a3:	57                   	push   %edi
801072a4:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801072a5:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
801072a8:	53                   	push   %ebx
801072a9:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801072ac:	6a 08                	push   $0x8
801072ae:	50                   	push   %eax
801072af:	6a 00                	push   $0x0
801072b1:	e8 8a f2 ff ff       	call   80106540 <argptr>
801072b6:	83 c4 10             	add    $0x10,%esp
801072b9:	85 c0                	test   %eax,%eax
801072bb:	78 4a                	js     80107307 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801072bd:	83 ec 08             	sub    $0x8,%esp
801072c0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801072c3:	50                   	push   %eax
801072c4:	8d 45 e0             	lea    -0x20(%ebp),%eax
801072c7:	50                   	push   %eax
801072c8:	e8 d3 d0 ff ff       	call   801043a0 <pipealloc>
801072cd:	83 c4 10             	add    $0x10,%esp
801072d0:	85 c0                	test   %eax,%eax
801072d2:	78 33                	js     80107307 <sys_pipe+0x67>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801072d4:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
801072d7:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801072d9:	e8 72 d6 ff ff       	call   80104950 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801072de:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
801072e0:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801072e4:	85 f6                	test   %esi,%esi
801072e6:	74 28                	je     80107310 <sys_pipe+0x70>
  for(fd = 0; fd < NOFILE; fd++){
801072e8:	83 c3 01             	add    $0x1,%ebx
801072eb:	83 fb 10             	cmp    $0x10,%ebx
801072ee:	75 f0                	jne    801072e0 <sys_pipe+0x40>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
801072f0:	83 ec 0c             	sub    $0xc,%esp
801072f3:	ff 75 e0             	push   -0x20(%ebp)
801072f6:	e8 45 ab ff ff       	call   80101e40 <fileclose>
    fileclose(wf);
801072fb:	58                   	pop    %eax
801072fc:	ff 75 e4             	push   -0x1c(%ebp)
801072ff:	e8 3c ab ff ff       	call   80101e40 <fileclose>
    return -1;
80107304:	83 c4 10             	add    $0x10,%esp
80107307:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010730c:	eb 53                	jmp    80107361 <sys_pipe+0xc1>
8010730e:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80107310:	8d 73 08             	lea    0x8(%ebx),%esi
80107313:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80107317:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010731a:	e8 31 d6 ff ff       	call   80104950 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010731f:	31 d2                	xor    %edx,%edx
80107321:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80107328:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
8010732c:	85 c9                	test   %ecx,%ecx
8010732e:	74 20                	je     80107350 <sys_pipe+0xb0>
  for(fd = 0; fd < NOFILE; fd++){
80107330:	83 c2 01             	add    $0x1,%edx
80107333:	83 fa 10             	cmp    $0x10,%edx
80107336:	75 f0                	jne    80107328 <sys_pipe+0x88>
      myproc()->ofile[fd0] = 0;
80107338:	e8 13 d6 ff ff       	call   80104950 <myproc>
8010733d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80107344:	00 
80107345:	eb a9                	jmp    801072f0 <sys_pipe+0x50>
80107347:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010734e:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80107350:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
80107354:	8b 45 dc             	mov    -0x24(%ebp),%eax
80107357:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80107359:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010735c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
8010735f:	31 c0                	xor    %eax,%eax
}
80107361:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107364:	5b                   	pop    %ebx
80107365:	5e                   	pop    %esi
80107366:	5f                   	pop    %edi
80107367:	5d                   	pop    %ebp
80107368:	c3                   	ret    
80107369:	66 90                	xchg   %ax,%ax
8010736b:	66 90                	xchg   %ax,%ax
8010736d:	66 90                	xchg   %ax,%ax
8010736f:	90                   	nop

80107370 <sys_fork>:
#include "reentrantlock.h"

int
sys_fork(void)
{
  return fork();
80107370:	e9 7b d7 ff ff       	jmp    80104af0 <fork>
80107375:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010737c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107380 <sys_exit>:
}

int
sys_exit(void)
{
80107380:	55                   	push   %ebp
80107381:	89 e5                	mov    %esp,%ebp
80107383:	83 ec 08             	sub    $0x8,%esp
  exit();
80107386:	e8 d5 d9 ff ff       	call   80104d60 <exit>
  return 0;  // not reached
}
8010738b:	31 c0                	xor    %eax,%eax
8010738d:	c9                   	leave  
8010738e:	c3                   	ret    
8010738f:	90                   	nop

80107390 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80107390:	e9 fb da ff ff       	jmp    80104e90 <wait>
80107395:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010739c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801073a0 <sys_kill>:
}

int
sys_kill(void)
{
801073a0:	55                   	push   %ebp
801073a1:	89 e5                	mov    %esp,%ebp
801073a3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
801073a6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801073a9:	50                   	push   %eax
801073aa:	6a 00                	push   $0x0
801073ac:	e8 3f f1 ff ff       	call   801064f0 <argint>
801073b1:	83 c4 10             	add    $0x10,%esp
801073b4:	85 c0                	test   %eax,%eax
801073b6:	78 18                	js     801073d0 <sys_kill+0x30>
    return -1;
  return kill(pid);
801073b8:	83 ec 0c             	sub    $0xc,%esp
801073bb:	ff 75 f4             	push   -0xc(%ebp)
801073be:	e8 8d dd ff ff       	call   80105150 <kill>
801073c3:	83 c4 10             	add    $0x10,%esp
}
801073c6:	c9                   	leave  
801073c7:	c3                   	ret    
801073c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073cf:	90                   	nop
801073d0:	c9                   	leave  
    return -1;
801073d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801073d6:	c3                   	ret    
801073d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073de:	66 90                	xchg   %ax,%ax

801073e0 <sys_getpid>:

int
sys_getpid(void)
{
801073e0:	55                   	push   %ebp
801073e1:	89 e5                	mov    %esp,%ebp
801073e3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801073e6:	e8 65 d5 ff ff       	call   80104950 <myproc>
801073eb:	8b 40 10             	mov    0x10(%eax),%eax
}
801073ee:	c9                   	leave  
801073ef:	c3                   	ret    

801073f0 <sys_sbrk>:

int
sys_sbrk(void)
{
801073f0:	55                   	push   %ebp
801073f1:	89 e5                	mov    %esp,%ebp
801073f3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801073f4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801073f7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801073fa:	50                   	push   %eax
801073fb:	6a 00                	push   $0x0
801073fd:	e8 ee f0 ff ff       	call   801064f0 <argint>
80107402:	83 c4 10             	add    $0x10,%esp
80107405:	85 c0                	test   %eax,%eax
80107407:	78 27                	js     80107430 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80107409:	e8 42 d5 ff ff       	call   80104950 <myproc>
  if(growproc(n) < 0)
8010740e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80107411:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80107413:	ff 75 f4             	push   -0xc(%ebp)
80107416:	e8 55 d6 ff ff       	call   80104a70 <growproc>
8010741b:	83 c4 10             	add    $0x10,%esp
8010741e:	85 c0                	test   %eax,%eax
80107420:	78 0e                	js     80107430 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80107422:	89 d8                	mov    %ebx,%eax
80107424:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107427:	c9                   	leave  
80107428:	c3                   	ret    
80107429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80107430:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80107435:	eb eb                	jmp    80107422 <sys_sbrk+0x32>
80107437:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010743e:	66 90                	xchg   %ax,%ax

80107440 <sys_sleep>:

int
sys_sleep(void)
{
80107440:	55                   	push   %ebp
80107441:	89 e5                	mov    %esp,%ebp
80107443:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80107444:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80107447:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010744a:	50                   	push   %eax
8010744b:	6a 00                	push   $0x0
8010744d:	e8 9e f0 ff ff       	call   801064f0 <argint>
80107452:	83 c4 10             	add    $0x10,%esp
80107455:	85 c0                	test   %eax,%eax
80107457:	0f 88 8a 00 00 00    	js     801074e7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010745d:	83 ec 0c             	sub    $0xc,%esp
80107460:	68 20 a9 34 80       	push   $0x8034a920
80107465:	e8 b6 ea ff ff       	call   80105f20 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010746a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
8010746d:	8b 1d 84 a8 34 80    	mov    0x8034a884,%ebx
  while(ticks - ticks0 < n){
80107473:	83 c4 10             	add    $0x10,%esp
80107476:	85 d2                	test   %edx,%edx
80107478:	75 27                	jne    801074a1 <sys_sleep+0x61>
8010747a:	eb 54                	jmp    801074d0 <sys_sleep+0x90>
8010747c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80107480:	83 ec 08             	sub    $0x8,%esp
80107483:	68 20 a9 34 80       	push   $0x8034a920
80107488:	68 84 a8 34 80       	push   $0x8034a884
8010748d:	e8 9e db ff ff       	call   80105030 <sleep>
  while(ticks - ticks0 < n){
80107492:	a1 84 a8 34 80       	mov    0x8034a884,%eax
80107497:	83 c4 10             	add    $0x10,%esp
8010749a:	29 d8                	sub    %ebx,%eax
8010749c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010749f:	73 2f                	jae    801074d0 <sys_sleep+0x90>
    if(myproc()->killed){
801074a1:	e8 aa d4 ff ff       	call   80104950 <myproc>
801074a6:	8b 40 24             	mov    0x24(%eax),%eax
801074a9:	85 c0                	test   %eax,%eax
801074ab:	74 d3                	je     80107480 <sys_sleep+0x40>
      release(&tickslock);
801074ad:	83 ec 0c             	sub    $0xc,%esp
801074b0:	68 20 a9 34 80       	push   $0x8034a920
801074b5:	e8 06 ea ff ff       	call   80105ec0 <release>
  }
  release(&tickslock);
  return 0;
}
801074ba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return -1;
801074bd:	83 c4 10             	add    $0x10,%esp
801074c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801074c5:	c9                   	leave  
801074c6:	c3                   	ret    
801074c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801074ce:	66 90                	xchg   %ax,%ax
  release(&tickslock);
801074d0:	83 ec 0c             	sub    $0xc,%esp
801074d3:	68 20 a9 34 80       	push   $0x8034a920
801074d8:	e8 e3 e9 ff ff       	call   80105ec0 <release>
  return 0;
801074dd:	83 c4 10             	add    $0x10,%esp
801074e0:	31 c0                	xor    %eax,%eax
}
801074e2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801074e5:	c9                   	leave  
801074e6:	c3                   	ret    
    return -1;
801074e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801074ec:	eb f4                	jmp    801074e2 <sys_sleep+0xa2>
801074ee:	66 90                	xchg   %ax,%ax

801074f0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801074f0:	55                   	push   %ebp
801074f1:	89 e5                	mov    %esp,%ebp
801074f3:	53                   	push   %ebx
801074f4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801074f7:	68 20 a9 34 80       	push   $0x8034a920
801074fc:	e8 1f ea ff ff       	call   80105f20 <acquire>
  xticks = ticks;
80107501:	8b 1d 84 a8 34 80    	mov    0x8034a884,%ebx
  release(&tickslock);
80107507:	c7 04 24 20 a9 34 80 	movl   $0x8034a920,(%esp)
8010750e:	e8 ad e9 ff ff       	call   80105ec0 <release>
  return xticks;
}
80107513:	89 d8                	mov    %ebx,%eax
80107515:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107518:	c9                   	leave  
80107519:	c3                   	ret    
8010751a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107520 <sys_create_palindrome>:

int 
sys_create_palindrome(void)
{
80107520:	55                   	push   %ebp
80107521:	89 e5                	mov    %esp,%ebp
80107523:	53                   	push   %ebx
80107524:	83 ec 04             	sub    $0x4,%esp
    int number = myproc()->tf->ebx; //register after eax
80107527:	e8 24 d4 ff ff       	call   80104950 <myproc>
    cprintf("Kernel: sys_create_palindrome called for number %d\n", number);
8010752c:	83 ec 08             	sub    $0x8,%esp
    int number = myproc()->tf->ebx; //register after eax
8010752f:	8b 40 18             	mov    0x18(%eax),%eax
80107532:	8b 58 10             	mov    0x10(%eax),%ebx
    cprintf("Kernel: sys_create_palindrome called for number %d\n", number);
80107535:	53                   	push   %ebx
80107536:	68 a8 a0 10 80       	push   $0x8010a0a8
8010753b:	e8 b0 92 ff ff       	call   801007f0 <cprintf>
    return create_palindrome(number);
80107540:	89 1c 24             	mov    %ebx,(%esp)
80107543:	e8 48 dd ff ff       	call   80105290 <create_palindrome>
}
80107548:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010754b:	c9                   	leave  
8010754c:	c3                   	ret    
8010754d:	8d 76 00             	lea    0x0(%esi),%esi

80107550 <sys_sort_syscalls>:

int
sys_sort_syscalls(void)
{
80107550:	55                   	push   %ebp
80107551:	89 e5                	mov    %esp,%ebp
80107553:	83 ec 20             	sub    $0x20,%esp
    int pid;
    // try to extract the first argument of the system call
    int could_fetch = argint(0, &pid);
80107556:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107559:	50                   	push   %eax
8010755a:	6a 00                	push   $0x0
8010755c:	e8 8f ef ff ff       	call   801064f0 <argint>
    if (could_fetch < 0) {
80107561:	83 c4 10             	add    $0x10,%esp
80107564:	85 c0                	test   %eax,%eax
80107566:	78 30                	js     80107598 <sys_sort_syscalls+0x48>
        cprintf("Kernel: Could not extract the 'pid' argument for sort_syscalls\n");
        return -1;
    }
    
    // If the function reachs here, it means the 'pid' argument is available
    cprintf("Kernel: sort_syscalls called for process with ID %d\n", pid);
80107568:	83 ec 08             	sub    $0x8,%esp
8010756b:	ff 75 f4             	push   -0xc(%ebp)
8010756e:	68 1c a1 10 80       	push   $0x8010a11c
80107573:	e8 78 92 ff ff       	call   801007f0 <cprintf>

    // Get the process structure
    struct proc* p = find_process_by_id(pid);
80107578:	58                   	pop    %eax
80107579:	ff 75 f4             	push   -0xc(%ebp)
8010757c:	e8 6f dd ff ff       	call   801052f0 <find_process_by_id>

    if (p == 0) {
80107581:	83 c4 10             	add    $0x10,%esp
80107584:	85 c0                	test   %eax,%eax
80107586:	74 27                	je     801075af <sys_sort_syscalls+0x5f>
        cprintf("Kernel: Process with ID %d not found\n", pid);
        return -1;
    }

    sort_syscalls_for_process(p);
80107588:	83 ec 0c             	sub    $0xc,%esp
8010758b:	50                   	push   %eax
8010758c:	e8 cf dd ff ff       	call   80105360 <sort_syscalls_for_process>
    return 0;
80107591:	83 c4 10             	add    $0x10,%esp
80107594:	31 c0                	xor    %eax,%eax
}
80107596:	c9                   	leave  
80107597:	c3                   	ret    
        cprintf("Kernel: Could not extract the 'pid' argument for sort_syscalls\n");
80107598:	83 ec 0c             	sub    $0xc,%esp
8010759b:	68 dc a0 10 80       	push   $0x8010a0dc
801075a0:	e8 4b 92 ff ff       	call   801007f0 <cprintf>
        return -1;
801075a5:	83 c4 10             	add    $0x10,%esp
801075a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801075ad:	c9                   	leave  
801075ae:	c3                   	ret    
        cprintf("Kernel: Process with ID %d not found\n", pid);
801075af:	83 ec 08             	sub    $0x8,%esp
801075b2:	ff 75 f4             	push   -0xc(%ebp)
801075b5:	68 54 a1 10 80       	push   $0x8010a154
801075ba:	e8 31 92 ff ff       	call   801007f0 <cprintf>
        return -1;
801075bf:	83 c4 10             	add    $0x10,%esp
801075c2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801075c7:	c9                   	leave  
801075c8:	c3                   	ret    
801075c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801075d0 <sys_most_invoked_syscall>:

int
sys_most_invoked_syscall(void)
{
801075d0:	55                   	push   %ebp
801075d1:	89 e5                	mov    %esp,%ebp
801075d3:	83 ec 20             	sub    $0x20,%esp
    int pid;
    // try to extract the first argument of the system call
    int could_fetch = argint(0, &pid);
801075d6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801075d9:	50                   	push   %eax
801075da:	6a 00                	push   $0x0
801075dc:	e8 0f ef ff ff       	call   801064f0 <argint>
    if (could_fetch < 0) {
801075e1:	83 c4 10             	add    $0x10,%esp
801075e4:	85 c0                	test   %eax,%eax
801075e6:	78 30                	js     80107618 <sys_most_invoked_syscall+0x48>
        cprintf("Kernel: Could not extract the 'pid' argument for most_invoked_systemcall\n");
        return -1;
    }

    // If the function reachs here, it means the 'pid' argument is available
    cprintf("Kernel: most_invoked_systemcall called for process with ID %d\n", pid);
801075e8:	83 ec 08             	sub    $0x8,%esp
801075eb:	ff 75 f4             	push   -0xc(%ebp)
801075ee:	68 c8 a1 10 80       	push   $0x8010a1c8
801075f3:	e8 f8 91 ff ff       	call   801007f0 <cprintf>

    // Get the process structure
    struct proc* p = find_process_by_id(pid);
801075f8:	58                   	pop    %eax
801075f9:	ff 75 f4             	push   -0xc(%ebp)
801075fc:	e8 ef dc ff ff       	call   801052f0 <find_process_by_id>

    if (p == 0) {
80107601:	83 c4 10             	add    $0x10,%esp
80107604:	85 c0                	test   %eax,%eax
80107606:	74 27                	je     8010762f <sys_most_invoked_syscall+0x5f>
        cprintf("Kernel: Process with ID %d not found\n", pid);
        return -1;
    }

    get_most_invoked_syscall(p);
80107608:	83 ec 0c             	sub    $0xc,%esp
8010760b:	50                   	push   %eax
8010760c:	e8 df df ff ff       	call   801055f0 <get_most_invoked_syscall>
    return 0;
80107611:	83 c4 10             	add    $0x10,%esp
80107614:	31 c0                	xor    %eax,%eax
}
80107616:	c9                   	leave  
80107617:	c3                   	ret    
        cprintf("Kernel: Could not extract the 'pid' argument for most_invoked_systemcall\n");
80107618:	83 ec 0c             	sub    $0xc,%esp
8010761b:	68 7c a1 10 80       	push   $0x8010a17c
80107620:	e8 cb 91 ff ff       	call   801007f0 <cprintf>
        return -1;
80107625:	83 c4 10             	add    $0x10,%esp
80107628:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010762d:	c9                   	leave  
8010762e:	c3                   	ret    
        cprintf("Kernel: Process with ID %d not found\n", pid);
8010762f:	83 ec 08             	sub    $0x8,%esp
80107632:	ff 75 f4             	push   -0xc(%ebp)
80107635:	68 54 a1 10 80       	push   $0x8010a154
8010763a:	e8 b1 91 ff ff       	call   801007f0 <cprintf>
        return -1;
8010763f:	83 c4 10             	add    $0x10,%esp
80107642:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107647:	c9                   	leave  
80107648:	c3                   	ret    
80107649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107650 <sys_list_all_processes>:

void
sys_list_all_processes(void)
{
80107650:	55                   	push   %ebp
80107651:	89 e5                	mov    %esp,%ebp
80107653:	83 ec 14             	sub    $0x14,%esp
  cprintf("Kernel: sys_list_all_processes called.\n");
80107656:	68 08 a2 10 80       	push   $0x8010a208
8010765b:	e8 90 91 ff ff       	call   801007f0 <cprintf>
  list_all_processes(1);
80107660:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80107667:	e8 84 e0 ff ff       	call   801056f0 <list_all_processes>
}
8010766c:	83 c4 10             	add    $0x10,%esp
8010766f:	c9                   	leave  
80107670:	c3                   	ret    
80107671:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107678:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010767f:	90                   	nop

80107680 <sys_setqueue>:

int sys_setqueue(void) {
80107680:	55                   	push   %ebp
80107681:	89 e5                	mov    %esp,%ebp
80107683:	53                   	push   %ebx
    int pid, level;

    if (argint(0, &pid) < 0 || argint(1, &level) < 0) {
80107684:	8d 45 f0             	lea    -0x10(%ebp),%eax
int sys_setqueue(void) {
80107687:	83 ec 1c             	sub    $0x1c,%esp
    if (argint(0, &pid) < 0 || argint(1, &level) < 0) {
8010768a:	50                   	push   %eax
8010768b:	6a 00                	push   $0x0
8010768d:	e8 5e ee ff ff       	call   801064f0 <argint>
80107692:	83 c4 10             	add    $0x10,%esp
80107695:	85 c0                	test   %eax,%eax
80107697:	78 56                	js     801076ef <sys_setqueue+0x6f>
80107699:	83 ec 08             	sub    $0x8,%esp
8010769c:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010769f:	50                   	push   %eax
801076a0:	6a 01                	push   $0x1
801076a2:	e8 49 ee ff ff       	call   801064f0 <argint>
801076a7:	83 c4 10             	add    $0x10,%esp
801076aa:	85 c0                	test   %eax,%eax
801076ac:	78 41                	js     801076ef <sys_setqueue+0x6f>
        cprintf("Kernel: Could not extract all of the arguments for setqueue\n");
        return -1;  
    }
    
    struct proc *ptable_array = getptable();  
801076ae:	e8 2d e5 ff ff       	call   80105be0 <getptable>

    struct proc *p;
    int success = -1;  
    
    for (p = ptable_array; p < &ptable_array[NPROC]; p++) {
        if (p->pid == pid) {  
801076b3:	8b 55 f0             	mov    -0x10(%ebp),%edx
    for (p = ptable_array; p < &ptable_array[NPROC]; p++) {
801076b6:	8d 88 00 50 23 00    	lea    0x235000(%eax),%ecx
801076bc:	eb 0b                	jmp    801076c9 <sys_setqueue+0x49>
801076be:	66 90                	xchg   %ax,%ax
801076c0:	05 40 8d 00 00       	add    $0x8d40,%eax
801076c5:	39 c8                	cmp    %ecx,%eax
801076c7:	74 1f                	je     801076e8 <sys_setqueue+0x68>
        if (p->pid == pid) {  
801076c9:	39 50 10             	cmp    %edx,0x10(%eax)
801076cc:	75 f2                	jne    801076c0 <sys_setqueue+0x40>
            p->sched_info.queue_level = level;
801076ce:	8b 55 f4             	mov    -0xc(%ebp),%edx
            success = 0;  
801076d1:	31 db                	xor    %ebx,%ebx
            p->sched_info.queue_level = level;
801076d3:	89 90 20 8d 00 00    	mov    %edx,0x8d20(%eax)
            break;
        }
    }

    releaseptable();
801076d9:	e8 22 e5 ff ff       	call   80105c00 <releaseptable>
    return success;
}
801076de:	89 d8                	mov    %ebx,%eax
801076e0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801076e3:	c9                   	leave  
801076e4:	c3                   	ret    
801076e5:	8d 76 00             	lea    0x0(%esi),%esi
    int success = -1;  
801076e8:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801076ed:	eb ea                	jmp    801076d9 <sys_setqueue+0x59>
        cprintf("Kernel: Could not extract all of the arguments for setqueue\n");
801076ef:	83 ec 0c             	sub    $0xc,%esp
        return -1;  
801076f2:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
        cprintf("Kernel: Could not extract all of the arguments for setqueue\n");
801076f7:	68 30 a2 10 80       	push   $0x8010a230
801076fc:	e8 ef 90 ff ff       	call   801007f0 <cprintf>
        return -1;  
80107701:	83 c4 10             	add    $0x10,%esp
80107704:	eb d8                	jmp    801076de <sys_setqueue+0x5e>
80107706:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010770d:	8d 76 00             	lea    0x0(%esi),%esi

80107710 <sys_printinfo>:
  [RUNNABLE] "RUNNABLE",
  [RUNNING] "RUNNING",
  [ZOMBIE] "ZOMBIE"
};

int sys_printinfo(void) {
80107710:	55                   	push   %ebp
80107711:	89 e5                	mov    %esp,%ebp
80107713:	57                   	push   %edi
80107714:	56                   	push   %esi
    char wait_title [100];
    char confidence_title [100];
    char burst_title [100];
    char consecutive_title [100];
    char arrival_title [100];
    align_word("Name", 16, name_title);
80107715:	8d 85 24 f6 ff ff    	lea    -0x9dc(%ebp),%eax
    align_word("PID", 4, pid_title);
    align_word("State", 11, state_title);
    align_word("Queue", 8, queue_title);
    align_word("Wait-time", 11, wait_title);
8010771b:	8d b5 b4 f7 ff ff    	lea    -0x84c(%ebp),%esi
int sys_printinfo(void) {
80107721:	53                   	push   %ebx
    align_word("Queue", 8, queue_title);
80107722:	8d 9d 50 f7 ff ff    	lea    -0x8b0(%ebp),%ebx
    align_word("Confidence", 12, confidence_title);
80107728:	8d bd 18 f8 ff ff    	lea    -0x7e8(%ebp),%edi
int sys_printinfo(void) {
8010772e:	81 ec f0 09 00 00    	sub    $0x9f0,%esp
    align_word("Name", 16, name_title);
80107734:	50                   	push   %eax
80107735:	6a 10                	push   $0x10
80107737:	68 48 a3 10 80       	push   $0x8010a348
8010773c:	e8 ef eb ff ff       	call   80106330 <align_word>
    align_word("PID", 4, pid_title);
80107741:	83 c4 0c             	add    $0xc,%esp
80107744:	8d 85 88 f6 ff ff    	lea    -0x978(%ebp),%eax
8010774a:	50                   	push   %eax
8010774b:	6a 04                	push   $0x4
8010774d:	68 4d a3 10 80       	push   $0x8010a34d
80107752:	e8 d9 eb ff ff       	call   80106330 <align_word>
    align_word("State", 11, state_title);
80107757:	8d 85 ec f6 ff ff    	lea    -0x914(%ebp),%eax
8010775d:	83 c4 0c             	add    $0xc,%esp
80107760:	50                   	push   %eax
80107761:	6a 0b                	push   $0xb
80107763:	68 51 a3 10 80       	push   $0x8010a351
80107768:	e8 c3 eb ff ff       	call   80106330 <align_word>
    align_word("Queue", 8, queue_title);
8010776d:	83 c4 0c             	add    $0xc,%esp
80107770:	53                   	push   %ebx
80107771:	6a 08                	push   $0x8
80107773:	68 57 a3 10 80       	push   $0x8010a357
80107778:	e8 b3 eb ff ff       	call   80106330 <align_word>
    align_word("Wait-time", 11, wait_title);
8010777d:	83 c4 0c             	add    $0xc,%esp
80107780:	56                   	push   %esi
80107781:	6a 0b                	push   $0xb
80107783:	68 5d a3 10 80       	push   $0x8010a35d
80107788:	e8 a3 eb ff ff       	call   80106330 <align_word>
    align_word("Confidence", 12, confidence_title);
8010778d:	83 c4 0c             	add    $0xc,%esp
80107790:	57                   	push   %edi
80107791:	6a 0c                	push   $0xc
80107793:	68 67 a3 10 80       	push   $0x8010a367
80107798:	e8 93 eb ff ff       	call   80106330 <align_word>
    align_word("Burst-time", 12, burst_title);
8010779d:	83 c4 0c             	add    $0xc,%esp
801077a0:	8d 85 7c f8 ff ff    	lea    -0x784(%ebp),%eax
801077a6:	50                   	push   %eax
801077a7:	6a 0c                	push   $0xc
801077a9:	68 72 a3 10 80       	push   $0x8010a372
801077ae:	e8 7d eb ff ff       	call   80106330 <align_word>
    align_word("Consecutive-run", 19, consecutive_title);
801077b3:	83 c4 0c             	add    $0xc,%esp
801077b6:	8d 95 e0 f8 ff ff    	lea    -0x720(%ebp),%edx
801077bc:	52                   	push   %edx
801077bd:	6a 13                	push   $0x13
801077bf:	68 7d a3 10 80       	push   $0x8010a37d
801077c4:	e8 67 eb ff ff       	call   80106330 <align_word>
    align_word("Arrival", 9, arrival_title);
801077c9:	83 c4 0c             	add    $0xc,%esp
801077cc:	8d 8d 44 f9 ff ff    	lea    -0x6bc(%ebp),%ecx
801077d2:	51                   	push   %ecx
801077d3:	6a 09                	push   $0x9
801077d5:	68 8d a3 10 80       	push   $0x8010a38d
801077da:	e8 51 eb ff ff       	call   80106330 <align_word>
    cprintf("%s %s %s %s %s %s %s %s %s \n",
801077df:	58                   	pop    %eax
801077e0:	8d 8d 44 f9 ff ff    	lea    -0x6bc(%ebp),%ecx
801077e6:	5a                   	pop    %edx
801077e7:	8d 85 7c f8 ff ff    	lea    -0x784(%ebp),%eax
801077ed:	8d 95 e0 f8 ff ff    	lea    -0x720(%ebp),%edx
801077f3:	51                   	push   %ecx
801077f4:	52                   	push   %edx
801077f5:	50                   	push   %eax
801077f6:	8d 85 ec f6 ff ff    	lea    -0x914(%ebp),%eax
801077fc:	57                   	push   %edi
801077fd:	56                   	push   %esi
801077fe:	53                   	push   %ebx
801077ff:	50                   	push   %eax
80107800:	8d 85 88 f6 ff ff    	lea    -0x978(%ebp),%eax
80107806:	50                   	push   %eax
80107807:	8d 85 24 f6 ff ff    	lea    -0x9dc(%ebp),%eax
8010780d:	50                   	push   %eax
8010780e:	68 95 a3 10 80       	push   $0x8010a395
80107813:	e8 d8 8f ff ff       	call   801007f0 <cprintf>
              wait_title,
              confidence_title,
              burst_title,
              consecutive_title,
              arrival_title);  
    cprintf("------------------------------------------------------------------------------------------------------------\n");
80107818:	83 c4 24             	add    $0x24,%esp
8010781b:	68 70 a2 10 80       	push   $0x8010a270
80107820:	e8 cb 8f ff ff       	call   801007f0 <cprintf>

    struct proc *ptable_array = getptable();
80107825:	e8 b6 e3 ff ff       	call   80105be0 <getptable>
 
    for (p = ptable_array; p < &ptable_array[NPROC]; p++) {
8010782a:	83 c4 10             	add    $0x10,%esp
8010782d:	8d 58 6c             	lea    0x6c(%eax),%ebx
80107830:	05 6c 50 23 00       	add    $0x23506c,%eax
80107835:	89 85 14 f6 ff ff    	mov    %eax,-0x9ec(%ebp)
8010783b:	eb 15                	jmp    80107852 <sys_printinfo+0x142>
8010783d:	8d 76 00             	lea    0x0(%esi),%esi
80107840:	81 c3 40 8d 00 00    	add    $0x8d40,%ebx
80107846:	3b 9d 14 f6 ff ff    	cmp    -0x9ec(%ebp),%ebx
8010784c:	0f 84 b6 01 00 00    	je     80107a08 <sys_printinfo+0x2f8>
        if (p->state != UNUSED) {  
80107852:	8b 4b a0             	mov    -0x60(%ebx),%ecx
80107855:	85 c9                	test   %ecx,%ecx
80107857:	74 e7                	je     80107840 <sys_printinfo+0x130>
            char _name[100];
            align_word(p->name, 16, _name);
80107859:	83 ec 04             	sub    $0x4,%esp
8010785c:	8d 85 a8 f9 ff ff    	lea    -0x658(%ebp),%eax

            char _state[100];
            align_word(state_str[p->state], 11, _state);

            char __queue[100];
            myitos(p->sched_info.queue_level, __queue, 10);
80107862:	8d b5 38 fb ff ff    	lea    -0x4c8(%ebp),%esi
            align_word(p->name, 16, _name);
80107868:	50                   	push   %eax
            myitos(p->sched_info.wait_time, __wait, 10);
            char _wait[100];
            align_word(__wait, 11, _wait);

            char __conf[100];
            myitos(p->sched_info.confidence, __conf, 10);
80107869:	8d bd c8 fc ff ff    	lea    -0x338(%ebp),%edi
            align_word(p->name, 16, _name);
8010786f:	6a 10                	push   $0x10
80107871:	53                   	push   %ebx
80107872:	e8 b9 ea ff ff       	call   80106330 <align_word>
            myitos(p->pid, __pid, 10);
80107877:	83 c4 0c             	add    $0xc,%esp
8010787a:	8d 85 0c fa ff ff    	lea    -0x5f4(%ebp),%eax
80107880:	6a 0a                	push   $0xa
80107882:	50                   	push   %eax
80107883:	ff 73 a4             	push   -0x5c(%ebx)
80107886:	e8 f5 ea ff ff       	call   80106380 <myitos>
            align_word(__pid, 4, _pid);
8010788b:	83 c4 0c             	add    $0xc,%esp
8010788e:	8d 85 70 fa ff ff    	lea    -0x590(%ebp),%eax
80107894:	50                   	push   %eax
80107895:	8d 85 0c fa ff ff    	lea    -0x5f4(%ebp),%eax
8010789b:	6a 04                	push   $0x4
8010789d:	50                   	push   %eax
8010789e:	e8 8d ea ff ff       	call   80106330 <align_word>
            align_word(state_str[p->state], 11, _state);
801078a3:	83 c4 0c             	add    $0xc,%esp
801078a6:	8d 85 d4 fa ff ff    	lea    -0x52c(%ebp),%eax
801078ac:	50                   	push   %eax
801078ad:	6a 0b                	push   $0xb
801078af:	8b 43 a0             	mov    -0x60(%ebx),%eax
801078b2:	ff 34 85 fc a3 10 80 	push   -0x7fef5c04(,%eax,4)
801078b9:	e8 72 ea ff ff       	call   80106330 <align_word>
            myitos(p->sched_info.queue_level, __queue, 10);
801078be:	83 c4 0c             	add    $0xc,%esp
801078c1:	6a 0a                	push   $0xa
801078c3:	56                   	push   %esi
801078c4:	ff b3 b4 8c 00 00    	push   0x8cb4(%ebx)
801078ca:	e8 b1 ea ff ff       	call   80106380 <myitos>
            align_word(__queue, 8, _queue);
801078cf:	83 c4 0c             	add    $0xc,%esp
801078d2:	8d 85 9c fb ff ff    	lea    -0x464(%ebp),%eax
801078d8:	50                   	push   %eax
801078d9:	6a 08                	push   $0x8
801078db:	56                   	push   %esi
            myitos(p->sched_info.wait_time, __wait, 10);
801078dc:	8d b5 00 fc ff ff    	lea    -0x400(%ebp),%esi
            align_word(__queue, 8, _queue);
801078e2:	e8 49 ea ff ff       	call   80106330 <align_word>
            myitos(p->sched_info.wait_time, __wait, 10);
801078e7:	83 c4 0c             	add    $0xc,%esp
801078ea:	6a 0a                	push   $0xa
801078ec:	56                   	push   %esi
801078ed:	ff b3 cc 8c 00 00    	push   0x8ccc(%ebx)
801078f3:	e8 88 ea ff ff       	call   80106380 <myitos>
            align_word(__wait, 11, _wait);
801078f8:	83 c4 0c             	add    $0xc,%esp
801078fb:	8d 85 64 fc ff ff    	lea    -0x39c(%ebp),%eax
80107901:	50                   	push   %eax
80107902:	6a 0b                	push   $0xb
80107904:	56                   	push   %esi
            char _conf[100];
            align_word(__conf, 12, _conf);
80107905:	8d b5 2c fd ff ff    	lea    -0x2d4(%ebp),%esi
            align_word(__wait, 11, _wait);
8010790b:	e8 20 ea ff ff       	call   80106330 <align_word>
            myitos(p->sched_info.confidence, __conf, 10);
80107910:	83 c4 0c             	add    $0xc,%esp
80107913:	6a 0a                	push   $0xa
80107915:	57                   	push   %edi
80107916:	ff b3 bc 8c 00 00    	push   0x8cbc(%ebx)
8010791c:	e8 5f ea ff ff       	call   80106380 <myitos>
            align_word(__conf, 12, _conf);
80107921:	83 c4 0c             	add    $0xc,%esp
80107924:	56                   	push   %esi
80107925:	6a 0c                	push   $0xc
80107927:	57                   	push   %edi
            
            char __burst[100];
            myitos(p->sched_info.burst_time, __burst, 10);
            char _burst[100];
            align_word(__burst, 12, _burst);
80107928:	8d bd f4 fd ff ff    	lea    -0x20c(%ebp),%edi
            align_word(__conf, 12, _conf);
8010792e:	e8 fd e9 ff ff       	call   80106330 <align_word>
            myitos(p->sched_info.burst_time, __burst, 10);
80107933:	83 c4 0c             	add    $0xc,%esp
80107936:	8d 85 90 fd ff ff    	lea    -0x270(%ebp),%eax
8010793c:	6a 0a                	push   $0xa
8010793e:	50                   	push   %eax
8010793f:	ff b3 b8 8c 00 00    	push   0x8cb8(%ebx)
80107945:	e8 36 ea ff ff       	call   80106380 <myitos>
            align_word(__burst, 12, _burst);
8010794a:	83 c4 0c             	add    $0xc,%esp
8010794d:	8d 85 90 fd ff ff    	lea    -0x270(%ebp),%eax
80107953:	57                   	push   %edi
80107954:	6a 0c                	push   $0xc
80107956:	50                   	push   %eax
80107957:	e8 d4 e9 ff ff       	call   80106330 <align_word>

            char __cons[100];
            myitos(p->sched_info.consecutive_run, __cons, 10);
8010795c:	83 c4 0c             	add    $0xc,%esp
8010795f:	8d 95 58 fe ff ff    	lea    -0x1a8(%ebp),%edx
80107965:	6a 0a                	push   $0xa
80107967:	52                   	push   %edx
80107968:	ff b3 c0 8c 00 00    	push   0x8cc0(%ebx)
8010796e:	e8 0d ea ff ff       	call   80106380 <myitos>
            char _cons[100];
            align_word(__cons, 19, _cons);
80107973:	83 c4 0c             	add    $0xc,%esp
80107976:	8d 85 bc fe ff ff    	lea    -0x144(%ebp),%eax
8010797c:	8d 95 58 fe ff ff    	lea    -0x1a8(%ebp),%edx
80107982:	50                   	push   %eax
80107983:	6a 13                	push   $0x13
80107985:	52                   	push   %edx
80107986:	e8 a5 e9 ff ff       	call   80106330 <align_word>

            char __arr[100];
            myitos(p->sched_info.arrival_time, __arr, 10);
8010798b:	83 c4 0c             	add    $0xc,%esp
8010798e:	8d 8d 20 ff ff ff    	lea    -0xe0(%ebp),%ecx
80107994:	6a 0a                	push   $0xa
80107996:	51                   	push   %ecx
80107997:	ff b3 c4 8c 00 00    	push   0x8cc4(%ebx)
8010799d:	e8 de e9 ff ff       	call   80106380 <myitos>
            char _arr[100];
            align_word(__arr, 9, _arr);
801079a2:	83 c4 0c             	add    $0xc,%esp
801079a5:	8d 55 84             	lea    -0x7c(%ebp),%edx
801079a8:	8d 8d 20 ff ff ff    	lea    -0xe0(%ebp),%ecx
801079ae:	52                   	push   %edx
801079af:	6a 09                	push   $0x9
801079b1:	51                   	push   %ecx
801079b2:	e8 79 e9 ff ff       	call   80106330 <align_word>
            
            cprintf("%s %s %s %s %s %s %s %s %s \n",
801079b7:	58                   	pop    %eax
801079b8:	8d 85 bc fe ff ff    	lea    -0x144(%ebp),%eax
801079be:	5a                   	pop    %edx
801079bf:	8d 55 84             	lea    -0x7c(%ebp),%edx
801079c2:	52                   	push   %edx
801079c3:	50                   	push   %eax
801079c4:	8d 85 64 fc ff ff    	lea    -0x39c(%ebp),%eax
801079ca:	57                   	push   %edi
801079cb:	56                   	push   %esi
801079cc:	50                   	push   %eax
801079cd:	8d 85 9c fb ff ff    	lea    -0x464(%ebp),%eax
801079d3:	50                   	push   %eax
801079d4:	8d 85 d4 fa ff ff    	lea    -0x52c(%ebp),%eax
801079da:	50                   	push   %eax
801079db:	8d 85 70 fa ff ff    	lea    -0x590(%ebp),%eax
801079e1:	50                   	push   %eax
801079e2:	8d 85 a8 f9 ff ff    	lea    -0x658(%ebp),%eax
801079e8:	50                   	push   %eax
801079e9:	68 95 a3 10 80       	push   $0x8010a395
801079ee:	e8 fd 8d ff ff       	call   801007f0 <cprintf>
801079f3:	83 c4 30             	add    $0x30,%esp
    for (p = ptable_array; p < &ptable_array[NPROC]; p++) {
801079f6:	81 c3 40 8d 00 00    	add    $0x8d40,%ebx
801079fc:	3b 9d 14 f6 ff ff    	cmp    -0x9ec(%ebp),%ebx
80107a02:	0f 85 4a fe ff ff    	jne    80107852 <sys_printinfo+0x142>
              _burst,
              _cons,
              _arr);  
        }
    }
    cprintf("------------------------------------------------------------------------------------------------------------\n");
80107a08:	83 ec 0c             	sub    $0xc,%esp
80107a0b:	68 70 a2 10 80       	push   $0x8010a270
80107a10:	e8 db 8d ff ff       	call   801007f0 <cprintf>
    releaseptable();
80107a15:	e8 e6 e1 ff ff       	call   80105c00 <releaseptable>
    return 0;
}
80107a1a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a1d:	31 c0                	xor    %eax,%eax
80107a1f:	5b                   	pop    %ebx
80107a20:	5e                   	pop    %esi
80107a21:	5f                   	pop    %edi
80107a22:	5d                   	pop    %ebp
80107a23:	c3                   	ret    
80107a24:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107a2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107a2f:	90                   	nop

80107a30 <sys_setburstconf>:

int sys_setburstconf(void) {
80107a30:	55                   	push   %ebp
80107a31:	89 e5                	mov    %esp,%ebp
80107a33:	83 ec 20             	sub    $0x20,%esp
    int pid, burst_time, confidence;

    if (argint(0, &pid) < 0 || argint(1, &burst_time) < 0 || argint(2, &confidence) < 0) {
80107a36:	8d 45 ec             	lea    -0x14(%ebp),%eax
80107a39:	50                   	push   %eax
80107a3a:	6a 00                	push   $0x0
80107a3c:	e8 af ea ff ff       	call   801064f0 <argint>
80107a41:	83 c4 10             	add    $0x10,%esp
80107a44:	85 c0                	test   %eax,%eax
80107a46:	78 7c                	js     80107ac4 <sys_setburstconf+0x94>
80107a48:	83 ec 08             	sub    $0x8,%esp
80107a4b:	8d 45 f0             	lea    -0x10(%ebp),%eax
80107a4e:	50                   	push   %eax
80107a4f:	6a 01                	push   $0x1
80107a51:	e8 9a ea ff ff       	call   801064f0 <argint>
80107a56:	83 c4 10             	add    $0x10,%esp
80107a59:	85 c0                	test   %eax,%eax
80107a5b:	78 67                	js     80107ac4 <sys_setburstconf+0x94>
80107a5d:	83 ec 08             	sub    $0x8,%esp
80107a60:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107a63:	50                   	push   %eax
80107a64:	6a 02                	push   $0x2
80107a66:	e8 85 ea ff ff       	call   801064f0 <argint>
80107a6b:	83 c4 10             	add    $0x10,%esp
80107a6e:	85 c0                	test   %eax,%eax
80107a70:	78 52                	js     80107ac4 <sys_setburstconf+0x94>
        cprintf("Kernel: Could not extract all of the arguments for setburstconf\n");
        return -1;
    }

    struct proc *p;
    struct proc *ptable_array = getptable();
80107a72:	e8 69 e1 ff ff       	call   80105be0 <getptable>
    
    for (p = ptable_array; p < &ptable_array[NPROC]; p++) {
        if (p->pid == pid) {
80107a77:	8b 55 ec             	mov    -0x14(%ebp),%edx
    for (p = ptable_array; p < &ptable_array[NPROC]; p++) {
80107a7a:	8d 88 00 50 23 00    	lea    0x235000(%eax),%ecx
80107a80:	eb 0f                	jmp    80107a91 <sys_setburstconf+0x61>
80107a82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107a88:	05 40 8d 00 00       	add    $0x8d40,%eax
80107a8d:	39 c8                	cmp    %ecx,%eax
80107a8f:	74 27                	je     80107ab8 <sys_setburstconf+0x88>
        if (p->pid == pid) {
80107a91:	39 50 10             	cmp    %edx,0x10(%eax)
80107a94:	75 f2                	jne    80107a88 <sys_setburstconf+0x58>
            p->sched_info.burst_time = burst_time;
80107a96:	8b 55 f0             	mov    -0x10(%ebp),%edx
80107a99:	89 90 24 8d 00 00    	mov    %edx,0x8d24(%eax)
            p->sched_info.confidence = confidence;
80107a9f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80107aa2:	89 90 28 8d 00 00    	mov    %edx,0x8d28(%eax)
            releaseptable();
80107aa8:	e8 53 e1 ff ff       	call   80105c00 <releaseptable>
            return 0;  
80107aad:	31 c0                	xor    %eax,%eax
        }
    }

    releaseptable();
    return -1;  
}
80107aaf:	c9                   	leave  
80107ab0:	c3                   	ret    
80107ab1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    releaseptable();
80107ab8:	e8 43 e1 ff ff       	call   80105c00 <releaseptable>
    return -1;  
80107abd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107ac2:	c9                   	leave  
80107ac3:	c3                   	ret    
        cprintf("Kernel: Could not extract all of the arguments for setburstconf\n");
80107ac4:	83 ec 0c             	sub    $0xc,%esp
80107ac7:	68 e0 a2 10 80       	push   $0x8010a2e0
80107acc:	e8 1f 8d ff ff       	call   801007f0 <cprintf>
        return -1;
80107ad1:	83 c4 10             	add    $0x10,%esp
80107ad4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107ad9:	c9                   	leave  
80107ada:	c3                   	ret    
80107adb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107adf:	90                   	nop

80107ae0 <sys_count_syscalls>:

int sys_count_syscalls(void){
80107ae0:	55                   	push   %ebp
80107ae1:	89 e5                	mov    %esp,%ebp
80107ae3:	53                   	push   %ebx
80107ae4:	83 ec 04             	sub    $0x4,%esp
    int num_syscalls = 0;
    for (int i = 0; i < ncpu; i++) {  // `ncpu` is the total number of CPUs
80107ae7:	8b 15 44 52 11 80    	mov    0x80115244,%edx
80107aed:	85 d2                	test   %edx,%edx
80107aef:	7e 4f                	jle    80107b40 <sys_count_syscalls+0x60>
80107af1:	69 d2 bc 00 00 00    	imul   $0xbc,%edx,%edx
80107af7:	31 c0                	xor    %eax,%eax
    int num_syscalls = 0;
80107af9:	31 db                	xor    %ebx,%ebx
80107afb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107aff:	90                   	nop
        struct cpu *c = &cpus[i];
        num_syscalls += c->sys_call_counter;
80107b00:	03 98 18 53 11 80    	add    -0x7feeace8(%eax),%ebx
    for (int i = 0; i < ncpu; i++) {  // `ncpu` is the total number of CPUs
80107b06:	05 bc 00 00 00       	add    $0xbc,%eax
80107b0b:	39 d0                	cmp    %edx,%eax
80107b0d:	75 f1                	jne    80107b00 <sys_count_syscalls+0x20>
    }
    cprintf("Global counter says: %d\n", global_sys_call_counter);
80107b0f:	83 ec 08             	sub    $0x8,%esp
80107b12:	ff 35 80 a8 34 80    	push   0x8034a880
80107b18:	68 b2 a3 10 80       	push   $0x8010a3b2
80107b1d:	e8 ce 8c ff ff       	call   801007f0 <cprintf>
    cprintf("Number of system calls used is: %d\n", num_syscalls);
80107b22:	58                   	pop    %eax
80107b23:	5a                   	pop    %edx
80107b24:	53                   	push   %ebx
80107b25:	68 24 a3 10 80       	push   $0x8010a324
80107b2a:	e8 c1 8c ff ff       	call   801007f0 <cprintf>
    return 0;
}
80107b2f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107b32:	31 c0                	xor    %eax,%eax
80107b34:	c9                   	leave  
80107b35:	c3                   	ret    
80107b36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107b3d:	8d 76 00             	lea    0x0(%esi),%esi
    int num_syscalls = 0;
80107b40:	31 db                	xor    %ebx,%ebx
80107b42:	eb cb                	jmp    80107b0f <sys_count_syscalls+0x2f>
80107b44:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107b4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107b4f:	90                   	nop

80107b50 <sys_init_reentrantlock>:

int sys_init_reentrantlock(void) {
80107b50:	55                   	push   %ebp
80107b51:	89 e5                	mov    %esp,%ebp
80107b53:	83 ec 1c             	sub    $0x1c,%esp
  struct reentrantlock* rl;
  if (argptr(0, (void*)&rl, sizeof(*rl)) < 0) { return -1; }
80107b56:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107b59:	6a 44                	push   $0x44
80107b5b:	50                   	push   %eax
80107b5c:	6a 00                	push   $0x0
80107b5e:	e8 dd e9 ff ff       	call   80106540 <argptr>
80107b63:	83 c4 10             	add    $0x10,%esp
80107b66:	85 c0                	test   %eax,%eax
80107b68:	78 16                	js     80107b80 <sys_init_reentrantlock+0x30>
  init_reentrantlock(rl);  
80107b6a:	83 ec 0c             	sub    $0xc,%esp
80107b6d:	ff 75 f4             	push   -0xc(%ebp)
80107b70:	e8 6b e4 ff ff       	call   80105fe0 <init_reentrantlock>
  return 0;
80107b75:	83 c4 10             	add    $0x10,%esp
80107b78:	31 c0                	xor    %eax,%eax
}
80107b7a:	c9                   	leave  
80107b7b:	c3                   	ret    
80107b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107b80:	c9                   	leave  
  if (argptr(0, (void*)&rl, sizeof(*rl)) < 0) { return -1; }
80107b81:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107b86:	c3                   	ret    
80107b87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107b8e:	66 90                	xchg   %ax,%ax

80107b90 <sys_acquire_reentrantlock>:

// bejaye 0, 1 ro emtehan kon
int sys_acquire_reentrantlock(void) {
80107b90:	55                   	push   %ebp
80107b91:	89 e5                	mov    %esp,%ebp
80107b93:	83 ec 1c             	sub    $0x1c,%esp
  struct reentrantlock* rl;
  if (argptr(0, (void*)&rl, sizeof(*rl)) < 0) { return -1; }
80107b96:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107b99:	6a 44                	push   $0x44
80107b9b:	50                   	push   %eax
80107b9c:	6a 00                	push   $0x0
80107b9e:	e8 9d e9 ff ff       	call   80106540 <argptr>
80107ba3:	83 c4 10             	add    $0x10,%esp
80107ba6:	85 c0                	test   %eax,%eax
80107ba8:	78 16                	js     80107bc0 <sys_acquire_reentrantlock+0x30>
  acquire_reentrantlock(rl);
80107baa:	83 ec 0c             	sub    $0xc,%esp
80107bad:	ff 75 f4             	push   -0xc(%ebp)
80107bb0:	e8 7b e4 ff ff       	call   80106030 <acquire_reentrantlock>
  return 0;
80107bb5:	83 c4 10             	add    $0x10,%esp
80107bb8:	31 c0                	xor    %eax,%eax
}
80107bba:	c9                   	leave  
80107bbb:	c3                   	ret    
80107bbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107bc0:	c9                   	leave  
  if (argptr(0, (void*)&rl, sizeof(*rl)) < 0) { return -1; }
80107bc1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107bc6:	c3                   	ret    
80107bc7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107bce:	66 90                	xchg   %ax,%ax

80107bd0 <sys_release_reentrantlock>:

int sys_release_reentrantlock(void) {
80107bd0:	55                   	push   %ebp
80107bd1:	89 e5                	mov    %esp,%ebp
80107bd3:	83 ec 1c             	sub    $0x1c,%esp
  struct reentrantlock* rl;
  if (argptr(0, (void*)&rl, sizeof(*rl)) < 0) { return -1; }
80107bd6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107bd9:	6a 44                	push   $0x44
80107bdb:	50                   	push   %eax
80107bdc:	6a 00                	push   $0x0
80107bde:	e8 5d e9 ff ff       	call   80106540 <argptr>
80107be3:	83 c4 10             	add    $0x10,%esp
80107be6:	85 c0                	test   %eax,%eax
80107be8:	78 16                	js     80107c00 <sys_release_reentrantlock+0x30>
  release_reentrantlock(rl);
80107bea:	83 ec 0c             	sub    $0xc,%esp
80107bed:	ff 75 f4             	push   -0xc(%ebp)
80107bf0:	e8 ab e4 ff ff       	call   801060a0 <release_reentrantlock>
  return 0;
80107bf5:	83 c4 10             	add    $0x10,%esp
80107bf8:	31 c0                	xor    %eax,%eax
}
80107bfa:	c9                   	leave  
80107bfb:	c3                   	ret    
80107bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107c00:	c9                   	leave  
  if (argptr(0, (void*)&rl, sizeof(*rl)) < 0) { return -1; }
80107c01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107c06:	c3                   	ret    

80107c07 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80107c07:	1e                   	push   %ds
  pushl %es
80107c08:	06                   	push   %es
  pushl %fs
80107c09:	0f a0                	push   %fs
  pushl %gs
80107c0b:	0f a8                	push   %gs
  pushal
80107c0d:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80107c0e:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80107c12:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80107c14:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80107c16:	54                   	push   %esp
  call trap
80107c17:	e8 c4 00 00 00       	call   80107ce0 <trap>
  addl $4, %esp
80107c1c:	83 c4 04             	add    $0x4,%esp

80107c1f <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80107c1f:	61                   	popa   
  popl %gs
80107c20:	0f a9                	pop    %gs
  popl %fs
80107c22:	0f a1                	pop    %fs
  popl %es
80107c24:	07                   	pop    %es
  popl %ds
80107c25:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80107c26:	83 c4 08             	add    $0x8,%esp
  iret
80107c29:	cf                   	iret   
80107c2a:	66 90                	xchg   %ax,%ax
80107c2c:	66 90                	xchg   %ax,%ax
80107c2e:	66 90                	xchg   %ax,%ax

80107c30 <tvinit>:
int global_sys_call_counter;
// P4

void
tvinit(void)
{
80107c30:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80107c31:	31 c0                	xor    %eax,%eax
{
80107c33:	89 e5                	mov    %esp,%ebp
80107c35:	83 ec 08             	sub    $0x8,%esp
80107c38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107c3f:	90                   	nop
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80107c40:	8b 14 85 a4 d3 10 80 	mov    -0x7fef2c5c(,%eax,4),%edx
80107c47:	c7 04 c5 62 a9 34 80 	movl   $0x8e000008,-0x7fcb569e(,%eax,8)
80107c4e:	08 00 00 8e 
80107c52:	66 89 14 c5 60 a9 34 	mov    %dx,-0x7fcb56a0(,%eax,8)
80107c59:	80 
80107c5a:	c1 ea 10             	shr    $0x10,%edx
80107c5d:	66 89 14 c5 66 a9 34 	mov    %dx,-0x7fcb569a(,%eax,8)
80107c64:	80 
  for(i = 0; i < 256; i++)
80107c65:	83 c0 01             	add    $0x1,%eax
80107c68:	3d 00 01 00 00       	cmp    $0x100,%eax
80107c6d:	75 d1                	jne    80107c40 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
80107c6f:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80107c72:	a1 a4 d4 10 80       	mov    0x8010d4a4,%eax
80107c77:	c7 05 62 ab 34 80 08 	movl   $0xef000008,0x8034ab62
80107c7e:	00 00 ef 
  initlock(&tickslock, "time");
80107c81:	68 62 a3 10 80       	push   $0x8010a362
80107c86:	68 20 a9 34 80       	push   $0x8034a920
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80107c8b:	66 a3 60 ab 34 80    	mov    %ax,0x8034ab60
80107c91:	c1 e8 10             	shr    $0x10,%eax
80107c94:	66 a3 66 ab 34 80    	mov    %ax,0x8034ab66
  initlock(&tickslock, "time");
80107c9a:	e8 b1 e0 ff ff       	call   80105d50 <initlock>
}
80107c9f:	83 c4 10             	add    $0x10,%esp
80107ca2:	c9                   	leave  
80107ca3:	c3                   	ret    
80107ca4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107cab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107caf:	90                   	nop

80107cb0 <idtinit>:

void
idtinit(void)
{
80107cb0:	55                   	push   %ebp
  pd[0] = size-1;
80107cb1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80107cb6:	89 e5                	mov    %esp,%ebp
80107cb8:	83 ec 10             	sub    $0x10,%esp
80107cbb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80107cbf:	b8 60 a9 34 80       	mov    $0x8034a960,%eax
80107cc4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80107cc8:	c1 e8 10             	shr    $0x10,%eax
80107ccb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80107ccf:	8d 45 fa             	lea    -0x6(%ebp),%eax
80107cd2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80107cd5:	c9                   	leave  
80107cd6:	c3                   	ret    
80107cd7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107cde:	66 90                	xchg   %ax,%ax

80107ce0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80107ce0:	55                   	push   %ebp
80107ce1:	89 e5                	mov    %esp,%ebp
80107ce3:	57                   	push   %edi
80107ce4:	56                   	push   %esi
80107ce5:	53                   	push   %ebx
80107ce6:	83 ec 1c             	sub    $0x1c,%esp
80107ce9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80107cec:	8b 43 30             	mov    0x30(%ebx),%eax
80107cef:	83 f8 40             	cmp    $0x40,%eax
80107cf2:	0f 84 98 01 00 00    	je     80107e90 <trap+0x1b0>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80107cf8:	83 e8 20             	sub    $0x20,%eax
80107cfb:	83 f8 1f             	cmp    $0x1f,%eax
80107cfe:	0f 87 8c 00 00 00    	ja     80107d90 <trap+0xb0>
80107d04:	ff 24 85 b8 a4 10 80 	jmp    *-0x7fef5b48(,%eax,4)
80107d0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107d0f:	90                   	nop
      c->slice_count++;
    }

    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80107d10:	e8 7b b4 ff ff       	call   80103190 <ideintr>
    lapiceoi();
80107d15:	e8 46 bb ff ff       	call   80103860 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107d1a:	e8 31 cc ff ff       	call   80104950 <myproc>
80107d1f:	85 c0                	test   %eax,%eax
80107d21:	74 1d                	je     80107d40 <trap+0x60>
80107d23:	e8 28 cc ff ff       	call   80104950 <myproc>
80107d28:	8b 50 24             	mov    0x24(%eax),%edx
80107d2b:	85 d2                	test   %edx,%edx
80107d2d:	74 11                	je     80107d40 <trap+0x60>
80107d2f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80107d33:	83 e0 03             	and    $0x3,%eax
80107d36:	66 83 f8 03          	cmp    $0x3,%ax
80107d3a:	0f 84 68 02 00 00    	je     80107fa8 <trap+0x2c8>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80107d40:	e8 0b cc ff ff       	call   80104950 <myproc>
80107d45:	85 c0                	test   %eax,%eax
80107d47:	74 0f                	je     80107d58 <trap+0x78>
80107d49:	e8 02 cc ff ff       	call   80104950 <myproc>
80107d4e:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80107d52:	0f 84 b8 00 00 00    	je     80107e10 <trap+0x130>
        //cprintf("Tick: Process %d is running in level %d of cpu %d\n", myproc()->pid, myproc()->sched_info.queue_level, cpuid());
        yield();
      }
    }
  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107d58:	e8 f3 cb ff ff       	call   80104950 <myproc>
80107d5d:	85 c0                	test   %eax,%eax
80107d5f:	74 1d                	je     80107d7e <trap+0x9e>
80107d61:	e8 ea cb ff ff       	call   80104950 <myproc>
80107d66:	8b 40 24             	mov    0x24(%eax),%eax
80107d69:	85 c0                	test   %eax,%eax
80107d6b:	74 11                	je     80107d7e <trap+0x9e>
80107d6d:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80107d71:	83 e0 03             	and    $0x3,%eax
80107d74:	66 83 f8 03          	cmp    $0x3,%ax
80107d78:	0f 84 9b 01 00 00    	je     80107f19 <trap+0x239>
    exit();
}
80107d7e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107d81:	5b                   	pop    %ebx
80107d82:	5e                   	pop    %esi
80107d83:	5f                   	pop    %edi
80107d84:	5d                   	pop    %ebp
80107d85:	c3                   	ret    
80107d86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107d8d:	8d 76 00             	lea    0x0(%esi),%esi
    if(myproc() == 0 || (tf->cs&3) == 0){
80107d90:	e8 bb cb ff ff       	call   80104950 <myproc>
80107d95:	8b 7b 38             	mov    0x38(%ebx),%edi
80107d98:	85 c0                	test   %eax,%eax
80107d9a:	0f 84 67 03 00 00    	je     80108107 <trap+0x427>
80107da0:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80107da4:	0f 84 5d 03 00 00    	je     80108107 <trap+0x427>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80107daa:	0f 20 d1             	mov    %cr2,%ecx
80107dad:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80107db0:	e8 7b cb ff ff       	call   80104930 <cpuid>
80107db5:	8b 73 30             	mov    0x30(%ebx),%esi
80107db8:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107dbb:	8b 43 34             	mov    0x34(%ebx),%eax
80107dbe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80107dc1:	e8 8a cb ff ff       	call   80104950 <myproc>
80107dc6:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107dc9:	e8 82 cb ff ff       	call   80104950 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80107dce:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80107dd1:	8b 55 dc             	mov    -0x24(%ebp),%edx
80107dd4:	51                   	push   %ecx
80107dd5:	57                   	push   %edi
80107dd6:	52                   	push   %edx
80107dd7:	ff 75 e4             	push   -0x1c(%ebp)
80107dda:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80107ddb:	8b 75 e0             	mov    -0x20(%ebp),%esi
80107dde:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80107de1:	56                   	push   %esi
80107de2:	ff 70 10             	push   0x10(%eax)
80107de5:	68 74 a4 10 80       	push   $0x8010a474
80107dea:	e8 01 8a ff ff       	call   801007f0 <cprintf>
    myproc()->killed = 1;
80107def:	83 c4 20             	add    $0x20,%esp
80107df2:	e8 59 cb ff ff       	call   80104950 <myproc>
80107df7:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107dfe:	e8 4d cb ff ff       	call   80104950 <myproc>
80107e03:	85 c0                	test   %eax,%eax
80107e05:	0f 85 18 ff ff ff    	jne    80107d23 <trap+0x43>
80107e0b:	e9 30 ff ff ff       	jmp    80107d40 <trap+0x60>
  if(myproc() && myproc()->state == RUNNING &&
80107e10:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80107e14:	0f 85 3e ff ff ff    	jne    80107d58 <trap+0x78>
      myproc()->sched_info.consecutive_run++;
80107e1a:	e8 31 cb ff ff       	call   80104950 <myproc>
80107e1f:	83 80 2c 8d 00 00 01 	addl   $0x1,0x8d2c(%eax)
      if (myproc()->sched_info.queue_level == ROUND_ROBIN)
80107e26:	e8 25 cb ff ff       	call   80104950 <myproc>
80107e2b:	83 b8 20 8d 00 00 01 	cmpl   $0x1,0x8d20(%eax)
80107e32:	0f 84 b8 02 00 00    	je     801080f0 <trap+0x410>
        myproc()->sched_info.consecutive_run = 0;
80107e38:	e8 13 cb ff ff       	call   80104950 <myproc>
80107e3d:	c7 80 2c 8d 00 00 00 	movl   $0x0,0x8d2c(%eax)
80107e44:	00 00 00 
        yield();
80107e47:	e8 74 d1 ff ff       	call   80104fc0 <yield>
80107e4c:	e9 07 ff ff ff       	jmp    80107d58 <trap+0x78>
80107e51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80107e58:	8b 7b 38             	mov    0x38(%ebx),%edi
80107e5b:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80107e5f:	e8 cc ca ff ff       	call   80104930 <cpuid>
80107e64:	57                   	push   %edi
80107e65:	56                   	push   %esi
80107e66:	50                   	push   %eax
80107e67:	68 1c a4 10 80       	push   $0x8010a41c
80107e6c:	e8 7f 89 ff ff       	call   801007f0 <cprintf>
    lapiceoi();
80107e71:	e8 ea b9 ff ff       	call   80103860 <lapiceoi>
    break;
80107e76:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107e79:	e8 d2 ca ff ff       	call   80104950 <myproc>
80107e7e:	85 c0                	test   %eax,%eax
80107e80:	0f 85 9d fe ff ff    	jne    80107d23 <trap+0x43>
80107e86:	e9 b5 fe ff ff       	jmp    80107d40 <trap+0x60>
80107e8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107e8f:	90                   	nop
    if(myproc()->killed)
80107e90:	e8 bb ca ff ff       	call   80104950 <myproc>
80107e95:	8b 70 24             	mov    0x24(%eax),%esi
80107e98:	85 f6                	test   %esi,%esi
80107e9a:	0f 85 28 02 00 00    	jne    801080c8 <trap+0x3e8>
    myproc()->tf = tf;
80107ea0:	e8 ab ca ff ff       	call   80104950 <myproc>
80107ea5:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80107ea8:	e8 b3 e7 ff ff       	call   80106660 <syscall>
    int id = tf->eax;
80107ead:	8b 43 1c             	mov    0x1c(%ebx),%eax
    switch (id)
80107eb0:	83 f8 0f             	cmp    $0xf,%eax
80107eb3:	0f 84 bf 01 00 00    	je     80108078 <trap+0x398>
80107eb9:	83 f8 10             	cmp    $0x10,%eax
80107ebc:	0f 84 66 01 00 00    	je     80108028 <trap+0x348>
        acquire(&syscall_counter_each_cpu);
80107ec2:	83 ec 0c             	sub    $0xc,%esp
80107ec5:	68 a0 a8 34 80       	push   $0x8034a8a0
80107eca:	e8 51 e0 ff ff       	call   80105f20 <acquire>
        mycpu()->sys_call_counter += 1;
80107ecf:	e8 fc c9 ff ff       	call   801048d0 <mycpu>
80107ed4:	83 80 b8 00 00 00 01 	addl   $0x1,0xb8(%eax)
        release(&syscall_counter_each_cpu);
80107edb:	c7 04 24 a0 a8 34 80 	movl   $0x8034a8a0,(%esp)
80107ee2:	e8 d9 df ff ff       	call   80105ec0 <release>
        acquire(&syscall_counter_lock);
80107ee7:	c7 04 24 e0 a8 34 80 	movl   $0x8034a8e0,(%esp)
80107eee:	e8 2d e0 ff ff       	call   80105f20 <acquire>
        release(&syscall_counter_lock);
80107ef3:	c7 04 24 e0 a8 34 80 	movl   $0x8034a8e0,(%esp)
        global_sys_call_counter += 1;
80107efa:	83 05 80 a8 34 80 01 	addl   $0x1,0x8034a880
        release(&syscall_counter_lock);
80107f01:	e8 ba df ff ff       	call   80105ec0 <release>
        break;
80107f06:	83 c4 10             	add    $0x10,%esp
    if(myproc()->killed)
80107f09:	e8 42 ca ff ff       	call   80104950 <myproc>
80107f0e:	8b 48 24             	mov    0x24(%eax),%ecx
80107f11:	85 c9                	test   %ecx,%ecx
80107f13:	0f 84 65 fe ff ff    	je     80107d7e <trap+0x9e>
}
80107f19:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107f1c:	5b                   	pop    %ebx
80107f1d:	5e                   	pop    %esi
80107f1e:	5f                   	pop    %edi
80107f1f:	5d                   	pop    %ebp
      exit();
80107f20:	e9 3b ce ff ff       	jmp    80104d60 <exit>
80107f25:	8d 76 00             	lea    0x0(%esi),%esi
    uartintr();
80107f28:	e8 73 03 00 00       	call   801082a0 <uartintr>
    lapiceoi();
80107f2d:	e8 2e b9 ff ff       	call   80103860 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107f32:	e8 19 ca ff ff       	call   80104950 <myproc>
80107f37:	85 c0                	test   %eax,%eax
80107f39:	0f 85 e4 fd ff ff    	jne    80107d23 <trap+0x43>
80107f3f:	e9 fc fd ff ff       	jmp    80107d40 <trap+0x60>
80107f44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80107f48:	e8 d3 b7 ff ff       	call   80103720 <kbdintr>
    lapiceoi();
80107f4d:	e8 0e b9 ff ff       	call   80103860 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107f52:	e8 f9 c9 ff ff       	call   80104950 <myproc>
80107f57:	85 c0                	test   %eax,%eax
80107f59:	0f 85 c4 fd ff ff    	jne    80107d23 <trap+0x43>
80107f5f:	e9 dc fd ff ff       	jmp    80107d40 <trap+0x60>
80107f64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80107f68:	e8 c3 c9 ff ff       	call   80104930 <cpuid>
80107f6d:	85 c0                	test   %eax,%eax
80107f6f:	74 7f                	je     80107ff0 <trap+0x310>
    lapiceoi();
80107f71:	e8 ea b8 ff ff       	call   80103860 <lapiceoi>
    struct cpu* c = mycpu();
80107f76:	e8 55 c9 ff ff       	call   801048d0 <mycpu>
    if (c->current_queue == ROUND_ROBIN && c->slice_count == 30)
80107f7b:	8b 48 04             	mov    0x4(%eax),%ecx
80107f7e:	8b 10                	mov    (%eax),%edx
80107f80:	83 f9 01             	cmp    $0x1,%ecx
80107f83:	74 4b                	je     80107fd0 <trap+0x2f0>
    else if (c->current_queue == SJF && c->slice_count == 20)
80107f85:	83 f9 02             	cmp    $0x2,%ecx
80107f88:	74 2e                	je     80107fb8 <trap+0x2d8>
    else if (c->current_queue == FCFS && c->slice_count == 10)
80107f8a:	83 f9 03             	cmp    $0x3,%ecx
80107f8d:	75 09                	jne    80107f98 <trap+0x2b8>
80107f8f:	83 fa 0a             	cmp    $0xa,%edx
80107f92:	0f 84 40 01 00 00    	je     801080d8 <trap+0x3f8>
      c->slice_count++;
80107f98:	83 c2 01             	add    $0x1,%edx
80107f9b:	89 10                	mov    %edx,(%eax)
80107f9d:	e9 78 fd ff ff       	jmp    80107d1a <trap+0x3a>
80107fa2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
80107fa8:	e8 b3 cd ff ff       	call   80104d60 <exit>
80107fad:	e9 8e fd ff ff       	jmp    80107d40 <trap+0x60>
80107fb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    else if (c->current_queue == SJF && c->slice_count == 20)
80107fb8:	83 fa 14             	cmp    $0x14,%edx
80107fbb:	75 db                	jne    80107f98 <trap+0x2b8>
      c->current_queue = FCFS;
80107fbd:	c7 40 04 03 00 00 00 	movl   $0x3,0x4(%eax)
      c->slice_count = 0;
80107fc4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80107fca:	e9 4b fd ff ff       	jmp    80107d1a <trap+0x3a>
80107fcf:	90                   	nop
    if (c->current_queue == ROUND_ROBIN && c->slice_count == 30)
80107fd0:	83 fa 1e             	cmp    $0x1e,%edx
80107fd3:	75 c3                	jne    80107f98 <trap+0x2b8>
      c->current_queue = SJF;
80107fd5:	c7 40 04 02 00 00 00 	movl   $0x2,0x4(%eax)
      c->slice_count = 0;
80107fdc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80107fe2:	e9 33 fd ff ff       	jmp    80107d1a <trap+0x3a>
80107fe7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107fee:	66 90                	xchg   %ax,%ax
      acquire(&tickslock);
80107ff0:	83 ec 0c             	sub    $0xc,%esp
80107ff3:	68 20 a9 34 80       	push   $0x8034a920
80107ff8:	e8 23 df ff ff       	call   80105f20 <acquire>
      wakeup(&ticks);
80107ffd:	c7 04 24 84 a8 34 80 	movl   $0x8034a884,(%esp)
      ticks++;
80108004:	83 05 84 a8 34 80 01 	addl   $0x1,0x8034a884
      wakeup(&ticks);
8010800b:	e8 e0 d0 ff ff       	call   801050f0 <wakeup>
      release(&tickslock);
80108010:	c7 04 24 20 a9 34 80 	movl   $0x8034a920,(%esp)
80108017:	e8 a4 de ff ff       	call   80105ec0 <release>
8010801c:	83 c4 10             	add    $0x10,%esp
8010801f:	e9 4d ff ff ff       	jmp    80107f71 <trap+0x291>
80108024:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        acquire(&syscall_counter_each_cpu);
80108028:	83 ec 0c             	sub    $0xc,%esp
8010802b:	68 a0 a8 34 80       	push   $0x8034a8a0
80108030:	e8 eb de ff ff       	call   80105f20 <acquire>
        mycpu()->sys_call_counter += 2;
80108035:	e8 96 c8 ff ff       	call   801048d0 <mycpu>
8010803a:	83 80 b8 00 00 00 02 	addl   $0x2,0xb8(%eax)
        release(&syscall_counter_each_cpu);
80108041:	c7 04 24 a0 a8 34 80 	movl   $0x8034a8a0,(%esp)
80108048:	e8 73 de ff ff       	call   80105ec0 <release>
        acquire(&syscall_counter_lock);
8010804d:	c7 04 24 e0 a8 34 80 	movl   $0x8034a8e0,(%esp)
80108054:	e8 c7 de ff ff       	call   80105f20 <acquire>
        release(&syscall_counter_lock);
80108059:	c7 04 24 e0 a8 34 80 	movl   $0x8034a8e0,(%esp)
        global_sys_call_counter += 2;
80108060:	83 05 80 a8 34 80 02 	addl   $0x2,0x8034a880
        release(&syscall_counter_lock);
80108067:	e8 54 de ff ff       	call   80105ec0 <release>
        break;
8010806c:	83 c4 10             	add    $0x10,%esp
8010806f:	e9 95 fe ff ff       	jmp    80107f09 <trap+0x229>
80108074:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        acquire(&syscall_counter_each_cpu);
80108078:	83 ec 0c             	sub    $0xc,%esp
8010807b:	68 a0 a8 34 80       	push   $0x8034a8a0
80108080:	e8 9b de ff ff       	call   80105f20 <acquire>
        mycpu()->sys_call_counter += 3;
80108085:	e8 46 c8 ff ff       	call   801048d0 <mycpu>
8010808a:	83 80 b8 00 00 00 03 	addl   $0x3,0xb8(%eax)
        release(&syscall_counter_each_cpu);
80108091:	c7 04 24 a0 a8 34 80 	movl   $0x8034a8a0,(%esp)
80108098:	e8 23 de ff ff       	call   80105ec0 <release>
        acquire(&syscall_counter_lock);
8010809d:	c7 04 24 e0 a8 34 80 	movl   $0x8034a8e0,(%esp)
801080a4:	e8 77 de ff ff       	call   80105f20 <acquire>
        release(&syscall_counter_lock);
801080a9:	c7 04 24 e0 a8 34 80 	movl   $0x8034a8e0,(%esp)
        global_sys_call_counter += 3;
801080b0:	83 05 80 a8 34 80 03 	addl   $0x3,0x8034a880
        release(&syscall_counter_lock);
801080b7:	e8 04 de ff ff       	call   80105ec0 <release>
        break;
801080bc:	83 c4 10             	add    $0x10,%esp
801080bf:	e9 45 fe ff ff       	jmp    80107f09 <trap+0x229>
801080c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      exit();
801080c8:	e8 93 cc ff ff       	call   80104d60 <exit>
801080cd:	e9 ce fd ff ff       	jmp    80107ea0 <trap+0x1c0>
801080d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      c->current_queue = ROUND_ROBIN;
801080d8:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
      c->slice_count = 0;
801080df:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801080e5:	e9 30 fc ff ff       	jmp    80107d1a <trap+0x3a>
801080ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        if(myproc()->sched_info.consecutive_run == 5)
801080f0:	e8 5b c8 ff ff       	call   80104950 <myproc>
801080f5:	83 b8 2c 8d 00 00 05 	cmpl   $0x5,0x8d2c(%eax)
801080fc:	0f 85 56 fc ff ff    	jne    80107d58 <trap+0x78>
80108102:	e9 31 fd ff ff       	jmp    80107e38 <trap+0x158>
80108107:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
8010810a:	e8 21 c8 ff ff       	call   80104930 <cpuid>
8010810f:	83 ec 0c             	sub    $0xc,%esp
80108112:	56                   	push   %esi
80108113:	57                   	push   %edi
80108114:	50                   	push   %eax
80108115:	ff 73 30             	push   0x30(%ebx)
80108118:	68 40 a4 10 80       	push   $0x8010a440
8010811d:	e8 ce 86 ff ff       	call   801007f0 <cprintf>
      panic("trap");
80108122:	83 c4 14             	add    $0x14,%esp
80108125:	68 14 a4 10 80       	push   $0x8010a414
8010812a:	e8 a1 83 ff ff       	call   801004d0 <panic>
8010812f:	90                   	nop

80108130 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80108130:	a1 60 b1 34 80       	mov    0x8034b160,%eax
80108135:	85 c0                	test   %eax,%eax
80108137:	74 17                	je     80108150 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80108139:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010813e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
8010813f:	a8 01                	test   $0x1,%al
80108141:	74 0d                	je     80108150 <uartgetc+0x20>
80108143:	ba f8 03 00 00       	mov    $0x3f8,%edx
80108148:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80108149:	0f b6 c0             	movzbl %al,%eax
8010814c:	c3                   	ret    
8010814d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80108150:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80108155:	c3                   	ret    
80108156:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010815d:	8d 76 00             	lea    0x0(%esi),%esi

80108160 <uartinit>:
{
80108160:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80108161:	31 c9                	xor    %ecx,%ecx
80108163:	89 c8                	mov    %ecx,%eax
80108165:	89 e5                	mov    %esp,%ebp
80108167:	57                   	push   %edi
80108168:	bf fa 03 00 00       	mov    $0x3fa,%edi
8010816d:	56                   	push   %esi
8010816e:	89 fa                	mov    %edi,%edx
80108170:	53                   	push   %ebx
80108171:	83 ec 1c             	sub    $0x1c,%esp
80108174:	ee                   	out    %al,(%dx)
80108175:	be fb 03 00 00       	mov    $0x3fb,%esi
8010817a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010817f:	89 f2                	mov    %esi,%edx
80108181:	ee                   	out    %al,(%dx)
80108182:	b8 0c 00 00 00       	mov    $0xc,%eax
80108187:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010818c:	ee                   	out    %al,(%dx)
8010818d:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80108192:	89 c8                	mov    %ecx,%eax
80108194:	89 da                	mov    %ebx,%edx
80108196:	ee                   	out    %al,(%dx)
80108197:	b8 03 00 00 00       	mov    $0x3,%eax
8010819c:	89 f2                	mov    %esi,%edx
8010819e:	ee                   	out    %al,(%dx)
8010819f:	ba fc 03 00 00       	mov    $0x3fc,%edx
801081a4:	89 c8                	mov    %ecx,%eax
801081a6:	ee                   	out    %al,(%dx)
801081a7:	b8 01 00 00 00       	mov    $0x1,%eax
801081ac:	89 da                	mov    %ebx,%edx
801081ae:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801081af:	ba fd 03 00 00       	mov    $0x3fd,%edx
801081b4:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
801081b5:	3c ff                	cmp    $0xff,%al
801081b7:	74 78                	je     80108231 <uartinit+0xd1>
  uart = 1;
801081b9:	c7 05 60 b1 34 80 01 	movl   $0x1,0x8034b160
801081c0:	00 00 00 
801081c3:	89 fa                	mov    %edi,%edx
801081c5:	ec                   	in     (%dx),%al
801081c6:	ba f8 03 00 00       	mov    $0x3f8,%edx
801081cb:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
801081cc:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
801081cf:	bf 38 a5 10 80       	mov    $0x8010a538,%edi
801081d4:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
801081d9:	6a 00                	push   $0x0
801081db:	6a 04                	push   $0x4
801081dd:	e8 ee b1 ff ff       	call   801033d0 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
801081e2:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
  ioapicenable(IRQ_COM1, 0);
801081e6:	83 c4 10             	add    $0x10,%esp
801081e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(!uart)
801081f0:	a1 60 b1 34 80       	mov    0x8034b160,%eax
801081f5:	bb 80 00 00 00       	mov    $0x80,%ebx
801081fa:	85 c0                	test   %eax,%eax
801081fc:	75 14                	jne    80108212 <uartinit+0xb2>
801081fe:	eb 23                	jmp    80108223 <uartinit+0xc3>
    microdelay(10);
80108200:	83 ec 0c             	sub    $0xc,%esp
80108203:	6a 0a                	push   $0xa
80108205:	e8 76 b6 ff ff       	call   80103880 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010820a:	83 c4 10             	add    $0x10,%esp
8010820d:	83 eb 01             	sub    $0x1,%ebx
80108210:	74 07                	je     80108219 <uartinit+0xb9>
80108212:	89 f2                	mov    %esi,%edx
80108214:	ec                   	in     (%dx),%al
80108215:	a8 20                	test   $0x20,%al
80108217:	74 e7                	je     80108200 <uartinit+0xa0>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80108219:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
8010821d:	ba f8 03 00 00       	mov    $0x3f8,%edx
80108222:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
80108223:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80108227:	83 c7 01             	add    $0x1,%edi
8010822a:	88 45 e7             	mov    %al,-0x19(%ebp)
8010822d:	84 c0                	test   %al,%al
8010822f:	75 bf                	jne    801081f0 <uartinit+0x90>
}
80108231:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108234:	5b                   	pop    %ebx
80108235:	5e                   	pop    %esi
80108236:	5f                   	pop    %edi
80108237:	5d                   	pop    %ebp
80108238:	c3                   	ret    
80108239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80108240 <uartputc>:
  if(!uart)
80108240:	a1 60 b1 34 80       	mov    0x8034b160,%eax
80108245:	85 c0                	test   %eax,%eax
80108247:	74 47                	je     80108290 <uartputc+0x50>
{
80108249:	55                   	push   %ebp
8010824a:	89 e5                	mov    %esp,%ebp
8010824c:	56                   	push   %esi
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010824d:	be fd 03 00 00       	mov    $0x3fd,%esi
80108252:	53                   	push   %ebx
80108253:	bb 80 00 00 00       	mov    $0x80,%ebx
80108258:	eb 18                	jmp    80108272 <uartputc+0x32>
8010825a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
80108260:	83 ec 0c             	sub    $0xc,%esp
80108263:	6a 0a                	push   $0xa
80108265:	e8 16 b6 ff ff       	call   80103880 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010826a:	83 c4 10             	add    $0x10,%esp
8010826d:	83 eb 01             	sub    $0x1,%ebx
80108270:	74 07                	je     80108279 <uartputc+0x39>
80108272:	89 f2                	mov    %esi,%edx
80108274:	ec                   	in     (%dx),%al
80108275:	a8 20                	test   $0x20,%al
80108277:	74 e7                	je     80108260 <uartputc+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80108279:	8b 45 08             	mov    0x8(%ebp),%eax
8010827c:	ba f8 03 00 00       	mov    $0x3f8,%edx
80108281:	ee                   	out    %al,(%dx)
}
80108282:	8d 65 f8             	lea    -0x8(%ebp),%esp
80108285:	5b                   	pop    %ebx
80108286:	5e                   	pop    %esi
80108287:	5d                   	pop    %ebp
80108288:	c3                   	ret    
80108289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108290:	c3                   	ret    
80108291:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108298:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010829f:	90                   	nop

801082a0 <uartintr>:

void
uartintr(void)
{
801082a0:	55                   	push   %ebp
801082a1:	89 e5                	mov    %esp,%ebp
801082a3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
801082a6:	68 30 81 10 80       	push   $0x80108130
801082ab:	e8 90 8c ff ff       	call   80100f40 <consoleintr>
}
801082b0:	83 c4 10             	add    $0x10,%esp
801082b3:	c9                   	leave  
801082b4:	c3                   	ret    

801082b5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
801082b5:	6a 00                	push   $0x0
  pushl $0
801082b7:	6a 00                	push   $0x0
  jmp alltraps
801082b9:	e9 49 f9 ff ff       	jmp    80107c07 <alltraps>

801082be <vector1>:
.globl vector1
vector1:
  pushl $0
801082be:	6a 00                	push   $0x0
  pushl $1
801082c0:	6a 01                	push   $0x1
  jmp alltraps
801082c2:	e9 40 f9 ff ff       	jmp    80107c07 <alltraps>

801082c7 <vector2>:
.globl vector2
vector2:
  pushl $0
801082c7:	6a 00                	push   $0x0
  pushl $2
801082c9:	6a 02                	push   $0x2
  jmp alltraps
801082cb:	e9 37 f9 ff ff       	jmp    80107c07 <alltraps>

801082d0 <vector3>:
.globl vector3
vector3:
  pushl $0
801082d0:	6a 00                	push   $0x0
  pushl $3
801082d2:	6a 03                	push   $0x3
  jmp alltraps
801082d4:	e9 2e f9 ff ff       	jmp    80107c07 <alltraps>

801082d9 <vector4>:
.globl vector4
vector4:
  pushl $0
801082d9:	6a 00                	push   $0x0
  pushl $4
801082db:	6a 04                	push   $0x4
  jmp alltraps
801082dd:	e9 25 f9 ff ff       	jmp    80107c07 <alltraps>

801082e2 <vector5>:
.globl vector5
vector5:
  pushl $0
801082e2:	6a 00                	push   $0x0
  pushl $5
801082e4:	6a 05                	push   $0x5
  jmp alltraps
801082e6:	e9 1c f9 ff ff       	jmp    80107c07 <alltraps>

801082eb <vector6>:
.globl vector6
vector6:
  pushl $0
801082eb:	6a 00                	push   $0x0
  pushl $6
801082ed:	6a 06                	push   $0x6
  jmp alltraps
801082ef:	e9 13 f9 ff ff       	jmp    80107c07 <alltraps>

801082f4 <vector7>:
.globl vector7
vector7:
  pushl $0
801082f4:	6a 00                	push   $0x0
  pushl $7
801082f6:	6a 07                	push   $0x7
  jmp alltraps
801082f8:	e9 0a f9 ff ff       	jmp    80107c07 <alltraps>

801082fd <vector8>:
.globl vector8
vector8:
  pushl $8
801082fd:	6a 08                	push   $0x8
  jmp alltraps
801082ff:	e9 03 f9 ff ff       	jmp    80107c07 <alltraps>

80108304 <vector9>:
.globl vector9
vector9:
  pushl $0
80108304:	6a 00                	push   $0x0
  pushl $9
80108306:	6a 09                	push   $0x9
  jmp alltraps
80108308:	e9 fa f8 ff ff       	jmp    80107c07 <alltraps>

8010830d <vector10>:
.globl vector10
vector10:
  pushl $10
8010830d:	6a 0a                	push   $0xa
  jmp alltraps
8010830f:	e9 f3 f8 ff ff       	jmp    80107c07 <alltraps>

80108314 <vector11>:
.globl vector11
vector11:
  pushl $11
80108314:	6a 0b                	push   $0xb
  jmp alltraps
80108316:	e9 ec f8 ff ff       	jmp    80107c07 <alltraps>

8010831b <vector12>:
.globl vector12
vector12:
  pushl $12
8010831b:	6a 0c                	push   $0xc
  jmp alltraps
8010831d:	e9 e5 f8 ff ff       	jmp    80107c07 <alltraps>

80108322 <vector13>:
.globl vector13
vector13:
  pushl $13
80108322:	6a 0d                	push   $0xd
  jmp alltraps
80108324:	e9 de f8 ff ff       	jmp    80107c07 <alltraps>

80108329 <vector14>:
.globl vector14
vector14:
  pushl $14
80108329:	6a 0e                	push   $0xe
  jmp alltraps
8010832b:	e9 d7 f8 ff ff       	jmp    80107c07 <alltraps>

80108330 <vector15>:
.globl vector15
vector15:
  pushl $0
80108330:	6a 00                	push   $0x0
  pushl $15
80108332:	6a 0f                	push   $0xf
  jmp alltraps
80108334:	e9 ce f8 ff ff       	jmp    80107c07 <alltraps>

80108339 <vector16>:
.globl vector16
vector16:
  pushl $0
80108339:	6a 00                	push   $0x0
  pushl $16
8010833b:	6a 10                	push   $0x10
  jmp alltraps
8010833d:	e9 c5 f8 ff ff       	jmp    80107c07 <alltraps>

80108342 <vector17>:
.globl vector17
vector17:
  pushl $17
80108342:	6a 11                	push   $0x11
  jmp alltraps
80108344:	e9 be f8 ff ff       	jmp    80107c07 <alltraps>

80108349 <vector18>:
.globl vector18
vector18:
  pushl $0
80108349:	6a 00                	push   $0x0
  pushl $18
8010834b:	6a 12                	push   $0x12
  jmp alltraps
8010834d:	e9 b5 f8 ff ff       	jmp    80107c07 <alltraps>

80108352 <vector19>:
.globl vector19
vector19:
  pushl $0
80108352:	6a 00                	push   $0x0
  pushl $19
80108354:	6a 13                	push   $0x13
  jmp alltraps
80108356:	e9 ac f8 ff ff       	jmp    80107c07 <alltraps>

8010835b <vector20>:
.globl vector20
vector20:
  pushl $0
8010835b:	6a 00                	push   $0x0
  pushl $20
8010835d:	6a 14                	push   $0x14
  jmp alltraps
8010835f:	e9 a3 f8 ff ff       	jmp    80107c07 <alltraps>

80108364 <vector21>:
.globl vector21
vector21:
  pushl $0
80108364:	6a 00                	push   $0x0
  pushl $21
80108366:	6a 15                	push   $0x15
  jmp alltraps
80108368:	e9 9a f8 ff ff       	jmp    80107c07 <alltraps>

8010836d <vector22>:
.globl vector22
vector22:
  pushl $0
8010836d:	6a 00                	push   $0x0
  pushl $22
8010836f:	6a 16                	push   $0x16
  jmp alltraps
80108371:	e9 91 f8 ff ff       	jmp    80107c07 <alltraps>

80108376 <vector23>:
.globl vector23
vector23:
  pushl $0
80108376:	6a 00                	push   $0x0
  pushl $23
80108378:	6a 17                	push   $0x17
  jmp alltraps
8010837a:	e9 88 f8 ff ff       	jmp    80107c07 <alltraps>

8010837f <vector24>:
.globl vector24
vector24:
  pushl $0
8010837f:	6a 00                	push   $0x0
  pushl $24
80108381:	6a 18                	push   $0x18
  jmp alltraps
80108383:	e9 7f f8 ff ff       	jmp    80107c07 <alltraps>

80108388 <vector25>:
.globl vector25
vector25:
  pushl $0
80108388:	6a 00                	push   $0x0
  pushl $25
8010838a:	6a 19                	push   $0x19
  jmp alltraps
8010838c:	e9 76 f8 ff ff       	jmp    80107c07 <alltraps>

80108391 <vector26>:
.globl vector26
vector26:
  pushl $0
80108391:	6a 00                	push   $0x0
  pushl $26
80108393:	6a 1a                	push   $0x1a
  jmp alltraps
80108395:	e9 6d f8 ff ff       	jmp    80107c07 <alltraps>

8010839a <vector27>:
.globl vector27
vector27:
  pushl $0
8010839a:	6a 00                	push   $0x0
  pushl $27
8010839c:	6a 1b                	push   $0x1b
  jmp alltraps
8010839e:	e9 64 f8 ff ff       	jmp    80107c07 <alltraps>

801083a3 <vector28>:
.globl vector28
vector28:
  pushl $0
801083a3:	6a 00                	push   $0x0
  pushl $28
801083a5:	6a 1c                	push   $0x1c
  jmp alltraps
801083a7:	e9 5b f8 ff ff       	jmp    80107c07 <alltraps>

801083ac <vector29>:
.globl vector29
vector29:
  pushl $0
801083ac:	6a 00                	push   $0x0
  pushl $29
801083ae:	6a 1d                	push   $0x1d
  jmp alltraps
801083b0:	e9 52 f8 ff ff       	jmp    80107c07 <alltraps>

801083b5 <vector30>:
.globl vector30
vector30:
  pushl $0
801083b5:	6a 00                	push   $0x0
  pushl $30
801083b7:	6a 1e                	push   $0x1e
  jmp alltraps
801083b9:	e9 49 f8 ff ff       	jmp    80107c07 <alltraps>

801083be <vector31>:
.globl vector31
vector31:
  pushl $0
801083be:	6a 00                	push   $0x0
  pushl $31
801083c0:	6a 1f                	push   $0x1f
  jmp alltraps
801083c2:	e9 40 f8 ff ff       	jmp    80107c07 <alltraps>

801083c7 <vector32>:
.globl vector32
vector32:
  pushl $0
801083c7:	6a 00                	push   $0x0
  pushl $32
801083c9:	6a 20                	push   $0x20
  jmp alltraps
801083cb:	e9 37 f8 ff ff       	jmp    80107c07 <alltraps>

801083d0 <vector33>:
.globl vector33
vector33:
  pushl $0
801083d0:	6a 00                	push   $0x0
  pushl $33
801083d2:	6a 21                	push   $0x21
  jmp alltraps
801083d4:	e9 2e f8 ff ff       	jmp    80107c07 <alltraps>

801083d9 <vector34>:
.globl vector34
vector34:
  pushl $0
801083d9:	6a 00                	push   $0x0
  pushl $34
801083db:	6a 22                	push   $0x22
  jmp alltraps
801083dd:	e9 25 f8 ff ff       	jmp    80107c07 <alltraps>

801083e2 <vector35>:
.globl vector35
vector35:
  pushl $0
801083e2:	6a 00                	push   $0x0
  pushl $35
801083e4:	6a 23                	push   $0x23
  jmp alltraps
801083e6:	e9 1c f8 ff ff       	jmp    80107c07 <alltraps>

801083eb <vector36>:
.globl vector36
vector36:
  pushl $0
801083eb:	6a 00                	push   $0x0
  pushl $36
801083ed:	6a 24                	push   $0x24
  jmp alltraps
801083ef:	e9 13 f8 ff ff       	jmp    80107c07 <alltraps>

801083f4 <vector37>:
.globl vector37
vector37:
  pushl $0
801083f4:	6a 00                	push   $0x0
  pushl $37
801083f6:	6a 25                	push   $0x25
  jmp alltraps
801083f8:	e9 0a f8 ff ff       	jmp    80107c07 <alltraps>

801083fd <vector38>:
.globl vector38
vector38:
  pushl $0
801083fd:	6a 00                	push   $0x0
  pushl $38
801083ff:	6a 26                	push   $0x26
  jmp alltraps
80108401:	e9 01 f8 ff ff       	jmp    80107c07 <alltraps>

80108406 <vector39>:
.globl vector39
vector39:
  pushl $0
80108406:	6a 00                	push   $0x0
  pushl $39
80108408:	6a 27                	push   $0x27
  jmp alltraps
8010840a:	e9 f8 f7 ff ff       	jmp    80107c07 <alltraps>

8010840f <vector40>:
.globl vector40
vector40:
  pushl $0
8010840f:	6a 00                	push   $0x0
  pushl $40
80108411:	6a 28                	push   $0x28
  jmp alltraps
80108413:	e9 ef f7 ff ff       	jmp    80107c07 <alltraps>

80108418 <vector41>:
.globl vector41
vector41:
  pushl $0
80108418:	6a 00                	push   $0x0
  pushl $41
8010841a:	6a 29                	push   $0x29
  jmp alltraps
8010841c:	e9 e6 f7 ff ff       	jmp    80107c07 <alltraps>

80108421 <vector42>:
.globl vector42
vector42:
  pushl $0
80108421:	6a 00                	push   $0x0
  pushl $42
80108423:	6a 2a                	push   $0x2a
  jmp alltraps
80108425:	e9 dd f7 ff ff       	jmp    80107c07 <alltraps>

8010842a <vector43>:
.globl vector43
vector43:
  pushl $0
8010842a:	6a 00                	push   $0x0
  pushl $43
8010842c:	6a 2b                	push   $0x2b
  jmp alltraps
8010842e:	e9 d4 f7 ff ff       	jmp    80107c07 <alltraps>

80108433 <vector44>:
.globl vector44
vector44:
  pushl $0
80108433:	6a 00                	push   $0x0
  pushl $44
80108435:	6a 2c                	push   $0x2c
  jmp alltraps
80108437:	e9 cb f7 ff ff       	jmp    80107c07 <alltraps>

8010843c <vector45>:
.globl vector45
vector45:
  pushl $0
8010843c:	6a 00                	push   $0x0
  pushl $45
8010843e:	6a 2d                	push   $0x2d
  jmp alltraps
80108440:	e9 c2 f7 ff ff       	jmp    80107c07 <alltraps>

80108445 <vector46>:
.globl vector46
vector46:
  pushl $0
80108445:	6a 00                	push   $0x0
  pushl $46
80108447:	6a 2e                	push   $0x2e
  jmp alltraps
80108449:	e9 b9 f7 ff ff       	jmp    80107c07 <alltraps>

8010844e <vector47>:
.globl vector47
vector47:
  pushl $0
8010844e:	6a 00                	push   $0x0
  pushl $47
80108450:	6a 2f                	push   $0x2f
  jmp alltraps
80108452:	e9 b0 f7 ff ff       	jmp    80107c07 <alltraps>

80108457 <vector48>:
.globl vector48
vector48:
  pushl $0
80108457:	6a 00                	push   $0x0
  pushl $48
80108459:	6a 30                	push   $0x30
  jmp alltraps
8010845b:	e9 a7 f7 ff ff       	jmp    80107c07 <alltraps>

80108460 <vector49>:
.globl vector49
vector49:
  pushl $0
80108460:	6a 00                	push   $0x0
  pushl $49
80108462:	6a 31                	push   $0x31
  jmp alltraps
80108464:	e9 9e f7 ff ff       	jmp    80107c07 <alltraps>

80108469 <vector50>:
.globl vector50
vector50:
  pushl $0
80108469:	6a 00                	push   $0x0
  pushl $50
8010846b:	6a 32                	push   $0x32
  jmp alltraps
8010846d:	e9 95 f7 ff ff       	jmp    80107c07 <alltraps>

80108472 <vector51>:
.globl vector51
vector51:
  pushl $0
80108472:	6a 00                	push   $0x0
  pushl $51
80108474:	6a 33                	push   $0x33
  jmp alltraps
80108476:	e9 8c f7 ff ff       	jmp    80107c07 <alltraps>

8010847b <vector52>:
.globl vector52
vector52:
  pushl $0
8010847b:	6a 00                	push   $0x0
  pushl $52
8010847d:	6a 34                	push   $0x34
  jmp alltraps
8010847f:	e9 83 f7 ff ff       	jmp    80107c07 <alltraps>

80108484 <vector53>:
.globl vector53
vector53:
  pushl $0
80108484:	6a 00                	push   $0x0
  pushl $53
80108486:	6a 35                	push   $0x35
  jmp alltraps
80108488:	e9 7a f7 ff ff       	jmp    80107c07 <alltraps>

8010848d <vector54>:
.globl vector54
vector54:
  pushl $0
8010848d:	6a 00                	push   $0x0
  pushl $54
8010848f:	6a 36                	push   $0x36
  jmp alltraps
80108491:	e9 71 f7 ff ff       	jmp    80107c07 <alltraps>

80108496 <vector55>:
.globl vector55
vector55:
  pushl $0
80108496:	6a 00                	push   $0x0
  pushl $55
80108498:	6a 37                	push   $0x37
  jmp alltraps
8010849a:	e9 68 f7 ff ff       	jmp    80107c07 <alltraps>

8010849f <vector56>:
.globl vector56
vector56:
  pushl $0
8010849f:	6a 00                	push   $0x0
  pushl $56
801084a1:	6a 38                	push   $0x38
  jmp alltraps
801084a3:	e9 5f f7 ff ff       	jmp    80107c07 <alltraps>

801084a8 <vector57>:
.globl vector57
vector57:
  pushl $0
801084a8:	6a 00                	push   $0x0
  pushl $57
801084aa:	6a 39                	push   $0x39
  jmp alltraps
801084ac:	e9 56 f7 ff ff       	jmp    80107c07 <alltraps>

801084b1 <vector58>:
.globl vector58
vector58:
  pushl $0
801084b1:	6a 00                	push   $0x0
  pushl $58
801084b3:	6a 3a                	push   $0x3a
  jmp alltraps
801084b5:	e9 4d f7 ff ff       	jmp    80107c07 <alltraps>

801084ba <vector59>:
.globl vector59
vector59:
  pushl $0
801084ba:	6a 00                	push   $0x0
  pushl $59
801084bc:	6a 3b                	push   $0x3b
  jmp alltraps
801084be:	e9 44 f7 ff ff       	jmp    80107c07 <alltraps>

801084c3 <vector60>:
.globl vector60
vector60:
  pushl $0
801084c3:	6a 00                	push   $0x0
  pushl $60
801084c5:	6a 3c                	push   $0x3c
  jmp alltraps
801084c7:	e9 3b f7 ff ff       	jmp    80107c07 <alltraps>

801084cc <vector61>:
.globl vector61
vector61:
  pushl $0
801084cc:	6a 00                	push   $0x0
  pushl $61
801084ce:	6a 3d                	push   $0x3d
  jmp alltraps
801084d0:	e9 32 f7 ff ff       	jmp    80107c07 <alltraps>

801084d5 <vector62>:
.globl vector62
vector62:
  pushl $0
801084d5:	6a 00                	push   $0x0
  pushl $62
801084d7:	6a 3e                	push   $0x3e
  jmp alltraps
801084d9:	e9 29 f7 ff ff       	jmp    80107c07 <alltraps>

801084de <vector63>:
.globl vector63
vector63:
  pushl $0
801084de:	6a 00                	push   $0x0
  pushl $63
801084e0:	6a 3f                	push   $0x3f
  jmp alltraps
801084e2:	e9 20 f7 ff ff       	jmp    80107c07 <alltraps>

801084e7 <vector64>:
.globl vector64
vector64:
  pushl $0
801084e7:	6a 00                	push   $0x0
  pushl $64
801084e9:	6a 40                	push   $0x40
  jmp alltraps
801084eb:	e9 17 f7 ff ff       	jmp    80107c07 <alltraps>

801084f0 <vector65>:
.globl vector65
vector65:
  pushl $0
801084f0:	6a 00                	push   $0x0
  pushl $65
801084f2:	6a 41                	push   $0x41
  jmp alltraps
801084f4:	e9 0e f7 ff ff       	jmp    80107c07 <alltraps>

801084f9 <vector66>:
.globl vector66
vector66:
  pushl $0
801084f9:	6a 00                	push   $0x0
  pushl $66
801084fb:	6a 42                	push   $0x42
  jmp alltraps
801084fd:	e9 05 f7 ff ff       	jmp    80107c07 <alltraps>

80108502 <vector67>:
.globl vector67
vector67:
  pushl $0
80108502:	6a 00                	push   $0x0
  pushl $67
80108504:	6a 43                	push   $0x43
  jmp alltraps
80108506:	e9 fc f6 ff ff       	jmp    80107c07 <alltraps>

8010850b <vector68>:
.globl vector68
vector68:
  pushl $0
8010850b:	6a 00                	push   $0x0
  pushl $68
8010850d:	6a 44                	push   $0x44
  jmp alltraps
8010850f:	e9 f3 f6 ff ff       	jmp    80107c07 <alltraps>

80108514 <vector69>:
.globl vector69
vector69:
  pushl $0
80108514:	6a 00                	push   $0x0
  pushl $69
80108516:	6a 45                	push   $0x45
  jmp alltraps
80108518:	e9 ea f6 ff ff       	jmp    80107c07 <alltraps>

8010851d <vector70>:
.globl vector70
vector70:
  pushl $0
8010851d:	6a 00                	push   $0x0
  pushl $70
8010851f:	6a 46                	push   $0x46
  jmp alltraps
80108521:	e9 e1 f6 ff ff       	jmp    80107c07 <alltraps>

80108526 <vector71>:
.globl vector71
vector71:
  pushl $0
80108526:	6a 00                	push   $0x0
  pushl $71
80108528:	6a 47                	push   $0x47
  jmp alltraps
8010852a:	e9 d8 f6 ff ff       	jmp    80107c07 <alltraps>

8010852f <vector72>:
.globl vector72
vector72:
  pushl $0
8010852f:	6a 00                	push   $0x0
  pushl $72
80108531:	6a 48                	push   $0x48
  jmp alltraps
80108533:	e9 cf f6 ff ff       	jmp    80107c07 <alltraps>

80108538 <vector73>:
.globl vector73
vector73:
  pushl $0
80108538:	6a 00                	push   $0x0
  pushl $73
8010853a:	6a 49                	push   $0x49
  jmp alltraps
8010853c:	e9 c6 f6 ff ff       	jmp    80107c07 <alltraps>

80108541 <vector74>:
.globl vector74
vector74:
  pushl $0
80108541:	6a 00                	push   $0x0
  pushl $74
80108543:	6a 4a                	push   $0x4a
  jmp alltraps
80108545:	e9 bd f6 ff ff       	jmp    80107c07 <alltraps>

8010854a <vector75>:
.globl vector75
vector75:
  pushl $0
8010854a:	6a 00                	push   $0x0
  pushl $75
8010854c:	6a 4b                	push   $0x4b
  jmp alltraps
8010854e:	e9 b4 f6 ff ff       	jmp    80107c07 <alltraps>

80108553 <vector76>:
.globl vector76
vector76:
  pushl $0
80108553:	6a 00                	push   $0x0
  pushl $76
80108555:	6a 4c                	push   $0x4c
  jmp alltraps
80108557:	e9 ab f6 ff ff       	jmp    80107c07 <alltraps>

8010855c <vector77>:
.globl vector77
vector77:
  pushl $0
8010855c:	6a 00                	push   $0x0
  pushl $77
8010855e:	6a 4d                	push   $0x4d
  jmp alltraps
80108560:	e9 a2 f6 ff ff       	jmp    80107c07 <alltraps>

80108565 <vector78>:
.globl vector78
vector78:
  pushl $0
80108565:	6a 00                	push   $0x0
  pushl $78
80108567:	6a 4e                	push   $0x4e
  jmp alltraps
80108569:	e9 99 f6 ff ff       	jmp    80107c07 <alltraps>

8010856e <vector79>:
.globl vector79
vector79:
  pushl $0
8010856e:	6a 00                	push   $0x0
  pushl $79
80108570:	6a 4f                	push   $0x4f
  jmp alltraps
80108572:	e9 90 f6 ff ff       	jmp    80107c07 <alltraps>

80108577 <vector80>:
.globl vector80
vector80:
  pushl $0
80108577:	6a 00                	push   $0x0
  pushl $80
80108579:	6a 50                	push   $0x50
  jmp alltraps
8010857b:	e9 87 f6 ff ff       	jmp    80107c07 <alltraps>

80108580 <vector81>:
.globl vector81
vector81:
  pushl $0
80108580:	6a 00                	push   $0x0
  pushl $81
80108582:	6a 51                	push   $0x51
  jmp alltraps
80108584:	e9 7e f6 ff ff       	jmp    80107c07 <alltraps>

80108589 <vector82>:
.globl vector82
vector82:
  pushl $0
80108589:	6a 00                	push   $0x0
  pushl $82
8010858b:	6a 52                	push   $0x52
  jmp alltraps
8010858d:	e9 75 f6 ff ff       	jmp    80107c07 <alltraps>

80108592 <vector83>:
.globl vector83
vector83:
  pushl $0
80108592:	6a 00                	push   $0x0
  pushl $83
80108594:	6a 53                	push   $0x53
  jmp alltraps
80108596:	e9 6c f6 ff ff       	jmp    80107c07 <alltraps>

8010859b <vector84>:
.globl vector84
vector84:
  pushl $0
8010859b:	6a 00                	push   $0x0
  pushl $84
8010859d:	6a 54                	push   $0x54
  jmp alltraps
8010859f:	e9 63 f6 ff ff       	jmp    80107c07 <alltraps>

801085a4 <vector85>:
.globl vector85
vector85:
  pushl $0
801085a4:	6a 00                	push   $0x0
  pushl $85
801085a6:	6a 55                	push   $0x55
  jmp alltraps
801085a8:	e9 5a f6 ff ff       	jmp    80107c07 <alltraps>

801085ad <vector86>:
.globl vector86
vector86:
  pushl $0
801085ad:	6a 00                	push   $0x0
  pushl $86
801085af:	6a 56                	push   $0x56
  jmp alltraps
801085b1:	e9 51 f6 ff ff       	jmp    80107c07 <alltraps>

801085b6 <vector87>:
.globl vector87
vector87:
  pushl $0
801085b6:	6a 00                	push   $0x0
  pushl $87
801085b8:	6a 57                	push   $0x57
  jmp alltraps
801085ba:	e9 48 f6 ff ff       	jmp    80107c07 <alltraps>

801085bf <vector88>:
.globl vector88
vector88:
  pushl $0
801085bf:	6a 00                	push   $0x0
  pushl $88
801085c1:	6a 58                	push   $0x58
  jmp alltraps
801085c3:	e9 3f f6 ff ff       	jmp    80107c07 <alltraps>

801085c8 <vector89>:
.globl vector89
vector89:
  pushl $0
801085c8:	6a 00                	push   $0x0
  pushl $89
801085ca:	6a 59                	push   $0x59
  jmp alltraps
801085cc:	e9 36 f6 ff ff       	jmp    80107c07 <alltraps>

801085d1 <vector90>:
.globl vector90
vector90:
  pushl $0
801085d1:	6a 00                	push   $0x0
  pushl $90
801085d3:	6a 5a                	push   $0x5a
  jmp alltraps
801085d5:	e9 2d f6 ff ff       	jmp    80107c07 <alltraps>

801085da <vector91>:
.globl vector91
vector91:
  pushl $0
801085da:	6a 00                	push   $0x0
  pushl $91
801085dc:	6a 5b                	push   $0x5b
  jmp alltraps
801085de:	e9 24 f6 ff ff       	jmp    80107c07 <alltraps>

801085e3 <vector92>:
.globl vector92
vector92:
  pushl $0
801085e3:	6a 00                	push   $0x0
  pushl $92
801085e5:	6a 5c                	push   $0x5c
  jmp alltraps
801085e7:	e9 1b f6 ff ff       	jmp    80107c07 <alltraps>

801085ec <vector93>:
.globl vector93
vector93:
  pushl $0
801085ec:	6a 00                	push   $0x0
  pushl $93
801085ee:	6a 5d                	push   $0x5d
  jmp alltraps
801085f0:	e9 12 f6 ff ff       	jmp    80107c07 <alltraps>

801085f5 <vector94>:
.globl vector94
vector94:
  pushl $0
801085f5:	6a 00                	push   $0x0
  pushl $94
801085f7:	6a 5e                	push   $0x5e
  jmp alltraps
801085f9:	e9 09 f6 ff ff       	jmp    80107c07 <alltraps>

801085fe <vector95>:
.globl vector95
vector95:
  pushl $0
801085fe:	6a 00                	push   $0x0
  pushl $95
80108600:	6a 5f                	push   $0x5f
  jmp alltraps
80108602:	e9 00 f6 ff ff       	jmp    80107c07 <alltraps>

80108607 <vector96>:
.globl vector96
vector96:
  pushl $0
80108607:	6a 00                	push   $0x0
  pushl $96
80108609:	6a 60                	push   $0x60
  jmp alltraps
8010860b:	e9 f7 f5 ff ff       	jmp    80107c07 <alltraps>

80108610 <vector97>:
.globl vector97
vector97:
  pushl $0
80108610:	6a 00                	push   $0x0
  pushl $97
80108612:	6a 61                	push   $0x61
  jmp alltraps
80108614:	e9 ee f5 ff ff       	jmp    80107c07 <alltraps>

80108619 <vector98>:
.globl vector98
vector98:
  pushl $0
80108619:	6a 00                	push   $0x0
  pushl $98
8010861b:	6a 62                	push   $0x62
  jmp alltraps
8010861d:	e9 e5 f5 ff ff       	jmp    80107c07 <alltraps>

80108622 <vector99>:
.globl vector99
vector99:
  pushl $0
80108622:	6a 00                	push   $0x0
  pushl $99
80108624:	6a 63                	push   $0x63
  jmp alltraps
80108626:	e9 dc f5 ff ff       	jmp    80107c07 <alltraps>

8010862b <vector100>:
.globl vector100
vector100:
  pushl $0
8010862b:	6a 00                	push   $0x0
  pushl $100
8010862d:	6a 64                	push   $0x64
  jmp alltraps
8010862f:	e9 d3 f5 ff ff       	jmp    80107c07 <alltraps>

80108634 <vector101>:
.globl vector101
vector101:
  pushl $0
80108634:	6a 00                	push   $0x0
  pushl $101
80108636:	6a 65                	push   $0x65
  jmp alltraps
80108638:	e9 ca f5 ff ff       	jmp    80107c07 <alltraps>

8010863d <vector102>:
.globl vector102
vector102:
  pushl $0
8010863d:	6a 00                	push   $0x0
  pushl $102
8010863f:	6a 66                	push   $0x66
  jmp alltraps
80108641:	e9 c1 f5 ff ff       	jmp    80107c07 <alltraps>

80108646 <vector103>:
.globl vector103
vector103:
  pushl $0
80108646:	6a 00                	push   $0x0
  pushl $103
80108648:	6a 67                	push   $0x67
  jmp alltraps
8010864a:	e9 b8 f5 ff ff       	jmp    80107c07 <alltraps>

8010864f <vector104>:
.globl vector104
vector104:
  pushl $0
8010864f:	6a 00                	push   $0x0
  pushl $104
80108651:	6a 68                	push   $0x68
  jmp alltraps
80108653:	e9 af f5 ff ff       	jmp    80107c07 <alltraps>

80108658 <vector105>:
.globl vector105
vector105:
  pushl $0
80108658:	6a 00                	push   $0x0
  pushl $105
8010865a:	6a 69                	push   $0x69
  jmp alltraps
8010865c:	e9 a6 f5 ff ff       	jmp    80107c07 <alltraps>

80108661 <vector106>:
.globl vector106
vector106:
  pushl $0
80108661:	6a 00                	push   $0x0
  pushl $106
80108663:	6a 6a                	push   $0x6a
  jmp alltraps
80108665:	e9 9d f5 ff ff       	jmp    80107c07 <alltraps>

8010866a <vector107>:
.globl vector107
vector107:
  pushl $0
8010866a:	6a 00                	push   $0x0
  pushl $107
8010866c:	6a 6b                	push   $0x6b
  jmp alltraps
8010866e:	e9 94 f5 ff ff       	jmp    80107c07 <alltraps>

80108673 <vector108>:
.globl vector108
vector108:
  pushl $0
80108673:	6a 00                	push   $0x0
  pushl $108
80108675:	6a 6c                	push   $0x6c
  jmp alltraps
80108677:	e9 8b f5 ff ff       	jmp    80107c07 <alltraps>

8010867c <vector109>:
.globl vector109
vector109:
  pushl $0
8010867c:	6a 00                	push   $0x0
  pushl $109
8010867e:	6a 6d                	push   $0x6d
  jmp alltraps
80108680:	e9 82 f5 ff ff       	jmp    80107c07 <alltraps>

80108685 <vector110>:
.globl vector110
vector110:
  pushl $0
80108685:	6a 00                	push   $0x0
  pushl $110
80108687:	6a 6e                	push   $0x6e
  jmp alltraps
80108689:	e9 79 f5 ff ff       	jmp    80107c07 <alltraps>

8010868e <vector111>:
.globl vector111
vector111:
  pushl $0
8010868e:	6a 00                	push   $0x0
  pushl $111
80108690:	6a 6f                	push   $0x6f
  jmp alltraps
80108692:	e9 70 f5 ff ff       	jmp    80107c07 <alltraps>

80108697 <vector112>:
.globl vector112
vector112:
  pushl $0
80108697:	6a 00                	push   $0x0
  pushl $112
80108699:	6a 70                	push   $0x70
  jmp alltraps
8010869b:	e9 67 f5 ff ff       	jmp    80107c07 <alltraps>

801086a0 <vector113>:
.globl vector113
vector113:
  pushl $0
801086a0:	6a 00                	push   $0x0
  pushl $113
801086a2:	6a 71                	push   $0x71
  jmp alltraps
801086a4:	e9 5e f5 ff ff       	jmp    80107c07 <alltraps>

801086a9 <vector114>:
.globl vector114
vector114:
  pushl $0
801086a9:	6a 00                	push   $0x0
  pushl $114
801086ab:	6a 72                	push   $0x72
  jmp alltraps
801086ad:	e9 55 f5 ff ff       	jmp    80107c07 <alltraps>

801086b2 <vector115>:
.globl vector115
vector115:
  pushl $0
801086b2:	6a 00                	push   $0x0
  pushl $115
801086b4:	6a 73                	push   $0x73
  jmp alltraps
801086b6:	e9 4c f5 ff ff       	jmp    80107c07 <alltraps>

801086bb <vector116>:
.globl vector116
vector116:
  pushl $0
801086bb:	6a 00                	push   $0x0
  pushl $116
801086bd:	6a 74                	push   $0x74
  jmp alltraps
801086bf:	e9 43 f5 ff ff       	jmp    80107c07 <alltraps>

801086c4 <vector117>:
.globl vector117
vector117:
  pushl $0
801086c4:	6a 00                	push   $0x0
  pushl $117
801086c6:	6a 75                	push   $0x75
  jmp alltraps
801086c8:	e9 3a f5 ff ff       	jmp    80107c07 <alltraps>

801086cd <vector118>:
.globl vector118
vector118:
  pushl $0
801086cd:	6a 00                	push   $0x0
  pushl $118
801086cf:	6a 76                	push   $0x76
  jmp alltraps
801086d1:	e9 31 f5 ff ff       	jmp    80107c07 <alltraps>

801086d6 <vector119>:
.globl vector119
vector119:
  pushl $0
801086d6:	6a 00                	push   $0x0
  pushl $119
801086d8:	6a 77                	push   $0x77
  jmp alltraps
801086da:	e9 28 f5 ff ff       	jmp    80107c07 <alltraps>

801086df <vector120>:
.globl vector120
vector120:
  pushl $0
801086df:	6a 00                	push   $0x0
  pushl $120
801086e1:	6a 78                	push   $0x78
  jmp alltraps
801086e3:	e9 1f f5 ff ff       	jmp    80107c07 <alltraps>

801086e8 <vector121>:
.globl vector121
vector121:
  pushl $0
801086e8:	6a 00                	push   $0x0
  pushl $121
801086ea:	6a 79                	push   $0x79
  jmp alltraps
801086ec:	e9 16 f5 ff ff       	jmp    80107c07 <alltraps>

801086f1 <vector122>:
.globl vector122
vector122:
  pushl $0
801086f1:	6a 00                	push   $0x0
  pushl $122
801086f3:	6a 7a                	push   $0x7a
  jmp alltraps
801086f5:	e9 0d f5 ff ff       	jmp    80107c07 <alltraps>

801086fa <vector123>:
.globl vector123
vector123:
  pushl $0
801086fa:	6a 00                	push   $0x0
  pushl $123
801086fc:	6a 7b                	push   $0x7b
  jmp alltraps
801086fe:	e9 04 f5 ff ff       	jmp    80107c07 <alltraps>

80108703 <vector124>:
.globl vector124
vector124:
  pushl $0
80108703:	6a 00                	push   $0x0
  pushl $124
80108705:	6a 7c                	push   $0x7c
  jmp alltraps
80108707:	e9 fb f4 ff ff       	jmp    80107c07 <alltraps>

8010870c <vector125>:
.globl vector125
vector125:
  pushl $0
8010870c:	6a 00                	push   $0x0
  pushl $125
8010870e:	6a 7d                	push   $0x7d
  jmp alltraps
80108710:	e9 f2 f4 ff ff       	jmp    80107c07 <alltraps>

80108715 <vector126>:
.globl vector126
vector126:
  pushl $0
80108715:	6a 00                	push   $0x0
  pushl $126
80108717:	6a 7e                	push   $0x7e
  jmp alltraps
80108719:	e9 e9 f4 ff ff       	jmp    80107c07 <alltraps>

8010871e <vector127>:
.globl vector127
vector127:
  pushl $0
8010871e:	6a 00                	push   $0x0
  pushl $127
80108720:	6a 7f                	push   $0x7f
  jmp alltraps
80108722:	e9 e0 f4 ff ff       	jmp    80107c07 <alltraps>

80108727 <vector128>:
.globl vector128
vector128:
  pushl $0
80108727:	6a 00                	push   $0x0
  pushl $128
80108729:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010872e:	e9 d4 f4 ff ff       	jmp    80107c07 <alltraps>

80108733 <vector129>:
.globl vector129
vector129:
  pushl $0
80108733:	6a 00                	push   $0x0
  pushl $129
80108735:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010873a:	e9 c8 f4 ff ff       	jmp    80107c07 <alltraps>

8010873f <vector130>:
.globl vector130
vector130:
  pushl $0
8010873f:	6a 00                	push   $0x0
  pushl $130
80108741:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80108746:	e9 bc f4 ff ff       	jmp    80107c07 <alltraps>

8010874b <vector131>:
.globl vector131
vector131:
  pushl $0
8010874b:	6a 00                	push   $0x0
  pushl $131
8010874d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80108752:	e9 b0 f4 ff ff       	jmp    80107c07 <alltraps>

80108757 <vector132>:
.globl vector132
vector132:
  pushl $0
80108757:	6a 00                	push   $0x0
  pushl $132
80108759:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010875e:	e9 a4 f4 ff ff       	jmp    80107c07 <alltraps>

80108763 <vector133>:
.globl vector133
vector133:
  pushl $0
80108763:	6a 00                	push   $0x0
  pushl $133
80108765:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010876a:	e9 98 f4 ff ff       	jmp    80107c07 <alltraps>

8010876f <vector134>:
.globl vector134
vector134:
  pushl $0
8010876f:	6a 00                	push   $0x0
  pushl $134
80108771:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80108776:	e9 8c f4 ff ff       	jmp    80107c07 <alltraps>

8010877b <vector135>:
.globl vector135
vector135:
  pushl $0
8010877b:	6a 00                	push   $0x0
  pushl $135
8010877d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80108782:	e9 80 f4 ff ff       	jmp    80107c07 <alltraps>

80108787 <vector136>:
.globl vector136
vector136:
  pushl $0
80108787:	6a 00                	push   $0x0
  pushl $136
80108789:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010878e:	e9 74 f4 ff ff       	jmp    80107c07 <alltraps>

80108793 <vector137>:
.globl vector137
vector137:
  pushl $0
80108793:	6a 00                	push   $0x0
  pushl $137
80108795:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010879a:	e9 68 f4 ff ff       	jmp    80107c07 <alltraps>

8010879f <vector138>:
.globl vector138
vector138:
  pushl $0
8010879f:	6a 00                	push   $0x0
  pushl $138
801087a1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801087a6:	e9 5c f4 ff ff       	jmp    80107c07 <alltraps>

801087ab <vector139>:
.globl vector139
vector139:
  pushl $0
801087ab:	6a 00                	push   $0x0
  pushl $139
801087ad:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801087b2:	e9 50 f4 ff ff       	jmp    80107c07 <alltraps>

801087b7 <vector140>:
.globl vector140
vector140:
  pushl $0
801087b7:	6a 00                	push   $0x0
  pushl $140
801087b9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801087be:	e9 44 f4 ff ff       	jmp    80107c07 <alltraps>

801087c3 <vector141>:
.globl vector141
vector141:
  pushl $0
801087c3:	6a 00                	push   $0x0
  pushl $141
801087c5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801087ca:	e9 38 f4 ff ff       	jmp    80107c07 <alltraps>

801087cf <vector142>:
.globl vector142
vector142:
  pushl $0
801087cf:	6a 00                	push   $0x0
  pushl $142
801087d1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801087d6:	e9 2c f4 ff ff       	jmp    80107c07 <alltraps>

801087db <vector143>:
.globl vector143
vector143:
  pushl $0
801087db:	6a 00                	push   $0x0
  pushl $143
801087dd:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801087e2:	e9 20 f4 ff ff       	jmp    80107c07 <alltraps>

801087e7 <vector144>:
.globl vector144
vector144:
  pushl $0
801087e7:	6a 00                	push   $0x0
  pushl $144
801087e9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801087ee:	e9 14 f4 ff ff       	jmp    80107c07 <alltraps>

801087f3 <vector145>:
.globl vector145
vector145:
  pushl $0
801087f3:	6a 00                	push   $0x0
  pushl $145
801087f5:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801087fa:	e9 08 f4 ff ff       	jmp    80107c07 <alltraps>

801087ff <vector146>:
.globl vector146
vector146:
  pushl $0
801087ff:	6a 00                	push   $0x0
  pushl $146
80108801:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80108806:	e9 fc f3 ff ff       	jmp    80107c07 <alltraps>

8010880b <vector147>:
.globl vector147
vector147:
  pushl $0
8010880b:	6a 00                	push   $0x0
  pushl $147
8010880d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80108812:	e9 f0 f3 ff ff       	jmp    80107c07 <alltraps>

80108817 <vector148>:
.globl vector148
vector148:
  pushl $0
80108817:	6a 00                	push   $0x0
  pushl $148
80108819:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010881e:	e9 e4 f3 ff ff       	jmp    80107c07 <alltraps>

80108823 <vector149>:
.globl vector149
vector149:
  pushl $0
80108823:	6a 00                	push   $0x0
  pushl $149
80108825:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010882a:	e9 d8 f3 ff ff       	jmp    80107c07 <alltraps>

8010882f <vector150>:
.globl vector150
vector150:
  pushl $0
8010882f:	6a 00                	push   $0x0
  pushl $150
80108831:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80108836:	e9 cc f3 ff ff       	jmp    80107c07 <alltraps>

8010883b <vector151>:
.globl vector151
vector151:
  pushl $0
8010883b:	6a 00                	push   $0x0
  pushl $151
8010883d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80108842:	e9 c0 f3 ff ff       	jmp    80107c07 <alltraps>

80108847 <vector152>:
.globl vector152
vector152:
  pushl $0
80108847:	6a 00                	push   $0x0
  pushl $152
80108849:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010884e:	e9 b4 f3 ff ff       	jmp    80107c07 <alltraps>

80108853 <vector153>:
.globl vector153
vector153:
  pushl $0
80108853:	6a 00                	push   $0x0
  pushl $153
80108855:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010885a:	e9 a8 f3 ff ff       	jmp    80107c07 <alltraps>

8010885f <vector154>:
.globl vector154
vector154:
  pushl $0
8010885f:	6a 00                	push   $0x0
  pushl $154
80108861:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80108866:	e9 9c f3 ff ff       	jmp    80107c07 <alltraps>

8010886b <vector155>:
.globl vector155
vector155:
  pushl $0
8010886b:	6a 00                	push   $0x0
  pushl $155
8010886d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80108872:	e9 90 f3 ff ff       	jmp    80107c07 <alltraps>

80108877 <vector156>:
.globl vector156
vector156:
  pushl $0
80108877:	6a 00                	push   $0x0
  pushl $156
80108879:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010887e:	e9 84 f3 ff ff       	jmp    80107c07 <alltraps>

80108883 <vector157>:
.globl vector157
vector157:
  pushl $0
80108883:	6a 00                	push   $0x0
  pushl $157
80108885:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010888a:	e9 78 f3 ff ff       	jmp    80107c07 <alltraps>

8010888f <vector158>:
.globl vector158
vector158:
  pushl $0
8010888f:	6a 00                	push   $0x0
  pushl $158
80108891:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80108896:	e9 6c f3 ff ff       	jmp    80107c07 <alltraps>

8010889b <vector159>:
.globl vector159
vector159:
  pushl $0
8010889b:	6a 00                	push   $0x0
  pushl $159
8010889d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801088a2:	e9 60 f3 ff ff       	jmp    80107c07 <alltraps>

801088a7 <vector160>:
.globl vector160
vector160:
  pushl $0
801088a7:	6a 00                	push   $0x0
  pushl $160
801088a9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801088ae:	e9 54 f3 ff ff       	jmp    80107c07 <alltraps>

801088b3 <vector161>:
.globl vector161
vector161:
  pushl $0
801088b3:	6a 00                	push   $0x0
  pushl $161
801088b5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801088ba:	e9 48 f3 ff ff       	jmp    80107c07 <alltraps>

801088bf <vector162>:
.globl vector162
vector162:
  pushl $0
801088bf:	6a 00                	push   $0x0
  pushl $162
801088c1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801088c6:	e9 3c f3 ff ff       	jmp    80107c07 <alltraps>

801088cb <vector163>:
.globl vector163
vector163:
  pushl $0
801088cb:	6a 00                	push   $0x0
  pushl $163
801088cd:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801088d2:	e9 30 f3 ff ff       	jmp    80107c07 <alltraps>

801088d7 <vector164>:
.globl vector164
vector164:
  pushl $0
801088d7:	6a 00                	push   $0x0
  pushl $164
801088d9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801088de:	e9 24 f3 ff ff       	jmp    80107c07 <alltraps>

801088e3 <vector165>:
.globl vector165
vector165:
  pushl $0
801088e3:	6a 00                	push   $0x0
  pushl $165
801088e5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801088ea:	e9 18 f3 ff ff       	jmp    80107c07 <alltraps>

801088ef <vector166>:
.globl vector166
vector166:
  pushl $0
801088ef:	6a 00                	push   $0x0
  pushl $166
801088f1:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
801088f6:	e9 0c f3 ff ff       	jmp    80107c07 <alltraps>

801088fb <vector167>:
.globl vector167
vector167:
  pushl $0
801088fb:	6a 00                	push   $0x0
  pushl $167
801088fd:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80108902:	e9 00 f3 ff ff       	jmp    80107c07 <alltraps>

80108907 <vector168>:
.globl vector168
vector168:
  pushl $0
80108907:	6a 00                	push   $0x0
  pushl $168
80108909:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010890e:	e9 f4 f2 ff ff       	jmp    80107c07 <alltraps>

80108913 <vector169>:
.globl vector169
vector169:
  pushl $0
80108913:	6a 00                	push   $0x0
  pushl $169
80108915:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010891a:	e9 e8 f2 ff ff       	jmp    80107c07 <alltraps>

8010891f <vector170>:
.globl vector170
vector170:
  pushl $0
8010891f:	6a 00                	push   $0x0
  pushl $170
80108921:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80108926:	e9 dc f2 ff ff       	jmp    80107c07 <alltraps>

8010892b <vector171>:
.globl vector171
vector171:
  pushl $0
8010892b:	6a 00                	push   $0x0
  pushl $171
8010892d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80108932:	e9 d0 f2 ff ff       	jmp    80107c07 <alltraps>

80108937 <vector172>:
.globl vector172
vector172:
  pushl $0
80108937:	6a 00                	push   $0x0
  pushl $172
80108939:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010893e:	e9 c4 f2 ff ff       	jmp    80107c07 <alltraps>

80108943 <vector173>:
.globl vector173
vector173:
  pushl $0
80108943:	6a 00                	push   $0x0
  pushl $173
80108945:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010894a:	e9 b8 f2 ff ff       	jmp    80107c07 <alltraps>

8010894f <vector174>:
.globl vector174
vector174:
  pushl $0
8010894f:	6a 00                	push   $0x0
  pushl $174
80108951:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80108956:	e9 ac f2 ff ff       	jmp    80107c07 <alltraps>

8010895b <vector175>:
.globl vector175
vector175:
  pushl $0
8010895b:	6a 00                	push   $0x0
  pushl $175
8010895d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80108962:	e9 a0 f2 ff ff       	jmp    80107c07 <alltraps>

80108967 <vector176>:
.globl vector176
vector176:
  pushl $0
80108967:	6a 00                	push   $0x0
  pushl $176
80108969:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010896e:	e9 94 f2 ff ff       	jmp    80107c07 <alltraps>

80108973 <vector177>:
.globl vector177
vector177:
  pushl $0
80108973:	6a 00                	push   $0x0
  pushl $177
80108975:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010897a:	e9 88 f2 ff ff       	jmp    80107c07 <alltraps>

8010897f <vector178>:
.globl vector178
vector178:
  pushl $0
8010897f:	6a 00                	push   $0x0
  pushl $178
80108981:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80108986:	e9 7c f2 ff ff       	jmp    80107c07 <alltraps>

8010898b <vector179>:
.globl vector179
vector179:
  pushl $0
8010898b:	6a 00                	push   $0x0
  pushl $179
8010898d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80108992:	e9 70 f2 ff ff       	jmp    80107c07 <alltraps>

80108997 <vector180>:
.globl vector180
vector180:
  pushl $0
80108997:	6a 00                	push   $0x0
  pushl $180
80108999:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010899e:	e9 64 f2 ff ff       	jmp    80107c07 <alltraps>

801089a3 <vector181>:
.globl vector181
vector181:
  pushl $0
801089a3:	6a 00                	push   $0x0
  pushl $181
801089a5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801089aa:	e9 58 f2 ff ff       	jmp    80107c07 <alltraps>

801089af <vector182>:
.globl vector182
vector182:
  pushl $0
801089af:	6a 00                	push   $0x0
  pushl $182
801089b1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801089b6:	e9 4c f2 ff ff       	jmp    80107c07 <alltraps>

801089bb <vector183>:
.globl vector183
vector183:
  pushl $0
801089bb:	6a 00                	push   $0x0
  pushl $183
801089bd:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801089c2:	e9 40 f2 ff ff       	jmp    80107c07 <alltraps>

801089c7 <vector184>:
.globl vector184
vector184:
  pushl $0
801089c7:	6a 00                	push   $0x0
  pushl $184
801089c9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801089ce:	e9 34 f2 ff ff       	jmp    80107c07 <alltraps>

801089d3 <vector185>:
.globl vector185
vector185:
  pushl $0
801089d3:	6a 00                	push   $0x0
  pushl $185
801089d5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801089da:	e9 28 f2 ff ff       	jmp    80107c07 <alltraps>

801089df <vector186>:
.globl vector186
vector186:
  pushl $0
801089df:	6a 00                	push   $0x0
  pushl $186
801089e1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801089e6:	e9 1c f2 ff ff       	jmp    80107c07 <alltraps>

801089eb <vector187>:
.globl vector187
vector187:
  pushl $0
801089eb:	6a 00                	push   $0x0
  pushl $187
801089ed:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
801089f2:	e9 10 f2 ff ff       	jmp    80107c07 <alltraps>

801089f7 <vector188>:
.globl vector188
vector188:
  pushl $0
801089f7:	6a 00                	push   $0x0
  pushl $188
801089f9:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
801089fe:	e9 04 f2 ff ff       	jmp    80107c07 <alltraps>

80108a03 <vector189>:
.globl vector189
vector189:
  pushl $0
80108a03:	6a 00                	push   $0x0
  pushl $189
80108a05:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80108a0a:	e9 f8 f1 ff ff       	jmp    80107c07 <alltraps>

80108a0f <vector190>:
.globl vector190
vector190:
  pushl $0
80108a0f:	6a 00                	push   $0x0
  pushl $190
80108a11:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80108a16:	e9 ec f1 ff ff       	jmp    80107c07 <alltraps>

80108a1b <vector191>:
.globl vector191
vector191:
  pushl $0
80108a1b:	6a 00                	push   $0x0
  pushl $191
80108a1d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80108a22:	e9 e0 f1 ff ff       	jmp    80107c07 <alltraps>

80108a27 <vector192>:
.globl vector192
vector192:
  pushl $0
80108a27:	6a 00                	push   $0x0
  pushl $192
80108a29:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80108a2e:	e9 d4 f1 ff ff       	jmp    80107c07 <alltraps>

80108a33 <vector193>:
.globl vector193
vector193:
  pushl $0
80108a33:	6a 00                	push   $0x0
  pushl $193
80108a35:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80108a3a:	e9 c8 f1 ff ff       	jmp    80107c07 <alltraps>

80108a3f <vector194>:
.globl vector194
vector194:
  pushl $0
80108a3f:	6a 00                	push   $0x0
  pushl $194
80108a41:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80108a46:	e9 bc f1 ff ff       	jmp    80107c07 <alltraps>

80108a4b <vector195>:
.globl vector195
vector195:
  pushl $0
80108a4b:	6a 00                	push   $0x0
  pushl $195
80108a4d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80108a52:	e9 b0 f1 ff ff       	jmp    80107c07 <alltraps>

80108a57 <vector196>:
.globl vector196
vector196:
  pushl $0
80108a57:	6a 00                	push   $0x0
  pushl $196
80108a59:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80108a5e:	e9 a4 f1 ff ff       	jmp    80107c07 <alltraps>

80108a63 <vector197>:
.globl vector197
vector197:
  pushl $0
80108a63:	6a 00                	push   $0x0
  pushl $197
80108a65:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80108a6a:	e9 98 f1 ff ff       	jmp    80107c07 <alltraps>

80108a6f <vector198>:
.globl vector198
vector198:
  pushl $0
80108a6f:	6a 00                	push   $0x0
  pushl $198
80108a71:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80108a76:	e9 8c f1 ff ff       	jmp    80107c07 <alltraps>

80108a7b <vector199>:
.globl vector199
vector199:
  pushl $0
80108a7b:	6a 00                	push   $0x0
  pushl $199
80108a7d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80108a82:	e9 80 f1 ff ff       	jmp    80107c07 <alltraps>

80108a87 <vector200>:
.globl vector200
vector200:
  pushl $0
80108a87:	6a 00                	push   $0x0
  pushl $200
80108a89:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80108a8e:	e9 74 f1 ff ff       	jmp    80107c07 <alltraps>

80108a93 <vector201>:
.globl vector201
vector201:
  pushl $0
80108a93:	6a 00                	push   $0x0
  pushl $201
80108a95:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80108a9a:	e9 68 f1 ff ff       	jmp    80107c07 <alltraps>

80108a9f <vector202>:
.globl vector202
vector202:
  pushl $0
80108a9f:	6a 00                	push   $0x0
  pushl $202
80108aa1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80108aa6:	e9 5c f1 ff ff       	jmp    80107c07 <alltraps>

80108aab <vector203>:
.globl vector203
vector203:
  pushl $0
80108aab:	6a 00                	push   $0x0
  pushl $203
80108aad:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80108ab2:	e9 50 f1 ff ff       	jmp    80107c07 <alltraps>

80108ab7 <vector204>:
.globl vector204
vector204:
  pushl $0
80108ab7:	6a 00                	push   $0x0
  pushl $204
80108ab9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80108abe:	e9 44 f1 ff ff       	jmp    80107c07 <alltraps>

80108ac3 <vector205>:
.globl vector205
vector205:
  pushl $0
80108ac3:	6a 00                	push   $0x0
  pushl $205
80108ac5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80108aca:	e9 38 f1 ff ff       	jmp    80107c07 <alltraps>

80108acf <vector206>:
.globl vector206
vector206:
  pushl $0
80108acf:	6a 00                	push   $0x0
  pushl $206
80108ad1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80108ad6:	e9 2c f1 ff ff       	jmp    80107c07 <alltraps>

80108adb <vector207>:
.globl vector207
vector207:
  pushl $0
80108adb:	6a 00                	push   $0x0
  pushl $207
80108add:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80108ae2:	e9 20 f1 ff ff       	jmp    80107c07 <alltraps>

80108ae7 <vector208>:
.globl vector208
vector208:
  pushl $0
80108ae7:	6a 00                	push   $0x0
  pushl $208
80108ae9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80108aee:	e9 14 f1 ff ff       	jmp    80107c07 <alltraps>

80108af3 <vector209>:
.globl vector209
vector209:
  pushl $0
80108af3:	6a 00                	push   $0x0
  pushl $209
80108af5:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80108afa:	e9 08 f1 ff ff       	jmp    80107c07 <alltraps>

80108aff <vector210>:
.globl vector210
vector210:
  pushl $0
80108aff:	6a 00                	push   $0x0
  pushl $210
80108b01:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80108b06:	e9 fc f0 ff ff       	jmp    80107c07 <alltraps>

80108b0b <vector211>:
.globl vector211
vector211:
  pushl $0
80108b0b:	6a 00                	push   $0x0
  pushl $211
80108b0d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80108b12:	e9 f0 f0 ff ff       	jmp    80107c07 <alltraps>

80108b17 <vector212>:
.globl vector212
vector212:
  pushl $0
80108b17:	6a 00                	push   $0x0
  pushl $212
80108b19:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80108b1e:	e9 e4 f0 ff ff       	jmp    80107c07 <alltraps>

80108b23 <vector213>:
.globl vector213
vector213:
  pushl $0
80108b23:	6a 00                	push   $0x0
  pushl $213
80108b25:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80108b2a:	e9 d8 f0 ff ff       	jmp    80107c07 <alltraps>

80108b2f <vector214>:
.globl vector214
vector214:
  pushl $0
80108b2f:	6a 00                	push   $0x0
  pushl $214
80108b31:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80108b36:	e9 cc f0 ff ff       	jmp    80107c07 <alltraps>

80108b3b <vector215>:
.globl vector215
vector215:
  pushl $0
80108b3b:	6a 00                	push   $0x0
  pushl $215
80108b3d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80108b42:	e9 c0 f0 ff ff       	jmp    80107c07 <alltraps>

80108b47 <vector216>:
.globl vector216
vector216:
  pushl $0
80108b47:	6a 00                	push   $0x0
  pushl $216
80108b49:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80108b4e:	e9 b4 f0 ff ff       	jmp    80107c07 <alltraps>

80108b53 <vector217>:
.globl vector217
vector217:
  pushl $0
80108b53:	6a 00                	push   $0x0
  pushl $217
80108b55:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80108b5a:	e9 a8 f0 ff ff       	jmp    80107c07 <alltraps>

80108b5f <vector218>:
.globl vector218
vector218:
  pushl $0
80108b5f:	6a 00                	push   $0x0
  pushl $218
80108b61:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80108b66:	e9 9c f0 ff ff       	jmp    80107c07 <alltraps>

80108b6b <vector219>:
.globl vector219
vector219:
  pushl $0
80108b6b:	6a 00                	push   $0x0
  pushl $219
80108b6d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80108b72:	e9 90 f0 ff ff       	jmp    80107c07 <alltraps>

80108b77 <vector220>:
.globl vector220
vector220:
  pushl $0
80108b77:	6a 00                	push   $0x0
  pushl $220
80108b79:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80108b7e:	e9 84 f0 ff ff       	jmp    80107c07 <alltraps>

80108b83 <vector221>:
.globl vector221
vector221:
  pushl $0
80108b83:	6a 00                	push   $0x0
  pushl $221
80108b85:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80108b8a:	e9 78 f0 ff ff       	jmp    80107c07 <alltraps>

80108b8f <vector222>:
.globl vector222
vector222:
  pushl $0
80108b8f:	6a 00                	push   $0x0
  pushl $222
80108b91:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80108b96:	e9 6c f0 ff ff       	jmp    80107c07 <alltraps>

80108b9b <vector223>:
.globl vector223
vector223:
  pushl $0
80108b9b:	6a 00                	push   $0x0
  pushl $223
80108b9d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80108ba2:	e9 60 f0 ff ff       	jmp    80107c07 <alltraps>

80108ba7 <vector224>:
.globl vector224
vector224:
  pushl $0
80108ba7:	6a 00                	push   $0x0
  pushl $224
80108ba9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80108bae:	e9 54 f0 ff ff       	jmp    80107c07 <alltraps>

80108bb3 <vector225>:
.globl vector225
vector225:
  pushl $0
80108bb3:	6a 00                	push   $0x0
  pushl $225
80108bb5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80108bba:	e9 48 f0 ff ff       	jmp    80107c07 <alltraps>

80108bbf <vector226>:
.globl vector226
vector226:
  pushl $0
80108bbf:	6a 00                	push   $0x0
  pushl $226
80108bc1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80108bc6:	e9 3c f0 ff ff       	jmp    80107c07 <alltraps>

80108bcb <vector227>:
.globl vector227
vector227:
  pushl $0
80108bcb:	6a 00                	push   $0x0
  pushl $227
80108bcd:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80108bd2:	e9 30 f0 ff ff       	jmp    80107c07 <alltraps>

80108bd7 <vector228>:
.globl vector228
vector228:
  pushl $0
80108bd7:	6a 00                	push   $0x0
  pushl $228
80108bd9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80108bde:	e9 24 f0 ff ff       	jmp    80107c07 <alltraps>

80108be3 <vector229>:
.globl vector229
vector229:
  pushl $0
80108be3:	6a 00                	push   $0x0
  pushl $229
80108be5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80108bea:	e9 18 f0 ff ff       	jmp    80107c07 <alltraps>

80108bef <vector230>:
.globl vector230
vector230:
  pushl $0
80108bef:	6a 00                	push   $0x0
  pushl $230
80108bf1:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80108bf6:	e9 0c f0 ff ff       	jmp    80107c07 <alltraps>

80108bfb <vector231>:
.globl vector231
vector231:
  pushl $0
80108bfb:	6a 00                	push   $0x0
  pushl $231
80108bfd:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80108c02:	e9 00 f0 ff ff       	jmp    80107c07 <alltraps>

80108c07 <vector232>:
.globl vector232
vector232:
  pushl $0
80108c07:	6a 00                	push   $0x0
  pushl $232
80108c09:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80108c0e:	e9 f4 ef ff ff       	jmp    80107c07 <alltraps>

80108c13 <vector233>:
.globl vector233
vector233:
  pushl $0
80108c13:	6a 00                	push   $0x0
  pushl $233
80108c15:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80108c1a:	e9 e8 ef ff ff       	jmp    80107c07 <alltraps>

80108c1f <vector234>:
.globl vector234
vector234:
  pushl $0
80108c1f:	6a 00                	push   $0x0
  pushl $234
80108c21:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80108c26:	e9 dc ef ff ff       	jmp    80107c07 <alltraps>

80108c2b <vector235>:
.globl vector235
vector235:
  pushl $0
80108c2b:	6a 00                	push   $0x0
  pushl $235
80108c2d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80108c32:	e9 d0 ef ff ff       	jmp    80107c07 <alltraps>

80108c37 <vector236>:
.globl vector236
vector236:
  pushl $0
80108c37:	6a 00                	push   $0x0
  pushl $236
80108c39:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80108c3e:	e9 c4 ef ff ff       	jmp    80107c07 <alltraps>

80108c43 <vector237>:
.globl vector237
vector237:
  pushl $0
80108c43:	6a 00                	push   $0x0
  pushl $237
80108c45:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80108c4a:	e9 b8 ef ff ff       	jmp    80107c07 <alltraps>

80108c4f <vector238>:
.globl vector238
vector238:
  pushl $0
80108c4f:	6a 00                	push   $0x0
  pushl $238
80108c51:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80108c56:	e9 ac ef ff ff       	jmp    80107c07 <alltraps>

80108c5b <vector239>:
.globl vector239
vector239:
  pushl $0
80108c5b:	6a 00                	push   $0x0
  pushl $239
80108c5d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80108c62:	e9 a0 ef ff ff       	jmp    80107c07 <alltraps>

80108c67 <vector240>:
.globl vector240
vector240:
  pushl $0
80108c67:	6a 00                	push   $0x0
  pushl $240
80108c69:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80108c6e:	e9 94 ef ff ff       	jmp    80107c07 <alltraps>

80108c73 <vector241>:
.globl vector241
vector241:
  pushl $0
80108c73:	6a 00                	push   $0x0
  pushl $241
80108c75:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80108c7a:	e9 88 ef ff ff       	jmp    80107c07 <alltraps>

80108c7f <vector242>:
.globl vector242
vector242:
  pushl $0
80108c7f:	6a 00                	push   $0x0
  pushl $242
80108c81:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80108c86:	e9 7c ef ff ff       	jmp    80107c07 <alltraps>

80108c8b <vector243>:
.globl vector243
vector243:
  pushl $0
80108c8b:	6a 00                	push   $0x0
  pushl $243
80108c8d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80108c92:	e9 70 ef ff ff       	jmp    80107c07 <alltraps>

80108c97 <vector244>:
.globl vector244
vector244:
  pushl $0
80108c97:	6a 00                	push   $0x0
  pushl $244
80108c99:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80108c9e:	e9 64 ef ff ff       	jmp    80107c07 <alltraps>

80108ca3 <vector245>:
.globl vector245
vector245:
  pushl $0
80108ca3:	6a 00                	push   $0x0
  pushl $245
80108ca5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80108caa:	e9 58 ef ff ff       	jmp    80107c07 <alltraps>

80108caf <vector246>:
.globl vector246
vector246:
  pushl $0
80108caf:	6a 00                	push   $0x0
  pushl $246
80108cb1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80108cb6:	e9 4c ef ff ff       	jmp    80107c07 <alltraps>

80108cbb <vector247>:
.globl vector247
vector247:
  pushl $0
80108cbb:	6a 00                	push   $0x0
  pushl $247
80108cbd:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80108cc2:	e9 40 ef ff ff       	jmp    80107c07 <alltraps>

80108cc7 <vector248>:
.globl vector248
vector248:
  pushl $0
80108cc7:	6a 00                	push   $0x0
  pushl $248
80108cc9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80108cce:	e9 34 ef ff ff       	jmp    80107c07 <alltraps>

80108cd3 <vector249>:
.globl vector249
vector249:
  pushl $0
80108cd3:	6a 00                	push   $0x0
  pushl $249
80108cd5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80108cda:	e9 28 ef ff ff       	jmp    80107c07 <alltraps>

80108cdf <vector250>:
.globl vector250
vector250:
  pushl $0
80108cdf:	6a 00                	push   $0x0
  pushl $250
80108ce1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80108ce6:	e9 1c ef ff ff       	jmp    80107c07 <alltraps>

80108ceb <vector251>:
.globl vector251
vector251:
  pushl $0
80108ceb:	6a 00                	push   $0x0
  pushl $251
80108ced:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80108cf2:	e9 10 ef ff ff       	jmp    80107c07 <alltraps>

80108cf7 <vector252>:
.globl vector252
vector252:
  pushl $0
80108cf7:	6a 00                	push   $0x0
  pushl $252
80108cf9:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80108cfe:	e9 04 ef ff ff       	jmp    80107c07 <alltraps>

80108d03 <vector253>:
.globl vector253
vector253:
  pushl $0
80108d03:	6a 00                	push   $0x0
  pushl $253
80108d05:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80108d0a:	e9 f8 ee ff ff       	jmp    80107c07 <alltraps>

80108d0f <vector254>:
.globl vector254
vector254:
  pushl $0
80108d0f:	6a 00                	push   $0x0
  pushl $254
80108d11:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80108d16:	e9 ec ee ff ff       	jmp    80107c07 <alltraps>

80108d1b <vector255>:
.globl vector255
vector255:
  pushl $0
80108d1b:	6a 00                	push   $0x0
  pushl $255
80108d1d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80108d22:	e9 e0 ee ff ff       	jmp    80107c07 <alltraps>
80108d27:	66 90                	xchg   %ax,%ax
80108d29:	66 90                	xchg   %ax,%ax
80108d2b:	66 90                	xchg   %ax,%ax
80108d2d:	66 90                	xchg   %ax,%ax
80108d2f:	90                   	nop

80108d30 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80108d30:	55                   	push   %ebp
80108d31:	89 e5                	mov    %esp,%ebp
80108d33:	57                   	push   %edi
80108d34:	56                   	push   %esi
80108d35:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80108d36:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
80108d3c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80108d42:	83 ec 1c             	sub    $0x1c,%esp
80108d45:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80108d48:	39 d3                	cmp    %edx,%ebx
80108d4a:	73 49                	jae    80108d95 <deallocuvm.part.0+0x65>
80108d4c:	89 c7                	mov    %eax,%edi
80108d4e:	eb 0c                	jmp    80108d5c <deallocuvm.part.0+0x2c>
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80108d50:	83 c0 01             	add    $0x1,%eax
80108d53:	c1 e0 16             	shl    $0x16,%eax
80108d56:	89 c3                	mov    %eax,%ebx
  for(; a  < oldsz; a += PGSIZE){
80108d58:	39 da                	cmp    %ebx,%edx
80108d5a:	76 39                	jbe    80108d95 <deallocuvm.part.0+0x65>
  pde = &pgdir[PDX(va)];
80108d5c:	89 d8                	mov    %ebx,%eax
80108d5e:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80108d61:	8b 0c 87             	mov    (%edi,%eax,4),%ecx
80108d64:	f6 c1 01             	test   $0x1,%cl
80108d67:	74 e7                	je     80108d50 <deallocuvm.part.0+0x20>
  return &pgtab[PTX(va)];
80108d69:	89 de                	mov    %ebx,%esi
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80108d6b:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80108d71:	c1 ee 0a             	shr    $0xa,%esi
80108d74:	81 e6 fc 0f 00 00    	and    $0xffc,%esi
80108d7a:	8d b4 31 00 00 00 80 	lea    -0x80000000(%ecx,%esi,1),%esi
    if(!pte)
80108d81:	85 f6                	test   %esi,%esi
80108d83:	74 cb                	je     80108d50 <deallocuvm.part.0+0x20>
    else if((*pte & PTE_P) != 0){
80108d85:	8b 06                	mov    (%esi),%eax
80108d87:	a8 01                	test   $0x1,%al
80108d89:	75 15                	jne    80108da0 <deallocuvm.part.0+0x70>
  for(; a  < oldsz; a += PGSIZE){
80108d8b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80108d91:	39 da                	cmp    %ebx,%edx
80108d93:	77 c7                	ja     80108d5c <deallocuvm.part.0+0x2c>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80108d95:	8b 45 e0             	mov    -0x20(%ebp),%eax
80108d98:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108d9b:	5b                   	pop    %ebx
80108d9c:	5e                   	pop    %esi
80108d9d:	5f                   	pop    %edi
80108d9e:	5d                   	pop    %ebp
80108d9f:	c3                   	ret    
      if(pa == 0)
80108da0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108da5:	74 25                	je     80108dcc <deallocuvm.part.0+0x9c>
      kfree(v);
80108da7:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80108daa:	05 00 00 00 80       	add    $0x80000000,%eax
80108daf:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80108db2:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
80108db8:	50                   	push   %eax
80108db9:	e8 52 a6 ff ff       	call   80103410 <kfree>
      *pte = 0;
80108dbe:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  for(; a  < oldsz; a += PGSIZE){
80108dc4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80108dc7:	83 c4 10             	add    $0x10,%esp
80108dca:	eb 8c                	jmp    80108d58 <deallocuvm.part.0+0x28>
        panic("kfree");
80108dcc:	83 ec 0c             	sub    $0xc,%esp
80108dcf:	68 ce 99 10 80       	push   $0x801099ce
80108dd4:	e8 f7 76 ff ff       	call   801004d0 <panic>
80108dd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80108de0 <mappages>:
{
80108de0:	55                   	push   %ebp
80108de1:	89 e5                	mov    %esp,%ebp
80108de3:	57                   	push   %edi
80108de4:	56                   	push   %esi
80108de5:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80108de6:	89 d3                	mov    %edx,%ebx
80108de8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80108dee:	83 ec 1c             	sub    $0x1c,%esp
80108df1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80108df4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80108df8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108dfd:	89 45 dc             	mov    %eax,-0x24(%ebp)
80108e00:	8b 45 08             	mov    0x8(%ebp),%eax
80108e03:	29 d8                	sub    %ebx,%eax
80108e05:	89 45 e0             	mov    %eax,-0x20(%ebp)
80108e08:	eb 3d                	jmp    80108e47 <mappages+0x67>
80108e0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80108e10:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80108e12:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80108e17:	c1 ea 0a             	shr    $0xa,%edx
80108e1a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80108e20:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80108e27:	85 c0                	test   %eax,%eax
80108e29:	74 75                	je     80108ea0 <mappages+0xc0>
    if(*pte & PTE_P)
80108e2b:	f6 00 01             	testb  $0x1,(%eax)
80108e2e:	0f 85 86 00 00 00    	jne    80108eba <mappages+0xda>
    *pte = pa | perm | PTE_P;
80108e34:	0b 75 0c             	or     0xc(%ebp),%esi
80108e37:	83 ce 01             	or     $0x1,%esi
80108e3a:	89 30                	mov    %esi,(%eax)
    if(a == last)
80108e3c:	3b 5d dc             	cmp    -0x24(%ebp),%ebx
80108e3f:	74 6f                	je     80108eb0 <mappages+0xd0>
    a += PGSIZE;
80108e41:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
80108e47:	8b 45 e0             	mov    -0x20(%ebp),%eax
  pde = &pgdir[PDX(va)];
80108e4a:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80108e4d:	8d 34 18             	lea    (%eax,%ebx,1),%esi
80108e50:	89 d8                	mov    %ebx,%eax
80108e52:	c1 e8 16             	shr    $0x16,%eax
80108e55:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
80108e58:	8b 07                	mov    (%edi),%eax
80108e5a:	a8 01                	test   $0x1,%al
80108e5c:	75 b2                	jne    80108e10 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80108e5e:	e8 6d a7 ff ff       	call   801035d0 <kalloc>
80108e63:	85 c0                	test   %eax,%eax
80108e65:	74 39                	je     80108ea0 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
80108e67:	83 ec 04             	sub    $0x4,%esp
80108e6a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80108e6d:	68 00 10 00 00       	push   $0x1000
80108e72:	6a 00                	push   $0x0
80108e74:	50                   	push   %eax
80108e75:	e8 96 d2 ff ff       	call   80106110 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80108e7a:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
80108e7d:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80108e80:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80108e86:	83 c8 07             	or     $0x7,%eax
80108e89:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
80108e8b:	89 d8                	mov    %ebx,%eax
80108e8d:	c1 e8 0a             	shr    $0xa,%eax
80108e90:	25 fc 0f 00 00       	and    $0xffc,%eax
80108e95:	01 d0                	add    %edx,%eax
80108e97:	eb 92                	jmp    80108e2b <mappages+0x4b>
80108e99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
80108ea0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80108ea3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80108ea8:	5b                   	pop    %ebx
80108ea9:	5e                   	pop    %esi
80108eaa:	5f                   	pop    %edi
80108eab:	5d                   	pop    %ebp
80108eac:	c3                   	ret    
80108ead:	8d 76 00             	lea    0x0(%esi),%esi
80108eb0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80108eb3:	31 c0                	xor    %eax,%eax
}
80108eb5:	5b                   	pop    %ebx
80108eb6:	5e                   	pop    %esi
80108eb7:	5f                   	pop    %edi
80108eb8:	5d                   	pop    %ebp
80108eb9:	c3                   	ret    
      panic("remap");
80108eba:	83 ec 0c             	sub    $0xc,%esp
80108ebd:	68 40 a5 10 80       	push   $0x8010a540
80108ec2:	e8 09 76 ff ff       	call   801004d0 <panic>
80108ec7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108ece:	66 90                	xchg   %ax,%ax

80108ed0 <seginit>:
{
80108ed0:	55                   	push   %ebp
80108ed1:	89 e5                	mov    %esp,%ebp
80108ed3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80108ed6:	e8 55 ba ff ff       	call   80104930 <cpuid>
  pd[0] = size-1;
80108edb:	ba 2f 00 00 00       	mov    $0x2f,%edx
80108ee0:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80108ee6:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80108eea:	c7 80 e0 52 11 80 ff 	movl   $0xffff,-0x7feead20(%eax)
80108ef1:	ff 00 00 
80108ef4:	c7 80 e4 52 11 80 00 	movl   $0xcf9a00,-0x7feead1c(%eax)
80108efb:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80108efe:	c7 80 e8 52 11 80 ff 	movl   $0xffff,-0x7feead18(%eax)
80108f05:	ff 00 00 
80108f08:	c7 80 ec 52 11 80 00 	movl   $0xcf9200,-0x7feead14(%eax)
80108f0f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80108f12:	c7 80 f0 52 11 80 ff 	movl   $0xffff,-0x7feead10(%eax)
80108f19:	ff 00 00 
80108f1c:	c7 80 f4 52 11 80 00 	movl   $0xcffa00,-0x7feead0c(%eax)
80108f23:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80108f26:	c7 80 f8 52 11 80 ff 	movl   $0xffff,-0x7feead08(%eax)
80108f2d:	ff 00 00 
80108f30:	c7 80 fc 52 11 80 00 	movl   $0xcff200,-0x7feead04(%eax)
80108f37:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80108f3a:	05 d8 52 11 80       	add    $0x801152d8,%eax
  pd[1] = (uint)p;
80108f3f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80108f43:	c1 e8 10             	shr    $0x10,%eax
80108f46:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80108f4a:	8d 45 f2             	lea    -0xe(%ebp),%eax
80108f4d:	0f 01 10             	lgdtl  (%eax)
}
80108f50:	c9                   	leave  
80108f51:	c3                   	ret    
80108f52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108f59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80108f60 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80108f60:	a1 64 b1 34 80       	mov    0x8034b164,%eax
80108f65:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80108f6a:	0f 22 d8             	mov    %eax,%cr3
}
80108f6d:	c3                   	ret    
80108f6e:	66 90                	xchg   %ax,%ax

80108f70 <switchuvm>:
{
80108f70:	55                   	push   %ebp
80108f71:	89 e5                	mov    %esp,%ebp
80108f73:	57                   	push   %edi
80108f74:	56                   	push   %esi
80108f75:	53                   	push   %ebx
80108f76:	83 ec 1c             	sub    $0x1c,%esp
80108f79:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80108f7c:	85 f6                	test   %esi,%esi
80108f7e:	0f 84 cb 00 00 00    	je     8010904f <switchuvm+0xdf>
  if(p->kstack == 0)
80108f84:	8b 46 08             	mov    0x8(%esi),%eax
80108f87:	85 c0                	test   %eax,%eax
80108f89:	0f 84 da 00 00 00    	je     80109069 <switchuvm+0xf9>
  if(p->pgdir == 0)
80108f8f:	8b 46 04             	mov    0x4(%esi),%eax
80108f92:	85 c0                	test   %eax,%eax
80108f94:	0f 84 c2 00 00 00    	je     8010905c <switchuvm+0xec>
  pushcli();
80108f9a:	e8 31 ce ff ff       	call   80105dd0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80108f9f:	e8 2c b9 ff ff       	call   801048d0 <mycpu>
80108fa4:	89 c3                	mov    %eax,%ebx
80108fa6:	e8 25 b9 ff ff       	call   801048d0 <mycpu>
80108fab:	89 c7                	mov    %eax,%edi
80108fad:	e8 1e b9 ff ff       	call   801048d0 <mycpu>
80108fb2:	83 c7 10             	add    $0x10,%edi
80108fb5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80108fb8:	e8 13 b9 ff ff       	call   801048d0 <mycpu>
80108fbd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80108fc0:	ba 67 00 00 00       	mov    $0x67,%edx
80108fc5:	66 89 bb a2 00 00 00 	mov    %di,0xa2(%ebx)
80108fcc:	83 c0 10             	add    $0x10,%eax
80108fcf:	66 89 93 a0 00 00 00 	mov    %dx,0xa0(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80108fd6:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80108fdb:	83 c1 10             	add    $0x10,%ecx
80108fde:	c1 e8 18             	shr    $0x18,%eax
80108fe1:	c1 e9 10             	shr    $0x10,%ecx
80108fe4:	88 83 a7 00 00 00    	mov    %al,0xa7(%ebx)
80108fea:	88 8b a4 00 00 00    	mov    %cl,0xa4(%ebx)
80108ff0:	b9 99 40 00 00       	mov    $0x4099,%ecx
80108ff5:	66 89 8b a5 00 00 00 	mov    %cx,0xa5(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80108ffc:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80109001:	e8 ca b8 ff ff       	call   801048d0 <mycpu>
80109006:	80 a0 a5 00 00 00 ef 	andb   $0xef,0xa5(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010900d:	e8 be b8 ff ff       	call   801048d0 <mycpu>
80109012:	66 89 58 18          	mov    %bx,0x18(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80109016:	8b 5e 08             	mov    0x8(%esi),%ebx
80109019:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010901f:	e8 ac b8 ff ff       	call   801048d0 <mycpu>
80109024:	89 58 14             	mov    %ebx,0x14(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80109027:	e8 a4 b8 ff ff       	call   801048d0 <mycpu>
8010902c:	66 89 78 76          	mov    %di,0x76(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80109030:	b8 28 00 00 00       	mov    $0x28,%eax
80109035:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80109038:	8b 46 04             	mov    0x4(%esi),%eax
8010903b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80109040:	0f 22 d8             	mov    %eax,%cr3
}
80109043:	8d 65 f4             	lea    -0xc(%ebp),%esp
80109046:	5b                   	pop    %ebx
80109047:	5e                   	pop    %esi
80109048:	5f                   	pop    %edi
80109049:	5d                   	pop    %ebp
  popcli();
8010904a:	e9 d1 cd ff ff       	jmp    80105e20 <popcli>
    panic("switchuvm: no process");
8010904f:	83 ec 0c             	sub    $0xc,%esp
80109052:	68 46 a5 10 80       	push   $0x8010a546
80109057:	e8 74 74 ff ff       	call   801004d0 <panic>
    panic("switchuvm: no pgdir");
8010905c:	83 ec 0c             	sub    $0xc,%esp
8010905f:	68 71 a5 10 80       	push   $0x8010a571
80109064:	e8 67 74 ff ff       	call   801004d0 <panic>
    panic("switchuvm: no kstack");
80109069:	83 ec 0c             	sub    $0xc,%esp
8010906c:	68 5c a5 10 80       	push   $0x8010a55c
80109071:	e8 5a 74 ff ff       	call   801004d0 <panic>
80109076:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010907d:	8d 76 00             	lea    0x0(%esi),%esi

80109080 <inituvm>:
{
80109080:	55                   	push   %ebp
80109081:	89 e5                	mov    %esp,%ebp
80109083:	57                   	push   %edi
80109084:	56                   	push   %esi
80109085:	53                   	push   %ebx
80109086:	83 ec 1c             	sub    $0x1c,%esp
80109089:	8b 45 0c             	mov    0xc(%ebp),%eax
8010908c:	8b 75 10             	mov    0x10(%ebp),%esi
8010908f:	8b 7d 08             	mov    0x8(%ebp),%edi
80109092:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80109095:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010909b:	77 4b                	ja     801090e8 <inituvm+0x68>
  mem = kalloc();
8010909d:	e8 2e a5 ff ff       	call   801035d0 <kalloc>
  memset(mem, 0, PGSIZE);
801090a2:	83 ec 04             	sub    $0x4,%esp
801090a5:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
801090aa:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
801090ac:	6a 00                	push   $0x0
801090ae:	50                   	push   %eax
801090af:	e8 5c d0 ff ff       	call   80106110 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
801090b4:	58                   	pop    %eax
801090b5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801090bb:	5a                   	pop    %edx
801090bc:	6a 06                	push   $0x6
801090be:	b9 00 10 00 00       	mov    $0x1000,%ecx
801090c3:	31 d2                	xor    %edx,%edx
801090c5:	50                   	push   %eax
801090c6:	89 f8                	mov    %edi,%eax
801090c8:	e8 13 fd ff ff       	call   80108de0 <mappages>
  memmove(mem, init, sz);
801090cd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801090d0:	89 75 10             	mov    %esi,0x10(%ebp)
801090d3:	83 c4 10             	add    $0x10,%esp
801090d6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801090d9:	89 45 0c             	mov    %eax,0xc(%ebp)
}
801090dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801090df:	5b                   	pop    %ebx
801090e0:	5e                   	pop    %esi
801090e1:	5f                   	pop    %edi
801090e2:	5d                   	pop    %ebp
  memmove(mem, init, sz);
801090e3:	e9 c8 d0 ff ff       	jmp    801061b0 <memmove>
    panic("inituvm: more than a page");
801090e8:	83 ec 0c             	sub    $0xc,%esp
801090eb:	68 85 a5 10 80       	push   $0x8010a585
801090f0:	e8 db 73 ff ff       	call   801004d0 <panic>
801090f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801090fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80109100 <loaduvm>:
{
80109100:	55                   	push   %ebp
80109101:	89 e5                	mov    %esp,%ebp
80109103:	57                   	push   %edi
80109104:	56                   	push   %esi
80109105:	53                   	push   %ebx
80109106:	83 ec 1c             	sub    $0x1c,%esp
80109109:	8b 45 0c             	mov    0xc(%ebp),%eax
8010910c:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
8010910f:	a9 ff 0f 00 00       	test   $0xfff,%eax
80109114:	0f 85 bb 00 00 00    	jne    801091d5 <loaduvm+0xd5>
  for(i = 0; i < sz; i += PGSIZE){
8010911a:	01 f0                	add    %esi,%eax
8010911c:	89 f3                	mov    %esi,%ebx
8010911e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
80109121:	8b 45 14             	mov    0x14(%ebp),%eax
80109124:	01 f0                	add    %esi,%eax
80109126:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
80109129:	85 f6                	test   %esi,%esi
8010912b:	0f 84 87 00 00 00    	je     801091b8 <loaduvm+0xb8>
80109131:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  pde = &pgdir[PDX(va)];
80109138:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  if(*pde & PTE_P){
8010913b:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010913e:	29 d8                	sub    %ebx,%eax
  pde = &pgdir[PDX(va)];
80109140:	89 c2                	mov    %eax,%edx
80109142:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80109145:	8b 14 91             	mov    (%ecx,%edx,4),%edx
80109148:	f6 c2 01             	test   $0x1,%dl
8010914b:	75 13                	jne    80109160 <loaduvm+0x60>
      panic("loaduvm: address should exist");
8010914d:	83 ec 0c             	sub    $0xc,%esp
80109150:	68 9f a5 10 80       	push   $0x8010a59f
80109155:	e8 76 73 ff ff       	call   801004d0 <panic>
8010915a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80109160:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80109163:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80109169:	25 fc 0f 00 00       	and    $0xffc,%eax
8010916e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80109175:	85 c0                	test   %eax,%eax
80109177:	74 d4                	je     8010914d <loaduvm+0x4d>
    pa = PTE_ADDR(*pte);
80109179:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010917b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
8010917e:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80109183:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80109188:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
8010918e:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80109191:	29 d9                	sub    %ebx,%ecx
80109193:	05 00 00 00 80       	add    $0x80000000,%eax
80109198:	57                   	push   %edi
80109199:	51                   	push   %ecx
8010919a:	50                   	push   %eax
8010919b:	ff 75 10             	push   0x10(%ebp)
8010919e:	e8 3d 98 ff ff       	call   801029e0 <readi>
801091a3:	83 c4 10             	add    $0x10,%esp
801091a6:	39 f8                	cmp    %edi,%eax
801091a8:	75 1e                	jne    801091c8 <loaduvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
801091aa:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
801091b0:	89 f0                	mov    %esi,%eax
801091b2:	29 d8                	sub    %ebx,%eax
801091b4:	39 c6                	cmp    %eax,%esi
801091b6:	77 80                	ja     80109138 <loaduvm+0x38>
}
801091b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801091bb:	31 c0                	xor    %eax,%eax
}
801091bd:	5b                   	pop    %ebx
801091be:	5e                   	pop    %esi
801091bf:	5f                   	pop    %edi
801091c0:	5d                   	pop    %ebp
801091c1:	c3                   	ret    
801091c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801091c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801091cb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801091d0:	5b                   	pop    %ebx
801091d1:	5e                   	pop    %esi
801091d2:	5f                   	pop    %edi
801091d3:	5d                   	pop    %ebp
801091d4:	c3                   	ret    
    panic("loaduvm: addr must be page aligned");
801091d5:	83 ec 0c             	sub    $0xc,%esp
801091d8:	68 40 a6 10 80       	push   $0x8010a640
801091dd:	e8 ee 72 ff ff       	call   801004d0 <panic>
801091e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801091e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801091f0 <allocuvm>:
{
801091f0:	55                   	push   %ebp
801091f1:	89 e5                	mov    %esp,%ebp
801091f3:	57                   	push   %edi
801091f4:	56                   	push   %esi
801091f5:	53                   	push   %ebx
801091f6:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
801091f9:	8b 45 10             	mov    0x10(%ebp),%eax
{
801091fc:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(newsz >= KERNBASE)
801091ff:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80109202:	85 c0                	test   %eax,%eax
80109204:	0f 88 b6 00 00 00    	js     801092c0 <allocuvm+0xd0>
  if(newsz < oldsz)
8010920a:	3b 45 0c             	cmp    0xc(%ebp),%eax
    return oldsz;
8010920d:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
80109210:	0f 82 9a 00 00 00    	jb     801092b0 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
80109216:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
8010921c:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
80109222:	39 75 10             	cmp    %esi,0x10(%ebp)
80109225:	77 44                	ja     8010926b <allocuvm+0x7b>
80109227:	e9 87 00 00 00       	jmp    801092b3 <allocuvm+0xc3>
8010922c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
80109230:	83 ec 04             	sub    $0x4,%esp
80109233:	68 00 10 00 00       	push   $0x1000
80109238:	6a 00                	push   $0x0
8010923a:	50                   	push   %eax
8010923b:	e8 d0 ce ff ff       	call   80106110 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80109240:	58                   	pop    %eax
80109241:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80109247:	5a                   	pop    %edx
80109248:	6a 06                	push   $0x6
8010924a:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010924f:	89 f2                	mov    %esi,%edx
80109251:	50                   	push   %eax
80109252:	89 f8                	mov    %edi,%eax
80109254:	e8 87 fb ff ff       	call   80108de0 <mappages>
80109259:	83 c4 10             	add    $0x10,%esp
8010925c:	85 c0                	test   %eax,%eax
8010925e:	78 78                	js     801092d8 <allocuvm+0xe8>
  for(; a < newsz; a += PGSIZE){
80109260:	81 c6 00 10 00 00    	add    $0x1000,%esi
80109266:	39 75 10             	cmp    %esi,0x10(%ebp)
80109269:	76 48                	jbe    801092b3 <allocuvm+0xc3>
    mem = kalloc();
8010926b:	e8 60 a3 ff ff       	call   801035d0 <kalloc>
80109270:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80109272:	85 c0                	test   %eax,%eax
80109274:	75 ba                	jne    80109230 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80109276:	83 ec 0c             	sub    $0xc,%esp
80109279:	68 bd a5 10 80       	push   $0x8010a5bd
8010927e:	e8 6d 75 ff ff       	call   801007f0 <cprintf>
  if(newsz >= oldsz)
80109283:	8b 45 0c             	mov    0xc(%ebp),%eax
80109286:	83 c4 10             	add    $0x10,%esp
80109289:	39 45 10             	cmp    %eax,0x10(%ebp)
8010928c:	74 32                	je     801092c0 <allocuvm+0xd0>
8010928e:	8b 55 10             	mov    0x10(%ebp),%edx
80109291:	89 c1                	mov    %eax,%ecx
80109293:	89 f8                	mov    %edi,%eax
80109295:	e8 96 fa ff ff       	call   80108d30 <deallocuvm.part.0>
      return 0;
8010929a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
801092a1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801092a4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801092a7:	5b                   	pop    %ebx
801092a8:	5e                   	pop    %esi
801092a9:	5f                   	pop    %edi
801092aa:	5d                   	pop    %ebp
801092ab:	c3                   	ret    
801092ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
801092b0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}
801092b3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801092b6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801092b9:	5b                   	pop    %ebx
801092ba:	5e                   	pop    %esi
801092bb:	5f                   	pop    %edi
801092bc:	5d                   	pop    %ebp
801092bd:	c3                   	ret    
801092be:	66 90                	xchg   %ax,%ax
    return 0;
801092c0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
801092c7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801092ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
801092cd:	5b                   	pop    %ebx
801092ce:	5e                   	pop    %esi
801092cf:	5f                   	pop    %edi
801092d0:	5d                   	pop    %ebp
801092d1:	c3                   	ret    
801092d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
801092d8:	83 ec 0c             	sub    $0xc,%esp
801092db:	68 d5 a5 10 80       	push   $0x8010a5d5
801092e0:	e8 0b 75 ff ff       	call   801007f0 <cprintf>
  if(newsz >= oldsz)
801092e5:	8b 45 0c             	mov    0xc(%ebp),%eax
801092e8:	83 c4 10             	add    $0x10,%esp
801092eb:	39 45 10             	cmp    %eax,0x10(%ebp)
801092ee:	74 0c                	je     801092fc <allocuvm+0x10c>
801092f0:	8b 55 10             	mov    0x10(%ebp),%edx
801092f3:	89 c1                	mov    %eax,%ecx
801092f5:	89 f8                	mov    %edi,%eax
801092f7:	e8 34 fa ff ff       	call   80108d30 <deallocuvm.part.0>
      kfree(mem);
801092fc:	83 ec 0c             	sub    $0xc,%esp
801092ff:	53                   	push   %ebx
80109300:	e8 0b a1 ff ff       	call   80103410 <kfree>
      return 0;
80109305:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010930c:	83 c4 10             	add    $0x10,%esp
}
8010930f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80109312:	8d 65 f4             	lea    -0xc(%ebp),%esp
80109315:	5b                   	pop    %ebx
80109316:	5e                   	pop    %esi
80109317:	5f                   	pop    %edi
80109318:	5d                   	pop    %ebp
80109319:	c3                   	ret    
8010931a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80109320 <deallocuvm>:
{
80109320:	55                   	push   %ebp
80109321:	89 e5                	mov    %esp,%ebp
80109323:	8b 55 0c             	mov    0xc(%ebp),%edx
80109326:	8b 4d 10             	mov    0x10(%ebp),%ecx
80109329:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010932c:	39 d1                	cmp    %edx,%ecx
8010932e:	73 10                	jae    80109340 <deallocuvm+0x20>
}
80109330:	5d                   	pop    %ebp
80109331:	e9 fa f9 ff ff       	jmp    80108d30 <deallocuvm.part.0>
80109336:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010933d:	8d 76 00             	lea    0x0(%esi),%esi
80109340:	89 d0                	mov    %edx,%eax
80109342:	5d                   	pop    %ebp
80109343:	c3                   	ret    
80109344:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010934b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010934f:	90                   	nop

80109350 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80109350:	55                   	push   %ebp
80109351:	89 e5                	mov    %esp,%ebp
80109353:	57                   	push   %edi
80109354:	56                   	push   %esi
80109355:	53                   	push   %ebx
80109356:	83 ec 0c             	sub    $0xc,%esp
80109359:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010935c:	85 f6                	test   %esi,%esi
8010935e:	74 59                	je     801093b9 <freevm+0x69>
  if(newsz >= oldsz)
80109360:	31 c9                	xor    %ecx,%ecx
80109362:	ba 00 00 00 80       	mov    $0x80000000,%edx
80109367:	89 f0                	mov    %esi,%eax
80109369:	89 f3                	mov    %esi,%ebx
8010936b:	e8 c0 f9 ff ff       	call   80108d30 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80109370:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80109376:	eb 0f                	jmp    80109387 <freevm+0x37>
80109378:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010937f:	90                   	nop
80109380:	83 c3 04             	add    $0x4,%ebx
80109383:	39 df                	cmp    %ebx,%edi
80109385:	74 23                	je     801093aa <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80109387:	8b 03                	mov    (%ebx),%eax
80109389:	a8 01                	test   $0x1,%al
8010938b:	74 f3                	je     80109380 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010938d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80109392:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
80109395:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80109398:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010939d:	50                   	push   %eax
8010939e:	e8 6d a0 ff ff       	call   80103410 <kfree>
801093a3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
801093a6:	39 df                	cmp    %ebx,%edi
801093a8:	75 dd                	jne    80109387 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
801093aa:	89 75 08             	mov    %esi,0x8(%ebp)
}
801093ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
801093b0:	5b                   	pop    %ebx
801093b1:	5e                   	pop    %esi
801093b2:	5f                   	pop    %edi
801093b3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
801093b4:	e9 57 a0 ff ff       	jmp    80103410 <kfree>
    panic("freevm: no pgdir");
801093b9:	83 ec 0c             	sub    $0xc,%esp
801093bc:	68 f1 a5 10 80       	push   $0x8010a5f1
801093c1:	e8 0a 71 ff ff       	call   801004d0 <panic>
801093c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801093cd:	8d 76 00             	lea    0x0(%esi),%esi

801093d0 <setupkvm>:
{
801093d0:	55                   	push   %ebp
801093d1:	89 e5                	mov    %esp,%ebp
801093d3:	56                   	push   %esi
801093d4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
801093d5:	e8 f6 a1 ff ff       	call   801035d0 <kalloc>
801093da:	89 c6                	mov    %eax,%esi
801093dc:	85 c0                	test   %eax,%eax
801093de:	74 42                	je     80109422 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
801093e0:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801093e3:	bb c0 d7 10 80       	mov    $0x8010d7c0,%ebx
  memset(pgdir, 0, PGSIZE);
801093e8:	68 00 10 00 00       	push   $0x1000
801093ed:	6a 00                	push   $0x0
801093ef:	50                   	push   %eax
801093f0:	e8 1b cd ff ff       	call   80106110 <memset>
801093f5:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
801093f8:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801093fb:	83 ec 08             	sub    $0x8,%esp
801093fe:	8b 4b 08             	mov    0x8(%ebx),%ecx
80109401:	ff 73 0c             	push   0xc(%ebx)
80109404:	8b 13                	mov    (%ebx),%edx
80109406:	50                   	push   %eax
80109407:	29 c1                	sub    %eax,%ecx
80109409:	89 f0                	mov    %esi,%eax
8010940b:	e8 d0 f9 ff ff       	call   80108de0 <mappages>
80109410:	83 c4 10             	add    $0x10,%esp
80109413:	85 c0                	test   %eax,%eax
80109415:	78 19                	js     80109430 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80109417:	83 c3 10             	add    $0x10,%ebx
8010941a:	81 fb 00 d8 10 80    	cmp    $0x8010d800,%ebx
80109420:	75 d6                	jne    801093f8 <setupkvm+0x28>
}
80109422:	8d 65 f8             	lea    -0x8(%ebp),%esp
80109425:	89 f0                	mov    %esi,%eax
80109427:	5b                   	pop    %ebx
80109428:	5e                   	pop    %esi
80109429:	5d                   	pop    %ebp
8010942a:	c3                   	ret    
8010942b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010942f:	90                   	nop
      freevm(pgdir);
80109430:	83 ec 0c             	sub    $0xc,%esp
80109433:	56                   	push   %esi
      return 0;
80109434:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80109436:	e8 15 ff ff ff       	call   80109350 <freevm>
      return 0;
8010943b:	83 c4 10             	add    $0x10,%esp
}
8010943e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80109441:	89 f0                	mov    %esi,%eax
80109443:	5b                   	pop    %ebx
80109444:	5e                   	pop    %esi
80109445:	5d                   	pop    %ebp
80109446:	c3                   	ret    
80109447:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010944e:	66 90                	xchg   %ax,%ax

80109450 <kvmalloc>:
{
80109450:	55                   	push   %ebp
80109451:	89 e5                	mov    %esp,%ebp
80109453:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80109456:	e8 75 ff ff ff       	call   801093d0 <setupkvm>
8010945b:	a3 64 b1 34 80       	mov    %eax,0x8034b164
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80109460:	05 00 00 00 80       	add    $0x80000000,%eax
80109465:	0f 22 d8             	mov    %eax,%cr3
}
80109468:	c9                   	leave  
80109469:	c3                   	ret    
8010946a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80109470 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80109470:	55                   	push   %ebp
80109471:	89 e5                	mov    %esp,%ebp
80109473:	83 ec 08             	sub    $0x8,%esp
80109476:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80109479:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
8010947c:	89 c1                	mov    %eax,%ecx
8010947e:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80109481:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80109484:	f6 c2 01             	test   $0x1,%dl
80109487:	75 17                	jne    801094a0 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80109489:	83 ec 0c             	sub    $0xc,%esp
8010948c:	68 02 a6 10 80       	push   $0x8010a602
80109491:	e8 3a 70 ff ff       	call   801004d0 <panic>
80109496:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010949d:	8d 76 00             	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
801094a0:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801094a3:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
801094a9:	25 fc 0f 00 00       	and    $0xffc,%eax
801094ae:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
801094b5:	85 c0                	test   %eax,%eax
801094b7:	74 d0                	je     80109489 <clearpteu+0x19>
  *pte &= ~PTE_U;
801094b9:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801094bc:	c9                   	leave  
801094bd:	c3                   	ret    
801094be:	66 90                	xchg   %ax,%ax

801094c0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801094c0:	55                   	push   %ebp
801094c1:	89 e5                	mov    %esp,%ebp
801094c3:	57                   	push   %edi
801094c4:	56                   	push   %esi
801094c5:	53                   	push   %ebx
801094c6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801094c9:	e8 02 ff ff ff       	call   801093d0 <setupkvm>
801094ce:	89 45 e0             	mov    %eax,-0x20(%ebp)
801094d1:	85 c0                	test   %eax,%eax
801094d3:	0f 84 bd 00 00 00    	je     80109596 <copyuvm+0xd6>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801094d9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801094dc:	85 c9                	test   %ecx,%ecx
801094de:	0f 84 b2 00 00 00    	je     80109596 <copyuvm+0xd6>
801094e4:	31 f6                	xor    %esi,%esi
801094e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801094ed:	8d 76 00             	lea    0x0(%esi),%esi
  if(*pde & PTE_P){
801094f0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
801094f3:	89 f0                	mov    %esi,%eax
801094f5:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
801094f8:	8b 04 81             	mov    (%ecx,%eax,4),%eax
801094fb:	a8 01                	test   $0x1,%al
801094fd:	75 11                	jne    80109510 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
801094ff:	83 ec 0c             	sub    $0xc,%esp
80109502:	68 0c a6 10 80       	push   $0x8010a60c
80109507:	e8 c4 6f ff ff       	call   801004d0 <panic>
8010950c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
80109510:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80109512:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80109517:	c1 ea 0a             	shr    $0xa,%edx
8010951a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80109520:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80109527:	85 c0                	test   %eax,%eax
80109529:	74 d4                	je     801094ff <copyuvm+0x3f>
    if(!(*pte & PTE_P))
8010952b:	8b 00                	mov    (%eax),%eax
8010952d:	a8 01                	test   $0x1,%al
8010952f:	0f 84 9f 00 00 00    	je     801095d4 <copyuvm+0x114>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80109535:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
80109537:	25 ff 0f 00 00       	and    $0xfff,%eax
8010953c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
8010953f:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80109545:	e8 86 a0 ff ff       	call   801035d0 <kalloc>
8010954a:	89 c3                	mov    %eax,%ebx
8010954c:	85 c0                	test   %eax,%eax
8010954e:	74 64                	je     801095b4 <copyuvm+0xf4>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80109550:	83 ec 04             	sub    $0x4,%esp
80109553:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80109559:	68 00 10 00 00       	push   $0x1000
8010955e:	57                   	push   %edi
8010955f:	50                   	push   %eax
80109560:	e8 4b cc ff ff       	call   801061b0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80109565:	58                   	pop    %eax
80109566:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010956c:	5a                   	pop    %edx
8010956d:	ff 75 e4             	push   -0x1c(%ebp)
80109570:	b9 00 10 00 00       	mov    $0x1000,%ecx
80109575:	89 f2                	mov    %esi,%edx
80109577:	50                   	push   %eax
80109578:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010957b:	e8 60 f8 ff ff       	call   80108de0 <mappages>
80109580:	83 c4 10             	add    $0x10,%esp
80109583:	85 c0                	test   %eax,%eax
80109585:	78 21                	js     801095a8 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
80109587:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010958d:	39 75 0c             	cmp    %esi,0xc(%ebp)
80109590:	0f 87 5a ff ff ff    	ja     801094f0 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
80109596:	8b 45 e0             	mov    -0x20(%ebp),%eax
80109599:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010959c:	5b                   	pop    %ebx
8010959d:	5e                   	pop    %esi
8010959e:	5f                   	pop    %edi
8010959f:	5d                   	pop    %ebp
801095a0:	c3                   	ret    
801095a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
801095a8:	83 ec 0c             	sub    $0xc,%esp
801095ab:	53                   	push   %ebx
801095ac:	e8 5f 9e ff ff       	call   80103410 <kfree>
      goto bad;
801095b1:	83 c4 10             	add    $0x10,%esp
  freevm(d);
801095b4:	83 ec 0c             	sub    $0xc,%esp
801095b7:	ff 75 e0             	push   -0x20(%ebp)
801095ba:	e8 91 fd ff ff       	call   80109350 <freevm>
  return 0;
801095bf:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
801095c6:	83 c4 10             	add    $0x10,%esp
}
801095c9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801095cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801095cf:	5b                   	pop    %ebx
801095d0:	5e                   	pop    %esi
801095d1:	5f                   	pop    %edi
801095d2:	5d                   	pop    %ebp
801095d3:	c3                   	ret    
      panic("copyuvm: page not present");
801095d4:	83 ec 0c             	sub    $0xc,%esp
801095d7:	68 26 a6 10 80       	push   $0x8010a626
801095dc:	e8 ef 6e ff ff       	call   801004d0 <panic>
801095e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801095e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801095ef:	90                   	nop

801095f0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801095f0:	55                   	push   %ebp
801095f1:	89 e5                	mov    %esp,%ebp
801095f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
801095f6:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
801095f9:	89 c1                	mov    %eax,%ecx
801095fb:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
801095fe:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80109601:	f6 c2 01             	test   $0x1,%dl
80109604:	0f 84 00 01 00 00    	je     8010970a <uva2ka.cold>
  return &pgtab[PTX(va)];
8010960a:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010960d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80109613:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
80109614:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
80109619:	8b 84 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%eax
  if((*pte & PTE_U) == 0)
80109620:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80109622:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80109627:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
8010962a:	05 00 00 00 80       	add    $0x80000000,%eax
8010962f:	83 fa 05             	cmp    $0x5,%edx
80109632:	ba 00 00 00 00       	mov    $0x0,%edx
80109637:	0f 45 c2             	cmovne %edx,%eax
}
8010963a:	c3                   	ret    
8010963b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010963f:	90                   	nop

80109640 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80109640:	55                   	push   %ebp
80109641:	89 e5                	mov    %esp,%ebp
80109643:	57                   	push   %edi
80109644:	56                   	push   %esi
80109645:	53                   	push   %ebx
80109646:	83 ec 0c             	sub    $0xc,%esp
80109649:	8b 75 14             	mov    0x14(%ebp),%esi
8010964c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010964f:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80109652:	85 f6                	test   %esi,%esi
80109654:	75 51                	jne    801096a7 <copyout+0x67>
80109656:	e9 a5 00 00 00       	jmp    80109700 <copyout+0xc0>
8010965b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010965f:	90                   	nop
  return (char*)P2V(PTE_ADDR(*pte));
80109660:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80109666:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
8010966c:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
80109672:	74 75                	je     801096e9 <copyout+0xa9>
      return -1;
    n = PGSIZE - (va - va0);
80109674:	89 fb                	mov    %edi,%ebx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80109676:	89 55 10             	mov    %edx,0x10(%ebp)
    n = PGSIZE - (va - va0);
80109679:	29 c3                	sub    %eax,%ebx
8010967b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80109681:	39 f3                	cmp    %esi,%ebx
80109683:	0f 47 de             	cmova  %esi,%ebx
    memmove(pa0 + (va - va0), buf, n);
80109686:	29 f8                	sub    %edi,%eax
80109688:	83 ec 04             	sub    $0x4,%esp
8010968b:	01 c1                	add    %eax,%ecx
8010968d:	53                   	push   %ebx
8010968e:	52                   	push   %edx
8010968f:	51                   	push   %ecx
80109690:	e8 1b cb ff ff       	call   801061b0 <memmove>
    len -= n;
    buf += n;
80109695:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
80109698:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
8010969e:	83 c4 10             	add    $0x10,%esp
    buf += n;
801096a1:	01 da                	add    %ebx,%edx
  while(len > 0){
801096a3:	29 de                	sub    %ebx,%esi
801096a5:	74 59                	je     80109700 <copyout+0xc0>
  if(*pde & PTE_P){
801096a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
801096aa:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
801096ac:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
801096ae:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
801096b1:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
801096b7:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
801096ba:	f6 c1 01             	test   $0x1,%cl
801096bd:	0f 84 4e 00 00 00    	je     80109711 <copyout.cold>
  return &pgtab[PTX(va)];
801096c3:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801096c5:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
801096cb:	c1 eb 0c             	shr    $0xc,%ebx
801096ce:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
801096d4:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
801096db:	89 d9                	mov    %ebx,%ecx
801096dd:	83 e1 05             	and    $0x5,%ecx
801096e0:	83 f9 05             	cmp    $0x5,%ecx
801096e3:	0f 84 77 ff ff ff    	je     80109660 <copyout+0x20>
  }
  return 0;
}
801096e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801096ec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801096f1:	5b                   	pop    %ebx
801096f2:	5e                   	pop    %esi
801096f3:	5f                   	pop    %edi
801096f4:	5d                   	pop    %ebp
801096f5:	c3                   	ret    
801096f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801096fd:	8d 76 00             	lea    0x0(%esi),%esi
80109700:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80109703:	31 c0                	xor    %eax,%eax
}
80109705:	5b                   	pop    %ebx
80109706:	5e                   	pop    %esi
80109707:	5f                   	pop    %edi
80109708:	5d                   	pop    %ebp
80109709:	c3                   	ret    

8010970a <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
8010970a:	a1 00 00 00 00       	mov    0x0,%eax
8010970f:	0f 0b                	ud2    

80109711 <copyout.cold>:
80109711:	a1 00 00 00 00       	mov    0x0,%eax
80109716:	0f 0b                	ud2    
