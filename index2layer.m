function [ layer ] = index2layer( index )
%INDEX2LAYER Summary of this function goes here
%   Detailed explanation goes here
layer = fix(log(2*index+1)/log(3));

end

