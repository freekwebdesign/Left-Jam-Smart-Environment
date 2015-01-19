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
int ietemp;
int oldtemp = 0;
float regen;
float oldregen = 0.0;
String icoon;
String oldicoon = "";

long time; //set up to use for millis

/* Amount of people */
int people = 120;
int oldpeople = 0;
int busyFactor = 0;

/* Manual Overwite */
int manualoverwrite = 0;

//Button
int button = 0;

/* LED strip */
int red, green, blue;
int RedPin = 9; //Red pin 9 has a PWM
int GreenPin = 10; //Green pin 10 has a PWM
int BluePin = 11; //Blue pin 11 has a PWM

/* Write data to XML */
String[] php;

void setup(){
/* Initial setup files */
  arduino = new Arduino(this, Arduino.list()[0], 57600); //disable if no Adruino connected
  frameRate(60);  // delay of 50 ms, 20Hz update
  size(1080,720);
  arduino.pinMode(2, Arduino.INPUT);
  arduino.pinMode(4, Arduino.OUTPUT);
}

void draw(){
  float ppl = arduino.analogRead(0);
  float tmp = arduino.analogRead(1);
  int button = arduino.digitalRead(2);
  busyFactor = int(people/25.5);
  //enable manual overwrite by pressing button
  if (button == 1 && manualoverwrite == 0){
  manualoverwrite = 1;
  delay(200);
  } 
  else if(button == 1){
  manualoverwrite = 0; 
  delay(200);
  }
  
  //changes temperature and amount of people manually
  if(manualoverwrite == 1){
    arduino.digitalWrite(4, Arduino.HIGH);
    if(ppl >800 && people>0){
    people--;
    }
    else if(ppl < 200 && people<255){
    people++;
    }
    if(tmp >800){
    temp++; 
    delay(200);
    }
    else if(tmp < 200){
    temp--;
    delay(200);
    }
    println("People " + people);
    println("Temperature " + temp);
  }
  else if(manualoverwrite == 0){
    arduino.digitalWrite(4, Arduino.LOW);
    temp = ietemp;
  }
  /* Control LEDs in combination with temp */
  int[] colors = new int[3];
  
  
  if (temp < 5) {
    colors[0] = int(25.5*busyFactor); //red
    colors[1] = 0;
    colors[2] = 0;
  }
    
  if (temp >= 5 && temp <= 15) {
    colors[0] = int(25.5*busyFactor); //red
    colors[1] = 0;
    colors[2] = int(((temp-5)*2.5)*busyFactor);
  }
    
  if (temp >= 15 && temp <= 25) {
    colors[0] = int((25.5 - ((temp-15)*2.5))*busyFactor);
    colors[1] = 0;
    colors[2] = int(25.5*busyFactor); //blue
  }
    
  if (temp > 25) {
    colors[0] = 0;
    colors[1] = 0;
    colors[2] = int(25.5*busyFactor); //blue
  } 
    
  for(int n=0;n<3;n++){ 
    //println(colors[n]);
    int num;
    num = colors[n]; // change string into Int
    
    arduino.analogWrite(RedPin, colors[0]); // write PWM to certain port
    arduino.analogWrite(GreenPin, colors[1]); // write PWM to certain port
    arduino.analogWrite(BluePin, colors[2]); // write PWM to certain port
  }
  
  /* Weather information */
  if (millis()>time+5000) { //Run every 5 sec
    time=millis();
    println("Weerinfo ophalen van Buienradar");
    XML xml;
    String url = "http://xml.buienradar.nl/";
  
    xml = loadXML(url);
    XML[] children = xml.getChildren("weergegevens/actueel_weer/weerstations/weerstation");
  
    for (int i = 0; i < children.length; i++) {
      int id = children[i].getInt("id");
      String name = children[i].getContent();
      if (id == 6290) {
        
        XML[] tempchildren = xml.getChildren("weergegevens/actueel_weer/weerstations/weerstation/temperatuurGC");
        ietemp = tempchildren[i].getIntContent();
        //println(temp);
        
        XML[] icoonchildren = xml.getChildren("weergegevens/actueel_weer/weerstations/weerstation/icoonactueel");
        icoon = icoonchildren[i].getContent();
        //println(icoon);
        //webImg = loadImage(icoon);
        
        XML[] regenchildren = xml.getChildren("weergegevens/actueel_weer/weerstations/weerstation/regenMMPU");
        regen = regenchildren[i].getFloatContent();
        //println(regen);
      }
    }
    
  }
  
if (temp != oldtemp || people != oldpeople || icoon != oldicoon || regen != oldregen) { //Check if some variables changed
  php = loadStrings("http://boelders.nl/uni/left-jam/index.php?temperature=" + temp + "&people=" + people + "&manualoverwrite=" + manualoverwrite + "&icoon=" + icoon + "&regen=" + regen + "");
  println("Temperaturen zijn niet hetzelfde of mensen zijn niet hetzelfde, dus XML schrijven!");
  oldtemp = temp;
  oldpeople = people;
  oldicoon = icoon;
  oldregen = regen;
  }

}
