function [ caching_tree ] = caching_random(server_number,cache_capacity,services_component_index,weight_tree,services_weight)
%CACHING_RANDOM Summary of this function goes here
%   Detailed explanation goes here

service_number = size(services_component_index,1);

%存储空间降为二维
caching_tree = zeros(size(weight_tree,1),server_number);
storage = 0;
temp_caching = zeros(size(weight_tree));
while storage<cache_capacity
    random_sel = randi(service_number);
    if services_weight(random_sel,1)>cache_capacity
        continue;
    end
    %关键：构建缓存树
    layer_index = services_component_index(random_sel,:);
    layer_index(layer_index==0)=[];
    temp_caching(layer_index) = layer_index;
    storage=storageCac(temp_caching,weight_tree);
end

for i = 1:server_number
    caching_tree(:,i)=temp_caching;
end

