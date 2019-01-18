function [ iter ] = tree_iter(tree,start,layer)
%子节点，遍历
%以树的第i个节点为根，开始遍历
%tree 需要遍历的整体
%start 开始遍历的节点
%layer start所在节点和最大节点

layer_starter = start;
for i=0:layer(2)-layer(1) 
    length = 3^i;
    tree(layer_starter:layer_starter+length-1)=1;
    layer_starter = 3*layer_starter+1;
end
iter = tree;
end

