function [ caching_tree ] = caching_my(server_number,layer,cache_capacity,weight_tree,pop_tree)
%CACHING_MY Summary of this function goes here
%   server_number ����������������
%   layer �������ṹΪ[min_layer max_layer]
%   cache_capacity ������������
%   weight_tree ���СȨ����
%   pop_tree ���ж�Ȩ����

accumulate_weight_tree = zeros(size(weight_tree));
for i=1:3
    accumulate_weight_tree(i)= weight_tree(i);
end
for i=4:(3^(layer(2)+1)-3)/2
    %�ܴ�СΪ������ϵ��µĲ��С
    accumulate_weight_tree(i) = weight_tree(i)+accumulate_weight_tree(fix((i-1)/3));
end
%�㷨1 �ִ�
aggregate_layer = layer(1);
aggregate_start = (3^aggregate_layer-1)/2;
aggregate_end = (3^(aggregate_layer+1)-3)/2;
accumulate_counter = 0;
%��һ������Ĳ���
server_response_req = zeros(1,server_number);
for s = 1:server_number
    accumulate_propability = 0;
    % ÿ���������ķ�����ʲ�Ӧ�ô���1/server_number�����ؾ��⿼�ǣ�ʵ���ϴ�һ��Ҳû��ϵ
    while accumulate_propability < 1/server_number && aggregate_start+accumulate_counter < aggregate_end
        accumulate_propability =  accumulate_propability+pop_tree(aggregate_start+accumulate_counter);
        accumulate_counter = accumulate_counter +1;
    end
    server_response_req(s) = aggregate_start+accumulate_counter;
end
%�õ�����ÿһ������������Ҫ���𵽵�������֣����ڽ��������ǳ������һ�������⣬�����ļ�1
server_response_req(1:end-1) = server_response_req(1:end-1)-1;
%�ִ����

%�㷨2 ������֦�Ļ���+���ʸ��� 
%caching_tree ��ά����
caching_tree = zeros(size(weight_tree,1),server_number);
storage = zeros(1,server_number);
%��ʼ������֦�Ļ��棬��Ϊ��ǰ�ִز���Ҫ���ʸ�����
%ÿһ��������ֻ��Ҫ������������Χ�ڵ�����
%ͨ�����ַ�ʽ���������ֳ���һ���ĸ��ؾ��������
independence_start = aggregate_start;
for s = 1:server_number
    %�ѷ���������������������Ҫһ����Ԫ����
    %���ڵ㣬�ӽڵ�ֱ���ѡ����
    independence_tree = zeros(size(pop_tree));
    for i=independence_start:server_response_req(s)
        %���ڵ�,����
        temp = i;
        while temp>0
            if independence_tree(temp)==1
                break;
            end
            independence_tree(temp)=1;
            temp = fix((temp-1)/3);
        end
        %�ӽڵ㣬����
        %�����ĵ�i���ڵ�Ϊ������ʼ����
        independence_tree = tree_iter(independence_tree,i,layer);
    end
    % ��ʼ�ڵ�仯������һ�������ڵ�+1��ʼ
    independence_start = server_response_req(s)+1;
    
    %pop_tree,independence_tree��˵õ�����������independence_pop_tree
    independence_pop_tree = pop_tree.*independence_tree;
    
    %����independence_pop_tree�ĸ��ʣ���һЩ��֧���ڴ˷������ķ���Χ
    %�������һЩ�������һ�еľ�����˲���ֱ�Ӵ����һ�л������
    %�ֳ������ֿ��ǣ���һ����layer(1)��--layer(2)��ķ�����Щ����ֱ����ԭ���Ĵ���
    %��Ҫ��1-layer(1)-1����Ҫ���¼���
    %(3^layer(1)-1)/2-1 ��ʾlayer��1�����ʼԪ��-1
    for i=(3^layer(1)-1)/2-1:-1:1
        independence_pop_tree(i) = independence_pop_tree(i*3+1) ...
        +independence_pop_tree(i*3+2)+independence_pop_tree(i*3+3);
    end
    
    
    %����independence_pop_tree���л���
    %�Լ۱���,������ֵ������
    pwr_tree = independence_pop_tree./accumulate_weight_tree;%����һЩ0/0�����
    pwr_tree(isnan(pwr_tree))=0;
    pwr_tree(1:3)=independence_pop_tree(1:3)./weight_tree(1:3);%��ʼ��ʱ�����²�����
    while storage(s) < cache_capacity
        [value,index] = max(pwr_tree);
        caching_tree(index,s)=index;
        %������ֵ��0
        pwr_tree(index)=0;
        %������ؽڵ��²�ĸ���
        if index*3+3<size(pwr_tree,1)
            pwr_tree(index*3+1:index*3+3)= ...
                independence_pop_tree(index*3+1:index*3+3)./weight_tree(index*3+1:index*3+3);
        end
        storage(s) = storage(s)+weight_tree(index);
    end
    %pop_tree-independence_pop_tree�����ִ����
    pop_tree = pop_tree - independence_pop_tree; 
end


