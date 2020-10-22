classdef Arduino
    properties
        port;
        baudrate;
        
    end
    
    properties(Access=private)
        serial;
    end
    
    methods %构造
        function obj=Arduino(port,baudrate)
            obj.port = port;
            obj.baudrate = baudrate;
            obj.serial = serialport(obj.port,obj.baudrate);
        end
    end
    
    methods
        function openserial(arduino)
            fopen(arduino.serial);
        end
        
        function data = getdata(arduino,points)
            all_signal = [];
            for i=1:points
                line = readline(arduino.serial);
%                 fprintf(line);
                newline=split(line,{'#',','});
                if size(newline,1) ~= 10
                    continue;
                end
                newline=newline(2:9);
                signal = zeros(8,1);
                for k=1:size(newline,1)
                    signal(k) = str2num(newline(k));
                end
                all_signal=cat(2,all_signal,signal);
            end
            data=all_signal;
        end
    end
end