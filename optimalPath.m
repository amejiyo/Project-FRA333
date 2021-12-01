function [select_via_point_joint] = optimalPath(via_point_joint_all)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[x,y,z] = size(via_point_joint_all);
x=randi(z,z^y,y);
sum1 = [];
for i=1:length(x)
    sum1(i) = 0;
    for j=1:y
        temp = x(i,:);
        sum1(i) = sum(abs(via_point_joint_all(:,j, temp(j)))) + sum1(i);
    end
end
index1 = find(sum1==(min(sum1)))
select_via_point_joint = [];
for i=1:y
    temp = x(index1,:);
    select_via_point_joint(:,i) = via_point_joint_all(:,i,temp(i));
end
end

