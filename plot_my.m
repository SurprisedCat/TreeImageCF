function [out] = plot_my(test_set,exp_aver,title_var)
%PLOT_MY Summary of this function goes here
%   Detailed explanation goes here
for i=1:size(exp_aver,2)
    plot(test_set,exp_aver(:,i));hold on;
end
title(title_var);
hold off;
end

