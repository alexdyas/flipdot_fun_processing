// Bouncing ball demo
// Alexander Dyas

// Serial port
import processing.serial.*;
Serial myPort;     
// Change this to your serial port.
// Use
//   printArray(Serial.list());
// to help find it
int serialport=1;
int baud=57600;

// Start ball somewhere in the grid
int xpos=2;
int ypos=3;

// What direction the ball is going in
int xdirection=1;
int ydirection=1;

// 
int xmax=28;
int ymax=7;

void setup() {

  // Open the serial port
  myPort = new Serial(this, Serial.list()[serialport], baud);

}

void draw() {

  // Header
  myPort.write(0x80);
  myPort.write(0x83);
  // Panel address
  myPort.write(0xFF);

  // Make all the columns before the ball black
  for(int count=1;count<xpos;count++) {
    myPort.write(0x00);
  }
  // Bit to light up in 7 bits
  switch(ypos) {
    case 1:
      myPort.write(0x01);    
      break;
    case 2:
      myPort.write(0x02);        
      break;
    case 3:
      myPort.write(0x04);    
      break;
    case 4:
      myPort.write(0x08);    
      break;
    case 5:
      myPort.write(0x10);    
      break;
    case 6:
      myPort.write(0x20);    
      break;
    case 7:
      myPort.write(0x40);    
      break;
    default:
      println("Eh?");
  }
  // Make all the columns after the ball black
  for(int count=xpos+1;count<=28;count++) {
    myPort.write(0x00);
  }
  // End message
  myPort.write(0x8F);
  
  // Change direction if we've reached a wall
  if(xpos==xmax) {
    xdirection=-1;
  }
  if(xpos==1) {
    xdirection=1;
  }
  if(ypos==ymax) {
    ydirection=-1;
  }
  if(ypos==1) {
    ydirection=1;
  }

  // Advance ball
  xpos=xpos+xdirection;
  ypos=ypos+ydirection;
 
  // Don't go too fast
  delay(100);

}
