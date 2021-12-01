function [C,t_i,T,flag] = coefficientGen(via_points)

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