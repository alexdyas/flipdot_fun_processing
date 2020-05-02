// Script for sending a 'bar' of dots down a 28x7 Flipdot display continuously
// Meant to test basic physical and programmatic communication with the FlipDot
// display
//
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

// Width limit
int xmax=28;
// Height limit
int ymax=7;

void setup() { //<>//

  // Open the serial port
  myPort = new Serial(this, Serial.list()[serialport], baud);
  
}

void draw() {

  // Move down the display width wise
  for(int x=1;x<xmax+1;x++) {
    // Start message
    myPort.write(0x80);
    // With refresh
    myPort.write(0x83);
    // Broadcast to all displays in the array
    myPort.write(0xFF); 
    // Make all the columns before the ball black
    for(int before=1;before<x;before++) {
      myPort.write(0x00);
    }
    // Write the bar
    myPort.write(0x7F); 
    // Make all the columns after the ball black
    for(int after=x+1;after<xmax+1;after++) {
      myPort.write(0x00); 
    }
    // End message
    myPort.write(0x8F);
    // Don't go too fast
    delay(100);
  }
  
}
