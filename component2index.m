function [ services_component_index ] = component2index( services_component )
%COMPONENT2INDEX Summary of this function goes here
%   return the index of each component

services_component_index=zeros(size( services_component));
 
services_component_index(:,1)= services_component(:,1);
for i=2:size( services_component,2)
    temp = services_component_index(:,i-1)*3+services_component(:,i);
    temp(services_component(:,i)==0)=0;
    services_component_index(:,i) =temp;
end
end

