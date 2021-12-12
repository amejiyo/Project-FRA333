function [command,via_point_task] = readVariable(command,via_point)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
input_command = importdata("robot_command_modeJ.txt");
input_command = input_command{1};
input_via_point = importdata("via_points_info.txt");
input_via_point = input_via_point{1};

command = [];
via_point_task = [];
input_command = strsplit(input_command);
input_via_point = strsplit(input_via_point);
for i=1:length(input_command)
    a = input_command(i);
    a = a{1};
%     x = str2double(a(5))
    if a(2) == 'L'
        command(i) = 0;
    elseif a(2) =='J'
        command(i) = 1;
    end
    b = input_via_point(str2double(a(5)));
    b1 = b{1};
    text = str2double(strsplit(b1(2:length(b1)-1),','));
%     temp = [text(1);text(2);text(3)];
    via_point_task(:,i) = text;
end
end
% function [command,via_points_taskspace] = readVariable(command,via_point)
% 
%  %Read via_points_info.txt file
%  via_points_info = fileread(via_point);
%  %Split each via-points
%  via_points_info = split(via_points_info, " ");
%  %Remove un-use characters
%  via_points_info = erase(via_points_info, ["(",")"]);
%  %Split x,y,z in via-point
%  via_points_info = split(via_points_info, ",");
%  %Convert string type to double type
%  via_points_info = str2double(via_points_info)'
% 
%  %Read robot_command.txt file
%  robot_command = fileread(command);
%  %Split each via-points
%  robot_command = split(robot_command, " ");
%  %Remove un-use characters
%  robot_command = erase(robot_command, ["(",")"]);
%  %Split x,y,z in via-point
%  robot_command = split(robot_command, ",")'
% 
% 
%  via_points_taskspace = zeros(3,length(robot_command));
% 
%  command = zeros(1,length(robot_command));
%  command = strfind(str,'in')
% 
%  end
