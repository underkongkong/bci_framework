classdef OperationStates
    %OPERATIONSTATAS �˴���ʾ�йش����ժҪ
    %   �˴���ʾ��ϸ˵��
    
    properties
        %���ݲɼ�״̬
            %INIT;%initial
            %CTNS;%connectToNeuroScan
            %DCNS;%disconnectToNeuroScan;
            %STAR;%startReceivedData
            %STOP;%stopReceivedData
        receiverState = 'INIT';
        
        
        
        %��������״̬
            %INIT;%initial
            %STON;%startOperation
            %SPON;%stopOperation
            %CSAL;%CloseAllOperation
            %EXIT;%Exit Program
        controlState = 'INIT';

    end
    
    methods
        function obj = OperationStates()

        end

    end
end

