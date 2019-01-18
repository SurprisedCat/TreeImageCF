function [cost] = costFuncTree( reqs_service,server_caching_tree,weight_tree)
%COSTFUNC get the overall cost, user i and server j need cost(i,j)  
%   reqs client requests
%   server_caching_tree  caching results
client_number=size(reqs_service,1);
server_number=size(server_caching_tree,2);

cost = zeros(client_number,server_number);

for i=1:client_number
    for j=1:server_number
       layer_component = reqs_service(i,reqs_service(i,:)~=0);
       for k=1:length(layer_component)
           if sum(layer_component(k)==server_caching_tree(:,j))>0
               continue;
           else
               cost(i,j)=sum(weight_tree(layer_component(k:length(layer_component))));
           end
       end
    end
end

end

