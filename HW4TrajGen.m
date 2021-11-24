function [C,t_i,T,flag] = HW4TrajGen(via_points)
%HW4TRAJGEN computes the coefficients and initial time of a quintic
%polynomial that passes through the given via points.
%
%   VP is a [3 x (K+1)] matrix representing a list of position in config
%   space
%   C is a [N x M x K] matrix where N is the number of degree-of-freedom, 
%   ,M is the number of coefficients (i.e. M = 4 for cubic polynomial), and
%   K is the number of sub-trajectory.
%   TI is a K-dimensional row vector representing initial time of each
%   sub-trajectory.
%   T is the total duration of the entire trajectory
%   flag is a indication whether there is a feasible trajectory
C = [];
flag = 0;
T = [];
t_i = [];
t = 0;
for i = 1:length(via_points)-1
    totDis = via_points(:,i+1) - via_points(:,i);
    totDis_all = sum(sqrt((via_points(:,i) - via_points(:,i+1)).^2));
%     T(i) = 2*sqrt(totDis_all/0.5);
    T(i) = floor(sqrt(10*totDis_all/(0.5*sqrt(3))));
    t_i(i) = t;
    C(:,:,i) = [via_points(:,i),[0;0;0],[0;0;0], (totDis.*10)./(T(i)^3), -totDis.*15/T(i)^4, 6*totDis./T(i)^5];
    t = t + T(i);
    v_eq = [1,2*(T(i)/2),3*(T(i)/2)^2,4*(T(i)/2)^3,5*(T(i)/2)^4];
    vmax = C(:,2:6,i)*v_eq'; 
    if t-T(end) >120
        flag = 1;
    elseif abs(vmax) > 1.75
        flag = 1;
    end
end
T = t;
end