class Snow {
  PImage flake1;
  PImage flake2; 
  float xpos, ypos;
  float speed;
  
  Snow() {
    speed = random(0.5, 2.3);
    xpos =  random(0,width);
    ypos =  random(0, height);
  }
  
  void moveMe() {
     if (ypos > height+3) {
      ypos = -5;
     }
     else {
       ypos += speed;
    }  
  }
}

class Small extends Snow {   
    Small() {
      super(); 
      flake1 = loadImage("flake1.png");
    }
    
   void drawMe() {
     image(flake1, xpos, ypos);
   }
}

class Big extends Snow {  
  Big() {
    super();
    flake2 = loadImage("flake2.png"); 
   }
   void drawMe() {
     image(flake2, xpos, ypos);
   }
}


  
  
