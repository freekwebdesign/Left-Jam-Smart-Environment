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
    println("hoi");
    i = 0;
  }
}
