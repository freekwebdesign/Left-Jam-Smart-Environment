/* LEFT JAM
   Mood Station TM
   Notes: Use the firmate sketch on the Arduino!
*/

/* Initial setup files */
import processing.serial.*;
import cc.arduino.*;

Arduino arduino;

/* Weather information  */
int temp;
int oldtemp = 3;

/* Amount of people */
int people = 120;
int oldpeople = 0;

/* Manual Overwite */
int manualoverwrite = 0;

/* LED strip */
int red, green, blue;
int RedPin = 7; //Red pin 9 has a PWM
int GreenPin = 8; //Green pin 10 has a PWM
int BluePin = 9; //Blue pin 11 has a PWM

/* Write data to XML */
String[] php;

void setup(){
/* Initial setup files */
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  frameRate(20);  // delay of 50 ms, 20Hz update
  size(1080,720);

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
  
}

void draw(){
  /* Control LEDs in combination with temp */
  int[] colors = new int[3];
  
  println(temp);
  // temp IS NOT GETTING HERE YET! HOW TO DO?
  
  if (temp < 5) {
    colors[0] = 255; //red
    colors[1] = 0;
    colors[2] = 0;
  }
    
  if (temp >= 5 && temp <= 15) {
    colors[0] = 255; //red
    colors[1] = 0;
    colors[2] = ((temp-5)*25);
  }
    
  if (temp >= 15 && temp <= 25) {
    colors[0] = 255 - ((temp-15)*25);
    colors[1] = 0;
    colors[2] = 255; //blue
  }
    
  if (temp > 25) {
    colors[0] = 0;
    colors[1] = 0;
    colors[2] = 255; //blue
  } 
    
  for(int n=0;n<3;n++){ 
    //println(colors[n]);
    int num;
    num = colors[n]; // change string into Int
    arduino.analogWrite(RedPin, colors[0]); // write PWM to certain port
    arduino.analogWrite(GreenPin, colors[1]); // write PWM to certain port
    arduino.analogWrite(BluePin, colors[2]); // write PWM to certain port
  }
  
  if (temp != oldtemp || people != oldpeople) {
  php = loadStrings("http://boelders.nl/uni/left-jam/index.php?temperature=" + temp +"&people=" + people +"&manualoverwrite=" + manualoverwrite + "");
  println("Temperaturen zijn niet hetzelfde of mensen zijn niet hetzelfde, dus XML schrijven!");
  oldtemp = temp;
  oldpeople = people;
  }
  
  //println(temp);
  //println(oldtemp);

}
