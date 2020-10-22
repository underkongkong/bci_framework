function [output] = dataconvert(input)
temp=input(1);
if temp > 0x7FFFFF
    temp = (~(temp) & 0x007FFFFF) + 1;
    real = temp * (-4.5) / 0x7FFFFF / 24;
else
    real = temp * 4.5 / 0x7FFFFF / 24;
end
output=real;

