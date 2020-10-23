unsigned long value;
int channelNum=8;
double doublevalue;

void setup() {
  // put your setup code here, to run once:
  SerialUSB.begin(500000);
}

unsigned long starttime;
unsigned long endtime;
unsigned long timegap;
int samplerate=4000;
void loop() {
  // put your main code here, to run repeatedly:
  starttime = micros();
  for(int k=0; k<samplerate; k++){
  SerialUSB.print("#");
  for(int i=1; i< channelNum + 1; i++){
    value=random(0,0xFFFFFF);
    doublevalue = (double)value/0x7FFFFF -1;
    if(i != 1) SerialUSB.print(',');
//    SerialUSB.print(doublevalue,4); 
    SerialUSB.print(value); 
    }
  SerialUSB.println("#");
//  SerialUSB.println();
  }
  endtime = micros();
  
  timegap = endtime-starttime;
  SerialUSB.println(timegap);
  delayMicroseconds(1000000-timegap);
   
}


//void setup() {
//  // put your setup code here, to run once:
//  Serial.begin(115200);
//}
//void loop() {
//  // put your main code here, to run repeatedly:
//  Serial.print("#");
//  for(int i=1; i< channelNum + 1; i++){
//    value=random(0,0xFFFFFF);
//    if(i != 1) Serial.print(",");
//    Serial.print(value);
//    }
//  Serial.println("#");
//}
