function [q,flag] = inverseKine(p)
gamma = [1,1,-1,-1;1,-1,1,-1];
L1 = 0.05;          %parameter Length1
L2 = 0.25;          %parameter Length2
L3 = 0.3;           %parameter Length3
h1 = 0.1;           %parameter Height1
q = [];             %to create q variables (default = 0)    
flag = [];
for i=1:length(gamma)
    q_temp = [0;0;0];
    r = gamma(1,i)*sqrt(p(1,:).^2 + p(2,:).^2);
    if ((r-L1).^2 + (p(3,:)-h1).^2 - L2^2 - L3^2)/(2*L2*L3) >1
        flag(i) = 0;
    else
        q_temp(1) = atan2(p(2,:)./r,p(1,:)./r);
        c3 = ((r-L1).^2 + (p(3,:)-h1).^2 - L2^2 - L3^2)./(2*L2*L3);
        s3 = gamma(2,i)*sqrt(1-c3.^2);
        q_temp(3) = atan2(s3,c3) + pi/2;
        q_temp(2) = atan2((p(3,:) - h1),(r-L1)) - atan2(L3*s3,L2+ L3*c3) - pi/2;
        flag(i) = 1;
    end
    q(:,:,i) = round((q_temp),6);
end