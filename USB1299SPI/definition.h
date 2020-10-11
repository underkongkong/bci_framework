/*
1298 DSLogic  Arduino
SCLK 0 灰  上排中间
DIN  1 棕  下排中间
DOUT 2 红  上排右边
CS_1 3 橙   4
DRDY 4 黄   28
RST  5 绿   40
CLKSEL 6 蓝  52  
START 7 紫   24
地线 下排左边
1298地线 drdy的对角

电源连三根线,J4参考点对面两个，和3.3V上面，隔一个，正对着DSP板子的豁口
*/

#define CMD_RDATA 0x12
#define CMD_RDATAC 0x10
#define CMD_SDATAC 0x11
#define CMD_STOP 0x0A
#define CMD_RREG 0x20
#define CMD_WREG 0x40

//Register Addresses
#define ID 0x00
#define CONFIG1 0x01
#define CONFIG2 0x02
#define CONFIG3 0x03
#define LOFF 0x04
#define CH1SET 0x05
#define CH2SET 0x06
#define CH3SET 0x07
#define CH4SET 0x08
#define CH5SET 0x09
#define CH6SET 0x0A
#define CH7SET 0x0B
#define CH8SET 0x0C
#define BIAS_SENSP 0x0D
#define BIAS_SENSN 0x0E
#define LOFF_SENSP 0x0F
#define LOFF_SENSN 0x10
#define LOFF_FLIP 0x11
#define LOFF_STATP 0x12
#define LOFF_STATN 0x13
#define GPIO 0x14
#define MISC1 0x15
#define MISC2 0x16
#define CONFIG4 0x17
