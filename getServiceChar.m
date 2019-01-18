function [pop_tree, services_pop,weight_tree,services_weight] = getServiceChar(services_component_index,tree_3,alpha)
% setServiceChar 设置服务的性质，大小和流行度

service_number = size(services_component_index,1);
layer = size(services_component_index,2);

%popularity zipf
Prob=zeros(service_number,1);
for idx=1:service_number
    Prob(idx)=(1/idx)^alpha;
end
Prob=Prob/sum(Prob);
%services_pop contains popularity,声明大小
services_pop = services_component_index;
services_pop = [Prob';services_pop']';

pop_tree = zeros(size(tree_3));
for i=1:service_number
    %去除0元素
    temp_index = services_component_index(i,services_component_index(i,:)~=0);
    pop_tree(temp_index)=pop_tree(temp_index)+Prob(i);
end

%weight
services_weight=zeros(service_number,layer);
%services_weight contains the size of each layer，声明大小
for i=1:service_number
    for j=1:layer
        if services_component_index(i,j)==0
            services_weight(i,j)=0;
        else
            services_weight(i,j)=tree_3(services_component_index(i,j));
        end
    end
end
weight_sum = sum(services_weight,2);
services_weight = [weight_sum';services_weight']';

weight_tree = zeros(size(tree_3));
temp_index = services_component_index(services_component_index~=0);
weight_tree(temp_index)=1;
weight_tree = weight_tree.*tree_3;
end

