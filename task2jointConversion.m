function [alert, via_point_joint] = task2jointConversion(via_point_task, command)
% check possible access + convert task to joint
gamma = [1,1,-1,-1;1,-1,1,-1];
via_point_joint = [];
alert = 1;
for i=1:length(gamma)
    [q,alert] = IKHW2(via_point_task,gamma(i));

end
