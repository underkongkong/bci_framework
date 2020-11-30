close all
clear all
clc
%%
p1 = mfilename('fullpath');
i = findstr(p1,'\');
p1=p1(1:i(end));
cd(p1);
addpath(genpath([pwd,'\..\..\']));


%开始记录日志
diary('DemoDataCreatorLog.txt');
diary on;

%创建一个与DemoOperator的连接器，用于接收发送过来的状态



%初始化数据生成器
dataCreatorParameter = DataCreatorParameter();
dataCreatorInterface = DataCreatorImplement();
dataCreatorInterface.initial(dataCreatorParameter);
data = dataCreatorInterface.getData(1,10);
%if(message == 'StartReceiveOK')





    
    
%end