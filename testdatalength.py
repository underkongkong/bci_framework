import matplotlib.pyplot as plt
from scipy import signal
from mpl_toolkits.axisartist.axislines import SubplotZero
import numpy as np
import serial
import _thread
from scipy import signal
import scipy.io
import time

read = []
serialPort = "COM3"  # 串口
baudRate = 115200  # 波特率
ser = serial.Serial(serialPort, baudRate, timeout=0.5)
N_channel = 2
times = 1
channel = [[] for i in range(9)]
filtered = [[] for i in range(9)]
times_ = 0


def continuous_(ser):
    global read
    print("***********************")
    while 1:
        while 1:
            line = ser.readline()
            line = line.strip()
            if line != b'':
                break

        try:
            if str(line, encoding="utf-8") == '##########':
                channel[8].append(1)
            read.append(line)
            # print(len(line))
            
            line = str(line, encoding="utf-8")
            # line = line[1:-1]
            data = line.split(',')
            # print(data)
            for i in range(len(data)):
                # print(i)
                # real = dataconvert(data[i])
                # print(real)
                channel[i].append(data[i])
                # print(len(channel[i]))
            channel[8].append(0)
        except:
            None

_thread.start_new_thread(continuous_, (ser,))
while 1:
    if read:
        while 1:
            a=len(channel[1])
            time.sleep(1)
            b=len(channel[1])
            print(b-a)


