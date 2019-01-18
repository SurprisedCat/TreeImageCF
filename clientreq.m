function [ reqs ] = clientreq( client_num,alpha, service_number )
%CLIENTREQ return requests number 
%  Generate client_num requests, follows zipf distribution
reqs = zipfrnd(alpha,service_number,client_num);
end

