clear all;clc;
%ʵ�����
exp_times = 20;
%�����㷨���࣬random��greedy��max_layer_utility��sa��my
test_type = 5;

setGlobal();%Ĭ��ֵ����
% global layer
% layer = [3 5]; % first layer started with 2
% global alpha
% alpha = 0.56;% Zipf parameters
% global service_number
% service_number =30; %service number
% global computing_capacity
% computing_capacity = 60;
% global client_number
% client_number = 200; % the number of clients, each client sends one request
% %����ڵ�����
% global cache_capacity
% cache_capacity = 60; % �洢�ռ�600M,2���ڵ�������ľ�ֵ
% global server_number
% server_number = 5;%N������ڵ�
% boolRes = true;

setGlobal();%Ĭ��ֵ����
%���Լ��ϣ���������
global client_number
test_set = [50 100 150 200 250 300 350 400 450 500];
global computing_capacity
computing_capacity = 105;
test_set_num = size(test_set,2);
exp_client_number=zeros(test_set_num,test_type,exp_times);
for i = 1:test_set_num
    client_number=test_set(i);
     client_number
    for j=1:exp_times
        exp_client_number(i,:,j)= main();
    end
end
exp_client_number_aver = mean(exp_client_number,3);
return 
%���Լ���
% global computing_capacity
% test_set = [45 50 55 60 65 70 80];
% test_set_num = size(test_set,2);
% exp_computing_capacity=zeros(test_set_num,test_type,exp_times);
% for i = 1:test_set_num
%     computing_capacity=test_set(i)
%     for j=1:exp_times
% %         exp_computing_capacity(i,:,j)= main();
%     end
% end
% exp_computing_capacity_aver = mean(exp_computing_capacity,3);
 
% setGlobal();%Ĭ��ֵ����
% %���Լ��ϣ���������
% global service_number
% test_set = [20 30 40 50 60 70 80 90];
% test_set_num = size(test_set,2);
% exp_service_number=zeros(test_set_num,test_type,exp_times);
% for i = 1:test_set_num
%     service_number=test_set(i)
%     for j=1:exp_times
%         exp_service_number(i,:,j)= main();
%     end
% end
% exp_service_number_aver = mean(exp_service_number,3);
% return

setGlobal();%Ĭ��ֵ����
%���Լ��ϣ���������
global alpha
test_set = [0.3 0.4 0.5 0.6 0.7 0.8 0.9 1 1.1];
test_set_num = size(test_set,2);
exp_alpha=zeros(test_set_num,test_type,exp_times);
for i = 1:test_set_num
    alpha=test_set(i)
    for j=1:exp_times
        exp_alpha(i,:,j)= main();
    end
end
exp_alpha_aver = mean(exp_alpha,3);
return 

setGlobal();%Ĭ��ֵ����
%���Լ��ϣ���������
global server_number
test_set = [4 5 6 7 8 9];
test_set_num = size(test_set,2);
exp_server_number=zeros(test_set_num,test_type,exp_times);
for i = 1:test_set_num
    server_number=test_set(i)
    for j=1:exp_times
        exp_server_number(i,:,j)= main();
    end
end
exp_server_number_aver = mean(exp_server_number,3);
return 