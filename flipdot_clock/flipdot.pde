/* FlipDot class

Class to encapsulate communication with the FlipDot display

- Notes
  - Any coordinates passed to this class assume 1 as the starting value. However the internal buffer array starts at 0.

- Todo
  - Address properly single and multiple Flipdot displays. Currently we send the same instructions to all displays in the array.
  - Add some more interesting methods, roll display, 2 planes.

*/

// Include Serial libraries
import processing.serial.*;

class FlipDot {

  // Serial connection
  Serial myPort;
  int serialport=0;
  // Serial connection details hard coded here to match those of the Flipdot controller
  int baudrate=57600;
  char parity = 'N';
  int dataBits = 8;
  float stopBits = 1.0;

  // Buffer. 2D array representation of the Flipdot display. Dimensions set in Class constructor
  boolean[][] buffer;
  int flipdot_width=0;
  int flipdot_height=0;

  // Constructor
  FlipDot(PApplet Parent , int c_flipdot_width , int c_flipdot_height , int c_serialport) {

    // Create buffer
    flipdot_width=c_flipdot_width;
    flipdot_height=c_flipdot_height;
    buffer = new boolean[flipdot_width][flipdot_height];

    // Open Serial line
    serialport=c_serialport;
    myPort = new Serial(Parent,Serial.list()[serialport],baudrate,parity,dataBits,stopBits);

    // Zero buffer
    this.reset(false);
  }

  // Set a single bit in the buffer to either on or off.
  boolean setbit(int c_x , int c_y , boolean state) {
    // Adjust for zero starting buffer array
    c_x--;
    c_y--;
    if((c_x > -1) && (c_x < flipdot_width) && (c_y > -1) && (c_y < flipdot_height)) {
      buffer[c_x][c_y]=state;
      return true;
    } else {
      return false;
    }
  }

  // Boolean not the bit at x , y
  boolean setbitnot(int x , int y) {
    // Adjust for zero starting buffer array
    x--;
    y--;
    if((x > -1) && (x < flipdot_width) && (y > -1) && (y < flipdot_height)) {
      buffer[x][y]=!buffer[x][y];
      return true;
    } else {
      return false;
    }
  }

  // Reset buffer to either all on (true) or all off (false)
  // Doesn't display, caller responsible for that by calling the display() method
  void reset(boolean state) {
    for(int x=0;x<flipdot_width;x++) {
      for(int y=0;y<flipdot_height;y++) {
        buffer[x][y]=state;
      }
    }
  }

  // Apply the array passed onto the buffer array
  void drawpartial(int[][] thearray,int x , int y){
    for( int iy=0 ; iy < thearray.length ; iy++ ) {
      for( int ix=0 ; ix < thearray[iy].length ; ix++ ) {
        if(thearray[iy][ix]==1) {
          buffer[x+ix][y+iy]=true;
        } else {
          buffer[x+ix][y+iy]=false;
        }
      }
    }
  }

  // Send buffer values to the actual display
  void display() {

    // 'Binary' string
    String binarystring="";
    int intvalue=0;

    // Header
    myPort.write(0x80);
    // Refresh
    myPort.write(0x83);
    // Panel address
    myPort.write(0xFF);

    // Step through the buffer, one column at a time, converting each string of
    // 7 bits to a hex value
    for(int x=0;x<flipdot_width;x++) {
      binarystring="";
      for(int y=flipdot_height-1;y>=0;y--) {
        if(buffer[x][y]) {
          binarystring = binarystring + '1';
        } else {
          binarystring = binarystring + '0';
        }
      }

      // Translate binary to hex
      intvalue = unbinary(binarystring);
      // Write
      myPort.write(intvalue);

    }
    // End message
    myPort.write(0x8F);

  }

  // Debug functions
  void _dumpbuffer() {
    for(int y=0;y<flipdot_height;y++) {
      for(int x=0;x<flipdot_width;x++) {
        if(buffer[x][y]) {
          print("1");
        } else {
          print("0");
        }
      }
      println();
    }
  }

}