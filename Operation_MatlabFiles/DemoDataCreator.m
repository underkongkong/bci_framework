close all
clear all
clc
%%
p1 = mfilename('fullpath');
i = findstr(p1,'\');
p1=p1(1:i(end));
cd(p1);
addpath(genpath([pwd,'\..\..\']));


%��ʼ��¼��־
diary('DemoDataCreatorLog.txt');
diary on;

%����һ����DemoOperator�������������ڽ��շ��͹�����״̬



%��ʼ������������
dataCreatorParameter = DataCreatorParameter();
dataCreatorInterface = DataCreatorImplement();
dataCreatorInterface.initial(dataCreatorParameter);
data = dataCreatorInterface.getData(1,10);
%if(message == 'StartReceiveOK')





    
    
%end