clear;
arduino = Arduino('COM3',115200);

data = arduino.getdata(2000);

save('buffer.mat','data');



