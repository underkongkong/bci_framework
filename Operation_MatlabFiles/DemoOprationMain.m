close all;
% clear all;
clc;

%%
p1 = mfilename('fullpath');
i = findstr(p1,'\');
p1=p1(1:i(end));
cd(p1);
addpath(genpath([pwd,'\..\']));


%record
diary('.\DemoOperationLog.txt');
diary on;

%init Operator
OperationStates = OperationStates();

timer=0;

%init Datapool
DATAPOOL= DATAPOOL();
DATAPOOL.initial();

%create an Operator State Change reality
OperatorStateChange = OperatorStateChange();

%
OperatorStateChange.operationState = OperationStates;
OperatorStateChange.DATAPOOL=DATAPOOL;

%operateExchangeMessageOperator.exchangeMessageManagement = exchangeMessageManagement;
%operateExchangeMessageOperator.realTimeReader = realTimeReader;
%operateExchangeMessageOperator.analysisController = analysisController;
OperatorStateChange.doSTAR();

while(OperatorStateChange.operationState.receiverState=='STAR')
timer=timer+1;
OperatorStateChange.doSTAR();
pause(1)
if(timer==10)
    OperatorStateChange.doSTOP();
end
end

OperatorStateChange.doSTON();
pause(2)
OperatorStateChange.doSPON();
pause(2)
OperatorStateChange.doCSAL();
pause(2)
OperatorStateChange.doCLRT();
pause(2)
OperatorStateChange.doEXIT();



