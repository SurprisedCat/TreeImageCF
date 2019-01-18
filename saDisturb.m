function [ new_tree ] = saDisturb(server_caching_tree,reqs,weight_tree,cache_capacity)
%SADISTURB randomly modify some caching items
new_tree = server_caching_tree;
service_num = size(weight_tree,1);
n=size(reqs,2);

for i=1:6
    delIndexSet = find(server_caching_tree > 0);
    delIndex = delIndexSet(randi(size(delIndexSet,1)));
    del_column_index = fix((delIndex-1)/size(new_tree,1))+1;
    del_row_index = mod(delIndex,service_num);
    if del_row_index == 0
        del_row_index=service_num;
    end
    addIndex = find(reqs>0);
    value2add = reqs(addIndex(randi(size(addIndex,1))));
    if sum(new_tree(:,del_column_index)==value2add)>0
        continue;
    elseif weight_tree(value2add )>weight_tree(del_row_index)
        if storageCac(new_tree(:,del_column_index),weight_tree)+weight_tree(value2add )-weight_tree(del_row_index)>cache_capacity
            continue
        else
            new_tree(delIndex)=0;
            new_tree(value2add,del_column_index)=value2add;
            break;
        end
    else      
        new_tree(delIndex)=0;
        new_tree(value2add,del_column_index)=value2add;
        break;
    end
end

end

