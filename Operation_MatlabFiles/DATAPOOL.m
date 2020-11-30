classdef DATAPOOL
    %DATAPOOL 
    %   
    
    properties
        inputData;
        
        outputData;
        
        totalData;
    end
    
    methods
        %initial function to init the totalData
        function obj = initial(obj)
            obj.totalData=[];
        end
        
        %clear all data
        function clear(obj)
            obj.inputData=[];
            obj.outputData=[];
            obj.totalData=[];
        end
        
    end
end

