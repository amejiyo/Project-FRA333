function [p,v,a] = polyTrajEval(t,C,t_i)
%POLYTRAJEVAL computes the value of the polynomial trajectory and its
%   derivatives based on given time stamp
%
%   [P,V,A] = POLYTRAJEVAL(T,C,TI) computes the value P of the polynomial 
%   trajectory and its first 2 derivatives V and A based on the given 
%   time-stamp T, a vector of coefficients C, and the initial time of the 
%   trajectory TI
%   
%   T is a scalar
%   C is a [N x M] matrix where N is the number of degree-of-freedom, and M
%   is the number of coefficients (i.e. M = 4 for cubic polynomial)
%   TI is a scalar
% tau = t-t_i;
size_c = size(C);
if size_c(2) == 6 %check C size. 2nd dimension = number of Nth polynomial
    p_eq = [1,(t-t_i),(t-t_i)^2,(t-t_i)^3,(t-t_i)^4,(t-t_i)^5];
    v_eq = [1,2*(t-t_i),3*(t-t_i)^2,4*(t-t_i)^3,5*(t-t_i)^4];
    a_eq = [2,6*(t-t_i),12*(t-t_i)^2,20*(t-t_i)^3];
    p = C(:,:,:)*p_eq';
    v = C(:,2:6,:)*v_eq';
    a = C(:,3:6,:)*a_eq';
elseif size_c(2) == 5
    p_eq = [1,(t-t_i),(t-t_i)^2,(t-t_i)^3,(t-t_i)^4];
    v_eq = [1,2*(t-t_i),3*(t-t_i)^2,4*(t-t_i)^3];
    a_eq = [2,6*(t-t_i),12*(t-t_i)^2];
    p = C(:,:,:)*p_eq';
    v = C(:,2:5,:)*v_eq';
    a = C(:,3:5,:)*a_eq';
elseif size_c(2) == 4
    p_eq = [1,(t-t_i),(t-t_i)^2,(t-t_i)^3];
    v_eq = [1,2*(t-t_i),3*(t-t_i)^2];
    a_eq = [2,6*(t-t_i)];
    p = C(:,:,:)*p_eq';
    v = C(:,2:4,:)*v_eq';
    a = C(:,3:4,:)*a_eq';
elseif size_c(2) == 3
    p_eq = [1,(t-t_i),(t-t_i)^2];
    v_eq = [1,2*(t-t_i)];
    a_eq = 2;
    p = C(:,:,:)*p_eq';
    v = C(:,2:3,:)*v_eq';
    a = C(:,3:3,:)*a_eq';
end
end