classdef Operator < handle

    properties
        operationState;
        DATAPOOL;
    end
    
    properties
        tcpserver;
    end
    
    properties
        PointsInOneFigure;
    end

    events
        INIT;
        STAR;%startReceivedData
        STOP;%stopReceivedData
        CLRT;%ClearResultOperation
        
    end
    events
        STON;%StartOperation
        SPON;%StopOperation
        CSAL;%CloseAllOperation
    end

%     events
%         STRD;%StartRealTimeDetection
%         EXIT;%Exit Program
%     end
    

    
    methods
        function doConn(obj,event)
            disp('Starting connection..........')
            try 
                obj.tcpserver= tcpip('0.0.0.0', 8080, 'NetworkRole', 'server');%连接这个ip和这个端口的UDP服务器
                %t.BytesAvailableFcnMode='byte'
                set(obj.tcpserver, 'InputBufferSize', 32000); %Buffer size must be set larger than data length
                fopen(obj.tcpserver);
                disp('Connection Success');
            catch ErrorInfo
                disp('Connection Failed')
                disp(ErrorInfo);  
            end
            
            %fwrite(obj.tcpserver,'please sent');%send a message to
            %tcpclient 
            obj.operationState.receiverState = 'STAR';
            disp('Waiting for data..........')
            while(1) %Polling until catching some data then break
                nBytes = get(obj.tcpserver,'BytesAvailable');
                if nBytes>0
                    disp('Data catched!')
                    break;
                end
            end
        end
        
        function doSTAR(obj,event)
            disp('Start receiving and showing Data')
            %initial some parameters
            obj.PointsInOneFigure=8000;
            timebase=[0:159]
            Numtotal=0; %How many times receive data（each time contains 160 points）
            NumInOneFigure=0;%Data transfer number in the current Figure (n?*160 in 8000)
            savedataNum=0;
            pots=[];
            figure(1);
            %Begin receiving data
            while(1)
                %Each circle read data twice, the first to read the pkgsize of
                %data, in the Second time, use pkgsize to read a Json Data
                %perfectly. This function needs Raspberry Pi client to
                %cooperate。
                
                pkgsize_temp = fread(obj.tcpserver,5);
                pkgsize=str2num(char(pkgsize_temp(1:end)')); 
                if size(pkgsize,1)==0  %if can't receive any data, break the circle 
                    break;
                end
               
                receive = fread(obj.tcpserver,pkgsize);
                obj.DATAPOOL.inputData = char(receive(1:end)');
                receive=char(receive(1:end)');    %ASCII to char
                DataStruct=jsondecode(receive);    %Decode json data into strcut variable
                
                disp(receive)
                obj.DATAPOOL.totalData = [obj.DATAPOOL.totalData,DataStruct.dec_data'];%Add current data to data pool
                
                if mod(Numtotal,obj.PointsInOneFigure)==0 %
                    %save data
                    savedata=obj.DATAPOOL.totalData;
                    filename=strcat('D:\Graduation_Project\Documents_Programming\Files_Matlab\Operation_MatlabFiles\Data_Received\EEG_signal_time',num2str(savedataNum),'.mat');
                    save(filename,'savedata')
                    %clear figure
                    clf(1);
                    %clear data pool buffer
                    obj.DATAPOOL.totalData=[];
                    %clear X axis number
                    pots=[];
                    NumInOneFigure=0;
                    
                    Numtotal=Numtotal+160;
                    savedataNum=savedataNum+1;
                    continue 
                end
                %change X in one Figure
                timetemp=timebase+NumInOneFigure;
                pots=[pots timetemp];
                
                %Draw the figure, 8 channels 
                plot(pots,obj.DATAPOOL.totalData(1,:)+0.4)
                hold on
                plot(pots,obj.DATAPOOL.totalData(2,:)+0.3)
                hold on
                plot(pots,obj.DATAPOOL.totalData(3,:)+0.2)
                hold on
                plot(pots,obj.DATAPOOL.totalData(4,:)+0.1)
                hold on
                plot(pots,obj.DATAPOOL.totalData(5,:))
                hold on
                plot(pots,obj.DATAPOOL.totalData(6,:)-0.1)
                hold on
                plot(pots,obj.DATAPOOL.totalData(7,:)-0.2)
                hold on
                plot(pots,obj.DATAPOOL.totalData(8,:)-0.3)
                axis([0,obj.PointsInOneFigure,-0.4,0.7]); %set axes Limits
                
                Numtotal=Numtotal+160;
                NumInOneFigure=NumInOneFigure+160;
                pause(0.04)
            end
            %message = 'StartReceiveOK';
            %%%if local show, use these codes, waiting to be updated
            %   dataCreatorParameter = DataCreatorParameter();
            %   dataCreatorInterface = DataCreatorImplement();
            %   dataCreatorInterface.initial(dataCreatorParameter);
            %   data = dataCreatorInterface.getData(1,10);

        end
        
        %%if Fieldtrip, use these codes, waiting to be updated
%         function show(obj,event)
%             cfg                = [];
%             cfg.blocksize      = 1;                            % seconds
%             cfg.dataset        = 'buffer://localhost:1972';    % where to read the data
%             ft_realtime_signalviewer(cfg)
%         end
        
        function doSTOP(obj,event)
            %message = 'StopReceiveOK';
            obj.operationState.receiverState = 'STOP';
            disp('Stop data receiving');
            %Close TCPIP connection
            fclose(obj.tcpserver);
            delete(obj.tcpserver);
        end
        
        
        function doSTON(obj,event)
            
            message = 'StartOperationOK';
            
            obj.operationState.controlState = 'STON';
            
            disp('Start Data processing....');
            obj.DATAPOOL.outputData = sum(obj.DATAPOOL.totalData);
            obj.DATAPOOL.outputData
        end
        
        function doSPON(obj,event)
            
            message = 'StopOperationOK';
            
            obj.operationState.controlState = 'SPON';
            
            disp('Stop Data processing....');

        end
        function doCSAL(obj,event)
            
            obj.operationState.controlState = 'CSAL';
            
            disp('Stop all functions');      
            
        end
        function doCLRT(obj,event)
            
            obj.DATAPOOL.clear();
            
            disp('Clear all data buffer');
        end
          
  
        function doEXIT(obj,event)
            obj.operationState.controlState = 'EXIT';
            disp('READY TO QUIT.....');
        end
        
        
%         function doSTRD(obj,event)
%             obj.operationState.currentDetectState = 'STRD';
%             disp('READY TO PROCESS DATA REALTIME');
%         end
    end
    
end

