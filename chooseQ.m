function [q_out,alert] = chooseQ(p,q_i)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[flag,q] = task2jointConversion(p);
p_pre = 100;
alert = 0;
for i=1:4
    if flag == 1
        if p_pre > sum(abs(q(:,i)-q_i))
            p_pre = sum(abs(q(:,i)-q_i));
            q_out = q(:,i);
        end
    else
        alert = 1;
    end
end

