// Flipdot Clock

FlipDot theflipdot;
int flipdot_serialport=1;
int flipdot_width=28;
int flipdot_height=7;

boolean state;

boolean left=true;

// Define the digits
int[][] char_1 = {  {0,0,1,0,0},
                    {0,1,1,0,0},
                    {1,0,1,0,0},
                    {0,0,1,0,0},
                    {0,0,1,0,0},
                    {0,0,1,0,0},
                    {1,1,1,1,1} };

int[][] char_2 = {  {0,1,1,1,0},
                    {1,0,0,0,1},
                    {0,0,0,0,1},
                    {0,0,1,1,0},
                    {0,1,0,0,0},
                    {1,0,0,0,0},
                    {1,1,1,1,1} };

int[][] char_3 = {  {0,1,1,1,0},
                    {1,0,0,0,1},
                    {0,0,0,0,1},
                    {0,0,1,1,0},
                    {0,0,0,0,1},
                    {1,0,0,0,1},
                    {0,1,1,1,0} };

int[][] char_4 = {  {0,0,0,1,0},
                    {0,0,1,1,0},
                    {0,1,0,1,0},
                    {1,0,0,1,0},
                    {1,1,1,1,1},
                    {0,0,0,1,0},
                    {0,0,0,1,0} };

int[][] char_5 = {  {1,1,1,1,1},
                    {1,0,0,0,0},
                    {1,1,1,1,0},
                    {0,0,0,0,1},
                    {0,0,0,0,1},
                    {1,0,0,0,1},
                    {0,1,1,1,0} };

int[][] char_6 = {  {0,1,1,1,0},
                    {1,0,0,0,1},
                    {1,0,0,0,0},
                    {1,1,1,1,0},
                    {1,0,0,0,1},
                    {1,0,0,0,1},
                    {0,1,1,1,0} };

int[][] char_7 = {  {1,1,1,1,1},
                    {0,0,0,0,1},
                    {0,0,0,1,0},
                    {0,0,1,0,0},
                    {0,0,1,0,0},
                    {0,0,1,0,0},
                    {0,0,1,0,0} };

int[][] char_8 = {  {0,1,1,1,0},
                    {1,0,0,0,1},
                    {1,0,0,0,1},
                    {0,1,1,1,0},
                    {1,0,0,0,1},
                    {1,0,0,0,1},
                    {0,1,1,1,0} };

int[][] char_9 = {  {0,1,1,1,0},
                    {1,0,0,0,1},
                    {1,0,0,0,1},
                    {0,1,1,1,1},
                    {0,0,0,0,1},
                    {1,0,0,0,1},
                    {0,1,1,1,0} };

int[][] char_0 = {  {0,1,1,1,0},
                    {1,0,0,0,1},
                    {1,0,0,1,1},
                    {1,0,1,0,1},
                    {1,1,0,0,1},
                    {1,0,0,0,1},
                    {0,1,1,1,0} };

int[][] char_colon_left = {  {0,0},
                             {0,0},
                             {1,0},
                             {0,0},
                             {1,0},
                             {0,0},
                             {0,0} };

int[][] char_colon_right = { {0,0},
                             {0,0},
                             {0,1},
                             {0,0},
                             {0,1},
                             {0,0},
                             {0,0} };

void setup () {

  // Prep the flipdot display
  theflipdot = new FlipDot(this,flipdot_width,flipdot_height,flipdot_serialport);
  theflipdot.reset(false);
  theflipdot.display();

}

void draw() {

  int the_hour=hour();
  int the_minute=minute();
  int the_second=second();

  int hour_digit_1;
  int hour_digit_2;
  int minute_digit_1;
  int minute_digit_2;

  println("the_second: "+the_second);

  hour_digit_1=int(nf(the_hour,2).substring(0,1));
  hour_digit_2=int(nf(the_hour,2).substring(1,2));
  minute_digit_1=int(nf(the_minute,2).substring(0,1));
  minute_digit_2=int(nf(the_minute,2).substring(1,2));

  drawnumber(hour_digit_1,1);
  drawnumber(hour_digit_2,2);
  if(left){
    theflipdot.drawpartial(char_colon_left,13,0);
  } else {
    theflipdot.drawpartial(char_colon_right,13,0);
  }
  drawnumber(minute_digit_1,3);
  drawnumber(minute_digit_2,4);

  left=!left;

  delay(1000);

}

// Draw a number 'digit' at offset 'pos'
void drawnumber(int digit, int pos) {

  int offset=0;

  switch(pos) {
    case 1:
      offset=1;
      break;
    case 2:
      offset=7;
      break;
    case 3:
      offset=16;
      break;
    case 4:
      offset=22;
      break;
    default:
      printdebug("Function drawnumber got an unsupported pos: "+pos);
      break;
  }

  switch(digit) {
    case 0:
      theflipdot.drawpartial(char_0,offset,0);
      break;
    case 1:
      theflipdot.drawpartial(char_1,offset,0);
      break;
    case 2:
      theflipdot.drawpartial(char_2,offset,0);
      break;
    case 3:
      theflipdot.drawpartial(char_3,offset,0);
      break;
    case 4:
      theflipdot.drawpartial(char_4,offset,0);
      break;
    case 5:
      theflipdot.drawpartial(char_5,offset,0);
      break;
    case 6:
      theflipdot.drawpartial(char_6,offset,0);
      break;
    case 7:
      theflipdot.drawpartial(char_7,offset,0);
      break;
    case 8:
      theflipdot.drawpartial(char_8,offset,0);
      break;
    case 9:
      theflipdot.drawpartial(char_9,offset,0);
      break;
    default:
      println("got unsupported digit: "+digit);
      break;
  }

  theflipdot.display();

}

void printdebug(String message) {
  println("Debug : "+message);
}