function [caching_tree] = caching_utility(server_number,cache_capacity,services_component_index,pop_tree,weight_tree,services_weight);
%CACHING_UTILITY Summary of this function goes here
%   Detailed explanation goes here
%存储空间降为二维
caching_tree = zeros(size(weight_tree,1),server_number);

%寻找利用率最高的层来缓存
[sortedValues,sortIndex] = sort(pop_tree,'descend');  %# Sort the values in descending order
server_counter = 1;
temp_caching = zeros(size(weight_tree));
for i=1:size(sortIndex,1)
    temp = sortIndex(i);
    while temp>0
        temp_caching(temp)=temp;   
        temp = fix((temp-1)/3);       
    end  
    storage = storageCac(temp_caching,weight_tree);
    if storage > cache_capacity || i==size(sortIndex,1)
        caching_tree(:,server_counter)=temp_caching;
        server_counter=server_counter+1;
        temp_caching = zeros(size(weight_tree));
    end
    if server_counter>server_number
        break;
    end
end

end

