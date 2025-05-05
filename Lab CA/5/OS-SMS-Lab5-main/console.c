// Console input and output.
// Input is from the keyboard or serial port.
// Output is written to the screen and serial port.

#include "types.h"
#include "defs.h"
#include "param.h"
#include "traps.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "fs.h"
#include "file.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "x86.h"

// ----------------------------------------
#define INPUT_BUF 128

// variables related to the NON=? feature
#define PRECISION 2
#define isdigit(c) (c >= '0' && c <= '9') // determine if an input char is digit or not
const int math_exp_len = 5;

// variables related to the ctrl+s / ctrl+f feature
static int copybuf[INPUT_BUF]; // buffer to store the copied inputs
static int copying = 0;  // flag to check if copying is active
static int insert_copied_commands = 0; // activated after ctrl+f until all the copied commands are runned
static int current_copied_command_to_run_idx = 0; // index of current copied command ro run
static int num_copied_commands = 0;  // length of the copied content

#define KEY_UP          0xE2
#define KEY_DN          0xE3
#define KEY_LF          0xE4
#define KEY_RT          0xE5 /*Finding keys hex code from kbd.h file*/

#define HISTORY "history"

#define MAX_NUM_OF_HISTORY 10
#define MAX_LEN_OF_COMMAND 128

char command_history [MAX_NUM_OF_HISTORY][MAX_LEN_OF_COMMAND];
int command_id = 0;
int num_of_stored_commands = 0;
// ----------------------------------------


static void consputc(int);

static int panicked = 0;

static struct {
  struct spinlock lock;
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
  else
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
    consputc(buf[i]);
}
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    if(c != '%'){
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
      consputc(c);
      break;
    }
  }

  if(locking)
    release(&cons.lock);
}

void
panic(char *s)
{
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
  for(;;)
    ;
}

//PAGEBREAK: 50
#define BACKSPACE 0x100
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

// ----------------------------------
void
move_cursor_left()
{
  int cursor_position;

  outb(CRTPORT, 14);                  
  cursor_position = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  cursor_position = cursor_position | inb(CRTPORT+1);/*Finding current position of cursor*/

  cursor_position = cursor_position - 1; /*Moving cursor one step back*/

  outb(CRTPORT, 15);
  outb(CRTPORT+1, (unsigned char)(cursor_position & 0xFF));
  outb(CRTPORT, 14);
  outb(CRTPORT+1, (unsigned char)((cursor_position>>8) & 0xFF)); /*Reset cursor*/
}
// ----------------------------------

// ----------------------------------
void
move_cursor_right()
{
  int cursor_position;

  outb(CRTPORT, 14);                  
  cursor_position = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  cursor_position = cursor_position | inb(CRTPORT+1);/*Finding current position of cursor*/

  cursor_position = cursor_position + 1; /*Moving cursor one step forward*/

  outb(CRTPORT, 15);
  outb(CRTPORT+1, (unsigned char)(cursor_position & 0xFF));
  outb(CRTPORT, 14);
  outb(CRTPORT+1, (unsigned char)((cursor_position>>8) & 0xFF)); /*Reset cursor*/
}
// ----------------------------------

static void
cgaputc(int c)
{
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
  }

  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
}

int num_of_backs = 0;

void
consputc(int c)
{
  if(panicked){
    cli();
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}

#define INPUT_BUF 128
struct {
  uint position; //real cursor position = row * 80 + position 
  char buf[INPUT_BUF];
  uint r;  // Read index
  uint w;  // Write index
  uint e;  // Edit index
} input;

#define C(x)  ((x)-'@')  // Control-x

// ----------------------------------
void remove_chars(int back_counter)
{
  int cursor_position;

  outb(CRTPORT, 14);                  
  cursor_position = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  cursor_position = cursor_position | inb(CRTPORT+1);/*Finding current position of cursor*/

  for(int i = cursor_position -1 ; i <= cursor_position + back_counter; i++)
  {
    crt[i] = crt[i+1];
  }
  //crt[cursor_position] = ' ' | 0x0700;/*move back crt buffer*/  

  cursor_position = cursor_position - 1; /*Moving cursor one step back*/

  outb(CRTPORT, 15);
  outb(CRTPORT+1, (unsigned char)(cursor_position & 0xFF));
  outb(CRTPORT, 14);
  outb(CRTPORT+1, (unsigned char)((cursor_position>>8) & 0xFF)); /*Reset cursor*/
  crt[cursor_position+back_counter] = ' ' | 0x0700;
}
// ----------------------------------

// ----------------------------------
void insert_chars(int back_counter,int c)
{
  int current_position;

  // get cursor position
  outb(CRTPORT, 14);                  
  current_position = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  current_position |= inb(CRTPORT+1);

  
  for(int i = current_position + back_counter; i >= current_position; i--)
  {
    crt[i+1] = crt[i];
  }
  crt[current_position] = (c&0xff) | 0x0700;/*move back crt buffer*/  

  current_position += 1;/*Updating cursor position*/

  outb(CRTPORT, 14);
  outb(CRTPORT+1, current_position>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, current_position);
  crt[current_position+back_counter] = ' ' | 0x0700;/*Reset cursor*/
}
// ----------------------------------

// ----------------------------------
void add_history(char *command)
{
  if((command[0]!='\0'))
  {
    int length = strlen(command) <= MAX_LEN_OF_COMMAND ? strlen(command) : MAX_LEN_OF_COMMAND - 1;

    if(num_of_stored_commands < MAX_NUM_OF_HISTORY)
    {
      num_of_stored_commands++;
    }
    else
    {
    //Move back
      for(int i = 0; i < MAX_NUM_OF_HISTORY - 1; i++)
      {
        memmove(command_history[i], command_history[i+1], sizeof(char)* MAX_LEN_OF_COMMAND);
      }   
    }
    //store
    memmove(command_history[num_of_stored_commands-1], command, sizeof(char)* length);
    command_history[num_of_stored_commands-1][length] = '\0';
    command_id = num_of_stored_commands - 1;
  }
}
// ----------------------------------

// ----------------------------------
// The function below looks for patterns of form NON=? in the input line
int detect_math_expression(char c) {
  if (c == '?' && input.buf[(input.position-1) % INPUT_BUF] == '=') {
    if (isdigit(input.buf[(input.position-2) % INPUT_BUF])) {
      char operator = input.buf[(input.position-3) % INPUT_BUF];
      if ((operator == '+') || (operator == '-') || (operator == '*') || (operator == '/')) {
        if (isdigit(input.buf[(input.position-4) % INPUT_BUF])) {
          return 1;
        }
      }
    }
  }
  return 0;
}
// ----------------------------------

// ----------------------------------
// The function below consists of two parts
//     1. Decoding the mathematical expression
//     2. Calculating the result
float calculate_result_math_expression(int* is_divide) {
  char operator = input.buf[(input.position-3) % INPUT_BUF];
  float first_operand = input.buf[(input.position-4) % INPUT_BUF] - '0';
  float second_operand = input.buf[(input.position-2) % INPUT_BUF] - '0';
  float result = 0;

  switch (operator) {
    case '+':
      result = first_operand + second_operand;
      break;
    case '-':
      result = first_operand - second_operand;
      break;     
    case '*':
      result = first_operand * second_operand;    
      break; 
    case '/':
      result = first_operand / second_operand;
      *is_divide = 1;
      break;            
    default:
      break;
  }

  return result;
}
// ----------------------------------

// ----------------------------------
// The function below converts integer result to its string representation 
// precision is the number of fractional digits we care about
int float_to_str(float result, char* res_str, int precision) {
  int res_len = 0;
  int is_neg = 0;
  int is_less_than_one = 0;

  if (result == 0) {
    res_str[res_len] = '0';
    res_len += 1;
  } else {
      if (result < 0) {
        is_neg = 1;
        result = -result;
      }
      if ((result > 0) && (result < 1)) {
        is_less_than_one = 1;
      }
      // shift the number by the given number of digits
      for (int i=0; i<precision; i++) {
        result *= 10;
      }
      int temp_result = result;
      int point = 0;
      do {
        if (point == precision) {
          res_str[res_len] = '.';
          res_len += 1;
        } else {
          res_str[res_len] = (temp_result % 10) + '0';
          res_len += 1;
          temp_result /= 10;
        }
        point++;
      } while (temp_result > 0);
  }

  if (is_less_than_one) {
    res_str[res_len] = '.';
    res_len += 1;
    res_str[res_len] = '0';
    res_len += 1;
  }

  if (is_neg) {
    res_str[res_len] = '-';
    res_len += 1;
  }

  // Reverse the string
  for (int i = 0; i < res_len / 2; ++i) {
    char temp = res_str[i];
    res_str[i] = res_str[res_len - i - 1];
    res_str[res_len - i - 1] = temp;
  }

  // for (int i = 0; i < res_len; i++) {
  //   input.buf[input.position % INPUT_BUF] = res_str[i];
  //   input.e++;
  //   input.position++;
  //   consputc(res_str[i]);
  // }
  return res_len;
}
// ----------------------------------

// ----------------------------------
// The function below converts integer result to its string representation 
int int_to_str(int result, char* res_str) {
  int res_len = 0;
  int is_neg = 0;

  if (result == 0) {
    res_str[res_len] = '0';
    res_len += 1;
  } else {
      if (result < 0) {
        is_neg = 1;
        result = -result;
      }
      int temp_result = result;
      do {
        res_str[res_len] = (temp_result % 10) + '0';
        res_len += 1;
        temp_result /= 10;
        }
      while (temp_result > 0);

  }

  if (is_neg) {
    res_str[res_len] = '-';
    res_len += 1;
  }

  // Reverse the string
  for (int i = 0; i < res_len / 2; ++i) {
    char temp = res_str[i];
    res_str[i] = res_str[res_len - i - 1];
    res_str[res_len - i - 1] = temp;
  }

  // for (int i = 0; i < res_len; i++) {
  //   input.buf[input.position % INPUT_BUF] = res_str[i];
  //   input.e++;
  //   input.position++;
  //   consputc(res_str[i]);
  // }
  return res_len;
}
// ----------------------------------

// ----------------------------------
// A function to store the current command
void store_command(int c) {
  if (num_copied_commands < INPUT_BUF) {  
    copybuf[num_copied_commands] = c; // save the current command
    num_copied_commands++; // increase the number of copied commands by 1
  }
  return;
}
// ----------------------------------


void
consoleintr(int (*getc)(void))
{
  int temp_c, doprocdump = 0;

  char current_command[MAX_LEN_OF_COMMAND];

  acquire(&cons.lock);
  while(((temp_c = getc()) >= 0) || (insert_copied_commands)){
    // determine if the next command to run is a new command or one of the copied commands
    int c = 0;
    if (insert_copied_commands) {
      c = copybuf[current_copied_command_to_run_idx];
      current_copied_command_to_run_idx++;
    } else {
      c = temp_c;
    }

    if (current_copied_command_to_run_idx == (num_copied_commands - 1)) {
        insert_copied_commands = 0; // turn off this signal
    }

    switch(c){
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      if (!copying) {
        while(input.e != input.w &&
              input.buf[(input.e-1) % INPUT_BUF] != '\n'){
          input.e--;
          consputc(BACKSPACE);
        }
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if (copying) {
        store_command(c);
      } else {
        if(input.e != input.w && input.position > input.r){
          input.e--;
          input.position--;
          remove_chars(num_of_backs);
          //consputc(BACKSPACE);
        }
      }
      break;

    case KEY_LF:
      if (copying) {
        store_command(c);
      } else {
        if(input.position > input.r) /*Checking that we are not at first of the line*/
        {
          input.position = input.position - 1;/*Fixing position of current state*/
          num_of_backs += 1; /*With each left movement we calculate how much do we go back*/
          move_cursor_left();
        }
      }
      break;

    case KEY_RT:
      if (copying) {
        store_command(c);
      } else {
        if(input.position < input.e) /*Checking that we are not at end of the line*/
        {
          input.position = input.position + 1;/*Fixing position of current state*/
          num_of_backs -= 1; /*With each left movement we calculate how much do we go back*/
          move_cursor_right();
        }
      }
      break;
       
    case KEY_UP:
      if (!copying) {
        if(command_id >= 0) /*We need to have a command in order to press up and see history*/
        {
          //Move cursor to most right position
          for(int i=input.position; i < input.e; i++)
          {
            move_cursor_right();
          }

          //clear current input
          while(input.e > input.w)
          {
            input.e--;
            remove_chars(0);
          }

          //show previous command
          int letter;
          for(int i=0; i < strlen(command_history[command_id]); i++)
          {
            letter = command_history[command_id][i];
            consputc(letter);
            input.buf[input.e++] = letter;
          }
          command_id --;
          input.position = input.e;
        }
      }
      break;
    
    case KEY_DN:
      if (!copying) {
        if(command_id < num_of_stored_commands - 1)/*Locating the last command in order to have a boundary*/
        {
          //move cursor to most right position
          for(int i=input.position; i < input.e; i++)
          {
            move_cursor_right();
          }
          
          //clear current input
          while(input.e > input.w)
          {
            input.e--;
            remove_chars(0);
          }

          //show next command
          int letter;
          command_id ++;
          for(int i=0; i < strlen(command_history[command_id]); i++)
          {
            letter = command_history[command_id][i];
            consputc(letter);
            input.buf[input.e++] = letter;
          }
          input.position = input.e;
        }
      }
      break;

    // ----------------------------------------
    case C('S'):  // Start copying on Ctrl+S
      copying = 1; // enable copying flag
      num_copied_commands = 0;
      insert_copied_commands = 0;
      break;
    case C('F'):  // Paste copied content on Ctrl+F
      copying = 0; // disable copying flag
      insert_copied_commands = 1; // send the signal to start running the copied commands
      current_copied_command_to_run_idx = 0; // set the idx to zero
      break;

    // ----------------------------------------
    default:
      if (copying) {
        store_command(c);
      } else {
        if(c != 0 && input.e-input.r < INPUT_BUF) {
          // Check for pattern "NON=?"
          int is_divide = 0;
          int is_math_expression = detect_math_expression(c);
          char res_str[12];
          int res_len = 0;

          if (is_math_expression) {
            float result = calculate_result_math_expression(&is_divide);
            if (!is_divide) {
              res_len = int_to_str((int)result, res_str);
            } else {
              res_len = float_to_str(result, res_str, PRECISION);
            }

            // Clear the input buffer for this expression
            for(int i = 0; i < math_exp_len-1; i++) {
              input.e--;
              input.position--;
              consputc(BACKSPACE);
              // remove_chars(num_of_backs);
            }
            

            // Put the result on console
            for (int i = 0; i < res_len; i++) {
              input.buf[input.position % INPUT_BUF] = res_str[i];
              input.e++;
              input.position++;
              consputc(res_str[i]);
            }
          } else {
            c = (c == '\r') ? '\n' : c;     
            if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF)
            {
              input.buf[input.e++ % INPUT_BUF] = c;
              consputc(c); /*This part went from outside the if to inside due to a bug in repetition*/

              num_of_backs = 0; /*Set num of back to 0*/


              /*copy the command*/
              for(int i=input.w, j=0; i < input.e-1; i++, j++)
              {
                current_command[j] = input.buf[i % INPUT_BUF];
              }
              current_command[(input.e-1-input.w) % INPUT_BUF] = '\0';

              //distinguish_command(current_command);

              add_history(current_command);/*Add history*/

              /*Making the position of the cursor and process*/
              input.w = input.e;
              input.position = input.e;
              wakeup(&input.r);
            }
            else {
              if(num_of_backs == 0) {
                  input.buf[input.e++ % INPUT_BUF] = c;
                  input.position ++;
                  consputc(c);/*Output*/
              } else {
                for(int i=input.e; i > input.position; i--)
                {
                  input.buf[(i + 1) % INPUT_BUF] = input.buf[(i) % INPUT_BUF];
                }

                //insert
                input.buf[input.position % INPUT_BUF] = c;

                input.e++;
                input.position++;

                insert_chars(num_of_backs,c);
              }

            }
            //if(command_history[])
          }
        }
      }
      break;
    }
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
  uint target;
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
    consputc(buf[i] & 0xff);
  release(&cons.lock);
  ilock(ip);

  return n;
}

void
consoleinit(void)
{
  initlock(&cons.lock, "console");

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
}

