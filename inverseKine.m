function [q,flag] = inverseKine(p)
gamma = [1,1,-1,-1;1,-1,1,-1];
p = [0.4,0.02,0.5;0.1,0.2,0.3;0.06,0.08,0.3];
L1 = 0.05;       %parameter Length1
L2 = 0.25;     %parameter Length2
L3 = 0.3;     %parameter Length3
h1 = 0.1;       %parameter Height1
q = [];    %to create q variables (default = 0)
z_temp = p(3,:) - h1;     %move the origin of x axis
x_temp = sqrt(p(1,:).^2 + p(2,:).^2 - L1^2);      %the lenght between joint 2 and end-effector in XY plane >> x'
condi1 = p(1,:).^2 + p(2,:).^2 - L1^2 < zeros(1,length(p));
condi2 = (x_temp.^2 + z_temp.^2 - L2^2 - L3^2)/(2*L2*L3) > ones(1,length(p));
flag = [];
for i=1:length(gamma)
    if any(condi1,'all') || any(condi2,'all')      %can not reach the goal
        %if (x_temp is imaginary number) or (exceed of the range of sine(i))
        flag(i) = 0;           %can not reach the goal >> flag = 0
        q(:,:,i) = zeros(3,length(p));       %q = 0
    else    %can reach the goal
        q_temp = [0;0;0];
        %if gamma = 1 >> q(1) = subtraction of the angle created from XY
        %coordinate and the angle created from robot's arm (Link 1, x')
        q_temp(1) = (atan2(p(1,:),-p(2,:)) - atan2(gamma(1,i)*x_temp,L1));     %q(1) >> subtraction
        if gamma(1) ~= 1    %otherwise,
            q_temp(1) = (atan2(p(1),-p(2)) + atan2(gamma(1,i)*x_temp,L1)); % q(1) >> summation
        end
        %X'Z plane
        s3 = (x_temp.^2 + z_temp.^2 - L2^2 - L3^2)/(2*L2*L3);    %cosine law
        c3 = gamma(2,i)*sqrt(1 - s3^2);                          %from c^2 + s^2 = 1
        q_temp(3) = atan2(s3,c3);                                   %arctan2 
        q_temp(2) = atan2(z_temp, x_temp) + atan2(L3.*c3, L2 + L3.*s3);    %summation of the angle created from X'Z
        %coordinate and the angle created from robot's arm (Link 2, Link 3)
        flag(i) = 1;           %can reach the goal >> flag = 1
        q(:,:,i) = wrapToPi(q_temp);    %%Range of q = [-pi,pi]
    end
end