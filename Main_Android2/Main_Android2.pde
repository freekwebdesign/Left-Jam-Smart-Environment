/* LEFT JAM
   Mood Station TM */

/* Initial setup files */
/* Music */
//import android.media.*; //disable if you use Java
//import android.content.res.*; //disable if you use Java
//MediaPlayer snd; //disable if you use Java

PImage webImg, nsImg, layoutImg;

int people;
int temp;
float regen;
String icoon;
String musicurl;
String mensen;
int manualoverwrite;
long time; //set up to use for millis

void setup(){
  /* Initial setup files */
  size(1280,736);

  musicurl = "http://boelders.nl/uni/mp3/Rain.mp3";
  
  layoutImg = loadImage("http://boelders.nl/uni/left-jam/layout-tablet.png");
  
  /*println(musicurl);
  try { //disable if you use Java
  MediaPlayer snd = new MediaPlayer();
  snd.setDataSource(musicurl);
  snd.prepare(); 
  snd.start();
  } catch (IOException e) {
          e.printStackTrace();
  }*/
}

void draw(){
  if (millis()>time+5000) { //Run every 5 sec
    time=millis();
    println("Variabelen ophalen van internet");
    
    XML xml;
    
    /*Get variables from Processing website XML */
    String url1 = "http://boelders.nl/uni/left-jam/values.xml";
    xml = loadXML(url1);
    XML[] tempchildren = xml.getChildren("values/temperature");
    temp = tempchildren[0].getIntContent();
    
    XML[] peoplechildren = xml.getChildren("values/people");
    people = peoplechildren[0].getIntContent();
    
    XML[] manualoverwritechildren = xml.getChildren("values/manualoverwrite");
    manualoverwrite = manualoverwritechildren[0].getIntContent();
    
    XML[] icoonchildren = xml.getChildren("values/icoon");
    icoon = icoonchildren[0].getContent();
    webImg = loadImage(icoon);
    
    XML[] regenchildren = xml.getChildren("values/regen");
    regen = regenchildren[0].getFloatContent();
    
    /*Weather information */  
    String url2 = "http://xml.buienradar.nl/";
    xml = loadXML(url2);
    XML tekstChild = xml.getChild("weergegevens/verwachting_vandaag/tekst");
    String weer_info = tekstChild.getContent("");
    
    
    /*Control LEDs in combination with temp*/
    int[] colors = new int[3];
    
    if (temp < 5) {
    colors[0] = 255; //red
    colors[1] = 0;
    colors[2] = 0;
    
    musicurl = "http://boelders.nl/uni/mp3/Rain.mp3";
    }
    
    if (temp >= 5 && temp <= 15) {
    colors[0] = 255; //red
    colors[1] = 0;
    colors[2] = ((temp-5)*25);
    
    musicurl = "http://boelders.nl/uni/mp3/Clouds.mp3";
    }
    
    if (temp >= 15 && temp <= 25) {
    colors[0] = 255 - ((temp-15)*25);
    colors[1] = 0;
    colors[2] = 255; //blue
    
    musicurl = "http://boelders.nl/uni/mp3/Sun.mp3";
    }
    
    if (temp > 25) {
    colors[0] = 0;
    colors[1] = 0;
    colors[2] = 255; //blue
    } 
    
    background(colors[0],colors[1],colors[2]);
    
    
    /* Put information on screen */
    mensen = "Er bevinden zich " + people + " mensen op het station op dit moment.";

    image(layoutImg, 0, 0, 1280,736);
    
    textSize(26);
    fill(#FFFFFF);
    text(""+ temp + " degrees" + "   " + "      " + regen + " mm",60,395);
    image(webImg, 40, 210, 150, 150);
    //image(nsImg, 50, 300, 800/2, 323/2);
    textSize(16);
    fill(#000000);
    text(weer_info,910,420,330,240);
    text(mensen,920,240,300,20);
  }
  
}
