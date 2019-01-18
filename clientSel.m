function [cs_pair,pair_cost ] = clientSel( cost,c_capacity )
%CLIENTSEL return the client server connection pair according to each
%client's choice
%  cost matrix shows the cost between each client and server
% c_capacity shows the computing capacity of servers 
client_number = size(cost,1);
server_number = size(cost,2);
server_counter=zeros(1,server_number);

cs_pair=zeros(client_number,1);
pair_cost=zeros(client_number,1);
%最坏の情况，用户的服务器都被占满了，随机分配，应该不会遇到这个情况
big_number = 1000;
%2d->1d-> A NUMBER
origin_largest = max(max(cost));

while isempty(find(cs_pair==0,1))==false
    for i=1:client_number
        if cs_pair(i)~=0
            continue;
        end
        [value,index]=min(cost(i,:),[],2);
        if value == big_number
            %选择负载最轻的那个服务器
            cs_pair(i) = min(server_counter);
            pair_cost(i) = origin_largest;
        elseif server_counter(index)<c_capacity
            server_counter(index)=server_counter(index)+1;
            cs_pair(i) = index;
            pair_cost(i) = value;
        else
            %服务器被占满，不可使用
            cost(:,index)=big_number;
        end
    end
end
end

