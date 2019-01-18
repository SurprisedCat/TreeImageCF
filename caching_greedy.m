function [ caching_tree ] = caching_greedy(server_number,cache_capacity,services_component_index,weight_tree,services_weight)
%CACHING_GREEDY Summary of this function goes here
%   Detailed explanation goes here

%�洢�ռ併Ϊ��ά
caching_tree = zeros(size(weight_tree,1),server_number);
storage = zeros(1,server_number);
service_num = size(services_component_index,1);
%���澡���ܶ�����ݣ�counter�����������
counter = 1;
for i = 1:server_number
    temp_caching = zeros(size(weight_tree));
    while storage(i)<cache_capacity
        if counter>service_num
            counter = mod(counter,service_num);
        end
        %�ؼ�������������
        layer_index = services_component_index(counter,:);
        if services_weight(counter,1)>cache_capacity
            counter=counter+1;
            continue;
        end
        counter=counter+1;
        if counter>service_num
            counter = mod(counter,service_num);
        end
        layer_index(layer_index==0)=[];
        caching_tree(:,i)=temp_caching;
        % use a temp_caching to calculate the potential overwhelmed caching
        % space
        temp_caching(layer_index) = layer_index;
        storage(i)=storageCac(temp_caching,weight_tree);
    end
   
end

end

