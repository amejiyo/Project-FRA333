function [C,t_i,T,flag] = coefficientGen(via_points, v_max, a_max)

flag = 0;

C = []; t_i = []; T = 0;
Tk_prev = 0; Tk_amax = [0;0;0];

for sub = 1:length(via_points)-1
    
    %Search for Tk by maximum velocity condition
    Tk_vmax = abs((15/8*(via_points(:,sub+1)-via_points(:,sub))) / v_max);
    
    %Search for Tk by maximum acceleration condition
    syms tau
    EQN = [a_max a_max;a_max a_max;a_max a_max] == (6 *( 10/tau.^3 .*(via_points(:,sub+1)-via_points(:,sub)))* (tau/6.*([3+3^(1/2) 3-3^(1/2)])))+...
                                                   (12*(-15/tau.^4 .*(via_points(:,sub+1)-via_points(:,sub)))* (tau/6.*([3+3^(1/2) 3-3^(1/2)])).^2)+...
                                                   (20*(  6/tau.^5 .*(via_points(:,sub+1)-via_points(:,sub)))* (tau/6.*([3+3^(1/2) 3-3^(1/2)])).^3);
    temp = zeros(3,2);
    for r=1:3
        if (via_points(r,sub+1) - via_points(r,sub) ~= 0)
            temp(r,:) = [vpasolve(EQN(r,1), [0 Inf]) vpasolve(EQN(r,2), [0 Inf])];
        end
    end
    Tk_amax = max(temp);

    %Select the maximum Tk from both conditions
    Tk = max([max(Tk_vmax) max(Tk_amax)]);
    %Add timestamp each sub-trajectory
    t_i(:,sub) = Tk_prev;
    %Save the previous timestamp
    Tk_prev = Tk_prev + Tk; 
    %Convert symbolic values to MATLAB double precision 
    T = double(Tk_prev);
    
    C(:,0+1,sub) = via_points(:,sub);   % initial position
    C(:,1+1,sub) = 0;                   % initial velocity
    C(:,2+1,sub) = 0;                   % initial acceleration

    C(:,3+1,sub) = 10/Tk.^3 *(via_points(:,sub+1)-via_points(:,sub));
    C(:,4+1,sub) =-15/Tk.^4 *(via_points(:,sub+1)-via_points(:,sub));
    C(:,5+1,sub) =  6/Tk.^5 *(via_points(:,sub+1)-via_points(:,sub));
end
end