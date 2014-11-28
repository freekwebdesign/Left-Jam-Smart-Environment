/* Left Jam */
/* Main-file */
/* Version 1.0 */

int i = 0;

void setup () {
  size(500,500);
}

void draw () {
  if (i < 10) {
    i = i + 1;
  }
  if (i > 9) {
    //println("hoi");
    i = 0;
  }
 fill(255,0,0);
 ellipse(100,100,100,100); 
 fill(0,255,0);
 ellipse(200,100,100,100);
}

void mousePressed(){
 if (mouseX >= 50 && mouseX <= 150 && mouseY >= 50 && mouseY <= 150){
   println("goed verhaal Emma");
 }
 if (mouseX >= 150 && mouseX <= 250 && mouseY >= 50 && mouseY <= 150){
   println("goed verhaal Marit");
 }
}
