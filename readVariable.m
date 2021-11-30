function [command,via_point_task] = readVariable
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
input_command = importdata('robot_command_v0.txt');
input_command = input_command{1};
input_via_point = importdata('via_points_info_v0.txt');
input_via_point = input_via_point{1};

command = [];
via_point_task = [];
input_command = strsplit(input_command);
input_via_point = strsplit(input_via_point);
for i=1:length(input_command)
    a = input_command(i);
    a = a{1};
    if a(2) == 'L'
        command(i) = 0;
    elseif a(2) =='J'
        command(i) = 1;
    end
    b = input_via_point(i);
    b1 = b{1};
    text = str2double(strsplit(b1(2:length(b1)-1),','));
    temp = [text(1);text(2);text(3)];
    via_point_task(:,i) = temp;
end
end

