function [alert, via_point_joint] = task2jointConversion(via_point_task)
% check possible access + convert task to joint
via_point_joint = [];
alert = 1;
[q,flag] = inverseKine(via_point_task);
if all(flag==0)
    alert = 0;
    via_point_joint = q(:,:,1);
else
    column = find(flag==1);
    for i=1:length(column)
        via_point_joint(:,:,i) = q(:,:,column(i));
    end
end
end
