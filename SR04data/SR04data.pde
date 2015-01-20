import processing.serial.*;
Serial port;   
int people = 0;
int oldpeople;
String[] php;

void setup() 
{
  println(Serial.list());
  size(500, 500);
  port = new Serial(this, Serial.list()[0], 9600);
}

void draw()
{

  char IO =(char)port.read();
  print((char)port.read());

  if (IO =='I' && people <255) {
    people++;
  } else if (IO =='O' && people >0) {
    people--;
  }


  println(people);

  if (people != oldpeople) { //Check if some variables changed
    php = loadStrings("http://boelders.nl/uni/left-jam/index.php?people=" + people);
    //println("Temperaturen zijn niet hetzelfde of mensen zijn niet hetzelfde, dus XML schrijven!");
    oldpeople = people;
  }
}

