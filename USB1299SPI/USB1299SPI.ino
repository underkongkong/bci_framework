#include "ADS1299.h"
#define PIN_SS   4
#define PIN_DRDY 28
#define PIN_RST  40
#define PIN_START 24
#define PIN_CLKSEL 52
/*
ch
*/

ADS1299 chip1(PIN_SS, PIN_DRDY, PIN_RST, PIN_START, PIN_CLKSEL);

void setup (void)
{
   SerialUSB.begin(2000000);
   Serial.begin(115200);

  chip1.initialize();
  //chip1.readAllReg();
//  chip1.changeToTestSignal();
//  chip1.changeToNormalElectrode();
//  chip1.enableSRB1();
  chip1.setSRB1(true);
  chip1.setLOFF(true);
  chip1.startTransform(); //测试刺激，开启装换
}

String input;
void loop (void)
{
//  SerialUSBMonitor();
//  SerialUSBPlotter();
  chip1.receiveData(8, false);
  input = readSerial();
//  input = readSerialUSB();
//  if(input!="")SerialUSB.println(input);
  if(input == "fix" or input == "pic") SerialUSB.println("##########");
//  else if(input == "") Serial
}

//读取串口USB的指令
String readSerialUSB(){
  String input = "";
  while(SerialUSB.available() > 0){
    input += char(SerialUSB.read());
    delay(2);
  }
  if(input.length() > 0)
    return input;
}

//读取串口的指令
String readSerial(){
  String input = "";
  while(Serial.available() > 0){
    input += char(Serial.read());
    delay(2);
  }
  if(input.length() > 0)
    return input;
}

int channelNum = 8;

//用串口监视器来调试
void SerialUSBMonitor(){
  String input = readSerialUSB();
  if(input == "REG"){
    chip1.readAllReg();
  }
  else if(input == "INIT"){
    chip1.initialize();
  }
  else if(input == "RDATA"){
    chip1.readData(false);
  }
  else if(input == "RDATAC"){
    String flag;
    while(flag != "STOP"){
      flag= readSerialUSB();
      chip1.acquire(false);
    }
  }
  else if(input == "TEST"){
  chip1.changeToTestSignal();
  }
  else if(input == "NORMAL"){
  chip1.changeToNormalElectrode();
  }
  else if(input == "SHORT"){
  chip1.changeToInputShort();
  }
}

//用串口绘图器来调试
void SerialUSBPlotter(){
  chip1.acquire(false);
}
