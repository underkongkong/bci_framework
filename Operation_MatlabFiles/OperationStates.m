classdef OperationStates

    
    properties
        %DateCollectin States
            %INIT;%initial
            %CTNS;%connectToNeuroScan
            %DCNS;%disconnectToNeuroScan;
            %STAR;%startReceivedData
            %STOP;%stopReceivedData
        receiverState = 'INIT';
        
        
        
        %Control states
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

