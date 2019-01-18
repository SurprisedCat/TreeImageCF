function [ caching_tree ] = caching_sa(reqs,server_number,cache_capacity,computing_capacity,pop_tree,weight_tree)
%CACHING_SA Summary of this function goes here
%   Detailed explanation goes here
% ��ʹ�������������㷨�ó�һ���ȽϺõ�ֵ
%�洢�ռ併Ϊ��ά
caching_tree = zeros(size(weight_tree,1),server_number);

%Ѱ����������ߵĲ�������
[~,sortIndex] = sort(pop_tree,'descend');  %# Sort the values in descending order
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

%xtotal_cost�ǳ�ʼ�ĳɱ�
cost_utility = costFuncTree( reqs,caching_tree,weight_tree);
[~,pair_cost] = clientSel(cost_utility,computing_capacity);
total_cost=sum(pair_cost);


%������SA�㷨��ʼ
temperature = server_number*cache_capacity;
iterator = 100;
total_cost1 = total_cost;
while(temperature>0.1)
    for i=1:iterator
        %����޸�һЩ������
        temp_tree = saDisturb(caching_tree,reqs,weight_tree,cache_capacity);
        if isequal(temp_tree, caching_tree)
            continue;
        end
        %�����޸ĺ��cost
        cost_utility = costFuncTree( reqs,temp_tree,weight_tree);
        [~,pair_cost] = clientSel(cost_utility,computing_capacity);
        total_cost2=sum(pair_cost);
        
        %��һ���ĸ��ʽ��ղ��ֵ
        delta = total_cost2 - total_cost1 ; 
        if (delta<0)
            caching_tree = temp_tree;
            total_cost1 =  total_cost2;
        else
            if(exp(-delta/temperature)>rand())
                caching_tree = temp_tree;
                total_cost1 =  total_cost2;
            end
        end
    end
    
    temperature = temperature * 0.99;
   % temperature
end
end

