#include "ADS1299.h"

ADS1299::ADS1299(int PIN_SS, int PIN_DRDY, int PIN_RST, int PIN_START, int PIN_CLKSEL){
  this->PIN_SS = PIN_SS;
  this->PIN_DRDY = PIN_DRDY;
  this->PIN_RST = PIN_RST;
  this->PIN_START = PIN_START;
  this->PIN_CLKSEL = PIN_CLKSEL;
}

void ADS1299::initialize(){

  delay(50);
  //引脚设置
  pinMode(PIN_SS, OUTPUT);
  pinMode(PIN_RST, OUTPUT);
  pinMode(PIN_DRDY, INPUT);
  pinMode(PIN_START, OUTPUT);
  pinMode(PIN_CLKSEL, OUTPUT);

  digitalWrite(PIN_SS, LOW);
  digitalWrite(PIN_START, LOW);
  digitalWrite(PIN_RST, LOW);
  digitalWrite(PIN_CLKSEL, LOW);

  delay(200); //等待上电稳定，等待tPOR
  
  SPI.begin(PIN_SS);
  SPI.setClockDivider(PIN_SS, 42);
  SPI.setDataMode(PIN_SS, SPI_MODE1);
  SPI.setBitOrder(PIN_SS, MSBFIRST);

  digitalWrite(PIN_RST, HIGH); 
  delay(3);
  
  //复位
  digitalWrite(PIN_RST, LOW);
  delay(1);
  SPI.transfer(PIN_SS, 0x11);
  delayMicroseconds(10);
  delay(4);
  digitalWrite(PIN_RST, HIGH);

  delay(50);
  
  //配置
  SPI.transfer(PIN_SS, 0x11); //SDATAC
  delayMicroseconds(10);
  
//  SPI.transfer(PIN_SS, 0x11); //SDATAC
//  delayMicroseconds(10);

  SPI.transfer(PIN_SS, 0x0A);
  
 // writeReg(0x41, 0x96); //2020年10月11日提高采样速率，注释此行
  writeReg(0x41, 0x94);//2020年10月11日提高采样速率，添加此行，和上一行功能抑制，保留一行
  
  writeReg(0x42, 0xC0);
  writeReg(0x43, 0xE0);
  writeReg(0x44, 0x00);
  changeToNormalElectrode();
  writeReg(0x4D, 0x0D);
  writeReg(0x4E, 0x00);
  writeReg(0x4F, 0x00);
  writeReg(0x50, 0x00);
  writeReg(0x51, 0x00);
  writeReg(0x54, 0x00);
  writeReg(0x55, 0x00);
  writeReg(0x56, 0x00);
  writeReg(0x57, 0x00);
}

//读一个寄存器
byte ADS1299::readReg(byte regID){
  byte receive;
  SPI.transfer(PIN_SS, CMD_RREG | regID, SPI_CONTINUE);  //寄存器ID
  SPI.transfer(PIN_SS, 0x00, SPI_CONTINUE); //0x00 = 寄存器数量-1
  delayMicroseconds(2); //延时等待芯片处理
  receive = SPI.transfer(PIN_SS, 0x00);  //接收返回值
  return receive;
}

//写一个寄存器
void ADS1299::writeReg(byte regID, byte value) {
  SPI.transfer(PIN_SS, CMD_WREG | regID, SPI_CONTINUE);
  SPI.transfer(PIN_SS, 0x00, SPI_CONTINUE); //寄存器数量-1  
  SPI.transfer(PIN_SS, value); 
//  delayMicroseconds(10);
}

//等待DRDY信号
void ADS1299::waitForDRDY(void){
  boolean value;
  digitalWrite(PIN_SS, HIGH);
  for(long i=0; i<40000000; i++){
    value = digitalRead(PIN_DRDY);
    if(!value)  break;
  }
}

void ADS1299::readAllReg(){
//  delay(10);
  byte address = 0x20;
  for(int i = 0; i<24 ; i++){
  SPI.transfer(PIN_SS, address); //读第一个寄存器
  delayMicroseconds(2);
  SPI.transfer(PIN_SS, 0x00);
  delayMicroseconds(2);
  byte receive = SPI.transfer(PIN_SS, 0x00);
  SerialUSB.print(i);
  SerialUSB.print(" : ");
  SerialUSB.println(receive, HEX);
  address += 1;
  delay(1);
  }
//  delay(10);
}

//常规电极输入
void ADS1299::changeToNormalElectrode(){
  writeReg(0x45, 0x60);
  writeReg(0x46, 0x60);
  writeReg(0x47, 0x60);
  writeReg(0x48, 0x60);
  writeReg(0x49, 0x60);
  writeReg(0x4A, 0x60);
  writeReg(0x4B, 0x60);
  writeReg(0x4C, 0x60);
}

//测试信号，内部
void ADS1299::changeToTestSignal(){
  writeReg(0x42, 0xD0);  //内部测试信号
  writeReg(0x45, 0x65);
  writeReg(0x46, 0x65);
  writeReg(0x47, 0x65);
  writeReg(0x48, 0x65);
  writeReg(0x49, 0x65);
  writeReg(0x4A, 0x65);
  writeReg(0x4B, 0x65);
  writeReg(0x4C, 0x65);
}

//切换模式，通过写寄存器实现
void ADS1299::changeToInputShort(){
  writeReg(0x45, 0x61);
  writeReg(0x46, 0x61);
  writeReg(0x47, 0x61);
  writeReg(0x48, 0x61);
  writeReg(0x49, 0x61);
  writeReg(0x4A, 0x61);
  writeReg(0x4B, 0x61);
  writeReg(0x4C, 0x61);
}

void ADS1299::changeOutputDataRate(){
  writeReg(0x41, 0x95);
}

void ADS1299::setSRB1(bool on){
  if(on) writeReg(0x55, 0x20); // close SRB1，enable
  else if(!on) writeReg(0x55, 0x00); // open SRB1，disable
}

//启用SRB1
void ADS1299::enableSRB1(){
  writeReg(0x55, 0x20); // close SRB1，enable
}

//禁用SRB1
void ADS1299::disableSRB1(){
  writeReg(0x55, 0x00); // open SRB1，disable
}

void ADS1299::setLOFF(boolean on){
  if(on){
    writeReg(LOFF_SENSP, 0xFF);
    writeReg(LOFF_SENSN, 0xFF);
    writeReg(LOFF_FLIP, 0xFF);
  }
  else if(!on){
    writeReg(LOFF_SENSP, 0x00);
    writeReg(LOFF_SENSN, 0x00);
    writeReg(LOFF_FLIP, 0x00);
  }
}

void ADS1299::receiveData(int channelNum, boolean isPlotter){
  waitForDRDY();
  byte receive[27];
  unsigned long value;
  for(int i=0; i<27; i++){
  receive[i] = SPI.transfer(PIN_SS, 0x00);}
  LOFFstatus = (receive[0]<<16) + (receive[1]<<8) +receive[2];
//  int channelNum = 2 ;
//  SerialUSB.print("Status: ");
//  SerialUSB.println(LOFFstatus, BIN);
  if(isPlotter){
    //绘图器调试
    for(int i=1; i< channelNum + 1; i++){
      double value = complementCodeToDouble(receive[3*i], receive[3*i+1], receive[3*i+2])*10000;
      if(i != 1) SerialUSB.print(",");
      SerialUSB.print(value);
    }
    SerialUSB.println();
  }
  else{
    //发给python
    SerialUSB.print("#");
    for(int i=1; i< channelNum + 1; i++){
    value = (receive[3*i]<<16) + (receive[3*i+1]<<8) + receive[3*i+2];
    if(i != 1) SerialUSB.print(",");
    SerialUSB.print(value);
    }
    SerialUSB.println("#");
//    SerialUSB.println();
  }
}

//补码转成浮点
double ADS1299::complementCodeToDouble(byte b1, byte b2, byte b3){
  double VREF = 4.5;
  int PGA = 24;
  //0x7FFFFF = 8388607
  unsigned long value = (b1<<16) + (b2<<8) + b3;
  if(value > 0x7FFFFF) {
    value = ((~value) & 0x007FFFFF) + 1;
//    SerialUSB.println(value);
    return VREF * (-1) * value / 0x7FFFFF / PGA;
  }
  else{
//    SerialUSB.println(value);
    return VREF * value / 0x7FFFFF / PGA;
   }
}


void ADS1299::startTransform(){
  SPI.transfer(PIN_SS, 0x08);
  SPI.transfer(PIN_SS, 0x10);
}

void ADS1299::endTransform(){
  SPI.transfer(PIN_SS, 0x0A);
  SPI.transfer(PIN_SS, 0x11);
}

//连续读1000次数据
void ADS1299::acquire(boolean isPlotter){
  SPI.transfer(PIN_SS, 0x08);
  SPI.transfer(PIN_SS, 0x10);
//  SPI.setClockDivider(PIN_SS, 4); //提高SPI速率
  for(int i=0;i<1000;i++){
    receiveData(8, isPlotter);
  }
//  SPI.setClockDivider(PIN_SS, 21); //降低SPI速率，传指令
  SPI.transfer(PIN_SS, 0x0A);
  SPI.transfer(PIN_SS, 0x11);
}

//读一次数据
void ADS1299::readData(boolean isPlotter){
  SPI.transfer(PIN_SS, 0x08);
  SPI.transfer(PIN_SS, 0x10);
  receiveData(8, isPlotter);
  SPI.transfer(PIN_SS, 0x0A);
  SPI.transfer(PIN_SS, 0x11);
}
