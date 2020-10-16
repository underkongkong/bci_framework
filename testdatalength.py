import matplotlib.pyplot as plt
from scipy import signal
from mpl_toolkits.axisartist.axislines import SubplotZero
import numpy as np
import serial
import _thread
from scipy import signal
import scipy.io
import time

duration = 500
sample_rate = 250


def dataconvert(input_data):
    ch_1_data = int(input_data)
    if ch_1_data > 0x7FFFFF:
        ch_1_data = (~(ch_1_data) & 0x007FFFFF) + 1
        real = float(ch_1_data * (-4.5) / 0x7FFFFF / 24)
    else:
        real = float(ch_1_data * 4.5 / 0x7FFFFF / 24)
    return real


b, a = signal.butter(10, 30, 'lowpass', fs=250)
read = []
serialPort = "COM5"  # 串口
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
                if line[0] == 35:
                    break

        try:
            if str(line, encoding="utf-8") == '##########':
                channel[8].append(1)
            read.append(line)
            # print(len(line))
            if len(line) >= 13:
                line = str(line, encoding="utf-8")
                line = line[1:-1]
                data = line.split(',')
                # print(data)
                for i in range(len(data)):
                    # print(i)
                    real = dataconvert(data[i])
                    # print(real)
                    channel[i].append(real)
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


