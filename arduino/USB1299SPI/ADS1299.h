#include "definition.h"
#include "Arduino.h"
#include <SPI.h>

class ADS1299{
  public:
    ADS1299(int PIN_SS, int PIN_DRDY, int PIN_RST, int PIN_START, int PIN_CLKSEL);

    void initialize(); //初始化，对所有寄存器的写入
    
    byte readReg(byte regID); //读一个寄存器，chip接片选引脚，regID寄存器ID
    // byte readReg(byte regID, int num);
    void writeReg(byte regID, byte value); //写一个寄存器
    void waitForDRDY(void); //等待DRDY信号
    
    void readAllReg();
    void changeToNormalElectrode(); // 
    void changeToTestSignal();
    void changeToInputShort();
    void changeOutputDataRate();

    void setConfig1();
    void setConfig2();
    void setConfig3();
    void setChannel(int channel, int gain, bool onSRB2, int mux);
    void setLOFF();

    void setSRB1(bool on);
    void setLOFF(boolean on);
    void enableSRB1(); //可移除
    void disableSRB1(); //可移除
    
    double complementCodeToDouble(byte b1, byte b2, byte b3);
    void receiveData(int channelNum, bool isPlotter);

    void startTransform();
    void endTransform();
    void acquire(bool isPlotter);
    void readData(bool isPlotter);
    void acquirec(bool isPlotter);
    
  private:
    int PIN_SS;
    int PIN_DRDY;
    int PIN_RST;
    int PIN_START;
    int PIN_CLKSEL;
    unsigned long LOFFstatus;
};

/*
setSRB1(0 or 1) -> enable/disable

*/
