%IKHW2 function is used to compute inverse kinematics (task space (p) >> given configuration (q)) of RRR robot 
%(only for HW2)
%There are 2 inputs : the position of the pose (x,y,z) and gamma (to tell the direction of links/joints)
%There are 2 outputs : the configuration variables (q1,q2,q3) and flag (to check whether the manipulator can reach the goal or not,
%flag = 0 means the robot can not reach the goal, flag = 1 means the robot can reach the goal)

%{
NAME        : IKHW2
AUTHOR      : Keedita Chaihetphon 62340500003
            : Pakapak Silpapinun  62340500042
DATE        : September 20th 2021
MODIFIED BY : -
%}

function [q,flag] = IKHW2(p,gamma)
L1 = 0.3;       %parameter Length1
L2 = 0.525;     %parameter Length2
L3 = 0.445;     %parameter Length3
h1 = 0.7;       %parameter Height1
q = [0;0;0];    %to create q variables (default = 0)
z_temp = p(3) - h1;     %move the origin of x axis
x_temp = sqrt(p(1)^2 + p(2)^2 - L1^2);      %the lenght between joint 2 and end-effector in XY plane >> x'
if p(1)^2 + p(2)^2 - L1^2 < 0 || (x_temp^2 + z_temp^2 - L2^2 - L3^2)/(2*L2*L3) > 1      %can not reach the goal
    %if (x_temp is imaginary number) or (exceed of the range of sine(i))
    flag = 0;           %can not reach the goal >> flag = 0
    q = [0;0;0];        %q = 0
else    %can reach the goal
    %if gamma = 1 >> q(1) = subtraction of the angle created from XY
    %coordinate and the angle created from robot's arm (Link 1, x')
    q(1) = (atan2(p(1),-p(2)) - atan2(gamma(1)*x_temp,L1));     %q(1) >> subtraction
    if gamma(1) ~= 1    %otherwise,
        q(1) = (atan2(p(1),-p(2)) + atan2(gamma(1)*x_temp,L1)); % q(1) >> summation
    end
    %X'Z plane
    s3 = (x_temp^2 + z_temp^2 - L2^2 - L3^2)/(2*L2*L3);    %cosine law
    c3 = gamma(2)*sqrt(1 - s3^2);                          %from c^2 + s^2 = 1
    q(3) = atan2(s3,c3);                                   %arctan2 
    q(2) = atan2(z_temp, x_temp) + atan2(L3*c3, L2 + L3*s3);    %summation of the angle created from X'Z
    %coordinate and the angle created from robot's arm (Link 2, Link 3)
    flag = 1;           %can reach the goal >> flag = 1
    q = wrapToPi(q);    %%Range of q = [-pi,pi]
end
end