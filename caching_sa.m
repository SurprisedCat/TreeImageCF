function [ caching_tree ] = caching_sa(reqs,server_number,cache_capacity,computing_capacity,pop_tree,weight_tree)
%CACHING_SA Summary of this function goes here
%   Detailed explanation goes here
% 先使用最大层利用率算法得出一个比较好的值
%存储空间降为二维
caching_tree = zeros(size(weight_tree,1),server_number);

%寻找利用率最高的层来缓存
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

%xtotal_cost是初始的成本
cost_utility = costFuncTree( reqs,caching_tree,weight_tree);
[~,pair_cost] = clientSel(cost_utility,computing_capacity);
total_cost=sum(pair_cost);


%这里是SA算法开始
temperature = server_number*cache_capacity;
iterator = 100;
total_cost1 = total_cost;
while(temperature>0.1)
    for i=1:iterator
        %随机修改一些缓存项
        temp_tree = saDisturb(caching_tree,reqs,weight_tree,cache_capacity);
        if isequal(temp_tree, caching_tree)
            continue;
        end
        %计算修改后的cost
        cost_utility = costFuncTree( reqs,temp_tree,weight_tree);
        [~,pair_cost] = clientSel(cost_utility,computing_capacity);
        total_cost2=sum(pair_cost);
        
        %以一定的概率接收差的值
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

