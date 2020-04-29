// Follow the mouse on Flipdot display
// Draw a grid on the screen, then flip the dot corresponding to the coordinates the mouse is in 

// Serial port
import processing.serial.*;
Serial myPort;     
// Change this to your serial port.
// Use
//   printArray(Serial.list());
// to help find it
int serialport=1;
int baud=57600;

// Size of square for computer display grid
int squaresize=20;

// Width limit
int xmax=28;
// Height limit
int ymax=7;

void setup() {
  
  // Open the serial port
  myPort = new Serial(this, Serial.list()[serialport], baud);
  
  // Set up screen
  size(600,200);
  background(153);

  // Draw grid
  for(int x=0;x<xmax;x++) {
    for(int y=0;y<ymax;y++) {
      rect(x*squaresize,y*squaresize,squaresize,squaresize);
    }
  }
    
}

void draw() {
  
  // Calculated ot position 
  int xpos;
  int ypos;
  
  xpos=(mouseX/squaresize)+1;
  ypos=(mouseY/squaresize)+1;
  
  // Write to display
  
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
  for(int count=xpos+1;count<=xmax;count++) {
    myPort.write(0x00);
  }
  // End message
  myPort.write(0x8F);

}
