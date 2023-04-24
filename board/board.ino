// include the library code:
#include <LiquidCrystal_I2C.h> 
#include <Wire.h>
#include <Servo.h> 
#include <SoftwareSerial.h>
#include <AES.h>

// define interrupt button to pin 13
int relayPin = 12; // the relay is connected to pin 12
int BUTTONPIN = 13;// the momentary switch is connected to pin 13
 
/* initialize the library by associating each LCD interface pins with the arduino pin number it is connected to */
LiquidCrystal_I2C lcd(0x27, 16, 2);
 
int boomBoxMode = 1; // start counter for keeping track of the Mode and LCD message to display
Servo servo;
Servo servo2;
int offset = 60;
int offset2 = 30;
int degree[] = {0,10,20,30,20,10,0,-10};
int size = 8;
int motorindex;
int debounce = 0;
SoftwareSerial Bluetooth(10,9);

String message = "";
AES encrypt;
char input[16] = "o";
char output[16] = "abcdefgh";
byte buffer[16] = "1234567890123456";
byte key[16] = "1234567890123456";

void setup()
{
  Wire.begin();      // begin communication protocol to use two-wire communication/ I2C
  Serial.begin(9600);   // starts communication with the Serial Monitor - used for troubleshooting when necessary
  Serial.print ("begin: "); 
  servo.attach(3);
  servo.write(offset);
  servo2.attach(4);
  servo2.write(offset2);
  motorindex = 0;
  Bluetooth.begin(9600);
  Bluetooth.println("Send 1 to turn on the LED. Send 0 to turn Off");
  encrypt.set_key(key,16);
  encrypt.encrypt(input, buffer);
    for(int i = 0;i<16;i++){
    message+=(byte)buffer[i];
    message+=" ";
  }
  Serial.print(message);
  message = "";
  /*
  encrypt.set_key(key,16);
  encrypt.encrypt(input, buffer);
  encrypt.decrypt(buffer,output);
  for(int i = 0;i<16;i++){
    message+=(byte)output[i];
    message+=" ";
  }
  //Serial.print((char)output[2]);
  Serial.println(message);
  */
  message = "";
}

int movemotor(){
  motorindex++;
  if(motorindex==size)
    motorindex = 0;
  servo.write(offset + degree[motorindex]);
  servo2.write((int)(offset2 - degree[motorindex]));
  return 0;
}

void loop() 
{
  int available = Bluetooth.available();
  if (Bluetooth.available()){
    char p = Bluetooth.read();
    if(p=='\n'){
      Serial.println(message);
      if(strcmp(message.c_str(),"Y31kPn/Knxd9rXX96Qe1Sg==")){
      movemotor();
      Serial.println("ASd");
      message = "";
      }
    }
    message += (char)p;
  }
  if(message.indexOf("Teststring") > 0){
    message = "";
  }
  /*
  if(message.indexOf("\n") >0){
    Serial.println(message);
    encrypt.decrypt(message.c_str(),output);
    //Serial.print(output);
    if(message == "Y31kPn/Knxd9rXX96Qe1Sg==\n"){
      movemotor();
      Serial.print("ASd");
    }
    message = "";
  }
*/
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
    
