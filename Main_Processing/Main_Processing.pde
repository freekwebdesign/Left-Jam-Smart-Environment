/* LEFT JAM
   Mood Station TM */

/* Initial setup files */
import processing.serial.*;
Serial port;

/* Tijmen */

/* Luuk */

/* Freek */

/* Jop */

void setup(){
/* Initial setup files */
  println("Available serial ports:");
  println(Serial.list());
  port = new Serial(this, Serial.list()[0], 9600);  // Open the port that the Arduino board is connected to, at 9600 baud
  
/* Tijmen */

/* Luuk */

/* Freek */

/* Jop */

}

void draw(){
/* Tijmen */

/* Luuk */

/* Freek */
  /* Control LEDs */
  String[] colors = new String[3];
  colors = loadStrings("http://boelders.nl/control-led/LED.txt"); // Insert the location of your .txt file
  /* text file contains 3 lines of numbers for RGB values, eg:
  255
  125
  0
  */
  
  for(int n=0;n<3;n++){ 
    //println(colors[n]);
    int num;
    num = parseInt(colors[n]); // change string into Int
    port.write((byte)(num)); // write as a byte over serial

/* Jop */

}


void mousePressed(){
  
}

