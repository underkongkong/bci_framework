close all;
% clear all;
clc;

%%
p1 = mfilename('fullpath');
i = findstr(p1,'\');
p1=p1(1:i(end));
cd(p1);
addpath(genpath([pwd,'\..\']));


%Log
diary('.\DemoOperationLog.txt');
diary on;

%init Operator properties
OperationStates = OperationStates(); 	%create OperationStates object

DATAPOOL= DATAPOOL();					%create DATAPOOL object
DATAPOOL.initial();						%init Datapool

Operator = Operator();	%create an Operator object
%initialize Operator
Operator.operationState = OperationStates;  
Operator.DATAPOOL=DATAPOOL;

Operator.doConn(); %connect to Raspberry Pi using TCPIP
Operator.doSTAR(); %receive Data from Raspberry Pi and show data realtime
Operator.doSTOP(); %stop the connection to Raspberry Pi
Operator.doSTON(); %Data processor
pause(2)
Operator.doSPON(); %stop data processing 
pause(2)
Operator.doCSAL();
pause(2)
Operator.doCLRT();
pause(2)
Operator.doEXIT();



