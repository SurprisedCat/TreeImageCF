function [ services_index,services_component,tree_3] = services(service_number,layer )
%SERVICES Summary of this function goes here
%   This funciton generate "service_number" services.
%   return the most popular "service_number" services

% average size aver_size Poisson distribution
% Popularity popular Zipf distribution
% Layer layer , each layer has (layer+n)*(layer+n) options, Power law distribution

max_layer = layer(2);
min_layer = layer(1);
services_component = zeros(service_number,max_layer);

start = (3^(min_layer)-1)/2;
fin = (3^(max_layer+1)-3)/2;
%total service space size 10,20,30,40,50,60,70,80,90,100
tree_3 = randi([1 10],fin,1);

services_index = randi([start fin],service_number,1);
%组成
temp = services_index;
for i=max_layer:-1:1
    temp_res = mod(temp,3);
    temp_res(temp_res == 0)=3;
    services_component(:,i) =temp_res;
    temp = fix((temp-1)/3);
    temp(temp==0)=NaN;
end
%NaN变成0
services_component(isnan(services_component)) = 0;
for i=1:service_number
    while services_component(i,1)==0
        services_component(i,:)=circshift(services_component(i,:),[0 -1]);
    end
end
end

