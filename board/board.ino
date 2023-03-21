// include the library code:
#include <LiquidCrystal_I2C.h> 
#include <Wire.h>
#include <Servo.h> 
// define interrupt button to pin 13
int relayPin = 12; // the relay is connected to pin 12
int BUTTONPIN = 13;// the momentary switch is connected to pin 13
 
/* initialize the library by associating each LCD interface pins with the arduino pin number it is connected to */
LiquidCrystal_I2C lcd(0x27, 16, 2);
 
int boomBoxMode = 1; // start counter for keeping track of the Mode and LCD message to display
Servo servo;
int degree[] = {0,15,30,45,60};
int size = 5;
int motorindex;
int debounce = 0;
void setup()
{
  Wire.begin();      // begin communication protocol to use two-wire communication/ I2C
  Serial.begin(9600);   // starts communication with the Serial Monitor - used for troubleshooting when necessary
  Serial.print ("begin: "); 
  servo.attach(3);
  pinMode(A2, INPUT);
  motorindex = 0;
}

int movemotor(){
  motorindex++;
  if(motorindex==size)
    motorindex = 0;
  servo.write(degree[motorindex]);
  return 0;
}

void loop() 
{
  int sensorValue = analogRead(A0);
  int v2 = analogRead(A1);
  float voltage= (sensorValue-v2) * (5.0 / 1023.0);
  if(abs(voltage)>3.0){
    Serial.println(voltage);
  }
  /*
  servo.write(0); // move MG996R's shaft to angle 0°
  delay(1000); // wait for one second
  servo.write(180); // move MG996R's shaft to angle 45°
  delay(1000); // wait for one second 
  servo.write(0); // move MG996R's shaft to angle 90°
  delay(1000); // wait for one second
  servo.write(180); // move MG996R's shaft to angle 135°
  delay(1000); // wait for one second
  */


  if (digitalRead(A2) == HIGH)
  {
    debounce++;
    if(debounce == 80)
      movemotor();
  }
  else
  {
    debounce = 0;
  }
  
}
    
 