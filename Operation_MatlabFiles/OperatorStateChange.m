classdef OperatorStateChange < handle

    properties

        operationState;
        
        DATAPOOL;
    end
    
    events

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
        function doSTAR(obj,event)
            message = 'StartReceiveOK';
            
            obj.operationState.receiverState = 'STAR';
           
            disp('开始接收数据');
            
            dataCreatorParameter = DataCreatorParameter();
            dataCreatorInterface = DataCreatorImplement();
            dataCreatorInterface.initial(dataCreatorParameter);
            data = dataCreatorInterface.getData(1,10);
            
            obj.DATAPOOL.inputData = data;
            obj.DATAPOOL.totalData = [obj.DATAPOOL.totalData,obj.DATAPOOL.inputData];
            obj.DATAPOOL.inputData
        end
        
        function doSTOP(obj,event)

            message = 'StopReceiveOK';
            
            obj.operationState.receiverState = 'STOP';
            
            disp('停止接收数据');

            fprintf('发送消息%s\n',message);
        end
        function doSTON(obj,event)
            
            message = 'StartOperationOK';
            
            obj.operationState.controlState = 'STON';
            
            disp('设置为开始数据处理状态');
            obj.DATAPOOL.outputData = sum(obj.DATAPOOL.totalData);
            obj.DATAPOOL.outputData
        end
        
        function doSPON(obj,event)
            
            message = 'StopOperationOK';
            
            obj.operationState.controlState = 'SPON';
            
            disp('设置为停止数据处理状态');

            fprintf('发送消息%s\n',message);
        end
        function doCSAL(obj,event)
            
            obj.operationState.controlState = 'CSAL';
            
            disp('设置为停止所有操作状态');      
            
        end
        function doCLRT(obj,event)
            
            obj.DATAPOOL.clear();
            
            disp('接收Del指令，已清理缓存内容');
        end
          
  
        function doEXIT(obj,event)
            obj.operationState.controlState = 'EXIT';
            disp('处理程序准备退出');
        end
        
        
        function doSTRD(obj,event)
            obj.operationState.currentDetectState = 'STRD';
            disp('准备进入实时处理模式');
            
            
        end
    end
    
end

