function [out] = plot_my_fairness(test_set,exp_aver,labelx)
%PLOT_MY 
%   Detailed explanation goes here
figure
color_my = ['-*y';'-+b';'->g';'-<m';'-or'];
for i=1:size(exp_aver,2)
    plot(test_set,exp_aver(:,i),color_my(i,:));
    hold on;
end
legend('Random','GA','MLU','SA','CBMU')
% title(title_var,'position',[5,-4]);
ylabel('JFI');
xlabel(labelx)
hold off;
end