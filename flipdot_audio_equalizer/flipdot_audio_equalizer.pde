// Attempt at a 'graphic equalizer'
//
// mp3 file needs to be placed into the same dir as the code
//
// A lot of tidying up to do, the values are a bit all over the place, and the code needs a bit of a refactor
//
// Alexander Dyas

// Serial port
import processing.serial.*;
import processing.sound.*;
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

FFT fft;
//AudioIn audioin;
int bands = 32;
float[] spectrum = new float[bands];
SoundFile disp;

void setup() {

  // Open the serial port
  myPort = new Serial(this, Serial.list()[serialport], baud);

  disp = new SoundFile(this, "file_example_MP3_700KB.mp3");
  disp.play();
  fft = new FFT(this, bands);
  fft.input(disp);

}

void draw() {

  float value;
  int scaledvalue;
  float oldrange;
  float oldmax=0.1;
  float oldmin=0.0;
  float newrange;
  float newmax=7.0;
  float newmin=0.0;

  fft.analyze(spectrum);

  // Start message
  myPort.write(0x80);
  // With refresh
  myPort.write(0x83);
  // Broadcast to all displays in the array
  myPort.write(0xFF);

  oldrange = (oldmax - oldmin);
  newrange = (newmax - newmin);

  for(int band = 1; band < 29; band++) {

    value=spectrum[band];
    scaledvalue = int((((value - oldmin) * newrange) / oldrange) + newmin);

    switch(scaledvalue) {
      case 1:
        myPort.write(0x01);
        break;
      case 2:
        myPort.write(0x03);
        break;
      case 3:
        myPort.write(0x07);
        break;
      case 4:
        myPort.write(0x0F);
        break;
      case 5:
        myPort.write(0x1F);
        break;
      case 6:
        myPort.write(0x3F);
        break;
      case 7:
        myPort.write(0x7F);
        break;
      default:
        myPort.write(0x00);
        println("Out of range"+scaledvalue);
    }

  }
  // End message
  myPort.write(0x8F);

}
