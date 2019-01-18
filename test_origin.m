tic;
clear all;clc;
%服务镜像
global layer
global service_number
%客户节点，Zipf参数
global client_number
global alpha
%服务节点
global cache_capacity
global server_number %8个服务节点
global computing_capacity

setGlobal();
%服务种类生成
[services_index,services_component,tree_3] = services(service_number,layer);
services_component_index=component2index(services_component);
[pop_tree, services_pop,weight_tree,services_weight] = getServiceChar(services_component_index,tree_3,alpha);

%用户请求生成
reqsIndex = clientreq(client_number,alpha, service_number);%reqs是请求的编号
reqs = services_component_index(reqsIndex,:);

%这里留缓存算法%
%random selection
random_server_caching_tree = caching_random(server_number,cache_capacity,services_component_index,weight_tree,services_weight);
%用户i到服务器j所需要的成本，三维矩阵
cost_random = costFuncTree( reqs,random_server_caching_tree,weight_tree);
%用户根据最低成本原则选择server
%计算所需成本
[cs_pair,pair_cost] = clientSel(cost_random ,computing_capacity);
total_cost(1)=sum(pair_cost);
% return
%greedy
greedy_server_caching_tree = caching_greedy(server_number,cache_capacity,services_component_index,weight_tree,services_weight);
%用户i到服务器j所需要的成本，三维矩阵
cost_greedy = costFuncTree( reqs,greedy_server_caching_tree,weight_tree);
%用户根据最低成本原则选择server
%计算所需成本
[cs_pair,pair_cost] = clientSel(cost_greedy,computing_capacity);
total_cost(2)=sum(pair_cost);

%maximum utility
utility_server_caching_tree = caching_utility(server_number,cache_capacity,services_component_index,pop_tree,weight_tree,services_weight);
%用户i到服务器j所需要的成本，三维矩阵
cost_utility = costFuncTree( reqs,utility_server_caching_tree,weight_tree);
%用户根据最低成本原则选择server
%计算所需成本
[cs_pair,pair_cost] = clientSel(cost_utility,computing_capacity);
total_cost(3)=sum(pair_cost);

% %SA
% sa_server_caching_tree = caching_sa(reqs,server_number,cache_capacity,computing_capacity,pop_tree,weight_tree);
% %用户i到服务器j所需要的成本，三维矩阵
% cost_utility_sa  = costFuncTree( reqs,sa_server_caching_tree,weight_tree);
% %用户根据最低成本原则选择server
% %计算所需成本
% [cs_pair,pair_cost] = clientSel(cost_utility_sa,computing_capacity);
% total_cost(4)=sum(pair_cost);

%my
my_server_caching_tree = caching_my(server_number,layer,cache_capacity,weight_tree,pop_tree);
%用户i到服务器j所需要的成本，三维矩阵
cost_utility_my = costFuncTree( reqs,my_server_caching_tree,weight_tree);
%用户根据最低成本原则选择server
%计算所需成本
[cs_pair,pair_cost] = clientSel(cost_utility_my,computing_capacity);
total_cost(5)=sum(pair_cost);
toc;

