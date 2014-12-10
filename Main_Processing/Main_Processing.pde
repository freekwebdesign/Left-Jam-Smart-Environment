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
  size(1080,720);
  
/* Tijmen */

/* Luuk */

/* Freek */
  /* Weather information */
  XML xml;
  String url = "http://xml.buienradar.nl/";

  xml = loadXML(url);
  XML firstChild = xml.getChild("weergegevens/actueel_weer/weerstations/weerstation/temperatuurGC");
  //println(firstChild.getIntContent());
  
  int temp = firstChild.getIntContent();
  text(temp + " graden",10,20);
  
  XML tekstChild = xml.getChild("weergegevens/verwachting_vandaag/tekst");
  String weer_info = tekstChild.getContent("");
  text(weer_info,10,40,1070,100);
  
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
  }
  
  /* Weather information */
  XML xml;
  String url = "http://xml.buienradar.nl/";

/* Jop */

}


void mousePressed(){
  
}

