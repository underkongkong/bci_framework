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
serialPort = "/dev/cu.usbmodem14201"  # 串口
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
            print(line)
            line = line.strip()
            if line != b'':
                if line[0] == 35:
                    break

        try:
            if (str(line, encoding="utf-8") == '##########'):
                channel[8].append(1)
            read.append(line)

            if len(line) >= 13:
                line = str(line, encoding="utf-8")
                line = line[1:-1]
                data = line.split(',')
                #            print(data)
                for i in range(len(data)):
                    #                print(i)
                    real = dataconvert(data[i])
                    ##                print(real)
                    channel[i].append(real)
                #                print(len(channel[i]))
                channel[8].append(0)
        except:
            None


# fig = plt.figure(1)
# ax = SubplotZero(fig, 1, 1, 1)
# fig.add_subplot(ax)
x = [4 * i / 250 for i in range(250)]
x = np.array(x)
x_2 = [i / 250 for i in range(1000)]
x_2 = np.array(x_2)
x_3 = [i / 4 + 1 for i in range(100)]
x_3 = np.array(x_3)

# x_3 = np.linspace(1, 26, 100,endpoint=True)
# x_3 = np.array(x_3).tolist()
_thread.start_new_thread(continuous_, (ser,))
while 1:
    if read != []:
        while 1:
            #            if(len(channel[0])>duration*sample_rate):
            #                sio.savemat('saveddata.mat', {'data': np.array(channel[0])})
            #                break
            for i in range(len(channel) - 1):
                filtered[i] = signal.lfilter(b, a, channel[i][-1200:])
                filtered[i] = filtered[i][-1000:]
                filtered[i] = signal.resample(filtered[i], 300)
                filtered[i] = filtered[i][-275:-25]
                try:
                    filtered[i] = signal.detrend(filtered[i])
                    filtered[i][:] = [x - 1500 * 1e-6 * (i) for x in filtered[i]]
                except:
                    filtered[i] = filtered[i] - np.mean(filtered[i])
                    filtered[i][:] = [x - 1500 * 1e-6 * (i) for x in filtered[i]]
            print(len(filtered[0]))
            if len(filtered[0]) >= 250:

                #            plt.subplot(9,2,17)
                #            plt.plot(x_2,channel[8][-1000:], "black")
                #
                #            my_x_ticks = np.arange(0, 4, 0.0025)
                #            my_x_ticks=np.linspace(0, 4, 1000,endpoint=False)
                #            plt.xticks(my_x_ticks)
                #
                #            plt.subplot(9,2,5)
                #            plt.ylabel('uV')
                #            plt.plot(filtered[1],"black")
                #            plt.subplot(9,1,3)
                # #            plt.ylabel('uV')
                #            plt.plot(filtered[2], "darkorange")
                #            plt.subplot(9,1,4)
                # #            plt.ylabel('uV')
                #            plt.plot(filtered[3], "chocolate")
                #            plt.subplot(9,1,5)
                # #            plt.ylabel('uV')
                #            plt.ylabel('Amplitude/V',font2)
                #            plt.plot(filtered[4], "cyan")
                #            plt.subplot(9,1,6)
                # #            plt.ylabel('uV')
                #            plt.plot(filtered[5], "")
                #            plt.subplot(9,1,7)
                # #            plt.ylabel('uV')
                #            plt.plot(filtered[6], "darkslategray")
                #            plt.subplot(9,1,8)
                # #            plt.ylabel('V')
                #            plt.plot(filtered[7], "")
                #            plt.subplot(9,1,9)
                #            plt.plot(channel[8][-1000:], "black")
                #
                # plt.pause(0.5)
                # plt.clf()
                time.sleep(0.5)
                scipy.io.savemat("data.mat", {'A': filtered[0], 'B': filtered[1], 'C': filtered[2], 'D': filtered[3],
                                              'E': filtered[4], 'F': filtered[5], 'G': filtered[6], 'H': filtered[7]})

                # scipy.io.savemat("data.mat", {'A': filtered[0], 'B': filtered[1],'C':filtered[2],'D':filtered[3],'E':filtered[4],'F':filtered[5],'G':filtered[6],'H':filtered[7],'I':channel[8][-1000:],})

#
#        plt.close()
#        break



