function [ iter ] = tree_iter(tree,start,layer)
%�ӽڵ㣬����
%�����ĵ�i���ڵ�Ϊ������ʼ����
%tree ��Ҫ����������
%start ��ʼ�����Ľڵ�
%layer start���ڽڵ�����ڵ�

layer_starter = start;
for i=0:layer(2)-layer(1) 
    length = 3^i;
    tree(layer_starter:layer_starter+length-1)=1;
    layer_starter = 3*layer_starter+1;
end
iter = tree;
end

