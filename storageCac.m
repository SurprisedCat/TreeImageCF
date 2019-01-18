function storage_size = storageCac(caching,weight_tree)
%STORAGECAC Summary of this function goes here
%   Detailed explanation goes here
storage_index = caching~=0;
storage_size=sum(weight_tree(storage_index));
end

