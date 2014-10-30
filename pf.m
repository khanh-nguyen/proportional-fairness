% Test proportional fairenss algorithm
% arg max_i {r_{i,n+1} / Theta_n}
clear all; clc;
num_user = 10;
run_time = 1000;

%fix_data_rate = [5;5;5;5;10;10;10;10;20;50];
%d = 0.01*rand(num_user, 1);
d = 0.001*ones(num_user,1);
data_rate = randi([5 50], num_user, run_time);
%data_rate = repmat(fix_data_rate,1,run_time);
assignments = zeros(num_user, run_time);
%possible_assignments = eye(num_uer);

for i=1:run_time
    if i==1
        current_throughput = zeros(num_user, 1);
    else
        current_throughput = (data_rate(:,1:i-1).*assignments(:,1:i-1));
        current_throughput = sum(current_throughput, 2) / (i-1);
    end
    temp = data_rate(:,i) ./ (d + current_throughput);
    [~,idx] = max(temp);
    new_assignment = zeros(num_user,1);
    new_assignment(idx) = 1;
    assignments(:,i) = new_assignment;
end