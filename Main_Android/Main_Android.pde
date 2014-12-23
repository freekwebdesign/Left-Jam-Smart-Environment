/* LEFT JAM
   Mood Station TM */

/* Freek */
int temp;


void setup(){
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

}

void draw(){
/* Freek */
  /* Control LEDs in combination with temp */
  int[] colors = new int[3];
  
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
    //port.write((byte)(num)); // write as a byte over serial
  }
}
