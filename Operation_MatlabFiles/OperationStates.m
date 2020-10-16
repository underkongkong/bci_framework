classdef OperationStates
    %OPERATIONSTATAS 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        %数据采集状态
            %INIT;%initial
            %CTNS;%connectToNeuroScan
            %DCNS;%disconnectToNeuroScan;
            %STAR;%startReceivedData
            %STOP;%stopReceivedData
        receiverState = 'INIT';
        
        
        
        %基本控制状态
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

