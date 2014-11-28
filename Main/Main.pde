PImage snow;

Small[] flakes1 = new Small[65];
Big[] flakes2 = new Big[30];
  int maxSnowSmall = 65;
  int maxSnowBig = 30;


void setup() {
  size(450, 360);
  snow = loadImage("snow.jpg");

  for(int s = 0; s < maxSnowSmall; s++){
    flakes1[s] = new Small();
  }
  for(int t = 0; t < maxSnowBig; t++){
    flakes2[t] = new Big();
   }
}

void draw() {
  imageMode(CORNERS);
  image(snow, 0, 0);
  
  imageMode(CENTER);

  for(int s = 0; s < maxSnowSmall; s++) {
    flakes1[s].drawMe();
    flakes1[s].moveMe();
  }
  for(int t = 0; t < maxSnowBig; t++) {
    flakes2[t].drawMe();
    flakes2[t].moveMe();
  } 
}



