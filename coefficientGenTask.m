function [C_t, t_i, tau] = coefficientGenTask(selected_via_point_joint,t_i,tau)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
p = forwardKine(selected_via_point_joint);
t = t_i;
t(end+1) = tau;
for i = 1:length(p)-1
    totDis = p(:,i+1) - p(:,i);
    T = t(i+1)-t(i);
    C_t(:,:,i) = [p(:,i),[0;0;0],[0;0;0], (totDis.*10)./(T^3), -totDis.*15/T^4, 6*totDis./T^5];
    v_eq = [1,2*(T/2),3*(T/2)^2,4*(T/2)^3,5*(T/2)^4];
    vmax = C_t(:,2:6,i)*v_eq'; 
    if t-T(end) >120
        flag = 1;
    elseif abs(vmax) > 1.75
        flag = 1;
    end
end
end

