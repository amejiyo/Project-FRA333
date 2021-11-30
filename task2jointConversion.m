function [alert, via_point_joint] = task2jointConversion(via_point_task)
% check possible access + convert task to joint
via_point_joint = [];
alert = [];
for j=1:length(via_point_task)
    alert_temp = 1;
    [q,flag] = inverseKine(via_point_task(:,j));
    if all(flag==0)
        alert_temp = 0;
        via_point_joint = q(:,1);
    else
        column = find(flag==1);
        for i=1:length(column)
            via_point_joint(:,i,j) = q(:,column(i));
        end
    end
    alert(j) = alert_temp;
end
end
