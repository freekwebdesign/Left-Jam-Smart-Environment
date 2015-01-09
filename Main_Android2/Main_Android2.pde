/* LEFT JAM
   Mood Station TM */

/* Freek */
PImage webImg;
int temp;
float regen;
String musicurl;

//import ddf.minim.*;
//Minim minim;
//AudioPlayer player;

import android.media.*;
import android.content.res.*;
MediaPlayer snd;

void setup(){
/* Freek */

  size(600,600);
  
  /* Weather information */
  XML xml;
  String url = "http://xml.buienradar.nl/";

  xml = loadXML(url);
  XML firstChild = xml.getChild("weergegevens/actueel_weer/weerstations/weerstation/temperatuurGC");
  //println(firstChild.getIntContent());
  
  //int temp = firstChild.getIntContent();
  
  
  XML[] children = xml.getChildren("weergegevens/actueel_weer/weerstations/weerstation");

  for (int i = 0; i < children.length; i++) {
    int id = children[i].getInt("id");
    String name = children[i].getContent();
    if (id == 6290) {
    
    XML[] tempchildren = xml.getChildren("weergegevens/actueel_weer/weerstations/weerstation/temperatuurGC");
    temp = tempchildren[i].getIntContent();
    println(temp);
    
    //println(children[i].getName());
    //println(children[i].listChildren());
    
   XML[] icoonchildren = xml.getChildren("weergegevens/actueel_weer/weerstations/weerstation/icoonactueel");
    String icoon = icoonchildren[i].getContent();
    println(icoon);
    webImg = loadImage(icoon);
    
    
    XML[] regenchildren = xml.getChildren("weergegevens/actueel_weer/weerstations/weerstation/regenMMPU");
    regen = regenchildren[i].getFloatContent();
    println(regen);
    //XML[] icoonchildren = xml.getChildren("weergegevens/actueel_weer/weerstations/weerstation/luchtdruk");
    //String icoon = children[i].getContent();
    
    //println(icoon);
    //println(temp);
    //println(id + ", " + ", " + name);
    }
  }
  
  
  
  /* Freek */
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
  
  text(temp + " graden",60,20);
  text(regen + " mm",60,40);
  image(webImg, 10, 5, 40, 40);
  
  //ZON: a,b,f,g,h,i,k,o,u
  //minim = new Minim(this);
  
  if (regen == 0) {
  //player = minim.loadFile("Sun.mp3", 2048);
  //player.play(); 
  }
  
  if (regen > 0) {
  //player = minim.loadFile("Rain.mp3", 2048);
  //player.play();
  }
    
  
  XML tekstChild = xml.getChild("weergegevens/verwachting_vandaag/tekst");
  String weer_info = tekstChild.getContent("");
  text(weer_info,10,60,400,400);
  
  println(musicurl);
  
  try {
  MediaPlayer snd = new MediaPlayer();
  snd.setDataSource(musicurl);
  snd.prepare();
  snd.start();
  } catch (IOException e) {
          e.printStackTrace();
  }
}

void draw(){
}
