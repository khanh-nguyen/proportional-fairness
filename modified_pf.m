% allow k users to be served in each slot
% arg max_i {r_{i,n+1} / Theta_n}
clear all; clc;
num_user = 10;
run_time = 1000;
num_served = 5;     % number of users to be served in each time slot
num_sim = 100;

d = 0.001*ones(num_user,1);

assign_counter = zeros(num_user, num_sim);

for sim=1:num_sim
    % fix rate
    % fix_data_rate = [5;5;5;5;10;10;10;10;20;50];
    % data_rate = repmat(fix_data_rate,1,run_time);

    % random rate
    data_rate = randi([5 50], num_user, run_time);

    assignments = zeros(num_user, run_time);    % keep track of assignments
    for i=1:run_time
        if i==1
            current_throughput = zeros(num_user, 1);
        else
            current_throughput = (data_rate(:,1:i-1).*assignments(:,1:i-1));
            current_throughput = sum(current_throughput, 2) / (i-1);
        end
        temp = data_rate(:,i) ./ (d + current_throughput);

        [~,sortIdx] = sort(temp,'descend');
        new_assignment = zeros(num_user,1);
        new_assignment(sortIdx(1:num_served)) = 1;
        assignments(:,i) = new_assignment;
    end
    assign_counter(:,sim) = sum(assignments,2);
end
