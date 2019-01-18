load('exp_alpha_aver_100');
plot_my(test_set,exp_alpha_aver,'Zipf Parameter');
clear;
load('exp_service_number_aver_100');
plot_my(test_set,exp_service_number_aver,'Number of Service Images');
clear;
load('exp_client_number_aver_100');
plot_my(test_set,exp_client_number_aver,'Number of Clients');
clear;
load('exp_server_number_aver_100');
plot_my(test_set,exp_server_number_aver,'Number of Servers');
clear;
load('exp_cache_capacity_aver_100');
plot_my(test_set,exp_cache_capacity_aver,'Caching Capacity (MB)');
clear;
load('exp_computing_capacity_aver_100');
plot_my(test_set,exp_computing_capacity_aver,'Computing Capacity');
clear;
load('exp_client_fair_100');
 plot_my_fairness(test_set,exp_client_number_aver,'Number of Clients');
clear;
load('exp_server_number_fair_100');
 plot_my_fairness(test_set,exp_server_number_aver,'Number of Servers');
clear;