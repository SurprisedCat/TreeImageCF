function [ boolRes ] = setGlobal()

global layer
layer = [3 5]; % first layer started with 2
global alpha
alpha = 0.56;% Zipf parameters
global service_number
service_number =30; %service number
global computing_capacity
computing_capacity = 60;
global client_number
client_number = 200; % the number of clients, each client sends one request
%����ڵ�����
global cache_capacity
cache_capacity = 60; % �洢�ռ�600M,2���ڵ�������ľ�ֵ
global server_number
server_number = 4;%N������ڵ�
boolRes = true;
end

