#include <Wire.h>
#include <HardwareSerial.h>
#include "MAX30105.h"
#include <Adafruit_GFX.h>        // OLED Library
#include <Adafruit_SSD1306.h>
//const int pulseled = 25;
//const int pulsem1 = 26;
//const int pulsem2 = 27;

//const int glucoseled = 21;
//const int glucosem1 = 22;
//const int glucosem2 = 23;

//const int oxygenled = 19;
//const int oxygenm1 = 5;
//const int oxygenm2 = 18;

const int templed = 14;
//const int tempm1 = 12;
//const int tempm2 = 13;
#define Sender_Txd_pin 17
#define Sender_Rxd_pin 16
HardwareSerial Sender(2);
#include "heartRate.h"
float pulse=0;
float oxygen=0; 
float Temp ;
float temp ;
int i;
#define RST 35
#define I2C_SDA 21
#define I2C_SCL 22
 #include <SPI.h>  //
const byte RATE_SIZE = 4;        // Increase this for more averaging. 4 is good.
byte rates[RATE_SIZE];           // Array of heart rates
byte rateSpot = 0;
long lastBeat = 0;               // Time at which the last beat occurred
float beatsPerMinute;
int beatAvg;

#define SCREEN_WIDTH 128         // OLED display width, in pixels
#define SCREEN_HEIGHT 64         // OLED display height, in pixels
#define OLED_RESET    -1         // Reset pin # (or -1 if sharing Arduino reset pin)

Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, OLED_RESET); //Declaring the display name (display)


int Glucose=0;

int differential_data;
int push_button = 4;
int buttonval = 0;
int state = 0;
//float beatsPerMinute;
#define digital_pin  4
#define analog_pin  2
unsigned long int avgValue;  
float b;
int buf[10];
float overal_data;
float volt_gluco;
float gluco;
float gluco_mmol;


MAX30105 particleSensor; 

int patient_Num =1 ;
int patient_count =1000 ;
#define REMOTEXY_MODE__ESP32CORE_BLUETOOTH
#include <BluetoothSerial.h>

#include <RemoteXY.h>                 

// RemoteXY connection settings 
#define REMOTEXY_BLUETOOTH_NAME "SWA Delta"



// RemoteXY configurate  
#pragma pack(push, 1)
uint8_t RemoteXY_CONF[] =   // 203 bytes
  { 255,0,0,62,0,192,0,16,24,0,66,130,6,15,17,13,121,26,66,130,
  29,15,17,13,121,26,66,130,53,15,17,13,121,26,66,130,78,15,17,13,
  121,26,67,4,4,34,20,6,122,26,11,67,4,28,34,20,6,122,26,11,
  67,4,52,34,20,6,122,26,11,67,4,78,34,19,6,122,26,11,70,16,
  8,46,10,10,133,37,0,70,16,32,46,10,10,133,37,0,70,16,56,46,
  10,10,133,37,0,70,16,80,46,10,10,133,37,0,129,0,6,5,16,6,
  133,80,117,108,115,101,0,129,0,26,5,24,6,133,79,120,121,103,101,110,
  32,0,129,0,53,5,16,6,133,84,101,109,112,0,129,0,75,5,24,6,
  133,71,108,117,99,111,115,101,0,69,1,9,52,10,10,69,1,33,52,10,
  10,69,1,56,52,10,10,69,1,81,52,10,10,69,1,44,20,10,10};
  
// this structure defines all the variables and events of your control interface 
struct {

    // output variables
  int8_t level_1; // =0..100 level position 
  int8_t level_2; // =0..100 level position 
  int8_t level_3; // =0..100 level position 
  int8_t level_4; // =0..100 level position 
  char text_1[11];  // string UTF8 end zero 
  char text_2[11];  // string UTF8 end zero 
  char text_3[11];  // string UTF8 end zero 
  char text_4[11];  // string UTF8 end zero 
  uint8_t led_1; // led state 0 .. 1 
  uint8_t led_2; // led state 0 .. 1 
  uint8_t led_3; // led state 0 .. 1 
  uint8_t led_4; // led state 0 .. 1 
  int16_t sound_1; // =0 no sound, else ID of sound, =1001 for example, look sound list in app 
  int16_t sound_2; // =0 no sound, else ID of sound, =1001 for example, look sound list in app 
  int16_t sound_3; // =0 no sound, else ID of sound, =1001 for example, look sound list in app 
  int16_t sound_4; // =0 no sound, else ID of sound, =1001 for example, look sound list in app 
  int16_t sound_5; // =0 no sound, else ID of sound, =1001 for example, look sound list in app 

  uint8_t connect_flag;  // =1 if wire connected, else =0 

} RemoteXY;
#pragma pack(pop)


void setup() 
{
  RemoteXY_Init ();
  {
    Wire.begin(I2C_SDA ,I2C_SCL);
    
   Wire.setClock(400000);                         // Set I2C speed to 400kHz
  display.begin(SSD1306_SWITCHCAPVCC, 0x3C);     // Start the OLED display
  display.setTextColor(WHITE);
   display.clearDisplay();
  display.setTextSize(2);
  display.setCursor(0, 5);
  display.print(" 'please'   put your  Finger");
  //display.print(0);
  display.display();
}
  Serial.begin(9600);
  Wire.begin();
 Sender.begin(115200, SERIAL_8N1, Sender_Txd_pin, Sender_Rxd_pin); 
   display.begin(SSD1306_SWITCHCAPVCC, 0x3C);
  pinMode(push_button,INPUT);
  pinMode(digital_pin,INPUT);
  display.clearDisplay();
  while(!Serial); //We must wait for Teensy to come online
  delay(10);
  Serial.print("Number");
  Serial.print('\t');
  Serial.print("Pulse Rate");
  Serial.print('\t');
  Serial.print("Oxygen");
  Serial.print('\t');
  Serial.print("Glucose");
  Serial.print('\t');
  Serial.println("Temp");
  
  
  if (particleSensor.begin(Wire, I2C_SPEED_FAST) == false) 
  {
  //  Serial.println("MAX30105 was not found. Please check wiring/power. ");
    while (1);
  }

  byte ledBrightness = 200; 
  byte sampleAverage = 1;
  byte ledMode = 2; 
  int sampleRate = 400; 
  int pulseWidth = 69; 
  int adcRange = 16384; 

  particleSensor.setup(ledBrightness, sampleAverage, ledMode, sampleRate, pulseWidth, adcRange); 

  
  }
  
  // TODO you setup code
  


void loop() {

 
  particleSensor.check(); //Check the sensor

  while (particleSensor.available()) {
     long irValue = particleSensor.getIR();

  if (checkForBeat(irValue) == true)
  {
    //We sensed a beat!
    long delta = millis() - lastBeat;
    lastBeat = millis();
    beatsPerMinute = 60 / (delta / 1000.0); }
     if (patient_Num < patient_count){
  Serial.print (++patient_Num);
  Serial.print('\t');
      pulse=(particleSensor.getFIFOIR()*5)/8000;
      Serial.print("PBM=  ");
      Serial.print(pulse);
      Serial.print('\t');
      oxygen=(particleSensor.getFIFORed()*4)/9000 ;
      Serial.print("oxygen = ");
      Serial.print(oxygen);
      Serial.print(" %");
      Serial.print('\t');
    
      particleSensor.nextSample();
      if ( pulse< 50)
      Serial.print(" No finger?");
      buttonval = digitalRead (push_button);
 
     if ( pulse> 50){
     Serial.print("glucose = ");
     Glucose=irValue/1300;
     Serial.print(Glucose);
     Serial.print('\t');
     }
   
      
      if ( pulse> 50)
     Temp =particleSensor.readTemperature();
     temp=Temp*14/11;
     Serial.print("Temp = ");
        Serial.print(temp);
         Serial.print(" C ");
          Serial.print('\n');
 }
  
   display.clearDisplay();
        display.setTextSize(2);
        display.setCursor(0,0);
        display.println("P:");
       display.setCursor(25,0);
       display.print(pulse);
        display.print('\n');
        display.display();
        display.setCursor(0, 19);
        display.println("T:");
         display.setCursor(25,19);
        display.println(temp);
        display.display();
        display.setCursor(0, 35);
        display.println("OX:");
         display.setCursor(35,35);
        display.println(oxygen);
        display.display();
         display.setCursor(0, 50);
        display.println("G:");
         display.setCursor(35,50);
        display.println(Glucose);
        display.display();
        delay(1000);
 
   }



 //function for differential mode

   
 { RemoteXY_Handler ();
if (pulse<40)
{ RemoteXY.sound_5 = 7;
delay(11000);}
else 
RemoteXY.sound_5 = 0;

   RemoteXY.level_1=(((analogRead(pulse)-60)*100)/(70-160));
  RemoteXY.level_2=(((analogRead(oxygen)-40)*100)/(60-110));
   RemoteXY.level_3=(((analogRead(temp)-10)*100)/(10-60));
    RemoteXY.level_4=(((analogRead(Glucose)-60)*100)/(60-180));
  // TODO you loop code
  
  if (temp>40){
  RemoteXY.led_3=(digitalRead,HIGH);
  RemoteXY.sound_3 = 5;
   delay(6000);
 } else 
   RemoteXY.led_3=(digitalRead,LOW);
   RemoteXY.sound_3 = 0;
  }
  if (pulse>120){
  RemoteXY.led_1=(digitalRead,HIGH);
   RemoteXY.sound_1 = 3;
   
  } else 
   RemoteXY.led_1=(digitalRead,LOW);
   RemoteXY.sound_1 = 0 ;
   
 if (pulse>50){
  if (oxygen<90){
    
  RemoteXY.led_2=(digitalRead,HIGH);
   RemoteXY.sound_2 = 4;
   
  } else{ 
   RemoteXY.led_2=(digitalRead,LOW);
    RemoteXY.sound_2 = 0 ;
   }}
   if (Glucose>160){
  RemoteXY.led_4=(digitalRead,HIGH);
  RemoteXY.sound_4 = 6;
   delay(6000);
  } else{ 
   RemoteXY.led_4=(digitalRead,LOW);
    RemoteXY.sound_4 = 0;
}
 
   dtostrf( temp  , 0, 1 ,RemoteXY.text_3);
   dtostrf( pulse  , 0, 1 ,RemoteXY.text_1);
   dtostrf( oxygen  , 0, 1 ,RemoteXY.text_2);
   dtostrf( Glucose, 0, 1 ,RemoteXY.text_4);

  }
  
  
