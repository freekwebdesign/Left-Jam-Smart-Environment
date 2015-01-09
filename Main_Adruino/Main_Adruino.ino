/* NIET MEER NODIG! */
/* NIET MEER NODIG! */
/* NIET MEER NODIG! */
/* NIET MEER NODIG! */

/* LEFT JAM
 Mood Station TM
 
 LED part: developed by Rajarshi Roy */

/* Initial setup files */

/* Tijmen */

/* Luuk */

/* Freek */
int red, green, blue; //red, green and blue values
int RedPin = 7; //Red pin 9 has a PWM
int GreenPin = 8; //Green pin 10 has a PWM
int BluePin = 9; //Blue pin 11 has a PWM

/* Jop */

void setup(){
/* Initial setup files */
   Serial.begin(9600);
   
/* Tijmen */

/* Luuk */

/* Freek */
  //initial values (no significance)
  int red = 255;
  int blue = 255;
  int green = 255;

/* Jop */

}

void loop()
{
/* Tijmen */

/* Luuk */

/* Freek */
  //protocol expects data in format of 4 bytes
  //(xff) as a marker to ensure proper synchronization always
  //followed by red, green, blue bytes
  if (Serial.available()>=4) {
    if(Serial.read() == 0xff){
      red = Serial.read();
      green= Serial.read();
      blue = Serial.read();
    }
  }
  //finally control led brightness through pulse-width modulation
  analogWrite (RedPin, red);
  analogWrite (GreenPin, green);
  analogWrite (BluePin, blue);
  delay(10); //just to be safe

/* Jop */

}



