function [ caching_tree ] = caching_my(server_number,layer,cache_capacity,weight_tree,pop_tree)
%CACHING_MY Summary of this function goes here
%   server_number 服务器数量，标量
%   layer 层数，结构为[min_layer max_layer]
%   cache_capacity 缓存的最大容量
%   weight_tree 层大小权重树
%   pop_tree 流行度权重树

accumulate_weight_tree = zeros(size(weight_tree));
for i=1:3
    accumulate_weight_tree(i)= weight_tree(i);
end
for i=4:(3^(layer(2)+1)-3)/2
    %总大小为本层加上底下的层大小
    accumulate_weight_tree(i) = weight_tree(i)+accumulate_weight_tree(fix((i-1)/3));
end
%算法1 分簇
aggregate_layer = layer(1);
aggregate_start = (3^aggregate_layer-1)/2;
aggregate_end = (3^(aggregate_layer+1)-3)/2;
accumulate_counter = 0;
%对一个服务的操作
server_response_req = zeros(1,server_number);
for s = 1:server_number
    accumulate_propability = 0;
    % 每个服务器的服务概率不应该大于1/server_number，负载均衡考虑，实际上大一点也没关系
    while accumulate_propability < 1/server_number && aggregate_start+accumulate_counter < aggregate_end
        accumulate_propability =  accumulate_propability+pop_tree(aggregate_start+accumulate_counter);
        accumulate_counter = accumulate_counter +1;
    end
    server_response_req(s) = aggregate_start+accumulate_counter;
end
%得到的是每一个服务器所需要负责到的序号数字，出于谨慎，我们除了最后一个数字外，其他的减1
server_response_req(1:end-1) = server_response_req(1:end-1)-1;
%分簇完成

%算法2 基于树枝的缓存+概率更新 
%caching_tree 二维矩阵
caching_tree = zeros(size(weight_tree,1),server_number);
storage = zeros(1,server_number);
%开始基于树枝的缓存，因为提前分簇不需要概率更新了
%每一个服务器只需要处理本服务请求范围内的内容
%通过这种方式还可以体现出来一定的负载均衡的优势
independence_start = aggregate_start;
for s = 1:server_number
    %把服务器的树独立出来，需要一个二元矩阵
    %根节点，子节点分别挑选出来
    independence_tree = zeros(size(pop_tree));
    for i=independence_start:server_response_req(s)
        %父节点,回溯
        temp = i;
        while temp>0
            if independence_tree(temp)==1
                break;
            end
            independence_tree(temp)=1;
            temp = fix((temp-1)/3);
        end
        %子节点，遍历
        %以树的第i个节点为根，开始遍历
        independence_tree = tree_iter(independence_tree,i,layer);
    end
    % 开始节点变化，从上一个结束节点+1开始
    independence_start = server_response_req(s)+1;
    
    %pop_tree,independence_tree相乘得到独立概率树independence_pop_tree
    independence_pop_tree = pop_tree.*independence_tree;
    
    %修正independence_pop_tree的概率，有一些分支不在此服务器的服务范围
    %这里存在一些不到最后一行的镜像，因此不能直接从最后一行回溯求和
    %分成两部分考虑，第一部分layer(1)层--layer(2)层的服务，这些可以直接用原来的代替
    %主要是1-layer(1)-1层需要重新计算
    %(3^layer(1)-1)/2-1 表示layer（1）层最开始元素-1
    for i=(3^layer(1)-1)/2-1:-1:1
        independence_pop_tree(i) = independence_pop_tree(i*3+1) ...
        +independence_pop_tree(i*3+2)+independence_pop_tree(i*3+3);
    end
    
    
    %基于independence_pop_tree进行缓存
    %性价比树,基于数值来计算
    pwr_tree = independence_pop_tree./accumulate_weight_tree;%存在一些0/0的情况
    pwr_tree(isnan(pwr_tree))=0;
    pwr_tree(1:3)=independence_pop_tree(1:3)./weight_tree(1:3);%开始的时候最下层启动
    while storage(s) < cache_capacity
        [value,index] = max(pwr_tree);
        caching_tree(index,s)=index;
        %最大概率值置0
        pwr_tree(index)=0;
        %更新相关节点下层的概率
        if index*3+3<size(pwr_tree,1)
            pwr_tree(index*3+1:index*3+3)= ...
                independence_pop_tree(index*3+1:index*3+3)./weight_tree(index*3+1:index*3+3);
        end
        storage(s) = storage(s)+weight_tree(index);
    end
    %pop_tree-independence_pop_tree修正现存概率
    pop_tree = pop_tree - independence_pop_tree; 
end


