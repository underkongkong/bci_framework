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
           
            disp('��ʼ��������');
            
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
            
            disp('ֹͣ��������');

            fprintf('������Ϣ%s\n',message);
        end
        function doSTON(obj,event)
            
            message = 'StartOperationOK';
            
            obj.operationState.controlState = 'STON';
            
            disp('����Ϊ��ʼ���ݴ���״̬');
            obj.DATAPOOL.outputData = sum(obj.DATAPOOL.totalData);
            obj.DATAPOOL.outputData
        end
        
        function doSPON(obj,event)
            
            message = 'StopOperationOK';
            
            obj.operationState.controlState = 'SPON';
            
            disp('����Ϊֹͣ���ݴ���״̬');

            fprintf('������Ϣ%s\n',message);
        end
        function doCSAL(obj,event)
            
            obj.operationState.controlState = 'CSAL';
            
            disp('����Ϊֹͣ���в���״̬');      
            
        end
        function doCLRT(obj,event)
            
            obj.DATAPOOL.clear();
            
            disp('����Delָ�������������');
        end
          
  
        function doEXIT(obj,event)
            obj.operationState.controlState = 'EXIT';
            disp('�������׼���˳�');
        end
        
        
        function doSTRD(obj,event)
            obj.operationState.currentDetectState = 'STRD';
            disp('׼������ʵʱ����ģʽ');
            
            
        end
    end
    
end

